within Modelica.Magnetic.FluxTubes.Sources;
model SignalMagneticPotentialDifference 
  "信号控制磁动势"

  extends Interfaces.TwoPortElementary;
  Modelica.Blocks.Interfaces.RealInput V_m(unit="A") 
    "磁位差" 
    annotation (Placement(transformation(
        origin={0,110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90), iconTransformation(
        extent={{10,-10},{-10,10}}, 
        rotation=90, 
        origin={0,110})));
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
      Line(points={{-100,0},{-50,0}}, color={255,127,0}), 
      Line(points={{50,0},{100,0}}, color={255,127,0}), 
      Text(
        extent={{-150,50},{150,90}}, 
        textString="%name", 
        textColor={0,0,255}), 
      Ellipse(
        extent={{-50,-50},{50,50}}, 
        lineColor={255,127,0}, 
        fillColor={255,255,255}, 
        fillPattern=FillPattern.Solid), 
      Line(points={{-50,0},{50,0}}, color={255,127,0}), 
        Line(points={{-70,30},{-70,10}}, color={255,128,0}), 
        Line(points={{-80,20},{-60,20}}, color={255,128,0}), 
        Line(points={{60,20},{80,20}}, color={255,128,0})}), 
    Documentation(info="<html>
<p>
在电磁设备中，线圈磁通链的变化&Psi;由于<em>法拉第</em>定律感应电压v对电气子系统起作用:
</p>
<blockquote><pre>
v = - d&Psi;/dt
</pre></blockquote>
<p>这个反应可以忽略不计</p>
<ul>
<li>准静态条件下电磁执行器的建模(慢电流变化、慢电枢运动),</li>
<li>电流控制电磁执行器的建模(理想电流源)和</li>
<li>用于系统仿真，其中系统动力学不是由电磁执行器控制，而是由周围的子系统控制.</li>
</ul>
<p>
在这些情况下，由线圈施加的磁电位差或磁动势可以很容易地用信号控制源建模。除了被忽略的动力学外，基于这些源的作动器模型将正确计算作动器的稳态力.
</p>
</html>"));
end SignalMagneticPotentialDifference;