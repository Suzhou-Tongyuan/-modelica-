within Modelica.Mechanics.Rotational.Examples;
model OneWayClutch "带有主动控制单向离合器的传动系统"

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
  Modelica.Blocks.Sources.Sine signalTorque(
    amplitude=10, 
    f=3) annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Sources.Pulse signalEngagement(
    amplitude=1, 
    width=50, 
    period=1.3, 
    startTime=0.3) annotation (Placement(transformation(extent={{-20,30},{0,50}})));
equation
  connect(torque.flange, inertiaIn.flange_a) annotation (Line(points={{-30,0},{-20,0}}));
  connect(signalTorque.y, torque.tau) annotation (Line(points={{-59,0},{-52,0}}, color={0,0,127}));
  connect(inertiaIn.flange_b, oneWayClutch.flange_a) annotation (Line(points={{0,0},{10,0}}));
  connect(oneWayClutch.flange_b, inertiaOut.flange_a) annotation (Line(points={{30,0},{40,0}}));
  connect(signalEngagement.y, oneWayClutch.f_normalized) annotation (Line(points={{1,40},{20,40},{20,11}}, color={0,0,127}));
  annotation (
    experiment(StopTime=2, Interval=0.001), Documentation(info="<html><p>
传动系统由单向离合器、驱动一维惯性组件和被动一维惯性组件组成。 单向离合器周期性地参与，强制使两个一维惯性组件的旋转速度匹配。 当单向离合器解除连接时，只有单向离合器的自由轮功能可用，并且只要相对角速度 w_rel 变为零，该功能就会处于活动状态。
</p>
<p>
模拟 2 秒并比较一维惯性组件之间的速度 <code>inertiaIn.w</code> 和 <code>inertiaOut.w</code>。 还要检查离合器的参与情况 <code>oneWayClutch.f_normalized</code> 和其损耗功率 <code>oneWayClutch.lossPower</code>。
</p>
</html>"));
end OneWayClutch;