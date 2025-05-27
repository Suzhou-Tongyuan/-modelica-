within Modelica.Electrical.Analog.Sources;
model CosineVoltage "余弦电压源"
  parameter SI.Voltage V(start = 1) "余弦的振幅";
  parameter SI.Angle phase = 0 "余弦波的相位";
  parameter SI.Frequency f(start = 1) "余弦波的频率";
  extends Interfaces.VoltageSource(redeclare Modelica.Blocks.Sources.Cosine 
    signalSource(
    final amplitude = V, 
    final f = f, 
    final phase = phase));
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 
    100}}), graphics = {Line(
    points = {{-71, 70}, {-68.4, 69.8}, {-63.5, 67}, {-58.6, 61}, {-53.6, 52}, {-48, 
    38.6}, {-40.98, 18.6}, {-26.21, -26.9}, {-19.9, -44}, {-14.2, -56.2}, {-9.3, 
    -64}, {-4.4, -68.6}, {0.5, -70}, {5.5, -67.9}, {10.4, -62.5}, {15.3, -54.1}, 
    {20.9, -41.3}, {28, -21.7}, {35, 0}}, 
    color = {192, 192, 192}, 
    smooth = Smooth.Bezier), Line(points = {{35, 0}, {44.8, 29.9}, {51.2, 46.5}, 
    {56.8, 58.1}, {61.7, 65.2}, {66.7, 69.2}, {71.6, 69.8}}, color = {192, 
    192, 192})}), 
    Documentation(revisions = "<html>
<ul>
<li>2013-05-14 Christian Kral创建</li>
</ul>
</html>", 
    info = "<html>

<p>这个电压源使用了Modelica.Blocks.Sources库中相应的信号源。 关于Blocks库中参数的意义，需要特别注意。另外，这里引入了一个offset参数，它将被添加到blocks源计算出的值中。startTime参数可用于沿时间轴平移的源模块。
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/CosineVoltage.png\"
     alt=\"CosineVoltage.png\">
</div>
</html>"));

end CosineVoltage;