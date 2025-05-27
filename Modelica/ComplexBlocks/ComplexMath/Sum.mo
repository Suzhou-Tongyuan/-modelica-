within Modelica.ComplexBlocks.ComplexMath;
block Sum "输出输入向量元素之和"
  extends Interfaces.ComplexMISO;
  parameter Complex k[nin] = fill(Complex(1, 0), nin) 
    "可选：系数总和";
equation
  y = k * uInternal;
  annotation(
    defaultComponentName = "sum1", 
    Documentation(info = "<html>
<p>
这个模块计算输出信号 <code>y</code>，其值为输入信号向量 <code>u</code> 中所有元素的 <em>sum</em>。
</p>
<blockquote><pre>
y = u[1] + u[2] + ...;
</pre></blockquote>
<p>
示例:
</p>
<blockquote><pre>
  parameter:   nin = 3;

results in the following equations:

  y = u[1] + u[2] + u[3];
</pre></blockquote>

</html>"), 
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
    100, 100}}), graphics = {Line(
    points = {{26, 42}, {-34, 42}, {6, 2}, {-34, -38}, {26, -38}}, color = {85, 
    170, 255})}));
end Sum;