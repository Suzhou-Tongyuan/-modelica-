within Modelica.Electrical.Analog.Sources;
model TrapezoidCurrent "梯形波电流源"
  extends Interfaces.CurrentSource;
  parameter SI.Current I(start = 1) "梯形幅度";
  parameter SI.Time rising(final min = 0, start = 0) 
    "梯形上升时间";
  parameter SI.Time width(final min = 0, start = 0.5) 
    "梯形的宽度持续时间";
  parameter SI.Time falling(final min = 0, start = 0) 
    "梯形波下降时间";
  parameter SI.Time period(final min = Modelica.Constants.small, start = 1) 
    "周期时间";
  parameter Integer nperiod(start = -1) 
    "周期数(<0表示无限周期)";
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
    100}}), graphics = {Line(points = {{-81, -66}, {-60, -66}, {-30, 74}, {1, 74}, 
    {30, -66}, {51, -66}, {80, 74}}, color = {192, 192, 192})}), 
    Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
    100, 100}}), graphics = {Line(
    points = {{60, 80}, {60, -30}}, 
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

<p>这个电流源使用了Modelica.Blocks.Sources库中相应的信号源。关于Blocks库中参数的意义，需要特别注意。另外，这里引入了一个offset参数，它将被添加到blocks源计算出的值中。startTime参数可用于沿时间轴平移的源模块。
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/TrapezoidCurrent.png\"
     alt=\"TrapezoidCurrent.png\">
</div>
</html>"));
end TrapezoidCurrent;