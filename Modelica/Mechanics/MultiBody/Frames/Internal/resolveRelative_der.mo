within Modelica.Mechanics.MultiBody.Frames.Internal;
function resolveRelative_der 
  "函数Frames.resolveRelative(..)的导数"
  import Modelica.Mechanics.MultiBody.Frames;
  extends Modelica.Icons.Function;
  input Real v1[3] "坐标系1中的矢量";
  input Orientation R1 "将坐标系0旋转到坐标系1的方向对象";
  input Orientation R2 "将坐标系0旋转到坐标系2的方向对象";
  input Real v1_der[3] "= der(v1)";
  output Real v2_der[3] "在坐标系2中解析的矢量v的导数";
algorithm
  v2_der := Frames.resolveRelative(v1_der+cross(R1.w,v1), R1, R2) 
            - cross(R2.w, Frames.resolveRelative(v1, R1, R2));

  /* skew(w) = T*der(T'), -skew(w) = der(T)*T'

     v2 = T2*(T1'*v1)
     der(v2) = der(T2)*T1'*v1 + T2*der(T1')*v1 + T2*T1'*der(v1)
             = der(T2)*T2'*T2*T1'*v1 + T2*T1'*T1*der(T1')*v1 + T2*T1'*der(v1)
             = -w2 x (T2*T1'*v1) + T2*T1'*(w1 x v1) + T2*T1'*der(v1)
             = T2*T1'*(der(v1) + w1 x v1) - w2 x (T2*T1'*v1)
  */
  annotation(Inline=true, Documentation(info="<html>
<p>
这是函数
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.resolveRelative\">resolveRelative</a>
的导数。
</p>
</html>"));
end resolveRelative_der;