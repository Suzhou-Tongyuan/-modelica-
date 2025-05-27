within Modelica.Electrical.Analog.Sources;
model StepCurrent "阶跃电流源"
  parameter SI.Current I(start = 1) "阶跃高度";
  extends Interfaces.CurrentSource(redeclare Modelica.Blocks.Sources.Step 
    signalSource(final height = I));
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
    100}}), graphics = {Line(points = {{-86, -70}, {-14, -70}, {-14, 70}, {57, 
    70}}, color = {192, 192, 192})}), 
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
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/StepCurrent.png\"
     alt=\"StepCurrent.png\">
</div>
</html>"));
end StepCurrent;