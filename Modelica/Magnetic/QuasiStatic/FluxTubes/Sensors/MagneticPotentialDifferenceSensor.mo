within Modelica.Magnetic.QuasiStatic.FluxTubes.Sensors;
model MagneticPotentialDifferenceSensor 
"测量磁电位差的传感器"
  extends FluxTubes.Interfaces.RelativeSensor;

equation
  Phi = Complex(0);
  y = V_m;

  annotation (defaultComponentName="magVoltageSensor", 
    Icon(coordinateSystem(
      preserveAspectRatio=false, 
      extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-30,-10},{30,-70}}, 
          textColor={64,64,64}, 
          textString="A")}),    Documentation(info="<html>
<p>
该传感器可用于测量复磁位差<code>V_m</code>
在准静态磁系统中.
</p>
</html>"));
end MagneticPotentialDifferenceSensor;