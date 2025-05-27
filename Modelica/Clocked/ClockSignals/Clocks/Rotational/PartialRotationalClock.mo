within Modelica.Clocked.ClockSignals.Clocks.Rotational;
partial block PartialRotationalClock 
  "用于生成时钟跳变的事件时钟基类，每次观察到的输入角度变化时生成一次时钟跳变"
  extends ClockSignals.Interfaces.PartialClock;

  Modelica.Blocks.Interfaces.RealInput angle(unit = "rad") 
    "用于生成时钟跳变的输入角度。" 
    annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
  Modelica.Blocks.Interfaces.IntegerOutput direction 
    "旋转方向(符号：+1或-1)。通过提供的时钟信号‘y’进行采样。" 
    annotation(Placement(transformation(extent = {{100, -50}, {120, -30}})));
  Modelica.Blocks.Interfaces.BooleanOutput direction_changed(start = false) 
    "如果自上次‘y’时钟跳变以来，观察到的角度的旋转方向发生了变化，则为真；否则为假。通过提供的时钟信号‘y’进行采样。" 
    annotation(Placement(transformation(extent = {{100, -90}, {120, -70}})));

  annotation(Icon(graphics = {
    Line(
    points = {{60, -80}, {100, -80}}, 
    color = {217, 67, 180}), 
    Line(
    points = {{92, -40}, {100, -40}}, 
    color = {244, 125, 35})}));
end PartialRotationalClock;