within Modelica.Magnetic.QuasiStatic.FluxTubes.Basic;
model Crossing "两支交叉"

  FluxTubes.Interfaces.PositiveMagneticPort port_p1 "正port_p1与port_p2相连" annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
  FluxTubes.Interfaces.PositiveMagneticPort port_p2 "正port_p2与port_p1相连" annotation (Placement(transformation(extent={{90,-110},{110,-90}})));
  FluxTubes.Interfaces.NegativeMagneticPort port_n1 "负port_n1与port_n2相连" annotation (Placement(transformation(extent={{-110,-110},{-90,-90}})));
  FluxTubes.Interfaces.NegativeMagneticPort port_n2 "负port_n2与port_n1相连" annotation (Placement(transformation(extent={{90,90},{110,110}})));

equation
  Connections.branch(port_p1.reference, port_p2.reference);
  Connections.branch(port_n1.reference, port_n2.reference);
  port_p1.reference.gamma = port_p2.reference.gamma;
  port_n1.reference.gamma = port_n2.reference.gamma;

  port_p1.V_m = port_p2.V_m;
  port_p1.Phi + port_p2.Phi = Complex(0,0);
  port_n1.V_m = port_n2.V_m;
  port_n1.Phi + port_n2.Phi = Complex(0,0);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
            -100},{100,100}}), graphics={
      Line(
          points={{100,100},{40,100},{-40,-100},{-100,-100}}, 
          color={255,170,85}), 
      Line(
          points={{-100,100},{-40,100},{40,-98},{100,-100}}, 
          color={255,170,85}), 
        Text(
          extent={{-150,110},{150,150}}, 
          textColor={0,0,255}, 
          textString="%name")}), Documentation(
        info="<html>
<p>
这是两个分支的简单交叉。连接端口<code>port_p1</code>和<code>port_p2</code>，以及<code>port_n1</code>和<code>port_n2</code>.
</p></html>", 
      revisions="<html>
</html>"));
end Crossing;