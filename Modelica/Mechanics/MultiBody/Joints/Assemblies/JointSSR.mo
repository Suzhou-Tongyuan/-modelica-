within Modelica.Mechanics.MultiBody.Joints.Assemblies;
model JointSSR 
  "球面副-球面副-转动副组合物带质量(无约束，无势态)"

  import Modelica.Mechanics.MultiBody.Types;

  extends Interfaces.PartialTwoFramesDoubleSize;
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_ib 
    "球面副和转动副连接杆上固定在frame_b原点处的坐标系" 
    annotation (Placement(transformation(
        origin={80,100}, 
        extent={{-8,8},{8,-8}}, 
        rotation=270)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_im 
    "球面副中间连接杆上固定在球面副原点处的坐标系" 
    annotation (Placement(transformation(
        origin={0,100}, 
        extent={{8,-8},{-8,8}}, 
        rotation=270)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a axis 
    "驱动转动副的一维旋转一维接口" 
    annotation (Placement(transformation(extent={{105,85},{95,75}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b bearing 
    "转动副驱动轴承的一维旋转一维接口" 
    annotation (Placement(transformation(extent={{95,45},{105,35}})));

parameter Boolean animation=true "=如果要启用动画，则为true";
parameter Boolean showMass=true 
  "=如果要显示连接杆1上的质点质量(前提是animation=true并且rod1Mass>0)";
parameter SI.Length rod1Length(min=Modelica.Constants.eps, start = 1) 
  "两个球面副原点之间的距离";
parameter SI.Mass rod1Mass(min=0)=0 
  "连接杆1的质量(连接两个球面副中间的质点质量)";
parameter Modelica.Mechanics.MultiBody.Types.Axis n_b={0,0,1} 
  "固定在frame_b中的转动副轴";
parameter SI.Position rRod2_ib[3]={1,0,0} 
  "从frame_ib原点到球面副中间的矢量，以frame_ib为参考系";
parameter Modelica.Units.NonSI.Angle_deg phi_offset=0 
  "转动副的相对角度偏移(角度=phi(t)+from_deg(phi_offset))";
parameter Modelica.Units.NonSI.Angle_deg phi_guess=0 
  "选择初始时刻|phi(t0)-from_deg(phi_guess)|尽可能小的配置";
parameter SI.Diameter sphereDiameter=world.defaultJointLength 
  "表示两个球面副的球的直径" 
  annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
input Types.Color sphereColor=Modelica.Mechanics.MultiBody.Types.Defaults.
     JointColor 
  "表示两个球面副的球的颜色" 
  annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));
parameter SI.Diameter rod1Diameter=sphereDiameter/Types.Defaults.
    JointRodDiameterFraction 
  "连接两个球面副的连接杆1的直径" 
  annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
input Types.Color rod1Color=Modelica.Mechanics.MultiBody.Types.Defaults.
    RodColor "连接两个球面副的连接杆1的颜色" 
  annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));
parameter SI.Diameter rod2Diameter=rod1Diameter 
  "连接转动副和球面副2的连接杆2的直径" 
  annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
input Types.Color rod2Color=rod1Color 
  "连接转动副和球面副2的连接杆2的颜色" 
  annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));
parameter SI.Diameter revoluteDiameter=world.defaultJointWidth 
  "表示转动副的圆柱体的直径" 
  annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
parameter SI.Distance revoluteLength=world.defaultJointLength 
  "表示转动副的圆柱体的长度" 
  annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
input Types.Color revoluteColor=Modelica.Mechanics.MultiBody.Types.
    Defaults.JointColor 
  "表示转动副的圆柱体的颜色" 
  annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));
input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
  "环境光的反射(=0：光被完全吸收)" 
  annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
parameter Boolean checkTotalPower=false 
  "=如果要确定流入此组件的总功率(必须为零)" 
  annotation (Dialog(tab="高级"));

 SI.Position aux 
  "用于计算连接万向节和球面副的杆的力的分母";
SI.Force f_rod 
  "杆沿杆方向的约束力(如果杆被按压，则为正)";
SI.Power totalPower 
  "如果checkTotalPower=true，则流入此元素的总功率(否则为虚拟)";

  Modelica.Mechanics.MultiBody.Joints.Internal.RevoluteWithLengthConstraint revolute(
    animation=animation, 
    lengthConstraint=rod1Length, 
    n=n_b, 
    phi_offset=phi_offset, 
    phi_guess=phi_guess, 
    cylinderDiameter=revoluteDiameter, 
    cylinderLength=revoluteLength, 
    cylinderColor=revoluteColor, 
    specularCoefficient=specularCoefficient) annotation (Placement(transformation(extent={{75,-20},{35,20}})));
  Modelica.Mechanics.MultiBody.Joints.SphericalSpherical rod1(
    animation=animation, 
    showMass=showMass, 
    m=rod1Mass, 
    rodLength=rod1Length, 
    rodDiameter=rod1Diameter, 
    sphereDiameter=sphereDiameter, 
    rodColor=rod1Color, 
    specularCoefficient=specularCoefficient, 
    kinematicConstraint=false, 
    sphereColor=sphereColor, 
    constraintResidue=rod1.f_rod - f_rod) annotation (Placement(transformation(extent={{-89,-20},{-49,20}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation rod2(
    animation=animation, 
    width=rod2Diameter, 
    height=rod2Diameter, 
    color=rod2Color, 
    specularCoefficient=specularCoefficient, 
    r=rRod2_ib) annotation (Placement(transformation(extent={{15,-20},{-25, 
            20}})));
  Sensors.RelativePosition relativePosition(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a) 
    annotation (Placement(transformation(extent={{60,-70},{40,-90}})));
  Modelica.Blocks.Sources.Constant position_b[3](k=rRod2_ib) 
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
equation
  /* 计算rod1运动副杆中的未知力
     通过在转动副处的力矩平衡来实现：
       0 = frame_b.t + frame_ib.t + frame_im.t + cross(rRod2_ib, frame_im.f)
           + cross(rRod2_ib, -rod1.f_b_a1)
           + cross(rRod2_ib, Frames.resolve2(rod1.R_rel, rod1.f_rod*rod1.eRod_a))
     条件是，转动副中力矩在转动副轴的投影等于一维接口上的驱动轴力矩：
       -revolute.tau = revolute.e*frame_b.t
     因此，我们有e=revolute.e和tau=revolute.tau
        tau = e*(frame_ib.t  + frame_im.t + cross(rRod2_ib, frame_im.f)
              + cross(rRod2_ib, -rod1.f_b_a1))
              + e*cross(rRod2_ib, Frames.resolve2(rod1.R_rel, rod1.f_rod*rod1.eRod_a))
            = e*(frame_ib.t + frame_im.t + cross(rRod2_ib, frame_im.f)
              + cross(rRod2_ib, -rod.f_b_a1))
              + rod1.f_rod*e*cross(rRod2_ib, Frames.resolve2(rod1.R_rel, rod1.eRod_a))
     解决此方程以获得f_rod的结果为
       rod1.f_rod = (tau - e*(frame_ib.t + frame_im.t + cross(rRod2_ib, frame_im.f)
                   + cross(rRod2_ib, -rod1.f_b_a1)))
                   / (cross(e,rRod2_ib)*Frames.resolve2(rod1.R_rel, rod1.eRod_a))
     另外，引入了防止除零的保护
  */

  aux = cross(revolute.e, rRod2_ib)*Frames.resolveRelative(rod1.eRod_a, 
    rod1.frame_a.R, rod1.frame_b.R);
  f_rod = (-revolute.tau - revolute.e*(frame_ib.t + frame_im.t + cross(
    rRod2_ib, frame_im.f) - cross(rRod2_ib, Frames.resolveRelative(rod1.
    f_b_a1, rod1.frame_a.R, rod1.frame_b.R))))/noEvent(if abs(aux) < 1e-10 then 
          1e-10 else aux);

  // 测试目的测量功率

  if checkTotalPower then
    totalPower = frame_a.f*Frames.resolve2(frame_a.R, der(frame_a.r_0)) + 
      frame_b.f*Frames.resolve2(frame_b.R, der(frame_b.r_0)) + frame_ib.f* 
      Frames.resolve2(frame_ib.R, der(frame_ib.r_0)) + frame_im.f* 
      Frames.resolve2(frame_im.R, der(frame_im.r_0)) + frame_a.t* 
      Frames.angularVelocity2(frame_a.R) + frame_b.t* 
      Frames.angularVelocity2(frame_b.R) + frame_ib.t* 
      Frames.angularVelocity2(frame_ib.R) + frame_im.t* 
      Frames.angularVelocity2(frame_im.R) + axis.tau*der(axis.phi) + 
      bearing.tau*der(bearing.phi) + (-rod1Mass)*(der(rod1.v_CM_0) - 
      world.gravityAcceleration(rod1.r_CM_0))*rod1.v_CM_0;
  else
    totalPower = 0;
  end if;

  connect(revolute.frame_b, rod2.frame_a) annotation (Line(
      points={{35,0},{15,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(rod2.frame_b, rod1.frame_b) annotation (Line(
      points={{-25,0},{-49,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(revolute.frame_a, frame_b) annotation (Line(
      points={{75,0},{100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(rod2.frame_a, frame_ib) annotation (Line(
      points={{15,0},{26,0},{26,70},{80,70},{80,100}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(rod1.frame_a, frame_a) annotation (Line(
      points={{-89,0},{-100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(relativePosition.frame_b, frame_a) 
                                           annotation (Line(
      points={{40,-80},{-95,-80},{-95,0},{-100,0}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(relativePosition.frame_a, frame_b) 
                                           annotation (Line(
      points={{60,-80},{96,-80},{96,0},{100,0}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(position_b.y, revolute.position_b) annotation (Line(
      points={{1,-40},{20,-40},{20,-12},{31,-12}}, color={0,0,127}));
  connect(revolute.axis, axis) annotation (Line(points={{55,20},{55,60},{90, 
          60},{90,80},{100,80}}));
  connect(rod2.frame_b, frame_im) annotation (Line(
      points={{-25,0},{-35,0},{-35,60},{0,60},{0,100}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(relativePosition.r_rel, revolute.position_a) 
                                                     annotation (Line(
      points={{50,-69},{50,-50},{90,-50},{90,-12},{79,-12}}, color={0,0,127}));
  connect(revolute.bearing, bearing) annotation (Line(
      points={{67,20},{67,40},{100,40}}));
  annotation (
    Documentation(info="<html>
<p>
该组件由frame_a处的一个<strong>球面副</strong>运动副1、frame_b处的一个<strong>旋转</strong>运动副以及通过rod1连接到球面副1的一个<strong>球面副</strong>运动副2和通过rod2连接到转动副的构成，参见以下图中的默认动画(轴向矢量不是默认动画的一部分)：</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Assemblies/JointSSR.png\"alt=\"model Joints.Assemblies.JointSSR\">
</div>

<p>
除了rod1中间的可选质点外，这个运动副组合没有质量和转动惯量，也不引入约束或潜在状态变量。
在可能的情况下，应该在运动学环路中使用它，因为这个运动副组合引入的非线性方程组是通过解析方法求解的(即，如果存在唯一解，则总是计算出解)。
</p>
<p>
存在额外的<strong>frame_ib</strong>。
它在连接转动副和球面副的rod2中是<strong>固定</strong>的，在与连接到此rod的转动副的那一侧(即rod2.frame_a=revolute.frame_a)。
</p>
<p>
存在额外的<strong>frame_im</strong>。
它在连接转动副和球面副的rod2中是<strong>固定</strong>的，在连接到此rod的球面副2的那一侧(即rod2.frame_b)。
它始终与<strong>frame_ib</strong>平行。
</p>
<p>
定义这个运动副的参数的最简单方法是将MultiBody系统移动到一个<strong>参考配置</strong>中，在这个配置中，<strong>所有组件的所有frame</strong>都是<strong>平行</strong>的(或者，至少当定义这个组件的一个实例时，JointSSR运动副的frame_b和frame_ib应该是彼此平行的)。
</p>
</html>"), 
    Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}, 
        initialScale=0.2), graphics={
        Text(
          extent={{-141,-41},{139,-66}}, 
          textColor={0,0,255}, 
          textString="%name"), 
        Ellipse(
          extent={{-100,-30},{-40,30}}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={192,192,192}), 
        Ellipse(
          extent={{-93,-22},{-48,23}}, 
          lineColor={160,160,164}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{-63,33},{-39,-33}}, 
          lineColor={255,255,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-40,-30},{20,30}}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={192,192,192}), 
        Ellipse(
          extent={{-33,-22},{12,23}}, 
          lineColor={192,192,192}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{-44,31},{-19,-30}}, 
          lineColor={255,255,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-23,10},{-3,-10}}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{19,6},{61,-6}}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          fillColor={192,192,192}), 
        Rectangle(
          extent={{60,-30},{76,30}}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          fillColor={192,192,192}), 
        Rectangle(
          extent={{85,-30},{100,30}}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          fillColor={192,192,192}), 
        Rectangle(
          extent={{76,10},{85,-10}}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(extent={{60,30},{76,-30}}), 
        Rectangle(extent={{85,30},{100,-30}}), 
        Text(
          extent={{88,112},{127,92}}, 
          textColor={128,128,128}, 
          textString="ib"), 
        Ellipse(
          extent={{-80,11},{-60,-9}}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{-62,6},{-21,-5}}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          fillColor={192,192,192}), 
        Line(
          points={{80,80},{100,80}}, 
          color={95,95,95}, 
          thickness=0.5), 
        Line(
          points={{19,6},{19,80},{0,80},{0,100}}, 
          color={95,95,95}, 
          thickness=0.5), 
        Text(
          extent={{-47,111},{-8,92}}, 
          textColor={128,128,128}, 
          textString="im"), 
        Line(
          points={{68,30},{68,80},{80,80},{80,98}}, 
          color={95,95,95}, 
          thickness=0.5), 
        Line(
          points={{90,30},{90,40},{95,40}}, 
          color={95,95,95}, 
          thickness=0.5)}));
end JointSSR;