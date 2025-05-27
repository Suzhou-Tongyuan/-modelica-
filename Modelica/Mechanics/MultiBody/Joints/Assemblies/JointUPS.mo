within Modelica.Mechanics.MultiBody.Joints.Assemblies;
model JointUPS 
  "万向节-平移副-球面副组合(无约束，无潜在状态变量)"

  import Modelica.Mechanics.MultiBody.Types;
  extends Interfaces.PartialTwoFramesDoubleSize;
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_ia 
    "连接到平移副固定在frame_a原点的坐标系" 
    annotation (Placement(transformation(
        origin={-80,100}, 
        extent={{-8,-8},{8,8}}, 
        rotation=270)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_ib 
    "连接到平移副固定在frame_b原点的坐标系" 
    annotation (Placement(transformation(
        origin={80,100}, 
        extent={{-8,8},{8,-8}}, 
        rotation=270)));
  Modelica.Mechanics.Translational.Interfaces.Flange_a axis 
    "驱动平移副的一维平动一维接口" 
    annotation (Placement(transformation(extent={{45,95},{35,105}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b bearing 
    "平移副驱动轴承的一维平动一维接口" 
    annotation (Placement(transformation(extent={{-35,95},{-45,105}})));

  parameter Boolean animation=true "=true，则启用动画";
  parameter Boolean showUniversalAxes=true 
    "=true，则用两个圆柱来可视化通用运动副，否则用一个球(如果animation=true)";
  parameter Modelica.Mechanics.MultiBody.Types.Axis n1_a={0,0,1} 
    "通用运动副在frame_a中解析的轴1(轴2与轴1垂直且与从通用到球面副的线相垂直)" 
    annotation (Evaluate=true);
  parameter SI.Position nAxis_ia[3]={1,0,0} 
    "从frame_a原点到frame_b原点的线的轴向矢量，在frame_ia中解析" 
    annotation (Evaluate=true);
  parameter SI.Position s_offset=0 
    "相对距离偏移(frame_a和frame_b之间的距离=s(t)+s_offset)";
  parameter SI.Diameter sphereDiameter=world.defaultJointLength 
    "表示球面副的球的直径" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
  input Types.Color sphereColor=Modelica.Mechanics.MultiBody.Types.Defaults.JointColor 
    "表示球面副的球的颜色" 
    annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));
  parameter SI.Diameter axisDiameter=sphereDiameter/Types.Defaults.
      JointRodDiameterFraction 
    "连接从frame_a到frame_b的连线上圆柱的直径" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
  input Types.Color axisColor=Modelica.Mechanics.MultiBody.Types.Defaults.SensorColor 
    "连接从frame_a到frame_b的连线上圆柱的颜色" 
    annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射(=0：光被完全吸收)" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
  parameter SI.Distance cylinderLength=world.defaultJointLength 
    "表示两个通用运动副轴的圆柱的长度" annotation (
     Dialog(tab="动画", group="如果animation=trueandshowUniversalAxes", 
            enable=animation and showUniversalAxes));
  parameter SI.Distance cylinderDiameter=world.defaultJointWidth 
    "表示两个通用运动副轴的圆柱的直径" 
    annotation (Dialog(tab="动画", group= 
          "如果animation=trueandshowUniversalAxes", 
            enable=animation and showUniversalAxes));
 input Types.Color cylinderColor=Modelica.Mechanics.MultiBody.Types.Defaults.JointColor 
    "表示两个通用运动副轴的圆柱的颜色" annotation (
      Dialog(colorSelector=true, tab="动画", group="如果animation=trueandshowUniversalAxes", 
            enable=animation and showUniversalAxes));


  parameter Boolean checkTotalPower=false 
    "=true，如果要确定流入该组件的总功率(必须为零)" 
    annotation (Dialog(tab="高级"));
  final parameter Real eAxis_ia[3](each final unit="1")=Modelica.Math.Vectors.normalizeWithAssert(nAxis_ia) 
    "从frame_a原点到frame_b原点的单位矢量，在frame_ia中解析";
  final parameter Real e2_ia[3](each final unit="1")=Modelica.Math.Vectors.normalizeWithAssert(
                                                 cross(n1_a, eAxis_ia)) 
    "通用运动副第二旋转轴方向的单位矢量，在frame_ia中解析";
  final parameter Real e3_ia[3](each final unit="1")=cross(eAxis_ia, e2_ia) 
    "垂直于eAxis_ia和e2_ia的单位矢量，在frame_ia中解析";
  SI.Position s 
    "frame_a和frame_b沿轴nAxis之间的相对距离=s+s_offset";
  SI.Force f "=axis.f(轴上的驱动力;=-bearing.f)";
  SI.Length axisLength "frame_a和frame_b之间的距离";
  SI.Power totalPower 
    "如果checkTotalPower=true，则流入该元素的总功率(否则为虚拟)";

protected
  SI.Force f_c_a[3] "frame_ia.f在frame_a中解析";
  SI.Torque t_cd_a[3] "frame_ia.t+frame_ib.t在frame_a中解析";
  SI.Force f_bd_a[3] "frame_b.f+frame_ib.f在frame_a中解析";
  SI.Position rAxis_0[3] 
    "从frame_a原点到frame_b原点的位置矢量，在全局坐标系中解析";
  SI.Position rAxis_a[3] 
    "从frame_a原点到frame_b原点的位置矢量，在frame_a中解析";
  Real eAxis_a[3](each final unit="1") 
    "rAxis_a方向的单位矢量，在frame_a中解析";
  Real e2_a[3](each final unit="1") 
    "通用运动副第二旋转轴方向的单位矢量，在frame_a中解析";
  Real e3_a[3](each final unit="1") 
    "垂直于eAxis_a和e2_a的单位矢量，在frame_a中解析";
  Real n2_a[3](each final unit="1") 
    "通用运动副第二旋转轴方向的矢量，在frame_a中解析";
  Real length2_n2_a(unit="1") "矢量n2_a的长度的平方";
  Real length_n2_a(unit="1") "矢量n2_a的长度";
  Real der_rAxis_a_L[3](each unit="1/s") "=der(rAxis_a)/axisLength";
  SI.AngularVelocity w_rel_ia1[3];
  Frames.Orientation R_ia1_a;
  Frames.Orientation R_ia2_a;
  Frames.Orientation R_ia_a "从frame_a到frame_ia的旋转";
  // Real T_ia_a[3, 3] "从frame_a到frame_ia的转换矩阵";


  Visualizers.Advanced.Shape axisCylinder(
    shapeType="cylinder", 
    color=axisColor, 
    specularCoefficient=specularCoefficient, 
    length=axisLength, 
    width=axisDiameter, 
    height=axisDiameter, 
    lengthDirection=eAxis_ia, 
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
    R=frame_a.R) if world.enableAnimation and animation;
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
equation
  Connections.branch(frame_a.R, frame_ia.R);
  Connections.branch(frame_ia.R, frame_ib.R);

 // 平动一维接口
  axisLength = s + s_offset;
  bearing.s = 0;
  axis.s = s;
  axis.f = f;

  // 位置矢量 rAxis 从 frame_a 到 frame_b
  rAxis_0 = frame_b.r_0 - frame_a.r_0;
  rAxis_a = Frames.resolve2(frame_a.R, rAxis_0);

  /* 确定从 frame_a 到 frame_ia 的相对旋转 R_rel_c 
     和 frame_a.R 的绝对旋转。
  */
  axisLength = sqrt(rAxis_0*rAxis_0);
  assert(axisLength > 1.0e-15, "
运动副UPS联合的frame_a和frame_b之间的距离为零。
这是不允许的。
如果在初始化期间发生这种情况，
则初始条件可能是错误的。
");

  eAxis_a = rAxis_a/axisLength;
  n2_a = cross(n1_a, eAxis_a);
  length2_n2_a = n2_a*n2_a;
  assert(noEvent(length2_n2_a > 1e-10), "
一个Modelica.Mechanics.MultiBody.Joints.Assemblies.JointUPS联合(由
通用、平动和球形联轴器组成)处于通用联轴器的奇异
配置。
这意味着通过参数“n1_a”定义的通用联轴器的轴1是平行的
指向从frame_a原点到frame_b原点的\"eAxis_ia\"矢量。
您可以尝试使用另一个“n1_a”矢量。
");

length_n2_a = sqrt(length2_n2_a);  // 计算 n2_a 的长度
e2_a = n2_a / length_n2_a;  // 计算 e2_a 单位矢量
e3_a = cross(eAxis_a, e2_a);  // 计算 e3_a 单位矢量

// 下面的语句是对原始方程的有效实现：
// T_ia_a = [eAxis_ia, e2_ia, e3_ia]*transpose([eAxis_a, e2_a, e3_a]);
// R_ia_a = Frames.from_T(T_ia_a, Frames.TransformationMatrices.angularVelocity2(T_ia_a, der(T_ia_a)));
// 为了执行这个，将旋转分为两部分：
// R_ia_a: 从 frame_a 到 frame_ia 的旋转对象
// R_ia1_a: 从 frame_a 到 frame_ia1 的旋转对象(在 frame_ia 中固定的 frame，使得 x 轴沿着杆轴)
// T = transpose([eAxis_a, e2_a, e3_a]；w = w_rel_ia1
// R_ia2_a: 从 frame_ia1 到 frame_ia 的固定旋转对象
// T = [eAxis_a, e2_ia, e3_ia]；w = zeros(3)

// 计算 w_rel_ia1 的困难部分是：
// w_rel_ia1 = [e3_a*der(e2_a); -e3_a*der(eAxis_a); e2_a*der(eAxis_a)]
// der(eAxis_a) 直接给出，因为 eAxis_a 仅是与平动量相关的函数。
// der(eAxis_a) = (der(rAxis_a) - eAxis_a*(eAxis_a*der(rAxis_a)))/axisLength
// der(n2_a) = cross(n1_a, der(eAxis_a))
// der(e2_a) = (der(n2_a) - e2_a*(e2_a*der(n2_a)))/length_n2_a
// 将这些方程代入 w_rel_ia1 中得到：
// e3_a*der(eAxis_a) = e3_a*der(rAxis_a)/axisLength  // e3_a*eAxis_a = 0
// e2_a*der(eAxis_a) = e2_a*der(rAxis_a)/axisLength  // e2_a*eAxis_a = 0
// e3_a*der(e2_a) = e3_a*der(n2_a)/length_n2_a  // e3_a*e2_a = 0
//                = e3_a*cross(n1_a, der(eAxis_a))/length_n2_a
//                = e3_a*cross(n1_a, der(rAxis_a) - eAxis_a*(eAxis_a*der(rAxis_a)))/(length_n2_a*axisLength)
//                = e3_a*cross(n1_a, der(rAxis_a))/(length_n2_a*axisLength)
// 此外，我们有：
// rAxis_a = resolve2(frame_a.R, rAxis_0);
// der(rAxis_a) = resolve2(frame_a.R, der(rAxis_0)) - cross(frame_a.R.w, rAxis_a));
der_rAxis_a_L = (Frames.resolve2(frame_a.R, der(rAxis_0)) - cross(frame_a.R.w, rAxis_a))/axisLength;
w_rel_ia1 = {e3_a*cross(n1_a, der_rAxis_a_L)/length_n2_a,-e3_a*der_rAxis_a_L,e2_a*der_rAxis_a_L};
R_ia1_a = Frames.from_T(transpose([eAxis_a, e2_a, e3_a]), w_rel_ia1);
R_ia2_a = Frames.from_T([eAxis_ia, e2_ia, e3_ia], zeros(3));
R_ia_a = Frames.absoluteRotation(R_ia1_a, R_ia2_a);

// 计算 frame_ia 和 frame_ib 的运动学量
frame_ia.r_0 = frame_a.r_0;
frame_ib.r_0 = frame_b.r_0;
frame_ia.R = Frames.absoluteRotation(frame_a.R, R_ia_a);
frame_ib.R = frame_ia.R;

// 在以下公式中，f_a、f_b、f_ia、f_ib、t_a、t_b、t_ia、t_ib 是分别在 frame_a、frame_b、frame_ia、frame_ib 中解析的力和力矩，eAxis、e2、e3 是在 frame_a 中解析的单位矢量。
// 绕 frame_a 原点的杆的扭矩平衡：
// 0 = t_a + t_ia + t_ib + cross(rAxis, (f_b+f_ib))
// 其中
// rAxis = axisLength*eAxis
// f_bd  = f_b + f_ib
// f_bd  = f*eAxis + f_bd[2]*e2 + f_bd[3]*e3
// 得到：
// 0 = t_a + t_ia + axisLength*(f_bd[2]*e_z - f_bd[3]*e_y)
// t_a 关于万向节轴的投影消失：
// e1*t_a = 0
// e2*t_a = 0
// 因此：
// 0 = e1*(t_ia + t_ib) + axisLength*f_bd[2]*(e1*e3)
// 0 = e2*(t_ia + t_ib) - axisLength*f_bd[3]
// 或者
// f_bd = f*eAxis - e2*(e1*(t_ia+t_ib))/(axisLength*(e1*e3)) + e3*(e2*(t_ia+t_ib))/axisLength
// 力的平衡：
// 0 = f_a + f_bd + f_ia
  f_c_a = Frames.resolve1(R_ia_a, frame_ia.f);
  t_cd_a = Frames.resolve1(R_ia_a, frame_ia.t + frame_ib.t);
  f_bd_a = -eAxis_a*f - e2_a*((n1_a*t_cd_a)/(axisLength*(n1_a*e3_a))) + 
    e3_a*((e2_a*t_cd_a)/axisLength);
  zeros(3) = frame_b.f + Frames.resolveRelative(frame_ib.f, frame_ib.R, 
    frame_b.R) - Frames.resolveRelative(f_bd_a, frame_a.R, frame_b.R);
  zeros(3) = frame_b.t;
  zeros(3) = frame_a.f + f_c_a + f_bd_a;
  zeros(3) = frame_a.t + t_cd_a + cross(rAxis_a, f_bd_a);

  // Measure power for test purposes
  if checkTotalPower then
    totalPower = frame_a.f*Frames.resolve2(frame_a.R, der(frame_a.r_0)) + 
      frame_b.f*Frames.resolve2(frame_b.R, der(frame_b.r_0)) + frame_ia.f* 
      Frames.resolve2(frame_ia.R, der(frame_ia.r_0)) + frame_ib.f* 
      Frames.resolve2(frame_ib.R, der(frame_ib.r_0)) + frame_a.t* 
      Frames.angularVelocity2(frame_a.R) + frame_b.t* 
      Frames.angularVelocity2(frame_b.R) + frame_ia.t* 
      Frames.angularVelocity2(frame_ia.R) + frame_ib.t* 
      Frames.angularVelocity2(frame_ib.R) + axis.f*der(axis.s) + bearing.f* 
      der(bearing.s);
  else
    totalPower = 0;
  end if;
  annotation (
    Documentation(info="<html>
<p>
这个组件由frame_a处的万向节、frame_b处的球面副和沿着连接frame_a和frame_b原点的线的平移副组成，参见下图中的默认动画(轴矢量不是默认动画的一部分):</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Assemblies/JointUPS.png\"alt=\"model Joints.Assemblies.JointUPS\">
</div>

<p>
这个联合组件没有质量和转动惯量，也不引入约束或潜在的状态变量。
它特别适用于构建更复杂的力元素，其中力元素的质量和/或转动惯量应被考虑。
</p>
<p>
万向节的定义如下：</p>
<ul>
<li>转动副1的旋转轴沿着参数矢量n1_a，该矢量固定在frame_a中。
</li>
<li>转动副2的旋转轴垂直于轴1，并且垂直于连接万向节和球面副的线。
</li>
</ul>
<p>
根据最常见的情况，对万向节轴2的定义是为了简单起见。
否则，如果轴2不与轴1和连接杆垂直，处理将变得更加复杂，操作数将大大增加。
</p>
<p>
注意，当轴1和连接线平行时会出现<strong>奇点</strong>。
因此，如果可能的话，应该选择n1_a，使其在初始配置中与nAxis_ia垂直(即，与奇点的距离尽可能大)。
</p>
<p>
另外还有一个<strong>frame_ia</strong>。
它<strong>固定</strong>在连接通用运动副和球面副的线上，位于<strong>frame_a</strong>的原点处。
frame_ia在这条线上的放置由通用运动副隐式定义(当通用运动副的两个转动副的角度为零时，frame_a和frame_ia重合)，以及由参数矢量<strong>nAxis_ia</strong>定义，该矢量是沿着从frame_a原点到球面副的线方向解析在frame_<strong>ia</strong>中的轴矢量。
</p>
<p>
另外还有一个<strong>frame_ib</strong>。
它<strong>固定</strong>在连接平动和球面副的线上，位于<strong>frame_b</strong>的原点处。
它始终与<strong>frame_ia</strong>平行。
</p>
<p>
注意，此运动副组合可以用于现实中存在两端带有球面副的杆的情况。
这样的系统具有沿其轴旋转杆的额外自由度。
在实践中，这种旋转通常不感兴趣，并且在数学上通过将一个球面副替换为一个通用运动副来移除。
</p>
<p>
定义此运动副参数的最简单方法是将MultiBody系统移动到一个<strong>参考配置</strong>中，在该配置中<strong>所有组件的所有frame</strong>都<strong>平行</strong>(或者，至少JointUSP运动副的frame_a、frame_ia和frame_ib应该在定义此组件实例时平行)。
</p>

</html>"), 
    Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}, 
        initialScale=0.2), graphics={
        Text(
          extent={{-140,-50},{140,-75}}, 
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
          extent={{45,14},{74,-14}}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={192,192,192}), 
        Text(
          extent={{-98,84},{-60,65}}, 
          textColor={128,128,128}, 
          textString="ia"), 
        Line(
          points={{-40,0},{-40,90},{-80,90},{-80,97}}, 
          color={95,95,95}, 
          thickness=0.5), 
        Text(
          extent={{61,86},{109,64}}, 
          textColor={128,128,128}, 
          textString="ib"), 
        Rectangle(
          extent={{-35,-13},{-6,14}}, 
          pattern=LinePattern.None, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Rectangle(
          extent={{-35,14},{-6,18}}, 
          pattern=LinePattern.None, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Rectangle(
          extent={{-6,-7},{46,6}}, 
          pattern=LinePattern.None, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Rectangle(
          extent={{-6,6},{46,10}}, 
          pattern=LinePattern.None, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Line(points={{-6,-13},{-6,18}}), 
        Line(
          points={{60,-1},{60,90},{80,90},{80,97}}, 
          color={95,95,95}, 
          thickness=0.5), 
        Line(
          points={{60,90},{40,90},{40,95}}, 
          color={95,95,95}, 
          thickness=0.5), 
        Line(points={{-30,70},{10,70}}), 
        Polygon(
          points={{30,70},{10,76},{10,63},{30,70}}, 
          lineColor={128,128,128}, 
          fillColor={128,128,128}, 
          fillPattern=FillPattern.Solid), 
        Line(
          points={{-40,90},{-40,90},{-40,95}}, 
          color={95,95,95}, 
          thickness=0.5)}));
end JointUPS;