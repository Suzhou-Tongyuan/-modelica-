within Modelica.Mechanics.MultiBody.Visualizers.Internal;
model Lines 
  "将一组线段可变大小显示为圆柱体，例如，用于显示字符(没有坐标系连接器)"

  import Modelica.Mechanics.MultiBody;
  import Modelica.Mechanics.MultiBody.Types;
  import Modelica.Mechanics.MultiBody.Frames;
  import T = Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
  input Modelica.Mechanics.MultiBody.Frames.Orientation R=Frames.nullRotation() 
    "将全局坐标系旋转到对象坐标系的方向对象" annotation(Dialog);
  input SI.Position r[3]={0,0,0} 
    "从全局坐标系原点到对象坐标系原点的位置矢量，以全局坐标系解析" 
     annotation(Dialog);
  input SI.Position r_lines[3]={0,0,0} 
    "从对象坐标系原点到'lines'坐标系原点的位置矢量，以对象坐标系解析" 
     annotation(Dialog);
  input Real n_x[3](each final unit="1")={1,0,0} 
    "在对象坐标系中沿着'lines'坐标系x轴方向的矢量" 
     annotation(Dialog);
  input Real n_y[3](each final unit="1")={0,1,0} 
    "在对象坐标系中沿着'lines'坐标系y轴方向的矢量" 
   annotation(Dialog);
  input SI.Position lines[:, 2, 2]=zeros(0, 2, 2) 
    "以由n_x、n_y定义的x-y坐标系解析的圆柱体起点和终点列表，例如，{[0,0;1,1],[0,1;1,0],[2,0;3,1]}" 
  annotation(Dialog);
  input SI.Length diameter(min=0) = 0.05 
    "由线段定义的圆柱体直径" 
  annotation(Dialog);
  input Modelica.Mechanics.MultiBody.Types.Color color={0,128,255} 
    "圆柱体的颜色" 
  annotation(Dialog(colorSelector=true));
  input Types.SpecularCoefficient specularCoefficient = 0.7 
    "环境光的反射(=0：完全吸收光)" 
    annotation (Dialog);
protected
  parameter Integer n=size(lines, 1) "圆柱体的数量";
  T.Orientation R_rel=T.from_nxy(n_x, n_y);
  T.Orientation R_lines=T.absoluteRotation(R.T, R_rel);
  SI.Position r_abs[3]=r + T.resolve1(R.T, r_lines);
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape cylinders[n](
    each shapeType="cylinder", 
    lengthDirection={T.resolve1(R_rel, vector([lines[i, 2, :] - lines[i, 1, :]; 0])) for i in 1:n}, 
    length={Modelica.Math.Vectors.length(lines[i, 2, :] - lines[i, 1, :]) for i in 1:n}, 
    r={r_abs + T.resolve1(R_lines, vector([lines[i, 1, :]; 0])) for i in 1:n}, 
    each width=diameter, 
    each height=diameter, 
    each widthDirection={0,1,0}, 
    each color=color, 
    each R=R, 
    each specularCoefficient=specularCoefficient);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}}, 
          lineColor={128,128,128}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Polygon(
          points={{-24,-34},{-82,40},{-72,46},{-14,-26},{-24,-34}}, 
          lineColor={0,127,255}, 
          fillColor={0,127,255}, 
          fillPattern=FillPattern.Solid), 
        Polygon(
          points={{-82,-24},{-20,46},{-10,38},{-72,-32},{-82,-24}}, 
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
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-150,145},{150,105}}, 
          textString="%name", 
          textColor={0,0,255})}), 
    Documentation(info="<html>
<p>
使用模型<strong>FixedLines</strong>定义了一组相对于frame_a的线段。
每条线段由一个圆柱体表示。
这允许定义简单形状的三维字符。
下图显示了一个示例：<br>&nbsp;</p>
<div><img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Internal/FixedLines.png\"alt=\"model Visualizers.Internal.FixedLines\"></div>
<p>
&nbsp;<br>通过提供以下参数数据给参数<strong>lines</strong>，可以用4条线段构建两个字母\"x\"和\"y\"：</p>
<blockquote><pre>
lines={[0,0;1,1],[0,1;1,0],[1.5,-0.5;2.5,1],[1.5,1;2,0.25]}
</pre></blockquote>
<p>
通过参数矢量<strong>n_x</strong>和<strong>n_y</strong>定义了一个二维坐标系。
参数<strong>lines</strong>中定义的点是相对于这个坐标系的。
例如，\"[0, 0; 1, 1]\"定义了一条从{0,0}开始到{1,1}结束的线段。
所有线圆柱体的直径和颜色都相同。
</p>

</html>"));

end Lines;