within Modelica.Clocked.Examples.Elementary.BooleanSignals;
model TickBasedStep 
  "使用基于时钟模拟计时/采样的布尔阶跃源模块示例"
   extends Modelica.Icons.Example;

Modelica.Clocked.ClockSignals.Clocks.PeriodicRealClock 
  periodicClock1(period=0.1) 
  annotation (Placement(transformation(extent={{-60,-8},{-48,4}})));
  Modelica.Clocked.BooleanSignals.Sampler.AssignClock assignClock1 
    annotation (Placement(transformation(extent={{-22,24},{-10,36}})));
Modelica.Clocked.BooleanSignals.TickBasedSources.Step step(startTick= 
        3) 
  annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
equation
  connect(periodicClock1.y, assignClock1.clock) annotation (Line(
      points={{-47.4,-2},{-16,-2},{-16,22.8}}, 
      color={175,175,175}, 
      pattern=LinePattern.Dot, 
      thickness=0.5));
  connect(assignClock1.u, step.y) annotation (Line(
      points={{-23.2,30},{-39,30}}, 
      color={255,0,255}));
  annotation (experiment(StopTime=1.0), 
  Documentation(info="<html>
<p>
模块示例
<a href=\"modelica://Modelica.Clocked.BooleanSignals.TickBasedSources.Step\">Modelica.Clocked.BooleanSignals.TickBasedSources.Step</a>.
</p>
</html>"));
end TickBasedStep;