within Modelica.Mechanics.MultiBody.Frames;
function planarRotationAngle 
  "给定旋转轴和其在坐标系1和坐标系2中表示的矢量，返回平面旋转的角度"

  extends Modelica.Icons.Function;
  input Real e[3](each final unit="1") 
    "将第一坐标系绕轴 e 旋转到第二坐标系的归一化旋转轴 (长度必须为 1)";
  input Real v1[3] 
    "在第一坐标系中表示的矢量 v(不能与 e 平行)";
  input Real v2[3] 
    "在第二坐标系中表示的矢量 v，即 v2 = resolve2(planarRotation(e,angle),v1)";
  output SI.Angle angle 
    "将第一坐标系绕轴 e 旋转到第二坐标系所需的旋转角度，范围为 -π 到 π";
algorithm
  /* 矢量 v 在第一坐标系和第二坐标系中的解析为：
        (1)  v2 = (e*transpose(e) + (identity(3) - e*transpose(e))*cos(angle) - skew(e)*sin(angle))*v1;
                = e*(e*v1) + (v1 - e*(e*v1))*cos(angle) - cross(e,v1)*sin(angle)
       方程 (1) 与 "v1" 相乘得到(注意：e*e = 1)
            v1*v2 = (e*v1)*(e*v2) + (v1*v1 - (e*v1)*(e*v1))*cos(angle)
       因此：
        (2) cos(angle) = ( v1*v2 - (e*v1)*(e*v2)) / (v1*v1 - (e*v1)*(e*v1))
       类似地，方程 (1) 与 cross(e,v1) 相乘，即与 e 和 v1 正交的矢量：
              cross(e,v1)*v2 = - cross(e,v1)*cross(e,v1)*sin(angle)
       因此：
          (3) sin(angle) = -cross(e,v1)*v2/(cross(e,v1)*cross(e,v1));
       我们有 e*e=1；因此：
          (4) v1*v1 - (e*v1)*(e*v1) = |v1|^2 - (|v1|*cos(e,v1))^2
       和
          (5) cross(e,v1)*cross(e,v1) = (|v1|*sin(e,v1))^2
                                      = |v1|^2*(1 - cos(e,v1)^2)
                                      = |v1|^2 - (|v1|*cos(e,v1))^2
       (2) 和 (3) 的分母是相同的，根据 (4) 和 (5)。
       此外，根据 (5)，分母始终为正。
       因此，在方程 "angle = atan2(sin(angle), cos(angle))" 中，sin(angle) 和 cos(angle) 的分母可以取消，
       结果为：
          angle = atan2(-cross(e,v1)*v2, v1*v2 - (e*v1)*(e*v2));
    */
  angle := Modelica.Math.atan2(-cross(e, v1)*v2, v1*v2 - (e*v1)*(e*v2));
  annotation (Inline=true, Documentation(info="<html>

<h4>语法</h4>
<blockquote><pre>
angle = Frames.<strong>planarRotationAngle</strong>(e, v1, v2);
</pre></blockquote>

<h4>描述</h4>
<p>
以如下形式调用此函数：
</p>
<blockquote><pre>
  Real[3]                e, v1, v2;
  SI.Angle angle;
<strong>equation</strong>
  angle = <strong>planarRotationAngle</strong>(e, v1, v2);
</pre></blockquote>
<p>
计算沿着单位矢量 <strong>e</strong> 进行平面旋转的旋转角度 \"<strong>angle</strong>\", 将第一坐标系旋转到第二坐标系，给定矢量 \"v\" 在第一坐标系 (<strong>v1</strong>) 和第二坐标系 (<strong>v2</strong>) 中的坐标表示。因此，此函数的结果满足以下方程：
</p>
<blockquote><pre>
v2 = <strong>resolve2</strong>(<strong>planarRotation</strong>(e,angle), v1)
</pre></blockquote>
<p>
旋转角度返回在以下范围内
</p>
<blockquote><pre>
-&pi; &lt;= angle &lt;= &pi;
</pre></blockquote>
<p>
此函数对输入参数作出以下假设：
</p>
<ul>
<li> 矢量 <strong>e</strong> 的长度为 1，即，length(e) = 1</li>
<li> 矢量 \"v\" 不与 <strong>e</strong> 平行，即，
     length(cross(e,v1)) &ne; 0</li>
</ul>
<p>
函数不检查上述假设。如果违反这些假设，将返回错误的结果和/或发生除零错误。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.planarRotation\">planarRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.planarRotationAngle\">TransformationMatrices.planarRotationAngle</a>.
</p>

</html>"));
end planarRotationAngle;