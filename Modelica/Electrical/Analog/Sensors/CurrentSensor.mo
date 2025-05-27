within Modelica.Electrical.Analog.Sensors;
model CurrentSensor "电流传感器"
  extends Modelica.Icons.RoundSensor;

  Interfaces.PositivePin p "Positive pin" annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  Interfaces.NegativePin n "Negative pin" annotation (Placement(
        transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealOutput i(unit="A") 
    "Current in the branch from p to n as output signal" 
     annotation (Placement(transformation(
        origin={0,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));

equation
  p.v = n.v;
  p.i = i;
  n.i = -i;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-150,80},{150,120}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Line(points={{0,-100},{0,-70}}, color={0,0,127}), 
        Text(
          extent={{-30,-10},{30,-70}}, 
          textColor={64,64,64}, 
          textString="A"),  Line(points={{100,0},{-100,0}}, color={0,0,255})}), 
    Diagram(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-153,79},{147,119}}, 
          textString="%name", 
          textColor={0,0,255})}), 
    Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       Christoph Clauss创建
       </li>
</ul>
</html>", 
        info="<html>
<p>电流传感器将流经两个连接器之间的电流转换为实值信号。这两个连接器在传感器内部以短路方式连接。传感器必须串联放置在电路连接中。它不会影响连接节点处的电流总和。因此，传感器的存在不会影响电路的电气行为。</p>
</html>"));
end CurrentSensor;