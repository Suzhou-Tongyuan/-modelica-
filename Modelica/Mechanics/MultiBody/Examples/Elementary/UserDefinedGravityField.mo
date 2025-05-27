within Modelica.Mechanics.MultiBody.Examples.Elementary;
model UserDefinedGravityField 
  "演示建立用户自定义重力场的模型"
  extends Modelica.Icons.Example;
  parameter Modelica.Units.NonSI.Angle_deg geodeticLatitude = 0 
    "地面纬度";
  parameter SI.Position height = 20 
    "WGS84地球椭球面上点的高度";
  SI.Acceleration gravity[3] = body.g_0 
    "Gravity acceleration at center of mass of body";
  inner Modelica.Mechanics.MultiBody.World world(
    gravityType = Modelica.Mechanics.MultiBody.Types.GravityTypes.NoGravity, 
  redeclare function gravityAcceleration = 
    Modelica.Mechanics.MultiBody.Examples.Elementary.Utilities.theoreticalNormalGravityWGS84(
    phi = geodeticLatitude), 
    axisLength = 10, 
    nominalLength = 10) annotation(Placement(transformation(extent = {{-80, -50}, {-60, -30}})));
  Joints.Revolute rev(n = {0, 0, 1}, useAxisFlange = true, 
    phi(fixed = true), 
    w(fixed = true)) annotation(Placement(transformation(extent = {{-20, -10}, {0, 10}})));
  Rotational.Components.Damper damper(d = 0.1) 
    annotation(Placement(transformation(extent = {{-20, 30}, {0, 50}})));
  Parts.Body body(r_CM = {10, 0, 0}, 
    m = 1000.0, 
    sphereDiameter = 1) 
    annotation(Placement(transformation(extent = {{20, -10}, {40, 10}})));
  Parts.FixedTranslation fixedTranslation(r = {0, height, 0}, width = 0.3) 
    annotation(Placement(
    transformation(
    extent = {{-10, -10}, {10, 10}}, 
    rotation = 90, 
    origin = {-40, -20})));
equation
  connect(damper.flange_b, rev.axis) annotation(Line(points = {{0, 40}, {0, 20}, {-10, 20}, {-10, 10}}));
  connect(rev.support, damper.flange_a) annotation(Line(points = {{-16, 10}, {-16, 20}, {-20, 20}, {-20, 40}}));
  connect(body.frame_a, rev.frame_b) annotation(Line(
    points = {{20, 0}, {0, 0}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(world.frame_b, fixedTranslation.frame_a) annotation(Line(
    points = {{-60, -40}, {-40, -40}, {-40, -30}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(fixedTranslation.frame_b, rev.frame_a) annotation(Line(
    points = {{-40, -10}, {-40, 0}, {-20, 0}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  annotation(experiment(StopTime = 10, Tolerance = 1e-008), 
    Documentation(info = "<html><p>
这个例子演示了一个用户自定义的重力场。函数\"world.gravityAcceleration\"被重新声明为函数 <a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.Utilities.theoreticalNormalGravityWGS84\" target=\"\">theoreticalNormalGravityWGS84</a>，
它计算了<a href=\"https://earth-info.nga.mil/GandG/publications/tr8350.2/wgs84fin.pdf\" target=\"\">WGS84 ellipsoid earth model</a>在地球椭球面上及其附近的理论重力。
在重力场中, 存在一个大的单摆。通过参数\"geodeticLatitude\"，可以定义地球上摆的存在位置的大地纬度。世界坐标系位于WGS84地球椭球体上的这个纬度处。结果变量\"gravity\"是摆质量的质心处的重力矢量。
由于该质量的高度在变化，重力值也在变化(差异在0.00001的量级上)。
</p>
<p>
在赤道(geodeticLatitude = 0)和极点(geodeticLatitude = 90)处，模拟的结果略有不同。
例如，在模拟时间为10秒后，摆的旋转角度rev.phi有以下值的变换：
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong><em>latitude [deg]</em></strong></td>
    <td><strong><em>rev.phi [rad]</em></strong></td></tr>
<tr><td> = 0</td>
    <td>= -2.39 rad</td></tr>

<tr><td>= 90</td>
    <td>= -2.42 rad</td></tr>
</table>
</html>"));
end UserDefinedGravityField;