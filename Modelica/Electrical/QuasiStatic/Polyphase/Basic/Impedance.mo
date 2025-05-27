within Modelica.Electrical.QuasiStatic.Polyphase.Basic;
model Impedance "多相线性阻抗"
  extends Interfaces.TwoPlug;
  parameter SI.ComplexImpedance Z_ref[m](re(start=fill(1,m)),im(start=fill(0,m))) 
    "复阻抗 R_ref + j*X_ref";
  parameter SI.Temperature T_ref[m]=fill(293.15, m) 
    "参考温度";
  parameter SI.LinearTemperatureCoefficient alpha_ref[m]=zeros(m) 
    "电阻温度系数 (R_actual = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
  extends Modelica.Electrical.Polyphase.Interfaces.ConditionalHeatPort(final mh=m, T=T_ref);
  parameter Boolean frequencyDependent = false "考虑频率依赖性时为真" 
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Frequency f_ref = 1 "如果考虑频率依赖性，则为参考频率" 
    annotation(Dialog(enable=frequencyDependent));
  QuasiStatic.SinglePhase.Basic.Impedance impedance[m](
    final Z_ref=Z_ref, 
    final T_ref=T_ref, 
    final alpha_ref=alpha_ref, 
    final useHeatPort=fill(useHeatPort, m), 
    final frequencyDependent=fill(frequencyDependent, m), 
    final f_ref=fill(f_ref, m), 
    final T=T_ref) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(plugToPins_p.pin_p, impedance.pin_p) annotation (Line(points={{-68,0},{-53.5,0},{-39,0},{-10,0}}, color={85,170,255}));
  connect(impedance.pin_n, plugToPins_n.pin_n) annotation (Line(points={{10,0},{39,0},{68,0}}, color={85,170,255}));
  connect(impedance.heatPort, heatPort) annotation (Line(points={{0,-10},{0,-10},{0,-100}}, color={191,0,0}));
  annotation (Icon(graphics={
                Text(
              extent={{150,-80},{-150,-40}}, 
              textString="m=%m"), Line(points={{60,0},{90,0}}, color={85,170,255}), 
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
          textColor={0,0,255})}), Documentation(info="<html>
<p>阻抗模型表示每相的电阻和电感器或电容器的<strong>串联</strong>连接。<br>
<img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/SinglePhase/Basic/RX_impedance.png\"></p>

<p>
线性阻抗通过 <code><u>v</u> = <u>Z</u>*<u>i</u></code> 将电压 <code><u>v</u></code> 和电流 <code><u>i</u></code> 连接起来，在每个相中，使用 <code>m</code>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Impedance\">单相阻抗</a>。
电阻的组件被建模为温度相关，所以实部 <code>R_actual = real(<u>Z</u>)</code> 由实际工作温度和参考输入电阻 <code>real(Z_ref)</code> 确定。
<a href=\"modelica://Modelica.Electrical.Polyphase.Interfaces.ConditionalHeatPort\">条件热端口</a> 被考虑。
如果 <code>frequencyDependent = false</code>，则反应性的组件 <code>X_actual = imag(<u>Z</u>)</code>
等于 <code>imag(Z_ref)</code>。
通过 <code>frequencyDependent = true</code> 考虑频率依赖性，区分两种情况：
</p>

<dl>
<dt>(a) <code>imag(Z_ref) &gt; 0</code>: 电感情况</dt>
<dd>实际的反应性组件 <code>X_actual</code> 与 <code>f/f_ref</code> 成正比</dd>
<dt>(b) <code>imag(Z_ref) &lt; 0</code>: 电容情况</dt>
<dd>实际的反应性组件 <code>X_actual</code> 与 <code>f_ref/f</code> 成正比</dd>
</dl>

<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Capacitor\">Capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Inductor\">Inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Admittance\">Admittance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableResistor\">Variable resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableConductor\">Variable conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableCapacitor\">Variable capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableInductor\">Variable inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableImpedance\">Variable impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
end Impedance;