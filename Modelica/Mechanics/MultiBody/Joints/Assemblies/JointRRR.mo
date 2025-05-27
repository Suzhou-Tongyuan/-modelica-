within Modelica.Mechanics.MultiBody.Joints.Assemblies;
model JointRRR 
  "平面旋转-旋转-转动副组合(无约束，无潜在状态变量)"

  import Modelica.Mechanics.MultiBody.Types;
  import Modelica.Units.Conversions.to_unit1;

  extends Interfaces.PartialTwoFramesDoubleSize;

  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_ia 
    "frame_a原点处的坐标系，在左中转动副的连接杆上固定" 
    annotation (Placement(transformation(
        origin={-80,100}, 
        extent={{-8,-8},{8,8}}, 
        rotation=90)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_ib 
    "frame_b原点处的坐标系，在中右转动副的连接杆上固定" 
    annotation (Placement(transformation(
        origin={80,100}, 
        extent={{-8,8},{8,-8}}, 
        rotation=270)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_im 
    "中间转动副处原点的坐标系，在中右转动副的连接杆上固定" 
    annotation (Placement(transformation(
        origin={0,100}, 
        extent={{8,-8},{-8,8}}, 
        rotation=270)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a axis 
    "一维旋转一维接口，驱动frame_b处右侧转动副" 
    annotation (Placement(transformation(extent={{105,85},{95,75}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b bearing 
    "frame_b处右侧转动副的驱动轴承的一维旋转一维接口" 
    annotation (Placement(transformation(extent={{95,45},{105,35}})));

 parameter Boolean animation=true "=true，则启用动画";
parameter Modelica.Mechanics.MultiBody.Types.Axis n_a={0,0,1} 
  "转动副的轴在frame_a中的方向(所有轴都平行于彼此)" 
  annotation (Evaluate=true);
final parameter Real n_b[3](each final unit="1",each fixed=false, start = {0,0,1}) 
  "转动副的轴在frame_b中的固定方向" 
  annotation (Evaluate=true);
parameter SI.Position rRod1_ia[3]={1,0,0} 
  "从frame_a原点到中间转动副的矢量，解析为frame_ia" 
  annotation (Evaluate=true);
parameter SI.Position rRod2_ib[3]={-1,0,0} 
  "从frame_ib原点到中间转动副的矢量，解析为frame_ib";
parameter Modelica.Units.NonSI.Angle_deg phi_offset=0 
  "frame_b处转动副的相对角度偏移(角度=phi(t)+from_deg(phi_offset))";
parameter Modelica.Units.NonSI.Angle_deg phi_guess=0 
  "选择配置，使初始时间时|phi(t0)-from_deg(phi_guess)|最小化";
parameter SI.Distance cylinderLength=world.defaultJointLength 
  "表示转动副的圆柱体的长度" 
  annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
parameter SI.Distance cylinderDiameter=world.defaultJointWidth 
  "表示转动副的圆柱体的直径" 
  annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
input Types.Color cylinderColor=Modelica.Mechanics.MultiBody.Types.Defaults.JointColor 
  "表示转动副的圆柱体的颜色" 
  annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));
parameter SI.Diameter rodDiameter=1.1*cylinderDiameter 
  "连接转动副的两个杆的直径" 
  annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
input Types.Color rodColor=Modelica.Mechanics.MultiBody.Types.Defaults.RodColor 
  "连接转动副的两个杆的颜色" 
  annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));
input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
  "环境光的反射(=0：光线完全吸收)" 
  annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));

  parameter Boolean checkTotalPower=false 
    "=true，则确定流入该组件的总功率(必须为零)" 
    annotation (Dialog(tab="高级"));
final parameter Real e_a[3](each final unit="1")=Modelica.Math.Vectors.normalizeWithAssert(
                                               n_a) 
    "旋转轴上的单位矢量，解析在frame_a中";
final parameter Real e_ia[3](each final unit="1")=jointUSR.e2_ia 
    "旋转轴上的单位矢量，解析在frame_ia中";
final parameter Real e_b[3](each final unit="1")=jointUSR.revolute.e 
    "旋转轴上的单位矢量，解析在frame_b、frame_ib和frame_im中";
SI.Power totalPower=jointUSR.totalPower 
    "如果checkTotalPower=true，则流入该元素的总功率(否则为虚拟)";

  JointUSR jointUSR(
    animation=false, 
    n1_a=n_a, 
    n_b=n_b, 
    phi_offset=phi_offset, 
    rRod2_ib=rRod2_ib, 
    showUniversalAxes=false, 
    rRod1_ia=rRod1_ia, 
    checkTotalPower=checkTotalPower, 
    phi_guess=phi_guess) annotation (Placement(transformation(extent={{-30, 
            -20},{10,20}})));

protected
 Visualizers.Advanced.Shape shape_rev1(
    shapeType="cylinder", 
    color=cylinderColor, 
    specularCoefficient=specularCoefficient, 
    length=cylinderLength, 
    width=cylinderDiameter, 
    height=cylinderDiameter, 
    lengthDirection=e_a, 
    widthDirection={0,1,0}, 
    r_shape=-e_a*(cylinderLength/2), 
    r=frame_a.r_0, 
    R=frame_a.R) if world.enableAnimation and animation;
  Visualizers.Advanced.Shape shape_rev2(
    shapeType="cylinder", 
    color=cylinderColor, 
    specularCoefficient=specularCoefficient, 
    length=cylinderLength, 
    width=cylinderDiameter, 
    height=cylinderDiameter, 
    lengthDirection=e_b, 
    widthDirection={0,1,0}, 
    r_shape=-e_b*(cylinderLength/2), 
    r=frame_im.r_0, 
    R=frame_im.R) if world.enableAnimation and animation;
  Visualizers.Advanced.Shape shape_rev3(
    shapeType="cylinder", 
    color=cylinderColor, 
    specularCoefficient=specularCoefficient, 
    length=cylinderLength, 
    width=cylinderDiameter, 
    height=cylinderDiameter, 
    lengthDirection=e_b, 
    widthDirection={0,1,0}, 
    r_shape=-e_b*(cylinderLength/2), 
    r=frame_b.r_0, 
    R=frame_b.R) if world.enableAnimation and animation;
  Visualizers.Advanced.Shape shape_rod1(
    shapeType="cylinder", 
    color=rodColor, 
    specularCoefficient=specularCoefficient, 
    length=Modelica.Math.Vectors.length(
                         rRod1_ia), 
    width=rodDiameter, 
    height=rodDiameter, 
    lengthDirection = to_unit1(rRod1_ia), 
    widthDirection=e_ia, 
    r=frame_ia.r_0, 
    R=frame_ia.R) if world.enableAnimation and animation;
  Visualizers.Advanced.Shape shape_rod2(
    shapeType="cylinder", 
    color=rodColor, 
    specularCoefficient=specularCoefficient, 
    length=Modelica.Math.Vectors.length(
                         rRod2_ib), 
    width=rodDiameter, 
    height=rodDiameter, 
    lengthDirection = to_unit1(rRod2_ib), 
    widthDirection=e_b, 
    r=frame_ib.r_0, 
    R=frame_ib.R) if world.enableAnimation and animation;
initial equation
  n_b = Frames.resolve2(frame_b.R, Frames.resolve1(frame_a.R, n_a));

equation
  connect(jointUSR.frame_a, frame_a) 
    annotation (Line(
      points={{-30,0},{-100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(jointUSR.frame_b, frame_b) 
    annotation (Line(
      points={{10,0},{100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(jointUSR.frame_ia, frame_ia) annotation (Line(
      points={{-26,20},{-26,70},{-80,70},{-80,100}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(jointUSR.frame_im, frame_im) annotation (Line(
      points={{-10,20},{-10,70},{0,70},{0,100}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(jointUSR.frame_ib, frame_ib) annotation (Line(
      points={{6,20},{6,50},{80,50},{80,100}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(jointUSR.axis, axis) 
    annotation (Line(points={{10,16},{86,16},{86,80},{100,80}}));
  connect(jointUSR.bearing, bearing) 
    annotation (Line(points={{10,8},{94,8},{94,40},{100,40}}));
  annotation (
    Documentation(info="<html>
<p>
这个组件由<strong>3个旋转</strong>运动副组成，其旋转轴平行连接在一起，由两根杆连接在一起，参见下图中的默认动画(轴矢量不是默认动画的一部分)：</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Assemblies/JointRRR.png\"alt=\"model Joints.Assemblies.JointRRR\">
</div>

<p>
这种运动副组合既不引入约束也不引入状态变量，因此在可能的情况下应该在运动学回路中使用，以避免非线性方程组。
只有在<strong>平面回路</strong>中使用这个组件才有意义。
基本上，通过解析地求解非线性方程，给定frame_a和frame_b处的位置和方向，计算出3个转动副以及frame_ia、frame_ib和frame_im的位置和方向。
</p>

<p>
连接器<strong>frame_a</strong>是第一个转动副的“左”侧，而<strong>frame_ia</strong>是这个转动副的“右”侧，固定在杆1上。
连接器<strong>frame_b</strong>是第三个转动副的“右”侧，而<strong>frame_ib</strong>是这个转动副的“左”侧，固定在杆2上。
最后，连接器<strong>frame_im</strong>是中间转动副的“右”侧连接器，固定在杆2上。
</p>

<p>
定义这个运动副的参数的最简单方法是将MultiBody系统移动到一个<strong>参考配置</strong>中，在这个配置中，所有组件的所有<strong>坐标系</strong>都是<strong>平行</strong>的(或者，至少在定义该组件的实例时，JointRRR运动副的frame_a、frame_ia、frame_im、frame_ib、frame_b应该互相平行)。
</p>

<p>
基本上，JointRRR模型在内部由一个万向节-球面副-转动副组合(=JointUSR)组成。
在平面回路中，这将表现为通过刚性杆连接的3个平行轴转动副。
</p>

</html>"), 
    Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}, 
        initialScale=0.2), graphics={
        Rectangle(
          extent={{-90,90},{90,-90}}, 
          lineColor={255,255,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-140,-55},{140,-80}}, 
          textColor={0,0,255}, 
          textString="%name"), 
        Text(
          extent={{36,114},{71,92}}, 
          textColor={128,128,128}, 
          textString="ib"), 
        Text(
          extent={{-126,115},{-87,90}}, 
          textColor={128,128,128}, 
          textString="ia"), 
        Ellipse(
          extent={{-100,25},{-50,-25}}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-85,10},{-65,-10}}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{50,25},{100,-25}}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{65,10},{85,-10}}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-26,80},{24,30}}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-10,66},{10,46}}, 
          fillPattern=FillPattern.Solid), 
        Polygon(
          points={{-71,9},{-24,45},{-19,39},{-66,3},{-71,9}}, 
          fillPattern=FillPattern.Solid), 
        Polygon(
          points={{54,12},{5,47},{10,52},{59,18},{54,12}}, 
          fillPattern=FillPattern.Solid), 
        Polygon(
          points={{100,-4},{83,-4},{84,3},{100,3},{100,-4}}, 
          fillPattern=FillPattern.Solid), 
        Line(
          points={{80,24},{80,80},{80,80},{80,100}}, 
          color={95,95,95}, 
          thickness=0.5), 
        Text(
          extent={{-128,-29},{136,-47}}, 
          textString="n_a=%n_a"), 
        Line(
          points={{0,57},{0,86},{0,86},{0,100}}, 
          color={95,95,95}, 
          thickness=0.5), 
        Text(
          extent={{-46,114},{-7,91}}, 
          textColor={128,128,128}, 
          textString="im"), 
        Line(
          points={{-80,100},{-80,8}}, 
          color={95,95,95}, 
          thickness=0.5), 
        Line(
          points={{80,80},{101,80}}, 
          color={95,95,95}, 
          thickness=0.5), 
        Line(
          points={{100,40},{93,40},{93,3}}, 
          color={95,95,95}, 
          thickness=0.5)}));
end JointRRR;