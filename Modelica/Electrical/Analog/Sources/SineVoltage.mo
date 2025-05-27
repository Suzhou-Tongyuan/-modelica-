within Modelica.Electrical.Analog.Sources;
model SineVoltage "正弦电压源"
  parameter SI.Voltage V(start = 1) "正弦波的振幅";
  parameter SI.Angle phase = 0 "正弦波的相位";
  parameter SI.Frequency f(start = 1) "正弦波频率";
  extends Interfaces.VoltageSource(redeclare Modelica.Blocks.Sources.Sine 
    signalSource(
    final amplitude = V, 
    final f = f, 
    final phase = phase));
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 
    100}}), graphics = {Line(points = {{-66, 0}, {-56.2, 29.9}, {-49.8, 46.5}, 
    {-44.2, 58.1}, {-39.3, 65.2}, {-34.3, 69.2}, {-29.4, 69.8}, {-24.5, 67}, 
    {-19.6, 61}, {-14.6, 52}, {-9, 38.6}, {-1.98, 18.6}, {12.79, -26.9}, {
    19.1, -44}, {24.8, -56.2}, {29.7, -64}, {34.6, -68.6}, {39.5, -70}, {44.5, 
    -67.9}, {49.4, -62.5}, {54.3, -54.1}, {59.9, -41.3}, {67, -21.7}, {74, 0}}, 
    color = {192, 192, 192})}), 
    Documentation(revisions = "<html>
<ul>
<li><em> 1998   </em>
       Christoph Clauss<br>创建<br>
       </li>
</ul>
</html>", 
    info = "<html>
<p>这个电压源使用了Modelica.Blocks.Sources库中相应的信号源。 关于Blocks库中参数的意义，需要特别注意。另外，这里引入了一个offset参数，它将被添加到blocks源计算出的值中。startTime参数可用于沿时间轴平移的源模块。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/SineVoltage.png\"
     alt=\"SineVoltage.png\">
</div>
</html>"));

end SineVoltage;