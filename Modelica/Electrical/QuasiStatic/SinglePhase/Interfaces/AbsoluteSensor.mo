within Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces;
partial model AbsoluteSensor "绝对传感器"
  extends Modelica.Icons.RoundSensor;
  SI.AngularVelocity omega;
  PositivePin pin "正电势静态单相引脚" annotation (Placement(transformation(extent={{-110, 
            -10},{-90,10}})));
equation
  omega = der(pin.reference.gamma);
  pin.i = Complex(0);
  annotation (Icon(graphics={
        Line(points={{-70,0},{-94,0}}, color={85,170,255}), 
        Text(
          extent={{-150,120},{150,80}}, 
          textColor={0,0,255}, 
          textString="%name")}),         Documentation(info="<html>
<p>
绝对传感器部分模型提供一个
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.PositivePin\">正引脚</a>
用于测量复电压、频率和角频率。此外，该模型包含适当的图标和对角速度的定义。
</p>

<h4>另请参阅</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.RelativeSensorElementary\">相对传感器元件</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PotentialSensor\">电势传感器</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.AbsoluteSensor\">多相界面绝对传感器</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.RelativeSensorElementary\">多相界面相对传感器元件</a>
</p>

</html>"));
end AbsoluteSensor;