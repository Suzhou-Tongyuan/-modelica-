within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function to_vector "将旋转对象映射到矢量"
  extends Modelica.Icons.Function;
  input TransformationMatrices.Orientation T 
    "将坐标系1旋转到坐标系2的方向对象";
  output Real vec[9] "T的元素组成的矢量";
algorithm
  vec := {T[1, 1],T[2, 1],T[3, 1],T[1, 2],T[2, 2],T[3, 2],T[1, 3],T[2, 3],T[
    3, 3]};
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
vec = TransformationMatrices.<strong>to_vector</strong>(T);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数返回一个矢量vec，其中包含<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\"> transformation matrix</a>&nbsp;T的元素。
</p>

<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.to_T\">to_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.to_vector\">Frames.to_vector</a>.
</p>
</html>"));
end to_vector;