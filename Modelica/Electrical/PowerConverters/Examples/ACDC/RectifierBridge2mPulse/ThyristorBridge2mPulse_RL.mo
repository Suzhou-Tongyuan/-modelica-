within Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2mPulse;
model ThyristorBridge2mPulse_RL 
  "带电阻电感负载的2*m脉冲可控硅整流桥"
  extends ExampleTemplates.ThyristorBridge2mPulse(pulse2m(
        constantFiringAngle=constantFiringAngle), rectifier(offStart_p= 
          fill(true, m), offStart_n=fill(true, m)));
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter SI.Angle constantFiringAngle=30*pi/180 
    "触发角";
  parameter SI.Resistance R=20 "负载电阻";
  parameter SI.Inductance L=1 "负载电感" 
    annotation (Evaluate=true);
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
      Placement(transformation(
        origin={30,30}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
  Modelica.Electrical.Analog.Basic.Inductor inductor(L=L, i(start=0, 
        fixed=true)) annotation (Placement(transformation(
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
<p>该示例展示了一个带有R-L负载的全控制的<code>2*m</code>脉冲桥式整流器，其中<code>m</code>是相数。</p>

<p>绘制电流<code>currentSensor.i</code>、平均电流<code>meanCurrent.y</code>、电压<code>voltageSensor.v</code>和平均电压<code>meanVoltage.v</code>。</p>
</html>"));
end ThyristorBridge2mPulse_RL;