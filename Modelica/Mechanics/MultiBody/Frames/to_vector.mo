within Modelica.Mechanics.MultiBody.Frames;
function to_vector "将旋转对象映射为矢量"
  extends Modelica.Icons.Function;
  input Orientation R "将坐标系1旋转到坐标系2的方向对象";
  output Real vec[9] "R中的元素组成的一个矢量";
algorithm
  vec := {R.T[1, 1], R.T[2, 1], R.T[3, 1], R.T[1, 2], R.T[2, 2], R.T[3, 2], R.T[1, 3], R.T[2, 3], R.T[3, 3]};
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
vec = Frames.<strong>to_vector</strong>(R);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数返回一个矢量 vec，其中包含从一个
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Orientation\">方向对象</a>&nbsp;R
计算得到的变换矩阵&nbsp;T 的元素。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.to_T\">to_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.to_vector\">TransformationMatrices.to_vector</a>.
</p>
</html>"));
end to_vector;