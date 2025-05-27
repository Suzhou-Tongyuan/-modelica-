within Modelica.Electrical.Polyphase.Basic;
model Conductor "理想线性电导"
  extends Interfaces.TwoPlug;
  extends Polyphase.Interfaces.ConditionalHeatPort;
  parameter SI.Conductance G[m](start=fill(1, m)) 
    "在参考温度T_ref下的电导G_ref";
  parameter SI.Temperature T_ref[m]=fill(300.15, m) 
    "参考温度";
  parameter SI.LinearTemperatureCoefficient alpha[m]=zeros(m) 
    "在参考温度下的电导温度系数";
  Modelica.Electrical.Analog.Basic.Conductor conductor[m](
    final G=G, 
    final T_ref=T_ref, 
    final alpha=alpha, 
    each final useHeatPort=useHeatPort) annotation (Placement(
        transformation(extent={{-10,-10},{10,10}})));
equation
  connect(plug_p.pin, conductor.p) 
    annotation (Line(points={{-100,0},{-10,0}}, color={0,0,255}));
  connect(plug_n.pin, conductor.n) 
    annotation (Line(points={{100,0},{10,0}}, color={0,0,255}));
  connect(conductor.heatPort, heatPort) annotation (Line(
      points={{0,-10},{0,-100}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
            -100},{100,100}}), graphics={
        Rectangle(
          extent={{-70,30},{70,-30}}, 
          lineColor={0,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-90,0},{-70,0}}, color={0,0,255}), 
        Line(points={{70,0},{90,0}}, color={0,0,255}), 
        Text(
          extent={{-150,-80},{150,-40}}, 
          textString="m=%m"), 
        Text(
          extent={{-150,50},{150,90}}, 
          textString="%name", 
          textColor={0,0,255})}), Documentation(info="<html>
<p>
包含m个电导体(Modelica.Electrical.Analog.Basic.Conductor)
</p>
</html>"));
end Conductor;