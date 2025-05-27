within Modelica.Mechanics.MultiBody.Frames.Quaternions;
function inverseRotation 
  "返回逆四元数方向的对象"
  extends Modelica.Icons.Function;
  input Quaternions.Orientation Q 
    "将坐标系 1旋转到坐标系 2的四元数方向对象";
  output Quaternions.Orientation Q_inv 
    "将坐标系 2旋转到坐标系 1的四元数方向对象";
algorithm
  Q_inv := {-Q[1],-Q[2],-Q[3],Q[4]};
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
Q_inv = Quaternions.<strong>inverseRotation</strong>(Q);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数返回描述了从坐标系&nbsp;2旋转到坐标系&nbsp;1的
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q_inv，
其描述了从坐标系&nbsp;1旋转到坐标系&nbsp;2的
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q。
</p>

<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.inverseRotation\">Frames.inverseRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.inverseRotation\">TransformationMatrices.inverseRotation</a>.
</p>
</html>"));
end inverseRotation;