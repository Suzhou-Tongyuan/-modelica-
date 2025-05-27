within Modelica.Mechanics.MultiBody.Visualizers;
model FixedShape2 
  "使用动态变化的形状属性可视化基本形状(具有两个坐标系连接器)"

  import Modelica.Mechanics.MultiBody.Frames;
  import Modelica.Mechanics.MultiBody.Types;
  import Modelica.Units.Conversions.to_unit1;

  Interfaces.Frame_a frame_a 
    "坐标系a(所有形状定义矢量在此坐标系中解析)" 
    annotation(Placement(transformation(extent = {{-116, -16}, {-84, 16}})));
  Interfaces.Frame_b frame_b "坐标系b" 
    annotation(Placement(transformation(extent = {{84, -16}, {116, 16}})));

  parameter Boolean animation = true "=true，则启用动画";
  parameter Types.ShapeType shapeType = "box" "形状类型" 
    annotation(Dialog(group = "如果animation=true", enable = animation));
  input SI.Position r[3] = {1, 0, 0} 
    "从frame_a到frame_b的矢量，解析在frame_a中";
  input SI.Position r_shape[3] = {0, 0, 0} 
    "从frame_a到形状原点的矢量，解析在frame_a中" 
    annotation(Dialog(group = "如果animation=true", enable = animation));
  input Types.Axis lengthDirection = to_unit1(r - r_shape) 
    "形状长度方向的矢量，解析在frame_a中" 
    annotation(Dialog(group = "如果animation=true", enable = animation));
  input Types.Axis widthDirection = {0, 1, 0} 
    "形状宽度方向的矢量，解析在frame_a中" 
    annotation(Dialog(group = "如果animation=true", enable = animation));
  input SI.Length length = Modelica.Math.Vectors.length(r - r_shape) "形状长度" 
    annotation(Dialog(group = "如果animation=true", enable = animation));
  input SI.Distance width = 0.1 "形状宽度" 
    annotation(Dialog(group = "如果animation=true", enable = animation));
  input SI.Distance height = width "形状高度" 
    annotation(Dialog(group = "如果animation=true", enable = animation));
  input Types.ShapeExtra extra = 0.0 
    "圆柱体、圆锥体、管道、齿轮和弹簧的附加数据" 
    annotation(Dialog(group = "如果animation=true", enable = animation));
  input Types.Color color = {0, 128, 255} "形状颜色" 
    annotation(Dialog(colorSelector = true, group = "如果animation=true", enable = animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射(=0：光完全被吸收)" 
    annotation(Dialog(group = "如果animation=true", enable = animation));

protected
  outer MultiBody.World world;
  Advanced.Shape shape(
    shapeType = shapeType, 
    r_shape = r_shape, 
    lengthDirection = lengthDirection, 
    widthDirection = widthDirection, 
    length = length, 
    width = width, 
    height = height, 
    extra = extra, 
    color = color, 
    specularCoefficient = specularCoefficient, 
    r = frame_a.r_0, 
    R = frame_a.R) if world.enableAnimation and animation;
equation
  Connections.branch(frame_a.R, frame_b.R);
  assert(cardinality(frame_a) > 0 or cardinality(frame_b) > 0, "多体可视化器FixedShape2对象的连接器frame_a或frame_b未连接");

  frame_b.r_0 = frame_a.r_0 + Frames.resolve1(frame_a.R, r);
  frame_b.R = frame_a.R;

  /* 力和力矩平衡 */
  zeros(3) = frame_a.f + frame_b.f;
  zeros(3) = frame_a.t + frame_b.t + cross(r, frame_b.f);

  annotation(
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Text(
    extent = {{-150, 115}, {150, 75}}, 
    textString = "%name", 
    textColor = {0, 0, 255}), 
    Text(
    extent = {{150, -90}, {-150, -60}}, 
    textString = "r=%r"), 
    Polygon(
    points = {{-100, 50}, {-66, 62}, {0, 46}, {100, 70}, {80, 50}, {-10, 28}, {-100, 50}}, 
    lineColor = {255, 255, 255}, 
    fillColor = {160, 160, 164}, 
    fillPattern = FillPattern.Solid), 
    Polygon(
    points = {{100, 70}, {80, 50}, {80, -44}, {100, -16}, {100, 70}}, 
    lineColor = {255, 255, 255}, 
    fillColor = {160, 160, 164}, 
    fillPattern = FillPattern.Solid), 
    Polygon(
    points = {{-100, 50}, {-100, -44}, {-10, -24}, {80, -44}, {80, 50}, {-10, 28}, {-100, 50}}, 
    lineColor = {215, 215, 215}, 
    fillColor = {0, 127, 255}, 
    fillPattern = FillPattern.Solid), 
    Text(
    extent = {{-86, 15}, {-50, -10}}, 
    textString = "a"), 
    Text(
    extent = {{37, 15}, {73, -10}}, 
    textString = "b")}), 
    Documentation(info = "<html>
<p>
<strong>FixedShape2</strong>模型定义了一个在frame_a位置显示的视觉形状。
这个模型与<strong>FixedShape</strong>完全相同，唯一的区别是存在一个额外的frame_b，它与frame_a平行。
这样做可以更方便地连接多个视觉形状，构建更复杂的视觉对象。
所有描述性数据，如大小和颜色，都可以通过在参数菜单的输入字段中提供适当的表达式来动态变化。
唯一的例外是参数shapeType，在模拟过程中无法更改。
目前通过参数<strong>shapeType</strong>支持以下形状(例如，shapeType=\"box\")：<br>&nbsp;</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Shape.png\"alt=\"model Visualizers.FixedShape2\">
</div>

<p>
&nbsp;<br>上图中的深蓝色箭头沿着变量<strong>lengthDirection</strong>方向。
浅蓝色箭头沿着变量<strong>widthDirection</strong>方向。
图中的<strong>坐标系</strong>代表FixedShape组件的frame_a。
</p>

<p>
此外，还可以指定<strong>外部形状</strong>(并非所有选项都适用于所有工具)：</p>

<ul>
<li><strong>\"1\",\"2\",&nbsp;&hellip;</strong><br>
定义在文件\"1.dxf\"、\"2.dxf\"等DXF格式文件中指定的外部形状。
DXF文件必须位于当前目录或引用了DXF文件的Shape实例所在的目录中。
这个(非常有限的)选项不应用于新模型。
示例：<br>
shapeType=\"1\"。
<br></li>

<li>\"<strong>modelica:</strong>//&lt;Modelica-name&gt;/&lt;relative-path-file-name&gt;\"<br>
表征存储在给定相对文件名的&lt;Modelica-name&gt;库路径下的位置的文件。
示例：<br>shapeType=\"modelica://Modelica/Resources/Data/Shapes/Engine/piston.dxf\"。
<br></li>

<li>\"<strong>file:</strong>//&lt;absolute-file-name&gt;\"<br>
表征文件系统中的绝对文件名。
示例：<br>
shapeType=\"file://C:/users/myname/shapes/piston.dxf\"。
</li>
</ul>

<p>
支持的文件格式取决于工具。
大多数工具至少支持DXF文件，但也可能支持其他格式(如STL、OBJ、3DS)。
由于可视化文件包含颜色和其他数据，模型中的相应信息通常被忽略。
有关DXF文件的信息，请参阅<a href=\"https://zh.wikipedia.org/wiki/DXF\">维基百科</a>。
默认情况下，假定DXF坐标位于“frame_a”系统中，单位为米，并且3D面是双面的。
一些工具仅支持3D面(用于几何)和层(用于高级着色)。
</p>

<p>
上述任何组件的尺寸由<strong>length</strong>、<strong>width</strong>和<strong>height</strong>变量指定。
通过变量<strong>extra</strong>可以定义额外的数据：</p>
<table border=\"1\"cellspacing=\"0\"cellpadding=\"2\">
<tr><th><strong>shapeType</strong></th><th>参数<strong>extra</strong>的含义</th></tr>
<tr>
<td>\"cylinder\"</td>
<td>如果extra&nbsp;&gt;&nbsp;0，则包括一条黑线表示圆柱体的旋转。
</td>
</tr>
<tr>
<td>\"cone\"</td>
<td>extra=左侧直径/右侧直径，即，<br>
extra=1:圆柱体<br>
extra=0:“真实”圆锥体。
</td>
</tr>
<tr>
<td>\"pipe\"</td>
<td>extra=外径/内径，即，<br>
extra=1:完全中空的圆柱体<br>
extra=0:没有孔的圆柱体。
</td>
</tr>
<tr>
<td>\"gearwheel\"</td>
<td>extra是(外部)齿轮的齿数。
如果extra&nbsp;&lt;&nbsp;0，则使用|extra|齿绘制内齿轮。
齿轮的轴沿着“lengthDirection”，通常：
width=height=2*radiusOfGearWheel。
</td>
</tr>
<tr>
<td>\"spring\"</td>
<td>extra是弹簧的匝数。
此外，“height”不是“高度”，而是2*coil-width。
</td>
</tr>
<tr>
<td>外部形状</td>
<td>extra=0:不缩放文件中的可视化。
<br>
extra=1:根据形状的“length”、“width”和“height”进行缩放文件中的可视化</td>
</tr>
</table>
<p>
参数<strong>color</strong>是一个具有3个元素的矢量，{r,&nbsp;g,&nbsp;b}，用于指定形状的颜色。
{r,&nbsp;g,&nbsp;b}分别是“红色”、“绿色”和“蓝色”的颜色分量。
注意，r、g、b分别以范围0&nbsp;&hellip;&nbsp;255的整数[3]给出。
预定义类型<a href=\"modelica://Modelica.Mechanics.MultiBody.Types.Color\">MultiBody.Types.Color</a>包含了MultiBody库中使用的颜色的菜单定义以及颜色编辑器。
</p>
<p>
在下图中显示了frame_a和frame_b之间的关系。
frame_b相对于frame_a的原点由参数矢量<strong>r</strong>指定。
</p>


<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Parts/FixedTranslation.png\"alt=\"Parts.FixedTranslation\">
</div>
</html>"));
end FixedShape2;