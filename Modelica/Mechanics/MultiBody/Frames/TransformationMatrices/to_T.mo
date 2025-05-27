within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function to_T "从方向对象 R 返回变换矩阵 T"
  extends Modelica.Icons.Function;
  input TransformationMatrices.Orientation R 
    "将坐标系 1 旋转到坐标系 2 的方向对象";
  output Real T[3, 3] 
    "将矢量从坐标系 1 变换到坐标系 2 的变换矩阵 (v2=T*v1)";
algorithm
  T := R;
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
T = TransformationMatrices.<strong>to_T</strong>(R);
</pre></blockquote>

<h4>描述</h4>
<p>
该函数返回一个实矩阵&nbsp;T，等于一个
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Orientation\"> quaternion object</a>&nbsp;R。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_T\">from_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.to_T_inv\">to_T_inv</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.to_T\">Frames.to_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.to_T\">Quaternions.to_T</a>.
</p>
</html>"));
end to_T;