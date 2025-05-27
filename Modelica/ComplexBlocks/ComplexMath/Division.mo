within Modelica.ComplexBlocks.ComplexMath;
block Division "输出第一个输入除以第二个输入"
  extends Interfaces.ComplexSI2SO;
  parameter Boolean useConjugateInput1 = false 
    "如果为真，则处理输入1的共轭复数";
  parameter Boolean useConjugateInput2 = false 
    "如果为真，则处理输入2的共轭复数";
equation
  y = (if useConjugateInput1 then Modelica.ComplexMath.conj(u1) else u1) / (
    if useConjugateInput2 then Modelica.ComplexMath.conj(u2) else u2);
  annotation(
    Documentation(info="<html><p>
这个模块按逐元素将两个输入信号 <code>u1</code> 和 <code>u2</code> 对应元素 <em>相除</em>，计算输出信号 <code>y</code>。 可选地，当参数 <code>useConjugateInput1</code> 和 <code>useConjugateInput2</code> 分别为 <code>true</code> 时， 输入 <code>u1</code> 或 <code>u2</code> 或两者都可以被处理为共轭复数。 根据 <code>useConjugateInput1</code> 和 <code>useConjugateInput2</code> 的设定， 内部信号可以表示原始的输入信号或其共轭复数形式。
</p>
<p>
<br>
</p>
<pre><code >y = u1Internal / u2Internal;
</code></pre><p>
<br>
</p>
<p>
<strong>示例：</strong> 如果 <code>useConjugateInput1 = true</code> 和 <code>useConjugateInput2 = false</code> 输出信号 <code>y = Modelica.ComplexMath.conj(u1) / u2</code>.
</p>
<p>
<br>
</p>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
    100, 100}}), graphics = {
    Line(points = {{-100, 60}, {-60, 60}, {0, 0}}, color = {85, 170, 255}), 
    Line(points = {{-100, -60}, {-60, -60}, {0, 0}}, color = {85, 170, 255}), 
    Ellipse(extent = {{-50, 50}, {50, -50}}, lineColor = {85, 170, 255}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{50, 0}, {100, 0}}, color = {85, 170, 255}), 
    Line(points = {{-30, 0}, {30, 0}}, color = {85, 170, 255}), 
    Ellipse(
    extent = {{-5, 20}, {5, 30}}, 
    lineColor = {85, 170, 255}, 
    fillColor = {85, 170, 255}, 
    fillPattern = FillPattern.Solid), Ellipse(
    extent = {{-5, -20}, {5, -30}}, 
    lineColor = {85, 170, 255}, 
    fillColor = {85, 170, 255}, 
    fillPattern = FillPattern.Solid), 
    Text(
    extent = {{-60, 90}, {90, 50}}, 
    textColor = {128, 128, 128}, 
    textString = "u1 / u2")}), 
    Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
    {100, 100}}), graphics = {Line(points = {{50, 0}, {100, 0}}, 
    color = {0, 0, 255})}));
end Division;