within Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2Pulse;
model ThyristorBridge2Pulse_RL 
  "具有电阻电感负载的双脉冲格雷兹晶闸管桥整流器"
  extends ExampleTemplates.ThyristorBridge2Pulse(pulse2(
        constantFiringAngle=constantFiringAngle));
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter SI.Angle constantFiringAngle=30*pi/180 
    "导通角";
  parameter SI.Resistance R=20 "负载电阻";
  parameter SI.Inductance L=1 "负载电感" 
    annotation (Evaluate=true);
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
      Placement(transformation(
        origin={30,30}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
  Modelica.Electrical.Analog.Basic.Inductor inductor(L=L, i(fixed=true, 
        start=0)) annotation (Placement(transformation(
        origin={30,0}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
equation
  connect(resistor.n, inductor.p) annotation (Line(
      points={{30,20},{30,10}}, color={0,0,255}));
  connect(inductor.n, currentSensor.p) annotation (Line(
      points={{30,-10},{30,-40},{10,-40}}, color={0,0,255}));
  connect(resistor.p, rectifier.dc_p) annotation (Line(
      points={{30,40},{-10,40},{-10,40},{-20,40}}, color={0,0,255}));
  annotation (
    experiment(
      StopTime=0.1, 
      Tolerance=1e-06, 
      Interval=0.0002), 
    Documentation(info="<html>
<p>这个示例展示了一个具有R-L负载的双脉冲全控制桥整流器。</p>

<p>绘制电流 <code>currentSensor.i</code>、平均电流 <code>meanCurrent.y</code>、电压 <code>voltageSensor.v</code> 和平均电压 <code>meanVoltage.v</code>。</p>
</html>"));
end ThyristorBridge2Pulse_RL;