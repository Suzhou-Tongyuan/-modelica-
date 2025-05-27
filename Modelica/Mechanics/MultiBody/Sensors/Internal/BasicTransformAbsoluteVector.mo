within Modelica.Mechanics.MultiBody.Sensors.Internal;
model BasicTransformAbsoluteVector 
  "将绝对矢量转换为另一个坐标系"
  import Modelica.Mechanics.MultiBody.Frames;
  import Modelica.Mechanics.MultiBody.Types.ResolveInFrameA;

  extends Modelica.Icons.RoundSensor;

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameA frame_r_in= 
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a 
    "解析矢量r_in所在的坐标系(world、frame_a或frame_resolve)";
  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameA frame_r_out= 
    frame_r_in 
    "解析矢量r_out(在另一个坐标系中与r_in相同)所在的坐标系(world、frame_a或frame_resolve)";

  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a 
    "绝对运动量测量的坐标系" 
    annotation (Placement(
        transformation(extent={{-116,-16},{-84,16}})));

  Modelica.Mechanics.MultiBody.Interfaces.Frame_resolve frame_resolve 
    "可选地解析矢量的坐标系" 
    annotation (Placement(transformation(extent={{-16,-16},{16,16}}, 
        origin={100,0})));

  Blocks.Interfaces.RealInput r_in[3] 
    "在frame_r_in定义的坐标系中解析的输入矢量" 
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, 
        rotation=-90, 
        origin={0,120})));
  Blocks.Interfaces.RealOutput r_out[3] 
    "在frame_r_out定义的坐标系中解析的输入矢量r_in" 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, 
        rotation=-90, 
        origin={0,-110})));

protected
  Modelica.Mechanics.MultiBody.Frames.Orientation R1 
    "从全局坐标系到解析矢量r_in所在坐标系的方向对象";
equation
  assert(cardinality(frame_a) > 0, "连接器frame_a必须至少连接一次");
  assert(cardinality(frame_resolve) == 1, "连接器frame_resolve必须恰好连接一次");
  frame_a.f = zeros(3);
  frame_a.t = zeros(3);
  frame_resolve.f = zeros(3);
  frame_resolve.t = zeros(3);

  if frame_r_out == frame_r_in then
    r_out = r_in;
    R1 = Frames.nullRotation();
  else
    if frame_r_in == ResolveInFrameA.world then
      R1 = Frames.nullRotation();
    elseif frame_r_in == ResolveInFrameA.frame_a then
      R1 = frame_a.R;
    elseif frame_r_in == ResolveInFrameA.frame_resolve then
      R1 = frame_resolve.R;
    else
      assert(false, "参数frame_r_in的值错误");
      R1 = Frames.nullRotation();
    end if;

    if frame_r_out == ResolveInFrameA.world then
      r_out = Frames.resolve1(R1, r_in);
    elseif frame_r_out == ResolveInFrameA.frame_a then
      r_out = Frames.resolveRelative(r_in, R1, frame_a.R);
    elseif frame_r_out == ResolveInFrameA.frame_resolve then
      r_out = Frames.resolveRelative(r_in, R1, frame_resolve.R);
    else
      assert(false, "参数frame_r_out的值错误");
      r_out = zeros(3);
    end if;
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100, 
            -100},{100,100}}), graphics={
        Text(
          extent={{-128,-84},{-2,-112}}, 
          textString="r_out"), 
        Text(
          extent={{-108,137},{-22,109}}, 
          textString="r_in"), 
        Line(
          points={{0,100},{0,70}}, 
          color={0,0,127}), 
        Line(
          points={{0,-70},{0,-100}}, 
          color={0,0,127}), 
        Text(
          extent={{58,47},{189,22}}, 
          textColor={95,95,95}, 
          textString="解析"), 
        Text(
          extent={{-116,45},{-80,20}}, 
          textColor={95,95,95}, 
          textString="a"), 
        Line(
          points={{-70,0},{-96,0},{-96,0}}), 
        Line(
          points={{95,0},{95,0},{70,0},{70,0}}, 
          pattern=LinePattern.Dot)}), Documentation(info="<html>
<p>
这个基本传感器将在frame_r_in定义的坐标系中解析的绝对矢量<strong>r_in</strong>转换为由frame_r_out指定的另一个坐标系。
输出矢量在输出信号连接器<strong>r_out</strong>中提供。
</p>

<p>
通过参数<strong>frame_r_in</strong>和<strong>frame_r_out</strong>定义了在哪个坐标系中解析位置矢量：</p>

<table border=\"1\"cellspacing=\"0\"cellpadding=\"2\">
<tr><th><strong>resolveInFrame=<br>Types.ResolveInFrameA.</strong></th><th><strong>含义</strong></th></tr>
<tr><td>world</td>
<td>在全局坐标系中解析矢量</td></tr>

<tr><td>frame_a</td>
<td>在frame_a坐标系中解析矢量</td></tr>

<tr><td>frame_resolve</td>
<td>在frame_resolve坐标系中解析矢量</td></tr>
</table>

<p>
在这个基本传感器模型中，<strong>连接器frame_resolve始终启用，必须连接</strong>。
</p>
</html>"));
end BasicTransformAbsoluteVector;