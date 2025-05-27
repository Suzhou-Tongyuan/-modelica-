within Modelica.Mechanics.MultiBody.Joints;
model Spherical 
  "球副(3个约束和无潜在状态变量，或3个自由度和3个状态变量)"

  import Modelica.Mechanics.MultiBody.Frames;

  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
  parameter Boolean animation=true 
    "=true，是否启用动画(显示球体)";
  parameter SI.Distance sphereDiameter=world.defaultJointLength 
    "代表球副的球体直径" 
    annotation (Dialog(group="如果animation=true", enable=animation));
  input Types.Color sphereColor=Modelica.Mechanics.MultiBody.Types.Defaults.JointColor 
    "代表球副的球体颜色" 
    annotation (Dialog(colorSelector=true, group="如果animation=true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射(=0：光被完全吸收)" 
    annotation (Dialog(group="如果animation=true", enable=animation));

  parameter Boolean angles_fixed = false 
    "=true，如果angles_start被用作初始值，否则用作猜测值" 
    annotation(Evaluate=true, choices(checkBox=true), Dialog(tab="初始化"));
  parameter SI.Angle angles_start[3]={0,0,0} 
    "将frame_a绕'sequence_start'轴旋转到frame_b的角度的初始值" 
    annotation (Dialog(tab="初始化"));
  parameter Types.RotationSequence sequence_start={1,2,3} 
    "将frame_a旋转到frame_b的旋转顺序，初始时间" 
    annotation (Evaluate=true, Dialog(tab="初始化"));

  parameter Boolean w_rel_a_fixed = false 
    "=true，如果w_rel_a_start被用作初始值，否则用作猜测值" 
    annotation(Evaluate=true, choices(checkBox=true), Dialog(tab="初始化"));
  parameter SI.AngularVelocity w_rel_a_start[3]={0,0,0} 
    "frame_b相对于frame_a的角速度的初始值，相对于frame_a" 
    annotation (Dialog(tab="初始化"));

  parameter Boolean z_rel_a_fixed = false 
    "=true，如果z_rel_a_start被用作初始值，否则用作猜测值" 
    annotation(Evaluate=true, choices(checkBox=true), Dialog(tab="初始化"));
  parameter SI.AngularAcceleration z_rel_a_start[3]={0,0,0} 
    "角加速度z_rel_a的初始值=der(w_rel_a)" 
    annotation (Dialog(tab="初始化"));

  parameter Boolean enforceStates=false 
    "=true，如果球副的相对变量将被用作状态变量(StateSelect.always)" 
    annotation (Evaluate=true, Dialog(tab="高级"));
  parameter Boolean useQuaternions=true 
    "=true，如果使用四元数作为状态变量，否则使用3个角度作为状态变量(假设enforceStates=true)" 
    annotation (Evaluate=true, Dialog(tab="高级", enable=enforceStates));
  parameter Types.RotationSequence sequence_angleStates={1,2,3} 
    "将frame_a旋转到frame_b的旋转顺序，使用作为状态变量的3个角度" 
     annotation (Evaluate=true, Dialog(tab="高级", enable=enforceStates 
           and not useQuaternions));

  final parameter Frames.Orientation R_rel_start= 
      Frames.axesRotations(sequence_start, angles_start, zeros(3)) 
    "初始时间时从frame_a到frame_b的方向对象";

protected
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

// 如果不使用四元数，则声明四元数(虚拟值)
parameter Frames.Quaternions.Orientation Q_start= 
            Modelica.Mechanics.MultiBody.Frames.to_Q(R_rel_start) 
    "初始时间时从frame_a到frame_b的四元数方向对象";
Frames.Quaternions.Orientation Q(start=Q_start, each stateSelect=if 
        enforceStates and useQuaternions then StateSelect.prefer else 
        StateSelect.never) 
    "从frame_a到frame_b的四元数方向对象(如果不使用四元数作为状态，则为虚拟值)";

// 三个角度的声明
parameter SI.Angle phi_start[3]=if sequence_start[1] == 
      sequence_angleStates[1] and sequence_start[2] == sequence_angleStates[2] 
       and sequence_start[3] == sequence_angleStates[3] then angles_start else 
       Frames.axesRotationsAngles(R_rel_start, sequence_angleStates) 
    "初始时间的可能角度状态";
SI.Angle phi[3](start=phi_start, each stateSelect=if enforceStates and not 
        useQuaternions then StateSelect.always else StateSelect.never) 
    "虚拟值或将frame_a旋转到frame_b的三个角度";
SI.AngularVelocity phi_d[3](each stateSelect=if enforceStates and not 
        useQuaternions then StateSelect.always else StateSelect.never) 
    "=der(phi)";
SI.AngularAcceleration phi_dd[3] "=der(phi_d)";

// 其他声明
SI.AngularVelocity w_rel[3](start=Frames.resolve2(R_rel_start, w_rel_a_start), 
        fixed = fill(w_rel_a_fixed,3), each stateSelect=if 
        enforceStates and useQuaternions then StateSelect.always else 
        StateSelect.never) 
    "虚拟值或frame_b相对于frame_a的相对角速度，解析在frame_b中";
Frames.Orientation R_rel 
    "虚拟值或从frame_a到frame_b的相对方向对象";
Frames.Orientation R_rel_inv 
    "虚拟值或从frame_b到frame_a的相对方向对象";

initial equation
  if angles_fixed then
    if not enforceStates then
      // 在球形对象中未定义状态
      zeros(3) = Frames.Orientation.equalityConstraint(Frames.absoluteRotation(frame_a.R, R_rel_start), frame_b.R);
    elseif useQuaternions then
      // 使用四元数 Q 作为状态
      zeros(3) = Frames.Quaternions.Orientation.equalityConstraint(Q, Q_start);
    else
      // 使用三个角度 'phi' 作为状态
      phi = phi_start;
    end if;
  end if;

  if z_rel_a_fixed then
    // 初始化加速度变量
    der(w_rel) = Frames.resolve2(R_rel_start, z_rel_a_start);
  end if;

equation
  // 扭矩平衡
  zeros(3) = frame_a.t;
  zeros(3) = frame_b.t;

  if enforceStates then
    Connections.branch(frame_a.R, frame_b.R);

    frame_b.r_0 = frame_a.r_0;
    if Connections.rooted(frame_a.R) then
      R_rel_inv = Frames.nullRotation();
      frame_b.R = Frames.absoluteRotation(frame_a.R, R_rel);
      zeros(3) = frame_a.f + Frames.resolve1(R_rel, frame_b.f);
    else
      R_rel_inv = Frames.inverseRotation(R_rel);
      frame_a.R = Frames.absoluteRotation(frame_b.R, R_rel_inv);
      zeros(3) = frame_b.f + Frames.resolve2(R_rel, frame_a.f);
    end if;

    // 计算相对方向对象
    if useQuaternions then
      // 使用四元数作为状态(带动态状态选择)
      {0} = Frames.Quaternions.orientationConstraint(Q);
      w_rel = Frames.Quaternions.angularVelocity2(Q, der(Q));
      R_rel = Frames.from_Q(Q, w_rel);

      // 虚拟值
      phi = zeros(3);
      phi_d = zeros(3);
      phi_dd = zeros(3);

    else
      // 使用角度作为状态
      phi_d = der(phi);
      phi_dd = der(phi_d);
      R_rel = Frames.axesRotations(sequence_angleStates, phi, phi_d);
      w_rel = Frames.angularVelocity2(R_rel);

      // 虚拟值
      Q = zeros(4);
    end if;

  else
  // 球形连接没有状态
  frame_b.r_0 = frame_a.r_0;
  //frame_b.r_0 = transpose(frame_b.R.T)*(frame_b.R.T*(transpose(frame_a.R.T)*(frame_a.R.T*frame_a.r_0)));

  zeros(3) = frame_a.f + Frames.resolveRelative(frame_b.f, frame_b.R, frame_a.R);

  if w_rel_a_fixed or z_rel_a_fixed then
    w_rel = Frames.angularVelocity2(frame_b.R) - Frames.resolve2(frame_b.R, 
      Frames.angularVelocity1(frame_a.R));
  else
    w_rel = zeros(3);
  end if;

  // 虚拟值
  R_rel = Frames.nullRotation();
  R_rel_inv = Frames.nullRotation();
  Q = zeros(4);
  phi = zeros(3);
  phi_d = zeros(3);
  phi_dd = zeros(3);
end if;

  annotation (
    Documentation(info="<html>
<p>
具有<strong>3个约束条件</strong>的运动副，定义了frame_a的原点和frame_b的原点重合。
默认情况下，此运动副仅定义3个约束条件，没有任何潜在状态变量。
如果在“高级”菜单中将参数<strong>enforceStates</strong>设置为<strong>true</strong>，则引入三个状态变量。
根据参数<strong>useQuaternions</strong>的不同，这些状态变量可以是四元数和相对角速度，或者是3个角度和角度导数。
在后一种情况下，frame_b的方向通过沿参数矢量“sequence_angleStates”(默认为{1,2,3}，即Cardan角序列)定义的轴旋转frame_a，绕用作状态的角度旋转到达frame_b。
例如，默认情况下将frame_a的x轴围绕angles[1]旋转，新的y轴围绕angles[2]旋转，新的z轴围绕angles[3]旋转，到达frame_b。
如果角度用作状态变量，则存在一个微小的缺点，即存在奇异配置导致除以零。
</p>
<p>
如果此运动副用于<strong>链</strong>结构，则Modelica转换器必须选择构件的方向坐标作为状态变量，如果使用默认设置。
通常最好将球副中的相对坐标用作状态变量，因此在这种情况下，参数enforceStates可能设置为<strong>true</strong>。
</p>
<p>
如果此运动副用于<strong>运动环</strong>结构，则默认设置会导致一个<strong>切割运动副</strong>，它将运动环中独立的运动学部分断开，并由该运动副的约束连接在一起。
结果，Modelica转换器将首先尝试在运动环的其余部分的运动副中选择3个广义坐标和其导数作为状态变量，如果不可能，例如因为运动环中只有球副，将从运动环的构件中选择坐标作为状态变量。
</p>
<p>
下图显示了球副的动画。
浅蓝色坐标系是frame_a，深蓝色坐标系是frame_b的运动副。
(此处：angles_start={45,45,45}<sup>o</sup>)。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Spherical.png\">
</div>
</html>"), 
         Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Ellipse(
          extent={{-70,-70},{70,70}}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={192,192,192}), 
        Ellipse(
          extent={{-49,-50},{51,50}}, 
          lineColor={128,128,128}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{30,70},{71,-68}}, 
          lineColor={255,255,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{-100,10},{-68,-10}}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          fillColor={192,192,192}), 
        Rectangle(
          extent={{23,10},{100,-10}}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          fillColor={192,192,192}), 
        Ellipse(
          extent={{-24,25},{26,-25}}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={160,160,164}), 
        Text(
          extent={{-150,-115},{150,-75}}, 
          textString="%name", 
          textColor={0,0,255})}));
end Spherical;