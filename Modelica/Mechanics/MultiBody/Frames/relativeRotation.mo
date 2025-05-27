within Modelica.Mechanics.MultiBody.Frames;
function relativeRotation "返回相对方向对象"
  extends Modelica.Icons.Function;
  input Orientation R1 "将坐标系0旋转到坐标系1的方向对象";
  input Orientation R2 "将坐标系0旋转到坐标系2的方向对象";
  output Orientation R_rel 
    "将坐标系1旋转到坐标系2的方向对象";
algorithm
  R_rel := Orientation(T=R2.T*transpose(R1.T), w=R2.w - resolve2(R2, resolve1(
     R1, R1.w)));
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
R_rel = Frames.<strong>relativeRotation</strong>(R1,R2);
</pre></blockquote>

<h4>描述</h4>
<p>
函数调用<code>Frames.<strong>relativeRotation</strong>(R1,R2)</code>返回相对方向对象R_rel，
描述从坐标系1旋转到坐标系2的方向，
其中方向对象R1描述从坐标系0旋转到坐标系1的方向，
方向对象R2描述从坐标系0旋转到坐标系2的方向。
</p>

<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.relativeRotation\">TransformationMatrices.relativeRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.relativeRotation\">Quaternions.relativeRotation</a>.
</p>
</html>"));
end relativeRotation;