within Modelica.Mechanics.MultiBody.Parts;
model BodyBox 
  "具有长方体形状的刚体，质量和动画属性由长方体数据和密度计算得出(12个潜在状态变量)"

  import Modelica.Mechanics.MultiBody.Types;
  import Modelica.Math.Vectors.normalizeWithAssert;
  import Modelica.Units.Conversions.to_unit1;

  Interfaces.Frame_a frame_a 
    "固定到组件的坐标系，带有一个局部力和局部扭矩" 
    annotation(Placement(transformation(extent = {{-116, -16}, {-84, 16}})));
  Interfaces.Frame_b frame_b 
    "固定到组件的坐标系，带有一个局部力和局部扭矩" 
    annotation(Placement(transformation(extent = {{84, -16}, {116, 16}})));
  parameter Boolean animation = true 
    "=true，如果要启用动画(在frame_a和frame_b之间显示长方体)";
  parameter SI.Position r[3](start = {0.1, 0, 0}) 
    "在frame_a中解析的从frame_a到frame_b的矢量";
  parameter SI.Position r_shape[3] = {0, 0, 0} 
    "在frame_a中解析的从frame_a到长方体原点的矢量";
  parameter Modelica.Mechanics.MultiBody.Types.Axis lengthDirection = 
    to_unit1(r - r_shape) 
    "在frame_a中解析的长方体长度方向的矢量" 
    annotation(Evaluate = true);
  parameter Modelica.Mechanics.MultiBody.Types.Axis widthDirection = {0, 1, 0} 
    "在frame_a中解析的长方体宽度方向的矢量" 
    annotation(Evaluate = true);
  parameter SI.Length length = Modelica.Math.Vectors.length(r - r_shape) 
    "长方体的长度";
  parameter SI.Distance width = length / world.defaultWidthFraction 
    "长方体的宽度";
  parameter SI.Distance height = width "长方体的高度";
  parameter SI.Distance innerWidth = 0 
    "内部长方体表面的宽度(0<=innerWidth<=width)";
  parameter SI.Distance innerHeight = innerWidth 
    "内部长方体表面的高度(0<=innerHeight<=height)";
  parameter SI.Density density = 7700 
    "密度(例如，钢：7700..7900，木材：400..800)";
  input Modelica.Mechanics.MultiBody.Types.Color color = Modelica.Mechanics.MultiBody.Types.Defaults.BodyColor 
    "长方体的颜色" 
    annotation(Dialog(colorSelector = true, enable = animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光反射(=0：完全吸收光)" 
    annotation(Dialog(enable = animation));

  SI.Position r_0[3](start = {0, 0, 0}, each stateSelect = if enforceStates then 
    StateSelect.always else StateSelect.avoid) 
    "从全局坐标系原点到frame_a坐标系原点的位置矢量" 
    annotation(Dialog(tab = "初始值", showStartAttribute = true));
  SI.Velocity v_0[3](start = {0, 0, 0}, each stateSelect = if enforceStates then 
    StateSelect.always else StateSelect.avoid) 
    "frame_a的绝对速度，在全局坐标系中表示(=der(r_0))" 
    annotation(Dialog(tab = "初始值", showStartAttribute = true));
  SI.Acceleration a_0[3](start = {0, 0, 0}) 
    "frame_a的绝对加速度，在全局坐标系中表示(=der(v_0))" 
    annotation(Dialog(tab = "初始值", showStartAttribute = true));

  parameter Boolean angles_fixed = false 
    "=true，如果angles_start用作初始值，则用作初始值，否则用作猜测值" 
    annotation(
    Evaluate = true, 
    choices(checkBox = true), 
    Dialog(tab = "初始值"));
  parameter SI.Angle angles_start[3] = {0, 0, 0} 
    "围绕'sequence_start'轴旋转全局坐标系到frame_a的初始角度值" 
    annotation(Dialog(tab = "初始值"));
  parameter Types.RotationSequence sequence_start = {1, 2, 3} 
    "将全局坐标系旋转到frame_a的旋转顺序" 
    annotation(Evaluate = true, Dialog(tab = "初始值"));

  parameter Boolean w_0_fixed = false 
    "=true，如果w_0_start用作初始值，则用作初始值，否则用作猜测值" 
    annotation(
    Evaluate = true, 
    choices(checkBox = true), 
    Dialog(tab = "初始值"));
  parameter SI.AngularVelocity w_0_start[3] = {0, 0, 0} 
    "frame_a在全局坐标系中的初始或猜测角速度值" 
    annotation(Dialog(tab = "初始值"));

  parameter Boolean z_0_fixed = false 
    "=true，如果z_0_start用作初始值，则用作初始值，否则用作猜测值" 
    annotation(
    Evaluate = true, 
    choices(checkBox = true), 
    Dialog(tab = "初始值"));
  parameter SI.AngularAcceleration z_0_start[3] = {0, 0, 0} 
    "角加速度z_0的初始值=der(w_0)" 
    annotation(Dialog(tab = "初始值"));

  parameter Boolean enforceStates = false 
    "=true，如果要使用body对象的绝对变量作为状态(StateSelect.always)" 
    annotation(Evaluate = true, Dialog(tab = "高级"));
  parameter Boolean useQuaternions = true 
    "=true，如果要使用四元数作为潜在状态变量，否则使用3个角度作为潜在状态变量" 
    annotation(Evaluate = true, Dialog(tab = "高级"));
  parameter Types.RotationSequence sequence_angleStates = {1, 2, 3} 
    "将全局坐标系旋转到frame_a的旋转顺序，围绕用作潜在状态变量的3个角度" 
    annotation(Evaluate = true, Dialog(tab = "高级", enable = not 
    useQuaternions));

  final parameter SI.Mass mo(min = 0) = density * length * width * height 
    "无孔长方体的质量";
  final parameter SI.Mass mi(min = 0) = density * length * innerWidth * innerHeight 
    "长方体孔的质量";
  final parameter SI.Mass m(min = 0) = mo - mi "长方体的质量";
  final parameter Frames.Orientation R = Frames.from_nxy(r, widthDirection) 
    "从frame_a到由r和widthDirection张成的坐标系的方向对象";
  final parameter SI.Position r_CM[3] = r_shape + 
    normalizeWithAssert(lengthDirection) * length / 2 
    "从frame_a原点到质心的位置矢量，解析为frame_a";
  final parameter SI.Inertia I[3,3] = Frames.resolveDyade1(R, diagonal({mo * (
    width * width + height * height) - mi * (innerWidth * innerWidth + innerHeight * 
    innerHeight), mo * (length * length + height * height) - mi * (length * length + 
    innerHeight * innerHeight), mo * (length * length + width * width) - mi * (length * 
    length + innerWidth * innerWidth)} / 12)) 
    "相对于质心的长方体的转动惯量张量，平行于frame_a";
  Body body(
    animation = false, 
    r_CM = r_CM, 
    m = m, 
    I_11 = I[1,1], 
    I_22 = I[2,2], 
    I_33 = I[3,3], 
    I_21 = I[2,1], 
    I_31 = I[3,1], 
    I_32 = I[3,2], 
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
    shapeType = "box", 
    r_shape = r_shape, 
    lengthDirection = lengthDirection, 
    widthDirection = widthDirection, 
    length = length, 
    width = width, 
    height = height, 
    color = color, 
    specularCoefficient = specularCoefficient) annotation(Placement(
    transformation(extent = {{-30, -20}, {10, 20}})));

protected
  outer Modelica.Mechanics.MultiBody.World world;
equation
  r_0 = frame_a.r_0;
  v_0 = der(r_0);
  a_0 = der(v_0);

  assert(innerWidth <= width, 
    "参数innerWidth大于参数width");
  assert(innerHeight <= height, 
    "参数innerHeight大于参数height");
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
此<strong>刚体</strong>具有<strong>长方体</strong>形状。
从长方体数据计算刚体的质量特性(质量、质心、转动惯量张量)。
作为可选项，长方体可以是空心的。(外部的)长方体形状被默认用于动画。动画中不显示空心部分。
两个连接器坐标系<strong>frame_a</strong>和<strong>frame_b</strong>始终平行。
组件动画示例(注意，可以通过参数animation=<strong>false</strong>关闭动画)：</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Parts/BodyBox.png\"alt=\"Parts.BodyBox\">
</div>

<p>
BodyBox组件具有潜在状态变量。
有关这些状态和“高级”菜单参数的详细信息，请参见模型<a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Body\">MultiBody.Parts.Body</a>。
</p>
</html>"), 
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Polygon(
    points = {{100, 40}, {100, -30}, {90, -40}, {90, 30}, {100, 40}}, 
    lineColor = {0, 95, 191}, 
    fillColor = {0, 95, 191}, 
    fillPattern = FillPattern.Solid), 
    Rectangle(
    extent = {{-100, 30}, {90, -40}}, 
    lineColor = {0, 127, 255}, 
    pattern = LinePattern.None, 
    fillColor = {0, 127, 255}, 
    fillPattern = FillPattern.Solid), 
    Polygon(
    points = {{-100, 30}, {-90, 40}, {100, 40}, {90, 30}, {-100, 30}}, 
    lineColor = {0, 95, 191}, 
    fillColor = {0, 95, 191}, 
    fillPattern = FillPattern.Solid), 
    Text(
    extent = {{-150, 90}, {150, 50}}, 
    textString = "%name", 
    textColor = {0, 0, 255}), 
    Text(
    extent = {{150, -80}, {-150, -50}}, 
    textString = "r=%r"), 
    Text(
    extent = {{52, 8}, {88, -17}}, 
    textString = "b"), 
    Text(
    extent = {{-87, 12}, {-51, -13}}, 
    textString = "a")}));
end BodyBox;