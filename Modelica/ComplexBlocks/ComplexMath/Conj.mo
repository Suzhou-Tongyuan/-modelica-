within Modelica.ComplexBlocks.ComplexMath;
block Conj "输出等于输入信号的共轭复数"

  extends Modelica.ComplexBlocks.Interfaces.ComplexSISO(final useConjugateInput = true);

equation
  y = uInternal;
  annotation(
    Documentation(info = "<html>
<p>
该模块将输入信号<code>u</code>的<em>共轭复数</em>作为输出信号<code>y</code>。
</p>
<blockquote><pre>
y = Modelica.ComplexMath.conj(u)
</pre></blockquote>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
    100, 100}}), graphics = {Line(
    points = {{-40, 0}, {40, 0}}, 
    color = {85, 170, 255}), 
    Line(
    points = {{-40, 0}, {40, 0}}, 
    color = {85, 170, 255}, 
    rotation = 60), Line(
    points = {{-40, 0}, {40, 0}}, 
    color = {85, 170, 255}, 
    rotation = 120)}));
end Conj;