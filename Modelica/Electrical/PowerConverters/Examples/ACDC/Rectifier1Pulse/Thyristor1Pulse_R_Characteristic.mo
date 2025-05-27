within Modelica.Electrical.PowerConverters.Examples.ACDC.Rectifier1Pulse;
model Thyristor1Pulse_R_Characteristic 
  "具有电阻负载的单脉冲整流器的控制特性"
  extends ExampleTemplates.Thyristor1Pulse(pulse2(
        useConstantFiringAngle=false, f=f));
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter SI.Resistance R=20 "负载电阻";
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
      Placement(transformation(
        origin={30,30}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
  Modelica.Blocks.Sources.Ramp ramp(height=pi, duration=10) annotation (
     Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=270, 
        origin={-40,-70})));
equation
  connect(resistor.n, currentSensor.p) annotation (Line(
      points={{30,20},{30,-40},{10,-40}}, color={0,0,255}));
  connect(resistor.p, idealthyristor.n) annotation (Line(
      points={{30,40},{0,40}}, color={0,0,255}));
  connect(ramp.y, pulse2.firingAngle) annotation (Line(
      points={{-40,-59},{-40,-12}}, color={0,0,127}));
  annotation (
    experiment(
      StopTime=10, 
      Tolerance=1e-06, 
      Interval=0.0002), 
    Documentation(info="<html>
<p>该示例演示了具有可变触发角和电阻负载的单相控制整流器的运行行为。通过触发角可以控制平均负载电压。</p>
<p><br>绘制平均电压<code>meanVoltage.v</code>与触发角<code>pulse2.firingAngle</code>的关系图，以查看具有电阻负载的这种类型整流器的控制特性。</p>
</html>"));
end Thyristor1Pulse_R_Characteristic;