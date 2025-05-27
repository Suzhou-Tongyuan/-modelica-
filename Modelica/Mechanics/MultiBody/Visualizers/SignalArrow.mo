within Modelica.Mechanics.MultiBody.Visualizers;
model SignalArrow 
  "在frame_a中基于输入信号可视化动态变化大小的箭头"

  import Modelica.Mechanics.MultiBody.Types;

  extends Modelica.Mechanics.MultiBody.Interfaces.PartialVisualizer;
  parameter Boolean animation=true "=true，如果启用动画";
  input SI.Position r_tail[3]={0,0,0} 
    "从frame_a到箭头尾部的矢量，在frame_a中解析" 
    annotation (Dialog(group="如果animation=true", enable=animation));
  input Types.Color color={0,0,255} "箭头的颜色" 
    annotation (Dialog(colorSelector=true, group="如果animation=true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射(=0：光完全被吸收)" 
    annotation (Dialog(group="如果animation=true", enable=animation));
  parameter Types.VectorQuantity quantity=Types.VectorQuantity.RelativePosition 
    "矢量代表的物理量的类型" 
    annotation (Dialog(group="如果animation=true", enable=animation));
  input Boolean headAtOrigin=false "=true，如果矢量指向矢量坐标系的原点" 
    annotation (Dialog(group="如果animation=true", enable=animation));

  Modelica.Blocks.Interfaces.RealInput r_head[3] 
    "在frame_a中解析的矢量" 
    annotation (Placement(transformation(
        origin={0,-120}, 
        extent={{-20,-20},{20,20}}, 
        rotation=90)));

protected
  Visualizers.Advanced.Arrow arrow(
    R=frame_a.R, 
    r=frame_a.r_0, 
    r_tail=r_tail, 
    r_head=r_head, 
    color=color, 
    quantity=quantity, 
    headAtOrigin=headAtOrigin, 
    specularCoefficient=specularCoefficient) if world.enableAnimation and animation;
equation
  frame_a.f = zeros(3);
  frame_a.t = zeros(3);

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
            100}}), graphics={
        Line(points={{0,-102},{0,-28}}, color={0,0,127}), 
        Rectangle(
          extent={{-100,28},{20,-28}}, 
          lineColor={128,128,128}, 
          fillColor={128,128,128}, 
          fillPattern=FillPattern.Solid), 
        Polygon(
          points={{20,60},{100,0},{20,-60},{20,60}}, 
          lineColor={128,128,128}, 
          fillColor={128,128,128}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-150,105},{150,65}}, 
          textString="%name", 
          textColor={0,0,255})}), 
    Documentation(info="<html>
<p>
<strong>SignalArrow</strong>模型定义了一个箭头，动态可视化在其连接的frame_a位置处。
箭头尾部到箭头头部的矢量，在frame_a中解析，通过连接器<code>r_head</code>的信号矢量定义：<code><strong>Real</strong>r_head[3]</code>。
<br>&nbsp;</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Arrow.png\"alt=\"model Visualizers.SignalArrow\">
</div>
<p>
<code>quantity</code>参数定义了矢量代表的内容，允许工具以一致的方式不同地缩放例如力和力矩。
对于默认值<strong>RelativePosition</strong>，明显的缩放是1，相对位置如实显示。
</p>
<p>
箭头的尾部通过输入<code>r_tail</code>相对于frame_a(从frame_a原点到箭头尾部的矢量)定义。
</p>

</html>"));
end SignalArrow;