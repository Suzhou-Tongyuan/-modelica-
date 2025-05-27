within Modelica.Mechanics.Translational.Sensors;
model RelPositionSensor "理想传感器，用于测量相对位置"
  extends Translational.Interfaces.PartialRelativeSensor;
  Modelica.Blocks.Interfaces.RealOutput s_rel(unit="m") 
    "输出信号：两个一维平动接口之间的距离（= flange_b.s - flange_a.s）" 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={0,-110})));

equation
  s_rel = flange_b.s - flange_a.s;
  0 = flange_a.f;
  annotation (
    Documentation(info="<html><p>
以理想方式测量一维平动接口的相对位置<em>s</em>，并将结果提供为输出信号（以便与Modelica.Blocks库中的模块进一步处理）。
</p>
</html>"), 
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100}, 
            {100,100}}), graphics={
                              Line(points={{0,-99},{0,-60}}, color={0,0,127}), 
        Text(
          extent={{-24,20},{66,-40}}, 
          textColor={64,64,64}, 
          textString="m")}));
end RelPositionSensor;