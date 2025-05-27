within Modelica.Mechanics.MultiBody.Frames;
function from_nxy 
  "返回从n_x和n_y矢量确定的固定方向对象"
  extends Modelica.Icons.Function;
  input Real n_x[3](each final unit="1") 
    "在坐标系1中解析的指向坐标系2的x轴方向的矢量";
  input Real n_y[3](each final unit="1") 
    "在坐标系1中解析的指向坐标系2的y轴方向的矢量";
  output Orientation R "将坐标系1旋转到坐标系2的方向对象";
algorithm
  R := Orientation(T=TransformationMatrices.from_nxy(n_x,n_y),w= zeros(3));
  annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
R = Frames.<strong>from_nxy</strong>(n_x, n_y);
</pre></blockquote>

<h4>描述</h4>
<p>
假设两个输入向量n_x和n_y在坐标系1中解析，并沿坐标系2的x轴和y轴定向(即n_x和n_y互为正交)。
函数返回从坐标系1旋转到坐标系2的方向对象R。
</p>
<p>
该函数具有鲁棒性，即使n_y不正交于n_x，也始终返回方向对象R。
方法如下：
<br>
如果n_x和n_y不彼此正交，则首先确定一个单位矢量e_y，该矢量与n_x正交并位于由n_x和n_y张成的平面内。
如果n_x和n_y平行或几乎平行，则选择一个矢量e_y，使得e_x和e_y互相正交。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_nxy\">TransformationMatrices.from_nxy</a>.
</p>
</html>"));
end from_nxy;