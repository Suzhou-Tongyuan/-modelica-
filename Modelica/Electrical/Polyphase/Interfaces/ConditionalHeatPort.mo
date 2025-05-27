within Modelica.Electrical.Polyphase.Interfaces;
partial model ConditionalHeatPort 
  "部分模型，包含有条件的热端口，以描述通过热网络的功率损失"
  parameter Integer mh(min=1) = 3 "热端口数量=相数";
  parameter Boolean useHeatPort=false 
    "=true，如果所有热端口均启用" annotation (
    Evaluate=true, 
    HideResult=true, 
    choices(checkBox=true));
  parameter SI.Temperature T[mh]=fill(293.15, mh) 
    "如果useHeatPort=false，则为固定设备温度" 
    annotation (Dialog(enable=not useHeatPort));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort[mh] if 
    useHeatPort "有条件的热端口" annotation (Placement(
        transformation(extent={{-10,-110},{10,-90}}), iconTransformation(
          extent={{-10,-110},{10,-90}})));
  annotation (Documentation(revisions="<html>
<ul>
<li><em>2009年8月26日</em>，由Anton Haumer最初实现</li>
</ul>
</html>", 
      info="<html>
<p>
该部分模型提供有条件的热端口，用于连接到热网络。
</p>
<ul>
<li> 如果<strong>useHeatPort</strong>设置为<strong>false</strong>(默认)，则不可用热端口，并且热损耗功率内部流向地面。在这种情况下，参数<strong>T</strong>指定固定设备温度。</li>
<li> 如果<strong>useHeatPort</strong>设置为<strong>true</strong>，则所有热端口均可用。</li>
</ul>
</html>"));
end ConditionalHeatPort;