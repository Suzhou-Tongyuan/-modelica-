within Modelica.Electrical.QuasiStatic.SinglePhase.Basic;
model Conductor "单相线性电导"
  extends Interfaces.OnePort;
  import Modelica.ComplexMath.real;
  import Modelica.ComplexMath.conj;
  parameter SI.Conductance G_ref(start=1) "在 T_ref 下的参考导纳";
  parameter SI.Temperature T_ref=293.15 "参考温度";
  parameter SI.LinearTemperatureCoefficient alpha_ref=0 "导纳的温度系数 (G_actual = G_ref/(1 + alpha_ref*(heatPort.T - T_ref))";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T=T_ref);
  SI.Conductance G_actual "导纳 = G_ref/(1 + alpha_ref*(heatPort.T - T_ref))";
equation
  assert((1 + alpha_ref*(T_heatPort - T_ref)) >= Modelica.Constants.eps, 
    "模型范围之外的温度!");
  G_actual = G_ref/(1 + alpha_ref*(T_heatPort - T_ref));
  i = G_actual*v;
  LossPower = real(v*conj(i));
  annotation (Icon(graphics={
        Line(points={{60,0},{90,0}}, color={85,170,255}), 
        Line(points={{-90,0},{-60,0}}, color={85,170,255}), 
        Rectangle(
          extent={{-70,30},{70,-30}}, 
          lineColor={85,170,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Text(extent={{150,-40},{-150,-80}}, textString="G=%G_ref"), 
        Text(
          extent={{-150,90},{150,50}}, 
          textString="%name", 
          textColor={0,0,255})}), 
      Documentation(info="<html>

<p>
线性导体通过 <code><u>v</u></code> 连接电压和
电流 <code><u>i</u></code> 由 <code><u>i</u> = <u>v</u>*G</code>确定。
导纳 <code>G</code> 可以是正数、零或负数。
</p>

<p>
导体模型还有一个可选的
<a href=\"modelica://Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort\">条件热端口</a>。
导纳的线性温度依赖性也被考虑在内。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Resistor\">电阻</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Capacitor\">电容</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Inductor\">电感</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Impedance\">阻抗</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Admittance\">导纳</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableResistor\">可变电阻</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableConductor\">可变导体</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableCapacitor\">可变电容</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableInductor\">可变电感</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableImpedance\">可变阻抗</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableAdmittance\">可变导纳</a>
</p>
</html>"));
end Conductor;