within Modelica.Electrical.QuasiStatic.Polyphase.Basic;
model VariableCapacitor "多相可变电容"
  extends Interfaces.TwoPlug;
  Modelica.Blocks.Interfaces.RealInput C[m](each unit="F") 
    "可变电容" annotation (Placement(transformation(
        origin={0,120}, 
        extent={{-20,-20},{20,20}}, 
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}}, 
        rotation=270, 
        origin={0,120})));
  QuasiStatic.SinglePhase.Basic.VariableCapacitor variableCapacitor[m] 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(variableCapacitor.pin_p, plugToPins_p.pin_p) annotation (Line(
        points={{-10,0},{-24.5,0},{-24.5,0},{-39,0},{-39,0},{-68,0}}, color={85,170,255}));
  connect(variableCapacitor.pin_n, plugToPins_n.pin_n) annotation (Line(
        points={{10,0},{39,0},{39,0},{68,0}}, color={85,170,255}));
  connect(C, variableCapacitor.C) annotation (Line(
      points={{0,120},{0,12}}, color={0,0,127}));
  annotation (defaultComponentName="capacitor", 
    Icon(graphics={Line(points={{-90,0},{-6,0}}, color={85,170,255}), 
          Line(points={{6,0},{90,0}}, color={85,170,255}), 
        Line(
          points={{-6,28},{-6,-28}}, 
          color={85,170,255}), 
        Line(
          points={{6,28},{6,-28}}, 
          color={85,170,255}), 
        Text(
          extent={{-150,90},{150,50}}, 
              textString="%name", 
          textColor={0,0,255}), 
                Text(
              extent={{150,-80},{-150,-40}}, 
              textString="m=%m")}), 
    Documentation(info="<html>
<p>
线性电容器通过 <code><u>v</u>*j*&omega;*C = <u>i</u></code> 将复电流 <code><u>i</u></code> 与复电压 <code><u>v</u></code> 连接起来，使用 <code>m</code>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableCapacitor\">单相可变电容器</a>。
电容 <code>C</code> 作为 <code>m</code> 输入信号给出。
</p>

<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableCapacitor\">VariableCapacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Capacitor\">Capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Inductor\">Inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Admittance\">Admittance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableResistor\">Variable resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableConductor\">Variable conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableInductor\">Variable inductor</a>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableImpedance\">Variable impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
end VariableCapacitor;