model IdealGyrator "理想回转器"
  extends Interfaces.TwoPort;
  parameter SI.Conductance G(start = 1) "回转导纳";

equation
  i1 = G * v2;
  i2 = -G * v1;
  annotation(defaultComponentName = "gyrator", 
    Documentation(info = "<html>
<p>
回转器是一个理想的双端元件，定义如下两个方程：

<br><br>
<code>
  i1 =  G * v2<br>
  i2 = -G * v1<br>
</code>
<br>
其中<em>G</em>为回转电导。
</p>

</html>", revisions = "<html>
<ul>

<li><em>1998年</em>
       Christoph Clauss<br>最初实现<br>
       </li>
</ul>

</html>"), 
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
    100}}, 
    grid = {2, 2}), graphics = {
    Line(points = {{-90, 100}, {-40, 100}, {-40, -100}, {-90, -100}}, 
    color = {0, 0, 255}), 
    Line(points = {{-30, 60}, {20, 60}}, color = {0, 0, 255}), 
    Polygon(
    points = {{20, 63}, {30, 60}, {20, 57}, {20, 63}}, 
    fillColor = {0, 0, 255}, 
    fillPattern = FillPattern.Solid, 
    lineColor = {0, 0, 255}), 
    Line(points = {{90, 100}, {40, 100}, {40, -100}, {90, -100}}, 
    color = {0, 0, 255}), 
    Text(
    extent = {{-150, 150}, {150, 110}}, 
    textString = "%name", 
    lineColor = {0, 0, 255}), 
    Line(
    points = {{-40, 30}, {-25, 28}, {-10, 12}, {-10, -12}, {-26, -28}, {-40, -30}}, 
    color = {0, 0, 255}, 
    smooth = Smooth.Bezier), 
    Line(
    points = {{-14, 30}, {1, 28}, {16, 12}, {16, -12}, {0, -28}, {-14, -30}}, 
    color = {0, 0, 255}, 
    smooth = Smooth.Bezier, 
    origin = {26, 0}, 
    rotation = 180), 
    Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 255})}));
end IdealGyrator;