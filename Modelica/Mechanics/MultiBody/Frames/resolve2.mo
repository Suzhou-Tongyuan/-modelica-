within Modelica.Mechanics.MultiBody.Frames;
function resolve2 "将矢量从坐标系1转换到坐标系2"
  extends Modelica.Icons.Function;
  input Orientation R "将坐标系1旋转到坐标系2的方向对象";
  input Real v1[3] "坐标系1中的矢量";
  output Real v2[3] "坐标系2中的矢量";
algorithm
  v2 := R.T*v1;
  annotation (
    derivative(noDerivative=R) = Internal.resolve2_der, 
    InlineAfterIndexReduction=true, 
    Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
v2 = Frames.<strong>resolve2</strong>(R, v1);
</pre></blockquote>

<h4>描述</h4>
<p>
函数调用<code>Frames.<strong>resolve2</strong>(R12, v1)</code>返回矢量v
在坐标系2中解析(= v2)，从在坐标系1中解析(= v1)的矢量v，使用orientation对象将坐标系1旋转到坐标系2的R12。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.resolve1\">resolve1</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.resolve2\">TransformationMatrices.resolve2</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.resolve2\">Quaternions.resolve2</a>.
</p>
</html>"));
end resolve2;