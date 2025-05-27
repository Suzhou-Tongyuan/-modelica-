within Modelica.ComplexBlocks.ComplexMath;
block Product "输出两个输入的乘积"
  extends Interfaces.ComplexSI2SO;
equation
  y = u1Internal * u2Internal;
  annotation(
    Documentation(info="<html><p>
这个模块按元素计算输出 <code>y</code>， 即两个输入信号 <code>u1</code> 和 <code>u2</code> 对应元素的 <em>乘积</em>。 可选地，当参数 <code>useConjugateInput1</code> 和 <code>useConjugateInput2</code> 分别为 <code>true</code> 时， 输入 <code>u1</code> 或 <code>u2</code> 或两者都可以被处理为共轭复数。 根据 <code>useConjugateInput1</code> 和 <code>useConjugateInput2</code> 的设置， 内部信号可以表示原始的输入信号或其共轭复数形式。
</p>
<p>
<br>
</p>
<pre><code >y = u1Inernal * u2Internal;
</code></pre><p>
<br>
</p>
<p>
<strong>示例：</strong> 如果 <code>useConjugateInput1 = true</code> 和 <code>useConjugateInput2 = false</code> 输出信号 <code>y = Modelica.ComplexMath.conj(u1) * u2</code>.
</p>
<p>
<br>
</p>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
    100, 100}}), graphics = {Line(points = {{-100, 60}, {-40, 60}, {-30, 40}}, 
    color = {85, 170, 255}), 
    Line(points = {{-100, -60}, {-40, -60}, {-30, -40}}, 
    color = {85, 170, 255}), 
    Line(points = {{50, 0}, {100, 0}}, color = {85, 170, 255}), 
    Line(points = {{-30, 0}, {30, 0}}, color = {85, 170, 255}), 
    Line(points = {{-15, 
    25.99}, {15, -25.99}}, color = {85, 170, 255}), 
    Line(points = {{-15, -25.99}, {15, 
    25.99}}, color = {85, 170, 255}), 
    Ellipse(extent = {{-50, 50}, {50, -50}}, 
    lineColor = {85, 170, 255})}));
end Product;