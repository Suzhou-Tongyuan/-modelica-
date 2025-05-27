within Modelica.Magnetic.QuasiStatic.FluxTubes.Sensors;
model MagneticFluxSensor "测量磁通量的传感器"
  extends FluxTubes.Interfaces.RelativeSensor;

equation
  V_m = Complex(0);
  y = Phi;

  annotation (defaultComponentName="magFluxSensor", 
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
            -100},{100,100}}), graphics={
        Text(
          extent={{-30,-10},{30,-70}}, 
          textColor={64,64,64}, 
          textString="Wb"), 
        Line(points={{100,0},{-100,0}},color={255,170,85})}), 
    Documentation(info="<html>
<p>
该传感器可用于测量准静态磁系统的复磁通<码>Phi</码>.
</p>
</html>"));
end MagneticFluxSensor;