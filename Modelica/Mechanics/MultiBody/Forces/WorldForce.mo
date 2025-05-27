within Modelica.Mechanics.MultiBody.Forces;
model WorldForce 
  "作用在frame_b上的外部力，由3个输入信号定义，并在world坐标系、frame_b或frame_resolve中解析"

  extends Interfaces.PartialOneFrame_b;
  Interfaces.Frame_resolve frame_resolve if 
    resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_resolve 
    "输入信号可选在此坐标系中解析" 
    annotation(Placement(transformation(
    origin = {0, -100}, 
    extent = {{-16, -16}, {16, 16}}, 
    rotation = 270)));
  Modelica.Blocks.Interfaces.RealInput force[3](each final quantity = "Force", each final unit = "N") 
    "在由resolveInFrame定义的坐标系中解析的力的x、y、z坐标" 
    annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
  parameter Boolean animation = true "= true，如果启用动画";
  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameB resolveInFrame = 
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.world 
    "输入力在其中解析的坐标系(1: world, 2: frame_b, 3: frame_resolve)";
  input Types.Color color = Modelica.Mechanics.MultiBody.Types.Defaults.ForceColor 
    "箭头的颜色" 
    annotation(Dialog(colorSelector = true, group = "如果animation = true", enable = animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射率(= 0: 光完全被吸收)" 
    annotation(Dialog(group = "如果animation = true", enable = animation));
protected
  Visualizers.Advanced.Arrow arrow(
    color = color, 
    specularCoefficient = specularCoefficient, 
    R = frame_b.R, 
    r = frame_b.r_0, 
    headAtOrigin = true, 
    quantity = Modelica.Mechanics.MultiBody.Types.VectorQuantity.Force, 
    r_head = -frame_b.f) if world.enableAnimation and animation;

public
  Internal.BasicWorldForce basicWorldForce(resolveInFrame = resolveInFrame) 
    annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}})));
protected
  Interfaces.ZeroPosition zeroPosition if 
    not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_resolve) 
    annotation(Placement(transformation(extent = {{20, -40}, {40, -20}})));
equation
  connect(basicWorldForce.frame_b, frame_b) annotation(Line(
    points = {{10, 0}, {100, 0}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(basicWorldForce.force, force) annotation(Line(
    points = {{-12, 0}, {-120, 0}}, color = {0, 0, 127}));
  connect(basicWorldForce.frame_resolve, frame_resolve) annotation(Line(
    points = {{0, -10}, {0, -100}}, 
    color = {95, 95, 95}, 
    pattern = LinePattern.Dot));
  connect(zeroPosition.frame_resolve, basicWorldForce.frame_resolve) 
    annotation(Line(
    points = {{20, -30}, {0, -30}, {0, -10}}, 
    color = {95, 95, 95}, 
    pattern = LinePattern.Dot));
  annotation(defaultComponentName = "force", 
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
    100}}), graphics = {
    Text(
    extent = {{-100, -40}, {100, -70}}, 
    textColor = {192, 192, 192}, 
    textString = "resolve"), 
    Polygon(
    points = {{-100, 10}, {50, 10}, {50, 31}, {94, 0}, {50, -31}, {50, -10}, {-100, -10}, 
    {-100, 10}}, 
    fillPattern = FillPattern.Solid), 
    Text(
    extent = {{-150, 80}, {150, 40}}, 
    textString = "%name", 
    textColor = {0, 0, 255}), 
    Line(
    points = {{0, -10}, {0, -95}}, 
    color = {95, 95, 95}, 
    pattern = LinePattern.Dot)}), 
    Documentation(info = "<html>
<p>
<strong>force</strong>连接器的<strong>3</strong>个信号被解析为作用在坐标系连接器上的<strong>力</strong>的x、y和z坐标，
该坐标系连接器与本组件的frame_b相连接。
通过参数<strong>resolveInFrame</strong>可以定义这些坐标值应在哪个坐标系中解析：
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th><strong>Types.ResolveInFrameB.</strong></th><th><strong>含义</strong></th></tr>
<tr><td>world</td>
    <td>在world坐标系中解析输入的力(默认设置)</td></tr>

<tr><td>frame_b</td>
    <td>在frame_b中解析输入力</td></tr>

<tr><td>frame_resolve</td>
    <td>在frame_resolve中解析输入力(frame_resolve必须已连接)</td></tr>
</table>

<p>
如果resolveInFrame = Types.ResolveInFrameB.frame_resolve，那么力的坐标将以连接到<strong>frame_resolve</strong>的坐标系为参考。
</p>

<p>
如果force={100,0,0}，且所有参数都使用默认设置，那就解释为，有一个100 N的力沿着frame_b的正x轴方向作用。
</p>

<p>
请注意，frame_b中的力矩(frame_b.t)始终设置为零。
从概念上讲，作用在世界坐标系上的力和力矩以这样一种方式平衡，即world.frame_b和frame_b之间的力和力矩达到平衡。
然而，出于效率考虑，这个反力矩实际上并不会被计算。
</p>

<p>
默认情况下，这个力组件会被可视化为一个箭头，作用在与之相连的连接器上
。箭头的颜色可以通过变量<strong>color</strong>来定义。箭头的指向由力信号定义的方向确定。
箭头的长度与力向量的长度成正比，具体比例取决于全局工具中相关的缩放因子。
</p>
<p>
关于如何使用这个模型的一个例子，请参见以下图示：
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/WorldForce1.png\">
</div>

<p>
结果为以下动画效果
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/WorldForce2.png\">
</div>
</html>"));
end WorldForce;