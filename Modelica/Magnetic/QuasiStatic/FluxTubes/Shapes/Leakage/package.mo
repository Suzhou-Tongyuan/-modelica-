within Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes;
package Leakage "泄漏磁通管具有与位置无关的磁通，因此不产生力;mu_r = 1"
  extends Modelica.Icons.VariantsPackage;
  annotation (Documentation(info="<html>
<p>
这个包的所有元素的磁导率都是根据它们的几何形状计算的<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a>。这些磁通管元件用于模拟通过真空、空气和其他具有相对磁导率的介质的泄漏场
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/mu_r-1.png\">。
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Basic.LeakageWithCoefficient\">Basic. LeakageWithCoefficient</a>不是通过磁通管的几何形状来解释泄漏，而是通过耦合系数<code>c_usefulFlux</code>.
</p></html>"));
end Leakage;