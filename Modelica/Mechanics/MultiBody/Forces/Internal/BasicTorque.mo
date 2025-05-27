within Modelica.Mechanics.MultiBody.Forces.Internal;
model BasicTorque 
  "在两个坐标系之间作用的力矩，由3个输入信号定义"
  import Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB;
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
  Interfaces.Frame_resolve frame_resolve 
    "输入信号可选择在此坐标系中解析" 
    annotation (Placement(transformation(
        origin={40,100}, 
        extent={{-16,-16},{16,16}}, 
        rotation=90)));

  Modelica.Blocks.Interfaces.RealInput torque[3](each final quantity="Torque", each final unit="N.m") 
    "力矩的x、y、z坐标，解析在resolveInFrame定义的坐标系中" 
    annotation (Placement(transformation(
        origin={-60,120}, 
        extent={{-20,-20},{20,20}}, 
        rotation=270)));
  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB 
    resolveInFrame= 
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_b 
    "力矩解析的坐标系(1: 全局坐标系，2: frame_a，3: frame_b，4: frame_resolve)";

  SI.Position r_0[3] 
    "从frame_a原点到frame_b原点的位置向量，解析在全局坐标系中";
  SI.Torque t_b_0[3] "frame_b.t 解析在全局坐标系中";

equation
  assert(cardinality(frame_resolve) > 0, "连接器 frame_resolve 必须至少连接一次，并且必须设置 frame_resolve.r_0/.R");
  frame_resolve.f = zeros(3);
  frame_resolve.t = zeros(3);

  r_0 = frame_b.r_0 - frame_a.r_0;
  frame_a.f = zeros(3);
  frame_b.f = zeros(3);

   if resolveInFrame == ResolveInFrameAB.frame_a then
      t_b_0     = -Frames.resolve1(frame_a.R, torque);
      frame_b.t =  Frames.resolve2(frame_b.R, t_b_0);
   elseif resolveInFrame == ResolveInFrameAB.frame_b then
      t_b_0     = -Frames.resolve1(frame_b.R, torque);
      frame_b.t = -torque;
   elseif resolveInFrame == ResolveInFrameAB.world then
      t_b_0     = -torque;
      frame_b.t =  Frames.resolve2(frame_b.R, t_b_0);
   elseif resolveInFrame == ResolveInFrameAB.frame_resolve then
      t_b_0     = -Frames.resolve1(frame_resolve.R, torque);
      frame_b.t =  Frames.resolve2(frame_b.R, t_b_0);
   else
      assert(false, "参数resolveInFrame的值错误");
      t_b_0     = zeros(3);
      frame_b.t = zeros(3);
   end if;

   // 力矩平衡
   zeros(3) = frame_a.t + Frames.resolve2(frame_a.R, t_b_0);

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{-98,99},{99,-98}}, 
          lineColor={255,255,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-59,55},{72,30}}, 
          textColor={192,192,192}, 
          textString="resolve"), 
        Text(
          extent={{-139,-27},{146,-88}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Polygon(
          points={{100,20},{84,52},{69,39},{100,20}}, 
          fillPattern=FillPattern.Solid), 
        Line(
          points={{40,100},{76,46}}, 
          color={95,95,95}, 
          pattern=LinePattern.Dot), 
        Polygon(
          points={{-99,20},{-86,53},{-70,42},{-99,20}}, 
          fillPattern=FillPattern.Solid), 
        Line(
          points={{-60,100},{40,100}}, 
          color={95,95,95}, 
          pattern=LinePattern.Dot), 
        Line(points={{-79,47},{-70,61},{-59,72},{-45,81},{-32,84},{-20,85}}), 
        Line(points={{77,45},{66,60},{55,69},{49,74},{41,80},{31,84},{20,85}})}), 
    Documentation(info="<html>
<p>
<strong>力矩</strong>连接器的<strong>3</strong>个信号被解释为作用在此组件的frame_b所连接的坐标系连接器上的<strong>力矩</strong>的x、y和z坐标。
通过参数<strong>resolveInFrame</strong>，定义了这些坐标应该在哪个坐标系中解析：
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th><strong>Types.ResolveInFrameAB.</strong></th><th><strong>含义</strong></th></tr>
<tr><td>world</td>
    <td>在全局坐标系中解析输入力矩</td></tr>

<tr><td>frame_a</td>
    <td>在frame_a中解析输入力矩</td></tr>

<tr><td>frame_b</td>
    <td>在frame_b中解析输入力矩(默认设置)</td></tr>

<tr><td>frame_resolve</td>
    <td>在frame_resolve中解析输入力矩(frame_resolve必须以连接)</td></tr>
</table>

<p>
如果resolveInFrame = ResolveInFrameAB.frame_resolve，则力矩坐标是相对于与<strong>frame_resolve</strong>连接的坐标系。
</p>

<p>
如果resolveInFrame不是ResolveInFrameAB.frame_resolve，则frame_resolve的位置向量和方向对象必须设置为外部的常数值，以使模型保持平衡(这些常数值将被忽略)。
</p>

</html>"));
end BasicTorque;