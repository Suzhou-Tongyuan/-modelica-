within Modelica.Electrical.QuasiStatic.Polyphase.Interfaces;
partial model Source "电压源/电流源的基类模型"
  extends OnePort;
  constant SI.Angle pi=Modelica.Constants.pi;
  SI.Angle gamma(start=0) = plug_p.reference.gamma;
equation
  Connections.root(plug_p.reference);
  annotation (
    Icon(graphics={Ellipse(
              extent={{-50,50},{50,-50}}, 
              lineColor={85,170,255}, 
              fillColor={255,255,255}, 
              fillPattern=FillPattern.Solid), 
        Line(points={{-90,0},{-50,0}}, color={85,170,255}), 
        Line(points={{50,0},{90,0}}, color={85,170,255}), 
        Text(
          extent={{160,-100},{-160,-60}}, 
          textString="m=%m"), 
                           Text(
              extent={{-150,60},{150,100}}, 
              textString="%name", 
              textColor={0,0,255})}), 
    Documentation(info="<html>
<p>
该源部分模型依赖于
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.TwoPlug\">双插头</a>，并包含适当的图标。
</p>

<h4>另请参阅</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sources.CurrentSource\">CurrentSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sources.VariableCurrentSource\">VariableCurrentSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.Source\">SinglePhase.Interfaces.Source</a>.
</p>
</html>"));
end Source;