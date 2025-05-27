within Modelica.Electrical.QuasiStatic.Polyphase.Sources;
model FrequencySweepVoltageSource "具有集成频率扫描的电压源"
  extends Interfaces.TwoPlug;
  import Modelica.Constants.eps;
  SI.Angle gamma(start=0) = plug_p.reference.gamma;
  parameter Integer m=3 "相位数" annotation(Evaluate=true);
  parameter SI.Frequency fStart(final min=eps, start=1) "开始扫描频率";
  parameter SI.Frequency fStop(final min=eps, start=1) "停止扫描频率";
  parameter SI.Time startTime=0 "开始频率扫描时间";
  parameter SI.Time duration(start=1) "频率扫描持续时间";
  parameter SI.Voltage V[m](start=fill(1,m)) "源的有效值电压";
  parameter SI.Angle phi[m]=-Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m) "源的相位移";
  SI.Frequency f = voltageSource.f "实际频率";
  VariableVoltageSource voltageSource(final m=m) annotation (Placement(transformation(extent={{-10,10},{10,-10}})));
  Modelica.Blocks.Sources.LogFrequencySweep logFrequencySweep(
    final wMin=fStart, 
    final wMax=fStop, 
    final startTime=startTime, 
    final duration=duration) annotation (Placement(transformation(extent={{40,-60},{20,-40}})));
  Modelica.ComplexBlocks.Sources.ComplexConstant const[m](final k= 
        Modelica.ComplexMath.fromPolar(len=V, phi=phi)) 
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
equation
  connect(logFrequencySweep.y, voltageSource.f) annotation (Line(points={{19,-50},{6,-50},{6,-12}}, color={0,0,127}));
  connect(plug_p, voltageSource.plug_p) annotation (Line(points={{-100,0},{-10,0}}, color={85,170,255}));
  connect(voltageSource.plug_n, plug_n) annotation (Line(points={{10,0},{100,0}}, color={85,170,255}));
  connect(const.y, voltageSource.V) annotation (Line(points={{-39,-50},{-6,-50},{-6,-12}}, color={85,170,255}));
  annotation (defaultComponentName="voltageSource",Icon(graphics={
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
          smooth=Smooth.Bezier), 
        Text(
          extent={{160,-100},{-160,-60}}, 
          textString="m=%m")}), 
    Documentation(info="<html>
<p>此源提供了多相恒定有效值相位电压 <code>V</code> 和相位角 <code>phi</code>，而频率从
<code>fStart</code> 扫描到 <code>fStop</code>，扫描持续时间为 <code>duration</code>。
在对数频率尺度上，频率曲线呈线性。</p>

<div><img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/SinglePhase/Sources/FrequencySweepSource.png\"
     alt=\"FrequencySweepSource.png\"></div>

</html>"));
end FrequencySweepVoltageSource;