within Modelica.Mechanics.MultiBody.Frames;
function from_Q 
  "从四元数方向对象Q返回方向对象R"
  extends Modelica.Icons.Function;
  input Quaternions.Orientation Q 
    "将坐标系1旋转到坐标系2的四元数方向对象";
  input SI.AngularVelocity w[3] 
    "坐标系2相对于坐标系1的角速度，在坐标系2下解析";
  output Orientation R "将坐标系1旋转到坐标系2的方向对象";
algorithm
  /*
  T := (2*Q[4]*Q[4] - 1)*identity(3) + 2*(outerProduct([Q[1:3],[Q[1:3]) - Q[4]*
    skew(Q[1:3]));
*/
  R := Orientation([2*(Q[1]*Q[1] + Q[4]*Q[4]) - 1, 2*(Q[1]*Q[2] + Q[3]*Q[4]),
     2*(Q[1]*Q[3] - Q[2]*Q[4]); 2*(Q[2]*Q[1] - Q[3]*Q[4]), 2*(Q[2]*Q[2] + Q[4] 
    *Q[4]) - 1, 2*(Q[2]*Q[3] + Q[1]*Q[4]); 2*(Q[3]*Q[1] + Q[2]*Q[4]), 2*(Q[3] 
    *Q[2] - Q[1]*Q[4]), 2*(Q[3]*Q[3] + Q[4]*Q[4]) - 1],w= w);
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
R = Frames.<strong>from_Q</strong>(Q, w);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数从四元数方向对象Q和角速度矢量w中返回一个
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Orientation\">方向对象</a>R。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.to_Q\">to_Q</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_Q\">TransformationMatrices.from_Q</a>.
</p>

</html>"));
end from_Q;