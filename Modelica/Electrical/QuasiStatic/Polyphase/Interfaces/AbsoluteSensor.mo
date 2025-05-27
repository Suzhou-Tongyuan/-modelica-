within Modelica.Electrical.QuasiStatic.Polyphase.Interfaces;
partial model AbsoluteSensor "绝对传感器"
  extends Modelica.Icons.RoundSensor;
  parameter Integer m(min=1) = 3 "相数" annotation(Evaluate=true);
  SI.AngularVelocity omega;
  PositivePlug plug_p(final m=m) 
    "正定态多相插头" annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
equation
  omega = der(plug_p.reference.gamma);
  annotation (Icon(graphics={
        Line(points={{-70,0},{-94,0}}, color={85,170,255}), 
        Text(
          extent={{150,-100},{-150,-70}}, 
          textString="m=%m"), 
        Text(
          textColor={0,0,255}, 
          extent={{-150,80},{150,120}}, 
          textString="%name")}), Documentation(info="<html>

<p>
绝对传感器部分模型依赖于
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug\">正插头</a>
来测量复电势、频率和角频率。此外，该模型包含适当的图标和对角速度的定义。
</p>

<h4>另请参阅</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.RelativeSensorElementary\">RelativeSensorElementary</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.AbsoluteSensor\">SinglePhase.Interfaces.AbsoluteSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.RelativeSensorElementary\">SinglePhase.Interfaces.RelativeSensorElementary</a>
</p>

</html>"));
end AbsoluteSensor;