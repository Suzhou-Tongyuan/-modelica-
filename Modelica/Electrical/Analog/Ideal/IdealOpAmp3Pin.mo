within Modelica.Electrical.Analog.Ideal;
model IdealOpAmp3Pin 
  "理想运算放大器(涉及无源器和无电位器对)，但有3个引脚"
  Interfaces.PositivePin in_p "输入端正极" annotation(
    Placement(transformation(extent = {{-110, -70}, {-90, -50}}), iconTransformation(extent = {{-110, -70}, {-90, -50}})));
  Interfaces.NegativePin in_n "输入端负极" annotation(
    Placement(transformation(extent = {{-110, 50}, {-90, 70}}), iconTransformation(extent = {{-110, 50}, {-90, 70}})));
  Interfaces.PositivePin out "输出接口" annotation(Placement(
    transformation(extent = {{90, -10}, {110, 10}}), iconTransformation(extent = {{90, -10}, {110, 10}})));
equation
  in_p.v = in_n.v;
  in_p.i = 0;
  in_n.i = 0;
  annotation(defaultComponentName = "opAmp", 
    Documentation(info = "<html>
<p>
具有三个管脚的理想运算放大器的行为与具有四个管脚的理想运算放大器的行为完全相同，仅是缺少了负输出管脚。输入端的电压和电流都被固定为零(空路器)。输出管脚上可能的任何电压为<em>v2</em>，也可能的任何电流为<em>i2</em>。
</p>

</html>", 
    revisions = "<html>
<ul>
<li><em> 2002   </em>
       Christoph Clauss<br>创建br>
       </li>
</ul>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
    100}}), graphics = {
    Line(points = {{60, 0}, {90, 0}}, color = {0, 0, 255}), 
    Text(
    extent = {{-150, 130}, {150, 90}}, 
    textString = "%name", 
    textColor = {0, 0, 255}), 
    Polygon(
    points = {{70, 0}, {-70, 80}, {-70, -80}, {70, 0}}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid, 
    lineColor = {0, 0, 255}), 
    Line(points = {{-100, 60}, {-70, 60}}, color = {0, 0, 255}), 
    Line(points = {{-100, -60}, {-70, -60}}, color = {0, 0, 255}), 
    Line(points = {{70, 0}, {100, 0}}, color = {0, 0, 255}), 
    Line(points = {{-60, 50}, {-40, 50}}, color = {0, 0, 255}), 
    Line(points = {{-60, -50}, {-40, -50}}, color = {0, 0, 255}), 
    Line(points = {{-50, -40}, {-50, -60}}, color = {0, 0, 255})}));
end IdealOpAmp3Pin;