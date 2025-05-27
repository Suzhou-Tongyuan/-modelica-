within Modelica.Electrical.Analog.Sources;
model ExponentialsCurrent "上升和下降的指数电流源"
  parameter Real iMax(start = 1) "上升沿的上界";
  parameter SI.Time riseTime(min = 0, start = 0.5) "上升时间";
  parameter SI.Time riseTimeConst(min = Modelica.Constants.small, start = 0.1) 
    "上升时间常数";
  parameter SI.Time fallTimeConst(min = Modelica.Constants.small, start = 
    riseTimeConst) "下降时间常数";
  extends Interfaces.CurrentSource(redeclare
    Modelica.Blocks.Sources.Exponentials signalSource(
    final outMax = iMax, 
    final riseTime = riseTime, 
    final riseTimeConst = riseTimeConst, 
    final fallTimeConst = fallTimeConst));
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
    100}}), graphics = {Line(points = {{-76, -59}, {-73.2, -44.3}, {-70.3, -31.1}, 
    {-66.8, -16.6}, {-63.3, -4}, {-59.7, 6.92}, {-55.5, 18.18}, {-51.3, 27.7}, 
    {-46.3, 37}, {-40.6, 45.5}, {-34.3, 53.1}, {-27.2, 59.6}, {-18.7, 65.3}, 
    {-8.1, 70.2}, {-6, 71}, {-3.88, 58.5}, {-1.05, 43.7}, {1.78, 30.8}, {
    4.606, 19.45}, {8.14, 7.3}, {11.68, -3}, {15.9, -13.2}, {20.2, -21.6}, {
    25.1, -29.5}, {30.8, -36.4}, {37.1, -42.3}, {44.9, -47.5}, {54.8, -51.8}, 
    {64, -54.4}}, color = {192, 192, 192})}), 
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
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/ExponentialsCurrent.png\"
     alt=\"ExponentialsCurrent.png\">
</div>
</html>"));
end ExponentialsCurrent;