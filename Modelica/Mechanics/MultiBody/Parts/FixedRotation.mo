within Modelica.Mechanics.MultiBody.Parts;
model FixedRotation 
  "frame_b相对于frame_a进行固定平动后的固定旋转"

  import Modelica.Mechanics.MultiBody.Frames;
  import Modelica.Units.Conversions.to_unit1;

  Interfaces.Frame_a frame_a 
    "与组件固定的坐标系，具有一个局部力和局部力矩" 
    annotation(Placement(transformation(extent = {{-116, -16}, {-84, 16}})));
  Interfaces.Frame_b frame_b 
    "与组件固定的坐标系，具有一个局部力和局部力矩" 
    annotation(Placement(transformation(extent = {{84, -16}, {116, 16}})));

  parameter Boolean animation = true "=true，如果启用动画";
  parameter SI.Position r[3] = {0, 0, 0} 
    "从frame_a到frame_b的矢量，在frame_a下解析";
  parameter Modelica.Mechanics.MultiBody.Types.RotationTypes rotationType = 
    Modelica.Mechanics.MultiBody.Types.RotationTypes.RotationAxis 
    "旋转描述的类型" annotation(Evaluate = true);
  parameter Modelica.Mechanics.MultiBody.Types.Axis n = {1, 0, 0} 
    "frame_a中的旋转轴(与frame_b相同)" annotation(
    Evaluate = true, Dialog(group = "如果rotationType = RotationAxis", enable = 
    rotationType == Modelica.Mechanics.MultiBody.Types.RotationTypes.RotationAxis));
  parameter Modelica.Units.NonSI.Angle_deg angle = 0 
    "将frame_a绕轴n旋转到frame_b的角度" annotation(Dialog(
    group = "如果rotationType = RotationAxis", enable = rotationType == 
    Modelica.Mechanics.MultiBody.Types.RotationTypes.RotationAxis));
  parameter Modelica.Mechanics.MultiBody.Types.Axis n_x = {1, 0, 0} 
    "frame_b沿着x轴的矢量在frame_a下解析" annotation(
    Evaluate = true, Dialog(group = "如果rotationType = TwoAxesVectors", enable = 
    rotationType == Modelica.Mechanics.MultiBody.Types.RotationTypes.TwoAxesVectors));
  parameter Modelica.Mechanics.MultiBody.Types.Axis n_y = {0, 1, 0} 
    "frame_b沿着x轴的矢量在frame_a下解析" annotation(
    Evaluate = true, Dialog(group = "如果rotationType = TwoAxesVectors", enable = 
    rotationType == Modelica.Mechanics.MultiBody.Types.RotationTypes.TwoAxesVectors));

  parameter Modelica.Mechanics.MultiBody.Types.RotationSequence sequence(
    min = {1, 1, 1}, 
    max = {3, 3, 3}) = {1, 2, 3} "旋转的顺序" annotation(Evaluate = true, 
    Dialog(group = "如果rotationType = PlanarRotationSequence", enable = 
    rotationType == Modelica.Mechanics.MultiBody.Types.RotationTypes.PlanarRotationSequence));
  parameter Modelica.Units.NonSI.Angle_deg angles[3] = {0, 0, 0} 
    "沿'sequence'定义的轴的旋转角度" annotation(
    Dialog(group = "如果rotationType = PlanarRotationSequence", enable = 
    rotationType == Modelica.Mechanics.MultiBody.Types.RotationTypes.PlanarRotationSequence));
  parameter Modelica.Mechanics.MultiBody.Types.ShapeType shapeType = "cylinder" 
    "形状类型" annotation(Dialog(
    tab = "动画", 
    group = "如果animation = true", 
    enable = animation));
  parameter SI.Position r_shape[3] = {0, 0, 0} 
    "从frame_a到形状原点的矢量，在frame_a中解析" annotation(
    Dialog(
    tab = "动画", 
    group = "如果animation = true", 
    enable = animation));
  parameter Modelica.Mechanics.MultiBody.Types.Axis lengthDirection = 
    to_unit1(r - r_shape) 
    "形状长度方向的矢量，在frame_a中解析" 
    annotation(Evaluate = true, Dialog(
    tab = "动画", 
    group = "如果animation = true", 
    enable = animation));
  parameter Modelica.Mechanics.MultiBody.Types.Axis widthDirection = {0, 1, 0} 
    "形状宽度方向的矢量，在frame_a中解析" annotation(
    Evaluate = true, Dialog(
    tab = "动画", 
    group = "如果animation = true", 
    enable = animation));
  parameter SI.Length length = Modelica.Math.Vectors.length(r - r_shape) 
    "形状的长度" annotation(Dialog(
    tab = "动画", 
    group = "如果animation = true", 
    enable = animation));
  parameter SI.Distance width = length / world.defaultWidthFraction 
    "形状的宽度" annotation(Dialog(
    tab = "动画", 
    group = "如果animation = true", 
    enable = animation));
  parameter SI.Distance height = width "形状的高度" annotation(Dialog(
    tab = "动画", 
    group = "如果animation = true", 
    enable = animation));
  parameter Modelica.Mechanics.MultiBody.Types.ShapeExtra extra = 0.0 
    "根据shapeType的附加参数(见Visualizers.Advanced.Shape文档)" 
    annotation(Dialog(
    tab = "动画", 
    group = "如果animation = true", 
    enable = animation));
  /*
  parameter Boolean checkTotalPower=false
  "=true，如果要确定流入此组件的总功率(必须为零)"
  annotation (Dialog(tab="高级"));
  */

  input Modelica.Mechanics.MultiBody.Types.Color color = Modelica.Mechanics.MultiBody.Types.Defaults.RodColor 
    "形状的颜色" 
    annotation(Dialog(
    colorSelector = true, 
    tab = "动画", 
    group = "如果animation = true", 
    enable = animation));
  input Modelica.Mechanics.MultiBody.Types.SpecularCoefficient 
    specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射(=0：光完全被吸收)" 
    annotation(Dialog(
    tab = "动画", 
    group = "如果animation = true", 
    enable = animation));
  final parameter Frames.Orientation R_rel = if rotationType == Types.RotationTypes.RotationAxis 
    then Frames.planarRotation(
    Modelica.Math.Vectors.normalizeWithAssert(n), 
    Cv.from_deg(angle), 
    0) else if rotationType == Types.RotationTypes.TwoAxesVectors then 
    Frames.from_nxy(n_x, n_y) else Frames.axesRotations(
    sequence, 
    Cv.from_deg(angles), 
    zeros(3)) "从frame_a到frame_b的固定旋转对象";
  /*
  SI.Power totalPower
  "如果checkTotalPower=true，则流入此元素的总功率(否则为虚拟)";
  */

protected
  outer Modelica.Mechanics.MultiBody.World world;

  /*
  parameter Frames.Orientation R_rel_inv=
  Frames.inverseRotation(R_rel)
  */
  parameter Frames.Orientation R_rel_inv = Frames.from_T(transpose(R_rel.T), 
    zeros(3)) "R_rel的逆(从frame_b到frame_a旋转)";
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape shape(
    shapeType = shapeType, 
    color = color, 
    specularCoefficient = specularCoefficient, 
    r_shape = r_shape, 
    lengthDirection = lengthDirection, 
    widthDirection = widthDirection, 
    length = length, 
    width = width, 
    height = height, 
    extra = extra, 
    r = frame_a.r_0, 
    R = frame_a.R) if world.enableAnimation and animation;

equation
  Connections.branch(frame_a.R, frame_b.R);
  assert(cardinality(frame_a) > 0 or cardinality(frame_b) > 0, 
    "FixedRotation对象的连接器frame_a或frame_b未连接");

  /* frame_a和frame_b的量之间的关系 */
  frame_b.r_0 = frame_a.r_0 + Frames.resolve1(frame_a.R, r);
  if Connections.rooted(frame_a.R) then
    frame_b.R = Frames.absoluteRotation(frame_a.R, R_rel);
    zeros(3) = frame_a.f + Frames.resolve1(R_rel, frame_b.f);
    zeros(3) = frame_a.t + Frames.resolve1(R_rel, frame_b.t) - cross(r, 
      frame_a.f);
  else
    frame_a.R = Frames.absoluteRotation(frame_b.R, R_rel_inv);
    zeros(3) = frame_b.f + Frames.resolve1(R_rel_inv, frame_a.f);
    zeros(3) = frame_b.t + Frames.resolve1(R_rel_inv, frame_a.t) + cross(
      Frames.resolve1(R_rel_inv, r), frame_b.f);
  end if;

  /*
  if checkTotalPower then
    totalPower = frame_a.f*Frames.resolve2(frame_a.R, der(frame_a.r_0)) +
                 frame_b.f*Frames.resolve2(frame_b.R, der(frame_b.r_0)) +
                 frame_a.t*Frames.angularVelocity2(frame_a.R) +
                 frame_b.t*Frames.angularVelocity2(frame_b.R);
  else
    totalPower = 0;
  end if;
*/

  annotation(
    Documentation(info = "<html>
<p>
此组件用于frame_b相对于frame_a的<strong>固定平动</strong>和<strong>固定旋转</strong>，即frame_a和frame_b之间的连接关系保持不变。
有几种定义frame_b相对于frame_a方向的可能性：</p>
<ul>
<li>沿着轴'n'(在frame_a中固定并解析)进行<strong>平面旋转</strong>，角度'angle'固定。
</li>
<li>指向frame_b相应轴方向的<strong>矢量n_x</strong>和<strong>n_y</strong>，在frame_a中解析(如果n_y不与n_x正交，则选择frame_b的y轴，使其与n_x正交并位于n_x和n_y的平面内)。
</li>
<li><strong>三个平面轴旋转</strong>的<strong>序列</strong>。
例如，\"sequence={1,2,3}\"和\"angles={90,45,-90}\"表示frame_a绕x轴旋转90度，绕新的y轴旋转45度，绕新的z轴旋转-90度到达frame_b。
注意，sequence={1,2,3}是卡尔丹角序列，sequence={3,1,3}是欧拉角序列。
</li>
</ul>
<p>
默认情况下，此组件由一个连接frame_a和frame_b的圆柱体可视化，如下图所示。
在此图中，frame_b沿着frame_a的z轴旋转60度。
请注意，两个可视化的坐标系不是组件动画的一部分，可以通过参数animation = <strong>false</strong>关闭动画。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Parts/FixedRotation.png\"alt=\"Parts.FixedRotation\">
</div>
</html>", 
    revisions = "<html><p>
<strong>发布说明：</strong></p>
<ul>
<li><em>2003年7月28日</em><br>
修复了一个错误：如果rotationType = PlanarRotationSequence，则'angles'的单位将使用弧度[rad]而不是角度[deg]。
</li>
</ul>
</html>"), 
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Text(
    extent = {{-150, 80}, {150, 120}}, 
    textString = "%name", 
    textColor = {0, 0, 255}), 
    Rectangle(
    extent = {{-100, 5}, {100, -4}}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{80, 20}, {129, 50}}), 
    Line(points = {{80, 20}, {57, 59}}), 
    Polygon(
    points = {{144, 60}, {117, 59}, {132, 37}, {144, 60}}, 
    fillPattern = FillPattern.Solid), 
    Polygon(
    points = {{43, 80}, {46, 50}, {68, 65}, {43, 80}}, 
    fillPattern = FillPattern.Solid), 
    Text(
    extent = {{-150, -50}, {150, -80}}, 
    textString = "r=%r"), 
    Text(
    extent = {{-117, 51}, {-81, 26}}, 
    textColor = {128, 128, 128}, 
    textString = "a"), 
    Text(
    extent = {{84, -24}, {120, -49}}, 
    textColor = {128, 128, 128}, 
    textString = "b")}) );
end FixedRotation;