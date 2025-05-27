within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function angularVelocity1 
  "返回在坐标系1中解析的方向对象及其导数的角速度"

  extends Modelica.Icons.Function;
  input TransformationMatrices.Orientation T 
    "将坐标系1旋转到坐标系2的方向对象";
  input der_Orientation der_T "T的导数";
  output SI.AngularVelocity w[3] 
    "相对于坐标系1解析的坐标系2的角速度";
algorithm
  /* 坐标系2相对于坐标系1在坐标系1中解析的角速度w定义为：
        w = vec(der(transpose(T))*T );
     其中
                   |   0 -w3  w2 |
         skew(w) = |  w3   0 -w1 | 并且 w = vec(skew(w))
                   | -w2  w1   0 |
     即
         W = der(transpose(T))*T)
         w = {W(3,2), -W(3,1), W(2,1)}
     因此，只需要计算W的3个值：
             | der(T[:,1]) |
         W = | der(T[:,2]) | * | T[:,1], T[:,2], T[:,3] |
             | der(T[:,3]) |
             |  W(3,2) |   |  der(T[:,3])*T[:,2] |
         w = | -W(3,1) | = | -der(T[:,3])*T[:,1] |
             |  W(2,1) |   |  der(T[:,2])*T[:,1] |
  */
  w := {der_T[:, 3]*T[:, 2],-der_T[:, 3]*T[:, 1],der_T[:, 2]*T[:, 1]};
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
w = TransformationMatrices.<strong>angularVelocity1</strong>(T, der_T);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数从描述将坐标系1旋转到坐标系2的方向的变换矩阵
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">T</a>
及其一阶导数<strong>der_T</strong>中返回在坐标系1中解析的坐标系2的角速度<strong>w</strong>。
</p>
<blockquote><pre>
w = vec( der(transpose(T)) * T ).
</pre></blockquote>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.angularVelocity1\">Frames.angularVelocity1</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.angularVelocity1\">Quaternions.angularVelocity1</a>.
</p>
</html>"));
end angularVelocity1;