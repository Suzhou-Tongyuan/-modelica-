within Modelica.Electrical.QuasiStatic.SinglePhase.Examples;
model Transformer "具有短路阻抗、传输电阻和负载的变压器示例"
  extends Modelica.Icons.Example;
  Sources.VoltageSource voltageSource(
    f=50, 
    V=1000, 
    phi=0, 
    gamma(fixed=true, start=0)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-90,-30})));
  Ideal.IdealTransformer idealTransformer(n=5) annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  Sensors.PowerSensor sensor0 annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  Basic.Impedance zk(Z_ref(re=0.72, im=0.96)) annotation (Placement(transformation(
        extent={{-10,-10}, {10,10}}, 
        origin={-20,-10})));
  Sources.VariableCurrentSource load(gamma(fixed=true, start=0)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={80,-30})));
  Sensors.PowerSensor sensorL annotation (Placement(transformation(extent={{50,-20},{70,0}})));
  Basic.Ground ground1 annotation (Placement(transformation(extent={{-100,-70},{-80,-50}})));
  Basic.Ground ground2 annotation (Placement(transformation(extent={{30,-70},{50,-50}})));
  Sensors.VoltageSensor v2 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={40,-32})));
  Modelica.ComplexBlocks.ComplexMath.PolarToComplex polarToComplex 
    annotation (Placement(transformation(extent={{60,52},{80,72}})));
  Modelica.Blocks.Sources.Constant const(k=250) 
    annotation (Placement(transformation(extent={{-34,70},{-14,90}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=1, 
    offset=0, 
    startTime=0, 
    height=2*Modelica.Constants.pi) 
    annotation (Placement(transformation(extent={{-14,40},{6,60}})));
  Modelica.Blocks.Sources.Constant constFrequency(k=50) 
    annotation (Placement(transformation(extent={{60,-90},{80,-70}})));
  Sensors.CurrentSensor i2 annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  Sensors.CurrentSensor i1 annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
equation
  connect(voltageSource.pin_p, sensor0.currentP) annotation (Line(points={{-90,-20},{-90,-20},{-90,-10},{-80,-10}}, color={85,170,255}));
  connect(zk.pin_n, idealTransformer.pin_p1) annotation (Line(points={{-10,-10},{-10,-20}}, color={85,170,255}));
  connect(sensorL.voltageP, sensorL.currentP) annotation (Line(points={{60,0},{50,0},{50,-10}}, color={85,170,255}));
  connect(voltageSource.pin_n, ground1.pin) annotation (Line(points={{-90,-40},{-90,-40},{-90,-50}}, color={85,170,255}));
  connect(ground1.pin, idealTransformer.pin_n1) annotation (Line(points={{-90,-50},{-10,-50},{-10,-40}}, color={85,170,255}));
  connect(sensor0.currentP, sensor0.voltageP) annotation (Line(points={{-80,-10},{-80,-10},{-80,0},{-70,0}}, color={85,170,255}));
  connect(sensor0.voltageN, ground1.pin) annotation (Line(points={{-70,-20},{-70,-50},{-90,-50}}, color={85,170,255}));
  connect(v2.pin_n, ground2.pin) annotation (Line(points={{40,-42},{40,-42},{40,-50}}, color={85,170,255}));
  connect(const.y, polarToComplex.len) annotation (Line(points={{-13,80},{-4,80},{20,80},{20,68},{58,68}}, color={0,0,127}));
  connect(ramp.y, polarToComplex.phi) annotation (Line(points={{7,50},{20,50},{20,50},{20,56},{58,56}}, color={0,0,127}));
  connect(load.pin_p, sensorL.currentN) annotation (Line(points={{80,-20},{80,-20},{80,-12},{80,-10},{70,-10}}, color={85,170,255}));
  connect(sensorL.voltageN, ground2.pin) annotation (Line(points={{60,-20},{60,-20},{60,-44},{60,-50},{40,-50}}, color={85,170,255}));
  connect(load.pin_n, ground2.pin) annotation (Line(points={{80,-40},{80,-40},{80,-50},{40,-50}}, color={85,170,255}));
  connect(ground2.pin, idealTransformer.pin_n2) annotation (Line(points={{40,-50},{10,-50},{10,-39.8}}, 
                                                                                                      color={85,170,255}));
  connect(load.I, polarToComplex.y) annotation (Line(points={{92,-24},{100,-24},{100,62},{81,62}}, color={85,170,255}));
  connect(load.f, constFrequency.y) annotation (Line(points={{92,-36},{100,-36},{100,-80},{81,-80}}, color={0,0,127}));
  connect(sensorL.currentP, v2.pin_p) annotation (Line(points={{50,-10},{40,-10},{40,-22}}, color={85,170,255}));
  connect(i2.pin_n, sensorL.currentP) annotation (Line(points={{40,-10},{40,-10},{50,-10}}, color={85,170,255}));
  connect(sensor0.currentN, i1.pin_p) annotation (Line(points={{-60,-10},{-60,-10}}, color={85,170,255}));
  connect(i1.pin_n, zk.pin_p) annotation (Line(points={{-40,-10},{-35,-10},{-30,-10}}, color={85,170,255}));
  connect(idealTransformer.pin_p2, i2.pin_p) annotation (Line(points={{10,-20},{12,-20},{12,-10},{20,-10}}, color={85,170,255}));
  annotation (experiment(StopTime=1),Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={Rectangle(
          extent={{50,10},{96,-60}}, 
          pattern=LinePattern.Dash, 
          fillColor={255,255,170}, 
          fillPattern=FillPattern.Solid), Rectangle(
          extent={{-40,10},{20,-60}}, 
          pattern=LinePattern.Dash, 
          fillColor={255,255,170}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-60,30},{40,10}}, 
          textColor={28,108,200}, 
          textString="具有短路阻抗的变压器"), 
        Text(
          extent={{50,30},{96,10}}, 
          textColor={28,108,200}, 
          textString="负载电流")}), 
    Documentation(info="<html>
<p>此示例展示了具有短路阻抗的变压器的运行行为。该变压器以恒定电流幅值250A负载，但相位角可变。相角在一秒的仿真时间内从0变化到360度。</p>

<p>变压器数据</p>
<ul>
<li>名义主电压 <code>V1N = 1000 V</code></li>
<li>名义次电压 <code>V2N = 200 V</code></li>
<li>名义视在功率  <code>SN = 50 kVA</code></li>
<li>短路阻抗 <code><u>Z</u><sub>k</sub> = 0.72 Ohm + j*0.96 Ohm</code></li>
<li>未考虑磁化电流和铁芯损耗</li>
</ul>

<p>绘制次电压的实部<code>idealTransformer.v2.re</code>在x轴上，<code>idealTransformer.v2.im</code>在y轴上。这个复电压<code><u>v</u><sub>2</sub></code>的轨迹是一个圆。圆的中心是主供电电压除以变换比<code>n=5</code>。由于在此实验中负载电流幅值是恒定的，变压器短路阻抗的电压降也是恒定的。圆的半径等于变压器短路阻抗的电压降的恒定幅值。</p>
</html>"));
end Transformer;