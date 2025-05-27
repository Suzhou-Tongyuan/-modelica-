within Modelica.Mechanics.MultiBody.Frames;
function resolveDyade1 
  "将二阶张量从坐标系2变换到坐标系1"
  extends Modelica.Icons.Function;
  input Orientation R "将坐标系1旋转到坐标系2的方向对象";
  input Real D2[3, 3] "在坐标系2中解析的二阶张量";
  output Real D1[3, 3] "在坐标系1中解析的二阶张量";
algorithm
  D1 := transpose(R.T)*D2*R.T;
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
D1 = Frames.<strong>resolveDyade1</strong>(R, D2);
</pre></blockquote>

<h4>描述</h4>
<p>
函数调用<code>Frames.<strong>resolveDyade1</strong>(R12, D2)</code>使用描述将坐标系1旋转到坐标系2的方向对象R12,从坐标系2(= D2)中的表示返回在坐标系1（=D1）中解析的二阶张量D。
</p>

<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.resolveDyade1\">TransformationMatrices.resolveDyade1</a>。
</p>
</html>"));
end resolveDyade1;