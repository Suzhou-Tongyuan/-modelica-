within Modelica.Mechanics.MultiBody.Parts;
model BodyShape 
  "具有质量、转动惯量张量、在动画中不同形状和两个坐标系连接器的刚体(12个潜在状态变量)"

  import Modelica.Mechanics.MultiBody.Types;
  import Modelica.Units.Conversions.to_unit1;

  Interfaces.Frame_a frame_a 
    "固定在组件上的坐标系，具有一个局部力和局部力矩" 
    annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));
  Interfaces.Frame_b frame_b 
    "固定在组件上的坐标系，具有一个局部力和局部力矩" 
    annotation (Placement(transformation(extent={{84,-16},{116,16}})));

  parameter Boolean animation=true 
    "=true，如果启用动画(在frame_a和frame_b之间显示形状，并在质心处显示一个球体作为可选项)";
  parameter Boolean animateSphere=true 
    "=true，如果质量应该被作为球体进行可视化，需要确保animation=true";
  parameter SI.Position r[3](start={0,0,0}) 
    "从frame_a到frame_b的矢量，在frame_a中解析";
  parameter SI.Position r_CM[3](start={0,0,0}) 
    "从frame_a到质心的矢量，在frame_a中解析";
  parameter SI.Mass m(min=0, start=1) "刚体的质量";
  parameter SI.Inertia I_11(min=0) = 0.001 "转动惯量张量的元素(1,1)" 
    annotation (Dialog(group="转动惯量张量(在质心解析，与frame_a平行)"));
  parameter SI.Inertia I_22(min=0) = 0.001 "转动惯量张量的元素(2,2)" 
    annotation (Dialog(group="转动惯量张量(在质心解析，与frame_a平行)"));
  parameter SI.Inertia I_33(min=0) = 0.001 "转动惯量张量的元素(3,3)" 
    annotation (Dialog(group="转动惯量张量(在质心解析，与frame_a平行)"));
  parameter SI.Inertia I_21(min=-C.inf) = 0 "转动惯量张量的元素(2,1)" 
    annotation (Dialog(group="转动惯量张量(在质心解析，与frame_a平行)"));
  parameter SI.Inertia I_31(min=-C.inf) = 0 "转动惯量张量的元素(3,1)" 
    annotation (Dialog(group="转动惯量张量(在质心解析，与frame_a平行)"));
  parameter SI.Inertia I_32(min=-C.inf) = 0 "转动惯量张量的元素(3,2)" 
    annotation (Dialog(group="转动惯量张量(在质心解析，与frame_a平行)"));

  SI.Position r_0[3](start={0,0,0}, each stateSelect=if enforceStates then 
        StateSelect.always else StateSelect.avoid) 
    "从全局坐标系原点到frame_a原点的位置矢量" 
    annotation (Dialog(tab="初始值",showStartAttribute=true));
  SI.Velocity v_0[3](start={0,0,0}, each stateSelect=if enforceStates then 
        StateSelect.always else StateSelect.avoid) 
    "frame_a的绝对速度，在全局坐标系中解析(=der(r_0))" 
    annotation (Dialog(tab="初始值",showStartAttribute=true));
  SI.Acceleration a_0[3](start={0,0,0}) 
    "frame_a的绝对加速度，在全局坐标系中解析(=der(v_0))" 
    annotation (Dialog(tab="初始值",showStartAttribute=true));

 parameter Boolean angles_fixed=false 
    "=true，如果将angles_start用作初始值，否则将其用作猜测值" 
    annotation (
    Evaluate=true, 
    choices(checkBox=true), 
    Dialog(tab="初始值"));
parameter SI.Angle angles_start[3]={0,0,0} 
    "将全局坐标系绕'sequence_start'轴旋转到frame_a的初始角度值" 
    annotation (Dialog(tab="初始值"));
parameter Types.RotationSequence sequence_start={1,2,3} 
    "将全局坐标系旋转到frame_a的初始序列" 
    annotation (Evaluate=true, Dialog(tab="初始值"));

parameter Boolean w_0_fixed=false 
    "=true，如果将w_0_start用作初始值，否则将其用作猜测值" 
    annotation (
    Evaluate=true, 
    choices(checkBox=true), 
    Dialog(tab="初始值"));
parameter SI.AngularVelocity w_0_start[3]={0,0,0} 
    "在全局坐标系中解析的frame_a的角速度的初始或猜测值" 
    annotation (Dialog(tab="初始值"));

parameter Boolean z_0_fixed=false 
    "=true，如果将z_0_start用作初始值，否则将其用作猜测值" 
    annotation (
    Evaluate=true, 
    choices(checkBox=true), 
    Dialog(tab="初始值"));
parameter SI.AngularAcceleration z_0_start[3]={0,0,0} 
    "角加速度z_0的初始值，其中z_0=der(w_0)" 
    annotation (Dialog(tab="初始值"));

parameter Types.ShapeType shapeType="cylinder" "形状的类型" annotation (
     Dialog(
      tab="动画", 
      group="如果animation=true", 
      enable=animation));
parameter SI.Position r_shape[3]={0,0,0} 
    "从frame_a到形状原点的矢量，在frame_a中解析" annotation (
      Dialog(
      tab="动画", 
      group="如果animation=true", 
      enable=animation));
parameter Types.Axis lengthDirection = to_unit1(r - r_shape) 
    "形状长度方向的矢量，在frame_a中解析" annotation (
      Evaluate=true, Dialog(
      tab="动画", 
      group="如果animation=true", 
      enable=animation));
parameter Types.Axis widthDirection={0,1,0} 
    "形状宽度方向的矢量，在frame_a中解析" annotation (
      Evaluate=true, Dialog(
      tab="动画", 
      group="如果animation=true", 
      enable=animation));
parameter SI.Length length=Modelica.Math.Vectors.length(r - r_shape) 
    "形状的长度" annotation (Dialog(
      tab="动画", 
      group="如果animation=true", 
      enable=animation));
parameter SI.Distance width=length/world.defaultWidthFraction 
    "形状的宽度" 
    annotation (Dialog(
      tab="动画", 
      group="如果animation=true", 
      enable=animation));
parameter SI.Distance height=width "形状的高度" 
    annotation (Dialog(
      tab="动画", 
      group="如果animation=true", 
      enable=animation));
parameter Types.ShapeExtra extra=0.0 
    "根据形状类型而定的额外参数(请参阅Visualizers.Advanced.Shape的文档)" 
    annotation (Dialog(
      tab="动画", 
      group="如果animation=true", 
      enable=animation));
input Types.Color color=Modelica.Mechanics.MultiBody.Types.Defaults.BodyColor 
    "形状的颜色" 
    annotation (Dialog(
      colorSelector=true, 
      tab="动画", 
      group="如果animation=true", 
      enable=animation));
parameter SI.Diameter sphereDiameter=2*width "球体的直径" 
    annotation (Dialog(
      tab="动画", 
      group="如果animation=true并且animateSphere=true", 
      enable=animation and animateSphere));
input Types.Color sphereColor=color "球体的颜色" 
    annotation (
      Dialog(
      colorSelector=true, 
      tab="动画", 
      group="如果animation=true并且animateSphere=true", 
      enable=animation and animateSphere));
input Types.SpecularCoefficient specularCoefficient=world.defaultSpecularCoefficient 
    "环境光的反射(=0：光完全被吸收)" 
    annotation (Dialog(
      tab="动画", 
      group="如果animation=true", 
      enable=animation));
parameter Boolean enforceStates=false 
    "=true，如果将物体对象的绝对变量用作状态(StateSelect.always)" 
    annotation (Evaluate=true, Dialog(tab="高级"));
parameter Boolean useQuaternions=true 
    "=true，如果将四元数用作潜在状态，否则使用3个角度作为潜在状态" 
    annotation (Evaluate=true, Dialog(tab="高级"));
parameter Types.RotationSequence sequence_angleStates={1,2,3} 
    "将全局坐标系绕用作潜在状态的3个角度旋转到frame_a的序列" 
    annotation (Evaluate=true, Dialog(tab="高级", enable=not useQuaternions));


  FixedTranslation frameTranslation(r=r, animation=false) annotation (
      Placement(transformation(extent={{-20,-20},{20,20}})));
  Body body(
    r_CM=r_CM, 
    m=m, 
    I_11=I_11, 
    I_22=I_22, 
    I_33=I_33, 
    I_21=I_21, 
    I_31=I_31, 
    I_32=I_32, 
    animation=false, 
    sequence_start=sequence_start, 
    angles_fixed=angles_fixed, 
    angles_start=angles_start, 
    w_0_fixed=w_0_fixed, 
    w_0_start=w_0_start, 
    z_0_fixed=z_0_fixed, 
    z_0_start=z_0_start, 
    useQuaternions=useQuaternions, 
    sequence_angleStates=sequence_angleStates, 
    enforceStates=false) annotation (Placement(transformation(extent={{-27.3333, 
            -70.3333},{13,-30}})));
protected
  outer Modelica.Mechanics.MultiBody.World world;
  Visualizers.Advanced.Shape shape1(
    shapeType=shapeType, 
    color=color, 
    specularCoefficient=specularCoefficient, 
    length=length, 
    width=width, 
    height=height, 
    lengthDirection=lengthDirection, 
    widthDirection=widthDirection, 
    r_shape=r_shape, 
    extra=extra, 
    r=frame_a.r_0, 
    R=frame_a.R) if world.enableAnimation and animation;
  Visualizers.Advanced.Shape shape2(
    shapeType="sphere", 
    color=sphereColor, 
    specularCoefficient=specularCoefficient, 
    length=sphereDiameter, 
    width=sphereDiameter, 
    height=sphereDiameter, 
    lengthDirection={1,0,0}, 
    widthDirection={0,1,0}, 
    r_shape=r_CM - {1,0,0}*sphereDiameter/2, 
    r=frame_a.r_0, 
    R=frame_a.R) if world.enableAnimation and animation and animateSphere;
equation
  r_0 = frame_a.r_0;
  v_0 = der(r_0);
  a_0 = der(v_0);
  connect(frame_a, frameTranslation.frame_a) annotation (Line(
      points={{-100,0},{-20,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(frame_b, frameTranslation.frame_b) annotation (Line(
      points={{100,0},{20,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(frame_a, body.frame_a) annotation (Line(
      points={{-100,0},{-60,0},{-60,-50.1666},{-27.3333,-50.1666}}, 
      color={95,95,95}, 
      thickness=0.5));
  annotation (
    Documentation(info="<html>
<p>
<strong>刚体</strong>具有质量和转动惯量张量以及<strong>两个坐标系连接器</strong>。
所有参数矢量都必须在frame_a中解析。
<strong>转动惯量张量</strong>必须相对于与frame_a平行的坐标系定义，原点位于物体质心处。
坐标系<strong>frame_b</strong>始终与<strong>frame_a</strong>平行。
</p>
<p>
默认情况下，此组件由可以使用Modelica.Mechanics.MultiBody.Visualizers.FixedShape定义的任何<strong>形状</strong>可视化。
此形状放置在frame_a和frame_b之间(默认：length(shape) = Frames.length(r))。
此外，还可以可视化一个<strong>球体</strong>，其中心位于质心。
请注意，动画可以通过参数animation = <strong>false</strong>关闭。
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Parts/BodyShape.png\" alt=\"Parts.BodyShape\">
</div>

<p>
可以通过参数<strong>shapeType</strong>定义以下形状，例如，shapeType = \"cone\"：
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/FixedShape.png\" alt=\"Visualizers.FixedShape\">
</div>

<p>
BodyShape组件具有潜在状态。
有关这些状态和\"高级\"菜单参数的详细信息，请参见模型<a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Body\">MultiBody.Parts.Body</a>。
</p>

</html>"), 
    Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-150,110},{150,70}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-150,-100},{150,-70}}, 
          textString="r=%r"), 
        Rectangle(
          extent={{-100,30},{101,-30}}, 
          lineColor={0,24,48}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          fillColor={0,127,255}, 
          radius=10), 
        Ellipse(
          extent={{-60,60},{60,-60}}, 
          lineColor={0,24,48}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={0,127,255}), 
        Text(
          extent={{-50,24},{55,-27}}, 
          textString="%m"), 
        Text(
          extent={{55,12},{91,-13}}, 
          textString="b"), 
        Text(
          extent={{-92,13},{-56,-12}}, 
          textString="a")}), 
    Diagram(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-100,9},{-100,43}}, color={128,128,128}), 
        Line(points={{100,0},{100,44}}, color={128,128,128}), 
        Line(points={{-100,40},{90,40}}, color={135,135,135}), 
        Polygon(
          points={{90,44},{90,36},{100,40},{90,44}}, 
          lineColor={128,128,128}, 
          fillColor={128,128,128}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-22,68},{20,40}}, 
          textColor={128,128,128}, 
          textString="r"), 
        Line(points={{-100,-10},{-100,-90}}, color={128,128,128}), 
        Line(points={{-100,-84},{-10,-84}}, color={128,128,128}), 
        Polygon(
          points={{-10,-80},{-10,-88},{0,-84},{-10,-80}}, 
          lineColor={128,128,128}, 
          fillColor={128,128,128}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-82,-66},{-56,-84}}, 
          textColor={128,128,128}, 
          textString="r_CM"), 
        Line(points={{0,-46},{0,-90}}, color={128,128,128})}));
end BodyShape;