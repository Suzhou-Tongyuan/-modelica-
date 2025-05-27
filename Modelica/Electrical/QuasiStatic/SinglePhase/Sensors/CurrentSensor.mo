within Modelica.Electrical.QuasiStatic.SinglePhase.Sensors;
model CurrentSensor "电流传感器"
  extends Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.RelativeSensorElementary; // 继承相对传感器元件接口
  Modelica.ComplexBlocks.Interfaces.ComplexOutput i(re(unit = "A"), im(unit = "A")) "复电流" annotation (Placement(
        transformation(
        origin={0,-110}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270), iconTransformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={0,-110}))); // 复电流输出端口，单位为安培
  SI.Current abs_i=Modelica.ComplexMath.abs(i) "复电流的幅值"; // 复电流的幅值
  SI.Angle arg_i=Modelica.ComplexMath.arg(i) "复电流的幅角"; // 复电流的幅角
  SI.ComplexVoltage v "复电压"; // 复电压
equation
  i = pin_p.i; // 电流等于正极端口电流
  v = pin_p.v - pin_n.v; // 电压等于正极电压减去负极电压
  v = Complex(0,0); // 复电压为0
  annotation (Documentation(info="<html>
<p>
该传感器可用于测量复电流。
</p>

<h4>另请参见</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PowerSensor\">PowerSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.MultiSensor\">MultiSensor</a>
</p>

</html>"), 
       Icon(graphics={
        Text(
          extent={{-30,-10},{30,-70}}, 
          textColor={64,64,64}, 
          textString="A"), 
        Line(points={{-70,0},{70,0}},   color={85,170,255})}));
end CurrentSensor;