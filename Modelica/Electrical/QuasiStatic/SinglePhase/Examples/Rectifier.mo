within Modelica.Electrical.QuasiStatic.SinglePhase.Examples;
model Rectifier "整流器示例"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter SI.Voltage VAC=100 "交流有效值电压";
  parameter Real conversionFactor=1 "直流电压与交流有效值电压的比值";
  output SI.Current Itr=iAC.y_rms "瞬态电流";
  output SI.Current Iqs=iQS.len "QS电流";
  Sources.VoltageSource voltageQS(
    f=50, 
    V=VAC, 
    phi=0, 
    i(re(start=0), im(start=0)), 
    gamma(fixed=true, start=0)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-80,50})));
  Basic.Resistor resistorQS(R_ref=50E-3) 
    annotation (Placement(transformation(extent={{-72,50},{-52,70}})));
  Sensors.CurrentSensor currentSensorQS 
    annotation (Placement(transformation(extent={{-40,70},{-20,50}})));
  Modelica.ComplexBlocks.ComplexMath.ComplexToPolar iQS 
    annotation (Placement(transformation(extent={{-20,70},{0,90}})));
  Basic.Ground groundQS 
    annotation (Placement(transformation(extent={{-20,10},{0,30}})));
  Utilities.IdealACDCConverter rectifierQS(conversionFactor= 
        conversionFactor) 
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Modelica.Electrical.Analog.Basic.Ground groundDC1 
    annotation (Placement(transformation(extent={{0,10},{20,30}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor iDC1 
    annotation (Placement(transformation(extent={{20,70},{40,50}})));
  Modelica.Electrical.Analog.Basic.VariableConductor load1 annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={50,50})));
  Modelica.Electrical.Analog.Sources.SineVoltage voltageAC(
    V=sqrt(2)*VAC, 
    f=50, 
    phase=pi/2) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=270, 
        origin={-80,-50})));
  Modelica.Electrical.Analog.Basic.Resistor resistorAC(R=50E-3) 
    annotation (Placement(transformation(extent={{-70,-50},{-50,-30}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensorAC 
    annotation (Placement(transformation(extent={{-40,-30},{-20,-50}})));
  Modelica.Blocks.Math.Harmonic iAC(f=50, k=1) 
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  Modelica.Electrical.Analog.Basic.Ground groundAC 
    annotation (Placement(transformation(extent={{-20,-90},{0,-70}})));
  Utilities.GraetzRectifier rectifierAC 
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensorDC2 
    annotation (Placement(transformation(extent={{20,-30},{40,-50}})));
  Modelica.Blocks.Math.RootMeanSquare iDC2(f=50) 
    annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
  Modelica.Electrical.Analog.Basic.VariableConductor load2 annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={50,-50})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=1, 
    duration=0.8, 
    startTime=0.1) 
    annotation (Placement(transformation(extent={{100,-10},{80,10}})));
equation
  connect(voltageQS.pin_p, resistorQS.pin_p) annotation (Line(
      points={{-80,60},{-72,60}}, color={85,170,255}));
  connect(voltageQS.pin_n, rectifierQS.pin_nQS) annotation (Line(
      points={{-80,40},{-10,40}}, color={85,170,255}));
  connect(rectifierQS.pin_nQS, groundQS.pin) annotation (Line(
      points={{-10,40},{-10,30}}, color={85,170,255}));
  connect(rectifierQS.pin_nDC, groundDC1.p) annotation (Line(
      points={{10,40},{10,30}}, color={0,0,255}));
  connect(load1.n, rectifierQS.pin_nDC) annotation (Line(
      points={{50,40},{10,40}}, color={0,0,255}));
  connect(voltageAC.p, resistorAC.p) annotation (Line(
      points={{-80,-40},{-70,-40}}, color={0,0,255}));
  connect(voltageAC.n, rectifierAC.pin_nAC) annotation (Line(
      points={{-80,-60},{-10,-60}}, color={0,0,255}));
  connect(rectifierAC.pin_nAC, groundAC.p) annotation (Line(
      points={{-10,-60},{-10,-70}}, color={0,0,255}));
  connect(rectifierAC.pin_nDC, load2.n) annotation (Line(
      points={{10,-60},{50,-60}}, color={0,0,255}));
  connect(ramp.y, load1.G) annotation (Line(
      points={{79,0},{70,0},{70,50},{62,50}}, color={0,0,127}));
  connect(ramp.y, load2.G) annotation (Line(
      points={{79,0},{70,0},{70,-50},{62,-50}}, color={0,0,127}));
  connect(resistorQS.pin_n, currentSensorQS.pin_p) annotation (Line(
      points={{-52,60},{-40,60}}, color={85,170,255}));
  connect(currentSensorQS.pin_n, rectifierQS.pin_pQS) annotation (Line(
      points={{-20,60},{-10,60}}, color={85,170,255}));
  connect(currentSensorQS.i, iQS.u) annotation (Line(
      points={{-30,71},{-30,80},{-22,80}}, color={85,170,255}));
  connect(rectifierQS.pin_pDC, iDC1.p) annotation (Line(
      points={{10,60},{20,60}}, color={0,0,255}));
  connect(iDC1.n, load1.p) annotation (Line(
      points={{40,60},{50,60}}, color={0,0,255}));
  connect(resistorAC.n, currentSensorAC.p) annotation (Line(
      points={{-50,-40},{-40,-40}}, color={0,0,255}));
  connect(currentSensorAC.n, rectifierAC.pin_pAC) annotation (Line(
      points={{-20,-40},{-10,-40}}, color={0,0,255}));
  connect(currentSensorAC.i, iAC.u) annotation (Line(
      points={{-30,-29},{-30,-20},{-22,-20}}, color={0,0,127}));
  connect(currentSensorDC2.i, iDC2.u) annotation (Line(
      points={{30,-29},{30,-20},{38,-20}}, color={0,0,127}));
  connect(currentSensorDC2.p, rectifierAC.pin_pDC) annotation (Line(
      points={{20,-40},{10,-40}}, color={0,0,255}));
  connect(currentSensorDC2.n, load2.p) annotation (Line(
      points={{40,-40},{50,-40}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<p>
这个例子演示了将一个准静态电路与一个直流电路耦合。
QS电压被整流（使用
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Utilities.IdealACDCConverter\">
理想的交直流转换器</a>），由可变负载导体负载。
在这种情况下，<em>conversionFactor = 直流电压 / 交流有效值电压</em> 是一个整流正弦的均方根，即为 1。
您可以比较准静态模型的结果与完全瞬态模型的结果（使用
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Utilities.GraetzRectifier\">
格雷茨整流器</a>），绘制：
</p>
<ul>
<li>QS: 交流有效值电流 = iQS.len</li>
<li>AC: 交流瞬时电流 = iAC.u</li>
<li>AC: 交流有效值电流 = iAC.y_rms</li>
<li>QS: 直流电流 = iDC1.i</li>
<li>AC: 直流瞬时电流 = iDC2.u</li>
<li>AC: 直流有效值电流 = iDC2.y</li>
</ul>
<p>
可以看到，在直流侧，电流由其平均值表示，在交流侧，电流由其均方根值表示。
</p>
<h4>注意</h4>
<p>
准静态模型需要在QS侧和DC侧都接地，
而瞬态模型可能只有一个地，因为交流侧和直流侧通过二极管连接。
</p>
</html>"), 
       experiment(StopTime=1.0, Interval=0.0001));
end Rectifier;