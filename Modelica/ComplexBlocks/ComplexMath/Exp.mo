within Modelica.ComplexBlocks.ComplexMath;
block Exp "输出输入值的指数(基数为e)"
  extends Interfaces.ComplexSISO;
equation
  y = Modelica.ComplexMath.exp(uInternal);
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
    100, 100}}), graphics = {Line(points = {{0, -80}, {0, 68}}, color = {192, 192, 192}), 
    Polygon(
    points = {{0, 90}, {-8, 68}, {8, 68}, {0, 90}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), Text(
    extent = {{-86, 50}, {-14, 2}}, 
    textColor = {192, 192, 192}, 
    textString = "exp"), Line(points = {{-80, -80}, {-31, -77.9}, {-6.03, -74}, 
    {10.9, -68.4}, {23.7, -61}, {34.2, -51.6}, {43, -40.3}, {50.3, -27.8}, {
    56.7, -13.5}, {62.3, 2.23}, {67.1, 18.6}, {72, 38.2}, {76, 57.6}, {80, 80}}, color = 
    {85, 170, 255}), Line(points = {{-90, -80.3976}, {68, -80.3976}}, color = 
    {192, 192, 192}), Polygon(
    points = {{90, -80.3976}, {68, -72.3976}, {68, -88.3976}, {90, -80.3976}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid)}), 
    Documentation(info = "<html>
<p>
这个模块计算输入 <code>u</code> 的 <em>指数</em> (以e为底)作为输出 <code>y</code>。
可选地，当参数 <code>useConjugateInput</code> 为 <code>true</code> 时，
输入 <code>u</code> 可以是处理过的共轭复数。根据 <code>useConjugateInput</code> 的设置，
内部信号 <code>uInternal</code> 可能代表原始输入信号或共轭复数输入信号。
</p>
<blockquote><pre>
y = <strong>exp</strong>(uInternal);
</pre></blockquote>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/exp.png\"
     alt=\"exp.png\">
</div>

</html>"));
end Exp;