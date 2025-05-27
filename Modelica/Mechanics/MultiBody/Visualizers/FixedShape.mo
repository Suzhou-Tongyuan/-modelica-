within Modelica.Mechanics.MultiBody.Visualizers;
model FixedShape 
  "使用动态变化的形状属性可视化基本形状(具有一个坐标系连接器)"
  import Modelica.Mechanics.MultiBody.Types;
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialVisualizer;

  parameter Boolean animation=true "=true，则启用动画";
  parameter Types.ShapeType shapeType="box" "形状类型" 
    annotation (Dialog(group="如果animation=true", enable=animation));
  input SI.Position r_shape[3]={0,0,0} 
    "从frame_a到形状原点的矢量，以frame_a为基准" 
    annotation (Dialog(group="如果animation=true", enable=animation));
  input Types.Axis lengthDirection={1,0,0} 
    "形状长度方向的矢量，以frame_a为基准" 
    annotation (Dialog(group="如果animation=true", enable=animation));
  input Types.Axis widthDirection={0,1,0} 
    "形状宽度方向的矢量，以frame_a为基准" 
    annotation (Dialog(group="如果animation=true", enable=animation));
  input SI.Distance length(start=1) "形状长度" 
    annotation (Dialog(group="如果animation=true", enable=animation));
  input SI.Distance width(start=0.1) "形状宽度" 
    annotation (Dialog(group="如果animation=true", enable=animation));
  input SI.Distance height(start=0.1) "形状高度" 
    annotation (Dialog(group="如果animation=true", enable=animation));
  input Modelica.Mechanics.MultiBody.Types.Color color={0,128,255} 
    "形状颜色" 
    annotation (Dialog(colorSelector=true, group="如果animation=true", enable=animation));
  input Types.ShapeExtra extra=0.0 
    "圆柱体、锥体、管道、齿轮和弹簧的额外数据" 
    annotation (Dialog(group="如果animation=true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射(=0：光完全被吸收)" 
    annotation (Dialog(group="如果animation=true", enable=animation));

protected
  Advanced.Shape vis(
    shapeType=shapeType, 
    r_shape=r_shape, 
    lengthDirection=lengthDirection, 
    widthDirection=widthDirection, 
    length=length, 
    width=width, 
    height=height, 
    color=color, 
    extra=extra, 
    specularCoefficient=specularCoefficient, 
    r=frame_a.r_0, 
    R=frame_a.R) if world.enableAnimation and animation;
equation
  // No forces and torques
  frame_a.f = zeros(3);
  frame_a.t = zeros(3);
  annotation (
    Documentation(info="<html>
<p>
模型<strong>FixedShape</strong>定义了一个在其frame_a位置显示的可视形状。
所有描述性数据，如大小和颜色，都可以通过在参数菜单的输入字段中提供适当的表达式来动态变化。
唯一的例外是参数shapeType，在仿真期间无法更改。
当前通过参数<strong>shapeType</strong>(例如，shapeType=\"box\")支持以下形状：<br>&nbsp;</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Shape.png\"alt=\"model Visualizers.FixedShape\">
</div>

<p>
上图中的深蓝色箭头沿着变量<strong>lengthDirection</strong>指向。
浅蓝色箭头沿着变量<strong>widthDirection</strong>指向。
图中的<strong>坐标系</strong>代表FixedShape组件的frame_a。
</p>

<p>
另外，<strong>外部形状</strong>可以指定为(不是所有选项都由所有工具支持)：</p>

<ul>
<li><strong>\"1\"、\"2\"、&nbsp;&hellip;</strong><br>
定义在文件\"1.dxf\"、\"2.dxf\"、&nbsp;&hellip;中以DXF格式指定的外部形状。
DXF文件必须位于当前目录或引用DXF文件的Shape实例存储的目录中。
不应该为新模型使用这个(非常有限的)选项。
示例：<br>
shapeType=\"1\"。
<br></li>

<li>\"<strong>modelica:</strong>//&lt;Modelica 名称&gt;/&lt;相对路径文件名&gt;\"<br>
表示存储在具有给定相对文件名的&lt;Modelica名称&gt;库路径下的位置的文件。
示例：<br>shapeType=\"modelica://Modelica/Resources/Data/Shapes/Engine/piston.dxf\"。
<br></li>

<li>\"<strong>file:</strong>//&lt;绝对文件名&gt;\"<br>
表示文件系统中的绝对文件名。
示例：<br>
shapeType=\"file://C:/users/myname/shapes/piston.dxf\"。
</li>
</ul>

<p>
支持的文件格式因工具而异。
大多数工具至少支持DXF文件，但也可能支持其他格式(如stl、obj、3ds)。
由于可视化文件包含颜色和其他数据，通常会忽略模型中的相应信息。
有关DXF文件的信息，请参阅<a href=\"https://en.wikipedia.org/wiki/AutoCAD_DXF\">维基百科</a>。
默认情况下，假设DXF坐标在“frame_a”系统中且以米为单位，并且3dfaces是双面的。
一些工具仅支持3dface(用于几何)和layer(用于高级着色)。
</p>

<p>
上述组件的尺寸由<strong>长度</strong>、<strong>宽度</strong>和<strong>高度</strong>变量指定。
通过变量<strong>额外</strong>可以定义额外的数据：</p>
<table border=\"1\"cellspacing=\"0\"cellpadding=\"2\">
<tr><th><strong>形状类型</strong></th><th><strong>额外</strong>参数的含义</th></tr>
<tr>
<td>\"圆柱体\"</td>
<td>如果额外&nbsp;&gt;&nbsp;0，圆柱体中包含一条黑线以显示其旋转。
</td>
</tr>
<tr>
<td>\"锥体\"</td>
<td>额外=左侧直径/右侧直径，即：<br>
额外=1：圆柱体<br>
额外=0：\"真实\"锥体。
</td>
</tr>
<tr>
<td>\"管道\"</td>
<td>额外=外径/内径，即：<br>
额外=1：完全为空心的圆柱体<br>
额外=0：没有孔的圆柱体。
</td>
</tr>
<tr>
<td>\"齿轮\"</td>
<td>额外是(外部)齿轮的齿数。
如果额外&nbsp;&lt;&nbsp;0，则用|额外|齿可视化内部齿轮。
齿轮的轴沿着“长度方向”，通常情况下：
宽度=高度=2*齿轮半径。
</td>
</tr>
<tr>
<td>\"弹簧\"</td>
<td>额外是弹簧的匝数。
此外，“高度”不是“高度”，而是2*线圈宽度。
</td>
</tr>
<tr>
<td>外部形状</td>
<td>额外=0：从文件可视化未经缩放。
<br>
额外=1：从文件可视化按照形状的\"长度\"、\"宽度\"和\"高度\"进行缩放。
</td>
</tr>
</table>

<p>
参数<strong>color</strong>是一个具有3个元素的矢量，{r,&nbsp;g,&nbsp;b}，用于指定形状的颜色。
{r,&nbsp;g,&nbsp;b}分别代表\"红色\"、\"绿色\"和\"蓝色\"部分。
请注意，r、g和b分别以0&nbsp;&hellip;&nbsp;255的范围给出为Integer[3]。
预定义类型<a href=\"modelica://Modelica.Mechanics.MultiBody.Types.Color\">MultiBody.Types.Color</a>包含了MultiBody库中使用的颜色的菜单定义以及颜色编辑器。
</p>

</html>"), 
         Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Polygon(
          points={{-100,32},{-64,46},{2,30},{72,54},{50,32},{-10,12},{-100,32}}, 
          lineColor={215,215,215}, 
          fillColor={160,160,160}, 
          fillPattern=FillPattern.Solid), 
        Polygon(
          points={{72,54},{50,32},{50,-60},{72,-32},{72,54}}, 
          lineColor={215,215,215}, 
          fillColor={160,160,164}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-150,-65},{150,-95}}, 
          textString="%shapeType"), 
        Text(
          extent={{-150,100},{150,60}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Polygon(
          points={{-100,32},{-100,-60},{-10,-42},{50,-60},{50,32},{-10,12},{-100,32}}, 
          lineColor={215,215,215}, 
          fillColor={0,127,255}, 
          fillPattern=FillPattern.Solid)}));
end FixedShape;