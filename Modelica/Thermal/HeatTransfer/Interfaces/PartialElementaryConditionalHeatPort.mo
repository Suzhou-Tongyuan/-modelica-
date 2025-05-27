within Modelica.Thermal.HeatTransfer.Interfaces;
partial model PartialElementaryConditionalHeatPort 
  "基类模型(包含条件式HeatPort以耗散损耗，适用于文本建模，即基础模型)"
  parameter Boolean useHeatPort = false "= true，如果启用了 heatPort" 
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Temperature T=293.15 
    "如果useHeatPort = false，固定设备温度" 
    annotation(Dialog(enable=not useHeatPort));
  HeatTransfer.Interfaces.HeatPort_a heatPort(final T=TheatPort, final Q_flow=-
        lossPower) if useHeatPort 
    "以热量形式输送损耗的可选端口" 
    annotation (Placement(transformation(extent={{-110,-110},{-90,-90}}), 
        iconTransformation(extent={{-110,-110},{-90,-90}})));
  SI.Power lossPower 
    "通过热端口离开组件的损耗功率（> 0，如果热量流出组件）";
  SI.Temperature TheatPort "热端口温度";
equation
  if not useHeatPort then
     TheatPort = T;
  end if;
  annotation (Documentation(info="<html><p>
该基类模型提供了一个有条件的热接口，用于耗散损耗。
</p>
<li>
如果<strong>useHeatPort</strong>设置为<strong>false</strong>(默认)，无可用热接口，热损耗功率将在内部耗散。此时，<strong>参数T</strong>指定器件的固定温度（默认值T = 20°C）。</li>
<li>
当<strong>useHeatPort</strong>设置为<strong>true</strong>时，表示该热接口可用。</li>
<p>
如果使用此模型，需在继承自PartialElementaryConditionalHeatPort的模型中通过方程提供损耗功率 (<strong>lossPower =…</strong>)。器件温度<strong>TheatPort</strong>可用于描述器件温度对模型行为的影响。
</p>
</html>"));
end PartialElementaryConditionalHeatPort;