within Modelica.ComplexBlocks.ComplexMath;
block Add "输出两个输入的总和"
  extends Interfaces.ComplexSI2SO;
  parameter Complex k1 = Complex(1, 0) "输入1的增益";
  parameter Complex k2 = Complex(1, 0) "输入2的增益";
equation
  y = k1 * u1Internal + k2 * u2Internal;
  annotation(
    Documentation(info = "<html>
<p>
这个模块将输出 <code>y</code> 计算为输入信号 <code>u1</code> 和 <code>u2</code> 的和。
可选地，当参数 <code>useConjugateInput1</code> 和 
<code>useConjugateInput2</code> 分别为 <code>true</code> 时，
可以处理输入 <code>u1</code> 或 <code>u2</code> 或两者都是共轭复数。
</p>
<blockquote><pre>
y = k1*u1Internal + k2*u2Internal;
</pre></blockquote>
<p>
<strong>示例</strong>参数:
</p>
<ul>
<li><code>k1 = +2</code>,</li>
<li><code>k2 = -3</code>,</li>
<li><code>useConjugateInput1 = true</code>,</li>
<li><code>useConjugateInput2 = false</code></li>
</ul>
<p>
导致下面的方程式：
</p>
<blockquote><pre>
y = 2 * Modelica.ComplexMath.conj(u1) - 3 * u2
</pre></blockquote>

</html>"), 
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
    100, 100}}), graphics = {Text(extent = {{-98, -52}, {5, -92}}, 
    textString = "%k2"), Text(extent = {{-98, 92}, {5, 52}}, textString = "%k1"), 
    Line(points = {{50, 0}, {100, 0}}, color = {0, 0, 255}), 
    Line(points = {{-100, 60}, {-74, 24}, {-44, 24}}, color = {85, 170, 255}), 
    Line(points = {{-100, -60}, {-74, -24}, {-44, -24}}, color = {85, 170, 255}), 
    Ellipse(extent = {{-50, 50}, {50, -50}}, lineColor = {85, 170, 255}), 
    Line(points = {{50, 0}, {100, 0}}, color = {85, 170, 255}), 
    Text(extent = {{-40, 40}, {40, -40}}, 
    textColor = {85, 170, 255}, 
    textString = "+")}));
end Add;