within Modelica.Clocked.RealSignals.Sampler.Utilities;
block AssignClockToSquareWaveHold 
  "从一个时钟驱动的实数输入生成一个布尔型连续时间方波输出"
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
  Real uu;
equation
  when Clock() then
    uu = u "虚拟赋值，用于关联输入信号u的时钟与y2";
    y2 = not previous(y2);
  end when;
  y = hold(y2);
  annotation(
    defaultComponentName = "clockToSquareWave", 
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
    Line(points = {{-80, -70}, {-40, -70}, {-40, 44}, 
    {0, 44}, {0, -70}, {40, -70}, {40, 44}, {79, 44}})}), 
    Documentation(info = "<html>
<p>
该模块创建一个布尔型的连续时间方波输出。每当输入信号的时钟激活时，布尔输出值发生变化。
</p>

<h4>示例</h4>

<p>
以下
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.AssignClockToSquareWaveHold\">示例</a>
使用周期为20毫秒的时钟对正弦信号进行采样。之后生成一个布尔型的连续时间方波信号，在每次时钟周期触发时切换其值：<br>
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/AssignClockToSquareWaveHold_Model.png\" alt=\"AssignClockToSquareWaveHold_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/AssignClockToSquareWaveHold_Result.png\" alt=\"AssignClockToSquareWaveHold_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">模型</td>
    <td align=\"center\">仿真结果</td>
   </tr>
</table>
</html>"));
end AssignClockToSquareWaveHold;