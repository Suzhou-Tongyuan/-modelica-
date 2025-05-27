within Modelica.Electrical.PowerConverters.Examples.DCAC.SinglePhaseTwoLevel;
model SinglePhaseTwoLevel_R 
  "带电阻负载的单相直流到交流转换器"
  extends ExampleTemplates.SinglePhaseTwoLevel(sine(
      amplitude=0.5, 
      offset=0.5, 
      f=f1));
  extends Modelica.Icons.Example;
  parameter SI.Resistance R=100 "电阻";
  parameter SI.Frequency f1=50 "AC频率";
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={40,10})));
equation
  connect(resistor.p, inverter.ac) annotation (Line(
      points={{40,20},{40,30},{-30,30}}, color={0,0,255}));
  connect(resistor.n, currentSensor.p) annotation (Line(
      points={{40,0},{40,-70},{10,-70}}, color={0,0,255}));
  annotation (
    experiment(
      StartTime=0, 
      StopTime=0.1, 
      Tolerance=1e-06, 
      Interval=0.0002), 
    Documentation(info="<html>
<p>绘制电流<code>currentSensor.i</code>、平均电流<code>meanCurrent.y</code>、电压<code>voltageSensor.v</code>和平均电压<code>meanVoltage.v</code>。瞬时电压和电流直接显示逆变器的开关模式。平均电压和平均电流显示电压和电流的基波，它们基本上与命令<code>sine.y</code>同相。</p>
</html>"));
end SinglePhaseTwoLevel_R;