within Modelica.Mechanics.MultiBody.Frames;
function resolve1 "将矢量从坐标系2转换到坐标系1"
  extends Modelica.Icons.Function;
  input Orientation R "将坐标系1旋转到坐标系2的方向对象";
  input Real v2[3] "坐标系2中的矢量";
  output Real v1[3] "坐标系1中的矢量";
algorithm
  v1 := transpose(R.T)*v2;
  annotation (
    derivative(noDerivative=R) = Internal.resolve1_der, 
    InlineAfterIndexReduction=true, 
    Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
v1 = Frames.<strong>resolve1</strong>(R, v2);
</pre></blockquote>

<h4>描述</h4>
<p>
函数调用<code>Frames.<strong>resolve1</strong>(R12, v2)</code>返回矢量v
在坐标系1中解析(= v1)，从在坐标系2中解析(= v2)的矢量v，使用描述将坐标系1旋转到坐标系2的方向对象R12。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.resolve2\">resolve2</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.resolve1\">TransformationMatrices.resolve1</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.resolve1\">Quaternions.resolve1</a>.
</p>
</html>"));
end resolve1;