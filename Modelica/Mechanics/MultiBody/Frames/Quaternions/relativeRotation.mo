within Modelica.Mechanics.MultiBody.Frames.Quaternions;
function relativeRotation "返回相对四元数方向对象"
  extends Modelica.Icons.Function;
  input Quaternions.Orientation Q1 
    "将坐标系0旋转到坐标系1的四元数方向对象";
  input Quaternions.Orientation Q2 
    "将坐标系0旋转到坐标系2的四元数方向对象";
  output Quaternions.Orientation Q_rel 
    "将坐标系1旋转到坐标系2的四元数方向对象";
algorithm
  Q_rel := [ Q1[4],  Q1[3], -Q1[2], -Q1[1];
            -Q1[3],  Q1[4],  Q1[1], -Q1[2];
             Q1[2], -Q1[1],  Q1[4], -Q1[3];
             Q1[1],  Q1[2],  Q1[3],  Q1[4]]*Q2;
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
Q_rel = Quaternions.<strong>relativeRotation</strong>(Q1, Q2);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数返回
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q_rel，
描述了从将坐标系&nbsp;1旋转到坐标系&nbsp;2的方向，
其中<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q1
描述了从将坐标系&nbsp;0旋转到坐标系&nbsp;1的方向，
而<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q2
描述了从将坐标系&nbsp;0旋转到坐标系&nbsp;2的方向。
</p>

<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.relativeRotation\">Frames.relativeRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.relativeRotation\">TransformationMatrices.relativeRotation</a>.
</p>
</html>"));
end relativeRotation;