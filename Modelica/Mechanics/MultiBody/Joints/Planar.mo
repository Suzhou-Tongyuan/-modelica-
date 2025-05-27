within Modelica.Mechanics.MultiBody.Joints;
model Planar "平面副(3个自由度，6个潜在状态变量)"
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
  parameter Boolean animation=true "=true，如果要启用动画";
  parameter Modelica.Mechanics.MultiBody.Types.Axis n={0,0,1} 
    "与不受约束的平面垂直的轴，以frame_a解析(与frame_b中相同)" 
    annotation (Evaluate=true);
  parameter Modelica.Mechanics.MultiBody.Types.Axis n_x={1,0,0} 
    "指向平面x轴方向的矢量，在frame_a中解析(n_x应与n垂直)" 
    annotation (Evaluate=true);
  parameter SI.Distance cylinderLength=world.defaultJointLength 
    "转动副（圆柱体）的长度" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
  parameter SI.Distance cylinderDiameter=world.defaultJointWidth 
    "转动副（圆柱体）的直径" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
  input Types.Color cylinderColor=Modelica.Mechanics.MultiBody.Types.Defaults.JointColor 
    "转动副（圆柱体）的颜色" 
    annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));
  parameter SI.Distance boxWidth=0.3*cylinderDiameter 
    "平移副（立方体）的宽度" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
  parameter SI.Distance boxHeight=boxWidth "平移副（立方体）的高度" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
  input Types.Color boxColor=Modelica.Mechanics.MultiBody.Types.Defaults.JointColor 
    "平移副（立方体）的颜色" 
    annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));
  parameter StateSelect stateSelect=StateSelect.prefer 
    "优先使用运动副坐标(s_x、s_y、phi、v_x、v_y、w)作为状态变量" annotation(Dialog(tab="高级"));

  Prismatic prismatic_x(
    stateSelect=StateSelect.never, 
    n=(cross(cross(n, n_x), n)), 
    animation=false) annotation (Placement(transformation(extent={{-69,-20},{
            -29,20}})));
  Prismatic prismatic_y(
    stateSelect=StateSelect.never, 
    n=(cross(n, n_x)), 
    animation=false) annotation (Placement(transformation(
        origin={0,50}, 
        extent={{-20,-20},{20,20}}, 
        rotation=90)));
  Revolute revolute(
    stateSelect=StateSelect.never, 
    n=n, 
    animation=false) annotation (Placement(transformation(extent={{41,-20},{
            81,20}})));

  SI.Position s_x(start=0, stateSelect=stateSelect) 
    "从frame_a开始沿第一个平动运动副的相对距离";
  SI.Position s_y(start=0, stateSelect=stateSelect) 
    "从第一个平动运动副开始沿第二个平动运动副的相对距离";
  SI.Angle phi(start=0, stateSelect=stateSelect) 
    "从frame_a到frame_b的相对旋转角度";
  SI.Velocity v_x(start=0, stateSelect=stateSelect) 
    "s_x的一阶导数(s_x方向的相对速度)";
  SI.Velocity v_y(start=0, stateSelect=stateSelect) 
    "s_y的一阶导数(s_y方向的相对速度)";
  SI.AngularVelocity w(start=0, stateSelect=stateSelect) 
    "phi的一阶导数(相对角速度)";
  SI.Acceleration a_x(start=0) 
    "s_x的二阶导数(s_x方向的相对加速度)";
  SI.Acceleration a_y(start=0) 
    "s_y的二阶导数(s_y方向的相对加速度)";
  SI.AngularAcceleration wd(start=0) 
    "phi的二阶导数(相对角加速度)";

protected
  parameter Integer ndim=if world.enableAnimation and animation then 1 else 0;
  parameter Real e[3](each final unit="1")=Modelica.Math.Vectors.normalize(
                                       n);
protected
  Visualizers.Advanced.Shape box_x[ndim](
    each shapeType="box", 
    each color=boxColor, 
    each length=prismatic_x.s, 
    each width=boxWidth, 
    each height=boxWidth, 
    each lengthDirection=prismatic_x.e, 
    each widthDirection={0,1,0}, 
    each r=frame_a.r_0, 
    each R=frame_a.R) annotation (Placement(transformation(extent={{-80,30},{
            -60,50}})));
  Visualizers.Advanced.Shape box_y[ndim](
    each shapeType="box", 
    each color=boxColor, 
    each length=prismatic_y.s, 
    each width=boxWidth, 
    each height=boxWidth, 
    each lengthDirection=prismatic_y.e, 
    each widthDirection={1,0,0}, 
    each r=prismatic_y.frame_a.r_0, 
    each R=prismatic_y.frame_a.R) annotation (Placement(transformation(extent={{-46,69}, 
            {-26,89}})));
  Visualizers.Advanced.Shape cylinder[ndim](
    each shapeType="cylinder", 
    each color=cylinderColor, 
    each length=cylinderLength, 
    each width=cylinderDiameter, 
    each height=cylinderDiameter, 
    each lengthDirection=n, 
    each widthDirection={0,1,0}, 
    each r_shape=-e*(cylinderLength/2), 
    each r=revolute.frame_b.r_0, 
    each R=revolute.frame_b.R) annotation (Placement(transformation(extent={{50,30}, 
            {70,50}})));
equation
  s_x = prismatic_x.s;
  s_y = prismatic_y.s;
  phi = revolute.phi;
  v_x = der(s_x);
  v_y = der(s_y);
  w   = der(phi);
  a_x = der(v_x);
  a_y = der(v_y);
  wd  = der(w);

  connect(frame_a, prismatic_x.frame_a) 
    annotation (Line(


      points={{-100,0},{-84,0},{-84,0},{-69,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(prismatic_x.frame_b, prismatic_y.frame_a) annotation (Line(
      points={{-29,0},{0,0},{0,30}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(prismatic_y.frame_b, revolute.frame_a) annotation (Line(
      points={{0,70},{0,80},{30,80},{30,0},{41,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(revolute.frame_b, frame_b) 
    annotation (Line(
      points={{81,0},{92,0},{92,0},{100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  annotation (
    Documentation(info="<html>
<p>
在运动副中frame_b可以在平面内移动，并可以围绕垂直于平面的轴旋转。
平面由矢量n和指向平面x轴的矢量n_x定义。
当s_x=prismatic_x.s=0，s_y=prismatic_y.s=0和phi=revolute.phi=0时，frame_a和frame_b重合。
此运动副具有以下潜在状态变量：</p>
<ul>
<li>沿轴n_x的相对距离s_x=prismatic_x.s[m]，</li>
<li>沿轴n_y=cross(n,n_x)的相对距离s_y=prismatic_y.s[m]，</li>
<li>围绕轴n的相对角度phi=revolute.phi[rad]，</li>
<li>相对速度v_x(=der(s_x))，</li>
<li>相对速度v_y(=der(s_y))，</li>
<li>相对角速度w(=der(phi))</li>
</ul>
<p>
它们被用作从工具中自动选择状态的候选项。
可以通过在<strong>高级</strong>菜单中设置\"stateSelect=StateSelect.<strong>always</strong>\"来强制执行此操作。
通常情况下，状态变量会自动选择。
在某些情况下，特别是当存在闭合运动链时，使用\"StateSelect.always\"设置可能会稍微更有效。
</p>
<p>
在以下图中显示了平面副的动画。
浅蓝色坐标系是frame_a，深蓝色坐标系是frame_b。
黑色箭头是参数矢量\"n\"和\"n_x\"(这里：n={0,1,0}，n_x={0,0,1}，s_x.start=0.5，s_y.start=0.5，phi.start=45<sup>o</sup>)。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Planar.png\">
</div>
</html>"), 
         Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-30,-60},{-10,60}}, 
          pattern=LinePattern.None, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{10,-60},{30,60}}, 
          pattern=LinePattern.None, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{-100,-10},{-30,10}}, 
          pattern=LinePattern.None, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{100,-10},{30,10}}, 
          pattern=LinePattern.None, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-150,-75},{150,-105}}, 
          textString="n=%n"), 
        Text(
          extent={{-150,110},{150,70}}, 
          textString="%name", 
          textColor={0,0,255})}));
end Planar;