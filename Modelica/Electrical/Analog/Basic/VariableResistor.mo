within Modelica.Electrical.Analog.Basic;
model VariableResistor 
  "理想线性可变电阻"
  parameter SI.Temperature T_ref = 300.15 "参考温度";
  parameter SI.LinearTemperatureCoefficient alpha = 0 
    "电阻的温度因数(R_actual = R*(1 + alpha*(T_heatPort - T_ref))";
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T = T_ref);
  SI.Resistance R_actual 
    "实际电阻=R*(1+alpha*(T_heatPort-T_ref))";
  Modelica.Blocks.Interfaces.RealInput R(unit = "Ohm") annotation(Placement(
    transformation(
    origin = {0, 120}, 
    extent = {{-20, -20}, {20, 20}}, 
    rotation = 270), iconTransformation(
    extent = {{-20, -20}, {20, 20}}, 
    rotation = 270, 
    origin = {0, 120})));
equation
  assert((1 + alpha * (T_heatPort - T_ref)) >= Modelica.Constants.eps, 
    "Temperature outside scope of model!");
  R_actual = R * (1 + alpha * (T_heatPort - T_ref));
  v = R_actual * i;
  LossPower = v * i;
  annotation(defaultComponentName = "resistor", 
    Documentation(info = "<html>
<p>线性电阻器通过连接支路电压<em>v</em>和支路电流<em>i</em>实现功能，其中<br><em><strong>i*R=v</strong></em>
<br>电阻<em>R</em>作为一个输入信号。
<br><br><strong>请注意:</strong><br>建议R信号不应穿越零值。否则，根据周边电路的特性，出现奇异点singularities的概率会增加。</p>
</html>", 
    revisions = "<html>
<ul>
<li><em> 2009/8/7   </em>
     Anton Haumer<br> 添加电阻温度系数<br>
     </li>
<li><em> 2009/3/11   </em>
     Christoph Clauss<br>添加条件热端口<br>
     </li>

<li><em> 2004/6/7   </em>
      Christoph Clauss<br>修改说明文档<br>
     </li>
     
     
<li><em> 2004/4/30   </em>
     Anton Haumer<br> 创建<br>
     </li>
</ul>

</html>"), 
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
    100}}), graphics = {
    Line(points = {{-90, 0}, {-70, 0}}, color = {0, 0, 255}), 
    Rectangle(
    extent = {{-70, 30}, {70, -30}}, 
    lineColor = {0, 0, 255}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{70, 0}, {90, 0}}, color = {0, 0, 255}), 
    Text(
    extent = {{-150, 90}, {150, 50}}, 
    textString = "%name", 
    textColor = {0, 0, 255})}));
end VariableResistor;