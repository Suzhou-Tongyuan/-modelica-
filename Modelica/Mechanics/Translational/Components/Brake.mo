within Modelica.Mechanics.Translational.Components;
model Brake "基于库仑摩擦的制动器"

  extends Modelica.Mechanics.Translational.Interfaces.PartialElementaryTwoFlangesAndSupport2;
  extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;
  parameter Real mu_pos[:, 2]=[0, 0.5] 
    "作为相对速度 [m/s] 函数的正向滑动摩擦系数 [-] (v_rel>=0)";
  parameter Real peak(final min=1) = 1 
    "w==0 时 mu 最大值的峰值 (mu0_max = peak*mu_pos[1,2])";
  parameter Real cgeo(final min=0) = 1 
    "包含摩擦分布假设的几何常数";
  parameter SI.Force fn_max(final min=0, start=1) "最大法向力";
  extends Translational.Interfaces.PartialFriction;

  SI.Position s "flange_a 和 flange_b 的绝对位置";
  SI.Force f "制动器摩擦力";
  SI.Velocity v "flange_a 和 flange_b 的绝对速度";
  SI.Acceleration a "flange_a 和 flange_b 的绝对加速度";

  Real mu0 "v=0 且向前滑动时的摩擦系数";
  SI.Force fn "法向力 (=fn_max*f_normalized)";

  // 常数辅助变量
  Modelica.Blocks.Interfaces.RealInput f_normalized 
    "归一化力信号 0..1 (法向力 = fn_max*f_normalized; 当 > 0 时制动器激活)" 
    annotation (Placement(transformation(
        origin={0,110}, 
        extent={{20,-20},{-20,20}}, 
        rotation=90)));
equation
  mu0 = Modelica.Math.Vectors.interpolate(
        mu_pos[:, 1], 
        mu_pos[:, 2], 
        0, 
        1);

  s = s_a;
  s = s_b;

  // flanges flange_a 和 flange_b 的速度和加速度
  v = der(s);
  a = der(v);
  v_relfric = v;
  a_relfric = a;

  // 摩擦力、法向力和 v_rel=0 时的摩擦力
  flange_a.f + flange_b.f - f = 0;
  fn = fn_max*f_normalized;
  f0 = mu0*cgeo*fn;
  f0_max = peak*f0;
  free = fn <= 0;

  // 摩擦力
  f = if locked then sa*unitForce else if free then 0 else cgeo*fn*(if 
    startForward then Modelica.Math.Vectors.interpolate(
        mu_pos[:, 1], 
        mu_pos[:, 2], 
        v, 
        1) else if startBackward then -Modelica.Math.Vectors.interpolate(
        mu_pos[:, 1], 
        mu_pos[:, 2], 
        -v, 
        1) else if pre(mode) == Forward then 
    Modelica.Math.Vectors.interpolate(
        mu_pos[:, 1], 
        mu_pos[:, 2], 
        v, 
        1) else -Modelica.Math.Vectors.interpolate(
        mu_pos[:, 1], 
        mu_pos[:, 2], 
        -v, 
        1));

  lossPower = f*v_relfric;
  annotation (Documentation(info="<html>
<p>
该组件模拟了一个<strong>制动器</strong>，即在壳体和一个一维平动接口之间产生摩擦力的组件，以及控制的法向力将一维平动接口压到壳体上以增加摩擦。
法向力 fn 必须以归一化形式的输入信号 f_normalized 提供（0 &le; f_normalized &le; 1），
fn = fn_max*f_normalized，其中 fn_max 必须作为参数提供。
制动器中的摩擦如下建模：
</p>
<p>
当绝对速度 \"v\" 不为零时，摩擦力是速度相关的摩擦系数 mu(v)、法向力 \"fn\" 和几何常数 \"cgeo\" 的函数，
它考虑了设备的几何形状和摩擦分布的假设：
</p>
<blockquote><pre>
frictional_force = <strong>cgeo</strong> * <strong>mu</strong>(v) * <strong>fn</strong>
</pre></blockquote>
<p>
   摩擦系数 mu 的典型值：
</p>
<ul>
  <li>干燥环境中：0.2&nbsp;&hellip;&nbsp;0.4</li>
  <li>油环境中：0.05&nbsp;&hellip;&nbsp;0.1</li>
</ul>
<p>
    摩擦特性 <strong>mu</strong>(v) 的正向部分，v >= 0，通过表 mu_pos（第一列 = v，第二列 = mu）定义。目前仅支持表中的线性插值。
</p>
<p>
   当绝对速度变为零时，连接摩擦元件的元素被锁定，即绝对位置保持不变。在这种情况下，摩擦力通过要求绝对加速度为零来计算。
   当摩擦力超过一个阈值时，即最大静摩擦力，计算如下：
</p>
<blockquote><pre>
frictional_force = <strong>peak</strong> * <strong>cgeo</strong> * <strong>mu</strong>(w=0) * <strong>fn</strong>   (<strong>peak</strong> >= 1)
</pre></blockquote>
<p>
该过程通过状态事件以\"十分干净\"的方式实现，并且如果摩擦元件动态耦合，则导致连续/离散方程组。该方法在以下文献中有描述：
</p>
<dl>
<dt>Otter M., Elmqvist H., and Mattsson S.E. (1999):</dt>
<dd><strong>基于同步数据流原理的 Modelica 混合建模</strong>。CACSD'99，8月22日至26日，夏威夷。</dd>
</dl>
<p>
更精确的摩擦模型考虑了两个元素\"卡住\"时的材料弹性以及其他效应，如滞后。这样做的优点是，摩擦元件可以完全由不需要事件的微分方程来描述。
缺点是系统变得僵硬（模拟速度变慢约10-20倍），需要提供更多的材料常数，这需要更复杂的识别。有关更多详细信息，请参见以下文献，特别是（Armstrong 和 Canudas de Wit 1996）：
</p>
<dl>
<dt>Armstrong B. (1991):</dt>
<dd><strong>Control of Machines with Friction</strong>. Kluwer Academic
    Press, Boston MA.<br><br></dd>
<dt>Armstrong B., and Canudas de Wit C. (1996):</dt>
<dd><strong>Friction Modeling and Compensation.</strong>
    The Control Handbook, edited by W.S.Levine, CRC Press,
    pp. 1369-1382.<br><br></dd>
<dt>Canudas de Wit C., Olsson H., &Aring;str&ouml;m K.J., and Lischinsky P. (1995):</dt>
<dd><strong>A new model for control of systems with friction.</strong>
    IEEE Transactions on Automatic Control, Vol. 40, No. 3, pp. 419-425.<br><br></dd>
</dl>
</html>"), 
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100}, 
            {100,100}}), graphics={Rectangle(
          extent={{-90,10},{90,-10}}, 
          lineColor={0,127,0}, 
          fillColor={160,215,160}, 
          fillPattern=FillPattern.Solid),    Polygon(
              points={{0,-30},{10,-50},{-10,-50},{0,-30}}, 
              lineColor={0,0,127}, 
              fillColor={0,0,127}, 
              fillPattern=FillPattern.Solid),Polygon(
              points={{10,50},{-10,50},{0,30},{10,50}}, 
              lineColor={0,0,127}, 
              fillColor={0,0,127}, 
              fillPattern=FillPattern.Solid),Line(
              points={{0,90},{0,50}}, color={0,0,127}), 
                                      Rectangle(
              extent={{20,28},{30,22}}, 
              lineColor={175,190,175}, 
              fillColor={175,190,175}, 
              fillPattern=FillPattern.Solid),Rectangle(
              extent={{20,-22},{30,-28}}, 
              lineColor={175,190,175}, 
              fillColor={175,190,175}, 
              fillPattern=FillPattern.Solid),Rectangle(
              extent={{30,28},{36,-102}}, 
              lineColor={175,190,175}, 
              fillColor={175,190,175}, 
              fillPattern=FillPattern.Solid),Rectangle(
              extent={{14,-96},{30,-102}}, 
              lineColor={175,190,175}, 
              fillColor={175,190,175}, 
              fillPattern=FillPattern.Solid),Line(
              points={{0,-50},{0,-60},{-40,-50},{-40,48},{0,60},{0,90}}, color={0,0,127}), 
                                                                         Text(
              extent={{-150,-120},{150,-160}}, 
              textString="%name", 
              textColor={0,0,255}),Line(
              visible=useHeatPort, 
              points={{-100,-102},{-100,-16},{0,-16}}, 
              color={191,0,0}, 
              pattern=LinePattern.Dot),      Rectangle(
              extent={{-20,30},{20,20}}, 
              fillPattern=FillPattern.Solid),Rectangle(
              extent={{-20,-20},{20,-30}}, 
              fillPattern=FillPattern.Solid)}));
end Brake;