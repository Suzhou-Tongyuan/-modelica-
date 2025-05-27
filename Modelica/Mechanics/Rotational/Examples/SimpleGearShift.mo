within Modelica.Mechanics.Rotational.Examples;
model SimpleGearShift "简单换挡器"
extends Modelica.Icons.Example;
  output SI.AngularVelocity wEngine=engine.w 
    "发动机转速";
  output SI.AngularVelocity wLoad=load.w "负载转速";
  output Real gearRatio=wLoad/max(wEngine, 1E-6) "齿轮比（负载/发动机）";
  Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStep(
    offsetTorque=0, 
    startTime=0.5, 
    stepTorque=20) 
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  Modelica.Mechanics.Rotational.Components.Inertia engine(J=1) 
    annotation (Placement(transformation(extent={{-50,-20},{-30,0}})));
  Modelica.Mechanics.Rotational.Components.IdealPlanetary idealPlanetary(
      ratio=75/50) 
    annotation (Placement(transformation(extent={{-10,0},{10,-20}})));
  Modelica.Mechanics.Rotational.Components.Inertia load(
    J=10, 
    phi(fixed=true, start=0), 
    w(fixed=true, start=0)) 
    annotation (Placement(transformation(extent={{30,-20},{50,0}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque 
    quadraticSpeedDependentTorque(w_nominal(displayUnit="rpm")= 
      10.471975511966, tau_nominal=-20) 
    annotation (Placement(transformation(extent={{80,-20},{60,0}})));
  Modelica.Mechanics.Rotational.Components.Clutch clutch(
    cgeo=2, 
    fn_max=100, 
    phi_rel(fixed=true), 
    w_rel(fixed=true)) 
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  Modelica.Mechanics.Rotational.Components.Brake brake(cgeo=2, fn_max=100) 
    annotation (Placement(transformation(extent={{20,10},{40,30}})));
  Modelica.Blocks.Math.Feedback feedback 
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  Modelica.Blocks.Sources.Constant const1(k=1) 
    annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=1, 
    offset=0, 
    startTime=2, 
    duration=0.1) 
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
equation
  connect(torqueStep.flange, engine.flange_a) annotation (Line(
      points={{-60,-10},{-50,-10}}));
  connect(quadraticSpeedDependentTorque.flange, load.flange_b) annotation (
      Line(
      points={{60,-10},{50,-10}}));
  connect(feedback.y, brake.f_normalized) annotation (Line(
      points={{9,60},{30,60},{30,31}}, color={0,0,127}));
  connect(engine.flange_b, idealPlanetary.sun) annotation (Line(
      points={{-30,-10},{-10,-10}}));
  connect(idealPlanetary.sun, clutch.flange_a) annotation (Line(
      points={{-10,-10},{-10,20}}));
  connect(idealPlanetary.ring, clutch.flange_b) annotation (Line(
      points={{10,-10},{10,20}}));
  connect(idealPlanetary.ring, brake.flange_a) annotation (Line(
      points={{10,-10},{20,-10},{20,20}}));
  connect(idealPlanetary.carrier, load.flange_a) annotation (Line(
      points={{-10,-14},{-20,-14},{-20,-30},{30,-30},{30,-10}}));
  connect(const1.y, feedback.u1) annotation (Line(
      points={{-19,60},{-8,60}}, color={0,0,127}));
  connect(feedback.u2, clutch.f_normalized) annotation (Line(
      points={{0,52},{0,31}}, color={0,0,127}));
  connect(ramp.y, clutch.f_normalized) annotation (Line(
      points={{-39,40},{0,40},{0,31}}, color={0,0,127}));
  annotation (experiment(StopTime=5, Interval=0.01), Documentation(info="<html><p>
这个模型演示了如何从行星齿轮、刹车和离合器构建自动换挡器。
</p>
<ul><li>
在开始时，离合器处于自由状态，刹车固定行星的环。因此，我们得到一个传动比 = 1/(1 + 行星传动比)。</li>
<li>
在时间 = 2 秒时，刹车释放了行星的环，而离合器则阻止了环和太阳轮。因此，我们得到一个传动比 = 1。</li>
</ul></html>"));
end SimpleGearShift;