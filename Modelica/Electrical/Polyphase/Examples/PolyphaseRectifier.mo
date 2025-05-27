within Modelica.Electrical.Polyphase.Examples;
model PolyphaseRectifier "展示多相二极管整流器"
  extends Icons.Example;
  parameter Utilities.PolyphaseRectifierData data 
    annotation (Placement(transformation(extent={{-90,70},{-70,90}})));
  Sources.SineVoltage sineVoltage(
    m=data.m, 
    V=sqrt(2)*fill(data.VrmsY, data.m), 
    f=fill(data.f, data.m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-90,-60})));
  Basic.MultiStarResistance multiStar(m=data.m, R=data.RGnd) 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        origin={-60,-90})));
  Analog.Basic.Resistor resistor2ground(R=data.RGnd) 
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        origin={-30,-90})));
  Analog.Basic.Ground groundAC 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={0,-90})));
  Utilities.AnalysatorAC analysatorAC(m=data.m, f=data.f) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-90,-30})));
  Basic.SplitToSubsystems splitToSubsystems(m=data.m) 
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Ideal.IdealDiode diode1[data.mSystems](
    each m=data.mBasic, 
    each Ron=fill(1e-6, data.mBasic), 
    each Goff=fill(1e-6, data.mBasic), 
    each Vknee=fill(0, data.mBasic)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-50,20})));
  Ideal.IdealDiode diode2[data.mSystems](
    each m=data.mBasic, 
    each Ron=fill(1e-6, data.mBasic), 
    each Goff=fill(1e-6, data.mBasic), 
    each Vknee=fill(0, data.mBasic)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-50,-20})));
  Basic.Star star1[data.mSystems](each m=data.mBasic) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-50,50})));
  Basic.Star star2[data.mSystems](each m=data.mBasic) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-50,-50})));
  Analog.Basic.Resistor resistorDC1[data.mSystems](each R=data.RDC/2) 
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  Analog.Basic.Inductor inductorDC1[data.mSystems](each i(fixed=true, start=0), 
      each L=data.LDC/2) 
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
  Utilities.AnalysatorDC analysatorDC[data.mSystems](each f=data.f) 
    annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  Analog.Basic.Resistor resistorDC2[data.mSystems](each R=data.RDC/2) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=180, 
        origin={0,-60})));
  Analog.Basic.Inductor inductorDC2[data.mSystems](each i(fixed=true, start=0), 
      each L=data.LDC/2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=180, 
        origin={30,-60})));
  Utilities.AnalysatorDC analysatorDCload(f=data.f) 
    annotation (Placement(transformation(extent={{60,50},{80,70}})));
  Analog.Basic.Resistor loadResistor1(R=data.RLoad/2) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={90,30})));
  Analog.Basic.Resistor loadResistor2(R=data.RLoad/2) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={90,-30})));
  Analog.Basic.Ground groundDC annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={80,0})));
equation
  for p in 1:data.Par loop
    for s in 1:data.Ser - 1 loop
      connect(inductorDC2[(p - 1)*data.Ser + s].p, inductorDC1[(p - 1)*data.Ser + s + 1].n);
    end for;
    connect(inductorDC1[(p - 1)*data.Ser + 1].n, analysatorDCload.p);
    connect(loadResistor2.n, inductorDC2[p*data.Ser].p);
  end for;
  connect(sineVoltage.plug_n, multiStar.plug) 
    annotation (Line(points={{-90,-70},{-90,-90},{-70,-90}}, 
                                                   color={0,0,255}));
  connect(star1.plug_p, diode1.plug_n) 
    annotation (Line(points={{-50,40},{-50,30}},          color={0,0,255}));
  connect(diode2.plug_p, star2.plug_p) 
    annotation (Line(points={{-50,-30},{-50,-40}}, color={0,0,255}));
  connect(loadResistor1.n, groundDC.p) 
    annotation (Line(points={{90,20},{90,0}}, color={0,0,255}));
  connect(groundDC.p, loadResistor2.p) 
    annotation (Line(points={{90,0},{90,-20}}, color={0,0,255}));
  connect(multiStar.pin, resistor2ground.p) 
    annotation (Line(points={{-50,-90},{-40,-90}}, color={0,0,255}));
  connect(resistor2ground.n, groundAC.p) 
    annotation (Line(points={{-20,-90},{-10,-90}}, color={0,0,255}));
  connect(diode1.plug_p, diode2.plug_n) 
    annotation (Line(points={{-50,10},{-50,-10}}, color={0,0,255}));
  connect(analysatorAC.plug_p, sineVoltage.plug_p) 
    annotation (Line(points={{-90,-40},{-90,-50}}, color={0,0,255}));
  connect(analysatorAC.plug_nv, multiStar.plug) 
    annotation (Line(points={{-80,-30},{-70,-30},{-70,-90}}, color={0,0,255}));
  connect(analysatorDCload.n, loadResistor1.p) 
    annotation (Line(points={{80,60},{90,60},{90,40}}, color={0,0,255}));
  connect(loadResistor2.n, analysatorDCload.nv) annotation (Line(points={{90,-40}, 
          {90,-60},{70,-60},{70,50}}, color={0,0,255}));
  connect(analysatorAC.plug_n, splitToSubsystems.plug_p) 
    annotation (Line(points={{-90,-20},{-90,0}}, color={0,0,255}));
  connect(splitToSubsystems.plugs_n, diode1.plug_p) 
    annotation (Line(points={{-70,0},{-50,0},{-50,10}}, color={0,0,255}));
  connect(star1.pin_n, analysatorDC.p) 
    annotation (Line(points={{-50,60},{-40,60}}, color={0,0,255}));
  connect(analysatorDC.n, resistorDC1.p) 
    annotation (Line(points={{-20,60},{-10,60}}, color={0,0,255}));
  connect(resistorDC1.n, inductorDC1.p) 
    annotation (Line(points={{10,60},{20,60}}, color={0,0,255}));
  connect(star2.pin_n, resistorDC2.n) 
    annotation (Line(points={{-50,-60},{-10,-60}}, color={0,0,255}));
  connect(resistorDC2.p, inductorDC2.n) 
    annotation (Line(points={{10,-60},{20,-60}}, color={0,0,255}));
  connect(star2.pin_n, analysatorDC.nv) 
    annotation (Line(points={{-50,-60},{-30,-60},{-30,50}}, color={0,0,255}));
  annotation (experiment(StopTime=0.2, Interval=5e-05),  Documentation(info="<html>
<p>
该示例展示了一个多相系统，每个子系统都有一个整流器。
</p>
<p>
请注意，子系统之间的相互作用由直流电阻和电感阻尼。
</p>
<p>
您可以尝试不同数量的相位2≤<code>m</code>，以及将整流器连接到不同数量的并联分支，并调查交流值：
</p>
<ul>
<li>交流功率<code>analysatorAC.pTotal</code>(所有相位的总和)</li>
<li>交流电流<code>analysatorAC.iFeed[m]</code>(基波有效值)</li>
<li>交流电压<code>analysatorAC.vLN[m]</code>(基波有效值，线对中性)</li>
<li>交流电压<code>analysatorAC.vLL[m]</code>(基波有效值，相对相)</li>
</ul>
<p>
以及每个子系统(整流器)和总体(负载)的直流值：
</p>
<ul>
<li>直流功率总体<code>analysatorAC.pDC</code>(均值)</li>
<li>直流电流总体<code>analysatorAC.iDC</code>(均值)</li>
<li>直流电压总体<code>analysatorAC.vDC</code>(均值)</li>
</ul>
</html>"), 
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
          extent={{-62,72},{42,-70}}, 
          lineColor={175,175,175}, 
          fillColor={215,215,215}, 
          fillPattern=FillPattern.Solid, 
          radius=5),                      Text(
          extent={{-24,10},{36,-10}}, 
          textColor={0,0,0}, 
          fillColor={215,215,215}, 
          fillPattern=FillPattern.None, 
          textString="rectifiers[mSystems]"), 
        Text(
          extent={{-58,10},{58,-10}}, 
          textColor={0,0,0}, 
          fillColor={215,215,215}, 
          fillPattern=FillPattern.Solid, 
          origin={50,0}, 
          rotation=90, 
          textString="connected in series / in parallel"), 
        Line(
          points={{60,60},{40,60}}, 
          color={0,0,0}, 
          pattern=LinePattern.Dot), 
        Line(points={{70,-60},{40,-60}}, color={0,0,0}, 
          pattern=LinePattern.Dot)}));
end PolyphaseRectifier;