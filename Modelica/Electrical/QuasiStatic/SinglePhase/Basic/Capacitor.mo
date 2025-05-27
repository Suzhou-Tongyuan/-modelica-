within Modelica.Electrical.QuasiStatic.SinglePhase.Basic;
model Capacitor "单相线性电容"
  extends Interfaces.OnePort;
  import Modelica.ComplexMath.j;
  parameter SI.Capacitance C(start=1) "电容";
equation
  i = j*omega*C*v;
  annotation (Icon(graphics={
        Text(extent={{150,-40},{-150,-80}}, textString="C=%C"), 
        Text(
          extent={{-150,90},{150,50}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Line(
          points={{-6,28},{-6,-28}}, 
          color={85,170,255}), 
        Line(
          points={{6,28},{6,-28}}, 
          color={85,170,255}), 
                             Line(points={{-90,0},{-6,0}}, color={85,170,255}), 
                Line(points={{6,0},{90,0}}, color={85,170,255})}), 
      Documentation(info="<html>

<p>
线性电容器通过电压<code><u>v</u></code>与电流<code><u>i</u></code>连接，<code><u>i</u> = j*&omega;*C*<u>v</u></code>。
电容<code>C</code>允许为正、零或负。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Inductor\">Inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Admittance\">Admittance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableResistor\">Variable resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableConductor\">Variable conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableCapacitor\">Variable capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableInductor\">Variable inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableImpedance\">Variable impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
end Capacitor;