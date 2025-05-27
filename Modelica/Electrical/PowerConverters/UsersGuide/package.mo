within Modelica.Electrical.PowerConverters;
package UsersGuide "用户指南"
  extends Modelica.Icons.Information;
  annotation (DocumentationClass=true, Documentation(info="<html>
<p>
该库为直流和交流单相和多相电气系统提供了功率转换器。PowerConverters库包含三种类型的转换器。
</p>

<ul>
  <li>交流/直流转换器（整流器）</li>
  <li>直流/交流转换器（逆变器）</li>
  <li>直流/直流转换器</li>
  <li>交流/交流转换器</li>
</ul>

<p>
交流/交流转换器目前仅提供具有三角晶闸管的调光器和软启动器。
</p>

<h4>转换器特性</h4>

<ul>
  <li>所有转换器模型都依赖于Modelica标准库的<a href=\"modelica://Modelica.Electrical.Analog.Ideal\">Analog.Ideal</a>和<a href=\"modelica://Modelica.Electrical.Polyphase.Ideal\">Polyphase.Ideal</a>包中提供的现有二极管、晶闸管和开关模型。</li>
  <li>不考虑开关损耗和恢复效应</li>
  <li>只考虑导通损耗</li>
  <li>半导体的参数包括
  <ul>
    <li>通态电阻 <code>Ron</code></li>
    <li>关态导纳 <code>Goff</code></li>
    <li>开启电压 <code>Vknee</code></li>
  </ul></li>
  <li>每个转换器都配备了一个可选的热端口，可以通过参数<code>useHeatPort</code>启用；所有半导体的热端口都连接在一起，因此所有半导体的温度都相等，转换器热端口的热流由所有半导体热流的总和确定</li>
  <li>每个转换器包含布尔型触发输入，提供变量<code>offStart...</code>来指定每个半导体的初始关断状态条件</li>
  <li>布尔型触发信号可以通过参数<code>constantEnable</code>或条件信号输入启用，由<code>useConstantEnable = false</code>启用</li>
  <li>多相转换器的相数不限于三</li>
</ul>

<h4>文献</h4>

<p>
关于功率转换器和功率电子学的一般背景知识可参考<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.References\">[Skvarenina01]</a>和<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.References\">[Luo05]</a>。一本免费提供的书籍可以在<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.References\">[Williams2006]</a>找到。
</p>
</html>"));
end UsersGuide;