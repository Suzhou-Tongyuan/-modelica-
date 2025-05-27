within Modelica.Mechanics.MultiBody.Joints;
model RevolutePlanarLoopConstraint 
  "平面环路中由两个位置约束描述的转动副(垂直于环路平面上的局部力和局部扭矩被任意地设定为零)"

  import T = Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
  import Modelica.Mechanics.MultiBody.Types;

  Interfaces.Frame_a frame_a 
    "接口坐标系a，具有一个局部力和一个局部力矩" 
    annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));
  Interfaces.Frame_b frame_b 
    "接口坐标系b，具有一个局部力和一个局部力矩" 
    annotation (Placement(transformation(extent={{84,-16},{116,16}})));

  parameter Boolean animation=true 
    "=true，如果启用动画(将轴显示为圆柱体)";
  parameter Modelica.Mechanics.MultiBody.Types.Axis n={0,0,1} 
    "在frame_a中解析的旋转轴(与frame_b中的相同)" 
    annotation (Evaluate=true);
  parameter SI.Distance cylinderLength=world.defaultJointLength 
    "转动副（圆柱体）的长度" 
    annotation (Dialog(group="如果animation=true", enable=animation));
  parameter SI.Distance cylinderDiameter=world.defaultJointWidth 
     "转动副（圆柱体）的直径" 
    annotation (Dialog(group="如果animation=true", enable=animation));
  input Types.Color cylinderColor=Modelica.Mechanics.MultiBody.Types.Defaults.JointColor 
     "转动副（圆柱体）的颜色" 
    annotation (Dialog(colorSelector=true, group="如果animation=true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射(=0：光被完全吸收)" 
    annotation (Dialog(group="如果animation=true", enable=animation));
protected
  outer Modelica.Mechanics.MultiBody.World world;
  parameter Real e[3](each final unit="1")=Modelica.Math.Vectors.normalizeWithAssert(n) 
    "旋转轴方向的单位矢量，在frame_a中解析(与frame_b中的相同)";
  parameter Real nnx_a[3](each final unit="1")=if abs(e[1]) > 0.1 then {0,1,0} else (if abs(e[2]) 
       > 0.1 then {0,0,1} else {1,0,0}) 
    "与旋转轴n不对齐的任意矢量" 
    annotation (Evaluate=true);
  parameter Real ey_a[3](each final unit="1")=Modelica.Math.Vectors.normalizeWithAssert(cross(e, nnx_a)) 
    "垂直于转动副轴n的单位矢量，在frame_a中解析" 
    annotation (Evaluate=true);
  parameter Real ex_a[3](each final unit="1")=cross(ey_a, e) 
    "垂直于转动副轴n和ey_a的单位矢量，在frame_a中解析" 
    annotation (Evaluate=true);
  Real ey_b[3](each final unit="1") "在frame_b中解析的ey_a";
  Real ex_b[3](each final unit="1") "在frame_b中解析的ex_a";
  Frames.Orientation R_rel 
    "从frame_a到frame_b的虚拟或相对方向对象";
  SI.Position r_rel_a[3] 
    "从frame_a原点到frame_b原点的位置矢量，在frame_a中解析";
  SI.Force f_c[2] "ex_a和ey_a方向的虚拟或约束力";

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
equation
  assert(cardinality(frame_a) > 0, 
    "转动副的连接器frame_a未连接");
  assert(cardinality(frame_b) > 0, 
    "转动副的连接器frame_b未连接");

  // 确定在 frame_a 中解析的相对位置矢量
  R_rel = Frames.relativeRotation(frame_a.R, frame_b.R);
  r_rel_a = Frames.resolve2(frame_a.R, frame_b.r_0 - frame_a.r_0);
  // r_rel_a = T.resolve1(R_rel.T, T.resolve2(frame_b.R.T, frame_b.r_0 - frame_a.r_0));

  // 约束方程
  0 = ex_a*r_rel_a;
  0 = ey_a*r_rel_a;

  /* 转换力和力矩
     (力矩假设为零)
  */
  frame_a.t = zeros(3);
  frame_b.t = zeros(3);

  frame_a.f = [ex_a, ey_a]*f_c;
  frame_b.f = -Frames.resolve2(R_rel, frame_a.f);

  // 检查转动副是否用于平面环
  ex_b = Frames.resolve2(R_rel, ex_a);
  ey_b = Frames.resolve2(R_rel, ey_a);
  assert(noEvent(abs(e*r_rel_a) <= 1e-10 and abs(e*ex_b) <= 1e-10 and 
      abs(e*ey_b) <= 1e-10), "
多体系统中的RevolutePlanarLoopConstraint运动副被用作平面环的局部运动副。
然而，转动副不是平面环的一部分，其中转动副的轴(参数n)垂直于可能的运动。
要么改用MultiBody.Joints.Revolute运动副，要么纠正平面环中转动副的轴矢量n的定义。
");

  annotation (
    defaultComponentName="revolute", 
    Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-150,70},{150,100}}, 
          textString="n=%n"), 
        Text(
          extent={{-150,-110},{150,-70}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Rectangle(
          extent={{-20,10},{20,-10}}, 
          lineColor={64,64,64}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{-100,-60},{-20,60}}, 
          lineColor={64,64,64}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          fillColor={255,255,255}, 
          radius=10), 
        Rectangle(
          extent={{20,-60},{100,60}}, 
          lineColor={64,64,64}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          fillColor={255,255,255}, 
          radius=10), 
        Rectangle(extent={{-100,60},{-20,-60}}, lineColor={64,64,64}, radius=10), 
        Rectangle(extent={{20,60},{100,-60}}, lineColor={64,64,64}, radius=10), 
        Text(
          extent={{-90,14},{-54,-11}}, 
          textColor={128,128,128}, 
          textString="a"), 
        Text(
          extent={{51,11},{87,-14}}, 
          textColor={128,128,128}, 
          textString="b"), 
        Line(
          points={{-91,-76},{-33,15},{30,-49},{87,61}}, 
          color={255,0,0}, 
          thickness=0.5)}), 
    Documentation(info="<html>
<p>
frame_b绕固定在frame_a中的轴n旋转的运动副，该运动副在平面环路中使用，提供了两个位置的约束方程。
</p>

<p>
如果存在<strong>平面环</strong>，例如，由4个转动副组成，其中转动副的轴都平行于彼此，如果所有转动副都使用Joints.Revolute进行建模则没有唯一的数学解，符号算法都将失败。
其失败的原因在于当使用三维的转动副进行描述时，垂直于平面环路的转动副中的局部力并不是唯一定义的。
通常，系统会打印出一条错误信息，指出这种情况。
在这种情况下，环路中的<strong>一个</strong>转动副必须替换为Joints.RevolutePlanarLoopCutJoint模型。
其效果是将三维转动副的5个约束中的3个约束移除，并替换为适当的已知变量
(例如，沿着旋转轴方向的力被视为已知值且等于0；对于标准的转动副，这个力是一个未知量)。
</p>


</html>"));
end RevolutePlanarLoopConstraint;