within Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTap2Pulse;
model ThyristorCenterTap2Pulse_RLV_Characteristic 
  "带有电阻电感负载和电压的双脉冲可控中心点晶闸管整流器特性"
  extends ExampleTemplates.ThyristorCenterTap2Pulse(pulse2(
        useConstantFiringAngle=false));
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter SI.Resistance R=20 "负载电阻";
  parameter SI.Inductance L=1 "负载电阻" 
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
        origin={-30,-60})));
equation
  connect(resistor.n, inductor.p) annotation (Line(
      points={{30,20},{30,10}}, color={0,0,255}));
  connect(inductor.n, constantVoltage.p) annotation (Line(
      points={{30,-10},{30,-20}}, color={0,0,255}));
  connect(constantVoltage.n, currentSensor.p) annotation (Line(
      points={{30,-40},{10,-40}}, color={0,0,255}));
  connect(ramp.y, pulse2.firingAngle) annotation (Line(
      points={{-30,-49},{-30,-12}}, color={0,0,127}));
  connect(resistor.p, rectifier.dc_p) annotation (Line(
      points={{30,40},{-10,40},{-10,40},{-20,40}}, color={0,0,255}));
  annotation (
    experiment(
      StopTime=10, 
      Tolerance=1e-06, 
      Interval=0.0002), 
    Documentation(info="<html>
<p>这个例子展示了一个带有R-L负载的控制中心点两脉冲整流器，包括DC电压源。此示例中的额外DC电压源使得负载的平均电压可以为负值。</p>

<p>绘制了平均电压 <code>meanVoltage.v</code> 与触发角 <code>pulse2.firingAngle</code> 的曲线，以查看包含有源电压的R-L负载整流器的控制特性。</p>
</html>"));
end ThyristorCenterTap2Pulse_RLV_Characteristic;