within Modelica.Mechanics.MultiBody.Joints;
model Prismatic 
"平移副(1个平移自由度，2个潜在状态变量，可选轴接口)"
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialElementaryJoint;
  Modelica.Mechanics.Translational.Interfaces.Flange_a axis if useAxisFlange 
    "驱动平移副的一维平动接口" 
    annotation (Placement(transformation(extent={{90,50},{70,70}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b support if useAxisFlange 
    "驱动支撑的一维平动接口(假定在全局坐标系中固定，而不在运动副中)" 
    annotation (Placement(transformation(extent={{-30,50},{-50,70}})));

  parameter Boolean useAxisFlange=false "=true，如果启用轴接口" 
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean animation=true "=true，如果启用动画（显示为长方体）";
  parameter Modelica.Mechanics.MultiBody.Types.Axis n={1,0,0} 
    "平移轴向量，在frame_a中解析" 
    annotation (Evaluate=true);
  parameter Types.Axis boxWidthDirection={0,1,0} 
    "长方体宽度方向的矢量，在frame_a中解析" 
    annotation (Evaluate=true, Dialog(tab="动画", group= 
          "如果animation=true", enable=animation));
  parameter SI.Distance boxWidth=world.defaultJointWidth 
    "平移副的的宽度" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
  parameter SI.Distance boxHeight=boxWidth "平移副的高度" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
  input Types.Color boxColor=Modelica.Mechanics.MultiBody.Types.Defaults.JointColor 
    "平移副的颜色" 
    annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射(=0：光完全被吸收)" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));
  parameter StateSelect stateSelect=StateSelect.prefer 
    "优先使用距离s和v=der(s)作为状态变量" annotation(Dialog(tab="高级"));
  final parameter Real e[3](each final unit="1")= 
     Modelica.Math.Vectors.normalizeWithAssert(n) 
    "平移轴的单位矢量";

  SI.Position s(start=0, final stateSelect=stateSelect) 
"frame_a和frame_b之间的相对距离" 
annotation (unassignedMessage="
无法确定平移副的相对距离s。
可能的原因：

连接到平移副的零件的任一侧可能缺少非零质量。

定义了过多的StateSelect.always，并且模型的自由度少于此设置指定的自由度
(移除所有StateSelect.always设置)。
");

SI.Velocity v(start=0,final stateSelect=stateSelect) 
"s的一阶导数(相对速度)";
SI.Acceleration a(start=0) "s的二阶导数(相对加速度)";
SI.Force f "沿平移轴方向的作用力";

protected
Visualizers.Advanced.Shape box(
shapeType="box", 
color=boxColor, 
specularCoefficient=specularCoefficient, 
length=if noEvent(abs(s) > 1.e-6) then s else 1.e-6, 
width=boxWidth, 
height=boxHeight, 
lengthDirection=e, 
widthDirection=boxWidthDirection, 
r=frame_a.r_0, 
R=frame_a.R) if world.enableAnimation and animation;
Translational.Components.Fixed fixed 
annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
Translational.Interfaces.InternalSupport internalAxis(f = f) 
annotation (Placement(transformation(extent={{70,50},{90,30}})));
Translational.Sources.ConstantForce constantForce(f_constant=0) if not useAxisFlange 
annotation (Placement(transformation(extent={{40,30},{60,50}})));
equation
v = der(s);
a = der(v);

// frame_a和frame_b的运动学量之间的关系
frame_b.r_0 = frame_a.r_0 + Frames.resolve1(frame_a.R, e*s);
frame_b.R = frame_a.R;

// 力和力矩平衡
zeros(3) = frame_a.f + frame_b.f;
zeros(3) = frame_a.t + frame_b.t + cross(e*s, frame_b.f);

// 达朗贝尔原理
f = -e*frame_b.f;

// 与内部连接器的连接
s = internalAxis.s;

  connect(fixed.flange, support) annotation (Line(
      points={{-40,40},{-40,60}}, color={0,127,0}));
  connect(internalAxis.flange, axis) annotation (Line(
      points={{80,40},{80,60}}, color={0,127,0}));
  connect(constantForce.flange, internalAxis.flange) annotation (Line(
      points={{60,40},{80,40}}, color={0,127,0}));
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,-50},{-30,41}}, 
          pattern=LinePattern.None, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Rectangle(
          extent={{-100,40},{-30,50}}, 
          pattern=LinePattern.None, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Rectangle(
          extent={{-30,-30},{100,20}}, 
          pattern=LinePattern.None, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Rectangle(
          extent={{-30,20},{100,30}}, 
          pattern=LinePattern.None, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Line(points={{-30,-50},{-30,50}}), 
        Line(points={{100,-30},{100,21}}), 
        Text(
          extent={{60,12},{96,-13}}, 
          textColor={128,128,128}, 
          textString="b"), 
        Text(
          extent={{-95,13},{-60,-9}}, 
          textColor={128,128,128}, 
          textString="a"), 
        Text(
          visible=useAxisFlange, 
          extent={{-150,-135},{150,-95}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-150,-90},{150,-60}}, 
          textString="n=%n"), 
        Rectangle(
          visible=useAxisFlange, 
          extent={{90,30},{100,70}}, 
          pattern=LinePattern.None, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Text(
          visible=not useAxisFlange, 
          extent={{-150,60},{150,100}}, 
          textString="%name", 
          textColor={0,0,255})}), 
    Documentation(info="<html>
<p>
在运动副中frame_b沿着在frame_a中固定的轴n进行平移。
当相对距离\"s = 0\"时，两个坐标系重合。
</p>

<p>
可选择通过参数<strong>useAxisFlange</strong>启用两个额外的一维机械接口(接口\"axis\"表示驱动接口，接口\"support\"表示轴承)。
启用的轴接口可以使用<a href=\"modelica://Modelica.Mechanics.Translational\">Modelica.Mechanics.Translational</a>库的元素驱动。
</p>

<p>
在\"高级\"菜单中，可以通过参数<strong>stateSelect</strong>定义相对距离\"s\"及其导数是否应该被明确地选为状态，通过设置stateSelect=StateSelect.always。
默认情况下，StateSelect.prefer首选将相对距离及其导数作为首选状态变量。
通常情况下，状态变量会自动选择。
在某些情况下，特别是在存在闭合运动学环路时，使用StateSelect.always设置可能会更有效。
</p>

<p>
在下图中，显示了一个平移副的动画。
浅蓝色坐标系是frame_a，深蓝色坐标系是连接件的frame_b。
黑色箭头是定义了平移轴的参数矢量\"n\"。
(这里：n={1,1,0})。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Prismatic.png\">
</div>

</html>"));
end Prismatic;