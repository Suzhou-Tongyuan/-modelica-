within Modelica.Math;
function isPowerOf2 "确定输入的整数是否为2的幂"
  extends Modelica.Icons.Function;
  input Integer i(min=1) "整数标量";
  output Boolean result "= true，如果整数标量是2的幂";
algorithm
  assert(i>=1, "输入到isPowerOf2的整数必须>= 1");
  result := i == 2^integer(log(i)/log(2)+0.5);
  annotation (Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
Math.<strong>isPowerOf2</strong>(i);
</pre></blockquote>
<h4>描述</h4>
<p>
函数调用\"<code>Math.isPowerOf2(i)</code>\"返回<strong>true</strong>，
如果整数输入i是2的幂。否则函数
<strong>false</strong>。Integer输入必须为&gt;=1。
</p>
<h4>例子</h4>
<blockquote><pre>
  Integer i1 = 1;
  Integer i2 = 4;
  Integer i3 = 9;
  Boolean result;
<strong>algorithm</strong>
  result := Math.isPowerOf2(i1);     // = <strong>true</strong> 2^0
  result := Math.isPowerOf2(i2);     // = <strong>true</strong> 2^2
  result := Math.isPowerOf2(i3);     // = <strong>false</strong>
</pre></blockquote>
</html>"));
end isPowerOf2;