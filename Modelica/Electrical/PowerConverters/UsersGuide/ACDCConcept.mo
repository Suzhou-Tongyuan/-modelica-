within Modelica.Electrical.PowerConverters.UsersGuide;
class ACDCConcept "AC/DC转换器概念"
  extends Modelica.Icons.Information;
  annotation (DocumentationClass=true, Documentation(info="<html>

<p>AC/DC转换器也称为整流器</p>

<h4>组件分类</h4>

<p>传统的AC/DC转换器包含二极管和晶闸管。如果使用晶闸管，整流器的输出电压可以受控制。如果只使用二极管，则输出电压仅取决于输入电压和应用二极管的特性。</p>
<ul>
  <li>二极管整流器</li>
  <li>晶闸管整流器</li>
  <li>半控制整流器；其中半导体一半是二极管，另一半是晶闸管</li>
</ul>

<h4>拓扑分类</h4>

<p>PowerConverters库为单相和多相供电提供了桥式和中心引线整流器，详见<a href=\"modelica://Modelica.Electrical.PowerConverters.ACDC\">AC/DC转换器</a>。</p>

<h4>控制</h4>

<p>为每个提供的整流器提供了一个<a href=\"modelica://Modelica.Electrical.PowerConverters.ACDC.Control\">控制模型</a>。
这些控制模型具有用于与交流供电连接的电气连接器。
晶闸管整流器的触发角可以通过参数或信号输入设置。</p>

<h4>示例</h4>

<p>在<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC\">Examples.ACDC</a>中提供了各种示例。
这些示例包括不同类型的直流负载。甚至可以通过实验获得整流器的控制特性；这些模型的名称包含<code>_Characteristic</code>。</p>
</html>"));
end ACDCConcept;