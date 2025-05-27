model HeatingResistor "热电阻"
  parameter SI.Resistance R_ref(start = 1) 
    "在温度T_ref时的电阻";
  parameter SI.Temperature T_ref = 300.15 "参考温度";
  parameter SI.LinearTemperatureCoefficient alpha = 0 
    "电阻的温度系数(R=R_ref*(1+alpha*(heatPort.T-T_ref))";
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T = T_ref, 
    useHeatPort = true);
  SI.Resistance R 
    "电阻=R_ref*(1+alpha*(T_heatPort-T_ref))";
equation
  assert((1 + alpha * (T_heatPort - T_ref)) >= Modelica.Constants.eps, 
    "温度超出模型范围!");
  R = R_ref * (1 + alpha * (T_heatPort - T_ref));
  v = R * i;
  LossPower = v * i;
  annotation(defaultComponentName = "resistor", 
    Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
    100, 100}}), graphics = {Line(points = {{-110, 20}, {-85, 20}}, color = {
    160, 160, 164}), Polygon(
    points = {{-95, 23}, {-85, 20}, {-95, 17}, {-95, 23}}, 
    lineColor = {160, 160, 164}, 
    fillColor = {160, 160, 164}, 
    fillPattern = FillPattern.Solid), Line(points = {{90, 20}, {115, 20}}, 
    color = {160, 160, 164}), Line(points = {{-125, 0}, {-115, 0}}, color = {160, 160, 164}), 
    Line(points = {{-120, -5}, {-120, 5}}, color = {160, 160, 164}), 
    Text(
    extent = {{-110, 25}, {-90, 45}}, 
    lineColor = {160, 160, 164}, 
    textString = "i"), Polygon(
    points = {{105, 23}, {115, 20}, {105, 17}, {105, 23}}, 
    lineColor = {160, 160, 164}, 
    fillColor = {160, 160, 164}, 
    fillPattern = FillPattern.Solid), Line(points = {{115, 0}, {125, 0}}, 
    color = {160, 160, 164}), Text(
    extent = {{90, 45}, {110, 25}}, 
    lineColor = {160, 160, 164}, 
    textString = "i")}), 
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
    100}}), graphics = {
    Line(points = {{-90, 0}, {-70, 0}}, color = {0, 0, 255}), 
    Line(points = {{70, 0}, {90, 0}}, color = {0, 0, 255}), 
    Rectangle(
    extent = {{-70, 30}, {70, -30}}, 
    lineColor = {0, 0, 255}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), 
    Text(
    extent = {{-150, 90}, {150, 50}}, 
    textString = "%name", 
    lineColor = {0, 0, 255})}), 
    Documentation(info = "<html>
<p>这是一个电阻器的模型，其中产生的热量通过连接器<strong>heatPort</strong>散发到环境中，并且电阻R的阻值随温度变化，变化规律遵循以下方程式：</p>
<pre>    R=R_ref*(1+alpha*(heatPort.T-T_ref))</pre>
<p><strong>alpha</strong>是<strong>电阻的温度系数</strong>，通常简称为<strong>TCR</strong>。在电阻器目录中，它通常被定义为<strong>X[ppm/K]</strong>(百万分率，类似于百分比)，意味着<strong>X*1e-6[1/K]</strong>。电阻器的可用范围为1至7000ppm/K，即α=1e-6至7e-3[1/K]。</p>

<p>通过参数<strong>useHeatPort</strong>，可以启用或禁用热端口连接器(默认启用)。如果禁用，产生的热量将隐式传输到一个内部温度源，该源具有固定的参考温度T_ref。如果启用了热端口连接器，则必须将其连接。</p>
</html>", revisions = "<html>
<ul>
<li><em> 2009/8/7   </em>
     Anton Haumer<br> 添加电阻温度系数<br>
     </li>
<li><em> 2009/3/11   </em>
     Christoph Clauss<br>添加条件热端口<br>
     </li>
<li><em> 2002   </em>
     Anton Haumer<br> 创建<br>
     </li>
</ul>
</html>"));
end HeatingResistor;