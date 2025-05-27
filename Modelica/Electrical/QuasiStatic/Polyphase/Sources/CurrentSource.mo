within Modelica.Electrical.QuasiStatic.Polyphase.Sources;
model CurrentSource "恒定多相交流电流源"
  extends Interfaces.Source;
  import Modelica.ComplexMath.j;
  import Modelica.ComplexMath.exp;
  parameter SI.Frequency f(start=1) "源的频率";
  parameter SI.Current I[m](start=fill(1, m)) 
    "源的有效值电流";
  parameter SI.Angle phi[m]=-
      Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m) 
    "源的相位移";
equation
  omega = 2*Modelica.Constants.pi*f;
  i = {I[k]*exp(j*phi[k]) for k in 1:m};
  annotation (
    Icon(graphics={Line(points={{0,50},{0,-50}}, color={85,170,255}), 
          Polygon(
          points={{90,0},{60,10},{60,-10},{90,0}}, 
          lineColor={85,170,255}, 
          fillColor={85,170,255}, 
          fillPattern=FillPattern.Solid)}), Documentation(info="<html>

<p>
该模型描述了 <em>m</em> 个恒定电流源，通过有效值电流和相位移来指定复电流。
默认为<a href=\"modelica://Modelica.Electrical.Polyphase.Functions.symmetricOrientation\">-symmetricOrientation</a>。
使用了 <em>m</em> 个<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.CurrentSource\">单相CurrentSources</a>。
</p>

<h4>另请参阅</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.CurrentSource\">SinglePhase.CurrentSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sources.VariableCurrentSource\">VariableCurrentSource</a>
</p>
</html>"));
end CurrentSource;