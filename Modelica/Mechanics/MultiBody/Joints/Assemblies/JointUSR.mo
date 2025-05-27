within Modelica.Mechanics.MultiBody.Joints.Assemblies;
model JointUSR 
  "万向节-球面副-转动副组合(无约束，无势态)"

  import Modelica.Mechanics.MultiBody.Types;

  extends Interfaces.PartialTwoFramesDoubleSize;
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_ia 
    "位于frame_a原点的坐标系，固定在万向节和球面副的连接杆上" 
    annotation (Placement(transformation(
        origin={-80,100}, 
        extent={{-8,-8},{8,8}}, 
        rotation=90)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_ib 
    "位于frame_b原点的坐标系，固定在球面副和转动副的连接杆上" 
    annotation (Placement(transformation(
        origin={80,100}, 
        extent={{-8,8},{8,-8}}, 
        rotation=270)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_im 
    "位于球面副原点的坐标系，固定在球面副和转动副的连接杆上" 
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

  parameter Boolean animation=true "=true，则启用动画";
  parameter Boolean showUniversalAxes=true 
    "=true，则用两个圆柱体可视化万向节运动副，否则用一个球体(仅在animation=true时有效)";
  parameter Modelica.Mechanics.MultiBody.Types.Axis n1_a={0,0,1} 
    "固定在frame_a上的万向节运动副轴1，解析在frame_a中(轴2与轴1和杆1正交)" 
    annotation (Evaluate=true);
  parameter Modelica.Mechanics.MultiBody.Types.Axis n_b={0,0,1} 
    "固定在frame_b上的转动副轴" 
    annotation (Evaluate=true);
  parameter SI.Position rRod1_ia[3]={1,0,0} 
    "从frame_a原点到球面副的矢量，解析在frame_ia中" 
    annotation (Evaluate=true);
  parameter SI.Position rRod2_ib[3]={-1,0,0} 
    "从frame_ib原点到球面副的矢量，解析在frame_ib中";
  parameter Modelica.Units.NonSI.Angle_deg phi_offset=0 
    "转动副的相对角度偏移(角度=phi(t)+from_deg(phi_offset))";
  parameter Modelica.Units.NonSI.Angle_deg phi_guess=0 
    "选择配置，使得初始时间|phi(t0)-from_deg(phi_guess)|最小化";
  parameter SI.Diameter sphereDiameter=world.defaultJointLength 
    "表示万向节和球面副的球直径" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
  input Types.Color sphereColor=Modelica.Mechanics.MultiBody.Types.Defaults.
       JointColor 
    "表示万向节和球面副的球的颜色" 
    annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));
  parameter SI.Diameter rod1Diameter=sphereDiameter/Types.Defaults.
      JointRodDiameterFraction 
    "连接万向节和球面副的杆1的直径" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
  input Types.Color rod1Color=Modelica.Mechanics.MultiBody.Types.Defaults.
      RodColor 
    "连接万向节和球面副的杆1的颜色" 
    annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));

  parameter SI.Diameter rod2Diameter = rod1Diameter 
"连接转动副和球面副的第二根杆的直径" 
annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));

input Types.Color rod2Color = rod1Color 
"连接转动副和球面副的第二根杆的颜色" 
annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));

parameter SI.Diameter revoluteDiameter = world.defaultJointWidth 
"表示转动副的圆柱的直径" 
annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));

parameter SI.Distance revoluteLength = world.defaultJointLength 
"表示转动副的圆柱的长度" 
annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));

input Types.Color revoluteColor = Modelica.Mechanics.MultiBody.Types.Defaults.JointColor 
"表示转动副的圆柱的颜色" 
annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));

input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
"环境光的反射率(=0:光线完全被吸收)" 
annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));

parameter SI.Distance cylinderLength = world.defaultJointLength 
"表示两个万向节轴的圆柱的长度" 
annotation (
  Dialog(tab="动画", group="如果启用动画并显示万向轴", enable=animation and showUniversalAxes));

parameter SI.Distance cylinderDiameter = world.defaultJointWidth 
"表示两个万向节轴的圆柱的直径" 
annotation (
  Dialog(tab="动画", group="如果启用动画并显示万向轴", enable=animation and showUniversalAxes));

input Types.Color cylinderColor = Modelica.Mechanics.MultiBody.Types.Defaults.JointColor 
"表示两个万向节轴的圆柱的颜色" 
annotation (
  Dialog(colorSelector=true, tab="动画", group="如果启用动画并显示万向轴", enable=animation and showUniversalAxes));

parameter Boolean checkTotalPower = false 
"如果要确定流入该组件的总功率(必须为零)，则为true" 
annotation (Dialog(tab="高级"));

final parameter Real eRod1_ia[3](each final unit="1") = rod1.eRod_ia 
"从frame_a原点到球面副原点的单位矢量，在frame_ia中解析";

final parameter Real e2_ia[3](each final unit="1") = rod1.e2_ia 
"万向节轴2方向上的单位矢量，在frame_ia中解析";

final parameter SI.Distance rod1Length = rod1.rodLength 
"rod1的长度(=万向节和球面副之间的距离)";

SI.Power totalPower 
"如果checkTotalPower=true，则流入该元件的总功率(否则为虚拟值)";

SI.Position aux 
"用于计算连接万向节和球面副的杆的力的分母";

SI.Force f_rod 
"杆的方向上的约束力(如果杆被压缩，则为正)";

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
  Modelica.Mechanics.MultiBody.Joints.UniversalSpherical rod1(
    animation=animation, 
    showUniversalAxes=showUniversalAxes, 
    rRod_ia=rRod1_ia, 
    n1_a=n1_a, 
    sphereDiameter=sphereDiameter, 
    sphereColor=sphereColor, 
    rodWidth=rod1Diameter, 
    rodHeight=rod1Diameter, 
    rodColor=rod1Color, 
    cylinderLength=cylinderLength, 
    cylinderDiameter=cylinderDiameter, 
    cylinderColor=cylinderColor, 
    specularCoefficient=specularCoefficient, 
    kinematicConstraint=false, 
    constraintResidue=rod1.f_rod - f_rod) annotation (Placement(transformation(extent={{-92,-20},{-52,20}})));
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
  // 连接 Connections.root(frame_ib.R);

  /* 通过转动副处的扭矩平衡计算rod1运动副中杆的未知力：
       0 = revolute.frame_b.t + frame_ib.t + frame_im.t + cross(rRod2_ib, frame_im.f)
           + cross(r_ib, -rod1.f_b_a1)
           + cross(r_ib, Frames.resolve2(rod1.R_rel, rod1.f_rod*rod1.eRod1_ia))
     条件是，沿着转动副轴的扭矩的投影等于一维接口上的驱动轴扭矩：
       -revolute.tau = revolute.e*frame_b.t
     因此，我们有
        tau = e*(frame_ib.t  + frame_im.t + cross(rRod2_ib, frame_im.f)
              + cross(rRod2_ib, -rod1.f_b_a1))
              + e*cross(rRod2_ib, Frames.resolve2(rod1.R_rel, rod1.f_rod*rod1.eRod_a))
            = e*(frame_ib.t + frame_im.t + cross(rRod2_ib, frame_im.f)
              + cross(rRod2_ib, -rod.f_b_a1))
              + rod1.f_rod*e*cross(rRod2_ib, Frames.resolve2(rod1.R_rel, rod1.eRod_a))
     解此方程得到 f_rod
       f_rod = (-tau - e*(frame_ib.t + frame_im.t + cross(rRod2_ib, frame_im.f)
               + cross(rRod2_ib, -rod1.f_b_a1)))
               / (cross(e,rRod2_ib)*Frames.resolve2(rod1.R_rel, rod1.eRod_a))
     另外，引入了防止除零的保护

     f_rod 通过高级菜单中的变量 "constraintResidue" 传递给组件 JointsUSR.rod1
  */
  aux = cross(revolute.e, rRod2_ib)*Frames.resolveRelative(rod1.eRod_a, 
    rod1.frame_a.R, rod1.frame_b.R);
  f_rod = (-revolute.tau - revolute.e*(frame_ib.t + frame_im.t + cross(
    rRod2_ib, frame_im.f) - cross(rRod2_ib, Frames.resolveRelative(rod1.
    f_b_a1, rod1.frame_a.R, rod1.frame_b.R))))/noEvent(if abs(aux) < 1e-10 then 
          1e-10 else aux);

  // 用于测试目的测量功率
  if checkTotalPower then
    totalPower = frame_a.f*Frames.resolve2(frame_a.R, der(frame_a.r_0)) + 
      frame_b.f*Frames.resolve2(frame_b.R, der(frame_b.r_0)) + frame_ia.f* 
      Frames.resolve2(frame_ia.R, der(frame_ia.r_0)) + frame_ib.f* 
      Frames.resolve2(frame_ib.R, der(frame_ib.r_0)) + frame_im.f* 
      Frames.resolve2(frame_im.R, der(frame_im.r_0)) + frame_a.t* 
      Frames.angularVelocity2(frame_a.R) + frame_b.t* 
      Frames.angularVelocity2(frame_b.R) + frame_ia.t* 
      Frames.angularVelocity2(frame_ia.R) + frame_ib.t* 
      Frames.angularVelocity2(frame_ib.R) + frame_im.t* 
      Frames.angularVelocity2(frame_im.R) + axis.tau*der(axis.phi) + 
      bearing.tau*der(bearing.phi);
  else
    totalPower = 0;
  end if;

  connect(revolute.frame_b, rod2.frame_a) annotation (Line(
      points={{35,0},{15,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(rod2.frame_b, rod1.frame_b) annotation (Line(
      points={{-25,0},{-52,0}}, 
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
      points={{-92,0},{-100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(relativePosition.frame_b, frame_a) 
                                           annotation (Line(
      points={{40,-80},{-96,-80},{-96,0},{-100,0}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(relativePosition.frame_a, frame_b) 
                                           annotation (Line(
      points={{60,-80},{96,-80},{96,0},{100,0}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(position_b.y, revolute.position_b) annotation (Line(
      points={{1,-40},{20,-40},{20,-12},{31,-12}}, color={0,0,127}));
  connect(rod2.frame_b, frame_im) annotation (Line(
      points={{-25,0},{-40,0},{-40,80},{0,80},{0,100}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(rod1.frame_ia, frame_ia) annotation (Line(
      points={{-80,20},{-80,100}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(revolute.axis, axis) annotation (Line(points={{55,20},{55,60},{90, 
          60},{90,80},{100,80}}));
  connect(relativePosition.r_rel, revolute.position_a) annotation (Line(
      points={{50,-69},{50,-40},{90,-40},{90,-12},{79,-12}}, color={0,0,127}));
  connect(revolute.bearing, bearing) annotation (Line(
      points={{67,20},{67,40},{100,40}}));
  annotation (
    Documentation(info="<html>
<p>
这个组件位于frame_a的万向节位于frame_b的转动副和球运动副组成,球运动副通过<strong>杆1</strong>与<strong>万向节</strong>相互连接，通过<strong>杆2</strong>与<strong>转动副</strong>相互连接，请参见下图中的默认动画(轴矢量不是默认动画的一部分)</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Assemblies/JointUSR.png\"alt=\"model Joints.Assemblies.JointUSR\">
</div>

<p>
这个联合组合物既没有质量也没有转动惯量，也不引入约束或潜在状态变量。
在可能的情况下，应该在运动学运动环中使用它，因为这个联合组合物引入的非线性方程组是通过解析方法解决的(即，如果存在唯一解，则总是计算出一个解)。
</p>
<p>
万向节运动副的定义如下：</p>
<ul>
<li>转动副<strong>1</strong>的旋转<strong>轴</strong>沿着参数矢量n1_a，该矢量固定在frame_a中。
</li>
<li>转动副<strong>2</strong>的旋转<strong>轴</strong>垂直于轴<strong>1</strong>，并且垂直于连接万向节运动副和球面副(rod1)的线。
</li>
</ul>
<p>
万向节运动副<strong>2</strong>的定义是根据最常见的情况进行的，以简化处理。
否则，如果<strong>轴</strong><strong>2</strong>不与<strong>轴</strong><strong>1</strong>和连接杆垂直，处理会变得更加复杂，操作数量会显著增加。
</p>
<p>
请注意，当<strong>轴</strong><strong>1</strong>和连接杆彼此平行时会出现<strong>奇点</strong>。
因此，如果可能的话，应该选择n1_a，使其在初始配置中与rRod1_ia垂直(即，到<strong>奇点</strong>的距离尽可能大)。
</p>
<p>
该联合组合物的其余部分由以下参数定义：</p>
<ul>
<li>球面副相对于万向节运动副的位置由矢量rRod1_ia定义。
该矢量从frame_a指向球面副，并在frame_ia中解析(最简单的方法是选择frame_ia，使其在参考或初始配置中与frame_a平行)。
</li>
<li>球面副相对于转动副的位置由矢量rRod2_ib定义。
该矢量从转动副的内部坐标系(frame_ib或revolute.frame_a)指向球面副，并在frame_ib中解析(注意，frame_ib和frame_b是相互平行的)。
</li>
<li>转动副的旋转轴由轴矢量n_b定义。
它是固定的，并在frame_b中解析。
</li>
<li>在使用上述定义指定这个联合组合物时，存在两种不同的<strong>配置</strong>。
通过参数<strong>phi_guess</strong>给出初始时间t0时revolute.phi(t0)的猜测值。
选择最接近phi_guess的<strong>配置</strong>(|revolute.phi-phi_guess|最小)。
</li>
</ul>

<p>
额外的<strong>frame_ia</strong>存在。
它在连接万向节运动副和球面副的杆上<strong>固定</strong>，位于<strong>frame_a</strong>的原点处。
frame_ia在杆上的位置由万向节运动副隐式定义(当万向节运动副的两个转动副的角度为零时，frame_a和frame_ia重合)和参数矢量<strong>rRod1_ia</strong>，即从frame_a的原点到球面副的位置矢量，在frame_<strong>ia</strong>中解析。
</p>
<p>
额外的<strong>frame_ib</strong>存在。
它在连接转动副和球面副的杆上<strong>固定</strong>，位于连接到这根杆的转动副侧面(=rod2.frame_a=revolute.frame_a)。
</p>
<p>
额外的<strong>frame_im</strong>存在。
它在连接转动副和球面副的杆上<strong>固定</strong>，位于连接到这根杆的球面副侧面(=rod2.frame_b)。
它始终与<strong>frame_ib</strong>平行。
</p>
<p>
定义这个运动副的参数的最简单方法是将多体系统移动到一个<strong>参考配置</strong>中，在这个配置中，<strong>所有</strong>组件的<strong>所有坐标系</strong><strong>平行</strong>(或者，至少在定义此组件的实例时，JointUSR运动副的frame_a和frame_ia应该<strong>平行</strong>)。
</p>
<p>
在JointUSR运动副的公共接口中，提供以下(最终的)<strong>参数</strong>：</p>
<blockquote><pre>
<strong>parameter</strong>Realrod1Length(unit=\"m\")\"杆1的长度\";
<strong>parameter</strong>RealeRod1_ia[3]\"沿着杆1的单位矢量，在frame_ia中解析\";
<strong>parameter</strong>Reale2_ia[3]\"沿着轴2的单位矢量，在frame_ia中解析\";
</pre></blockquote>
<p>
这允许更方便地定义与杆1相关的数据。
例如，如果要在frame_ia处连接一个箱子，从frame_a的原点指向杆1的中间，可能会这样定义：</p>
<blockquote><pre>
Modelica.Mechanics.MultiBody.Joints.Assemblies.JointUSPjointUSR(rRod1_ia={1.2,1,0.2});
Modelica.Mechanics.MultiBody.Visualizers.FixedShapeshape(shapeType=\"box\",
lengthDirection=jointUSR.eRod1_ia,
widthDirection=jointUSR.e2_ia,
length=jointUSR.rod1Length/2,
width=jointUSR.rod1Length/10);
<strong>equation</strong>
<strong>connect</strong>(jointUSP.frame_ia,shape.frame_a);
</pre></blockquote>

</html>"), 
    Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}, 
        initialScale=0.2), graphics={
        Text(
          extent={{-140,-41},{140,-66}}, 
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
          extent={{-70,40},{-39,-33}}, 
          lineColor={255,255,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Line(
          points={{-70,28},{-70,-30}}, 
          thickness=0.5), 
        Ellipse(
          extent={{-89,-18},{-48,18}}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={192,192,192}), 
        Ellipse(
          extent={{-84,-12},{-53,13}}, 
          lineColor={160,160,164}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Polygon(
          points={{-81,-17},{-92,-1},{-83,16},{-57,24},{-81,-17}}, 
          pattern=LinePattern.None, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Line(
          points={{-70,30},{-70,-10}}, 
          thickness=0.5), 
        Line(
          points={{-61,16},{-79,-15}}, 
          thickness=0.5), 
        Line(
          points={{-50,0},{-50,80},{-80,80},{-80,100}}, 
          color={95,95,95}, 
          thickness=0.5), 
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
          extent={{-44,31},{-14,-30}}, 
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
          extent={{-50,5},{-21,-5}}, 
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
          extent={{40,109},{77,91}}, 
          textColor={128,128,128}, 
          textString="ib"), 
        Text(
          extent={{-124,109},{-95,92}}, 
          textColor={128,128,128}, 
          textString="ia"), 
        Line(
          points={{60,30},{60,80},{80,80},{80,100}}, 
          color={95,95,95}, 
          thickness=0.5), 
        Text(
          extent={{-43,108},{-10,92}}, 
          textColor={128,128,128}, 
          textString="im"), 
        Line(
          points={{19,6},{19,80},{0,80},{0,100}}, 
          color={95,95,95}, 
          thickness=0.5), 
        Line(
          points={{80,80},{101,80}}, 
          color={128,128,128}, 
          thickness=0.5), 
        Line(
          points={{90,30},{90,40},{95,40}}, 
          color={95,95,95}, 
          thickness=0.5)}));
end JointUSR;