within Modelica.Mechanics.MultiBody.Sensors.Internal;
model BasicCutTorque 
  "基本传感器，用于测量局部力矢量(frame_resolve必须连接)"
  import Modelica.Mechanics.MultiBody.Types.ResolveInFrameA;
  import Modelica.Mechanics.MultiBody.Frames;

  extends Modelica.Mechanics.MultiBody.Sensors.Internal.PartialCutForceBaseSensor;
  Modelica.Blocks.Interfaces.RealOutput torque[3](each final quantity="Torque", each final unit= 
        "N.m") "在resolveInFrame坐标系中解析的局部力矢量" 
       annotation (Placement(transformation(
        origin={-80,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));

  parameter Boolean positiveSign=true 
    "=true，如果返回具有正号的扭矩(=frame_a.t)，否则返回具有负号的扭矩(=frame_b.t)";

protected
  parameter Integer csign=if positiveSign then +1 else -1;
equation
   if resolveInFrame == ResolveInFrameA.world then
      torque = Frames.resolve1(frame_a.R, frame_a.t)*csign;
   elseif resolveInFrame == ResolveInFrameA.frame_a then
      torque = frame_a.t*csign;
   elseif resolveInFrame == ResolveInFrameA.frame_resolve then
      torque = Frames.resolveRelative(frame_a.t, frame_a.R, frame_resolve.R)*csign;
   else
      assert(false,"参数resolveInFrame的值错误");
      torque = zeros(3);
   end if;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), 
      graphics={
        Line(points={{-80,-100},{-80,0}}, color={0,0,127}), 
        Text(
          extent={{-50,-14},{50,-54}}, 
          textColor={64,64,64}, 
          textString="N.m")}), 
    Documentation(info="<html>
<p>
这是一个基本传感器，旨在用于高级传感器中，以确定两个坐标系之间作用的局部扭矩。
此局部扭矩在输出信号连接器<strong>torque</strong>中提供(=frame_a.f)。
如果参数<strong>positiveSign</strong>=<strong>false</strong>，则提供负局部扭矩(=frame_b.f)。
</p>
<p>
通过参数<strong>resolveInFrame</strong>定义了在哪个坐标系中解析扭矩矢量：</p>

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
如果resolveInFrame=Types.ResolveInFrameA.frame_resolve，则矢量torque将在连接到frame_resolve的坐标系中解析。
</p>

<p>
在下图中，显示了CutTorque传感器的动画。
深蓝色坐标系是frame_b，绿色箭头是作用在frame_b上的局部扭矩，在frame_a上带有负号。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Sensors/CutTorque.png\">
</div>
</html>"));
end BasicCutTorque;