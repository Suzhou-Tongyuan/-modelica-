within Modelica.Mechanics.MultiBody.Frames;
function from_T2 
  "从变换矩阵T和其导数der(T)返回方向对象R"
  extends Modelica.Icons.Function;
  input Real T[3, 3] 
    "将矢量从坐标系 1 转换到坐标系 2 的变换矩阵 (v2=T*v1)";
  input Real der_T[3,3] "= der(T)";
  output Orientation R "将坐标系 1 旋转到坐标系 2 的方向对象";

algorithm
  R := Orientation(T=T,w={T[3, :]*der_T[2, :],-T[3, :]*der_T[1, :],T[2, :]*der_T[1, :]});
  annotation (Inline=true,Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
R = Frames.<strong>from_T2</strong>(T, der_T);
</pre></blockquote>

<h4>描述</h4>
<p>
从变换矩阵 T 和变换矩阵的导数 der(T) 计算方向对象。
通常情况下，更有效的做法是使用函数 \"from_T\"，其中角速度必须作为输入参数给出。
仅当这不可行或者计算过于困难时，才使用函数 from_T2(&hellip;)。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_T\">from_T</a>。
</p>
</html>"));
end from_T2;