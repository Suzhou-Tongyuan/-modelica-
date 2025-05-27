within Modelica.Mechanics.Rotational.Sensors;
model PowerSensor 
  "测量两个一维转动接口之间功率的理想传感器（= flange_a.tau*der(flange_a.phi)）"

  extends Rotational.Interfaces.PartialRelativeSensor;
  Modelica.Blocks.Interfaces.RealOutput power(unit="W") 
    "一维转动接口flange_a上的功率作为输出信号" 
    annotation (Placement(transformation(
        origin={-80,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));

equation
  flange_a.phi = flange_b.phi;
  power = flange_a.tau*der(flange_a.phi);
  annotation (
    Documentation(info="<html>
<p>
以理想方式测量两个一维转动接口之间的<strong>功率</strong>

并将结果作为输出信号<strong>power</strong>返回

（用于进一步使用Modelica.Blocks库中的块进行处理）。
</p>
</html>"), 
       Icon(
    coordinateSystem(preserveAspectRatio=true, 
      extent={{-100.0,-100.0},{100.0,100.0}}), 
      graphics={
    Line(points={{-80.0,-100.0},{-80.0,0.0}}, 
      color={0,0,127}), 
        Text(
          extent={{-30,-10},{30,-70}}, 
          textColor={64,64,64}, 
          textString="W")}));
end PowerSensor;