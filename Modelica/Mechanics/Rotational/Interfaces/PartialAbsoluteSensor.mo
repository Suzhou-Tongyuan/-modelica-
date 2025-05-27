within Modelica.Mechanics.Rotational.Interfaces;
partial model PartialAbsoluteSensor 
  "测量单个绝对一维转动接口变量的部分模型"
  extends Modelica.Icons.RoundSensor;

  Flange_a flange 
    "应从中测量传感器信息的轴的一维转动接口" 
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));

equation
  0 = flange.tau;
  annotation (Documentation(info="<html>
<p>
这是一个一维旋转组件的部分模型，具有轴的一个一维转动接口，
用于测量一维转动接口中的绝对运动学量，并将测量信号作为输出信号提供给
Modelica.Blocks包中的其他处理块。
</p>
</html>"), 
       Icon(
    coordinateSystem(preserveAspectRatio=true, 
      extent={{-100.0,-100.0},{100.0,100.0}}), 
      graphics={
    Line(points={{-70.0,0.0},{-90.0,0.0}}), 
    Line(points={{70.0,0.0},{100.0,0.0}}, 
      color={0,0,127}), 
    Text(textColor={0,0,255}, 
      extent={{-150.0,80.0},{150.0,120.0}}, 
      textString="%name")}));
end PartialAbsoluteSensor;