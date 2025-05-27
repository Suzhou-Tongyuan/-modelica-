within Modelica.Mechanics.MultiBody.Sensors;
model RelativePosition 
  "测量两个坐标系连接器原点之间的相对位置矢量"
  extends Internal.PartialRelativeSensor;

  Blocks.Interfaces.RealOutput r_rel[3] 
    "相对位置矢量在resolveInFrame定义的坐标系中解析" 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=-90, 
        origin={0,-110})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_resolve frame_resolve if resolveInFrame == 
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve 
    "可选地解析r_rel的坐标系" 
    annotation (Placement(transformation(extent={{84,64},{116,96}})));

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB resolveInFrame= 
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a 
    "输出矢量r_rel应在其中解析的坐标系(world、frame_a、frame_b或frame_resolve)";

protected
  Internal.BasicRelativePosition relativePosition(resolveInFrame=resolveInFrame) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  Modelica.Mechanics.MultiBody.Interfaces.ZeroPosition zeroPosition if 
    not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve) 
    annotation (Placement(transformation(extent={{52,20},{72,40}})));

equation
  connect(relativePosition.frame_a, frame_a) annotation (Line(
      points={{-10,0},{-100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(relativePosition.frame_b, frame_b) annotation (Line(
      points={{10,0},{100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(relativePosition.frame_resolve, frame_resolve) annotation (Line(
      points={{10,8},{20,8},{20,8},{30,8},{30,80},{100,80}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(zeroPosition.frame_resolve, relativePosition.frame_resolve) 
    annotation (Line(
      points={{52,30},{30,30},{30,8},{10,8}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(relativePosition.r_rel, r_rel) annotation (Line(
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
          textString="m")}), 
    Documentation(info="<html>
<p>
坐标系frame_a和frame_b原点之间的相对位置矢量在输出信号连接器<strong>r_rel</strong>处确定并提供。
</p>

<p>
通过参数<strong>resolveInFrame</strong>定义了位置矢量在哪个坐标系中解析：</p>

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
如果resolveInFrame=Types.ResolveInFrameAB.frame_resolve，则条件连接器\"frame_resolve\"被启用，并且r_rel在与frame_resolve连接的坐标系中解析。
注意，如果启用此连接器，则必须连接它。
</p>

<h4>示例</h4>
<p>
如果resolveInFrame=Types.ResolveInFrameAB.frame_a，则输出矢量计算为：</p>

<blockquote><pre>
r_rel=MultiBody.Frames.resolve2(frame_a.R,frame_b.r_0-frame_a.r_0);
</pre></blockquote>
</html>"));
end RelativePosition;