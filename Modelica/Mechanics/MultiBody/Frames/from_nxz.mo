within Modelica.Mechanics.MultiBody.Frames;
function from_nxz 
  "返回从n_x和n_z矢量确定的固定方向对象"
  extends Modelica.Icons.Function;
  input Real n_x[3](each final unit="1") 
    "在坐标系1中解析的指向坐标系2的x轴方向的矢量";
  input Real n_z[3](each final unit="1") 
    "在坐标系1中解析的指向坐标系2的z轴方向的矢量";
  output Orientation R "将坐标系1旋转到坐标系2的方向对象";
algorithm
  R := Orientation(T=TransformationMatrices.from_nxz(n_x,n_z),w= zeros(3));
  annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
R = Frames.<strong>from_nxz</strong>(n_x, n_z);
</pre></blockquote>

<h4>描述</h4>
<p>
假定两个输入矢量n_x和n_z在坐标系1中解析，并且沿着坐标系2的x轴和z轴方向(即n_x和n_z是彼此正交的)。
该函数返回将坐标系1旋转到坐标系2的方向对象R。
</p>
<p>
该函数具有鲁棒性，即使n_z不正交于n_x，也始终返回方向对象R。
方法如下：
<br>
如果n_x和n_z不彼此正交，则首先确定一个单位矢量e_z，该矢量与n_x正交并位于由n_x和n_z张成的平面内。
如果n_x和n_z平行或几乎平行，则选择一个矢量e_z，使得n_x和e_z互相正交。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_nxz\">TransformationMatrices.from_nxz</a>.
</p>
</html>"));
end from_nxz;