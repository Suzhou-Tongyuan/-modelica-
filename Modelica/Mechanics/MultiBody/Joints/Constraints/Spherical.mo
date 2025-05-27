within Modelica.Mechanics.MultiBody.Joints.Constraints;
model Spherical 
    "球面局部运动副和平动方向可以被约束或释放"
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
  import MBS = Modelica.Mechanics.MultiBody;

  parameter Boolean x_locked=true 
    "=true:在x方向上的约束力，在frame_a中解算" 
    annotation (Dialog(group="约束"), choices(checkBox=true));
  parameter Boolean y_locked=true 
    "=true:在y方向上的约束力，在frame_a中解算" 
    annotation (Dialog(group="约束"), choices(checkBox=true));
  parameter Boolean z_locked=true 
    "=true:在z方向上的约束力，在frame_a中解算" 
    annotation (Dialog(group="约束"), choices(checkBox=true));

  parameter Boolean animation=true 
    "=true，如果启用动画(显示球体)" 
    annotation (Dialog(group="动画"));
  parameter SI.Distance sphereDiameter=world.defaultJointLength /3 
    "表示球面副的直径" 
    annotation (Dialog(group="动画", enable=animation));
  input MBS.Types.Color sphereColor=MBS.Types.Defaults.JointColor 
    "表示球面副的颜色" 
    annotation (Dialog(colorSelector=true, group="动画", enable=animation));
  input MBS.Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射(=0：光完全被吸收)" 
    annotation (Dialog(group="动画", enable=animation));

  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape sphere(
    shapeType="sphere", 
    color=sphereColor, 
    specularCoefficient=specularCoefficient, 
    length=sphereDiameter, 
    width=sphereDiameter, 
    height=sphereDiameter, 
    lengthDirection={1,0,0}, 
    widthDirection={0,1,0}, 
    r_shape={-0.5,0,0}*sphereDiameter, 
    r=frame_a.r_0, 
    R=frame_a.R) if world.enableAnimation and animation;
  MBS.Frames.Orientation R_rel 
    "从frame_a到frame_b的虚拟或相对方向对象";
  SI.Position r_rel_a[3] 
    "从frame_a原点到frame_b原点的位置矢量，在frame_a中解算";
  SI.InstantaneousPower P;

equation
  // 在 frame_a 中解算相对位置矢量
  R_rel = MBS.Frames.relativeRotation(frame_a.R, frame_b.R);
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

  //frame_a.t = zeros(3);

  frame_b.t = zeros(3);
  frame_b.f = -MBS.Frames.resolve2(R_rel, frame_a.f);
  zeros(3) = frame_a.t + MBS.Frames.resolve1(R_rel, frame_b.t) - cross(r_rel_a, frame_a.f);
  P= frame_a.t*MBS.Frames.angularVelocity2(frame_a.R)+frame_b.t*MBS.Frames.angularVelocity2(frame_b.R) + MBS.Frames.resolve1(frame_b.R,frame_b.f)*der(frame_b.r_0)+MBS.Frames.resolve1(frame_a.R,frame_a.f)*der(frame_a.r_0);
  annotation (
    defaultComponentName="constraint", 
    Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-150,120},{150,80}}, 
          textColor={0,0,255}, 
          textString="%name"), 
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
          extent={{-100,-70},{100,-100}}, 
          textColor={95,95,95}, 
          textString="lock:x,y,z", 
          visible=x_locked and y_locked and z_locked), 
        Ellipse(
          extent={{-66,-70},{74,70}}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={192,192,192}), 
        Ellipse(
          extent={{-45,-50},{55,50}}, 
          lineColor={128,128,128}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{34,70},{75,-68}}, 
          lineColor={255,255,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{-96,10},{-64,-10}}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          fillColor={192,192,192}), 
        Rectangle(
          extent={{27,10},{104,-10}}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          fillColor={192,192,192}), 
        Ellipse(
          extent={{-20,25},{30,-25}}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={160,160,164}), 
        Line(
          points={{-81,-66},{-23,25},{40,-39},{97,71}}, 
          color={255,0,0}, 
          thickness=0.5)}), 
    Documentation(info="<html>
<p>
该模型不使用显式变量，例如状态变量来描述frame_b相对于frame_a的相对运动，而是在frame_a和frame_b之间定义运动约束。
然后以确保约束得到满足的方式评估两个坐标系上的力和力矩。
有时这种类型的表述在文献中也被称为隐式连接。
</p>
<p>
由于这种表述的结果，frame_a和frame_b之间的相对运动不能被初始化。
</p>
<p>
特别是在具有闭环的复杂多体系统中，这可能有助于简化非线性方程组。
请比较使用传统运动副表述和此处使用的替代表述的翻译记录，以检查这个事实是否适用于正在考虑的特定系统。
</p>
<p>
在没有闭环的系统中，使用这种隐式运动副是没有意义的，甚至可能是不利的。
</p>
<p>
请参阅子包<a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Constraints\">Examples.Constraints</a>来测试该运动副。
</p>
</html>"));
end Spherical;