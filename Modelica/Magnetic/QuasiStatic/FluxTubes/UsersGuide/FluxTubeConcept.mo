within Modelica.Magnetic.QuasiStatic.FluxTubes.UsersGuide;
class FluxTubeConcept "磁通管概念"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<h4>准静态磁通管概念概述</h4>
<p>
下面简要介绍磁通管的概念。有关磁通管元件的详细说明，请参阅列出的文献。磁通管可以用集总等效电路网络对磁场进行建模.</p>

<p>由于假定准静态条件，每个场的量都可以用一个复相量来表示——通过在各自的变量下划下划线来表示:
</p>

<ul>
<li>磁通密度的法向分量,
    <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/B_n.png\"> </li>
<li>磁场强度的法向分量,
    <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/H_n.png\"> </li>
<li>磁通量,
    <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/Phi.png\"> </li>
<li>磁电势差,
    <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/V_m.png\"> </li>
</ul>

<p>下图和下面的公式说明了</p>

<ul>
<li>磁通密度和磁通的法向分量，以及</li>
<li>磁场强度和磁势差的法向分量.</li>
</ul>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/magnetic_flux_tube_schematic_qs.png\" alt=\"Magnetic flux tube\">
</div>

<p><strong>磁通管</strong>限制磁通量。磁力线和磁通管分别总是封闭的。因此，没有磁通量进入或离开磁通管。一个构型的总磁通量可以用平行的磁通管来表示，代表不同的磁通路径。这可以通过连接块状电路模型中的元件来实现，这样一个连接的所有磁通量之和等于零.</p>

<p>
对于具有长度的磁通管的一段
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/l.png\">
磁位差由长度积分除以磁场强度决定:</p>

<dl>
<dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/V_m-H_n.png\">
</dd>
</dl>

<p>
分别进入和离开磁通管的磁通量由以下法向分量的表面积分决定
的表面积分:</p>
<dl><dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/Phi-B_n.png\">
</dd></dl>
<p>磁势差和磁通量的角度相同，因此磁阻是一个实数（非复数）:</p>

<dl><dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/R_m-V_m-Phi.png\">
</dd></dl>

<p>
对于一个
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.FixedShape.GenericFluxTube\">generic flux tube</a>磁阻常数
横截面面积;
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/A.png\">,
和长度,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/l.png\">,
磁阻为:</p>
<dl><dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/R_m_cuboid.png\">
</dd></dl>

<h4>假设</h4>

<ul>
<li>不考虑<strong>力</strong>相互作用</li>
<li>电感模型是 <strong>线性的</strong>；因此只有通过调整恒定的相对磁导率，才能将非线性因素考虑在内；
参见示例
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Examples.NonLinearInductor\">NonLinearInductor</a></li>
</ul>

<h4>注释</h4>

<p>参数和变量名的选择尽可能接近瞬态
<a href=\"modelica://Modelica.Magnetic. FluxTubes\">FluxTubes</a>库，以避免在将瞬态通量管模型转换为准静态通量管模型时进行额外的工作.</p>

<h4>参考注释</h4>

<p>在准静态磁通管模型上也有类似的方法
[<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.UsersGuide.Literature\">Raabe2012</a>].</p>
</html>"));
end FluxTubeConcept;