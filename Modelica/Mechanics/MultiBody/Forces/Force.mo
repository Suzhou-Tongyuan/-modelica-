within Modelica.Mechanics.MultiBody.Forces;
model Force 
  "两个坐标系之间作用的力，由3个输入信号定义，并在world坐标系、frame_a、frame_b或frame_resolve中解析"
  import Modelica.Units.Conversions.to_unit1;
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
  Interfaces.Frame_resolve frame_resolve if 
    resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve 
    "输入信号可在此坐标系中解析" 
    annotation(Placement(transformation(
    origin = {40, 100}, 
    extent = {{-16, -16}, {16, 16}}, 
    rotation = 90)));
  Modelica.Blocks.Interfaces.RealInput force[3](each final quantity = "Force", each final unit = "N") 
    "在由resolveInFrame定义的坐标系中解析的力的x、y、z坐标" 
    annotation(Placement(transformation(
    origin = {-60, 120}, 
    extent = {{-20, -20}, {20, 20}}, 
    rotation = 270)));
  parameter Boolean animation = true "= true, 如果启用动画";
  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB 
    resolveInFrame = 
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_b 
    "解析输入力的坐标系(1: 全局坐标系，2: frame_a，3: frame_b，4: frame_resolve)";
  input SI.Diameter connectionLineDiameter = world.defaultArrowDiameter 
    "连接frame_a和frame_b的线的直径" 
    annotation(Dialog(group = "如果 animation = true", enable = animation));
  input Types.Color forceColor = Modelica.Mechanics.MultiBody.Types.Defaults.ForceColor 
    "力箭头的颜色" annotation(Dialog(colorSelector = true, group = "如果 animation = true", enable = animation));
  input Types.Color connectionLineColor = Modelica.Mechanics.MultiBody.Types.Defaults.SensorColor 
    "连接frame_a和frame_b的线的颜色" 
    annotation(Dialog(colorSelector = true, group = "如果 animation = true", enable = animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射(= 0: 光完全被吸收)" 
    annotation(Dialog(group = "如果 animation = true", enable = animation));

protected
  Visualizers.Advanced.Arrow forceArrow(
    color = forceColor, 
    specularCoefficient = specularCoefficient, 
    quantity = Modelica.Mechanics.MultiBody.Types.VectorQuantity.Force, 
    R = frame_b.R, 
    r = frame_b.r_0, 
    r_head = -frame_b.f, 
    headAtOrigin = true) if world.enableAnimation and animation;
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
  Internal.BasicForce basicForce(resolveInFrame = resolveInFrame) annotation(Placement(transformation(extent = {{0, -10}, {20, 10}})));
protected
  MultiBody.Interfaces.ZeroPosition zeroPosition if 
    not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve) 
    annotation(Placement(transformation(extent = {{40, 10}, {60, 30}})));
equation
  connect(basicForce.frame_a, frame_a) annotation(Line(
    points = {{0, 0}, {-100, 0}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(basicForce.frame_b, frame_b) annotation(Line(
    points = {{20, 0}, {100, 0}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(force, basicForce.force) annotation(Line(
    points = {{-60, 120}, {-60, 40}, {4, 40}, {4, 12}}, color = {0, 0, 127}));
  connect(basicForce.frame_resolve, frame_resolve) annotation(Line(
    points = {{14, 10}, {14, 40}, {40, 40}, {40, 100}}, 
    color = {95, 95, 95}, 
    pattern = LinePattern.Dot));
  connect(zeroPosition.frame_resolve, basicForce.frame_resolve) annotation(
    Line(
    points = {{40, 20}, {27, 20}, {27, 10}, {14, 10}}, 
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
    extent = {{-92, 61}, {87, 35}}, 
    textColor = {192, 192, 192}, 
    textString = "resolve"), 
    Text(
    extent = {{-150, -55}, {150, -95}}, 
    textString = "%name", 
    textColor = {0, 0, 255}), 
    Line(
    points = {{40, 100}, {40, 0}}, 
    color = {95, 95, 95}, 
    pattern = LinePattern.Dot), 
    Polygon(
    points = {{-94, 0}, {-64, 11}, {-64, -10}, {-94, 0}}, 
    fillPattern = FillPattern.Solid), 
    Line(
    points = {{-60, 100}, {40, 100}}, 
    color = {95, 95, 95}, 
    pattern = LinePattern.Dot), 
    Polygon(
    points = {{94, 0}, {65, 12}, {65, -11}, {94, 0}}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{-64, 0}, {-20, 0}}), 
    Line(points = {{20, 0}, {65, 0}})}), 
    Documentation(info = "<html>
<p>
<strong>force</strong>连接器上的<strong>3</strong>个信号被解释为作用在坐标系连接器上的<strong>力</strong>的x、y和z坐标，而这个坐标系连接器与这个组件的frame_b相连。
通过参数<strong>resolveInFrame</strong>可以定义这些坐标值应在哪个坐标系中解析：
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th><strong>Types.ResolveInFrameAB.</strong></th><th><strong>含义</strong></th></tr>
<tr><td>world</td>
    <td>输入力在world坐标系中解析</td></tr>

<tr><td>frame_a</td>
    <td>输入力在frame_a中解析</td></tr>

<tr><td>frame_b</td>
    <td>输入力在frame_b中解析(默认设置)</td></tr>

<tr><td>frame_resolve</td>
    <td>输入力在frame_resolve中解析(frame_resolve必须已连接)</td></tr>
</table>

<p>
如果resolveInFrame = ResolveInFrameAB.frame_resolve，那么力的坐标将相对于连接到<strong>frame_resolve</strong>的坐标系。

</p>

<p> 如果force = {100,0,0}，并且对所有参数都使用默认设置，那么解释为沿着frame_b的正x轴方向作用了一个100牛顿的力。 
</p>

<p> 请注意，frame_b中的局部力矩(frame_b.t)始终设置为零。
此外，frame_a上的力和力矩以使得frame_a和frame_b之间的力和力矩达到平衡的方式作用。 
</p>

<p> 以下图例给出了如何使用此模型的一个示例： </p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/Force1.png\">
</div>

<p>
其结果为以下动画(黄色圆柱表示Force组件的frame_a和frame_b之间的连线，
即力也在此圆柱的另一侧以反方向作用，但为了清晰起见，在动画中并未显示)：

</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/Force2.png\">
</div>

</html>"));
end Force;