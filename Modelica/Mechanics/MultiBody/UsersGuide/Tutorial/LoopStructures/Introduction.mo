within Modelica.Mechanics.MultiBody.UsersGuide.Tutorial.LoopStructures;
class Introduction "介绍"
  extends Modelica.Icons.Information;

  annotation (DocumentationClass=true, Documentation(info="<html><p>
原则上，如果出现环路结构(与ModelicaAdditions.MultiBody库相反)，不需要采取特殊措施。
下图显示了一个示例。
该示例可在
<a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Fourbar1\" target=\"\">MultiBody.Examples.Loops.Fourbar1</a>
中找到。
</p>
<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/LoopStructures/Fourbar1a.png\">
</blockquote>
<p>
这个机构由6个旋转关节和1个棱柱关节组成，形成一个运动学闭环。它有1个自由度。在下一个图中显示了默认动画。请注意，旋转关节的轴由红色圆柱体表示，棱柱关节的轴由右下角的红色方块表示。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/LoopStructures/Fourbar1b.png\" width=\"300\">
</p>
<p>
每当出现环路结构时，“位置级别”上会存在非线性代数方程。
通常情况下，通过结构分析无法在平移过程中选择状态变量(但这对于非环路结构是可能的)。
在上述示例中，可以检测到一个包含54个方程的非线性代数回路，并将其简化为一个由6个耦合代数方程组成的系统。
请注意，这是通过适当的对符号型方程操作完成的，而没有像在多体程序中通常所做的那样使用任何“局部关节”。
通过动态虚拟导数方法，从这7个关节中的一个的位置和速度级别的广义坐标在仿真期间动态选择为状态。
每当这两个状态不再适用时，在仿真期间就会从其他一个关节中选择状态。
</p>
<p>
如果在平移时静态固定状态变量，通常可以增强环路结构的效率。
对于这个机构，关节j1的广义坐标(即旋转关节的旋转角度及其导数；在上述动画图中，该关节被可视化为x轴上的红色圆柱体)始终可以用作状态。
在上述示例中，通过在该关节的“高级”菜单中设置参数“stateSelect = 
<strong>StateSelect.always</strong>，
已经表明了这一点。当在四连杆机构中以这种方式为关节j1设置此标志时，可以检测到一个包含40个方程的非线性代数回路，并将其简化为一个由5个耦合非线性代数方程组成的系统。 
</p>
<p>

在许多机构中，可以通过对非线性代数方程进行解析来解决这一类问题。
对于某一类系统，MultiBody库也可以执行此操作。
这种技术在“<a href=\"modelica://Modelica.Mechanics.MultiBody.UsersGuide.Tutorial.LoopStructures.AnalyticLoopHandling\" target=\"\">Analtyic loop handing</a>”部分中描述。
</p>
</html>"));
end Introduction;