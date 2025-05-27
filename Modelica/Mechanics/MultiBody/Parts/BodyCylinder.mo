within Modelica.Mechanics.MultiBody.Parts;
model BodyCylinder 
  "圆柱形状的刚体，质量和动画属性根据圆柱数据和密度计算(12个潜在状态变量)"

  import Modelica.Units.NonSI;
  import Modelica.Mechanics.MultiBody.Types;
  import Modelica.Math.Vectors.normalizeWithAssert;
  import Modelica.Units.Conversions.to_unit1;
  import Modelica.Constants.pi;

  Interfaces.Frame_a frame_a 
    "固定在组件上的坐标系，带有一个局部力和局部力矩" 
    annotation(Placement(transformation(extent = {{-116, -16}, {-84, 16}})));
  Interfaces.Frame_b frame_b 
    "固定在组件上的坐标系，带有一个局部力和局部力矩" 
    annotation(Placement(transformation(extent = {{84, -16}, {116, 16}})));
  parameter Boolean animation = true 
    "=true，如果启用动画(在frame_a和frame_b之间显示圆柱)";
  parameter SI.Position r[3](start = {0.1, 0, 0}) 
    "从frame_a到frame_b的矢量，在frame_a中解析";
  parameter SI.Position r_shape[3] = {0, 0, 0} 
    "从frame_a到圆柱原点的矢量，在frame_a中解析";
  parameter Modelica.Mechanics.MultiBody.Types.Axis lengthDirection = 
    to_unit1(r - r_shape) 
    "圆柱长度方向的矢量，在frame_a中解析" 
    annotation(Evaluate = true);
  parameter SI.Length length = Modelica.Math.Vectors.length(r - r_shape) 
    "圆柱长度";
  parameter SI.Distance diameter = length / world.defaultWidthFraction 
    "圆柱直径";
  parameter SI.Distance innerDiameter = 0 
    "圆柱内直径(0<=innerDiameter<=Diameter)";
  parameter SI.Density density = 7700 
    "圆柱密度(例如，钢：7700..7900，木材：400..800)";
  input Modelica.Mechanics.MultiBody.Types.Color color = Modelica.Mechanics.MultiBody.Types.Defaults.BodyColor 
    "圆柱的颜色" 
    annotation(Dialog(colorSelector = true, enable = animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光反射(=0：光完全吸收)" 
    annotation(Dialog(enable = animation));

  SI.Position r_0[3](start = {0, 0, 0}, each stateSelect = if enforceStates then 
    StateSelect.always else StateSelect.avoid) 
    "从全局坐标系原点到frame_a原点的位置矢量" 
    annotation(Dialog(tab = "初始值", showStartAttribute = true));
  SI.Velocity v_0[3](start = {0, 0, 0}, each stateSelect = if enforceStates then 
    StateSelect.always else StateSelect.avoid) 
    "frame_a的绝对速度，解析在全局坐标系中(=der(r_0))" 
    annotation(Dialog(tab = "初始值", showStartAttribute = true));
  SI.Acceleration a_0[3](start = {0, 0, 0}) 
    "frame_a的绝对加速度，解析在全局坐标系中(=der(v_0))" 
    annotation(Dialog(tab = "初始值", showStartAttribute = true));

  parameter Boolean angles_fixed = false 
    "=true，如果angles_start被用作初始值，则作为初始值，否则作为猜测值" 
    annotation(
    Evaluate = true, 
    choices(checkBox = true), 
    Dialog(tab = "初始值"));
  parameter SI.Angle angles_start[3] = {0, 0, 0} 
    "围绕'sequence_start'轴将全局坐标系旋转到frame_a的初始角度值" 
    annotation(Dialog(tab = "初始值"));
  parameter Types.RotationSequence sequence_start = {1, 2, 3} 
    "在初始时间将全局坐标系旋转到frame_a的旋转序列" 
    annotation(Evaluate = true, Dialog(tab = "初始值"));

  parameter Boolean w_0_fixed = false 
    "=true，如果w_0_start被用作初始值，则作为初始值，否则作为猜测值" 
    annotation(
    Evaluate = true, 
    choices(checkBox = true), 
    Dialog(tab = "初始值"));
  parameter SI.AngularVelocity w_0_start[3] = {0, 0, 0} 
    "frame_a在全局坐标系中的角速度的初始或猜测值" 
    annotation(Dialog(tab = "初始值"));

  parameter Boolean z_0_fixed = false 
    "=true，如果z_0_start被用作初始值，则作为初始值，否则作为猜测值" 
    annotation(
    Evaluate = true, 
    choices(checkBox = true), 
    Dialog(tab = "初始值"));
  parameter SI.AngularAcceleration z_0_start[3] = {0, 0, 0} 
    "角加速度z_0=der(w_0)的初始值" 
    annotation(Dialog(tab = "初始值"));

  parameter Boolean enforceStates = false 
    "=true，如果应该使用刚体对象的绝对变量作为状态(StateSelect.always)" 
    annotation(Evaluate = true, Dialog(tab = "高级"));
  parameter Boolean useQuaternions = true 
    "=true，如果应该使用四元数作为潜在状态变量，否则使用3个角度作为潜在状态变量" 
    annotation(Evaluate = true, Dialog(tab = "高级"));
  parameter Types.RotationSequence sequence_angleStates = {1, 2, 3} 
    "将全局坐标系绕使用作为潜在状态变量的3个角度旋转到frame_a的旋转序列" 
    annotation(Evaluate = true, Dialog(tab = "高级", enable = not 
    useQuaternions));

  final parameter SI.Distance radius = diameter / 2 "圆柱的半径";
  final parameter SI.Distance innerRadius = innerDiameter / 2 
    "圆柱的内半径";
  final parameter SI.Mass mo(min = 0) = density * pi * length * radius * radius 
    "不带孔的圆柱的质量";
  final parameter SI.Mass mi(min = 0) = density * pi * length * innerRadius * 
    innerRadius "圆柱孔的质量";
  final parameter SI.Inertia I22 = (mo * (length * length + 3 * radius * radius) - mi * (
    length * length + 3 * innerRadius * innerRadius)) / 12 
    "相对于通过质心、垂直于圆柱轴的轴的转动惯量";
  final parameter SI.Mass m(min = 0) = mo - mi "圆柱的质量";
  final parameter Frames.Orientation R = Frames.from_nxy(r, {0, 1, 0}) 
    "从frame_a到由圆柱轴和垂直于圆柱轴的轴张成的坐标系的方向对象";
  final parameter SI.Position r_CM[3] = r_shape + 
    normalizeWithAssert(lengthDirection) * length / 2 
    "从frame_a到质心的位置矢量，在frame_a中解析";
  final parameter SI.Inertia I[3,3] = Frames.resolveDyade1(R, diagonal({(mo * 
    radius * radius - mi * innerRadius * innerRadius) / 2, I22, I22})) 
    "相对于质心的圆柱的转动惯量张量，在与frame_a平行的坐标系中解析";

  Body body(
    r_CM = r_CM, 
    m = m, 
    I_11 = I[1,1], 
    I_22 = I[2,2], 
    I_33 = I[3,3], 
    I_21 = I[2,1], 
    I_31 = I[3,1], 
    I_32 = I[3,2], 
    animation = false, 
    sequence_start = sequence_start, 
    angles_fixed = angles_fixed, 
    angles_start = angles_start, 
    w_0_fixed = w_0_fixed, 
    w_0_start = w_0_start, 
    z_0_fixed = z_0_fixed, 
    z_0_start = z_0_start, 
    useQuaternions = useQuaternions, 
    sequence_angleStates = sequence_angleStates, 
    enforceStates = false) annotation(Placement(transformation(extent = {{-30, -80}, 
    {10, -40}})));
  FixedTranslation frameTranslation(
    r = r, 
    animation = animation, 
    shapeType = "pipecylinder", 
    r_shape = r_shape, 
    lengthDirection = lengthDirection, 
    length = length, 
    width = diameter, 
    height = diameter, 
    extra = innerDiameter / diameter, 
    color = color, 
    specularCoefficient = specularCoefficient, 
    widthDirection = {0, 1, 0}) annotation(Placement(transformation(extent = {{-30, 
    -20}, {10, 20}})));

protected
  outer Modelica.Mechanics.MultiBody.World world;
equation
  r_0 = frame_a.r_0;
  v_0 = der(r_0);
  a_0 = der(v_0);

  assert(innerDiameter < diameter, 
    "参数innerDiameter大于参数diameter");
  connect(frameTranslation.frame_a, frame_a) annotation(Line(
    points = {{-30, 0}, {-100, 0}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(frameTranslation.frame_b, frame_b) annotation(Line(
    points = {{10, 0}, {100, 0}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(frame_a, body.frame_a) annotation(Line(
    points = {{-100, 0}, {-70, 0}, {-70, -60}, {-30, -60}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  annotation(Documentation(info = "<html>
<p>
此<strong>刚体</strong>具有<strong>圆柱体</strong>形状。
从圆柱体数据计算刚体的质量特性(质量、质心、转动惯量张量)。
作为可选项，圆柱体可以是空心的。默认情况下，圆柱形状在动画中使用。
两个连接器坐标系<strong>frame_a</strong>和<strong>frame_b</strong>始终平行。
组件动画示例(请注意，可以通过参数animation=<strong>false</strong>关闭动画)：</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Parts/BodyCylinder.png\"alt=\"Parts.BodyCylinder\">
</div>

<p>
BodyCylinder组件具有潜在状态变量。
有关这些状态的详细信息以及“高级”菜单参数，请参阅模型<a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Body\">MultiBody.Parts.Body</a>。
</p></html>"), 
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Text(
    extent = {{-150, 90}, {150, 50}}, 
    textString = "%name", 
    textColor = {0, 0, 255}), 
    Text(
    extent = {{150, -80}, {-150, -50}}, 
    textString = "r=%r"), 
    Rectangle(
    extent = {{-100, 40}, {100, -40}}, 
    lineColor = {0, 24, 48}, 
    fillPattern = FillPattern.HorizontalCylinder, 
    fillColor = {0, 127, 255}, 
    radius = 10), 
    Text(
    extent = {{-87, 13}, {-51, -12}}, 
    textString = "a"), 
    Text(
    extent = {{51, 12}, {87, -13}}, 
    textString = "b")}));
end BodyCylinder;