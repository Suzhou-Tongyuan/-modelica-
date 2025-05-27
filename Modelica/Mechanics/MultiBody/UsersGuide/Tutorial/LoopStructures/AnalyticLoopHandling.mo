within Modelica.Mechanics.MultiBody.UsersGuide.Tutorial.LoopStructures;
class AnalyticLoopHandling "解析环路处理"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html><p>
众所周知，在技术设备中的大多数机械环路的非线性代数方程可以通过解析法解决。
然而，要完全自动执行这一过程是困难的，因此商业通用多体程序，如MSC ADAMS、LMS DADS、SIMPACK等都没有这个功能。
这些程序使用纯数值方法解决环路结构。
设计用于特定车辆动力学实时仿真的多体程序，例如ve-DYNA，通常包含特定多体系统(车辆)的手动实现，如果可能的话其中出现的环路要么通过解析法解决，要么通过在预处理阶段构建的表格查找。
没有这些功能，实现所需的实时性将会很困难。
</p>
<p>
德国杜伊斯堡的希勒教授及其团队在一系列论文中开发了系统处理机械环路的方法，详见
<a href=\"modelica://Modelica.Mechanics.MultiBody.UsersGuide.Literature\" target=\"\">MultiBody.UsersGuide.Literature</a>。
\"特征关节对\"方法基本上在两个关节处的一个局部环路，并使用几何不变量来减少代数方程的数量，通常减少到一个可以通过解析法解决的方程。
除此之外还开发了几个基于这种方法的多体代码，例如MOBILE。
除了解析法在解决非线性代数方程有非常期望的功能外，即以高效和稳健的方式解决，还存在部分缺点：首先很难自动应用这种方法。
即使这种自动化是可能的，也总会存在这样一个问题，即无法保证在仿真过程中静态选择的状态不会导致奇异性。
因此，“特征关节对”方法通常是手动应用的，这需要专业知识和经验。
</p>
<p>

在多体库中，以一种受限制的形式支持“特征关节对”方法，以便非专家也能应用它。
其基本思想是将关节在<a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Assemblies\" target=\"\">MultiBody.Joints.Assemblies</a>包中聚合为一个对象，该对象具有6个自由度或3个自由度(用于平面环路中的使用)。
</p>
<p>
下图给出了四连杆机构的一个变体作为示例。
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/LoopStructures/FourbarAnalytic2.png\">
</blockquote>
<p>
这里，该机构使用了六个旋转关节和一个平移关节进行建模。
在下图中，这五个旋转关节和一个平移关节被集合在一个名为“jointSSP”的组件对象中，该对象来自
<a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Assemblies.JointSSP\">
MultiBody.Joints.Assemblies.JointSSP</a>.</p>
<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/LoopStructures/FourbarAnalytic1.png\">
</blockquote>

<p>
JointSSP关节集合具有外部球形关节(frame_a)和平移关节(frame_b)的坐标系。
与Joints.Assemblies包中的所有其他对象一样，JointSSP具有这样一个特性：
<strong>给定frame_a和frame_b的运动，可以计算出广义坐标和组件中定义的所有其他坐标系
</strong>。
这是通过<strong>解析</strong>非线性方程组来完成的。
从结构上看，组件对象中的方程被写成如下形式<strong>q</strong> = <strong> f</strong><sub>1</sub>(<strong>r</strong><sup>a</sup>, <strong>R</strong><sup>a</sup>, <strong>r</strong><sup>b</sup>, <strong>R</strong><sup>b</sup>)：
</p>

<p>
其中 &nbsp;<strong>r</strong><sup>a</sup>, <strong>R</strong><sup>a</sup>, <strong>r</strong><sup>b</sup>, <strong>R</strong><sup>b</sup> 是分别定义frame_a和frame_b的位置和方向的变量，<strong>q</strong>是组件内部的广义位置坐标，例如，四连杆机构的旋转关节的角度。给定四连杆机构中旋转关节j1的角度j，组件对象的frame_a和frame_b可以通过正向递归计算得到：
(<strong>r</strong><sup>a</sup>,<strong>R</strong><sup>a</sup>, <strong>r</strong><sup>b</sup>, <strong>R</strong><sup>b</sup>) = <strong>f</strong>(j)
</p>
<p>
由于这是一个结构性质，算法可以自动选择j及其导数作为状态，然后可以按正向顺序计算所有位置变量。
现在可以理解，Modelica转换器可以将四杆连杆机构的方程转换为不再具有非线性代数环路的递归序列的语句(请记住，之前的“直接”解决方案具有5阶非线性方程组)。
</p>
<p>
聚合的关节对象由旋转关节或平移关节的组合以及在其两端具有两个球形关节或一个球形关节和一个万向节的杆组成。
对于所有组合，都可以确定解析解。
对于平面环路，可以解析处理1、2或3个具有平行轴的旋转关节以及轴与旋转关节垂直的2个或1个平移关节的组合。
当前支持的组合列在下表中。
</p>

<table style=\"width: auto;\"><tbody><tr><td colSpan=\"2\" rowSpan=\"1\" width=\"auto\"><strong>三维环结构:</strong></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">JointSSR</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">球关节 - 球关节 - 旋转关节</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">JointSSP</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">球关节 - 球关节 - 棱柱关节</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">JointUSR</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">万向节 - 球关节 - 旋转关节</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">JointUSP</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">万向节 - 球关节 - 棱柱关节</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">JointUPS</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">万向节 - 棱柱关节 - 球关节</td></tr><tr><td colSpan=\"2\" rowSpan=\"1\" width=\"auto\"><strong>平面环结构:</strong></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">JointRRR</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">旋转关节 - 旋转关节 - 旋转关节</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">JointRRP</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">旋转关节 - 旋转关节 - 棱柱关节</td></tr></tbody></table><p>
初看起来，这似乎相当受限制。
然而，机械装置通常是由连接在每一端的球形关节的杆组成，并且通常还包括旋转关节和平移关节。
因此，上表中的组合经常出现。
万向节通常在实际设备中不存在，但是会在以下情况下被使用：
(a)如果两个JointXXX组件可以连接，使得一个旋转关节和一个万向节共同形成一个球形关节；
(b)如果需要连接杆之间的定位，例如，因为需要连接一个物体。
在这种情况下，只要杆的质量和惯性不显著那么一个球形关节可能会被万向节替换的近似是可以被接受的。
</p>
<p>

让我们更详细地讨论项目(a)：下图所示的麦克弗森悬挂装置有三个坐标系连接器。
</p>
<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/LoopStructures/MacPherson1.png\">
</blockquote>

<p>
左下方的那个(frameChassis)被固定在车辆底盘上。
左上方的那个(frameSteering)由转向机构驱动，即两个坐标系的运动已知。
右侧的坐标系连接器(frameWheel)驱动车轮。
这三个坐标系通过一个由两根带有球形关节的杆组成的机构连接在一起。
这些杆由一个jointUPS和一个jointSSR组件构建而成。
可以看到，jointUPS组件的万向节与jointSSR组件的旋转关节相连接。
因此，在一个点上连接了3个旋转关节，并且如果选择旋转轴适当，这就描述了一个球形关节。
换句话说，这两个连接的组件定义了两根带有球形关节的所需杆。
</p>
<p>
底盘的运动，frameChassis，是在悬挂模型之外计算的。
当旋转关节“jointArm”(图中左下部分)的广义坐标被用作状态时，可以计算出jointUPS关节的frame_a和frame_b。
在与jointUPS关节的非线性环路解决(解析)之后，就可以得到该组件上的所有坐标系，特别是与jointSSR组件的frame_b相连的坐标系。
由于jointSSR的frame_a连接到由转向机构计算得到的frameSteering，再次计算出jointSSR组件所需的两个坐标系运动。
这反过来意味着该组件上的所有其他坐标系也可以计算出来，特别是与驱动车轮的frameWheel相连接的坐标系。
通过这种分析，可以清楚地看出系统能够解析地解决这些耦合的环路。
</p>
<p>
另一个例子是V6发动机的模型，请参见下图以查看动画视图和一个带有基本关节定义的气缸的原始定义。
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/LoopStructures/EngineV6_3.png\" width=\"303\" height=\"136\">
</blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/LoopStructures/EngineV6_2.png\">
</blockquote>

<p>
在这里，只需通过用一个具有两个旋转关节和一个平移关节的JointRRP对象替换关节，即可重新编写基本的气缸模型，如下图所示。
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/LoopStructures/EngineV6_4.png\">
</blockquote>

<p>
由于6个气缸相互连接，存在6个带有6个JointRRP对象的耦合环路。
该模型可作为<a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.EngineV6_analytic\" target=\"\">MultiBody.Examples.Loops.EngineV6_analytic</a>
使用。
</p>
<p>
连接的6个气缸的组合图如下图所示。
</p>
<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/LoopStructures/EngineV6_1.png\">
</blockquote>
<p>
可以看到，曲轴的旋转关节(图中左侧的joint \"bearing\")可以选择为自由度。
然后，可以计算出所有气缸的4个连接器坐标系。
因此，气缸的计算是相互解耦的。在一个气缸内，可以计算出jointRRP组件的frame_a和frame_b的位置，从而确定jointRRP对象中两个旋转关节和一个平移关节的广义坐标。
考虑到这种分析，一个Modelica转换器能够将DAE方程转换为顺序评估且没有任何非线性环路。
将这个良好的结果与仅使用基本关节的模型进行比较，后者导致每个环路有6个代数环路和5个非线性方程。
此外，还存在一个43阶的线性方程组。
采用解析环路处理的模拟时间大约快了5倍。
</p>
</html>"));
end AnalyticLoopHandling;