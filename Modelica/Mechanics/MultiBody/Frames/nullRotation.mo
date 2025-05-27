within Modelica.Mechanics.MultiBody.Frames;
function nullRotation 
  "返回不旋转坐标系的方向对象"
  extends Modelica.Icons.Function;
  output Orientation R 
    "方向对象，使得坐标系1和坐标系2相同";
algorithm
  R := Orientation(T=identity(3), w=zeros(3));
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
R = Frames.<strong>nullRotation</strong>();
</pre></blockquote>

<h4>描述</h4>
<p>
函数调用<code>Frames.<strong>nullRotation</strong>()</code>返回一个方向矩阵&nbsp;R，
描述将坐标系1旋转到坐标系2的方向对象，如果坐标系1和坐标系2是相同的。
(= 变换矩阵是单位矩阵，角速度为零)。
</p>

<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.nullRotation\">TransformationMatrices.nullRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.nullRotation\">Quaternions.nullRotation</a>.
</p>
</html>"));
end nullRotation;