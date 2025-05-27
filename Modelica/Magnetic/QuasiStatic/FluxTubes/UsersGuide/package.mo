within Modelica.Magnetic.QuasiStatic.FluxTubes;
package UsersGuide "用户指南"
  extends Modelica.Icons.Information;
  annotation (DocumentationClass=true, Documentation(info="<html>
<p>准静态磁通管库是在瞬态库的基础上建立的
<a href=\"modelica://Modelica.Magnetic.FluxTubes\">Magnetic.FluxTubes</a>。限制通量和通量管的主要原理也适用。准静态磁通管库包含了基于准静态理论的集总磁网络电磁器件的建模组件。基于此库的模型适用于元器件级和系统级变压器的准静态仿真。</p>
该库的准静态分量不考虑饱和，因为<strong>线性</strong>是严格假设的。如果需要考虑饱和电路的磁导率，则<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Sensors.Transient. FundamentalWavePermabilitySensor\">transient permeability estimation sensor</a>可通过瞬态模拟确定有效渗透率.
</p>

<p>
有关 <strong>准静态</strong>（准静态）相位的一般介绍，可参阅<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview\">Modelica.Electrical.QuasiStatic</a>.
</p>

<p>
这个用户指南对底层提供了一个简短的介绍
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.UsersGuide. FluxTubeConcept\">concept</a>，总结了基本关系和方程.
</p>
</html>"));
end UsersGuide;