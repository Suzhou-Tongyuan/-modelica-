within Modelica.Mechanics.Rotational.UsersGuide;
class UserDefinedComponents "用户自定义的组件"
  extends Modelica.Icons.Information;

  annotation (DocumentationClass=true, Documentation(info="<html><p>
在这个部分中，给出了一些部件，来定义与该包的元素兼容的自定义一维旋转组件。 通过从以下基类之一中继承定义一个新的组件是方便的， 这些基类定义在子库接口中： <a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces\" target=\"\">Interfaces</a>:
</p>
<table style=\"width: auto;\"><tbody><tr><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">名称</th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">描述</th></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialCompliant\" target=\"\">PartialCompliant</a></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 两个旋转的一维转动接口的顺从连接<br>(用于力学定律，如弹簧或阻尼器)。<br></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialCompliantWithRelativeStates\" target=\"\">PartialCompliantWithRelativeStates</a></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 与\"PartialCompliant\"相同，但相对角度和相对速度是定义为首选状态。如果力学定律需要相对速度，使用这个基类模型的优点是可以更好地使用驱动传动组件之间的相对角度作为状态，特别是如果角度不受限制 (例如，对于车辆中的驱动传动)。<br></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialElementaryTwoFlangesAndSupport2\" target=\"\">PartialElementaryTwoFlangesAndSupport2</a></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 由输入轴的一维转动接口、输出轴一维转动接口和支撑组成的一维旋转齿轮的部分模型。<br></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialTorque\" target=\"\">PartialTorque</a></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 作用于一维转动接口的扭矩的部分模型 (加速一维转动接口)。<br></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlanges\" target=\"\">PartialTwoFlanges</a></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 两个旋转一维转动接口的一般连接。<br></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialAbsoluteSensor\" target=\"\">PartialAbsoluteSensor</a></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 测量绝对一维转动接口变量。<br></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialRelativeSensor\" target=\"\">PartialRelativeSensor</a></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 测量相对一维转动接口变量。<br></td></tr></tbody></table><p>
这些基类之间的区别在于模型中定义的辅助变量以及已在基类中定义的一维转动接口变量之间的关系。 例如，在模型<strong>PartialCompliant</strong>中，没有支撑一维转动接口，而在模型 <strong>PartialElementaryTwoFlangesAndSupport2</strong>中有一个支撑一维转动接口。
</p>
<p>
机械组件的方程是矢量方程，即它们需要在一个公共坐标系中表示。 因此，对于一个组件，必须定义一个<strong>本地旋转轴</strong>。所有矢量，例如切向力矩或角速度， 都必须根据这个定义来表示。 以下示例给出了一个一维转动惯性组件组件和一个行星齿轮箱的定义：
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/UsersGuide/driveAxis.png\" alt=\"driveAxis\" data-href=\"\" style=\"\"/>
</p>
<p>
可以看到，所有矢量都指向旋转轴的方向。一维转动接口中的角度相应地定义。 例如，行星齿轮箱中太阳轮一维转动接口的角度<code>sun.phi</code>是正的， 如果沿着旋转轴的数学正方向（逆时针）旋转，则为正。
</p>
<p>
粗略的看，可能会认为所选的本地坐标系会影响组件的使用。 但事实并非如此，正如下图所示：
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/UsersGuide/inertias.png\" alt=\"inertias\" data-href=\"\" style=\"\"/>
</p>
<p>
图中显示了组件的<strong>本地</strong>旋转轴。左图和右图部分中两个一维转动惯性组件的连接完全等效，即，右图只是左图的不同绘制方式。 这是由于通过连接，两个本地坐标系被弄成了相同，并且自动生成的连接方程（= 角度相同，力矩相互抵消）也是根据这个公共坐标系来表示的。 因此，即使在左图中，<code>J2</code>的角速度矢量似乎是从右向左的， 实际上它是从左向右的，如右图所示，其中本地坐标系被绘制成对齐的。 请注意，在左图中，<code>J2</code>的角速度是从左向右的，这符合 <a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.SignConventions\" target=\"\">符号约定</a> 中的简单规则。
</p>
<p>
总之，为一个组件选择本地坐标系只是为了确保这个组件的方程正确表示。 坐标系的选择是任意的，不影响组件的使用。 尤其是，例如，切向力矩的实际方向最容易由 <a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.SignConventions\" target=\"\">符号约定</a> 的规则确定。 通过对齐坐标系然后使用本地坐标系的矢量方向更严格地确定，但通常需要重新绘制图表，因此使用起来不太方便。
</p>
<p>
<br>
</p>
</html>"));

end UserDefinedComponents;