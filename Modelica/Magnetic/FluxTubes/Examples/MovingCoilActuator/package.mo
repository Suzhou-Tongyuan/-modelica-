within Modelica.Magnetic.FluxTubes.Examples;
package MovingCoilActuator "两种不同建模深度的平移电动推杆模型及其比较"
  extends Modelica.Icons.ExamplesPackage;

  annotation (Documentation(info="<html>
<p>
动圈执行器通常被称为电动力执行器，力和电流之间的比例行为由转换器常数表示(参见<a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.ConstantActuator\">ConstantActuator</a>)。然而，在一个简单的动圈执行器中，如本例所示，有一个额外的非线性力分量，这是由于电枢线圈进入铁磁定子时电感的增加。一个简单的<a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components. PermeanceActuator\">PermeanceActuator</a>可以用来描述这个非线性力分量.
</p>
</html>"));
end MovingCoilActuator;