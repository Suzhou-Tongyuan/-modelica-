within Modelica.Mechanics.MultiBody.Visualizers.Advanced;
model Shape 
  "可视化具有可变大小的基本对象；所有数据都设置为可修改的(参见信息层)"

  extends ModelicaServices.Animation.Shape;
  extends Modelica.Utilities.Internal.PartialModelicaServices.Animation.PartialShape;

  annotation(
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Rectangle(
    extent = {{-100, -100}, {80, 60}}, 
    lineColor = {0, 0, 255}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), 
    Polygon(
    points = {{-100, 60}, {-80, 100}, {100, 100}, {80, 60}, {-100, 60}}, 
    lineColor = {0, 0, 255}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), 
    Polygon(
    points = {{100, 100}, {100, -60}, {80, -100}, {80, 60}, {100, 100}}, 
    lineColor = {0, 0, 255}, 
    fillColor = {160, 160, 164}, 
    fillPattern = FillPattern.Solid), 
    Text(
    extent = {{-100, -54}, {80, 8}}, 
    textString = "%shapeType"), 
    Text(
    extent = {{-150, 150}, {150, 110}}, 
    textColor = {0, 0, 255}, 
    textString = "%name")}), 
    Documentation(info = "<html>
<p>
<strong>Shape</strong>模型定义了一个可视形状，它显示在其参考坐标系的位置上，称为下面的“对象坐标系”。
所有描述变量，如大小和颜色，都可以动态变化(参数shapeType是唯一的例外)。
声明中的默认方程应通过提供适当的修饰方程进行修改。
<strong>Shape</strong>模型通常用作实现更简单易用的图形组件的基本构建块。
</p>

<p>
通过参数<strong>shapeType</strong>支持以下形状(例如，shapeType=\"box\")：<br>&nbsp;</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Shape.png\"alt=\"model Visualizers.FixedShape\">
</div>

<p>
&nbsp;<br>上图中的深蓝色箭头沿着变量<strong>lengthDirection</strong>指向。
浅蓝色箭头沿着变量<strong>widthDirection</strong>指向。
图中的<strong>坐标系</strong>表示Shape组件的frame_a。
</p>

<p>
此外，可以指定<strong>外部形状</strong>(并非所有选项都受所有工具支持)：</p>

<ul>
<li><strong>\"1\",\"2\",&nbsp;&hellip;</strong><br>
定义在文件\"1.dxf\",\"2.dxf\",&nbsp;&hellip;中以DXF格式指定的外部形状。
DXF文件必须位于当前目录或引用DXF文件的Shape实例所存储的目录中。
对于新模型，不应使用此(非常有限的)选项。
示例：<br>
shapeType=\"1\".<br></li>

<li>\"<strong>modelica:</strong>//&lt;Modelica 名称&gt;/&lt;相对路径文件名&gt;\"<br>
表示存储在给定相对文件名的&lt;Modelica名称&gt;库路径下的文件。
示例：<br>shapeType=\"modelica://Modelica/Resources/Data/Shapes/Engine/piston.dxf\".<br></li>

<li>\"<strong>file:</strong>//&lt;绝对文件名&gt;\"<br>
表示文件系统中的绝对文件名。
示例：<br>
shapeType=\"file://C:/users/myname/shapes/piston.dxf\"。
</li>
</ul>

<p>
支持的文件格式取决于工具。
大多数工具至少支持DXF文件，但也可能支持其他格式(如STL、OBJ、3DS)。
由于可视化文件包含颜色和其他数据，模型中的相应信息通常被忽略。
有关DXF文件的信息，请参阅<a href=\"https://en.wikipedia.org/wiki/AutoCAD_DXF\">维基百科</a>。
默认情况下，假定DXF坐标位于“frame_a”系统中，以米为单位，且3D面是双面的。
某些工具仅支持3D面(用于几何)和层(用于高级着色)。
</p>

<p>
上述任何组件的大小由<strong>length</strong>、<strong>width</strong>和<strong>height</strong>变量指定。
通过变量<strong>extra</strong>可以定义额外的数据：</p>
<table border=\"1\"cellspacing=\"0\"cellpadding=\"2\">
<tr><th><strong>shapeType</strong></th><th>参数<strong>extra</strong>的含义</th></tr>
<tr>
<td>\"cylinder\"</td>
<td>如果extra&nbsp;&gt;&nbsp;0，则在圆柱体中包含一条黑线以显示其旋转。</td>
</tr>
<tr>
<td>\"cone\"</td>
<td>extra=左侧直径/右侧直径，即，<br>
extra=1：圆柱体<br>
extra=0：\"真\"圆锥。</td>
</tr>
<tr>
<td>\"pipe\"</td>
<td>extra=外径/内径，即，<br>
extra=1：完全中空的圆柱体<br>
extra=0：没有孔的圆柱体。</td>
</tr>
<tr>
<td>\"gearwheel\"</td>
<td>extra是(外部)齿轮的齿数。
如果extra&lt;0，则以|extra|齿数可视化内部齿轮。
齿轮的轴沿着\"lengthDirection\"，通常：
width=height=2*gearwheel半径。</td>
</tr>
<tr>
<td>\"spring\"</td>
<td>extra是弹簧的匝数。
此外，\"height\"不是\"高度\"，而是2*coil-width。</td>
</tr>
<tr>
<td>外部形状</td>
<td>extra=0：文件中的可视化未经缩放。
<br>
extra=1：文件中的可视化使用形状的\"length\"、\"width\"和\"height\"进行缩放。</td>
</tr>
</table>
<p>
参数<strong>color</strong>是一个包含3个元素的矢量{r,&nbsp;g,&nbsp;b}，用于指定形状的颜色。
{r,&nbsp;g,&nbsp;b}分别是\"红色\"、\"绿色\"和\"蓝色\"的颜色部分。
请注意，r、g、b以0到255的整数范围给出。
预定义类型<a href=\"modelica://Modelica.Mechanics.MultiBody.Types.Color\">MultiBody.Types.Color</a>包含MultiBody库中使用的颜色的菜单定义以及颜色编辑器。
</p>

<p>
对话框变量<code>shapeType</code>,<code>R</code>,<code>r</code>,<code>r_shape</code>,<code>lengthDirection</code>,<code>widthDirection</code>,<code>length</code>,<code>width</code>,<code>height</code>,<code>extra</code>,<code>color</code>,和<code>specularCoefficient</code>被声明为(时间变化的)<strong>输入</strong>变量。
如果默认方程不合适，相应的修饰方程必须在使用<strong>Shape</strong>实例的模型中提供，例如：</p>

<blockquote><pre>
Visualizers.Advanced.Shape shape(length=sin(time));
</pre></blockquote>
</html>"));
end Shape;