within Modelica.Electrical.QuasiStatic.Polyphase.Basic;
model VariableConductor "多相可变电导"
  extends Interfaces.TwoPlug;
  parameter SI.Temperature T_ref[m]=fill(293.15, m) 
    "参考温度";
  parameter SI.LinearTemperatureCoefficient alpha_ref[m]= 
      zeros(m) 
    "电阻温度系数 (G_actual = G_ref/(1 + alpha_ref*(heatPort.T - T_ref))";
  extends Modelica.Electrical.Polyphase.Interfaces.ConditionalHeatPort(
      final mh=m, T=T_ref);
  Modelica.Blocks.Interfaces.RealInput G_ref[m](each unit="S") 
    "可变导纳" annotation (Placement(transformation(
        origin={0,120}, 
        extent={{-20,-20},{20,20}}, 
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}}, 
        rotation=270, 
        origin={0,120})));
  QuasiStatic.SinglePhase.Basic.VariableConductor variableConductor[m](
    final T_ref=T_ref, 
    final alpha_ref=alpha_ref, 
    each final useHeatPort=useHeatPort, 
    final T) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(variableConductor.pin_p, plugToPins_p.pin_p) annotation (Line(
        points={{-10,0},{-24.5,0},{-24.5,0},{-39,0},{-39,0},{-68,0}}, color={85,170,255}));
  connect(variableConductor.pin_n, plugToPins_n.pin_n) annotation (Line(
        points={{10,0},{39,0},{39,0},{68,0}}, color={85,170,255}));
  connect(variableConductor.heatPort, heatPort) annotation (Line(points={{0, 
          -10},{0,-32.5},{0,-32.5},{0,-55},{0,-55},{0,-100}}, color={191,0,0}));
  connect(G_ref, variableConductor.G_ref) annotation (Line(points={{0,120},{0,120},{0,12},{0,12}}, color={0,0,127}));
  annotation (defaultComponentName="conductor", 
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
线性电阻通过 <code><u>v</u>*G = <u>i</u></code> 将复电流 <code><u>i</u></code> 与复电压 <code><u>v</u></code> 连接起来，使用 <code>m</code>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableConductor\">单相可变导体</a>。
电导 <code>G</code> 作为 <code>m</code> 输入信号给出。
</p>

<p>
导体模型也具有 <code>m</code> 个可选
<a href=\"modelica://Modelica.Electrical.Polyphase.Interfaces.ConditionalHeatPort\">条件热端口</a>。
导体的线性温度依赖性也被考虑在内。
</p>

<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableConductor\">VariableConductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Capacitor\">Capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Inductor\">Inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Admittance\">Admittance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableResistor\">Variable resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableCapacitor\">Variable capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableInductor\">Variable inductor</a>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableImpedance\">Variable impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
end VariableConductor;