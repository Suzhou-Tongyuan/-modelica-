within Modelica.Electrical.QuasiStatic.Polyphase.Basic;
model VariableResistor "多相可变电阻"
  extends Interfaces.TwoPlug;
  parameter SI.Temperature T_ref[m]=fill(293.15, m) 
    "参考温度";
  parameter SI.LinearTemperatureCoefficient alpha_ref[m]= 
      zeros(m) 
    "电阻温度系数 (R_actual = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
  extends Modelica.Electrical.Polyphase.Interfaces.ConditionalHeatPort(
      final mh=m, T=T_ref);
  Modelica.Blocks.Interfaces.RealInput R_ref[m](each unit="Ohm") 
    "可变电阻" annotation (Placement(transformation(
        origin={0,120}, 
        extent={{-20,-20},{20,20}}, 
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}}, 
        rotation=270, 
        origin={0,120})));
  QuasiStatic.SinglePhase.Basic.VariableResistor variableResistor[m](
    final T_ref=T_ref, 
    final alpha_ref=alpha_ref, 
    each final useHeatPort=useHeatPort, 
    final T) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation

  connect(variableResistor.pin_p, plugToPins_p.pin_p) annotation (Line(
        points={{-10,0},{-24.5,0},{-24.5,0},{-39,0},{-39,0},{-68,0}}, color={85,170,255}));
  connect(variableResistor.pin_n, plugToPins_n.pin_n) annotation (Line(
        points={{10,0},{39,0},{39,0},{68,0}}, color={85,170,255}));
  connect(variableResistor.heatPort, heatPort) annotation (Line(
      points={{0,-10},{0,-10},{0,-100}}, color={191,0,0}));
  connect(R_ref, variableResistor.R_ref) annotation (Line(
      points={{0,120},{0,12}}, color={0,0,127}));
  annotation (defaultComponentName="resistor", 
    Icon(graphics={Line(points={{60,0},{90,0}}, color={85,170,255}), 
          Line(points={{-90,0},{-60,0}}, color={85,170,255}), 
          Rectangle(
              extent={{-70,30},{70,-30}}, 
              lineColor={85,170,255}, 
              fillColor={255,255,255}, 
              fillPattern=FillPattern.Solid), 
        Text(
          extent={{-150,90},{150,50}}, 
          textString="%name", 
          textColor={0,0,255}), 
                Text(
              extent={{150,-80},{-150,-40}}, 
              textString="m=%m")}), 
    Documentation(info="<html>
<p>
线性电阻通过 <code><u>i</u>*R = <u>v</u></code> 将复电压 <code><u>v</u></code> 和复电流 <code><u>i</u></code> 连接起来，使用 <code>m</code>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableResistor\">单相可变电阻</a>。
电阻 <code>R</code> 作为 <code>m</code> 输入信号给出。
</p>

<p>
电阻模型还具有 <code>m</code> 个可选
<a href=\"modelica://Modelica.Electrical.Polyphase.Interfaces.ConditionalHeatPort\">条件热端口</a>。
电阻的线性温度依赖性也被考虑在内。
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
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableInductor\">Variable inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableImpedance\">Variable impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
end VariableResistor;