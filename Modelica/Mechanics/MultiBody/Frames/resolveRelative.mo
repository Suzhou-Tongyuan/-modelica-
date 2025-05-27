within Modelica.Mechanics.MultiBody.Frames;
function resolveRelative 
  "使用坐标系1和坐标系2的绝对方向对象，将矢量从坐标系1下解析转换到坐标系2下解析"

  extends Modelica.Icons.Function;
  input Real v1[3] "坐标系1中的矢量";
  input Orientation R1 "将坐标系0旋转到坐标系1的方向对象";
  input Orientation R2 "将坐标系0旋转到坐标系2的方向对象";
  output Real v2[3] "坐标系2中的矢量";
algorithm
  v2 := resolve2(R2, resolve1(R1, v1));
  annotation (
    derivative(noDerivative=R1, noDerivative=R2) = Internal.resolveRelative_der, 
    InlineAfterIndexReduction=true, 
    Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
v2 = Frames.<strong>resolveRelative</strong>(v1, R1, R2);
</pre></blockquote>

<h4>描述</h4>
<p>
函数调用<code>Frames.<strong>resolveRelative</strong>(v1,R1,R2)</code>从坐标系1(=v1)中解析的向量v返回至坐标系2（=v1)中解析的向量v。给定的方向对象R1描述了将坐标系0转换至坐标系1的方向，方向对象R2描述了将坐标系0旋转到坐标系2的方向。
</p>
</html>"));
end resolveRelative;