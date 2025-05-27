within Modelica.Magnetic.FluxTubes.UsersGuide;
class FluxTubeConcept "通量管概念"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<h4>磁通管概念概述</h4>
<p>
下面简要介绍磁通管的概念。有关磁通管元件的详细说明，请参阅列出的文献。磁通管可以用集总网络对磁场进行建模。下图和下面的方程说明了从<em>麦克斯韦</em>方程描述的原始磁场量到具有流动变量和跨变量的网元的转变:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/FluxTubeConcept/magnetic_flux_tube_schematic.png\" alt=\"Magnetic flux tube\">
</div>

<p>
在每个长度坐标<em>s</em> (<em> a </em>垂直于磁力线方向)处，磁场强度<strong>H</strong>和磁通密度<strong>B</strong>通过横截面积<em> a </em>近似均匀分布的区域，可以定义磁阻<em>R<sub>m</sub></em>:</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/FluxTubeConcept/eq_transition_reluctance_flowAcross_IntegralQuantities.png\" alt=\"Transition from field quantities to flow- and across variables\">
</div>

<p>
将磁位差<em>V<sub>m</sub></em>定义为跨变量，磁通量<em>&Phi;</em>为流动变量，则磁阻元件<em>R<sub>m</sub></em>的定义与其他物理域的电阻网络元件类似。利用<em>Maxwell</em>的本构方程
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/FluxTubeConcept/eq_MaxwellConstitutive.png\" alt=\"Maxwell's constitutive equation\">
</div>

<p>根据磁阻的几何性质和材料性质计算磁阻<em>R<sub>m</sub></em>的通式为:</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/FluxTubeConcept/eq_reluctance_general.png\" alt=\"General formula for calculation of a magnetic reluctance\">
</div>

<p>
对于长度<em>l</em>，截面积<em> a </em>且磁通量通过其端面进出该区域的棱柱体或圆柱体，上式化简为:</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/FluxTubeConcept/eq_reluctance_prismatic.png\" alt=\"Magnetic reluctance of a prismatic or cylindrical volume\">
</div>

<p>
对其他几何图形也可以推导出类似的方程。在不能直接积分的情况下，磁阻可以分别根据平均长度、平均横截面积和体积<em>V</em>计算:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/FluxTubeConcept/eq_reluctanceFromAverageGeometry.png\" alt=\"Reluctance calculation from average geometric quantities\">
</div>

<p>
用于磁电位差或磁动势源的网络元件，即线圈或永磁体也可以制定。所得到的执行器磁网络模型反映了这些装置的主要尺寸以及其磁活性材料的通常非线性特性.
</p>

</html>"));
end FluxTubeConcept;