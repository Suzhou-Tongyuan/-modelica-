within Modelica.Mechanics.MultiBody.Frames.Quaternions;
function resolve2 "从坐标系1到坐标系2的变换矢量"
  extends Modelica.Icons.Function;
  input Quaternions.Orientation Q 
    "将坐标系 1旋转到坐标系 2的四元数方向对象";
  input Real v1[3] "坐标系 1中的矢量";
  output Real v2[3] "坐标系 2中的矢量";
algorithm
  v2 := 2*((Q[4]*Q[4] - 0.5)*v1 + (Q[1:3]*v1)*Q[1:3] - Q[4]*cross(Q[1:3], 
    v1));
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
v2 = Quaternions.<strong>resolve2</strong>(Q, v1);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数从在坐标系1中解析的矢量v(=v1)使用将坐标系1旋转到坐标系2的
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q，
返回在坐标系2中解析的矢量v(=v2)。
</p>

<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.resolve1\">resolve1</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.resolve2\">Frames.resolve2</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.resolve2\">TransformationMatrices.resolve2</a>.
</p>
</html>"));
end resolve2;