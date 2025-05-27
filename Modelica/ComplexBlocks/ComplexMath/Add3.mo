within Modelica.ComplexBlocks.ComplexMath;
block Add3 "输出三个输入的总和"
  extends Modelica.ComplexBlocks.Icons.ComplexBlock;

  parameter Complex k1 = Complex(1, 0) "上输入增益";
  parameter Boolean useConjugateInput1 = false 
    "如果为真，则处理输入1的共轭复数";

  parameter Complex k2 = Complex(1, 0) "中间输入增益";
  parameter Boolean useConjugateInput2 = false 
    "如果为真，则处理输入2的共轭复数";

  parameter Complex k3 = Complex(1, 0) "下输入增益";
  parameter Boolean useConjugateInput3 = false 
    "如果为真，则处理输入3的共轭复数";

  Interfaces.ComplexInput u1 "复数输入信号的连接器1" 
    annotation(Placement(transformation(extent = {{-140, 60}, {-100, 100}})));
  Interfaces.ComplexInput u2 "复数输入信号的连接器2" 
    annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
  Interfaces.ComplexInput u3 "复数输入信号的连接器3" 
    annotation(Placement(transformation(extent = {{-140, -100}, {-100, -60}})));
  Interfaces.ComplexOutput y "复数输出信号的连接器" 
    annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));

equation
  y = k1 * (if useConjugateInput1 then Modelica.ComplexMath.conj(u1) else u1) 
    + k2 * (if useConjugateInput2 then Modelica.ComplexMath.conj(u2) else u2) 
    + k3 * (if useConjugateInput3 then Modelica.ComplexMath.conj(u3) else u3);
  annotation(
    Documentation(info = "<html>
<p>
这个模块计算输出信号 <code>y</code>，为输入信号 <code>u1</code>、<code>u2</code> 
和 <code>u3</code> 的 <em>求和</em>。
可选地，当参数 <code>useConjugateInput1</code>、<code>useConjugateInput2</code> 和
<code>useConjugateInput3</code> 分别为 <code>true</code> 时，
输入 <code>u1</code>、<code>u2</code> 和 <code>u3</code> 可以被处理为共轭复数。
</p>
<blockquote><pre>
y = k1*(if useConjugateInput1 then Modelica.ComplexMath.conj(u1) else u1)
  + k2*(if useConjugateInput2 then Modelica.ComplexMath.conj(u2) else u2)
  + k3*(if useConjugateInput3 then Modelica.ComplexMath.conj(u3) else u3);
</pre></blockquote>
<p>
<strong>示例</strong>参数:
</p>
<ul>
<li><code>k1 = +2</code>,</li>
<li><code>k2 = -3</code>,</li>
<li><code>k3 = +1</code>,</li>
<li><code>useConjugateInput1 = true</code>,</li>
<li><code>useConjugateInput2 = false</code></li>
<li><code>useConjugateInput3 = false</code></li>
</ul>

<p>
导致下面的方程式：</p>
<blockquote><pre>
y = 2 * Modelica.ComplexMath.conj(u1) - 3 * u2 + u3;
</pre></blockquote>

</html>"), 
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
    100, 100}}), graphics = {Text(extent = {{-98, 50}, {5, 90}}, textString = "%k1"), 
    Text(extent = {{-98, -20}, {5, 20}}, textString = "%k2"), 
    Text(extent = {{-98, -50}, {5, -90}}, textString = "%k3"), 
    Text(extent = {{10, 40}, {90, -40}}, 
    textColor = {85, 170, 255}, 
    textString = "+")}));
end Add3;