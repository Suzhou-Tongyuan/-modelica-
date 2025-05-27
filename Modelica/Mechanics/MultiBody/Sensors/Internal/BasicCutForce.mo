within Modelica.Mechanics.MultiBody.Sensors.Internal;
model BasicCutForce 
  "基本传感器，用于测量局部力矢量(frame_resolve必须连接)"
  import Modelica.Mechanics.MultiBody.Types.ResolveInFrameA;
  import Modelica.Mechanics.MultiBody.Frames;
  extends Modelica.Mechanics.MultiBody.Sensors.Internal.PartialCutForceBaseSensor;

  Modelica.Blocks.Interfaces.RealOutput force[3](each final quantity="Force", each final unit="N") 
    "在resolveInFrame坐标系中解析的局部力" 
       annotation (Placement(transformation(
        origin={-80,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
  parameter Boolean positiveSign=true 
    "=true，如果返回具有正号的力(=frame_a.f)，否则返回具有负号的力(=frame_b.f)";
protected
  parameter Integer csign=if positiveSign then +1 else -1;
equation
  if resolveInFrame == ResolveInFrameA.world then
    force = Frames.resolve1(frame_a.R, frame_a.f)*csign;
  elseif resolveInFrame == ResolveInFrameA.frame_a then
    force = frame_a.f*csign;
  elseif resolveInFrame == ResolveInFrameA.frame_resolve then
    force = Frames.resolveRelative(frame_a.f, frame_a.R, frame_resolve.R)*csign;
  else
    assert(false,"参数resolveInFrame的值错误");
    force = zeros(3);
  end if;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), 
      graphics={
        Line(points={{-80,-100},{-80,0}}, color={0,0,127}), 
        Text(
          extent={{-50,-14},{50,-54}}, 
          textColor={64,64,64}, 
          textString="N")}), 
    Documentation(info="<html>
<p>
这是一个基本传感器，旨在用于高级传感器中，以确定两个坐标系之间作用的局部力。
此局部力在输出信号连接器<strong>force</strong>中提供(=frame_a.f)。
如果参数<strong>positiveSign</strong>=<strong>false</strong>，则提供负局部力(=frame_b.f)。
</p>
<p>
通过参数<strong>resolveInFrame</strong>定义了在哪个坐标系中解析力矢量：</p>

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
在此基本传感器模型中，<strong>连接器frame_resolve始终启用且必须连接</strong>。
如果resolveInFrame=Types.ResolveInFrameA.frame_resolve，则矢量force将在连接到frame_resolve的坐标系中解析。
</p>

<p>
在下图中，显示了CutForce传感器的动画。
深蓝色坐标系是frame_b，绿色箭头是作用在frame_b上的局部力，在frame_a上带有负号。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Sensors/CutForce.png\">
</div>
</html>"));
end BasicCutForce;