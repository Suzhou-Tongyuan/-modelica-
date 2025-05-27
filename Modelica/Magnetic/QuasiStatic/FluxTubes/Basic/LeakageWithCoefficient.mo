within Modelica.Magnetic.QuasiStatic.FluxTubes.Basic;
model LeakageWithCoefficient 
"相对于有用磁通路径磁阻的泄漏磁阻（不适用于执行器的动态模拟）"

  extends BaseClasses.Leakage;
  import Modelica.Constants.eps;
  parameter SI.CouplingCoefficient c_usefulFlux(final min=eps, final max=1-eps, start=0.7) 
    "Ratio useful flux/(leakage flux + useful flux) = useful flux/total flux" 
    annotation (Dialog(groupImage= 
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Basic/LeakageWithCoefficient.png"));
  Blocks.Interfaces.RealInput R_mUsefulTot(quantity="Reluctance", unit="H-1") 
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},rotation=270,origin={0,120})));

equation
  (1 - c_usefulFlux)*R_m = c_usefulFlux*R_mUsefulTot;
  // 广义基尔霍夫电流定律

  annotation (Documentation(info="<html>
<p>
不同于磁通管元件的封装<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.Leakage\">Shapes.Leakage</a>
这是从它们的几何形状计算出来的，泄漏磁阻是根据有用磁通路径的总磁阻计算出来的。参数<code>c_usefulFlux</code>是有用通量与总通量的比值.
</p>
</html>"));
end LeakageWithCoefficient;