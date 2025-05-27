within Modelica.Electrical.Analog.Examples;
model ShowVariableResistor "简单演示可变电阻模型"
   extends Modelica.Icons.Example;

  Modelica.Electrical.Analog.Basic.VariableResistor VariableResistor 
                    annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  Modelica.Electrical.Analog.Basic.Ground Ground1 
  annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
  Modelica.Electrical.Analog.Basic.Ground Ground2 
  annotation (Placement(transformation(extent={{60,-40},{80,-20}})));
  Modelica.Electrical.Analog.Basic.Resistor R1(R=1) 
  annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Electrical.Analog.Basic.Resistor R2(R=1) 
  annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Modelica.Electrical.Analog.Basic.Resistor R3(R=1) 
  annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Modelica.Electrical.Analog.Basic.Resistor R4(R=1) 
  annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  Modelica.Electrical.Analog.Basic.Resistor R5(R=1) 
  annotation (Placement(transformation(extent={{20,-20},{40,0}})));

  Modelica.Electrical.Analog.Sources.SineVoltage SineVoltage1(V=1, f=1) 
  annotation (Placement(transformation(
        origin={-90,-30}, 
        extent={{-10,-10},{10,10}}, 
        rotation=90)));
  Modelica.Blocks.Sources.Ramp Ramp1(height=5, offset=2, 
    duration=2) 
  annotation (Placement(transformation(
        origin={-10,20}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
equation
  connect(R1.n, R2.p) annotation (Line(points={{-40,50},{-20,50}}, color={0,0,255}));
  connect(R2.n, R3.p) annotation (Line(points={{0,50},{20,50}}, color={0,0,255}));
  connect(R4.n, VariableResistor.p) annotation (Line(points={{-40,-10},{
          -20,-10}}, color={0,0,255}));
  connect(VariableResistor.n, R5.p) annotation (Line(points={{0,-10},{20, 
          -10}}, color={0,0,255}));
  connect(R3.n, Ground2.p) annotation (Line(points={{40,50},{70,50},{70, 
          -20}}, color={0,0,255}));
  connect(Ground2.p, R5.n) annotation (Line(points={{70,-20},{70,-10},{40, 
          -10}}, color={0,0,255}));
  connect(SineVoltage1.p, Ground1.p) annotation (Line(points={{-90,-40},{-90,-60}}, color={0,0,255}));
  connect(SineVoltage1.n, R1.p) annotation (Line(points={{-90,-20},{-90,50}, 
          {-60,50}}, color={0,0,255}));
  connect(SineVoltage1.n, R4.p) annotation (Line(points={{-90,-20},{-90, 
          -10},{-60,-10}}, color={0,0,255}));
  connect(Ramp1.y, VariableResistor.R) annotation (Line(points={{-10,9},{-10,2},{-10,2}}, color={0,0,255}));
annotation (Documentation(info="<html>
<p>这是一个用于测试可变电阻工作性能的简单测试回路。用户可以在特定界面将VariableResistor的图像与R2的相关图像进行比较。</p>
<p>该测试回路的仿真时间为1秒。</p>
</html>", 
   revisions="<html>
<p><strong>版本信息：</strong></p>
<ul>
<li><em>2004/5/6   </em>
       Teresa Schlegel<br> 创建<br>
       </li>
</ul>
</html>"), 
  experiment(StopTime=1), 
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={Text(
          extent={{-100,112},{80,40}}, 
          textColor={0,0,255}, 
          textString="Example VariableResistor")}));
end ShowVariableResistor;