within Modelica.Mechanics.MultiBody.Frames;
function to_T "从方向对象R返回转换矩阵 T"
  extends Modelica.Icons.Function;
  input Orientation R "将坐标系1旋转到坐标系2的方向对象";
  output Real T[3, 3] 
    "将向量从坐标系1转换到坐标系2的转换矩阵(v2=T*v1)";
algorithm
  T := R.T;
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
T = Frames.<strong>to_T</strong>(R);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数从一个
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Orientation\">方向对象</a>R
计算并得到一个实数矩阵T。矩阵T被视为一个对象转换矩阵。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_T\">from_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.to_T_inv\">to_T_inv</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.to_T\">TransformationMatrices.to_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.to_T\">Quaternions.to_T</a>.
</p>
</html>"));
end to_T;