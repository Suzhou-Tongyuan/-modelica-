within Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2Pulse;
model ThyristorBridge2Pulse_RLV_Characteristic 
  "带有电阻电感负载和电压的双脉冲格雷兹晶闸管桥整流器的特性"
  extends ExampleTemplates.ThyristorBridge2Pulse(pulse2(
        useConstantFiringAngle=false));
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter SI.Voltage Vdi0=2/pi*sin(pi/2)*sqrt(2)*Vrms 
    "理想最大直流电压";
  parameter SI.Resistance R=20 "负载电阻";
  parameter SI.Inductance L=1 "负载电感" 
    annotation (Evaluate=true);
  parameter SI.Voltage VDC=-120 "DC负载偏移电压";
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
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V= 
        VDC) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={30,-30})));
  Modelica.Blocks.Sources.Ramp ramp(height=pi, duration=10) annotation (
     Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=270, 
        origin={-30,-50})));
equation
  connect(resistor.n, inductor.p) annotation (Line(
      points={{30,20},{30,10}}, color={0,0,255}));
  connect(inductor.n, constantVoltage.p) annotation (Line(
      points={{30,-10},{30,-20}}, color={0,0,255}));
  connect(constantVoltage.n, currentSensor.p) annotation (Line(
      points={{30,-40},{10,-40}}, color={0,0,255}));
  connect(ramp.y, pulse2.firingAngle) annotation (Line(
      points={{-30,-39},{-30,-39},{-30,-14}}, color={0,0,127}));
  connect(resistor.p, rectifier.dc_p) annotation (Line(
      points={{30,40},{-10,40},{-10,40},{-20,40}}, color={0,0,255}));
  annotation (
    experiment(
      StopTime=10, 
      Tolerance=1e-06, 
      Interval=0.0002), 
    Documentation(info="<html>

<p>这个示例展示了一个带有R-L负载和直流电压源的双脉冲全控制桥整流器的特性。这个示例中额外的直流电压源使得负载的平均电压可以为负。</p>

<p>绘制平均电压 <code>meanVoltage.v</code> 与导通角 <code>pulse2.firingAngle</code> 的关系图，以查看带有R-L负载和电压的这种整流器的控制特性。</p>
</html>"));
end ThyristorBridge2Pulse_RLV_Characteristic;