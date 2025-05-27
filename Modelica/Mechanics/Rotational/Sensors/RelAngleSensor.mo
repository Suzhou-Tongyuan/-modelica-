within Modelica.Mechanics.Rotational.Sensors;
model RelAngleSensor 
  "测量两个一维转动接口之间相对角度的理想传感器"

  extends Rotational.Interfaces.PartialRelativeSensor;
  Modelica.Blocks.Interfaces.RealOutput phi_rel(unit="rad", displayUnit="deg") 
    "两个一维转动接口之间的相对角度（= flange_b.phi - flange_a.phi）作为输出信号" 
    annotation (Placement(transformation(
        origin={0,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));

equation
  phi_rel = flange_b.phi - flange_a.phi;
  0 = flange_a.tau;
  annotation (
    Documentation(info="<html>
<p>
以理想方式测量两个一维转动接口之间的<strong>相对角度 phi_rel</strong>，并将结果作为输出信号<strong>phi_rel</strong>返回
（用于进一步使用Modelica.Blocks库中的块进行处理）。
</html>"), 
       Icon(
    coordinateSystem(preserveAspectRatio=true, 
      extent={{-100.0,-100.0},{100.0,100.0}}), 
      graphics={
   Line(points={{0.0,-100.0},{0.0,-70.0}}, 
    color={0,0,127}), 
        Text(
          extent={{-30,-10},{30,-70}}, 
          textColor={64,64,64}, 
          textString="rad")}));
end RelAngleSensor;