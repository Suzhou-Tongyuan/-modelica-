within Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTapmPulse;
model ThyristorCenterTapmPulse_RLV 
  "带中心点和电阻电感负载及电压的2*m脉冲晶闸管整流器"
  extends ExampleTemplates.ThyristorCenterTapmPulse(pulsem(
        constantFiringAngle=constantFiringAngle));
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter SI.Angle constantFiringAngle=30*pi/180 
    "触发角";
  parameter SI.Resistance R=20 "负载电阻";
  parameter SI.Inductance L=1 "负载电感" 
    annotation (Evaluate=true);
  parameter SI.Voltage VDC=-50 "DC 负载偏置电压";
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
equation
  connect(resistor.n, inductor.p) annotation (Line(
      points={{30,20},{30,10}}, color={0,0,255}));
  connect(inductor.n, constantVoltage.p) annotation (Line(
      points={{30,-10},{30,-10},{30,-20}}, color={0,0,255}));
  connect(constantVoltage.n, currentSensor.p) annotation (Line(
      points={{30,-40},{30,-40},{30,-48},{30,-48},{30,-50},{10,-50}}, color={0,0,255}));
  connect(resistor.p, rectifier.dc_p) annotation (Line(
      points={{30,40},{-10,40},{-10,40},{-20,40}}, color={0,0,255}));
  annotation (
    experiment(
      StopTime=0.1, 
      Tolerance=1e-06, 
      Interval=0.0002), 
    Documentation(info="<html>
<p>此示例展示了带有 R-L 负载的受控 2*m 脉冲中心点整流器，包括 DC 电压源，其中 <code>m</code> 是相数。此示例中的额外 DC 电压源使得负载平均电压为负。</p>

<p>绘制电流 <code>currentSensor.i</code>、平均电流 <code>meanCurrent.y</code>、电压 <code>voltageSensor.v</code> 和平均电压 <code>meanVoltage.v</code>。</p>
</html>"));
end ThyristorCenterTapmPulse_RLV;