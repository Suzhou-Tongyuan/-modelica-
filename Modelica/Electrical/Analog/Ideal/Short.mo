within Modelica.Electrical.Analog.Ideal;
model Short "短路分支"
  extends Interfaces.OnePort;
equation
  v = 0;
  annotation(
    Documentation(info = "<html>
<p>Short模型是一个简单的短路分支。这意味着两个引脚之间的电压降为零。如果将两个引脚的节点合并，则可以忽略此设备。除了将两个引脚的节点连接起来之外，该设备没有其他功能。
</p>

</html>", 
    revisions = "<html>
<ul>

<li><em>1998年</em>
       Christoph Clauss<br>最初实现<br>
       </li>
</ul>

</html>"), 
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
    100}}), graphics = {
    Rectangle(
    extent = {{-80, 80}, {80, -80}}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid, 
    lineColor = {0, 0, 255}), 
    Line(points = {{91, 0}, {-90, 0}}, color = {0, 0, 255}), 
    Text(
    extent = {{-150, 130}, {150, 90}}, 
    textString = "%name", 
    textColor = {0, 0, 255})}), 
    Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
    100, 100}}), graphics = {
    Text(
    extent = {{-100, 100}, {100, 70}}, 
    textString = "Short", 
    textColor = {0, 0, 255})}));
end Short;