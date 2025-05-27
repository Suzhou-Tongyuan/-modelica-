within Modelica.Mechanics.MultiBody.Parts;
model RollingWheelSet 
  "由两个理想滚轮通过轴连接在一起的理想滚轮组模型"
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frameMiddle 
    "固定在连接两个滚轮的轴中间的坐标系(y轴：沿轮的轴，z轴：向上)" 
    annotation(Placement(transformation(extent = {{-16, 16}, {16, -16}}), 
    iconTransformation(extent = {{-16, -16}, {16, 16}}, 
    rotation = 90, 
    origin = {0, -20})));

  parameter Boolean animation = true 
    "=true，如果启用轮组动画";

  parameter SI.Radius R_wheel "一个滚轮的半径";
  parameter SI.Mass m_wheel "一个滚轮的质量";
  parameter SI.Inertia I_wheelAxis "沿一个滚轮轴的转动惯量";
  parameter SI.Inertia I_wheelLong "垂直于一个滚轮轴的转动惯量";
  parameter SI.Distance track "两个滚轮之间的距离(=轴距)";
  parameter StateSelect stateSelect = StateSelect.always 
    "优先使用广义坐标作为状态";

  SI.Position x(
    start = 0, 
    fixed = true, 
    stateSelect = stateSelect) "两个滚轮中间点的x坐标";
  SI.Position y(
    start = 0, 
    fixed = true, 
    stateSelect = stateSelect) "两个滚轮中间点的y坐标";
  SI.Angle phi(
    start = 0, 
    fixed = true, 
    stateSelect = stateSelect) "轮轴与z轴的方向角";
  SI.Angle theta1(
    start = 0, 
    fixed = true, 
    stateSelect = stateSelect) "滚轮1的角度";
  SI.Angle theta2(
    start = 0, 
    fixed = true, 
    stateSelect = stateSelect) "滚轮2的角度";
  SI.AngularVelocity der_theta1(
    start = 0, 
    fixed = true, 
    stateSelect = stateSelect) "theta1的导数";
  SI.AngularVelocity der_theta2(
    start = 0, 
    fixed = true, 
    stateSelect = stateSelect) "theta2的导数";

  parameter SI.Distance width_wheel = 0.01 "一个滚轮的宽度" 
    annotation(
    Dialog(
    tab = "动画", 
    group = "如果animation = true", 
    enable = animation));
  parameter Real hollowFraction = 0.8 
    "用于环状滚轮可视化：滚轮半径/内孔半径；即1.0：完全空心，0.0：完全实心" 
    annotation(Dialog(
    tab = "动画", 
    group = "如果animation = true", 
    enable = animation));
  parameter Types.Color color = {30, 30, 30} "滚轮的颜色" 
    annotation(Dialog(
    colorSelector = true, 
    tab = "动画", 
    group = "如果animation = true", 
    enable = animation));

  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame1 
    "固定在左轮中心点的坐标系(y轴：沿轮轴，z轴：向上)" 
    annotation(Placement(transformation(extent = {{-96, 16}, {-64, -16}}), 
    iconTransformation(extent = {{-96, 16}, {-64, -16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame2 
    "固定在右轮中心点的坐标系(y轴：沿轮轴，z轴：向上)" 
    annotation(Placement(transformation(extent = {{64, 16}, {96, -16}})));
  Modelica.Mechanics.MultiBody.Parts.Body body2(
    final r_CM = {0, 0, 0}, 
    final I_21 = 0, 
    final I_31 = 0, 
    final I_32 = 0, 
    animation = false, 
    final m = m_wheel, 
    final I_11 = I_wheelLong, 
    final I_22 = I_wheelAxis, 
    final I_33 = I_wheelLong) annotation(Placement(transformation(
    extent = {{10, -10}, {-10, 10}}, 
    rotation = -90, 
    origin = {60, 30})));

  Modelica.Mechanics.MultiBody.Visualizers.FixedShape shape2(
    final animation = animation, 
    final lengthDirection = {0, 1, 0}, 
    final widthDirection = {1, 0, 0}, 
    final color = color, 
    final extra = hollowFraction, 
    final shapeType = "pipe", 
    final r_shape = {0, -width_wheel, 0}, 
    final length = 2 * width_wheel, 
    final width = 2 * R_wheel, 
    final height = 2 * R_wheel) if animation annotation(Placement(transformation(
    extent = {{10, -10}, {-10, 10}}, 
    rotation = 90, 
    origin = {60, -38})));
  Modelica.Mechanics.MultiBody.Parts.Body body1(
    final r_CM = {0, 0, 0}, 
    final I_21 = 0, 
    final I_31 = 0, 
    final I_32 = 0, 
    animation = false, 
    final m = m_wheel, 
    final I_11 = I_wheelLong, 
    final I_22 = I_wheelAxis, 
    final I_33 = I_wheelLong) annotation(Placement(transformation(
    extent = {{-10, -10}, {10, 10}}, 
    rotation = 90, 
    origin = {-60, 30})));
  Modelica.Mechanics.MultiBody.Visualizers.FixedShape shape1(
    final animation = animation, 
    final lengthDirection = {0, 1, 0}, 
    final widthDirection = {1, 0, 0}, 
    final color = color, 
    final extra = hollowFraction, 
    final shapeType = "pipe", 
    final r_shape = {0, -width_wheel, 0}, 
    final length = 2 * width_wheel, 
    final width = 2 * R_wheel, 
    final height = 2 * R_wheel) if animation annotation(Placement(transformation(
    extent = {{-10, -10}, {10, 10}}, 
    rotation = -90, 
    origin = {-60, -40})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a axis1 
    "驱动左轮的一维旋转一维接口" 
    annotation(Placement(transformation(extent = {{-110, 90}, {-90, 110}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a axis2 
    "驱动右轮的一维旋转一维接口" 
    annotation(Placement(transformation(extent = {{90, 90}, {110, 110}})));
  Modelica.Mechanics.MultiBody.Joints.RollingWheelSet wheelSetJoint(
    animation = false, 
    radius = R_wheel, 
    track = track, 
    stateSelect = StateSelect.default, 
    x(fixed = false), 
    y(fixed = false), 
    phi(fixed = false), 
    theta1(fixed = false), 
    theta2(fixed = false), 
    der_theta1(fixed = false), 
    der_theta2(fixed = false)) 
    annotation(Placement(transformation(extent = {{-10, 40}, {10, 60}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b support 
    "1D轴的支撑" 
    annotation(Placement(transformation(extent = {{-10, 70}, {10, 90}}), iconTransformation(extent = {{-10, 70}, {10, 90}})));

equation
  wheelSetJoint.x = x;
  wheelSetJoint.y = y;
  wheelSetJoint.phi = phi;
  wheelSetJoint.theta1 = theta1;
  wheelSetJoint.theta2 = theta2;
  der_theta1 = der(theta1);
  der_theta2 = der(theta2);

  connect(body2.frame_a, frame2) annotation(Line(
    points = {{60, 20}, {60, 0}, {80, 0}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(body1.frame_a, frame1) annotation(Line(
    points = {{-60, 20}, {-60, 0}, {-80, 0}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(shape1.frame_a, frame1) annotation(Line(
    points = {{-60, -30}, {-60, 0}, {-80, 0}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(shape2.frame_a, frame2) annotation(Line(
    points = {{60, -28}, {60, 0}, {80, 0}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(wheelSetJoint.frame2, frame2) annotation(Line(
    points = {{8, 50}, {30, 50}, {30, 0}, {80, 0}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(wheelSetJoint.frame1, frame1) annotation(Line(
    points = {{-8, 50}, {-30, 50}, {-30, 0}, {-80, 0}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(wheelSetJoint.axis1, axis1) annotation(Line(
    points = {{-10, 60}, {-80, 60}, {-80, 100}, {-100, 100}}));
  connect(wheelSetJoint.axis2, axis2) annotation(Line(
    points = {{10, 60}, {80, 60}, {80, 100}, {100, 100}}));
  connect(wheelSetJoint.support, support) annotation(Line(
    points = {{0, 58}, {0, 80}}));
  connect(wheelSetJoint.frameMiddle, frameMiddle) annotation(Line(
    points = {{0, 48}, {0, 46}, {20, 46}, {20, 0}, {0, 0}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  annotation(
    defaultComponentName = "wheelSet", 
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
    100}}), graphics = {
    Line(
    points = {{0, 76}, {0, 4}}), 
    Ellipse(
    extent = {{42, 80}, {118, -80}}, 
    fillColor = {215, 215, 215}, 
    fillPattern = FillPattern.Sphere, 
    lineColor = {64, 64, 64}), 
    Ellipse(extent = {{42, 80}, {118, -80}}, lineColor = {64, 64, 64}), 
    Rectangle(
    extent = {{-100, -80}, {100, -100}}, 
    fillColor = {175, 175, 175}, 
    fillPattern = FillPattern.Solid, 
    pattern = LinePattern.None), 
    Text(
    extent = {{-150, -105}, {150, -145}}, 
    textString = "%name", 
    textColor = {0, 0, 255}), 
    Line(points = {{86, 24}, {64, 24}, {64, 12}, {56, 12}}), 
    Line(points = {{86, -24}, {64, -24}, {64, -12}, {56, -12}}), 
    Line(
    points = {{100, 100}, {80, 100}, {80, -2}}), 
    Polygon(
    points = {{-62, 6}, {64, 6}, {64, -6}, {6, -6}, {6, -20}, {-6, -20}, {-6, -6}, {-62, -6}, {-62, 6}}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{-118, 80}, {-42, -80}}, 
    fillColor = {215, 215, 215}, 
    fillPattern = FillPattern.Sphere, 
    lineColor = {64, 64, 64}), 
    Line(
    points = {{-96, 100}, {-80, 100}, {-80, 4}}), 
    Ellipse(extent = {{-118, 80}, {-42, -80}}, lineColor = {64, 64, 64}), 
    Line(
    points = {{-100, -80}, {100, -80}})}), 
    Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
    100, 100}}), graphics = {Line(
    points = {{0, -106}, {0, -78}}, 
    color = {0, 0, 255}), Polygon(
    points = {{0, -60}, {-6, -78}, {6, -78}, {0, -60}}, 
    lineColor = {0, 0, 255}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), Text(
    extent = {{12, -68}, {30, -80}}, 
    textColor = {0, 0, 255}, 
    textString = "x"), Line(
    points = {{6, -100}, {-26, -100}}, 
    color = {0, 0, 255}), Polygon(
    points = {{-22, -94}, {-22, -106}, {-40, -100}, {-22, -94}}, 
    lineColor = {0, 0, 255}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), Text(
    extent = {{-46, -80}, {-28, -92}}, 
    textColor = {0, 0, 255}, 
    textString = "y")}), 
    Documentation(info = "<html>
<p>
两个滚轮由一个轴连接，可以围绕这个轴旋转。
滚轮在全局坐标系的x-y平面上滚动。
连接到轮轴中心的坐标系(frameMiddle)受限制，始终平行于x-y平面。
如果所有广义坐标都为零，则frameMiddle平行于全局坐标系。
</p>

<h4>注意</h4>
<p>
为了正常工作，世界的重力加速度矢量g必须指向负z轴，即</p>
<blockquote><pre>
<span style=\"font-family:'Courier New',courier; color:#0000ff;\">inner</span><span style=\"font-family:'Courier New',courier; color:#ff0000;\">Modelica.Mechanics.MultiBody.World</span>world(n={0,0,-1});
</pre></blockquote>

</html>") );
end RollingWheelSet;