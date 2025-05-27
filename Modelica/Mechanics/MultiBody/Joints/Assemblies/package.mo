within Modelica.Mechanics.MultiBody.Joints;
package Assemblies "组件，汇集了几个用于解析回路处理的运动副"
  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>
该包中的运动副主要设计用于在<strong>运动学回路</strong>结构中使用。
每个组件由<strong>3个基本运动副</strong>组成。
这些运动副被组合在一起，以使frame_a和frame_b之间的3个运动副的运动从frame_a和frame_b的运动中计算出来，即，frame_a和frame_b之间<strong>没有约束</strong>。
这需要解决一个<strong>非线性方程组</strong>，并以<strong>解析方式</strong>执行(即，当存在数学解时，会高效可靠地计算出来)。
如何使用这些运动副的详细说明在<a href=\"modelica://Modelica.Mechanics.MultiBody.UsersGuide.Tutorial.LoopStructures.AnalyticLoopHandling\">MultiBody.UsersGuide.Tutorial.LoopStructures.AnalyticLoopHandling</a>中提供。
</p>
<p>
该包中的组装运动副命名为<strong>JointXYZ</strong>，其中<strong>XYZ</strong>是组件中使用的基本运动副的首字母，特别是：</p>
<table border=\"1\"cellspacing=\"0\"cellpadding=\"2\">
<tr><td><strong>P</strong></td><td>平动副</td></tr>
<tr><td><strong>R</strong></td><td>转动副</td></tr>
<tr><td><strong>S</strong></td><td>球面运动副</td></tr>
<tr><td><strong>U</strong></td><td>万向运动副</td></tr>
</table>
<p>
例如，JointUSR是一个组装运动副，包括一个万向运动副、一个球面运动副和一个转动副。
</p>
<p>
该包包含以下模型：</p>
<h4>内容</h4>
<table border=\"1\"cellspacing=\"0\"cellpadding=\"2\">
<tr><th><strong><em>模型</em></strong></th><th><strong><em>描述</em></strong></th></tr>
<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Assemblies.JointUPS\">JointUPS</a></td>
<td>万向-平动-球面运动副组合<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Assemblies/JointUPS.png\">
</td>
</tr>
<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Assemblies.JointUSR\">JointUSR</a></td>
<td>万向-球面-转动副组合<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Assemblies/JointUSR.png\">
</td>
</tr>
<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Assemblies.JointUSP\">JointUSP</a></td>
<td>万向-球面-平动副组合<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Assemblies/JointUSP.png\">
</td>
</tr>

<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Assemblies.JointSSR\">JointSSR</a></td>
<td>球面-球面-转动副组合，连接两个球面运动副的杆上可选的质量点<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Assemblies/JointSSR.png\">
</td>
</tr>
<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Assemblies.JointSSP\">JointSSP</a></td>
<td>球面-球面-移动运动副组合，连接两个球面运动副的杆上可选的质量点<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Assemblies/JointSSP.png\">
</td>
</tr>
<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Assemblies.JointRRR\">JointRRR</a></td>
<td>旋转-旋转-转动副组合，用于平面回路<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Assemblies/JointRRR.png\">
</td>
</tr>
<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Assemblies.JointRRP\">JointRRP</a></td>
<td>旋转-旋转-移动运动副组合，用于平面回路<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Assemblies/JointRRP.png\">
</td>
</tr>
</table>
<p>
注意，此包中的任何组件均没有势状态，因为这些组件的设计方式是从frame_a和frame_b坐标计算出所使用的基本运动副的广义坐标。
尽管如此，仍然可以在树形结构中使用这些组件。
在这种情况下，状态是从连接到组件的frame_a或frame_b侧的主体中选择的。
在大多数情况下，这会导致效率较低的解决方案，就像直接使用Modelica.Mechanics.MultiBody.Joints包中的基本运动副一样。
</p>
<p>
通过使用此包提供的具有6自由度的运动副组合来解析运动学回路，是一种<strong>新的</strong>方法。
它基于Woernle和Hiller开发的解决非线性运动学回路方程的更一般的方法。
自动应用这种更一般的方法很困难，手动应用只适用于这个领域的专家。
这里介绍的方法是一种折衷：它可以由最终用户相对容易地应用，但适用于较小类别的运动学回路。
Woernle和Hiller的“特征运动副对”方法的描述在以下文献中：</p>

```html
<dl>
<dt>WoernleC.:</dt>
<dd><strong>一个系统化的方法用于建立运动学闭环中的几何约束条件，应用于工业机器人的逆向变换。
</strong><br>
VDI技术报告，第18卷，第59号，杜塞尔多夫：VDI出版社，1988年，ISBN3-18-145918-6。
<br>&nbsp;</dd>
<dt>HillerM.,andWoernleC.:</dt>
<dd><strong>解决机器人操作器逆运动学问题的系统方法。
</strong><br>
第7届世界机械学和机械工程大会论文集，1987年，塞维利亚。
</dd>
</dl>
```
</html>"));
end Assemblies;