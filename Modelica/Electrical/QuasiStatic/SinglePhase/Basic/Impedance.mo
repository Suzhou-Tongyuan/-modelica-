within Modelica.Electrical.QuasiStatic.SinglePhase.Basic;
model Impedance "单相线性阻抗"
  extends Interfaces.OnePort;
  import Modelica.ComplexMath.j;
  import Modelica.ComplexMath.real;
  import Modelica.ComplexMath.imag;
  import Modelica.ComplexMath.conj;
  parameter SI.ComplexImpedance Z_ref(re(start=1),im(start=0)) "复阻抗 R_ref + j*X_ref";
  parameter SI.Temperature T_ref=293.15 "参考温度";
  parameter SI.LinearTemperatureCoefficient alpha_ref=0 "电阻温度系数 (R_actual = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T=T_ref);
  parameter Boolean frequencyDependent = false "是否考虑频率依赖，如果为true";
  parameter SI.Frequency f_ref = 1 "如果考虑频率依赖，则为参考频率";
  SI.Resistance R_actual "电阻 = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
  SI.Reactance X_actual "考虑可能的频率依赖的电抗";
  final parameter SI.Resistance R_ref=real(Z_ref) "阻抗的电阻成分，电阻";
  final parameter SI.Reactance X_ref=imag(Z_ref) "阻抗的反应性成分，电抗";
equation
  assert((1 + alpha_ref*(T_heatPort - T_ref)) >= Modelica.Constants.eps, 
    "温度超出模型范围！");
  R_actual = R_ref*(1 + alpha_ref*(T_heatPort - T_ref));
  X_actual = X_ref * (if not frequencyDependent then 1 else 
    (if X_ref>=0 then omega/(2*Modelica.Constants.pi*f_ref) else 2*Modelica.Constants.pi*f_ref/omega));
  v = Complex(R_actual, X_actual) * i;
  LossPower = real(v*conj(i));

  annotation (Icon(graphics={
        Line(points={{60,0},{90,0}}, color={85,170,255}), 
        Line(points={{-90,0},{-60,0}}, color={85,170,255}), 
        Rectangle(
          extent={{-70,30},{70,-30}}, 
          lineColor={85,170,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Polygon(
          points={{-70,-30},{70,30},{70,-30},{-70,-30}}, 
          lineColor={85,170,255}, 
          fillColor={85,170,255}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-150,90},{150,50}}, 
          textString="%name", 
          textColor={0,0,255})}), 
      Documentation(info="<html>

<p>阻抗模型表示电阻和电感器或电容器的串联连接。<br>
<img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/SinglePhase/Basic/RX_impedance.png\"></p>

<p>
线性阻抗通过<code><u>i</u></code>和电压<code><u>v</u></code>连接，方程为<code><u>v</u> = <u>Z</u>*<u>i</u></code>。电阻
成分受温度影响，因此实部<code>R_actual = real(<u>Z</u>)</code>是根据实际工作温度和参考输入电阻<code>real(Z_ref)</code>确定的。
考虑<a href=\"modelica://Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort\">条件热端口</a>。
反应性成分<code>X_actual = imag(<u>Z</u>)</code>
等于<code>imag(Z_ref)</code>如果<code>frequencyDependent = false</code>。
频率依赖性由<code>frequencyDependent = true</code>考虑，区分两种情况：
</p>

<dl>
<dt>(a) <code>imag(Z_ref) &gt; 0</code>: 电感情况</dt>
<dd>实际电抗<code>X_actual</code>与<code>f/f_ref</code>成正比</dd>
<dt>(b) <code>imag(Z_ref) &lt; 0</code>: 电容情况</dt>
<dd>实际电抗<code>X_actual</code>与<code>f_ref/f</code>成正比</dd>
</dl>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Resistor\">电阻</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Conductor\">导体</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Capacitor\">电容器</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Admittance\">导纳</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableResistor\">可变电阻</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableConductor\">可变导体</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableCapacitor\">可变电容器</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableInductor\">可变电感器</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableImpedance\">可变阻抗</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableAdmittance\">可变导纳</a>
</p>
</html>"));
end Impedance;