within Modelica.Electrical.Batteries.Examples;
model BatteryDischargeCharge "放电和充电理想化电池"
  extends Modelica.Icons.Example;
  Modelica.Electrical.Batteries.Utilities.PulseSeries pulseSeries(
    n1=7, 
    T1=60, 
    Tp1=60, 
    n2=7, 
    Tp=60, 
    startTime=60) 
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  parameter Modelica.Electrical.Batteries.ParameterRecords.CellData cellData1(
    Qnom=18000, 
    OCVmax=4.2, 
    OCVmin=2.5, 
    Ri=cellData1.OCVmax/1200) 
    annotation (Placement(transformation(extent={{60,20},{80,40}})));
  Modelica.Electrical.Batteries.BatteryStacks.CellStack battery1(
    Ns=10, 
    Np=2, 
    cellData=cellData1, 
    useHeatPort=false, 
    SOC(fixed=true, start=0.95)) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=270, 
        origin={40,40})));
  Modelica.Electrical.Analog.Basic.Ground ground1 
    annotation (Placement(transformation(extent={{10,0},{30,20}})));
  Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent1 
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=90, 
        origin={0,40})));
  Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor1 
    annotation (Placement(transformation(extent={{10,70},{30,90}})));
  Modelica.Blocks.Continuous.Integrator energy1(u(unit="W"), y(unit="J")) 
    annotation (Placement(transformation(extent={{60,50},{80,70}})));
  parameter Modelica.Electrical.Batteries.ParameterRecords.TransientData.ExampleData cellData2(
    Qnom=18000, 
    useLinearSOCDependency=false, 
    Ri=cellData2.OCVmax/1200, 
    Idis=0.1, 
    nRC=2, 
    rcData={Modelica.Electrical.Batteries.ParameterRecords.TransientData.RCData(
        R=0.2*cellData2.Ri, C=60/(0.2*cellData2.Ri)), 
        Modelica.Electrical.Batteries.ParameterRecords.TransientData.RCData(R= 
        0.1*cellData2.Ri, C=10/(0.1*cellData2.Ri))}) 
    annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
  Modelica.Electrical.Batteries.BatteryStacks.CellRCStack battery2(
    Ns=10, 
    Np=2, 
    cellData=cellData2, 
    useHeatPort=false, 
    SOC(fixed=true, start=0.95)) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=270, 
        origin={40,-60})));
  Modelica.Electrical.Analog.Basic.Ground ground2 
    annotation (Placement(transformation(extent={{10,-100},{30,-80}})));
  Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent2 
    annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=90, 
        origin={0,-60})));
  Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor2 
    annotation (Placement(transformation(extent={{10,-30},{30,-10}})));
  Modelica.Blocks.Continuous.Integrator energy2(u(unit="W"), y(unit="J")) 
    annotation (Placement(transformation(extent={{60,-50},{80,-30}})));
  Modelica.Blocks.Math.Gain gain(k=75) 
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
equation
  connect(battery1.n, ground1.p) 
    annotation (Line(points={{40,30},{40,20},{20,20}}, color={0,0,255}));
  connect(signalCurrent1.n, ground1.p) 
    annotation (Line(points={{0,30},{0,20},{20,20}}, color={0,0,255}));
  connect(signalCurrent1.p, powerSensor1.pc) 
    annotation (Line(points={{0,50},{0,80},{10,80}}, color={0,0,255}));
  connect(powerSensor1.nc, battery1.p) 
    annotation (Line(points={{30,80},{40,80},{40,50}}, color={0,0,255}));
  connect(powerSensor1.nv, ground1.p) 
    annotation (Line(points={{20,70},{20,20}}, color={0,0,255}));
  connect(powerSensor1.pc, powerSensor1.pv) 
    annotation (Line(points={{10,80},{10,90},{20,90}}, color={0,0,255}));
  connect(powerSensor1.power, energy1.u) 
    annotation (Line(points={{10,69},{10,60},{58,60}}, color={0,0,127}));
  connect(battery2.n,ground2. p) 
    annotation (Line(points={{40,-70},{40,-80},{20,-80}},color={0,0,255}));
  connect(signalCurrent2.n,ground2. p) 
    annotation (Line(points={{0,-70},{0,-80},{20,-80}},    color={0,0,255}));
  connect(signalCurrent2.p,powerSensor2. pc) 
    annotation (Line(points={{0,-50},{0,-20},{10,-20}},      color={0,0,255}));
  connect(powerSensor2.nc,battery2. p) 
    annotation (Line(points={{30,-20},{40,-20},{40,-50}}, color={0,0,255}));
  connect(powerSensor2.nv,ground2. p) 
    annotation (Line(points={{20,-30},{20,-80}}, 
                                               color={0,0,255}));
  connect(powerSensor2.pc,powerSensor2. pv) 
    annotation (Line(points={{10,-20},{10,-10},{20,-10}},  color={0,0,255}));
  connect(powerSensor2.power,energy2. u) 
    annotation (Line(points={{10,-31},{10,-40},{58,-40}},   color={0,0,127}));
  connect(gain.y, signalCurrent1.i) annotation (Line(points={{-29,0},{-20,0}, 
          {-20,40},{-12,40}}, color={0,0,127}));
  connect(gain.y,signalCurrent2. i) annotation (Line(points={{-29,0},{-20,0}, 
          {-20,-60},{-12,-60}}, color={0,0,127}));
  connect(pulseSeries.y, gain.u) 
    annotation (Line(points={{-59,0},{-52,0}}, color={0,0,127}));
  annotation (experiment(
      StopTime=3600, 
      Interval=0.1, 
      Tolerance=1e-06), 
    Documentation(info="<html>

<p>比较两个带有10 A.h标称电荷且初始SOC=95％的电池：</p>
<ul>
<li><code>battery1</code>是一个SOC线性依赖的电池，没有自放电，并且不包含RC元件。</li>
<li><code>battery2</code>是一个SOC依赖于表格的电池，具有自放电并包括RC元件。</li>
</ul>
<p>
使用两个<a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.CellData\">参数记录</a><code>cellData1</code>和<code>cellData2</code>来参数化电池模型。
</p>
<p>
首先，电池通过7个50 A电流脉冲进行放电，每个持续1分钟，脉冲之间间隔1分钟，直到SOC=5％为止。<br>
随后，电池再次通过7个50 A电流脉冲进行充电，每个持续1分钟，脉冲之间间隔1分钟，直到SOC=95％为止。<br>
最后，电池处于空载状态以显示自放电效应。
请注意，为了在相当短的时间内显示自放电，<code>battery2</code>的自放电设置为不现实的高值，以显示相对较短时间内的自放电。<br>
<code>battery2</code>的RC元件的参数设置为估计值，仅用于演示效果。
</p>
<p>模拟并绘制端电压<code>battery1.v</code>和<code>battery2.v</code>以及充放电状态<code>battery1.SOC</code>和<code>battery2.SOC</code>。</p>
<p>
绘制<code>energy1.y</code>和<code>energy2.y</code>，值得注意的是，首先电池释放能量，
但随后由于损耗，更多能量被消耗来充电电池。
</p>

</html>"));

end BatteryDischargeCharge;