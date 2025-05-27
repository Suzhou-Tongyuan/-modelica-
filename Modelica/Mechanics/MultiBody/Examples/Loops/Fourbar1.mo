within Modelica.Mechanics.MultiBody.Examples.Loops;
model Fourbar1 
  "一个包含四根杆件的运动环(仅包含转动副；5个非线性方程)"
  extends Modelica.Icons.Example;

  output SI.Angle j1_phi "旋转接头j1的角度";
  output SI.Position j2_s "平移副j2的距离";
  output SI.AngularVelocity j1_w "旋转接头j1的轴速度";
  output SI.Velocity j2_v "平移副j的轴速度";

  inner Modelica.Mechanics.MultiBody.World world annotation (Placement(
        transformation(extent={{-100,-70},{-80,-50}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute j1(
    n={1,0,0}, 
    stateSelect=StateSelect.always, 
    phi(fixed=true), 
    w(displayUnit="deg/s", 
      start=5.235987755982989, 
      fixed=true)) 
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic j2(
    n={1,0,0}, 
    s(start=-0.2), 
    boxWidth=0.05) annotation (Placement(transformation(extent={{-20,-70},{0,-50}})));
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder b1(r={0,0.5,0.1}, diameter=0.05) 
    annotation (Placement(transformation(
        origin={-30,-10}, 
        extent={{-10,-10},{10,10}}, 
        rotation=90)));
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder b2(r={0,0.2,0}, diameter=0.05) 
    annotation (Placement(transformation(
        origin={20,-40}, 
        extent={{-10,-10},{10,10}}, 
        rotation=90)));
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder b3(r={-1,0.3,0.1}, diameter=0.05) 
    annotation (Placement(transformation(extent={{60,50},{40,70}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute rev(n={0,1,0}) 
    annotation (Placement(transformation(
        origin={20,-10}, 
        extent={{-10,-10},{10,10}}, 
        rotation=90)));
  Modelica.Mechanics.MultiBody.Joints.Revolute rev1 annotation (Placement(
        transformation(extent={{40,0},{60,20}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute j3(n={1,0,0}) annotation (Placement(
        transformation(extent={{-70,30},{-50,50}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute j4(n={0,1,0}) annotation (Placement(
        transformation(extent={{-30,40},{-10,60}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute j5(n={0,0,1}) annotation (Placement(
        transformation(extent={{10,50},{30,70}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation b0(animation=false, r={1.2,0,0}) 
    annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
equation
  connect(j2.frame_b, b2.frame_a) annotation (Line(
      points={{0,-60},{20,-60},{20,-50}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(j1.frame_b, b1.frame_a) annotation (Line(
      points={{-40,-30},{-30,-30},{-30,-20}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(rev.frame_a, b2.frame_b) 
    annotation (Line(
      points={{20,-20},{20,-30}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(rev.frame_b, rev1.frame_a) 
    annotation (Line(
      points={{20,0},{20,10},{40,10}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(rev1.frame_b, b3.frame_a) annotation (Line(
      points={{60,10},{70,10},{70,60},{60,60}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(world.frame_b, j1.frame_a) annotation (Line(
      points={{-80,-60},{-70,-60},{-70,-30},{-60,-30}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(b1.frame_b, j3.frame_a) annotation (Line(
      points={{-30,0},{-30,10},{-80,10},{-80,40},{-70,40}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(j3.frame_b, j4.frame_a) annotation (Line(
      points={{-50,40},{-40,40},{-40,50},{-30,50}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(j4.frame_b, j5.frame_a) 
    annotation (Line(
      points={{-10,50},{0,50},{0,60},{10,60}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(j5.frame_b, b3.frame_b) annotation (Line(
      points={{30,60},{40,60}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(b0.frame_a, world.frame_b) 
    annotation (Line(
      points={{-60,-60},{-80,-60}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(b0.frame_b, j2.frame_a) 
    annotation (Line(
      points={{-40,-60},{-20,-60}}, 
      color={95,95,95}, 
      thickness=0.5));
  j1_phi = j1.phi;
  j2_s = j2.s;
  j1_w = j1.w;
  j2_v = j2.v;
  annotation (
    experiment(StopTime=5), 
    Documentation(info="<html><p>
这是一个简单的运动环，由6个转动副、1个平移副和4根杆件组成，它经常作为机构中的基本构建单元。
这个例子表明，通常用户不需要特定的知识来处理运动环。
只需根据实际系统将运动副和刚体连接起来即可。
特别是，<strong>不需要</strong>确定局部运动副或生成树。
在这种情况下，为了驱动这个运动环，转动副j1的角速度初始条件被设置为300deg/s。
</p>
<p>
<div><img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/Fourbar1.png\"alt=\"model Examples.Loops.Fourbar1\"></div></p>
</html>"));
end Fourbar1;