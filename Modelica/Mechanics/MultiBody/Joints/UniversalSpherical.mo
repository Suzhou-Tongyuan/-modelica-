within Modelica.Mechanics.MultiBody.Joints;
model UniversalSpherical 
  "万向节-球副组合(1个约束，无潜在状态变量)"
  import Modelica.Mechanics.MultiBody.Types;

  extends Interfaces.PartialTwoFrames;
  Interfaces.Frame_a frame_ia 
    "在frame_a原点处的坐标系，固定在连接万向节和球副的杆上" 
    annotation (Placement(transformation(
        origin={-40,100}, 
        extent={{-16,-16},{16,16}}, 
        rotation=270)));
  parameter Boolean animation=true "=true，如果启用动画";
  parameter Boolean showUniversalAxes=true 
    "=true，万向节应该使用两个圆柱体可视化，否则使用一个球体(如果启用动画=true)";
  parameter Boolean computeRodLength=false 
    "=true，如果在初始化期间应计算frame_a和frame_b之间的距离(见信息)";
  parameter Modelica.Mechanics.MultiBody.Types.Axis n1_a={0,0,1} 
    "万向节在frame_a中的解析轴1(轴2垂直于轴1和杆)";
  parameter SI.Position rRod_ia[3]={1,0,0} 
    "从frame_a原点到frame_b原点的矢量，在frame_ia中解析(如果computeRodLength=true，则rRod_ia仅是沿连接杆的轴矢量)";
  parameter SI.Diameter sphereDiameter=world.defaultJointLength 
    "表示万向节和球副的球的直径";
  input Types.Color sphereColor=Modelica.Mechanics.MultiBody.Types.Defaults.JointColor 
    "表示万向节和球副的球的颜色";
  parameter Types.ShapeType rodShapeType="cylinder" 
    "连接万向节和球副的杆的形状类型";
  parameter SI.Distance rodWidth=sphereDiameter/Types.Defaults.JointRodDiameterFraction 
    "万向节轴2方向上杆形状的宽度";
  parameter SI.Distance rodHeight=rodWidth 
    "杆形状的高度，垂直于杆和轴2的方向";

    parameter Types.ShapeExtra rodExtra=0.0 
    "根据rodShapeType而定的附加参数" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
  input Types.Color rodColor=Modelica.Mechanics.MultiBody.Types.Defaults.RodColor 
    "连接万向节和球副的杆形状的颜色" 
    annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));
  parameter SI.Distance cylinderLength=world.defaultJointLength 
    "表示两个万向节轴的圆柱体的长度" annotation (
     Dialog(tab="动画", group="如果animation=trueandshowUniversalAxes", 
                             enable=animation and showUniversalAxes));
  parameter SI.Distance cylinderDiameter=world.defaultJointWidth 
    "表示两个万向节轴的圆柱体的直径" 
    annotation (Dialog(tab="动画", group= 
          "如果animation=trueandshowUniversalAxes", 
          enable=animation and showUniversalAxes));
  input Types.Color cylinderColor=Modelica.Mechanics.MultiBody.Types.Defaults.JointColor 
    "表示两个万向节轴的圆柱体的颜色" annotation (
      Dialog(colorSelector=true, tab="动画", group="如果animation=trueandshowUniversalAxes", 
                              enable=animation and showUniversalAxes));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射(=0：光完全被吸收)" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));


  parameter Boolean kinematicConstraint=true 
    "=false，如果不定义约束，因为通过解析解动力学闭环来解决" 
    annotation (Dialog(tab="高级", group="KinematicConstraint"));
Real constraintResidue = rRod_0*rRod_0 - rodLength*rodLength 
    "运动副的约束方程的残差形式：要么长度约束(默认)，要么计算杆力的方程(用于与Internal.RevoluteWithLengthConstraint/PrismaticWithLengthConstraint结合解析解闭环)" 
    annotation (Dialog(tab="高级", enable=not kinematicConstraint, group="KinematicConstraint"));
parameter Boolean checkTotalPower=false 
    "=true，如果要确定流入此组件的总功率(必须为零)" 
    annotation (Dialog(tab="高级", group="PowerCalculation"));
SI.Force f_rod 
    "杆的方向上的约束力(如果杆被压缩，则为正)";
final parameter SI.Distance rodLength(fixed=false, start=Modelica.Math.Vectors.length(rRod_ia)) 
    "杆的长度(frame_a的原点到frame_b的原点的距离)";
final parameter Real eRod_ia[3](each final unit="1")=Modelica.Math.Vectors.normalizeWithAssert(rRod_ia) 
    "从frame_a的原点到frame_b的原点的单位矢量，解析在frame_ia中";
final parameter Real e2_ia[3](each final unit="1")=Modelica.Math.Vectors.normalize(
                                                 cross(n1_a, eRod_ia)) 
    "万向节轴2方向的单位矢量，解析在frame_ia中(与n1_a和eRod_ia正交；注意：当通用运动副角度为零时，frame_ia与frame_a平行)";
final parameter Real e3_ia[3](each final unit="1")=cross(eRod_ia, e2_ia) 
    "垂直于eRod_ia和e2_ia的单位矢量，解析在frame_ia中";
SI.Power totalPower 
    "如果checkTotalPower=true，则流入此元件的总功率(否则为虚拟)";
SI.Force f_b_a1[3] 
    "frame_b.f，不包括f_rod部分，解析在frame_a中(解析解闭环处理所需)";
Real eRod_a[3](each final unit="1") 
    "rRod_a方向的单位矢量，解析在frame_a中(解析解闭环处理所需)";
SI.Position rRod_0[3](start=rRod_ia) 
    "解析在worldframe中的frame_a的原点到frame_b的原点的位置矢量";
SI.Position rRod_a[3](start=rRod_ia) 
    "解析在frame_a中的frame_a的原点到frame_b的原点的位置矢量";

protected
  SI.Force f_b_a[3] "frame_b.f解析在frame_a中";
  SI.Force f_ia_a[3] "frame_ia.f解析在frame_a中";
  SI.Torque t_ia_a[3] "frame_ia.t解析在frame_a中";
  Real n2_a[3](each final unit="1") 
    "万向节轴2方向的单位矢量(e2_ia)，解析在frame_a中";
  Real length2_n2_a(start=1, unit="1") "矢量n2_a的长度的平方";
  Real length_n2_a(unit="1") "矢量n2_a的长度";
  Real e2_a[3](each final unit="1") 
    "万向节轴2方向的单位矢量(e2_ia)，解析在frame_a中";
  Real e3_a[3](each final unit="1") 
    "垂直于eRod_ia和e2_a的单位矢量，解析在frame_a中";
  Real der_rRod_a_L[3](each unit="1/s") "=der(rRod_a)/rodLength";
  SI.AngularVelocity w_rel_ia1[3];
  Frames.Orientation R_rel_ia1;
  Frames.Orientation R_rel_ia2;
  // Real T_rel_ia[3, 3];
  Frames.Orientation R_rel_ia "从frame_a到frame_ia的旋转";

  Visualizers.Advanced.Shape rodShape(
    shapeType=rodShapeType, 
    color=rodColor, 
    specularCoefficient=specularCoefficient, 
    length=rodLength, 
    width=rodWidth, 
    height=rodHeight, 
    lengthDirection=eRod_ia, 
    widthDirection=e2_ia, 
    r=frame_ia.r_0, 
    R=frame_ia.R) if world.enableAnimation and animation;
  Visualizers.Advanced.Shape sphericalShape_b(
    shapeType="sphere", 
    color=sphereColor, 
    specularCoefficient=specularCoefficient, 
    length=sphereDiameter, 
    width=sphereDiameter, 
    height=sphereDiameter, 
    lengthDirection={1,0,0}, 
    widthDirection={0,1,0}, 
    r_shape={-0.5,0,0}*sphereDiameter, 
    r=frame_b.r_0, 
    R=frame_b.R) if world.enableAnimation and animation;
  Visualizers.Advanced.Shape sphericalShape_a(
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
    R=frame_a.R) if world.enableAnimation and animation and not showUniversalAxes;
  Visualizers.Advanced.Shape universalShape1(
    shapeType="cylinder", 
    color=cylinderColor, 
    specularCoefficient=specularCoefficient, 
    length=cylinderLength, 
    width=cylinderDiameter, 
    height=cylinderDiameter, 
    lengthDirection=n1_a, 
    widthDirection={0,1,0}, 
    r_shape=-n1_a*(cylinderLength/2), 
    r=frame_a.r_0, 
    R=frame_a.R) if world.enableAnimation and animation and showUniversalAxes;
  Visualizers.Advanced.Shape universalShape2(
    shapeType="cylinder", 
    color=cylinderColor, 
    specularCoefficient=specularCoefficient, 
    length=cylinderLength, 
    width=cylinderDiameter, 
    height=cylinderDiameter, 
    lengthDirection=e2_ia, 
    widthDirection={0,1,0}, 
    r_shape=-e2_ia*(cylinderLength/2), 
    r=frame_ia.r_0, 
    R=frame_ia.R) if world.enableAnimation and animation and showUniversalAxes;

initial equation
if not computeRodLength then
  rodLength = Modelica.Math.Vectors.length(rRod_ia);
end if;

equation
  Connections.branch(frame_a.R, frame_ia.R);
  if kinematicConstraint then
    rRod_0 = transpose(frame_b.R.T)*(frame_b.R.T*frame_b.r_0) - transpose(
      frame_a.R.T)*(frame_a.R.T*frame_a.r_0);
  else
    rRod_0 = frame_b.r_0 - frame_a.r_0;
  end if;
  //rRod_0 = frame_b.r_0 - frame_a.r_0;
  rRod_a = Frames.resolve2(frame_a.R, rRod_0);

  // 约束方程
  constraintResidue = 0;

  /* 从 frame_a 到 frame_ia 确定相对旋转 R_rel_ia
     和 frame_a.R 的绝对旋转。
  */
  eRod_a = rRod_a/rodLength;
  n2_a = cross(n1_a, eRod_a);
  length2_n2_a = n2_a*n2_a;

  assert(length2_n2_a > 1e-10, "
在Modelica.Mechanics.MultiBody.Joints.UniversalSpherical运动副(由
连接的通用运动副和球面副共同组成
由刚性杆连接)处于
通用的奇异配置。
这意味着通用运动副的轴1通过参数\"n1_a\"定义为与矢量平行
从frame_a的原点到frame_b的原点的矢量
\"rRod_ia\"。
您可以尝试使用另一个\"n1_a\"矢量。
如果这失败，
请改用Modelica.Mechanics.MultiBody.Joints.SphericalSpherical，如果可以的话，
因为这种运动副组合没有
奇异配置。
");

  length_n2_a = sqrt(length2_n2_a);
e2_a = n2_a/length_n2_a;
e3_a = cross(eRod_a, e2_a);

/* 下面的语句是原始方程的高效实现：
   T_rel_ia = [eRod_ia, e2_ia, e3_ia]*transpose([eRod_a, e2_a, e3_a]);
   R_rel_ia = Frames.from_T(T_rel_ia,
                 Frames.TransformationMatrices.angularVelocity2(T_rel_ia, der(T_rel_ia)));
   为了执行这个操作，将旋转分为两部分：
   R_rel_ia: 从 frame_a 到 frame_ia 的旋转对象
   R_rel_ia1: 从 frame_a 到 frame_ia1 的旋转对象
              (frame_ia 中固定在 frame_ia 中，使得 x 轴沿着杆轴)
              T = transpose([eRod_a, e2_a, e3_a]; w = w_rel_ia1
   R_rel_ia2: 从 frame_ia1 到 frame_ia 的固定旋转对象
              T = [eRod_ia, e2_ia, e3_ia]; w = zeros(3)

   计算 w_rel_ia1 的困难部分是：
      w_rel_ia1 = [  e3_a*der(e2_a);
                    -e3_a*der(eRod_a);
                     e2_a*der(eRod_a)]
   因为 eRod_a 仅与平动量有关，所以直接给出 der(eRod_a)。
      der(eRod_a) = (der(rRod_a) - eRod_a*(eRod_a*der(rRod_a)))/rodLength
      der(n2_a)   = cross(n1_a, der(eRod_a))
      der(e2_a)   = (der(n2_a) - e2_a*(e2_a*der(n2_a)))/length_n2_a
   将这些方程代入 w_rel_ia1 中得到：
      e3_a*der(eRod_a) = e3_a*der(rRod_a)/rodLength       // e3_a*eRod_a = 0
      e2_a*der(eRod_a) = e2_a*der(rRod_a)/rodLength       // e2_a*eRod_a = 0
      e3_a*der(e2_a)   = e3_a*der(n2_a)/length_n2_a       // e3_a*e2_a = 0
                       = e3_a*cross(n1_a, der(eRod_a))/length_n2_a
                       = e3_a*cross(n1_a, der(rRod_a) - eRod_a*(eRod_a*der(rRod_a)))/(length_n2_a*rodLength)
                       = e3_a*cross(n1_a, der(rRod_a))/(length_n2_a*rodLength)
   此外，我们还有：
     rRod_a            = resolve2(frame_a.R, rRod_0);
     der(rRod_a)       = resolve2(frame_a.R, der(rRod_0)) - cross(frame_a.R.w, rRod_a));
*/

 // 计算杆在 frame_a 中的位置变化率
der_rRod_a_L = (Frames.resolve2(frame_a.R, der(rRod_0)) - cross(frame_a.R.w, rRod_a))/rodLength;

// 计算相对于 frame_a 的旋转速度
w_rel_ia1 = {e3_a*cross(n1_a, der_rRod_a_L)/length_n2_a,-e3_a*der_rRod_a_L, e2_a*der_rRod_a_L};

// 计算相对于 frame_ia1 的旋转对象
R_rel_ia1 = Frames.from_T(transpose([eRod_a, e2_a, e3_a]), w_rel_ia1);

// 计算相对于 frame_ia2 的旋转对象
R_rel_ia2 = Frames.from_T([eRod_ia, e2_ia, e3_ia], zeros(3));

// 计算相对于 frame_ia 的旋转对象
R_rel_ia = Frames.absoluteRotation(R_rel_ia1, R_rel_ia2);

// 计算 frame_ia 的位置
frame_ia.r_0 = frame_a.r_0;

// 计算 frame_ia 的旋转
frame_ia.R = Frames.absoluteRotation(frame_a.R, R_rel_ia);


/*以下公式中，f_a、f_b、f_ia、t_a、t_b、t_ia 分别是 frame_a、frame_b、frame_ia 中的力和力矩，
在 frame_a 中解析得到。
e_x、e_y、e_z 是在 frame_a 中解析的单位矢量。
杆相对于 frame_a 原点的力矩平衡：
    0 = t_a + t_ia + cross(rRod_a, f_b)
其中
    rRod_a = rodLength*e_x
    f_b     = -f_rod*e_x + f_b[2]*e_y + f_b[3]*e_z
得到：
    0 = t_a + t_ia + rodLength*(f_b[2]*e_z - f_b[3]*e_y)
t_a 关于万向节轴的投影为零：
    n1_a*t_a = 0
    e_y*t_a = 0
因此：
    0 = n1_a*t_ia + rodLength*f_b[2]*(n1_a*e_z)
    0 = e_y*t_ia - rodLength*f_b[3]
或者
    f_b = -f_rod*e_x - e_y*(n1_a*t_ia)/(rodLength*(n1_a*e_z)) + e_z*(e_y*t_ia)/rodLength
力平衡：
    0 = f_a + f_b + f_ia
*/
f_ia_a = Frames.resolve1(R_rel_ia, frame_ia.f);
t_ia_a = Frames.resolve1(R_rel_ia, frame_ia.t);

    // f_b_a1 is needed in aggregation joints to solve kinematic loops analytically
// f_b_a1 在组合运动副中用于解析解运动学回路
f_b_a1 = -e2_a*((n1_a*t_ia_a)/(rodLength*(n1_a*e3_a))) + e3_a*((e2_a*t_ia_a) 
    /rodLength);
f_b_a = -f_rod*eRod_a + f_b_a1;
frame_b.f = Frames.resolveRelative(f_b_a, frame_a.R, frame_b.R);
frame_b.t = zeros(3);
zeros(3) = frame_a.f + f_b_a + f_ia_a;
zeros(3) = frame_a.t + t_ia_a + cross(rRod_a, f_b_a);

  // Measure power for test purposes
// 为了测试目的测量功率
if checkTotalPower then
  totalPower = frame_a.f*Frames.resolve2(frame_a.R, der(frame_a.r_0)) + 
    frame_b.f*Frames.resolve2(frame_b.R, der(frame_b.r_0)) + frame_ia.f* 
    Frames.resolve2(frame_ia.R, der(frame_ia.r_0)) + frame_a.t* 
    Frames.angularVelocity2(frame_a.R) + frame_b.t*Frames.angularVelocity2(
    frame_b.R) + frame_ia.t*Frames.angularVelocity2(frame_ia.R);
else
  totalPower = 0;
end if;

  annotation (
    Documentation(info="<html>
<p>
该组件由frame_a处的一个<strong>万向节</strong>和frame_b处的一个<strong>球副</strong>组成，它们通过一个<strong>刚性杆</strong>连接在一起，参见默认动画图(箭头不是默认动画的一部分)：</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/UniversalSpherical.png\"alt=\"model Joints.UniversalSpherical\">
</div>

<p>
该组合副没有质量和转动惯量，并引入了一个约束，即frame_a的原点与frame_b的原点之间的距离是恒定的(=Frames.length(rRod_ia))。
万向节的定义如下：</p>

<ul>
<li>转动副<strong>1</strong>的<strong>轴</strong>沿着参数矢量n1_a固定在frame_a中。
</li>
<li>转动副<strong>2</strong>的<strong>轴</strong>垂直于轴1，并且垂直于连接万向节和球副的直线。
</li>
</ul>
<p>
万向节轴2的定义是根据通常出现的情况进行的，以便简化处理。
否则，如果轴2不垂直于轴1和连接杆，则处理会更加复杂，操作数量会大大增加。
</p>
<p>
注意，当轴1和连接杆彼此平行时存在一个<strong>奇点</strong>。
因此，如果可能的话，应该选择n1_a，使其在初始配置中与rRod_ia垂直(即，与奇点的距离尽可能大)。
</p>
<p>
还存在一个额外的<strong>frame_ia</strong>。
它在连接<strong>杆</strong>中<strong>固定</strong>，位于<strong>frame_a</strong>的原点处。
frame_ia在杆上的放置由万向节隐式定义(当万向节的两个转动副的角度为零时，frame_a和frame_ia重合)，并由参数矢量<strong>rRod_ia</strong>和位置矢量(从frame_a的原点到frame_b的原点，在frame_<strong>ia</strong>中解析)。
</p>
<p>
定义这种运动副的最简单方法是将MultiBody系统移动到<strong>参考配置</strong>中，其中<strong>所有组件的所有坐标系</strong>都<strong>平行</strong>于其他组件(或者至少当定义此组件的实例时，UniversalSpherical联合的frame_a和frame_ia应平行于其他组件)。
由于frame_a和frame_ia彼此平行，因此frame_a到frame_b的矢量rRod_ia在frame_<strong>a</strong>(或者如果所有坐标系都平行于其他坐标系，则在<strong>全局坐标系</strong>中)中可以解析。
</p>
<p>
此组合副可用于现实中存在球副的杆。
这样的系统具有沿其轴旋转杆的额外自由度。
在实践中，这种旋转通常不感兴趣，并且通过用万向节替换一个球副来从数学上去除。
但是，在大多数情况下，可以使用Joints.SphericalSpherical联合代替UniversalSpherical联合，因为杆是动画的，其质量特性由杆中点的质量近似表示。
SphericalSpherical联合的优点是它没有奇异配置。
</p>
<p>
在UniversalSpherical运动副的公共接口中，提供以下(最终)<strong>参数</strong>：</p>
<blockquote><pre>
<strong>parameter</strong>RealrodLength(unit=\"m\")\"Length of rod\";
<strong>parameter</strong>RealeRod_ia[3]\"Unit vector along rod, resolved in frame_ia\";
<strong>parameter</strong>Reale2_ia[3]\"Unit vector along axis 2, resolved in frame_ia\";
</pre></blockquote>
<p>
这样可以更方便地定义与杆相关的数据。
例如，如果要将一个箱子连接到从frame_a原点指向杆中间的frame_ia，则可以定义如下：</p>

<blockquote><pre>
Modelica.Mechanics.MultiBody.Joints.UniversalSphericaljointUS(rRod_ia={1.2,1,0.2});
Modelica.Mechanics.MultiBody.Visualizers.FixedShapeshape(shapeType=\"box\",
lengthDirection=jointUS.eRod_ia,
widthDirection=jointUS.e2_ia,
length=jointUS.rodLength/2,
width=jointUS.rodLength/10);
<strong>equation</strong>
<strong>connect</strong>(jointUS.frame_ia,shape.frame_a);
</pre></blockquote>
</html>"), 
         Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-150,-50},{150,-90}}, 
          textColor={0,0,255}, 
          textString="%name"), 
        Ellipse(
          extent={{-100,-40},{-19,40}}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={192,192,192}), 
        Ellipse(
          extent={{-90,-30},{-29,29}}, 
          lineColor={160,160,164}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{-60,41},{-9,-44}}, 
          lineColor={255,255,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Line(
          points={{-60,40},{-60,-40}}, 
          thickness=0.5), 
        Ellipse(
          extent={{-83,-17},{-34,21}}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={192,192,192}), 
        Ellipse(
          extent={{-74,-12},{-40,15}}, 
          lineColor={160,160,164}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Polygon(
          points={{-72,-20},{-89,3},{-69,25},{-45,27},{-72,-20}}, 
          pattern=LinePattern.None, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Line(
          points={{-60,40},{-60,-10}}, 
          thickness=0.5), 
        Line(
          points={{-49,20},{-69,-15}}, 
          thickness=0.5), 
        Ellipse(
          extent={{44,14},{73,-14}}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{20,-40},{100,40}}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={192,192,192}), 
        Ellipse(
          extent={{30,-30},{90,30}}, 
          lineColor={192,192,192}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{-22,45},{40,-43}}, 
          lineColor={255,255,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{46,14},{75,-14}}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={192,192,192}), 
        Rectangle(
          extent={{-36,-8},{48,8}}, 
          pattern=LinePattern.None, 
          fillPattern=FillPattern.HorizontalCylinder, 
          fillColor={192,192,192}), 
        Text(
          extent={{-105,118},{-67,86}}, 
          textColor={128,128,128}, 
          textString="ia"), 
        Text(
          extent={{-24,95},{167,65}}, 
          textString="%rRod_ia"), 
        Line(
          points={{-40,101},{-40,60},{-60,1}}, 
          color={128,128,128}, 
          thickness=0.5)}));
end UniversalSpherical;