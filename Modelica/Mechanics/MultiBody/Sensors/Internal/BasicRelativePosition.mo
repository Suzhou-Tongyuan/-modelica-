within Modelica.Mechanics.MultiBody.Sensors.Internal;
model BasicRelativePosition 
  "用于测量相对位置矢量的基本传感器"
  import Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB;
  extends Modelica.Mechanics.MultiBody.Sensors.Internal.PartialRelativeBaseSensor;
  Modelica.Blocks.Interfaces.RealOutput r_rel[3](each final quantity="Length", each final
            unit = "m") 
    "在由resolveInFrame定义的坐标系中解析的相对位置矢量frame_b.r_0-frame_a.r_0" 
    annotation (Placement(transformation(
        origin={0,-110}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB 
    resolveInFrame= 
  Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a 
    "解析输出矢量r_rel所在的坐标系(world、frame_a、frame_b或frame_resolve)";

equation
   if resolveInFrame == ResolveInFrameAB.frame_a then
      r_rel = Frames.resolve2(frame_a.R, frame_b.r_0 - frame_a.r_0);
   elseif resolveInFrame == ResolveInFrameAB.frame_b then
      r_rel = Frames.resolve2(frame_b.R, frame_b.r_0 - frame_a.r_0);
   elseif resolveInFrame == ResolveInFrameAB.world then
      r_rel = frame_b.r_0 - frame_a.r_0;
   elseif resolveInFrame == ResolveInFrameAB.frame_resolve then
      r_rel = Frames.resolve2(frame_resolve.R, frame_b.r_0 - frame_a.r_0);
   else
      assert(false, "参数resolveInFrame的值错误");
      r_rel = zeros(3);
   end if;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), 
      graphics={
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
这个基本传感器旨在在高级传感器中使用，应确定frame_a和frame_b原点之间的相对位置矢量。
该矢量在输出信号连接器&nbsp;<strong>r_rel</strong>中提供。
</p>

<p>
通过参数<strong>resolveInFrame</strong>定义了在哪个坐标系中解析位置矢量：</p>

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
如果resolveInFrame=Types.ResolveInFrameAB.frame_resolve，则矢量&nbsp;r_rel解析到连接到frame_resolve的坐标系中。
</p>

<h4>示例</h4>
<p>
如果resolveInFrame=Types.ResolveInFrameAB.frame_a，则输出矢量计算为：</p>

<blockquote><pre>
r_rel=MultiBody.Frames.resolve2(frame_a.R,frame_b.r_0-frame_a.r_0);
</pre></blockquote>
</html>"));
end BasicRelativePosition;