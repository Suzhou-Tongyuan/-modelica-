within Modelica.Mechanics.Translational.Sensors;
model ForceSensor "理想传感器，用于测量两个一维平动接口之间的力"
  extends Translational.Interfaces.PartialRelativeSensor;
  Modelica.Blocks.Interfaces.RealOutput f(unit="N") 
    "输出信号：一维平动接口a和一维平动接口b之间的力（f = flange_a.f = -flange_b.f）" 
    annotation (Placement(transformation(
        origin={-80,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
equation
  flange_a.s = flange_b.s;
  flange_a.f = f;
  annotation (
    Documentation(info="<html><p>
以理想方式测量两个一维平动接口之间的相对力，并将结果作为输出信号提供（以便与Modelica.Blocks库中的模块进一步处理）。
</p>
</html>"), 
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100}, 
            {100,100}}), graphics={    Line(points={{-80,-100}, 
          {-80,0}}, color={0,0,127}), 
        Text(
          extent={{-24,20},{66,-40}}, 
          textColor={64,64,64}, 
          textString="N")}));
end ForceSensor;