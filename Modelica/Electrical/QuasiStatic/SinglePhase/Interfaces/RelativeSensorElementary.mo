within Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces;
partial model RelativeSensorElementary "基本局部电压/电流传感器"
  extends Modelica.Icons.RoundSensor;
  extends TwoPinElementary;

equation
  Complex(0,0) = pin_p.i + pin_n.i "电流平衡";

  annotation (Icon(graphics={
        Line(points={{-70,0},{-94,0}}, color={85,170,255}), 
        Line(points={{70,0},{94,0}}, color={85,170,255}), 
        Text(
          extent={{-150,120},{150,80}}, 
          textColor={0,0,255}, 
          textString="%name"), 
        Line(points={{0,-100},{0,-70}}, color={85,170,255})}), 
      Documentation(info="<html>
<p>
相对传感器部分模型依赖于
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.TwoPinElementary\">TwoPinElementary</a>
来测量复电压或电流。此外，该模型包含适当的图标和对角速度的定义。
</p>

<h4>另请参阅</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.AbsoluteSensor\">绝对传感器</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.VoltageSensor\">电压传感器</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.CurrentSensor\">电流传感器</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PowerSensor\">功率传感器</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.AbsoluteSensor\">多相界面绝对传感器</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.RelativeSensorElementary\">多相界面相对传感器元件</a>
</p>

</html>"));
end RelativeSensorElementary;