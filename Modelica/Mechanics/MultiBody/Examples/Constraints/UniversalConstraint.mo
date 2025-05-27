within Modelica.Mechanics.MultiBody.Examples.Constraints;
model UniversalConstraint 
  "通过一个弹簧和一个万向节连接或约束到外界环境的刚体"
  extends Modelica.Icons.Example;
  parameter Boolean animation = true "= true, 如需要启用动画";
  Joints.Universal joint(
    n_a = {0, 0, 1}, 
    n_b = {1, 0, 0}, 
    stateSelect = StateSelect.always, 
    phi_a(fixed = true), 
    phi_b(fixed = true), 
    w_a(fixed = true), 
    w_b(fixed = true)) 
    annotation(Placement(transformation(extent = {{60, -30}, {40, -10}})));
  Joints.Constraints.Universal constraint(n_a = joint.n_a, n_b = joint.n_b) 
    annotation(Placement(transformation(extent = {{60, 10}, {40, 30}})));
  Modelica.Mechanics.MultiBody.Sensors.RelativeSensor sensorConstraintRelative(
    resolveInFrame = Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a, 
    get_r_rel = true, 
    get_a_rel = false, 
    get_angles = true, 
    sequence = {3, 2, 1}) 
    annotation(Placement(transformation(extent = {{60, 60}, {40, 40}})));
  Modelica.Mechanics.MultiBody.Parts.BodyShape bodyOfJoint(
    m = 1, 
    I_11 = 1, 
    I_22 = 1, 
    I_33 = 1, 
    r = {0.4, 0, 0}, 
    r_CM = {0.2, 0, 0}, 
    width = 0.05, 
    r_0(start = {0.2, -0.5, 0.1}, each fixed = false), 
    v_0(each fixed = false), 
    angles_fixed = false, 
    w_0_fixed = false, 
    angles_start = {0.17453292519943, 0.95993108859688, 1.1868238913561}, 
    final color = {0, 0, 255}) 
    annotation(Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 180, 
    origin = {10, -20})));
  Modelica.Mechanics.MultiBody.Parts.BodyShape bodyOfConstraint(
    I_11 = 1, 
    I_22 = 1, 
    I_33 = 1, 
    width = 0.05, 
    r_0(start = {0.2, -0.5, 0.1}, each fixed = false), 
    v_0(each fixed = false), 
    angles_fixed = false, 
    w_0_fixed = false, 
    final color = {0, 128, 0}, 
    r = bodyOfJoint.r, 
    r_CM = bodyOfJoint.r_CM, 
    m = bodyOfJoint.m, 
    angles_start = {0.17453292519943, 0.95993108859688, 1.1868238913561}) 
    annotation(Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 180, 
    origin = {10, 20})));
  Modelica.Mechanics.MultiBody.Forces.Spring springOfJoint(
    c = 20, 
    s_unstretched = 0, 
    width = 0.1, 
    coilWidth = 0.005, 
    numberOfWindings = 5) annotation(Placement(transformation(
    origin = {-50, -20}, 
    extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Forces.Spring springOfConstraint(
    width = 0.1, 
    coilWidth = 0.005, 
    c = springOfJoint.c, 
    s_unstretched = springOfJoint.s_unstretched, 
    numberOfWindings = springOfJoint.numberOfWindings) 
    annotation(Placement(transformation(
    origin = {-50, 20}, 
    extent = {{-10, -10}, {10, 10}})));
  inner Modelica.Mechanics.MultiBody.World world annotation(Placement(
    transformation(extent = {{-100, -100}, {-80, -80}})));
  Modelica.Mechanics.MultiBody.Parts.FixedRotation fixedRotation(
    r = {0.2, -0.3, 0.2}, 
    rotationType = Modelica.Mechanics.MultiBody.Types.RotationTypes.PlanarRotationSequence, 
    angles = {10, 55, 68}) 
    annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, 
    rotation = 90, 
    origin = {90, -50})));

  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation(animation = 
    false, r = {0.8, 0, 0.3}) 
    annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, 
    rotation = 90, 
    origin = {-70, -50})));
  Parts.FixedTranslation fixedTranslationOfJoint(r = {0.1, 0.15, 0.2}) 
    annotation(Placement(transformation(extent = {{-10, -30}, {-30, -10}})));
  Parts.FixedTranslation fixedTranslationOfConstraint(r = fixedTranslationOfJoint.r) 
    annotation(Placement(transformation(extent = {{-10, 10}, {-30, 30}})));
  Joints.FreeMotionScalarInit freeMotionScalarInit(
    use_angle = true, 
    use_angle_d = true, 
    angle_1(fixed = true), 
    angle_3(fixed = true), 
    angle_d_1(fixed = true), 
    angle_d_3(fixed = true), 
    sequence_start = {1, 2, 3}) 
    annotation(Placement(transformation(extent = {{60, 70}, {40, 90}})));
equation
  connect(fixedTranslation.frame_a, world.frame_b) 
    annotation(Line(
    points = {{-70, -60}, {-70, -90}, {-80, -90}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(world.frame_b, fixedRotation.frame_a) annotation(Line(
    points = {{-80, -90}, {90, -90}, {90, -60}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(fixedRotation.frame_b, constraint.frame_a) annotation(Line(
    points = {{90, -40}, {90, 20}, {60, 20}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(constraint.frame_a, sensorConstraintRelative.frame_a) 
    annotation(Line(
    points = {{60, 20}, {70, 20}, {70, 50}, {60, 50}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(joint.frame_b, bodyOfJoint.frame_a) annotation(
    Line(
    points = {{40, -20}, {20, -20}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(fixedTranslation.frame_b, springOfJoint.frame_a) 
    annotation(Line(
    points = {{-70, -40}, {-70, -20}, {-60, -20}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(fixedTranslation.frame_b, springOfConstraint.frame_a) 
    annotation(Line(
    points = {{-70, -40}, {-70, 20}, {-60, 20}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(bodyOfConstraint.frame_a, constraint.frame_b) annotation(Line(
    points = {{20, 20}, {40, 20}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(joint.frame_a, fixedRotation.frame_b) annotation(Line(
    points = {{60, -20}, {90, -20}, {90, -40}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(bodyOfJoint.frame_b, fixedTranslationOfJoint.frame_a) annotation(
    Line(
    points = {{0, -20}, {-10, -20}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(bodyOfConstraint.frame_b, fixedTranslationOfConstraint.frame_a) 
    annotation(Line(
    points = {{0, 20}, {-10, 20}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(springOfJoint.frame_b, fixedTranslationOfJoint.frame_b) annotation(
    Line(
    points = {{-40, -20}, {-30, -20}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(springOfConstraint.frame_b, fixedTranslationOfConstraint.frame_b) 
    annotation(Line(
    points = {{-40, 20}, {-30, 20}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(fixedRotation.frame_b, freeMotionScalarInit.frame_a) annotation(
    Line(
    points = {{90, -40}, {90, 80}, {60, 80}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(bodyOfConstraint.frame_a, freeMotionScalarInit.frame_b) annotation(
    Line(
    points = {{20, 20}, {30, 20}, {30, 80}, {40, 80}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(bodyOfConstraint.frame_a, sensorConstraintRelative.frame_b) annotation(Line(
    points = {{20, 20}, {30, 20}, {30, 50}, {40, 50}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  annotation(
    experiment(StopTime = 10), 
    Documentation(info = "<html>
<p>本示例展示了代表<strong>万向节</strong>的<strong>约束</strong>功能。
两个刚体中的每一个都通过弹簧连接到外界环境的一个端点。
另一个端点也通过万向节或适当的约束连接到世界。
因此，刚体只能根据作用力在两个旋转轴上进行旋转运动。</p>

<p><strong>模拟结果</strong></p> 
<p>在模拟模型后，观察多体系统的动画，并比较通过关节连接的刚体(蓝色)与通过约束连接的刚体(绿色)的运动。
此外，来自<code> sensorConstraintRelative </code>的输出显示了约束元素中的位置偏差。</p>
</html>"));
end UniversalConstraint;