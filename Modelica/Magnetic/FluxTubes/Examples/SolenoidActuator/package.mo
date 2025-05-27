within Modelica.Magnetic.FluxTubes.Examples;
package SolenoidActuator "两种不同建模深度的磁阻致动器模型及其对比和使用方法"
  extends Modelica.Icons.ExamplesPackage;

  annotation (Documentation(info="<html>
<p>
在电磁或磁阻执行器中，由于不同磁导率区域(非饱和铁磁材料:mu_r>>1，相邻空气:mu_r=1)之间的表面相对磁导率mu_r的梯度不为零而产生推力或磁阻力。在集总磁网络模型中，这种力可以按<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide. ReluctanceForceCalculation\">Reluctance Forces</a>的用户指南.
</p>

<p>
作为磁阻执行器的一个例子，给出了一个简单的轴对称提升磁体，其电枢和磁极端面是平面的。通常，<a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.Components. SimpleSolenoid\">SimpleSolenoid</a>模型对于这种执行器的磁子系统的初始粗略设计是足够的。可以通过<a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.Components. AdvancedSolenoid\">AdvancedSolenoid</a>模型，其中线圈施加的磁动势被分割，电枢和轭架之间的泄漏磁通被更精确地计算.
</p>

<p>
可以分析这两种模型在静态行为方面的差异，并将其与<a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.ComparisonQuasiStatic\">ComparisonQuasiStatic</a>中更精确的有限元分析(FEA)得到的结果进行比较。在<a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.ComparisonPullInStroke\">ComparisonPullInStroke</a>中，可以分析所产生的动态行为差异，并将其与有限元分析结果进行比较。.
</p>
</html>"));
end SolenoidActuator;