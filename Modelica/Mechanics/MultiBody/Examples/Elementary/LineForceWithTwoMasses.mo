within Modelica.Mechanics.MultiBody.Examples.Elementary;
model LineForceWithTwoMasses 
  "使用JointUPS和LineForceWithTwoMasses组件演示两个质点的线性力"
  extends Modelica.Icons.Example;
  parameter SI.Mass m = 1 "质点的质量";
  SI.Force rod_f_diff[3] = rod1.frame_b.f - rod3.frame_b.f 
    "rod1和rod3的局部力的差值";
  SI.Force body_f_diff[3] = bodyBox1.frame_b.f - bodyBox2.frame_b.f 
    "bodyBox1和bodyBox2的局部力的差值";

  inner Modelica.Mechanics.MultiBody.World world annotation(Placement(
    transformation(extent = {{-90, -10}, {-70, 10}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute1(phi(fixed = true), w(
    fixed = true)) annotation(Placement(transformation(extent = {{-20, 80}, {0, 100}})));
  Modelica.Mechanics.MultiBody.Parts.BodyBox bodyBox1(r = {0.7, 0, 0}) 
    annotation(Placement(transformation(extent = {{20, 80}, {40, 100}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation rod1(
    r = {0, -0.9, 0}, 
    width = 0.01, 
    animation = false) annotation(Placement(transformation(
    origin = {-40, 50}, 
    extent = {{-10, -10}, {10, 10}}, 
    rotation = 270)));
  Modelica.Mechanics.MultiBody.Joints.Assemblies.JointUPS jointUPS(nAxis_ia = {0.7, 1.2, 0}, animation = 
    true) annotation(Placement(transformation(extent = {{-12, 52}, {12, 28}})));
  Modelica.Mechanics.MultiBody.Parts.Body body1(
    r_CM = 0.2 * jointUPS.eAxis_ia, 
    cylinderDiameter = 0.05, 
    animation = true, 
    m = m, 
    I_11 = 0, 
    I_22 = 0, 
    I_33 = 0) annotation(Placement(transformation(extent = {{-20, 18}, {-40, 38}})));
  Modelica.Mechanics.MultiBody.Parts.Body body2(
    r_CM = -0.2 * jointUPS.eAxis_ia, 
    cylinderDiameter = 0.05, 
    animation = true, 
    m = m, 
    I_11 = 0, 
    I_22 = 0, 
    I_33 = 0) annotation(Placement(transformation(extent = {{20, 18}, {40, 38}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation rod2(
    r = {0, 0.3, 0}, 
    width = 0.01, 
    animation = false) annotation(Placement(transformation(
    origin = {-40, 80}, 
    extent = {{10, -10}, {-10, 10}}, 
    rotation = 270)));
  Modelica.Mechanics.Translational.Components.Damper damper1(
    d = 3) 
    annotation(Placement(transformation(extent = {{-10, 20}, {10, 0}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute2(phi(fixed = true), w(
    fixed = true)) annotation(Placement(transformation(extent = {{-20, -30}, {0, -10}})));
  Modelica.Mechanics.MultiBody.Parts.BodyBox bodyBox2(r = {0.7, 0, 0}) 
    annotation(Placement(transformation(extent = {{20, -30}, {40, -10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation rod3(
    width = 0.01, 
    r = {0, -0.9, 0.3}, 
    animation = false) annotation(Placement(transformation(
    origin = {-40, -70}, 
    extent = {{-10, -10}, {10, 10}}, 
    rotation = 270)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation rod4(
    width = 0.01, 
    r = {0, 0.3, 0.3}, 
    animation = false) annotation(Placement(transformation(
    origin = {-40, -30}, 
    extent = {{10, -10}, {-10, 10}}, 
    rotation = 270)));
  Modelica.Mechanics.Translational.Components.Damper damper2(
    d = 3) 
    annotation(Placement(transformation(extent = {{-10, -64}, {10, -44}})));
  Modelica.Mechanics.MultiBody.Forces.LineForceWithTwoMasses 
    lineForceWithTwoMasses(
    L_a = 0.2, 
    L_b = 0.2, 
    cylinderLength_a = 0.2, 
    cylinderLength_b = 1.2, 
    massDiameterFaction = 2.2, 
    m_a = m, 
    m_b = m) annotation(Placement(transformation(extent = {{-10, -90}, {10, -70}})));
equation
  connect(jointUPS.bearing, damper1.flange_a) 
    annotation(Line(points = {{-4.8, 28}, {-4.8, 20}, {-10, 20}, {-10, 10}}, 
    color = {0, 127, 0}));
  connect(jointUPS.axis, damper1.flange_b) 
    annotation(Line(points = {{4.8, 28}, {4.8, 20}, {10, 20}, {10, 10}}, 
    color = {0, 127, 0}));
  connect(jointUPS.frame_ib, body2.frame_a) 
    annotation(Line(
    points = {{9.6, 28}, {20, 28}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(world.frame_b, rod2.frame_a) annotation(Line(
    points = {{-70, 0}, {-60, 0}, {-60, 64}, {-40, 64}, {-40, 70}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(world.frame_b, rod1.frame_a) annotation(Line(
    points = {{-70, 0}, {-60, 0}, {-60, 64}, {-40, 64}, {-40, 60}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(rod2.frame_b, revolute1.frame_a) annotation(Line(
    points = {{-40, 90}, {-20, 90}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(revolute1.frame_b, bodyBox1.frame_a) 
    annotation(Line(
    points = {{0, 90}, {20, 90}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(bodyBox1.frame_b, jointUPS.frame_b) annotation(Line(
    points = {{40, 90}, {50, 90}, {50, 40}, {12, 40}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(body1.frame_a, jointUPS.frame_ia) 
    annotation(Line(
    points = {{-20, 28}, {-9.6, 28}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(rod1.frame_b, jointUPS.frame_a) annotation(Line(
    points = {{-40, 40}, {-12, 40}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(rod4.frame_b, revolute2.frame_a) annotation(Line(
    points = {{-40, -20}, {-20, -20}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(revolute2.frame_b, bodyBox2.frame_a) 
    annotation(Line(
    points = {{0, -20}, {20, -20}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(world.frame_b, rod4.frame_a) annotation(Line(
    points = {{-70, 0}, {-60, 0}, {-60, -50}, {-40, -50}, {-40, -40}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(rod3.frame_a, rod4.frame_a) 
    annotation(Line(
    points = {{-40, -60}, {-40, -40}}, 
    thickness = 0.5));
  connect(lineForceWithTwoMasses.frame_a, rod3.frame_b) annotation(Line(
    points = {{-10, -80}, {-40, -80}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(lineForceWithTwoMasses.frame_b, bodyBox2.frame_b) annotation(Line(
    points = {{10, -80}, {50, -80}, {50, -20}, {40, -20}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(lineForceWithTwoMasses.flange_b, damper2.flange_b) 
    annotation(Line(points = {{6, -69}, {10, -69}, {10, -54}}, color = {0, 127, 0}));
  connect(lineForceWithTwoMasses.flange_a, damper2.flange_a) 
    annotation(Line(points = {{-6, -69}, {-10, -69}, {-10, -54}}, 
    color = {0, 127, 0}));
  annotation(
    experiment(StopTime = 3), 
    Documentation(info = "<html><p>
演示了如何实现具有质量属性的线性力组件。给出了两种替代实现方法：
</p>
<ul><li>
使用<a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Assemblies.JointUPS\" target=\"\">JointUPS</a>:<br>Modelica.Mechanics.MultiBody.Joints.Assemblies.JointUPS是一个通用、平移和球形关节的聚合体，
它近似于一个真实的力组件，如液压缸。在平移关节的两个坐标系(jointUPS的frame_ia、frame_ib)处连接了两个物体。
选择参数使得两个物体的质心位于连接jointUPS组件的frame_a和frame_b的线上。
两个物体具有相同的质量，并且惯性张量设置为零，即两个物体被视为点质量。
</li>
<li>
使用<a href=\"modelica://Modelica.Mechanics.MultiBody.Forces.LineForceWithTwoMasses\" target=\"\">LineForceWithTwoMasses</a>:<br> Modelica.Mechanics.MultiBody.Forces.LineForceWithTwoMasses是一个具有内置属性的线性力组件，两个点质量位于线性力作用的线上。
选择参数的方式描述了与jointUPS组件相同的系统。</li>
</ul><p>
在两种情况下，都使用了Modelica.Mechanics.Translational库中的线性一维传递阻尼器作为两个附着点之间的线性力。
模拟此系统并绘制线性力组件两侧的局部力之间的差异(\"rod_f_diff\"和\"body_f_diff\")。
这两个矢量应该为零(取决于积分的选择的相对容差，差异在1e-10到1e-15的数量级)。
</p>
<p>
注意，使用LineForceWithTwoMasses组件的实现更简单、更方便。
此模拟的动画如下图所示。
左前方的系统是使用LineForceWithTwoMasses组件的动画，而右后方的系统是使用JointUPS的动画。
</p>
<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/LineForceWithTwoMasses2.png\">
</blockquote>
</html>"));
end LineForceWithTwoMasses;