within Modelica.Mechanics.Translational.Sensors;
model SpeedSensor "理想传感器，用于测量绝对速度"
  extends Translational.Interfaces.PartialAbsoluteSensor;
  Modelica.Blocks.Interfaces.RealOutput v(unit="m/s") 
    "输出信号：一维平动接口的绝对速度" annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));

equation
  v = der(flange.s);
  annotation (
    Documentation(info="<html><p>
以理想方式测量一维平动接口的绝对速度<em>v</em>，并将结果提供为输出信号（以便与Modelica.Blocks库中的模块进一步处理）。
</p>
</html>"), 
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100}, 
            {100,100}}), graphics={
        Text(
          extent={{-24,20},{66,-40}}, 
          textColor={64,64,64}, 
          textString="m/s")}));
end SpeedSensor;