within Modelica.ComplexBlocks.ComplexMath;
block Tan "输出输入值的正切值"
  extends Interfaces.ComplexSISO;
equation
  y = Modelica.ComplexMath.tan(uInternal);
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
    100, 100}}), graphics = {Polygon(
    points = {{0, 90}, {-8, 68}, {8, 68}, {0, 90}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), Line(points = {{0, -80}, {0, 68}}, 
    color = {192, 192, 192}), Line(points = {{-80, -80}, {-78.4, -68.4}, {-76.8, 
    -59.7}, {-74.4, -50}, {-71.2, -40.9}, {-67.1, -33}, {-60.7, -24.8}, {-51.1, 
    -17.2}, {-35.8, -9.98}, {-4.42, -1.07}, {33.4, 9.12}, {49.4, 16.2}, {59.1, 
    23.2}, {65.5, 30.6}, {70.4, 39.1}, {73.6, 47.4}, {76, 56.1}, {77.6, 63.8}, {
    80, 80}}, color = {85, 170, 255}), 
    Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), 
    Polygon(
    points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), Text(
    extent = {{-90, 72}, {-18, 24}}, 
    textColor = {192, 192, 192}, 
    textString = "tan")}), 
    Documentation(info = "<html>
<p>
这个模块计算输出 <code>y</code> 为输入 <code>u</code> 的 <strong>正切值</strong>。
可选地，当参数 <code>useConjugateInput</code> 为 <code>true</code> 时，
输入 <code>u</code> 可以处理为共轭复数。
根据 <code>useConjugateInput</code> 参数的值，
内部信号 <code>uInternal</code> 可以代表原始的或共轭的复数输入信号。
</p>
<blockquote><pre>
y = <strong>tan</strong>(uInternal);
</pre></blockquote>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/tan.png\"
     alt=\"tan.png\">
</div>

</html>"));
end Tan;