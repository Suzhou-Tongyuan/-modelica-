within Modelica.Electrical.Analog.Semiconductors;
model Diode2 "复杂二极管模型"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T = 293.15);
  parameter SI.Voltage Vf = 0.7 "正向电压";
  parameter SI.Current Ids = 1e-13 "反向饱和电流";
  parameter SI.Resistance Rs = 16 "欧姆电阻";
  parameter SI.Voltage Vt = Modelica.Constants.R * T / Modelica.Constants.F 
    "普通条件(大约20度)下的热电压(kT/q)为0.026" 
    annotation(Dialog(enable = not useHeatPort));
  parameter Real N = 1 "发射系数";
  parameter SI.Voltage Bv = 100 "反向击穿电压";
  parameter SI.Conductance Gp = 1e-6 
    "并联电导以提高数值稳定性";
  SI.Voltage vd "二极管部分的电压";
  SI.Current id "二极管电流";
protected
  SI.Voltage VdMax = Vf + (N * Vt_applied) "线性延续阈值";
  SI.Current iVdMax = Ids * (exp(VdMax / (N * Vt_applied)) - 1) "阈值处的电流";
  SI.Conductance diVdMax = Ids * exp(VdMax / (N * Vt_applied)) / (N * Vt_applied) "阈值处的电导";
  SI.Voltage Vt_applied;
equation
  Vt_applied = if useHeatPort then Modelica.Constants.R * T_heatPort / Modelica.Constants.F else Vt;
  id = smooth(1, 
    if vd < -Bv / 2 then 
    -Ids * (exp(-(vd + Bv) / (N * Vt_applied)) + 1 - 2 * exp(-Bv / (2 * N * Vt_applied))) 
    else if vd < VdMax then 
    Ids * (exp(vd / (N * Vt_applied)) - 1) 
    else 
    iVdMax + (vd - VdMax) * diVdMax);
  //反向偏置区域的下半部分，包括击穿。
  //反向偏置区域的上半部分，和导通前的正向偏置区域。
  //导通后的正向偏置区域。
  v = vd + id * Rs;
  i = id + v * Gp;
  LossPower = i * v;
  assert(Bv > 0, "Bv必须大于零");
  assert(Vf > 0, "Vf必须大于零");
  assert(Vt > 0, "Vt必须大于零");
  annotation(defaultComponentName = "二极管", 
    Documentation(info = "<html>
<p>这个二极管模型是对<a href=\"modelica://Modelica.Electrical.Analog.Semiconductors.Diode\">简单二极管</a>的优化版本。它包括串联电阻、并联电导，并且模拟了反向击穿。该模型被分为三个部分：

<ul>
<li>反向偏置区域的下半部分，包括击穿：-Ids·(exp(-(vd+Bv)/(N·Vt))+1-2·exp(-Bv/(2·N·Vt)))。</li>
<li>反向偏置区域的上半部分，和导通前的正向偏置区域：Ids·(exp(vd/(N·Vt))-1)。</li>
<li>导通后的正向偏置区域：iVdMax+(vd-VdMax)·diVdMax。</li>
</ul>
<p>当useHeatPort=true时，将建模温度相关行为。在这种情况下，Vt参数将被忽略，而Vt将根据公式Vt=k·T/q进行计算，其中，
<ul>
<li>k是玻尔兹曼常数。</li>
<li>T是热端口温度。</li>
<li>q是元电荷。</li>
</ul>
</html>", 
    revisions = "<html>
<ul>
<li><em>2015年11月 </em> Stefan Vorkoetter<br>实现了动态温度依赖性<br></li>
<li><em>2015年11月</em> Kristin Majetta<br>基于固定温度定义了参数Vt<br></li>
<li><em>2014年6月</em> Stefan Vorkoetter、Kristin Majetta和Christoph Clauss<br>创建<br></li>
<li><em>2011年10月</em> Stefan Vorkoetter提出了新模型。</li>
</ul>
</html>"), 
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Polygon(
    points = {{30, 0}, {-30, 40}, {-30, -40}, {30, 0}}, 
    lineColor = {0, 0, 255}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{-90, 0}, {40, 0}}, color = {0, 0, 255}), 
    Line(points = {{40, 0}, {90, 0}}, color = {0, 0, 255}), 
    Line(points = {{30, 40}, {30, -40}}, color = {0, 0, 255}), 
    Text(
    extent = {{-150, 90}, {150, 50}}, 
    textString = "%name", 
    textColor = {0, 0, 255}), 
    Line(
    visible = useHeatPort, 
    points = {{0, -100}, {0, -20}}, 
    color = {127, 0, 0}, 
    pattern = LinePattern.Dot)}));
end Diode2;