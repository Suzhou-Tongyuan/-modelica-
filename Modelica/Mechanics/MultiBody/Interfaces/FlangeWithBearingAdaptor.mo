within Modelica.Mechanics.MultiBody.Interfaces;
model FlangeWithBearingAdaptor 
  "允许直接连接到FlangeWithBearing子连接器的适配器"
  parameter Boolean includeBearingConnector = false 
    "= true, 表示存在轴承坐标系连接器，否则表示不存在";

  Modelica.Mechanics.MultiBody.Interfaces.FlangeWithBearing flangeAndFrame(includeBearingConnector = includeBearingConnector) 
    "由一维转动接口和三维坐标系安装组成的复合连接器" 
    annotation(Placement(transformation(extent = {{-130, -30}, {-70, 30}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange 
    "一维转动接口" 
    annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  Frame_a frame if includeBearingConnector 
    "三维坐标系，其中已安装一维轴" annotation(Placement(
    transformation(
    origin = {0, -100}, 
    extent = {{-16, -16}, {16, 16}}, 
    rotation = 90)));

equation
  connect(flange, flangeAndFrame.flange) annotation(Line(
    points = {{0, 0}, {-100, 0}}));
  connect(frame, flangeAndFrame.bearingFrame) annotation(Line(
    points = {{0, -100}, {0, -40}, {-100, -40}, {-100, 0}}, 
    thickness = 0.5));
  annotation(
    defaultComponentName = "adaptor", 
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Rectangle(
    extent = {{-100, 30}, {20, -100}}, 
    lineColor = {255, 255, 255}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), 
    Line(
    points = {{-100, -10}, {-100, -40}, {0, -40}, {0, -100}}, 
    thickness = 0.5), 
    Line(points = {{-90, 0}, {0, 0}}), 
    Text(
    extent = {{-216, 88}, {86, 36}}, 
    textColor = {0, 0, 255}, 
    textString = "%name")}), 
    Documentation(info = "<html>
<p>
适配器对象，用于更直观地连接到
<a href=\"modelica://Modelica.Mechanics.MultiBody.Interfaces.FlangeWithBearing\">FlangeWithBearing</a>
连接器的接口和坐标系子连接器。
</p>
</html>"));
end FlangeWithBearingAdaptor;