within Modelica.Mechanics.MultiBody.UsersGuide.Tutorial;
class ConnectionOfLineForces "线性力的连接"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html><p>
线性力元件，例如<a href=\"modelica://Modelica.Mechanics.MultiBody.Forces.Spring\" target=\"\">Spring</a>，通常连接在两个部件之间。
事实上，在大多数多体程序中将弹簧连接在两个构件之间是唯一可能的形式。
在像Modelica这样的基于方程的系统中，更广义的连接是可能的。
特别是，可以将<strong>三维线性力</strong>元件连接在一起，而无需在连接点处具有质量的物体。
这对于系统而言是十分有利的，因为可以避免刚性系统。
例如，由于刚性弹簧和连接点处的小质量点的作用，其详细介绍请参阅<a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.ThreeSprings\" target=\"\">ThreeSprings</a>模型。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/ThreeSprings.png\">
</p>
<p>
在这里，三个弹簧在一个点处连接在一起，而不在弹簧连接点处具有物体。
这种情况有一个困难：在这种情况下，连接点处的方向对象是未定义的，因为弹簧不传递扭矩。
因此，如果以这种方式连接了三个弹簧和一个物体，那么翻译将失败。
为了处理这种情况，所有线性力元件在其“高级”参数菜单中都有“fixedRotationAtFrame_a”和“fixedRotationAtFrame_b”标志。例如，如果“fixedRotationAtFrame_b = <strong>true</strong>”，
则在frame_b处的方向对象将显式设置为零旋转，即，
</p>
<pre><code >frame_b.R = Modelica.Mechanics.MultiBody.Frames.nullRotation();
</code></pre><p>
这意味着三个弹簧的连接点处的坐标系始终与全局坐标系平行。
当选择了此选项时，线性力图标中的相应框架将用红色圆圈标记，并带有文本“R=0”。
下图显示了这种情况，其中为spring3.frame_b选择了此选项：
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/ThreeSpringsDiagramLayer.png\">
</p>
<p>
注意，如果此标志未设置为<strong>true</strong>，将会发生翻译错误。
由于在MultiBody库中使用了超定约束器，因此错误消息将类似于：
</p>
<p>
“超定约束器&lt;...&gt;被连接但没有任何根定义”。
</p>
<p>
两个标志“fixedRotationAtFrame_a”和“fixedRotationAtFrame_b”必须非常谨慎地设置，因为错误的定义可能会导致模型进行仿真，但仿真的结果是错误的。
每当系统的运动取决于任意设置为与全局坐标系平行的方向对象时，就会出现这种情况。
下图显示了一个典型示例：
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/ThreeSprings2DiagramLayer.png\">

</p>
<p>
在这里，spring3.frame_b.R 被定义为与全局坐标系平行。
然而，这也意味着 fixedTranslation.frame_a 的方向也是如此，这反过来又意味着fixedTranslation对象的左部始终与全局坐标系平行。
由于这是不正确的，这个模型将导致<strong>错误的仿真结果</strong>。
这个系统在数学上没有被完整定义，也没有解。
建模这样的系统的唯一方法是为 fixedTranslation 提供质量和惯性张量。
然后，这些标志就不再需要了，因为弹簧的“连接”点是一个物体，其中绝对位置矢量和物体固定坐标系的方向矩阵被用作状态变量。
</p>
</html>"));
end ConnectionOfLineForces;