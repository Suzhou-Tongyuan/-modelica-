within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function resolveDyade1 
  "将二阶张量从坐标系2转换到坐标系1"
  extends Modelica.Icons.Function;
  input TransformationMatrices.Orientation T 
    "旋转坐标系1至坐标系2的方向对象";
  input Real D2[3, 3] "在坐标系2中解析的二阶张量";
  output Real D1[3, 3] "在坐标系1中解析的二阶张量";
algorithm
  D1 := transpose(T)*D2*T;
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
D1 = TransformationMatrices.<strong>resolveDyade1</strong>(T, D2);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数从在坐标系2中的表示(即D2)返回在坐标系1中解析的二阶张量&nbsp;D(即D1)，使用描述将坐标系1旋转至坐标系2的
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.resolveDyade1\">Frames.resolveDyade1</a>.
</p>
</html>"));
end resolveDyade1;