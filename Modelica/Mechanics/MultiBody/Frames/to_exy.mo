within Modelica.Mechanics.MultiBody.Frames;
function to_exy 
  "将旋转对象映射为坐标系2的轴e_x和e_y矢量在坐标系1中的解析"

  extends Modelica.Icons.Function;
  input Orientation R 
    "将坐标系1旋转到坐标系2的方向对象";
  output Real exy[3, 2] 
    "= [e_x, e_y]，其中e_x和e_y是表示坐标系2轴的单位矢量，在坐标系1中解析";
algorithm
  exy := [R.T[1, :], R.T[2, :]];
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
exy = Frames.<strong>to_exy</strong>(R);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数返回单位矢量e_x和e_y，它们定义了坐标系2的轴在坐标系1中解析的坐标列阵，
其中R是一个<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Orientation\">方向对象</a>，
用于将坐标系1旋转到坐标系2。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_nxy\">from_nxy</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_nxz\">from_nxz</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.to_exy\">TransformationMatrices.to_exy</a>.
</p>
</html>"));
end to_exy;