within Modelica.Mechanics.MultiBody.Joints.Internal;
model RevoluteWithLengthConstraint 
  "转动副，其旋转角度由长度约束计算(1个自由度，无潜在状态变量)"

  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
  Modelica.Mechanics.Rotational.Interfaces.Flange_a axis 
    "驱动运动副的一维旋转一维接口" 
    annotation (Placement(transformation(extent={{10,90},{-10,110}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b bearing 
    "传动轴承的一维旋转一维接口" 
    annotation (Placement(transformation(extent={{-50,90},{-70,110}})));

  Modelica.Blocks.Interfaces.RealInput position_a[3](each final quantity="Length", each final unit="m") 
    "从frame_a到约束长度的frame_a侧的位置矢量，在转动副的frame_a中解析" 
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealInput position_b[3](each final quantity="Length", each final unit="m") 
    "从frame_b到约束长度的frame_b侧的位置矢量，在转动副的frame_b中解析" 
    annotation (Placement(transformation(extent={{140,-80},{100,-40}})));

  parameter Boolean animation=true "=true，则启用动画";
  parameter SI.Position lengthConstraint(start=1) 
    "长度约束的固定长度";
  parameter Modelica.Mechanics.MultiBody.Types.Axis n={0,0,1} 
    "旋转轴在frame_a中的分辨率(与frame_b相同)" 
    annotation (Evaluate=true);
  parameter Modelica.Units.NonSI.Angle_deg phi_offset=0 
    "相对角度偏移(角度=phi+from_deg(phi_offset))";
  parameter Modelica.Units.NonSI.Angle_deg phi_guess=0 
    "选择配置，使初始时间|phi-from_deg(phi_guess)|最小化";
  parameter SI.Distance cylinderLength=world.defaultJointLength 
    "表示运动副轴的圆柱体的长度" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
  parameter SI.Distance cylinderDiameter=world.defaultJointWidth 
    "表示运动副轴的圆柱体的直径" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
  input Types.Color cylinderColor=Modelica.Mechanics.MultiBody.Types.Defaults.JointColor 
    "表示运动副轴的圆柱体的颜色" 
    annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射(=0：光被完全吸收)" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));

 final parameter Boolean positiveBranch(fixed=false) 
    "根据phi_guess，选择非线性约束方程的两个解中的一个";

final parameter Real e[3](each final unit="1")=Modelica.Math.Vectors.normalizeWithAssert(n) 
    "旋转轴方向的单位矢量，在转动副的frame_a中解析";

SI.Angle phi "转动副的旋转角度";
Frames.Orientation R_rel 
    "从frame_a到frame_b的相对方向对象";
SI.Angle angle 
    "=phi+from_deg(phi_offset)(frame_a和frame_b之间的相对旋转角度)";
SI.Torque tau "=axis.tau(轴上的驱动扭矩)";

protected
SI.Position r_a[3]=position_a 
    "从frame_a到约束长度的frame_a侧的位置矢量，在转动副的frame_a中解析";
SI.Position r_b[3]=position_b 
    "从frame_b到约束长度的frame_b侧的位置矢量，在转动副的frame_b中解析";
Real e_r_a "r_a在e上的投影";
Real e_r_b "r_b在e上的投影";
Real A "方程的系数A：A*cos(phi)+B*sin(phi)+C=0";
Real B "方程的系数B：A*cos(phi)+B*sin(phi)+C=0";
Real C "方程的系数C：A*cos(phi)+B*sin(phi)+C=0";
Real k1 "二次方程的常数";
Real k2 "二次方程的常数";
Real k1a(start=1);
Real k1b;
Real kcos_angle "=k1*cos(angle)";
Real ksin_angle "=k1*sin(angle)";

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

public
 function selectBranch 
    "确定距离初始角度=0最近的支路"
    extends Modelica.Icons.Function;
    input SI.Length L "长度约束的长度";
    input Real e[3](each final unit="1") 
      "绕轴的单位矢量，解析为frame_a(=frame_b中相同)";
    input SI.Angle angle_guess 
      "选择配置，使得在初始时间|angle-angle_guess|最小(angle=0：frame_a和frame_b重合)";
    input SI.Position r_a[3] 
      "从约束的长度运动副的frame_a到frame_a一侧的位置矢量，解析为revolute运动副的frame_a";
    input SI.Position r_b[3] 
      "从frame_b到约束的长度运动副的frame_b一侧的位置矢量，解析为revolute运动副的frame_b";
    output Boolean positiveBranch "初始解的支路";
  protected
    Real e_r_a "r_a在e上的投影";
    Real e_r_b "r_b在e上的投影";
    Real A "方程的系数A：A*cos(phi)+B*sin(phi)+C=0";
    Real B "方程的系数B：A*cos(phi)+B*sin(phi)+C=0";
    Real C "方程的系数C：A*cos(phi)+B*sin(phi)+C=0";
    Real k1 "二次方程的常数";
    Real k2 "二次方程的常数";
    Real k1a;
    Real k1b;
    Real kcos1 "k1*cos(angle1)";
    Real ksin1 "k1*sin(angle1)";
    Real kcos2 "k2*cos(angle2)";
    Real ksin2 "k2*sin(angle2)";
    SI.Angle angle1 "非线性方程的解1";
    SI.Angle angle2 "非线性方程的解2";
    annotation();
  algorithm
    /* 长度约束元素的frame_a到frame_b的位置矢量r_rel，解析为revolute运动副的frame_b为
       (T_rel是frame_a到frame_b的平面转换矩阵的计划变换)：
          r_rel = r_b - T_rel*r_a
       因此，长度约束可以表述为：
          r_rel*r_rel = L*L
       其中
          (r_b - T_rel*r_a)*(r_b - T_rel*r_a)
             = r_b*r_b - 2*r_b*T_rel*r_a + r_a*transpose(T_rel)*T_rel*r_a
             = r_b*r_b + r_a*r_a - 2*r_b*T_rel*r_a
       得出
          (1) 0 = r_a*r_a + r_b*r_b - 2*r_b*T_rel*r_a - L*L
       矢量r_a、r_b和参数L不是关于revolute运动副的角度的函数。
       由于T_rel = T_rel(angle)是未知revolute运动副角度的函数，这是该角度的非线性方程。
          T_rel = [e]*transpose([e]) + (identity(3) - [e]*transpose([e]))*cos(angle)
                  - skew(e)*sin(angle);
       其中
          r_b*T_rel*r_a
             = r_b*(e*(e*r_a) + (r_a - e*(e*r_a))*cos(angle) - cross(e,r_a)*sin(angle)
             = (e*r_b)*(e*r_a) + (r_b*r_a - (e*r_b)*(e*r_a))*cos(angle) - r_b*cross(e,r_a)*sin(angle)
       得出约束方程(1)
          (2) 0 = r_a*r_a + r_b*r_b - L*L
                  - 2*(e*r_b)*(e*r_a)
                  - 2*(r_b*r_a - (e*r_b)*(e*r_a))*cos(angle)
                  + 2*r_b*cross(e,r_a)*sin(angle)
       或
          (3) A*cos(angle) + B*sin(angle) + C = 0
       其中
              A = -2*(r_b*r_a - (e*r_b)*(e*r_a))
              B = 2*r_b*cross(e,r_a)
              C = r_a*r_a + r_b*r_b - L*L - 2*(e*r_b)*(e*r_a)
       方程(3)通过分别计算sin(angle)和cos(angle)来求解。
 这允许计算角度的范围：-180度<= angle <= 180度
    */

    e_r_a := e*r_a;  // 计算e在r_a上的投影
 e_r_b := e*r_b;  // 计算e在r_b上的投影
 A := -2*(r_b*r_a - e_r_b*e_r_a);  // 方程系数A的计算
 B := 2*r_b*cross(e, r_a);  // 方程系数B的计算
 C := r_a*r_a + r_b*r_b - L*L - 2*e_r_b*e_r_a;  // 方程系数C的计算
 k1 := A*A + B*B;  // 二次方程的常数k1的计算
 k1a := k1 - C*C;  // k1a的计算
 assert(k1a > 1e-10, "
环路奇异位置(在该位置可能不存在解析解，或存在两个解析解；
在该位置，机构已经失去了一个自由度)。
首先尝试使用另一个Modelica.Mechanics.MultiBody.Joints.Assemblies.JointXXX组件。
在大多数情况下，最好将JointXXX组件外的运动副设置为转动副而不是平移副。
如果这也导致奇异位置，则可能是因为无法解析求解这个运动学环路。
在这种情况下，您必须使用基本运动副(不要使用组合JointXXX组件)构建环路，并依赖于动态状态选择，
即在模拟过程中，将动态地选择状态，以保证在任何位置都不会失去自由度。
" );
 k1b := max(k1a, 1.0e-12);  // 计算k1b

    k2 := sqrt(k1b);

    kcos1 := -A*C + B*k2;
    ksin1 := -B*C - A*k2;
    angle1 := Modelica.Math.atan2(ksin1, kcos1);

    kcos2 := -A*C - B*k2;
    ksin2 := -B*C + A*k2;
    angle2 := Modelica.Math.atan2(ksin2, kcos2);

    if abs(angle1 - angle_guess) <= abs(angle2 - angle_guess) then
      positiveBranch := true;
    else
      positiveBranch := false;
    end if;
  end selectBranch;
initial equation
  positiveBranch = selectBranch(lengthConstraint, e, Cv.from_deg(phi_offset 
     + phi_guess), r_a, r_b);
equation
  Connections.branch(frame_a.R, frame_b.R);  // 连接旋转参考系
  axis.tau = tau;  // 设定轴上的扭矩
  axis.phi = phi;  // 设定轴上的角度
  bearing.phi = 0;  // 设定轴承的角度为0

  angle = Cv.from_deg(phi_offset) + phi;  // 计算实际角度

  // 将运动学量从frame_a转换到frame_b
  frame_b.r_0 = frame_a.r_0;
  R_rel = Frames.planarRotation(e, angle, der(angle));
  frame_b.R = Frames.absoluteRotation(frame_a.R, R_rel);

  // 力和力矩平衡
  zeros(3) = frame_a.f + Frames.resolve1(R_rel, frame_b.f);
  zeros(3) = frame_a.t + Frames.resolve1(R_rel, frame_b.t);

  // 计算旋转角度(详细信息，请参阅函数"selectBranch")
  e_r_a = e*r_a;  // 计算e在r_a上的投影
  e_r_b = e*r_b;  // 计算e在r_b上的投影
  A = -2*(r_b*r_a - e_r_b*e_r_a);  // 方程系数A的计算
  B = 2*r_b*cross(e, r_a);  // 方程系数B的计算
  C = r_a*r_a + r_b*r_b - lengthConstraint*lengthConstraint - 2*e_r_b*e_r_a;  // 方程系数C的计算
  k1 = A*A + B*B;  // 二次方程的常数k1的计算
  k1a = k1 - C*C;  // 计算k1a

  assert(k1a > 1e-10, "
环路奇异位置(在该位置可能不存在解析解，或存在两个解析解；
在该位置，机构已经失去了一个自由度)。
首先尝试使用另一个Modelica.Mechanics.MultiBody.Joints.Assemblies.JointXXX组件。
在大多数情况下，最好将JointXXX组件外的运动副设置为转动副而不是平移副。
如果这也导致奇异位置，则可能是因为无法解析求解这个运动学环路。
在这种情况下，您必须使用基本运动副(不要使用组合JointXXX组件)构建环路，并依赖于动态状态选择，
即在模拟过程中，将动态地选择状态，以保证在任何位置都不会失去自由度。
");


  k1b = Frames.Internal.maxWithoutEvent(k1a, 1.0e-12);
  k2 = sqrt(k1b);
  kcos_angle = -A*C + (if positiveBranch then B else -B)*k2;
  ksin_angle = -B*C + (if positiveBranch then -A else A)*k2;

  angle = Modelica.Math.atan2(ksin_angle, kcos_angle);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-30,10},{10,-10}}, 
          lineColor={64,64,64}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{-100,-60},{-30,60}}, 
          lineColor={64,64,64}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          fillColor={255,255,255}, 
          radius=10), 
        Rectangle(
          extent={{30,-60},{100,60}}, 
          lineColor={64,64,64}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          fillColor={255,255,255}, 
          radius=10), 
        Text(
          extent={{-139,-168},{137,-111}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Rectangle(extent={{-100,60},{-30,-60}}, lineColor={64,64,64}, radius=10), 
        Rectangle(extent={{30,60},{100,-60}}, lineColor={64,64,64}, radius=10), 
        Text(
          extent={{-142,-108},{147,-69}}, 
          textString="n=%n"), 
        Line(points={{-60,60},{-60,90}}), 
        Line(points={{-20,70},{-60,70}}), 
        Line(points={{-20,80},{-20,60}}), 
        Line(points={{20,80},{20,60}}), 
        Line(points={{20,70},{41,70}}), 
        Polygon(
          points={{-9,30},{10,30},{30,50},{-29,50},{-9,30}}, 
          lineColor={64,64,64}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Polygon(
          points={{10,30},{30,50},{30,-51},{10,-31},{10,30}}, 
          lineColor={64,64,64}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{-10,90},{10,50}}, 
          lineColor={64,64,64}, 
          fillPattern=FillPattern.VerticalCylinder, 
          fillColor={192,192,192})}), 
    Documentation(info="<html>
<p>
坐标系_b绕轴n旋转的接头，该轴在坐标系_a中固定。
当“phi+phi_offset=0”时，两个坐标系重合，其中“phi_offset”是一个带有零默认值的参数，而“phi”是旋转角度。
</p>
<p>
这种旋转接头的变体旨在与运动回路中的长度约束配合使用。
这意味着旋转接头的角度phi被计算为满足长度约束。
</p>
<p>
<strong>通常，这个接头不应该被MultiBody库的用户使用。
它只是为了构建Modelica.Mechanics.MultiBody.Joints.Assemblies.JointXYZ接头。
</strong></p>

<p>
在Modelica标准库的3.0版本之前的发布版本中，可以通过参数<strong>axisTorqueBalance</strong>来激活扭矩投影方程(=投影到旋转轴的剪切扭矩必须与一维接口轴的驱动扭矩相同)。
这在3.0版本及更高版本中已不再可能，因为否则该模型将不会“平衡”(=未知数与方程式数量相同)。
相反，当在3.0版本及更高版本中使用此模型时，必须计算长度约束组件(Joints.SphericalSpherical或Joints.UniversalSpherical)中的力，使得沿旋转轴的驱动扭矩为：</p>
<blockquote><pre>
0=RC.axis.tau+RC.e*RC.frame_b.t;
</pre></blockquote>
<p>
如果使用这个方程，通常长度约束中的力和旋转角的二阶导数将成为一个线性代数方程组的一部分。
在某些情况下，可以局部解决这个方程组，即直接提供作为旋转约束扭矩函数的杆力。
无论如何，这个投影方程或等效方程都必须通过“Joints.SphericalSpherical”或“Joints.UniversalSpherical”的“高级”菜单中的变量“constraintResidue”提供。
</p>

</html>"));
end RevoluteWithLengthConstraint;