within Modelica.Electrical.Analog.Ideal;
model ControlledIdealIntermediateSwitch 
  "受控理想中间开关"
  parameter SI.Voltage level = 0.5 "开关级别";
  parameter SI.Resistance Ron(final min = 0) = 1e-5 "关闭开关电阻";
  parameter SI.Conductance Goff(final min = 0) = 1e-5 
    "打开开关电阻";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T = 
    293.15);
  Interfaces.PositivePin p1 annotation(Placement(transformation(extent = {{-110, 30}, {-90, 50}}), iconTransformation(extent = {{-110, 30}, {-90, 50}})));
  Interfaces.PositivePin p2 annotation(Placement(transformation(extent = {{-110, 
    -10}, {-90, 10}})));
  Interfaces.NegativePin n1 annotation(Placement(transformation(extent = {{90, 30}, {110, 50}}), iconTransformation(extent = {{90, 30}, {110, 50}})));
  Interfaces.NegativePin n2 annotation(Placement(transformation(extent = {{90, 
    -10}, {110, 10}})));
  Interfaces.Pin control "控制端口:如果control.v>level，p1--n2,p2--n1连接,否则p1--n1,p2--n2连接" 
    annotation(Placement(
    transformation(
    origin = {0, 100}, 
    extent = {{-10, -10}, {10, 10}}, 
    rotation = 90)));
protected
  Real s1(final unit = "1");
  Real s2(final unit = "1");
  Real s3(final unit = "1");
  Real s4(final unit = "1") "辅助变量";
  constant SI.Voltage unitVoltage = 1 annotation(HideResult = true);
  constant SI.Current unitCurrent = 1 annotation(HideResult = true);
equation
  control.i = 0;

  p1.v - n1.v = (s1 * unitCurrent) * (if (control.v > level) then 1 else Ron);
  p2.v - n2.v = (s2 * unitCurrent) * (if (control.v > level) then 1 else Ron);
  p1.v - n2.v = (s3 * unitCurrent) * (if (control.v > level) then Ron else 1);
  p2.v - n1.v = (s4 * unitCurrent) * (if (control.v > level) then Ron else 1);

  p1.i = if control.v > level then s1 * unitVoltage * Goff + s3 * unitCurrent else 
    s1 * unitCurrent + s3 * unitVoltage * Goff;
  p2.i = if control.v > level then s2 * unitVoltage * Goff + s4 * unitCurrent else 
    s2 * unitCurrent + s4 * unitVoltage * Goff;
  n1.i = if control.v > level then -s1 * unitVoltage * Goff - s4 * unitCurrent 
    else -s1 * unitCurrent - s4 * unitVoltage * Goff;
  n2.i = if control.v > level then -s2 * unitVoltage * Goff - s3 * unitCurrent 
    else -s2 * unitCurrent - s3 * unitVoltage * Goff;

  LossPower = p1.i * p1.v + p2.i * p2.v + n1.i * n1.v + n2.i * n2.v;
  annotation(defaultComponentName = "switch", 
    Documentation(info = "<html>
<p>中继开关有四个切换接触管脚p1、p2、n1和n2。 切换行为由控制引脚控制。 如果控制引脚的电压超过参数级别的值，则管脚p1将连接到管脚n2，管脚p2将连接到管脚n1。 否则，管脚p1将连接到管脚n1，管脚p2将连接到管脚n2。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/ControlledIdealIntermediateSwitch1.png\"
     alt=\"ControlledIdealIntermediateSwitch1.png\">
</div>

<p>为了防止切换时出现奇异点，已打开的开关具有(非常低)的导纳Goff，而已关闭的开关具有(非常低)的电阻Ron。

</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/ControlledIdealIntermediateSwitch2.png\"
     alt=\"ControlledIdealIntermediateSwitch2.png\">
</div>

<p>
允许极限情况，即已关闭的开关的电阻Ron可以准确地为零，而已打开的开关的导纳Goff可以也准确地为零。请注意，有某些电路，其中描述Ron为零或Goff为零是不可能的。
</p>
<p><br><strong>请注意:</strong>在使用useHeatPort=true的情况下，电行为的温度依赖性并未被建模。参数<strong>不</strong>随温度变化。
</p>
</html>", 
    revisions = "<html>
<ul>
<li><em>2009年3月11日</em>
       Christoph Clauss<br>添加了条件热口<br>
       </li>
<li><em>1998年</em>
       Christoph Clauss<br>最初实现<br>
       </li>
</ul>

</html>"), 
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
    100}}), graphics = {
    Ellipse(extent = {{-4, 24}, {4, 16}}, lineColor = {0, 0, 255}), 
    Line(points = {{-90, 0}, {-40, 0}}, color = {0, 0, 255}), 
    Line(points = {{-90, 40}, {-40, 40}}, color = {0, 0, 255}), 
    Line(points = {{-40, 0}, {40, 40}}, color = {0, 0, 255}), 
    Line(points = {{-40, 40}, {40, 0}}, color = {0, 0, 255}), 
    Line(points = {{40, 40}, {90, 40}}, color = {0, 0, 255}), 
    Line(points = {{40, 0}, {90, 0}}, color = {0, 0, 255}), 
    Line(
    visible = useHeatPort, 
    points = {{0, -100}, {0, 22}}, 
    color = {127, 0, 0}, 
    pattern = LinePattern.Dot), 
    Text(
    extent = {{-150, 90}, {150, 50}}, 
    textString = "%name", 
    textColor = {0, 0, 255})}));
end ControlledIdealIntermediateSwitch;