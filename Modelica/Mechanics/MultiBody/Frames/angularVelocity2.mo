within Modelica.Mechanics.MultiBody.Frames;
function angularVelocity2 
  "从方向对象返回在坐标系2中解析的角速度"

  extends Modelica.Icons.Function;
  input Orientation R "将坐标系1旋转到坐标系2的方向对象";
  output SI.AngularVelocity w[3] 
    "相对于坐标系1解析的坐标系2的角速度，解析在坐标系2中";
algorithm
  w := R.w;
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
w = Frames.<strong>angularVelocity2</strong>(R);
</pre></blockquote>

<h4>描述</h4>
<p>
函数调用<code>Frames.<strong>angularVelocity1</strong>(R12)</code>返回
坐标系2相对于坐标系1的角速度<strong>解析在坐标系2中</strong>，
从描述将坐标系1旋转到坐标系2的方向对象R12。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.angularVelocity2\">TransformationMatrices.angularVelocity2</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.angularVelocity2\">Quaternions.angularVelocity2</a>.
</p>
</html>"));
end angularVelocity2;