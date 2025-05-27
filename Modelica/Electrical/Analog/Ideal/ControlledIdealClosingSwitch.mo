within Modelica.Electrical.Analog.Ideal;
model ControlledIdealClosingSwitch "受控理想电气闭合器"
  parameter SI.Voltage level = 0.5 "Switch level";
  extends Modelica.Electrical.Analog.Interfaces.IdealSwitch;
  Modelica.Electrical.Analog.Interfaces.Pin control 
    "控制引脚工作原理：当control.v控制电压处于高电平状态时，level switch(级联开关)会被激活，反之则处于闭合状态" 
    annotation(Placement(transformation(
    origin = {0, 100}, 
    extent = {{-10, -10}, {10, 10}}, 
    rotation = 90)));
equation
  off = control.v < level;
  control.i = 0;
  annotation(defaultComponentName = "switch", 
    Documentation(info = "<html>
<p>受控的理想闭合开关的切换行为由控制引脚控制：开关关闭条件:控制电压<阈值电压。
详细请查看：<a href=\"modelica://Modelica.Electrical.Analog.Interfaces.IdealSwitch\">IdealSwitch</a>
</p>



</html>", 
    revisions = "<html>
<ul>
<li><em>2016年2月7日</em>
       Anton Haumer<br>从部分IdealSwitch扩展而来<br>
       </li>
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
    Line(
    visible = useHeatPort, 
    points = {{0, -100}, {0, 25}}, 
    color = {127, 0, 0}, 
    pattern = LinePattern.Dot)}));
end ControlledIdealClosingSwitch;