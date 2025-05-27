within Modelica.Electrical.QuasiStatic.SinglePhase.Examples;
model SeriesBode "具有伯德分析的串联电路"
  extends Modelica.Icons.Example;
  output Real abs_y = bode.abs_y "电压比的幅度";
  output SI.AmplitudeLevelDifference dB_y = bode.dB_y "以dB为单位的电压比幅度的对数";
  output SI.Angle arg_y = bode.arg_y "电压比的角度";
  Modelica.Blocks.Sources.LogFrequencySweep frequencySweep(
    duration=1, 
    wMin=0.01, 
    wMax=100) annotation (Placement(transformation(origin={-70,-40}, extent={{-10, 
            -10},{10,10}})));
  QuasiStatic.SinglePhase.Sources.VariableVoltageSource voltageSource(gamma(
        fixed=true, start=0)) annotation (Placement(transformation(
        origin={-30,-20}, 
        extent={{-10,10},{10,-10}}, 
        rotation=270)));
  QuasiStatic.SinglePhase.Basic.Ground ground 
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  QuasiStatic.SinglePhase.Basic.Resistor resistor(R_ref=1) 
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  QuasiStatic.SinglePhase.Basic.Inductor inductor(L=1/(2*Modelica.Constants.pi)) 
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  Modelica.ComplexBlocks.Sources.ComplexConstant complexConst(k=Complex(1, 0)) 
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Sensors.CurrentSensor currentSensor annotation (Placement(transformation(extent={{10,10},{-10,-10}}, 
        rotation=180, 
        origin={-10,0})));
  Sensors.VoltageSensor voltageSensor annotation (Placement(transformation(
        extent={{-10,10},{10,-10}}, 
        origin={30,20})));
  Modelica.ComplexBlocks.ComplexMath.Bode bode annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=180, 
        origin={-70,30})));
equation
  connect(frequencySweep.y, voltageSource.f) annotation (Line(points={{-59,-40},{-50,-40},{-50,-26},{-42,-26}}, color={0,0,127}));
  connect(ground.pin, voltageSource.pin_n) annotation (Line(points={{-30,-40}, 
          {-30,-35},{-30,-30}}, color={85,170,255}));
  connect(resistor.pin_n, inductor.pin_p) annotation (Line(points={{40,0},{50,0}}, 
                                  color={85,170,255}));
  connect(complexConst.y, voltageSource.V) annotation (Line(points={{-59,0},{-50,0},{-50,-14},{-42,-14}}, color={85,170,255}));
  connect(voltageSensor.pin_p, resistor.pin_p) annotation (Line(points={{20,20},{10,20},{10,0},{20,0}}, 
                                                                                               color={85,170,255}));
  connect(voltageSensor.pin_n, inductor.pin_p) annotation (Line(points={{40,20},{50,20},{50,0}}, color={85,170,255}));
  connect(ground.pin, inductor.pin_n) annotation (Line(points={{-30,-40},{80,-40},{80,0},{70,0}}, color={85,170,255}));
  connect(bode.divisor, complexConst.y) annotation (Line(points={{-58,24},{-50,24},{-50,0},{-59,0}}, color={85,170,255}));
  connect(bode.u,voltageSensor.v)  annotation (Line(points={{-58,36},{30,36},{30,31}}, color={85,170,255}));
  connect(currentSensor.pin_p, voltageSource.pin_p) annotation (Line(points={{-20,0},{-30,0},{-30,-10}}, color={85,170,255}));
  connect(currentSensor.pin_n, resistor.pin_p) annotation (Line(points={{0,0},{20,0}}, color={85,170,255}));
  annotation (Documentation(info="<html>
<p>
通过对数斜坡调节电压源的频率，供电电压幅度保持不变。</p>
<p>绘制对数尺度上的 <code>voltageSource.f</code> 对电阻的电压与供电电压的比值的波德图：</p>
<ul>
<li>增益响应： <code>dB_y</code></li>
<li>相位响应： <code>arg_y</code></li>
</ul>
</html>"), 
       experiment(StopTime=1.0, Interval=0.001));
end SeriesBode;