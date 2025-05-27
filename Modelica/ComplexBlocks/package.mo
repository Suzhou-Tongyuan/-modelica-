within Modelica;
package ComplexBlocks "复数信号基本输入/输出控制模块库"
  extends Modelica.Icons.Package;

  annotation(Documentation(info = "<html>
<p>这个库用于承载使用复数输入和输出的模块。</p>
<p>这取决于复数的实现情况。</p>
</html>"), Icon(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, 
    preserveAspectRatio = true), graphics = {
    Rectangle(
    origin = {0.0, 35.1488}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid, 
    extent = {{-30.0, -20.1488}, {30.0, 20.1488}}), 
    Rectangle(
    origin = {0.0, -34.8512}, 
    fillColor = {128, 128, 128}, 
    fillPattern = FillPattern.Solid, 
    extent = {{-30.0, -20.1488}, {30.0, 20.1488}}), 
    Line(origin = {-51.25, 0.0}, points = {{21.25, -35.0}, {-13.75, -35.0}, {-13.75, 
    35.0}, {6.25, 35.0}}), 
    Polygon(
    origin = {-40.0, 35.0}, 
    pattern = LinePattern.None, 
    fillPattern = FillPattern.Solid, 
    points = {{10.0, 0.0}, {-5.0, 5.0}, {-5.0, -5.0}}), 
    Line(origin = {51.25, 0.0}, points = {{-21.25, 35.0}, {13.75, 35.0}, {13.75, -35.0}, 
    {-6.25, -35.0}}), 
    Polygon(
    origin = {40.0, -35.0}, 
    pattern = LinePattern.None, 
    fillPattern = FillPattern.Solid, 
    points = {{-10.0, 0.0}, {5.0, 5.0}, {5.0, -5.0}})}));
end ComplexBlocks;