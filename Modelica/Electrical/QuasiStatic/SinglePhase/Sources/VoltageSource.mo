within Modelica.Electrical.QuasiStatic.SinglePhase.Sources;
model VoltageSource "恒定交流电压源"
  extends Interfaces.Source;
  parameter SI.Frequency f(start=1) "电压源的频率";
  parameter SI.Voltage V(start=1) "电压源的有效值电压";
  parameter SI.Angle phi(start=0) "电压源的相位移";
equation
  omega = 2*Modelica.Constants.pi*f;
  v = Complex(V*cos(phi), V*sin(phi));
  annotation (Icon(graphics={
        Line(points={{-50,0},{50,0}}, color={85,170,255}), 
        Line(points={{-70,30},{-70,10}}, color={85,170,255}), 
        Line(points={{-80,20},{-60,20}}, color={85,170,255}), 
        Line(points={{60,20},{80,20}}, color={85,170,255})}), 
                                         Documentation(info="<html>

<p>
这是一个恒定电压源，通过有效值电压和相位移指定复电压。
</p>

<h4>另请参阅</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.CurrentSource\">CurrentSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VariableCurrentSource\">VariableCurrentSource</a>
</p>
</html>"));
end VoltageSource;