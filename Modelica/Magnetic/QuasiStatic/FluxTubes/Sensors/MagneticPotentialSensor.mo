within Modelica.Magnetic.QuasiStatic.FluxTubes.Sensors;
model MagneticPotentialSensor "潜在的传感器"
  extends FluxTubes.Interfaces.AbsoluteSensor;
  Modelica.ComplexBlocks.Interfaces.ComplexOutput y annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));
equation
  y = port.V_m;
  annotation (defaultComponentName="magPotentialSensor", 
  Documentation(info="<html>
<p>
该传感器可用于测量准静态磁系统中的复磁势<code>V_m</code>.
</p>
</html>"), 
    Icon(graphics={
        Text(
          extent={{-30,-10},{30,-70}}, 
          textColor={64,64,64}, 
          textString="A"), Line(points={{70,0},{100,0}}, color={85,170,255})}));
end MagneticPotentialSensor;