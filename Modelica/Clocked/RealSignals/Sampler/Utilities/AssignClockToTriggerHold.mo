within Modelica.Clocked.RealSignals.Sampler.Utilities;
block AssignClockToTriggerHold 
  "从时钟驱动的实数输入生成一个布尔型的连续时间触发信号"
  extends Clocked.ClockSignals.Interfaces.ClockedBlockIcon;
  parameter Boolean y_start = false "输出信号的初始值";
  Modelica.Blocks.Interfaces.RealInput u 
    annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
  Modelica.Blocks.Interfaces.BooleanOutput y 
    "布尔输出信号的连接器" annotation(Placement(
    transformation(extent = {{100, -10}, {120, 10}}), 
    iconTransformation(extent = {{100, -10}, {120, 10}})));
protected
  Boolean y2(start = y_start);
  Boolean y3(start = y_start, fixed = true);
  Real uu annotation(HideResult = true);
equation
  when Clock() then
    uu = u "虚拟赋值，用于将u的时钟与y2关联";
    y2 = not previous(y2);
  end when;
  y3 = hold(y2);
  y = change(y3);
  annotation(
    defaultComponentName = "clockToTrigger", 
    Icon(graphics = {
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
该模块在输入信号的时钟激活时，生成一个布尔型的连续时间触发信号。
</p>

<p>
这个模块的一个特定应用场景是将“老式”采样块（即使用“when trigger then”语句实现的“无时钟”离散控制函数）与有时钟驱动的模块结合使用。
</p>

<h4>示例</h4>

<p>
下面的
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.AssignClockToTriggerHold\">示例</a>
通过周期为20毫秒的时钟采样一个正弦信号。之后，在每次时钟信号的脉冲时，生成一个连续时间的布尔触发信号。该生成的信号被用作“老式”<a href=\"modelica://Modelica.Blocks.Discrete.TriggeredSampler\">TriggeredSampler</a>块的触发信号，该块来自Modelica.Blocks.Discrete包：<br>
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/AssignClockToTriggerHold_Model.png\" alt=\"AssignClockToTriggerHold_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/AssignClockToTriggerHold_Result.png\" alt=\"AssignClockToTriggerHold_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">模型</td>
    <td align=\"center\">仿真结果</td>
   </tr>
</table>
<p>
请注意，在图中清楚可见，“老式”离散变量具有隐式的零阶保持语义，而新的时钟驱动变量仅在其关联的时钟脉冲时激活。通过比较变量sample.y（时钟驱动）与triggeredSampler.y（无时钟驱动）可以观察到两者的差异。
</p>
</html>"));
end AssignClockToTriggerHold;