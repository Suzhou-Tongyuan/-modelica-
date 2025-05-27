within Modelica.Mechanics.MultiBody.Frames.Quaternions;
function resolve1 "将矢量从坐标系2解析到坐标系1"
  extends Modelica.Icons.Function;
  input Quaternions.Orientation Q 
    "将坐标系1旋转到坐标系2的四元数方向对象";
  input Real v2[3] "坐标系2中的矢量";
  output Real v1[3] "坐标系1中的矢量";
algorithm
  v1 := 2*((Q[4]*Q[4] - 0.5)*v2 + (Q[1:3]*v2)*Q[1:3] + Q[4]*cross(Q[1:3], 
    v2));
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
v1 = Quaternions.<strong>resolve1</strong>(Q, v2);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数从在坐标系 2中解析的矢量v(=v2)使用描述将坐标系1旋转到坐标系2的
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q，
返回在坐标系1中解析的矢量v(=v1)。
</p>

<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.resolve2\">resolve2</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.resolve1\">Frames.resolve1</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.resolve1\">TransformationMatrices.resolve1</a>.
</p>
</html>"));
end resolve1;