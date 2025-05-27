within Modelica.Electrical.QuasiStatic.SinglePhase.Sources;
model FrequencySweepVoltageSource "集成频率扫描的电压源"
  extends Interfaces.TwoPin;
  import Modelica.Constants.eps;
  SI.Angle gamma(start=0) = pin_p.reference.gamma;
  parameter SI.Frequency fStart(final min=eps, start=1) "开始扫描频率";
  parameter SI.Frequency fStop(final min=eps, start=1) "结束扫描频率";
  parameter SI.Time startTime=0 "频率扫描开始时间";
  parameter SI.Time duration(start=1) "频率扫描持续时间";
  parameter SI.Voltage V(start=1) "电压源的有效值电压";
  parameter SI.Angle phi=0 "电压源的相位移";
  SI.Frequency f = voltageSource.f "实际频率";
  Modelica.Blocks.Sources.LogFrequencySweep logFrequencySweep(
    final wMin=fStart, 
    final wMax=fStop, 
    final startTime=startTime, 
    final duration=duration) 
    annotation (Placement(transformation(extent={{40,-60},{20,-40}})));
  VariableVoltageSource voltageSource annotation (Placement(transformation(extent={{-20,10},{0,-10}})));
  Modelica.ComplexBlocks.Sources.ComplexConstant const(final k= 
        Modelica.ComplexMath.fromPolar(len=V, phi=phi)) 
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
equation
  connect(logFrequencySweep.y, voltageSource.f) annotation (Line(points={{19,-50},{-4,-50},{-4,-12}}, color={0,0,127}));
  connect(const.y, voltageSource.V) annotation (Line(points={{-39,-50},{-16,-50},{-16,-12}}, color={85,170,255}));
  connect(pin_p, voltageSource.pin_p) annotation (Line(points={{-100,0},{-20,0}}, color={85,170,255}));
  connect(voltageSource.pin_n, pin_n) annotation (Line(points={{0,0},{100,0}}, color={85,170,255}));
  annotation (defaultComponentName="voltageSource",Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-50,50},{50,-50}}, 
          lineColor={85,170,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-90,0},{-50,0}}, color={85,170,255}), 
        Line(points={{50,0},{90,0}}, color={85,170,255}), 
        Line(points={{-50,0},{50,0}}, color={85,170,255}), 
        Line(points={{-70,30},{-70,10}}, color={85,170,255}), 
        Line(points={{-80,20},{-60,20}}, color={85,170,255}), 
        Line(points={{60,20},{80,20}}, color={85,170,255}), 
        Text(
          extent={{150,60},{-150,100}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Line(
          points={{-44,0},{-32,14},{-20,32},{-12,42},{-6,30},{0,0},{4,-28},{8,-40},{12,-20},{14,2},{16,30},{18,42},{20,28},{24,-32},{26,-40},{28,0}}, 
          color={192,192,192}, 
          smooth=Smooth.Bezier)}),    Documentation(info="<html>
<p>该源提供恒定有效值相位电压<code>V</code>和相位角<code>phi</code>，
而频率从<code>fStart</code>到<code>fStop</code>在<code>duration</code>时间内扫描。
在对数频率尺度上，频率以线性方式扫描。</p>

<div><img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/SinglePhase/Sources/FrequencySweepSource.png\"
     alt=\"FrequencySweepSource.png\"></div>

</html>"));
end FrequencySweepVoltageSource;