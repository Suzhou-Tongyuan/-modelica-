within Modelica.Mechanics.Rotational.Sources;
model Torque "作用于一维转动接口的外部转矩输入信号"
  extends Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport2;
  Modelica.Blocks.Interfaces.RealInput tau(unit="N.m") 
    "作用于一维转动接口的加速转矩(= -flange.tau)" annotation (
      Placement(transformation(extent={{-140,-20},{-100,20}})));

equation
  flange.tau = -tau;
  annotation (
    Documentation(info="<html><p>
输入信号 <strong>tau</strong> 定义了一个外部转矩(单位为N.m)，它(带负号)作用于一个一维转动接口连接器，即连接到此 一维转动接口的组件由转矩 <strong>tau</strong> 驱动。
</p>
<p>
输入信号可以从Modelica.Blocks.Sources块库中的信号发生器块之一提供
</p>
</html>"), 
    Icon(
    coordinateSystem(preserveAspectRatio=true, 
      extent={{-100,-100},{100,100}}), 
      graphics={
    Text(extent={{-150,110},{150,70}}, 
      textString="%name", 
      textColor={0,0,255}), 
    Text(extent={{-62,-29},{-141,-70}}, 
      textString="tau"), 
    Polygon(points={{86,0},{66,58},{37,27},{86,0}}, 
      fillPattern=FillPattern.Solid), 
    Line(points={{0,-10},{0,-101}}), 
    Polygon(points={{-53,-54},{-36,-30},{-50,-24},{-53,-54}}, 
      fillPattern=FillPattern.Solid), 
    Line(
      points={{-84,0},{-78,18},{-56,46},{-20,60},{20,60},{60,40},{82,8}}, 
      smooth=Smooth.Bezier, 
      thickness=0.5), 
    Line(
      points={{-50,-40},{-38,-24},{-18,-12},{0,-10},{18,-12},{38,-24},{50,-40}}, 
      smooth=Smooth.Bezier)}));
end Torque;