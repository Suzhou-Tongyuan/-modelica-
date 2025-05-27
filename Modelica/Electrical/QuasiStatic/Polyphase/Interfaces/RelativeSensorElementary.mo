within Modelica.Electrical.QuasiStatic.Polyphase.Interfaces;
partial model RelativeSensorElementary "基本偏压/偏流传感器"
  extends Modelica.Icons.RoundSensor;
  extends TwoPlugElementary;
  annotation (Icon(graphics={
        Line(points={{-70,0},{-94,0}}, color={85,170,255}), 
        Line(points={{70,0},{94,0}}, color={85,170,255}), 
        Line(points={{0,-70},{0,-80},{0,-90},{0,-100}}, color={85,170,255}), 
        Text(
          extent={{150,-100},{-150,-70}}, 
          textString="m=%m"), 
        Text(
          textColor={0,0,255}, 
          extent={{-150,80},{150,120}}, 
          textString="%name")}), Documentation(info="<html>
<p>
相对传感器部分模型依赖于
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.TwoPlug\">双插头</a> 来测量复电压、电流或功率。此外，该模型包含适当的图标和对角速度的定义。
</p>

<h4>另请参阅</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.AbsoluteSensor\">AbsoluteSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.AbsoluteSensor\">SinglePhase.Interfaces.AbsoluteSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.RelativeSensorElementary\">SinglePhase.Interfaces.RelativeSensorElementary</a>
</p>

</html>"));

end RelativeSensorElementary;