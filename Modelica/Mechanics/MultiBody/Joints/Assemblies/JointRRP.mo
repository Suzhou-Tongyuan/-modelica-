within Modelica.Mechanics.MultiBody.Joints.Assemblies;
model JointRRP 
  "平面旋转-旋转-平移副组合(无约束，无潜在状态变量)"

  import Modelica.Mechanics.MultiBody.Types;
  import Modelica.Units.Conversions.to_unit1;

  extends Interfaces.PartialTwoFramesDoubleSize;
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_ia 
    "位于frame_a原点的坐标系，固定在转动副的连接杆上" 
    annotation (Placement(transformation(
        origin={-80,100}, 
        extent={{-8,-8},{8,8}}, 
        rotation=90)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_ib 
    "位于frame_b原点的坐标系，固定在转动副和平移副的连接杆上" 
    annotation (Placement(transformation(
        origin={80,100}, 
        extent={{-8,8},{8,-8}}, 
        rotation=270)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_im 
    "位于中间转动副原点的坐标系，固定在转动副和平移副的连接杆上" 
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

parameter Boolean animation=true "=true，如果要启用动画";
parameter Modelica.Mechanics.MultiBody.Types.Axis n_a={0,0,1} 
  "两个转动副在frame_a中解析的轴(两个轴都与彼此平行)" 
  annotation (Evaluate=true);
parameter Modelica.Mechanics.MultiBody.Types.Axis n_b={-1,0,0} 
  "固定在frame_b中并在其内解析的平移副轴(必须与转动副轴正交)" 
  annotation (Evaluate=true);
parameter SI.Position rRod1_ia[3]={1,0,0} 
  "从frame_a原点到中间转动副的矢量，解析在frame_ia中" 
  annotation (Evaluate=true);
parameter SI.Position rRod2_ib[3]={-1,0,0} 
  "从frame_ib原点到中间转动副的矢量，解析在frame_ib中(frame_ib与frame_b平行)";
parameter SI.Position s_offset=0 
  "平移副的相对距离偏移(平移副坐标系之间的距离=s(t)+s_offset)";
parameter SI.Position s_guess=0 
  "选择配置，使得在初始时间|s(t0)-s_guess|最小化";
parameter SI.Distance cylinderLength=world.defaultJointLength 
  "表示转动副的圆柱体的长度" 
  annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
parameter SI.Distance cylinderDiameter=world.defaultJointWidth 
  "表示转动副的圆柱体的直径" 
  annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
input Types.Color cylinderColor=Modelica.Mechanics.MultiBody.Types.Defaults.JointColor 
  "表示转动副的圆柱体的颜色" 
  annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));
parameter Types.Axis boxWidthDirection={0,1,0} 
  "平移副宽度方向的矢量，解析在frame_b中" 
  annotation (Evaluate=true, Dialog(tab="动画", group="如果animation=true", enable=animation));

parameter SI.Distance boxWidth=world.defaultJointWidth 
  "平移副箱体的宽度" 
  annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
parameter SI.Distance boxHeight=boxWidth "平移副箱体的高度" 
  annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
input Types.Color boxColor=cylinderColor "平移副箱体的颜色" 
  annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));
parameter SI.Diameter rodDiameter=1.1*cylinderDiameter 
  "连接运动副的两根杆的直径" 
  annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
input Types.Color rodColor=Modelica.Mechanics.MultiBody.Types.Defaults.RodColor 
  "连接运动副的两根杆的颜色" 
  annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));
input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
  "环境光的反射(=0：光完全被吸收)" 
  annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
parameter Boolean checkTotalPower=false 
  "=true，如果要确定流入此组件的总功率(必须为零)" 
  annotation (Dialog(tab="高级"));
final parameter Real e_a[3](each final unit="1")=Modelica.Math.Vectors.normalizeWithAssert(
                                           n_a) 
  "绕轴的单位矢量，在frame_a中解析";
final parameter Real e_ia[3](each final unit="1")=jointUSP.e2_ia 
  "绕轴的单位矢量，在frame_ia中解析";
final parameter Real e_im[3](each final unit="1", each fixed=false) 
  "绕轴的单位矢量，在frame_im中解析";
final parameter Real e_b[3](each final unit="1")=jointUSP.prismatic.e 
  "平移副的平动轴的单位矢量，在frame_b和frame_ib中解析";
SI.Power totalPower=jointUSP.totalPower 
  "如果checkTotalPower=true，则流入此元素的总功率(否则为虚拟值)";

  JointUSP jointUSP(
    animation=false, 
    showUniversalAxes=false, 
    n1_a=n_a, 
    n_b=n_b, 
    s_offset=s_offset, 
    s_guess=s_guess, 
    rRod1_ia=rRod1_ia, 
    rRod2_ib=rRod2_ib, 
    checkTotalPower=checkTotalPower) annotation (Placement(transformation(
          extent={{-30,-20},{10,20}})));

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
    lengthDirection=e_im, 
    widthDirection={0,1,0}, 
    r_shape=-e_im*(cylinderLength/2), 
    r=frame_im.r_0, 
    R=frame_im.R) if world.enableAnimation and animation;
  Visualizers.Advanced.Shape shape_prism(
    shapeType="box", 
    color=boxColor, 
    specularCoefficient=specularCoefficient, 
    length=jointUSP.prismatic.distance, 
    width=boxWidth, 
    height=boxHeight, 
    lengthDirection=e_b, 
    widthDirection=e_im, 
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
  e_im = Frames.resolve2(frame_im.R, Frames.resolve1(frame_a.R, e_a));

equation
  connect(jointUSP.frame_a, frame_a) 
    annotation (Line(
      points={{-30,0},{-100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(jointUSP.frame_b, frame_b) 
    annotation (Line(
      points={{10,0},{100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(jointUSP.frame_ia, frame_ia) annotation (Line(
      points={{-26,20},{-26,70},{-80,70},{-80,100}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(jointUSP.frame_im, frame_im) annotation (Line(
      points={{-10,20},{-10,70},{0,70},{0,100}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(jointUSP.frame_ib, frame_ib) annotation (Line(
      points={{6,20},{6,50},{80,50},{80,100}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(jointUSP.axis, axis) 
    annotation (Line(points={{10,16},{86,16},{86,80},{100,80}}));
  connect(jointUSP.bearing, bearing) 
    annotation (Line(points={{10,8},{94,8},{94,40},{100,40}}));
  annotation (
    Documentation(info="<html>
<p>
这个组件由<strong>2个旋转</strong>运动副和一个与转动副轴线平行的<strong>平动</strong>运动副组成，该平移副的轴线与转动副轴线正交，参见下图中的默认动画(轴向矢量不是默认动画的一部分)：</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Assemblies/JointRRP.png\"alt=\"model Joints.Assemblies.JointRRP\">
</div>

<p>
这个运动副组合既不引入约束也不引入状态变量，因此在可能的情况下应该在运动学环路中使用，以避免非线性方程组。
只有在<strong>平面环路</strong>中使用这个组件才有意义。
基本上，通过解析一个非线性方程来计算3个运动副以及frame_ia、frame_ib和frame_im的位置和方向，给定frame_a和frame_b处的位置和方向。
</p>
<p>
连接器<strong>frame_a</strong>是第一个转动副的“左”侧，而<strong>frame_ia</strong>是这个转动副的“右”侧，固定在杆1上。
连接器<strong>frame_b</strong>是平移副的“右”侧，而<strong>frame_ib</strong>是这个平移副的“左”侧，固定在杆2上。
最后，连接器<strong>frame_im</strong>是中间转动副的“右”侧连接器，固定在杆2上。
frame_b、frame_ib、frame_im始终平行于彼此。
</p>
<p>
定义这个运动副的参数最简单的方法是将MultiBody系统移动到一个<strong>参考配置</strong>中，其中<strong>所有组件的所有坐标系</strong>都<strong>平行</strong>于彼此(或者，当定义这个组件的实例时，至少JointRRP运动副的frame_a、frame_ia、frame_im、frame_ib、frame_b应该彼此平行)。
</p>
<p>
基本上，JointRRP模型内部由一个万向节-球面-平移副组合(=JointUSP)组成。
在一个平面环路中，这将表现得像是连接了刚性杆的2个平行轴转动副和1个平移副。
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
          extent={{-139,-53},{141,-78}}, 
          textColor={0,0,255}, 
          textString="%name"), 
        Text(
          extent={{26,124},{68,93}}, 
          textColor={128,128,128}, 
          textString="ib"), 
        Text(
          extent={{-134,128},{-94,94}}, 
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
          points={{54,5},{5,47},{8,53},{58,11},{54,5}}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-128,-29},{139,-47}}, 
          textString="n_a=%n_a"), 
        Line(
          points={{0,57},{0,86},{0,86},{0,100}}, 
          color={95,95,95}, 
          thickness=0.5), 
        Text(
          extent={{-55,126},{-15,92}}, 
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
          thickness=0.5), 
        Rectangle(
          extent={{80,15},{100,21}}, 
          pattern=LinePattern.None, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Rectangle(
          extent={{53,5},{80,11}}, 
          pattern=LinePattern.None, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Rectangle(
          extent={{53,5},{80,-15}}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{80,15},{100,-21}}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Line(
          points={{80,100},{80,80},{57,11}}, 
          color={95,95,95}, 
          thickness=0.5)}));
end JointRRP;