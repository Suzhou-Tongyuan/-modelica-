within Modelica.Mechanics.MultiBody.Frames;
function planarRotation "返回平面旋转的方向对象"
  import Modelica.Math;
  extends Modelica.Icons.Function;
  input Real e[3](each final unit="1") 
    "旋转轴的归一化向量(必须长度为1)";
  input SI.Angle angle 
    "将坐标系1沿轴e旋转到坐标系2的旋转角度";
  input SI.AngularVelocity der_angle "= der(angle)";
  output Orientation R "将坐标系1旋转到坐标系2的方向对象";
algorithm
  R := Orientation(T=outerProduct(e,e) + (identity(3) - outerProduct(e,e))* 
    Math.cos(angle) - skew(e)*Math.sin(angle), w= e*der_angle);

  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
R = Frames.<strong>planarRotation</strong>(e, angle, der_angle);
</pre></blockquote>

<h4>描述</h4>
<p>
函数调用<code>Frames.<strong>planarRotation</strong>(e, angle, der_angle)</code>返回
方向对象R，描述沿单位轴<strong>e</strong>在平面内旋转
从坐标系1到坐标系2，旋转角度为<strong>angle</strong>，角度导数为<strong>der_angle</strong>。
注意，“e”必须是单位向量。但在此函数中未进行检查，如果长度(e)不是一，函数将返回错误的结果。
</p>

<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.planarRotationAngle\">planarRotationAngle</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.planarRotation\">TransformationMatrices.planarRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.planarRotation\">Quaternions.planarRotation</a>.
</p>
</html>"));
end planarRotation;