within Modelica.Electrical.Analog.Sources;
model TrapezoidVoltage "梯形波电压源"
  parameter SI.Voltage V(start = 1) "梯形波幅值";
  parameter SI.Time rising(final min = 0, start = 0) 
    "梯形波形上升时间";
  parameter SI.Time width(final min = 0, start = 0.5) 
    "梯形波形宽度";
  parameter SI.Time falling(final min = 0, start = 0) 
    "梯形波形下降时间";
  parameter SI.Time period(final min = Modelica.Constants.small, start = 1) 
    "周期时间";
  parameter Integer nperiod(start = -1) 
    "周期数(小于0表示无限多个周期)";

  extends Interfaces.VoltageSource(redeclare
    Modelica.Blocks.Sources.Trapezoid signalSource(
    final amplitude = V, 
    final rising = rising, 
    final width = width, 
    final falling = falling, 
    final period = period, 
    final nperiod = nperiod));
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
    100}}), graphics = {Line(points = {{-81, -70}, {-60, -70}, {-30, 70}, {1, 70}, 
    {30, -70}, {51, -70}, {80, 70}}, color = {192, 192, 192})}), 
    Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
    100, 100}}), graphics = {Line(
    points = {{60, 81}, {60, -30}}, 
    color = {192, 192, 192}, 
    pattern = LinePattern.Dash)}), 
    Documentation(revisions = "<html>
<ul>
<li><em> 1998   </em>
       Christoph Clauss<br>创建<br>
       </li>
</ul>
</html>", 
    info = "<html>
<p>这个电压源使用了Modelica.Blocks.Sources库中相应的信号源。关于Blocks库中参数的意义，需要特别注意。另外，这里引入了一个offset参数，它将被添加到blocks源计算出的值中。startTime参数可用于沿时间轴平移的源模块。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/TrapezoidVoltage.png\"
     alt=\"TrapezoidVoltage.png\">
</div>
</html>"));
end TrapezoidVoltage;