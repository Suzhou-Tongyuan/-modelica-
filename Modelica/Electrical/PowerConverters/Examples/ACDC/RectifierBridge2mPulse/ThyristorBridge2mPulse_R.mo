within Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2mPulse;
model ThyristorBridge2mPulse_R 
  "带电阻负载的2*m脉冲晶闸管整流桥"
  extends ExampleTemplates.ThyristorBridge2mPulse(pulse2m(
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
      points={{30,20},{30,-40},{10,-40}}, color={0,0,255}));
  connect(resistor.p, rectifier.dc_p) annotation (Line(
      points={{30,40},{-10,40},{-10,40},{-20,40}}, color={0,0,255}));
  annotation (
    experiment(
      StopTime=0.1, 
      Tolerance=1e-06, 
      Interval=0.0002), 
    Documentation(info="<html>
<p>此示例展示了带有电阻负载的全控制 <code>2*m</code> 脉冲整流桥，其中 <code>m</code> 是相数。在电阻负载的情况下，全控制桥显示与
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2mPulse.HalfControlledBridge2mPulse\">半控制桥</a>相同的输出电压。</p>

<p>绘制电流 <code>currentSensor.i</code>、平均电流 <code>meanCurrent.y</code>、电压 <code>voltageSensor.v</code> 和平均电压 <code>meanVoltage.v</code>。</p>
</html>"));
end ThyristorBridge2mPulse_R;