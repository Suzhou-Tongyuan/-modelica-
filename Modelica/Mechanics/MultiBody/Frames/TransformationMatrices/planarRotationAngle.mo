within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function planarRotationAngle 
  "给定旋转轴和矢量在坐标系1和坐标系2中的表示，返回平面旋转的角度"

  extends Modelica.Icons.Function;
  input Real e[3](each final unit="1") 
    "使坐标系1绕e旋转到坐标系2的归一化旋转轴(长度必须为1)";
  input Real v1[3] 
    "在坐标系1中解析的矢量v(不得与e平行)";
  input Real v2[3] 
    "在坐标系2中解析的矢量v，即v2 = resolve2(planarRotation(e,angle),v1)";
  output SI.Angle angle 
    "将坐标系1沿轴e旋转到坐标系2的旋转角度范围：-pi <= angle <= pi";
algorithm
  /* 矢量v在坐标系1和坐标系2中的解析如下：
        (1)  v2 = (e*transpose(e) + (identity(3) - e*transpose(e))*cos(angle) - skew(e)*sin(angle))*v1;
                = e*(e*v1) + (v1 - e*(e*v1))*cos(angle) - cross(e,v1)*sin(angle)
       方程(1)乘以“v1”得到(注意：e*e =1)
            v1*v2 = (e*v1)*(e*v2) + (v1*v1 - (e*v1)*(e*v1))*cos(angle)
       因此：
        (2) cos(angle) = ( v1*v2 - (e*v1)*(e*v2)) / (v1*v1 - (e*v1)*(e*v1))
       同样，方程(1)乘以cross(e,v1)，即与e和v1正交的矢量a：
              cross(e,v1)*v2 = - cross(e,v1)*cross(e,v1)*sin(angle)
       因此：
          (3) sin(angle) = -cross(e,v1)*v2/(cross(e,v1)*cross(e,v1));
       我们有e*e=1；因此：
          (4) v1*v1 - (e*v1)*(e*v1) = |v1|^2 - (|v1|*cos(e,v1))^2
       和
          (5) cross(e,v1)*cross(e,v1) = (|v1|*sin(e,v1))^2
                                      = |v1|^2*(1 - cos(e,v1)^2)
                                      = |v1|^2 - (|v1|*cos(e,v1))^2
       根据(4)和(5)，(2)和(3)的分母是相同的。
       此外，根据(5)，分母始终为正。
       因此，在方程“angle = atan2(sin(angle), cos(angle))”中，可以消除sin(angle)和cos(angle)的分母，
       结果为：
          angle = atan2(-cross(e,v1)*v2, v1*v2 - (e*v1)*(e*v2));
    */
  angle := Modelica.Math.atan2(-cross(e, v1)*v2, v1*v2 - (e*v1)*(e*v2));
  annotation (Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
angle = TransformationMatrices.<strong>planarRotationAngle</strong>(e, v1, v2);
</pre></blockquote>

<h4>描述</h4>
<p>
调用此函数的形式为
</p>
<blockquote><pre>
  Real[3]                e, v1, v2;
  SI.Angle angle;
<strong>equation</strong>
  angle = <strong>planarRotationAngle</strong>(e, v1, v2);
</pre></blockquote>
<p>
计算平面旋转沿单位矢量<strong>e</strong>旋转坐标系1到坐标系2的旋转角度，给定矢量在坐标系1(<strong>v1</strong>)
和坐标系2(<strong>v2</strong>)中的坐标表示。因此，此函数的结果满足以下等式：
</p>
<blockquote><pre>
v2 = <strong>resolve2</strong>(<strong>planarRotation</strong>(e,angle), v1)
</pre></blockquote>
<p>
旋转角度返回在范围内
</p>
<blockquote><pre>
-&pi; &lt;= angle &lt;= &pi;
</pre></blockquote>
<p>
此函数对输入参数做出以下假设
</p>
<ul>
<li> 矢量<strong>e</strong>长度为1，即，length(e) =1</li>
<li> 矢量“v”不与<strong>e</strong>平行，即，
     length(cross(e,v1)) &ne; 0</li>
</ul>
<p>
该函数不检查上述假设。如果违反这些假设，将返回错误结果
和/或将出现除零。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.planarRotation\">planarRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.planarRotationAngle\">Frames.planarRotationAngle</a>.
</p>
</html>"));
end planarRotationAngle;