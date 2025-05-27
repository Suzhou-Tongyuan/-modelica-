within Modelica.Mechanics.Rotational.Sensors;
model AccSensor 
  "理想传感器，用于测量绝对一维转动接口角加速度"

  extends Rotational.Interfaces.PartialAbsoluteSensor;
  SI.AngularVelocity w "一维转动接口的绝对角速度";
  Modelica.Blocks.Interfaces.RealOutput a(unit="rad/s2") 
    "作为输出信号的一维转动接口绝对角加速度" annotation (
      Placement(transformation(extent={{100,-10},{120,10}})));

equation
  w = der(flange.phi);
  a = der(w);
  annotation (
    Documentation(info="<html>
<p>
以理想方式测量一维转动接口的<strong>绝对角加速度 a</strong>，并将结果作为输出信号<strong>a</strong>返回

（用于进一步使用Modelica.Blocks库中的块进行处理）。</p>
</html>"), 
       Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-50,-14},{50,-54}}, 
          textColor={64,64,64}, 
          textString="rad/s2")}));
end AccSensor;