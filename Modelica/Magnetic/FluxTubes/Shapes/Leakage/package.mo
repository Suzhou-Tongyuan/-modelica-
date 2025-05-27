within Modelica.Magnetic.FluxTubes.Shapes;
package Leakage "泄漏磁通管具有与位置无关的磁通，因此不产生力;mu_r = 1"
  extends Modelica.Icons.VariantsPackage;

  annotation (Documentation(info="<html>
<p>
请查看<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.ReluctanceForceCalculation\">UsersGuide. ReluctanceForceCalculation</a>的不同磁通管类别和产生的子包的解释.
</p>

<p>
这个包的所有元素的渗透是从它们的几何形状计算出来的。这些磁通管元件用于模拟通过真空、空气和其他相对磁导率为mu_r=1的介质的泄漏场。<a href=\"modelica://Modelica.Magnetic.FluxTubes.Basic.LeakageWithCoefficient\">Basic. LeakageWithCoefficient</a> 不是通过磁通管的几何形状，而是通过耦合系数c_usefulFlux来计算泄漏.
</p>

<p>
所有维度都定义为参数。因此，在执行器的动态仿真过程中，这些元件的形状将保持不变，并且这些磁通管元件不会产生磁阻力。一个简单的磁阻磁通管提供了元件<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Force.LeakageAroundPoles\">Force.LeakageAroundPoles</a>.。在该元件精度不够的情况下，该封装的泄漏元件可以进行调整和扩展，以便它们能够随着电枢运动改变形状并产生磁阻力。这需要一个局部模型的扩展<a href=\"modelica://Modelica.Magnetic.FluxTubes.BaseClasses.Force\">BaseClasses. Force</a>，表示磁通管尺寸的变量的较高可变性，定义电枢位置与这些尺寸之间的关系，确定磁通管的磁通率G_m对电枢位置x的解析导数dG_m/dx.
</p>
</html>"));
end Leakage;