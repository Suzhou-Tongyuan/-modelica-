within Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2mPulse;
model DiodeBridge2mPulse 
  "带电阻负载的2*m脉冲二极管整流桥"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Integer m(final min=3) = 3 "相数" annotation(Evaluate=true);
  parameter SI.Voltage Vrms=110 "有效值供电电压";
  parameter SI.Frequency f=50 "频率";
  parameter SI.Resistance R=20 "负载电阻";

  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage(
    final m=m, 
    V=fill(sqrt(2)*Vrms, m), 
    phase=-
        Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m), 
    f=fill(f, m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-80,-30})));
  PowerConverters.ACDC.DiodeBridge2mPulse rectifier(final m=m) 
    annotation (Placement(transformation(extent={{-40,24},{-20,44}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltagesensor 
    annotation (Placement(transformation(
        origin={50,10}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
  Modelica.Blocks.Math.Mean meanVoltage(f=2*m*f) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        origin={80,40})));
  Modelica.Blocks.Math.RootMeanSquare rootMeanSquareVoltage(f=2*m*f) 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        origin={80,10})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor 
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=180, 
        origin={0,-40})));
  Modelica.Blocks.Math.Mean meanCurrent(f=2*m*f) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        origin={80,-60})));
  Modelica.Electrical.Polyphase.Basic.MultiStarResistance 
    multiStarResistance(final m=m) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-80,-60})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(extent={{-90,-100},{-70,-80}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
      Placement(transformation(
        origin={30,30}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
equation
  connect(meanCurrent.u, currentSensor.i) annotation (Line(
      points={{68,-60},{0,-60},{0,-50}}, color={0,0,127}));
  connect(voltagesensor.v, meanVoltage.u) annotation (Line(
      points={{60,10},{64,10},{64,40},{68,40}}, color={0,0,127}));
  connect(voltagesensor.v, rootMeanSquareVoltage.u) annotation (Line(
      points={{60,10},{68,10}}, color={0,0,127}));
  connect(sineVoltage.plug_p, rectifier.ac) annotation (Line(
      points={{-80,-20},{-80,34},{-40,34}}, color={0,0,255}));
  connect(rectifier.dc_n, currentSensor.n) annotation (Line(
      points={{-19.8,28},{-10,28},{-10,-40}}, color={0,0,255}));
  connect(rectifier.dc_p, voltagesensor.p) annotation (Line(
      points={{-20,40},{50,40},{50,20}}, color={0,0,255}));
  connect(currentSensor.p, voltagesensor.n) annotation (Line(
      points={{10,-40},{50,-40},{50,0}}, color={0,0,255}));
  connect(sineVoltage.plug_n, multiStarResistance.plug) annotation (
      Line(
      points={{-80,-40},{-80,-50}}, color={0,0,255}));
  connect(multiStarResistance.pin, ground.p) annotation (Line(
      points={{-80,-70},{-80,-80}}, color={0,0,255}));
  connect(resistor.n, currentSensor.p) annotation (Line(
      points={{30,20},{30,-40},{10,-40}}, color={0,0,255}));
  connect(resistor.p, rectifier.dc_p) annotation (Line(
      points={{30,40},{-20,40}}, color={0,0,255}));
  annotation (
    experiment(
      StopTime=0.1, 
      Tolerance=1e-06, 
      Interval=0.0002), 
    Documentation(info="<html>
<p>该示例展示了一个不受控制的<code>2*m</code>脉冲二极管整流桥，带有电阻负载，其中<code>m</code>是相数。</p>

<p><code>2*m</code>脉冲二极管整流桥示例，其中<code>m</code>是相数。</p>

<p>绘制电流<code>currentSensor.i</code>、平均电流<code>meanCurrent.y</code>、电压<code>voltageSensor.v</code>和平均电压<code>meanVoltage.v</code>。</p>
</html>"));
end DiodeBridge2mPulse;