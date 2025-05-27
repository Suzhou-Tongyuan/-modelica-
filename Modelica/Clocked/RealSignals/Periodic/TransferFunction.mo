within Modelica.Clocked.RealSignals.Periodic;
block TransferFunction "离散时间传递函数模块"
  extends Clocked.RealSignals.Interfaces.PartialClockedSISO;
  parameter Real b[:]={1} "传递函数的分子系数";
  parameter Real a[:] "传递函数的分母系数";

  output Real x[size(a, 1) - 1](each start=0.0) 
    "控制器规范形式的状态矢量";
protected
  parameter Integer nb=size(b, 1) "传递函数分子的大小";
  parameter Integer na=size(a, 1) 
    "传递函数分母的大小";
  Real x1;
  Real xext[size(a, 1)];

equation
  when Clock() then
    /* 状态变量 x 根据
       控制器规范形式定义。*/
    x1 = (u - a[2:size(a, 1)]*previous(x))/a[1];
    xext = vector([x1; previous(x)]);
    x = xext[1:size(x, 1)];
    y = vector([zeros(na - nb, 1); b])*xext;
  end when;
  annotation (
    Documentation(info="<html><p>
<span style=\"color: rgb(51, 51, 51);\"><strong>离散传递函数</strong></span><span style=\"color: rgb(51, 51, 51);\">模块定义了输入信号 u 和输出信号 y 之间的传递函数。分子为 nb-1 次，分母为 na-1 次。</span>
</p>
<p>
<br>
</p>
<pre><code >       b(1)*z^(nb-1) + b(2)*z^(nb-2) + … + b(nb)
y(z) = -------------------------------------------- * u(z)
       a(1)*z^(na-1) + a(2)*z^(na-2) + … + a(na)
</code></pre><p>
<br>
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">状态变量 </span><span style=\"color: rgb(51, 51, 51);\"><strong>x </strong></span><span style=\"color: rgb(51, 51, 51);\">按照</span><span style=\"color: rgb(51, 51, 51);\"><strong>控制器标准形</strong></span><span style=\"color: rgb(51, 51, 51);\">定义。状态的初始值可以设置为 </span><span style=\"color: rgb(51, 51, 51);\"><strong>x</strong></span><span style=\"color: rgb(51, 51, 51);\"> 的起始值。</span>
</p>
<p>
例如:
</p>
<p>
<br>
</p>
<pre><code >TransferFunction g(b = {2,4}, a = {1,3});
</code></pre><p>
<br>
</p>
<p>
results in the following transfer function:
</p>
<p>
<br>
</p>
<pre><code >     2*z + 4
y = --------- * u
      z + 3
</code></pre><p>
<br>
</p>
<p>
<br>
</p>
</html>",revisions="<html>
<p><strong>Release Notes:</strong></p>
<ul>
<li><em>August 13, 2012</em>
    by <a href=\"http://www.dlr.de/rm/\">Bernhard Thiele</a>:<br>
    Used the original code from Blocks.Discrete.TransferFunction and converted it into
    the Modelica 3.3 clocked equation style.</li>
<li><em>November 15, 2000</em>
    by <a href=\"http://www.dynasim.se\">Hans Olsson</a>:<br>
    Converted to when-semantics of Modelica 1.4 with special
    care to avoid unnecessary algebraic loops.</li>
<li><em>June 18, 2000</em>
    by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
    Realized based on a corresponding model of Dieter Moormann
    and Hilding Elmqvist.</li>
</ul>
</html>"), 
    Icon(coordinateSystem(
        preserveAspectRatio=false, 
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{82,0},{-84,0}}, color={0,0,127}), 
        Text(
          extent={{-92,92},{86,12}}, 
          textColor={0,0,127}, 
          textString="b(z)"), 
        Text(
          extent={{-90,-12},{90,-90}}, 
          textColor={0,0,127}, 
          textString="a(z)")}), 
    Diagram(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}), 
        Line(
          points={{40,0},{-44,0}}, 
          thickness=0.5), 
        Text(
          extent={{-54,54},{54,4}}, 
          textString="b(z)"), 
        Text(
          extent={{-54,-6},{56,-56}}, 
          textString="a(z)"), 
        Line(points={{-100,0},{-60,0}}, color={0,0,255}), 
        Line(points={{60,0},{100,0}}, color={0,0,255})}));
end TransferFunction;