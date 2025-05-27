within Modelica.Mechanics.MultiBody.Frames;
function inverseRotation "返回逆方向对象"
  extends Modelica.Icons.Function;
  input Orientation R "将坐标系1旋转到坐标系2的方向对象";
  output Orientation R_inv 
    "将坐标系2旋转到坐标系1的方向对象";
algorithm
  R_inv := Orientation(T=transpose(R.T), w=-resolve1(R, R.w));
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
R_inv = Frames.<strong>inverseRotation</strong>(R);
</pre></blockquote>

<h4>描述</h4>
<p>
函数调用<code>Frames.<strong>inverseRotation</strong>(R)</code>描述从坐标系1旋转到坐标系2的方向的方向对象R返回描述从坐标系2旋转到坐标系1的方向的方向对象R_inv
</p>

<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.inverseRotation\">TransformationMatrices.inverseRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.inverseRotation\">Quaternions.inverseRotation</a>.
</p>
</html>"));
end inverseRotation;