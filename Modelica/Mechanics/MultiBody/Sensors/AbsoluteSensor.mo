within Modelica.Mechanics.MultiBody.Sensors;
model AbsoluteSensor 
  "测量连接器的绝对运动学量"

  Blocks.Interfaces.RealOutput r[3](
    each final quantity="长度", 
    each final unit="m") if get_r 
    "在由resolveInFrame定义的参考系中解析的绝对位置矢量frame_a.r_0" 
    annotation (Placement(transformation(
        origin={-100,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
  Blocks.Interfaces.RealOutput v[3](
    each final quantity="速度", 
    each final unit="m/s") if get_v "绝对速度矢量" 
    annotation (Placement(transformation(
        origin={-60,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
  Blocks.Interfaces.RealOutput a[3](
    each final quantity="加速度", 
    each final unit="m/s2") if get_a "绝对加速度矢量" 
    annotation (Placement(transformation(
        origin={-20,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
  Blocks.Interfaces.RealOutput angles[3](
    each final quantity="角度", 
    each final unit="rad", 
    each displayUnit="deg") if get_angles 
    "将全局坐标系旋转到frame_a的角度，通过'sequence'" 
    annotation (Placement(transformation(
        origin={20,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
  Blocks.Interfaces.RealOutput w[3](each final quantity="角速度", 
      each final unit="1/s") if get_w "绝对角速度矢量" 
    annotation (Placement(transformation(
        origin={60,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
  Blocks.Interfaces.RealOutput z[3](each final quantity="角加速度", 
      each final unit="1/s2") if get_z "绝对角加速度矢量" 
    annotation (Placement(transformation(
        origin={100,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
extends Modelica.Mechanics.MultiBody.Sensors.Internal.PartialAbsoluteSensor;

Interfaces.Frame_resolve frame_resolve if resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve 
    "如果resolveInFrame=Types.ResolveInFrameA.frame_resolve，则输出信号在此坐标系中解析" 
    annotation (Placement(transformation(
        extent={{84,-16},{116,16}})));

parameter Boolean animation=true 
    "=true，如果要启用动画(显示箭头)";
parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameA resolveInFrame= 
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a 
    "矢量解析的坐标系(world，frame_a或frame_resolve)";
parameter Boolean get_r=false 
    "=true，测量frame_a原点的绝对位置矢量" 
    annotation(HideResult=true, choices(checkBox=true));
parameter Boolean get_v=false 
    "=true，测量frame_a原点的绝对速度" 
    annotation(HideResult=true, choices(checkBox=true));
parameter Boolean get_a=false 
    "=true，测量frame_a原点的绝对加速度" 
    annotation(HideResult=true, choices(checkBox=true));
parameter Boolean get_w=false 
    "=true，测量frame_a的绝对角速度" 
    annotation(HideResult=true, choices(checkBox=true));
parameter Boolean get_z=false 
    "=true，测量frame_a的绝对角加速度" 
    annotation(HideResult=true, choices(checkBox=true));
parameter Boolean get_angles=false 
    "=true，测量3个旋转角度" 
    annotation(HideResult=true, choices(checkBox=true), Dialog(group="3个角度，将全局坐标系旋转到frame_a坐标系沿着\"sequence\"中定义的轴"));
parameter Types.RotationSequence sequence(
    min={1,1,1}, 
    max={3,3,3}) = {1,2,3} 
    "如果get_angles=true:返回旋转全局坐标系围绕轴sequence[1]、sequence[2]和最后sequence[3]到frame_a的角度" 
    annotation (HideResult=true,Evaluate=true, Dialog(group="3个角度，将全局坐标系旋转到frame_a坐标系沿着\"sequence\"中定义的轴", enable=get_angles));
parameter SI.Angle guessAngle1=0 
    "如果get_angles=true:选择angles[1]，使得abs(angles[1]-guessAngle1)最小" 
    annotation (HideResult=true,Dialog(group="3个角度，将全局坐标系旋转到frame_a坐标系沿着\"sequence\"中定义的轴", enable=get_angles));

input Types.Color arrowColor=Modelica.Mechanics.MultiBody.Types.Defaults.SensorColor 
    "从全局坐标系到frame_b的绝对箭头颜色" 
    annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));
input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射(=0：光被完全吸收)" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));

protected
  AbsolutePosition position(resolveInFrame=resolveInFrame) if get_r 
    annotation (Placement(transformation(extent={{10,10},{-10,30}}, 
        rotation=90, 
        origin={-80,-60})));

protected
  AbsoluteVelocity velocity(resolveInFrame=resolveInFrame) if get_v 
                                                           annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=90, 
        origin={-60,-60})));
  Modelica.Mechanics.MultiBody.Sensors.AbsoluteAngles absoluteAngles(sequence=sequence, guessAngle1=guessAngle1) if get_angles annotation (Placement(transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=-90, 
        origin={20,-60})));
  AbsoluteAngularVelocity angularVelocity(resolveInFrame=resolveInFrame) if get_w 
    annotation (Placement(transformation(extent={{-10,-10},{10,-30}}, 
        rotation=-90, 
        origin={70,-60})));

protected
  Blocks.Continuous.Der der1[3] if get_a annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}}, 
        rotation=-90, 
        origin={-20,-34})));
protected
  Blocks.Continuous.Der der2[3] if get_z annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}}, 
        rotation=-90, 
        origin={100,-46})));

protected
  Modelica.Mechanics.MultiBody.Sensors.TransformAbsoluteVector transformVector_a(frame_r_in=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world, frame_r_out=resolveInFrame) if get_a annotation (Placement(transformation(extent={{-10,-70},{-30,-50}})));
  Modelica.Mechanics.MultiBody.Sensors.TransformAbsoluteVector transformVector_z(frame_r_in=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world, frame_r_out=resolveInFrame) if get_z annotation (Placement(transformation(extent={{90,-80},{110,-60}})));

protected
  outer Modelica.Mechanics.MultiBody.World world;

  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Arrow arrow(
    r_head=frame_a.r_0, 
    color=arrowColor, 
    specularCoefficient) if world.enableAnimation and animation;

protected
  AbsoluteVelocity absoluteVelocity(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world) if get_a 
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=90, 
        origin={-20,-12})));
  AbsoluteAngularVelocity absoluteAngularVelocity(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world) if 
       get_z 
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Mechanics.MultiBody.Forces.Internal.ZeroForceAndTorque zeroForce1 
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Mechanics.MultiBody.Forces.Internal.ZeroForceAndTorque zeroForce2 if resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve 
    annotation (Placement(transformation(extent={{80,20},{60,40}})));
equation
  connect(zeroForce1.frame_a, frame_a) 
                                  annotation (Line(
      points={{-60,30},{-80,30},{-80,0},{-100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(absoluteAngles.angles, angles) annotation (Line(
      points={{20,-71},{20,-90},{20,-90},{20,-110}}, color={0,0,127}));
  connect(angularVelocity.frame_a, frame_a) annotation (Line(
      points={{50,-50},{50,-40},{20,-40},{20,0},{-100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(angularVelocity.w, w) annotation (Line(
      points={{50,-71},{50,-94},{60,-94},{60,-110}}, color={0,0,127}));
  connect(frame_resolve, position.frame_resolve) annotation (Line(
      points={{100,0},{114,0},{114,-90},{-80,-90},{-80,-60},{-90,-60}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(frame_resolve,zeroForce2. frame_a) annotation (Line(
      points={{100,0},{90,0},{90,30},{80,30}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(angularVelocity.frame_resolve, frame_resolve) annotation (
      Line(
      points={{60,-60},{66,-60},{66,-90},{114,-90},{114,0},{100,0}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(transformVector_a.frame_a, frame_a) annotation (Line(
      points={{-10,-60},{0,-60},{0,-40},{20,-40},{20,0},{-100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(transformVector_a.frame_resolve, frame_resolve) annotation (Line(
      points={{-30,-60},{-40,-60},{-40,-90},{114,-90},{114,0},{100,0}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(transformVector_a.r_out, a) annotation (Line(
      points={{-20,-71},{-20,-110}}, color={0,0,127}));
  connect(der2.y, transformVector_z.r_in) annotation (Line(
      points={{100,-52.6},{100,-58}}, color={0,0,127}));
  connect(transformVector_z.r_out, z) annotation (Line(
      points={{100,-81},{100,-110}}, color={0,0,127}));
  connect(transformVector_z.frame_a, frame_a) annotation (Line(
      points={{90,-70},{80,-70},{80,-40},{20,-40},{20,0},{-100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(transformVector_z.frame_resolve, frame_resolve) annotation (Line(
      points={{110,-70},{110,-70},{114,-70},{114,0},{100,0}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(frame_a, position.frame_a) annotation (Line(
      points={{-100,0},{-80,0},{-80,-40},{-100,-40},{-100,-50}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(absoluteAngles.frame_a, frame_a) annotation (Line(
      points={{20,-50},{20,0},{-100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(position.r, r) annotation (Line(
      points={{-100,-71},{-100,-110}}, color={0,0,127}));
  connect(velocity.frame_a, frame_a) annotation (Line(
      points={{-60,-50},{-60,-40},{-80,-40},{-80,0},{-100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(velocity.frame_resolve, frame_resolve) annotation (Line(
      points={{-50,-60},{-40,-60},{-40,-90},{114,-90},{114,0},{100,0}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(velocity.v, v) annotation (Line(
      points={{-60,-71},{-60,-110}}, color={0,0,127}));
  connect(der1.y, transformVector_a.r_in) annotation (Line(
      points={{-20,-40.6},{-20,-48}}, color={0,0,127}));
  connect(absoluteVelocity.v, der1.u) annotation (Line(
      points={{-20,-23},{-20,-26.8}}, color={0,0,127}));
  connect(absoluteVelocity.frame_a, frame_a) annotation (Line(
      points={{-20,-2},{-20,0},{-100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(absoluteAngularVelocity.frame_a, frame_a) annotation (Line(
      points={{40,0},{-100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(absoluteAngularVelocity.w, der2.u) annotation (Line(
      points={{61,0},{80,0},{80,-30},{100,-30},{100,-38.8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
            -100},{100,100}}), graphics={
        Line(
          visible=get_r, 
          points={{-68,-20},{-100,-40},{-100,-100}}, 
          color={0,0,127}), 
        Line(
          visible=get_v, 
          points={{-60,-36},{-60,-68}}, 
          color={0,0,127}), 
        Line(
          visible=get_v, 
          points={{-60,-94},{-60,-100}}, 
          color={0,0,127}), 
        Line(
          visible=get_a, 
          points={{-20,-67},{-20,-100}}, 
          color={0,0,127}), 
        Line(
          visible=get_angles, 
          points={{20,-67},{20,-72}}, 
          color={0,0,127}), 
        Line(
          visible=get_angles, 
          points={{20,-94},{20,-100}}, 
          color={0,0,127}), 
        Line(
          visible=get_w, 
          points={{60,-36},{60,-48}}, 
          color={0,0,127}), 
        Line(
          visible=get_w, 
          points={{60,-76},{60,-100}}, 
          color={0,0,127}), 
        Line(
          visible=get_z, 
          points={{68,-20},{100,-40},{100,-68}}, 
          color={0,0,127}), 
        Line(
          visible=get_z, 
          points={{100,-94},{100,-100}}, 
          color={0,0,127}), 
        Line(
          points={{95,0},{95,0},{70,0}}, 
          pattern=LinePattern.Dot), 
        Text(
          extent={{-132,76},{129,124}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          visible=get_r, 
          extent={{-140,-72},{-100,-92}}, 
          textColor={64,64,64}, 
          textString="m"), 
        Text(
          visible=get_v, 
          extent={{-90,-72},{-40,-92}}, 
          textColor={64,64,64}, 
          textString="m/s"), 
        Text(
          visible=get_a, 
          extent={{-50,-36},{20,-56}}, 
          textColor={64,64,64}, 
          textString="m/s2"), 
        Text(
          visible=get_angles, 
          extent={{-6,-72},{54,-92}}, 
          textColor={64,64,64}, 
          textString="rad"), 
        Text(
          visible=get_w, 
          extent={{34,-50},{104,-70}}, 
          textColor={64,64,64}, 
          textString="rad/s"), 
        Text(
          visible=get_z, 
          extent={{70,-72},{160,-92}}, 
          textColor={64,64,64}, 
          textString="rad/s2"), 
        Text(
          extent={{60,52},{191,27}}, 
          textColor={95,95,95}, 
          textString="resolve")}), 
    Documentation(info="<html>
<p>
frame_a的绝对运动量由条件输出信号连接器确定并提供。
例如，如果参数\"get_r = <strong>true</strong>\"，则连接器\"r\"被启用，并包含从全局坐标系到frame_a原点的绝对矢量。
可以提供以下量作为输出信号：</p>

<ol>
<li>绝对位置矢量(=r)</li>
<li>绝对速度矢量(=v)</li>
<li>绝对加速度矢量(=a)</li>
<li>将全局坐标系旋转到frame_a的三个角度(=angles)</li>
<li>绝对角速度矢量(=w)</li>
<li>绝对角加速度矢量(=z)</li>
</ol>

<p>
通过参数<strong>resolveInFrame</strong>定义了在哪个坐标系中解析矢量：</p>

<table border=\"1\"cellspacing=\"0\"cellpadding=\"2\">
<tr><th><strong>resolveInFrame=<br>Types.ResolveInFrameA.</strong></th><th><strong>含义</strong></th></tr>
<tr><td>world</td>
<td>在全局坐标系中解析矢量</td></tr>

<tr><td>frame_a</td>
<td>在frame_a中解析矢量</td></tr>

<tr><td>frame_resolve</td>
<td>在frame_resolve中解析矢量</td></tr>
</table>

<p>
如果resolveInFrame=Types.ResolveInFrameA.frame_resolve，则条件连接器\"frame_resolve\"被启用，并且矢量在连接到frame_resolve的坐标系中解析。
请注意，如果启用了此连接器，则必须连接它。
</p>

<p>
下图显示了AbsoluteSensor组件的动画。
浅蓝色坐标系是frame_a，黄色箭头是动画传感器。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Sensors/AbsoluteSensor.png\">
</div>

<p>
速度、加速度、角速度和角加速度是通过在全局坐标系中对它们进行微分，然后将它们转换为由<strong>resolveInFrame</strong>定义的坐标系中确定的。
</p>
<p>
例如，如果resolveInFrame=<strong>Types.ResolveInFrameA.frame_a</strong>，则返回以下内容：</p>
<blockquote><pre>
v0=<strong>der</strong>(frame_a.r0);
v=resolve2(frame_a.R,v0);
</pre></blockquote>
<p>
即，绝对从全局坐标系到frame_a原点的距离的导数，在frame_a中解析。
</p>

<p>
frame_resolve中的局部力和局部力矩始终为零，无论frame_resolve是否连接。
</p>


<p>
如果<strong>get_angles</strong>=<strong>true</strong>，则返回将全局坐标系旋转到frame_a坐标系的三个角度，沿着由参数<strong>sequence</strong>定义的轴。
例如，如果sequence={3,1,2}，则全局坐标系围绕angles[1]沿着z轴旋转，然后围绕angles[2]沿着x轴旋转，最后围绕angles[3]沿着y轴旋转，最终与frame_a完全相同。
这三个角度返回在以下范围内：</p>
<blockquote><pre>
-&pi;&lt;=angles[i]&lt;=&pi;
</pre></blockquote>
<p>
在这个范围内，对于\"angles[1]\"有<strong>两个解</strong>。
通过参数<strong>guessAngle1</strong>(默认值为0)，选择使|angles[1]-guessAngle1|最小的解。
相对于\"sequence\"，frame_a的绝对变换矩阵可能处于奇异配置，即，有无限多个角度值导致相同的绝对变换矩阵。
在这种情况下，通过设置angles[1]=guessAngle1来选择返回的解。
然后angles[2]和angles[3]可以在上述范围内唯一确定。
</p>
<p>
参数<strong>sequence</strong>有一个限制，即只能使用值1、2、3，并且sequence[1]&ne;sequence[2]和sequence[2]&ne;sequence[3]。
经常使用的值包括：</p>
<blockquote><pre>
sequence=<strong>{1,2,3}</strong>//Cardan或Tait-Bryan角顺序
=<strong>{3,1,3}</strong>//欧拉角顺序
=<strong>{3,2,1}</strong>
</pre></blockquote>

</html>"));
end AbsoluteSensor;