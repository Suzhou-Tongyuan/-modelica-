within Modelica.Electrical.QuasiStatic.UsersGuide;
package Overview "概述"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic\">Modelica.Electrical.QuasiStatic</a> 库用于分析仅具有纯正弦电压和电流的电路。该库的主要特点包括：
</p>

<ul>
  <li>仅考虑纯正弦电压和电流。不考虑更高次谐波电压和电流。</li>
  <li>忽略任何电气瞬态效应。</li>
  <li>该库的电气组件严格为线性。</li>
  <li>电路的电压和电流的角频率 <code>omega</code> 是通过参考角度 <code>gamma</code> 计算得出的，即 <code>omega = der(gamma)</code>。</li>
  <li>参考角度 <code>gamma</code> 不是全局量，因为它通过连接器传播。因此，可以在一个模型中建模不同频率的独立电路。</li>
  <li>连接器包含电压和电流的实部和虚部的<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview.Introduction\">有效值相量</a>。</li>

</ul>

<p>
该库的主要目的是对具有固定和可变频率的单相和多相<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview.ACCircuit\">交流电路</a>的准静态行为进行建模。准静态理论和应用可在 [<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.References\">Dorf1993</a>], [<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.References\">Burton1994</a>], [<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.References\">Landolt1936</a>], [<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.References\">Philippow1967</a>], [<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.References\">Weyh1967</a>], [<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.References\">Vaske1973</a>] 中找到。
</p>

<h4>注意</h4>
<p>
一般的电气电路可以是直流电路，具有周期正弦或非正弦电压和电流的交流电路，或者没有特定电压和电流波形的瞬态电路。因此，必须谨慎设计准静态电路与一般（瞬态）电路之间的耦合模型，考虑特定的应用。例如，您可以查看<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Utilities.IdealACDCConverter\">理想交直流转换器</a>，该转换器在<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Examples.Rectifier\">整流器示例</a>中使用。
</p>

</html>"));
end Overview;