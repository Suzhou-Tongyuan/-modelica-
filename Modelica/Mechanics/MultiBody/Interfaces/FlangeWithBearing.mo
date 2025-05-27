within Modelica.Mechanics.MultiBody.Interfaces;
connector FlangeWithBearing 
  "包含一维转动接口和轴承坐标系的连接器"
  parameter Boolean includeBearingConnector = false 
    "= true, 表示存在轴承坐标系连接器，否则表示不存在";
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange 
    "一维转动接口";
  Modelica.Mechanics.MultiBody.Interfaces.Frame bearingFrame if includeBearingConnector "三维坐标系，其中已安装一维轴";

  annotation(
    defaultComponentName = "flange", 
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Rectangle(
    extent = {{-20, 1}, {20, -1}}, 
    lineColor = {135, 135, 135}, 
    lineThickness = 0.5), 
    Rectangle(
    extent = {{-100, 100}, {100, -100}}, 
    lineColor = {255, 255, 255}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), 
    Rectangle(
    extent = {{-100, 25}, {100, -25}}, 
    lineColor = {64, 64, 64}, 
    fillPattern = FillPattern.HorizontalCylinder, 
    fillColor = {192, 192, 192}), 
    Line(points = {{-80, 60}, {80, 60}}), 
    Line(points = {{-80, -60}, {80, -60}}), 
    Line(points = {{0, 100}, {0, 60}}), 
    Line(points = {{0, -60}, {0, -100}}), 
    Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {135, 135, 135}), 
    Rectangle(extent = {{-100, 25}, {100, -25}}, lineColor = {64, 64, 64})}), 
    Diagram(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Line(
    points = {{-50, -40}, {50, -40}}, 
    thickness = 0.5), 
    Line(
    points = {{-50, 40}, {50, 40}}, 
    thickness = 0.5), 
    Text(
    extent = {{-158, -66}, {158, -124}}, 
    textString = "%name"), 
    Rectangle(
    extent = {{-60, 60}, {60, -60}}, 
    lineColor = {255, 255, 255}, 
    lineThickness = 0.5, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), 
    Rectangle(
    extent = {{-60, 15}, {60, -15}}, 
    lineColor = {64, 64, 64}, 
    fillPattern = FillPattern.HorizontalCylinder, 
    fillColor = {192, 192, 192}), 
    Line(points = {{0, 60}, {0, 40}}), 
    Line(points = {{0, -40}, {0, -60}}), 
    Line(points = {{-50, 40}, {50, 40}}), 
    Line(points = {{-50, -40}, {50, -40}}), 
    Rectangle(extent = {{-60, 60}, {60, -60}}, lineColor = {135, 135, 135}), 
    Rectangle(extent = {{-60, 15}, {60, -15}}, lineColor = {64, 64, 64})}), 
    Documentation(info = "<html>
<p>
该分级连接器模拟了一个一维转动接口连接器和一个可选的由三维坐标系连接器定义的轴承。
如果需要将连接到子连接器的连接清晰可见，首先将一个
<a href=\"modelica://Modelica.Mechanics.MultiBody.Interfaces.FlangeWithBearingAdaptor\">FlangeWithBearingAdaptor</a>
的实例连接到FlangeWithBearing连接器。
</p>
</html>"));

end FlangeWithBearing;