within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function to_T_inv 
  "从方向对象R返回逆变换矩阵T_inv"

  extends Modelica.Icons.Function;
  input TransformationMatrices.Orientation R 
    "用于将坐标系1旋转到坐标系2的方向对象";
  output Real T_inv[3, 3] 
    "逆变换矩阵，用于将向量从坐标系2转换到坐标系1 (v1=T_inv*v2)";
algorithm
  T_inv := transpose(R);
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
T_inv = TransformationMatrices.<strong>to_T_inv</strong>(R);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数返回一个实数矩阵&nbsp;T_inv，
它是<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;R的逆。
</p>

<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_T_inv\">from_T_inv</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.to_T\">to_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.to_T_inv\">Frames.to_T_inv</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.to_T_inv\">Quaternions.to_T_inv</a>.
</p>
</html>"));
end to_T_inv;