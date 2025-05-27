within Modelica.Mechanics.MultiBody.Sensors;
model RelativeVelocity 
  "测量两个坐标系连接器原点之间的相对速度矢量"
  extends Internal.PartialRelativeSensor;

  Modelica.Blocks.Interfaces.RealOutput v_rel[3](each final quantity="Velocity", each final
            unit = "m/s") 
    "相对速度矢量在resolveInFrame定义的坐标系中解析" 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=-90, 
        origin={0,-110})));

  Modelica.Mechanics.MultiBody.Interfaces.Frame_resolve frame_resolve if resolveInFrame == 
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve 
    "可选解析v_rel的坐标系" 
    annotation (Placement(transformation(extent={{84,64},{116,96}})));

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB 
    resolveInFrame= 
  Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a 
    "输出矢量v_rel应解析在的坐标系(全局坐标系，frame_a，frame_b或frame_resolve)";

protected
  RelativePosition relativePosition(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.MultiBody.Interfaces.ZeroPosition zeroPosition if 
    not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve) 
    annotation (Placement(transformation(extent={{50,-60},{70,-40}})));
  Modelica.Blocks.Continuous.Der der_r_rel[3] annotation (Placement(transformation(
        extent={{-20,-20},{0,0}}, 
        rotation=-90, 
        origin={10,-40})));
  Modelica.Mechanics.MultiBody.Sensors.TransformRelativeVector transformRelativeVector(frame_r_in=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a, frame_r_out=resolveInFrame) annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
equation
  connect(relativePosition.frame_a, frame_a) annotation (Line(
      points={{-10,0},{-100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(relativePosition.frame_b, frame_b) annotation (Line(
      points={{10,0},{100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(relativePosition.r_rel, der_r_rel.u) annotation (Line(
      points={{0,-11},{0,-18}}, color={0,0,127}));
  connect(der_r_rel.y, transformRelativeVector.r_in) annotation (Line(
      points={{0,-41},{0,-58}}, color={0,0,127}));
  connect(transformRelativeVector.r_out, v_rel) annotation (Line(
      points={{0,-81},{0,-110}}, color={0,0,127}));
  connect(transformRelativeVector.frame_a, frame_a) annotation (Line(
      points={{-10,-70},{-70,-70},{-70,0},{-100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(transformRelativeVector.frame_b, frame_b) annotation (Line(
      points={{10,-70},{80,-70},{80,0},{100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(transformRelativeVector.frame_resolve, frame_resolve) annotation (Line(
      points={{10,-62},{30,-62},{30,80},{100,80}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(zeroPosition.frame_resolve, transformRelativeVector.frame_resolve) 
    annotation (Line(
      points={{50,-50},{30,-50},{30,-62},{10,-62}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  annotation (Icon(coordinateSystem(
          preserveAspectRatio=true,  extent={{-100,-100},{100,100}}), graphics={
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
          textString="m/s")}), 
    Documentation(info="<html>
<p>
在frame_a的原点和frame_b的原点之间的相对速度矢量被确定并提供在输出信号连接器<strong>v_rel</strong>上。
该矢量定义为：</p>

<blockquote><pre>
r_rel=MultiBody.Frames.resolve2(frame_a.R,frame_b.r_0-frame_a.r_0);
v_rel=<strong>der</strong>(r_rel);
</pre></blockquote>

<p>
通过参数<strong>resolveInFrame</strong>定义了速度矢量在哪个坐标系中解析：</p>

<table border=\"1\"cellspacing=\"0\"cellpadding=\"2\">
<tr><th><strong>resolveInFrame=<br>Types.ResolveInFrameAB.</strong></th><th><strong>意义</strong></th></tr>
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
如果resolveInFrame=Types.ResolveInFrameAB.frame_resolve，则条件连接器“frame_resolve”被启用，并且v_rel被解析在frame_resolve连接的坐标系中。
注意，如果启用了此连接器，则必须连接它。
</p>

<h4>示例</h4>
<p>
如果resolveInFrame=Types.ResolveInFrameAB.frame_b，则输出矢量计算为：</p>

<blockquote><pre>
r_rel=MultiBody.Frames.resolve2(frame_a.R,frame_b.r_0-frame_a.r_0);
v_rel_a=<strong>der</strong>(r_rel);
v_rel=MultiBody.Frames.resolveRelative(frame_a.R,frame_b.R,v_rel_a);
</pre></blockquote>

</html>"));
end RelativeVelocity;