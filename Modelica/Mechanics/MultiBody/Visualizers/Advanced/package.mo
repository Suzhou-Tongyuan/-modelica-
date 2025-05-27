within Modelica.Mechanics.MultiBody.Visualizers;
package Advanced "需要基本的Modelica知识才能使用的可视化组件"

  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>
包<strong>Visualizers.高级</strong>包含用于可视化具有动态大小的三维形状的组件。
这些组件中没有一个有坐标系连接器。
位置和方向是通过修饰符设置的。
为了使用此包的组件，需要基本的Modelica知识。
这些组件还必须用于模型，其中坐标系连接器中的力和扭矩是通过方程设置的(在这种情况下，不能使用Visualizers包的模型，因为它们都有坐标系连接器)。
</p>
<h4>内容</h4>
<table border=\"1\"cellspacing=\"0\"cellpadding=\"2\">
<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Arrow\">Arrow</a></td>
<td>可视化箭头，箭头的所有部分都可以动态变化：<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Arrow.png\"alt=\"model Visualizers.Advanced.Arrow\">
</td>
</tr>
<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.DoubleArrow\">DoubleArrow</a></td>
<td>可视化双箭头，箭头的所有部分都可以动态变化：<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Advanced/DoubleArrow.png\"alt=\"model Visualizers.Advanced.DoubleArrow\">
</td>
</tr>
<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape\">Shape</a></td>
<td>可视化具有可变大小的基本对象。
支持以下形状类型：<br>&nbsp;<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/FixedShape.png\"alt=\"model Visualizers.Advanced.Shape\">
</td>
</tr>

<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Surface\">Surface</a></td>
<td>可视化可移动参数化表面：<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Advanced/Surface_small.png\">
</td>
</tr>

<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.PipeWithScalarField\">PipeWithScalarField</a></td>
<td>可视化通过颜色编码表示的标量场的管道：<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/PipeWithScalarFieldIcon.png\">
</td>
</tr>
</table>
</html>"));
end Advanced;