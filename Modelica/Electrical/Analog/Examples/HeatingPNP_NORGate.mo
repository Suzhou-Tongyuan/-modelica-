within Modelica.Electrical.Analog.Examples;
model HeatingPNP_NORGate "考虑热特性的PNP构成的异或门电路"
  extends Modelica.Icons.Example;
  parameter SI.Capacitance CapVal = 0 "电容值" annotation(Evaluate = true);
  parameter SI.Time tauVal = 0 "半导体理想正向和反向过渡时间的值" annotation(Evaluate = true);

  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor HeatCapacitor1(C = 0.1) 
    annotation(Placement(transformation(
    origin = {76, -84}, 
    extent = {{-10, -10}, {10, 10}}, 
    rotation = 180)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor TC1(G = 0.01) 
    annotation(Placement(transformation(
    origin = {90, -50}, 
    extent = {{-10, -10}, {10, 10}}, 
    rotation = 270)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor TC2(G = 0.01) 
    annotation(Placement(transformation(
    origin = {60, -50}, 
    extent = {{-10, -10}, {10, 10}}, 
    rotation = 270)));

  Modelica.Electrical.Analog.Sources.RampVoltage V(V = 6, duration = 5) 
    annotation(Placement(transformation(
    origin = {90, 38}, 
    extent = {{-10, -10}, {10, 10}}, 
    rotation = 90)));
  Modelica.Electrical.Analog.Sources.TrapezoidVoltage V1(
    startTime = 55, 
    rising = 5, 
    width = 15, 
    falling = 5, 
    period = 50, 
    nperiod = 10, 
    V = -6) annotation(Placement(transformation(
    origin = {-90, 18}, 
    extent = {{-10, -10}, {10, 10}}, 
    rotation = 270)));
  Modelica.Electrical.Analog.Sources.TrapezoidVoltage V2(
    startTime = 65, 
    rising = 5, 
    width = 15, 
    falling = 5, 
    period = 50, 
    nperiod = 10, 
    V = -6) annotation(Placement(transformation(
    origin = {-50, -42}, 
    extent = {{-10, -10}, {10, 10}}, 
    rotation = 270)));
  Modelica.Electrical.Analog.Basic.Resistor R1(R = 1800) 
    annotation(Placement(transformation(extent = {{-90, 48}, {-70, 68}})));
  Modelica.Electrical.Analog.Basic.Resistor R2(R = 1800) 
    annotation(Placement(transformation(extent = {{-36, -22}, {-16, -2}})));
  Modelica.Electrical.Analog.Basic.Resistor RI(R = 40) 
    annotation(Placement(transformation(extent = {{60, 58}, {80, 78}})));
  Modelica.Electrical.Analog.Basic.Ground Gnd 
    annotation(Placement(transformation(extent = {{80, 0}, {100, 20}})));
  Modelica.Electrical.Analog.Basic.Ground Gnd2 
    annotation(Placement(transformation(extent = {{-60, -82}, {-40, -62}})));
  Modelica.Electrical.Analog.Basic.Ground Gnd3 
    annotation(Placement(transformation(extent = {{-10, 16}, {10, 36}})));
  Modelica.Electrical.Analog.Basic.Ground Gnd4 
    annotation(Placement(transformation(extent = {{30, -52}, {50, -32}})));
  Modelica.Electrical.Analog.Basic.Capacitor C1(final C = CapVal) 
    annotation(Placement(transformation(
    origin = {-70, 38}, 
    extent = {{-10, -10}, {10, 10}}, 
    rotation = 270)));
  Modelica.Electrical.Analog.Basic.Capacitor C2(final C = CapVal) 
    annotation(Placement(transformation(
    origin = {60, 42}, 
    extent = {{-10, -10}, {10, 10}}, 
    rotation = 270)));
  Modelica.Electrical.Analog.Basic.Capacitor C3(final C = CapVal) 
    annotation(Placement(transformation(
    origin = {-16, -40}, 
    extent = {{-10, -10}, {10, 10}}, 
    rotation = 270)));
  Modelica.Electrical.Analog.Basic.Ground Gnd5 
    annotation(Placement(transformation(extent = {{-26, -76}, {-6, -56}})));
  Modelica.Electrical.Analog.Basic.Ground Gnd6 
    annotation(Placement(transformation(extent = {{50, 6}, {70, 26}})));
  Modelica.Electrical.Analog.Basic.Ground Gnd7 
    annotation(Placement(transformation(extent = {{-80, 2}, {-60, 22}})));
  Modelica.Electrical.Analog.Semiconductors.PNP T1(
    Bf = 100, 
    Br = 1, 
    Is = 1e-14, 
    Vak = 0, 
    final Tauf = tauVal, 
    final Taur = tauVal, 
    final Ccs = CapVal, 
    final Cje = CapVal, 
    final Cjc = CapVal, 
    Phie = 1, 
    Me = 0.5, 
    Phic = 1, 
    Mc = 0.5, 
    Gbc = 1e-12, 
    Gbe = 1e-12, 
    EMax = 40, 
    vt_t(start = 0.01, fixed = false), 
    useTemperatureDependency = true) 
    annotation(Placement(transformation(extent = {{-20, 48}, {0, 68}})));
  Modelica.Electrical.Analog.Semiconductors.PNP T2(
    Bf = 100, 
    Br = 1, 
    Is = 1e-14, 
    Vak = 0, 
    final Tauf = tauVal, 
    final Taur = tauVal, 
    final Ccs = CapVal, 
    final Cje = CapVal, 
    final Cjc = CapVal, 
    Phie = 1, 
    Me = 0.5, 
    Phic = 1, 
    Mc = 0.5, 
    Gbc = 1e-12, 
    Gbe = 1e-12, 
    EMax = 40, 
    vt_t(start = 0.01, fixed = false), 
    useTemperatureDependency = true) 
    annotation(Placement(transformation(extent = {{20, -22}, {40, -2}})));
  Modelica.Electrical.Analog.Basic.Ground Gnd1 
    annotation(Placement(transformation(extent = {{-100, -20}, {-80, 0}})));
initial equation
  HeatCapacitor1.T = 293.15;

equation
  connect(Gnd7.p, C1.n) 
    annotation(Line(points = {{-70, 22}, {-70, 28}}, color = {0, 0, 255}));
  connect(C3.p, R2.n) 
    annotation(Line(points = {{-16, -30}, {-16, -21}, {-16, -12}}, color = {0, 0, 255}));
  connect(C1.p, R1.n) 
    annotation(Line(points = {{-70, 48}, {-70, 58}}, color = {0, 0, 255}));
  connect(Gnd5.p, C3.n) 
    annotation(Line(points = {{-16, -56}, {-16, -50}}, color = {0, 0, 255}));
  connect(T1.B, R1.n) 
    annotation(Line(points = {{-20, 58}, {-70, 58}}, color = {0, 0, 255}));
  connect(T1.E, Gnd3.p) 
    annotation(Line(points = {{0, 52}, {0, 52}, {0, 44.5}, {0, 36}}, color = {0, 0, 255}));
  connect(RI.p, T1.C) 
    annotation(Line(points = {{60, 68}, {30, 68}, {30, 64}, {0, 64}}, color = {0, 0, 255}));
  connect(T2.B, R2.n) 
    annotation(Line(points = {{20, -12}, {-16, -12}}, color = {0, 0, 255}));
  connect(T2.E, Gnd4.p) 
    annotation(Line(points = {{40, -18}, {40, -32}}, color = {0, 0, 255}));
  connect(T2.C, RI.p) 
    annotation(Line(points = {{40, -6}, {40, 68}, {60, 68}}, color = {0, 0, 255}));
  connect(TC1.port_b, HeatCapacitor1.port) 
    annotation(Line(points = {{90, -60}, {84, 
    -60}, {84, -74}, {76, -74}}, color = {191, 0, 0}));
  connect(TC2.port_b, HeatCapacitor1.port) 
    annotation(Line(points = {{60, -60}, {68, 
    -60}, {68, -74}, {76, -74}}, color = {191, 0, 0}));
  connect(TC2.port_a, T2.heatPort) 
    annotation(Line(points = {{60, -40}, {60, -22}, {30, -22}}, color = {191, 0, 0}));
  connect(TC1.port_a, T1.heatPort) 
    annotation(Line(points = {{90, -40}, {90, 2}, {-10, 
    2}, {-10, 48}}, color = {191, 0, 0}));
  connect(V.n, RI.n) 
    annotation(Line(points = {{90, 48}, {90, 68}, {80, 68}}, color = {0, 0, 255}));
  connect(Gnd.p, V.p) 
    annotation(Line(points = {{90, 20}, {90, 28}}, color = {0, 0, 255}));
  connect(V1.p, R1.p) 
    annotation(Line(points = {{-90, 28}, {-90, 58}}, color = {0, 0, 255}));
  connect(V1.n, Gnd1.p) 
    annotation(Line(points = {{-90, 8}, {-90, 0}, {-90, 0}}, color = {0, 0, 255}));
  connect(V2.p, R2.p) 
    annotation(Line(points = {{-50, -32}, {-50, -12}, {-36, -12}}, color = {0, 0, 255}));
  connect(V2.n, Gnd2.p) 
    annotation(Line(points = {{-50, -52}, {-50, -62}}, color = {0, 0, 255}));
  connect(C2.p, RI.p) 
    annotation(Line(points = {{60, 52}, {60, 68}}, color = {0, 0, 255}));
  connect(C2.n, Gnd6.p) 
    annotation(Line(points = {{60, 32}, {60, 26}}, color = {0, 0, 255}));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
    -100}, {100, 100}}), graphics = {Text(
    extent = {{-98, 100}, {-4, 72}}, 
    textColor = {0, 0, 255}, 
    textString = "Heating \"PNP NOR\" Gate")}), 
    Documentation(info = "<html>
<p>该示例展示了如果一个晶体管处于导通状态，就会一直有热量流动。</p>
<p>示例的仿真时间为200秒。用户可在“仿真--仿真浏览器”中勾选相应的“仿真结果变量”查看
V1.v、V2.v和C2.v等结果变量的数值(这些变量数值的变化可以显现出异或门的工作情况)。当高电位为-6V时表示异或门逻辑为true；当低电位为0V时，表示异或门逻辑为flase。</p>
<p>如果用户想要查看哪个晶体管正在导通，可在“仿真--仿真浏览器”中通过勾选“仿真结果变量”查看对应的温度结果变量和热流结果变量数值进行判断。</p>
<p>当晶体管导通时，温度结果变量和热流结果变量的数值将不为0。</p>
</html>", 
    revisions = "<html>
<h4>版本信息：</h4>
<ul>
<li><em>2018/5/2</em> Kristin Majetta和Christoph Clauss<br>创建<br></li>
</ul>
</html>"), experiment(StopTime = 200));
end HeatingPNP_NORGate;