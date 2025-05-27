within Modelica.Mechanics.Translational.Examples;
model Brake "演示一个平移运动质量块的制动"
  extends Modelica.Icons.Example;

  Modelica.Mechanics.Translational.Components.Brake brake(fn_max=1, 
      useSupport=false) 
    annotation (Placement(transformation(extent={{0,50},{20,30}})));
  Modelica.Mechanics.Translational.Components.Mass mass1(
    m=1, 
    s(fixed=true), 
    v(start=1, fixed=true)) 
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Modelica.Blocks.Sources.Step step(startTime=0.1, height=2) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        origin={-30,0})));
  Modelica.Mechanics.Translational.Components.Brake brake1(fn_max=1, 
      useSupport=true) 
    annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
  Modelica.Mechanics.Translational.Components.Mass mass2(
    m=1, 
    s(fixed=true), 
    v(start=1, fixed=true)) 
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  Modelica.Mechanics.Translational.Components.Fixed fixed 
    annotation (Placement(transformation(extent={{0,-70},{20,-50}})));
equation
  connect(mass1.flange_b, brake.flange_a) annotation (Line(
      points={{-20,40},{0,40}}, color={0,127,0}));
  connect(step.y, brake.f_normalized) annotation (Line(
      points={{-19,0},{10,0},{10,29}},     color={0,0,127}));
  connect(mass2.flange_b, brake1.flange_a) annotation (Line(
      points={{-20,-40},{0,-40}}, color={0,127,0}));
  connect(step.y, brake1.f_normalized) annotation (Line(
      points={{-19,0},{10,0},{10,-29}},     color={0,0,127}));
  connect(fixed.flange, brake1.support) annotation (Line(
      points={{10,-60},{10,-50}}, color={0,127,0}));
  annotation (Documentation(info="<html>
<p>
这个模型由一个具有初始速度为1&nbsp;m/s的质量块组成。
0.1&nbsp;s后，一个制动器被激活，并且显示质量减速直到它停止并保持静止。
该系统有两个版本，
一个是制动器被隐式的接地，另一个是被显式的接地。
</p>
</html>"), 
       experiment(StopTime=2.0, Interval=0.001));
end Brake;