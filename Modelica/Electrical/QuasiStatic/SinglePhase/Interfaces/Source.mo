within Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces;
partial model Source "局部电压/电流源"
  extends OnePort;
  SI.Angle gamma(start=0) = pin_p.reference.gamma;
equation
  Connections.root(pin_p.reference);
  annotation (Icon(graphics={
        Ellipse(
          extent={{-50,50},{50,-50}}, 
          lineColor={85,170,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{150,60},{-150,100}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Line(points={{-90,0},{-50,0}}, color={85,170,255}), 
        Line(points={{50,0},{90,0}}, color={85,170,255})}), 
                                        Documentation(info="<html>
<p>
该源部分模型依赖于
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.OnePort\">OnePort</a> 并包含适当的图标。
</p>

<h4>另请参阅</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VoltageSource\">电压源</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VariableVoltageSource\">可变电压源</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.CurrentSource\">电流源</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VariableCurrentSource\">可变电流源</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.Source\">多相界面源</a>.
</p>
</html>"));
end Source;