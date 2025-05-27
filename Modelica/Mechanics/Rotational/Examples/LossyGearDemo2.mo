within Modelica.Mechanics.Rotational.Examples;
model LossyGearDemo2 
  "演示LossyGear和BearingFriction组合的示例"
  extends Modelica.Icons.Example;
  SI.Power PowerLoss=gear.flange_a.tau*der(gear.flange_a.phi) + gear.flange_b.tau 
      *der(gear.flange_b.phi) "齿轮中的功率损失";

  Rotational.Components.LossyGear gear(
    ratio=2, 
    lossTable=[0, 0.5, 0.5, 0, 0], 
    useSupport=true) annotation (Placement(transformation(extent={{-20,0},{
            0,20}})));
  Rotational.Components.Inertia Inertia1(J=1) annotation (Placement(
        transformation(extent={{-50,0},{-30,20}})));
  Rotational.Components.Inertia Inertia2(
    J=1.5, 
    phi(fixed=true, start=0, nominal=1e-4), 
    w(fixed=true, start=0, nominal=0.001)) annotation (Placement(transformation(extent={{
            10,0},{30,20}})));
  Rotational.Sources.Torque torque1(useSupport=true) annotation (Placement(
        transformation(extent={{-110,0},{-90,20}})));
  Rotational.Sources.Torque torque2(useSupport=true) annotation (Placement(
        transformation(extent={{60,0},{40,20}})));
  Modelica.Blocks.Sources.Sine DriveSine(amplitude=10, f=1) 
    annotation (Placement(transformation(extent={{-140,0},{-120,20}})));
  Modelica.Blocks.Sources.Ramp load(
    height=5, 
    duration=2, 
    offset=-10) annotation (Placement(transformation(extent={{90,0},{70,20}})));
  Rotational.Components.BearingFriction bearingFriction(tau_pos=[0, 0.5; 1,
        1], useSupport=true) annotation (Placement(transformation(extent={{
            -80,0},{-60,20}})));
  Rotational.Components.Fixed fixed annotation (Placement(transformation(
          extent={{-20,-30},{0,-10}})));
equation
  connect(torque2.flange, Inertia2.flange_b) 
    annotation (Line(points={{40,10},{30,10}}));
  connect(Inertia2.flange_a, gear.flange_b) 
    annotation (Line(points={{10,10},{0,10}}));
  connect(gear.flange_a, Inertia1.flange_b) 
    annotation (Line(points={{-20,10},{-30,10}}));
  connect(Inertia1.flange_a, bearingFriction.flange_b) 
    annotation (Line(points={{-50,10},{-60,10}}));
  connect(bearingFriction.flange_a, torque1.flange) 
    annotation (Line(points={{-80,10},{-80,10},{-90,10}}));
  connect(DriveSine.y, torque1.tau) annotation (Line(points={{-119,10},{-119, 
          10},{-112,10}}, color={0,0,127}));
  connect(load.y, torque2.tau) 
    annotation (Line(points={{69,10},{62,10}}, color={0,0,127}));
  connect(gear.support, fixed.flange) 
    annotation (Line(points={{-10,0},{-10,-20}}));
  connect(fixed.flange, torque2.support) 
    annotation (Line(points={{-10,-20},{50,-20},{50,0}}));
  connect(fixed.flange, bearingFriction.support) 
    annotation (Line(points={{-10,-20},{-70,-20},{-70,0}}));
  connect(torque1.support, fixed.flange) annotation (Line(points={{-100,0}, 
          {-100,-20},{-10,-20}}));
  annotation (
    Diagram(coordinateSystem(extent={{-140,-100},{100,100}})), 
    Documentation(info="<html><p>
这个模型包含轴承摩擦和齿轮摩擦（=效率）。 如果两种摩擦模型都卡滞，那么就没有唯一的解决方案。 但是，一个可靠的Modelica求解器应该能够解决这种情况。
</p>
<p>
模拟约0.5秒。摩擦元件处于所有模式（前进和后退滚动，以及卡滞）。
</p>
<p>
可绘制如下参数：
</p>
<pre><code >Inertia1.w,
Inertia2.w          : angular velocities of inertias
powerLoss           : power lost in the gear
bearingFriction.mode:  1 = forward rolling
0 = stuck (w=0)
-1 = backward rolling
gear.mode           :  1 = forward rolling
0 = stuck (w=0)
-1 = backward rolling
</code></pre><p>
注意，<code>powerLoss</code>（=连接器的功率流之和）和 <code>gear.powerLoss</code>（= <code>gear.tau_loss</code>*<code>gear.w_a</code>， 其中<code>gear.tau_loss</code>以非平凡的方式从轴承和齿摩擦的卡滑情况确定； = [<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.References\" target=\"\">Pelchen2002</a>]中的方程（16）） 应该是相同的，或者差异应该接近零，如果模型 <a href=\"modelica://Modelica.Mechanics.Rotational.Components.LossyGear\" target=\"\">LossyGear</a> 被正确实现。
</p>
<p>
注意：不建议使用LossyGear和BearingFriction的这种组合， 因为组件LossyGear包含了组件BearingFriction的功能 （除了<em>peak</em>外）。
</p>
<p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"), 
       experiment(StopTime=0.5, Interval=0.001));
end LossyGearDemo2;