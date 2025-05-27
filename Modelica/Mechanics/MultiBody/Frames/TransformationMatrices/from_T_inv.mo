within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function from_T_inv 
  "从逆变换矩阵T_inv返回方向对象 R"
  extends Modelica.Icons.Function;
  input Real T_inv[3, 3] 
    "将矢量从坐标系2变换到坐标系1的逆变换矩阵(v1=T_inv*v2)";
  output TransformationMatrices.Orientation R 
    "将坐标系1旋转到坐标系2的方向对象";
algorithm
  R := Modelica.Math.Transpose(T_inv);
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
R = TransformationMatrices.<strong>from_T_inv</strong>(T_inv);
</pre></blockquote>

<h4>描述</h4>
<p>
该函数返回一个与实际输入矩阵&nbsp;T_inv&nbsp;逆矩阵相等的
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\"> transformation matrix </a>&nbsp;R。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.to_T_inv\">to_T_inv</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_T\">from_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_T_inv\">Frames.from_T_inv</a>.
</p>
</html>"));
end from_T_inv;