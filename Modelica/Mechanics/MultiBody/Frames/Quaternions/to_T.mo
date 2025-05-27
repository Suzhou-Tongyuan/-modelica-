within Modelica.Mechanics.MultiBody.Frames.Quaternions;
function to_T 
  "从四元数方向对象 Q 返回变换矩阵 T"

  extends Modelica.Icons.Function;
  input Quaternions.Orientation Q 
    "将坐标系 1 旋转到坐标系 2 的四元数方向对象";
  output Real T[3, 3] 
    "用于将矢量从坐标系 1 转换到坐标系 2 的变换矩阵 (v2=T*v1)";
algorithm
  /*
  T := (2*Q[4]*Q[4] - 1)*identity(3) + 2*(outerProduct(Q[1:3],Q[1:3]) - Q[4]*
    skew(Q[1:3]));
*/
  T := [2*(Q[1]*Q[1] + Q[4]*Q[4]) - 1, 2*(Q[1]*Q[2] + Q[3]*Q[4]), 2*(Q[1]*Q[
    3] - Q[2]*Q[4]); 2*(Q[2]*Q[1] - Q[3]*Q[4]), 2*(Q[2]*Q[2] + Q[4]*Q[4]) 
     - 1, 2*(Q[2]*Q[3] + Q[1]*Q[4]); 2*(Q[3]*Q[1] + Q[2]*Q[4]), 2*(Q[3]*Q[2] 
     - Q[1]*Q[4]), 2*(Q[3]*Q[3] + Q[4]*Q[4]) - 1];
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
T = Quaternions.<strong>to_T</strong>(Q);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数从四元数方向对象&nbsp;Q 计算出一个实数矩阵&nbsp;T。
<!--<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T-->
从一个
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q 计算出矩阵&nbsp;T。
矩阵&nbsp;T 被认为是一个对象变换矩阵。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.from_T\">from_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.to_T_inv\">to_T_inv</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.to_T\">Frames.to_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.to_T\">TransformationMatrices.to_T</a>.
</p>
</html>"));
end to_T;