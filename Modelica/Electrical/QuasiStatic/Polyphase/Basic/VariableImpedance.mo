within Modelica.Electrical.QuasiStatic.Polyphase.Basic;
model VariableImpedance "多相可变阻抗"
  extends Interfaces.TwoPlug;
  parameter SI.Temperature T_ref[m]=fill(293.15, m) 
    "参考温度";
  parameter SI.LinearTemperatureCoefficient alpha_ref[m]=zeros(m) 
    "电阻的温度系数 (R_actual = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
  extends Modelica.Electrical.Polyphase.Interfaces.ConditionalHeatPort(final mh=m, T=T_ref);
  parameter Boolean frequencyDependent = false "如果为真，考虑频率依赖性" 
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Frequency f_ref = 1 "参考频率，如果考虑频率依赖性" 
    annotation(Dialog(enable=frequencyDependent));
  Modelica.ComplexBlocks.Interfaces.ComplexInput Z_ref[m] 
    "可变复阻抗" annotation (Placement(transformation(
        origin={0,120}, 
        extent={{-20,-20},{20,20}}, 
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}}, 
        rotation=270, 
        origin={0,120})));
  SinglePhase.Basic.VariableImpedance variableImpedance[m](
    final T_ref=T_ref, 
    final alpha_ref=alpha_ref, 
    each final useHeatPort=useHeatPort, 
    final T=T, 
    final frequencyDependent=fill(frequencyDependent, m), 
    final f_ref=fill(f_ref, m)) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(variableImpedance.pin_p, plugToPins_p.pin_p) annotation (Line(
        points={{-10,0},{-24.5,0},{-39,0},{-68,0}}, color={85,170,255}));
  connect(variableImpedance.pin_n, plugToPins_n.pin_n) 
    annotation (Line(points={{10,0},{39,0},{68,0}}, color={85,170,255}));
  connect(variableImpedance.heatPort, heatPort) annotation (Line(
      points={{0,-10},{0,-100}}, color={191,0,0}));
  connect(variableImpedance.Z_ref, Z_ref) annotation (Line(
      points={{0,12},{0,64},{0,120}}, color={85,170,255}));
  annotation (defaultComponentName="impedance", 
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={Line(points={{60,0},{90,0}}, 
          color={85,170,255}),Line(points={{-90,0},{-60,0}}, color={85,170,255}), 
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
          textColor={0,0,255}), 
                Text(
              extent={{150,-80},{-150,-40}}, 
              textString="m=%m")}), 
    Documentation(info="<html>
<p>阻抗模型表示每个相位中电阻和电感或电容器的<strong>串联</strong>连接。<br>
<img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/SinglePhase/Basic/RX_impedance.png\"></p>

<p>
线性阻抗将复电压 <code><u>v</u></code> 与复电流 <code><u>i</u></code> 通过在每个相位中的 <code><u>i</u>*<u>Z</u> = <u>v</u></code> 连接起来，
使用 <code>m</code> <a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableImpedance\">
可变单相阻抗</a>。
阻抗 <code>Z_ref = R_ref + j*X_ref</code> 作为复输入信号给出，表示输入阻抗的电阻和电抗组件。电阻性分量模型温度相关，因此实部 <code>R_actual = real(<u>Z</u>)</code> 是由实际工作温度和参考输入电阻 <code>real(Z_ref)</code> 确定的。
<a href=\"modelica://Modelica.Electrical.Polyphase.Interfaces.ConditionalHeatPort\">条件热端口</a> 被考虑。
如果 <code>frequencyDependent = false</code>，则反应性组件 <code>X_actual = imag(<u>Z</u>)</code> 等于 <code>imag(Z_ref)</code>。
通过 <code>frequencyDependent = true</code> 考虑频率依赖性，区分两种情况：
</p>

<dl>
<dt>(a) <code>imag(Z_ref) &gt; 0</code>: 电感情况</dt>
<dd>实际电抗 <code>X_actual</code> 与 <code>f/f_ref</code> 成正比</dd>
<dt>(b) <code>imag(Z_ref) &lt; 0</code>: 电容情况</dt>
<dd>实际电抗 <code>X_actual</code> 与 <code>f_ref/f</code> 成正比</dd>
</dl>

<h4>注意</h4>
<p>
阻抗信号 <code>Z_ref</code> 的实部或虚部的零交叉可能会由于连接网络的实际结构引起奇异性。
</p>

<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableResistor\">VariableResistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Capacitor\">Capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Inductor\">Inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Admittance\">Admittance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableConductor\">Variable conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableCapacitor\">Variable capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableInductor\">Variable inductor</a>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
end VariableImpedance;