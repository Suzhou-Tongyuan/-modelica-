within Modelica.Mechanics.MultiBody;
package Parts "刚性组件，如具有质量和转动惯量的体和无质量杆"
  extends Modelica.Icons.Package;


  annotation (Documentation(info="<html>
<p>
<strong>Parts</strong>包包含多体系统的<strong>刚性组件</strong>。
这些组件可用于构建更复杂的结构。
例如，一个部件可能由一个\"Body\"和几个\"FixedTranslation\"组件构成。
</p>
<h4>目录</h4>
<table border=\"1\"cellspacing=\"0\"cellpadding=\"2\">
<tr><th><strong><em>模型</em></strong></th><th><strong><em>描述</em></strong></th></tr>
<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Fixed\">Fixed</a></td>
<td>在给定位置固定于世界坐标系中的坐标系。
它用一个形状来可视化，见下面的<strong>shapeType</strong>(两侧的坐标系不属于组件)：<br>&nbsp;<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Parts/Fixed.png\"alt=\"model Parts.Fixed\">
</td>
</tr>
<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.FixedTranslation\">FixedTranslation</a></td>
<td>frame_b相对于frame_a的固定平动。
它用一个形状来可视化，见下面的<strong>shapeType</strong>(两侧的坐标系不属于组件)：<br>&nbsp;<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Parts/FixedTranslation.png\"alt=\"model Parts.FixedTranslation\">
</td>
</tr>
<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.FixedRotation\">FixedRotation</a></td>
<td>frame_b相对于frame_a的固定平动和固定旋转。
它用一个形状来可视化，见下面的<strong>shapeType</strong>(两侧的坐标系不属于组件)：<br>&nbsp;<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Parts/FixedRotation.png\"alt=\"model Parts.FixedRotation\">
</td>
</tr>
<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Body\">Body</a></td>
<td>带有质量、转动惯量张量和一个坐标系连接器的刚体。
它用一个圆柱体和一个位于质心的球来可视化：<br>&nbsp;<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Parts/Body.png\"alt=\"model Parts.Body\">
</td>
</tr>

<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.BodyShape\">BodyShape</a></td>
<td>带有质量、转动惯量张量、不同的形状(见下面的<strong>shapeType</strong>)可以用于动画，并且有两个坐标系连接器：<br>&nbsp;<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Parts/BodyShape.png\"alt=\"model Parts.BodyShape\">
</td>
</tr>
<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Fixed\">FixedBodyBox</a></td>
<td>带有长方体形状的刚体(质量和动画属性根据长方体数据和密度计算)：<br>&nbsp;<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Parts/BodyBox.png\"alt=\"model Parts.BodyBox\">
</td>
</tr>
<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.BodyCylinder\">BodyCylinder</a></td>
<td>带有圆柱形状的刚体(质量和动画属性根据圆柱数据和密度计算)：<br>&nbsp;<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Parts/BodyCylinder.png\"alt=\"model Parts.BodyCylinder\">
</td>
</tr>
<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.PointMass\">PointMass</a></td>
<td>转动惯量张量和旋转被忽略的刚体：<br>&nbsp;<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Parts/PointMass.png\"alt=\"model Parts.PointMass\">
</td>
</tr>
<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Mounting1D\">Mounting1D</a></td>
<td>将一维支撑扭矩传递给三维系统
</td>
</tr>
<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Rotor1D\">Rotor1D</a></td>
<td>一维转动惯量连接在三维刚体上(不忽略动态效应)<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Parts/Rotor1D.png\"alt=\"model Parts.Rotor1D\">
</td>
</tr>
<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.BevelGear1D\">BevelGear1D</a></td>
<td>带有任意轴方向的一维齿轮箱(三维轴承坐标系)
</td>
</tr>
</table>

<p>
组件<strong>Fixed</strong>、<strong>FixedTranslation</strong>、<strong>FixedRotation</strong>和<strong>BodyShape</strong>根据参数<strong>shapeType</strong>进行可视化，该参数可以具有以下值(例如，shapeType = \"box\")：<br>&nbsp;<br></p>
<div><img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/FixedShape.png\"alt=\"model Visualizers.FixedShape\"></div>
<p>
可视化形状参数的所有细节都在<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.FixedShape\">Visualizers.FixedShape</a>中给出。
</p>
<p>
所有动画部件的颜色都通过参数<strong>color</strong>定义。
这是一个具有3个元素{r, g, b}的整数矢量，用于指定形状的颜色。
{r, g, b}分别在0&nbsp;&hellip;&nbsp;255范围中给出红色、绿色和蓝色部分。
预定义类型<strong>MultiBody.Types.Color</strong>包含MultiBody库中使用的颜色的菜单定义(这将被颜色编辑器替代)。
</p>
</html>"), Icon(graphics={Rectangle(
          extent={{-80,28},{2,-16}}, 
          lineColor={95,95,95}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          fillColor={215,215,215}, 
          radius=10), Ellipse(
          extent={{-8,52},{86,-42}}, 
          lineColor={95,95,95}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={215,215,215})}));
end Parts;