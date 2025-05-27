within Modelica.Mechanics.MultiBody.Sensors;
model AbsoluteVelocity 
  "测量坐标系连接器原点的绝对速度矢量"
  extends Internal.PartialAbsoluteSensor;

  Blocks.Interfaces.RealOutput v[3](
    each final quantity="Velocity", 
    each final unit="m/s") 
    "在resolveInFrame定义的坐标系中解析的绝对速度矢量" 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        origin={110,0})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_resolve frame_resolve if 
    resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve 
    "可选解析输出矢量v的坐标系" 
    annotation (Placement(transformation(extent={{-16,-16},{16,16}}, 
        rotation=-90, 
        origin={0,-100})));

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameA resolveInFrame= 
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a 
    "输出矢量v应在其中解析的坐标系(world、frame_a或frame_resolve)";

protected
  Internal.BasicAbsolutePosition position(
    resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world) 
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Blocks.Continuous.Der der1[3] annotation (Placement(transformation(
        extent={{-20,-20},{0,0}}, 
        origin={10,10})));
  Modelica.Mechanics.MultiBody.Sensors.TransformAbsoluteVector transformAbsoluteVector(frame_r_in=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world, frame_r_out=resolveInFrame) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=90, 
        origin={50,0})));
  Modelica.Mechanics.MultiBody.Interfaces.ZeroPosition zeroPosition 
    annotation (Placement(transformation(extent={{-60,-60},{-80,-40}})));
  Modelica.Mechanics.MultiBody.Interfaces.ZeroPosition zeroPosition1 if not (
    resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve) 
    annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
equation
  connect(position.r, der1.u) annotation (Line(
      points={{-39,0},{-12,0}}, color={0,0,127}));
  connect(position.frame_a, frame_a) annotation (Line(
      points={{-60,0},{-80,0},{-80,0},{-100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(der1.y, transformAbsoluteVector.r_in) annotation (Line(
      points={{11,0},{38,0}}, color={0,0,127}));
  connect(transformAbsoluteVector.r_out, v) annotation (Line(
      points={{61,0},{110,0}}, color={0,0,127}));
  connect(zeroPosition.frame_resolve, position.frame_resolve) annotation (Line(
      points={{-60,-50},{-50,-50},{-50,-10}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(transformAbsoluteVector.frame_a, frame_a) annotation (Line(
      points={{50,10},{50,20},{-70,20},{-70,0},{-100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(transformAbsoluteVector.frame_resolve, zeroPosition1.frame_resolve) 
    annotation (Line(
      points={{49.9,-10},{50,-10},{50,-50},{60,-50}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(transformAbsoluteVector.frame_resolve, frame_resolve) annotation (Line(
      points={{49.9,-10},{50,-10},{50,-50},{0,-50},{0,-100}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  annotation (Icon(coordinateSystem(
          preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Line(
          points={{70,0},{100,0}}, 
          color={0,0,127}), 
        Line(
          points={{0,-70},{0,-95}}, 
          color={95,95,95}, 
          pattern=LinePattern.Dot), 
        Text(
          extent={{-130,72},{131,120}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-50,-14},{50,-54}}, 
          textColor={64,64,64}, 
          textString="m/s"), 
        Text(
          extent={{0,-67},{130,-92}}, 
          textColor={95,95,95}, 
          textString="resolve")}), 
    Documentation(info="<html>
<p>
坐标系frame_a原点的绝对速度矢量在输出信号连接器<strong>v</strong>处确定并提供。
</p>

<p>
通过参数<strong>resolveInFrame</strong>定义了速度矢量在哪个坐标系中解析：</p>

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
如果resolveInFrame=Types.ResolveInFrameA.frame_resolve，则条件连接器“frame_resolve”被启用，并且v在连接到frame_resolve的坐标系中解析。
请注意，如果启用此连接器，则必须连接它。
</p>

<h4>示例</h4>
<p>
如果resolveInFrame=Types.ResolveInFrameA.frame_a，则输出矢量计算如下：</p>

<blockquote><pre>
v0=der(frame_a.r_0);
v=MultiBody.Frames.resolve2(frame_a.R,v0);
</pre></blockquote>

</html>"));
end AbsoluteVelocity;