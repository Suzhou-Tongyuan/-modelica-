within Modelica.Mechanics.MultiBody.Frames.Quaternions;
function from_T_inv 
  "从逆变换矩阵 T_inv 返回四元数方向对象 Q"

  extends Modelica.Icons.Function;
  input Real T_inv[3, 3] 
    "将矢量从坐标系 2 转换到坐标系 1 的逆变换矩阵(v1=T_inv*v2)";
  input Quaternions.Orientation Q_guess=nullRotation() 
    "Q 的猜测值(有 2 个解；选择接近 Q_guess 的一个解)";
  output Quaternions.Orientation Q 
    "将坐标系 2 旋转到坐标系 1 的四元数方向对象(Q 和 -Q 具有相同的变换矩阵)";
algorithm
  Q := from_T(transpose(T_inv), Q_guess);
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
Q = Quaternions.<strong>from_T_inv</strong>(T_inv, Q_guess);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数从逆变换矩阵 T_inv 计算得到一个
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q。
取决于初始猜测 Q_guess。
通常，逆变换矩阵 T_inv 可以通过使用
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.inverseRotation\">inverseRotation</a>(T)等函数获得。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.from_T\">from_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_T_inv\">Frames.from_T_inv</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_T_inv\">TransformationMatrices.from_T_inv</a>。
</p>
</html>"));
end from_T_inv;