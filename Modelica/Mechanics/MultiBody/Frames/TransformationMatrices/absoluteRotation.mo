within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function absoluteRotation 
  "从另一个绝对方向对象和一个相对方向对象返回绝对方向对象"

  extends Modelica.Icons.Function;
  input TransformationMatrices.Orientation T1 
    "将坐标系0旋转至坐标系1的方向对象";
  input TransformationMatrices.Orientation T_rel 
    "将坐标系1旋转至坐标系2的相对方向对象";
  output TransformationMatrices.Orientation T2 
    "将坐标系0旋转至坐标系2的绝对方向对象";
algorithm
  T2 := T_rel*T1;
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
T2 = TransformationMatrices.<strong>absoluteRotation</strong>(T1, T_rel);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数返回描述从坐标系0旋转至坐标系2的
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a> T2，
其中T1是描述从坐标系0旋转至坐标系1的
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>，
T_rel是描述从坐标系1旋转至坐标系2的相对
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.absoluteRotation\">Frames.absoluteRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.absoluteRotation\">Quaternions.absoluteRotation</a>.
</p>
</html>"));
end absoluteRotation;