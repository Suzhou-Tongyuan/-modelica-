within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function planarRotation "返回平面旋转的方向对象"
  import Modelica.Math;
  extends Modelica.Icons.Function;
  input Real e[3](each final unit="1") 
    "旋转轴的归一化向量 (必须长度为1)";
  input SI.Angle angle 
    "将坐标系1沿轴e旋转至坐标系2的旋转角度";
  output TransformationMatrices.Orientation T 
    "将坐标系1旋转至坐标系2的方向对象";
algorithm
  T := outerProduct(e,e) + (identity(3) - outerProduct(e,e))*Math.cos(
    angle) - skew(e)*Math.sin(angle);
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
T = TransformationMatrices.<strong>planarRotation</strong>(e, angle);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数返回描述沿单位轴<strong>e</strong>在平面内旋转将坐标系1旋转至坐标系2的
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T，
其中角度为<strong>angle</strong>。
注意，\"e\"必须是单位向量。然而，此函数中未检查这一点，如果length(e)不为一，函数将返回错误的结果。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.planarRotationAngle\">planarRotationAngle</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.planarRotation\">Frames.planarRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.planarRotation\">Quaternions.planarRotation</a>.
</p>
</html>"));
end planarRotation;