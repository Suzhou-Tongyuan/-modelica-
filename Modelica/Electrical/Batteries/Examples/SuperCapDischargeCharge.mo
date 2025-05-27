within Modelica.Electrical.Batteries.Examples;
model SuperCapDischargeCharge "放电和充电理想化超级电容"
  extends Modelica.Icons.Example;
  Modelica.Electrical.Batteries.Utilities.PulseSeries pulseSeries(
    n1=5, 
    T1=10, 
    Tp1=10, 
    n2=5, 
    Tp=10, 
    startTime=10) 
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Electrical.Batteries.BatteryStacks.SuperCap superCap(
    Vnom=48, 
    C=500, 
    Rs=0.002, 
    Idis=0.05, 
    useHeatPort=false) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=270, 
        origin={40,0})));
  Modelica.Electrical.Analog.Basic.Ground ground 
    annotation (Placement(transformation(extent={{10,-40},{30,-20}})));
  Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent 
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
  Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor 
    annotation (Placement(transformation(extent={{10,30},{30,50}})));
  Modelica.Blocks.Continuous.Integrator energy(u(unit="W"), y(unit="J")) 
    annotation (Placement(transformation(extent={{60,10},{80,30}})));
  Modelica.Blocks.Math.Gain gain(k=300) 
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
equation
  connect(superCap.n, ground.p) annotation (Line(points={{40,-10},{40,-20}, 
          {20,-20}}, color={0,0,255}));
  connect(signalCurrent.n, ground.p) 
    annotation (Line(points={{0,-10},{0,-20},{20,-20}}, color={0,0,255}));
  connect(signalCurrent.p, powerSensor.pc) 
    annotation (Line(points={{0,10},{0,40},{10,40}}, color={0,0,255}));
  connect(powerSensor.nc, superCap.p) 
    annotation (Line(points={{30,40},{40,40},{40,10}}, color={0,0,255}));
  connect(powerSensor.nv, ground.p) 
    annotation (Line(points={{20,30},{20,-20}}, color={0,0,255}));
  connect(powerSensor.pc, powerSensor.pv) 
    annotation (Line(points={{10,40},{10,50},{20,50}}, color={0,0,255}));
  connect(powerSensor.power, energy.u) 
    annotation (Line(points={{10,29},{10,20},{58,20}}, color={0,0,127}));
  connect(gain.y, signalCurrent.i) annotation (Line(points={{-29,0},{-12,0}, 
          {-12,6.66134e-16}}, color={0,0,127}));
  connect(pulseSeries.y, gain.u) 
    annotation (Line(points={{-59,0},{-52,0}}, color={0,0,127}));
  annotation (experiment(
      StopTime=720, 
      Interval=0.01, 
      Tolerance=1e-06), 
    Documentation(info="<html>
<p>一个电容为500F的超级电容，初始电压为48V，
通过5个持续10秒的240A电流脉冲进行放电，脉冲之间间隔10秒。
随后，超级电容通过5个持续10秒的240A电流脉冲进行充电，脉冲之间间隔10秒。
最后，超级电容处于空载状态以显示自放电效应。
</p>
<p>
请注意，自放电设置为不现实的高值，以显示相对较短时间内的自放电。<br>
超级电容的其他参数设置为估计但现实的值：
</p>
<ul>
<li><code>C = 500 F</code></li>
<li><code>Vnom = 48 V</code></li>
<li><code>Qnom = C*Vnom = 24,000 As</code></li>
<li><code>Ri = 2 m&Omega;</code></li>
</ul>
<p>用户可以在特定窗口模拟并绘制端电压<code>supercap.v</code>曲线。</p>
<p>
用户可以在特定窗口绘制<code>energy.y</code>曲线，值得注意的是，首先超级电容释放能量，
但随后由于损耗，更多能量被消耗来充电超级电容。
</p>
</html>"));
end SuperCapDischargeCharge;