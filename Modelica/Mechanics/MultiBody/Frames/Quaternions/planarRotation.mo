within Modelica.Mechanics.MultiBody.Frames.Quaternions;
function planarRotation 
  "返回平面旋转的四元数方向对象"
  import Modelica.Math;
  extends Modelica.Icons.Function;
  input Real e[3](each final unit="1") 
    "旋转轴的标准化矢量（必须长度为1）";
  input SI.Angle angle 
    "将坐标系1沿轴e旋转到坐标系2的旋转角度";
  output Quaternions.Orientation Q 
    "将坐标系1沿轴e旋转到坐标系2的四元数方向对象";
algorithm
  Q := vector([e*Math.sin(angle/2); Math.cos(angle/2)]);
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
Q = Quaternions.<strong>planarRotation</strong>(e, angle);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数返回
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q，
描述了沿单位轴<strong>e</strong>从坐标系1旋转到坐标系2的方向，
角度为<strong>angle</strong>。
注意，\"e\" 必须是单位矢量。但是，此函数不会检查此条件，如果e的长度不为1，则函数将返回错误的结果。
</p>

<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.planarRotation\">Frames.planarRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.planarRotation\">TransformationMatrices.planarRotation</a>.
</p>
</html>"));
end planarRotation;