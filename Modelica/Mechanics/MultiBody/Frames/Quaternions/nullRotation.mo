within Modelica.Mechanics.MultiBody.Frames.Quaternions;
function nullRotation 
  "返回一个不旋转frame的四元数方向对象"
  extends Modelica.Icons.Function;
  output Quaternions.Orientation Q 
    "将坐标系 1旋转到坐标系 2的四元数方向对象";
algorithm
  Q := {0,0,0,1};
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
Q = Quaternions.<strong>nullRotation</strong>();
</pre></blockquote>

<h4>描述</h4>
<p>
如果坐标系&nbsp;1和坐标系&nbsp;2是相同的则此函数返回一个将坐标系&nbsp;1旋转到坐标系&nbsp;2的
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">四元数方向</a>&nbsp;Q。(= 变换矩阵是单位矩阵且角速度为零)。
</p>
<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.nullRotation\">Frames.nullRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.nullRotation\">TransformationMatrices.nullRotation</a>.
</p>
</html>"));
end nullRotation;