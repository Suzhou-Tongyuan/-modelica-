within Modelica.Mechanics.Rotational.UsersGuide;
class RequirementsForSimulationTool "仿真工具的要求"
  extends Modelica.Icons.Information;

  annotation (DocumentationClass=true, Documentation(info="<html><p>
这个库是完全以面向对象的方式设计的，以便组件可以以有意义的组合方式连接在一起 （例如，直接连接两个弹簧或两个一维惯性转动组件）。
因此，大多数模型都导致微分代数方程组（DAE）的<strong>3阶</strong>（=约束方程必须进行两次微分才能得到 状态空间表示），Modelica翻译器或模拟器必须处理这种系统表示。 
根据我们目前的知识，这要求Modelica翻译器能够解决符号化的微分方程 （否则，例如，无法提供一致的初始 条件；即使存在一致的初始条件，大多数 数值DAE积分器最多只能处理2阶DAE）。
</p>
<p>
该库的元素可以以任意方式连接在一起。 然而，如果连接了可以<strong>锁定</strong>两个一维转动接口之间的<strong>相对运动</strong>的元素 <strong>刚性地</strong>连接在一起，可能会出现困难， 因为基本上可以锁定<strong>相同的相对运动</strong>。 原因是如果在同一时刻锁定元素（即，不存在一个唯一的解），则锁定阶段的扭矩不是唯一定义的 （存在奇异性），一些仿真系统可能不能够处理这种情况，因为这会导致模拟期间的奇异性。 目前，当元素被卡住时，这种类型的问题可能会出现。例如库仑摩擦元件， <strong>BearingFriction</strong>，<strong>Clutch</strong>，<strong>Brake</strong>或<strong>LossyGear</strong>：
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/UsersGuide/driveConnections3.png\" alt=\"driveConnections3\" data-href=\"\" style=\"\"/>
</p>
<p>
上图显示了两种典型情况：在图的上半部分， 显示了刚性连接的串联<strong>bearingFriction1</strong>和 <strong>clutch</strong>组件。这没有问题，因为<strong>bearingFriction1</strong> 元件可以锁定元素与壳体之间的相对运动（<strong>fixed1</strong>），而离合器元素可以锁定两个之间的相对运动连接的一维转动接口。相反，图的下半部分的传动系统 可能会引起模拟问题，因为<strong>bearingFriction2</strong>元件 和<strong>brake</strong>元件可以锁定一维转动接口之间的相对运动和这些一维转动接口刚性地连接在一起，即， 基本上可以锁定相同的相对运动。这些困难可以通过在这些一维转动接口之间引入柔度来解决，或者通过将轴承摩擦和制动元素组合成一个组件并解决该组件在卡住模式下的摩擦力矩的歧义。仿真工具也可以自动处理这种情况，通过选择无穷多个解的一个，例如，在其中与前一个的值的差异尽可能小。
</p>
</html>"));

end RequirementsForSimulationTool;