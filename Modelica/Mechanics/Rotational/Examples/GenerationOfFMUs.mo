within Modelica.Mechanics.Rotational.Examples;
model GenerationOfFMUs 
  "演示生成FMU(功能模拟单元)的变体的示例"
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Sine sine1(f=2, amplitude=10) 
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Mechanics.Rotational.Examples.Utilities.DirectInertia 
    directInertia(J=1.1) 
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Modelica.Mechanics.Rotational.Examples.Utilities.InverseInertia 
    inverseInertia(J=2.2) 
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
  Modelica.Mechanics.Rotational.Examples.Utilities.SpringDamper 
    springDamper(c=1e4, d=100) 
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia2a(
    J=1.1, 
    phi(fixed=true, start=0), 
    w(fixed=true, start=0)) 
    annotation (Placement(transformation(extent={{-30,-20},{-10,0}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque2 
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  Components.TorqueToAngleAdaptor 
    torqueToAngle2a(use_a=false) 
    annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia2b(
    J=2.2, 
    phi(fixed=true, start=0), 
    w(fixed=true, start=0)) 
    annotation (Placement(transformation(extent={{70,-20},{90,0}})));
  Components.TorqueToAngleAdaptor 
    torqueToAngle2b(use_a=false) 
    annotation (Placement(transformation(extent={{70,-20},{50,0}})));
  Modelica.Mechanics.Rotational.Examples.Utilities.Spring spring(c=1e4) 
    annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia3a(
    J=1.1, 
    phi(fixed=true, start=0), 
    w(fixed=true, start=0)) annotation (Placement(transformation(extent= 
           {{-30,-80},{-10,-60}})));
  Modelica.Mechanics.Rotational.Sources.Torque   force3 
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  Components.TorqueToAngleAdaptor 
    torqueToAngle3a(use_w=false, use_a=false) 
    annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia3b(
    J=2.2, 
    phi(fixed=true, start=0), 
    w(fixed=true, start=0)) 
    annotation (Placement(transformation(extent={{70,-80},{90,-60}})));
  Components.TorqueToAngleAdaptor 
    torqueToAngle3b(use_w=false, use_a=false) 
    annotation (Placement(transformation(extent={{70,-80},{50,-60}})));
equation
  connect(sine1.y, directInertia.tauDrive) 
    annotation (Line(points={{-79,50},{-2,50}}, color={0,0,127}));
  connect(directInertia.phi, inverseInertia.phi) 
    annotation (Line(points={{21,58},{38,58}}, color={0,0,127}));
  connect(directInertia.w, inverseInertia.w) 
    annotation (Line(points={{21,53},{38,53}}, color={0,0,127}));
  connect(directInertia.a, inverseInertia.a) 
    annotation (Line(points={{21,47},{38,47}}, color={0,0,127}));
  connect(inverseInertia.tau, directInertia.tau) 
    annotation (Line(points={{39,42},{22,42}}, color={0,0,127}));
  connect(sine1.y, torque2.tau) annotation (Line(points={{-79,50},{-70, 
          50},{-70,-10},{-62,-10}}, color={0,0,127}));
  connect(sine1.y, force3.tau) annotation (Line(points={{-79,50},{-70, 
          50},{-70,-70},{-62,-70}}, color={0,0,127}));
  connect(torqueToAngle2b.flange, inertia2b.flange_a) 
    annotation (Line(points={{62,-10},{70,-10}}));
  connect(inertia2a.flange_b, torqueToAngle2a.flange) 
    annotation (Line(points={{-10,-10},{-2,-10}}));
  connect(torque2.flange, inertia2a.flange_a) 
    annotation (Line(points={{-40,-10},{-30,-10}}));
  connect(inertia3a.flange_b, torqueToAngle3a.flange) 
    annotation (Line(points={{-10,-70},{-2,-70}}));
  connect(force3.flange, inertia3a.flange_a) 
    annotation (Line(points={{-40,-70},{-30,-70}}));
  connect(torqueToAngle3b.flange, inertia3b.flange_a) 
    annotation (Line(points={{62,-70},{70,-70}}));
  connect(torqueToAngle2a.phi, springDamper.phi1) 
    annotation (Line(points={{3,-2},{18,-2}}, color={0,0,127}));
  connect(torqueToAngle2a.w, springDamper.w1) annotation (Line(points={{3, 
          -7},{10.5,-7},{10.5,-7},{18,-7}}, color={0,0,127}));
  connect(torqueToAngle2a.tau, springDamper.tau1) 
    annotation (Line(points={{4,-18},{19,-18}}, color={0,0,127}));
  connect(springDamper.tau2, torqueToAngle2b.tau) 
    annotation (Line(points={{41,-18},{56,-18}}, color={0,0,127}));
  connect(springDamper.phi2, torqueToAngle2b.phi) 
    annotation (Line(points={{42,-2},{57,-2}}, color={0,0,127}));
  connect(springDamper.w2, torqueToAngle2b.w) annotation (Line(points={{42, 
          -7},{50,-7},{50,-7},{57,-7}}, color={0,0,127}));
  connect(torqueToAngle3a.phi, spring.phi1) 
    annotation (Line(points={{3,-62},{18,-62}}, color={0,0,127}));
  connect(torqueToAngle3a.tau, spring.tau1) 
    annotation (Line(points={{4,-78},{19,-78}}, color={0,0,127}));
  connect(spring.phi2, torqueToAngle3b.phi) 
    annotation (Line(points={{42,-62},{57,-62}}, color={0,0,127}));
  connect(spring.tau2, torqueToAngle3b.tau) 
    annotation (Line(points={{41,-78},{56,-78}}, color={0,0,127}));
  annotation (experiment(StopTime=1, Interval=0.001), Documentation(info="<html>
<p>
  本示例演示如何从各种转动组件生成输入/输出块(例如，以FMU形式 - <a href=\"https://fmi-standard.org\">Function Mock-up Unit</a>)。
  本案例的内容是从Modelica导出这样一个输入/输出块，并在另一个建模环境中导入它。
  解决这个问题的关键是问题是在导出之前必须知道组件在目标环境中的使用方式。
  根据目标使用情况，接口中需要具有不同输入或输出因果关系的不同变量。
  请注意，此示例模型可用于测试Modelica工具的FMU导出/导入。
  只需导出图标中标记为“toFMU”的组件作为FMU，然后重新导入它们。
  模型应该仍然可以工作，并且给出与纯Modelica模型相同的结果。
</p>

<p>
  <strong>连接两个一维惯性转动组件</strong><br>
  上半部分(DirectInertia，InverseInertia)演示了如何导出两个一维惯性转动组件并将它们连接在一起导入到目标系统中。
  这要求其中一个一维惯性转动组件(这里是：DirectInertia)被定义为具有状态，并且在接口中提供角度、角速度和角加速度。
  另一个质量(这里是：InverseInertia)根据提供的输入角度、角速度和角加速度的值进行运动。
</p>

<p>
  <strong>连接所需要角度和角速度的力元件</strong><br>
  中间部分(SpringDamper)演示了如何导出一个需要角度和角速度的力元件，用于其力学规律，并将此力学规律在目标系统中连接两个一维惯性转动组件之间。
</p>

<p>
  <strong>连接只需要角度的力元件</strong><br>
  下半部分(Spring)演示了如何导出一个只需要角度的力元件，用于其力学规律，并将此力学规律在目标系统中连接两个一维惯性转动组件之间。
</p>

</html>"));
end GenerationOfFMUs;