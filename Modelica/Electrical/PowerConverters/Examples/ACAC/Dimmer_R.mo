within Modelica.Electrical.PowerConverters.Examples.ACAC;
model Dimmer_R "电阻负载的调光器"
  extends PowerConverters.Examples.ACAC.ExampleTemplates.Dimmer(powerFactor=1);
  extends Modelica.Icons.Example;
  Modelica.Electrical.Analog.Basic.Resistor loadResistor(R=RLoad) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={50,10})));
equation
  connect(ground.p, loadResistor.n) annotation (Line(points={{-80,-20},{50,-20}, 
          {50,-3.55271e-15}}, color={0,0,255}));
  connect(loadResistor.p, multiSensor.nc) 
    annotation (Line(points={{50,20},{50,40},{30,40}}, color={0,0,255}));
  annotation (experiment(
      StopTime=8, 
      Interval=0.0001, 
      Tolerance=1e-06), 
    Documentation(info="<html>
<p>
该模型演示了具有电阻性负载的相位角控制调光器的行为。
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
end Dimmer_R;