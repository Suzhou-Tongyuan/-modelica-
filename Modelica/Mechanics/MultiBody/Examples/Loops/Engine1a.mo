within Modelica.Mechanics.MultiBody.Examples.Loops;
model Engine1a "一个气缸发动机的模型"
  extends Modelica.Icons.Example;
  extends Utilities.Engine1Base;
  Modelica.Mechanics.MultiBody.Joints.Revolute b1(
    n = {1, 0, 0}, 
    cylinderLength = 0.02, 
    cylinderDiameter = 0.05) 
    annotation(Placement(transformation(extent = {{40, -10}, {60, 10}})));
  Joints.RevolutePlanarLoopConstraint b2(
    n = {1, 0, 0}, 
    cylinderLength = 0.02, 
    cylinderDiameter = 0.05) annotation(Placement(transformation(extent = {{40, -30}, {60, -50}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic cylinder(
    boxWidth = 0.02, 
    n = {0, -1, 0}, 
    s(start = 0.15)) annotation(Placement(transformation(
    origin = {50, 80}, 
    extent = {{-10, -10}, {10, 10}}, 
    rotation = 270)));
equation
  connect(cylPosition.frame_b, cylinder.frame_a) annotation(Line(
    points = {{-70, 50}, {-70, 94}, {50, 94}, {50, 90}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(b2.frame_a, mid.frame_b) annotation(Line(
    points = {{40, -40}, {30, -40}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(b2.frame_b, connectingRod.frame_b) annotation(Line(
    points = {{60, -40}, {90, -40}, {90, -30}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(connectingRod.frame_a, b1.frame_b) annotation(Line(
    points = {{90, -10}, {90, 0}, {60, 0}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(b1.frame_a, piston.frame_b) annotation(Line(
    points = {{40, 0}, {30, 0}, {30, 20}, {90, 20}, {90, 30}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(cylinder.frame_b, piston.frame_a) annotation(Line(
    points = {{50, 70}, {50, 60}, {90, 60}, {90, 50}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  annotation(experiment(StopTime = 5), Documentation(info = "<html>
<p>
这是一个单缸发动机机械部分的模型。燃烧过程未进行建模。
左下角的\"转动惯量\"组件是驱动变速箱的发动机输出转动惯量。
为了展示发动机的运动，输出转动惯量的角速度初始值为10 rad/s。
</p>
<p>
该发动机仅通过旋转关节和移动关节进行建模。
由于这会产生一个<strong>平面</strong>循环，因此存在一个非常普遍的困难，
即垂直于循环的局部力以及平面内的局部扭矩无法唯一计算。
通过在每个平面循环中的一个旋转关节的\"<strong>高级</strong>\"菜单中使用<strong>planarCutJoint</strong>选项（此处为关节b1）来解决这种歧义。
该选项将此关节上沿旋转轴方向的局部力以及垂直于旋转轴的局部扭矩设置为零，从而使问题在数学上得到良好定义。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/Engine.png\" alt=\"model Examples.Loops.Engine\" data-href=\"\" style=\"width: 237.97px;height: 242.22px;\"/>
</p>
</html>"));
end Engine1a;