within Modelica.Mechanics.MultiBody.Joints.Internal;
model PrismaticWithLengthConstraint 
  "从长度约束计算的平动距离的平移副(1个自由度，无潜在状态变量)"

  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
  Modelica.Mechanics.Translational.Interfaces.Flange_a axis 
    "驱动运动副的一维平动一维接口" 
    annotation (Placement(transformation(extent={{70,80},{90,60}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b bearing 
    "驱动轴承的一维平动一维接口" 
    annotation (Placement(transformation(extent={{-30,80},{-50,60}})));
  Modelica.Blocks.Interfaces.RealInput position_a[3](each final quantity="Length", each final unit="m") 
    "长度约束的frame_a到frame_a端的位置矢量，在平动体运动副的frame_a中解析" 
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealInput position_b[3](each final quantity="Length", each final unit="m") 
    "长度约束的frame_b到frame_b端的位置矢量，在平动体运动副的frame_b中解析" 
    annotation (Placement(transformation(extent={{140,-80},{100,-40}})));

  parameter Boolean animation=true "=true，则启用动画";
  parameter SI.Position length(start=1) "长度约束的固定长度";
  parameter Modelica.Mechanics.MultiBody.Types.Axis n={1,0,0} 
    "在frame_a中解析的平动轴(与frame_b中的相同)" 
    annotation (Evaluate=true);
  parameter SI.Position s_offset=0 
    "相对距离偏移(frame_a和frame_b之间的距离=s(t)+s_offset)";
  parameter SI.Position s_guess=0 
    "选择配置，使得在初始时间|s(t0)-s_guess|最小";
  parameter Types.Axis boxWidthDirection={0,1,0} 
    "长方体宽度方向的矢量，在frame_a中解析" 
    annotation (Evaluate=true, Dialog(tab="动画", group= 
          "如果animation=true", enable=animation));
  parameter SI.Distance boxWidth=world.defaultJointWidth 
    "平动体运动副长方体的宽度" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
  parameter SI.Distance boxHeight=boxWidth "平动体运动副长方体的高度" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
  input Types.Color boxColor=Modelica.Mechanics.MultiBody.Types.Defaults.JointColor 
    "平动体运动副长方体的颜色" 
    annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射(=0：光被完全吸收)" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));

  final parameter Boolean positiveBranch(fixed=false) 
    "非线性约束方程的两个解之一的选择";
final parameter Real e[3](each final unit="1")=Modelica.Math.Vectors.normalizeWithAssert(n) 
    "沿着平动轴方向的单位矢量，在frame_a中解析";
SI.Position s 
    "frame_a和frame_b沿轴n的相对距离=s+s_offset)";
SI.Position distance 
    "frame_a和frame_b沿轴n的相对距离";
SI.Position r_rel_a[3] 
    "从frame_a到frame_b的位置矢量，在frame_a中解析";
SI.Force f "=axis.f(轴上的驱动力)";

protected
SI.Position r_a[3]=position_a 
    "从frame_a到长度约束的frame_a端的位置矢量，在平动体运动副的frame_a中解析";
SI.Position r_b[3]=position_b 
    "从frame_b到长度约束的frame_b端的位置矢量，在平动体运动副的frame_b中解析";
SI.Position rbra[3] "=rb-ra";
Real B "方程的系数B：s*s+B*s+C=0";
Real C "方程的系数C：s*s+B*s+C=0";
Real k1 "二次方程解的常数";
Real k2 "二次方程解的常数";
Real k1a(start=1);
Real k1b;

Visualizers.Advanced.Shape box(
    shapeType="box", 
    color=boxColor, 
    specularCoefficient=specularCoefficient, 
    length=if noEvent(abs(s + s_offset) > 1.e-6) then s + s_offset else 1.e-6, 
    width=boxWidth, 
    height=boxHeight, 
    lengthDirection=e, 
    widthDirection=boxWidthDirection, 
    r=frame_a.r_0, 
    R=frame_a.R) if world.enableAnimation and animation;

public
function selectBranch 
    "确定距离初始角度为0的最近的分支"
    extends Modelica.Icons.Function;
input SI.Length L "长度约束的长度";
input Real e[3](each final unit="1") 
    "沿平动轴的单位矢量，解析在frame_a中(在frame_b中相同)";
input SI.Position d_guess 
    "选择配置，使得在初始时间|d-d_guess|最小(d：frame_a原点到frame_b原点的距离)";
input SI.Position r_a[3] 
    "从frame_a到长度约束的frame_a端的位置矢量，在平动体运动副的frame_a中解析";
input SI.Position r_b[3] 
    "从frame_b到长度约束的frame_b端的位置矢量，在平动体运动副的frame_b中解析";
output Boolean positiveBranch "初始解的分支";

protected
    SI.Position rbra[3] "=rb-ra";
    Real B "方程的系数B：d*d+B*d+C=0";
    Real C "方程的系数C：d*d+B*d+C=0";
    Real k1 "二次方程解的常数";
    Real k2 "二次方程解的常数";
    Real k1a;
    Real k1b;
    Real d1 "二次方程的解1";
    Real d2 "二次方程的解2";
    annotation();
algorithm
    /* 从frame_a到frame_b的长度约束元素的位置矢量r_rel，在平动体运动副的frame_b中解析(平动体运动副的frame_a和frame_b彼此平行)为：
          r_rel = d*e + r_b - r_a
       因此，长度约束可以表示为：
          r_rel*r_rel = L*L
       其中
          (d*e + r_b - r_a)*(d*e + r_b - r_a)
                   = d*d + 2*d*e*(r_b - r_a) + (r_b - r_a)*(r_b - r_a)
       得到
          (1)  0 = d*d + d*2*e*(r_b - r_a) + (r_b - r_a)*(r_b - r_a) - L*L
       矢量r_a、r_b和参数L不是平动体运动副的距离d的函数。
因此，(1)是关于单个未知数"d"的二次方程：
          (2) d*d + B*d + C = 0
              其中   B = 2*e*(r_b - r_a)
                     C = (r_b - r_a)*(r_b - r_a) - L*L
       解为
          (3) d = - B/2 +/- sqrt(B*B/4 - C)
    */
    rbra := r_b - r_a;
    B := 2*(e*rbra);
    C := rbra*rbra - L*L;
    k1 := B/2;
    k1a := k1*k1 - C;

 assert(noEvent(k1a > 1e-10), "
环路的奇异位置(要么没有解，要么有两个解；在这个位置，机构失去了一个自由度)。
首先尝试使用另一个Modelica.Mechanics.MultiBody.Joints.Assemblies.JointXXX组件。
如果这也导致奇异位置，可能是由于这个运动学环路无法通过固定状态选择来解析求解。
在这种情况下，您必须使用基本运动副(没有组合JointXXX组件)来建立环路，并依赖于动态状态选择，
即在模拟过程中，状态将以动态方式选择，以确保在任何位置都不会失去自由度。
");
k1b := max(k1a, 1.0e-12);
k2 := sqrt(k1b);
d1 := -k1 + k2;
d2 := -k1 - k2;
if abs(d1 - d_guess) <= abs(d2 - d_guess) then
  positiveBranch := true;
else
  positiveBranch := false;
end if;

  end selectBranch;
initial equation
  positiveBranch = selectBranch(length, e, s_offset + s_guess, r_a, r_b);
equation
  Connections.branch(frame_a.R, frame_b.R);

  axis.f = f;
axis.s = s;
bearing.s = 0;
distance = s_offset + s;

// frame_a 和 frame_b 量之间的关系
r_rel_a = e * distance;
frame_b.r_0 = frame_a.r_0 + Frames.resolve1(frame_a.R, r_rel_a);
frame_b.R = frame_a.R;
zeros(3) = frame_a.f + frame_b.f;
zeros(3) = frame_a.t + frame_b.t + cross(r_rel_a, frame_b.f);

// 计算平动距离(详情，请参阅函数“selectBranch”)
rbra = r_b - r_a;
B = 2 * (e * rbra);
C = rbra * rbra - length * length;
k1 = B / 2;
k1a = k1 * k1 - C;
assert(noEvent(k1a > 1e-10), "
环路的奇异位置(要么没有解，要么有两个解；
在这个位置，机构失去了一个自由度)。
首先尝试使用另一个Modelica.Mechanics.MultiBody.Joints.Assemblies.JointXXX组件。
如果这也导致奇异位置，可能是由于这个运动学环路无法通过固定状态选择来解析求解。
在这种情况下，您必须使用基本运动副(没有组合JointXXX组件)来建立环路，并依赖于动态状态选择，
即在模拟过程中，状态将以动态方式选择，以确保在任何位置都不会失去自由度。
");

  k1b = Frames.Internal.maxWithoutEvent(k1a, 1.0e-12);
  k2 = sqrt(k1b);
  distance = -k1 + (if positiveBranch then k2 else -k2);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-30,-40},{100,30}}, 
          pattern=LinePattern.None, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Rectangle(extent={{-30,40},{100,-40}}), 
        Rectangle(
          extent={{-100,-60},{-30,50}}, 
          pattern=LinePattern.None, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Rectangle(
          extent={{-100,50},{-30,60}}, 
          pattern=LinePattern.None, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Rectangle(
          extent={{-30,30},{100,40}}, 
          pattern=LinePattern.None, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Text(
          extent={{-136,-170},{140,-113}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Rectangle(extent={{-100,60},{-30,-60}}), 
        Line(points={{100,-40},{100,-60}}, color={0,0,255}), 
        Rectangle(
          extent={{100,40},{90,80}}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-136,-116},{153,-77}}, 
          textString="n=%n")}), 
    Documentation(info="<html>
<p>
该运动副使得frame_b沿着在frame_a中固定的轴n进行平动。
当\"s + s_offset = 0\"时，两个坐标系重合，其中\"s_offset\"是一个带有零默认值的参数，而\"s\"是相对距离。
</p>
<p>
这种变体的平移副设计用于与运动学环路中的长度约束配合使用。
这意味着运动副的相对距离\"s\"被计算为满足长度约束。
</p>
<p>
<strong>通常，多体库的用户不应该使用这个运动副。
它只提供给建立Modelica.Mechanics.MultiBody.Joints.Assemblies.JointXYZ运动副。
</strong></p>

<p>
在Modelica标准库版本3.0之前的发布版本中，可以通过参数<strong>axisForceBalance</strong>激活力投影方程(=局部力投影到平动轴上必须与一维接口轴的驱动力相同)。
但是，自此版本后不再支持，因为否则这个模型将不会\"平衡\"(=未知数与方程数相同)。
相反，在版本3.0及更高版本中使用这个模型时，必须计算长度约束组件(Joints.SphericalSpherical或Joints.UniversalSpherical)中的力，使得平动轴方向的驱动力为(假设RC是平动约束的实例名)：</p>
<blockquote><pre>
0=RC.axis.f+RC.e*RC.frame_b.f;
</pre></blockquote>
<p>
如果使用此方程式，则通常长度约束中的力和平动距离的二阶导数将成为线性代数方程组的一部分。
在某些情况下，可能可以局部解决这个方程组，即直接提供作为平动约束力的杆力。
无论如何，这个投影方程或等效方程都必须通过\"Joints.SphericalSpherical\"或\"Joints.UniversalSpherical\"的\"高级\"菜单中的变量\"constraintResidue\"提供。
</p>

</html>"));
end PrismaticWithLengthConstraint;