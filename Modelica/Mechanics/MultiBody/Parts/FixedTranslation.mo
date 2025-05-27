within Modelica.Mechanics.MultiBody.Parts;
model FixedTranslation "frame_b相对于frame_a的固定平移"
  import Modelica.Mechanics.MultiBody.Types;
  import Modelica.Units.Conversions.to_unit1;

  Interfaces.Frame_a frame_a 
    "固定在组件上的坐标系，带有一个局部力和局部力矩" 
    annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));
  Interfaces.Frame_b frame_b 
    "固定在组件上的坐标系，带有一个局部力和局部力矩" 
    annotation (Placement(transformation(extent={{84,-16},{116,16}})));

  parameter Boolean animation=true "= true，如果启用动画";
  parameter SI.Position r[3](start={0,0,0}) 
    "从frame_a到frame_b的矢量，在frame_a中解析";
  parameter Types.ShapeType shapeType="cylinder" "形状类型" annotation (
     Dialog(
      tab="动画", 
      group="如果animation = true", 
      enable=animation));
  parameter SI.Position r_shape[3]={0,0,0} 
    "从frame_a到形状原点的矢量，在frame_a中解析" annotation (
      Dialog(
      tab="动画", 
      group="如果animation = true", 
      enable=animation));
  parameter Types.Axis lengthDirection = to_unit1(r - r_shape) 
    "形状长度方向的矢量，在frame_a中解析" annotation (
      Evaluate=true, Dialog(
      tab="动画", 
      group="如果animation = true", 
      enable=animation));
  parameter Types.Axis widthDirection={0,1,0} 
    "形状宽度方向的矢量，在frame_a中解析" annotation (
      Evaluate=true, Dialog(
      tab="动画", 
      group="如果animation = true", 
      enable=animation));
  parameter SI.Length length=Modelica.Math.Vectors.length(r - r_shape) 
    "形状的长度" annotation (Dialog(
      tab="动画", 
      group="如果animation = true", 
      enable=animation));
  parameter SI.Distance width=length/world.defaultWidthFraction 
    "形状的宽度" annotation (Dialog(
      tab="动画", 
      group="如果animation = true", 
      enable=animation));
  parameter SI.Distance height=width "形状的高度" annotation (Dialog(
      tab="动画", 
      group="如果animation = true", 
      enable=animation));

 parameter Types.ShapeExtra extra=0.0 
    "根据shapeType而定的额外参数(参见Visualizers.Advanced.Shape的文档)" 
    annotation (Dialog(
      tab="动画", 
      group="如果animation = true", 
      enable=animation));
  input Types.Color color=Modelica.Mechanics.MultiBody.Types.Defaults.RodColor 
    "形状的颜色" annotation (Dialog(
      colorSelector=true, 
      tab="动画", 
      group="如果animation = true", 
      enable=animation));
  input Types.SpecularCoefficient specularCoefficient=world.defaultSpecularCoefficient 
    "环境光的反射(= 0：光完全被吸收)" 
    annotation (Dialog(
      tab="动画", 
      group="如果animation = true", 
      enable=animation));


protected
  outer Modelica.Mechanics.MultiBody.World world;
  Visualizers.Advanced.Shape shape(
    shapeType=shapeType, 
    color=color, 
    specularCoefficient=specularCoefficient, 
    r_shape=r_shape, 
    lengthDirection=lengthDirection, 
    widthDirection=widthDirection, 
    length=length, 
    width=width, 
    height=height, 
    extra=extra, 
    r=frame_a.r_0, 
    R=frame_a.R) if world.enableAnimation and animation;
equation
  Connections.branch(frame_a.R, frame_b.R);
  assert(cardinality(frame_a) > 0 or cardinality(frame_b) > 0, 
    "FixedTranslation对象的连接器frame_a和frame_b都未连接");

  frame_b.r_0 = frame_a.r_0 + Frames.resolve1(frame_a.R, r);
  frame_b.R = frame_a.R;

  /* 力和力矩平衡 */
  zeros(3) = frame_a.f + frame_b.f;
  zeros(3) = frame_a.t + frame_b.t + cross(r, frame_b.f);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-99,5},{101,-5}}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-150,85},{150,45}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{150,-50},{-150,-20}}, 
          textString="r=%r"), 
        Text(
          extent={{-89,38},{-53,13}}, 
          textColor={128,128,128}, 
          textString="a"), 
        Text(
          extent={{57,39},{93,14}}, 
          textColor={128,128,128}, 
          textString="b")}), 

    Documentation(info="<html>
<p>
固定移动的frame_b 相对于 frame_a 的组件，即连接器 frame_a 和 frame_b 之间的关系保持不变，frame_a 始终与 frame_b 平行。
</p>
<p>
默认情况下，此组件通过连接 frame_a 和 frame_b 的圆柱体进行可视化，如下图所示。请注意，这两个可视化的坐标系不是组件动画的一部分，并且可以通过参数 animation = false 关闭动画。
</p>


<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Parts/FixedTranslation.png\" alt=\"Parts.FixedTranslation\">
</div>
</html>"));
end FixedTranslation;