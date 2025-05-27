within Modelica.Electrical.PowerConverters.Examples.DCAC.SinglePhaseTwoLevel;
model SinglePhaseTwoLevel_RL 
  "带电阻电感负载的单相直流到交流转换器"
  extends ExampleTemplates.SinglePhaseTwoLevel(sine(
      amplitude=0.5, 
      offset=0.5, 
      f=f1));
  extends Modelica.Icons.Example;
  parameter SI.Resistance R=100 "电阻";
  parameter SI.Inductance L=1 "电感";
  parameter SI.Frequency f1=50 "AC频率";
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={40,10})));
  Modelica.Electrical.Analog.Basic.Inductor inductor(L=L, i(fixed=true)) 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={40,-22})));
equation
  connect(resistor.p, inverter.ac) annotation (Line(
      points={{40,20},{40,30},{-30,30}}, color={0,0,255}));
  connect(resistor.n, inductor.p) annotation (Line(
      points={{40,0},{40,-12}}, color={0,0,255}));
  connect(inductor.n, currentSensor.p) annotation (Line(
      points={{40,-32},{40,-70},{10,-70}}, color={0,0,255}));
  annotation (
    experiment(
      StartTime=0, 
      StopTime=0.1, 
      Tolerance=1e-06, 
      Interval=0.0002), 
    Documentation(info="<html>
<p>绘制电流<code>currentSensor.i</code>、平均电流<code>meanCurrent.y</code>、电压<code>voltageSensor.v</code>和平均电压<code>meanVoltage.v</code>。瞬时电压直接显示逆变器的开关模式。电流显示由输入电压和开关频率决定的特定纹波。平均电压基本上与命令<code>sine.y</code>同相。平均电流由于R-L负载具有相移。</p>
</html>"));
end SinglePhaseTwoLevel_RL;