within Modelica.Electrical.QuasiStatic.Polyphase.Sensors;
model AronSensor "三相有功功率传感器"
  extends Modelica.Icons.RoundSensor;
  final parameter Integer m(final min=1) = 3 "相数" annotation(Evaluate=true);
  Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug plug_p(final m=m) 
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.NegativePlug plug_n(final m=m) 
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealOutput activePower(unit="W") "有功功率" annotation (Placement(transformation(
        origin={0,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.PlugToPins_p plugToPins_p(final m=m) 
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.PlugToPins_n plugToPins_n(final m=m) 
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PowerSensor powerSensor1 
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PowerSensor powerSensor3 
    annotation (Placement(transformation(extent={{20,-30},{40,-50}})));
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={0,-70})));
  Modelica.ComplexBlocks.ComplexMath.ComplexToReal complexToReal1(final
      useConjugateInput=false) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-40,-20})));
  Modelica.ComplexBlocks.ComplexMath.ComplexToReal complexToReal3(final
      useConjugateInput=false) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={0,-22})));
equation
  connect(add.y, activePower) annotation (Line(points={{0,-81},{0,-110}}, color={0,0,127}));
  connect(plug_p, plugToPins_p.plug_p) 
    annotation (Line(points={{-100,0},{-72,0}}, color={85,170,255}));
  connect(plugToPins_n.plug_n, plug_n) 
    annotation (Line(points={{72,0},{100,0}}, color={85,170,255}));
  connect(plugToPins_p.pin_p[1], powerSensor1.currentP) annotation (Line(
        points={{-68,0},{-68,40},{-40,40}}, color={85,170,255}));
  connect(powerSensor1.currentP, powerSensor1.voltageP) annotation (Line(
        points={{-40,40},{-40,50},{-30,50}}, color={85,170,255}));
  connect(powerSensor1.currentN, plugToPins_n.pin_n[1]) annotation (Line(
        points={{-20,40},{68,40},{68,0}}, color={85,170,255}));
  connect(plugToPins_p.pin_p[2], plugToPins_n.pin_n[2]) 
    annotation (Line(points={{-68,0},{68,0}}, color={85,170,255}));
  connect(plugToPins_p.pin_p[3], powerSensor3.currentP) annotation (Line(
        points={{-68,0},{-68,-40},{20,-40}}, color={85,170,255}));
  connect(powerSensor3.currentP, powerSensor3.voltageP) annotation (Line(
        points={{20,-40},{20,-50},{30,-50}}, color={85,170,255}));
  connect(powerSensor3.currentN, plugToPins_n.pin_n[3]) annotation (Line(
        points={{40,-40},{68,-40},{68,0}}, color={85,170,255}));
  connect(complexToReal3.re, add.u1) 
    annotation (Line(points={{6,-34},{6,-58}}, color={0,0,127}));
  connect(complexToReal1.re, add.u2) annotation (Line(points={{-34,-32},{
          -34,-50},{-6,-50},{-6,-58}}, color={0,0,127}));
  connect(powerSensor3.apparentPower, complexToReal3.u) annotation (Line(points={{20,-29},{20,10},{0,10},{0,-10}}, color={85,170,255}));
  connect(powerSensor1.apparentPower, complexToReal1.u) annotation (Line(points={{-40,29},{-40,-8}}, color={85,170,255}));
  connect(plugToPins_p.pin_p[2], powerSensor1.voltageN) annotation (Line(
        points={{-68,0},{-30,0},{-30,30}}, color={85,170,255}));
  connect(plugToPins_p.pin_p[2], powerSensor3.voltageN) annotation (Line(
        points={{-68,0},{30,0},{30,-30}}, color={85,170,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
            -100},{100,100}}), graphics={
                                       Line(points={{0,-100}, 
          {0,-70}}, color={0,0,127}), 
        Text(
          extent={{150,-100},{-150,-70}}, 
          textString="m=%m"), 
        Text(
          extent={{-150,80},{150,120}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-30,-10},{30,-70}}, 
          textColor={64,64,64}, 
          textString="W"), 
        Line(points={{-100,0},{100,0}}, color={85,170,255})}), 
                                  Documentation(info="<html>
<p>包含两个<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PowerSensor\">功率计</a>，用于测量三相系统中的总有功功率。</p>
<p>此设备仅在无中性的三相系统中工作。</p>
<p>此传感器背后的原理是电路两部分之间交换的功率是两部分之间连接的<i>m</i>根导线中的电流乘以参考任意电势<i>v</i><sub>ref</sub>的电位之和：</p>
<p><i>P</i>=(<i>v</i><sub>1</sub>-<i>v</i><sub>ref</sub>)*<i>i</i><sub>1</sub>+(<i>v</i><sub>2</sub>-<i>v</i><sub>ref</sub>)*<i>i</i><sub>2</sub>+&hellip;+(<i>v</i><sub>m</sub>-<i>v</i><sub>ref</sub>)*<i>i</i><sub>m</sub></p>
<p>在没有中性的三相系统中，我们可能希望测量流经连接电路左部分和右部分的线路中的功率。连接两部分的导线仅有三根（即<i>m</i>=3），因此两部分之间的所有电流为<i>i</i><sub>1</sub>、<i>i</i><sub>2</sub>、<i>i</i><sub>3</sub>。</p>
<p>由于所取的参考电压是任意的，我们可以取导线2的电压作为参考。因此，我们的功率变为：</p>
<p><i>P</i>=(<i>v</i><sub>1</sub>-<i>v</i><sub>2</sub>)*<i>i</i><sub>1</sub>+(<i>v</i><sub>2</sub>-<i>v</i><sub>2</sub>)*<i>i</i><sub>2</sub>+(<i>v</i><sub>3</sub>-<i>v</i><sub>2</sub>)*<i>i</i><sub>3 </sub>=
(<i>v</i><sub>1</sub>-<i>v</i><sub>2</sub>)*i<sub>1</sub>+(<i>v</i><sub>3</sub>-<i>v</i><sub>2</sub>)* i<sub>3</sub></p>
<p>这样，我们只需将两个瓦特表的功率相加即可得到三相功率。</p>
<p>请注意，如果我们电路的左部分和右部分之间有额外的电流路径，例如，如果两者都接地（并且电流通过它流过），则此公式不起作用。</p>
<p>有关电路中两个子电路之间流动的功率为电压和电流乘积之和的更多信息，所测量的电压是相对于任意参考电势进行测量的，请参见
[<a href=\"modelica://Modelica.Electrical.Polyphase.UsersGuide.References\">Ceraolo2014</a>, par. 3.8.1]。</p>
</html>"));
end AronSensor;