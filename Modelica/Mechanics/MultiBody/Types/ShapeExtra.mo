within Modelica.Mechanics.MultiBody.Types;
type ShapeExtra = Modelica.Icons.TypeReal 
  "用于定义可为基本ShapeType定义的额外数据的类型" 
     annotation (
  Documentation(info="<html>
<p>
该类型用于可视对象的形状中，根据形状类型定义额外数据。
通常，输入变量<strong>extra</strong>用作实例名称：</p>

<table border=\"1\"cellspacing=\"0\"cellpadding=\"2\">
<tr><th><strong>shapeType</strong></th><th>参数<strong>extra</strong>的含义</th></tr>
<tr>
<td>\"cylinder\"</td>
<td>如果extra&nbsp;&gt;&nbsp;0，则在圆柱体中包含一条黑线，用于显示其旋转。
</td>
</tr>
<tr>
<td>\"cone\"</td>
<td>extra=左侧直径/右侧直径，即，<br>
extra=1:圆柱体<br>
extra=0:\"真实\"圆锥体。
</td>
</tr>
<tr>
<td>\"pipe\"</td>
<td>extra=外直径/内直径，即，<br>
extra=1:完全中空的圆柱体<br>
extra=0:没有孔的圆柱体。
</td>
</tr>
<tr>
<td>\"gearwheel\"</td>
<td>extra是(外部)齿轮的齿数。
如果extra&nbsp;&lt;&nbsp;0，则使用|extra|齿数可视化内齿轮。
齿轮轴沿\"lengthDirection\"，通常为：
宽度=高度=2*radiusOfGearWheel。
</td>
</tr>
<tr>
<td>\"spring\"</td>
<td>extra是弹簧的匝数。
此外，“高度”不是指“高度”，而是2*coil-width。
</td>
</tr>
<tr>
<td>外部形状</td>
<td>extra=0:文件中的可视化未缩放。
<br>
extra=1：文件中的可视化按形状的\"length\"、\"width\"和\"height\"缩放</td>
</tr>
</table>
</html>"));