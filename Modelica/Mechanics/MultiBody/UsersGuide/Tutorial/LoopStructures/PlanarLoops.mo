within Modelica.Mechanics.MultiBody.UsersGuide.Tutorial.LoopStructures;
class PlanarLoops "平面环"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html><p>
下图显示了一个具有简单燃烧模型的V6发动机模型。它可从<a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.EngineV6\" target=\"\">MultiBody.Examples.Loops.EngineV6</a>获得。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/LoopStructures/EngineV6_1.png\">
</p>
<p>
下图显示了一个气缸的Modelica原理图。
将6个这样的气缸实例对象适当连接在一起，就可以得到上面显示的发动机原理图。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/LoopStructures/EngineV6_2.png\">
</p>
<p>
在下图中显示了发动机的动画。
每个气缸主要由1个移动副和2个转动副组成，形成一个平面回路，因为两个转动副的轴平行，而移动副的轴与转动副轴正交。
所有的6个气缸一起形成了一个耦合的6个回路集合，总共有1个自由度。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/LoopStructures/EngineV6_3.png\" width=\"303\" height=\"136\">
</p>
<p>
所有平面环路，特别是发动机，会导致一个不具有唯一解的DAE(Differential-Algebraic Equation system 微分-代数方程系统)。
原因是例如转动副轴向的局部力无法唯一计算。
任何值都可以满足DAE方程。
这是由算法确定的结构性属性。
由于它们检测到DAE在结构上是奇异的，因此无法进一步处理。
如果不提供额外信息，也不可能增强算法，因为如果转动副的旋转轴仅稍作改变，使它们不再平行，平面环路将无法移动，自由度为0。基于纯结构信息的算法无法区分这两种情况。
</p>
<p>
通常的解决方法是移除多余的约束，例如，沿着<strong>一个</strong>转动副的旋转轴。
由于对于不熟练的建模者来说这不容易，因此提供了特殊的关节：
<a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.RevolutePlanarLoopConstraint\" target=\"\">RevolutePlanarLoopConstraint</a>
，用以移除这些约束。
在每个平面环路中，必须用这种关节类型替换一个转动副。在发动机示例中，这个特殊的关节用于上述气缸模型中的转动副B2。该关节的图标与其他转动副略有不同，以便于可视化这种情况。
</p>
<p>
如果建模者不了解平面环路的问题，并在没有特殊考虑的情况下进行建模，Modelica翻译器会显示错误消息，并指出平面环路出问题的可能原因，并建议使用RevolutePlanarLoopConstraint关节。
这条错误消息是由于Frame连接器中的注释所致。
</p>
<pre><code >connector Frame
...
flow SI.Force f[3] annotation(unassignedMessage=\"...\");
end Frame;
</code></pre><p>
如果无法为连接器中的某些力找到分配，会显示\"unassignedMessage\"。
大多数情况下，这个原因是一个平面环路或两个约束相同运动的关节。
这两种情况在错误消息中都有讨论。
</p>
<p>
请注意，平面环路中出现的非线性代数方程在大多数情况下可以通过解析法解决，因此强烈建议在这种系统中使用
“<a href=\"modelica://Modelica.Mechanics.MultiBody.UsersGuide.Tutorial.LoopStructures.AnalyticLoopHandling\" target=\"\">Analytic loop handing</a>”部分中的讨论。
</p>
</html>"));
end PlanarLoops;