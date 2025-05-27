within Modelica.Electrical.QuasiStatic.Polyphase.Basic;
model Resistor "多相线性电阻"
  extends Interfaces.TwoPlug;
  parameter SI.Resistance R_ref[m](start=fill(1, m)) 
    "在 T_ref 下的参考电阻";
  parameter SI.Temperature T_ref[m]=fill(293.15, m) 
    "参考温度";
  parameter SI.LinearTemperatureCoefficient alpha_ref[m]= 
      zeros(m) 
    "电阻的温度系数 (R_actual = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
  extends Modelica.Electrical.Polyphase.Interfaces.ConditionalHeatPort(
      final mh=m, T=T_ref);
  QuasiStatic.SinglePhase.Basic.Resistor resistor[m](
    final R_ref=R_ref, 
    final T_ref=T_ref, 
    final alpha_ref=alpha_ref, 
    each final useHeatPort=useHeatPort, 
    final T=T) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(plugToPins_p.pin_p, resistor.pin_p) annotation (Line(points={{-68, 
          0},{-53.5,0},{-39,0},{-10,0}}, color={85,170,255}));
  connect(resistor.pin_n, plugToPins_n.pin_n) 
    annotation (Line(points={{10,0},{39,0},{68,0}}, color={85,170,255}));
  connect(resistor.heatPort, heatPort) annotation (Line(points={{0,-10},{0, 
          -32.5},{0,-55},{0,-100}}, color={191,0,0}));
  annotation (Icon(graphics={Line(points={{60,0},{90,0}}, color={85,170,255}), 
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
          textString="m=%m")}), Documentation(info="<html>
<p>
线性电阻通过 <code><u>v</u></code> 与 <code><u>i</u></code> 之间的复电压和复电流连接，
使用 <code>m</code> 个<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Resistor\">单相电阻</a>。
</p>

<p>
电阻模型还具有 <code>m</code> 个可选的<a href=\"modelica://Modelica.Electrical.Polyphase.Interfaces.ConditionalHeatPort\">条件热口</a>。
对于启用的热口，还考虑了电阻的线性温度依赖性。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Capacitor\">Capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Inductor\">Inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Admittance\">Admittance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableResistor\">Variable resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableConductor\">Variable conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableCapacitor\">Variable capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableInductor\">Variable inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableImpedance\">Variable impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
end Resistor;