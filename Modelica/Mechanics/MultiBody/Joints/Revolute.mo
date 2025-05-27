within Modelica.Mechanics.MultiBody.Joints;
model Revolute 
  "转动副(1个转动自由度，2个潜在状态变量，可选轴接口)"

  Modelica.Mechanics.Rotational.Interfaces.Flange_a axis if useAxisFlange 
    "驱动转动副的一维旋转接口" 
    annotation (Placement(transformation(extent={{10,90},{-10,110}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b support if useAxisFlange 
    "驱动支撑的一维旋转接口(假定固定在全局坐标系中，而不是转动副中)" 
    annotation (Placement(transformation(extent={{-70,90},{-50,110}})));

  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a 
    "接口坐标系a，具有一个局部力和一个局部力矩" 
    annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_b 
    "接口坐标系b，具有一个局部力和一个局部力矩" 
    annotation (Placement(transformation(extent={{84,-16},{116,16}})));

  parameter Boolean useAxisFlange=false "=true，如果启用轴接口" 
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean animation=true 
    "=true，如果启用动画(显示为圆柱体)";
  parameter Modelica.Mechanics.MultiBody.Types.Axis n={0,0,1} 
    "旋转轴，在frame_a中解析(与frame_b中相同)" 
    annotation (Evaluate=true);
  parameter SI.Distance cylinderLength=world.defaultJointLength 
    "转动副（圆柱体）的长度" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
  parameter SI.Distance cylinderDiameter=world.defaultJointWidth 
    "转动副（圆柱体）的直径" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
  input Modelica.Mechanics.MultiBody.Types.Color cylinderColor=Modelica.Mechanics.MultiBody.Types.Defaults.JointColor 
    "转动副（圆柱体）的颜色" 
    annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));
  input Modelica.Mechanics.MultiBody.Types.SpecularCoefficient 
    specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射(=0：光完全被吸收)" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
  parameter StateSelect stateSelect=StateSelect.prefer 
    "优先使用连接件角度phi和w=der(phi)作为状态变量" annotation(Dialog(tab="高级"));

  SI.Angle phi(start=0, final stateSelect=stateSelect) 
    "从frame_a到frame_b的相对旋转角度" 
     annotation (unassignedMessage="
无法确定转动副的旋转角度phi。
可能的原因为：
-转动副所连接的任一侧的部件缺少非零质量。
-定义了过多的StateSelect.always，并且模型的自由度少于此设置指定的自由度(请移除所有StateSelect.always设置)。
");
  SI.AngularVelocity w(start=0, stateSelect=stateSelect) 
    "角度phi的第一阶导数(相对角速度)";
  SI.AngularAcceleration a(start=0) 
    "角度phi的第二阶导数(相对角加速度)";
  SI.Torque tau "绕旋转轴方向的驱动力矩";
  SI.Angle angle "=phi";

protected
  outer Modelica.Mechanics.MultiBody.World world;
  parameter Real e[3](each final unit="1")=Modelica.Math.Vectors.normalizeWithAssert(n) 
    "沿旋转轴方向的单位矢量，在frame_a中解析(与frame_b中相同)";
  Frames.Orientation R_rel 
    "从frame_a到frame_b的相对方向对象，或从frame_b到frame_a的相对方向对象";
  Visualizers.Advanced.Shape cylinder(
    shapeType="cylinder", 
    color=cylinderColor, 
    specularCoefficient=specularCoefficient, 
    length=cylinderLength, 
    width=cylinderDiameter, 
    height=cylinderDiameter, 
    lengthDirection=e, 
    widthDirection={0,1,0}, 
    r_shape=-e*(cylinderLength/2), 
    r=frame_a.r_0, 
    R=frame_a.R) if world.enableAnimation and animation;

protected
  Modelica.Mechanics.Rotational.Components.Fixed fixed 
    "支撑接口固定在地面上" 
    annotation (Placement(transformation(extent={{-70,70},{-50,90}})));
  Rotational.Interfaces.InternalSupport internalAxis(tau=tau) 
    annotation (Placement(transformation(extent={{-10,90},{10,70}})));
  Rotational.Sources.ConstantTorque constantTorque(tau_constant=0) if not useAxisFlange 
    annotation (Placement(transformation(extent={{40,70},{20,90}})));
equation
  Connections.branch(frame_a.R, frame_b.R);

  assert(cardinality(frame_a) > 0, 
    "转动副的连接器frame_a未连接");
  assert(cardinality(frame_b) > 0, 
    "转动副的连接器frame_b未连接");

  angle = phi;
  w = der(phi);
  a = der(w);

  // frame_a 和 frame_b 之间的关系
  frame_b.r_0 = frame_a.r_0;

  if Connections.rooted(frame_a.R) then
    R_rel = Frames.planarRotation(e, phi, w);
    frame_b.R = Frames.absoluteRotation(frame_a.R, R_rel);
    frame_a.f = -Frames.resolve1(R_rel, frame_b.f);
    frame_a.t = -Frames.resolve1(R_rel, frame_b.t);
  else
    R_rel = Frames.planarRotation(-e, phi, w);
    frame_a.R = Frames.absoluteRotation(frame_b.R, R_rel);
    frame_b.f = -Frames.resolve1(R_rel, frame_a.f);
    frame_b.t = -Frames.resolve1(R_rel, frame_a.t);
  end if;

  // 达朗贝尔原理
  tau = -frame_b.t*e;

  // 内部连接件的连接
  phi = internalAxis.phi;


  connect(fixed.flange, support) annotation (Line(
      points={{-60,80},{-60,100}}));
  connect(internalAxis.flange, axis) annotation (Line(
      points={{0,80},{0,100}}));
  connect(constantTorque.flange, internalAxis.flange) annotation (Line(
      points={{20,80},{0,80}}));
  annotation (
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, 
preserveAspectRatio=true, 
grid={2,2}),graphics = {Rectangle(origin={-65,0}, 
lineColor={64,64,64}, 
fillColor={255,255,255}, 
fillPattern=FillPattern.HorizontalCylinder, 
extent={{-35,-60},{35,60}}, 
radius=10), Rectangle(origin={65,0}, 
lineColor={64,64,64}, 
fillColor={255,255,255}, 
fillPattern=FillPattern.HorizontalCylinder, 
extent={{-35,-60},{35,60}}, 
radius=10), Rectangle(origin={-65,0}, 
lineColor={64,64,64}, 
extent={{-35,60},{35,-60}}, 
radius=10), Rectangle(origin={65,0}, 
lineColor={64,64,64}, 
extent={{-35,60},{35,-60}}, 
radius=10), Text(origin={-72,1.5}, 
lineColor={128,128,128}, 
extent={{-18,12.5},{18,-12.5}}, 
textString="a", 
textColor={128,128,128}), Text(origin={69,-1.5}, 
lineColor={128,128,128}, 
extent={{-18,12.5},{18,-12.5}}, 
textString="b", 
textColor={128,128,128}), Line(visible=useAxisFlange, 
origin={-20,70}, 
points={{0,10},{0,-10}}), Line(visible=useAxisFlange, 
origin={20,70}, 
points={{0,10},{0,-10}}), Rectangle(visible=useAxisFlange, 
origin={0,75}, 
fillColor={192,192,192}, 
fillPattern=FillPattern.VerticalCylinder, 
extent={{-10,25},{10,-25}}), Polygon(visible=useAxisFlange, 
origin={0,40}, 
lineColor={64,64,64}, 
fillColor={192,192,192}, 
fillPattern=FillPattern.Solid, 
points={{-10,-10},{10,-10},{30,10},{-30,10},{-10,-10}}), Rectangle(origin={0,0.5}, 
lineColor={64,64,64}, 
fillColor={192,192,192}, 
fillPattern=FillPattern.Solid, 
extent={{-30,10.5},{30,-10.5}}), Polygon(visible=useAxisFlange, 
origin={20,0}, 
lineColor={64,64,64}, 
fillColor={192,192,192}, 
fillPattern=FillPattern.Solid, 
points={{-10,30},{10,50},{10,-50},{-10,-30},{-10,30}}), Text(origin={0,-95}, 
extent={{-150,-15},{150,15}}, 
textString="n=%n"), Text(visible=useAxisFlange, 
origin={0,-135}, 
lineColor={0,0,255}, 
extent={{-150,-20},{150,20}}, 
textString="%name", 
textColor={0,0,255}), Line(visible=useAxisFlange, 
origin={-40,65}, 
points={{20,5},{-20,5},{-20,-5}}), Line(visible=useAxisFlange, 
origin={35,65}, 
points={{-15,5},{15,5},{15,-5}}), Line(visible=useAxisFlange, 
origin={-60,100}, 
points={{-30,0},{30,0}}), Line(visible=useAxisFlange, 
origin={-40,90}, 
points={{10,10},{-10,-10}}), Line(visible=useAxisFlange, 
origin={-59.5,90}, 
points={{10.5,10},{-10.5,-10}}), Line(visible=useAxisFlange, 
origin={-80,90}, 
points={{10,10},{-10,-10}}), Text(visible=not useAxisFlange, 
origin={0,90}, 
lineColor={0,0,255}, 
extent={{-150,-20},{150,20}}, 
textString="%name", 
textColor={0,0,255})}), 
    Documentation(info="<html>

<p>
转动副，其中frame_b围绕固定在frame_a中的轴n旋转。
当旋转角度\"phi = 0\"时，两个坐标系重合。
</p>

<p>
可选地，可以通过参数<strong>useAxisFlange</strong>启用两个额外的一维机械接口(接口\"axis\"表示驱动接口，接口\"support\"表示轴承)。
可以通过参数<strong>useAxisFlange</strong>启用。
启用的轴接口可以使用<a href=\"modelica://Modelica.Mechanics.Rotational\">Modelica.Mechanics.Rotational</a>库中的元素进行驱动。
</p>

<p>
在\"高级\"菜单中，可以通过参数<strong>stateSelect</strong>定义旋转角度\"phi\"及其导数是否要作为状态变量，设置stateSelect=StateSelect.always。
默认为StateSelect.prefer，使用转动副角度及其导数作为首选状态变量。
状态通常会自动选择。
在某些情况下，特别是当存在闭合运动链时，使用StateSelect.always设置可能会稍微更有效。
</p>

<p>
如果存在<strong>平面环</strong>，例如，由4个转动副组成，其中连接件轴都平行于彼此，则不再存在唯一的数学解，符号算法将失败。
通常，会打印出指出此情况的错误消息。
在这种情况下，必须用Joints.RevolutePlanarLoopConstraint连接件替换运动环中的一个转动副。
其效果是从通常的转动副的5个约束中去除3个约束，并用适当的已知变量替换(例如，沿旋转轴方向的力被视为已知变量，其值为零；对于标准的转动副，这种力是未知量)。
</p>

<p>
下图显示了转动副的动画。
淡蓝色坐标系是frame_a，深蓝色坐标系是frame_b。
黑色箭头是参数矢量\"n\"定义的平动轴(这里：n={0,0,1}，phi.start=45<sup>o</sup>)。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Revolute.png\">
</div>

</html>"));
end Revolute;