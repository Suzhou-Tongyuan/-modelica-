within Modelica.Mechanics.Translational.UsersGuide;
class SignConventions "符号约定"
  extends Modelica.Icons.Information;

  annotation (
    DocumentationClass=true, 
    Documentation(info="<html>

<p>
可以像访问常规变量一样访问此库中组件的变量。然而，由于大多数这些变量基本上是<strong>向量</strong>的元素，即具有方向，因此会出现如何解释变量符号的问题。
其基本思想如下图所示：
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/UsersGuide/drive2.png\" alt=\"drive2\">
</div>

<p>
首先，必须定义此线的<strong>正向</strong>，称为<strong>运动轴</strong>。在图的顶部，这由一个箭头和相应的文本标识。现在的简单规则是：
如果组件的某个变量为正，并且可以解释为向量的元素（例如，力或速度向量），则相应的向量将指向运动轴的正方向。在下图中，根据此规则，将显示上图中最右侧的质量块的正向矢量方向：
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/UsersGuide/drive3.png\" alt=\"drive3\">
</div>
<p>
如果值为正，右侧质量的局部力<code>mass2.flange_a.f</code>将指向运动方向。类似地，如果值为正，则右侧质量块的速度<code>mass2.v</code>也将指向运动方向
</p>
</html>"));

end SignConventions;