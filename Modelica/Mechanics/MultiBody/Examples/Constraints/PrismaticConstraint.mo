within Modelica.Mechanics.MultiBody.Examples.Constraints;
model PrismaticConstraint 
  "通过一个弹簧和两个移动副连接或约束连接到环境的刚体"
  extends Modelica.Icons.Example;
  parameter Boolean animation=true "true,如需要启用动画";

  Joints.Prismatic jointPrismatic_x(stateSelect=StateSelect.always, 
    n={1,0,0}, 
    s(fixed=true), 
    v(fixed=true)) 
    annotation (Placement(transformation(extent={{80,-30},{60,-10}})));
  Joints.Prismatic jointPrismatic_y(stateSelect=StateSelect.always, 
    n={0,1,0}, 
    s(fixed=true), 
    v(fixed=true)) 
    annotation (Placement(transformation(extent={{40,-30},{20,-10}})));
  Joints.Constraints.Prismatic constraint(x_locked=false, y_locked= 
        false) 
    annotation (Placement(transformation(extent={{60,10},{40,30}})));
  Modelica.Mechanics.MultiBody.Sensors.RelativeSensor sensorConstraintRelative(
    resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a, 
    get_r_rel=true, 
    get_a_rel=false, 
    get_angles=true) 
    annotation (Placement(transformation(extent={{60,60},{40,40}})));
  Modelica.Mechanics.MultiBody.Parts.BodyShape bodyOfJoint(
    m=1, 
    I_11=1, 
    I_22=1, 
    I_33=1, 
    r={0.4,0,0}, 
    r_CM={0.2,0,0}, 
    width=0.05, 
    r_0(start={0.2,-0.5,0.1}, each fixed=false), 
    v_0(each fixed=false), 
    angles_fixed=false, 
    w_0_fixed=false, 
    angles_start={0.17453292519943,0.95993108859688,1.1868238913561}, 
    final color={0,0,255}) 
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},rotation=180, 
        origin={-10,-20})));
  Modelica.Mechanics.MultiBody.Parts.BodyShape bodyOfConstraint(
    I_11=1, 
    I_22=1, 
    I_33=1, 
    width=0.05, 
    w_0_fixed=false, 
    final color={0,128,0}, 
    r=bodyOfJoint.r, 
    r_CM=bodyOfJoint.r_CM, 
    m=bodyOfJoint.m, 
    angles_fixed=false, 
    angles_start={0.17453292519943,0.95993108859688,1.1868238913561}) 
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},rotation=180, 
        origin={-10,20})));
  Modelica.Mechanics.MultiBody.Forces.Spring springOfJoint(
    c=20, 
    s_unstretched=0, 
    width=0.1, 
    coilWidth=0.005, 
    numberOfWindings=5) annotation (Placement(transformation(
        origin={-50,-20}, 
        extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.MultiBody.Forces.Spring springOfConstraint(
    width=0.1, 
    coilWidth=0.005, 
    c=springOfJoint.c, 
    s_unstretched=springOfJoint.s_unstretched, 
    numberOfWindings=springOfJoint.numberOfWindings) 
                        annotation (Placement(transformation(
        origin={-50,20}, 
        extent={{-10,-10},{10,10}})));
  inner Modelica.Mechanics.MultiBody.World world annotation (Placement(
        transformation(extent={{-100,-100},{-80,-80}})));
  Modelica.Mechanics.MultiBody.Parts.FixedRotation fixedRotation(
    r={0.2,-0.3,0.2}, 
    rotationType=Modelica.Mechanics.MultiBody.Types.RotationTypes.PlanarRotationSequence, 
    angles={10,55,68}) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={90,-50})));

  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation(animation= 
       false, r={0.8,0,0.3}) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, 
rotation=90, 
        origin={-70,-50})));
  Joints.FreeMotionScalarInit freeMotionScalarInit(
    use_r=true, 
    use_v=true, 
    v_rel_a_2(fixed=true, start=0), 
    v_rel_a_3(fixed=true, start=0), 
    use_w=true, 
    w_rel_b_1(fixed=false), 
    w_rel_b_2(fixed=false), 
    w_rel_b_3(fixed=false), 
    angle_d_3(fixed=false), 
    r_rel_a_2(fixed=true, start=0), 
    r_rel_a_3(fixed=true, start=0), 
    angle_1(fixed=false)) 
    annotation (Placement(transformation(extent={{60,70},{40,90}})));
equation
  connect(fixedTranslation.frame_a, world.frame_b) 
    annotation (Line(
      points={{-70,-60},{-70,-90},{-80,-90}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(bodyOfConstraint.frame_b, springOfConstraint.frame_b) 
                                         annotation (Line(
      points={{-20,20},{-40,20}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(world.frame_b, fixedRotation.frame_a) annotation (Line(
      points={{-80,-90},{90,-90},{90,-60}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(fixedRotation.frame_b, constraint.frame_a) annotation (Line(
      points={{90,-40},{90,20},{60,20}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(constraint.frame_a,sensorConstraintRelative. frame_a) 
                                                      annotation (Line(
      points={{60,20},{70,20},{70,50},{60,50}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(bodyOfJoint.frame_b, springOfJoint.frame_b) 
                                         annotation (Line(
      points={{-20,-20},{-40,-20}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(sensorConstraintRelative.frame_b, constraint.frame_b) annotation (
      Line(
      points={{40,50},{30,50},{30,20},{40,20}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(fixedTranslation.frame_b, springOfJoint.frame_a) 
                                              annotation (Line(
      points={{-70,-40},{-70,-20},{-60,-20}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(fixedTranslation.frame_b, springOfConstraint.frame_a) 
                                                   annotation (Line(
      points={{-70,-40},{-70,20},{-60,20}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(bodyOfConstraint.frame_a, constraint.frame_b) annotation (Line(
      points={{0,20},{40,20}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(jointPrismatic_x.frame_b, jointPrismatic_y.frame_a) 
                                                  annotation (Line(
      points={{60,-20},{40,-20}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(fixedRotation.frame_b, jointPrismatic_x.frame_a) annotation (Line(
      points={{90,-40},{90,-20},{80,-20}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(bodyOfJoint.frame_a, jointPrismatic_y.frame_b) annotation (Line(
      points={{0,-20},{20,-20}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(freeMotionScalarInit.frame_a, fixedRotation.frame_b) annotation (
      Line(
      points={{60,80},{90,80},{90,-40}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(freeMotionScalarInit.frame_b, bodyOfConstraint.frame_a) annotation (
     Line(
      points={{40,80},{10,80},{10,20},{0,20}}, 
      color={95,95,95}, 
      thickness=0.5));
  annotation (
    experiment(StopTime=10), 
    Documentation(info="<html>
<p>
本示例展示了代表<strong>移动运动副</strong>的<strong>约束</strong>功能。
两个刚体中的每一个都通过弹簧连接到外界的一个端点。
另一个端点也通过两个串联耦合的平移副或适当的约束连接到外界。
因此，刚体只能在两个运动副指定的两个方向上进行平动，这取决于工作力。
</p>
<p>
<strong>模拟结果</strong></p><p>
在仿真后，观察多体系统的动画，并比较通过运动副连接的刚体(蓝色)与通过约束连接的刚体(绿色)的运动。
此外，<code>sensorConstraintRelative</code>的输出显示约束元素中的位置和角度偏差。
</p></html>"));
end PrismaticConstraint;