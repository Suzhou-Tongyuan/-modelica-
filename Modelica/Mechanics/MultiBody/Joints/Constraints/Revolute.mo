within Modelica.Mechanics.MultiBody.Joints.Constraints;
model Revolute 
  "转动副和平动方向可以受到约束或释放"
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;

  parameter Boolean x_locked = true 
    "=true:在frame_a中约束x方向的力" 
    annotation(Dialog(group = "平移运动中的约束"), choices(checkBox = true));
  parameter Boolean y_locked = true 
    "=true:在frame_a中约束y方向的力" 
    annotation(Dialog(group = "平移运动中的约束"), choices(checkBox = true));
  parameter Boolean z_locked = true 
    "=true:在frame_a中约束z方向的力" 
    annotation(Dialog(group = "平移运动中的约束"), choices(checkBox = true));

  parameter Boolean animation = true 
    "=true,如果启用动画(显示球体)";
  parameter Types.Axis n = {0, 1, 0} 
    "在frame_a中解析的旋转轴(=与frame_b相同)" 
    annotation(Evaluate = true);

  parameter SI.Distance sphereDiameter = world.defaultJointLength / 3 
    "表示球面副的球体的直径" 
    annotation(Dialog(group = "如果animation=true", enable = animation));
  input Types.Color sphereColor = Types.Defaults.JointColor 
    "表示球面副的球体的颜色" 
    annotation(Dialog(colorSelector = true, group = "如果animation=true", enable = animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射(=0：光线完全吸收)" 
    annotation(Dialog(group = "如果animation=true", enable = animation));

protected
  Frames.Orientation R_rel 
    "虚拟或相对方向对象，从frame_a到frame_b";
  SI.Position r_rel_a[3] 
    "从frame_a原点到frame_b原点的位置矢量，以frame_a为基准";
  SI.InstantaneousPower P;
  parameter Real e[3](each final unit = "1") = Modelica.Math.Vectors.normalizeWithAssert(
    n) 
    "单位矢量，指向在frame_a中的旋转轴方向(与frame_b中的相同)";

  parameter Real nnx_a[3](each final unit = "1") = if abs(e[1]) > 0.1 then {0, 1, 0} else (if abs(e[2]) 
    > 0.1 then {0, 0, 1} else {1, 0, 0}) 
    "与旋转轴n不对齐的任意矢量" 
    annotation(Evaluate = true);
  parameter Real ey_a[3](each final unit = "1") = Modelica.Math.Vectors.normalizeWithAssert(
    cross(e, nnx_a)) 
    "与转动副轴n正交的单位矢量，以frame_a为基准" 
    annotation(Evaluate = true);
  parameter Real ex_a[3](each final unit = "1") = cross(ey_a, e) 
    "与转动副轴n和ey_a正交的单位矢量，以frame_a为基准";

public
  Visualizers.Advanced.Shape sphere(
    shapeType = "sphere", 
    color = sphereColor, 
    specularCoefficient = specularCoefficient, 
    length = sphereDiameter, 
    width = sphereDiameter, 
    height = sphereDiameter, 
    lengthDirection = {1, 0, 0}, 
    widthDirection = {0, 1, 0}, 
    r_shape = {-0.5, 0, 0} * sphereDiameter, 
    r = frame_a.r_0, 
    R = frame_a.R) if world.enableAnimation and animation;

equation
  // 在frame_a中确定相对位置矢量
  R_rel = Frames.relativeRotation(frame_a.R, frame_b.R);
  r_rel_a = Frames.resolve2(frame_a.R, frame_b.r_0 - frame_a.r_0);

  // 关于平动的约束方程
  if x_locked and y_locked and z_locked then
    r_rel_a = zeros(3);
  elseif x_locked and y_locked and not z_locked then
    r_rel_a[1] = 0;
    r_rel_a[2] = 0;
    frame_a.f[3] = 0;
  elseif x_locked and not y_locked and z_locked then
    r_rel_a[1] = 0;
    r_rel_a[3] = 0;
    frame_a.f[2] = 0;
  elseif x_locked and not y_locked and not z_locked then
    r_rel_a[1] = 0;
    frame_a.f[2] = 0;
    frame_a.f[3] = 0;
  elseif not x_locked and y_locked and z_locked then
    r_rel_a[2] = 0;
    r_rel_a[3] = 0;
    frame_a.f[1] = 0;
  elseif not x_locked and y_locked and not z_locked then
    r_rel_a[2] = 0;
    frame_a.f[1] = 0;
    frame_a.f[3] = 0;
  elseif not x_locked and not y_locked and z_locked then
    r_rel_a[3] = 0;
    frame_a.f[1] = 0;
    frame_a.f[2] = 0;
  else
    frame_a.f = zeros(3);
  end if;

  // 关于旋转的约束方程
  0 = ex_a * R_rel.T * e;
  0 = ey_a * R_rel.T * e;
  frame_a.t * n = 0;

  zeros(3) = frame_a.f + Frames.resolve1(R_rel, frame_b.f);
  zeros(3) = frame_a.t + Frames.resolve1(R_rel, frame_b.t) - cross(r_rel_a, 
    frame_a.f);
  P = frame_a.t * Frames.angularVelocity2(frame_a.R) + frame_b.t * 
    Frames.angularVelocity2(frame_b.R) + Frames.resolve1(frame_b.R, frame_b.f) 
    * der(frame_b.r_0) + Frames.resolve1(frame_a.R, frame_a.f) * der(frame_a.r_0);
  annotation(defaultComponentName = "constraint", 
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Text(
    extent = {{-63, -63}, {53, -93}}, 
    textString = "n=%n"), 
    Rectangle(
    extent = {{-100, -60}, {-30, 60}}, 
    lineColor = {64, 64, 64}, 
    fillPattern = FillPattern.HorizontalCylinder, 
    fillColor = {255, 255, 255}, 
    radius = 10), 
    Rectangle(
    extent = {{30, -60}, {100, 60}}, 
    lineColor = {64, 64, 64}, 
    fillPattern = FillPattern.HorizontalCylinder, 
    fillColor = {255, 255, 255}, 
    radius = 10), 
    Rectangle(extent = {{-100, 60}, {-30, -60}}, lineColor = {64, 64, 64}, radius = 10), 
    Rectangle(extent = {{30, 60}, {100, -60}}, lineColor = {64, 64, 64}, radius = 10), 
    Text(
    extent = {{-90, 14}, {-54, -11}}, 
    textColor = {128, 128, 128}, 
    textString = "a"), 
    Text(
    extent = {{51, 11}, {87, -14}}, 
    textColor = {128, 128, 128}, 
    textString = "b"), 
    Rectangle(
    extent = {{-30, 11}, {30, -10}}, 
    lineColor = {64, 64, 64}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), 
    Line(
    points = {{-81, -66}, {-23, 25}, {40, -39}, {97, 71}}, 
    color = {255, 0, 0}, 
    thickness = 0.5), 
    Text(
    extent = {{-49, 82}, {45, 59}}, 
    textString = "constraint"), 
    Text(
    extent = {{-150, 120}, {150, 80}}, 
    textColor = {0, 0, 255}, 
    textString = "%name")}), 
    Documentation(info = "<html>
<p>
该模型不使用显式变量(例如状态变量)来描述frame_b相对于frame_a的相对运动，而是定义了frame_a和frame_b之间的运动约束。
然后以满足这些约束的方式评估两个坐标系上的力和力矩。
有时候，这种类型的表述在文献中也被称为隐式运动副。
</p>
<p>
由于这种表述，frame_a和frame_b之间的相对运动无法初始化。
</p>
<p>
特别是在具有闭环的复杂多体系统中，这种表述可能有助于简化非线性方程组。
请比较使用经典运动副表述和此处使用的替代表述的转换日志，以检查这一事实是否适用于所考虑的特定系统。
</p>
<p>
在没有闭环的系统中，使用这种隐式运动副是没有意义的，甚至可能是不利的。
</p>
<p>
请参阅子包<a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Constraints\">Examples.Constraints</a>以测试该运动副。
</p>
</html>"));
end Revolute;