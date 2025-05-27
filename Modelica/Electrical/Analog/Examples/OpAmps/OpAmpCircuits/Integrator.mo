within Modelica.Electrical.Analog.Examples.OpAmps.OpAmpCircuits;
model Integrator "积分运算放大器电路"
  extends PartialOpAmp(v2(start = 0));
  import Modelica.Constants.pi;
  parameter Real k(final min = 0) = 1 "在频率f时的所需放大倍数";
  parameter SI.Frequency f "频率";
  parameter SI.Resistance R = 1000 "OpAmp负极输入的电阻";
  parameter SI.Capacitance C = 1 / k / (2 * pi * f * R) "计算电阻(为达到所需的放大倍数k)";
  SI.Voltage v(start = 0) = c.v "电容电压(state状态时)";

  Basic.Capacitor c(final C = C) 
    annotation(Placement(transformation(extent = {{30, 20}, {10, 40}})));
  Basic.Resistor r(final R = R) 
    annotation(Placement(transformation(extent = {{-50, 20}, {-30, 40}})));
equation
  connect(n1, n2) 
    annotation(Line(points = {{-100, -100}, {100, -100}}, color = {0, 0, 255}));
  connect(opAmp.out, p2) annotation(Line(points = {{10, 0}, {80, 0}, {80, 100}, {100, 100}}, 
    color = {0, 0, 255}));
  connect(n1, opAmp.in_p) annotation(Line(points = {{-100, -100}, {-10, -100}, {-10, -6}}, 
    color = {0, 0, 255}));
  connect(r.p, p1) annotation(Line(points = {{-50, 30}, {-80, 30}, {-80, 100}, {-100, 100}}, 
    color = {0, 0, 255}));
  connect(r.n, opAmp.in_n) 
    annotation(Line(points = {{-30, 30}, {-10, 30}, {-10, 6}}, color = {0, 0, 255}));
  connect(opAmp.in_n, c.n) 
    annotation(Line(points = {{-10, 6}, {-10, 30}, {10, 30}}, color = {0, 0, 255}));
  connect(opAmp.out, c.p) 
    annotation(Line(points = {{10, 0}, {30, 0}, {30, 30}}, color = {0, 0, 255}));
  annotation(Documentation(info = "<html>
<p>这个模型为反相积分器，该模型基于<a href=\"modelica://Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited\">IdealizedOpAmpLimited</a>搭建。</p>
<p><code>k*vin=-der(dvOut)</code></p>
</html>"), 
    Icon(graphics = {
    Polygon(
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid, 
    points = {{-80.0, 90.0}, {-88.0, 68.0}, {-72.0, 68.0}, {-80.0, 90.0}}), 
    Line(
    points = {{-80.0, 78.0}, {-80.0, -90.0}}, 
    color = {192, 192, 192}), 
    Line(
    points = DynamicSelect({{-80.0, -80.0}, {80.0, 80.0}}, if use_reset then {{-80.0, -80.0}, {60.0, 60.0}, {60.0, -80.0}, {80.0, -60.0}} else {{-80.0, -80.0}, {80.0, 80.0}}), 
    color = {0, 0, 127}), 
    Line(
    points = {{-90.0, -80.0}, {82.0, -80.0}}, 
    color = {192, 192, 192}), 
    Polygon(
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid, 
    points = {{90.0, -80.0}, {68.0, -72.0}, {68.0, -88.0}, {90.0, -80.0}}), 
    Text(
    extent = {{-80, 40}, {0, -40}}, 
    textColor = {0, 0, 255}, 
    textString = "I")}));
end Integrator;