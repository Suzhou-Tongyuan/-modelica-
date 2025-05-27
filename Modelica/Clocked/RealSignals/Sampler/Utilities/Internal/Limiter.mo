within Modelica.Clocked.RealSignals.Sampler.Utilities.Internal;
block Limiter "限制信号范围"
  extends Clocked.RealSignals.Interfaces.PartialClockedSISO;
  parameter Real uMax(start = 1) "输入信号的上限";
  parameter Real uMin = -uMax "输入信号的下限";

equation
  assert(uMax >= uMin, "Limiter: 限制条件必须一致。uMax (= " + String(uMax) + 
    ") 小于 uMin (= " + String(uMin) + ")");
  y = if u > uMax then uMax else if u < uMin then uMin else u;
  annotation(
    Documentation(info = "<html>
<p>
Limiter块将输入信号作为输出信号，只要输入信号在指定的上下限范围内。如果输入信号超出范围，则会传递相应的限值作为输出。
</p>
</html>"), 
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Line(points = {{0, -90}, {0, 68}}, color = {192, 192, 192}), 
    Polygon(
    points = {{0, 90}, {-8, 68}, {8, 68}, {0, 90}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), 
    Polygon(
    points = {{90, 0}, {68, -8}, {68, 8}, {90, 0}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{-80, -70}, {-50, -70}, {50, 70}, {80, 70}}), 
    Text(
    extent = {{-150, -150}, {150, -110}}, 
    textString = "uMax=%uMax"), 
    Text(
    extent = {{-150, 150}, {150, 110}}, 
    textString = "%name", 
    textColor = {0, 0, 255})}), 
    Diagram(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Line(points = {{0, -60}, {0, 50}}, color = {192, 192, 192}), 
    Polygon(
    points = {{0, 60}, {-5, 50}, {5, 50}, {0, 60}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{-60, 0}, {50, 0}}, color = {192, 192, 192}), 
    Polygon(
    points = {{60, 0}, {50, -5}, {50, 5}, {60, 0}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{-50, -40}, {-30, -40}, {30, 40}, {50, 40}}), 
    Text(
    extent = {{46, -6}, {68, -18}}, 
    textColor = {128, 128, 128}, 
    textString = "u"), 
    Text(
    extent = {{-30, 70}, {-5, 50}}, 
    textColor = {128, 128, 128}, 
    textString = "y"), 
    Text(
    extent = {{-58, -54}, {-28, -42}}, 
    textColor = {128, 128, 128}, 
    textString = "uMin"), 
    Text(
    extent = {{26, 40}, {66, 56}}, 
    textColor = {128, 128, 128}, 
    textString = "uMax")}));
end Limiter;