within Modelica.Electrical.PowerConverters.Examples.DCDC.ChopperStepDown;
model ChopperStepDown_RL "带电阻电感负载的降压斩波器"
  extends ExampleTemplates.ChopperStepDown(signalPWM(useConstantDutyCycle=false));
  extends Modelica.Icons.Example;
  parameter SI.Inductance LLoad=0.025 "负载电感";
  Modelica.Electrical.Analog.Basic.Resistor loadResistor(R=RLoad) 
    annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={40,40})));
  Modelica.Electrical.Analog.Basic.Inductor loadInductor(i(fixed=true, start=0), 
    L=LLoad) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={40,10})));
  PowerConverters.DCDC.Control.Voltage2DutyCycle adaptor(
    reciprocal=false, 
    useBipolarVoltage=false, 
    VLim=Vsource) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-70,-60})));
  Modelica.Blocks.Sources.Ramp vRef(
    height=V0, 
    duration=0.05, 
    offset=0, 
    startTime=0.025) 
    annotation (Placement(transformation(extent={{100,-90},{80,-70}})));
equation
  connect(loadResistor.p, capacitor.p) annotation (Line(points={{40,50},{40,60}, 
          {1.77636e-15,60},{1.77636e-15,10}}, color={0,0,255}));
  connect(loadInductor.n, currentSensor.p) 
    annotation (Line(points={{40,0},{40,-10},{30,-10}}, color={0,0,255}));
  connect(loadResistor.n, loadInductor.p) 
    annotation (Line(points={{40,30},{40,20}}, color={0,0,255}));
  connect(adaptor.dutyCycle, signalPWM.dutyCycle) 
    annotation (Line(points={{-70,-49},{-70,-40},{-42,-40}}, color={0,0,127}));
  connect(adaptor.v, vRef.y) 
    annotation (Line(points={{-70,-72},{-70,-80},{79,-80}}, color={0,0,127}));
  annotation (
    experiment(
      StopTime=0.1, 
      Interval=1e-05, 
      Tolerance=1e-06), 
    Documentation(info="<html>
<p>此示例演示了由降压斩波器操作的 R-L 负载的开关。
直流输出电压等于<code>dutyCycle</code>乘以输入电压。
绘制电流<code>currentSensor.i</code>、平均电流<code>meanCurrent.y</code>、总电压<code>voltageSensor.v</code>和电压<code>meanVoltage.v</code>。平均电流波形由负载的时间常数<code>L/R</code>确定。</p>
</html>"));
end ChopperStepDown_RL;