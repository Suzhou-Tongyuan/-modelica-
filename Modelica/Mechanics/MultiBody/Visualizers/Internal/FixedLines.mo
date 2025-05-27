within Modelica.Mechanics.MultiBody.Visualizers.Internal;
 model FixedLines 
 "将一组线条视为圆柱体(例如，用于显示字符)"

  import Modelica.Mechanics.MultiBody;
  import Modelica.Mechanics.MultiBody.Types;
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialVisualizer;

  parameter Boolean animation=true "=如果要启用动画，则为true";
  input Real scale(min=0) = 1 
    "通过'scale'倍放大可视化的'lines'" 
    annotation (Dialog(group="如果animation=true", enable=animation));
  input SI.Position lines[:,2,2]={[0,0; 1,1],[0,1; 1,0]} 
    "沿n_x和n_y分辨率解析的圆柱体的起始点和终点列表" 
    annotation (Dialog(group="如果animation=true", enable=animation));
  input SI.Distance diameter(min=0) = 0.05 
    "由线条定义的圆柱体的直径" 
    annotation (Dialog(group="如果animation=true", enable=animation));
  input SI.Position r_lines[3]={0,0,0} 
    "从frame_a的原点到'lines'坐标系的原点的位置矢量，以frame_a为基准解析" 
    annotation (Dialog(group="如果animation=true", enable=animation));
  input Real n_x[3](each final unit="1")={1,0,0} 
    "定义'lines'坐标系x轴方向的矢量，以frame_a为基准解析。
" 
    annotation (Dialog(group="如果animation=true", enable=animation));
  input Real n_y[3](each final unit="1")={0,1,0} 
    "定义'lines'坐标系y轴方向的矢量，以frame_a为基准解析。
" 
    annotation (Dialog(group="如果animation=true", enable=animation));
  input MultiBody.Types.Color color={0,128,255} "圆柱体的颜色" 
    annotation (Dialog(colorSelector=true, group="如果animation=true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射(=0：光完全被吸收)" 
    annotation (Dialog(group="如果animation=true", enable=animation));

protected
  Lines x_label(
    lines=scale*lines, 
    diameter=scale*diameter, 
    color=color, 
    specularCoefficient = specularCoefficient, 
    r_lines=r_lines, 
    n_x=n_x, 
    n_y=n_y, 
    r=frame_a.r_0, 
    R=frame_a.R) if world.enableAnimation and animation;
equation
  frame_a.f = zeros(3);
  frame_a.t = zeros(3);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}}, 
          lineColor={128,128,128}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-150,145},{150,105}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Polygon(
          points={{-82,-24},{-20,46},{-10,38},{-72,-32},{-82,-24}}, 
          lineColor={0,127,255}, 
          fillColor={0,127,255}, 
          fillPattern=FillPattern.Solid), 
        Polygon(
          points={{-24,-34},{-82,40},{-72,46},{-14,-26},{-24,-34}}, 
          lineColor={0,127,255}, 
          fillColor={0,127,255}, 
          fillPattern=FillPattern.Solid), 
        Polygon(
          points={{42,-18},{10,40},{20,48},{50,-6},{42,-18}}, 
          lineColor={0,127,255}, 
          fillColor={0,127,255}, 
          fillPattern=FillPattern.Solid), 
        Polygon(
          points={{10,-68},{84,48},{96,42},{24,-72},{10,-68}}, 
          lineColor={0,127,255}, 
          fillColor={0,127,255}, 
          fillPattern=FillPattern.Solid)}), 
    Documentation(info="<html>
<p>
使用模型<strong>FixedLines</strong>定义了一组相对于frame_a的线条。
每条线由一个圆柱体表示。
这允许定义简单形状的三维字符。
下图显示了一个示例：<br>&nbsp;</p>
<div><img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Internal/FixedLines.png\"alt=\"model Visualizers.Internal.FixedLines\"></div>
<p>
&nbsp;<br>通过提供以下参数数据给参数<strong>lines</strong>，使用4条线条构建了两个字母“x”和“y”</p>
<blockquote><pre>
lines={[0,0;1,1],[0,1;1,0],[1.5,-0.5;2.5,1],[1.5,1;2,0.25]}
</pre></blockquote>
<p>
通过参数矢量<strong>n_x</strong>和<strong>n_y</strong>定义了一个二维坐标系。
使用参数<strong>lines</strong>定义的点是相对于此坐标系的。
例如“[0,0;1,1]”定义了一条从{0,0}到{1,1}的线。
所有线圆柱体的直径和颜色都相同。
</p>
</html>"));
end FixedLines;