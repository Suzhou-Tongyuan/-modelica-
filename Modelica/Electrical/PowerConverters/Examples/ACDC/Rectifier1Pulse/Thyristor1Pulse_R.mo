within Modelica.Electrical.PowerConverters.Examples.ACDC.Rectifier1Pulse;
model Thyristor1Pulse_R 
  "具有电阻负载和恒定触发角的单脉冲整流器"
  extends ExampleTemplates.Thyristor1Pulse(pulse2(
      useConstantFiringAngle=true, 
      f=f, 
      constantFiringAngle=constantFiringAngle));
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter SI.Angle constantFiringAngle=30*pi/180 
    "触发角";
  parameter SI.Resistance R=20 "负载电阻";
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
      Placement(transformation(
        origin={30,30}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
equation
  connect(idealthyristor.n, resistor.p) annotation (Line(
      points={{0,40},{30,40}}, color={0,0,255}));
  connect(resistor.n, currentSensor.p) annotation (Line(
      points={{30,20},{30,-40},{10,-40}}, color={0,0,255}));
  annotation (
    experiment(
      StopTime=0.1, 
      Tolerance=1e-06, 
      Interval=0.0002), 
    Documentation(info="<html>
<p>该示例演示了具有恒定触发角和电阻负载的单相控制整流器的运行行为。</p>
<p>绘制电流<code>currentSensor.i</code>、平均电流<code>meanCurrent.y</code>、电压<code>voltageSensor.v</code>和平均电压<code>meanVoltage.v</code>。</p>
</html>"));
end Thyristor1Pulse_R;