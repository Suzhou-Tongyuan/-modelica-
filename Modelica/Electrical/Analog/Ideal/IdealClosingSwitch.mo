within Modelica.Electrical.Analog.Ideal;
model IdealClosingSwitch "理想电气闭合器"
  extends Modelica.Electrical.Analog.Interfaces.IdealSwitch;
  Modelica.Blocks.Interfaces.BooleanInput control 
    "true=>p--n连接，开关打开" annotation(Placement(
    transformation(
    origin = {0, 120}, 
    extent = {{-20, -20}, {20, 20}}, 
    rotation = 270)));
equation
  off = not control;
  annotation(defaultComponentName = "switch", 
    Documentation(info = "<html>
<p>理想闭合开关的切换行为由输入信号控制：off=无控制。
详细请看：<a href=\"modelica://Modelica.Electrical.Analog.Interfaces.IdealSwitch\">IdealSwitch</a>
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
end IdealClosingSwitch;