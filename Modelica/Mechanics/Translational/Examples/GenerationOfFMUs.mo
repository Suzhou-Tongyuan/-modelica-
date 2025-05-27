within Modelica.Mechanics.Translational.Examples;
model GenerationOfFMUs 
  "示例演示生成FMUs（Functional Mock-up Units）的变体"
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Sine sine1(f=2, amplitude=10) 
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Mechanics.Translational.Examples.Utilities.DirectMass directMass(
      m=1.1) annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Modelica.Mechanics.Translational.Examples.Utilities.InverseMass 
    inverseMass(m=2.2) 
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
  Modelica.Mechanics.Translational.Examples.Utilities.SpringDamper 
    springDamper(c=1e4, d=100) 
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  Modelica.Mechanics.Translational.Components.Mass mass2a(
    m=1.1, 
    s(fixed=true, start=0), 
    v(fixed=true, start=0)) 
    annotation (Placement(transformation(extent={{-30,-20},{-10,0}})));
  Modelica.Mechanics.Translational.Sources.Force force2 
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  Modelica.Mechanics.Translational.Components.GeneralForceToPositionAdaptor forceToPosition2a(use_pder2=false) 
    annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
  Modelica.Mechanics.Translational.Components.Mass mass2b(
    m=2.2, 
    s(fixed=true, start=0), 
    v(fixed=true, start=0)) 
    annotation (Placement(transformation(extent={{70,-20},{90,0}})));
  Modelica.Mechanics.Translational.Components.GeneralForceToPositionAdaptor forceToPosition2b(use_pder2=false) 
    annotation (Placement(transformation(extent={{70,-20},{50,0}})));
  Modelica.Mechanics.Translational.Examples.Utilities.Spring spring(c=1e4) 
    annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
  Modelica.Mechanics.Translational.Components.Mass mass3a(
    m=1.1, 
    s(fixed=true, start=0), 
    v(fixed=true, start=0)) 
    annotation (Placement(transformation(extent={{-30,-80},{-10,-60}})));
  Modelica.Mechanics.Translational.Sources.Force force3 
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  Modelica.Mechanics.Translational.Components.GeneralForceToPositionAdaptor forceToPosition3a(use_pder=false, use_pder2=false) 
    annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
  Modelica.Mechanics.Translational.Components.Mass mass3b(
    m=2.2, 
    s(fixed=true, start=0), 
    v(fixed=true, start=0)) 
    annotation (Placement(transformation(extent={{70,-80},{90,-60}})));
  Modelica.Mechanics.Translational.Components.GeneralForceToPositionAdaptor forceToPosition3b(use_pder=false, use_pder2=false) 
    annotation (Placement(transformation(extent={{70,-80},{50,-60}})));
equation
  connect(sine1.y, directMass.fDrive) 
    annotation (Line(points={{-79,50},{-2,50}},  color={0,0,127}));
  connect(directMass.s, inverseMass.s) 
    annotation (Line(points={{21,58},{38,58}},color={0,0,127}));
  connect(directMass.v,inverseMass.v) 
    annotation (Line(points={{21,53},{30,53},{30,55},{38,55}}, 
                                              color={0,0,127}));
  connect(directMass.a, inverseMass.a) 
    annotation (Line(points={{21,47},{30,47},{30,45},{38,45}}, 
                                              color={0,0,127}));
  connect(inverseMass.f, directMass.f) 
    annotation (Line(points={{39,42},{22,42}}, color={0,0,127}));
  connect(force2.flange, mass2a.flange_a) 
    annotation (Line(points={{-40,-10},{-30,-10}}, color={0,127,0}));
  connect(mass2a.flange_b, forceToPosition2a.flange) 
    annotation (Line(points={{-10,-10},{-2,-10}},  color={0,127,0}));
  connect(forceToPosition2b.flange, mass2b.flange_a) 
    annotation (Line(points={{62,-10},{70,-10}}, color={0,127,0}));
  connect(force3.flange, mass3a.flange_a) 
    annotation (Line(points={{-40,-70},{-30,-70}}, color={0,127,0}));
  connect(mass3a.flange_b, forceToPosition3a.flange) 
    annotation (Line(points={{-10,-70},{-2,-70}},  color={0,127,0}));
  connect(forceToPosition3b.flange, mass3b.flange_a) 
    annotation (Line(points={{62,-70},{70,-70}}, color={0,127,0}));
  connect(forceToPosition2a.f, springDamper.f1) 
    annotation (Line(points={{3,-18},{19,-18}}, color={0,0,127}));
  connect(springDamper.f2, forceToPosition2b.f) 
    annotation (Line(points={{41,-18},{57,-18}}, color={0,0,127}));
  connect(forceToPosition3a.f, spring.f1) 
    annotation (Line(points={{3,-78},{19,-78}}, color={0,0,127}));
  connect(spring.f2, forceToPosition3b.f) 
    annotation (Line(points={{41,-78},{57,-78}}, color={0,0,127}));
  connect(forceToPosition3a.p, spring.s1) 
    annotation (Line(points={{3,-62},{18,-62}}, color={0,0,127}));
  connect(spring.s2, forceToPosition3b.p) 
    annotation (Line(points={{42,-62},{57,-62}}, color={0,0,127}));
  connect(forceToPosition2a.p, springDamper.s1) 
    annotation (Line(points={{3,-2},{18,-2}}, color={0,0,127}));
  connect(forceToPosition2a.pder, springDamper.v1) annotation (Line(
        points={{3,-5},{10,-5},{10,-5},{18,-5}}, 
                                               color={0,0,127}));
  connect(springDamper.s2, forceToPosition2b.p) 
    annotation (Line(points={{42,-2},{57,-2}}, color={0,0,127}));
  connect(forceToPosition2b.pder, springDamper.v2) annotation (Line(
        points={{57,-5},{50,-5},{50,-5},{42,-5}}, color={0,0,127}));
  connect(sine1.y, force2.f) annotation (Line(points={{-79,50},{-70,50}, 
          {-70,-10},{-62,-10}}, color={0,0,127}));
  connect(sine1.y, force3.f) annotation (Line(points={{-79,50},{-70,50}, 
          {-70,-70},{-62,-70}}, color={0,0,127}));
  annotation (experiment(StopTime=1, Interval=0.001), Documentation(info="<html>
<p>
这个例子演示了如何从各种平移组件生成输入/输出块（例如FMU - <a href=\"https://fmi-standard.org\">Functional Mock-up Unit</a>）。
本案例的目的是从Modelica导出这样的输入/输出块，并在另一个建模环境中导入它。
要实现这个问题的关键在于，在导出之前必须知道组件在目标环境中的使用方式。
根据目标使用方式，接口中需要不同的一维平动接口变量，具有输入或输出的因果关系。
请注意，此示例模型可用于测试Modelica工具的FMU导出/导入。只需将标记为图标中的组件“toFMU”导出为FMU，然后重新导入。
然后，模型应该仍然正常工作，并给出与纯Modelica模型相同的结果。
</p>

<p>
<strong>连接两个质量块</strong><br>
上半部分（DirectMass，InverseMass）演示了如何导出两个质量块并将它们在目标系统中连接在一起
这其中一个质量块（这里定义为：DirectMass）
被定义为具有状态，位置，速度和加速度。
上述状态均可在质量块的接口中得到。
另一个质量块（这里：InverseMass）根据给定的输入位置，速度和加速度移动。
</p>

<p>
<strong>连接需要位置和速度的力元件</strong><br>
中间部分（SpringDamper）演示了如何导出一个力元件
其力律需要位置和速度，并将此力律在目标系统中的两个质量块之间连接。
</p>

<p>
<strong>连接只需要位置的力元件</strong><br>
下半部分（Spring）演示了如何导出一个力元件
其力律仅需要位置，并将此力律在目标系统中两个质量块之间连接。
</p>
</html>"));
end GenerationOfFMUs;