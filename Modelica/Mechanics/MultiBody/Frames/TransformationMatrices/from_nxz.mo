within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function from_nxz "从 n_x 和 n_z 矢量返回方向对象"
  extends Modelica.Icons.Function;
  import Modelica.Math.Vectors.length;
  import Modelica.Math.Vectors.normalize;

  input Real n_x[3](each final unit="1") 
    "在坐标系1中解析的指向 x 轴的矢量，解析为坐标系2";
  input Real n_z[3](each final unit="1") 
    "在坐标系1中解析的指向 z 轴的矢量，解析为坐标系2";
  output TransformationMatrices.Orientation T 
    "将坐标系1旋转到坐标系2 的方向对象";
protected
  Real e_x[3](each final unit="1")=if length(n_x) < 1e-10 then {1,0,0} else normalize(n_x);
  Real e_z[3](each final unit="1")=if length(n_z) < 1e-10 then {0,0,1} else normalize(n_z);
  Real n_y_aux[3](each final unit="1")=cross(e_z, e_x);
  Real n_z_aux[3](each final unit="1")=if n_y_aux*n_y_aux > 1.0e-6 then e_z 
         else if abs(e_x[1]) > 1.0e-6 then {0,0,1} else {1,0,0};
  Real e_y_aux[3](each final unit="1")=cross(n_z_aux, e_x);
  Real e_y[3](each final unit="1")=normalize(e_y_aux);
algorithm
  T := {e_x,e_y,cross(e_x, e_y)};
  annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
T = TransformationMatrices.<strong>from_nxz</strong>(n_x, n_z);
</pre></blockquote>

<h4>描述</h4>
<p>
假设两个输入矢量 n_x 和 n_z 解析为坐标系 1，并且指向坐标系2 的 x 轴和 z 轴(即，n_x 和 n_z 互相垂直)。
该函数返回方向对象 T，以将坐标系1旋转到坐标系2。
</p>
<p>
该函数在某种程度上是健壮的，即使 n_z 不与 n_x 垂直，它也始终返回一个方向对象 T。
具体操作如下：
<br>
如果 n_x 和 n_z 不互相垂直，首先确定一个单位矢量 e_z，它与 n_x 垂直并位于由 n_x 和 n_z 张成的平面上。
如果 n_x 和 n_z 平行或几乎平行，将任意选择一个矢量 e_z，使得 n_x 和 e_z 互相垂直。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_nxz\">Frames.from_nxz</a>.
</p>
</html>"));
end from_nxz;