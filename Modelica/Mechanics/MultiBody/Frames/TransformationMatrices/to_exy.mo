within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function to_exy 
  "将旋转对象映射为坐标系2的e_x和e_y矢量在坐标系1中进行解析"

  extends Modelica.Icons.Function;
  input TransformationMatrices.Orientation T 
    "将坐标系1旋转到坐标系2的方向对象";
  output Real exy[3, 2] 
    "= [e_x, e_y]，其中e_x和e_y是表示坐标系2轴的单位矢量，在坐标系1中解析";
algorithm
  exy := [T[1, :], T[2, :]];
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
exy = TransformationMatrices.<strong>to_exy</strong>(T);
</pre></blockquote>

<h4>描述</h4>
<p>
该函数返回单位矢量e_x和e_y，它们定义了坐标系2的轴在坐标系1中解析，
其中的T是一个<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\">变换矩阵</a>，
用于将坐标系1旋转到坐标系2。
</p>

<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_nxy\">from_nxy</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_nxz\">from_nxz</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.to_exy\">Frames.to_exy</a>.
</p>
</html>"));
end to_exy;