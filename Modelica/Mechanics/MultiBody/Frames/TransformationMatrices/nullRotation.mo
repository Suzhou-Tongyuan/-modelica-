within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function nullRotation 
  "返回不旋转坐标系的方向对象"
  extends Modelica.Icons.Function;
  output TransformationMatrices.Orientation T 
    "方向对象，使得坐标系1和坐标系2相同";
algorithm
  T := identity(3);
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
T = TransformationMatrices.<strong>nullRotation</strong>();
</pre></blockquote>

<h4>描述</h4>
<p>
此函数返回一个描述将坐标系1旋转至坐标系2的
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T，
如果坐标系1和坐标系2是相同的。(= 变换矩阵是单位矩阵且角速度为零)。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.nullRotation\">Frames.nullRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.nullRotation\">Quaternions.nullRotation</a>.
</p>
</html>"));
end nullRotation;