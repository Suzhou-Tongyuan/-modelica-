within Modelica.ComplexBlocks.ComplexMath;
block Tanh "输出输入值的双曲正切值"
  extends Interfaces.ComplexSISO;
equation
  y = Modelica.ComplexMath.tanh(uInternal);
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
    100, 100}}), graphics = {Line(points = {{0, -90}, {0, 84}}, color = {192, 192, 192}), 
    Line(points = {{-100, 0}, {84, 0}}, color = {192, 192, 192}), 
    Line(points = {{-80, -80}, {-47.8, -78.7}, {-35.8, -75.7}, {-27.7, -70.6}, 
    {-22.1, -64.2}, {-17.3, -55.9}, {-12.5, -44.3}, {-7.64, -29.2}, {-1.21, -4.82}, 
    {6.83, 26.3}, {11.7, 42}, {16.5, 54.2}, {21.3, 63.1}, {26.9, 69.9}, {34.2, 
    75}, {45.4, 78.4}, {72, 79.9}, {80, 80}}, color = {85, 170, 255}), 
    Polygon(
    points = {{0, 90}, {-8, 68}, {8, 68}, {0, 90}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), Text(
    extent = {{-88, 72}, {-16, 24}}, 
    textColor = {192, 192, 192}, 
    textString = "tanh"), Polygon(
    points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid)}), 
    Documentation(info = "<html>
<p>
这个模块计算输入 <code>u</code> 的 <em>双曲正切</em> 作为输出 <code>y</code>。
可选地，当参数 <code>useConjugateInput</code> 为 <code>true</code> 时，
输入 <code>u</code> 可以是处理过的共轭复数。
根据 <code>useConjugateInput</code> 的设置，
内部信号 <code>uInternal</code> 可能代表原始输入信号或共轭复数输入信号。
</p>
<blockquote><pre>
y = <strong>tanh</strong>(uInternal);
</pre></blockquote>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/tanh.png\"
     alt=\"tanh.png\">
</div>

</html>"));
end Tanh;