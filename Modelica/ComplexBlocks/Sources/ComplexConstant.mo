within Modelica.ComplexBlocks.Sources;
block ComplexConstant "生成复数类型的常量信号"
  parameter Complex k(re(start = 1), im(start = 0)) "恒定输出值";
  extends Modelica.ComplexBlocks.Interfaces.ComplexSO;

equation
  y = k;
  annotation(
    defaultComponentName = "complexConst", 
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
    100, 100}}), graphics = {Line(points = {{-80, 68}, {-80, -80}}, color = {
    192, 192, 192}), Polygon(
    points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), Line(points = {{-90, -70}, {82, -70}}, 
    color = {192, 192, 192}), Polygon(
    points = {{90, -70}, {68, -62}, {68, -78}, {90, -70}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), Line(points = {{-80, 0}, {80, 0}}, color = 
    {85, 170, 255}), Text(
    extent = {{-150, -150}, {150, -110}}, 
    textString = "k=%k")}), 
    Documentation(info = "<html>
<p>
复数输出信号 y 是一个常数信号：
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Constant.png\"
     alt=\"Constant.png\">
</div>
</html>"));
end ComplexConstant;