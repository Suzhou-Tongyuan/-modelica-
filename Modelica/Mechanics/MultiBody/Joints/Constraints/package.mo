within Modelica.Mechanics.MultiBody.Joints;
package Constraints "通过约束定义运动副的组件"
  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>
这个包包含了<strong>约束组件</strong>，即理想化的、质量为零的元素，通过运动约束限制了坐标系之间的运动。
约束元素特别适用于包含<strong>运动回路</strong>的多体模型。
通常，运动回路会被自动处理。
然而，通过使用<a href=\"Modelica://Modelica.Mechanics.MultiBody.Joints.Assemblies\">Assemblies</a>子包中的组件解析某些类型的回路，或者通过提供数值上更好的回路约束公式以改善性能。
</p>
</html>"));
end Constraints;