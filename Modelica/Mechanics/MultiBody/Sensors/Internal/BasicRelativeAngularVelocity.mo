within Modelica.Mechanics.MultiBody.Sensors.Internal;
model BasicRelativeAngularVelocity "用于测量相对角速度的基本传感器"
  import Modelica.Mechanics.MultiBody.Frames;
  import Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB;

  extends Modelica.Mechanics.MultiBody.Sensors.Internal.PartialRelativeBaseSensor;
  Modelica.Blocks.Interfaces.RealOutput w_rel[3](each final quantity="AngularVelocity",each final unit = "rad/s") 
    "相对角速度矢量" 
    annotation (Placement(transformation(
        origin={0,-110}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB 
    resolveInFrame= 
  Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a 
    "解析输出矢量w_rel所在的坐标系(world、frame_a、frame_b或frame_resolve)";

protected
  Modelica.Mechanics.MultiBody.Frames.Orientation R_rel 
    "从frame_a到frame_b的相对方向对象";
equation
   R_rel = Frames.relativeRotation(frame_a.R, frame_b.R);
   if resolveInFrame == ResolveInFrameAB.frame_a then
      w_rel = Frames.angularVelocity1(R_rel);
   elseif resolveInFrame == ResolveInFrameAB.frame_b then
      w_rel = Frames.angularVelocity2(R_rel);
   elseif resolveInFrame == ResolveInFrameAB.world then
      w_rel = Frames.resolve1(frame_a.R, Frames.angularVelocity1(R_rel));
   elseif resolveInFrame == ResolveInFrameAB.frame_resolve then
      w_rel = Frames.resolveRelative(Frames.angularVelocity1(R_rel), frame_a.R, frame_resolve.R);
   else
      assert(false, "参数resolveInFrame的值错误");
      w_rel = zeros(3);
   end if;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), 
      graphics={
        Text(
          extent={{-132,90},{129,138}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-50,-14},{50,-54}}, 
          textColor={64,64,64}, 
          textString="rad/s")}), 
    Documentation(info="<html>
<p>
这个基本传感器旨在在高级传感器中使用，应确定frame_a和frame_b之间的相对角速度。
该矢量在输出信号连接器&nbsp;<strong>w_rel</strong>中提供。
</p>

<p>
通过参数<strong>resolveInFrame</strong>定义了在哪个坐标系中解析角速度：</p>

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
如果resolveInFrame=Types.ResolveInFrameAB.frame_resolve，则矢量&nbsp;w_rel解析到连接到frame_resolve的坐标系中。
</p>

<h4>示例</h4>
<p>
如果resolveInFrame=Types.ResolveInFrameAB.frame_a，则输出矢量计算为：</p>

<blockquote><pre>
//从frame_a到frame_b的相对方向对象
R_rel=MultiBody.Frames.relativeRotation(frame_a.R,frame_b.R);

//在frame_a中解析的角速度
w_rel=MultiBody.Frames.angularVelocity1(R_rel);
</pre></blockquote>
</html>"));
end BasicRelativeAngularVelocity;