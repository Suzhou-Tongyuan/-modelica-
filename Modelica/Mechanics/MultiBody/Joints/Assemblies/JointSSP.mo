within Modelica.Mechanics.MultiBody.Joints.Assemblies;
model JointSSP 
  "球面副-球面副-平移副组合，带质量(无约束，无潜在状态变量)"
  import Modelica.Mechanics.MultiBody.Types;
  extends Interfaces.PartialTwoFramesDoubleSize;
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_ib 
    "位于球面副和平移副连接杆固定点的frame_b原点处的坐标系" 
    annotation (Placement(transformation(
        origin={80,100}, 
        extent={{-8,8},{8,-8}}, 
        rotation=270)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_im 
    "位于球面副中间固定在球面副和平移副连接杆上的球面副原点处的坐标系" 
    annotation (Placement(transformation(
        origin={0,100}, 
        extent={{8,-8},{-8,8}}, 
        rotation=270)));
  Modelica.Mechanics.Translational.Interfaces.Flange_a axis 
    "驱动平移副的一维平动一维接口" 
    annotation (Placement(transformation(extent={{95,75},{105,85}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b bearing 
    "平移副驱动轴承的一维平动一维接口" 
    annotation (Placement(transformation(extent={{105,35},{95,45}})));

  parameter Boolean animation=true "=true，启用动画";
  parameter Boolean showMass=true 
    "=true，如果要显示连接杆上的质点(如果animation=true且rod1Mass>0)";
  parameter SI.Length rod1Length(min=Modelica.Constants.eps, start = 1) 
    "两个球面副原点之间的距离";
  parameter SI.Mass rod1Mass(min=0)=0 
    "连接两个球面副的杆的质量(位于杆中间的质点的质量)";
  parameter Modelica.Mechanics.MultiBody.Types.Axis n_b={0,0,1} 
    "固定在frame_b中并在frame_b中解析的平移副轴";
  parameter SI.Position rRod2_ib[3]={1,0,0} 
    "从frame_ib原点到球面副中间的矢量，在frame_ib中解析";
  parameter SI.Position s_offset=0 
    "平移副的相对距离偏移(frame_b和frame_ib之间的距离=s(t)+s_offset)";
  parameter SI.Position s_guess=0 
    "选择初始时间点时|s(t0)-s_guess|最小的配置";

parameter SI.Diameter sphereDiameter=world.defaultJointLength 
    "表示两个球面副的球的直径" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
input Types.Color sphereColor=Modelica.Mechanics.MultiBody.Types.Defaults.
       JointColor 
    "表示两个球面副的球的颜色" 
    annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));
parameter SI.Diameter rod1Diameter=sphereDiameter/Types.Defaults.
      JointRodDiameterFraction 
    "连接两个球面副的杆的直径" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
input Types.Color rod1Color=Modelica.Mechanics.MultiBody.Types.Defaults.
      RodColor "连接两个球面副的杆的颜色" 
    annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));

parameter SI.Diameter rod2Diameter=rod1Diameter 
    "连接转动副和第二个球面副的杆的直径" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
input Types.Color rod2Color=rod1Color 
    "连接转动副和第二个球面副的杆的颜色" 
    annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));

parameter Types.Axis boxWidthDirection={0,1,0} 
    "平移副箱子宽度方向上的矢量，解析在frame_b中" 
    annotation (Evaluate=true, Dialog(tab="动画", group="如果animation=true", enable=animation));
parameter SI.Distance boxWidth=world.defaultJointWidth 
    "平移副箱子的宽度" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
parameter SI.Distance boxHeight=boxWidth "平移副箱子的高度" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
input Types.Color boxColor=Modelica.Mechanics.MultiBody.Types.Defaults.JointColor 
    "平移副箱子的颜色" 
    annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));
input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光反射(=0：光完全被吸收)" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
parameter Boolean checkTotalPower=false 
    "=true，如果要确定流入此组件的总功率(必须为零)" 
    annotation (Dialog(tab="高级"));
Real aux 
    "用于计算连接万向节和球面副的杆上的力的分母";
SI.Force f_rod 
    "杆的约束力(正值，如果杆被按压)";
SI.Power totalPower 
    "如果checkTotalPower=true，则流入此元素的总功率(否则为虚拟)";

  Modelica.Mechanics.MultiBody.Joints.Internal.PrismaticWithLengthConstraint prismatic(
    animation=animation, 
    length=rod1Length, 
    n=n_b, 
    s_offset=s_offset, 
    s_guess=s_guess, 
    boxWidthDirection=boxWidthDirection, 
    boxWidth=boxWidth, 
    boxHeight=boxHeight, 
    specularCoefficient=specularCoefficient, 
    boxColor=boxColor) annotation (Placement(transformation(extent={{75,-20},{35,20}})));
  Modelica.Mechanics.MultiBody.Joints.SphericalSpherical rod1(
    animation=animation, 
    showMass=showMass, 
    m=rod1Mass, 
    rodLength=rod1Length, 
    rodDiameter=rod1Diameter, 
    sphereDiameter=sphereDiameter, 
    rodColor=rod1Color, 
    kinematicConstraint=false, 
    specularCoefficient=specularCoefficient, 
    sphereColor=sphereColor, 
    constraintResidue=rod1.f_rod - f_rod) annotation (Placement(transformation(extent={{-89,-20},{-49,20}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation rod2(
    animation=animation, 
    width=rod2Diameter, 
    height=rod2Diameter, 
    specularCoefficient=specularCoefficient, 
    color=rod2Color, 
    r=rRod2_ib) annotation (Placement(transformation(extent={{15,-20},{-25, 
            20}})));
  Sensors.RelativePosition relativePosition(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a) 
    annotation (Placement(transformation(extent={{60,-70},{40,-90}})));
  Modelica.Blocks.Sources.Constant position_b[3](k=rRod2_ib) 
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
equation
  /* 通过力平衡计算rod1运动副杆上的未知力：
       0 = frame_b.f + frame_ib.f + frame_im.f +
           Frames.resolve2(rod1.R_rel, rod1.f_rod*rod1.eRod_a)
     条件是，沿平移副轴向的力在平移副轴上的投影等于一维接口上的驱动轴力：
       -prismatic.f = prismatic.e*frame_b.f
     因此，我们有e=prismatic.e和f=prismatic.f
        f = e*(frame_ib.f + frame_im.f +
               Frames.resolve2(rod1.R_rel, rod1.f_rod*rod1.eRod_a))
          = e*(frame_ib.f + frame_im.f +
               rod1.f_rod*Frames.resolve2(rod1.R_rel, rod1.eRod_a))
     解这个方程得到f_rod的结果为
       rod1.f_rod = (f - e*(frame_ib.f + frame_im.f))
                    / (e*Frames.resolve2(rod1.R_rel, rod1.eRod_a))
     另外，引入了防止除零的保护
  */
  aux = prismatic.e*Frames.resolveRelative(rod1.eRod_a, rod1.frame_a.R, 
    rod1.frame_b.R);
  f_rod = (-prismatic.f - prismatic.e*(frame_ib.f + frame_im.f))/ 
    noEvent(if abs(aux) < 1e-10 then 1e-10 else aux);

  // 为测试目的测量功率
  if checkTotalPower then

    totalPower = frame_a.f*Frames.resolve2(frame_a.R, der(frame_a.r_0)) + 
      frame_b.f*Frames.resolve2(frame_b.R, der(frame_b.r_0)) + frame_ib.f* 
      Frames.resolve2(frame_ib.R, der(frame_ib.r_0)) + frame_im.f* 
      Frames.resolve2(frame_im.R, der(frame_im.r_0)) + frame_a.t* 
      Frames.angularVelocity2(frame_a.R) + frame_b.t* 
      Frames.angularVelocity2(frame_b.R) + frame_ib.t* 
      Frames.angularVelocity2(frame_ib.R) + frame_im.t* 
      Frames.angularVelocity2(frame_im.R) + axis.f*der(axis.s) + bearing.f* 
      der(bearing.s) + (-rod1Mass)*(der(rod1.v_CM_0) - 
      world.gravityAcceleration(rod1.r_CM_0))*rod1.v_CM_0;
  else
    totalPower = 0;
  end if;

  connect(prismatic.frame_b, rod2.frame_a) annotation (Line(
      points={{35,0},{15,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(rod2.frame_b, rod1.frame_b) annotation (Line(
      points={{-25,0},{-49,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(prismatic.frame_a, frame_b) annotation (Line(
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
  connect(position_b.y, prismatic.position_b) annotation (Line(
      points={{1,-40},{20,-40},{20,-12},{31,-12}}, color={0,0,127}));
  connect(prismatic.axis, axis) annotation (Line(points={{39,14},{40,14},{
          40,60},{90,60},{90,80},{100,80}}));
  connect(prismatic.bearing, bearing) 
    annotation (Line(points={{63,14},{63,40},{100,40}}));
  connect(rod2.frame_b, frame_im) annotation (Line(
      points={{-25,0},{-35,0},{-35,60},{0,60},{0,100}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(relativePosition.r_rel, prismatic.position_a) 
                                                      annotation (Line(
      points={{50,-69},{50,-50},{90,-50},{90,-12},{79,-12}}, color={0,0,127}));
  annotation (
    Documentation(info="<html>
<p>
这个组件由坐标系_a上的一个<strong>球面副</strong>运动副1、坐标系_b上的一个<strong>平动</strong>运动副和通过杆1连接到球面副1以及通过杆2连接到平移副的<strong>球面副</strong>运动副2组成，参见以下图中的默认动画(轴向矢量不是默认动画的一部分)：</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Assemblies/JointSSP.png\"alt=\"model Joints.Assemblies.JointSSP\">
</div>

<p>
除了杆1中间的可选点质量外，这个运动副组合物没有质量和转动惯量，也不引入约束或潜在状态变量。
在可能的情况下，应该在运动学运动环中使用它，因为这个运动副组合引入的非线性方程组是通过<strong>解析</strong>(即，如果存在唯一解，则总是计算解)解决的。
</p>
<p>
还有一个额外的<strong>frame_ib</strong>。
它在连接到平动和连接到这个杆的球面副一侧的平移副处是<strong>固定的</strong>(=rod2.frame_a=prismatic.frame_a)。
</p>
<p>
还有一个额外的<strong>frame_im</strong>。
它在连接到平动和连接到这个杆的球面副2一侧的球面副处是<strong>固定的</strong>(=rod2.frame_b)。
它始终与<strong>frame_ib</strong>平行。
</p>
<p>
定义这个运动副的参数的最简单的方法是将多体系统移动到一个<strong>参考配置</strong>中，在这个配置中，<strong>所有组件的所有坐标系</strong>都是<strong>平行</strong>的(或者，至少在定义这个组件的实例时，JointSSP运动副的frame_b和frame_ib应该是平行的)。
</p>

</html>"), 
    Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}, 
        initialScale=0.2), graphics={
        Text(
          extent={{-140,-40},{140,-65}}, 
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
        Text(
          extent={{89,115},{132,92}}, 
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
          points={{19,6},{19,80},{0,80},{0,100}}, 
          color={95,95,95}, 
          thickness=0.5), 
        Text(
          extent={{-49,114},{-11,92}}, 
          textColor={128,128,128}, 
          textString="im"), 
        Rectangle(
          extent={{50,20},{80,-20}}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{80,30},{100,-30}}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{50,14},{80,20}}, 
          pattern=LinePattern.None, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Rectangle(
          extent={{80,24},{100,30}}, 
          pattern=LinePattern.None, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Line(
          points={{50,6},{50,80},{80,80},{80,100}}, 
          color={95,95,95}, 
          thickness=0.5), 
        Line(
          points={{101,80},{80,80}}, 
          color={95,95,95}, 
          thickness=0.5), 
        Line(
          points={{99,40},{90,40},{90,30}}, 
          color={95,95,95}, 
          thickness=0.5)}));
end JointSSP;