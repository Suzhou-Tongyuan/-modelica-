within Modelica.Mechanics.MultiBody.Forces.Internal;
model BasicForce 
  "在两个坐标系之间作用的力，由3个输入信号定义"
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
  import Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB;
  Interfaces.Frame_resolve frame_resolve 
    "可以在此坐标系中选择性地解析输入信号" 
    annotation (Placement(transformation(
        origin={40,100}, 
        extent={{-16,-16},{16,16}}, 
        rotation=90)));
  Modelica.Blocks.Interfaces.RealInput force[3](each final quantity="Force", each final unit="N") 
    "力在由 resolveInFrame 定义的坐标系中解析的 x、y、z 坐标" 
    annotation (Placement(transformation(
        origin={-60,120}, 
        extent={{-20,-20},{20,20}}, 
        rotation=270)));
  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB 
    resolveInFrame= 
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_b 
    "力解析的坐标系 (1: 全局坐标系, 2: frame_a, 3: frame_b, 4: frame_resolve)";

  SI.Position r_0[3] 
    "从 frame_a 原点到 frame_b 原点的位置矢量，解析在全局坐标系中";
  SI.Force f_b_0[3] "frame_b.f 在全局坐标系中解析的力";

equation
  assert(cardinality(frame_resolve) > 0, "连接器 frame_resolve 必须至少连接一次且 frame_resolve.r_0/.R 必须设置");
  frame_resolve.f = zeros(3);
  frame_resolve.t = zeros(3);

if resolveInFrame == ResolveInFrameAB.frame_a then
  f_b_0     = -Frames.resolve1(frame_a.R, force);
  frame_b.f =  Frames.resolve2(frame_b.R, f_b_0);
elseif resolveInFrame == ResolveInFrameAB.frame_b then
  f_b_0     = -Frames.resolve1(frame_b.R, force);
  frame_b.f = -force;
elseif resolveInFrame == ResolveInFrameAB.world then
  f_b_0     = -force;
  frame_b.f =  Frames.resolve2(frame_b.R, f_b_0);
elseif resolveInFrame == ResolveInFrameAB.frame_resolve then
  f_b_0     = -Frames.resolve1(frame_resolve.R, force);
  frame_b.f = Frames.resolve2(frame_b.R, f_b_0);
else
  assert(false, "参数 resolveInFrame 的值错误");
  f_b_0     = zeros(3);
  frame_b.f = zeros(3);
end if;
frame_b.t = zeros(3);

// 力和力矩平衡
r_0 = frame_b.r_0 - frame_a.r_0;
zeros(3) = frame_a.f + Frames.resolve2(frame_a.R, f_b_0);
   zeros(3) = frame_a.t + Frames.resolve2(frame_a.R, cross(r_0, f_b_0));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{-98,99},{99,-98}}, 
          lineColor={255,255,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-92,61},{87,35}}, 
          textColor={192,192,192}, 
          textString="resolve"), 
        Text(
          extent={{-136,-52},{149,-113}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Line(
          points={{40,100},{40,0}}, 
          color={95,95,95}, 
          pattern=LinePattern.Dot), 
        Polygon(
          points={{-94,0},{-64,11},{-64,-10},{-94,0}}, 
          fillPattern=FillPattern.Solid), 
        Line(
          points={{-60,100},{40,100}}, 
          color={95,95,95}, 
          pattern=LinePattern.Dot), 
        Polygon(
          points={{94,0},{65,12},{65,-11},{94,0}}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-64,0},{-20,0}}), 
        Line(points={{20,0},{65,0}})}), 
    Documentation(info="<html>
<p>
<strong>力</strong>连接器的<strong>3</strong>个信号被解释为作用在该组件的frame_b连接器上的力的x、y和z坐标。
通过参数<strong>resolveInFrame</strong>定义了这些坐标应该在哪个坐标系中解析：
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th><strong>Types.ResolveInFrameAB.</strong></th><th><strong>意义</strong></th></tr>
<tr><td>world</td>
    <td>在world坐标系中解析输入力</td></tr>

<tr><td>frame_a</td>
    <td>在frame_a中解析输入力</td></tr>

<tr><td>frame_b</td>
    <td>在frame_b中解析输入力(默认设置)</td></tr>

<tr><td>frame_resolve</td>
    <td>在frame_resolve中解析输入力(frame_resolve必须以连接)</td></tr>
</table>

<p>
如果resolveInFrame = ResolveInFrameAB.frame_resolve，则力坐标是相对于所连接到<strong>frame_resolve</strong>的坐标系的。
</p>

<p>
如果resolveInFrame不是ResolveInFrameAB.frame_resolve，则必须将frame_resolve的位置矢量和方向对象设置为外部给定的常数值，以保持模型的平衡(这些常数值将被忽略)。
</p>


</html>"));
end BasicForce;