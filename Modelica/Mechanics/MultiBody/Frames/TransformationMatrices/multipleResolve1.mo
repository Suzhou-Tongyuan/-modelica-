within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function multipleResolve1 
  "将多个矢量从坐标系2转换到坐标系1"
  extends Modelica.Icons.Function;
  input TransformationMatrices.Orientation T 
    "旋转坐标系1至坐标系2的方向对象";
  input Real v2[3, :] "坐标系2中的矢量";
  output Real v1[3, size(v2, 2)] "坐标系1中的矢量";
algorithm
  v1 := transpose(T)*v2;
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
v1 = TransformationMatrices.<strong>multipleResolve1</strong>(T, v2);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数将在坐标系2中解析的多个矢量&nbsp;v 转换为在坐标系1中解析的矢量&nbsp;v1，使用描述将坐标系1旋转至坐标系2的
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.multipleResolve1\">Quaternions.multipleResolve1</a>.
</p>
</html>"));
end multipleResolve1;