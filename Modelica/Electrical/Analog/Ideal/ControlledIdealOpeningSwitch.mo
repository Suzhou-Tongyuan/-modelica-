within Modelica.Electrical.Analog.Ideal;
model ControlledIdealOpeningSwitch "受控理想电气开启器"
  parameter SI.Voltage level = 0.5 "Switch level";
  extends Modelica.Electrical.Analog.Interfaces.IdealSwitch;
  Modelica.Electrical.Analog.Interfaces.Pin control 
    "控制引脚：当control.v>level，开关打开，否则p--n连接" 
    annotation(Placement(transformation(
    origin = {0, 100}, 
    extent = {{-10, -10}, {10, 10}}, 
    rotation = 90)));
equation
  off = control.v > level;
  control.i = 0;
  annotation(defaultComponentName = "switch", 
    Documentation(info = "<html>
<p>受控理想开路开关的切换行为由控制引脚控制：当控制电压(control.v)大于阈值(level)时，开关处于关闭状态。
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
    Line(points = {{40, 20}, {40, 0}}, color = {0, 0, 255}), 
    Line(
    visible = useHeatPort, 
    points = {{0, -100}, {0, 25}}, 
    color = {127, 0, 0}, 
    pattern = LinePattern.Dot)}));
end ControlledIdealOpeningSwitch;