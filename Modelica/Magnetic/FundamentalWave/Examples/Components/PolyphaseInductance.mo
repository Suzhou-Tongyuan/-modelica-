within Modelica.Magnetic.FundamentalWave.Examples.Components;
model PolyphaseInductance "多相电感"
  extends Modelica.Icons.Example;
  parameter Integer m=3 "阶段数" annotation(Evaluate=true);
  parameter SI.Frequency f=1 "供电频率";
  parameter SI.Voltage VRMS=100 "电源电压有效值";
  parameter SI.Resistance R=0.1 "导线电缆阻力";
  parameter Real effectiveTurns=5 "有效转数";
  parameter SI.Inductance L=1 "负载电感";
  final parameter SI.Reluctance R_m=m*effectiveTurns^2/2/L 
    "等效磁阻";
  Modelica.Electrical.Analog.Basic.Ground ground_e 
    annotation (Placement(transformation(extent={{-70,10},{-50,30}})));
  Modelica.Electrical.Analog.Basic.Ground ground_m 
    annotation (Placement(transformation(extent={{-70,-90},{-50,-70}})));
  Modelica.Electrical.Polyphase.Basic.Star star_e(m=m) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-60,40})));
  Modelica.Electrical.Polyphase.Basic.Star star_m(m=m) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-60,-60})));
  Modelica.Electrical.Polyphase.Sources.SineVoltage voltageSource_e(
    m=m, 
    f=fill(f, m), 
    V=fill(sqrt(2)*VRMS, m), 
    phase=-Modelica.Electrical.Polyphase.Functions.symmetricOrientation(
        m) + fill(Modelica.Constants.pi/2, m)) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-60,70})));
  Modelica.Electrical.Polyphase.Sources.SineVoltage voltageSource_m(
    m=m, 
    f=fill(f, m), 
    V=fill(sqrt(2)*VRMS, m), 
    phase=-Modelica.Electrical.Polyphase.Functions.symmetricOrientation(
        m) + fill(Modelica.Constants.pi/2, m)) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-60,-30})));
  Modelica.Electrical.Polyphase.Basic.Resistor resistor_e(m=m, R=fill(R, 
        m)) 
    annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  Modelica.Electrical.Polyphase.Basic.Resistor resistor_m(m=m, R=fill(R, 
        m)) 
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Modelica.Electrical.Polyphase.Basic.Inductor inductor_e(m=m, L=fill(L, 
        m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={0,70})));
  Magnetic.FundamentalWave.Components.PolyphaseElectroMagneticConverter converter_m(
    m=m, 
    orientation=Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m), 
    effectiveTurns=fill(effectiveTurns, m)) 
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));

  Magnetic.FundamentalWave.Components.Reluctance reluctance_m(R_m(d=R_m, q=R_m)) 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={60,-30})));
  Magnetic.FundamentalWave.Components.Ground groundM_m 
    annotation (Placement(transformation(extent={{10,-90},{30,-70}})));
initial equation
  resistor_e.i = zeros(m);
  resistor_m.i[1:2] = zeros(2);
equation
  connect(star_e.plug_p, voltageSource_e.plug_n) annotation (Line(
      points={{-60,50},{-60,60}}, color={0,0,255}));
  connect(voltageSource_e.plug_n, inductor_e.plug_n) annotation (Line(
      points={{-60,60},{0,60}}, color={0,0,255}));
  connect(converter_m.port_p, reluctance_m.port_p) annotation (Line(
      points={{20,-20},{60,-20}}, color={255,128,0}));
  connect(converter_m.port_n, reluctance_m.port_n) annotation (Line(
      points={{20,-40},{60,-40}}, color={255,128,0}));
  connect(converter_m.port_n, groundM_m.port_p) annotation (Line(
      points={{20,-40},{20,-70}}, color={255,128,0}));
  connect(voltageSource_m.plug_n, star_m.plug_p) annotation (Line(
      points={{-60,-40},{-60,-50}}, color={0,0,255}));
  connect(voltageSource_m.plug_n, converter_m.plug_n) annotation (Line(
      points={{-60,-40},{0,-40}}, color={0,0,255}));
  connect(voltageSource_e.plug_p, resistor_e.plug_p) annotation (Line(
      points={{-60,80},{-40,80}}, color={0,0,255}));
  connect(resistor_e.plug_n, inductor_e.plug_p) annotation (Line(
      points={{-20,80},{0,80}}, color={0,0,255}));
  connect(voltageSource_m.plug_p, resistor_m.plug_p) annotation (Line(
      points={{-60,-20},{-40,-20}}, color={0,0,255}));
  connect(resistor_m.plug_n, converter_m.plug_p) annotation (Line(
      points={{-20,-20},{0,-20}}, color={0,0,255}));
  connect(star_e.pin_n, ground_e.p) annotation (Line(
      points={{-60,30},{-60,30}}, color={0,0,255}));
  connect(star_m.pin_n, ground_m.p) annotation (Line(
      points={{-60,-70},{-60,-70}}, color={0,0,255}));
  annotation (experiment(StopTime=100, Interval=0.01), Documentation(info="<html>
<p>
本例比较了电多相电感与等效基波磁阻电路。
相电感<code>L</code>与磁基波磁阻<code>R_m</code>的关系为:
</p>

<blockquote><pre>
R_m = m * effectiveTurns^2 / 2 / L
</pre></blockquote>

<p>
两股电流
</p>

<ul>
<li><code>resistor_e.i[1]</code></li>
<li><code>resistor_m.i[1]</code></li>
</ul>

<p>
显示了相同的波形，从而证明了两种不同建模方法的等效性.
</p>
</html>"));
end PolyphaseInductance;