within Modelica.Electrical.QuasiStatic.SinglePhase.Basic;
model Resistor "单相线性电阻"
  extends Interfaces.OnePort;
  import Modelica.ComplexMath.real;
  import Modelica.ComplexMath.conj;
  parameter SI.Resistance R_ref(start=1) "参考温度下的电阻";
  parameter SI.Temperature T_ref=293.15 "参考温度";
  parameter SI.LinearTemperatureCoefficient alpha_ref=0 "电阻温度系数 (R_actual = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T=T_ref);
  SI.Resistance R_actual "电阻 = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
equation
  assert((1 + alpha_ref*(T_heatPort - T_ref)) >= Modelica.Constants.eps, 
    "模型范围外的温度！");
  R_actual = R_ref*(1 + alpha_ref*(T_heatPort - T_ref));
  v = R_actual*i;
  LossPower = real(v*conj(i));
  annotation (Icon(graphics={
        Line(points={{60,0},{90,0}}, color={85,170,255}), 
        Line(points={{-90,0},{-60,0}}, color={85,170,255}), 
        Rectangle(
          extent={{-70,30},{70,-30}}, 
          lineColor={85,170,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Text(extent={{150,-40},{-150,-80}}, textString="R=%R_ref"), 
        Text(
          extent={{-150,90},{150,50}}, 
          textString="%name", 
          textColor={0,0,255})}), 
      Documentation(info="<html>
<p>
线性电阻通过复电压<code><u>v</u></code>与复电流<code><u>i</u></code>连接，<code><u>i</u>*R = <u>v</u></code>。
电阻<code>R</code>允许为正、零或负。
</p>

<p>
电阻模型还具有可选的
<a href=\"modelica://Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort\">条件热口</a>。
还考虑了电阻的线性温度依赖性。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Capacitor\">Capacitor</a>,
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
end Resistor;