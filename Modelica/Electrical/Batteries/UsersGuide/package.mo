within Modelica.Electrical.Batteries;
package UsersGuide "用户指南"
  extends Modelica.Icons.Information;

  annotation (DocumentationClass=true, Documentation(info="<html>
<p>
该库提供了基于电池终端的电气行为的电池模型。
</p>
<h4>电池特性</h4>
<p>
所有电池模型都依赖于Modelica标准库中提供的电压源、电阻和电容模型等现有组件
(<a href=\"modelica://Modelica.Electrical.Analog\">模拟库</a>)。用户可以在这个库中了解电池模型的<a href=\"modelica://Modelica.Electrical.Batteries.UsersGuide.Concept\">概念</a>以及<a href=\"modelica://Modelica.Electrical.Batteries.UsersGuide.Parameterization\">参数化</a>。
这两者都基于<a href=\"modelica://Modelica.Electrical.Batteries.UsersGuide.References\">参考文献</a>。
</p>
<p>
每个电池都配备了一个可选的热端口，可以通过参数<code>useHeatPort</code>启用；电池热端口的热流由所有电阻元件的热流之和确定。
这使得可以与外部热模型耦合，以研究热管理问题。然而，热模型尚未包含在内。
</p>
</html>"));
end UsersGuide;