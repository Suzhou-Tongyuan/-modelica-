within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function orientationConstraint 
  "返回方向约束的残差(应为零)"
  extends Modelica.Icons.Function;
  input TransformationMatrices.Orientation T 
    "将坐标系1旋转到坐标系2的方向对象";
  output Real residue[6] 
    "方向对象元素之间约束的残差(应为零)";
algorithm
  residue := {T[:, 1]*T[:, 1] - 1, T[:, 2]*T[:, 2] - 1, T[:, 3]*T[:, 3] - 1, 
              T[:, 1]*T[:, 2], T[:, 1]*T[:, 3], T[:, 2]*T[:, 3]};
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
residue = TransformationMatrices.<strong>orientationConstraint</strong>(T);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数返回具有6个元素的实数残差矢量，描述了
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>
T 的9个元素之间的约束。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.orientationConstraint\">Frames.orientationConstraint</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.orientationConstraint\">Quaternions.orientationConstraint</a>.
</p>
</html>"));
end orientationConstraint;