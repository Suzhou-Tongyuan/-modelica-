within Modelica.Electrical.Analog.Interfaces;
partial model PartialConditionalHeatPort 
  "这是一个部分模型，该模型包含一个条件性的热端口(HeatPort)，以便于散逸能量损失。这种模型通常用于图形化建模，即通过拖放的方式来构建模型"

  parameter Boolean useHeatPort = false "=true，当HeatPort端口的状态为enabled" 
    annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
  parameter SI.Temperature T = 293.15 
    "修正后设备温度(当useHeatPort的状态为false)" 
    annotation(Dialog(enable = not useHeatPort));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatPort 
    "可选端口(通过热能形式传输散失的损失)" 

    annotation(Placement(transformation(extent = {{-10, -110}, {10, -90}}), 
    iconTransformation(extent = {{-10, -110}, {10, -90}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(final T = T) if not useHeatPort 
    annotation(Placement(transformation(extent = {{40, -90}, {20, -70}})));
protected
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a internalHeatPort 
    annotation(Placement(transformation(extent = {{-4, -84}, {4, -76}})));
equation
  connect(heatPort, internalHeatPort) annotation(Line(
    points = {{0, -100}, {0, -80}}, color = {191, 0, 0}));
  connect(fixedTemperature.port, internalHeatPort) annotation(Line(
    points = {{20, -80}, {0, -80}}, color = {191, 0, 0}));
  annotation(Documentation(info = "<html>
<p>这个部分模型提供了一个条件热端口，该端口可以用于散逸处理损失。
</p>

<ul>
<li>如果<strong>useHeatPort</strong>设置为false，则不提供热端口，热损失功率将在内部散失。在这种情况下，参数T指定了固定设备的温度(T = 20°C是默认值)。</li>
<li>如果<strong>useHeatPort</strong>设置为<strong>true</strong>，则热端口开始运转。
</li>

</ul>
<p>
如果使用这个模型，那么因其基于自PartialElementaryConditionalHeatPort模型搭建，该模型中必须连接internalHeatPort。<strong>internalHeatPort.T</strong>可以用来描述设备温度对模型行为的影响。
</p>
</html>"));
end PartialConditionalHeatPort;