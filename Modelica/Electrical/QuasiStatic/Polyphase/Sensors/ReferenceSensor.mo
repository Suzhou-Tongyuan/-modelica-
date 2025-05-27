within Modelica.Electrical.QuasiStatic.Polyphase.Sensors;
model ReferenceSensor "参考角度传感器"
  extends QuasiStatic.Polyphase.Interfaces.AbsoluteSensor;
  Modelica.Blocks.Interfaces.RealOutput gamma "参考角度" annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  gamma = plug_p.reference.gamma;
  plug_p.pin.i = fill(Complex(0), m);
  annotation (Documentation(info="<html>
<p>
该传感器可用于测量参考角度。
</p>

<h4>另请参阅</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.ReferenceSensor\">单相传感器的参考角度</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.FrequencySensor\">频率传感器</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.PotentialSensor\">电位传感器</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.VoltageSensor\">电压传感器</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.VoltageQuasiRMSSensor\">电压准有效值传感器</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.CurrentSensor\">电流传感器</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.CurrentQuasiRMSSensor\">电流准有效值传感器</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.PowerSensor\">功率传感器</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.MultiSensor\">多功能传感器</a>
</p>

</html>"), 
       Icon(graphics={
        Text(
          extent={{-30,-10},{30,-70}}, 
          textColor={64,64,64}, 
          textString="弧度"), Line(points={{70,0},{100,0}}, color={0,0,127})}));
end ReferenceSensor;