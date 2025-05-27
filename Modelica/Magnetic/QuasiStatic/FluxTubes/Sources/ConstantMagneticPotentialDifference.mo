within Modelica.Magnetic.QuasiStatic.FluxTubes.Sources;
model ConstantMagneticPotentialDifference "恒磁动势"

  extends FluxTubes.Interfaces.Source;
  parameter SI.Frequency f(start=1) "源频率";
  parameter SI.ComplexMagneticPotentialDifference V_m 
  "磁位差";
  SI.ComplexMagneticFlux Phi(re(start=0),im(start=0)) 
  "从port_p到port_n的磁通量";

equation
  omega = 2*Modelica.Constants.pi*f;
  V_m = port_p.V_m - port_n.V_m;
  Complex(0) = port_p.Phi + port_n.Phi;
  Phi = port_p.Phi;

  annotation (
    defaultComponentName="magVoltageSource", 
    Icon(coordinateSystem(
      preserveAspectRatio=false, 
      extent={{-100,-100},{100,100}}), graphics={
      Line(points={{90,0},{50,0}}, color={255,170,85}), 
      Line(points={{-50,0},{-90,0}}, color={255,170,85}), 
      Line(points={{-50,0},{50,0}}, color={255,170,85}), 
        Line(points={{-80,20},{-60,20}}, color={255,170,85}), 
        Line(points={{-70,30},{-70,10}}, color={255,170,85}), 
        Line(points={{60,20},{80,20}}, color={255,170,85})}), 
    Documentation(info="<html>
<p>
该源提供恒定的准静态磁位差<code>V_m</code>(或磁动势，mmf)，
在固定频率下, <code>f</code>.
</p>
</html>"));
end ConstantMagneticPotentialDifference;