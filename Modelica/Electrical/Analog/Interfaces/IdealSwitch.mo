within Modelica.Electrical.Analog.Interfaces;
partial model IdealSwitch "理想电气开关"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  parameter SI.Resistance Ron(final min = 0) = 1e-5 
    "闭合开关电阻";
  parameter SI.Conductance Goff(final min = 0) = 1e-5 
    "打开开关导纳";

  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T = 293.15);
protected
  Boolean off "Indicates off-state";
  Real s(final unit = "1") "Auxiliary variable";
  constant SI.Voltage unitVoltage = 1 annotation(HideResult = true);
  constant SI.Current unitCurrent = 1 annotation(HideResult = true);
equation
  v = (s * unitCurrent) * (if off then 1 else Ron);
  i = (s * unitVoltage) * (if off then Goff else 1);
  LossPower = v * i;
  annotation(
    Documentation(info = "<html>
<p>
理想开关有一个正极p和一个负极n。开关行为由布尔信号off控制。如果off为真，则正极p不与负极n连接。否则，正极p与负极n连接。
<br><br>

为了防止切换时出现奇点，已打开的开关具有(很低)的导纳Goff，而已打开的开关具有(很低)电阻Ron。极限情况也是允许的，即已关闭的开关的电阻Ron可能恰好为零，而已打开的开关的导纳Goff也可能恰好为零。请注意，有些电路在零Ron或零Goff的描述是不可能的。
<br><br>
<strong>请注意：</strong>
如果useHeatPort=true，则<strong>不会</strong>对电行为的温度依赖性进行建模。参数不是温度依赖的。即使环境温度发生变化，电子元件的电气特性也不会随之改变。
</p>
</html>", 
    revisions = "<html>
<ul>
<li><em> March 11, 2009   </em>
       由Christoph Clauss<br>添加conditional heat port<br>
       </li>
<li><em> 1998   </em>
       由Christoph Clauss<br>创建<br>
       </li>
</ul>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
    100}}), graphics = {
    Ellipse(extent = {{-44, 4}, {-36, -4}}, lineColor = {0, 0, 255}), 
    Line(points = {{-90, 0}, {-44, 0}}, color = {0, 0, 255}), 
    Line(points = {{-37, 2}, {40, 40}}, color = {0, 0, 255}), 
    Line(points = {{40, 0}, {90, 0}}, color = {0, 0, 255}), 
    Line(
    visible = useHeatPort, 
    points = {{0, -100}, {0, 25}}, 
    color = {127, 0, 0}, 
    pattern = LinePattern.Dot), 
    Text(
    extent = {{-150, 90}, {150, 50}}, 
    textString = "%name", 
    textColor = {0, 0, 255})}));
end IdealSwitch;