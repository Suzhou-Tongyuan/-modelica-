within Modelica.Mechanics.MultiBody.Visualizers.Advanced;
model DoubleArrow 
    "可视化可变大小的双箭头"

  import Modelica.Mechanics.MultiBody.Types;
  import Modelica.Mechanics.MultiBody.Frames;
  import T = Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
  import Modelica.Units.Conversions.to_unit1;

  input Frames.Orientation R=Frames.nullRotation() 
    "将全局坐标系旋转到箭头坐标系的方向对象" annotation(Dialog);
  input SI.Position r[3]={0,0,0} 
    "从全局坐标系原点到箭头坐标系原点的位置矢量，以全局坐标系为参考" annotation(Dialog);
  input SI.Position r_tail[3]={0,0,0} 
    "从箭头坐标系原点到双箭头尾部的位置矢量，以箭头坐标系为参考" annotation(Dialog);
  input Real r_head[3]={0,0,0} 
    "从双箭头尾部到双箭头头部的矢量，以箭头坐标系为参考" annotation(Dialog);
  input Types.Color color=Modelica.Mechanics.MultiBody.Types.Defaults.ArrowColor 
    "双箭头的颜色" annotation(Dialog(colorSelector=true));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "描述环境光反射的材料属性(=0表示完全吸收光)" annotation(Dialog);
  parameter Types.VectorQuantity quantity=Types.VectorQuantity.Torque 
    "矢量表示的物理量的类型";
  input Boolean headAtOrigin=true "=true，如果矢量指向矢量坐标系的原点" annotation(Dialog);
protected
  outer Modelica.Mechanics.MultiBody.World world;
  SI.Position rvisobj[3] = r + T.resolve1(R.T, r_tail);
  Visualizers.Advanced.Vector arrowLine(
    coordinates=r_head, 
    color=color, 
    specularCoefficient=specularCoefficient, 
    r=rvisobj, 
    quantity=quantity, 
    headAtOrigin=headAtOrigin, 
    twoHeadedArrow=true, 
    R=R) if world.enableAnimation;

  annotation(
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
    100, 100}}), graphics = {
    Rectangle(
    extent = {{-100, 28}, {0, -28}}, 
    lineColor = {128, 128, 128}, 
    fillColor = {128, 128, 128}, 
    fillPattern = FillPattern.Solid), 
    Polygon(
    points = {{40, 60}, {100, 0}, {40, -60}, {40, 60}}, 
    lineColor = {128, 128, 128}, 
    fillColor = {128, 128, 128}, 
    fillPattern = FillPattern.Solid), 
    Text(
    extent = {{-150, 105}, {150, 65}}, 
    textString = "%name", 
    textColor = {0, 0, 255}), 
    Polygon(
    points = {{0, 60}, {60, 0}, {0, -60}, {0, 60}}, 
    lineColor = {128, 128, 128}, 
    fillColor = {128, 128, 128}, 
    fillPattern = FillPattern.Solid)}), 
    Documentation(info = "<html>
<p>
<strong>DoubleArrow</strong> 模型定义了一个动态可视化的双箭头，位于定义的位置(参见下面的变量)。
然而，在许多情况下，通过<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Vector\">Vector</a>来可视化物理矢量可能是更好的选择。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Advanced/DoubleArrow.png\"alt=\"model Visualizers.Advanced.DoubleArrow\">
</div>

<p>
对话框中的变量<code>R</code>,<code>r</code>,<code>r_tail</code>,<code>r_head</code>,<code>color</code>,<code>specularCoefficient</code>,和<code>headAtOrigin</code>被声明为(时变的)<strong>input</strong>变量。
如果默认方程不合适，则必须在使用<strong>Arrow</strong>实例的模型中提供相应的可修改的方程，例如，</p>

<blockquote><pre>
Visualizers.Advanced.DoubleArrowdoubleArrow(r_head={sin(time),cos(time},0})
</pre></blockquote>

<p>
变量<strong>color</strong>是一个具有3个元素的整数矢量，{r,&nbsp;g,&nbsp;b}，指定了形状的颜色。
{r,&nbsp;g,&nbsp;b}分别表示\"红色\"、\"绿色\"和\"蓝色\"部分。
请注意，r、g和b的取值范围为0&nbsp;&hellip;&nbsp;255。
预定义类型<a href=\"modelica://Modelica.Mechanics.MultiBody.Types.Color\">MultiBody.Types.Color</a>包含MultiBody库中使用的颜色的菜单定义以及颜色编辑器。
</p>
</html>"));
end DoubleArrow;