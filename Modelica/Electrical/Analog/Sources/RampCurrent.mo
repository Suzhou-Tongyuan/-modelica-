within Modelica.Electrical.Analog.Sources;
model RampCurrent "斜坡电流源"
  parameter SI.Current I(start = 1) "斜坡的高度";
  parameter SI.Time duration(min = Modelica.Constants.small, start = 2) 
    "斜坡持续时间";
  extends Interfaces.CurrentSource(redeclare Modelica.Blocks.Sources.Ramp 
    signalSource(final height = I, final duration = duration));
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
    100}}), graphics = {Line(points = {{-80, -60}, {-50, -60}, {50, 60}, {80, 60}}, 
    color = {192, 192, 192})}), 
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
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/RampCurrent.png\"
     alt=\"RampCurrent.png\">
</div>
</html>"));
end RampCurrent;