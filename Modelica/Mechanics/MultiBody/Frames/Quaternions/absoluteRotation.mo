within Modelica.Mechanics.MultiBody.Frames.Quaternions;
function absoluteRotation 
  "返回另一个绝对四元数方向对象的绝对四元数方向对象"

  extends Modelica.Icons.Function;
  input Quaternions.Orientation Q1 
    "将坐标系0旋转到坐标系1的四元数方向对象";
  input Quaternions.Orientation Q_rel 
    "将坐标系1旋转到坐标系2的相对四元数方向对象";
  output Quaternions.Orientation Q2 
    "将坐标系0旋转到坐标系2的四元数方向对象";
algorithm
  Q2 := [Q_rel[4], Q_rel[3], -Q_rel[2], Q_rel[1]; -Q_rel[3], Q_rel[4],
    Q_rel[1], Q_rel[2]; Q_rel[2], -Q_rel[1], Q_rel[4], Q_rel[3]; -Q_rel[1],
     -Q_rel[2], -Q_rel[3], Q_rel[4]]*Q1;
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
Q2 = Quaternions.<strong>absoluteRotation</strong>(Q1, Q_rel);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数返回
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q2，
描述了从将坐标系&nbsp;0旋转到坐标系&nbsp;2的方向，
其中<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q1
描述了从将坐标系&nbsp;0旋转到坐标系&nbsp;1的方向，
而相对的<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q_rel
描述了从将坐标系&nbsp;1旋转到坐标系&nbsp;2的方向。
</p>

<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.absoluteRotation\">Frames.absoluteRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.absoluteRotation\">TransformationMatrices.absoluteRotation</a>.
</p>
</html>"));
end absoluteRotation;