within Modelica.Thermal.HeatTransfer.Interfaces;
partial model PartialElementaryConditionalHeatPortWithoutT 
  "基类模型(包含条件式HeatPort以耗散损耗，适用于文本建模，即基础模型)"
  parameter Boolean useHeatPort = false "= true，如果启用了热端口" 
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  HeatTransfer.Interfaces.HeatPort_a heatPort(final Q_flow=-lossPower) if 
    useHeatPort 
    "以热量形式输送损耗的可选端口" 
    annotation (Placement(transformation(extent={{-110,-110},{-90,-90}}), 
        iconTransformation(extent={{-110,-110},{-90,-90}})));
  SI.Power lossPower 
    "通过热端口离开组件的损耗功率(> 0，如果热量流出组件)";
  annotation (Documentation(info="<html><p>
该基类模型提供了一个有条件的热接口，用于耗散损耗。
</p>
<li>
当<strong>useHeatPort</strong>设置为<strong>false</strong>(默认)，则无可用热接口，热损耗功率将在内部耗散。</li>
<li>
当<strong>useHeatPort</strong>设置为<strong>true</strong>时，热接口可用且必须进行外部连接。</li>
<p>
如果使用此模型，需在继承自PartialElementaryConditionalHeatPortWithoutT的模型中通过方程提供损耗功率 (<strong>lossPower =…</strong>)。
</p>
<p>
注意：此基类模型适用于未使用heatPort.T（即器件温度）的场景。若需使用温度参数，请改为继承基类模型<a href=\"modelica://Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPort\" target=\"\">PartialElementaryConditionalHeatPort</a>&nbsp;。
</p>
</html>"));
end PartialElementaryConditionalHeatPortWithoutT;