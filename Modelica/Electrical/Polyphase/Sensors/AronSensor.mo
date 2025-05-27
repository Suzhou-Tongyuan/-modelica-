within Modelica.Electrical.Polyphase.Sensors;
model AronSensor "用于有功功率的三相传感器"
  extends Modelica.Icons.RoundSensor;
  final parameter Integer m(final min=1) = 3 "相数" annotation(Evaluate=true);
  Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  Interfaces.NegativePlug plug_n(final m=m) annotation (Placement(
        transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealOutput power(unit="W") "主动功率" annotation (
      Placement(transformation(
        origin={0,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
  Basic.PlugToPins_p plugToPins_p(final m=m) 
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Basic.PlugToPins_n plugToPins_n(final m=m) 
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor1 
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor3 
    annotation (Placement(transformation(extent={{20,-30},{40,-50}})));
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={0,-70})));
equation
  connect(plug_p, plugToPins_p.plug_p) 
    annotation (Line(points={{-100,0},{-72,0}}, color={0,0,255}));
  connect(plugToPins_n.plug_n, plug_n) 
    annotation (Line(points={{72,0},{100,0}}, color={0,0,255}));
  connect(plugToPins_p.pin_p[1], powerSensor1.pc) annotation (Line(points={{-68,0}, 
          {-68,40},{-40,40}},            color={0,0,255}));
  connect(powerSensor1.pc, powerSensor1.pv) 
    annotation (Line(points={{-40,40},{-40,50},{-30,50}}, color={0,0,255}));
  connect(powerSensor1.nc, plugToPins_n.pin_n[1]) annotation (Line(points={{-20,40}, 
          {68,40},{68,0}},            color={0,0,255}));
  connect(plugToPins_p.pin_p[2], plugToPins_n.pin_n[2]) 
    annotation (Line(points={{-68,0},{68,0}}, color={0,0,255}));
  connect(plugToPins_p.pin_p[3], powerSensor3.pc) annotation (Line(points={{-68,0}, 
          {-68,-40},{20,-40}},            color={0,0,255}));
  connect(powerSensor3.pc, powerSensor3.pv) 
    annotation (Line(points={{20,-40},{20,-50},{30,-50}}, color={0,0,255}));
  connect(powerSensor3.nc, plugToPins_n.pin_n[3]) annotation (Line(points={{40,-40}, 
          {68,-40},{68,0}},        color={0,0,255}));
  connect(powerSensor1.nv, plugToPins_p.pin_p[2]) 
    annotation (Line(points={{-30,30},{-30,0},{-68,0}}, color={0,0,255}));
  connect(powerSensor3.nv, plugToPins_p.pin_p[2]) 
    annotation (Line(points={{30,-30},{30,0},{-68,0}}, color={0,0,255}));
  connect(add.y, power) 
    annotation (Line(points={{0,-81},{0,-110}}, color={0,0,127}));
  connect(powerSensor1.power, add.u2) annotation (Line(points={{-40,29},{-40,-50}, 
          {-6,-50},{-6,-58}}, color={0,0,127}));
  connect(powerSensor3.power, add.u1) annotation (Line(points={{20,-29},{20,-20}, 
          {6,-20},{6,-58}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
            -100},{100,100}}), graphics={
                            Line(points={{100,0},{-100,0}}, color={0,0,255}), 
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
          textString="W")}),      Documentation(info="<html>
<p>包含两个<a href=\"modelica://Modelica.Electrical.Analog.Sensors.PowerSensor\">功率计</a>，用于测量三相系统中的总有功功率。</p>
<p>此设备仅适用于没有中性线的三相系统。</p>
<p>这种传感器背后的原理是电路的两个部分之间交换的功率是连接两个部分的m条线路中电流与电势的乘积的和，电势相对于任意电势v<sub>ref</sub>进行评估：</p>
<p><em>P</em>=(<em>v</em><sub>1</sub>-<em>v</em><sub>ref</sub>)*<em>i</em><sub>1</sub>+(<em>v</em><sub>2</sub>-<em>v</em><sub>ref</sub>)*<em>i</em><sub>2</sub>+&hellip;+(<em>v</em><sub>m</sub>-<em>v</em><sub>ref</sub>)*<em>i</em><sub>m</sub></p>
<p>在没有中性线的三相系统中，我们可能希望测量流经线路的功率，例如连接电路的左部分和右部分。连接两个部分的导线只有三条(即m=3)，因此连接这两个部分之间的所有电流为i<sub>1</sub>，i<sub>2</sub>，i<sub>3</sub>。</p>
<p>由于要作为参考的电压是任意的，我们可以采用导线2的电压作为参考。因此，我们的功率变为：</p>
<p><em>P</em>=(<em>v</em><sub>1</sub>-<em>v</em><sub>2</sub>)*<em>i</em><sub>1</sub>+(<em>v</em><sub>2</sub>-<em>v</em><sub>2</sub>)*<em>i</em><sub>2</sub>+(<em>v</em><sub>3</sub>-<em>v</em><sub>2</sub>)*<em>i</em><sub>3 </sub>=
(<em>v</em><sub>1</sub>-<em>v</em><sub>2</sub>)*i<sub>1</sub>+(<em>v</em><sub>3</sub>-<em>v</em><sub>2</sub>)* i<sub>3</sub></p>
<p>通过这种方式，我们只需将两个瓦特表的功率相加即可得到三相功率。</p>
<p>请注意，如果电路的左部分和右部分之间存在其他电流路径，例如，如果两者都接地(并且电流流经它)，则此公式不起作用。</p>
<p>有关在电路的两个子电路之间流动的功率为电压乘以电流的乘积之和的更多信息，其中电压是相对于任意参考电势进行测量的，请参见
[<a href=\"modelica://Modelica.Electrical.Polyphase.UsersGuide.References\">Ceraolo2014</a>，第3.8.1节]。</p>
</html>"));
end AronSensor;