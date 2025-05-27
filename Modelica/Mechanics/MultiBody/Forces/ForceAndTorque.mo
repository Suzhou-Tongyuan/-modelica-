within Modelica.Mechanics.MultiBody.Forces;
model ForceAndTorque 
  "两个坐标系之间作用的力和力矩，由3+3个输入信号定义，并在world坐标系、frame_a、frame_b或frame_resolve中解析"

  import Modelica.Mechanics.MultiBody.Types;
  import Modelica.Units.Conversions.to_unit1;

  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;

  Blocks.Interfaces.RealInput force[3](each final quantity = "力", each final unit = "N") 
    "在由resolveInFrame定义的坐标系中解析的力的x、y、z坐标" 
    annotation(Placement(transformation(
    origin = {-80, 120}, 
    extent = {{-20, -20}, {20, 20}}, 
    rotation = 270)));
  Blocks.Interfaces.RealInput torque[3](each final quantity = "力矩", each final unit = "N.m") 
    "在由resolveInFrame定义的坐标系中解析的力矩的x、y、z坐标" 
    annotation(Placement(transformation(
    origin = {0, 120}, 
    extent = {{-20, -20}, {20, 20}}, 
    rotation = 270)));
  Interfaces.Frame_resolve frame_resolve if 
    resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve 
    "输入信号可选择在此坐标系中解析" 
    annotation(Placement(transformation(
    origin = {80, 100}, 
    extent = {{-16, -16}, {16, 16}}, 
    rotation = 90)));

  parameter Boolean animation = true "= true, 如果应启用动画效果";
  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB 
    resolveInFrame = 
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_b 
    "输入力和力矩在其中解析的坐标系(1: 全局坐标系, 2: frame_a, 3: frame_b, 4: frame_resolve)";
  input SI.Diameter connectionLineDiameter = world.defaultArrowDiameter 
    "连接frame_a和frame_b的线条直径" 
    annotation(Dialog(group = "如果 animation = true", enable = animation));
  input Types.Color forceColor = Modelica.Mechanics.MultiBody.Types.Defaults.ForceColor 
    "力的箭头颜色" annotation(Dialog(colorSelector = true, group = "如果 animation = true", enable = animation));
  input Types.Color torqueColor = Modelica.Mechanics.MultiBody.Types.Defaults.TorqueColor 
    "力矩的箭头颜色" annotation(Dialog(colorSelector = true, group = "如果 animation = true", enable = animation));
  input Types.Color connectionLineColor = Modelica.Mechanics.MultiBody.Types.Defaults.SensorColor 
    "连接frame_a和frame_b的线条颜色" 
    annotation(Dialog(colorSelector = true, group = "如果 animation = true", enable = animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射系数" 
    annotation(Dialog(group = "如果 animation = true", enable = animation));

protected
  Visualizers.Advanced.Arrow forceArrow(
    specularCoefficient = specularCoefficient, 
    quantity = Modelica.Mechanics.MultiBody.Types.VectorQuantity.Force, 
    R = frame_b.R, 
    r = frame_b.r_0, 
    headAtOrigin = true, 
    r_head = -frame_b.f) if world.enableAnimation and animation;
  Visualizers.Advanced.DoubleArrow torqueArrow(
    color = torqueColor, 
    specularCoefficient = specularCoefficient, 
    quantity = Modelica.Mechanics.MultiBody.Types.VectorQuantity.Torque, 
    R = frame_b.R, 
    r = frame_b.r_0, 
    headAtOrigin = true, 
    r_head = -frame_b.t) if world.enableAnimation and animation;
  Visualizers.Advanced.Shape connectionLine(
    shapeType = "cylinder", 
    lengthDirection = to_unit1(basicForce.r_0), 
    widthDirection = {0, 1, 0}, 
    length = Modelica.Math.Vectors.length(basicForce.r_0), 
    width = connectionLineDiameter, 
    height = connectionLineDiameter, 
    color = connectionLineColor, 
    specularCoefficient = specularCoefficient, 
    r = frame_a.r_0) if world.enableAnimation and animation;

public
  Internal.BasicForce basicForce(resolveInFrame = resolveInFrame) 
    annotation(Placement(transformation(extent = {{-84, -10}, {-64, 10}})));
  Internal.BasicTorque basicTorque(resolveInFrame = resolveInFrame) 
    annotation(Placement(transformation(extent = {{-4, 10}, {16, 30}})));
protected
  Interfaces.ZeroPosition zeroPosition if 
    not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve) 
    annotation(Placement(transformation(extent = {{20, 30}, {40, 50}})));
equation
  connect(basicForce.frame_a, frame_a) annotation(Line(
    points = {{-84, 0}, {-100, 0}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(basicForce.frame_b, frame_b) annotation(Line(
    points = {{-64, 0}, {100, 0}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(basicTorque.frame_b, frame_b) annotation(Line(
    points = {{16, 20}, {68, 20}, {68, 0}, {100, 0}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(basicTorque.frame_a, frame_a) annotation(Line(
    points = {{-4, 20}, {-90, 20}, {-90, 0}, {-100, 0}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(basicForce.force, force) annotation(Line(
    points = {{-80, 12}, {-80, 120}}, color = {0, 0, 127}));
  connect(basicTorque.torque, torque) annotation(Line(
    points = {{0, 32}, {0, 120}}, color = {0, 0, 127}));
  connect(basicTorque.frame_resolve, frame_resolve) annotation(Line(
    points = {{10, 30}, {10, 80}, {80, 80}, {80, 100}}, 
    color = {95, 95, 95}, 
    pattern = LinePattern.Dot));
  connect(basicForce.frame_resolve, frame_resolve) annotation(Line(
    points = {{-70, 10}, {-70, 80}, {80, 80}, {80, 100}}, 
    color = {95, 95, 95}, 
    pattern = LinePattern.Dot));
  connect(zeroPosition.frame_resolve, basicTorque.frame_resolve) annotation(
    Line(
    points = {{20, 40}, {10, 40}, {10, 30}}, 
    color = {95, 95, 95}, 
    pattern = LinePattern.Dot));
  connect(zeroPosition.frame_resolve, basicForce.frame_resolve) annotation(
    Line(
    points = {{20, 40}, {-70, 40}, {-70, 10}}, 
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
    extent = {{-150, -55}, {150, -95}}, 
    textString = "%name", 
    textColor = {0, 0, 255}), 
    Polygon(
    points = {{100, 21}, {84, 55}, {69, 39}, {100, 21}}, 
    fillPattern = FillPattern.Solid), 
    Line(
    points = {{80, 100}, {80, 0}}, 
    color = {95, 95, 95}, 
    pattern = LinePattern.Dot), 
    Polygon(
    points = {{-95, 1}, {-64, 11}, {-64, -10}, {-95, 1}}, 
    fillPattern = FillPattern.Solid), 
    Polygon(
    points = {{-100, 20}, {-86, 53}, {-70, 42}, {-100, 20}}, 
    fillPattern = FillPattern.Solid), 
    Line(
    points = {{-80, 100}, {80, 100}}, 
    color = {95, 95, 95}, 
    pattern = LinePattern.Dot), 
    Polygon(
    points = {{94, 0}, {65, 12}, {65, -11}, {94, 0}}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{-64, 0}, {-20, 0}}), 
    Line(points = {{20, 0}, {65, 0}}), 
    Line(points = {{-79, 47}, {-70, 61}, {-59, 72}, {-45, 81}, {-32, 84}, {-20, 85}}), 
    Line(points = {{76, 47}, {66, 60}, {55, 69}, {49, 74}, {41, 80}, {31, 84}, {20, 85}}), 
    Text(
    extent = {{-144, 124}, {-106, 102}}, 
    textString = "f"), 
    Text(
    extent = {{20, 124}, {58, 102}}, 
    textString = "t")}), 
    Documentation(info = "<html>
<p> <strong>force</strong>连接器上的<strong>3</strong>个信号
和<strong>torque</strong>连接器上的<strong>3</strong>个信号，
分别被解释为作用在坐标系连接器上(即该组件的frame_b所连接的坐标系)的<strong>力</strong>和<strong>力矩</strong>在x、y、z坐标轴上的分量。 
通过参数<strong>resolveInFrame</strong>可以定义这些坐标值应在哪个坐标系中解析： </p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th><strong>Types.ResolveInFrameAB.</strong></th><th><strong>含义</strong></th></tr>
<tr><td>world</td>
    <td>在world坐标系中解析输入力和力矩</td></tr>

<tr><td>frame_a</td>
    <td>在frame_a中解析输入力和力矩<</td></tr>

<tr><td>frame_b</td>
    <td>在frame_b中解析输入力和力矩(默认设置)</td></tr>

<tr><td>frame_resolve</td>
    <td>在frame_resolve中解析输入力和力矩(frame_resolve必须已连接)</td></tr>
</table>

<p>
如果resolveInFrame = ResolveInFrameAB.frame_resolve，那么力和力矩的坐标是相对于连接到<strong>frame_resolve</strong>的坐标系。
</p>

<p>
如果force={100,0,0}，并且所有参数都使用默认值，那么解释为沿着frame_b的正x轴方向作用了一个大小为100 N的力。 
</p>

<p>
 注意，力和力矩作用在frame_a上，使得frame_a和frame_b之间的力和力矩达到平衡。
</p>

<p>
一个如何使用这个模型的例子如下所示：
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/ForceAndTorque1.png\">
</div>

<p>
这将产生以下动画(黄色圆柱体表示ForceAndTorque组件的frame_a和frame_b之间的连线，
即力和力矩也应该在这个圆柱体的另一边以反方向表示，但为了清晰起见，动画中没有显示)：
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/ForceAndTorque2.png\">
</div>

</html>"));
end ForceAndTorque;