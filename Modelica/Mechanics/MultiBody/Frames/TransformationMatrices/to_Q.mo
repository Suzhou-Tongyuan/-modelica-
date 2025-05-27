within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function to_Q 
  "从方向对象T返回四元数方向对象Q"

  extends Modelica.Icons.Function;
  input TransformationMatrices.Orientation T 
    "用于将坐标系1旋转到坐标系2的方向对象";
  input Quaternions.Orientation Q_guess=Quaternions.nullRotation() 
    "用于输出Q的初始猜测值(有2个解；选择离Q_guess更近的一个)";
  output Quaternions.Orientation Q 
    "用于将坐标系1旋转到坐标系2的四元数方向对象";
algorithm
  Q := Quaternions.from_T(T, Q_guess);
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
Q = TransformationMatrices.<strong>to_Q</strong>(T, Q_guess);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数返回一个<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternion object</a>&nbsp;Q，
根据一个<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">transformation matrix</a>&nbsp;T
和初始猜测值Q_guess计算得出。
</p>

<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_Q\">from_Q</a>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.to_Q\">Frames.to_Q</a>.
</p>
</html>"));
end to_Q;