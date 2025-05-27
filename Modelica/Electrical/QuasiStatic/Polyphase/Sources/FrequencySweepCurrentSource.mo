within Modelica.Electrical.QuasiStatic.Polyphase.Sources;
model FrequencySweepCurrentSource "集成频率扫描的电流源"
  extends Interfaces.TwoPlug;
  import Modelica.Constants.eps;
  SI.Angle gamma(start=0) = plug_p.reference.gamma;
  parameter Integer m=3 "相数" annotation(Evaluate=true);
  parameter SI.Frequency fStart(final min=eps, start=1) "开始扫描频率";
  parameter SI.Frequency fStop(final min=eps, start=1) "停止扫描频率";
  parameter SI.Time startTime=0 "频率扫描开始时间";
  parameter SI.Time duration(start=1) "频率扫描持续时间";
  parameter SI.Current I[m](start=fill(1,m)) "电流源的有效值";
  parameter SI.Angle phi[m]=-Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m) "电流源的相位移";
  SI.Frequency f=currentSource.f   "实际频率";
  VariableCurrentSource currentSource(final m=m) annotation (Placement(transformation(extent={{-10,10},{10,-10}})));
  Modelica.Blocks.Sources.LogFrequencySweep logFrequencySweep(
    final wMin=fStart, 
    final wMax=fStop, 
    final startTime=startTime, 
    final duration=duration) annotation (Placement(transformation(extent={{40,-60},{20,-40}})));
  Modelica.ComplexBlocks.Sources.ComplexConstant const[m](final k= 
        Modelica.ComplexMath.fromPolar(len=I, phi=phi)) 
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
equation
  connect(logFrequencySweep.y,currentSource. f) annotation (Line(points={{19,-50},{6,-50},{6,-12}},   color={0,0,127}));
  connect(plug_p,currentSource. plug_p) annotation (Line(points={{-100,0},{-10,0}}, color={85,170,255}));
  connect(currentSource.plug_n, plug_n) annotation (Line(points={{10,0},{100,0}}, color={85,170,255}));
  connect(currentSource.I, const.y) annotation (Line(points={{-6.2,-12},{-6,-12},{-6,-50},{-39,-50}}, color={85,170,255}));
  annotation (defaultComponentName="currentSource",Icon(graphics={
        Ellipse(
          extent={{-50,50},{50,-50}}, 
          lineColor={85,170,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-90,0},{-50,0}}, color={85,170,255}), 
        Line(points={{50,0},{90,0}}, color={85,170,255}), 
        Line(points={{0,-50},{0,50}}, color={85,170,255}), 
        Text(
          extent={{150,60},{-150,100}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Line(
          points={{-44,0},{-32,14},{-20,32},{-12,42},{-6,30},{0,0},{4,-28},{8,-40},{12,-20},{14,2},{16,30},{18,42},{20,28},{24,-32},{26,-40},{28,0}}, 
          color={192,192,192}, 
          smooth=Smooth.Bezier), 
        Polygon(
          points={{90,0},{60,10},{60,-10},{90,0}}, 
          lineColor={85,170,255}, 
          fillColor={85,170,255}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{160,-100},{-160,-60}}, 
          textString="m=%m")}), 
    Documentation(info="<html>
<p>该源提供多相恒定有效值相电流 <code>I</code> 和相位角 <code>phi</code>，
频率从 <code>fStart</code> 到 <code>fStop</code> 进行扫描，持续时间为 <code>duration</code>。频率扫描使得在对数频率尺度上，频率曲线呈线性。</p>

<div><img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/SinglePhase/Sources/FrequencySweepSource.png\"
     alt=\"FrequencySweepSource.png\"></div>

</html>"));
end FrequencySweepCurrentSource;