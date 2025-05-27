within Modelica.Mechanics.Rotational.Examples;
model LossyGearDemo1 
  "演示高效率齿轮可能导致运动卡滞的示例"
  extends Modelica.Icons.Example;
  SI.Power PowerLoss=gear.flange_a.tau*der(gear.flange_a.phi) + gear.flange_b.tau 
      *der(gear.flange_b.phi) "齿轮损失的功率";
  Rotational.Components.LossyGear gear(
    ratio=2, 
    lossTable=[0, 0.5, 0.5, 0, 0], 
    useSupport=true) annotation (Placement(transformation(extent={{-10,0},{
            10,20}})));

  Rotational.Components.Inertia Inertia1(J=1) annotation (Placement(
        transformation(extent={{-40,0},{-20,20}})));
  Rotational.Components.Inertia Inertia2(
    J=1.5, 
    phi(fixed=true, start=0, nominal=0.001), 
    w(fixed=true, start=0, nominal=0.01)) annotation (Placement(transformation(extent={{
            20,0},{40,20}})));
  Rotational.Sources.Torque torque1(useSupport=true) annotation (Placement(
        transformation(extent={{-70,0},{-50,20}})));
  Rotational.Sources.Torque torque2(useSupport=true) annotation (Placement(
        transformation(extent={{70,0},{50,20}})));
  Modelica.Blocks.Sources.Sine DriveSine(amplitude=10, f=1) 
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Sources.Ramp load(
    height=5, 
    duration=2, 
    offset=-10) annotation (Placement(transformation(extent={{100,0},{80,20}})));
  Rotational.Components.Fixed fixed annotation (Placement(transformation(
          extent={{-10,-30},{10,-10}})));
equation
  connect(Inertia1.flange_b, gear.flange_a) 
    annotation (Line(points={{-20,10},{-10,10}}));
  connect(gear.flange_b, Inertia2.flange_a) 
    annotation (Line(points={{10,10},{20,10}}));
  connect(torque1.flange, Inertia1.flange_a) 
    annotation (Line(points={{-50,10},{-40,10}}));
  connect(torque2.flange, Inertia2.flange_b) 
    annotation (Line(points={{50,10},{40,10}}));
  connect(DriveSine.y, torque1.tau) 
    annotation (Line(points={{-79,10},{-72,10}}, color={0,0,127}));
  connect(load.y, torque2.tau) 
    annotation (Line(points={{79,10},{72,10}}, color={0,0,127}));
  connect(fixed.flange, gear.support) 
    annotation (Line(points={{0,-20},{0,0}}));
  connect(fixed.flange, torque1.support) 
    annotation (Line(points={{0,-20},{-60,-20},{-60,0}}));
  connect(fixed.flange, torque2.support) 
    annotation (Line(points={{0,-20},{60,-20},{60,0}}));
  annotation (Documentation(info="<html><p>
此模型包含两个一维转动惯性组件，它们通过一个理想齿轮连接， 其中轮齿之间的摩擦以物理上有意义的方式建模（摩擦可能导致卡滞模式，锁定齿轮的运动）。摩擦由效率因子（= 0.5）定义，适用于正向和反向驱动条件，导致扭矩相关的摩擦损失。 模拟约0.5秒。 齿轮中的摩擦将采取所有模式（前进和后退滚动，以及卡滞）。
</p>
<p>
您可以绘制：
</p>
<pre><code >Inertia1.w,
Inertia2.w : angular velocities of inertias
powerLoss  : power lost in the gear
gear.mode  :  1 = forward rolling
0 = stuck (w=0)
-1 = backward rolling
</code></pre><p>
注意，如果<a href=\"modelica://Modelica.Mechanics.Rotational.Components.LossyGear\" target=\"\">LossyGear</a>模型被正确实现，那么<code>powerLoss</code>（=连接器的功率流之和）和 <code>gear.powerLoss</code>（= <code>gear.tau_loss</code>*<code>gear.w_a</code>， 其中<code>gear.tau_loss</code> 是通过轴承和齿轮摩擦的卡住/滑动状态以非常规的方式确定的；= [<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.References\" target=\"\">Pelchen2002</a>]中的方程（16））应该是相同的，或者两者差异应该接近零。
</p>
</html>"), 
       experiment(StopTime=0.5, Interval=0.001));
end LossyGearDemo1;