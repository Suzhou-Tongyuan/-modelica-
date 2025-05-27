within Modelica.Electrical.Analog.Sensors;
model PotentialSensor "电位传感器"
  extends Modelica.Icons.RoundSensor;

  Interfaces.PositivePin p "待测引脚" annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.RealOutput phi(unit="V") 
    "绝对电压电位作为输出信号" 
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  p.i = 0;
  phi = p.v;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-70,0},{-90,0}}, color={0,0,255}), 
        Line(points={{100,0},{70,0}}, color={0,0,127}), 
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
<p>电位传感器将一个节点(相对于地节点)的电压转换为一个实值信号。它不会影响被测量电压节点的电流总和，因此，传感器不会影响电气行为。</p>
</html>"));
end PotentialSensor;