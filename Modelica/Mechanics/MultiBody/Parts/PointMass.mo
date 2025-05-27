within Modelica.Mechanics.MultiBody.Parts;
model PointMass 
  "忽略了刚体旋转和转动惯量张量的刚体(具有6个潜在状态变量)"

  import Modelica.Mechanics.MultiBody.Types;
  Interfaces.Frame_a frame_a 
    "固定在质心点的坐标系" annotation(Placement(
    transformation(extent = {{-16, -16}, {16, 16}})));
  parameter Boolean animation = true 
    "=true，如果要启用动画(显示球体)";
  parameter SI.Mass m(min = 0) "质点的质量";
  input SI.Diameter sphereDiameter = world.defaultBodyDiameter 
    "球体直径" annotation(Dialog(
    tab = "动画", 
    group = "如果animation=true", 
    enable = animation));
  input Types.Color sphereColor = Modelica.Mechanics.MultiBody.Types.Defaults.BodyColor 
    "球体颜色" annotation(Dialog(
    colorSelector = true, 
    tab = "动画", 
    group = "如果animation=true", 
    enable = animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射(=0：光线完全被吸收)" 
    annotation(Dialog(
    tab = "动画", 
    group = "如果animation=true", 
    enable = animation));
  parameter StateSelect stateSelect = StateSelect.avoid 
    "使用frame_a.r_0、v_0(=der(frame_a.r_0))作为状态的优先级" 
    annotation(Dialog(tab = "高级"));

  SI.Position r_0[3](start = {0, 0, 0}, each stateSelect = stateSelect) 
    "从全局坐标系原点到frame_a坐标系原点的位置矢量，以全局坐标系为基础解析" 
    annotation(Dialog(group = "初始值", showStartAttribute = true));
  SI.Velocity v_0[3](start = {0, 0, 0}, each stateSelect = stateSelect) 
    "frame_a的绝对速度，以全局坐标系为基础解析(=der(r_0))" 
    annotation(Dialog(group = "初始值", showStartAttribute = true));
  SI.Acceleration a_0[3](start = {0, 0, 0}) 
    "frame_a的绝对加速度，以全局坐标系为基础解析(=der(v_0))" 
    annotation(Dialog(group = "初始值", showStartAttribute = true));
protected
  outer Modelica.Mechanics.MultiBody.World world;

  // 动画声明
  Visualizers.Advanced.Shape sphere(
    shapeType = "sphere", 
    color = sphereColor, 
    specularCoefficient = specularCoefficient, 
    length = sphereDiameter, 
    width = sphereDiameter, 
    height = sphereDiameter, 
    lengthDirection = {1, 0, 0}, 
    widthDirection = {0, 1, 0}, 
    r_shape = -{1, 0, 0} * sphereDiameter / 2, 
    r = frame_a.r_0, 
    R = frame_a.R) if world.enableAnimation and animation;
equation
  // 如果可能的话，不要将连接器用作根
  Connections.potentialRoot(frame_a.R, 10000);

  if Connections.isRoot(frame_a.R) then
    assert(cardinality(frame_a) == 0, "
连接了一个Modelica.Mechanics.MultiBody.Parts.PointMass模型，但没有方程来计算frame_a.R
(连接器中的方向对象)。
在PointMass模型中将frame_a.R设置为任意值可能会导致整体模型错误，
这取决于PointMass模型的使用方式。
您可以通过提供计算方向对象的方程来避免此消息，
例如，使用Modelica.Mechanics.MultiBody.Joints.FreeMotion运动副。
如果一个PointMass模型根本没有连接，方向对象将被设置为单位旋转。
但这是唯一的情况。
");
    frame_a.R = Frames.nullRotation();
  else
    frame_a.t = zeros(3);
  end if;

  // 牛顿方程：f = m*(a-g)
  r_0 = frame_a.r_0;
  v_0 = der(r_0);
  a_0 = der(v_0);
  frame_a.f = m * Frames.resolve2(frame_a.R, a_0 - world.gravityAcceleration(
    r_0));
  annotation(Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Text(
    extent = {{150, -90}, {-150, -60}}, 
    textString = "m=%m"), 
    Text(
    extent = {{-150, 100}, {150, 60}}, 
    textString = "%name", 
    textColor = {0, 0, 255}), 
    Ellipse(
    extent = {{-50, 50}, {50, -50}}, 
    lineColor = {0, 24, 48}, 
    fillPattern = FillPattern.Sphere, 
    fillColor = {0, 127, 255})}), Documentation(info = "<html>
<p>
转动惯量张量被忽略的<strong>刚体</strong>。
这个刚体仅由其质量定义。
默认情况下，这个组件由一个<strong>球体</strong>表示，其中心位于frame_a处。
请注意，动画可以通过参数animation=<strong>false</strong>关闭。
</p>

<p>
每个PointMass都有潜在的状态变量。
如果可能的话，工具将选择运动副的状态而不是PointMass的状态，因为这是通常是最有效的选择。
在这种情况下，位置和frame_a的速度将由与frame_a连接的组件计算的刚体。
但是，如果PointMass在空间中自由移动，则必须使用PointMass的变量作为状态。
潜在状态变量有：从世界的原点开始的<strong>位置矢量</strong>frame_a.r_0到frame_a的刚体的原点，在解决全局坐标系中，以及<strong>绝对速度</strong>v_0的起源frame_a，在全局坐标系中解决(=der(frame_a.r_0))。
</p>

<p>
通常情况下，是否使用体的变量作为状态是Modelica翻译器自动选择的。
如果参数<strong>enforceStates</strong>在\"高级\"菜单中设置为<strong>true</strong>，那么PointMass变量frame_a.r_0和der(frame_a.r_0)被强制用作状态。
</p>
</html>"));
end PointMass;