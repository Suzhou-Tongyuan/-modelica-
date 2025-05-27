within Modelica.Mechanics.Rotational.UsersGuide;
class SignConventions "符号约定"
  extends Modelica.Icons.Information;

  annotation (DocumentationClass=true, Documentation(info="<html>

<p>
该库中组件的变量可以以常规的方式访问。然而，由于这些变量大多基本上是<strong>矢量</strong>元素，即具有方向，所以问题是如何解释变量的符号。
其基本思想是通过以下图示说明的：
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/UsersGuide/drive2.png\" alt=\"drive2\">
</div>

<p>
在图中，显示了三个相同的传动系统。
唯一的区别是，中间传动系统的齿轮与上方和下方传动系统的齿轮相比发生了水平翻转（即中间系统齿轮的传动比为其它两齿轮传动比的倒数）
现在变量的符号被解释如下：
由于模型的一维性质，所有组件基本上沿着一条线连接在一起（更复杂的情况将在下文讨论）。
首先，必须定义该线的<strong>正方向</strong>，称为<strong>旋转轴</strong>。
在图的顶部所示，该旋转轴这通过一个箭头和相应的文本来描述。
</P>
<p>
现在对旋转轴的简单的定义如下：
<br>
如果组件的变量是正的，并且是作为矢量存在的元素（例如，扭矩或角速度向量），则相应的矢量将指向旋转轴的正方向。
在下图中，根据此定义表示了图上最右边的惯性：
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/UsersGuide/drive3.png\" alt=\"drive3\">
</div>
<p>
右侧一维惯性转动组件的力矩 <code>J2.flange_a.tau</code>，<code>J4.flange_a.tau</code> 和 <code>J6.flange_b.tau</code>
如果值为正，则全部相同，并且指向旋转方向也同样相同
右侧以为惯性转动组件的角速度 <code>J2.w</code>，<code>J4.w</code> 和 <code>J6.w</code>
如果值为正，则全部相同，并且也指向旋转方向。
<br>
下图显示了一些特殊情况：
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/UsersGuide/drive4.png\" alt=\"drive4\">
</div>

<p>
图的上半部分显示了外部扭矩与一维惯性转动组件连接的两种变体。在两种情况下，输入到扭矩组件的正信号将加速一维惯性转动组件
<code>inertia1</code> 和 <code>inertia2</code> 到正的旋转轴，即角加速度 <code>inertia1.a</code> 和 <code>inertia2.a</code>
都是正的，并沿着“旋转轴”箭头方向。
<br>
在图的下半部分显示了一维惯性转动组件与行星齿轮的连接。注意，行星齿轮箱的三个一维转动接口位于旋转轴沿线，并且轴方向确定了这些一维转动接口沿着的正旋转。
因此，对于 <code>inertia4</code> 和 <code>inertia6</code>，正旋转如附加的黑色箭头所示。
</p>
</html>"));

end SignConventions;