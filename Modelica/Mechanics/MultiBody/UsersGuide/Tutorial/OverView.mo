within Modelica.Mechanics.MultiBody.UsersGuide.Tutorial;
class OverView "多体库概述"
  extends Modelica.Icons.Information;

  annotation(Documentation(info = "<html><p>
<strong>MultiBody</strong>库是一个<strong>免费</strong>的Modelica包，提供三维机械组件，以便捷迅速的方式对<strong>机械系统</strong>建模，如机器人、机构、车辆等。其基本特点是所有组件都具有<strong>动画</strong>信息，包括适当的默认大小和颜色。下图显示了一个双摆的动画典型截图，以及它的示意图。
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/DoublePendulumSmall.png\">

<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/DoublePendulumDiagramSmall.png\" alt=\"double pendulum (diagram layer)\">
</div>

<p>
注意，所有组件(全局坐标系、重力加速度矢量、旋转关节和构件)都在动画中可视化显示。</p>
<p>这个库取代了长期使用的ModelicaAdditions.MultiBody库，因为它更容易使用，功能强大。
该库的主要特点如下：
</p>
<ul><li>
大约有<strong>60个主要的组件 </strong>，即关节、力、部件、物体、传感器和可视化组件，这些组件均可直接使用，并具有可使用的默认动画属性。
对于一维力学定律部分可以使用Modelica.Mechanics.Rotational和Modelica.Mechanics.Translational库的组件定义，并通过相应的一维接口接器连接到MultiBody组件。</li>
</ul><ul><li>
约<strong>75个函数</strong>，用以操作方向对象，例如：在不同坐标系之间转换矢量，或计算平面旋转的方向对象。其基本思想实质上是通过提供一个<strong>Orientation</strong>类型，通过在该类型的实例上操作的<strong>函数</strong>来隐藏方向的实际定义。
基于已被提供的3x3变换矩阵和四元数。然而另一方面，所有在其它组件中的方程都更简单且更加容易理解。</li>
<li>
每个模型顶层必须存在一个<strong>World模型。
</strong>在这里定义了重力场(无重力、均匀重力、点重力)、全局坐标系和动画的默认设置。
如果不存在World模型，则会自动提供并显示警告信息。</li>
<li>
所有组件中都具有<strong>内置的动画属性，</strong>例如关节、力、构件、传感器。这使得用户可以便捷的方式构建模型同时对模型进行可视化检查。
每个组件的动画均可以通过参数进行关闭。其基本方式是通过世界模型中的一个参数关闭整个模型的动画。如果关闭动画，则会从生成的代码中删除所有与动画相关的方程。
但动画对于实时仿真尤为重要。</li>
<li>
<strong>运动环的自动处理</strong>。
组件可以以几乎任意的方式连接在一起。
组件是否翻转都无关紧要。
这不影响效率。
如果出现运动环的结构，系统将自动通过一种新技术以高效的方式处理，该技术将一定类别的符号型超定微分代数方程转换为方程和未知数相同的系统(用户<strong>无需使用</strong>特殊的局部关节来构造树结构用以构建局部环路)。
</li>
<li>
<span style=\"color: rgb(36, 41, 47); background-color: rgb(244, 246, 248);\">
<strong>自动从关节和构件中选择状态变量</strong></span><span style=\"color: rgb(36, 41, 47); background-color: rgb(244, 246, 248);\">。
大多数关节和所有物体都具有潜在的状态变量。如果可能，Modelica翻译器将使用关节的广义坐标作为状态变量。
如果这不可行，则从物体坐标中选择状态变量。
因此，在空间中自由移动的物体无需定义具有6个自由度的关节。
用户可以从相应组件的</span><span style=\"color: rgb(36, 41, 47); 
background-color: rgb(244, 246, 248);\"><strong>高级菜单</strong></span><span style=\"color: rgb(36, 41, 47); background-color: rgb(244, 246, 248);\">中手动选择状态变量，或者使用Modelica参数修改来直接设置“stateSelect”属性。</span></li>
<li>
<span style=\"color: rgb(36, 41, 47); background-color: rgb(244, 246, 248);\"><strong>运动环的解析解</strong></span><span style=\"color: rgb(36, 41, 47); background-color: rgb(244, 246, 248);\">。
在运动环中出现的非线性方程会被</span><span style=\"color: rgb(36, 41, 47); background-color: rgb(244, 246, 248);\"><strong>解析</strong></span><span style=\"color: rgb(36, 41, 47); background-color: rgb(244, 246, 248);\">求解，适用于大多数机构，
例如4连杆机构、滑块曲柄机构或麦弗逊悬架。这是通过使用Modelica.Mechanics.MultiBody.Joints包中提供的装配关节JointXXX来构造这样的环来实现的。装配关节由3个一起具有6个自由度的关节组成，即没有约束。它们没有潜在的状态变量。当提供了两个坐标系连接器的运动时，将解析求解非线性方程组以计算3个关节的运动。
解析处理环对于实时仿真尤为重要。</span></li>

<li>
<span style=\"color: rgb(36, 41, 47); background-color: rgb(244, 246, 248);\">
<strong>可能具有质量的线性力组件</strong></span><span style=\"color: rgb(36, 41, 47); background-color: rgb(244, 246, 248);\">。
线性力组件的质量位于力作用的线上。
它们通过一个或两个点质量来近似真实物理设备的质量属性。
例如，弹簧通常具有显著的质量，这些质量在实际处理中必须考虑到。如果将质量设置为零，则这些点质量的额外代码需要删除处理。
如果考虑到质量，其计算开销一般很小(一维出现的运动学环被解析解决)。</span></li>
<li>
<span style=\"color: rgb(36, 41, 47); background-color: rgb(244, 246, 248);\">
<strong>力组件可以直接连接在一起</strong></span><span style=\"color: rgb(36, 41, 47); background-color: rgb(244, 246, 248);\">，例如，串联的三维弹簧。
通常，多体程序有一个限制，即力组件只能在两个物体之间连接。Modelica多体库中没有此类限制，因为它是一个完全面向对象的基于方程的库。
通常，如果力组件直接连接在一起，会出现非线性方程组。这样做的优点通常是这可能避免如果必须在两个力元素之间放置一个小质量时会出现的刚性系统。</span></li>
<li>
<span style=\"color: rgb(36, 41, 47); background-color: rgb(244, 246, 248);\">
<strong>通过菜单进行初始化定义</strong></span><span style=\"color: rgb(36, 41, 47); background-color: rgb(244, 246, 248);\">。
在参数菜单中可以对关节和物体的状态进行初始化，无需在Modelica语句中进行调整。
对于非标准初始化，可以使用常规的Modelica命令来进行初始化。</span></li>
<li>
<span style=\"color: rgb(36, 41, 47); background-color: rgb(244, 246, 248);\">
<strong>多体特定的错误消息</strong></span><span style=\"color: rgb(36, 41, 47); background-color: rgb(244, 246, 248);\">。
已引入注释和assert语句，这些语句在许多情况下提供与库组件相关的警告或错误消息(而不是通常在Modelica库中特定方程的错误消息)。
这需要适当的工具支持。</span></li>
<li>
<span style=\"color: rgb(36, 41, 47); background-color: rgb(244, 246, 248);\">机械系统的</span><span style=\"color: rgb(36, 41, 47); background-color: rgb(244, 246, 248);\"><strong>逆向模型</strong></span><span style=\"color: rgb(36, 41, 47); background-color: rgb(244, 246, 248);\">
可以通过使用运动生成器轻松定义，例如通过Modelica.Mechanics.Rotational.Position。
还可以生成非标准的逆向模型，例如当存在弹性时，可能需要对方程进行多次微分。</span></li>
</ul></html>"));
end OverView;