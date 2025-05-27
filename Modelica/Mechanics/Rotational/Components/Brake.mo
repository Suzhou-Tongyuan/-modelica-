within Modelica.Mechanics.Rotational.Components;
model Brake "基于库仑摩擦的刹车模型"
  extends 
    Modelica.Mechanics.Rotational.Interfaces.PartialElementaryTwoFlangesAndSupport2;

  parameter Real mu_pos[:, 2]=[0, 0.5] 
    "正向滑动摩擦系数 [-]，作为 w_rel [rad/s] 的函数 (w_rel>=0)";
  parameter Real peak(final min=1) = 1 
    "在 w==0 时 mu 的最大值 (mu0_max = peak*mu_pos[1,2])";
  parameter Real cgeo(final min=0) = 1 
    "包含摩擦分布假设的几何常数";
  parameter SI.Force fn_max(final min=0, start=1) "最大法向力";

  extends Rotational.Interfaces.PartialFriction;
  extends 
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;

  SI.Angle phi 
    "轴承一维转动接口 (flange_a, flange_b) 与支撑之间的角度";
  SI.Torque tau "刹车摩擦扭矩";
  SI.AngularVelocity w "一维转动接口a和一维转动接口b的绝对角速度";
  SI.AngularAcceleration a 
    "一维转动接口a和一维转动接口b的绝对角加速度";

  Real mu0 "w=0 时的摩擦系数和正向滑动";
  SI.Force fn "法向力 (=fn_max*f_normalized)";

  // 常数辅助变量
  Modelica.Blocks.Interfaces.RealInput f_normalized 
    "标准化力信号 0..1 (法向力 = fn_max*f_normalized；如果 > 0，则刹车处于活动状态)" 
    annotation (Placement(transformation(
        origin={0,110}, 
        extent={{20,-20},{-20,20}}, 
        rotation=90)));

equation
  mu0 = Modelica.Math.Vectors.interpolate(mu_pos[:,1], mu_pos[:,2], 0, 1);

  phi = flange_a.phi - phi_support;
  flange_b.phi = flange_a.phi;

  // 一维转动接口flange_a和flange_b的角速度和角加速度
  w = der(phi);
  a = der(w);
  w_relfric = w;
  a_relfric = a;

  // 摩擦扭矩、法向力和 w_rel=0 时的摩擦扭矩
  flange_a.tau + flange_b.tau - tau = 0;
  fn = fn_max*f_normalized;
  tau0 = mu0*cgeo*fn;
  tau0_max = peak*tau0;
  free = fn <= 0;

  // 摩擦扭矩

  tau = if locked then sa*unitTorque else if free then 0 else cgeo*fn*(
    if startForward then 
      Modelica.Math.Vectors.interpolate(mu_pos[:,1], mu_pos[:,2], w, 1) 
    else if startBackward then 
      -Modelica.Math.Vectors.interpolate(mu_pos[:,1], mu_pos[:,2], -w, 1) 
    else if pre(mode) == Forward then 
      Modelica.Math.Vectors.interpolate(mu_pos[:,1], mu_pos[:,2], w, 1) 
    else 
      -Modelica.Math.Vectors.interpolate(mu_pos[:,1], mu_pos[:,2], -w, 1));
  lossPower = tau*w_relfric;
  annotation (Icon(
        coordinateSystem(preserveAspectRatio=true, 
        extent={{-100.0,-100.0},{100.0,100.0}}), 
        graphics={
      Polygon(  lineColor={192,192,192}, 
        fillColor={192,192,192}, 
        fillPattern=FillPattern.Solid, 
        points={{-37.0,-55.0},{-37.0,-90.0},{37.0,-90.0},{37.0,-55.0},{33.0,-55.0},{33.0,-86.0},{-33.0,-86.0},{-33.0,-55.0},{-37.0,-55.0}}), 
      Rectangle(  lineColor={64,64,64}, 
        fillColor={192,192,192}, 
        fillPattern=FillPattern.HorizontalCylinder, 
        extent={{-100.0,-10.0},{-20.0,10.0}}), 
      Rectangle(  lineColor={64,64,64}, 
        fillColor={255,255,255}, 
        fillPattern=FillPattern.HorizontalCylinder, 
        extent={{-20.0,-60.0},{20.0,60.0}}, 
        radius=10.0), 
      Rectangle(  lineColor={64,64,64}, 
        extent={{-20.0,-60.0},{20.0,60.0}}, 
        radius=10.0), 
      Rectangle(  lineColor={64,64,64}, 
        fillColor={192,192,192}, 
        fillPattern=FillPattern.HorizontalCylinder, 
        extent={{20.0,-10.0},{100.0,10.0}}), 
      Polygon(  lineColor={0,0,127}, 
        fillColor={0,0,127}, 
        fillPattern=FillPattern.Solid, 
        points={{40.0,-40.0},{70.0,-30.0},{70.0,-50.0},{40.0,-40.0}}), 
      Rectangle(  fillPattern=FillPattern.Solid, 
        extent={{30.0,-55.0},{40.0,-25.0}}), 
      Polygon(  lineColor={0,0,127}, 
        fillColor={0,0,127}, 
        fillPattern=FillPattern.Solid, 
        points={{-40.0,-40.0},{-70.0,-30.0},{-70.0,-50.0},{-40.0,-40.0}}), 
      Rectangle(  fillPattern=FillPattern.Solid, 
        extent={{-40.0,-55.0},{-30.0,-25.0}}), 
      Line(  points={{0.0,90.0},{80.0,70.0},{80.0,-40.0},{70.0,-40.0}}, 
        color={0,0,127}), 
      Line(  points={{0.0,90.0},{-80.0,70.0},{-80.0,-40.0},{-70.0,-40.0}}, 
        color={0,0,127}), 
      Text(  textColor={0,0,255}, 
        extent={{-150.0,-180.0},{150.0,-140.0}}, 
        textString="%name"), 
      Line(visible=useHeatPort, 
        points={{-100.0,-98.0},{-100.0,-70.0},{0.0,-70.0},{0.0,-40.0}}, 
        color={191,0,0}, 
        pattern=LinePattern.Dot)}), Documentation(info="<html>
<p>
该组件模拟了一个<strong>刹车</strong>，即在轴承座和一维转动接口之间存在摩擦力矩，并且通过控制的法向力将一维转动接口压向轴承座以增加摩擦力的组件。
法向力fn必须以标准化形式f_normalized提供为输入信号（0 ≤ f_normalized ≤ 1），
fn = fn_max * f_normalized，其中fn_max必须作为参数提供。
刹车中的摩擦力模型如下：
</p>
<p>
当绝对角速度“w”不为零时，摩擦力矩是速度相关摩擦系数mu(w)、法向力“fn”和几何常数“cgeo”的函数，该常数考虑了装置的几何形状和对摩擦分布的假设：
</p>
<blockquote><pre>
frictional_torque = <strong>cgeo</strong> * <strong>mu</strong>(w) * <strong>fn</strong>
</pre></blockquote>
<p>
   摩擦系数<strong>mu</strong>的典型值：
</p>
<ul>
  <li>干介质中操作：0.2&nbsp;&hellip;&nbsp;0.4</li>
  <li>油介质中操作：0.05&nbsp;&hellip;&nbsp;0.1</li>
</ul>
<p>
   当板片被压合在一起时，其中<strong>ri</strong>是内半径，<strong>ro</strong>是外半径，<strong>N</strong>是摩擦界面的数量，
   根据在界面处磨损速率均匀的假设，几何常数如下计算：
</p>
<blockquote><pre>
<strong>cgeo</strong> = <strong>N</strong>*(<strong>ro</strong> + <strong>ri</strong>)/2
</pre></blockquote>
<p>
    摩擦特性<strong>mu</strong>(w)的正部分，w >= 0，通过表mu_pos定义（第一列=w，第二列=mu）。目前，仅支持表中的线性插值。
</p>
<p>
   当绝对角速度变为零时，摩擦元件连接的元素变得卡住，即绝对角度保持不变。在此阶段，摩擦力矩是根据扭矩平衡计算的，要求绝对加速度为零。当摩擦力矩超过阈值时，即最大静摩擦力矩时，元素开始滑动，该阈值通过以下方式计算：
</p>
<blockquote><pre>
frictional_torque = <strong>peak</strong> * <strong>cgeo</strong> * <strong>mu</strong>(w=0) * <strong>fn</strong>   (<strong>peak</strong> >= 1)
</pre></blockquote>
<p>
这个过程通过状态事件以\"十分清晰\"的方式实现，并且如果摩擦元素被动态耦合，则导致连续/离散方程系统。该方法的描述见：
</p>
<dl>
<dt>Otter M., Elmqvist H., and Mattsson S.E. (1999):</dt>
<dd><strong>Hybrid Modeling in Modelica based on the Synchronous Data Flow Principle</strong>. CACSD'99, Aug. 22.-26, Hawaii.</dd>
</dl>

<p>
更精确的摩擦模型考虑了当两个元素“卡住”时材料的弹性，以及其他影响，如滞后效应。这样做的优点是摩擦元件可以完全由一个微分方程描述，而不需要事件。缺点是系统变得刚性（模拟速度变慢约10-20倍），并且需要提供更多的材料常数，这需要更复杂的识别。有关更多详细信息，请参阅以下参考文献，特别是（Armstrong和Canudas de Wit 1996年）：
</p>
<dl>
<dt>Armstrong B. (1991):</dt>
<dd><strong>Control of Machines with Friction</strong>. Kluwer Academic
    Press, Boston MA.<br></dd>
<dt>Armstrong B., and Canudas de Wit C. (1996):</dt>
<dd><strong>Friction Modeling and Compensation.</strong>
    The Control Handbook, edited by W.S.Levine, CRC Press,
    pp. 1369-1382.<br></dd>
<dt>Canudas de Wit C., Olsson H., &Aring;str&ouml;m K.J., and Lischinsky P. (1995):</dt>
<dd><strong>A new model for control of systems with friction.</strong>
    IEEE Transactions on Automatic Control, Vol. 40, No. 3, pp. 419-425.</dd>
</dl>


<p>
有关<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.StateSelection\">State Selection</a>
的讨论请见Rotational库的用户指南。
</p>

</html>"));
end Brake;