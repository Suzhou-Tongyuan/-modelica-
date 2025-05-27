within Modelica.Electrical.Analog.Examples.OpAmps.OpAmpCircuits;
model PI "PI控制器运算放大器电路"
  extends PartialOpAmp(v2(start = 0));
  import Modelica.Constants.pi;
  parameter Real k(final min = 0) = 1 "所需放大倍数";
  parameter SI.Resistance R1 = 1000 "在OpAmp负极输入的电阻";
  parameter SI.Resistance R2 = k * R1 "计算电阻(为达到放大倍数k)";
  parameter SI.Time T "时间常数";
  parameter SI.Capacitance C = T / k / R1 "计算电容(为达到放大倍数k)";
  Basic.Resistor r1(R = R1) 
    annotation(Placement(transformation(extent = {{-50, 20}, {-30, 40}})));
  Basic.Resistor r2(R = R2) 
    annotation(Placement(transformation(extent = {{30, 20}, {10, 40}})));
  Basic.Capacitor c(C = C) 
    annotation(Placement(transformation(extent = {{60, 20}, {40, 40}})));
equation
  connect(n1, n2) 
    annotation(Line(points = {{-100, -100}, {100, -100}}, color = {0, 0, 255}));
  connect(opAmp.out, p2) annotation(Line(points = {{10, 0}, {80, 0}, {80, 100}, {100, 100}}, 
    color = {0, 0, 255}));
  connect(n1, opAmp.in_p) annotation(Line(points = {{-100, -100}, {-10, -100}, {-10, -6}}, 
    color = {0, 0, 255}));
  connect(r1.n, opAmp.in_n) 
    annotation(Line(points = {{-30, 30}, {-10, 30}, {-10, 6}}, color = {0, 0, 255}));
  connect(opAmp.in_n, r2.n) 
    annotation(Line(points = {{-10, 6}, {-10, 30}, {10, 30}}, color = {0, 0, 255}));
  connect(p1, r1.p) annotation(Line(points = {{-100, 100}, {-80, 100}, {-80, 30}, {-50, 
    30}}, color = {0, 0, 255}));
  connect(r2.p, c.n) 
    annotation(Line(points = {{30, 30}, {40, 30}}, color = {0, 0, 255}));
  connect(opAmp.out, c.p) 
    annotation(Line(points = {{10, 0}, {60, 0}, {60, 30}}, color = {0, 0, 255}));
  annotation(defaultComponentName = "PI", Documentation(info = "<html>
<p>该示例为反相比例积分控制器电路模型，该模型基于<a href=\"modelica://Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited\">IdealizedOpAmpLimited</a>搭建。</p>
<p>传递函数：<code>vOut/vIn=-k*s/(1+s*T)</code></p>
</html>"), Icon(graphics = {
    Polygon(
    points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{-80, 78}, {-80, -90}}, color = {192, 192, 192}), 
    Line(points = {{-80.0, -80.0}, {-80.0, -20.0}, {60.0, 80.0}}, color = {0, 0, 127}), 
    Line(points = {{-90, -80}, {82, -80}}, color = {192, 192, 192}), 
    Polygon(
    points = {{90, -80}, {68, -72}, {68, -88}, {90, -80}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid)}));
end PI;