within Modelica.Mechanics.MultiBody.Frames.Quaternions;
function orientationConstraint 
  "返回方向约束的残差(应为零)"
  extends Modelica.Icons.Function;
  input Quaternions.Orientation Q 
    "将坐标系1旋转到坐标系2的四元数方向对象";
  output Real residue[1] "残差约束(应为零)";
algorithm
  residue := {Q*Q - 1};
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
residue = Quaternions.<strong>orientationConstraint</strong>(Q);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数返回具有一个元素的Real残差矢量，描述了
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q的四个元素之间的约束。
</p>

<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.orientationConstraint\">Frames.orientationConstraint</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.orientationConstraint\">TransformationMatrices.orientationConstraint</a>.
</p>
</html>"));
end orientationConstraint;