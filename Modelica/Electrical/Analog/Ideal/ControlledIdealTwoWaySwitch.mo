within Modelica.Electrical.Analog.Ideal;
model ControlledIdealTwoWaySwitch "可控理想双向开关"
  parameter SI.Voltage level = 0.5 "Switch level";
  parameter SI.Resistance Ron(final min = 0) = 1e-5 "关闭开关电阻";
  parameter SI.Conductance Goff(final min = 0) = 1e-5 
    "打开开关导通";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T = 
    293.15);
  Interfaces.PositivePin p annotation(Placement(transformation(extent = {{-110, 
    -10}, {-90, 10}})));
  Interfaces.NegativePin n2 annotation(Placement(transformation(extent = {{90, 
    -10}, {110, 10}})));
  Interfaces.NegativePin n1 annotation(Placement(transformation(extent = {{90, 30}, {110, 50}}), iconTransformation(extent = {{90, 30}, {110, 50}})));
  Interfaces.Pin control 
    "控制端口:如果control.v>level，p--n2,p2--n1连接,否则p--n1连接" 
    annotation(Placement(transformation(
    origin = {0, 100}, 
    extent = {{-10, -10}, {10, 10}}, 
    rotation = 90)));
protected
  Real s1(final unit = "1");
  Real s2(final unit = "1") "辅助变量";
  constant SI.Voltage unitVoltage = 1 annotation(HideResult = true);
  constant SI.Current unitCurrent = 1 annotation(HideResult = true);
equation
  control.i = 0;
  0 = p.i + n2.i + n1.i;

  p.v - n1.v = (s1 * unitCurrent) * (if (control.v > level) then 1 else Ron);
  n1.i = -(s1 * unitVoltage) * (if (control.v > level) then Goff else 1);
  p.v - n2.v = (s2 * unitCurrent) * (if (control.v > level) then Ron else 1);
  n2.i = -(s2 * unitVoltage) * (if (control.v > level) then 1 else Goff);
  LossPower = p.i * p.v + n1.i * n1.v + n2.i * n2.v;
  annotation(defaultComponentName = "switch", 
    Documentation(info = "<html>
<p>双向开关具有一个正极引脚p和两个负极引脚n1和n2。开关行为由控制引脚控制。如果其电压超过参数level的值，则引脚p与负极引脚n2连接。否则，引脚p与负极引脚n1连接。
</p>
<p>
为了防止在开关过程中出现奇点，打开的开关具有(非常低的)导纳Goff，而闭合的开关具有(非常低的)电阻Ron。极限情况也是允许的，即闭合开关的电阻Ron可以完全为零，而打开开关的导纳Goff也可以完全为零。请注意，有些电路无法用零Ron或零Goff来描述。
<br><br>
<strong>请注意:</strong>
如果在使用热端口(useHeatPort=true)的情况下，电行为的温度依赖性并未被建模。参数并不随温度变化而变化。
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
    Ellipse(extent = {{-44, 4}, {-36, -4}}, lineColor = {0, 0, 255}), 
    Line(points = {{-90, 0}, {-44, 0}}, color = {0, 0, 255}), 
    Line(points = {{-37, 2}, {40, 40}}, color = {0, 0, 255}), 
    Line(points = {{40, 40}, {90, 40}}, color = {0, 0, 255}), 
    Line(points = {{40, 0}, {90, 0}}, color = {0, 0, 255}), 
    Line(
    visible = useHeatPort, 
    points = {{0, -99}, {0, 25}}, 
    color = {127, 0, 0}, 
    pattern = LinePattern.Dot), 
    Text(
    extent = {{-150, 90}, {150, 50}}, 
    textString = "%name", 
    textColor = {0, 0, 255})}));
end ControlledIdealTwoWaySwitch;