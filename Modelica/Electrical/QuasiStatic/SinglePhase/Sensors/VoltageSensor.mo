within Modelica.Electrical.QuasiStatic.SinglePhase.Sensors;
model VoltageSensor "电压传感器"
  extends Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.RelativeSensorElementary;
  Modelica.ComplexBlocks.Interfaces.ComplexOutput v(re(unit = "V"), im(unit = "V")) "复电压" annotation (Placement(
        transformation(
        origin={0,-110}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270), iconTransformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={0,-110})));
  SI.Voltage abs_v=Modelica.ComplexMath.abs(v) "复电压的幅值";
  SI.Angle arg_v=Modelica.ComplexMath.arg(v) "复电压的幅角";
  SI.ComplexCurrent i "复电流";
equation
  v = pin_p.v - pin_n.v;
  i = pin_p.i;
  i = Complex(0,0);
  annotation (Documentation(info="<html>
<p>
此传感器可用于测量复电压。
</p>

<h4>另请参阅</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PowerSensor\">PowerSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.MultiSensor\">MultiSensor</a>
</p>

</html>"), 
       Icon(graphics={
        Text(
          extent={{-30,-10},{30,-70}}, 
          textColor={64,64,64}, 
          textString="V"), 
        Line(points={{-100,0},{-70,0}}, color={85,170,255}), 
        Line(points={{70,0},{100,0}},   color={85,170,255})}));
end VoltageSensor;