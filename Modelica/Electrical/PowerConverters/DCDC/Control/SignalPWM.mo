within Modelica.Electrical.PowerConverters.DCDC.Control;
model SignalPWM 
  "生成布尔信号的脉宽调制(PWM)"
  extends Icons.Control;
  parameter Boolean useConstantDutyCycle=true 
    "启用恒定占空比";
  parameter Real constantDutyCycle=0 "恒定占空比" 
    annotation (Dialog(enable=useConstantDutyCycle));
  parameter SI.Frequency f=1000 "切换频率";
  parameter SI.Time startTime=0 "开始时间";
  Modelica.Blocks.Interfaces.RealInput dutyCycle if not 
    useConstantDutyCycle "占空比" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput fire "触发PWM信号" 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-60,110})));
  Modelica.Blocks.Interfaces.BooleanOutput notFire "触发PWM信号" 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={60,110})));
  Modelica.Blocks.Sources.Constant const(final k=constantDutyCycle) if 
    useConstantDutyCycle 
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=0) 
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Logical.Less greaterEqual annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}}, 
        origin={22,-8})));
  Modelica.Blocks.Discrete.ZeroOrderHold zeroOrderHold(final startTime= 
        startTime, final samplePeriod=1/f) 
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Blocks.Sources.SawTooth sawtooth(
    final period=1/f, 
    final amplitude=1, 
    final nperiod=-1, 
    final offset=0, 
    final startTime=startTime) annotation (Placement(transformation(
        origin={-50,-50}, 
        extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Logical.Not inverse annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=90, 
        origin={52,20})));
equation
  connect(const.y, limiter.u) annotation (Line(
      points={{-79,-50},{-70,-50},{-70,0},{-62,0}}, color={0,0,127}));
  connect(dutyCycle, limiter.u) annotation (Line(
      points={{-120,0},{-62,0}}, color={0,0,127}));
  connect(limiter.y, zeroOrderHold.u) annotation (Line(
      points={{-39,0},{-32,0}}, color={0,0,127}));
  connect(zeroOrderHold.y, greaterEqual.u2) annotation (Line(
      points={{-9,0},{10,0}}, color={0,0,127}));
  connect(sawtooth.y, greaterEqual.u1) annotation (Line(
      points={{-39,-50},{0,-50},{0,-8},{10,-8}}, color={0,0,127}));
  connect(greaterEqual.y, inverse.u) annotation (Line(
      points={{33,-8},{52,-8},{52,8}}, color={255,0,255}));
  connect(greaterEqual.y, fire) annotation (Line(
      points={{33,-8},{36,-8},{36,80},{-60,80},{-60,110}}, color={255,0,255}));
  connect(inverse.y, notFire) annotation (Line(
      points={{52,31},{52,80},{60,80},{60,110}}, color={255,0,255}));
  annotation (defaultComponentName="pwm", 
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100}, 
            {100,100}}),graphics={Line(
                points={{-100,0},{-98,0},{12,0}}, 
                color={0,0,255}),Line(
                points={{-60,-22},{-60,-64},{44,-64},{44,-36}}, 
                color={0,0,255}),Line(
                points={{-80,-16},{-80,-20},{-40,20},{-40,-20},{-36,-16}}, 
                color={0,0,255}),Line(
                points={{-62,0},{-76,4},{-76,-4},{-62,0}}, 
                color={0,0,255}),Line(
                points={{44,-36},{44,-36},{40,-50},{44,-50},{48,-50},{44, 
            -36}}, 
                color={0,0,255}),Line(
                points={{20,-20},{22,-20},{24,-20},{24,20},{44,20},{44,-20}, 
            {64,-20},{64,-16}}, 
                color={255,0,255}),Line(
                points={{-40,-16},{-40,-20},{0,20},{0,-20},{4,-16}}, 
                color={0,0,255}),Line(
                points={{60,-20},{62,-20},{64,-20},{64,20},{84,20},{84,-20}, 
            {84,-20},{88,-20}}, 
                color={255,0,255})}), 
    Documentation(info="<html>
<p>
此控制器既可用于DC/DC也可用于AC/DC转换器。
PWM控制器的信号输入是占空比；占空比是通断时间与开关周期的比值。输出触发信号严格由实际占空比确定，如图所示。
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>图. 1:</strong> PWM控制的触发（<code>fire</code>）和反触发（<code>notFire</code>）信号；<code>d</code> = 占空比；<code>f</code> = 切换频率 </caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/PowerConverters/dutyCycle.png\">
    </td>
  </tr>
</table>

<p>
触发信号是通过将采样的占空比输入与周期锯齿信号进行比较而生成的[<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.References\">Williams2006</a>]。
</p>
</html>"));
end SignalPWM;