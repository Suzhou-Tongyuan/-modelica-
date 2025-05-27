within Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2mPulse;
model ThyristorBridge2mPulse_RLV_Characteristic 
  "带电阻电感负载和电压的2*m脉冲晶闸管整流桥的特性"
  extends ExampleTemplates.ThyristorBridge2mPulse(pulse2m(
        useConstantFiringAngle=false));
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter SI.Voltage Vdi0= 
      Modelica.Electrical.Polyphase.Functions.factorY2DC(m)*Vrms 
    "理想最大直流电压";
  parameter SI.Resistance R=20 "负载电阻";
  parameter SI.Inductance L=1 "负载电感" 
    annotation (Evaluate=true);
  parameter SI.Voltage VDC=-260 "DC 负载偏置电压";
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
  connect(currentSensor.p, constantVoltage.n) annotation (Line(
      points={{10,-40},{30,-40}}, color={0,0,255}));
  connect(ramp.y, pulse2m.firingAngle) annotation (Line(
      points={{-30,-39},{-30,-12}}, color={0,0,127}));
  connect(resistor.p, rectifier.dc_p) annotation (Line(
      points={{30,40},{-10,40},{-10,40},{-20,40}}, color={0,0,255}));
  annotation (
    experiment(
      StopTime=10, 
      Tolerance=1e-06, 
      Interval=0.0002), 
    Documentation(info="<html>
<p>此示例展示了带有 R-L 负载和电压的全控制 <code>2*m</code> 脉冲整流桥，其中 <code>m</code> 是相数。此示例中的额外 DC 电压源使得负载平均电压为负。</p>

<p>绘制平均电压 <code>meanVoltage.v</code> 相对于触发角 <code>pulse2m.firingAngle</code>，以查看带有 R-L 负载和主动电压的此类型整流器的控制特性。</p>
</html>"));
end ThyristorBridge2mPulse_RLV_Characteristic;