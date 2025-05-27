within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function inverseRotation "返回逆方向对象"
  extends Modelica.Icons.Function;
  input TransformationMatrices.Orientation T 
    "将坐标系1旋转至第2个坐标系的方向对象";
  output TransformationMatrices.Orientation T_inv 
    "将第2个坐标系旋转至坐标系1的方向对象";
algorithm
  T_inv := transpose(T);
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
T_inv = TransformationMatrices.<strong>inverseRotation</strong>(T);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数返回描述从第2个坐标系旋转至坐标系1的
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a> T_inv，
其中T是描述从坐标系1旋转至第2个坐标系的
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.inverseRotation\">Frames.inverseRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.inverseRotation\">Quaternions.inverseRotation</a>.
</p>
</html>"));
end inverseRotation;