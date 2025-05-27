within Modelica.ComplexBlocks.ComplexMath;
block Sqrt 
  "输出输入值的平方根(=复数的主平方根)"
  extends Interfaces.ComplexSISO;
equation
  y = Modelica.ComplexMath.sqrt(uInternal);
  annotation(
    defaultComponentName = "sqrt1", 
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
    100, 100}}), graphics = {Line(points = {{-90, -80}, {68, -80}}, color = {
    192, 192, 192}), Polygon(
    points = {{90, -80}, {68, -72}, {68, -88}, {90, -80}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), Line(points = {{-80, -80}, {-79.2, 
    -68.7}, {-78.4, -64}, {-76.8, -57.3}, {-73.6, -47.9}, {-67.9, -36.1}, {-59.1, 
    -22.2}, {-46.2, -6.49}, {-28.5, 10.7}, {-4.42, 30}, {27.7, 51.3}, {69.5, 
    74.7}, {80, 80}}, color = {85, 170, 255}), 
    Polygon(
    points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), Line(points = {{-80, -88}, {-80, 68}}, 
    color = {192, 192, 192}), Text(
    extent = {{-8, -4}, {64, -52}}, 
    textColor = {192, 192, 192}, 
    textString = "sqrt")}), 
    Documentation(info = "<html>
<p>
该模块将输出 <code>y</code> 计算为输入 <code>u</code> 的 <em>平方根</em>（= 输入复数的主平方根）。
如果参数 <code>useConjugateInput</code> 为 <code>true</code>，
还可以选择处理输入 <code>u</code> 的共轭复数。
根据 <code>useConjugateInput</code> 的不同，
内部信号 <code>uInternal</code> 代表原始或共轭复变输入信号。
</p>
<blockquote><pre>
y = <strong>sqrt</strong>(uInternal);
</pre></blockquote>
</html>"));
end Sqrt;