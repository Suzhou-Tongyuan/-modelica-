within Modelica.Electrical.Analog.Ideal;
model Idle "开路分支"
  extends Interfaces.OnePort;
equation
  i = 0;
  annotation(
    Documentation(info = "<html>
<p>
Idle模型是一个简单的开路分支。这意味着在两个端子之间没有电流通过。这个理想化的组件对电路的电气行为没有任何影响。因此，在电路分析中可以将其视为不存在。为了确保模型的完整性，这个开路组件被包含在MSL中，作为短路的对立组件。
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
    Line(points = {{-90, 0}, {-41, 0}}, color = {0, 0, 255}), 
    Line(points = {{91, 0}, {40, 0}}, color = {0, 0, 255}), 
    Text(
    extent = {{-150, 130}, {150, 90}}, 
    textString = "%name", 
    textColor = {0, 0, 255})}));
end Idle;