within Modelica.ComplexBlocks.Interfaces;
connector ComplexOutput = output Complex "'output Complex'作为连接器" 
  annotation(
  IconMap(primitivesVisible = false), 
  defaultComponentName = "y", 
  Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
  100}}), graphics = {Polygon(
  points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}}, 
  lineColor = {85, 170, 255}, 
  fillColor = {255, 255, 255}, 
  fillPattern = FillPattern.Solid)}), 
  Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
  100, 100}}), graphics = {Polygon(
  points = {{-100, 50}, {0, 0}, {-100, -50}, {-100, 50}}, 
  lineColor = {85, 170, 255}, 
  fillColor = {255, 255, 255}, 
  fillPattern = FillPattern.Solid), Text(
  extent = {{30, 110}, {30, 60}}, 
  textColor = {85, 170, 255}, 
  textString = "%name")}), 
  Documentation(info = "<html>
<p>
具有一个复数类型的输出信号的连接器。
</p>
</html>"));