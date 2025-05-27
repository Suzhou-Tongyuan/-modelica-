within Modelica.Electrical.QuasiStatic.SinglePhase.Basic;
model VariableAdmittance "单相可变导纳"
  extends Interfaces.OnePort;
  import Modelica.ComplexMath.real;
  import Modelica.ComplexMath.imag;
  import Modelica.ComplexMath.conj;
  parameter SI.Temperature T_ref=293.15 "参考温度";
  parameter SI.LinearTemperatureCoefficient alpha_ref=0 "电阻温度系数 (R_actual = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T=T_ref);
  Modelica.ComplexBlocks.Interfaces.ComplexInput Y_ref "可变复导纳" 
    annotation (Placement(transformation(
        origin={0,120}, 
        extent={{-20,-20},{20,20}}, 
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}}, 
        rotation=270, 
        origin={0,120})));
  parameter Boolean frequencyDependent = false "如果为真，则考虑频率依赖性" 
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Frequency f_ref = 1 "如果考虑频率依赖性，则为参考频率" 
    annotation(Dialog(enable=frequencyDependent));
  SI.Conductance G_actual "电阻 = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
  SI.Susceptance B_actual "考虑可能的频率依赖性的导纳";
  SI.Conductance G_ref=real(Y_ref) "导纳的电阻性成分";
  SI.Susceptance B_ref=imag(Y_ref) "导纳的反应性成分";
equation
  assert((1 + alpha_ref*(T_heatPort - T_ref)) >= Modelica.Constants.eps, 
    "模型温度超出范围!");
  G_actual = G_ref/(1 + alpha_ref*(T_heatPort - T_ref));
  B_actual = B_ref * (if not frequencyDependent then 1 else 
    (if B_ref>=0 then omega/(2*Modelica.Constants.pi*f_ref) else 2*Modelica.Constants.pi*f_ref/omega));
  i = Complex(G_actual, B_actual) * v;
  LossPower = real(v*conj(i));
  annotation (defaultComponentName="admittance", 
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={
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

<p>导纳模型表示导体和电容器或电感器的<strong>并联</strong>连接。<br>
<img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/SinglePhase/Basic/GB_admittance.png\"></p>

<p>
线性导纳通过 <code><u>v</u>*<u>Y</u> = <u>i</u></code> 将复电压 <code><u>v</u></code> 与复电流 <code><u>i</u></code> 连接。
导纳 <code>Y_ref = G_ref + j*B_ref</code> 给出为复输入信号，表示输入导纳的电阻和反应性成分。电阻性成分模拟为温度依赖，因此实部 <code>G_actual = real(<u>Y</u>)</code> 由实际操作温度和参考输入电导率 <code>real(Y_ref)</code> 确定。
反应性成分 <code>B_actual = imag(<u>Y</u>)</code>
如果 <code>frequencyDependent = false</code>，则等于 <code>imag(Y_ref)</code>。
通过 <code>frequencyDependent = true</code> 考虑频率依赖性，区分两种情况：
</p>

<dl>
<dt>(a) <code>imag(Y_ref) &gt; 0</code>: 电容情况</dt>
<dd>实际电导的反应性成分 <code>B_actual</code> 与 <code>f/f_ref</code> 成比例</dd>
<dt>(b) <code>imag(Y_ref) &lt; 0</code>: 电感情况</dt>
<dd>实际电导的反应性成分 <code>B_actual</code> 与 <code>f_ref/f</code> 成比例</dd>
</dl>

<h4>注意</h4>
<p>
导纳信号 <code>Y_ref</code> 的实部或虚部的零点可能会导致由于连接网络的实际结构而导致奇异性。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Capacitor\">Capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Inductor\">Inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Admittance\">Admittance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableResistor\">Variable resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableConductor\">Variable conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableCapacitor\">Variable capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableInductor\">Variable inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableImpedance\">Variable impedance</a>
</p>
</html>"));
end VariableAdmittance;