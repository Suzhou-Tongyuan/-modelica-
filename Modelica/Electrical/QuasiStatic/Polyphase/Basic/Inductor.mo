within Modelica.Electrical.QuasiStatic.Polyphase.Basic;
model Inductor "多相线性电感"
  extends Interfaces.TwoPlug;
  parameter SI.Inductance L[m](start=fill(1, m)) 
    "电感";
  QuasiStatic.SinglePhase.Basic.Inductor inductor[m](final L=L) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation

  connect(plugToPins_p.pin_p, inductor.pin_p) annotation (Line(points={{-68, 
          0},{-53.5,0},{-53.5,0},{-39,0},{-39,0},{-10,0}}, color={85,170, 
          255}));
  connect(inductor.pin_n, plugToPins_n.pin_n) annotation (Line(points={{10, 
          0},{39,0},{39,0},{68,0}}, color={85,170,255}));
  annotation (Icon(graphics={Line(points={{60,0},{90,0}}, 
          color={85,170,255}),Line(points={{-90,0},{-60,0}}, color={85,170,255}), 
          Text(
              extent={{150,-80},{-150,-40}}, 
              textString="m=%m"), 
        Line(
          points={{-60,0},{-59,6},{-52,14},{-38,14},{-31,6},{-30,0}}, 
          color={85,170,255}, 
          smooth=Smooth.Bezier), 
        Line(
          points={{-30,0},{-29,6},{-22,14},{-8,14},{-1,6},{0,0}}, 
          color={85,170,255}, 
          smooth=Smooth.Bezier), 
        Line(
          points={{0,0},{1,6},{8,14},{22,14},{29,6},{30,0}}, 
          color={85,170,255}, 
          smooth=Smooth.Bezier), 
        Line(
          points={{30,0},{31,6},{38,14},{52,14},{59,6},{60,0}}, 
          color={85,170,255}, 
          smooth=Smooth.Bezier), 
        Text(
          extent={{-150,90},{150,50}}, 
          textString="%name", 
          textColor={0,0,255})}), Documentation(info="<html>
<p>
线性电感器通过 <code><u>v</u></code> 与 <code><u>i</u></code> 之间的复电压和复电流连接，
使用 <code>m</code> 个<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Inductor\">单相电感器</a>。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Inductor\">Inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Capacitor\">Capacitor</a>,
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
end Inductor;