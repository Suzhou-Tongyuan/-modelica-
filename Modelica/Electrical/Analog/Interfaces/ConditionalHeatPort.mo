within Modelica.Electrical.Analog.Interfaces;
partial model ConditionalHeatPort 
  "部分模型中包含一个可选热端口(用以描述热网络中功耗)"
  parameter Boolean useHeatPort = false "=true，当heatPort=enabled" 
    annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
  parameter SI.Temperature T = 293.15 
    "修正后设备温度，当useHeatPort=false" annotation(Dialog(enable = not useHeatPort));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(final T = T_heatPort, final Q_flow = -LossPower) if useHeatPort 
    "可选热端口" 
    annotation(Placement(transformation(extent = {{-10, -110}, {10, -90}}), 
    iconTransformation(extent = {{-10, -110}, {10, -90}})));
  SI.Power LossPower "Loss power leaving component via heatPort";
  SI.Temperature T_heatPort "热端口的温度";
equation
  if not useHeatPort then
    T_heatPort = T;
  end if;

  annotation(Documentation(revisions = "<html>
<ul>
<li><em>February 17, 2009</em>
       由Christoph Clauss<br>创建<br>
       </li>
</ul>
</html>", 
    info = "<html>
<p>这个部分模型提供了一个条件性加热端口，用于连接到热网络。
</p>

<ul>
<li>如果<strong>useHeatPort</strong>设置为<strong>false</strong>(默认值)，则不提供热端口，热损耗功率会内部流向地面。在这种情况下，参数<strong>T</strong>指定固定的设备温度(T的默认值为20°C)。
</li>

<li>如果<strong>useHeatPort</strong>设置为<strong>true</strong>，则提供热端口。
</li>
</ul>

<p>如果使用这个模型，那么损耗功率必须通过该模型中的一个方程式来提供，该方程式继承自ConditionalHeatingPort模型(<strong>损耗功率 = ...</strong>)。设备温度<strong>T_heatPort</strong>可以用来描述设备温度对模型行为的影响。
</p>

</html>"));
end ConditionalHeatPort;