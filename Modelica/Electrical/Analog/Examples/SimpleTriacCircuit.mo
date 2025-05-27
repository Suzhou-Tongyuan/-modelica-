within Modelica.Electrical.Analog.Examples;
model SimpleTriacCircuit "简单的双向晶闸管测试电路"
  extends Modelica.Icons.Example;

  Modelica.Electrical.Analog.Basic.Ground ground 
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
  Modelica.Electrical.Analog.Basic.Inductor L(L=2e-6, i(start=0, fixed=true), 
    p(                                                          v(  start=0))) 
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
  Modelica.Electrical.Analog.Basic.Resistor R(R=10) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={60,30})));
  Modelica.Electrical.Analog.Sources.SineVoltage V(V=30, f=10000) 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={60,-10})));
  Modelica.Electrical.Analog.Semiconductors.SimpleTriac simpleTriac(VDRM=400, VRRM=400, 
    thyristor1(                                                                         vGK(           start=0))) 
                          annotation (Placement(transformation(
        extent={{-13,-13},{11,11}}, 
        rotation=270, 
        origin={1,23})));
  Sources.TrapezoidCurrent                        trapezoidCurrent(
    I=0.005, 
    rising=0.000001, 
    width=0.000005, 
    falling=0.000001, 
    nperiod=-1, 
    startTime=0.00002, 
    period=0.00005) 
                annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-40,-10})));

initial equation
     simpleTriac.thyristor.vControl=0;
    simpleTriac.thyristor1.vControl=0;

equation
  connect(L.n, R.p) annotation (Line(
      points={{40,60},{60,60},{60,40}}, color={0,0,255}));
  connect(R.n, V.p) annotation (Line(
      points={{60,20},{60,0}}, color={0,0,255}));
  connect(V.n, ground.p) annotation (Line(
      points={{60,-20},{60,-40},{0,-40}}, color={0,0,255}));
  connect(simpleTriac.p, ground.p) annotation (Line(
      points={{0,12},{0,-40}},    color={0,0,255}));
  connect(simpleTriac.n, L.p) annotation (Line(
      points={{0,36},{0,60},{20,60}}, color={0,0,255}));
  connect(trapezoidCurrent.n, simpleTriac.g) annotation (Line(points={{-40,0},{
          -40,40},{-12,40},{-12,36}}, color={0,0,255}));
  connect(trapezoidCurrent.p, ground.p) 
    annotation (Line(points={{-40,-20},{-40,-40},{0,-40}}, color={0,0,255}));
  annotation (experiment(
      StopTime=0.001, 
      Interval=5e-7, 
      Tolerance=1e-12), 
    Documentation(revisions="<html>
<ul>
<li><em>2009/11/5   </em><br>

       Susann Wolf<br><br>
       </li>
</ul>
</html>", info="<html>
<p>这个simple TRIAC示例展示了如何在交流电路中使用simple Triac。</p>
<p>在门控输入g为正前，晶闸管不导通。在输入g为正后，晶闸管导通。如果晶闸管电压改变了方向，晶闸管就会变成关断状态。晶闸管可以在两个方向上导通电流，从而实现双向控制。</p>
<p>该示例的仿真结束时间为0.001秒。用户可在“仿真--仿真浏览器”中勾选以下的“仿真结果变量”查看示例的工作状态:V.p.v (输入电压)、 simpleTriac.g.i (门控输入)、simplelTriac.n.v、simpleTriac.n.i</p>
</html>"));
end SimpleTriacCircuit;