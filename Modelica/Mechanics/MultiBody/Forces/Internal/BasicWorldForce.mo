within Modelica.Mechanics.MultiBody.Forces.Internal;
model BasicWorldForce 
  "在frame_b作用的外部力，由3个输入信号定义"
  import Modelica.Mechanics.MultiBody.Types.ResolveInFrameB;
  extends Interfaces.PartialOneFrame_b;
  Interfaces.Frame_resolve frame_resolve 
    "可以选择在此坐标系中解析输入信号" 
    annotation (Placement(transformation(
        origin={0,-100}, 
        extent={{-16,-16},{16,16}}, 
        rotation=270)));

  Modelica.Blocks.Interfaces.RealInput force[3](each final quantity="Force", each final unit="N") 
    "在resolveInFrame定义的坐标系中解析的力的x、y、z坐标" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameB 
    resolveInFrame= 
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.world 
    "力被解析的坐标系(1: 全局坐标系, 2: frame_b, 3: frame_resolve)";
equation
   assert(cardinality(frame_resolve) > 0, "连接器frame_resolve必须至少被连接一次，并且frame_resolve.r_0/.R必须被设置参数");
   frame_resolve.f = zeros(3);
   frame_resolve.t = zeros(3);

   if resolveInFrame == ResolveInFrameB.world then
      frame_b.f = -Frames.resolve2(frame_b.R, force);
   elseif resolveInFrame == ResolveInFrameB.frame_b then
      frame_b.f = -force;
   elseif resolveInFrame == ResolveInFrameB.frame_resolve then
      frame_b.f = -Frames.resolveRelative(force, frame_resolve.R, frame_b.R);
   else
      assert(false, "参数resolveInFrame的值错误");
      frame_b.f = zeros(3);
   end if;
   frame_b.t = zeros(3);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Text(
          extent={{-100,-40},{100,-70}}, 
          textColor={192,192,192}, 
          textString="resolve"), 
        Polygon(
          points={{-100,10},{50,10},{50,31},{94,0},{50,-31},{50,-10},{-100, 
              -10},{-100,10}}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-150,80},{150,40}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Line(
          points={{0,-10},{0,-95}}, 
          color={95,95,95}, 
          pattern=LinePattern.Dot)}), 
    Documentation(info="<html>
<p>
<strong>力</strong>连接器的3个信号被解释为作用在连接到该组件的坐标系上的<strong>力</strong>的x、y和z坐标。
通过参数<strong>resolveInFrame</strong>定义了这些坐标应该在哪个坐标系中解析：
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th><strong>Types.ResolveInFrameB.</strong></th><th><strong>意义</strong></th></tr>
<tr><td>world</td>
    <td>在world坐标系中解析输入的力(默认设置)</td></tr>

<tr><td>frame_b</td>
    <td>在frame_b中解析输入力</td></tr>

<tr><td>frame_resolve</td>
    <td>在frame_resolve中解析输入力(frame_resolve必须已连接)</td></tr>
</table>

<p>
如果resolveInFrame = Types.ResolveInFrameB.frame_resolve，则力坐标相对于连接到<strong>frame_resolve</strong>的坐标系。
</p>

<p>
如果resolveInFrame不是Types.ResolveInFrameB.frame_resolve，则
frame_resolve的位置矢量和方向对象必须从外部设置为常数值，
以确保模型保持平衡(这些常数值将被忽略)。
</p>
</html>"));
end BasicWorldForce;