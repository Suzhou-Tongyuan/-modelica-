within Modelica.Electrical.QuasiStatic.SinglePhase.Sources;
model CurrentSource "恒定交流电流"
  extends Interfaces.Source;
  parameter SI.Frequency f(start=1) "源的频率";
  parameter SI.Current I(start=1) "源的有效值电流";
  parameter SI.Angle phi(start=0) "源的相位偏移";
equation
  omega = 2*Modelica.Constants.pi*f;
  i = Complex(I*cos(phi), I*sin(phi));
  annotation (
    Icon(graphics={
        Polygon(
          points={{90,0},{60,10},{60,-10},{90,0}}, 
          lineColor={85,170,255}, 
          fillColor={85,170,255}, 
          fillPattern=FillPattern.Solid), Line(points={{0,50},{0,-50}}, color={85,170,255})}), 
                                            Documentation(info="<html>

<p>
这是一个恒定电流源，通过有效值电流和相位偏移指定复电流。
</p>

<h4>参见</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VariableCurrentSource\">VariableCurrentSource</a>
</p>
</html>"));
end CurrentSource;