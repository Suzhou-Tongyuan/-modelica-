within Modelica.Mechanics.MultiBody.Sensors.Internal;
model BasicAbsolutePosition 
  "用于测量绝对位置矢量的基本传感器"
  import Modelica.Mechanics.MultiBody.Types.ResolveInFrameA;
  extends Modelica.Mechanics.MultiBody.Sensors.Internal.PartialAbsoluteBaseSensor;
  Modelica.Blocks.Interfaces.RealOutput r[3](
    each final quantity="Length", each final unit = "m") 
    "在由resolveInFrame定义的坐标系中解析的绝对位置矢量frame_a.r_0" 
    annotation (Placement(transformation(
        origin={110,0}, 
        extent={{-10,-10},{10,10}})));

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameA resolveInFrame= 
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a 
    "解析输出矢量r所在的坐标系(world、frame_a或frame_resolve)";

equation
  if resolveInFrame == ResolveInFrameA.world then
    r = frame_a.r_0;
  elseif resolveInFrame == ResolveInFrameA.frame_a then
    r = Frames.resolve2(frame_a.R, frame_a.r_0);
  elseif resolveInFrame == ResolveInFrameA.frame_resolve then
    r = Frames.resolve2(frame_resolve.R, frame_a.r_0);
  else
    assert(false, "参数resolveInFrame的值错误");
    r = zeros(3);
  end if;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
            -100},{100,100}}), 
      graphics={
        Text(
          extent={{-127,75},{134,123}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-50,-14},{50,-54}}, 
          textColor={64,64,64}, 
          textString="m")}), 
    Documentation(info="<html>
<p>
这个基本传感器旨在在高级传感器中使用，应确定frame_a原点的绝对位置矢量。
该矢量在输出信号连接器<strong>r</strong>中提供。
</p>

<p>
通过参数<strong>resolveInFrame</strong>定义了在哪个坐标系中解析位置矢量：</p>

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
如果resolveInFrame=Types.ResolveInFrameA.frame_resolve，则矢量&nbsp;r解析到连接到frame_resolve的坐标系中。
</p>

<h4>示例</h4>
<p>
如果resolveInFrame=Types.ResolveInFrameA.frame_a，则输出矢量计算为：</p>

<blockquote><pre>
r=MultiBody.Frames.resolve2(frame_a.R,frame_b.r_0);
</pre></blockquote>
</html>"));
end BasicAbsolutePosition;