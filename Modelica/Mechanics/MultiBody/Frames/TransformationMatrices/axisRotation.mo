within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function axisRotation 
  "返回绕一个坐标系轴旋转的旋转对象"
  extends Modelica.Icons.Function;
  input Integer axis(min=1, max=3) "绕坐标系1的'axis'旋转";
  input SI.Angle angle 
    "旋转角度，将坐标系1沿坐标系1的'axis'旋转到坐标系2";
  output TransformationMatrices.Orientation T 
    "将坐标系1旋转到坐标系2的方向对象";
algorithm
  T := if axis == 1 then [1, 0, 0; 0, Modelica.Math.cos(angle), Modelica.Math.sin(angle); 0, -Modelica.Math.sin(angle),
     Modelica.Math.cos(angle)] else if axis == 2 then [Modelica.Math.cos(angle), 0, -Modelica.Math.sin(angle); 0, 1, 0;
     Modelica.Math.sin(angle), 0, Modelica.Math.cos(angle)] else [Modelica.Math.cos(angle), Modelica.Math.sin(angle), 0;
    -Modelica.Math.sin(angle), Modelica.Math.cos(angle), 0; 0, 0, 1];
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
T = TransformationMatrices.<strong>axisRotation</strong>(axis, angle);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数返回描述绕单位轴<strong>axis</strong>从坐标系1旋转到坐标系2的方向的
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T，旋转角度为<strong>angle</strong>。
例如，TransformationMatrices.axisRotation(2, phi) 返回与调用TransformationMatrices.planarRotation({0,1,0}, phi)相同的方向对象
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.planarRotation\">planarRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.axisRotation\">Frames.axisRotation</a>.
</p>
</html>"));
end axisRotation;