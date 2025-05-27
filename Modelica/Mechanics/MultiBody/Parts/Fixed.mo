within Modelica.Mechanics.MultiBody.Parts;
model Fixed "在给定位置固定在全局坐标系中的坐标系"
  import Modelica.Mechanics.MultiBody.Types;
  import Modelica.Units.Conversions.to_unit1;

  Interfaces.Frame_b frame_b "在全局坐标系中固定的坐标系" 
    annotation(Placement(transformation(extent = {{84, -16}, {116, 16}})));

  parameter Boolean animation = true "= true，如果要启用动画";
  parameter SI.Position r[3] = {0, 0, 0} 
    "从全局坐标系到frame_b的位置矢量，在全局坐标系中解析";
  parameter Types.ShapeType shapeType = "cylinder" "形状类型" annotation(
    Dialog(
    tab = "动画", 
    group = "如果animation = true", 
    enable = animation));
  parameter SI.Position r_shape[3] = {0, 0, 0} 
    "从全局坐标系到形状原点的矢量，在全局坐标系中解析" 
    annotation(Dialog(
    tab = "动画", 
    group = "如果animation = true", 
    enable = animation));
  parameter Types.Axis lengthDirection = to_unit1(r - r_shape) 
    "形状长度方向的矢量，在全局坐标系中解析" 
    annotation(Dialog(
    tab = "动画", 
    group = "如果animation = true", 
    enable = animation));
  parameter Types.Axis widthDirection = {0, 1, 0} 
    "形状宽度方向的矢量，在全局坐标系中解析" 
    annotation(Dialog(
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
  parameter Types.ShapeExtra extra = 0.0 
    "锥体、管道等的附加参数(请参阅Visualizers.Advanced.Shape的文档)" 
    annotation(Dialog(
    tab = "动画", 
    group = "如果animation = true", 
    enable = animation));
  input Types.Color color = Modelica.Mechanics.MultiBody.Types.Defaults.RodColor 
    "形状的颜色" annotation(Dialog(
    colorSelector = true, 
    tab = "动画", 
    group = "如果animation = true", 
    enable = animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射(= 0：光完全吸收)" 
    annotation(Dialog(
    tab = "动画", 
    group = "如果animation = true", 
    enable = animation));


protected
  outer Modelica.Mechanics.MultiBody.World world;
  Visualizers.Advanced.Shape shape(
    shapeType = shapeType, 
    color = color, 
    specularCoefficient = specularCoefficient, 
    length = length, 
    width = width, 
    height = height, 
    lengthDirection = lengthDirection, 
    widthDirection = widthDirection, 
    extra = extra, 
    r_shape = r_shape, 
    r = zeros(3), 
    R = Frames.nullRotation()) if world.enableAnimation and animation;
equation
  Connections.root(frame_b.R);
  frame_b.r_0 = r;
  frame_b.R = Frames.nullRotation();
  annotation(
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Rectangle(
    extent = {{-90, 90}, {90, -90}}, 
    lineColor = {255, 255, 255}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), 
    Text(
    extent = {{150, 145}, {-150, 105}}, 
    textString = "%name", 
    textColor = {0, 0, 255}), 
    Line(points = {{0, 100}, {0, -100}}), 
    Line(points = {{0, -80}, {-100, -20}}), 
    Line(points = {{0, -40}, {-100, 20}}), 
    Line(points = {{0, 0}, {-100, 60}}), 
    Line(points = {{0, 40}, {-100, 100}}), 
    Line(points = {{0, 0}, {100, 0}}), 
    Text(
    extent = {{-150, -105}, {150, -135}}, 
    textString = "r=%r")}), 
    Documentation(info = "<html>
<p>
该元素由一个在全局坐标系中固定的坐标系(frame_b)组成，该坐标系的位置由参数矢量<strong>r</strong>定义(从全局坐标系原点到frame_b的矢量，在全局坐标系中解析)。</p>
<p>
默认情况下，此组件通过连接全局坐标系和此组件的frame_b的圆柱体来进行可视化，如下图所示。
请注意，左侧可视化的全局坐标系和右侧的Fixed.frame_b不是组件动画的一部分，并且可以通过参数animation = <strong>false</strong>关闭动画。
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Parts/Fixed.png\" alt=\"Parts.Fixed\">
</div>

</html>"));
end Fixed;