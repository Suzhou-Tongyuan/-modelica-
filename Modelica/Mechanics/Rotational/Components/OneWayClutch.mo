within Modelica.Mechanics.Rotational.Components;
model OneWayClutch "自由轮和离合器的并联连接"
  extends Modelica.Mechanics.Rotational.Icons.Clutch;
  extends 
    Modelica.Mechanics.Rotational.Interfaces.PartialCompliantWithRelativeStates;

  parameter Real mu_pos[:, 2]=[0, 0.5] 
    "正滑动摩擦系数 [-] 作为 w_rel [rad/s] 的函数 (w_rel>=0)";
  parameter Real peak(final min=1) = 1 
    "在 w==0 时 mu 的最大值的峰值 (mu0_max = peak*mu_pos[1,2])";
  parameter Real cgeo(final min=0) = 1 
    "包含摩擦分布假设的几何常数";
  parameter SI.Force fn_max(final min=0, start=1) "最大法向力";
  parameter SI.AngularVelocity w_small=1e10 
    "如果由于速度的重新初始化（reinit(..)）而产生跳变，则接近零的相对角速度（仅在可能发生此类冲动时设置为低值）" 
    annotation (Dialog(tab="高级"));
  extends 
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;

  Real u "标准化力输入信号 (0..1)";
  SI.Force fn "法向力 (fn=fn_max*inPort.signal)";
  Boolean startForward(start=false) 
    "= true，如果 w_rel=0 并且开始向前滑动或 w_rel > w_small";
  Boolean locked(start=false) "= true，如果 w_rel=0 并且不滑动";
  Boolean stuck(start=false) "w_rel=0（锁定或开始向前滑动）";

protected
  SI.Torque tau0 "w=0 且滑动时的摩擦力矩";
  SI.Torque tau0_max "w=0 且锁定时的最大摩擦力矩";
  Real mu0 "w=0 且滑动时的摩擦系数";
  Boolean free "= true，如果摩擦元件未激活";
  Real sa(final unit="1") 
    "tau = f(a_rel) 摩擦特性的路径参数";
  constant Real eps0=1.0e-4 "相对滞后 epsilon";
  SI.Torque tau0_max_low "tau0_max 的最小值";
  parameter Real peak2=max([peak, 1 + eps0]);
  constant SI.AngularAcceleration unitAngularAcceleration=1;
  constant SI.Torque unitTorque=1;
public
  Modelica.Blocks.Interfaces.RealInput f_normalized 
    "标准化的力信号 0..1（法向力 = fn_max*f_normalized；如果 > 0，则离合器已接合）" 
    annotation (Placement(transformation(
        origin={0,110}, 
        extent={{20,-20},{-20,20}}, 
        rotation=90)));

equation
  // 常数辅助变量
  mu0 = Modelica.Math.Vectors.interpolate(mu_pos[:,1], mu_pos[:,2], 0, 1);
  tau0_max_low = eps0*mu0*cgeo*fn_max;

  // w_rel=0 时的法向力和摩擦力矩
  u = f_normalized;
  free = u <= 0;
  fn = if free then 0 else fn_max*u;
  tau0 = mu0*cgeo*fn;
  tau0_max = if free then tau0_max_low else peak2*tau0;

  /* 摩擦特性
       （引入 locked 是为了帮助 Modelica 翻译器确定
       不同的结构配置，如果为每个配置
       生成特殊代码）
    */
  startForward = pre(stuck) and (sa > tau0_max/unitTorque or pre(
    startForward) and sa > tau0/unitTorque or w_rel > w_small) or initial() 
     and (w_rel > 0);
  locked = pre(stuck) and not startForward;

  // 加速度和摩擦力矩
  a_rel = unitAngularAcceleration*(if locked then 0 else sa - tau0/ 
    unitTorque);
  tau = if locked then sa*unitTorque else (if free then 0 else cgeo*fn* 
    Modelica.Math.Vectors.interpolate(mu_pos[:,1], mu_pos[:,2], w_rel, 1));

  // 确定配置

  stuck = locked or w_rel <= 0;

  lossPower = if stuck then 0 else tau*w_rel;
  annotation (
    Icon(
        coordinateSystem(preserveAspectRatio=true, 
          extent={{-100,-100},{100,100}}), 
          graphics={
        Text(extent={{-150,-110},{150,-70}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Polygon(points={{-10,30},{50,0},{-10,-30},{-10,30}}, 
          fillPattern=FillPattern.Solid), 
        Line(visible=useHeatPort, 
          points={{-100,-99},{-100,-40},{0,-40}}, 
          color={191,0,0}, 
          pattern=LinePattern.Dot)}), Documentation(info="<html>
<p>
这个组件模拟一个<strong>单向离合器</strong>，即一个具有两个一维转动接口的组件，在这两个一维转动接口之间存在摩擦力，这些一维转动接口通过法向力彼此压在一起。这些一维转动接口可以相对滑动。
</p>
<p>
单向离合器是一个元素，其中一个离合器与一个自由轮并联连接。提供了这个特殊元素，因为这样的并联连接在模型中引入了歧义（当两个元素都被卡住时，约束力矩不是唯一定义的），这个元素通过只引入一个约束力矩而不是两个约束力矩来解决了这个问题。
</p>
<p>
注意，必须为模型选择初始值，使得单向离合器的相对速度&ge;&nbsp;0。否则，配置在物理上是不可能的，会出现错误。
</p>
<p>
法向力&nbsp;fn 必须以归一化形式作为输入信号 f_normalized 提供（0&nbsp;&le;&nbsp;f_normalized&nbsp;&le;&nbsp;1），其中 fn_max 必须作为参数提供，fn&nbsp;=&nbsp;fn_max&nbsp;*&nbsp;f_normalized。
</p>
<p>
离合器中的摩擦是这样模拟的。当相对角速度为正时，摩擦力矩是速度依赖摩擦系数 mu(w_rel)、法向力&nbsp;fn 和几何常数 cgeo 的函数，它考虑了装置的几何形状和摩擦分布的假设：
</p>

<blockquote><pre>
frictional_torque = <strong>cgeo</strong> * <strong>mu</strong>(w_rel) * <strong>fn</strong>
</pre></blockquote>

<p>
摩擦系数 <strong>mu</strong> 的典型值：
</p>
<ul>
  <li>在干燥运行时为 0.2&nbsp;&hellip;&nbsp;0.4，</li>
  <li>在油中运行时为 0.05&nbsp;&hellip;&nbsp;0.1。</li>
</ul>


<p>
几何常数是根据摩擦表面均匀磨损的假设来计算的，计算方式如下：
</p>

<blockquote><pre>
<strong>cgeo</strong> = <strong>N</strong>*(<strong>r0</strong> + <strong>ri</strong>)/2
</pre></blockquote>

<p>
其中 <strong>ri</strong> 是内半径，<strong>ro</strong> 是外半径，而&nbsp;<strong>N</strong> 是摩擦界面的数量。
</p>

<p>
摩擦特性 <strong>mu</strong>(w_rel) 的正部分，即 w_rel&nbsp;>=&nbsp;0，通过表格 mu_pos 定义（第一列 = w_rel，第二列 = mu）。目前，表格仅支持线性插值。
</p>
<p>
当相对角速度 w_rel 变为零时，与摩擦元件连接的元素会被卡住，即相对角度保持不变。在此阶段，摩擦力矩是根据要求相对加速度为零的力矩平衡计算出来的。当摩擦力矩超过阈值时，元素开始滑动，该阈值称为最大静摩擦力矩，通过以下方式计算：
</p>

<blockquote><pre>
frictional_torque = <strong>peak</strong> * <strong>cgeo</strong> * <strong>mu</strong>(w_rel=0) * <strong>fn</strong>,   (<strong>peak</strong> >= 1)
</pre></blockquote>

<p>
通过状态事件以一种“十分清晰”的方式实现了这个过程，并且如果摩擦元素动态耦合，则会导致连续/离散方程系统。该方法的描述详见：
</p>
<dl>
<dt>Otter M., Elmqvist H., and Mattsson S.E. (1999):</dt>
<dd><strong>Hybrid Modeling in Modelica based on the Synchronous
    Data Flow Principle</strong>. CACSD'99, Aug. 22.-26, Hawaii.</dd>
</dl>

<p>
有关
<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.StateSelection\">State Selection</a>
的讨论，请参考Rotational库中的用户指南
</p>

</html>"));
end OneWayClutch;