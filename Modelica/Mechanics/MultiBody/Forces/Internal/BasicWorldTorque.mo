within Modelica.Mechanics.MultiBody.Forces.Internal;
model BasicWorldTorque 
  "在frame_b作用的外部力矩，由3个输入信号定义"
  import Modelica.Mechanics.MultiBody.Types.ResolveInFrameB;
  extends Interfaces.PartialOneFrame_b;
  Interfaces.Frame_resolve frame_resolve 
    "输入信号可选地在此坐标系中解析" 
    annotation (Placement(transformation(
        origin={0,100}, 
        extent={{16,-16},{-16,16}}, 
        rotation=270)));

  Modelica.Blocks.Interfaces.RealInput torque[3](each final quantity="扭矩", each final unit="N.m") 
    "在resolveInFrame定义的坐标系中解析的扭矩的x、y、z坐标" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameB 
    resolveInFrame= 
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.world 
    "扭矩解析的坐标系(1: 全局坐标系，2: frame_b，3: frame_resolve)";
equation
  assert(cardinality(frame_resolve) > 0, "连接器frame_resolve必须至少连接一次，并且frame_resolve.r_0/.R必须设置");
  frame_resolve.f = zeros(3);
  frame_resolve.t = zeros(3);

  if resolveInFrame == ResolveInFrameB.world then
    frame_b.t = -Frames.resolve2(frame_b.R, torque);
  elseif resolveInFrame == ResolveInFrameB.frame_b then
    frame_b.t = -torque;
  elseif resolveInFrame == ResolveInFrameB.frame_resolve then
    frame_b.t = -Frames.resolveRelative(torque, frame_resolve.R, frame_b.R);
  else
    assert(false, "参数resolveInFrame的值错误");
    frame_b.t = zeros(3);
  end if;

   frame_b.f = zeros(3);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Text(
          extent={{-61,64},{46,27}}, 
          textColor={192,192,192}, 
          textString="resolve"), 
        Text(
          extent={{-150,-40},{150,-80}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Line(
          points={{0,95},{0,82}}, 
          color={95,95,95}, 
          pattern=LinePattern.Dot), 
        Line(
          points={{-100,0},{-94,13},{-86,28},{-74,48},{-65,60},{-52,72},{-35, 
              81},{-22,84},{-8,84},{7,80},{19,73},{32,65},{44,55},{52,47},{
              58,40}}, 
          thickness=0.5), 
        Polygon(
          points={{94,10},{75,59},{41,24},{94,10}}, 
          fillPattern=FillPattern.Solid)}), 
    Documentation(info="<html>
<p>
  <strong>力矩</strong>连接器的3个信号被解释为作用在此组件所连接的坐标系上的x、y和z坐标的<strong>力矩</strong>。
  通过参数<strong>resolveInFrame</strong>定义了这些坐标值应该在哪个坐标系中解析：
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><th><strong>Types.ResolveInFrameB.</strong></th><th><strong>含义</strong></th></tr>
  <tr><td>world</td>
      <td>在world坐标系中解析输入的力矩(默认设置)</td></tr>
  
  <tr><td>frame_b</td>
      <td>在frame_b中解析输入力矩</td></tr>
  
  <tr><td>frame_resolve</td>
      <td>在frame_resolve中解析输入力矩(frame_resolve必须已连接)</td></tr>
</table>

<p>
  如果resolveInFrame = Types.ResolveInFrameB.frame_resolve，则力矩坐标是相对于与<strong>frame_resolve</strong>连接的坐标系的。
</p>

<p>
  如果resolveInFrame不是Types.ResolveInFrameB.frame_resolve，则必须从外部设置frame_resolve的位置向量和方向对象为常量值，以使模型保持平衡(这些常量值会被忽略)。
</p>

</html>"));
end BasicWorldTorque;