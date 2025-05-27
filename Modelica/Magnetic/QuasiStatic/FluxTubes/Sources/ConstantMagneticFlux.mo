within Modelica.Magnetic.QuasiStatic.FluxTubes.Sources;
model ConstantMagneticFlux "恒定磁通的来源"

  extends FluxTubes.Interfaces.Source;
  parameter SI.Frequency f(start=1) "源频率";
  SI.ComplexMagneticPotentialDifference V_m 
  "两个端口之间的磁电位差";
  parameter SI.ComplexMagneticFlux Phi=Complex(1,0) 
  "磁通";

equation
  omega = 2*Modelica.Constants.pi*f;
  V_m = port_p.V_m - port_n.V_m;
  Complex(0) = port_p.Phi + port_n.Phi;
  Phi = port_p.Phi;
  annotation (
    defaultComponentName="magFluxSource", 
    Icon(coordinateSystem(
      preserveAspectRatio=false, 
      extent={{-100,-100},{100,100}}), graphics={
      Polygon(
        points={{80,0},{60,6},{60,-6},{80,0}}, 
        lineColor={255,170,85}, 
        fillColor={255,170,85}, 
        fillPattern=FillPattern.Solid), 
      Line(points={{-90,0},{-50,0}},  color={255,170,85}), 
      Line(points={{50,0},{90,0}},  color={255,170,85}), 
      Ellipse(
        extent={{-50,-50},{50,50}}, 
        lineColor={255,170,85}, 
        fillColor={255,255,255}, 
        fillPattern=FillPattern.Solid), 
      Line(points={{0,50},{0,-50}}, color={255,170,85})}), 
    Documentation(info="<html>
<p>
该源在固定频率下提供恒定的准静态磁通量<code>Phi</code>， <code>f</code>.
</p>
</html>"));
end ConstantMagneticFlux;