within Modelica.Mechanics.MultiBody.Frames.Quaternions;
function to_T_inv 
  "从四元数方向对象 Q 返回逆变换矩阵 T_inv"

  extends Modelica.Icons.Function;
  input Quaternions.Orientation Q 
    "将坐标系 1 旋转到坐标系 2 的四元数方向对象";
  output Real T_inv[3, 3] 
    "用于将矢量从坐标系 2 转换到坐标系 1 的变换矩阵 (v1=T_inv*v2)";
algorithm
  /*
  T_inv := (2*Q[4]*Q[4] - 1)*identity(3) + 2*(outerProduct(Q[1:3],Q[1:3]) + Q[
    4]*skew(Q[1:3]));
*/
  T_inv := [2*(Q[1]*Q[1] + Q[4]*Q[4]) - 1, 2*(Q[2]*Q[1] - Q[3]*Q[4]), 2*(Q[
    3]*Q[1] + Q[2]*Q[4]); 2*(Q[1]*Q[2] + Q[3]*Q[4]), 2*(Q[2]*Q[2] + Q[4]*Q[
    4]) - 1, 2*(Q[3]*Q[2] - Q[1]*Q[4]); 2*(Q[1]*Q[3] - Q[2]*Q[4]), 2*(Q[2]* 
    Q[3] + Q[1]*Q[4]), 2*(Q[3]*Q[3] + Q[4]*Q[4]) - 1];
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
T_inv = Quaternions.<strong>to_T_inv</strong>(Q);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数从四元数方向对象&nbsp;Q 计算出一个实数矩阵&nbsp;T_inv。
<!--<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T_inv-->
从一个
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q 计算出逆变换矩阵&nbsp;T_inv。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.to_T\">to_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.from_T_inv\">from_T_inv</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.to_T_inv\">Frames.to_T_inv</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.to_T_inv\">TransformationMatrices.to_T_inv</a>.
</p>
</html>"));
end to_T_inv;