within Modelica.Mechanics.MultiBody.UsersGuide.Tutorial;
class FirstExample "第一个例子"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html><p>
<span style=\"color: rgb(36, 41, 47); background-color: rgb(244, 246, 248);\">
作为第一个示例，将演示如何构建、模拟和动画演示一个简单的
</span><span style=\"color: rgb(36, 41, 47);
background-color: rgb(244, 246, 248);\">
<strong>单摆模型</strong>
</span><span style=\"color: rgb(36, 41, 47); 
background-color: rgb(244, 246, 248);\">。
</span>
</p>
<p>
首先建立一个由<strong>构件</strong>和带有<strong>线性阻尼</strong>的<strong>旋转</strong>关节组成的简单单摆，作为Modelica组合图，其结果如下图所示：
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/PendulumSchematic1.png\"
alt=\"Modelica composition diagram of simple pendulum\">
</p>
<p>
在下图中显示了使用的模型组件的位置。将这些组件拖放到图表层，并根据图示连接它们：
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/PendulumSchematic2.png\">
</p>
<p>
<span style=\"color: rgb(36, 41, 47); background-color: rgb(244, 246, 248);\">
使用MultiBody库中的模型组件的每个模型必须在最高级别上具有Modelica.Mechanics.MultiBody.World模型的实例。
原因是在World对象中定义了重力场(均匀重力或点重力)，以及动画形状的默认大小，并将此信息发送给所有使用的组件。
如果World对象丢失，将输出警告消息，并自动使用具有默认设置的世界对象的实例(此功能使用注释定义)。
</span>
</p>
<p>
在第二步中，需要定义拖动组件的参数。一些参数是矢量，必须相对于相应组件的局部坐标系定义。
执行此操作的最简单方法是定义多体模型的
<strong>参考配置</strong>
：在此配置中，所有关节的相对坐标都为零。
这意味着所有组件上的所有坐标系彼此平行。
因此，在此配置中，所有矢量都是相对于世界坐标系解析的。
</p>
<p>
简单单摆的参考配置应以以下方式定义：
世界坐标系的y轴向上，即重力加速度的相反方向。
世界坐标系的x轴与其正交。
旋转关节位于世界坐标系的原点处。
旋转关节的旋转轴沿着世界坐标系的z轴方向。
构件位于世界坐标系的x轴上(即，当主体位于x轴上时，旋转关节的旋转角为零)。
在以下图表中，显示了旋转关节和构件参数菜单中对此参考配置的定义：
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/ActuatedRevoluteParameters.png\">
<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/BodyParameters.png\">
</div>

<p>
翻译并模拟该模型。所有定义的组件将自动使用默认的绝对或相对大小在动画中可视化。
例如，一个体被可视化为一个球体和一个圆柱体。球体的默认大小在world对象中定义为参数。
您可以在主体的“动画”参数菜单中更改此大小(参见上面的参数菜单)。
圆柱体的默认大小相对于球体的大小定义(球体大小的一半)。
使用默认设置，定义以下动画：
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/Pendulum.png\">
</div>

<p>
世界坐标系以带有轴标签的坐标轴形式可视化。
重力加速度矢量的方向显示为绿色箭头。
红色圆柱体代表旋转关节的旋转轴，浅蓝色形状代表构件。构件的质心位于浅蓝色球体的中心。
</p>
</html>"));
end FirstExample;