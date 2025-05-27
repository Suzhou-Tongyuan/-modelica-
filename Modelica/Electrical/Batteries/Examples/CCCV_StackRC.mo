within Modelica.Electrical.Batteries.Examples;
model CCCV_StackRC 
  "使用恒定电流-恒定电压特性为瞬态电池组充电"
  extends Modelica.Icons.Example;
  parameter Modelica.Electrical.Batteries.ParameterRecords.TransientData.ExampleData cellDataOriginal(
    Qnom=18000, 
    useLinearSOCDependency=false, 
    Ri=4.2/1200, 
    Idis=0.001) "原始电池数据" 
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  parameter Modelica.Electrical.Batteries.ParameterRecords.TransientData.ExampleData cellDataDegraded(
    Qnom=18000, 
    useLinearSOCDependency=false, 
    Ri=2*4.2/1200, 
    Idis=0.001) "退化电池数据" 
    annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
  parameter Modelica.Electrical.Batteries.ParameterRecords.TransientData.StackData 
    stackData(
    Ns=3, 
    Np=2, 
    kDegraded=[1,1], 
    cellDataOriginal=cellDataOriginal, 
    cellDataDegraded=cellDataDegraded) "电池组数据" 
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
  Modelica.Electrical.Batteries.Utilities.CCCVcharger cccvCharger(I=stackData.Np*25, Vend=stackData.Ns*4.2) 
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-50,0})));
  Modelica.Electrical.Analog.Basic.Ground ground 
    annotation (Placement(transformation(extent={{-30,-40},{-10,-20}})));
  Modelica.Electrical.Batteries.BatteryStacksWithSensors.StackRC stack(
    stackData=stackData, 
    useHeatPort=false, 
    SOC0=fill(
          0.1, 
          stackData.Ns, 
          stackData.Np)) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
  Modelica.Electrical.Batteries.Utilities.BusTranscription busTranscription(
      Np=stackData.Np, Ns=stackData.Ns) 
    annotation (Placement(transformation(extent={{30,-30},{50,-10}})));
  Blocks.Continuous.Integrator          energy(u(unit="W"), y(unit="J")) 
    annotation (Placement(transformation(extent={{-60,24},{-80,44}})));
  Analog.Sensors.MultiSensor                     multiSensor 
    annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
equation
  connect(ground.p, cccvCharger.n) annotation (Line(points={{-20,-20},{-50,-20}, 
          {-50,-10}},      color={0,0,255}));
  connect(ground.p, stack.n) 
    annotation (Line(points={{-20,-20},{0,-20},{0,-10}}, color={0,0,255}));
  connect(stack.stackBus, busTranscription.stackBus) annotation (Line(
      points={{8,-6},{20,-6},{20,-20},{30,-20}}, 
      color={255,204,51}, 
      thickness=0.5));
  connect(ground.p, multiSensor.nv) 
    annotation (Line(points={{-20,-20},{-20,30}}, color={0,0,255}));
  connect(cccvCharger.p, multiSensor.pc) 
    annotation (Line(points={{-50,10},{-50,40},{-30,40}}, color={0,0,255}));
  connect(multiSensor.power, energy.u) 
    annotation (Line(points={{-31,34},{-58,34}}, color={0,0,127}));
  connect(multiSensor.pc, multiSensor.pv) 
    annotation (Line(points={{-30,40},{-30,50},{-20,50}}, color={0,0,255}));
  connect(multiSensor.nc, stack.p) 
    annotation (Line(points={{-10,40},{0,40},{0,10}}, color={0,0,255}));
  annotation (experiment(
      StopTime=1200, 
      Interval=0.1, 
      Tolerance=1e-06), 
    Documentation(info="<html>
<p>
一个具有瞬态特性的电池组，其中有一个退化电池(索引为<code>[1,1]</code>，内阻翻倍)，所有电池都放电到<code>SOC = 0.1</code>，使用CC-CV充电器充电。
示例仿真时间为1200秒，用户可以在特定界面绘制与<code>time</code>相关的图像：
</p>
<ul>
<li><code>stack.batteryBus.soc</code></li>
<li><code>busTransription.stackBusArrays.soc[1,1]</code></li>
<li><code>busTransription.stackBusArrays.soc[1,2]</code></li>
</ul>
</html>"));
end CCCV_StackRC;