within Modelica.Mechanics.Rotational.Components;
model ElastoBacklash 
  "串联线性弹簧和阻尼器的齿隙（采用弹性模型对齿隙建模）"

  parameter SI.RotationalSpringConstant c(final min=Modelica.Constants.small, 
      start=1.0e5) "弹簧刚度系数（要求 c > 0）";
  parameter SI.RotationalDampingConstant d(final min=0, start=0) 
    "阻尼系数";
  parameter SI.Angle b(final min=0) = 0 "总齿隙";
  parameter SI.Angle phi_rel0=0 "未拉伸弹簧角度";

  extends 
    Modelica.Mechanics.Rotational.Interfaces.PartialCompliantWithRelativeStates;
  extends 
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;
protected
  final parameter SI.Angle bMax=b/2 
    "反弹在 bMin <= phi_rel - phi_rel0 <= bMax 范围内";
  final parameter SI.Angle bMin=-bMax 
    "反弹在 bMin <= phi_rel - phi_rel0 <= bMax 范围内";
  SI.Torque tau_c;
  SI.Torque tau_d;
  SI.Angle phi_diff=phi_rel - phi_rel0;

  // 定义最小齿隙，以避免如果齿隙 b 设置为零时发生无限数量的状态事件。
  constant SI.Angle bEps=1e-10 "最小齿隙";

equation
  if initial() then
    /* 在初始化期间，特性被修改，以确保其是严格的单调递增函数。
        否则，当需要反转特性时，初始化可能导致奇异系统。在范围 1.5*bMin <= phi_rel - phi_rel0 <= 1.5 bMax 内修改特性，
        以便在此范围内存在一个线性特性，该特性在其限制处连续地逼近原始函数，例如，
          原始：  tau(1.5*bMax) = c*(phi_diff - bMax)
                                   = c*(0.5*bMax)
          初始化： tau(1.5*bMax) = (c/3)*phi_diff
                                   = (c/3)*(3/2)*bMax
                                   = (c/2)*bMax
     */
    tau_c = if phi_diff > 1.5*bMax then c*(phi_diff - bMax) else if 
      phi_diff < 1.5*bMin then c*(phi_diff - bMin) else (c/3)*phi_diff;
    tau_d = d*w_rel;
    tau = tau_c + tau_d;
    lossPower = tau_d*w_rel;
  else
    /*
     if abs(b) <= bEps then
        tau_c = c*phi_diff;
        tau_d = d*w_rel;
        tau   = tau_c + tau_d;
     elseif phi_diff > bMax then
        tau_c = c*(phi_diff - bMax);
        tau_d = d*w_rel;
        tau   = smooth(0, noEvent(if tau_c + tau_d <= 0 then 0 else tau_c + min(tau_c,tau_d)));
     elseif phi_diff < bMin then
        tau_c = c*(phi_diff - bMin);
        tau_d = d*w_rel;
        tau   = smooth(0, noEvent(if tau_c + tau_d >= 0 then 0 else tau_c + max(tau_c,tau_d)));
     else
        tau_c = 0;
        tau_d = 0;
        tau   = 0;
     end if;

     为了在翻译过程中不评估参数“b”，以以下形式编写（即，在上述形式中翻译后不再能够更改它）。
   */

    tau_c = if abs(b) <= bEps then c*phi_diff else if phi_diff > bMax then 
      c*(phi_diff - bMax) else if phi_diff < bMin then c*(phi_diff - bMin) 
       else 0;
    tau_d = d*w_rel;
    tau = if abs(b) <= bEps then tau_c + tau_d else if phi_diff > bMax 
       then smooth(0, noEvent(if tau_c + tau_d <= 0 then 0 else tau_c + min(
      tau_c, tau_d))) else if phi_diff < bMin then smooth(0, noEvent(if 
      tau_c + tau_d >= 0 then 0 else tau_c + max(tau_c, tau_d))) else 0;
    lossPower = if abs(b) <= bEps then tau_d*w_rel else if phi_diff > bMax 
       then smooth(0, noEvent(if tau_c + tau_d <= 0 then 0 else min(tau_c, 
      tau_d)*w_rel)) else if phi_diff < bMin then smooth(0, noEvent(if 
      tau_c + tau_d >= 0 then 0 else max(tau_c, tau_d)*w_rel)) else 0;
  end if;

  annotation (
    Documentation(info="<html>
<p>
该元件由一个串联连接的齿隙元件和一个并联连接的弹簧和阻尼器元件组成。
弹簧常数必须是非零的，否则该组件无法使用。
</p>

<p>
结合 IdealGear 组件，ElastoBacklash 模型可以用于模拟具有齿隙、弹性和阻尼的齿轮箱。
</p>

<p>
在初始化期间，齿隙特性被替换为在齿隙区域内的连续近似，以减少初始化期间的问题，特别是对于反向模型而言。
</p>

<p>
如果齿隙 b 小于 1e-10 弧度（特别是，如果 b=0），则忽略齿隙，该组件将简化为并联的弹簧/阻尼器元件。
</p>

<p>
在齿隙区域（-b/2 ≤ flange_b.phi - flange_a.phi - phi_rel0 ≤ b/2）内不施加扭矩（flange_b.tau = 0）。在此区域之外，存在接触，并且接触扭矩基本上是用线性弹簧/阻尼器特性计算的：
</p>

<blockquote><pre>
desiredContactTorque = c*phi_contact + d*<strong>der</strong>(phi_contact)

         phi_contact = phi_rel - phi_rel0 - b/2 <strong>if</strong> phi_rel - phi_rel0 &gt;  b/2
                     = phi_rel - phi_rel0 + b/2 <strong>if</strong> phi_rel - phi_rel0 &lt; -b/2

         phi_rel     = flange_b.phi - flange_a.phi;
</pre></blockquote>

<p>
此扭矩特性导致以下困难：
</p>

<ol>
<li> 如果阻尼器扭矩变大并且与弹簧扭矩方向相反，则接触扭矩将是“拉扯/粘结”，这是不符合物理规律的，因为在接触时只能产生推力扭矩。</li>

<li> 当接触发生时，存在非零的相对速度（这是通常的情况），阻尼器扭矩具有非零值，因此接触扭矩在 phi_rel = phi_rel0 处发生不连续变化。同样，这不是物理上的，因为扭矩只能连续变化。（请注意，该组件不是一个理想化模型，其中陡峭特性被不连续地近似，而是应该模拟陡峭特性。）</li>
</ol>

<p>
在文献中有几种提议来解决问题（2）。然而，似乎没有提出避免粘结的解决方案。因此，ElastoBacklash 模型中使用了最简单的方法来通过对线性弹簧/阻尼器特性进行轻微更改来解决这两个问题：
</p>

<blockquote><pre>
// Torque characteristic when phi_rel > phi_rel0
<strong>if</strong> phi_rel - phi_rel0 &lt; b/2 <strong>then</strong>
   tau_c = 0;          // spring torque
   tau_d = 0;          // damper torque
   flange_b.tau = 0;
<strong>else</strong>
   tau_c = c*(phi_rel - phi_rel0);    // spring torque
   tau_d = d*<strong>der</strong>(phi_rel);            // damper torque
   flange_b.tau = <strong>if</strong> tau_c + tau_d &le; 0 <strong>then</strong> 0 <strong>else</strong> tau_c + <strong>min</strong>( tau_c, tau_d );
<strong>end if</strong>;
</pre></blockquote>

<p>
注意，当发生粘结时（tau_c + tau_d ≤ 0），接触扭矩被显式地设置为零。if 表达式中的 \"min(tau_c, tau_d)\" 部分限制了阻尼扭矩在推动时的大小。这意味着在接触开始时（phi_rel - phi_rel0 = b/2），阻尼扭矩为零且连续。这两个修改的效果是，阻尼扭矩的绝对值始终受到弹簧扭矩绝对值的限制：|tau_d| ≤ |tau_c|。
</p>

<p>
在下图中，显示了使用 ElastoBacklash 模型进行的典型仿真（<a href=\"modelica://Modelica.Mechanics.Rotational.Examples.Backlash\">Examples.Backlash</a>），其中可视化了不同的效果：
</p>

<ol>
<li>曲线 1（elastoBacklash1.tau）是未修改的接触扭矩，即线性弹簧/阻尼特性。在接触结束时存在拉扯/粘结扭矩。</li>
<li>曲线 2（elastoBacklash2.tau）是接触扭矩，在拉扯/粘结发生时，扭矩被显式地设置为零。接触扭矩在接触开始时不连续。</li>
<li>曲线 3（elastoBacklash3.tau）是该库的 ElastoBacklash 模型。没有不连续，也没有拉扯/粘结发生。</li>
</ol>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/Components/elastoBacklash.png\" alt=\"使用 ElastoBacklash 模型进行的仿真结果\">
</div>

<p>
还请参阅旋转库的用户指南中的讨论：<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.StateSelection\">State Selection</a>。
</p>

</html>"), 
    Icon(
    coordinateSystem(preserveAspectRatio=true, 
      extent={{-100,-100},{100,100}}), 
      graphics={
    Line(points={{-80,32},{-58,32},{-48,0},{-34,61},{-20,0},{-8,60},{0,30},{20,30}}), 
    Rectangle(extent={{-60,-10},{-10,-50}}, 
      fillColor={192,192,192}, 
      fillPattern=FillPattern.Solid), 
    Line(points={{-60,-50},{0,-50}}), 
    Line(points={{-60,-10},{0,-10}}), 
    Line(points={{-10,-30},{20,-30}}), 
    Line(points={{-80,-30},{-60,-30}}), 
    Line(points={{-80,32},{-80,-30}}), 
    Line(points={{20,30},{20,-30}}), 
    Line(points={{-90,0},{-80,0}}), 
    Line(points={{90,0},{80,0}}), 
    Line(points={{20,0},{60,0},{60,-30}}), 
    Line(points={{40,-12},{40,-40},{80,-40},{80,0}}), 
    Text(extent={{-150,-130},{150,-90}}, 
      textString="b=%b"), 
    Text(extent={{-150,100},{150,60}}, 
      textColor={0,0,255}, 
      textString="%name"), 
    Text(extent={{-152,-92},{148,-52}}, 
      textString="c=%c"), 
    Line(visible=useHeatPort, 
      points={{-100,-100},{-100,-43},{-34,-43}}, 
      color={191,0,0}, 
      pattern=LinePattern.Dot)}));
end ElastoBacklash;