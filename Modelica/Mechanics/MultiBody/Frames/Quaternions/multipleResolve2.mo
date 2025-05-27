within Modelica.Mechanics.MultiBody.Frames.Quaternions;
function multipleResolve2 
  "将多个向量从坐标系1转换到坐标系2"
  extends Modelica.Icons.Function;
  input Quaternions.Orientation Q 
    "将坐标系1旋转到坐标系2的四元数方向对象";
  input Real v1[3, :] "坐标系1中的向量";
  output Real v2[3, size(v1, 2)] "坐标系2中的向量";
algorithm
  v2 := ((2*Q[4]*Q[4] - 1)*identity(3) + 2*(outerProduct(Q[1:3],Q[1:3]) - 
    Q[4]*skew(Q[1:3])))*v1;
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
v2 = Quaternions.<strong>multipleResolve2</strong>(Q, v1);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数从在坐标系1中解析的多个向量v(=v1)使用<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternion orientation</a>&nbsp;Q将坐标系1旋转到坐标系2，返回在坐标系2中解析的向量v(=v2)。
</p>

<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.multipleResolve2\">TransformationMatrices.multipleResolve2</a>.
</p>
</html>"));
end multipleResolve2;