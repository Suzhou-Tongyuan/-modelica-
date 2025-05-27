within Modelica.Mechanics.MultiBody.Frames.Internal;
function resolve2_der "函数Frames.resolve2(..)的导数"
  import Modelica.Mechanics.MultiBody.Frames;
  extends Modelica.Icons.Function;
  input Orientation R "将坐标系1旋转到坐标系2的方向对象";
  input Real v1[3] "在坐标系1中解析的矢量";
  input Real v1_der[3] "= der(v1)";
  output Real v2_der[3] "在坐标系2中解析的矢量的导数";
algorithm
  v2_der := Frames.resolve2(R, v1_der) - cross(R.w, Frames.resolve2(R, v1));
  annotation(Inline=true, Documentation(info="<html>
<p>
这是函数
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.resolve2\">resolve2</a>
的导数。
</p>
</html>"));
end resolve2_der;