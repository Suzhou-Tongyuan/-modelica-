within Modelica.Mechanics.Translational.UsersGuide;
class UserDefinedComponents "用户自定义的组件"
  extends Modelica.Icons.Information;

  annotation (
    DocumentationClass=true, 
    Documentation(info="<html><p>
本节提供了一些文字解释，以定义与此包中元素兼容的自定义一维传动组件。 通过从以下基类之一继承来定义一个新组件会很便捷，这些基类定义在子库 <a href=\"modelica://Modelica.Mechanics.Translational.Interfaces\" target=\"\">Interfaces</a>中：
</p>
<table style=\"width: auto;\"><tbody><tr><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Name</th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Description</th></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialCompliant\" target=\"\">PartialCompliant</a></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 两个传动一维平动接口的弹性连接（用于诸如弹簧或减震器的力律）。<br></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialCompliantWithRelativeStates\" target=\"\">PartialCompliantWithRelativeStates</a></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 与“PartialCompliant”相同，但相对位置和相对速度被定义为首选状态。如果需要相对速度，则使用此部分模型。其优点是通常更好地使用驱动组件之间的相对位置作为状态，特别是如果位置不受限制。<br></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialElementaryTwoFlangesAndSupport2\" target=\"\">PartialElementaryTwoFlangesAndSupport2</a></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 输入轴的一维平动接口、输出轴的一维平动接口和支撑构成的一维传动组件的部分模型。<br></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialForce\" target=\"\">PartialForce</a></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 作用在一维平动接口上的外部力的部分模型（加速一维平动接口）。<br></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialTwoFlanges\" target=\"\">PartialTwoFlanges</a></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 两个传动一维平动接口的一般连接。<br></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialAbsoluteSensor\" target=\"\">PartialAbsoluteSensor</a></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 测量绝对一维平动接口变量。<br></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialRelativeSensor\" target=\"\">PartialRelativeSensor</a></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 测量相对一维平动接口变量。<br></td></tr></tbody></table><p>
这些基类之间的差异在于模型中定义的辅助变量和已在基类中定义的一维平动接口变量之间的关系。例如，在模型<strong>PartialCompliant</strong>中没有 支撑一维平动接口，而在模型<strong>PartialElementaryTwoFlangesAndSupport2</strong>中有支撑一维平动接口。
</p>
<p>
机械组件的方程是矢量方程，因此它们需要在一个共同的坐标系中表示。因此，必须为组件定义一个<strong>本地运动轴</strong>。所有矢量，例如切割力或速度，都必须根据此定义进行表达。 以下是质量组件的示例：
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/UsersGuide/driveAxis.png\" alt=\"driveAxis\" data-href=\"\" style=\"\"/>
</p>
<p>
可以看到，所有矢量都指向运动轴的方向。一维平动接口中的位置相应地定义。
</p>
<p>
乍看之下，可能会认为所选的本地坐标系会影响组件的使用。但实际上不是这样的，如下图所示：
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/UsersGuide/masses.png\" alt=\"masses\" data-href=\"\" style=\"\"/>
</p>
<p>
图中显示了组件的<strong>本地</strong>平移轴。图中左侧和右侧的两个质量的连接是完全等效的，即右侧部分只是左侧部分的不同绘制。这是因为通过连接，两个本地坐标系被使相同，并且（自动生成的）连接方程（=位置相同，切割力相加为零）也在此公共坐标系中表示。因此，即使在左图中，<code>mass2</code>的速度矢量似乎是从右到左的，实际上它是从左到右的，如右图所示，其中本地坐标系被绘制为对齐。请注意，根据第<a href=\"modelica://Modelica.Mechanics.Translational.UsersGuide.SignConventions\" target=\"\">Sign conventions</a>节中所述的简单规则也决定了图中左侧<code>mass2</code>的速度是从左到右的。
</p>
<p>
总之，选择为组件选定的本地坐标系仅仅是为了确保该组件的方程被正确表达。坐标系的选择是任意的，并且不会影响组件的使用。特别是，例如切割力的实际方向最容易通过第<a href=\"modelica://Modelica.Mechanics.Translational.UsersGuide.SignConventions\" target=\"\">Sign conventions</a>节中的规则确定。通过对齐坐标系然后使用本地坐标系的矢量方向来更严格地确定，通常需要重新绘制图表，因此使用起来不太方便。
</p>
<p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"));

end UserDefinedComponents;