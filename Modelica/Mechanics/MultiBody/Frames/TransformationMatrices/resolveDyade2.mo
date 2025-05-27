within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function resolveDyade2 
  "将二阶张量从坐标系1转换到坐标系2"
  extends Modelica.Icons.Function;
  input TransformationMatrices.Orientation T 
    "旋转坐标系1至坐标系2的方向对象";
  input Real D1[3, 3] "在坐标系1中解析的二阶张量";
  output Real D2[3, 3] "在坐标系2中解析的二阶张量";
algorithm
  D2 := T*D1*transpose(T);
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
D2 = TransformationMatrices.<strong>resolveDyade2</strong>(T, D1);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数从在坐标系1中的表示(即D1)返回在坐标系2中解析的二阶张量&nbsp;D(即D2)，使用描述将坐标系1旋转至坐标系2的<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.resolveDyade2\">Frames.resolveDyade2</a>.
</p>
</html>"));
end resolveDyade2;