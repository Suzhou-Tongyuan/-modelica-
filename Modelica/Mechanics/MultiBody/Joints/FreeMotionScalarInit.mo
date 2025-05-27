within Modelica.Mechanics.MultiBody.Joints;
model FreeMotionScalarInit 
  "具有标量初始化和状态选择的自由运动副(6个自由度，12个潜在状态变量)"

  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;

  parameter Boolean animation=true 
    "=true，如果要启用动画(从frame_a到frame_b显示箭头)" 
    annotation(Dialog(enable=use_r));

  parameter Boolean use_r = false "=true，如果要使用r_rel_a" 
      annotation(Evaluate=true, HideResult=true,Dialog(tab="转换初始化", group="r_rel_a是从frame_a的原点到frame_b的原点的位置矢量，在frame_a中解析"));
  Modelica.Blocks.Interfaces.RealOutput r_rel_a_1(final quantity="Length", final unit="m", start=0, final stateSelect=r_rel_a_1_stateSelect) if use_r 
    "相对距离r_rel_a[1]" 
    annotation(Dialog(enable=use_r, tab="转换初始化", group="r_rel_a是从frame_a的原点到frame_b的原点的位置矢量，在frame_a中解析",showStartAttribute=true));
  Modelica.Blocks.Interfaces.RealOutput r_rel_a_2(final quantity="Length", final unit="m", start=0, final stateSelect=r_rel_a_2_stateSelect) if use_r 
    "相对距离r_rel_a[2]" 
    annotation(Dialog(enable=use_r, tab="转换初始化", group="r_rel_a是从frame_a的原点到frame_b的原点的位置矢量，在frame_a中解析",showStartAttribute=true));
  Modelica.Blocks.Interfaces.RealOutput r_rel_a_3(final quantity="Length", final unit="m", start=0, final stateSelect=r_rel_a_3_stateSelect) if use_r 
    "相对距离r_rel_a[3]" 
    annotation(Dialog(enable=use_r, tab="转换初始化", group="r_rel_a是从frame_a的原点到frame_b的原点的位置矢量，在frame_a中解析",showStartAttribute=true));

  parameter StateSelect r_rel_a_1_stateSelect=StateSelect.never 
    "r_rel_a[1]的StateSelect" annotation(HideResult=true, 
     Dialog(enable=use_r, tab="转换初始化", group="r_rel_a是从frame_a的原点到frame_b的原点的位置矢量，在frame_a中解析"));
  parameter StateSelect r_rel_a_2_stateSelect=StateSelect.never 
    "r_rel_a[2]的StateSelect" annotation(HideResult=true, 
     Dialog(enable=use_r, tab="转换初始化", group="r_rel_a是从frame_a的原点到frame_b的原点的位置矢量，在frame_a中解析"));
  parameter StateSelect r_rel_a_3_stateSelect=StateSelect.never 
    "r_rel_a[3]的StateSelect" annotation(HideResult=true, 
     Dialog(enable=use_r, tab="转换初始化", group="r_rel_a是从frame_a的原点到frame_b的原点的位置矢量，在frame_a中解析"));

parameter Boolean use_v = false "=true，如果要使用v_rel_a" 
  annotation(Evaluate=true, HideResult=true, 
             Dialog(enable=use_r, tab="转换初始化", group="Velocityvectorv_rel_a=der(r_rel_a)"));
Modelica.Blocks.Interfaces.RealOutput v_rel_a_1(final quantity="Velocity", final unit="m/s", start=0, final stateSelect=v_rel_a_1_stateSelect) if use_r and use_v 
  "相对速度v_rel_a[1]" 
  annotation(Dialog(enable=use_r and use_v, tab="转换初始化", group="Velocityvectorv_rel_a=der(r_rel_a)",showStartAttribute=true));
Modelica.Blocks.Interfaces.RealOutput v_rel_a_2(final quantity="Velocity", final unit="m/s", start=0, final stateSelect=v_rel_a_2_stateSelect) if use_r and use_v 
  "相对速度v_rel_a[2]" 
  annotation(Dialog(enable=use_r and use_v, tab="转换初始化", group="Velocityvectorv_rel_a=der(r_rel_a)",showStartAttribute=true));
Modelica.Blocks.Interfaces.RealOutput v_rel_a_3(final quantity="Velocity", final unit="m/s", start=0, final stateSelect=v_rel_a_3_stateSelect) if use_r and use_v 
  "相对速度v_rel_a[3]" 
  annotation(Dialog(enable=use_r and use_v, tab="转换初始化", group="Velocityvectorv_rel_a=der(r_rel_a)",showStartAttribute=true));

parameter StateSelect v_rel_a_1_stateSelect=StateSelect.never 
  "v_rel_a[1]的状态选择" 
  annotation(HideResult=true, 
             Dialog(enable=use_r and use_v, tab="平动初始化", group="速度矢量v_rel_a=der(r_rel_a)"));
parameter StateSelect v_rel_a_2_stateSelect=StateSelect.never 
  "v_rel_a[2]的状态选择" 
  annotation(HideResult=true, 
             Dialog(enable=use_r and use_v, tab="平动初始化", group="速度矢量v_rel_a=der(r_rel_a)"));
parameter StateSelect v_rel_a_3_stateSelect=StateSelect.never 
  "v_rel_a[3]的状态选择" 
  annotation(HideResult=true, 
             Dialog(enable=use_r and use_v, tab="平动初始化", group="速度矢量v_rel_a=der(r_rel_a)"));

parameter Boolean use_a = false "=true，如果要使用a_rel_a" 
  annotation(Evaluate=true, HideResult=true, 
             Dialog(enable=use_r and use_v, tab="平动初始化", group="加速度矢量a_rel_a=der(v_rel_a)"));
Modelica.Blocks.Interfaces.RealOutput a_rel_a_1(final quantity="加速度", final unit="m/s2", start=0) if use_r and use_v and use_a 
  "相对加速度a_rel_a[1]" 
  annotation(Dialog(enable=use_r and use_v and use_a, tab="平动初始化", group="加速度矢量a_rel_a=der(v_rel_a)",showStartAttribute=true));
Modelica.Blocks.Interfaces.RealOutput a_rel_a_2(final quantity="加速度", final unit="m/s2", start=0) if use_r and use_v and use_a 
  "相对加速度a_rel_a[2]" 
  annotation(Dialog(enable=use_r and use_v and use_a, tab="平动初始化", group="加速度矢量a_rel_a=der(v_rel_a)",showStartAttribute=true));
Modelica.Blocks.Interfaces.RealOutput a_rel_a_3(final quantity="加速度", final unit="m/s2", start=0) if use_r and use_v and use_a 
  "相对加速度a_rel_a[3]" 
  annotation(Dialog(enable=use_r and use_v and use_a, tab="平动初始化", group="加速度矢量a_rel_a=der(v_rel_a)",showStartAttribute=true));

parameter Boolean use_angle = false "=true，如果要使用角度" 
  annotation(Evaluate=true, HideResult=true, 
             Dialog(tab="角度初始化", group="将frame_a旋转到frame_b的角度序列"));

parameter Types.RotationSequence sequence_start={1,2,3} 
  "角度旋转的序列" 
  annotation(Evaluate=true, 
             Dialog(enable=use_angle, tab="角度初始化", group="将frame_a旋转到frame_b的角度序列"));

Modelica.Blocks.Interfaces.RealOutput angle_1(final quantity="角度", final unit="rad", start=0, stateSelect=angle_1_stateSelect) if use_angle 
  "第一个旋转角度或虚拟值" 
  annotation(Dialog(enable=use_angle, tab="角度初始化", group="将frame_a旋转到frame_b的角度序列",showStartAttribute=true));
Modelica.Blocks.Interfaces.RealOutput angle_2(final quantity="角度", final unit="rad", start=0, stateSelect=angle_2_stateSelect) if use_angle 
  "第二个旋转角度或虚拟值" 
  annotation(Dialog(enable=use_angle, tab="角度初始化", group="将frame_a旋转到frame_b的角度序列",showStartAttribute=true));
Modelica.Blocks.Interfaces.RealOutput angle_3(final quantity="角度", final unit="rad", start=0, stateSelect=angle_3_stateSelect) if use_angle 
  "第三个旋转角度或虚拟值" 
  annotation(Dialog(enable=use_angle, tab="角度初始化", group="将frame_a旋转到frame_b的角度序列",showStartAttribute=true));

parameter StateSelect angle_1_stateSelect=StateSelect.never 
  "angle_1的状态选择" 
  annotation(HideResult=true, Dialog(enable=use_angle, tab="角度初始化", group="将frame_a旋转到frame_b的角度序列"));
parameter StateSelect angle_2_stateSelect=StateSelect.never 
  "angle_2的状态选择" 
  annotation(HideResult=true, Dialog(enable=use_angle, tab="角度初始化", group="将frame_a旋转到frame_b的角度序列"));
parameter StateSelect angle_3_stateSelect=StateSelect.never 
  "angle_3的状态选择" 
  annotation(HideResult=true, Dialog(enable=use_angle, tab="角度初始化", group="将frame_a旋转到frame_b的角度序列"));

parameter Boolean use_angle_d= false "=true，如果要使用angle_d" 
  annotation(Evaluate=true, HideResult=true, Dialog(enable=use_angle, tab="角度初始化", group="angle_d=der(angle)"));

Modelica.Blocks.Interfaces.RealOutput angle_d_1(final quantity="角速度", final unit="rad/s", start=0, final stateSelect=angle_d_1_stateSelect) if use_angle and use_angle_d 
  "=der(angle_1)" 
  annotation(Dialog(enable=use_angle and use_angle_d, tab="角度初始化", group="angle_d=der(angle)",showStartAttribute=true));
Modelica.Blocks.Interfaces.RealOutput angle_d_2(final quantity="角速度", final unit="rad/s", start=0, final stateSelect=angle_d_2_stateSelect) if use_angle and use_angle_d 
  "=der(angle_2)" 
  annotation(Dialog(enable=use_angle and use_angle_d, tab="角度初始化", group="angle_d=der(angle)",showStartAttribute=true));
Modelica.Blocks.Interfaces.RealOutput angle_d_3(final quantity="角速度", final unit="rad/s", start=0, final stateSelect=angle_d_3_stateSelect) if use_angle and use_angle_d 
  "=der(angle_3)" 
  annotation(Dialog(enable=use_angle and use_angle_d, tab="角度初始化", group="angle_d=der(angle)",showStartAttribute=true));

parameter StateSelect angle_d_1_stateSelect=StateSelect.never 
  "angle_d_1的状态选择" 
  annotation(HideResult=true, Dialog(enable=use_angle and use_angle_d, tab="角度初始化", group="angle_d=der(angle)"));
parameter StateSelect angle_d_2_stateSelect=StateSelect.never 
  "angle_d_2的状态选择" 
  annotation(HideResult=true, Dialog(enable=use_angle and use_angle_d, tab="角度初始化", group="angle_d=der(angle)"));
parameter StateSelect angle_d_3_stateSelect=StateSelect.never 
  "angle_d_3的状态选择" 
  annotation(HideResult=true, Dialog(enable=use_angle and use_angle_d, tab="角度初始化", group="angle_d=der(angle)"));

parameter Boolean use_angle_dd = false "=true，如果要使用angle_dd" 
  annotation(Evaluate=true, HideResult=true, Dialog(enable=use_angle and use_angle_d, tab="角度初始化", group="angle_dd=der(angle_d)"));

Modelica.Blocks.Interfaces.RealOutput angle_dd_1(final quantity="角加速度", final unit="rad/s2", start=0) if use_angle and use_angle_d and use_angle_dd 
  "=der(angle_d_1)" 
  annotation(Dialog(enable=use_angle and use_angle_d and use_angle_dd, tab="角度初始化", group="angle_dd=der(angle_d)",showStartAttribute=true));
Modelica.Blocks.Interfaces.RealOutput angle_dd_2(final quantity="角加速度", final unit="rad/s2", start=0) if use_angle and use_angle_d and use_angle_dd 
  "=der(angle_d_2)" 
  annotation(Dialog(enable=use_angle and use_angle_d and use_angle_dd, tab="角度初始化", group="angle_dd=der(angle_d)",showStartAttribute=true));
Modelica.Blocks.Interfaces.RealOutput angle_dd_3(final quantity="角加速度", final unit="rad/s2", start=0) if use_angle and use_angle_d and use_angle_dd 
  "=der(angle_d_3)" 
  annotation(Dialog(enable=use_angle and use_angle_d and use_angle_dd, tab="角度初始化", group="angle_dd=der(angle_d)",showStartAttribute=true));

parameter Boolean use_w = false "=true，如果要使用w_rel_b" 
  annotation(Evaluate=true, HideResult=true,Dialog(tab="角速度初始化", group="相对于frame_a，frame_b的角速度w_rel_b，以frame_b为参考系"));

Modelica.Blocks.Interfaces.RealOutput w_rel_b_1(final quantity="角速度", final unit="rad/s", start=0, stateSelect=w_rel_b_1_stateSelect) if use_w 
  "相对角速度w_rel_b[1]" 
  annotation(Dialog(enable=use_w, tab="角速度初始化", group="相对于frame_a，frame_b的角速度w_rel_b，以frame_b为参考系",showStartAttribute=true));
Modelica.Blocks.Interfaces.RealOutput w_rel_b_2(final quantity="角速度", final unit="rad/s", start=0, stateSelect=w_rel_b_2_stateSelect) if use_w 
  "相对角速度w_rel_b[2]" 
  annotation(Dialog(enable=use_w, tab="角速度初始化", group="相对于frame_a，frame_b的角速度w_rel_b，以frame_b为参考系",showStartAttribute=true));
Modelica.Blocks.Interfaces.RealOutput w_rel_b_3(final quantity="角速度", final unit="rad/s", start=0, stateSelect=w_rel_b_3_stateSelect) if use_w 
  "相对角速度w_rel_b[3]" 
  annotation(Dialog(enable=use_w, tab="角速度初始化", group="相对于frame_a，frame_b的角速度w_rel_b，以frame_b为参考系",showStartAttribute=true));

parameter StateSelect w_rel_b_1_stateSelect=StateSelect.never 
  "w_rel_b[1]的状态选择" annotation(HideResult=true, 
   Dialog(enable=use_w, tab="角速度初始化", group="相对于frame_a，frame_b的角速度w_rel_b，以frame_b为参考系"));
parameter StateSelect w_rel_b_2_stateSelect=StateSelect.never 
  "w_rel_b[2]的状态选择" annotation(HideResult=true, 
   Dialog(enable=use_w, tab="角速度初始化", group="相对于frame_a，frame_b的角速度w_rel_b，以frame_b为参考系"));
parameter StateSelect w_rel_b_3_stateSelect=StateSelect.never 
  "w_rel_b[3]的状态选择" annotation(HideResult=true, 
   Dialog(enable=use_w, tab="角速度初始化", group="相对于frame_a，frame_b的角速度w_rel_b，以frame_b为参考系"));

parameter Boolean use_z = false "=true,如果z_rel_b将要被使用" 
  annotation(Evaluate=true, HideResult=true, Dialog(enable=use_w, tab="角速度初始化", group="角加速度z_rel_b=der(w_rel_b)"));
Modelica.Blocks.Interfaces.RealOutput z_rel_b_1(final quantity="角加速度", final unit="rad/s2", start=0) if use_w and use_z 
  "相对角加速度z_rel_b[1]" 
  annotation(Dialog(enable=use_w and use_z, tab="角速度初始化", group="角加速度z_rel_b=der(w_rel_b)", showStartAttribute=true));
Modelica.Blocks.Interfaces.RealOutput z_rel_b_2(final quantity="角加速度", final unit="rad/s2", start=0) if use_w and use_z 
  "相对角加速度z_rel_b[2]" 
  annotation(Dialog(enable=use_w and use_z, tab="角速度初始化", group="角加速度z_rel_b=der(w_rel_b)", showStartAttribute=true));
Modelica.Blocks.Interfaces.RealOutput z_rel_b_3(final quantity="角加速度", final unit="rad/s2", start=0) if use_w and use_z 
  "相对角加速度z_rel_b[3]" 
  annotation(Dialog(enable=use_w and use_z, tab="角速度初始化", group="角加速度z_rel_b=der(w_rel_b)", showStartAttribute=true));

input Types.Color arrowColor=Modelica.Mechanics.MultiBody.Types.Defaults.SensorColor 
  "箭头颜色" 
  annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation and use_r));
input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
  "环境光反射(=0:光完全被吸收)" 
  annotation (Dialog(tab="动画", group="如果animation=true", enable=animation and use_r));

protected
  Modelica.Mechanics.MultiBody.Joints.Internal.InitPosition initPosition(
    r_a_0=frame_a.r_0, 
    r_b_0=frame_b.r_0, 
    R_a=frame_a.R) if use_r annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  Modelica.Mechanics.MultiBody.Joints.Internal.InitAngle initAngle(sequence_start=sequence_start) if use_angle annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Mechanics.MultiBody.Joints.Internal.InitAngularVelocity initAngularVelocity(R_a=frame_a.R, R_b=frame_b.R) if use_w annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Modelica.Blocks.Continuous.Der derv[3] if use_r and use_v 
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  Modelica.Blocks.Continuous.Der dera[3] if use_r and use_v and use_a 
    annotation (Placement(transformation(extent={{60,60},{80,80}})));
  Modelica.Blocks.Continuous.Der derd[3] if use_angle and use_angle_d 
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  Modelica.Blocks.Continuous.Der derdd[3] if use_angle and use_angle_d and use_angle_dd 
    annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
  Modelica.Blocks.Continuous.Der derz[3] if use_w and use_z 
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  Modelica.Mechanics.MultiBody.Forces.Internal.ZeroForceAndTorque zeroForceAndTorque1 
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Modelica.Mechanics.MultiBody.Forces.Internal.ZeroForceAndTorque zeroForceAndTorque2 
    annotation (Placement(transformation(extent={{80,-50},{60,-30}})));
  Modelica.Mechanics.MultiBody.Visualizers.SignalArrow arrow(
    color=arrowColor, 
    specularCoefficient=specularCoefficient) if world.enableAnimation and animation and use_r 
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
equation
  // r_rel_a
  connect(initPosition.r_rel_a[1], r_rel_a_1);
  connect(initPosition.r_rel_a[2], r_rel_a_2);
  connect(initPosition.r_rel_a[3], r_rel_a_3);

  // v_rel_a
  connect(derv[1].y, v_rel_a_1);
  connect(derv[2].y, v_rel_a_2);
  connect(derv[3].y, v_rel_a_3);

  // a_rel_a
  connect(dera[1].y, a_rel_a_1);
  connect(dera[2].y, a_rel_a_2);
  connect(dera[3].y, a_rel_a_3);

  // angle
  connect(initAngle.angle[1], angle_1);
  connect(initAngle.angle[2], angle_2);
  connect(initAngle.angle[3], angle_3);

  // angle_d
  connect(derd[1].y, angle_d_1);
  connect(derd[2].y, angle_d_2);
  connect(derd[3].y, angle_d_3);

  // angle_dd
  connect(derdd[1].y, angle_dd_1);
  connect(derdd[2].y, angle_dd_2);
  connect(derdd[3].y, angle_dd_3);

  // w_rel_b
  connect(initAngularVelocity.w_rel_b[1], w_rel_b_1);
  connect(initAngularVelocity.w_rel_b[2], w_rel_b_2);
  connect(initAngularVelocity.w_rel_b[3], w_rel_b_3);

  // z_rel_b
  connect(derz[1].y, z_rel_b_1);
  connect(derz[2].y, z_rel_b_2);
  connect(derz[3].y, z_rel_b_3);

  connect(initPosition.r_rel_a, derv.u) annotation (Line(
      points={{1,70},{18,70}}, color={0,0,127}));
  connect(derv.y, dera.u) annotation (Line(
      points={{41,70},{58,70}}, color={0,0,127}));
  connect(initAngle.frame_a, frame_a) annotation (Line(
      points={{-60,0},{-100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(initAngle.frame_b, frame_b) annotation (Line(
      points={{-40,0},{100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(initAngle.angle, derd.u) annotation (Line(
      points={{-50,-11},{-50,-20},{-22,-20}}, color={0,0,127}));
  connect(derd.y, derdd.u) annotation (Line(
      points={{1,-20},{18,-20}}, color={0,0,127}));
  connect(zeroForceAndTorque1.frame_a, frame_a) annotation (Line(
      points={{-80,-40},{-88,-40},{-88,0},{-100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(zeroForceAndTorque2.frame_a, frame_b) annotation (Line(
      points={{80,-40},{90,-40},{90,0},{100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(initAngularVelocity.w_rel_b, derz.u) annotation (Line(
      points={{1,30},{18,30}}, color={0,0,127}));
  connect(frame_a, arrow.frame_a) annotation (Line(
      points={{-100,0},{-88,0},{-88,70},{-80,70}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(initPosition.r_rel_a, arrow.r_head) annotation (Line(
      points={{1,70},{10,70},{10,52},{-70,52},{-70,58}}, color={0,0,127}));
  annotation (
    Documentation(info="<html>
<p>
该运动副中不约束frame_a和frame_b之间的运动。
如果需要使用frame_a和frame_b之间的相对距离和方向以及它们的导数作为状态，或者用于非标准初始化，这样的运动副是有意义的。
这个运动副允许初始化相对量的每个标量元素，以及为每个标量元素单独定义StateSelect属性。
</p>

<p>
在下图中显示了FreeMotionScalarInit运动副的动画。
浅蓝色坐标系是frame_a，深蓝色坐标系是运动副的frame_b。
(这里：r_rel_a_1(start=0.5)，r_rel_a_2(start=0)，r_rel_a_3(start=0.5)，angle_1(start=45°)，angle_2(start=45°)，angle_3(start=45°))。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/FreeMotion.png\">
</div>

<p>
一个示例，通过提供平面双摆的尖端位置来使用该运动副进行初始化，示例显示在<a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulumInitTip\">Examples.Elementary.DoublePendulumInitTip</a>中。
</p>

</html>"), 
         Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Line(
          points={{-86,31},{-74,61},{-49,83},{-17,92},{19,88},{40,69},{59,48}}, 
          color={160,160,164}, 
          thickness=0.5, 
          smooth=Smooth.Bezier), 
        Polygon(
          points={{90,0},{50,20},{50,-20},{90,0}}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Polygon(
          points={{69,58},{49,40},{77,28},{69,58}}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{150,-44},{-150,-84}}, 
          textColor={0,0,255}, 
          textString="%name"), 
        Rectangle(
          extent={{-70,-5},{-90,5}}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{50,-5},{30,5}}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{11,-5},{-9,5}}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{-30,-5},{-50,5}}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid)}));
end FreeMotionScalarInit;