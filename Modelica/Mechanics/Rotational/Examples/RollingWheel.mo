within Modelica.Mechanics.Rotational.Examples;
model RollingWheel "演示旋转 - 平移耦合"
  extends Modelica.Icons.Example;
  Rotational.Components.IdealRollingWheel idealRollingWheel(radius=1) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Rotational.Components.Inertia inertia(
    J=1, 
    phi(fixed=true, start=0), 
    w(fixed=true, start=0)) 
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Rotational.Sources.TorqueStep torqueStep(
    stepTorque=10, 
    offsetTorque=0, 
    startTime=0.1, 
    useSupport=false) 
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Translational.Components.Mass mass(L=0, m=1) 
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Translational.Sources.QuadraticSpeedDependentForce 
    quadraticSpeedDependentForce(
    f_nominal=-10, 
    ForceDirection=false, 
    v_nominal=5) 
    annotation (Placement(transformation(extent={{72,-10},{52,10}})));
equation

  connect(torqueStep.flange, inertia.flange_a) annotation (Line(
      points={{-50,0},{-40,0}}));
  connect(inertia.flange_b, idealRollingWheel.flangeR) annotation (Line(
      points={{-20,0},{-10,0}}));
  connect(idealRollingWheel.flangeT, mass.flange_a) annotation (Line(
      points={{10,0},{20,0}}, color={0,127,0}));
  connect(quadraticSpeedDependentForce.flange, mass.flange_b) annotation (
      Line(
      points={{52,0},{40,0}}, color={0,127,0}));
  annotation (Documentation(info="<html>
<p>
这个模型演示了旋转和平移组件之间的耦合：<br>
一个扭矩（阶跃）会加速滚轮的惯性和车辆的质量。<br>
由于速度相关的力（如行驶阻力），在约5秒后在5 m/s处达到了一个平衡点。
</p>

</html>"), 
       experiment(StopTime=5.0, Interval=0.001));
end RollingWheel;