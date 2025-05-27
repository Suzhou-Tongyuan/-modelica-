within Modelica.Electrical.Analog.Interfaces;
partial model TwoPort 
  "含电流的双端口组件"

  extends FourPin;

equation
  0 = p1.i + n1.i;
  0 = p2.i + n2.i;
  annotation(
    Diagram(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}, 
    grid = {2, 2}), graphics = {
    Polygon(
    points = {{-124, 103}, {-114, 100}, {-124, 97}, {-124, 103}}, 
    lineColor = {160, 160, 164}, 
    fillColor = {160, 160, 164}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{-140, 100}, {-115, 100}}, 
    color = {160, 160, 164}), 
    Polygon(
    points = {{130, -97}, {140, -100}, {130, -103}, {130, -97}}, 
    lineColor = {160, 160, 164}, 
    fillColor = {160, 160, 164}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{114, -100}, {139, -100}}, 
    color = {160, 160, 164}), 
    Text(
    extent = {{113, -96}, {129, -81}}, 
    textColor = {160, 160, 164}, 
    textString = "i2"), 
    Text(
    extent = {{122, 102}, {139, 117}}, 
    textColor = {160, 160, 164}, 
    textString = "i2"), 
    Polygon(
    points = {{124, 103}, {114, 100}, {124, 97}, {124, 103}}, 
    lineColor = {160, 160, 164}, 
    fillPattern = FillPattern.HorizontalCylinder, 
    fillColor = {160, 160, 164}), 
    Line(points = {{115, 100}, {140, 100}}, color = {160, 160, 164}), 
    Line(points = {{-140, -100}, {-115, -100}}, 
    color = {160, 160, 164}), 
    Polygon(
    points = {{-130, -97}, {-140, -100}, {-130, -103}, {-130, -97}}, 
    lineColor = {160, 160, 164}, 
    fillColor = {160, 160, 164}, 
    fillPattern = FillPattern.Solid), 
    Text(
    extent = {{-131, -97}, {-114, -82}}, 
    textColor = {160, 160, 164}, 
    textString = "i1"), 
    Text(
    extent = {{-140, 103}, {-123, 118}}, 
    textColor = {160, 160, 164}, 
    textString = "i1")}), 
    Documentation(revisions = "<html>
<ul>
<li><em> 1998   </em>
       由Christoph Clauss<br>初版创建<br>
       </li>
</ul>
</html>", 
    info = "<html>
<p>TwoPort是一个部分模型，由两个端口组成。与OnePort类似，每个端口都有两个引脚。假设流入正引脚的电流等于从引脚n流出的电流。每个端口的电流分别作为i1和i2明确提供，电压分别作为v1和v2。
</p>

</html>"));
end TwoPort;