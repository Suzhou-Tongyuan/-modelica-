within Modelica.Mechanics.Rotational.Sources;
model Torque2 "作用于两个一维转动接口的转矩输入信号"
  extends Rotational.Interfaces.PartialTwoFlanges;

  Modelica.Blocks.Interfaces.RealInput tau(unit="N.m") 
    "驱动两个一维转动接口的转矩（正值加速一维转动接口）" 
    annotation (Placement(transformation(
        origin={0,40}, 
        extent={{-20,-20},{20,20}}, 
        rotation=270)));

equation
  flange_a.tau = tau;
  flange_b.tau = -tau;
  annotation (defaultComponentName="torque", 
    Documentation(info="<html><p>
输入信号 <strong>tau</strong> 定义了一个外部 转矩（单位为N.m），它作用于两个一维转动接口连接器， 即连接到这些一维转动接口的组件由转矩 <strong>tau</strong> 驱动。
</p>
<p>
输入信号可以从Modelica.Blocks.Sources块库中的信号发生器块之一提供。
</p>
</html>"), 
    Icon(
    coordinateSystem(preserveAspectRatio=true, 
      extent={{-100,-100},{100,100}}), 
      graphics={
    Text(extent={{-150,-40},{150,-80}}, 
      textString="%name", 
      textColor={0,0,255}), 
    Polygon(points={{-78,24},{-69,17},{-89,0},{-78,24}}, 
      lineThickness=0.5, 
      fillPattern=FillPattern.Solid), 
    Line(points={{-74,20},{-70,23},{-65,26},{-60,28},{-56,29},{-50,30},{-41,30},{-35,29},{-31,28},{-26,26},{-21,23},{-17,20},{-13,15},{-10,9}}, 
      thickness=0.5, smooth=Smooth.Bezier), 
    Line(points={{74,20},{70,23},{65,26},{60,28},{56,29},{50,30},{41,30},{35,29},{31,28},{26,26},{21,23},{17,20},{13,15},{10,9}}, 
      thickness=0.5, smooth=Smooth.Bezier), 
    Polygon(points={{89,0},{78,24},{69,17},{89,0}}, 
      fillPattern=FillPattern.Solid)}));
end Torque2;