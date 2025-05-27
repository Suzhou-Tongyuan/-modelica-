within Modelica.Mechanics.MultiBody.Frames;
function absoluteRotation 
  "从另一个绝对方向和相对方向对象返回绝对方向对象"

  extends Modelica.Icons.Function;
  input Orientation R1 "将坐标系0旋转到坐标系1的方向对象";
  input Orientation R_rel "将坐标系1旋转到坐标系2的相对方向对象";
  output Orientation R2 "将坐标系0旋转到坐标系2的方向对象";
algorithm
  R2 := Orientation(T=R_rel.T*R1.T, w=resolve2(R_rel, R1.w) + R_rel.w);
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
R2 = Frames.<strong>absoluteRotation</strong>(R1,R_rel);
</pre></blockquote>

<h4>描述</h4>
<p>
函数调用<code>Frames.<strong>absoluteRotation</strong>(R1,R_rel)</code>返回绝对方向对象R2，
描述从坐标系0旋转到坐标系2的方向，
其中方向对象R1描述从坐标系0旋转到坐标系1的方向，
相对方向对象R_rel描述从坐标系1旋转到坐标系2的方向。
</p>

<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.absoluteRotation\">TransformationMatrices.absoluteRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.absoluteRotation\">Quaternions.absoluteRotation</a>.
</p>
</html>"));
end absoluteRotation;