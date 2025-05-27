within Modelica.Mechanics.Rotational.Sensors;
model AngleSensor "理想传感器，用于测量绝对一维转动接口角度"

  extends Rotational.Interfaces.PartialAbsoluteSensor;
  Modelica.Blocks.Interfaces.RealOutput phi(unit="rad", displayUnit="deg") 
    "作为输出信号的一维转动接口绝对角度" 
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  phi = flange.phi;
  annotation (
    Documentation(info="<html>
<p>
以理想方式测量一维转动接口的<strong>绝对角度 phi</strong>，并将结果作为输出信号<strong>phi</strong>返回（用于进一步使用Modelica.Blocks库中的块进行处理）。
</p> 
</html>"), 
       Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-30,-10},{30,-70}}, 
          textColor={64,64,64}, 
          textString="rad")}));
end AngleSensor;