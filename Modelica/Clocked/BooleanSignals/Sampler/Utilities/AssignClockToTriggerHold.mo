within Modelica.Clocked.BooleanSignals.Sampler.Utilities;
block AssignClockToTriggerHold 
  "从一个时钟布尔输入生成布尔的连续时间触发信号"
  extends Clocked.ClockSignals.Interfaces.ClockedBlockIcon;
  parameter Boolean y_start = false "输出信号的初始值";
  Modelica.Blocks.Interfaces.BooleanInput 
    u 
    annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
  Modelica.Blocks.Interfaces.BooleanOutput y 
    "布尔输出信号的连接器" annotation(Placement(
    transformation(extent = {{100, -10}, {120, 10}}), 
    iconTransformation(extent = {{100, -10}, {120, 10}})));
protected
  Boolean y2(start = y_start);
  Boolean y3(start = y_start, fixed = true);
  Boolean uu annotation(HideResult = true);
equation
  when Clock() then
    uu = u "虚拟赋值以将输入u的时钟与y2关联";
    y2 = not previous(y2);
  end when;
  y3 = hold(y2);
  y = change(y3);
  annotation(
    defaultComponentName = "clockToTrigger", 
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), 
    graphics = {
    Polygon(
    points = {{-80, 88}, {-88, 66}, {-72, 66}, {-80, 88}}, 
    lineColor = {255, 0, 255}, 
    fillColor = {255, 0, 255}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{-80, 66}, {-80, -82}}, color = {255, 0, 255}), 
    Line(points = {{-90, -70}, {72, -70}}, color = {255, 0, 255}), 
    Polygon(
    points = {{90, -70}, {68, -62}, {68, -78}, {90, -70}}, 
    lineColor = {255, 0, 255}, 
    fillColor = {255, 0, 255}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{71, 7}, {85, -7}}, 
    lineColor = DynamicSelect({235, 235, 235}, if y then {0, 255, 0} else {235, 235, 235}), 
    fillColor = DynamicSelect({235, 235, 235}, if y then {0, 255, 0} else {235, 235, 235}), 
    fillPattern = FillPattern.Solid), 
    Line(points = {{-60, -70}, {-60, 70}}), 
    Line(points = {{-20, -70}, {-20, 70}}), 
    Line(points = {{20, -70}, {20, 70}}), 
    Line(points = {{60, -70}, {60, 70}})}), 
    Documentation(info = "<html>
<p>
该块用于布尔信号的处理，类似于对应的实数信号块(参见
<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Utilities.AssignClockToTriggerHold\">RealSignals.Sampler.Utilities.AssignClockToTriggerHold</a>)。
</p>
</html>"));
end AssignClockToTriggerHold;