within Modelica.Electrical.QuasiStatic.SinglePhase.Basic;
model VariableImpedance "单相可变阻抗"
  extends Interfaces.OnePort;
  import Modelica.ComplexMath.real;
  import Modelica.ComplexMath.imag;
  import Modelica.ComplexMath.conj;
  parameter SI.Temperature T_ref=293.15 "参考温度";
  parameter SI.LinearTemperatureCoefficient alpha_ref=0 "电阻的温度系数 (R_actual = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T=T_ref);
  Modelica.ComplexBlocks.Interfaces.ComplexInput Z_ref "可变复阻抗" 
    annotation (Placement(transformation(
        origin={0,120}, 
        extent={{-20,-20},{20,20}}, 
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}}, 
        rotation=270, 
        origin={0,120})));
  parameter Boolean frequencyDependent = false "如果为真，考虑频率依赖性" 
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Frequency f_ref = 1 "参考频率，如果考虑频率依赖性" 
    annotation(Dialog(enable=frequencyDependent));
  SI.Resistance R_actual "电阻 = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
  SI.Reactance X_actual "考虑可能的频率依赖性的反应";
  SI.Resistance R_ref=real(Z_ref) "阻抗的电阻性分量，电阻";
  SI.Reactance X_ref=imag(Z_ref) "阻抗的反应性分量，电抗";
equation
  assert((1 + alpha_ref*(T_heatPort - T_ref)) >= Modelica.Constants.eps, 
    "模型范围外的温度！");
  R_actual = R_ref*(1 + alpha_ref*(T_heatPort - T_ref));
  X_actual = X_ref * (if not frequencyDependent then 1 else 
    (if X_ref>=0 then omega/(2*Modelica.Constants.pi*f_ref) else 2*Modelica.Constants.pi*f_ref/omega));
  v = Complex(R_actual, X_actual) * i;
  LossPower = real(v*conj(i));
  annotation (defaultComponentName="impedance", 
    Icon(graphics={
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

<p>阻抗模型表示电阻和电感或电容器的<strong>串联</strong>连接。<br>
<img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/SinglePhase/Basic/RX_impedance.png\"></p>

<p>
线性阻抗通过 <code><u>i</u>*<u>Z</u> = <u>v</u></code> 将复电压 <code><u>v</u></code> 与
复电流 <code><u>i</u></code> 连接。
阻抗 <code>Z_ref = R_ref + j*X_ref</code> 给出为复数输入信号，表示输入阻抗的电阻性和反应性分量。
电阻性分量被建模为温度依赖的，因此实部 <code>R_actual = real(<u>Z</u>)</code> 由实际工作温度和参考输入电阻 <code>real(Z_ref)</code> 确定。
反应性分量 <code>X_actual = imag(<u>Z</u>)</code>
等于 <code>imag(Z_ref)</code> 如果 <code>frequencyDependent = false</code>。
频率依赖性由 <code>frequencyDependent = true</code> 考虑，区分两种情况：
</p>

<dl>
<dt>(a) <code>imag(Z_ref) &gt; 0</code>：电感情况</dt>
<dd>实际电抗 <code>X_actual</code> 与 <code>f/f_ref</code> 成比例</dd>
<dt>(b) <code>imag(Z_ref) &lt; 0</code>：电容情况</dt>
<dd>实际电抗 <code>X_actual</code> 与 <code>f_ref/f</code> 成比例</dd>
</dl>

<h4>注意</h4>
<p>
阻抗信号 <code>Z_ref</code> 的实部或虚部的零点交叉可能由于连接网络的实际结构而导致奇点。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Resistor\">电阻</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Conductor\">导体</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Capacitor\">电容器</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Inductor\">电感</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Impedance\">阻抗</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Admittance\">导纳</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableResistor\">可变电阻</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableConductor\">可变导体</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableCapacitor\">可变电容器</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableInductor\">可变电感</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableAdmittance\">可变导纳</a>
</p>
</html>"));
end VariableImpedance;