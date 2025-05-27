within Modelica.Electrical.PowerConverters.Examples.DCDC.HBridge;
model HBridge_R "带电阻负载的H桥直流直流变换器"
  extends ExampleTemplates.HBridge;
  extends Modelica.Icons.Example;
  parameter SI.Resistance R=100 "电阻";
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={20,50})));
equation
  connect(resistor.p, hbridge.dc_p2) annotation (Line(
      points={{20,60},{20,70},{-30,70},{-30,6},{-40,6}}, color={0,0,255}));
  connect(resistor.n, currentSensor.p) annotation (Line(
      points={{20,40},{20,-6},{0,-6}}, color={0,0,255}));
  annotation (
    experiment(
      StopTime=0.1, 
      Interval=0.0002, 
      Tolerance=1e-06), 
    Documentation(info="<html>
<p>此示例演示了由 H 桥操作的电阻性负载的开关。
直流输出电压等于<code>2 * (dutyCycle - 0.5)</code>乘以输入电压。
绘制电流<code>currentSensor.i</code>、平均电流<code>meanCurrent.y</code>、总电压<code>voltageSensor.v</code>和电压<code>meanVoltage.v</code>。</p>
</html>"));
end HBridge_R;