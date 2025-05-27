within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function axesRotations 
  "返回依次绕3个轴旋转的旋转对象"
  extends Modelica.Icons.Function;
  input Integer sequence[3](
    min={1,1,1}, 
    max={3,3,3}) = {1,2,3} 
    "从坐标系1到坐标系2沿axis sequence[i]的旋转顺序";
  input SI.Angle angles[3]={0,0,0} 
    "在'sequence'中定义的轴周围的旋转角度";
  output TransformationMatrices.Orientation T 
    "将坐标系1旋转到坐标系2的方向对象";
algorithm
  T := absoluteRotation(absoluteRotation(axisRotation(sequence[1], angles[1]), 
     axisRotation(sequence[2], angles[2])), axisRotation(sequence[3], 
    angles[3]));
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
T = TransformationMatrices.<strong>axesRotations</strong>(sequence, angles);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数返回由给定<strong>sequence</strong>中的三个基本旋转定义的方向的
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T，
每个旋转角度为<strong>angles</strong>。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.axesRotations\">Frames.axesRotations</a>.
</p>
</html>"));
end axesRotations;