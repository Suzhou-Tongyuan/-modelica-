within Modelica.Clocked.Examples.Elementary.RealSignals;
model ShiftSample "实数信号的 ShiftSample 模块示例"
   extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Sine sine(f=2, 
    offset=0.1, 
    startTime=0) 
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Clocked.RealSignals.Sampler.SampleClocked sample1 
    annotation (Placement(transformation(extent={{-46,24},{-34,36}})));
  Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
      factor=20, resolution=Modelica.Clocked.Types.Resolution.ms) 
    annotation (Placement(transformation(extent={{-62,-6},{-50,6}})));
  Modelica.Clocked.RealSignals.Sampler.ShiftSample shiftSample1(
      shiftCounter=4, resolution=3) 
    annotation (Placement(transformation(extent={{-22,24},{-10,36}})));
equation
  connect(sine.y, sample1.u) 
    annotation (Line(points={{-59,30},{-47.2,30}}, color={0,0,127}));
  connect(periodicClock.y, sample1.clock) annotation (Line(
      points={{-49.4,0},{-40,0},{-40,22.8}}, 
      color={175,175,175}, 
      pattern=LinePattern.Dot, 
      thickness=0.5));
  connect(sample1.y, shiftSample1.u) 
    annotation (Line(points={{-33.4,30},{-23.2,30}}, color={0,0,127}));
  annotation (experiment(StopTime=0.09), 
  Documentation(info="<html>
<p>
生成一个用于区模块文档的示例图
<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.ShiftSample\">Modelica.Clocked.RealSignals.Sampler.ShiftSample</a>.
</p>
</html>"));
end ShiftSample;