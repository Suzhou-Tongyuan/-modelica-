within Modelica.Clocked.IntegerSignals.Sampler;
block BackSample 
  "将整数输入信号的时钟向后偏移(并在此新的时钟上访问输入的最新值)"
  parameter Integer backCounter(min = 0) = 0 "移位公式的分子" 
    annotation(Evaluate = true, Dialog(group = "将第一次时钟激活向时间轴上移动，偏移量为 'shiftCounter/resolution*interval(u)' 秒"));
  parameter Integer resolution(min = 1) = 1 "移位公式的分母" 
    annotation(Evaluate = true, Dialog(group = "将第一次时钟激活向时间轴上移动，偏移量为 'shiftCounter/resolution*interval(u)' 秒"));
  parameter Integer y_start = 0 
    "输入 u 的第一个时钟周期之前的输出 y 值";
  Modelica.Blocks.Interfaces.IntegerInput u(start = y_start) 
    "时钟、整数输入信号连接器" 
    annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
  Modelica.Blocks.Interfaces.IntegerOutput y 
    "时钟、整数输出信号连接器（y 的时钟比 u 的时钟快）" 
    annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));
equation
  y = backSample(u, backCounter, resolution);

  annotation(
    defaultComponentName = "backSample1", 
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}, 
    initialScale = 0.06), 
    graphics = {Line(points = {{20, -50}, {60, -50}, {60, 50}}, 
    color = {255, 128, 0}, 
    pattern = LinePattern.Dot), 
    Text(
    extent = {{-150, 150}, {150, 110}}, 
    textString = "%name", 
    textColor = {0, 0, 255}), 
    Text(
    extent = {{-150, -150}, {150, -190}}, 
    textColor = {0, 0, 0}, 
    textString = "%backCounter/%resolution"), 
    Line(points = {{-80, -50}, {-40, -50}, {-40, 50}}, 
    color = {255, 128, 0}, 
    pattern = LinePattern.Dot), 
    Ellipse(
    extent = {{-90, -40}, {-70, -60}}, 
    lineColor = {255, 128, 0}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{-50, 60}, {-30, 40}}, 
    lineColor = {255, 128, 0}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), 
    Polygon(
    points = {{-16, 0}, {4, 20}, {4, 10}, {34, 10}, {34, -10}, {4, -10}, {4, -20}, {-16, 0}}, 
    fillColor = {95, 95, 95}, 
    fillPattern = FillPattern.Solid, 
    lineColor = {95, 95, 95}), 
    Ellipse(
    extent = {{10, -40}, {30, -60}}, 
    lineColor = {255, 128, 0}, 
    fillColor = {255, 128, 0}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{50, 60}, {70, 40}}, 
    lineColor = {255, 128, 0}, 
    fillColor = {255, 128, 0}, 
    fillPattern = FillPattern.Solid), 
    Text(
    extent = {{-150, -100}, {150, -140}}, 
    textColor = {0, 0, 0}, 
    textString = "y_start=%y_start")}), 
    Documentation(info = "<html>
<p>
该整数信号模块的工作原理与相应的实数信模号块类似（参见 <a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.BackSample\">RealSignals.Sampler.BackSample</a>）。
</p>
<p>
与相应的实数信号模块示例类似，该整数信号模块也有一个基本<a href=\"modelica://Modelica.Clocked.Examples.Elementary.IntegerSignals.BackSample\">example</a>。
</p>
</html>"));
end BackSample;