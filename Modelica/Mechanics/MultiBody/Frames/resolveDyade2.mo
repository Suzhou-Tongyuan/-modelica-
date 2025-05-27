within Modelica.Mechanics.MultiBody.Frames;
function resolveDyade2 
  "将二阶张量从坐标系1变换到坐标系2"
  extends Modelica.Icons.Function;
  input Orientation R "将坐标系1旋转到坐标系2的方向对象";
  input Real D1[3, 3] "在坐标系1中解析的二阶张量";
  output Real D2[3, 3] "在坐标系2中解析的二阶张量";
algorithm
  D2 := R.T*D1*transpose(R.T);
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
D2 = Frames.<strong>resolveDyade2</strong>(R, D1);
</pre></blockquote>

<h4>描述</h4>
<p>
函数调用<code>Frames.<strong>resolveDyade2</strong>(R12, D1)</code>使用描述将坐标系1旋转到坐标系2的方向对象R12。
从坐标系1中解析(= D1)返回二阶张量D在坐标系2中解析(= D2)。
</p>

<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.resolveDyade2\">TransformationMatrices.resolveDyade2</a>。
</p>
</html>"));
end resolveDyade2;