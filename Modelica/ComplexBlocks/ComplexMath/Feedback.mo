within Modelica.ComplexBlocks.ComplexMath;
block Feedback 
  "输出指令输入1和反馈输入2之间的差值"

  Interfaces.ComplexInput u1 annotation(Placement(transformation(extent = {{-100, 
    -20}, {-60, 20}}), iconTransformation(extent = {{-100, -20}, {-60, 20}})));
  Interfaces.ComplexInput u2 annotation(Placement(transformation(
    origin = {0, -100}, 
    extent = {{-20, -20}, {20, 20}}, 
    rotation = 90), iconTransformation(
    extent = {{-20, -20}, {20, 20}}, 
    rotation = 90, 
    origin = {0, -80})));
  Interfaces.ComplexOutput y annotation(Placement(transformation(extent = {{80, -10}, 
    {100, 10}}), iconTransformation(extent = {{80, -10}, {100, 10}})));

  parameter Boolean useConjugateInput1 = false 
    "如果为真，则处理输入1的共轭复数";
  parameter Boolean useConjugateInput2 = false 
    "如果为真，则处理输入2的共轭复数";

equation
  y = (if useConjugateInput1 then Modelica.ComplexMath.conj(u1) else u1) - 
    (if useConjugateInput2 then Modelica.ComplexMath.conj(u2) else u2);
  annotation(
    Documentation(info="<html><p>
这个模块计算输出信号 <code>y</code>， 其值为指令输入 <code>u1</code> 和反馈输入 <code>u2</code> 之间的 <em>差异</em>。 可选地，当参数 <code>useConjugateInput1</code> 和 <code>useConjugateInput2</code> 分别为 <code>true</code> 时， 可以处理输入 <code>u1</code> 和 <code>u2</code> 的复共轭。
</p>
<p>
<br>
</p>
<pre><code >y = (if useConjugateInput1 then Modelica.ComplexMath.conj(u1) else u1)
  - (if useConjugateInput1 then Modelica.ComplexMath.conj(u2) else u2);
</code></pre><p>
<br>
</p>
<p>
<strong>示例</strong>参数:
</p>
<li>
<code>useConjugateInput1 = true</code>,</li>
<li>
<code>useConjugateInput2 = false</code></li>
<p>
导致下面的方程式：
</p>
<p>
<br>
</p>
<pre><code >y = Modelica.ComplexMath.conj(u1) - u2
</code></pre><p>
<br>
</p>
<p>
<br>
</p>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
    100, 100}}), graphics = {Ellipse(
    extent = {{-20, 20}, {20, -20}}, 
    lineColor = {85, 170, 255}, 
    fillColor = {235, 235, 235}, 
    fillPattern = FillPattern.Solid), Line(points = {{-60, 0}, {-20, 0}}, 
    color = {85, 170, 255}), 
    Line(points = {{20, 0}, {80, 0}}, color = {85, 170, 255}), 
    Line(points = {{0, -20}, {0, -60}}, color = {85, 170, 255}), 
    Text(
    extent = {{-150, 94}, {150, 44}}, 
    textString = "%name", 
    textColor = {0, 0, 255}), Text(
    extent = {{20, -20}, {100, -100}}, 
    textColor = {85, 170, 255}, 
    textString = "-")}));
end Feedback;