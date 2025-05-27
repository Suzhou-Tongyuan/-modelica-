within Modelica.Electrical.Machines.Examples.ControlledDCDrives;
model CurrentControlledDCPM 
  "带有电池H桥的电流控制永磁直流电机驱动"
  extends Utilities.PartialControlledDCPM;
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque 
    loadTorque(
    tau_nominal=-driveData.tauNominal, 
    TorqueDirection=false, 
    w_nominal=driveData.motorData.wNominal) 
    annotation (Placement(transformation(extent={{100,-50},{80,-30}})));
  Modelica.Blocks.Sources.Step step(
    offset=0, 
    startTime=0.2, 
    height=driveData.tauNominal) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        origin={-110,-10})));
equation
  connect(loadInertia.flange_b, loadTorque.flange) 
    annotation (Line(points={{70,-40},{80,-40}}));
  connect(step.y, tau2i.u) 
    annotation (Line(points={{-99,-10},{-82,-10}}, 
                                                 color={0,0,127}));
  annotation (experiment(StopTime=2, Interval=0.0001), Documentation(info="<html>
<p>该模型演示了直流永磁电机驱动的电流控制器的工作原理。</p>
<p>
电流控制器根据绝对最佳值进行参数化。
</p>
<p>在时间=0.2 s时，施加一个参考转矩阶跃，导致驱动器加速，直到电机转矩和负载转矩达到平衡。</p>
<p>
进一步阅读：
<a href=\"modelica://Modelica/Resources/Documentation/Electrical/Machines/DriveControl.pdf\">2017 Modelica会议上的教程</a>
</p>
</html>"), 
    Diagram(coordinateSystem(extent={{-200,-100},{100,100}})));
end CurrentControlledDCPM;