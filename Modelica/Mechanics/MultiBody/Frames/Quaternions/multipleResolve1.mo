within Modelica.Mechanics.MultiBody.Frames.Quaternions;
function multipleResolve1 
  "将多个矢量从坐标系2转换到坐标系 1"
  extends Modelica.Icons.Function;
  input Quaternions.Orientation Q 
    "将坐标系1旋转到坐标系2的四元数方向对象";
  input Real v2[3, :] "坐标系2中的矢量";
  output Real v1[3, size(v2, 2)] "坐标系1中的矢量";
algorithm
  v1 := ((2*Q[4]*Q[4] - 1)*identity(3) + 2*(outerProduct(Q[1:3],Q[1:3]) + 
    Q[4]*skew(Q[1:3])))*v2;
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
v1 = Quaternions.<strong>multipleResolve1</strong>(Q, v2);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数从在坐标系2中解析的多个矢量v(=v2)使用
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternion orientation</a>&nbsp;Q，将坐标系1旋转到坐标系2。
返回在坐标系1中解析的矢量v(=v1)。
</p>

<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.multipleResolve1\">TransformationMatrices.multipleResolve1</a>.
</p>
</html>"));
end multipleResolve1;