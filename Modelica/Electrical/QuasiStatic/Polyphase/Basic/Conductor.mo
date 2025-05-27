within Modelica.Electrical.QuasiStatic.Polyphase.Basic;
model Conductor "多相线性电导"
  extends Interfaces.TwoPlug;
  parameter SI.Conductance G_ref[m](start=fill(1, m)) 
    "在 T_ref 下的参考导纳";
  parameter SI.Temperature T_ref[m]=fill(293.15, m) 
    "参考温度";
  parameter SI.LinearTemperatureCoefficient alpha_ref[m]= 
      zeros(m) 
    "导纳的温度系数 (G_actual = G_ref/(1 + alpha_ref*(heatPort.T - T_ref))";
  extends Modelica.Electrical.Polyphase.Interfaces.ConditionalHeatPort(
      final mh=m, T=T_ref);
  QuasiStatic.SinglePhase.Basic.Conductor conductor[m](
    final G_ref=G_ref, 
    final T_ref=T_ref, 
    final alpha_ref=alpha_ref, 
    each final useHeatPort=useHeatPort, 
    final T=T) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(plugToPins_p.pin_p, conductor.pin_p) annotation (Line(points={{-68, 
          0},{-53.5,0},{-53.5,0},{-39,0},{-39,0},{-10,0}}, color={85,170, 
          255}));
  connect(conductor.pin_n, plugToPins_n.pin_n) annotation (Line(points={{10, 
          0},{39,0},{39,0},{68,0}}, color={85,170,255}));
  connect(conductor.heatPort, heatPort) annotation (Line(points={{0,-10},{0, 
          -32.5},{0,-32.5},{0,-55},{0,-55},{0,-100}}, color={191,0,0}));
  annotation (Icon(graphics={Line(points={{60,0},{90,0}}, color={85,170,255}), 
          Line(points={{-90,0},{-60,0}}, color={85,170,255}), 
          Rectangle(
              extent={{-70,30},{70,-30}}, 
              lineColor={85,170,255}, 
              fillColor={255,255,255}, 
              fillPattern=FillPattern.Solid),Text(
              extent={{150,-80},{-150,-40}}, 
              textString="m=%m"), 
        Text(
          extent={{-150,90},{150,50}}, 
          textString="%name", 
          textColor={0,0,255})}), Documentation(info="<html>
<p>
线性导体通过 <code><u>i</u></code> 与 <code><u>v</u></code> 之间的复电流和复电压连接，
使用 <code>m</code> 个<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Conductor\">单相导体</a>。
</p>

<p>
导体模型还具有 <code>m</code> 个可选的<a href=\"modelica://Modelica.Electrical.Polyphase.Interfaces.ConditionalHeatPort\">条件热口</a>。
对于启用的热口，还考虑了导纳的线性温度依赖性。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Resistor\">Resistor</a>,
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
end Conductor;