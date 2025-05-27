within Modelica.Mechanics.MultiBody;
package Visualizers "用于动画的三维可视化对象"
  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>
<strong>Visualizers</strong>包含用于可视化三维形状的组件。
这些组件是MultiBody库动画功能的基础。
</p>
<h4>内容</h4>
<table border=\"1\"cellspacing=\"0\"cellpadding=\"2\">
<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.FixedShape\">FixedShape</a><br>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.FixedShape2\">FixedShape2</a></td>
<td>使用动态变化的形状属性来可视化基本形状。
FixedShape有一个连接器frame_a，而FixedShape2还额外拥有一个frame_b，
用于更容易地连接到其他可视对象。
支持以下形状类型：<br>&nbsp;<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/FixedShape.png\"alt=\"model Visualizers.FixedShape\">
</td>
</tr>
<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.FixedFrame\">FixedFrame</a></td>
<td>可视化包含固定大小轴标签的坐标系：<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/FixedFrame_small.png\"
alt=\"model Visualizers.FixedFrame2\">
</td>
</tr>
<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.FixedArrow\">FixedArrow</a>,<br>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.SignalArrow\">SignalArrow</a></td>
<td>可视化箭头。
模型\"FixedArrow\"提供了
固定大小的箭头，模型\"SignalArrow\"提供了
由输入信号矢量定义长度动态变化的箭头：<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Arrow.png\">
</td>
</tr>

<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Torus\">Torus</a></td>
<td>可视化环面：<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/TorusIcon.png\">
</td>
</tr>

<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.VoluminousWheel\">VoluminousWheel</a></td>
<td>可视化滚轮：<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/VoluminousWheelIcon.png\">
</td>
</tr>

<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.PipeWithScalarField\">PipeWithScalarField</a></td>
<td>可视化带有标量场的管道，通过颜色编码表示：<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/PipeWithScalarFieldIcon.png\">
</td>
</tr>

<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced\">高级</a></td>
<td>包含用于可视化三维形状的组件的<strong>包</strong>，
形状的所有部分都可以动态变化。
需要基本的Modelica知识才能利用此包的组件。
</td>
</tr>
</table>
<p>
可视化组件的颜色使用预定义类型<strong>MultiBody.Types.Color</strong>声明。
这是一个具有3个元素的矢量，{r,g,b}，指定形状的颜色。
{r,g,b}分别表示\"红色\"、\"绿色\"和\"蓝色\"部分。
注意，r、g、b分别以整数数组形式给出，范围为0&nbsp;&hellip;&nbsp;255。
</p>
</html>"), 
    Icon(
      coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), 
      graphics={
        Polygon(origin = {4.391, -1}, lineColor = {128, 128, 128}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-14.391, 86}, {75.609, 66}, {15.609, 26}, {-84.391, 56}}), 
        Polygon(origin = {18.391, -30}, lineColor = {128, 128, 128}, fillColor = {128, 128, 128}, fillPattern = FillPattern.Solid, points = {{61.609, 95}, {1.609, 55}, {1.609, -55}, {61.609, -5}}), 
        Polygon(origin = {-11.843, -48.757}, lineColor = {128, 128, 128}, fillColor = {191, 191, 191}, fillPattern = FillPattern.Solid, points = {{31.843, 73.757}, {31.843, -36.243}, {-68.157, 3.757}, {-68.157, 103.757}})}));
end Visualizers;