within Modelica.Mechanics.MultiBody.Sensors;
model RelativeAngularVelocity 
  "测量两个连接器之间的相对角速度"
  extends Internal.PartialRelativeSensor;

  Blocks.Interfaces.RealOutput w_rel[3](
    each final quantity="AngularVelocity", 
    each final unit = "rad/s") 
    "frame_a和frame_b之间相对角速度矢量，解析在由resolveInFrame定义的坐标系中" 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=-90, 
        origin={0,-110})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_resolve frame_resolve if resolveInFrame == 
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve 
    "可选地解析w_rel的坐标系" 
    annotation (Placement(transformation(extent={{84,64},{116,96}})));

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB resolveInFrame= 
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a 
    "w_rel输出矢量应该解析在哪个坐标系中(world,frame_a,frame_b,或frame_resolve)";

protected
  Internal.BasicRelativeAngularVelocity relativeAngularVelocity(
    resolveInFrame=resolveInFrame) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.MultiBody.Interfaces.ZeroPosition zeroPosition if 
    not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve) 
    annotation (Placement(transformation(extent={{52,20},{72,40}})));

equation
  connect(relativeAngularVelocity.frame_a, frame_a) annotation (Line(
      points={{-10,0},{-100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(relativeAngularVelocity.frame_b, frame_b) annotation (Line(
      points={{10,0},{100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(relativeAngularVelocity.frame_resolve, frame_resolve) annotation (Line(
      points={{10,8},{30,8},{30,80},{100,80}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(zeroPosition.frame_resolve, relativeAngularVelocity.frame_resolve) annotation (Line(
      points={{52,30},{30,30},{30,8},{10,8}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(relativeAngularVelocity.w_rel, w_rel) annotation (Line(
      points={{0,-11},{0,-110}}, color={0,0,127}));

  annotation (Icon(coordinateSystem(
          preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Line(
          points={{0,-70},{0,-100}}, 
          color={0,0,127}), 
        Text(
          extent={{-127,95},{134,143}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-50,-14},{50,-54}}, 
          textColor={64,64,64}, 
          textString="rad/s")}), 
    Documentation(info="<html>
<p>
frame_a和frame_b之间的相对角速度通过输出信号连接器<strong>w_rel</strong>确定并提供。
</p>

<p>
通过参数<strong>resolveInFrame</strong>定义了角速度解析在哪个坐标系中：</p>

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
在这个基本传感器模型中，<strong>连接器frame_resolve总是被启用</strong>。
如果resolveInFrame=Types.ResolveInFrameAB.frame_resolve，则矢量w_rel被解析到与frame_resolve连接的坐标系中。
</p>

<h4>例子</h4>
<p>
如果resolveInFrame=Types.ResolveInFrameAB.frame_a，则输出矢量计算为：</p>

<blockquote><pre>
// Relative orientation object from frame_a to frame_b
R_rel = MultiBody.Frames.relativeRotation(frame_a.R, frame_b.R);

// Angular velocity resolved in frame_a
w_rel = MultiBody.Frames.angularVelocity1(R_rel);
</pre></blockquote>

</html>"));
end RelativeAngularVelocity;