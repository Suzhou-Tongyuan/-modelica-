within Modelica.Electrical.QuasiStatic.Polyphase.Sensors;
model PotentialSensor "电位传感器"
  extends Interfaces.AbsoluteSensor;
  QuasiStatic.SinglePhase.Sensors.PotentialSensor potentialSensor[m] 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Basic.PlugToPins_p plugToPins_p(final m=m) annotation (Placement(
        transformation(extent={{-80,-10},{-60,10}})));
  Modelica.ComplexBlocks.Interfaces.ComplexOutput v[m] "复数输出信号的电势" 
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  SI.Voltage abs_v[m]=Modelica.ComplexMath.abs(v) 
    "复数电势的幅值";
  SI.Angle arg_v[m]=Modelica.ComplexMath.arg(v) 
    "复数电势的参数";

equation
  connect(potentialSensor.v,v)  annotation (Line(points={{11,0},{35.75,0},{
          35.75,0},{60.5,0},{60.5,0},{110,0}}, color={85,170,255}));
  connect(plug_p, plugToPins_p.plug_p) annotation (Line(
      points={{-100,0},{-72,0}}, color={85,170,255}));
  connect(plugToPins_p.pin_p, potentialSensor.pin) annotation (Line(
      points={{-68,0},{-10,0}}, color={85,170,255}));
  annotation (Documentation(info="<html>

<p>
这个传感器可用于测量 <em>m</em> 个复数电势，使用 <em>m</em>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PotentialSensor\">单相电势传感器</a>。
</p>

<h4>另请参阅</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PotentialSensor\">SinglePhase.Sensors.PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.VoltageQuasiRMSSensor\">VoltageQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.CurrentQuasiRMSSensor\">CurrentQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.PowerSensor\">PowerSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.MultiSensor\">MultiSensor</a>
</p>

</html>"), 
       Icon(graphics={
        Text(
          extent={{-30,-10},{30,-70}}, 
          textColor={64,64,64}, 
          textString="V"), Line(points={{70,0},{100,0}}, color={85,170,255})}));
end PotentialSensor;