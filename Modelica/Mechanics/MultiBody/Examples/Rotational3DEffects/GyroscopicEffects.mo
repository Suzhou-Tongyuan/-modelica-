within Modelica.Mechanics.MultiBody.Examples.Rotational3DEffects;
model GyroscopicEffects 
  "演示如何用一个一维旋转模型Rotor1D来替代圆柱体部件"
  extends Modelica.Icons.Example;

  inner World world(driveTrainMechanics3D=true) annotation (Placement(
        transformation(extent={{-100,20},{-80,40}})));
  Joints.Spherical spherical1(
    angles_fixed=true, 
    w_rel_a_fixed=true, 
    z_rel_a_fixed=false) annotation (Placement(transformation(extent={{-70,20}, 
            {-50,40}})));
  Parts.BodyCylinder bodyCylinder1(r={0.25,0,0}, diameter=0.05) annotation (
      Placement(transformation(extent={{-40,20},{-20,40}})));
  Parts.FixedRotation fixedRotation1(angle=45, n={0,1,0}) annotation (
      Placement(transformation(extent={{-10,20},{10,40}})));
  Joints.Revolute revolute(
    n={1,0,0}, 
    a(fixed=false), 
    phi(fixed=true), 
    w(fixed=true, start=10)) annotation (Placement(transformation(extent={{20,20},{40,40}})));
  Parts.FixedTranslation fixedTranslation(r={-0.1,0,0}) annotation (Placement(
        transformation(extent={{50,20},{70,40}})));
  Parts.BodyCylinder bodyCylinder2(diameter=0.1, r={0.2,0,0}) annotation (
      Placement(transformation(extent={{80,20},{100,40}})));
  Parts.Fixed fixed annotation (Placement(transformation(extent={{-100,-40},{
            -80,-20}})));
  Joints.Spherical spherical2(
    angles_fixed=true, 
    w_rel_a_fixed=true, 
    z_rel_a_fixed=false) annotation (Placement(transformation(extent={{-70,-40}, 
            {-50,-20}})));
  Parts.BodyCylinder bodyCylinder3(
    r={0.25,0,0}, 
    diameter=0.05, 
    color={0,128,0}) annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Parts.FixedRotation fixedRotation2(n={0,1,0}, angle=45) annotation (
      Placement(transformation(extent={{-10,-40},{10,-20}})));
  Parts.FixedTranslation fixedTranslation1(r={-0.1,0,0}) annotation (
      Placement(transformation(extent={{50,-40},{70,-20}})));
  Parts.BodyCylinder bodyCylinder4(
    diameter=0.1, 
    r={0.2,0,0}, 
    color={0,128,0}) annotation (Placement(transformation(extent={{80,-40},{100,-20}})));
  Parts.Rotor1D rotor1D(
    J=bodyCylinder4.I[1, 1], 
    n={1,0,0}, 
    a(fixed=false), 
    phi(fixed=true), 
    w(fixed=true, start=10)) annotation (Placement(transformation(extent={{20,-40},{40,-60}})));
equation
  connect(world.frame_b, spherical1.frame_a) annotation (Line(
      points={{-80,30},{-70,30}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(spherical1.frame_b, bodyCylinder1.frame_a) annotation (Line(
      points={{-50,30},{-40,30}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(bodyCylinder1.frame_b, fixedRotation1.frame_a) annotation (Line(
      points={{-20,30},{-10,30}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(fixedRotation1.frame_b, revolute.frame_a) annotation (Line(
      points={{10,30},{20,30}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(revolute.frame_b, fixedTranslation.frame_a) annotation (Line(
      points={{40,30},{50,30}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(fixedTranslation.frame_b, bodyCylinder2.frame_a) annotation (Line(
      points={{70,30},{80,30}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(spherical2.frame_b, bodyCylinder3.frame_a) annotation (Line(
      points={{-50,-30},{-40,-30}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(bodyCylinder3.frame_b, fixedRotation2.frame_a) annotation (Line(
      points={{-20,-30},{-10,-30}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(fixed.frame_b, spherical2.frame_a) annotation (Line(
      points={{-80,-30},{-70,-30}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(fixedTranslation1.frame_b, bodyCylinder4.frame_a) annotation (Line(
      points={{70,-30},{80,-30}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(fixedRotation2.frame_b, fixedTranslation1.frame_a) annotation (Line(
      points={{10,-30},{50,-30}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(rotor1D.frame_a, fixedRotation2.frame_b) annotation (Line(
      points={{30,-40},{30,-30},{10,-30}}, 
      color={95,95,95}, 
      thickness=0.5));
  annotation (experiment(StopTime=5, Tolerance=1e-008), Documentation(info="<html>
<p>
这个示例包含一个通过球形关节连接到外界的构件。在这个构件上，存在一个“转子”，即具有旋转对称性的物体。
本示例展示了两种模型：
</p>

<ul>

<li>在图表层的上半部分，仅使用了多体组件。</li> 
<li>在图表层的下半部分，实现了相同的模型，但对圆柱体采用了不同的建模方式： 
圆柱体被包含在内，但它被刚性地连接到了其支架上。这部分考虑了圆柱体的质心运动和惯性张量的变化。
请注意，由于圆柱体具有旋转对称性，其质心和惯性张量不依赖于惯性角，因此可以刚性地连接到其支架上。 
此外，通过使用“MultiBody.Parts.Rotor1D”模型，
还考虑了一个主要的一维惯性，这相当于考虑了当圆柱体相对于其支架移动时产生的附加效应。</li> </ul>

<p>
模拟结果表明，两种模型在动力学运动和对环境的反作用力(分别是“世界”对象和“固定”对象)方面都是相同的。
</p>

<p>
一个典型的使用场景是使用“Mechanics.Rotational”库中的元素来模拟车辆的整个传动系统，包括自动变速箱，但使用“Rotor1D”模型代替“Rotational.Components.Inertia”组件。
这个传动系统模型可以安装到车辆的三维多体模型上。
此外，还需要将一个刚体固定在车辆上，这个刚体具有整个传动系统的质量、质心和惯性张量。
这两个模型组合在一起，产生的效果与使用多体组件单独建模传动系统的每个部分完全相同。
这种建模的一个好处是模拟速度会快得多。
</p>

</html>"));
end GyroscopicEffects;