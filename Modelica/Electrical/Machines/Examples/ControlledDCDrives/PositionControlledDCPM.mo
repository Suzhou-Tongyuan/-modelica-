within Modelica.Electrical.Machines.Examples.ControlledDCDrives;
model PositionControlledDCPM 
  "带有电池H桥的位置控制永磁直流电机驱动"
  extends Utilities.PartialControlledDCPM;
  Modelica.Mechanics.Rotational.Sources.TorqueStep loadTorque(
    stepTorque=-driveData.tauNominal, 
    offsetTorque=0, 
    startTime=2.3) 
    annotation (Placement(transformation(extent={{100,-50},{80,-30}})));
  Utilities.LimitedPI speedController(
    initType=Modelica.Blocks.Types.Init.InitialOutput, 
    k=driveData.kpw, 
    Ti=driveData.Tiw, 
    constantLimits=true, 
    yMax=driveData.tauMax) 
    annotation (Placement(transformation(extent={{-120,-20},{-100,0}})));
  Utilities.LimitedPI positionController(
    constantLimits=true, 
    k=driveData.kpP, 
    useI=false, 
    yMax=driveData.wMax, 
    initType=Modelica.Blocks.Types.Init.SteadyState) 
    annotation (Placement(transformation(extent={{-150,-20},{-130,0}})));
  Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={70,-70})));
  Modelica.Blocks.Sources.KinematicPTP2 kinematicPTP(
    qd_max={driveData.wMax}, 
    qdd_max={driveData.aMax}, 
    q_end={200}, 
    startTime=0.2) 
                 annotation (Placement(transformation(
        extent={{10,10},{-10,-10}}, 
        rotation=180, 
        origin={-180,-10})));
equation
  connect(positionController.y, speedController.u) 
    annotation (Line(points={{-129,-10},{-122,-10}}, 
                                                 color={0,0,127}));
  connect(angleSensor.phi, positionController.u_m) annotation (Line(
        points={{70,-81},{70,-100},{-146,-100},{-146,-22}}, 
                                                       color={0,0,127}));
  connect(kinematicPTP.q[1], positionController.u) annotation (Line(
        points={{-169,-2},{-160,-2},{-160,-10},{-152,-10}}, 
                                                      color={0,0,127}));
  connect(speedSensor.flange, angleSensor.flange) 
    annotation (Line(points={{50,-60},{70,-60}}));
  connect(speedSensor.w, speedController.u_m) annotation (Line(points={{50,-81}, 
          {50,-90},{-116,-90},{-116,-22}},   color={0,0,127}));
  connect(loadInertia.flange_b, loadTorque.flange) 
    annotation (Line(points={{70,-40},{80,-40}}));
  connect(speedController.y, tau2i.u) 
    annotation (Line(points={{-99,-10},{-82,-10}}, 
                                                 color={0,0,127}));
  annotation (experiment(StopTime=2.5, Interval=0.0001), 
                                                       Documentation(info="<html>
<p>该模型演示了用于速度控制的直流永磁电机驱动的位置控制器的工作原理。</p>
<p>
内部电流控制器根据绝对最佳值进行参数化。
中间控制回路由速度控制器形成，速度控制器根据对称最佳值进行参数化。
外部控制回路由位置控制器形成，位置控制器根据参数化以避免位置超调。
</p>
<p>
在时间=0.2s时，kinematicPTP开始以有限的速度和有限的加速度指定参考位置。
在时间=2.3s时，施加一个负载转矩阶跃，导致驱动器略微离开结束位置，直到位置控制器将驱动器带回到期望位置。
</p>
<p>
进一步阅读：
<a href=\"modelica://Modelica/Resources/Documentation/Electrical/Machines/DriveControl.pdf\">2017 Modelica会议上的教程</a>
</p>
</html>"), 
    Diagram(coordinateSystem(extent={{-200,-100},{100,100}})));
end PositionControlledDCPM;