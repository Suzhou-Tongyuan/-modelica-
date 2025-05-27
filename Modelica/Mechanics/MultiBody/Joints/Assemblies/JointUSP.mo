within Modelica.Mechanics.MultiBody.Joints.Assemblies;
model JointUSP 
  "万向节-球面副-平动副组合(无约束，无潜在状态变量)"

  import Modelica.Mechanics.MultiBody.Types;

  extends Interfaces.PartialTwoFramesDoubleSize;
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_ia 
    "位于万向节和球面副连接杆固定在frame_a原点的坐标系" 
    annotation (Placement(transformation(
        origin={-80,100}, 
        extent={{-8,-8},{8,8}}, 
        rotation=90)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_ib 
    "位于球形和平动副连接杆固定在frame_b原点的坐标系" 
    annotation (Placement(transformation(
        origin={80,100}, 
        extent={{-8,8},{8,-8}}, 
        rotation=270)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_im 
    "位于球形和平动副连接杆固定在球面副原点的坐标系" 
    annotation (Placement(transformation(
        origin={0,100}, 
        extent={{8,-8},{-8,8}}, 
        rotation=270)));
  Modelica.Mechanics.Translational.Interfaces.Flange_a axis 
    "驱动平动副的一维平动一维接口" 
    annotation (Placement(transformation(extent={{95,75},{105,85}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b bearing 
    "平动副驱动轴承的一维平动一维接口" 
    annotation (Placement(transformation(extent={{105,35},{95,45}})));

parameter Boolean animation=true "=true，则启用动画";
parameter Boolean showUniversalAxes=true 
  "=true，则用两个圆柱体可视化万向节运动副，否则用一个球体(如果animation=true)";
parameter Modelica.Mechanics.MultiBody.Types.Axis n1_a={0,0,1} 
  "万向节运动副的轴1，在frame_a中固定并解析(轴2与轴1和平动1垂直)" 
  annotation (Evaluate=true);
parameter Modelica.Mechanics.MultiBody.Types.Axis n_b={-1,0,0} 
  "平动副的轴，在frame_b中固定并解析" 
  annotation (Evaluate=true);
parameter SI.Position rRod1_ia[3]={1,0,0} 
  "从frame_a原点到球面副的矢量，解析在frame_ia中" 
  annotation (Evaluate=true);
parameter SI.Position rRod2_ib[3]={-1,0,0} 
  "从frame_ib原点到球面副的矢量，解析在frame_ib中(frame_ib平行于frame_b)" 
  annotation (Evaluate=true);
parameter SI.Position s_offset=0 
  "平动副的相对距离偏移(平动副坐标系之间的距离=s(t)+s_offset)";
parameter SI.Position s_guess=0 
  "选择配置，使得初始时间时|s(t0)-s_guess|最小";
parameter SI.Diameter sphereDiameter=world.defaultJointLength 
  "表示万向节和球面副的球的直径" 
  annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
input Types.Color sphereColor=Modelica.Mechanics.MultiBody.Types.Defaults.JointColor 
  "表示万向节和球面副的球的颜色" 
  annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));
parameter SI.Diameter rod1Diameter=sphereDiameter/Types.Defaults.
    JointRodDiameterFraction 
  "连接万向节和球面副的平动1的直径" 
  annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
input Types.Color rod1Color=Modelica.Mechanics.MultiBody.Types.Defaults.RodColor 
  "连接万向节和球面副的平动1的颜色" 
  annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));
parameter SI.Diameter rod2Diameter=rod1Diameter 
  "连接平动和球面副的平动2的直径" 
  annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
input Types.Color rod2Color=rod1Color 
  "连接平动和球面副的平动2的颜色" 
  annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));
parameter Types.Axis boxWidthDirection={0,1,0} 
  "平动副宽度方向的矢量，在frame_b中解析" 
  annotation (Evaluate=true, Dialog(tab="动画", group="如果animation=true", enable=animation));
parameter SI.Distance boxWidth=world.defaultJointWidth 
  "平动副框的宽度" 

annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
parameter SI.Distance boxHeight=boxWidth "平动副框的高度" 
  annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
input Types.Color boxColor=sphereColor "平动副框的颜色" 
  annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));
input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
  "环境光的反射(=0：光完全被吸收)" 
  annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
parameter SI.Distance cylinderLength=world.defaultJointLength 
  "表示两个万向节运动副轴的圆柱体的长度" 
  annotation (
   Dialog(tab="动画", group="如果animation=true并且showUniversalAxes", 
          enable=animation and showUniversalAxes));
parameter SI.Distance cylinderDiameter=world.defaultJointWidth 
  "表示两个万向节运动副轴的圆柱体的直径" 
  annotation (Dialog(tab="动画", group= 
        "如果animation=true并且showUniversalAxes", 
          enable=animation and showUniversalAxes));
input Types.Color cylinderColor=Modelica.Mechanics.MultiBody.Types.Defaults.JointColor 
  "表示两个万向节运动副轴的圆柱体的颜色" annotation (
    Dialog(colorSelector=true, tab="动画", group="如果animation=true并且showUniversalAxes", 
          enable=animation and showUniversalAxes));
parameter Boolean checkTotalPower=false 
  "=true，则确定流入此组件的总功率(必须为零)" 
  annotation (Dialog(tab="高级"));
final parameter Real eRod1_ia[3](each final unit="1")=rod1.eRod_ia 
  "从frame_a原点到球面副原点的单位矢量，在frame_ia中解析";
final parameter Real e2_ia[3](each final unit="1")=rod1.e2_ia 
  "万向节运动副轴2方向上的单位矢量，在frame_ia中解析";
final parameter SI.Distance rod1Length=rod1.rodLength 
  "平动1的长度(=万向节运动副和球面副之间的距离)";
SI.Force f_rod 
  "平动方向上的约束力(正值表示平动被按压)";
SI.Power totalPower 
  "如果checkTotalPower=true，则流入此元素的总功率(否则为虚拟值)";

  Modelica.Mechanics.MultiBody.Joints.Internal.PrismaticWithLengthConstraint prismatic(
    animation=animation, 
    length=rod1.rodLength, 
    n=n_b, 
    s_offset=s_offset, 
    s_guess=s_guess, 
    boxWidthDirection=boxWidthDirection, 
    boxWidth=boxWidth, 
    boxHeight=boxHeight, 
    boxColor=boxColor, 
    specularCoefficient=specularCoefficient) annotation (Placement(transformation(extent={{76,-20},{36,20}})));
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
    specularCoefficient=specularCoefficient, 
    cylinderLength=cylinderLength, 
    cylinderDiameter=cylinderDiameter, 
    cylinderColor=cylinderColor, 
    kinematicConstraint=false, 
    constraintResidue=rod1.f_rod - f_rod) annotation (Placement(transformation(extent={{-92,-20},{-52,20}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation rod2(
    animation=animation, 
    r=rRod2_ib, 
    width=rod2Diameter, 
    height=rod2Diameter, 
    specularCoefficient=specularCoefficient, 
    color=rod2Color) annotation (Placement(transformation(extent={{0,20},{
            -40,-20}})));
  Sensors.RelativePosition relativePosition(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a) 
    annotation (Placement(transformation(extent={{50,-70},{30,-90}})));
  Modelica.Blocks.Sources.Constant position_b[3](k=rRod2_ib) 
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
protected
  Real aux 
    "用于计算连接万向节运动副和球面副的平动杆中力的分母";
equation
  /* 通过平动副处的力平衡来计算连接万向节运动副和球面副的平动杆中的未知力
     0 = -prismatic.frame_b.f + frame_ib.f + frame_im.f - rod1.frame_b.f
     rod1.frame_b处的力被分成两部分：
     rod1.frame_b.f = Frames.resolve2(rod1.R_rel, rod1.f_b_a1 - rod1.f_rod*rod1.eRod_a)
     其中 rod1.f_rod 是平动杆中的未知力。
     条件是沿着平动轴的轴线的平动副中的力的投影等于一维接口的驱动轴力：
     -prismatic.f = prismatic.e*prismatic.frame_b.f
     因此，我们有 e=prismatic.e 和 f=prismatic.f
     -f = e*(frame_ib.f + frame_im.f
             - Frames.resolve2(rod1.R_rel, rod1.f_b_a1 - rod1.f_rod*rod1.eRod_a))
         = e*(frame_ib.f + frame_im.f - Frames.resolve2(rod1.R_rel, rod1.f_b_a1)
             + rod1.f_rod*Frames.resolve2(rod1.R_rel, rod1.eRod_a))
     解这个方程得到 f_rod 的结果是
       rod1.f_rod = -(f+e*(frame_ib.f + frame_im.f - Frames.resolve2(rod1.R_rel, rod1.f_b_a1)))
                   /(e*Frames.resolve2(rod1.R_rel, rod1.eRod_a))
     此外，引入了防止除以零的保护
  */
  aux = prismatic.e*Frames.resolveRelative(rod1.eRod_a, rod1.frame_a.R, 
    rod1.frame_b.R);
  f_rod = (-prismatic.f - prismatic.e*(frame_ib.f + frame_im.f - 
    Frames.resolveRelative(rod1.f_b_a1, rod1.frame_a.R, rod1.frame_b.R)))/ 
    noEvent(if abs(aux) < 1e-10 then 1e-10 else aux);
  // 为测试目的测量功率
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
      Frames.angularVelocity2(frame_im.R) + axis.f*der(axis.s) + bearing.f* 
      der(bearing.s);
  else
    totalPower = 0;
  end if;

  connect(prismatic.frame_b, rod2.frame_a) annotation (Line(
      points={{36,0},{0,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(rod2.frame_b, rod1.frame_b) annotation (Line(
      points={{-40,0},{-52,0}}, 
      thickness=0.5));
  connect(prismatic.frame_a, frame_b) annotation (Line(
      points={{76,0},{100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(rod2.frame_a, frame_ib) annotation (Line(
      points={{0,0},{7,0},{7,70},{80,70},{80,100}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(rod1.frame_a, frame_a) annotation (Line(
      points={{-92,0},{-100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(relativePosition.frame_b, frame_a) 
                                           annotation (Line(
      points={{30,-80},{-97,-80},{-97,0},{-100,0}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(relativePosition.frame_a, frame_b) 
                                           annotation (Line(
      points={{50,-80},{95,-80},{95,0},{100,0}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(rod2.frame_b, frame_im) annotation (Line(
      points={{-40,0},{-46,0},{-46,80},{0,80},{0,100}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(rod1.frame_ia, frame_ia) annotation (Line(
      points={{-80,20},{-80,100}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(position_b.y, prismatic.position_b) annotation (Line(
      points={{1,-50},{10,-50},{10,-12},{32,-12}}, color={0,0,127}));
  connect(prismatic.axis, axis) annotation (Line(points={{40,14},{40,56},{
          90,56},{90,80},{100,80}}, color={0,191,0}));
  connect(prismatic.bearing, bearing) 
    annotation (Line(points={{64,14},{64,40},{100,40}}, color={0,191,0}));
  connect(relativePosition.r_rel, prismatic.position_a) 
                                                      annotation (Line(
      points={{40,-69},{40,-50},{90,-50},{90,-12},{80,-12}}, color={0,0,127}));
  annotation (
    Documentation(info="<html>
<p>
该组件由frame_a处的一个<strong>万向节</strong>、frame_b处的一个<strong>平动副</strong>和通过<strong>rod1</strong>连接到万向节并通过<strong>rod2</strong>连接到平动副的一个<strong>球面副</strong>组成，参见以下默认动画(轴向矢量不是默认动画的一部分)：</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Assemblies/JointUSP.png\"alt=\"model Joints.Assemblies.JointUSP\">
</div>

<p>
该连接不具有质量和转动惯量，也不引入约束或潜在状态变量。
在可能的情况下，应该在运动学运动环中使用它，因为这个连接引入的非线性方程组被<strong>解析地</strong>求解(即，如果存在唯一解，则总是计算出解)。
</p>
<p>
万向节的定义如下：</p>
<ul>
<li>转动副<strong>1</strong>的旋转<strong>轴</strong>沿着固定在frame_a中的参数矢量n1_a。
</li>
<li>转动副<strong>2</strong>的旋转<strong>轴</strong>垂直于轴1，并且垂直于连接万向节和球面副(rod1)的线。
</li>
</ul>
<p>
万向节轴2的定义是根据最常见的情况简单处理的。
否则，如果轴2不与轴1和连接杆垂直，则处理会更加复杂，操作数量会大大增加。
</p>
<p>
注意，当轴1和连接杆彼此平行时会出现<strong>奇点</strong>。
因此，如果可能的话，应该选择n1_a，使其在初始配置中与rRod1_ia垂直(即，到奇点的距离尽可能大)。
</p>
<p>
该连接的其余部分由以下参数定义：</p>
<ul>
<li>球面副相对于万向节的位置由矢量<strong>rRod1_ia</strong>定义。
该矢量从frame_a指向球面副，并在frame_ia中解析(最简单的是选择frame_ia使其在参考或初始配置中与frame_a平行)。
</li>
<li>球面副相对于平动副的位置由矢量<strong>rRod2_ib</strong>定义。
该矢量从平动副的内部坐标系(frame_ib或prismatic.frame_a)指向球面副，并在frame_ib中解析(注意，frame_ib和frame_b彼此平行)。
</li>
<li>平动副的平动轴由轴矢量<strong>n_b</strong>定义。
它是固定的并在frame_b中解析。
</li>
<li>平动副的两个坐标系，即frame_b和frame_ib，彼此平行。
这两个坐标系沿轴n_b之间的原点距离等于\"prismatic.s(t) + s_offset\"，其中\"prismatic.s(t)\"是一个时间变化的变量，\"s_offset\"是一个固定的、常数偏移参数。
</li>
<li>当使用上述定义指定此连接时，可以有<strong>两种</strong>不同的<strong>配置</strong>。
通过参数<strong>s_guess</strong>给出初始时间t0处prismatic.s(t0)的猜测值。
选择与s_guess最接近的配置(|prismatic.s-s_guess|最小)。
</li>
</ul>

<p>
存在一个额外的<strong>frame_ia</strong>。
它被<strong>固定</strong>在连接万向节和球面副的杆上，在<strong>frame_a</strong>的原点处。
frame_ia的放置在杆上是由万向节隐式定义的(当万向节的两个转动副的角度为零时，frame_a和frame_ia重合)，以及参数矢量<strong>rRod1_ia</strong>，该参数矢量是从frame_a的原点指向球面副的位置矢量，在frame_<strong>ia</strong>中解析。
</p>
<p>
存在一个额外的<strong>frame_ib</strong>。
它被<strong>固定</strong>在连接平动副和球面副的杆上，在与该杆连接的平动副的一侧上(=rod2.frame_a=prismatic.frame_a)。
它始终与<strong>frame_b</strong>平行。
</p>
<p>
存在一个额外的<strong>frame_im</strong>。
它被<strong>固定</strong>在连接平动副和球面副的杆上，在与该杆连接的球面副的一侧上(=rod2.frame_b)。
它始终与<strong>frame_b</strong>平行。
</p>
<p>
定义这个连接的参数的最简单方法是将MultiBody系统移动到一个<strong>参考配置</strong>中，在这个配置中，<strong>所有组件的所有坐标系</strong>都是<strong>平行</strong>的(或者至少在定义此组件的实例时，JointUSP连接的frame_a和frame_ia应该平行)。
</p>
<p>
在JointUSP连接的公共接口中，提供了以下(最终的)<strong>参数</strong>：</p>
<blockquote><pre>
<strong>parameter</strong>Realrod1Length(unit=\"m\")\"杆1的长度\";
<strong>parameter</strong>RealeRod1_ia[3]\"沿着杆1的单位矢量，在frame_ia中解析\";
<strong>parameter</strong>Reale2_ia[3]\"沿轴2的单位矢量，在frame_ia中解析\";
</pre></blockquote>

<p>
这允许更方便地定义与杆1相关的数据。
例如，如果要将一个箱子连接到从frame_a的原点指向杆1中间的frame_ia，可能会定义如下：</p>
<blockquote><pre>
Modelica.Mechanics.MultiBody.Joints.Assemblies.JointUSPjointUSP(rRod1_ia={1.2,1,0.2});
Modelica.Mechanics.MultiBody.Visualizers.FixedShapeshape(shapeType=\"box\",
lengthDirection=jointUSP.eRod1_ia,
widthDirection=jointUSP.e2_ia,
length=jointUSP.rod1Length/2,
width=jointUSP.rod1Length/10);
<strong>equation</strong>
<strong>connect</strong>(jointUSP.frame_ia,shape.frame_a);
</pre></blockquote>

</html>"), 
    Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}, 
        initialScale=0.2), graphics={
        Rectangle(
          extent={{50,20},{80,-20}}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{80,30},{100,-30}}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-140,-45},{140,-70}}, 
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
          extent={{19,6},{50,-6}}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          fillColor={192,192,192}), 
        Rectangle(
          extent={{-50,5},{-21,-5}}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          fillColor={192,192,192}), 
        Text(
          extent={{37,109},{68,90}}, 
          textColor={128,128,128}, 
          textString="ib"), 
        Text(
          extent={{-124,110},{-93,90}}, 
          textColor={128,128,128}, 
          textString="ia"), 
        Line(
          points={{50,6},{50,80},{80,80},{80,100}}, 
          color={95,95,95}, 
          thickness=0.5), 
        Text(
          extent={{-44,111},{-8,91}}, 
          textColor={128,128,128}, 
          textString="im"), 
        Line(
          points={{19,6},{19,80},{0,80},{0,100}}, 
          color={95,95,95}, 
          thickness=0.5), 
        Rectangle(
          extent={{80,24},{100,30}}, 
          pattern=LinePattern.None, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Rectangle(
          extent={{50,14},{80,20}}, 
          pattern=LinePattern.None, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Line(
          points={{95,80},{79,80}}, 
          color={135,135,135}, 
          thickness=0.5), 
        Line(
          points={{95,40},{90,40},{90,30}}, 
          color={135,135,135}, 
          thickness=0.5)}), 
    Diagram(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}, 
        initialScale=0.2), graphics={
        Line(
          points={{-78,30},{-50,30}}, 
          color={128,128,128}, 
          arrow={Arrow.None,Arrow.Filled}), 
        Text(
          extent={{-76,39},{-49,32}}, 
          textColor={128,128,128}, 
          textString="rRod1_ia"), 
        Text(
          extent={{-27,40},{0,33}}, 
          textColor={128,128,128}, 
          textString="rRod2_ib"), 
        Line(
          points={{3,30},{-43,30}}, 
          color={128,128,128}, 
          arrow={Arrow.None,Arrow.Filled})}));
end JointUSP;