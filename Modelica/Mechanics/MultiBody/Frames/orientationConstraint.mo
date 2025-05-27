within Modelica.Mechanics.MultiBody.Frames;
function orientationConstraint 
  "返回方向约束的残差(应等于零)"
  extends Modelica.Icons.Function;
  input Orientation R "将坐标系1旋转到坐标系2的方向对象";
  output Real residue[6] 
    "方向对象元素之间约束的残差(应等于零)";
algorithm
  residue := {R.T[:, 1]*R.T[:, 1] - 1,R.T[:, 2]*R.T[:, 2] - 1,R.T[:, 3]*R.T[:,
     3] - 1,R.T[:, 1]*R.T[:, 2],R.T[:, 1]*R.T[:, 3],R.T[:, 2]*R.T[:, 3]};
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
residue = Frames.<strong>orientationConstraint</strong>(R);
</pre></blockquote>

<h4>描述</h4>
<p>
函数调用<code>Frames.<strong>orientationConstraint</strong>(R)</code>返回一个具有6个元素的Real残差矢量，
描述了方向矩阵的9个元素之间的约束。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.orientationConstraint\">TransformationMatrices.orientationConstraint</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.orientationConstraint\">Quaternions.orientationConstraint</a>.
</p>
</html>"));
end orientationConstraint;