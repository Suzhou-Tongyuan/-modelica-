within Modelica.Mechanics.MultiBody.Sensors.Internal;
model BasicTransformRelativeVector 
  "将相对矢量转换为另一个坐标系"
  import Modelica.Mechanics.MultiBody.Frames;
  import Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB;
  extends Modelica.Mechanics.MultiBody.Sensors.Internal.PartialRelativeBaseSensor;
  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB frame_r_in= 
  Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a 
    "解析矢量r_in所在的坐标系(world、frame_a、frame_b或frame_resolve)";
  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB frame_r_out= 
    frame_r_in 
    "解析矢量r_out(在另一个坐标系中与r_in相同)所在的坐标系(world、frame_a、frame_b或frame_resolve)";

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
   if frame_r_out == frame_r_in then
      r_out = r_in;
      R1 = Frames.nullRotation();
   else
      if frame_r_in == ResolveInFrameAB.world then
         R1 = Frames.nullRotation();
      elseif frame_r_in == ResolveInFrameAB.frame_a then
         R1 = frame_a.R;
      elseif frame_r_in == ResolveInFrameAB.frame_b then
         R1 = frame_b.R;
      else
         R1 = frame_resolve.R;
      end if;

      if frame_r_out == ResolveInFrameAB.world then
         r_out = Frames.resolve1(R1, r_in);
      elseif frame_r_out == ResolveInFrameAB.frame_a then
         r_out = Frames.resolveRelative(r_in, R1, frame_a.R);
      elseif frame_r_out == ResolveInFrameAB.frame_b then
         r_out = Frames.resolveRelative(r_in, R1, frame_b.R);
      else
         r_out = Frames.resolveRelative(r_in, R1, frame_resolve.R);
      end if;
   end if;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100, 
            -100},{100,100}}), graphics={
        Text(
          extent={{-128,-92},{-2,-120}}, 
          textString="r_out"), 
        Text(
          extent={{-108,144},{-22,116}}, 
          textString="r_in"), 
        Line(
          points={{0,100},{0,70}}, 
          color={0,0,127})}), Documentation(info="<html>
<p>
这个基本传感器将在frame_r_in定义的坐标系中解析的相对矢量<strong>r_in</strong>转换为由frame_r_out指定的另一个坐标系。
输出矢量在输出信号连接器<strong>r_out</strong>中提供。
</p>

<p>
通过参数<strong>frame_r_in</strong>和<strong>frame_r_out</strong>定义了在哪个坐标系中解析位置矢量：</p>

<table border=\"1\"cellspacing=\"0\"cellpadding=\"2\">
<tr><th><strong>resolveInFrame=<br>Types.ResolveInFrameAB.</strong></th><th><strong>含义</strong></th></tr>
<tr><td>world</td>
<td>在全局坐标系中解析矢量</td></tr>

<tr><td>frame_a</td>
<td>在frame_a坐标系中解析矢量</td></tr>

<tr><td>frame_b</td>
<td>在frame_b坐标系中解析矢量</td></tr>

<tr><td>frame_resolve</td>
<td>在frame_resolve坐标系中解析矢量</td></tr>
</table>

<p>
在这个基本传感器模型中，<strong>连接器frame_resolve始终启用，必须连接</strong>。
</p>
</html>"));
end BasicTransformRelativeVector;