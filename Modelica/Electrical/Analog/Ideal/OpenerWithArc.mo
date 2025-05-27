within Modelica.Electrical.Analog.Ideal;
model OpenerWithArc "带电弧效应的理想开路开关模型"

  extends Modelica.Electrical.Analog.Interfaces.IdealSwitchWithArc;
  Modelica.Blocks.Interfaces.BooleanInput control 
    "false=> p--n连接，true=>开关打开" annotation(Placement(
    transformation(
    origin = {0, 110}, 
    extent = {{-10, -10}, {10, 10}}, 
    rotation = 270)));
equation
  off = control;
  annotation(defaultComponentName = "switch", 
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
    100}}), graphics = {
    Line(points = {{40, 20}, {40, 0}}, color = {0, 0, 255}), 
    Line(points = {{40, 40}, {32, 30}, {48, 26}, {40, 20}}, color = {255, 0, 0})}), 
    Documentation(info = "<html>


<p>
这个模型是基于以下模型搭建：<a href=\"modelica://Modelica.Electrical.Analog.Ideal.IdealOpeningSwitch\">IdealOpeningSwitch</a>
</p>
<p>
如果对电弧效应存在疑惑，请查看：<a href=\"modelica://Modelica.Electrical.Analog.Interfaces.IdealSwitchWithArc\">IdealSwitchWithArc</a>
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
</html>"));
end OpenerWithArc;