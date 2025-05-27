within Modelica.Electrical.QuasiStatic.SinglePhase.Sensors;
model PotentialSensor "电位传感器"
  extends Interfaces.AbsoluteSensor;
  Modelica.ComplexBlocks.Interfaces.ComplexOutput v "复电势" 
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  SI.Voltage abs_v=Modelica.ComplexMath.abs(v) "复电势的幅值";
  SI.Angle arg_v=Modelica.ComplexMath.arg(v) "复电势的幅角";
equation
  v = pin.v;
  annotation (Documentation(info="<html>

<p>
此传感器可用于测量复电势。
</p>

<h4>另请参阅</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PowerSensor\">PowerSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.MultiSensor\">MultiSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.MultiSensor\">MultiSensor</a>
</p>

</html>"), 
       Icon(graphics={
        Text(
          extent={{-30,-10},{30,-70}}, 
          textColor={64,64,64}, 
          textString="V"), 
        Line(points={{100,0},{70,0}}, color={85,170,255})}));
end PotentialSensor;