within Modelica.Electrical.Analog.Examples;
model ControlledSwitchWithArc 
  "受控开关模型差异比较(考虑电弧效应与不考虑电弧效应)"
  extends Modelica.Icons.Example;
  Modelica.Electrical.Analog.Basic.Ground ground1 
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage1(V=50) 
    annotation (Placement(transformation(
        origin={-20,20}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Inductor inductor1(L=0.1, i(fixed=true, 
        start=0)) 
    annotation (Placement(transformation(extent={{40,30},{60,50}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R=1) 
    annotation (Placement(transformation(
        origin={80,20}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Electrical.Analog.Ideal.ControlledIdealClosingSwitch switch1 
                   annotation (Placement(transformation(extent={{0,30},{20,50}})));
  Modelica.Electrical.Analog.Basic.Ground ground2 
    annotation (Placement(transformation(extent={{20,-100},{40,-80}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage2(V=50) 
    annotation (Placement(transformation(
        origin={-20,-60}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Inductor inductor2(L=0.1, i(fixed=true, 
        start=0)) 
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor2(R=1) 
    annotation (Placement(transformation(
        origin={80,-60}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Electrical.Analog.Ideal.ControlledCloserWithArc switch2(
    V0=30, 
    dVdt=10000, 
    Vmax=60, 
    off(fixed=true)) 
                   annotation (Placement(transformation(extent={{0,-50},{20, 
            -30}})));
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(V=1, f=1) 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-70,-10})));
  Modelica.Electrical.Analog.Basic.Ground ground 
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
equation
  connect(inductor1.n,resistor1. p) annotation (Line(points={{60,40},{80,40}, 
          {80,30}}, color={0,0,255}));
  connect(resistor1.n,ground1. p) 
    annotation (Line(points={{80,10},{80,0},{30,0}}, color={0,0,255}));
  connect(constantVoltage1.n,ground1. p) 
    annotation (Line(points={{-20,10},{-20,0},{30,0}}, color={0,0,255}));
  connect(switch1.n,inductor1. p) 
    annotation (Line(points={{20,40},{40,40}}, color={0,0,255}));
  connect(constantVoltage1.p,switch1. p) annotation (Line(points={{-20,30},{-20, 
          40},{0,40}}, color={0,0,255}));
  connect(inductor2.n,resistor2. p) annotation (Line(points={{60,-40},{80,-40}, 
          {80,-50}}, color={0,0,255}));
  connect(resistor2.n,ground2. p) 
    annotation (Line(points={{80,-70},{80,-80},{30,-80}}, color={0,0,255}));
  connect(constantVoltage2.n,ground2. p) 
    annotation (Line(points={{-20,-70},{-20,-80},{30,-80}}, color={0,0,255}));
  connect(switch2.n,inductor2. p) 
    annotation (Line(points={{20,-40},{40,-40}}, color={0,0,255}));
  connect(constantVoltage2.p,switch2. p) annotation (Line(points={{-20,-50},{
          -20,-40},{0,-40}}, color={0,0,255}));
  connect(sineVoltage.p, switch1.control) annotation (Line(
      points={{-70,0},{-40,0},{-40,50},{10,50}}, color={0,0,255}));
  connect(sineVoltage.p, switch2.control) annotation (Line(
      points={{-70,0},{-40,0},{-40,-30},{10,-30}}, color={0,0,255}));
  connect(sineVoltage.n, ground.p) annotation (Line(
      points={{-70,-20},{-70,-40}}, color={0,0,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100, 
            -100},{100,100}}), graphics={Text(
          extent={{-100,80},{100,60}}, 
          textColor={0,0,255}, 
          textString="Compare voltage and current of inductor1 and inductor2")}), 
    experiment(
      StopTime=6, 
      Interval=0.00025, 
      Tolerance=1e-006), 
    Documentation(info="<html><p>
该示例旨在比较考虑电弧与不考虑电弧两种情况下两种开关模型运行性能的差异。
</p>
<li>
该示例的仿真时间为2秒。</li>
<li>
用户可在“仿真--仿真浏览器”中勾选相应的“仿真结果变量”查看示例的<code>switch1.i</code>和<code>switch2.i</code></li>
<p>
仿真结果的差异表明了简单的电弧模型能避免突然的开关行为。
</p>
</html>",revisions="<html>
<ul>
<li><em>2009/5   </em>
       Anton Haumer<br> 创建<br>
       </li>
</ul>
</html>"));
end ControlledSwitchWithArc;