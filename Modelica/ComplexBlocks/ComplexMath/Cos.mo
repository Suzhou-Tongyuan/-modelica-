within Modelica.ComplexBlocks.ComplexMath;
block Cos "输出输入值的余弦值"
  extends Interfaces.ComplexSISO;
equation
  y = Modelica.ComplexMath.cos(uInternal);
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
    100, 100}}), graphics = {Polygon(
    points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), Line(points = {{-80, -80}, {-80, 68}}, 
    color = {192, 192, 192}), Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), 
    Polygon(
    points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), Line(points = {{-80, 80}, {-74.4, 
    78.1}, {-68.7, 72.3}, {-63.1, 63}, {-56.7, 48.7}, {-48.6, 26.6}, {-29.3, -32.5}, 
    {-22.1, -51.7}, {-15.7, -65.3}, {-10.1, -73.8}, {-4.42, -78.8}, {1.21, -79.9}, 
    {6.83, -77.1}, {12.5, -70.6}, {18.1, -60.6}, {24.5, -45.7}, {32.6, -23}, {
    50.3, 31.3}, {57.5, 50.7}, {63.9, 64.6}, {69.5, 73.4}, {75.2, 78.6}, {80, 80}}, color = 
    {85, 170, 255}), Text(
    extent = {{-36, 82}, {36, 34}}, 
    textColor = {192, 192, 192}, 
    textString = "cos")}), 
    Documentation(info = "<html>
<p>
这个模块计算输出 <code>y</code> 为输入 <code>u</code>的 <strong>余弦值</strong>。
可选地，当参数 <code>useConjugateInput</code> 为 <code>true</code> 时，
输入 <code>u</code> 可以处理为共轭复数。
根据 <code>useConjugateInput</code> 参数的值，
内部信号 <code>uInternal</code> 可以代表原始的或共轭的复数输入信号。
</p>
<blockquote><pre>
y = <strong>cos</strong>(uInternal);
</pre></blockquote>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/cos.png\"
     alt=\"cos.png\">
</div>

</html>"));
end Cos;