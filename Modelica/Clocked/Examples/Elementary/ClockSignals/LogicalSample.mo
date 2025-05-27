within Modelica.Clocked.Examples.Elementary.ClockSignals;
model LogicalSample 
  "结合逻辑时钟和析取逻辑时钟的简单示例，通过合并时钟信号来推导新的事件驱动时钟"
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Sine sine_angle_input(
    amplitude = 10, 
    f = 1) 
    annotation(Placement(transformation(extent = {{-80, 30}, {-60, 50}})));
  Modelica.Blocks.Sources.Cosine cosine_angle_input(
    amplitude = 10, 
    f = 1) 
    annotation(Placement(transformation(extent = {{-80, -50}, {-60, -30}})));
  Modelica.Blocks.Sources.Pulse trigger_interval_input(
    amplitude = 2, 
    period = 1, 
    offset = 1) 
    annotation(Placement(transformation(extent = {{-80, -10}, {-60, 10}})));

  Clocked.ClockSignals.Clocks.Rotational.RotationalClock rotational_clock_1 
    annotation(Placement(transformation(extent = {{-20, 30}, {0, 50}})));
  Clocked.ClockSignals.Clocks.Rotational.RotationalClock rotational_clock_2 
    annotation(Placement(transformation(extent = {{-20, -50}, {0, -30}})));

  Clocked.ClockSignals.Clocks.Logical.ConjunctiveClock conjunctiveClock 
    annotation(Placement(transformation(extent = {{40, 20}, {60, 40}})));
  Clocked.ClockSignals.Clocks.Logical.DisjunctiveClock disjunctiveClock 
    annotation(Placement(transformation(extent = {{40, -40}, {60, -20}})));

  Clocked.RealSignals.Sampler.SampleClocked sample_conjunctive 
    annotation(Placement(transformation(extent = {{74, 54}, {86, 66}})));
  Clocked.RealSignals.Sampler.SampleClocked sample_disjunctive 
    annotation(Placement(transformation(extent = {{74, -54}, {86, -66}})));
equation
  connect(sine_angle_input.y, rotational_clock_1.angle) 
    annotation(Line(
    points = {{-59, 40}, {-22, 40}}, 
    color = {0, 0, 127}));
  connect(trigger_interval_input.y, rotational_clock_1.trigger_interval) 
    annotation(Line(
    points = {{-59, 0}, {-40, 0}, {-40, 46}, {-22, 46}}, 
    color = {0, 0, 127}));
  connect(trigger_interval_input.y, rotational_clock_2.trigger_interval) 
    annotation(Line(
    points = {{-59, 0}, {-40, 0}, {-40, -34}, {-22, -34}}, 
    color = {0, 0, 127}));
  connect(cosine_angle_input.y, rotational_clock_2.angle) 
    annotation(Line(
    points = {{-59, -40}, {-22, -40}}, 
    color = {0, 0, 127}));
  connect(rotational_clock_1.y, conjunctiveClock.u[1]) 
    annotation(Line(
    points = {{1, 40}, {20, 40}, {20, 34}, {40, 34}, {40, 30}}, 
    color = {175, 175, 175}, 
    pattern = LinePattern.Dot, 
    thickness = 0.5));
  connect(rotational_clock_2.y, conjunctiveClock.u[2]) 
    annotation(Line(
    points = {{1, -40}, {20, -40}, {20, 30}, {40, 30}}, 
    color = {175, 175, 175}, 
    pattern = LinePattern.Dot, 
    thickness = 0.5));
  connect(rotational_clock_1.y, disjunctiveClock.u[1]) 
    annotation(Line(
    points = {{1, 40}, {20, 40}, {20, -28}, {40, -28}, {40, -30}}, 
    color = {175, 175, 175}, 
    pattern = LinePattern.Dot, 
    thickness = 0.5));
  connect(rotational_clock_2.y, disjunctiveClock.u[2]) 
    annotation(Line(
    points = {{1, -40}, {20, -40}, {20, -30}, {40, -30}}, 
    color = {175, 175, 175}, 
    pattern = LinePattern.Dot, 
    thickness = 0.5));

  connect(disjunctiveClock.y, sample_disjunctive.clock) annotation(Line(
    points = {{61, -30}, {80, -30}, {80, -52.8}}, 
    color = {175, 175, 175}, 
    pattern = LinePattern.Dot, 
    thickness = 0.5));
  connect(conjunctiveClock.y, sample_conjunctive.clock) annotation(Line(
    points = {{61, 30}, {80, 30}, {80, 52.8}}, 
    color = {175, 175, 175}, 
    pattern = LinePattern.Dot, 
    thickness = 0.5));
  connect(sample_conjunctive.u, sine_angle_input.y) annotation(Line(
    points = {{72.8, 60}, {-50, 60}, {-50, 40}, {-59, 40}}, color = {0, 0, 127}));
  connect(sample_disjunctive.u, sine_angle_input.y) annotation(Line(
    points = {{72.8, -60}, {-50, -60}, {-50, 40}, {-59, 40}}, color = {0, 0, 127}));
  annotation(
    preferredView = "info", 
    experiment(StopTime = 2), 
    Documentation(info="<html><p>
<span style=\"color: rgb(51, 51, 51);\">两个逻辑时钟的简单示例，一个是结合逻辑时钟，一个是析取逻辑时钟。它们都接收相同的时钟输入，这些输入由两个旋转时钟产生，旋转时钟的输入角度波形略有偏移（分别是正弦和余弦波）。旋转时钟的配置和结果在</span><a href=\"modelica://Modelica.Clocked.Examples.Elementary.ClockSignals.RotationalSample\" target=\"\">rotational clocks example</a>&nbsp;<span style=\"color: rgb(51, 51, 51);\">中有解释。因此，析取逻辑时钟和结合逻辑时钟生成的时钟信号为：</span>
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Clocked/Examples/LogicalSample_Result.png\" alt=\"LogicalSample_Result.png\" data-href=\"\" style=\"\"/>.<br> &nbsp; &nbsp;
</p>
</html>"));
end LogicalSample;