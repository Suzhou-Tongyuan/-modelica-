within Modelica.Mechanics.MultiBody.Joints;
model Universal "万向节(2自由度，4个潜在状态变量)"
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
  parameter Boolean animation=true "=true，如果启用动画";
  parameter Modelica.Mechanics.MultiBody.Types.Axis n_a={1,0,0} 
    "转动副1的轴方向向量，在frame_a中的解析" annotation (Evaluate=true);
  parameter Modelica.Mechanics.MultiBody.Types.Axis n_b={0,1,0} 
    "转动副2的轴方向向量，在frame_a中的解析" annotation (Evaluate=true);

  parameter SI.Distance cylinderLength=world.defaultJointLength 
    "转动副（圆柱体）的长度" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
  parameter SI.Distance cylinderDiameter=world.defaultJointWidth 
    "转动副（圆柱体）的直径" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
  input Types.Color cylinderColor=Modelica.Mechanics.MultiBody.Types.Defaults.JointColor 
    "转动副（圆柱体）的颜色" 
    annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射(=0：光完全被吸收)" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
  parameter StateSelect stateSelect=StateSelect.prefer 
    "优先使用运动副坐标(phi_a、phi_b、w_a、w_b)作为状态变量" annotation(Dialog(tab="高级"));

  Modelica.Mechanics.MultiBody.Joints.Revolute revolute_a(
    n=n_a, 
    stateSelect=StateSelect.never, 
    cylinderDiameter=cylinderDiameter, 
    cylinderLength=cylinderLength, 
    cylinderColor=cylinderColor, 
    specularCoefficient=specularCoefficient, 
    animation=animation) annotation (Placement(transformation(extent={{-60,-25},{-10,25}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute_b(
    n=n_b, 
    stateSelect=StateSelect.never, 
    animation=animation, 
    cylinderDiameter=cylinderDiameter, 
    cylinderLength=cylinderLength, 
    cylinderColor=cylinderColor, 
    specularCoefficient=specularCoefficient) annotation (Placement(transformation(
        origin={35,45}, 
        extent={{-25,-25},{25,25}}, 
        rotation=90)));

  SI.Angle phi_a(start=0, stateSelect=stateSelect) 
    "从frame_a到中间坐标系的相对旋转角度";
  SI.Angle phi_b(start=0, stateSelect=stateSelect) 
    "从中间坐标系到frame_b的相对旋转角度";
  SI.AngularVelocity w_a(start=0, stateSelect=stateSelect) 
    "角度phi_a的一阶导数(相对角速度a)";
  SI.AngularVelocity w_b(start=0, stateSelect=stateSelect) 
    "角度phi_b的一阶导数(相对角速度b)";
  SI.AngularAcceleration a_a(start=0) 
    "角度phi_a的二阶导数(相对角加速度a)";
  SI.AngularAcceleration a_b(start=0) 
    "角度phi_b的二阶导数(相对角加速度b)";


equation
  phi_a = revolute_a.phi;
  phi_b = revolute_b.phi;
  w_a = der(phi_a);
  w_b = der(phi_b);
  a_a = der(w_a);
  a_b = der(w_b);
  connect(frame_a, revolute_a.frame_a) 
    annotation (Line(
      points={{-100,0},{-60,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(revolute_b.frame_b, frame_b) annotation (Line(
      points={{35,70},{35,90},{70,90},{70,0},{100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(revolute_a.frame_b, revolute_b.frame_a) annotation (Line(
      points={{-10,0},{35,0},{35,20}}, 
      color={95,95,95}, 
      thickness=0.5));
  annotation (
    Documentation(info="<html>
<p>
在这个运动副中，frame_a绕着固定在frame_a中的轴n_a旋转，而frame_b绕着固定在frame_b中的轴n_b旋转。
当\"revolute_a.phi=0\"和\"revolute_b.phi=0\"时，两个坐标系重合。
此运动副具有以下潜在状态变量;</p>
<ul>
<li>相对角度phi_a=revolute_a.phi[rad]，围绕轴n_a旋转，</li>
<li>相对角度phi_b=revolute_b.phi[rad]，围绕轴n_b旋转，</li>
<li>相对角速度w_a(=der(phi_a))</li>
<li>相对角速度w_b(=der(phi_b))。
</li>
</ul>
<p>
它们被用作工具中自动选择状态的候选项。
这可以通过在<strong>高级</strong>菜单中设置\"stateSelect=StateSelect.<strong>always</strong>\"来强制执行。
通常情况下，状态变量会自动选择。
在某些情况下，特别是当存在闭合运动链时，使用\"StateSelect.always\"设置可能会略微更有效。
</p>

<p>
在下图中显示了万向节的动画中。
浅蓝色坐标系是frame_a，而深蓝色坐标系是运动副的frame_b(此处：n_a={0,0,1}，n_b={0,1,0}，phi_a.start=90<sup>o</sup>，phi_b.start=45<sup>o</sup>)。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Universal.png\">
</div>
</html>"), 
    Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,15},{-65,-15}}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          fillColor={235,235,235}), 
        Ellipse(
          extent={{-80,-80},{80,80}}, 
          lineColor={160,160,164}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-60,-60},{60,60}}, 
          lineColor={160,160,164}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-150,-80},{150,-120}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Rectangle(
          extent={{12,82},{80,-82}}, 
          lineColor={255,255,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{56,15},{100,-15}}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          fillColor={235,235,235}), 
        Line(
          points={{12,78},{12,-78}}, 
          thickness=0.5), 
        Ellipse(
          extent={{-52,-40},{80,40}}, 
          lineColor={160,160,164}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-32,-20},{60,26}}, 
          lineColor={160,160,164}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Polygon(
          points={{-22,-54},{-60,0},{-22,50},{40,52},{-22,-54}}, 
          pattern=LinePattern.None, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Line(
          points={{12,78},{12,-20}}, 
          thickness=0.5), 
        Line(
          points={{32,38},{-12,-36}}, 
          thickness=0.5)}));
end Universal;