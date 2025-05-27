within Modelica.Mechanics.Rotational.UsersGuide;
class Overview "概述"
  extends Modelica.Icons.Information;

  annotation (DocumentationClass=true, Documentation(info="<html><p>
Rotational包主要是提供用于对<strong>一维转动机械</strong>系统建模的组件，包括不同类型的齿轮箱、一维惯性转动组件、外部扭矩、弹簧/阻尼元件、摩擦元件、间隙、用于测量角度、角速度、角加速度和一维平动接口的扭矩。 在子库<strong>Examples</strong>当中提供了几个参考案例用以演示这些组件的使用。 用户只需打开相应的案例模型并根据提供相应的描述来模拟该模型即可。
</p>
<p>
该库的一个特别的特点是<strong>面向组件</strong>对<strong>库仑摩擦</strong>元件的建模，如轴承摩擦、离合器、刹车和齿轮效率。 甚至可以处理（动态）耦合的摩擦元件，例如自动变速箱，可以在不引入刚度的情况下进行处理，从而实现快速仿真。其基础理论是新的，并且基于混合连续/离散方程组的解， 即方程中的<strong>未知数</strong>的类型为<strong>实数</strong>、<strong>整数</strong>或<strong>布尔值</strong>的方程。 只要仿真工具提供了适当的用于解决这种类型系统的数值计算的算法，该库中（动态）耦合的摩擦元件的仿真就是<strong>高效</strong>和<strong>可靠</strong>的。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/UsersGuide/drive1.png\" alt=\"drive1\" data-href=\"\" style=\"\"/>
</p>
<p>
上图是对该库使用的一个简单示例。该驱动轴是由具有一维惯性转动组件的轴<code>J1</code>组成，其一维惯性转动组件为 &nbsp;0.2 kg.m<sup>2</sup>， 通过齿轮传动连接到具有一维惯性转动组件的第二个轴<code>J2</code>，其一维惯性转动组件为 &nbsp;5 kg.m<sup>2</sup>。输入轴通过外部正弦扭矩驱动。 组件左侧和右侧的<strong>填充的</strong>和<strong>非填充的</strong>圆形表示<strong>机械一维转动接口</strong>。 在这些圆形点之间连线意味着相应的一维转动接口<strong>刚性连接</strong>在一起。 按照该库的惯例，被描述为<strong>填充</strong>灰色的连接器在“设计视图”中称为<strong>一维转动接口a</strong>，并放置在组件的左侧； 被描述为<strong>非填充</strong>灰色的连接器在“设计视图”中称为<strong>一维转动接口b</strong>，并放置在组件的右侧。 这两个连接器完全<strong>相同</strong>，唯一的例外是在图形布局上略有不同，以便区分它们，以便更轻松地访问连接器变量。 例如，<code>J1.一维转动接口a.tau</code>是组件<code>J1</code>中连接器<code>一维转动接口a</code>中的力矩。
</p>
<p>
该库的组件可以以<strong>任意</strong>方式<strong>连接</strong>在一起。例如，可以直接将两个弹簧或两个带一维惯性转动组件的轴直接连接在一起，如下图所示。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/UsersGuide/driveConnections1.png\" alt=\"driveConnections1\" data-href=\"\" style=\"\"/><br><img src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/UsersGuide/driveConnections2.png\" alt=\"driveConnections2\" data-href=\"\" style=\"\"/>
</p>
</html>"));

end Overview;