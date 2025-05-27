within Modelica.Electrical.PowerConverters.UsersGuide;
class ReleaseNotes "发布说明"
  extends Modelica.Icons.ReleaseNotes;
  annotation (Documentation(info="<html>
<h5>版本 3.2.3，2019-01-23</h5>
<ul>
<li>添加了直流和交流接口部分模型的瞬时功率计算，参见<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2198\">#2198</a></li>
<li>用Modelica.Electrical.PowerConverter替换了Modelica_Electrical_PowerConverters，参见<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2196\">#2196</a></li>
<li>在图表层中统一了PowerConverter连接器的位置，参见<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2185\">#2185</a></li>
<li>修复了损坏的超链接</li>
<li>根据<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2065\">#2065</a>，将引脚声明替换为<code>extends</code></li>
</ul>

<h5>版本 1.2.0，2014-04-06</h5>
<ul>
<li>由于一致性原因，将启用信号从控制移动到逆变器模型</li>
<li>添加了用于启用触发信号的部分模型</li>
</ul>

<h5>版本 1.1.0，2014-03-24</h5>
<ul>
<li>由于一致性原因，移除了StepUp转换器</li>
</ul>

<h5>版本 1.0.0，2014-03-24</h5>
<ul>
<li>第一个标记版本</li>
</ul>

</html>"));
end ReleaseNotes;