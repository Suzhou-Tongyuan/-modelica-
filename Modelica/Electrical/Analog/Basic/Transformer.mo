within Modelica.Electrical.Analog.Basic;
model Transformer "变压器"
  extends Interfaces.TwoPort(i1(start = 0), i2(start = 0));
  parameter SI.Inductance L1(start = 1) "主电感";
  parameter SI.Inductance L2(start = 1) "次电感";
  parameter SI.Inductance M(start = 1) "耦合电感";
  Real dv "Difference between voltage drop over primary inductor and voltage drop over secondary inductor";
equation
  v1 = L1 * der(i1) + M * der(i2);

  /* Original equation:
  v2 = M*der(i1) + L2*der(i2);
  If L1 = L2 = M, then this model has one state less. However,
  it might be difficult for a tool to detect this. For this reason
  the model is defined with a relative potential:
  */
  dv = (L1 - M) * der(i1) + (M - L2) * der(i2);
  v2 = v1 - dv;

  annotation(
    Documentation(info = "<html>
<p>变压器是一个双端口设备。左端口的电压为<em>v1</em>，左端口的电流为<em>i1</em>，右端口的电压为<em>v2</em>，右端口的电流为<em>i2</em>，它们之间的关系如下：</p>
<blockquote><pre>
| v1 |         | L1   M  |  | i1&#39; |
|    |    =    |         |  |     |
| v2 |         | M    L2 |  | i2&#39; |
</pre></blockquote>
<p><em>L1</em>、<em>L2</em>和<em>M</em>分别是初级、次级和耦合电感。</p>
</html>", 
    revisions = "<html>
<ul>
<li><em> 1998   </em>
       Christoph Clauss<br>创建<br>
       </li>
</ul>

</html>"), 
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
    100}}), graphics = {
    Text(
    extent = {{-150, 150}, {150, 110}}, 
    textString = "%name", 
    textColor = {0, 0, 255}), 
    Text(
    extent = {{-20, -60}, {20, -100}}, 
    textString = "M", 
    textColor = {0, 0, 255}), 
    Line(points = {{-40, 60}, {-40, 100}, {-90, 100}}, color = {0, 0, 255}), 
    Line(points = {{40, 60}, {40, 100}, {90, 100}}, color = {0, 0, 255}), 
    Line(points = {{-40, -60}, {-40, -100}, {-90, -100}}, color = {0, 0, 255}), 
    Line(points = {{40, -60}, {40, -100}, {90, -100}}, color = {0, 0, 255}), 
    Line(
    points = {{-15, -7}, {-14, -1}, {-7, 7}, {7, 7}, {14, -1}, {15, -7}}, 
    color = {0, 0, 255}, 
    smooth = Smooth.Bezier, 
    origin = {-33, 45}, 
    rotation = 270), 
    Line(
    points = {{-15, -7}, {-14, -1}, {-7, 7}, {7, 7}, {14, -1}, {15, -7}}, 
    color = {0, 0, 255}, 
    smooth = Smooth.Bezier, 
    origin = {-33, 15}, 
    rotation = 270), 
    Line(
    points = {{-15, -7}, {-14, -1}, {-7, 7}, {7, 7}, {14, -1}, {15, -7}}, 
    color = {0, 0, 255}, 
    smooth = Smooth.Bezier, 
    origin = {-33, -15}, 
    rotation = 270), 
    Line(
    points = {{-15, -7}, {-14, -1}, {-7, 7}, {7, 7}, {14, -1}, {15, -7}}, 
    color = {0, 0, 255}, 
    smooth = Smooth.Bezier, 
    origin = {-33, -45}, 
    rotation = 270), 
    Line(
    points = {{-15, -7}, {-14, -1}, {-7, 7}, {7, 7}, {14, -1}, {15, -7}}, 
    color = {0, 0, 255}, 
    smooth = Smooth.Bezier, 
    origin = {33, 45}, 
    rotation = 90), 
    Line(
    points = {{-15, -7}, {-14, -1}, {-7, 7}, {7, 7}, {14, -1}, {15, -7}}, 
    color = {0, 0, 255}, 
    smooth = Smooth.Bezier, 
    origin = {33, 15}, 
    rotation = 90), 
    Line(
    points = {{-15, -7}, {-14, -1}, {-7, 7}, {7, 7}, {14, -1}, {15, -7}}, 
    color = {0, 0, 255}, 
    smooth = Smooth.Bezier, 
    origin = {33, -15}, 
    rotation = 90), 
    Line(
    points = {{-15, -7}, {-14, -1}, {-7, 7}, {7, 7}, {14, -1}, {15, -7}}, 
    color = {0, 0, 255}, 
    smooth = Smooth.Bezier, 
    origin = {33, -45}, 
    rotation = 90), 
    Text(
    extent = {{-100, 20}, {-58, -20}}, 
    textString = "L1", 
    textColor = {0, 0, 255}), 
    Text(
    extent = {{60, 20}, {100, -20}}, 
    textString = "L2", 
    textColor = {0, 0, 255})}));
end Transformer;