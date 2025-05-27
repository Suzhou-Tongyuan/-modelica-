within Modelica.Mechanics.MultiBody.Frames.Internal;
function resolve1_der "函数Frames.resolve1(..)的导数"
  import Modelica.Mechanics.MultiBody.Frames;
  extends Modelica.Icons.Function;
  input Orientation R "将坐标系1旋转到坐标系2的方向对象";
  input Real v2[3] "在坐标系2中解析的矢量";
  input Real v2_der[3] "= der(v2)";
  output Real v1_der[3] "在坐标系1中解析的矢量的导数";
algorithm
  v1_der := Frames.resolve1(R, v2_der + cross(R.w, v2));
  annotation(Inline = true, Documentation(info = "<html>
<p>
这是函数
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.resolve1\">resolve1</a>
的导数。
</p>
</html>"));
end resolve1_der;