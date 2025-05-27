within Modelica.ComplexBlocks.Routing;
block ExtractSignal "从输入信号矢量中提取信号"
  extends Modelica.ComplexBlocks.Interfaces.ComplexMIMO;
  parameter Integer extract[nout] = 1:nout "提取矢量";

equation
  for i in 1:nout loop
    y[i] = u[extract[i]];
  end for;

  annotation(
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Rectangle(
    extent = {{-90, 51}, {-50, -49}}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid, 
    lineColor = {85, 170, 255}), 
    Rectangle(
    extent = {{50, 50}, {90, -50}}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid, 
    lineColor = {85, 170, 255}), 
    Polygon(
    points = {{-94.4104, 1.90792}, {-94.4104, -2.09208}, {-90.4104, -0.0920762}, 
    {-94.4104, 1.90792}}, 
    fillColor = {85, 170, 255}, 
    fillPattern = FillPattern.Solid, 
    lineColor = {85, 170, 255}), 
    Line(points = {{-72, 2}, {-60.1395, 12.907}, {-49.1395, 12.907}}, color = {85, 
    170, 255}), 
    Line(points = {{-73, 4}, {-59, 40}, {-49, 40}}, color = {85, 170, 255}), 
    Line(points = {{-113, 0}, {-76.0373, -0.0180176}}, color = {85, 170, 255}), 
    Line(points = {{-73, -5}, {-60, -40}, {-49, -40}}, color = {85, 170, 255}), 
    Line(points = {{-72, -2}, {-60.0698, -12.907}, {-49.0698, -12.907}}, color = {85, 
    170, 255}), 
    Polygon(
    points = {{-48.8808, -11}, {-48.8808, -15}, {-44.8808, -13}, {-48.8808, -11}}, 
    fillColor = {85, 170, 255}, 
    fillPattern = FillPattern.Solid, 
    lineColor = {85, 170, 255}), 
    Line(points = {{-46, 13}, {-35, 13}, {35, -30}, {45, -30}}, color = {85, 170, 
    255}), 
    Line(points = {{-45, 40}, {-35, 40}, {35, 0}, {44, 0}}, color = {85, 170, 255}), 
    Line(points = {{-45, -40}, {-34, -40}, {35, 30}, {44, 30}}, color = {85, 170, 
    255}), 
    Polygon(
    points = {{-49, 42}, {-49, 38}, {-45, 40}, {-49, 42}}, 
    fillColor = {85, 170, 255}, 
    fillPattern = FillPattern.Solid, 
    lineColor = {85, 170, 255}), 
    Polygon(
    points = {{-48.8728, -38.0295}, {-48.8728, -42.0295}, {-44.8728, -40.0295}, 
    {-48.8728, -38.0295}}, 
    fillColor = {85, 170, 255}, 
    fillPattern = FillPattern.Solid, 
    lineColor = {85, 170, 255}), 
    Polygon(
    points = {{-48.9983, 14.8801}, {-48.9983, 10.8801}, {-44.9983, 12.8801}, {-48.9983, 
    14.8801}}, 
    fillColor = {85, 170, 255}, 
    fillPattern = FillPattern.Solid, 
    lineColor = {85, 170, 255}), 
    Line(points = {{80, 0}, {100, 0}}, color = {85, 170, 255}), 
    Polygon(
    points = {{43.1618, 32.3085}, {43.1618, 28.3085}, {47.1618, 30.3085}, {
    43.1618, 32.3085}}, 
    fillColor = {85, 170, 255}, 
    fillPattern = FillPattern.Solid, 
    lineColor = {85, 170, 255}), 
    Polygon(
    points = {{43.2575, 1.80443}, {43.2575, -2.19557}, {47.2575, -0.195573}, {
    43.2575, 1.80443}}, 
    fillColor = {85, 170, 255}, 
    fillPattern = FillPattern.Solid, 
    lineColor = {85, 170, 255}), 
    Polygon(
    points = {{43.8805, -28.1745}, {43.8805, -32.1745}, {47.8805, -30.1745}, {
    43.8805, -28.1745}}, 
    fillColor = {85, 170, 255}, 
    fillPattern = FillPattern.Solid, 
    lineColor = {85, 170, 255}), 
    Line(points = {{48, 0}, {70, 0}}, color = {85, 170, 255}), 
    Line(points = {{47, 30}, {60, 30}, {73, 3}}, color = {85, 170, 255}), 
    Line(points = {{49, -30}, {60, -30}, {74, -4}}, color = {85, 170, 255}), 
    Text(
    extent = {{-150, -150}, {150, -110}}, 
    textString = "extract=%extract"), 
    Ellipse(
    extent = {{-81.0437, 4.59255}, {-71.0437, -4.90745}}, 
    fillColor = {85, 170, 255}, 
    fillPattern = FillPattern.Solid, 
    lineColor = {0, 0, 127}), 
    Ellipse(
    extent = {{69.3052, 4.12743}, {79.3052, -5.37257}}, 
    fillColor = {85, 170, 255}, 
    fillPattern = FillPattern.Solid, 
    lineColor = {0, 0, 127})}), 
    Documentation(info = "<html>
<p>
从输入连接器提取信号并传输到输出连接器。
</p>
<p>
提取方案由整数向量 'extract' 给出。该向量指定了要提取哪些输入信号，
并按照什么顺序将它们传输到输出向量中。请注意，'extract' 的维度必须与输出的数量匹配。
此外，输入连接器信号和输出连接器信号的维度必须通过参数 'nin' 和 'nout' 明确定义。</p>
<p>例如:</p>
<blockquote><pre>
nin  = 7 \"Number of inputs\";
nout = 4 \"Number of outputs\";
extract[nout] = {6,3,3,2} \"Extracting vector\";
</pre></blockquote>
<p>从长度为7的输入向量(nin=7)中提取四个输出信号（nout=4）：
</p>
<blockquote><pre>
output no. 1 is set equal to input no. 6
output no. 2 is set equal to input no. 3
output no. 3 is set equal to input no. 3
output no. 4 is set equal to input no. 2
</pre></blockquote>
</html>"));
end ExtractSignal;