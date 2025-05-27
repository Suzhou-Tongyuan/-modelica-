within Modelica.Electrical.Analog.Sensors;
model VoltageSensor "电压传感器"
  extends Modelica.Icons.RoundSensor;

  Interfaces.PositivePin p "Positive pin" annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  Interfaces.NegativePin n "Negative pin" annotation (Placement(
        transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealOutput v(unit="V") 
    "Voltage between pin p and n (= p.v - n.v) as output signal" 
     annotation (Placement(transformation(
        origin={0,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));

equation
  p.i = 0;
  n.i = 0;
  v = p.v - n.v;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-70,0},{-90,0}}, color={0,0,255}), 
        Line(points={{70,0},{90,0}}, color={0,0,255}), 
        Line(points={{0,-100},{0,-70}}, color={0,0,127}), 
        Text(
          extent={{-150,80},{150,120}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-30,-10},{30,-70}}, 
          textString="V", 
          textColor={64,64,64})}), 
    Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       Christoph Clauss创建
       </li>
</ul>
</html>", 
        info="<html>
<p>电压传感器将两个连接器之间的电压转换为实数信号。它不会影响测量电压之间节点处的电流总和，因此，传感器不会影响电气行为。</p>
</html>"));
end VoltageSensor;