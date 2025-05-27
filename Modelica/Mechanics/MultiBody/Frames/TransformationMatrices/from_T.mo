within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function from_T "从变换矩阵 T 返回方向对象 R"
  extends Modelica.Icons.Function;
  input Real T[3, 3] 
    "将向量从坐标系1变换到坐标系2的变换矩阵 (v2=T*v1)";
  output TransformationMatrices.Orientation R 
    "将坐标系1旋转到坐标系2的方向对象";
algorithm
  R := T;
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
R = TransformationMatrices.<strong>from_T</strong>(T);
</pre></blockquote>

<h4>描述</h4>
<p>
该函数返回一个与实际输入矩阵&nbsp;T&nbsp;相等的
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\"> transformation matrix </a>&nbsp;R。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_T_inv\">from_T_inv</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.to_T\">to_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_T\">Frames.from_T</a>.
</p>
</html>"));
end from_T;