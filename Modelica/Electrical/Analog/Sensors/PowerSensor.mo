within Modelica.Electrical.Analog.Sensors;
model PowerSensor "功率传感器"
  extends Modelica.Icons.RoundSensor;
  Modelica.Electrical.Analog.Interfaces.PositivePin pc 
    "Positive pin, current path" 
    annotation(Placement(transformation(extent = {{-90, -10}, {-110, 10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin nc 
    "Negative pin, current path" 
    annotation(Placement(transformation(extent = {{110, -10}, {90, 10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pv 
    "Positive pin, voltage path" 
    annotation(Placement(transformation(extent = {{-10, 110}, {10, 90}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin nv 
    "Negative pin, voltage path" 
    annotation(Placement(transformation(extent = {{10, -110}, {-10, -90}})));
  Modelica.Blocks.Interfaces.RealOutput power(unit = "W") 
    "Instantaneous power as output signal" 
    annotation(Placement(transformation(
    origin = {-100, -110}, 
    extent = {{-10, 10}, {10, -10}}, 
    rotation = 270), iconTransformation(
    extent = {{-10, 10}, {10, -10}}, 
    rotation = 270, 
    origin = {-100, -110})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor 
    annotation(Placement(transformation(
    origin = {0, -30}, 
    extent = {{10, 10}, {-10, -10}}, 
    rotation = 90)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor 
    annotation(Placement(transformation(extent = {{-50, -10}, {-30, 10}})));
  Modelica.Blocks.Math.Product product 
    annotation(Placement(transformation(
    origin = {-30, -50}, 
    extent = {{-10, -10}, {10, 10}}, 
    rotation = 270)));

equation
  connect(pv, voltageSensor.p) annotation(Line(points = {{0, 100}, {0, -20}}, color = {0, 0, 255}));
  connect(voltageSensor.n, nv) annotation(Line(points = {{0, -40}, {0, -63}, {0, -100}}, color = {0, 0, 255}));
  connect(pc, currentSensor.p) 
    annotation(Line(points = {{-100, 0}, {-50, 0}}, color = {0, 0, 255}));
  connect(currentSensor.n, nc) 
    annotation(Line(points = {{-30, 0}, {100, 0}}, color = {0, 0, 255}));
  connect(currentSensor.i, product.u2) annotation(Line(points = {{-40, -11}, {-40, -30}, {-36, -30}, {-36, -38}}, color = {0, 0, 127}));
  connect(voltageSensor.v, product.u1) annotation(Line(points = {{-11, -30}, {-24, -30}, {-24, -38}}, color = {0, 0, 127}));
  connect(product.y, power) annotation(Line(points = {{-30, -61}, {-30, -80}, {-100, -80}, {-100, -110}}, color = {0, 0, 127}));
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {
    Line(points = {{0, 100}, {0, 70}}, color = {0, 0, 255}), 
    Line(points = {{0, -70}, {0, -100}}, color = {0, 0, 255}), 
    Line(points = {{-100, -100}, {-100, -80}, {-58, -38}}, color = {0, 0, 127}), 
    Line(points = {{-100, 0}, {100, 0}}, color = {0, 0, 255}), 
    Text(textColor = {0, 0, 255}, extent = {{-150, 110}, {150, 150}}, textString = "%name"), 
    Line(points = {{0, 70}, {0, 40}}), 
    Text(
    extent = {{-30, -10}, {30, -70}}, 
    textColor = {64, 64, 64}, 
    textString = "W")}), 
    Documentation(info = "<html>
<p>这种功率传感器用于测量单相系统的瞬时电功率，并且具有分离的电压和电流路径。电压路径的引脚标记为PV和NV，电流路径的引脚标记为PC和NC。电流路径的内部电阻为零，而电压路径的内部电阻为无穷大。</p>
</html>", revisions = "<html>
<ul>
<li><em>2006/1/12 </em>Anton Haumer</li>
</ul>
</html>"));
end PowerSensor;