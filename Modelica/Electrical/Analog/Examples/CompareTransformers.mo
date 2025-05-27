within Modelica.Electrical.Analog.Examples;
model CompareTransformers 
  "展示磁化特性的变压器电路"
  import Modelica.Constants.pi;
  extends Modelica.Icons.Example;
  parameter SI.Voltage Vdc = 0.1 "电压源的直流偏移";
  parameter SI.Voltage Vpeak = 0.1 "电压源的峰值电压";
  parameter SI.Frequency f = 10 "电压源频率";
  parameter SI.Angle phi0 = pi / 2 "电压源的的相位";
  parameter Real n = 2 "电压匝数比(一次:二次)";
  parameter SI.Resistance R1 = 0.01 
    "一次侧电阻";
  parameter SI.Inductance L1sigma = 0.05 / (2 * pi * f) 
    "一次侧漏感";
  parameter SI.Inductance Lm1 = 10. / (2 * pi * f) 
    "一次侧磁化电感";
  parameter SI.Inductance L2sigma = 0.05 / (2 * pi * f) / n ^ 2 
    "二次侧漏感";
  parameter SI.Resistance R2 = 0.01 / n ^ 2 
    "二次侧电阻";
  parameter SI.Resistance RL = 1 / n ^ 2 "负载电阻";
  final parameter SI.Inductance L1 = L1sigma + M * n 
    "一次侧空载电感";
  final parameter SI.Inductance L2 = L2sigma + M / n 
    "二次侧空载电感";
  final parameter SI.Inductance M = Lm1 / n "互感";
  output SI.Voltage v1B = resistor11.n.v 
    "变压器一次侧电压";
  output SI.Current i1B = resistor11.i 
    "变压器一次侧电流";
  output SI.Voltage v2B = resistor12.p.v 
    "变压器二次侧电压";
  output SI.Current i2B = resistor12.i 
    "变压器二次侧电流";
  output SI.Voltage v1I = resistor21.n.v 
    "变压器一次侧电压";
  output SI.Current i1I = resistor21.i 
    "变压器一次侧电流";
  output SI.Voltage v2I = resistor22.p.v 
    "变压器二次侧电压";
  output SI.Current i2I = resistor22.i 
    "变压器二次侧电流";
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage1(
    V = Vpeak, 
    phase = phi0, 
    f = f, 
    offset = Vdc) 
    annotation(Placement(transformation(
    origin = {-80, 40}, 
    extent = {{-10, -10}, {10, 10}}, 
    rotation = 270)));
  Modelica.Electrical.Analog.Basic.Ground ground11 
    annotation(Placement(transformation(extent = {{-90, 0}, {-70, 20}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor11(R = R1) 
    annotation(Placement(transformation(extent = {{-80, 50}, {-60, 70}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor12(R = R2) 
    annotation(Placement(transformation(extent = {{60, 50}, {80, 70}})));
  Modelica.Electrical.Analog.Basic.Resistor load1(R = RL) 
    annotation(Placement(transformation(
    origin = {80, 40}, 
    extent = {{-10, -10}, {10, 10}}, 
    rotation = 270)));
  Modelica.Electrical.Analog.Basic.Ground ground12 
    annotation(Placement(transformation(extent = {{70, 0}, {90, 20}})));
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage2(
    V = Vpeak, 
    phase = phi0, 
    f = f, 
    offset = Vdc) 
    annotation(Placement(transformation(
    origin = {-80, -50}, 
    extent = {{-10, -10}, {10, 10}}, 
    rotation = 270)));
  Modelica.Electrical.Analog.Basic.Ground ground21 
    annotation(Placement(transformation(extent = {{-90, -90}, {-70, -70}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor21(R = R1) 
    annotation(Placement(transformation(extent = {{-80, -40}, {-60, -20}})));
  Modelica.Electrical.Analog.Basic.Inductor inductor21(L = L1sigma) 
    annotation(Placement(transformation(extent = {{-50, -40}, {-30, -20}})));
  Modelica.Electrical.Analog.Basic.Inductor inductor22(L = L2sigma, i(start = 0, fixed = true)) 
    annotation(Placement(transformation(extent = {{30, -40}, {50, -20}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor22(R = R2) 
    annotation(Placement(transformation(extent = {{60, -40}, {80, -20}})));
  Modelica.Electrical.Analog.Basic.Resistor load2(R = RL) 
    annotation(Placement(transformation(
    origin = {80, -50}, 
    extent = {{-10, -10}, {10, 10}}, 
    rotation = 270)));
  Modelica.Electrical.Analog.Basic.Ground ground22 
    annotation(Placement(transformation(extent = {{70, -90}, {90, -70}})));
  Modelica.Electrical.Analog.Basic.Transformer basicTransformer(
    L1 = L1, 
    L2 = L2, 
    M = M) annotation(Placement(transformation(extent = {{-10, 40}, {10, 60}})));
  Modelica.Electrical.Analog.Ideal.IdealTransformer idealTransformer(n = n, 
    Lm1 = Lm1, 
    considerMagnetization = false) 
    annotation(Placement(transformation(extent = {{-10, -50}, {10, -30}})));

initial equation
  basicTransformer.i1 = 0;
  basicTransformer.i2 = 0;
equation

  connect(sineVoltage1.n, ground11.p) 
    annotation(Line(points = {{-80, 30}, {-80, 20}}, color = {0, 0, 255}));
  connect(sineVoltage1.p, resistor11.p) 
    annotation(Line(points = {{-80, 50}, {-80, 60}}, color = {0, 0, 255}));
  connect(load1.n, ground12.p) 
    annotation(Line(points = {{80, 30}, {80, 20}}, color = {0, 0, 255}));
  connect(resistor12.n, load1.p) 
    annotation(Line(points = {{80, 60}, {80, 50}}, color = {0, 0, 255}));
  connect(sineVoltage2.n, ground21.p) 
    annotation(Line(points = {{-80, -60}, {-80, -70}}, color = {0, 0, 255}));
  connect(sineVoltage2.p, resistor21.p) 
    annotation(Line(points = {{-80, -40}, {-80, -30}}, color = {0, 0, 255}));
  connect(resistor21.n, inductor21.p) 
    annotation(Line(points = {{-60, -30}, {-50, -30}}, color = {0, 0, 255}));
  connect(inductor22.n, resistor22.p) 
    annotation(Line(points = {{50, -30}, {60, -30}}, color = {0, 0, 255}));
  connect(load2.n, ground22.p) 
    annotation(Line(points = {{80, -60}, {80, -70}}, color = {0, 0, 255}));
  connect(resistor22.n, load2.p) 
    annotation(Line(points = {{80, -30}, {80, -40}}, color = {0, 0, 255}));
  connect(ground11.p, basicTransformer.n1) annotation(Line(points = {{-80, 20}, 
    {-10, 20}, {-10, 45}}, color = {0, 0, 255}));
  connect(basicTransformer.n2, ground12.p) annotation(Line(points = {{10, 45}, {10, 
    20}, {80, 20}}, color = {0, 0, 255}));
  connect(basicTransformer.p1, resistor11.n) annotation(Line(points = {{-10, 55}, 
    {-10, 60}, {-60, 60}}, color = {0, 0, 255}));
  connect(basicTransformer.p2, resistor12.p) annotation(Line(points = {{10, 55}, {
    10, 60}, {60, 60}}, color = {0, 0, 255}));
  connect(ground21.p, idealTransformer.n1) annotation(Line(points = {{-80, -70}, 
    {-10, -70}, {-10, -45}}, color = {0, 0, 255}));
  connect(ground22.p, idealTransformer.n2) annotation(Line(points = {{80, -70}, {
    10, -70}, {10, -45}}, color = {0, 0, 255}));
  connect(idealTransformer.p1, inductor21.n) annotation(Line(points = {{-10, 
    -35}, {-10, -30}, {-30, -30}}, color = {0, 0, 255}));
  connect(idealTransformer.p2, inductor22.p) annotation(Line(points = {{10, -35}, 
    {10, -30}, {30, -30}}, color = {0, 0, 255}));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, 
    -100}, {100, 100}}), graphics = {Text(
    extent = {{-60, -80}, {60, -100}}, 
    textColor = {0, 0, 255}, 
    textString = "try considerMagnetization=false/true"), Text(
    extent = {{-60, 20}, {60, 0}}, 
    textColor = {0, 0, 255}, 
    textString = "Basic.Transformer (mutual inductance)")}), 
    experiment(StopTime = 50, Interval = 0.001), 
    Documentation(revisions = "<html>
<dl>
<dt><em>2009</em></dt>
<dd>Anton Haumer<br>创建</dd>
</dl>
</html>", 
    info = "<html>
<p>该示例旨在演示变压器模型的行为。Basic.Transformer是包含互感耦合的电容器，在这里它将被与理想变压器模型进行比较。在比较过程中，理想变压器可以通过调整considerMagnetization参数来控制自身是否带漏感电感。当considerMagnetization=true，理想变压器考虑漏感电感，反之则不考虑。
该示例的构建思路是：让理想变压器的considerMagnetization=true还原出变压器的实际工作行为。</p>
<p>该示例的仿真时间为50秒，用户可以通过改变considerMagnetization的状态(true/false)对理想变压器进行仿真。仿真结束后，用户可在“仿真--仿真浏览器”中勾选相应的“仿真结果变量”查看以下变量的图像:
<br>basicTransformer.p1.v、alTransformer.p1.v
<br>basicTransformer.p1.i、ealTransformer.p1.i
<br>basicTransformer.p2.v、ealTransformer.p2.v
basicTransformer.p2.i、ealTransformer.p2.i</p>
</html>"));
end CompareTransformers;