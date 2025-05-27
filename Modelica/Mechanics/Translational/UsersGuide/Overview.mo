within Modelica.Mechanics.Translational.UsersGuide;
class Overview "概述"
  extends Modelica.Icons.Information;

  annotation (
    DocumentationClass=true, 
    Documentation(info="<html>

<p>
这个包中包含了用于对<strong>一维平动机械系统</strong>建模的组件，包括不同类型的质量块、外部力、弹簧/阻尼元件、摩擦元件、弹性间隙、用于测量位置、速度、加速度或一维平动接口剪切力的元素。
在子库<strong><a href=\"modelica://Modelica.Mechanics.Translational.Examples\">Examples</a></strong>中，有几个示例来演示组件的使用方法。只需打开相应的示例模型并按照提供的说明进行仿真模拟即可。
</p>
<p>
这个库的一个独特特点是对<strong>库仑摩擦</strong>元素（如支撑摩擦）进行<strong>面向组件</strong>的建模。即使（动态地）耦合摩擦元素也可以<strong>无需</strong>引入刚度来处理，这样可进行快速模拟。其基本理论是基于混合连续/离散方程的解决方案，即方程的<strong>未知数</strong>是 <strong>实数</strong>、<strong>整数</strong>或<strong>布尔值</strong>类型。
只要模拟工具提供了适当的数值算法来解决这种类型的系统，这个库的（动态地）耦合摩擦元素的模拟就是<strong>高效</strong>且<strong>可靠</strong>的。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/UsersGuide/drive1.png\" alt=\"drive1\">
</div>

<p>
上图是使用这个库的一个简单示例。这个模型由一个质量为 <var>m</var> = 1 kg 的 <code>mass1</code> 和一个通过弹簧连接的质量为 <var>m</var>5kg的 <code>mass2</code> 组成。
左侧的质量块受到外部的正弦力驱动。在组件的左侧和右侧分别用<strong>填充的绿色正方形</strong>和<strong>非填充的绿色正方形</strong>表示<strong>机械一维平动接口</strong>。
在这样的正方形之间画一条线意味着对应的一维平动接口<strong>刚性连接</strong>在一起。根据这个库中的约定，被描述为<strong>填充的</strong>绿色正方形的连接器称为<strong>一维平动接口_a</strong>，
并且在“设计视图”中位于组件的左侧，而被描述为<strong>非填充的</strong>绿色正方形的连接器称为<strong>一维平动接口_b</strong>，并且在“设计视图”中位于组件的右侧。
这两个连接器完全<strong>相同</strong>，唯一的区别是在图形布局上稍有不同，以便更容易访问连接器变量。
例如，<code>mass1.flange_a.f</code> 是组件 <code>mass1</code> 的连接器 <code>flange_a</code> 上的局部力。
</p>
<p>
这个库的组件可以以<strong>任意</strong>的方式<strong>连接</strong>在一起。例如，可以直接将两个弹簧或两个带惯性的轴连接在一起，如下图所示。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/UsersGuide/driveConnections1.png\" alt=\"driveConnections1\"><br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/UsersGuide/driveConnections2.png\" alt=\"driveConnections2\"><br>
</div>
</html>"));

end Overview;