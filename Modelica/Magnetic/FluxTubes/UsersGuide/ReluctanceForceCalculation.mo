within Modelica.Magnetic.FluxTubes.UsersGuide;
class ReluctanceForceCalculation "阻力"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<h4>根据叠加磁网络模型计算磁阻力</h4>

<p>
一般情况下，平移式电磁机械作动器产生的推力<em>F</em>(类似于有转矩和角位置的转动情况)等于磁协能<em>W<sub>m</sub><sup>*</sup></em>随电枢位置<em>x</em>的变化
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/ReluctanceForceCalculation/eq_CoEnergy_general.png\" alt=\"Equation for force calculation from change of magnetic co-energy with armature position\">
</div>

<p>
(<em>&Psi;</em>磁链，<em>i</em>执行器电流)。在集总磁网络模型中，上述方程化简为
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/ReluctanceForceCalculation/eq_forceFromPermeance_network.png\" alt=\"Equation for force calculation in lumped magnetic network models\">
</div>

<p>
其中<em>n<sub>linear</sub></em>为磁通管中相对磁导率不变的磁通管元件的个数，其磁通率随电枢位置的变化而变化<em>G<sub>m i</sub></em>， <em>V<sub>m i</sub></em>为各磁通管上的磁电压，<em>dG<sub>m i</sub>/dx</em>为各磁通管的磁通率对电枢位置的导数。
从基于磁共能的一般公式到后者的过渡概述在 <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[KEQ+12]</a>为磁导率的倒数，即为磁阻<em>R<sub>m</sub></em>。请注意,
</p>

<div>
<img 
src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/ReluctanceForceCalculation/eq_transition_forceReluctancePermeance.png\" alt=\"Transition from force calculation based on reluctance to calculation based on permeance\">
</div>

<p>
其中<em>&Phi;<sub>i</sub></em>为通过各磁通管元件的磁通量.
</p>

<p>
磁网模型中具有<em>非线性</em>材料特性的磁管元件<em>&mu;<sub>r</sub></em>(<em>B</em>)不限制上述方程的可用性。然而，要求这些非线性磁通管元件不随电枢运动而改变其形状(例如，磁通沿轴向通过的螺线管柱塞部分)。这种限制并不强，因为在大多数情况下，可以忽略非线性但高导磁的铁磁通管元件的磁导率及其与气隙磁通管相比随电枢位置的变化。
由于此约束，
子包<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.FixedShape\">Shapes.FixedShape</a>是固定的，是非线性磁通管元件的尺寸。
而子包<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Force\">Shapes.Force</a>中的线性磁通管元件的运动方向尺寸是固定的，力在模拟过程中可能会变化。对于该包中定义的形状相当简单的磁通管，给出了导数<em>dG<sub>m</sub>/dx</em>的解析表达式。对于更复杂的形状和带有电圈运动的尺寸变化，必须在模型开发期间解析地提供它，
最好是通过扩展部分模型<a href=\"modelica://Modelica.Magnetic.FluxTubes.BaseClasses.Force\">BaseClasses.Force</a>.
</p>

<p>
子包<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Leakage\">Shapes.Leakage</a>包含漏磁管形状，通常是围绕棱柱或圆柱极点的漏磁。由于磁通管的磁导率不随电枢位置的变化而变化，因此它们不影响磁阻执行器的推力.
</p>

</html>"));
end ReluctanceForceCalculation;