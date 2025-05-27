within Modelica.Electrical.Polyphase.UsersGuide;
class ReleaseNotes "发布说明"
  extends Modelica.Icons.ReleaseNotes;
  annotation (preferredView="info", 
    DocumentationClass=true, Documentation(info="<html>

<h5>版本 3.2.3, 2019-01-23(Anton Haumer, Christian Kral)</h5>
<ul>
  <li>缩短了默认组件名称，请参阅
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2301\">#2301</a></li>
<li>从<a href=\"modelica://Modelica.Electrical.Polyphase.Basic.MutualInductor\">MutualInductor</a>中移除了多余的(并且不相同的)参数m，
    请参阅<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2202\">#2202</a></li>
<li>在<a href=\"modelica://Modelica.Electrical.Polyphase.Basic.MutualInductor\">MutualInductor</a>中，将epsilon从常数改为参数，
    请参阅<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2200\">#2200</a></li>
<li>添加了用户指南</li>
<li>添加了用于多个基本系统的块和函数</li>
</ul>

<h5>版本 1.4.0, 2009-08-26(Anton Haumer)</h5>
<ul>
<li>添加了作为Electrical.Analog中的条件热端口</li>
<li>添加了作为Electrical.Analog中的带弧开关</li>
</ul>

<h5>版本 1.3.2, 2007-08-24(Anton Haumer)</h5>
<ul>
<li>移除了重新声明类型SignalType</li>
</ul>

<h5>版本 1.3.1, 2007-08-12(Anton Haumer)</h5>
<ul>
<li>改进了文档</li>
</ul>

<h5>版本 1.3.0, 2007-01-23(Anton Haumer)</h5>
<ul>
<li>改进了一些图标</li>
</ul>

<h5>版本 1.2, 2006-07-05(Anton Haumer)</h5>
<ul>
<li>从Interfaces.Plug的引脚中移除了注释</li>
<li>修正了电阻/导纳的使用</li>
</ul>

<h5>版本 1.1, 2006-01-12(Anton Haumer)</h5>
<ul>
<li>添加了Sensors.PowerSensor</li>
</ul>

<h5>版本 1.0, 2004-10-01(Anton Haumer)</h5>
<ul>
  <li>初始发布版本</li>
</ul></html>"));
end ReleaseNotes;