within Modelica.Mechanics.MultiBody.Sensors;
model AbsoluteAngularVelocity 
  "测量坐标系连接器的绝对角速度"
  extends Internal.PartialAbsoluteSensor;

  Blocks.Interfaces.RealOutput w[3](
    each final quantity="AngularVelocity", 
    each final unit="rad/s") 
    "相对于全局坐标系，以resolveInFrame定义的坐标系解析的frame_a的绝对角速度矢量" 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        origin={110,0})));

  Modelica.Mechanics.MultiBody.Interfaces.Frame_resolve frame_resolve if resolveInFrame == 
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve 
    "可选地将w解析到的坐标系" 
    annotation (Placement(transformation(extent={{-16,-16},{16,16}}, 
        rotation=-90, 
        origin={0,-100})));

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameA resolveInFrame= 
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a 
    "w输出矢量应解析到的坐标系(世界，frame_a或frame_resolve)";

protected
  Internal.BasicAbsoluteAngularVelocity angularVelocity(
    resolveInFrame=resolveInFrame) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.MultiBody.Interfaces.ZeroPosition zeroPosition if 
    not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve) 
    annotation (Placement(transformation(extent={{40,-40},{60,-20}})));

equation
  connect(angularVelocity.frame_resolve, frame_resolve) annotation (Line(
      points={{0,-10},{0,-100}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(zeroPosition.frame_resolve, angularVelocity.frame_resolve) 
    annotation (Line(
      points={{40,-30},{0,-30},{0,-10}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(angularVelocity.w, w) annotation (Line(
      points={{11,0},{110,0}}, color={0,0,127}));
  connect(angularVelocity.frame_a, frame_a) annotation (Line(
      points={{-10,0},{-100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  annotation (Icon(coordinateSystem(
          preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Line(
          points={{70,0},{100,0}}, 
          color={0,0,127}), 
        Line(
          points={{0,-70},{0,-96}}, 
          color={95,95,95}, 
          pattern=LinePattern.Dot), 
        Text(
          extent={{-127,77},{134,125}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-50,-14},{50,-54}}, 
          textColor={64,64,64}, 
          textString="rad/s"), 
        Text(
          extent={{0,-67},{130,-92}}, 
          textColor={95,95,95}, 
          textString="resolve")}), 
    Documentation(info="<html>
<p>
相对于全局坐标系，坐标系frame_a的绝对角速度在输出信号连接器<strong>w</strong>处确定并提供。
</p>

<p>
通过参数<strong>resolveInFrame</strong>定义了角速度在哪个坐标系中解析：</p>

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
如果resolveInFrame=Types.ResolveInFrameA.frame_resolve，则条件连接器\"frame_resolve\"被启用，并且w在frame_resolve连接的坐标系中解析。
注意，如果启用此连接器，则必须连接它。
</p>

<h4>示例</h4>
<p>
如果resolveInFrame=Types.ResolveInFrameA.frame_a，则输出矢量计算为：</p>

<blockquote><pre>
w=MultiBody.Frames.angularVelocity2(frame_a.R);
</pre></blockquote>

</html>"));
end AbsoluteAngularVelocity;