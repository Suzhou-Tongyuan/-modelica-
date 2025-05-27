within Modelica.Clocked.Examples.Elementary.ClockSignals;
model RotationalSample 
  "具有可变触发间隔和旋转方向切换功能的旋转时钟的简单示例。"
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Sine angle_input(
    amplitude = 10, 
    f = 1) 
    annotation (Placement(transformation(extent = {{-70,-10},{-50,10}})));
  Modelica.Blocks.Sources.Pulse trigger_interval_input(
    amplitude = 2, 
    period = 1, 
    offset = 1) 
    annotation (Placement(transformation(extent = {{-70,30},{-50,50}})));
  Clocked.ClockSignals.Clocks.Rotational.RotationalClock rotationalClock 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Clocked.RealSignals.Sampler.SampleClocked sample_angle 
    annotation (Placement(transformation(extent={{34,-14},{46,-26}})));

equation
  connect(angle_input.y, rotationalClock.angle) 
    annotation (Line(
      points = {{-49,0},{-12,0}}, 
      color = {0,0,127}));
  connect(rotationalClock.y, sample_angle.clock) 
    annotation (Line(
      points = {{11,0},{40,0},{40,-12.8}}, 
      color = {175,175,175}, 
      pattern = LinePattern.Dot, 
      thickness = 0.5));
  connect(angle_input.y, sample_angle.u) 
    annotation (Line(
      points = {{-49,0},{-30,0},{-30,-20},{32.8,-20}}, 
      color = {0,0,127}));
  connect(trigger_interval_input.y, rotationalClock.trigger_interval) 
    annotation (Line(
      points = {{-49,40},{-40,40},{-40,6},{-12,6}}, 
      color = {0,0,127}));

  annotation (
    preferredView = "info", 
    experiment(StopTime = 2), 
    Documentation(info="<html><p>
    一个简单的旋转时钟示例，带有可变触发间隔和旋转方向切换。
    输入旋转仅为正弦波，每半秒切换一次方向。
    触发间隔以相同的速度改变；每半秒分别加倍或减半。
    因此生成的时钟信号如下：
    </p>
    <div><img src=\"modelica://Modelica/Resources/Images/Clocked/Examples/RotationalSample_Result.png\" alt=\"RotationalSample_Result.png\"></div>.
    </html>"));
end RotationalSample;