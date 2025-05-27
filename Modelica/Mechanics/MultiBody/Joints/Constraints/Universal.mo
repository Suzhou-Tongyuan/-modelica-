within Modelica.Mechanics.MultiBody.Joints.Constraints;
model Universal 
  "万向节的局部运动副和平动方向可以约束或释放"
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
  import MBS = Modelica.Mechanics.MultiBody;

  parameter MBS.Types.Axis n_a={1,0,0} 
    "转动副1在frame_a中的轴" annotation (Evaluate=true);
  parameter MBS.Types.Axis n_b={0,1,0} 
    "转动副2在frame_b中的轴" annotation (Evaluate=true);

  parameter Boolean x_locked=true 
    "=true:x方向的约束力，解析在frame_a中" 
    annotation (Dialog(group="平动运动中的约束"), choices(checkBox=true));
  parameter Boolean y_locked=true 
    "=true:y方向的约束力，解析在frame_a中" 
    annotation (Dialog(group="平动运动中的约束"), choices(checkBox=true));
  parameter Boolean z_locked=true 
    "=true:z方向的约束力，解析在frame_a中" 
    annotation (Dialog(group="平动运动中的约束"), choices(checkBox=true));

  parameter Boolean animation=true 
    "=true，如果启用动画(显示球)" 
    annotation (Dialog(group="动画"));
  parameter SI.Distance sphereDiameter=world.defaultJointLength /3 
    "代表球面副的球直径" 
    annotation (Dialog(group="动画", enable=animation));
  input MBS.Types.Color sphereColor=MBS.Types.Defaults.JointColor 
    "代表球面副的球的颜色" 
    annotation (Dialog(colorSelector=true, group="动画", enable=animation));
  input MBS.Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射(=0：光完全被吸收)" 
    annotation (Dialog(group="动画", enable=animation));

protected
  MBS.Frames.Orientation R_rel 
    "从frame_a到frame_b的虚拟或相对方向对象";
  Real w_rel[3];
  SI.Position r_rel_a[3] 
    "从frame_a原点到frame_b原点的位置矢量，解析在frame_a中";

  SI.InstantaneousPower P;
equation
  // 确定在frame_a中解析的相对位置矢量
  R_rel = MBS.Frames.relativeRotation(frame_a.R, frame_b.R);
  w_rel = MBS.Frames.angularVelocity1(R_rel);
  r_rel_a = MBS.Frames.resolve2(frame_a.R, frame_b.r_0 - frame_a.r_0);

  // 关于平动的约束方程

  if x_locked and y_locked and z_locked then
    r_rel_a=zeros(3);
  elseif x_locked and y_locked and not z_locked then
    r_rel_a[1]=0;
    r_rel_a[2]=0;
    frame_a.f[3]=0;
  elseif x_locked and not y_locked and z_locked then
    r_rel_a[1]=0;
    r_rel_a[3]=0;
    frame_a.f[2]=0;
  elseif x_locked and not y_locked and not z_locked then
    r_rel_a[1]=0;
    frame_a.f[2]=0;
    frame_a.f[3]=0;
  elseif not x_locked and y_locked and z_locked then
    r_rel_a[2]=0;
    r_rel_a[3]=0;
    frame_a.f[1]=0;
  elseif not x_locked and y_locked and not z_locked then
    r_rel_a[2]=0;
    frame_a.f[1]=0;
    frame_a.f[3]=0;
  elseif not x_locked and not y_locked and z_locked then
    r_rel_a[3]=0;
    frame_a.f[1]=0;
    frame_a.f[2]=0;
  else
    frame_a.f=zeros(3);
  end if;
  // 关于旋转的约束方程
  frame_a.t * n_a = 0;
  frame_b.t * n_b = 0;
  n_b * R_rel.T * n_a = 0;
  assert(abs(n_a * n_b) < Modelica.Constants.eps, "构成Constraints.Universal运动副的两个轴必须不同");

  zeros(3) = frame_a.f + MBS.Frames.resolve1(R_rel, frame_b.f);
  zeros(3) = frame_a.t + MBS.Frames.resolve1(R_rel, frame_b.t) - cross(r_rel_a, frame_a.f);
  P = frame_a.t * MBS.Frames.angularVelocity2(frame_a.R) + frame_b.t * MBS.Frames.angularVelocity2(frame_b.R) + MBS.Frames.resolve1(frame_b.R, frame_b.f) * der(frame_b.r_0) + MBS.Frames.resolve1(frame_a.R, frame_a.f) * der(frame_a.r_0);

  annotation (
    defaultComponentName="constraint", 
    Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-100,-70},{100,-100}}, 
          textColor={95,95,95}, 
          textString="lock:x", 
          visible=x_locked and not y_locked and not z_locked), 
        Text(
          extent={{-100,-70},{100,-100}}, 
          textColor={95,95,95}, 
          textString="lock:y", 
          visible=not x_locked and y_locked and not z_locked), 
        Text(
          extent={{-100,-70},{100,-100}}, 
          textColor={95,95,95}, 
          textString="lock:z", 
          visible=not x_locked and not y_locked and z_locked), 
        Text(
          extent={{-100,-70},{100,-100}}, 
          textColor={95,95,95}, 
          textString="lock:x,y", 
          visible=x_locked and y_locked and not z_locked), 
        Text(
          extent={{-100,-70},{100,-100}}, 
          textColor={95,95,95}, 
          textString="lock:x,z", 
          visible=x_locked and not y_locked and z_locked), 
        Text(
          extent={{-100,-70},{100,-100}}, 
          textColor={95,95,95}, 
          textString="lock:y,z", 
          visible=not x_locked and y_locked and z_locked), 
        Text(
          extent={{-100,-76},{100,-106}}, 
          textColor={95,95,95}, 
          textString="lock:x,y,z", 
          visible=x_locked and y_locked and z_locked), 
        Rectangle(
          extent={{-96,15},{-61,-15}}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          fillColor={235,235,235}), 
        Ellipse(
          extent={{-76,-80},{84,80}}, 
          lineColor={160,160,164}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-56,-60},{64,60}}, 
          lineColor={160,160,164}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{16,82},{84,-82}}, 
          lineColor={255,255,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{60,15},{104,-15}}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          fillColor={235,235,235}), 
        Line(
          points={{16,78},{16,-78}}, 
          thickness=0.5), 
        Ellipse(
          extent={{-48,-40},{84,40}}, 
          lineColor={160,160,164}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-28,-20},{64,26}}, 
          lineColor={160,160,164}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Polygon(
          points={{-18,-54},{-56,0},{-18,50},{44,52},{-18,-54}}, 
          pattern=LinePattern.None, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Line(
          points={{16,78},{16,-20}}, 
          thickness=0.5), 
        Line(
          points={{36,38},{-8,-36}}, 
          thickness=0.5), 
        Text(
          extent={{-150,120},{150,80}}, 
          textColor={0,0,255}, 
          textString="%name"), 
        Line(
          points={{-81,-66},{-23,25},{40,-39},{97,71}}, 
          color={255,0,0}, 
          thickness=0.5)}), 
    Documentation(info="<html>
<p>
此模型不使用显式变量，例如状态变量，来描述frame_b相对于frame_a的相对运动，而是在frame_a和frame_b之间定义了运动约束。
然后，以满足约束条件的方式评估两个坐标系上的力和力矩。
有时候，文献中也将这种类型的表述称为隐式运动副。
</p>
<p>
由于这种表述的结果，frame_a和frame_b之间的相对运动不能被初始化。
</p>
<p>
特别是在具有闭环的复杂多体系统中，这可能有助于简化非线性方程组。
请比较使用经典运动副表述和此处使用的替代表述的翻译日志，以检查这个事实是否适用于特定系统。
</p>
<p>
在没有闭环的系统中，使用这种隐式运动副是没有意义的，甚至可能是不利的。
</p>
<p>
请参阅子包<a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Constraints\">Examples.Constraints</a>以测试该运动副。
</p>
</html>"));
end Universal;