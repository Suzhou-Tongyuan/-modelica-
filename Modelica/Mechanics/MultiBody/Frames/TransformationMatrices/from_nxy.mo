within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function from_nxy 
  "从n_x和n_y向量返回方向对象"
  extends Modelica.Icons.Function;
  import Modelica.Math.Vectors.length;
  import Modelica.Math.Vectors.normalize;

  input Real n_x[3](each final unit="1") 
    "坐标系1中指向坐标系2 x轴方向的向量";
  input Real n_y[3](each final unit="1") 
    "坐标系1中指向坐标系2 y轴方向的向量";
  output TransformationMatrices.Orientation T 
    "将坐标系1旋转到坐标系2的方向对象";
protected
  Real e_x[3](each final unit="1")=if length(n_x) < 1e-10 then {1,0,0} else normalize(n_x);
  Real e_y[3](each final unit="1")=if length(n_y) < 1e-10 then {0,1,0} else normalize(n_y);
  Real n_z_aux[3](each final unit="1")=cross(e_x, e_y);
  Real n_y_aux[3](each final unit="1")=if n_z_aux*n_z_aux > 1.0e-6 then e_y 
         else if abs(e_x[1]) > 1.0e-6 then {0,1,0} else {1,0,0};
  Real e_z_aux[3](each final unit="1")=cross(e_x, n_y_aux);
  Real e_z[3](each final unit="1")=normalize(e_z_aux);
algorithm
  T := {e_x,cross(e_z, e_x),e_z};
  annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
T = TransformationMatrices.<strong>from_nxy</strong>(n_x, n_y);
</pre></blockquote>

<h4>描述</h4>
<p>
假设两个输入向量n_x和n_y是在坐标系&nbsp;1中解析的，并且分别沿着坐标系&nbsp;2的x轴和y轴方向
(即，n_x和n_y彼此正交)。
该函数返回从坐标系&nbsp;1旋转到坐标系&nbsp;2的方向对象T。
</p>
<p>
该函数在以下意义上是有意义的：即使n_y不正交于n_x，它也始终返回一个方向对象T。
这是通过以下方式执行的：
<br>
如果n_x和n_y不彼此正交，则首先确定一个单位向量e_y，它正交于n_x并且位于n_x和n_y跨度的平面上。
如果n_x和n_y平行或几乎平行，则任意选择一个向量e_y，使得e_x和e_y彼此正交。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_nxy\">Frames.from_nxy</a>.
</p>
</html>"));
end from_nxy;