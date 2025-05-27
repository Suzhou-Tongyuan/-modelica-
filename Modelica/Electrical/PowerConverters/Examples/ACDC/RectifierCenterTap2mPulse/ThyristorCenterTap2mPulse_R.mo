within Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTap2mPulse;
model ThyristorCenterTap2mPulse_R 
  "带电阻负载的2*m脉冲可控硅中心点整流器"
  extends ExampleTemplates.ThyristorCenterTap2mPulse(pulse2m(
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
  connect(resistor.n, currentSensor.p) annotation (Line(
      points={{30,20},{30,-50},{10,-50}}, color={0,0,255}));
  connect(resistor.p, rectifier.dc_p) annotation (Line(
      points={{30,40},{-10,40},{-10,40},{-20,40}}, color={0,0,255}));
  annotation (
    experiment(
      StopTime=0.1, 
      Tolerance=1e-06, 
      Interval=0.0002), 
    Documentation(info="<html>
<p>该示例展示了带有电阻负载的可控<code>2*m</code>脉冲中心点整流器，其中<code>m</code>是相数。</p>

<p>绘制电流<code>currentSensor.i</code>，平均电流<code>meanCurrent.y</code>，电压<code>voltageSensor.v</code>和平均电压<code>meanVoltage.v</code>。</p>
</html>"));
end ThyristorCenterTap2mPulse_R;