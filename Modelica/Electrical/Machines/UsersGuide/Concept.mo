within Modelica.Electrical.Machines.UsersGuide;
class Concept "概念"
  extends Modelica.Icons.Information;
  annotation (preferredView="info",Documentation(info="<html>
<p>该包含有电机模型和用于建模这些机器的组件。</p>
<strong>限制和假设：</strong>
<ul>
<li>相数（感应电机的）限制为3，因此将其定义为常数 m=3</li>
<li>相对称绕组以及整个机器结构的对称性</li>
<li>所有值均使用物理单位，不进行 p.u. 缩放</li>
<li>仅考虑基本谐波（在空间中）</li>
<li>电压和电流的波形（随时间变化）不受限制</li>
<li>常量参数，即无饱和，无皮肤效应</li>
</ul>
<p>
您可以查看空间矢量理论的简要摘要：<a href=\"https://www.haumer.at/refimg/SpacePhasors.pdf\">https://www.haumer.at/refimg/SpacePhasors.pdf</a>
</p>
<strong>进一步发展：</strong>
<ul>
<li>将空间矢量理论推广到带有任意空间线圈角度的 m 相</li>
<li>将空间矢量理论推广到任意绕组数和线圈的绕组因数</li>
<li>MachineModels：其他机器类型</li>
<li>效应：饱和，皮肤效应等</li>
</ul>
<p>
谨以此库纪念<strong>Prof. Hans Kleinrath(1928-03-07-2010-04-05)</strong>
</p>

</html>"));
end Concept;