within Modelica.Electrical.PowerConverters.Examples.ACAC;
model Dimmer_RL "电阻电感负载的调光器"
  extends PowerConverters.Examples.ACAC.ExampleTemplates.Dimmer(powerFactor= 
        0.87);
  extends Modelica.Icons.Example;
  Modelica.Electrical.Analog.Basic.Resistor loadResistor(R=RLoad) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={50,30})));
  Modelica.Electrical.Analog.Basic.Inductor loadInductor(i(start=0, fixed=true), 
      L=LLoad) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={50,-10})));
equation
  connect(loadResistor.p, multiSensor.nc) 
    annotation (Line(points={{50,40},{30,40}},         color={0,0,255}));
  connect(ground.p, loadInductor.n) 
    annotation (Line(points={{-80,-20},{50,-20}}, color={0,0,255}));
  connect(loadInductor.p, loadResistor.n) 
    annotation (Line(points={{50,0},{50,20}}, color={0,0,255}));
  annotation (experiment(
      StopTime=8, 
      Interval=0.0001, 
      Tolerance=1e-06), 
    Documentation(info="<html>
<p>
该模型演示了具有电阻性-感性负载的相位角控制调光器的行为。
请注意，由于电感，电流在电压的零点交叉时不为零，
并且晶闸管保持导通状态，直到电流变为零。
</p>
<p>
参考电压由从零到满电压的梯形指定。
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACAC.Control.VoltageToAngle\">voltageToAngle block</a>
计算所需的相位角，由
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACDC.Control.Signal2mPulse\">Signal2mPulse适配器</a>
处理，并将触发信号应用于
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACAC.SinglePhaseTriac\">三角洲型晶闸管</a>。
</p>
</html>"));
end Dimmer_RL;