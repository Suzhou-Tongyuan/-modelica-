within Modelica.Mechanics.Rotational.Components;
model ElastoBacklash2 
  "串联连接到线性弹簧和阻尼器的齿隙（齿隙用弹性建模；在接触开始时，一维转动接口扭矩可能会跳跃，与 ElastoBacklash 模型相反)"

  parameter SI.RotationalSpringConstant c(final min=Modelica.Constants.small, 
      start=1.0e5) "弹簧刚度系数（要求 c > 0）";
  parameter SI.RotationalDampingConstant d(final min=0, start=0) 
    "阻尼系数";
  parameter SI.Angle b(final min=0)=0 "总齿隙";
  parameter SI.Angle phi_rel0=0 "未拉伸弹簧角度";

  extends 
    Modelica.Mechanics.Rotational.Interfaces.PartialCompliantWithRelativeStates;
  extends 
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;
protected
  final parameter SI.Angle bMax=b/2 
    "在范围 bMin <= phi_rel - phi_rel0 <= bMax 内的齿隙";
  final parameter SI.Angle bMin=-bMax 
    "在范围 bMin <= phi_rel - phi_rel0 <= bMax 内的齿隙";
  SI.Torque tau_c;
  SI.Torque tau_d;
  SI.Angle phi_diff=phi_rel - phi_rel0;

  // 为避免当齿隙 b 设为零时出现无限数量的状态事件，在此定义最小齿隙。
  constant SI.Angle bEps=1e-10 "最小齿隙";

equation
  if initial() then
    /* 在初始化期间，修改特性，以便它是严格单调递增的函数。
        否则，当特性必须反转时，初始化可能会导致奇异系统。在范围 1.5*bMin <= phi_rel - phi_rel0 <= 1.5 bMax 内修改特性，
        以便在此范围内存在一个线性特性，该特性在其极限处连续地接近原始函数，例如，
          原始：  tau(1.5*bMax) = c*(phi_diff - bMax)
                                   = c*(0.5*bMax)
          初始：  tau(1.5*bMax) = (c/3)*phi_diff
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
        tau   = if tau_c + tau_d <= 0 then 0 else tau_c + tau_d;
     elseif phi_diff < bMin then
        tau_c = c*(phi_diff - bMin);
        tau_d = d*w_rel;
        tau   = if tau_c + tau_d >= 0 then 0 else tau_c + tau_d;
     else
        tau_c = 0;
        tau_d = 0;
        tau   = 0;
     end if;

     为了避免在翻译期间评估参数 "b"（即，在上述形式中，在翻译后无法再更改它），
     将其以以下形式编写。
   */

    tau_c = if abs(b) <= bEps then 
               c*phi_diff 
            else if phi_diff > bMax then 
               c*(phi_diff - bMax) 
            else if phi_diff < bMin then 
               c*(phi_diff - bMin) 
            else 0;
    tau_d = d*w_rel;

    tau = if abs(b) <= bEps then 
             tau_c + tau_d 
          else if phi_diff > bMax then 
             (if tau_c + tau_d <= 0 then 0 else tau_c + tau_d) 
          else if phi_diff < bMin then 
             (if tau_c + tau_d >= 0 then 0 else tau_c + tau_d) 
          else 0;

    lossPower = if abs(b) <= bEps then 
                   tau_d*w_rel 
                else if phi_diff > bMax then 
                   (if tau_c + tau_d <= 0 then 0 else tau_d*w_rel) 
                else if phi_diff < bMin then 
                   (if tau_c + tau_d >= 0 then 0 else tau_d*w_rel) 
                else 0;
  end if;
  annotation (defaultComponentName="elastoBacklash", 
    Documentation(info="<html>
<p>
该元素由一个<strong>回程</strong>元素串联连接到一个<strong>弹簧</strong>和<strong>阻尼器</strong>元素，它们<strong>并联连接</strong>。
弹簧常数必须是非零的，否则该组件无法使用。
</p>

<p>
与IdealGear组件结合使用时，ElastoBacklash2模型可用于建模带有回程、弹性和阻尼的齿轮箱。
</p>

<p>
在初始化过程中，回程特性在回程区域被连续的近似替代，以减少初始化过程中的问题，特别是对于逆向模型。
</p>

<p>
如果回程b小于1e-10 rad（特别是，如果b=0），则忽略回程，并且该组件简化为并联的弹簧/阻尼器元素。
</p>

<p>
在回程区域（-b/2 ≤ flange_b.phi - flange_a.phi - phi_rel0 ≤ b/2）内不施加扭矩（flange_b.tau = 0）。在此区域之外，存在接触，接触扭矩基本上是用线性弹簧/阻尼器特性计算的：
</p>

<blockquote><pre>
desiredContactTorque = c*phi_contact + d*<strong>der</strong>(phi_contact)

         phi_contact = phi_rel - phi_rel0 - b/2 <strong>if</strong> phi_rel - phi_rel0 &gt;  b/2
                     = phi_rel - phi_rel0 + b/2 <strong>if</strong> phi_rel - phi_rel0 &lt; -b/2

         phi_rel     = flange_b.phi - flange_a.phi;
</pre></blockquote>

<p>
这种扭矩特性导致以下困难：
</p>

<ul>
<li> 如果阻尼器扭矩大于弹簧扭矩且具有相反的符号，接触扭矩将是“拉/粘”的，这是不物理的，因为在接触时只会发生推力扭矩。</li>
</ul>

<p>
在文献中似乎没有讨论这个问题。因此，在ElastoBacklash2模型中使用最简单的方法，稍微改变线性弹簧/阻尼器特性为：
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
   flange_b.tau = <strong>if</strong> tau_c + tau_d &le; 0 <strong>then</strong> 0 <strong>else</strong> tau_c + tau_d;
<strong>end if</strong>;
</pre></blockquote>


<p>
注意，当发生粘连时（tau_c + tau_d &le; 0），则将接触扭矩明确设置为零。
</p>

<p>
这种回程模型与ElastoBacklash组件略有不同：
</p>

<ul>
<li> 当接触发生或接触释放时，会发生事件（与ElastoBacklash组件相反）。</li>
<li> 当接触发生时，由于阻尼，扭矩会发生不连续变化。与ElastoBacklash组件相比，阻尼较大（对于相同的阻尼系数），
    因为ElastoBacklash组件具有一种启发式方法，以避免接触发生时扭矩的不连续性。</li>
<li> 对于某些模型，ElastoBacklash2组件导致模拟速度更快（与使用ElastBacklash组件相比）。</li>
</ul>

<p>
对于
<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.StateSelection\">State Selection</a>。
的进一步讨论请查阅Rotational库的用户手册
</p>

</html>"), 
    Icon(
    coordinateSystem(preserveAspectRatio=false, 
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
      pattern=LinePattern.Dot), 
        Text(
          extent={{20,48},{80,10}}, 
          textColor={95,95,95}, 
          textString="2")}));
end ElastoBacklash2;