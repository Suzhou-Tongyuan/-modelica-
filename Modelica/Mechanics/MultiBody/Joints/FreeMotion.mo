within Modelica.Mechanics.MultiBody.Joints;
model FreeMotion 
  "自由运动副(6个自由度，12个潜在状态变量)"

  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;

  parameter Boolean animation = true 
    "=true，如果启用动画(显示从frame_a到frame_b的箭头)";

  SI.Position r_rel_a[3](start={0,0,0}, each stateSelect=if enforceStates then 
              StateSelect.always else StateSelect.prefer) 
    "从frame_a原点到frame_b原点的位置矢量，在frame_a中解析" 
    annotation(Dialog(group="初始值", showStartAttribute=true));
  SI.Velocity v_rel_a[3](start={0,0,0}, each stateSelect=if enforceStates then StateSelect.always else 
              StateSelect.prefer) 
    "=der(r_rel_a)，即frame_b相对于frame_a的原点的速度，解析在frame_a中" 
    annotation(Dialog(group="初始值", showStartAttribute=true));
  SI.Acceleration a_rel_a[3](start={0,0,0}) "=der(v_rel_a)" 
    annotation(Dialog(group="初始值", showStartAttribute=true));

  parameter Boolean angles_fixed = false 
    "=true，如果angles_start用作初始值，否则用作猜测值" 
    annotation(Evaluate=true, choices(checkBox=true), Dialog(group="初始值"));
  parameter SI.Angle angles_start[3]={0,0,0} 
    "旋转frame_a围绕'sequence_start'轴到frame_b的初始角度值" 
    annotation (Dialog(group="初始值"));
  parameter Types.RotationSequence sequence_start={1,2,3} 
    "将frame_a旋转到frame_b的旋转序列在初始时间" 
    annotation (Evaluate=true, Dialog(group="初始值"));

  parameter Boolean w_rel_a_fixed = false 
    "=true，如果w_rel_a_start用作初始值，否则用作猜测值" 
    annotation(Evaluate=true, choices(checkBox=true), Dialog(group="初始值"));
  parameter SI.AngularVelocity w_rel_a_start[3]={0,0,0} 
    "frame_b相对于frame_a的角速度的初始值，在frame_a中解析" 
    annotation (Dialog(group="初始值"));

  parameter Boolean z_rel_a_fixed = false 
    "=true，如果z_rel_a_start用作初始值，否则用作猜测值" 
    annotation(Evaluate=true, choices(checkBox=true), Dialog(group="初始值"));
  parameter SI.AngularAcceleration z_rel_a_start[3]={0,0,0} 
    "角加速度z_rel_a的初始值=der(w_rel_a)" 
    annotation (Dialog(group="初始值"));

  input Types.Color arrowColor=Modelica.Mechanics.MultiBody.Types.Defaults.SensorColor 
    "箭头的颜色" 
    annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射(=0：光完全吸收)" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
  parameter Boolean enforceStates=true 
    "=true，如果frame_a和frame_b之间的相对变量应该用作状态" 
    annotation (Evaluate=true, Dialog(tab="高级"));
  parameter Boolean useQuaternions=true 
    "=true，如果四元数应该用作状态，否则使用3个角度作为状态" 
    annotation (Evaluate=true, Dialog(tab="高级"));
  parameter Types.RotationSequence sequence_angleStates={1,2,3} 
    "将frame_a旋转到frame_b，围绕用作状态的3个角度的旋转序列" 
     annotation (Evaluate=true, Dialog(tab="高级", enable=not 
          useQuaternions));

final parameter Frames.Orientation R_rel_start= 
      Modelica.Mechanics.MultiBody.Frames.axesRotations(sequence_start, angles_start,zeros(3)) 
    "初始时刻从frame_a到frame_b的方向对象";

protected
  Visualizers.Advanced.Arrow arrow(
    r_head=r_rel_a, 
    color=arrowColor, 
    specularCoefficient=specularCoefficient, 
    r=frame_a.r_0, 
    R=frame_a.R) if world.enableAnimation and animation;

  // 四元数的声明(如果四元数未被使用则为虚拟)
  parameter Frames.Quaternions.Orientation Q_start=Frames.to_Q(R_rel_start) 
    "初始时刻从frame_a到frame_b的四元数方向对象";
  Frames.Quaternions.Orientation Q(start=Q_start, each stateSelect=if 
        enforceStates then (if useQuaternions then StateSelect.prefer else 
        StateSelect.never) else StateSelect.default) 
    "从frame_a到frame_b的四元数方向对象(如果四元数未被用作状态，则为虚拟值)";

  // 3个角度的声明
  parameter SI.Angle phi_start[3]=if sequence_start[1] == 
      sequence_angleStates[1] and sequence_start[2] == sequence_angleStates[2] 
       and sequence_start[3] == sequence_angleStates[3] then angles_start else 
            Frames.axesRotationsAngles(R_rel_start, 
      sequence_angleStates) "初始时刻的潜在角度状态";
  SI.Angle phi[3](start=phi_start, each stateSelect=if enforceStates then (if 
        useQuaternions then StateSelect.never else StateSelect.always) else 
        StateSelect.prefer) 
    "将frame_a旋转到frame_b的虚拟或3个角度";
  SI.AngularVelocity phi_d[3](each stateSelect=if enforceStates then (if 
        useQuaternions then StateSelect.never else StateSelect.always) else 
        StateSelect.prefer) "=der(phi)";
  SI.AngularAcceleration phi_dd[3] "=der(phi_d)";

  // 其他声明
  SI.AngularVelocity w_rel_b[3](start=Frames.resolve2(R_rel_start, w_rel_a_start), 
                                fixed=fill(w_rel_a_fixed,3), 
                                each stateSelect=if enforceStates then 
                                (if useQuaternions then StateSelect.always else 
                                StateSelect.avoid) else StateSelect.prefer) 
    "frame_b相对于frame_a的虚拟或相对角速度，解析在frame_b中";
  Frames.Orientation R_rel 
    "从frame_a到frame_b的虚拟或相对方向对象";
  Frames.Orientation R_rel_inv 
    "从frame_b到frame_a的虚拟或相对方向对象";

initial equation
  if angles_fixed then
    // 初始化位置变量
    if not enforceStates then
      // 没有定义状态
      zeros(3) = Frames.Orientation.equalityConstraint(Frames.absoluteRotation(frame_a.R,R_rel_start),frame_b.R);
    elseif useQuaternions then
      // 使用四元数Q作为状态
      zeros(3) = Frames.Quaternions.Orientation.equalityConstraint(Q, Q_start);
    else
      // 使用3个角度'phi'作为状态
      phi = phi_start;
    end if;
  end if;

  if z_rel_a_fixed then
    // 初始化加速度变量
    der(w_rel_b) = Frames.resolve2(R_rel_start, z_rel_a_start);
  end if;


equation
  // 平动运动的运动微分方程
  der(r_rel_a) = v_rel_a;
  der(v_rel_a) = a_rel_a;

  // 运动关系
  frame_b.r_0 = frame_a.r_0 + Frames.resolve1(frame_a.R, r_rel_a);

  // 局部力和局部扭矩为零
  frame_a.f = zeros(3);
  frame_a.t = zeros(3);
  frame_b.f = zeros(3);
  frame_b.t = zeros(3);

  if enforceStates then
    Connections.branch(frame_a.R, frame_b.R);

    if Connections.rooted(frame_a.R) then
      R_rel_inv = Frames.nullRotation();
      frame_b.R = Frames.absoluteRotation(frame_a.R, R_rel);
    else
      R_rel_inv = Frames.inverseRotation(R_rel);
      frame_a.R = Frames.absoluteRotation(frame_b.R, R_rel_inv);
    end if;

    // 计算相对方向对象
    if useQuaternions then
      // 使用四元数作为状态(带有动态状态选择)
      {0} = Frames.Quaternions.orientationConstraint(Q);
      w_rel_b = Frames.Quaternions.angularVelocity2(Q, der(Q));
      R_rel = Frames.from_Q(Q, w_rel_b);

      // 虚拟值
      phi = zeros(3);
      phi_d = zeros(3);
      phi_dd = zeros(3);

    else
      // 使用角度作为状态
      phi_d = der(phi);
      phi_dd = der(phi_d);
      R_rel = Frames.axesRotations(sequence_angleStates, phi, phi_d);
      w_rel_b = Frames.angularVelocity2(R_rel);

      // 虚拟值
      Q = zeros(4);
    end if;

  else
    // 自由运动运动副没有状态
    if w_rel_a_fixed or z_rel_a_fixed then
      w_rel_b = Frames.angularVelocity2(frame_b.R) - Frames.resolve2(frame_b.
        R, Frames.angularVelocity1(frame_a.R));
    else
      // 虚拟值
      w_rel_b = zeros(3);
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
该运动副不约束frame_a和frame_b之间的运动。
若在frame_a和frame_b之间的相对距离和方向以及它们的导数将被用作状态变量时，这样自由运动副才有意义。
</p>
<p>
请注意，像Parts.Body、Parts.BodyShape这样的物体具有描述全局坐标系和体固定坐标系之间距离和方向及其导数的潜在状态变量。
因此，如果这些潜在状态变量合适，就不需要自由运动副。
</p>
<p>
FreeMotion对象的状态包括：</p>
<ul>
<li>相对位置矢量r_rel_a，从frame_a的原点到frame_b的原点，以frame_a的形式解析，并且frame_b的原点相对于frame_a的原点的相对速度v_rel_a，以frame_a的形式解析(=der(r_rel_a))。
</li>
<li>如果\"高级\"菜单中的参数useQuaternions为true(这是默认值)，则有4个四元数作为状态变量。
另外，相对角速度矢量的坐标是3个潜在状态变量。
<br>如果\"高级\"菜单中的参数useQuaternions为false，则有3个角度及其导数作为潜在状态变量。
通过围绕用作状态的角度旋转frame_a沿着参数矢量\"sequence_angleStates\"(默认值={1,2,3}，即Cardan角序列)定义的轴，计算出frame_b的方向。
例如，默认情况下将frame_a的x轴围绕angles[1]旋转，新的y轴围绕angles[2]旋转，新的z轴围绕angles[3]旋转，最终得到frame_b。
</li>
</ul>
<p>
四元数的微小缺点是4个四元数之间存在非线性约束方程。
因此，在模拟过程中至少必须解决一个非线性方程。
然而，工具可能会分析性地解决这个简单的约束方程。
将3个角度用作状态变量的缺点是存在一个奇异配置，其中将发生除以零的情况。
如果可以预先确定对于应用程序类来说，这个奇异配置在操作区域之外，那么可以通过设置useQuaternions=false将3个角度用作状态。
</p>
<p>
关于三维力学的教科书通常使用3个角度和角速度作为状态。
在这里并不是这样，因为如果useQuaternions=false，则使用3个角度及其导数作为状态。
然而对于实时模拟，积分器的离散化公式可能会被\"内联\"并与模型方程一起求解。
通过适当的符号转换，如果使用角度及其导数作为状态，而不是角度和角速度，其性能将得到显著提高。
</p>
<p>
如果在\"高级\"菜单中将参数enforceStates设置为true(默认值)，则根据参数useQuaternions和sequence_angleStates的设置，强制使用FreeMotion变量作为状态变量。
</p>
<p>
在下图中显示了自由运动副的动画。
浅蓝色坐标系是frame_a，深蓝色坐标系是联合的frame_b。
(这里：r_rel_a_start={0.5,0,0.5}，angles_start={45,45,45}°)。
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/FreeMotion.png\">
</div>

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
          extent={{150,-35},{-150,-75}}, 
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
end FreeMotion;