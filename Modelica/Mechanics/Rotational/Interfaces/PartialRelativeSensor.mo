within Modelica.Mechanics.Rotational.Interfaces;
partial model PartialRelativeSensor 
  "测量两个一维转动接口之间单个相对变量的部分模型"
  extends Modelica.Icons.RoundSensor;

  Flange_a flange_a "轴的一维转动接口a" annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  Flange_b flange_b "轴的一维转动接口b" annotation (Placement(
        transformation(extent={{90,-10},{110,10}})));

equation
  0 = flange_a.tau + flange_b.tau;
  annotation (Documentation(info="<html>
<p>
这是一个带有两个刚性连接的一维旋转组件的部分模型，
以便测量两个一维转动接口之间的相对运动学量
或一维转动接口处的局部力矩，并将测量信号作为输出信号提供给
Modelica.Blocks包中的其他处理块。
</p>
</html>"), 
       Icon(
    coordinateSystem(preserveAspectRatio=true, 
      extent={{-100.0,-100.0},{100.0,100.0}}), 
      graphics={
    Line(points={{-70.0,0.0},{-90.0,0.0}}), 
    Line(points={{70.0,0.0},{90.0,0.0}}), 
    Text(textColor={0,0,255}, 
      extent={{-150,80},{150,120}}, 
      textString="%name")}));
end PartialRelativeSensor;