within Modelica.Magnetic.FluxTubes.Sources;
model ConstantMagneticPotentialDifference "恒磁动势"

  extends Interfaces.TwoPortElementary;
  parameter SI.MagneticPotentialDifference V_m 
    "磁位差";
  SI.MagneticFlux Phi "从port_p到port_n的磁通量";

equation
  V_m = port_p.V_m - port_n.V_m;
  Phi = port_p.Phi;
  0 = port_p.Phi + port_n.Phi;

  annotation (
    defaultComponentName="magVoltageSource", 
    Icon(coordinateSystem(
      preserveAspectRatio=false, 
      extent={{-100,-100},{100,100}}), graphics={
      Ellipse(
        extent={{-50,-50},{50,50}}, 
        lineColor={255,127,0}, 
        fillColor={255,255,255}, 
        fillPattern=FillPattern.Solid), 
      Line(points={{100,0},{50,0}}, color={255,127,0}), 
      Line(points={{-50,0},{-100,0}}, color={255,127,0}), 
      Text(
        extent={{-150,60},{150,100}}, 
        textString="%name", 
        textColor={0,0,255}), 
      Line(points={{-50,0},{50,0}}, color={255,127,0}), 
        Line(points={{-70,30},{-70,10}}, color={255,128,0}), 
        Line(points={{-80,20},{-60,20}}, color={255,128,0}), 
        Line(points={{60,20},{80,20}}, color={255,128,0})}), 
    Documentation(info="<html>
<p>
稳态条件下的磁路，即具有固定磁场(磁通量变化d&Phi;/dt = 0)的磁路，可以用磁位差或磁动势(mmf)的恒定源来描述。恒定磁位差是由
</p>
<ul>
<li>线圈具有固定电流(di / dt = 0)和</li>
<li>用<em>模拟永磁体</em>的等效磁路.</li>
</ul>
<p>
对于具有此源元件的磁阻执行器的建模，假设电枢是固定的，因此不会发生运动引起的磁通变化d&Phi;/dt.
</p>
</html>"));
end ConstantMagneticPotentialDifference;