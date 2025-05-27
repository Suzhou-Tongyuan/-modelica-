within Modelica.Mechanics.MultiBody.Joints.Constraints;
model Prismatic 
  "平动方向可限制或不限制的局部平移副"
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;

  parameter Boolean x_locked=true 
    "=true:x方向的约束力，解析在frame_a中" 
    annotation (Dialog(group="约束"),choices(checkBox=true));
  parameter Boolean y_locked=true 
    "=true:y方向的约束力，解析在frame_a中" 
    annotation (Dialog(group="约束"),choices(checkBox=true));
  parameter Boolean z_locked=true 
    "=true:z方向的约束力，解析在frame_a中" 
    annotation (Dialog(group="约束"),choices(checkBox=true));

  parameter Boolean animation=true 
    "=true，如果启用动画(显示球体)";
  parameter SI.Distance sphereDiameter=world.defaultJointLength /3 
    "代表球面副的球体直径" 
      annotation (Dialog(group="如果animation=true", enable=animation));
  input Types.Color sphereColor=Types.Defaults.JointColor 
    "代表球面副的球体颜色" 
      annotation (Dialog(colorSelector=true, group="如果animation=true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient=world.defaultSpecularCoefficient 
    "环境光的反射(=0：光完全被吸收)" 
      annotation (Dialog(group="如果animation=true", enable=animation));

protected
  Frames.Orientation R_rel 
    "从frame_a到frame_b的虚拟或相对方向对象";
  SI.Position r_rel_a[3] 
    "从frame_a原点到frame_b原点的位置矢量，解析在frame_a中";
  SI.InstantaneousPower P;


public
  Visualizers.Advanced.Shape sphere(
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
equation
  // 在frame_a中确定相对位置矢量
  R_rel = Frames.relativeRotation(frame_a.R, frame_b.R);
  r_rel_a = Frames.resolve2(frame_a.R, frame_b.r_0 - frame_a.r_0);

  // 关于旋转的约束方程
  ones(3)={R_rel.T[1,1], R_rel.T[2,2], R_rel.T[3,3]};

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

  zeros(3) = frame_a.t + Frames.resolve1(R_rel, frame_b.t) + cross(r_rel_a, 
    Frames.resolve1(R_rel, frame_b.f));
  zeros(3) = Frames.resolve1(R_rel, frame_b.f) + frame_a.f;
  P = frame_a.t*Frames.angularVelocity2(frame_a.R) + frame_b.t* 
    Frames.angularVelocity2(frame_b.R) + frame_b.f*Frames.resolve2(frame_b.R, 
    der(frame_b.r_0)) + frame_a.f*Frames.resolve2(frame_a.R, der(frame_a.r_0));

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
          extent={{-100,-70},{100,-100}}, 
          textColor={95,95,95}, 
          textString="lock:x,y,z", 
          visible=x_locked and y_locked and z_locked), 
        Rectangle(
          extent={{-100,46},{-30,56}}, 
          pattern=LinePattern.None, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Rectangle(
          extent={{-100,-44},{-30,47}}, 
          pattern=LinePattern.None, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Rectangle(
          extent={{-30,24},{100,34}}, 
          pattern=LinePattern.None, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Rectangle(
          extent={{-30,-26},{100,24}}, 
          pattern=LinePattern.None, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Line(points={{100,-26},{100,25}}), 
        Line(points={{-30,-44},{-30,56}}), 
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
这个模型不使用显式变量，例如相对于frame_a描述frame_b的相对运动的状态变量，而是在frame_a和frame_b之间定义运动学约束。
然后，评估两个坐标系上的力和扭矩，以使约束得到满足。
有时候，这种类型的表述在文献中也被称为隐式运动副。
</p>
<p>
由于这种表述的结果，frame_a和frame_b之间的相对运动学无法初始化。
</p>
<p>
特别是在具有闭环的复杂多体系统中，这可能有助于简化非线性方程组。
请比较使用经典运动副表述和此处使用的替代表述的翻译日志，以检查这一事实是否适用于考虑的特定系统。
</p>
<p>
在没有闭环的系统中，使用这种隐式运动副是没有意义的，甚至可能是不利的。
</p>
<p>
查看subpackage<a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Constraints\">Examples.Constraints</a>以测试该运动副。
</p>
</html>"));
end Prismatic;