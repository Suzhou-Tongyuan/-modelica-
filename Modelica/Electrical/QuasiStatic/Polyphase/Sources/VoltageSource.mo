within Modelica.Electrical.QuasiStatic.Polyphase.Sources;
model VoltageSource "恒定多相交流电压源"
  extends Interfaces.Source;
  import Modelica.ComplexMath.j;
  import Modelica.ComplexMath.exp;
  parameter SI.Frequency f(start=1) "源的频率";
  parameter SI.Voltage V[m](start=fill(1, m)) 
    "源的有效值电压";
  parameter SI.Angle phi[m]=-
      Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m) 
    "源的相位移";
equation
  omega = 2*Modelica.Constants.pi*f;
  v = {V[k]*exp(j*phi[k]) for k in 1:m};
  annotation (
    Icon(graphics={
        Line(points={{-50,0},{50,0}}, color={85,170,255}), 
        Line(points={{-70,30},{-70,10}}, color={85,170,255}), 
        Line(points={{-80,20},{-60,20}}, color={85,170,255}), 
        Line(points={{60,20},{80,20}}, color={85,170,255})}), 
    Documentation(info="<html>

<p>
该模型描述了 <em>m</em> 个恒定电压源，通过有效值电压和相位移来指定复电压
（默认为<a href=\"modelica://Modelica.Electrical.Polyphase.Functions.symmetricOrientation\">-symmetricOrientation</a>）。
使用了 <em>m</em> 个<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VoltageSource\">单相VoltageSources</a>。
</p>

<h4>另请参阅</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VoltageSource\">SinglePhase.VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sources.CurrentSource\">CurrentSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sources.VariableCurrentSource\">VariableCurrentSource</a>
</p>
</html>"));
end VoltageSource;