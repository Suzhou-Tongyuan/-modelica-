within Modelica.Mechanics.MultiBody.Sensors;
model RelativeSensor 
 "测量两个坐标系连接器之间的相对运动量"

  extends Modelica.Mechanics.MultiBody.Sensors.Internal.PartialRelativeSensor;

  Interfaces.Frame_resolve frame_resolve if 
        resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve or 
        resolveInFrameAfterDifferentiation == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve 
    "如果resolveInFrame=Types.ResolveInFrameAB.frame_resolve，则输出信号在此坐标系中解析" 
     annotation (Placement(transformation(
          extent={{84,64},{116,96}})));

  parameter Boolean animation=true 
    "=true，如果要启用动画(显示箭头)";
  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB 
    resolveInFrame= 
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a 
    "在微分之前解析矢量的坐标系(world、frame_a、frame_b或frame_resolve)";
  parameter Boolean get_r_rel=false 
    "=true，以测量从frame_a原点到frame_b的相对位置矢量" 
    annotation(HideResult=true, choices(checkBox=true));
  parameter Boolean get_v_rel=false 
    "=true，以测量frame_b原点相对于frame_a的相对速度" 
    annotation(HideResult=true, choices(checkBox=true));
  parameter Boolean get_a_rel=false 
    "=true，以测量frame_b原点相对于frame_a的相对加速度" 
    annotation(HideResult=true, choices(checkBox=true));
  parameter Boolean get_w_rel=false 
    "=true，以测量frame_b相对于frame_a的相对角速度" 
    annotation(HideResult=true, choices(checkBox=true));
  parameter Boolean get_z_rel=false 
    "=true，以测量frame_b相对于frame_a的相对角加速度" 
    annotation(HideResult=true, choices(checkBox=true));
  parameter Boolean get_angles=false 
    "=true，以测量3个旋转角度" 
    annotation(HideResult=true, choices(checkBox=true), Dialog(group="沿着\"序列\"中定义的坐标轴将frame_a旋转到frame_b的3个角度"));
  parameter Types.RotationSequence sequence(
    min={1,1,1}, 
    max={3,3,3}) = {1,2,3} 
    "如果get_angles=true：返回角度以将frame_a沿sequence[1]、sequence[2]和最后sequence[3]的轴旋转到frame_b" 
    annotation (HideResult=true,Evaluate=true, Dialog(group="沿着\"序列\"中定义的坐标轴将frame_a旋转到frame_b的3个角度", enable=get_angles));
  parameter SI.Angle guessAngle1=0 
    "如果get_angles=true：选择angles[1]，使abs(angles[1]-guessAngle1)最小" 
    annotation (HideResult=true,Dialog(group="沿着\"序列\"中定义的坐标轴将frame_a旋转到frame_b的3个角度", enable=get_angles));
  input Types.Color arrowColor=Modelica.Mechanics.MultiBody.Types.Defaults.SensorColor 
    "frame_a到frame_b的相对箭头颜色" 
    annotation (Dialog(colorSelector=true, tab="动画", group="如果animation=true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射(=0：光被完全吸收)" 
    annotation (Dialog(tab="动画", group="如果animation=true", enable=animation));

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB 
    resolveInFrameAfterDifferentiation = resolveInFrame 
    "微分后解析矢量的坐标系(world、frame_a、frame_b或frame_resolve)" 
    annotation(Dialog(tab="高级", group="如果get_v_relor=get_a_relorget_z_rel", enable=get_v_rel or get_a_rel or get_z_rel));

  Blocks.Interfaces.RealOutput r_rel[3](each final quantity="Length", each final
            unit="m") if get_r_rel 
    "在resolveInFrame定义的坐标系中解析的相对位置矢量frame_b.r_0-frame_a.r_0" 
    annotation (Placement(transformation(
        origin={-100,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
  Blocks.Interfaces.RealOutput v_rel[3](each final quantity="Velocity", each final
            unit="m/s") if get_v_rel "相对速度矢量" 
    annotation (Placement(transformation(
        origin={-60,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
  Blocks.Interfaces.RealOutput a_rel[3](each final quantity="Acceleration", 
      each final unit="m/s2") if get_a_rel "相对加速度矢量" 
    annotation (Placement(transformation(
        origin={-20,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
  Blocks.Interfaces.RealOutput angles[3](
    each final quantity="Angle", 
    each final unit="rad", 
    each displayUnit="deg") if get_angles 
    "通过'sequence'将frame_a旋转到frame_b的角度" 
    annotation (Placement(transformation(
        origin={20,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
  Blocks.Interfaces.RealOutput w_rel[3](each final quantity="AngularVelocity", 
      each final unit="1/s") if get_w_rel "相对角速度矢量" 
    annotation (Placement(transformation(
        origin={60,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
  Blocks.Interfaces.RealOutput z_rel[3](each final quantity="AngularAcceleration", 
      each final unit="1/s2") if get_z_rel 
    "相对角加速度矢量" 
    annotation (Placement(transformation(
        origin={100,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));

protected
  RelativePosition relativePosition(resolveInFrame=resolveInFrame) if 
                                                get_r_rel or get_v_rel or get_a_rel 
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));

protected
  Blocks.Continuous.Der der1[3] if get_v_rel or get_a_rel annotation (Placement(transformation(
        extent={{-10,-10},{0,0}}, 
        rotation=-90, 
        origin={-55,-30})));
  Blocks.Continuous.Der der2[3] if get_a_rel annotation (Placement(transformation(
        extent={{0,0},{10,10}}, 
        rotation=-90, 
        origin={-25,-40})));
  Modelica.Mechanics.MultiBody.Sensors.RelativeAngles relativeAngles(sequence=sequence, guessAngle1=guessAngle1) if get_angles annotation (Placement(transformation(extent={{20,-25},{40,-5}})));
  RelativeAngularVelocity relativeAngularVelocity(resolveInFrame=resolveInFrame) if get_w_rel or get_z_rel 
    annotation (Placement(transformation(extent={{50,-40},{70,-20}})));

protected
  Blocks.Continuous.Der der3[3] if get_z_rel annotation (Placement(transformation(
        extent={{-10,-10},{0,0}}, 
        rotation=-90, 
        origin={95,-58})));
  Modelica.Mechanics.MultiBody.Forces.Internal.ZeroForceAndTorque zeroForce1 
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Modelica.Mechanics.MultiBody.Forces.Internal.ZeroForceAndTorque zeroForce2 
    annotation (Placement(transformation(extent={{80,40},{60,60}})));
  Modelica.Mechanics.MultiBody.Forces.Internal.ZeroForceAndTorque zeroForce3 if resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve 
    annotation (Placement(transformation(extent={{40,70},{20,90}})));

protected
  Modelica.Mechanics.MultiBody.Sensors.TransformRelativeVector transformVector_v_rel(frame_r_in=resolveInFrame, frame_r_out=resolveInFrameAfterDifferentiation) if get_v_rel annotation (Placement(transformation(extent={{-70,-64},{-50,-44}})));
  Modelica.Mechanics.MultiBody.Sensors.TransformRelativeVector transformVector_a_rel(frame_r_in=resolveInFrame, frame_r_out=resolveInFrameAfterDifferentiation) if get_a_rel annotation (Placement(transformation(extent={{-30,-78},{-10,-58}})));
  Modelica.Mechanics.MultiBody.Sensors.TransformRelativeVector transformVector_z_rel(frame_r_in=resolveInFrame, frame_r_out=resolveInFrameAfterDifferentiation) if get_z_rel annotation (Placement(transformation(extent={{80,-94},{100,-74}})));

protected
  outer Modelica.Mechanics.MultiBody.World world;

  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Arrow arrow(
    r=frame_a.r_0, 
    r_head=frame_b.r_0 - frame_a.r_0, 
    color=arrowColor, 
    specularCoefficient) if world.enableAnimation and animation;
equation
  connect(relativePosition.frame_a, frame_a) annotation (Line(
      points={{-80,0},{-100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(relativePosition.frame_b, frame_b) annotation (Line(
      points={{-60,0},{100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(relativePosition.r_rel, r_rel) annotation (Line(
      points={{-70,-11},{-70,-15},{-80,-15},{-80,-30},{-100,-30},{-100,-110}}, color={0,0,127}));
  connect(zeroForce1.frame_a, frame_a) 
    annotation (Line(
      points={{-80,50},{-90,50},{-90,0},{-100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(zeroForce2.frame_a, frame_b) 
    annotation (Line(
      points={{80,50},{90,50},{90,0},{100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(relativePosition.r_rel, der1.u) annotation (Line(
      points={{-70,-11},{-70,-15},{-60,-15},{-60,-19}}, color={0,0,127}));
  connect(der2.u, der1.y) annotation (Line(
      points={{-20,-39},{-20,-35},{-60,-35},{-60,-30.5}}, color={0,0,127}));
  connect(relativeAngles.frame_a, frame_a) annotation (Line(
      points={{20,-15},{10,-15},{10,-84},{-90,-84},{-90,0},{-100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(relativeAngles.frame_b, frame_b) annotation (Line(
      points={{40,-15},{50,-15},{50,0},{100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(relativeAngles.angles, angles) annotation (Line(
      points={{30,-26},{30,-92},{20,-92},{20,-110}}, 
                                   color={0,0,127}));
  connect(relativeAngularVelocity.frame_b, frame_b) annotation (Line(
      points={{70,-30},{80,-30},{80,0},{100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(relativeAngularVelocity.frame_a, frame_a) annotation (Line(
      points={{50,-30},{10,-30},{10,-84},{-90,-84},{-90,0},{-100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(relativeAngularVelocity.w_rel, w_rel) annotation (Line(
      points={{60,-41},{60,-110}}, color={0,0,127}));
  connect(relativeAngularVelocity.w_rel, der3.u) annotation (Line(
      points={{60,-41},{60,-45},{90,-45},{90,-47}},   color={0,0,127}));
  connect(der1.y, transformVector_v_rel.r_in) 
    annotation (Line(
      points={{-60,-30.5},{-60,-42}}, color={0,0,127}));
  connect(transformVector_v_rel.r_out, v_rel) 
    annotation (Line(
      points={{-60,-65},{-60,-110}}, color={0,0,127}));
  connect(transformVector_v_rel.frame_a, frame_a) 
    annotation (Line(
      points={{-70,-54},{-90,-54},{-90,0},{-100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(transformVector_v_rel.frame_b, frame_b) 
    annotation (Line(
      points={{-50,-54},{-40,-54},{-40,0},{100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(transformVector_v_rel.frame_resolve, frame_resolve) 
    annotation (Line(
      points={{-50,-46},{-46,-46},{-46,-28},{-30,-28},{-30,20},{50,20},{50,80},{100,80}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(frame_resolve, relativePosition.frame_resolve) annotation (Line(
      points={{100,80},{50,80},{50,20},{-30,20},{-30,8.1},{-60,8.1}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(frame_resolve, zeroForce3.frame_a) annotation (Line(
      points={{100,80},{40,80}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(relativeAngularVelocity.frame_resolve, frame_resolve) annotation (
      Line(
      points={{70,-21.9},{70,-21.9},{70,20},{50,20},{50,80},{100,80}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(der2.y, transformVector_a_rel.r_in) annotation (Line(
      points={{-20,-50.5},{-20,-56}}, color={0,0,127}));
  connect(transformVector_a_rel.frame_a, frame_a) annotation (Line(
      points={{-30,-68},{-40,-68},{-40,-84},{-90,-84},{-90,0},{-100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(transformVector_a_rel.frame_b, frame_b) annotation (Line(
      points={{-10,-68},{0,-68},{0,0},{100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(transformVector_a_rel.frame_resolve, frame_resolve) annotation (Line(
      points={{-10,-60},{-10,-28},{-30,-28},{-30,20},{50,20},{50,80},{100,80}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(transformVector_a_rel.r_out, a_rel) annotation (Line(
      points={{-20,-79},{-20,-110}}, color={0,0,127}));
  connect(der3.y, transformVector_z_rel.r_in) annotation (Line(
      points={{90,-58.5},{90,-72}},   color={0,0,127}));
  connect(transformVector_z_rel.r_out, z_rel) annotation (Line(
      points={{90,-95},{90,-100},{100,-100},{100,-110}}, 
                                     color={0,0,127}));
  connect(transformVector_z_rel.frame_a, frame_a) annotation (Line(
      points={{80,-84},{-90,-84},{-90,0},{-100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(transformVector_z_rel.frame_b, frame_b) annotation (Line(
      points={{100,-84},{110,-84},{110,0},{100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(transformVector_z_rel.frame_resolve, frame_resolve) annotation (Line(
      points={{100,-76},{100,-20},{70,-20},{70,20},{50,20},{50,80},{100,80}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, 
          extent={{-100,-100},{100,100}}), graphics={
        Line(
          visible=get_r_rel, 
          points={{-68,-20},{-100,-40},{-100,-100}}, 
          color={0,0,127}), 
        Line(
          visible=get_w_rel, 
          points={{60,-36},{60,-46}}, 
          color={0,0,127}), 
        Line(
          visible=get_w_rel, 
          points={{60,-76},{60,-100}}, 
          color={0,0,127}), 
        Line(
          visible=get_a_rel, 
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
          visible=get_v_rel, 
          points={{-60,-36},{-60,-68}}, 
          color={0,0,127}), 
        Line(
          visible=get_v_rel, 
          points={{-60,-94},{-60,-100}}, 
          color={0,0,127}), 
        Line(
          visible=get_z_rel, 
          points={{68,-20},{100,-40},{100,-68}}, 
          color={0,0,127}), 
        Line(
          visible=get_z_rel, 
          points={{100,-94},{100,-100}}, 
          color={0,0,127}), 
        Text(
          extent={{-132,90},{129,138}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          visible=get_r_rel, 
          extent={{-140,-72},{-100,-92}}, 
          textColor={64,64,64}, 
          textString="m"), 
        Text(
          visible=get_v_rel, 
          extent={{-90,-72},{-40,-92}}, 
          textColor={64,64,64}, 
          textString="m/s"), 
        Text(
          visible=get_a_rel, 
          extent={{-50,-36},{20,-56}}, 
          textColor={64,64,64}, 
          textString="m/s2"), 
        Text(
          visible=get_angles, 
          extent={{-6,-72},{54,-92}}, 
          textColor={64,64,64}, 
          textString="rad"), 
        Text(
          visible=get_w_rel, 
          extent={{34,-50},{104,-70}}, 
          textColor={64,64,64}, 
          textString="rad/s"), 
        Text(
          visible=get_z_rel, 
          extent={{70,-72},{160,-92}}, 
          textColor={64,64,64}, 
          textString="rad/s2")}), 
    Documentation(info="<html>
<p>
frame_a和frame_b之间的相对运动量在条件输出信号连接器处确定并提供。
例如，如果参数\"get_r_rel = <strong>true</strong>\"，则连接器\"r_rel\"被启用，并包含从frame_a到frame_b的相对矢量。
以下量可以作为输出信号提供：</p>

<ol>
<li>相对位置矢量(=r_rel)</li>
<li>相对速度矢量(=v_rel)</li>
<li>相对加速度矢量(=a_rel)</li>
<li>将frame_a旋转到frame_b的三个角度(=angles)</li>
<li>相对角速度矢量(=w_rel)</li>
<li>相对角加速度矢量(=z_rel)</li>
</ol>

<p>
通过参数<strong>resolveInFrame</strong>定义了在哪个坐标系中解析矢量(微分前)：</p>

<table border=\"1\"cellspacing=\"0\"cellpadding=\"2\">
<tr><th><strong>resolveInFrame=<br>Types.ResolveInFrameAB.</strong></th><th><strong>含义</strong></th></tr>
<tr><td>world</td>
<td>在全局坐标系中解析矢量</td></tr>

<tr><td>frame_a</td>
<td>在frame_a中解析矢量</td></tr>

<tr><td>frame_b</td>
<td>在frame_b中解析矢量</td></tr>

<tr><td>frame_resolve</td>
<td>在frame_resolve中解析矢量</td></tr>
</table>

<p>
如果resolveInFrame=Types.ResolveInFrameAB.frame_resolve，则条件连接器“frame_resolve”被启用，并且矢量在连接的坐标系中解析。
注意，如果启用了此连接器，则必须连接。
</p>

<p>
在下图中显示了RelativeSensor组件的动画。
浅蓝色坐标系是frame_a，深蓝色坐标系是frame_b，而黄色箭头是动画传感器。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Sensors/RelativeSensor.png\">
</div>

<p>
注意，相对运动量的导数始终是相对于解析矢量的坐标系执行的。
在微分后，可以通过参数<strong>resolveInFrameAfterD如果ferentiation</strong>(位于“高级”菜单中)将微分后的矢量解析到另一个坐标系中。
</p>

<p>
例如，如果resolveInFrame=<strong>Types.ResolveInFrameAB.frame_b</strong>，那么</p>

<blockquote><pre>
r_rel=resolve2(frame_b.R,frame_b.r_0-frame_a.r0);
v_rel=<strong>der</strong>(r_rel);
</pre></blockquote>

<p>
将返回(r_rel=resolve2(frame_b.R,frame_b.r_0-frame_a.r0))，即，相对于frame_a到frame_b的相对距离的导数，在frame_b中解析。
如果<strong>resolveInFrameAfterD如果ferentiation</strong>=Types.ResolveInFrameAB.world，则v_rel还会额外转换为：</p>

<blockquote><pre>
v_rel=resolve1(frame_b.R,<strong>der</strong>(r_rel))
</pre></blockquote>

<p>
在frame_resolve中，局部力和局部力矩始终为零，无论是否连接frame_resolve。
</p>


<p>
如果<strong>get_angles</strong>=<strong>true</strong>，则返回将frame_a旋转到frame_b的3个角度，这些角度沿着参数<strong>sequence</strong>定义的轴进行旋转。
例如，如果sequence={3,1,2}，那么frame_a首先绕z轴旋转angles[1]角度，然后绕x轴旋转angles[2]角度，最后绕y轴旋转angles[3]角度，此时frame_a与frame_b相同。
这3个角度返回的范围为</p>
<blockquote><pre>
-&pi;&lt;=angles[i]&lt;=&pi;
</pre></blockquote>
<p>
在这个范围内对于\"angles[1]\"有<strong>两个解</strong>。
通过参数<strong>guessAngle1</strong>(默认值为0)，选择返回的解，使得|angles[1]-guessAngle1|最小。
关于frame_a和frame_b之间的相对变换矩阵可能处于相对于\"sequence\"的奇异配置，即，有无穷多个角度值导致相同的相对变换矩阵。
在这种情况下，通过设置angles[1]=guessAngle1来选择返回的解。
然后angles[2]和angles[3]可以在上述范围内唯一确定。
</p>
<p>
参数<strong>sequence</strong>的限制是只能使用值1、2、3，并且sequence[1]&ne;sequence[2]以及sequence[2]&ne;sequence[3]。
经常使用的值包括：</p>
<blockquote><pre>
sequence=<strong>{1,2,3}</strong>//Cardan或Tait-Bryan角序列
=<strong>{3,1,3}</strong>//欧拉角序列
=<strong>{3,2,1}</strong>
</pre></blockquote>

</html>"));
end RelativeSensor;