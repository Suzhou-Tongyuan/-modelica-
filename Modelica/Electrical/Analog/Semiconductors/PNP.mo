within Modelica.Electrical.Analog.Semiconductors;
model PNP "按照Ebers-Moll搭建简单的带加热端口的PNP BJT模型"

  parameter Real Bf = 50 "正向增益";
  parameter Real Br = 0.1 "反向增益";
  parameter SI.Current Is = 1e-16 "传输饱和电流";
  parameter SI.InversePotential Vak = 0.02 "Early电压(反相)，1/Volt";
  parameter SI.Time Tauf = 0.12e-9 "理想正相渡越时间";
  parameter SI.Time Taur = 5e-9 "理想反相渡越时间";
  parameter SI.Capacitance Ccs = 1e-12 "集电极-接地电容.";
  parameter SI.Capacitance Cje = 0.4e-12 "基极-发射极零偏压耗尽电容";
  parameter SI.Capacitance Cjc = 0.5e-12 "基极-集电极零偏压耗尽电容";
  parameter SI.Voltage Phie = 0.8 "基极-发射极扩散电压";
  parameter Real Me = 0.4 "基极-发射极梯度指数";
  parameter SI.Voltage Phic = 0.8 "基极-集电极扩散电压";
  parameter Real Mc = 0.333 "基极-集电极梯度指数";
  parameter SI.Conductance Gbc = 1e-15 "基集导纳";
  parameter SI.Conductance Gbe = 1e-15 "基射导纳";
  parameter Real EMin = -100 "如果x<EMin，exp(x)函数线性化";
  parameter Real EMax = 40 "如果x>EMax，exp(x)函数线性化";
  parameter Boolean useTemperatureDependency = false "=true,此时Bf，Br，Is和Vt随温度的变化而变化" annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
  parameter SI.Voltage Vt = 0.02585 "电压等效温度" annotation(Dialog(enable = not useTemperatureDependency));
  parameter SI.Temperature Tnom = 300.15 "参数测量温度" annotation(Dialog(enable = useTemperatureDependency));
  parameter Real XTI = 3 "影响Is的温度指数" annotation(Dialog(enable = useTemperatureDependency));
  parameter Real XTB = 0 "正向和反向beta温度指数" annotation(Dialog(enable = useTemperatureDependency));
  parameter SI.Voltage EG = 1.11 "温度对半导体能带间能隙的影响" annotation(Dialog(enable = useTemperatureDependency));
  parameter Real NF = 1.0 "正向电流发射系数";
  parameter Real NR = 1.0 "反向电流发射系数";
  parameter SI.Voltage IC = 0 "集电极到基底电压的初始值" annotation(Dialog(enable = UIC));
  parameter Boolean UIC = false "是否应该使用初始值IC";
  parameter Boolean useSubstrate = false "=false，此时基板被隐式地接地";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(useHeatPort = useTemperatureDependency);

  SI.Voltage vcb "Collector-base voltage";
  SI.Voltage veb "Emitter-base voltage";
  SI.Voltage vcs "Collector-substrate voltage";
  Real qbk "Relative majority carrier charge, inverse";
  SI.Current icb "Collector-base diode current";
  SI.Current ieb "Emitter-base diode current";
  SI.Capacitance ccb "Total collector-base capacitance";
  SI.Capacitance ceb "Total emitter-base capacitance";
  SI.Capacitance Capcje "Effective emitter-base depletion capacitance";
  SI.Capacitance Capcjc "Effective collector-base depletion capacitance";
  SI.Current is_t "Temperature dependent transport saturation current";
  Real br_t "Temperature dependent forward beta";
  Real bf_t "Temperature dependent reverse beta";
  SI.Voltage vt_t "Voltage equivalent of effective temperature";
  Real hexp "Auxiliary quantity temperature dependent exponent";
  Real htempexp "Auxiliary quantity exp(hexp)";
  SI.Voltage vS "Substrate potential";
  SI.Current iS "Substrate current";

  Modelica.Electrical.Analog.Interfaces.Pin C "集电极" 
    annotation(Placement(transformation(extent = {{90, 50}, {110, 70}}), iconTransformation(extent = {{90, 50}, {110, 70}})));
  Modelica.Electrical.Analog.Interfaces.Pin B "基极" 
    annotation(Placement(transformation(extent = {{-90, -10}, {-110, 10}})));
  Modelica.Electrical.Analog.Interfaces.Pin E "发射极" 
    annotation(Placement(transformation(extent = {{90, -50}, {110, -70}}), iconTransformation(extent = {{90, -50}, {110, -70}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin S(final i = iS, final v = vS) if useSubstrate "底层基板(Substrate)" 
    annotation(Placement(transformation(extent = {{110, -10}, {90, 10}})));
initial equation
  if UIC then
    vcs = IC;
  end if;
equation
  assert(T_heatPort > 0, "Temperature must be positive");
  vcb = C.v - B.v;
  veb = E.v - B.v;
  vcs = C.v - vS;
  qbk = 1 - vcb * Vak;

  hexp = (T_heatPort / Tnom - 1) * EG / vt_t;
  htempexp = smooth(1, exlin2(hexp, EMin, EMax));

  is_t = if useTemperatureDependency then Is * pow(T_heatPort / Tnom, XTI) * htempexp else Is;
  br_t = if useTemperatureDependency then Br * pow(T_heatPort / Tnom, XTB) else Br;
  bf_t = if useTemperatureDependency then Bf * pow(T_heatPort / Tnom, XTB) else Bf;
  vt_t = if useTemperatureDependency then (k / q) * T_heatPort else Vt;

  icb = smooth(1, is_t * (exlin2(vcb / (NR * vt_t), EMin, EMax) - 1) + vcb * Gbc);
  ieb = smooth(1, is_t * (exlin2(veb / (NF * vt_t), EMin, EMax) - 1) + veb * Gbe);
  Capcjc = smooth(1, Cjc * powlin(vcb / Phic, Mc));
  Capcje = smooth(1, Cje * powlin(veb / Phie, Me));
  ccb = smooth(1, Taur * is_t / (NR * vt_t) * exlin2(vcb / (NR * vt_t), EMin, EMax) + Capcjc);
  ceb = smooth(1, Tauf * is_t / (NF * vt_t) * exlin2(veb / (NF * vt_t), EMin, EMax) + Capcje);
  C.i = icb / br_t + ccb * der(vcb) + (icb - ieb) * qbk - iS;
  B.i = -ieb / bf_t - icb / br_t - ceb * der(veb) - ccb * der(vcb);
  E.i = -B.i - C.i - iS;
  iS = -Ccs * der(vcs);
  if not useSubstrate then
    vS = 0;
  end if;
  LossPower = vcb * icb / br_t + veb * ieb / bf_t + (icb - ieb) * qbk * (C.v - E.v);
  annotation(defaultComponentName = "pnp", 
    Documentation(info = "<html>
<p>这个模型是根据Ebers-Moll理论的简单PNP型双极结型晶体管模型。
</p>

<p>该模型添加了一个热端口用于热电模拟。该热端口在Modelica.Thermal库中定义
</p>

<p>以下为模型的典型参数设置：
</p>

<blockquote><pre>
Bf  Br  Is     Vak  Tauf    Taur  Ccs   Cje     Cjc     Phie  Me   PHic   Mc     Gbc    Gbe
-   -   A      V    s       s     F     F       F       V     -    V      -      mS     mS
50  0.1 1e-16  0.02 0.12e-9 5e-9  1e-12 0.4e-12 0.5e-12 0.8   0.4  0.8    0.333  1e-15  1e-15
</pre></blockquote>
<p><strong>参考文献：</strong> [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Vlach1983</a>]</p>
</html>", revisions = "<html>
<ul>
<li><em> March 11, 2009   </em>
       Christoph Clauss<br>添加conditional heat port<br>
       </li>
<li><em>March 20, 2004   </em>
       Christoph Clauss<br>创建<br>
       </li>
</ul>
</html>"), 
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Line(points = {{-20, 40}, {-20, -40}}, color = {0, 0, 255}), 
    Line(points = {{-20, 0}, {-100, 0}}, color = {0, 0, 255}), 
    Line(points = {{91, 60}, {30, 60}}, color = {0, 0, 255}), 
    Line(points = {{30, 60}, {-20, 10}}, color = {0, 0, 255}), 
    Line(points = {{-20, -10}, {30, -60}}, color = {0, 0, 255}), 
    Line(points = {{30, -60}, {91, -60}}, color = {0, 0, 255}), 
    Polygon(
    points = {{-20, -10}, {-5, -17}, {-13, -25}, {-20, -10}}, 
    fillColor = {0, 0, 255}, 
    fillPattern = FillPattern.Solid, 
    lineColor = {0, 0, 255}), 
    Text(extent = {{-150, 130}, {150, 90}}, 
    textString = "%name", 
    textColor = {0, 0, 255}), 
    Line(points = {{0, 0}, {90, 0}}, 
    color = {0, 0, 255}, 
    pattern = LinePattern.Dash, 
    visible = useSubstrate)}));
end PNP;