within Modelica.Electrical.Analog.Semiconductors;
model NMOS "带热端口的简单NMOS晶体管"

  Modelica.Electrical.Analog.Interfaces.Pin D "漏极(Drain)" 
    annotation(Placement(transformation(extent = {{90, 50}, {110, 70}}), iconTransformation(extent = {{90, 50}, {110, 70}})));
  Modelica.Electrical.Analog.Interfaces.Pin G "门极(Gate)" 
    annotation(Placement(transformation(extent = {{-90, -50}, {-110, -70}}), iconTransformation(extent = {{-90, -50}, {-110, -70}})));
  Modelica.Electrical.Analog.Interfaces.Pin S "源极(Source)" 
    annotation(Placement(transformation(extent = {{90, -50}, {110, -70}}), iconTransformation(extent = {{90, -50}, {110, -70}})));
  Modelica.Electrical.Analog.Interfaces.Pin B "体区(Bulk)" 
    annotation(Placement(transformation(extent = {{90, -10}, {110, 10}})));
  parameter SI.Length W = 20.e-6 "宽度";
  parameter SI.Length L = 6.e-6 "长度";
  parameter SI.Transconductance Beta = 0.041e-3 "转导系数参数";
  parameter SI.Voltage Vt = 0.8 "零偏置阈值电压";
  parameter Real K2 = 1.144 "体阈值参数";
  parameter Real K5 = 0.7311 "截断区域的减小";
  parameter SI.Length dW = -2.5e-6 "通道窄化";
  parameter SI.Length dL = -1.5e-6 "通道缩短";
  parameter SI.Resistance RDS = 1e7 "漏源电阻";
  parameter Boolean useTemperatureDependency = false "=true，此时参数Beta、K2和Vt随温度的变化而变化" annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
  parameter SI.Temperature Tnom = 300.15 "参数测量温度" annotation(Dialog(enable = useTemperatureDependency));
  parameter Real kvt = -6.96e-3 "Vt的适应参数" annotation(Dialog(enable = useTemperatureDependency));
  parameter Real kk2 = 6e-4 "K2的适应参数" annotation(Dialog(enable = useTemperatureDependency));
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(useHeatPort = useTemperatureDependency);
protected
  Real v;
  Real uds;
  Real ubs;
  Real ugst;
  Real ud;
  Real us;
  Real id;
  Real gds;
  Real beta_t;
  Real vt_t;
  Real k2_t;
equation
  assert(L + dL > 0, "NMOS: Effective length must be positive");
  assert(W + dW > 0, "NMOS: Effective width must be positive");
  assert(T_heatPort > 0, "NMOS: Temperature must be positive");
  gds = if (RDS < 1e-20 and RDS > -1e-20) then 1e20 else 1 / RDS;
  v = beta_t * (W + dW) / (L + dL);
  ud = smooth(0, if (D.v < S.v) then S.v else D.v);
  us = smooth(0, if (D.v < S.v) then D.v else S.v);
  uds = ud - us;
  ubs = smooth(0, if (B.v > us) then 0 else B.v - us);
  ugst = (G.v - us - vt_t + k2_t * ubs) * K5;
  id = smooth(0, if (ugst <= 0) then uds * gds else if (ugst > uds) then v * uds * (
    ugst - uds / 2) + uds * gds else v * ugst * ugst / 2 + uds * gds);

  beta_t = if useTemperatureDependency then Beta * pow((T_heatPort / Tnom), -1.5) else Beta;
  vt_t = if useTemperatureDependency then Vt * (1 + (T_heatPort - Tnom) * kvt) else Vt;
  k2_t = if useTemperatureDependency then K2 * (1 + (T_heatPort - Tnom) * kk2) else K2;

  G.i = 0;
  D.i = smooth(0, if (D.v < S.v) then -id else id);
  S.i = smooth(0, if (D.v < S.v) then id else -id);
  B.i = 0;
  LossPower = D.i * (D.v - S.v);
  annotation(defaultComponentName = "nMOS", 
    Documentation(info = "<html>
<p>NMOS模型是n沟道金属氧化物半导体场效应晶体管的简化模型。它与SPICE模拟器中使用的器件略有不同。如需了解更多详细信息，请关注
[<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Spiro1990</a>]。

<p>模型已添加一个用于热电模拟的heating port，heating port定义在 Modelica.Thermal库中。
</p>
<p>该模型没有考虑电容。为避免发生数值上的问题，该模型已包含了高的源阻抗RDS。
</p>

<blockquote><pre>
W       L      Beta         Vt      K2     K5       dW       dL
m       m      A/V^2        V       -      -        m        m
12.e-6  4.e-6  0.062e-3    -4.5     0.24   0.61    -1.2e-6  -0.9e-6      depletion
60.e-6  3.e-6  0.048e-3     0.1     0.08   0.68    -1.2e-6  -0.9e-6      enhancement
12.e-6  4.e-6  0.0625e-3   -0.8     0.21   0.78    -1.2e-6  -0.9e-6      zero
50.e-6  8.e-6  0.0299e-3    0.24    1.144  0.7311  -5.4e-6  -4.e-6
20.e-6  6.e-6  0.041e-3     0.8     1.144  0.7311  -2.5e-6  -1.5e-6
30.e-6  9.e-6  0.025e-3    -4.0     0.861  0.878   -3.4e-6  -1.74e-6
30.e-6  5.e-6  0.031e-3     0.6     1.5    0.72     0       -3.9e-6
50.e-6  6.e-6  0.0414e-3   -3.8     0.34   0.8     -1.6e-6  -2.e-6       depletion
50.e-6  5.e-6  0.03e-3      0.37    0.23   0.86    -1.6e-6  -2.e-6       enhancement
50.e-6  6.e-6  0.038e-3    -0.9     0.23   0.707   -1.6e-6  -2.e-6       zero
20.e-6  4.e-6  0.06776e-3   0.5409  0.065  0.71    -0.8e-6  -0.2e-6
20.e-6  4.e-6  0.06505e-3   0.6209  0.065  0.71    -0.8e-6  -0.2e-6
20.e-6  4.e-6  0.05365e-3   0.6909  0.03   0.8     -0.3e-6  -0.2e-6
20.e-6  4.e-6  0.05365e-3   0.4909  0.03   0.8     -0.3e-6  -0.2e-6
12.e-6  4.e-6  0.023e-3    -4.5     0.29   0.6      0        0           depletion
60.e-6  3.e-6  0.022e-3     0.1     0.11   0.65     0        0           enhancement
12.e-6  4.e-6  0.038e-3    -0.8     0.33   0.6      0        0           zero
20.e-6  6.e-6  0.022e-3     0.8     1      0.66     0        0
</pre></blockquote>
<p><strong>参考文献：</strong> [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Spiro1990</a>]</p>
</html>", revisions = "<html>
<ul>
<li><em> March 11, 2009   </em>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><em>December 7, 2005   </em>
       by Christoph Clauss<br>
       error in RDS calculation deleted</li>
<li><em>March 31, 2004   </em>
       by Christoph Clauss<br> implemented<br>
       </li>
</ul>
</html>"), 
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Line(points = {{-90, -60}, {-10, -60}}, color = {0, 0, 255}), 
    Line(points = {{-10, -60}, {-10, 60}}, color = {0, 0, 255}), 
    Line(points = {{10, 80}, {10, 39}}, color = {0, 0, 255}), 
    Line(points = {{10, 20}, {10, -21}}, color = {0, 0, 255}), 
    Line(points = {{10, -40}, {10, -81}}, color = {0, 0, 255}), 
    Line(points = {{10, 60}, {91, 60}}, color = {0, 0, 255}), 
    Line(points = {{10, 0}, {90, 0}}, color = {0, 0, 255}), 
    Line(points = {{10, -60}, {90, -60}}, color = {0, 0, 255}), 
    Polygon(
    points = {{40, 0}, {60, 5}, {60, -5}, {40, 0}}, 
    fillColor = {0, 0, 255}, 
    fillPattern = FillPattern.Solid, 
    lineColor = {0, 0, 255}), 
    Text(extent = {{-150, 130}, {150, 90}}, 
    textString = "%name", 
    textColor = {0, 0, 255})}));
end NMOS;