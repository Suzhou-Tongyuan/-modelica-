within Modelica.Mechanics.MultiBody.Types;
type ShapeType = Modelica.Icons.TypeString 
  "形状类型(长方体、球体、圆柱体、管状圆柱体、锥体、管道、梁、齿轮、弹簧，<外部形状>)" 
  annotation (choices(
    choice="box" "\"box\"", 
    choice="sphere" "\"sphere\"", 
    choice="cylinder" "\"cylinder\"", 
    choice="pipecylinder" "\"pipecylinder\"", 
    choice="cone" "\"cone\"", 
    choice="pipe" "\"pipe\"", 
    choice="beam" "\"beam\"", 
    choice="gearwheel" "\"gearwheel\"", 
    choice="spring" "\"spring\"", 
    choice="modelica://PackageName/PathName.dxf"), 
  Documentation(info="<html>
<p>
类型<strong>ShapeType</strong>用于以字符串参数定义可视对象的形状。
通常情况下，\"shapeType\"被用作实例名称。
下面是shapeType的可能取值，例如，shapeType=\"box\"：</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Shape.png\"alt=\"model Visualizers.FixedShape\">
</div>

<p>
上图中的深蓝色箭头沿着变量<strong>lengthDirection</strong>指向。
浅蓝色箭头沿着变量<strong>widthDirection</strong>指向。
图中的<strong>坐标系</strong>表示形状组件的frame_a。
</p>

<p>
另外，可以指定外部形状(不是所有选项都可能被所有工具支持)：</p>

<ul>
<li><strong>\"1\",\"2\",&nbsp;&hellip;</strong><br>
定义以DXF格式指定的外部形状，文件名为\"1.dxf\"、\"2.dxf\"、&nbsp;&hellip;DXF文件必须位于当前目录或引用DXF文件的形状实例所在的目录中。
这个(非常有限的)选项不应该用于新模型。
示例：<br>
shapeType=\"1\".<br></li>

<li>\"<strong>modelica:</strong>//&lt;Modelica-name&gt;/&lt;relative-path-file-name&gt;\"<br>
表示存储在&lt;Modelica-name&gt;库路径下具有给定相对文件名的文件。
示例：<br>shapeType=\"modelica://Modelica/Resources/Data/Shapes/Engine/piston.dxf\".<br></li>

<li>\"<strong>file:</strong>//&lt;absolute-file-name&gt;\"<br>
表示文件系统中的绝对文件名。
示例：<br>
shapeType=\"file://C:/users/myname/shapes/piston.dxf\"。
</li>
</ul>

<p>
支持的文件格式取决于工具。
大多数工具至少支持DXF文件(某些工具可能仅支持DXF格式的三维面)，但也可能支持其他格式(如stl、obj、3ds)。
由于可视化文件包含颜色和其他数据，因此模型中的相应信息通常被忽略。
</p>
</html>"));