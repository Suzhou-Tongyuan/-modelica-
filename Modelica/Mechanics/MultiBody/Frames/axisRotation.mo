within Modelica.Mechanics.MultiBody.Frames;
function axisRotation 
  "返回围绕一个坐标系轴沿角度旋转的旋转对象"

  extends Modelica.Icons.Function;
  input Integer axis(min=1, max=3) "围绕坐标系1的'axis'旋转";
  input SI.Angle angle 
    "将坐标系1旋转到坐标系2沿着坐标系1的'axis'的旋转角度";
  input SI.AngularVelocity der_angle "= der(angle)";
  output Orientation R "将坐标系1旋转到坐标系2的方向对象";
algorithm
  R := Orientation(T=(if axis == 1 then [1, 0, 0; 0, Modelica.Math.cos(angle), Modelica.Math.sin(angle);
    0, -Modelica.Math.sin(angle), Modelica.Math.cos(angle)] else if axis == 2 then [Modelica.Math.cos(angle), 0, -Modelica.Math.sin(
    angle); 0, 1, 0; Modelica.Math.sin(angle), 0, Modelica.Math.cos(angle)] else [Modelica.Math.cos(angle), Modelica.Math.sin(angle),
     0; -Modelica.Math.sin(angle), Modelica.Math.cos(angle), 0; 0, 0, 1]),w= if axis == 1 then {der_angle, 
    0,0} else if axis == 2 then {0,der_angle,0} else {0,0,der_angle});
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
R = Frames.<strong>axisRotation</strong>(axis, angle, der_angle);
</pre></blockquote>

<h4>描述</h4>
<p>
函数调用<code>Frames.<strong>axisRotation</strong>(axis, angle, der_angle)</code>返回描述沿单位轴<strong>axis</strong>
从坐标系1旋转到坐标系2的方向对象&nbsp;R，
角度为<strong>angle</strong>，角度导数为<strong>der_angle</strong>。
例如，Frames.axisRotation(2, phi, der_phi)返回与调用相同的方向对象
Frames.planarRotation({0,1,0}, phi, der_phi)
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.planarRotation\">planarRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.axisRotation\">TransformationMatrices.axisRotation</a>.
</p>
</html>"));
end axisRotation;