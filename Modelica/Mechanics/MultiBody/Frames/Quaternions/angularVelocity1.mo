within Modelica.Mechanics.MultiBody.Frames.Quaternions;
function angularVelocity1 
  "从四元数方向对象及其导数计算在坐标系1中解析的角速度"

  extends Modelica.Icons.Function;
  input Quaternions.Orientation Q 
    "将坐标系1旋转到坐标系2的四元数方向对象";
  input der_Orientation der_Q "Q的导数";
  output SI.AngularVelocity w[3] 
    "坐标系2相对于坐标系1的角速度在坐标系1中解析";
algorithm
  w := 2*([Q[4], -Q[3], Q[2], -Q[1]; Q[3], Q[4], -Q[1], -Q[2]; -Q[2], Q[1],
     Q[4], -Q[3]]*der_Q);
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
w = Quaternions.<strong>angularVelocity1</strong>(Q, der_Q);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数从描述将frame&nbsp;1旋转到frame&nbsp;2的方向的
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q及其第一时间导数der_Q，
返回frame&nbsp;2相对于frame&nbsp;1的角速度w，<strong>解析在frame&nbsp;1中</strong>。
</p>

<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.angularVelocity1\">Frames.angularVelocity1</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.angularVelocity1\">TransformationMatrices.angularVelocity1</a>.
</p>
</html>"));
end angularVelocity1;