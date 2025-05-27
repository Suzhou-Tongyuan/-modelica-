within Modelica.Mechanics.MultiBody.Joints;
model Cylindrical 
  "圆柱副(2个自由度，4个潜在状态变量)"
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
  parameter Boolean animation=true 
    "=true，如果要启用动画(显示为圆柱)";
  parameter Modelica.Mechanics.MultiBody.Types.Axis n={1,0,0} 
    "圆柱轴，在frame_a中解析(与在frame_b中相同)" 
    annotation (Evaluate=true);
  parameter SI.Distance cylinderDiameter=world.defaultJointWidth 
    "圆柱直径" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
  input Types.Color cylinderColor=Modelica.Mechanics.MultiBody.Types.Defaults.JointColor 
    "圆柱颜色" 
    annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光反射(=0：光被完全吸收)" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
  parameter StateSelect stateSelect=StateSelect.prefer 
    "优先使用运动副坐标(phi、s、w、v)作为状态变量" annotation(Dialog(tab="高级"));

  Prismatic prismatic(
    n=n, 
    animation=false, 
    stateSelect=StateSelect.never) annotation (Placement(transformation(extent={{-70,-25},{
            -15,25}})));
  Revolute revolute(
    n=n, 
    animation=false, 
    stateSelect=StateSelect.never) annotation (Placement(transformation(extent={{10,-25},{
            65,25}})));

  SI.Position s(start=0, stateSelect=stateSelect) 
    "frame_a和frame_b之间的相对距离";
  SI.Angle phi(start=0, stateSelect=stateSelect) 
    "从frame_a到frame_b的相对旋转角度";
  SI.Velocity v(start=0, stateSelect=stateSelect) 
    "s的一阶导数(相对速度)";
  SI.AngularVelocity w(start=0, stateSelect=stateSelect) 
    "角度phi的一阶导数(相对角速度)";
  SI.Acceleration a(start=0) "s的二阶导数(相对加速度)";
  SI.AngularAcceleration wd(start=0) 
    "角度phi的二阶导数(相对角加速度)";

protected
  Visualizers.Advanced.Shape cylinder(
    shapeType="cylinder", 
    color=cylinderColor, 
    specularCoefficient=specularCoefficient, 
    length=prismatic.s, 
    width=cylinderDiameter, 
    height=cylinderDiameter, 
    lengthDirection=prismatic.n, 
    widthDirection={0,1,0}, 
    r=frame_a.r_0, 
    R=frame_a.R) if world.enableAnimation and animation 
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
equation
  phi = revolute.phi;
  w = der(phi);
  wd = der(w);
  s = prismatic.s;
  v = der(s);
  a = der(v);
  connect(frame_a, prismatic.frame_a) 
    annotation (Line(
      points={{-100,0},{-70,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(prismatic.frame_b, revolute.frame_a) 
    annotation (Line(
      points={{-15,0},{10,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(revolute.frame_b, frame_b) 
    annotation (Line(
      points={{65,0},{100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  annotation (
    Documentation(info="<html>
<p>
frame_b绕着固定在frame_a中的轴n旋转并沿轴n移动的运动副。
当“phi=revolute.phi=0”和“s=prismatic.s=0”时，两个坐标系重合。
这个运动副具有以下潜在状态变量;</p>
<ul>
<li>相对于轴n的相对角度phi[弧度]</li>
<li>沿轴n的相对距离s[米]</li>
<li>相对角速度w[rad/s](=der(phi))</li>
<li>相对速度v[米/秒](=der(s))</li>
</ul>
<p>
它们被用作工具自动选择状态的候选项。
或者可以通过在<strong>高级</strong>菜单中设置“stateSelect=StateSelect.<strong>always</strong>”来强制执行。
但通常会自动选择状态变量。
在某些情况下，特别是当存在闭合运动学环路时，使用“StateSelect.always”设置可能会更有效一些。
</p>
<p>
在下图中显示了圆柱副的动画。
浅蓝色坐标系是frame_a，深蓝色坐标系是frame_b的运动副。
黑色箭头是参数矢量“n”，定义了圆柱轴(这里：n={0,0,1})。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Cylindrical.png\">
</div>
</html>"), 
         Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-30,-30},{100,30}}, 
          lineColor={64,64,64}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          fillColor={255,255,255}, 
          radius=10), 
        Rectangle(
          extent={{-30,-30},{100,30}}, 
          lineColor={64,64,64}, 
          radius=10), 
        Rectangle(
          extent={{-100,-50},{0,50}}, 
          lineColor={64,64,64}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          fillColor={255,255,255}, 
          radius=10), 
        Rectangle(
          extent={{-100,-50},{0,50}}, 
          lineColor={64,64,64}, 
          radius=10), 
        Text(
          extent={{-150,100},{150,60}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-150,-65},{150,-95}}, 
          textString="n=%n")}));
end Cylindrical;