within Modelica.Math;
function wrapAngle "将角度归一化到区间]-pi,pi]或[0,2*pi["
  extends Modelica.Math.Icons.AxisCenter;
  import Modelica.Constants.pi;
  input Modelica.Units.SI.Angle u "输入角度";
  input Boolean positiveRange = false "如果为真，只使用正值输出范围";
  output Modelica.Units.SI.Angle y "归一化输出角度";

algorithm
  y := mod(u, 2 * pi);
  if y > pi and not positiveRange then
    y := y - 2 * pi;
  end if;

  annotation(Icon(graphics = {
    Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), 
    Polygon(
    points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{-80, 54}, {-80, 54}, {-60, 80}, {-60, -80}, {60, 80}, {60, -80}, {80, -52}})}), 
    Documentation(info = "<html>
<p>
此函数将输入角度<code>u</code>归一化到区间]-pi,pi](如果<code>positiveRange == false</code>)。
否则，输入角度<code>u</code>将被归一化到区间[0,2*pi[。
</p>
</html>"));
end wrapAngle;