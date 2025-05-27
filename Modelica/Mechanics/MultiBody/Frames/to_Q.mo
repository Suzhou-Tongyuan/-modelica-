within Modelica.Mechanics.MultiBody.Frames;
function to_Q 
  "从方向对象R返回四元数方向对象Q"

  extends Modelica.Icons.Function;
  input Orientation R "将坐标系1旋转到坐标系2的方向对象";
  input Quaternions.Orientation Q_guess=Quaternions.nullRotation() 
    "输出Q的猜测值(有2个解决方案；选择离Q_guess更近的那个)";
  output Quaternions.Orientation Q 
    "将坐标系1旋转到坐标系2的四元数方向对象";
algorithm
  Q := Quaternions.from_T(R.T, Q_guess);
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
Q = Frames.<strong>to_Q</strong>(R, Q_guess);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数从一个
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Orientation\">方向对象</a>R
计算并得到一个<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">四元数对象</a>Q，
取决于初始猜测值Q_guess。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_Q\">from_Q</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.to_Q\">TransformationMatrices.to_Q</a>.
</p>
</html>"));
end to_Q;