within Modelica.Mechanics.Translational.Sensors;
model PositionSensor "理想传感器，用于测量绝对位置"
  extends Translational.Interfaces.PartialAbsoluteSensor;
  Modelica.Blocks.Interfaces.RealOutput s(unit="m") 
    "输出信号：一维平动接口的绝对位置" annotation (Placement(
        transformation(extent={{100,-11},{120,9}}), 
        iconTransformation(extent={{100,-10},{120,10}})));

equation
  s = flange.s;
  annotation (
    Documentation(info="<html><p>
以理想方式测量一维平动接口的绝对位置<em>s</em>，并将结果提供为输出信号（以便与Modelica.Blocks库中的模块进一步处理）。
</p>
</html>"), 
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100}, 
            {100,100}}), graphics={
        Text(
          extent={{-24,20},{66,-40}}, 
          textColor={64,64,64}, 
          textString="m")}));
end PositionSensor;