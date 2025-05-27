within Modelica.Mechanics.MultiBody.Sensors;
model AbsolutePosition 
  "测量坐标系连接器原点的绝对位置矢量"
  extends Internal.PartialAbsoluteSensor;

  Blocks.Interfaces.RealOutput r[3](
    each final quantity="Length", 
    each final unit="m") 
    "在由resolveInFrame定义的坐标系中解析的绝对位置矢量" 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        origin={110,0})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_resolve frame_resolve if 
    resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve 
    "可选择解析输出矢量r的坐标系" 
    annotation (Placement(transformation(extent={{-16,-16},{16,16}}, 
        rotation=-90, 
        origin={0,-100})));

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameA resolveInFrame= 
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a 
    "将输出矢量r解析到的坐标系(world、frame_a或frame_resolve)";

protected
  Internal.BasicAbsolutePosition position(resolveInFrame=resolveInFrame) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  Modelica.Mechanics.MultiBody.Interfaces.ZeroPosition zeroPosition if 
    not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve) 
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));

equation
  connect(position.frame_resolve, frame_resolve) annotation (Line(
      points={{0,-10},{0,-100}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(zeroPosition.frame_resolve, position.frame_resolve) 
    annotation (Line(
      points={{20,-30},{0,-30},{0,-10}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(position.r, r) annotation (Line(
      points={{11,0},{110,0}}, color={0,0,127}));
  connect(position.frame_a, frame_a) annotation (Line(
      points={{-10,0},{-100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  annotation (Icon(coordinateSystem(
          preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Line(
          points={{70,0},{100,0}}, 
          color={0,0,127}), 
        Line(
          points={{0,-96},{0,-96},{0,-70},{0,-70}}, 
          pattern=LinePattern.Dot), 
        Text(
          extent={{-127,95},{134,143}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-50,-14},{50,-54}}, 
          textColor={64,64,64}, 
          textString="m"), 
        Text(
          extent={{0,-67},{130,-92}}, 
          textColor={95,95,95}, 
          textString="resolve")}), 
    Documentation(info="<html>
<p>
坐标系frame_a原点的绝对位置矢量在输出信号连接器<strong>r</strong>上被确定和提供。
</p>

<p>
通过参数<strong>resolveInFrame</strong>定义了位置矢量在哪个坐标系中解析：</p>

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
如果resolveInFrame=Types.ResolveInFrameA.frame_resolve，则条件连接器“frame_resolve”被启用，并且r在frame_resolve所连接的坐标系中解析。
请注意，如果启用此连接器，则必须连接它。
</p>

<h4>示例</h4>
<p>
如果resolveInFrame=Types.ResolveInFrameA.frame_a，则输出矢量计算如下：</p>

<blockquote><pre>
r=MultiBody.Frames.resolve2(frame_a.R,frame_b.r_0);
</pre></blockquote>

</html>"));
end AbsolutePosition;