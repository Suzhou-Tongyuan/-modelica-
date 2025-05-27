within Modelica.Mechanics.Translational.Sensors;
model RelSpeedSensor "理想传感器，用于测量相对速度"
  extends Translational.Interfaces.PartialRelativeSensor;
  SI.Position s_rel "两个一维平动接口之间的距离（flange_b.s - flange_a.s）";
  Modelica.Blocks.Interfaces.RealOutput v_rel(unit="m/s") 
    "输出信号：两个一维平动接口之间的相对速度（= der(flange_b.s) - der(flange_a.s)）" 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={0,-110})));

equation
  s_rel = flange_b.s - flange_a.s;
  v_rel = der(s_rel);
  0 = flange_a.f;
  annotation (
    Documentation(info="<html><p>
以理想方式测量一维平动接口的相对速度<em>v</em>，并将结果提供为输出信号（以便与Modelica.Blocks库中的模块进一步处理）。
</p>
</html>",revisions="<html>
<p><strong>发行说明：</strong></p>
<ul>
<li><em>由P. Beater于1999年8月26日发布的第一个版本</em></li>
</ul>
</html>"), 
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100}, 
            {100,100}}), graphics={
                              Line(points={{0,-100},{0,-61}}, color={0,0, 
          127}), 
        Text(
          extent={{-24,20},{66,-40}}, 
          textColor={64,64,64}, 
          textString="m/s")}));
end RelSpeedSensor;