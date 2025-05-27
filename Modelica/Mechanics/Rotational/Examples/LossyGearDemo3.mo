within Modelica.Mechanics.Rotational.Examples;
model LossyGearDemo3 
  "在上一个版本的LossyGear中失败的示例"
  extends Modelica.Icons.Example;


  Modelica.Mechanics.Rotational.Components.LossyGear gear(
    ratio=1, 
    lossTable=[0, 0.25, 0.25, 0.625, 2.5], 
    useSupport=false) annotation (Placement(transformation(extent={{-10,0}, 
            {10,20}})));
  Modelica.Mechanics.Rotational.Components.Inertia Inertia1(w(start=10), J= 
        0.001) annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque1(useSupport=false) 
    annotation (Placement(transformation(extent={{-68,0},{-48,20}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque2(useSupport=false) 
    annotation (Placement(transformation(extent={{68,0},{48,20}})));
  Modelica.Blocks.Sources.Step step(height=0) annotation (Placement(
        transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Sources.Step step1(
    startTime=0.5, 
    height=1, 
    offset=0) annotation (Placement(transformation(
        origin={90,10}, 
        extent={{-10,10},{10,-10}}, 
        rotation=180)));
  Modelica.Mechanics.Rotational.Components.Inertia Inertia2(
    J=0.001, 
    phi(fixed=true, start=0), 
    w(start=10, fixed=true)) annotation (Placement(transformation(extent={{
            20,0},{40,20}})));
equation
  connect(Inertia1.flange_b, gear.flange_a) 
    annotation (Line(points={{-20,10},{-16,10},{-10,10}}));
  connect(torque1.flange, Inertia1.flange_a) 
    annotation (Line(points={{-48,10},{-40,10}}));
  connect(step.y, torque1.tau) 
    annotation (Line(points={{-79,10},{-70,10}}, color={0,0,127}));
  connect(gear.flange_b, Inertia2.flange_a) 
    annotation (Line(points={{10,10},{20,10}}));
  connect(Inertia2.flange_b, torque2.flange) 
    annotation (Line(points={{40,10},{48,10}}));
  connect(step1.y, torque2.tau) annotation (Line(
      points={{79,10},{74.5,10},{74.5,10},{70,10}}, color={0,0,127}));
  annotation (
    Documentation(info="<html>
<p>
这个示例演示了LossyGear模型的驱动端的驱动不明显的情形。
直到Modelica包的版本3.1，LossyGear的版本在这种情况下失效了
（事件的迭代没有收敛）。
</p>

</html>"), 
       experiment(StopTime=1.0, Interval=0.001));
end LossyGearDemo3;