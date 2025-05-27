within Modelica.Electrical.QuasiStatic.SinglePhase.Basic;
model Admittance "单相线性导纳"
  extends Interfaces.OnePort;
  import Modelica.ComplexMath.j;
  import Modelica.ComplexMath.real;
  import Modelica.ComplexMath.imag;
  import Modelica.ComplexMath.conj;
  parameter SI.ComplexAdmittance Y_ref(re(start=1),im(start=0)) "复导纳 G_ref + j*B_ref";
  parameter SI.Temperature T_ref=293.15 "参考温度";
  parameter SI.LinearTemperatureCoefficient alpha_ref=0 "电阻的温度系数 (R_actual = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T=T_ref);
  parameter Boolean frequencyDependent = false "如果为真，则考虑频率依赖性" 
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Frequency f_ref = 1 "如果考虑频率依赖性，则为参考频率" 
    annotation(Dialog(enable=frequencyDependent));
  SI.Conductance G_actual "电阻 = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
  SI.Susceptance B_actual "考虑可能的频率依赖性的感抗";
  final parameter SI.Conductance G_ref=real(Y_ref) "导纳的电阻性分量";
  final parameter SI.Susceptance B_ref=imag(Y_ref) "感抗的虚部分量";
equation
  assert((1 + alpha_ref*(T_heatPort - T_ref)) >= Modelica.Constants.eps, 
    "模型范围之外的温度!");
  G_actual = G_ref/(1 + alpha_ref*(T_heatPort - T_ref));
  B_actual = B_ref * (if not frequencyDependent then 1 else 
    (if B_ref>=0 then omega/(2*Modelica.Constants.pi*f_ref) else 2*Modelica.Constants.pi*f_ref/omega));
  i = Complex(G_actual, B_actual) * v;
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

<p>导纳模型表示导体和电容或电感的<strong>并联</strong>连接。<br>
<img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/SinglePhase/Basic/GB_admittance.png\"></p>

<p>
线性导纳通过 <code><u>v</u></code> 连接电压和
电流 <code><u>i</u></code> 由 <code><u>i</u> = <u>Y</u>*<u>v</u></code> 确定。
电阻性部分模拟温度依赖性，因此实部 <code>G_actual = real(<u>Y</u>)</code> 是根据
实际工作温度和参考输入导纳 <code>real(Y_ref)</code> 确定的。
考虑<a href=\"modelica://Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort\">条件热端口</a>。
感抗部分 <code>B_actual = imag(<u>Y</u>)</code>
如果 <code>frequencyDependent = false</code> 则等于 <code>imag(Y_ref)</code>。
通过 <code>frequencyDependent = true</code> 考虑频率依赖性，区分两种情况：
</p>

<dl>
<dt>(a) <code>imag(Y_ref) &gt; 0</code>: 电容情况</dt>
<dd>实际感抗 <code>B_actual</code> 与 <code>f/f_ref</code> 成正比</dd>
<dt>(b) <code>imag(Y_ref) &lt; 0</code>: 电感情况</dt>
<dd>实际感抗 <code>B_actual</code> 与 <code>f_ref/f</code> 成正比</dd>
</dl>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Resistor\">电阻</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Conductor\">导体</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Capacitor\">电容</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Impedance\">阻抗</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableResistor\">可变电阻</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableConductor\">可变导体</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableCapacitor\">可变电容</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableInductor\">可变电感</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableImpedance\">可变阻抗</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableAdmittance\">可变导纳</a>
</p>
</html>"));
end Admittance;