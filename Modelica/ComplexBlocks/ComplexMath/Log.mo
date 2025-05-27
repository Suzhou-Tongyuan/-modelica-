within Modelica.ComplexBlocks.ComplexMath;
block Log "输出输入值的自然对数(以e为底)(要求输入 <> '0)"
  extends Interfaces.ComplexSISO;
equation
  y = Modelica.ComplexMath.log(uInternal);
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
    100, 100}}), graphics = {Line(points = {{-80, -80}, {-80, 68}}, color = {
    192, 192, 192}), Polygon(
    points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), Line(points = {{-80, -80}, {-79.2, 
    -50.6}, {-78.4, -37}, {-77.6, -28}, {-76.8, -21.3}, {-75.2, -11.4}, {-72.8, 
    -1.31}, {-69.5, 8.08}, {-64.7, 17.9}, {-57.5, 28}, {-47, 38.1}, {-31.8, 
    48.1}, {-10.1, 58}, {22.1, 68}, {68.7, 78.1}, {80, 80}}, color = {85, 170, 
    255}), 
    Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), Polygon(
    points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), Text(
    extent = {{-6, -24}, {66, -72}}, 
    textColor = {192, 192, 192}, 
    textString = "log")}), 
    Documentation(info = "<html>
<p>
这个模块计算输入 <code>u</code> 的 <em>自然对数(以e为底的对数)</em> 作为输出 <code>y</code>。
可选地，当参数 <code>useConjugateInput</code> 为 <code>true</code> 时，
输入 <code>u</code> 可以是处理过的共轭复数。
根据 <code>useConjugateInput</code> 的设置，
内部信号 <code>uInternal</code> 可能代表原始输入信号或共轭复数输入信号。
</p>
<blockquote><pre>
y = <strong>log</strong>(uInternal);
</pre></blockquote>
<p>
如果输入 <code>u</code> 的元素为零，就会发生错误。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/log.png\"
     alt=\"log.png\">
</div>

</html>"));
end Log;