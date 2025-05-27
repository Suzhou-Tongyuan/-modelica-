within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function angularVelocity2 
  "返回方位对象在坐标系2中的角速度及其导数"

  extends Modelica.Icons.Function;
  input TransformationMatrices.Orientation T 
    "用于将坐标系1旋转到坐标系2的方向对象";
  input der_Orientation der_T "T的导数";
  output SI.AngularVelocity w[3] 
    "相对于坐标系1解析的坐标系2中的角速度";
algorithm
  /* 相对于坐标系1解析的坐标系2中的角速度w，定义为：
        w = vec(T*der(transpose(T)));
     其中
                   |   0 -w3  w2 |
         skew(w) = |  w3   0 -w1 |，且 w = vec(skew(w))
                   | -w2  w1   0 |
     即
         W = T*der(transpose(T))
         w = {W(3,2), -W(3,1), W(2,1)}
     因此，只需要计算W的3个值：
             | T[1,:] |
         W = | T[2,:] | * | der(T[1,:]), der(T[2,:]), der(T[3,:]) |
             | T[3,:] |
             |  W(3,2) |   |  T[3,:]*der(T[2,:]) |
         w = | -W(3,1) | = | -T[3,:]*der(T[1,:]) |
             |  W(2,1) |   |  T[2,:]*der(T[1,:]) |
  */
  w := {T[3, :]*der_T[2, :],-T[3, :]*der_T[1, :],T[2, :]*der_T[1, :]};
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
w = TransformationMatrices.<strong>angularVelocity2</strong>(T, der_T);
</pre></blockquote>

<h4>描述</h4>
<p>
该函数根据描述将坐标系1旋转到坐标系2的方向矩阵T及其一阶导数der_T，返回在坐标系2中解析的坐标系2相对于坐标系1的角速度w。
</p>
<blockquote><pre>
w = vec( T * der(transpose(T)) ).
</pre></blockquote>

<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.angularVelocity2\">Frames.angularVelocity2</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.angularVelocity2\">Quaternions.angularVelocity2</a>.
</p>
</html>"));
end angularVelocity2;