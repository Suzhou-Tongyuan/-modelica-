within Modelica.Mechanics.Translational.Examples;
model Oscillator "在初始条件下演示振荡器的使用"

  extends Modelica.Icons.Example;

  Translational.Components.Mass mass1(
    L=1, 
    s(start=-0.5, fixed=true), 
    v(start=0, fixed=true), 
    m=1) annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Translational.Components.Spring spring1(s_rel0=1, c=10000) annotation (
      Placement(transformation(extent={{20,20},{40,40}})));
  Translational.Components.Fixed fixed1(s0=1) annotation (Placement(
        transformation(extent={{60,20},{80,40}})));
  Translational.Sources.Force force1 annotation (Placement(transformation(
          extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Sources.Sine sine1(f=15.9155) annotation (Placement(
        transformation(extent={{-100,20},{-80,40}})));
  Translational.Components.Mass mass2(
    L=1, 
    s(start=-0.5, fixed=true), 
    v(start=0, fixed=true), 
    m=1) annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Translational.Components.Spring spring2(s_rel0=1, c=10000) annotation (
      Placement(transformation(extent={{20,-50},{40,-30}})));
  Translational.Components.Fixed fixed2(s0=1) annotation (Placement(
        transformation(extent={{60,-40},{80,-20}})));
  Translational.Sources.Force force2 annotation (Placement(transformation(
          extent={{-60,-40},{-40,-20}})));
  Modelica.Blocks.Sources.Sine sine2(f=15.9155) annotation (Placement(
        transformation(extent={{-100,-40},{-80,-20}})));
  Translational.Components.Damper damper1(d=10) annotation (Placement(
        transformation(extent={{20,-30},{40,-10}})));
equation
  connect(mass1.flange_b, spring1.flange_a) 
    annotation (Line(points={{0,30},{20,30}}, color={0,127,0}));
  connect(spring2.flange_a, damper1.flange_a) 
    annotation (Line(points={{20,-40},{10,-40},{10,-20},{20,-20}}, 
                                                 color={0,127,0}));
  connect(mass2.flange_b, spring2.flange_a) 
    annotation (Line(points={{0,-30},{10,-30},{10,-40},{20,-40}}, 
                                                color={0,127,0}));
  connect(damper1.flange_b, spring2.flange_b) 
    annotation (Line(points={{40,-20},{50,-20},{50,-40},{40,-40}}, 
                                                 color={0,127,0}));
  connect(sine1.y, force1.f) 
    annotation (Line(points={{-79,30},{-62,30}}, color={0,0,127}));
  connect(sine2.y, force2.f) 
    annotation (Line(points={{-79,-30},{-62,-30}}, color={0,0,127}));
  connect(spring1.flange_b, fixed1.flange) annotation (Line(
      points={{40,30},{70,30}}, color={0,127,0}));
  connect(force2.flange, mass2.flange_a) annotation (Line(
      points={{-40,-30},{-20,-30}}, color={0,127,0}));
  connect(force1.flange, mass1.flange_a) annotation (Line(
      points={{-40,30},{-20,30}}, color={0,127,0}));
  connect(spring2.flange_b, fixed2.flange) annotation (Line(
      points={{40,-40},{50,-40},{50,-30},{70,-30}}, 
                                  color={0,127,0}));
  annotation (Documentation(info="<html><p>
弹簧-质量系统是一种机械振荡器。如果没有包含阻尼并且系统以共振频率激励， 将产生无限的振幅。谐振频率由以下公式给出： omega_res = sqrt(c / m) 其中：<br><br><br>c … spring stiffness <br>m … mass.<br><br><br>
</p>
<p>
为了确保系统最初处于静止状态，将滑动质量的初始条件设置为 s(start=-0.5) 和 v(start=0)。 如果添加了阻尼，则振幅将受到限制。
</p>
</html>"), 
       experiment(StopTime=1.0, Interval=0.001));
end Oscillator;