within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function from_Q 
  "从四元数方向对象 Q 返回方向对象 T"
  extends Modelica.Icons.Function;
  input Quaternions.Orientation Q 
    "将坐标系2旋转到坐标系1的四元数方向对象";
  output TransformationMatrices.Orientation T 
    "将坐标系2旋转到坐标系1的方向对象";
algorithm
  T := [2*(Q[1]*Q[1] + Q[4]*Q[4]) - 1, 2*(Q[1]*Q[2] + Q[3]*Q[4]), 2*(Q[1]*Q[3] - Q[2]*Q[4]);
        2*(Q[2]*Q[1] - Q[3]*Q[4]), 2*(Q[2]*Q[2] + Q[4]*Q[4]) - 1, 2*(Q[2]*Q[3] + Q[1]*Q[4]);
        2*(Q[3]*Q[1] + Q[2]*Q[4]), 2*(Q[3]*Q[2] - Q[1]*Q[4]), 2*(Q[3]*Q[3] + Q[4]*Q[4]) - 1];
annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
T = TransformationMatrices.<strong>from_Q</strong>(Q);
</pre></blockquote>

<h4>描述</h4>
<p>
该函数返回一个
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\"> transformation matrix</a>&nbsp;T，
根据给定的<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\"> quaternion object</a>&nbsp;Q计算而得。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.to_Q\">to_Q</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_Q\">Frames.from_Q</a>.
</p>
</html>"));
end from_Q;