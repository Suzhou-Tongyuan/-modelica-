within Modelica.Electrical.Machines.Examples.ControlledDCDrives;
model SpeedControlledDCPM 
  "带有电池H桥的速度控制永磁直流电机驱动"
  extends Utilities.PartialControlledDCPM;
  Modelica.Mechanics.Rotational.Sources.TorqueStep loadTorque(
    stepTorque=-driveData.tauNominal, 
    offsetTorque=0, 
    startTime=0.8) 
    annotation (Placement(transformation(extent={{100,-50},{80,-30}})));
  Utilities.LimitedPI speedController(
    initType=Modelica.Blocks.Types.Init.InitialOutput, 
    k=driveData.kpw, 
    Ti=driveData.Tiw, 
    constantLimits=true, 
    yMax=driveData.tauMax) 
    annotation (Placement(transformation(extent={{-120,-20},{-100,0}})));
  Modelica.Blocks.Continuous.FirstOrder preFilter(
    k=1, 
    T=driveData.Tfw, 
    initType=Modelica.Blocks.Types.Init.InitialOutput) 
    annotation (Placement(transformation(extent={{-160,0},{-140,20}})));
  Modelica.Blocks.Sources.Step step(
    offset=0, 
    height=driveData.motorData.wNominal, 
    startTime=0.2)                       annotation (Placement(transformation(
        extent={{10,10},{-10,-10}}, 
        rotation=180, 
        origin={-190,-10})));
  Modelica.Blocks.Nonlinear.SlewRateLimiter slewRateLimiter(initType=Modelica.Blocks.Types.Init.InitialOutput, 
      Rising=driveData.aMax) 
    annotation (Placement(transformation(extent={{-160,-40},{-140,-20}})));
equation
  connect(step.y, preFilter.u) annotation (Line(points={{-179,-10},{-170,-10}, 
          {-170,10},{-162,10}}, 
                              color={0,0,127}));
  connect(loadInertia.flange_b, loadTorque.flange) 
    annotation (Line(points={{70,-40},{80,-40}}));
  connect(speedSensor.w, speedController.u_m) annotation (Line(points={{50,-81}, 
          {50,-90},{-116,-90},{-116,-22}},   color={0,0,127}));
  connect(speedController.y, tau2i.u) 
    annotation (Line(points={{-99,-10},{-82,-10}}, 
                                                 color={0,0,127}));
  connect(step.y, slewRateLimiter.u) annotation (Line(points={{-179,-10},{
          -170,-10},{-170,-30},{-162,-30}}, color={0,0,127}));
  connect(speedController.u, preFilter.y) annotation (Line(points={{-122,-10}, 
          {-130,-10},{-130,10},{-139,10}}, color={0,0,127}));
  annotation (experiment(StopTime=1, Interval=0.0001), Documentation(info="<html>
<p>该模型演示了针对电流控制的直流永磁电机驱动的速度控制器的工作原理。</p>
<p>
内部电流控制器根据绝对最佳值进行参数化。
外部控制回路由速度控制器形成，速度控制器根据对称最佳值进行参数化。
</p>
<p>
在时间=0.2s时，施加一个参考速度阶跃，导致驱动器加速到期望速度。
在时间=0.8s时，施加一个负载转矩阶跃，导致驱动器减速，直到速度控制器将驱动器带回到期望速度。
</p>
<p>
您可以尝试使用斜率限制器而不是前置滤波器来限制速度上升，即扭矩上升。
</p>
<p>
进一步阅读：
<a href=\"modelica://Modelica/Resources/Documentation/Electrical/Machines/DriveControl.pdf\">2017 Modelica会议上的教程</a>
</p>
</html>"), 
    Diagram(coordinateSystem(extent={{-200,-100},{100,100}})));
end SpeedControlledDCPM;