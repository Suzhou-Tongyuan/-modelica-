within Modelica.Mechanics.MultiBody;
package Joints "用于约束两个接口坐标系之间运动的组件"
  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>
该库中提供<strong>运动副组件</strong>，即理想化的、无质量的元素，用于约束接口坐标系之间的运动。
在子包<strong>Assemblies</strong>中提供了组合运动副，用于解决运动学环路的分析问题(这意味着这些运动副组合中出现的非线性方程组被稳健高效的解析求解)。
</p>
<h4>内容</h4>
<table border=\"1\"cellspacing=\"0\"cellpadding=\"2\">
<tr><th><strong><em>模型</em></strong></th><th><strong><em>描述</em></strong></th></tr>
<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Prismatic\">Prismatic</a></td>
<td>平动副和被驱动的平动副
(1个平移自由度，2个潜在状态变量)<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Prismatic.png\">
</td>
</tr>
<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Revolute\">Revolute</a>
</td>
<td>转动副和被驱动的转动副
(1个转动自由度，2个潜在状态变量)<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Revolute.png\">
</td>
</tr>
<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Cylindrical\">Cylindrical</a></td>
<td>圆柱副(2个自由度，4个潜在状态变量)<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Cylindrical.png\">
</td>
</tr>

<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Universal\">Universal</a></td>
<td>万向节(2个自由度，4个潜在状态变量)<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Universal.png\">
</td>
</tr>
<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Planar\">Planar</a></td>
<td>平面副(3个自由度，6个潜在状态变量)<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Planar.png\">
</td>
</tr>
<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Spherical\">Spherical</a></td>
<td>球副(3个约束，没有潜在状态变量，或者3个自由度和3个状态变量)<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Spherical.png\">
</td>
</tr>
<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.FreeMotion\">FreeMotion</a></td>
<td>自由运动副(6个自由度，12个潜在状态变量)<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/FreeMotion.png\">
</td>
</tr>
<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.SphericalSpherical\">SphericalSpherical</a></td>
<td>球-球组合副(1个约束，没有潜在状态变量)，在中间有可选的点质量<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/SphericalSpherical.png\">
</td>
</tr>
<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.UniversalSpherical\">UniversalSpherical</a></td>
<td>万向节-球组合副(1个约束，没有潜在状态变量)<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/UniversalSpherical.png\">
</td>
</tr>
<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.GearConstraint\">GearConstraint</a></td>
<td>理想的三维齿轮箱(任意轴方向)
</td>
</tr>
<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Assemblies\">MultiBody.Joints.Assemblies</a></td>
<td><strong>组合运动副</strong>的包，用于解析环路问题。
</td>
</tr>
<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Constraints\">MultiBody.Joints.Constraints</a></td>
<td><strong>约束</strong>的组件包，用于定义运动副
</td>
</tr>

</table>
</html>"), 
    Icon(
      coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), 
      graphics={
        Rectangle(
          origin={30,-22}, 
          lineColor={64,64,64}, 
          fillColor={235,235,235}, 
          fillPattern=FillPattern.VerticalCylinder, 
          extent={{-20,0},{20,100}}, 
          rotation=110), 
        Rectangle(
          origin={30,-22}, 
          lineColor={64,64,64}, 
          fillColor={215,215,215}, 
          fillPattern=FillPattern.VerticalCylinder, 
          extent={{-20,0},{20,100}}), 
        Rectangle(
          origin={30,-22}, 
          lineColor={64,64,64}, 
          extent={{-20,0},{20,100}}), 
        Rectangle(
          origin={30,-22}, 
          lineColor={64,64,64}, 
          extent={{-20,0},{20,100}}, 
          rotation=110), 
        Ellipse(
          origin={30,-22}, 
          rotation=-45, 
          lineColor={64,64,64}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          extent={{-34,-34},{34,34}}), 
        Ellipse(
          origin={30,-22}, 
          lineColor={64,64,64}, 
          fillColor={64,64,64}, 
          fillPattern=FillPattern.Solid, 
          extent={{-14,14},{14,-14}}), 
        Ellipse(
          extent={{-34,34},{34,-34}}, 
          lineColor={64,64,64}, 
          origin={30,-22})}));
end Joints;