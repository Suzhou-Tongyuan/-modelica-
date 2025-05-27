within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function relativeRotation "返回相对方向对象"
  extends Modelica.Icons.Function;
  input TransformationMatrices.Orientation T1 
    "将坐标系0旋转至坐标系1的方向对象";
  input TransformationMatrices.Orientation T2 
    "将坐标系0旋转至坐标系2的方向对象";
  output TransformationMatrices.Orientation T_rel 
    "将坐标系1旋转至坐标系2的方向对象";
algorithm
  T_rel := T2*transpose(T1);
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
T_rel = TransformationMatrices.<strong>relativeRotation</strong>(T1, T2);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数返回描述从坐标系1旋转至坐标系2的
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a> T_rel，
其中T1是描述从坐标系0旋转至坐标系1的
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>，
T2是描述从坐标系0旋转至坐标系2的
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.relativeRotation\">Frames.relativeRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.relativeRotation\">Quaternions.relativeRotation</a>.
</p>
</html>"));
end relativeRotation;