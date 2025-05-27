within Modelica.Electrical.Analog.Semiconductors;
model ZDiode "具有3个工作区域的齐纳二极管"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  parameter SI.Current Ids = 1e-6 "饱和电流";
  parameter SI.Voltage Vt = 0.04 "热电压(kT/qn)";
  parameter Real Maxexp(final min = Modelica.Constants.small) = 30 
    "线性连续的最大指数";
  parameter SI.Resistance R = 1e8 "并联欧姆电阻";
  parameter SI.Voltage Bv = 5.1 "击穿电压=齐纳电压或Z电压";
  parameter SI.Current Ibv = 0.7 "击穿电流";
  parameter Real Nbv = 0.74 "突破发射系数";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T = 293.15);
equation
  i = smooth(1, if (v > Maxexp * Vt) then 
    Ids * (exp(Maxexp) * (1 + v / Vt - Maxexp) - 1) + v / R else 
    if ((v + Bv) < -Maxexp * (Nbv * Vt)) then 
    -Ids - Ibv * exp(Maxexp) * (1 - (v + Bv) / (Nbv * Vt) - Maxexp) + v / R else 
    Ids * (exp(v / Vt) - 1) - Ibv * exp(-(v + Bv) / (Nbv * Vt)) + v / R);
  LossPower = v * i;
  annotation(defaultComponentName = "二极管", 
    Documentation(info = "<html>
<p>简单的Zenner二极管是一个一端元件，它包括二极管本身和一个并联电阻 R。二极管的公式是:
</p>

<blockquote><pre>
              v/Vt                -(v+Bv)/(Nbv*Vt)
i  =  Ids ( e      - 1) - Ibv ( e                  ).
</pre></blockquote>
<p>如果一个分支中的指数达到最大限值Maxexp，那么二极管特性将线性延续以避免溢出。
</p>

<p><br>相比简单二极管模型，Zener二极管模型允许在超过断点电压Bv(也称为Zener弯曲点电压)的反向偏置条件下通过电流。

<p>模型内热能=<em>i*v</em>。</p>

<p><strong>请注意：</strong>如果useHeatPort=true，那么该模型将<strong>忽略</strong>电气参数的温度依赖性，也就是说，所有的电气参数都被假定为不随温度变化的常数。</p>
</html>", revisions = "<html>
<ul>
<li><em> 2009年3月   </em>Christoph Clauss<br>添加了条件热端口<br>
       </li>
<li><em>2004年4月   </em>Christoph Clauss<br>创建<br>
       </li>
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
    points = {{0, -101}, {0, -20}}, 
    color = {127, 0, 0}, 
    pattern = LinePattern.Dot), 
    Line(points = {{30, -40}, {20, -40}}, color = {28, 108, 200})}));
end ZDiode;