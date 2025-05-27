within Modelica.Electrical.Analog.Examples;
model IdealTriacCircuit "理想三极管测试电路"
  extends Modelica.Icons.Example;

  Modelica.Electrical.Analog.Basic.Ground ground 
    annotation (Placement(transformation(extent={{-12,-40},{8,-20}})));
  Modelica.Electrical.Analog.Basic.Resistor R(R=20) annotation (
      Placement(transformation(
        extent={{-10,-10},{12,12}}, 
        origin={-44,32})));
  Modelica.Electrical.Analog.Sources.SineVoltage V(V=5, f=2) 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        origin={-42,-20})));
  Modelica.Blocks.Sources.BooleanPulse booleanPulse(width=50, 
    period=0.25, 
    startTime=0.1) 
    annotation (Placement(transformation(extent={{-22,0},{-6,16}})));
 Modelica.Electrical.Analog.Ideal.IdealTriac idealTriac(capacitor(v(start=0, fixed=true)),idealThyristor(
                                                        off(               start=true, fixed=true)), idealThyristor1(off(start=true, fixed=true))) 
    annotation (Placement(transformation(extent={{6,20},{32,46}})));

equation
  connect(V.n, ground.p) annotation (Line(
      points={{-32,-20},{-2,-20}}, color={0,0,255}));
  connect(R.p, V.p) annotation (Line(
      points={{-54,33},{-60,33},{-60,-20},{-52,-20}}, color={0,0,255}));
  connect(R.n, idealTriac.n) annotation (Line(
      points={{-32,33},{6,33}}, color={0,0,255}));
  connect(idealTriac.p, ground.p) annotation (Line(
      points={{32.52,33},{42,33},{42,-20},{-2,-20}}, color={0,0,255}));
  connect(idealTriac.fire1, booleanPulse.y) annotation (Line(
      points={{6,18.18},{0,18.18},{0,8},{-5.2,8}},    color={255,0,255}));
  annotation (experiment(StopTime=2), 
    Documentation(revisions="<html>
<ul>
<li><em>2009/11/25   </em><br>

       Susann Wolf<br><br>
       </li>
</ul>
</html>", info="<html>
<p>这个示例展示了TRIAC在交流电路中的应用。</p>
<p>当布尔输入变为真时(内部编码为1，因此称为fire1)，TRIAC才开始导通。一旦导通，就会达到“膝压”电压。如果TRIAC的电压低于膝压电压，TRIAC将停止导通。由于内部两个晶闸管的反并联连接，相同的行为在负半波中重复出现。</p>
<p>该示例的仿真时长为2秒。用户可以在“仿真--仿真浏览器”中勾选相应的“仿真结果变量”查看以下变量的数值：V.p.v(输入电压)、booleanPulse.y(触发输入)、idealTriac.n.v、idealTriac.n.i</p>
</html>"));
end IdealTriacCircuit;