within Modelica.Mechanics.MultiBody.Visualizers;
model FixedArrow "在frame_a中可视化具有动态变化大小的箭头"

  import Modelica.Mechanics.MultiBody.Types;
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialVisualizer;
  parameter Boolean animation=true "=true，如果启用动画";
  input SI.Position r_tail[3]={0,0,0} 
    "从frame_a到箭头尾部的矢量，在frame_a中解析" 
    annotation (Dialog(group="如果animation=true", enable=animation));
  input Types.Axis n={1,0,0} "箭头方向上的矢量，在frame_a中解析" 
    annotation (Dialog(group="如果animation=true", enable=animation));
  input SI.Length length=0.1 "完整箭头的长度" 
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
protected
  Visualizers.Advanced.Vector arrowLine(
    color=color, 
    specularCoefficient=specularCoefficient, 
    coordinates=n*length, 
    quantity=quantity, 
    headAtOrigin=headAtOrigin, 
    r=frame_a.r_0 + Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.resolve1(frame_a.R.T, r_tail), 
    R=frame_a.R) if world.enableAnimation and animation;
equation
  frame_a.f = zeros(3);
  frame_a.t = zeros(3);

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
            100}}), graphics={
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
          textColor={0,0,255}), 
        Text(
          extent={{-150,-75},{150,-105}}, 
          textString="%length")}), 
    Documentation(info="<html>
<p>
<strong>FixedArrow</strong> 模型定义了一个箭头，显示在其frame_a的位置。
<br>&nbsp;</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Arrow.png\"alt=\"模型 Visualizers.FixedArrow\">
</div>

<p>
箭头的方向由相对于frame_a的矢量<code>n</code>指定，frame_a是箭头组件所附加到的本地坐标系。
箭头的方向、长度和颜色可以通过在参数菜单的输入字段中提供适当的表达式来动态变化。
</p>
<p>
<code>quantity</code>参数定义了矢量表示的是什么量，允许工具以一致的方式不同比例地缩放，例如力和力矩。
对于默认值<strong>RelativePosition</strong>，明显地，比例是1，相对位置原样显示。
</p>
</html>"));
end FixedArrow;