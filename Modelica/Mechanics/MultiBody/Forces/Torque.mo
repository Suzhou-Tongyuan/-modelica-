within Modelica.Mechanics.MultiBody.Forces;
model Torque 
  "两个坐标系之间作用的力矩，由3个输入信号定义，并在world坐标系、frame_a、frame_b或frame_resolve中解析"
  import Modelica.Units.Conversions.to_unit1;
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
  Interfaces.Frame_resolve frame_resolve if 
    resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve 
    "输入信号可选择在此坐标系中解析" 
    annotation(Placement(transformation(
    origin = {40, 100}, 
    extent = {{-16, -16}, {16, 16}}, 
    rotation = 90)));

  Modelica.Blocks.Interfaces.RealInput torque[3](each final quantity = "Torque", each final unit = "N.m") 
    "在由resolveInFrame定义的坐标系中解析的力矩的x、y、z坐标" 
    annotation(Placement(transformation(
    origin = {-60, 120}, 
    extent = {{-20, -20}, {20, 20}}, 
    rotation = 270)));
  parameter Boolean animation = true "= true, 如果应启用动画";
  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB 
    resolveInFrame = 
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_b 
    "解析输入力的坐标系(1: 全局坐标系，2: frame_a，3: frame_b，4: frame_resolve)";
  input SI.Diameter connectionLineDiameter = world.defaultArrowDiameter 
    "连接frame_a和frame_b的线的直径" 
    annotation(Dialog(group = "如果 animation = true", enable = animation));

  input Types.Color torqueColor = Modelica.Mechanics.MultiBody.Types.Defaults.TorqueColor 
    "力矩箭头的颜色" 
    annotation(Dialog(colorSelector = true, group = "如果 animation = true", enable = animation));

  input Types.Color connectionLineColor = Modelica.Mechanics.MultiBody.Types.Defaults.SensorColor 
    "连接frame_a和frame_b的线的颜色" 
    annotation(Dialog(colorSelector = true, group = "如果 animation = true", enable = animation));

  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射系数(= 0: 光完全被吸收)" 
    annotation(Dialog(group = "如果 animation = true", enable = animation));
protected
  Visualizers.Advanced.DoubleArrow torqueArrow(
    color = torqueColor, 
    specularCoefficient = specularCoefficient, 
    R = frame_b.R, 
    r = frame_b.r_0, 
    quantity = Modelica.Mechanics.MultiBody.Types.VectorQuantity.Torque, 
    headAtOrigin = true, 
    r_head = -frame_b.t) if world.enableAnimation and animation;
  Visualizers.Advanced.Shape connectionLine(
    shapeType = "cylinder", 
    lengthDirection = to_unit1(basicTorque.r_0), 
    widthDirection = {0, 1, 0}, 
    length = Modelica.Math.Vectors.length(basicTorque.r_0), 
    width = connectionLineDiameter, 
    height = connectionLineDiameter, 
    color = connectionLineColor, 
    specularCoefficient = specularCoefficient, 
    r = frame_a.r_0) if world.enableAnimation and animation;

public
  Internal.BasicTorque basicTorque(resolveInFrame = resolveInFrame) 
    annotation(Placement(transformation(extent = {{-8, -10}, {12, 10}})));
protected
  Interfaces.ZeroPosition zeroPosition if 
    not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve) 
    annotation(Placement(transformation(extent = {{34, 10}, {54, 30}})));
equation
  connect(basicTorque.frame_a, frame_a) annotation(Line(
    points = {{-8, 0}, {-100, 0}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(basicTorque.frame_b, frame_b) annotation(Line(
    points = {{12, 0}, {100, 0}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(basicTorque.torque, torque) annotation(Line(
    points = {{-4, 12}, {-4, 60}, {-60, 60}, {-60, 120}}, color = {0, 0, 127}));
  connect(basicTorque.frame_resolve, frame_resolve) annotation(Line(
    points = {{6, 10}, {6, 60}, {40, 60}, {40, 100}}, 
    color = {95, 95, 95}, 
    pattern = LinePattern.Dot));
  connect(zeroPosition.frame_resolve, basicTorque.frame_resolve) annotation(
    Line(
    points = {{34, 20}, {20, 20}, {20, 10}, {6, 10}}, 
    color = {95, 95, 95}, 
    pattern = LinePattern.Dot));
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
    100}}), graphics = {
    Rectangle(
    extent = {{-98, 99}, {99, -98}}, 
    lineColor = {255, 255, 255}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), 
    Text(
    extent = {{-59, 55}, {72, 30}}, 
    textColor = {192, 192, 192}, 
    textString = "resolve"), 
    Text(
    extent = {{-150, -30}, {150, -70}}, 
    textString = "%name", 
    textColor = {0, 0, 255}), 
    Polygon(
    points = {{100, 20}, {84, 52}, {69, 39}, {100, 20}}, 
    fillPattern = FillPattern.Solid), 
    Line(
    points = {{40, 100}, {76, 46}}, 
    color = {95, 95, 95}, 
    pattern = LinePattern.Dot), 
    Polygon(
    points = {{-99, 20}, {-86, 53}, {-70, 42}, {-99, 20}}, 
    fillPattern = FillPattern.Solid), 
    Line(
    points = {{-60, 100}, {40, 100}}, 
    color = {95, 95, 95}, 
    pattern = LinePattern.Dot), 
    Line(points = {{-79, 47}, {-70, 61}, {-59, 72}, {-45, 81}, {-32, 84}, {-20, 85}}), 
    Line(points = {{77, 45}, {66, 60}, {55, 69}, {49, 74}, {41, 80}, {31, 84}, {20, 85}})}), 
    Documentation(info = "<html>
<p>
<strong>torque</strong>连接器的<strong>3</strong>个信号被解释为作用在与此组件的frame_b连接的坐标系连接器上的<strong>力矩</strong>的x、y和z坐标。
通过参数<strong>resolveInFrame</strong>，可以定义这些坐标应在哪个坐标系中解析：

</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th><strong>Types.ResolveInFrameAB.</strong></th><th><strong>含义</strong></th></tr>
<tr><td>world</td>
    <td>在world坐标系中解析输入力矩</td></tr>

<tr><td>frame_a</td>
    <td>在frame_a中解析输入力矩</td></tr>

<tr><td>frame_b</td>
    <td>在frame_b中解析输入力矩(默认设置)</td></tr>

<tr><td>frame_resolve</td>
    <td>在frame_resolve中解析输入力矩(frame_resolve必须已连接)</td></tr>
</table>

<p>
如果resolveInFrame = ResolveInFrameAB.frame_resolve，那么力矩坐标将相对于连接到<strong>frame_resolve</strong>的坐标系。
</p>

<p>
如果torque = {100,0,0}，且所有参数均使用默认设置，那么其解释就是在frame_b的正x轴上作用一个100 N.m的力矩。
</p>

<p>
注意，frame_a和frame_b上的局部力(frame_a.f, frame_b.f)始终设置为零，而frame_a上的局部力矩(frame_a.t)与frame_b上的局部力矩(frame_b.t)大小相等但符号相反。
</p>

<p>
如何使用此模型的示例见下图：</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/Torque1.png\">
</div>

<p>
其结果为以下动画(黄色圆柱体表示Torque组件的frame_a和frame_b之间的连线，
即力矩也在此圆柱的另一侧以反方向作用，但为了清晰起见，在动画中并未显示)：

</p> 

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/Torque2.png\">
</div>

</html>"));
end Torque;