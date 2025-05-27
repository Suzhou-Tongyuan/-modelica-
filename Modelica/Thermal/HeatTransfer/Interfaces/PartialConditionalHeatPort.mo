within Modelica.Thermal.HeatTransfer.Interfaces;
partial model PartialConditionalHeatPort 
  "基类模型(包含条件式HeatPort以耗散损耗，适用于图形建模，即拖拽式建模)"
  parameter Boolean useHeatPort = false "= true，如果启用了热端口" 
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Temperature T=293.15 
    "如果useHeatPort = false，设备温度固定不变" 
    annotation(Dialog(enable=not useHeatPort));
  HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatPort 
    "以热量形式输送损耗的可选端口" 
    annotation (Placement(transformation(extent={{-110,-110},{-90,-90}}), 
        iconTransformation(extent={{-110,-110},{-90,-90}})));
  HeatTransfer.Sources.FixedTemperature fixedTemperature(final T=T) if not 
    useHeatPort 
    annotation (Placement(transformation(extent={{-60,-90},{-80,-70}})));
protected
  HeatPort_a internalHeatPort 
    annotation (Placement(transformation(extent={{-104,-84},{-96,-76}})));
equation
  connect(heatPort, internalHeatPort) annotation (Line(
      points={{-100,-100},{-100,-80}}, color={191,0,0}));
  connect(fixedTemperature.port, internalHeatPort) annotation (Line(
      points={{-80,-80},{-100,-80}}, color={191,0,0}));
  annotation (Documentation(info="<html><p>
该基类模型提供了一个有条件的热接口，用于耗散损耗。
</p>
<li>
如果<strong>useHeatPort</strong>设置为<strong>false</strong>(默认)，无可用热接口，热损耗功率将在内部耗散。。在这种情况下，参数<strong>T</strong>指定固定的设备温度(默认为T = 20&℃)</li>
<li>
当<strong>useHeatPort</strong>设置为<strong>true</strong>时，表示该热接口可用。</li>
<p>
使用此模型时，继承自PartialElementaryConditionalHeatPort的模型中必须对<strong>internalHeatPort</strong>进行连接。 器件温度<strong>internalHeatPort.T</strong>可以用来描述器件温度对模型行为的影响。
</p>
</html>"));
end PartialConditionalHeatPort;