within Modelica.ComplexBlocks.ComplexMath;
block Gain "输出增益值与输入信号的乘积"

  parameter Complex k(re(start = 1), im(start = 0)) 
    "与输入信号相乘的增益值";
  parameter Boolean useConjugateInput = false 
    "如果为真，则处理输入的共轭复数";
  Interfaces.ComplexInput u "输入信号连接器" annotation(Placement(
    transformation(extent = {{-140, -20}, {-100, 20}})));
  Interfaces.ComplexOutput y "输入出信号连接器" annotation(
    Placement(transformation(extent = {{100, -10}, {120, 10}})));

equation
  y = k * (if useConjugateInput then Modelica.ComplexMath.conj(u) else u);
  annotation(
    Documentation(info="<html><p>
这个模块根据增益<code>k</code>与输入信号<code>u</code>的<em>乘积</em>计算输出信号<code>y</code>。 可选地，如果参数<code>useConjugateInput</code>设置为<code>true</code>， <span style=\"color: rgb(51, 51, 51);\">输入 </span><code>u</code><span style=\"color: rgb(51, 51, 51);\"> 可以被处理为共轭复数</span>。 <span style=\"color: rgb(51, 51, 51);\">根据</span><code>useConjugateInput</code><span style=\"color: rgb(51, 51, 51);\"> 的值，处理的是原始输入信号还是共轭复数输入信号。</span>
</p>
<p>
<br>
</p>
<pre><code >y = k * (if useConjugateInput then Modelica.ComplexMath.conj(u) else u);
</code></pre><p>
<br>
</p>
<p>
<strong>示例：</strong> 如果<code>useConjugateInput = true</code> 和 <code>k = 2</code>，输出信号<code>y = 2 * Modelica.ComplexMath.conj(u)</code>.
</p>
<p>
<br>
</p>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
    100, 100}}), graphics = {Polygon(
    points = {{-100, -100}, {-100, 100}, {100, 0}, {-100, -100}}, 
    lineColor = {85, 170, 255}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), Text(
    extent = {{-150, -140}, {150, -100}}, 
    textString = "k=%k"), Text(
    extent = {{-150, 140}, {150, 100}}, 
    textString = "%name", 
    textColor = {0, 0, 255})}));
end Gain;