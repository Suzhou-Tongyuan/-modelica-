within Modelica.Magnetic.FluxTubes.Shapes;
package FixedShape "在模拟过程中具有固定形状和线性或非线性材料特性的流量管"
  extends Modelica.Icons.VariantsPackage;

  annotation (Documentation(info="<html>
<p>
请查看<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.ReluctanceForceCalculation\">UsersGuide.ReluctanceForceCalculation</a>的不同磁通管类别和产生的子包的解释.
</p>

<p>
由于对磁阻力计算的限制，在模拟转炉运动时，可能具有非线性材料特性mu_r(B)的磁通管元件必须具有固定的形状。因此，这些磁通管的尺寸被定义为扩展基类的模型组件中的参数<a href=\"modelica://Modelica.Magnetic.FluxTubes.BaseClasses.FixedShape\">BaseClasses.FixedShape</a>.</p>

<p>
对于磁路的初始设计，可以很容易地将可能非线性的磁通管元件的相对磁导率设置为恒定值mu_rConst(非线性磁导率设置为false)。在某些情况下，这可以简化设备磁路的粗略几何设计。一旦找到初始几何形状，磁性子系统就可以模拟和微调，使其具有更真实的铁磁材料的非线性特性。这样做需要将参数非线性磁导率设置为true，并选择<a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">Material.SoftMagnetic</a>中的一种软磁材料。
</p>
</html>"));
end FixedShape;