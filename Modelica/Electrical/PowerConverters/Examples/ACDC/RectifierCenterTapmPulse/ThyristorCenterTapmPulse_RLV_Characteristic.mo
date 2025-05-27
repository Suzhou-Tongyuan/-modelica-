within Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTapmPulse;
model ThyristorCenterTapmPulse_RLV_Characteristic 
  "带中心点和电阻电感负载及电压的2*m脉冲可控硅整流器特性"
  extends ExampleTemplates.ThyristorCenterTapmPulse(pulsem(
        useConstantFiringAngle=false));
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter SI.Resistance R=20 "负载电阻";
  parameter SI.Inductance L=1 "负载电感" 
    annotation (Evaluate=true);
  parameter SI.Voltage VDC=-50 "直流负载偏置电压";
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
        origin={-30,-70})));
equation
  connect(resistor.n, inductor.p) annotation (Line(
      points={{30,20},{30,10}}, color={0,0,255}));
  connect(inductor.n, constantVoltage.p) annotation (Line(
      points={{30,-10},{30,-20}}, color={0,0,255}));
  connect(currentSensor.p, constantVoltage.n) annotation (Line(
      points={{10,-50},{30,-50},{30,-40}}, color={0,0,255}));
  connect(resistor.p, rectifier.dc_p) annotation (Line(
      points={{30,40},{-10,40},{-10,40},{-20,40}}, color={0,0,255}));
  connect(ramp.y, pulsem.firingAngle) annotation (Line(
      points={{-30,-59},{-30,-12}}, color={0,0,127}));
  annotation (
    experiment(
      StopTime=10, 
      Tolerance=1e-06, 
      Interval=0.0002), 
    Documentation(info="<html>
<p>该示例展示了带有R-L负载及直流电压源的可控<m>脉冲中心点整流器，其中<m>是相数。该示例中的额外直流电压源可以产生负平均负载电压。</p>

<p>绘制平均电压<code>meanVoltage.v</code>与触发角<code>pulsem.firingAngle</code>的曲线，以查看带有R-L负载及主动电压的这种整流器的控制特性。</p>
</html>"));
end ThyristorCenterTapmPulse_RLV_Characteristic;