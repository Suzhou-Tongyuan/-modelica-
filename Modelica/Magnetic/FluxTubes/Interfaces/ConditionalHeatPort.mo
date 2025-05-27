within Modelica.Magnetic.FluxTubes.Interfaces;
partial model ConditionalHeatPort 
  "部分模型包括一个条件热端口，以描述通过热网的功率损失"

  parameter Boolean useHeatPort = false "= true, 如果启用了HeatPort" 
  annotation(Evaluate=true, HideResult=true, choices(checkBox=true), Dialog(tab="Losses and heat", group="HeatPort"));
  parameter SI.Temperature T=293.15 
    "如果 useHeatPort = false，固定设备温度" annotation(Dialog(tab="Losses and heat", group="HeatPort", enable=not useHeatPort));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(final T=T_heatPort, final Q_flow=-LossPower) if useHeatPort 
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}}), 
        iconTransformation(extent={{-10,-110},{10,-90}})));
  SI.Power LossPower 
    "通过HeatPort失去电源离开组件";
  SI.Temperature T_heatPort "热口温度";
equation
  if not useHeatPort then
     T_heatPort = T;
  end if;

  annotation (Documentation(revisions="<html>
<ul>
<li><em>February 17, 2009</em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", 
      info="<html>
<p>
这种局部模型为连接到热网提供了一个有条件的加热端口.
</p>
<ul>
<li> 如果<strong>useHeatPort</strong>设置为<strong>false</strong>(默认值)，则没有热口可用，热口会自动关闭
损耗功率从内部流向地面。在本例中，参数<strong>T</strong>指定
固定设备温度(默认为T = 20<sup>o</sup>C).</li>
<li> 当<strong>useHeatPort</strong>设置为<strong>true</strong>时，表示有一个热口可用.</li>
</ul>

<p>
如果使用该模型，则损耗功率必须由继承自的模型中的方程提供
ConditionalHeatingPort模型(<strong>lossPower =…</strong>)。器件温度
<strong>T_heatPort</strong>可以用来描述设备温度的影响
关于模型行为.
</p>
</html>"));
end ConditionalHeatPort;