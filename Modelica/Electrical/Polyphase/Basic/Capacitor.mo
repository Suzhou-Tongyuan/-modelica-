within Modelica.Electrical.Polyphase.Basic;
model Capacitor "理想线性电容"
  extends Interfaces.TwoPlug;
  parameter SI.Capacitance C[m](start=fill(1, m)) 
    "电容量";
  Modelica.Electrical.Analog.Basic.Capacitor capacitor[m](final C=C) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(capacitor.p, plug_p.pin) 
    annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
  connect(capacitor.n, plug_n.pin) 
    annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
            -100},{100,100}}), graphics={
        Line(
          points={{-6,28},{-6,-28}}, 
          color={0,0,255}), 
        Line(
          points={{6,28},{6,-28}}, 
          color={0,0,255}), 
        Line(points={{-90,0},{-6,0}}, color={0,0,255}), 
        Line(points={{6,0},{90,0}}, color={0,0,255}), 
        Text(
          extent={{-150,90},{150,50}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-150,-80},{150,-40}}, 
          textString="m=%m")}), Documentation(info="<html>
<p>
包含m个电容器(Modelica.Electrical.Analog.Basic.Capacitor)
</p>
</html>"));
end Capacitor;