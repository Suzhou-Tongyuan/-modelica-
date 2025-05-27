within Modelica.Mechanics.MultiBody.Frames.Quaternions;
function smallRotation "返回适用于小旋转的旋转角度"
  extends Modelica.Icons.Function;
  input Quaternions.Orientation Q 
    "将坐标系1旋转到坐标系2的四元数方向对象";
  output SI.Angle phi[3] 
    "坐标系1围绕x轴、y轴和z轴的旋转角度，用于将坐标系1旋转到坐标系2的小相对旋转";
algorithm
  phi := 2*{Q[1],Q[2],Q[3]};
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
phi = Quaternions.<strong>smallRotation</strong>(Q);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数返回适用于小旋转角度的旋转，采用x-y-z顺序(即{1,2,3})。
</p>

<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.smallRotation\">Frames.smallRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.smallRotation\">TransformationMatrices.smallRotation</a>.
</p>
</html>"));
end smallRotation;