within Modelica.Mechanics.MultiBody.Visualizers.Advanced;
model Vector "可视化矢量量(力、扭矩等)"
  extends ModelicaServices.Animation.Vector;
  extends Modelica.Utilities.Internal.PartialModelicaServices.Animation.PartialVector;

  annotation(
    Documentation(info = "<html>
<p>
<strong>Vector</strong> 模型定义了一个在指定位置动态可视化的矢量(见下面的变量)。
矢量长度不代表实际长度，而是一个不同的三维物理量(如力、力矩、速度等)，除了<strong>RelativePosition</strong>。
这允许对类似量的矢量在后处理期间适当地进行缩放。
这是有用的，即使对于<strong>RelativePosition</strong>，在这种情况下也可以禁用或夸张显示相对位置。
</p>

<p>
对话框中的变量<code>R</code>,<code>r</code>,<code>coordinates</code>,<code>color</code>,<code>specularCoefficient</code>,<code>quantity</code>,<code>headAtOrigin</code>,和<code>twoHeadedArrow</code>被声明为(时变的)<strong>input</strong>变量。
如果默认方程不合适，则必须在使用<strong>Vector</strong>实例的模型中提供相应的可修改的方程，例如，</p>
<blockquote><pre>
Visualizers.Advanced.VectorvectorForce(coordinates={sin(time),cos(time),0});
</pre></blockquote>

<p>
变量<code>color</code>是一个具有3个元素的整数矢量，{r,&nbsp;g,&nbsp;b}，指定了形状的颜色。
{r,&nbsp;g,&nbsp;b}分别表示\"红色\"、\"绿色\"和\"蓝色\"部分。
请注意，r、g和b的取值范围为0&nbsp;&hellip;&nbsp;255。
预定义类型<a href=\"modelica://Modelica.Mechanics.MultiBody.Types.Color\">MultiBody.Types.Color</a>包含MultiBody库中使用的颜色的菜单定义以及颜色编辑器。
</p>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
    100, 100}}), graphics = {
    Polygon(
    points = {{20, 60}, {100, 0}, {20, -60}, {20, 60}}, 
    fillColor = {60, 120, 180}, 
    fillPattern = FillPattern.Solid, 
    pattern = LinePattern.None), 
    Text(
    extent = {{-150, 105}, {150, 65}}, 
    textString = "%name", 
    textColor = {0, 0, 255}), 
    Rectangle(
    extent = {{-100, -28}, {20, 28}}, 
    fillColor = {60, 120, 180}, 
    fillPattern = FillPattern.Solid, 
    pattern = LinePattern.None, 
    lineColor = {0, 0, 0}), 
    Rectangle(
    extent = {{-100, -8}, {20, -20}}, 
    fillColor = {46, 94, 140}, 
    fillPattern = FillPattern.Solid, 
    pattern = LinePattern.None, 
    lineColor = {0, 0, 0}), 
    Rectangle(
    extent = {{-100, -20}, {20, -28}}, 
    fillColor = {26, 53, 80}, 
    fillPattern = FillPattern.Solid, 
    pattern = LinePattern.None, 
    lineColor = {0, 0, 0}), 
    Polygon(
    points = {{20, -20}, {100, 0}, {20, -48}, {20, -20}}, 
    fillColor = {46, 93, 140}, 
    fillPattern = FillPattern.Solid, 
    pattern = LinePattern.None, 
    lineColor = {0, 0, 0}), 
    Polygon(
    points = {{20, -60}, {100, 0}, {20, -48}, {20, -60}}, 
    fillColor = {26, 53, 80}, 
    fillPattern = FillPattern.Solid, 
    pattern = LinePattern.None, 
    lineColor = {0, 0, 0}), 
    Rectangle(
    extent = {{-100, 26}, {20, 4}}, 
    fillColor = {73, 147, 220}, 
    fillPattern = FillPattern.Solid, 
    pattern = LinePattern.None), 
    Rectangle(
    extent = {{-100, 22}, {20, 14}}, 
    fillColor = {85, 170, 255}, 
    fillPattern = FillPattern.Solid, 
    pattern = LinePattern.None), 
    Polygon(
    points = {{20, 56}, {100, 0}, {20, 18}, {20, 56}}, 
    fillColor = {72, 149, 220}, 
    fillPattern = FillPattern.Solid, 
    pattern = LinePattern.None, 
    lineColor = {0, 0, 0}), 
    Polygon(
    points = {{20, 48}, {100, 0}, {20, 36}, {20, 48}}, 
    fillColor = {85, 170, 255}, 
    fillPattern = FillPattern.Solid, 
    pattern = LinePattern.None, 
    lineColor = {0, 0, 0})}));
end Vector;