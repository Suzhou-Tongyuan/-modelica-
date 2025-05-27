within Modelica.Electrical.QuasiStatic.Polyphase.Sensors;
model CurrentQuasiRMSSensor 
  "用于多相系统的连续准均方根电流传感器"
  extends Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.RelativeSensorElementary;

  parameter Integer m(min=1) = 3 "相数" annotation(Evaluate=true);
  Modelica.Blocks.Interfaces.RealOutput I(unit="A") 
    "电流的连续准均方根值" annotation (Placement(
        transformation(
        origin={0,-100}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270), iconTransformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={0,-110})));
  QuasiStatic.SinglePhase.Sensors.CurrentSensor currentSensor[m] 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  QuasiStatic.Polyphase.Blocks.QuasiRMS quasiRMS(final m=m) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={0,-50})));
  SI.ComplexVoltage v[m] = plug_p.pin.v - plug_n.pin.v "复电压";
  SI.ComplexCurrent i[m] = plug_p.pin.i "复电流";
equation
  connect(quasiRMS.y, I) annotation (Line(
      points={{0,-61},{0,-100}}, color={0,0,127}));
  connect(plugToPins_p.pin_p, currentSensor.pin_p) annotation (Line(
      points={{-68,0},{-10,0}}, color={85,170,255}));
  connect(currentSensor.pin_n, plugToPins_n.pin_n) annotation (Line(
      points={{10,0},{68,0}}, color={85,170,255}));
  connect(currentSensor.i, quasiRMS.u) annotation (Line(
      points={{0,-11},{0,-38}}, color={85,170,255}));
  annotation (defaultComponentName="currentRMSSensor", 
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={
        Line(points={{0,-70},{0,-100}}, color={0,0,127}), 
        Text(
          extent={{-30,-10},{30,-70}}, 
          textColor={64,64,64}, 
          textString="A"), 
        Line(points={{100,0},{-100,0}},color={85,170,255})}), 
    Documentation(revisions="<html>
</html>", 
      info="<html>
<p>
该传感器通过对相电流相量<i>进行平均，确定多相电流系统的连续准均方根值。
</p>
<pre>
  I = sum({abs(i[k]) for k in 1:m})/m
</pre>

<h4>另请参阅</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.VoltageQuasiRMSSensor\">VoltageQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.PowerSensor\">PowerSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.MultiSensor\">MultiSensor</a>
</p>
</html>"));
end CurrentQuasiRMSSensor;