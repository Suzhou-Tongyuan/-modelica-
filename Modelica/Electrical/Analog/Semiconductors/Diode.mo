within Modelica.Electrical.Analog.Semiconductors;
model Diode "带热端口的简单二极管"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  parameter SI.Current Ids = 1e-6 "饱和电流";
  parameter Boolean useTemperatureDependency = false "=true(如果二极管的电流受温度影响，那么它会根据温度的变化而变化)，反之，则需要将温度对二极管行为的效应转化为电压的形式来表示，即使用温度电压系数TCV" 
    annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
  parameter SI.Voltage Vt = 0.04 "电压等效于温度(kT/qn)" 
    annotation(Dialog(enable = not useTemperatureDependency));
  parameter Real Maxexp(final min = Modelica.Constants.small) = 15 "线性延续的最大指数";
  parameter SI.Resistance R = 1e8 "并联欧姆电阻";
  parameter Real EG = 1.11 "活化能" annotation(Dialog(enable = useTemperatureDependency));
  parameter Real N = 1 "发射系数" annotation(Dialog(enable = useTemperatureDependency));
  parameter SI.Temperature TNOM = 300.15 "测量参数的温度" annotation(Dialog(enable = useTemperatureDependency));
  parameter Real XTI = 3 "饱和电流的温度指数" annotation(Dialog(enable = useTemperatureDependency));
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(useHeatPort = useTemperatureDependency);

  SI.Voltage vt_t "Temperature voltage";
  SI.Current id "Diode current";
protected
  SI.Temperature htemp "辅助温度";
  Real aux;
  Real auxp;
equation
  assert(T_heatPort > 0, "Temperature must be positive");
  htemp = T_heatPort;
  vt_t = k * htemp / q;

  if useTemperatureDependency then
    id = Ids * (exlin(v / (N * vt_t), Maxexp) - 1);
    i = id * pow(htemp / TNOM, XTI / N) * auxp + v / R;
  else
    id = Ids * (exlin(v / Vt, Maxexp) - 1);
    i = smooth(1, id + v / R);
  end if;

  aux = (htemp / TNOM - 1) * EG / (N * vt_t);
  auxp = exp(aux);

  LossPower = i * v;
  annotation(defaultComponentName = "diode", 
    Documentation(info = "<html>
<p>简单二极管是一个电气一端口模型，该模型有一个热端口(热端口定义在Modelica.Thermal库中)。该模型二极管本身和并联电阻<em>R</em>组成。如果<em>useTemperatureDependency</em>设置为true，则二极管公式为：
</p>

<blockquote><pre>
           v/N/vt_t
i = Ids (e          - 1)
</pre></blockquote>
其中<em>vt_t</em>随热端口温度的变化而变化：
<blockquote><pre>
vt_t = k*temp/q
</pre></blockquote>
<p>
如果<em>useTemperatureDependency</em>被设置为<em>false</em>，二极管的电压与温度有关，例如，
</p>
<blockquote><pre>
           v/Vt
i = Ids (e      - 1).
</pre></blockquote>
<p>
当电压<em>v</em>的指数表达超出其理论<em>最大值</em>时，计算会采用一种线性近似方法，将超出部分的指数部分替换为一个线性关系，这样可以保持输出在可处理的范围内，同时保持二极管特性的连续性。
<br>
模型中热能=<em>i*v</em>。
</p>
</html>", 
    revisions = "<html>
<ul>
<li><em> March 11, 2009   </em>
       Christoph Clauss<br>添加conditional heat port<br>
       </li>
<li><em>April 5, 2004   </em>
       Christoph Clauss<br>创建<br>
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
    extent = {{-150, -40}, {150, -80}}, 
    textString = "Vt=%Vt", 
    visible = not useTemperatureDependency), 
    Text(
    extent = {{-150, 90}, {150, 50}}, 
    textString = "%name", 
    textColor = {0, 0, 255}), 
    Line(
    visible = useHeatPort, 
    points = {{0, -100}, {0, -20}}, 
    color = {127, 0, 0}, 
    pattern = LinePattern.Dot)}));
end Diode;