within Modelica.Mechanics.Rotational.Sensors;
model RelAccSensor 
  "测量两个一维转动接口之间相对角加速度的理想传感器"

  extends Rotational.Interfaces.PartialRelativeSensor;

  SI.Angle phi_rel 
    "两个一维转动接口之间的相对角度（flange_b.phi - flange_a.phi）";
  SI.AngularVelocity w_rel "两个一维转动接口之间的相对角速度";
  Modelica.Blocks.Interfaces.RealOutput a_rel(unit="rad/s2") 
    "两个一维转动接口之间的相对角加速度作为输出信号" 
    annotation (Placement(transformation(
        origin={0,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));

equation
  phi_rel = flange_b.phi - flange_a.phi;
  w_rel = der(phi_rel);
  a_rel = der(w_rel);
  0 = flange_a.tau;
  annotation (
    Documentation(info="<html>
<p>
以理想方式测量两个一维转动接口之间的<strong>相对角加速度 a_rel</strong>，并将结果作为输出信号<strong>a_rel</strong>返回
（用于进一步使用Modelica.Blocks库中的块进行处理）。
</p>
</html>"), 
       Icon(
    coordinateSystem(preserveAspectRatio=true, 
      extent={{-100.0,-100.0},{100.0,100.0}}), 
      graphics={
    Line(points={{0.0,-100.0},{0.0,-70.0}}, 
      color={0,0,127}), 
        Text(
          extent={{-50,-14},{50,-54}}, 
          textColor={64,64,64}, 
          textString="rad/s2")}));
end RelAccSensor;