within Modelica.Mechanics.Rotational.Examples;
model OneWayClutchDisengaged "带有控制连接的单向离合器的传动系统"

  extends Modelica.Icons.Example;

  Modelica.Mechanics.Rotational.Components.Inertia inertiaIn(
    J=1, 
    phi(fixed=true, start=0), 
    w(fixed=true, start=-0.5)) annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertiaOut(
    J=1, 
    phi(fixed=true, start=0), 
    w(fixed=true, start=0)) annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Mechanics.Rotational.Components.OneWayClutch oneWayClutch(
    peak=25, 
    fn_max=3, 
    startForward(fixed=true), 
    stuck(fixed=true)) annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque 
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Mechanics.Rotational.Sources.ConstantTorque torqueLoad(tau_constant=-0.3) annotation (Placement(transformation(extent={{90,-10},{70,10}})));
  Modelica.Blocks.Sources.Sine signalTorque(
    amplitude=10, 
    offset=-torqueLoad.tau_constant, 
    f=2) annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Sources.Constant signalEngagement(k=0) 
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
equation
  connect(torque.flange, inertiaIn.flange_a) annotation (Line(points={{-30,0},{-20,0}}));
  connect(signalTorque.y, torque.tau) annotation (Line(points={{-59,0},{-52,0}}, color={0,0,127}));
  connect(inertiaIn.flange_b, oneWayClutch.flange_a) annotation (Line(points={{0,0},{10,0}}));
  connect(oneWayClutch.flange_b, inertiaOut.flange_a) annotation (Line(points={{30,0},{40,0}}));
  connect(signalEngagement.y, oneWayClutch.f_normalized) annotation (Line(points={{1,40},{20,40},{20,11}}, color={0,0,127}));
  connect(inertiaOut.flange_b, torqueLoad.flange) annotation (Line(points={{60,0},{70,0}}));
  annotation (
    experiment(StopTime=2, Interval=0.001), Documentation(info="<html><p>
传动系统由单向离合器、驱动一维惯性组件和被动一维惯性组件组成。 为了演示单向离合器仅自由轮的行为，离合器始终保持解除连接状态。 在驱动一维惯性组件上施加正弦变化的扭矩，强制使一维惯性组件的速度发生变化。 在被动侧仅施加恒定的载荷扭矩。
</p>
<p>
模拟 2 秒并比较一维惯性组件之间的速度 <code>inertiaIn.w</code> 和 <code>inertiaOut.w</code>。
</p>
</html>"));
end OneWayClutchDisengaged;