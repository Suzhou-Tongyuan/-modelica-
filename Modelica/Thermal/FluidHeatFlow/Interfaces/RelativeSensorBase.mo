within Modelica.Thermal.FluidHeatFlow.Interfaces;
partial model RelativeSensorBase "无信号输出的相对传感器基类模型"
  extends Modelica.Icons.RoundSensor;
  parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium() 
    "传感器介质" annotation (choicesAllMatching=true);
  FluidHeatFlow.Interfaces.FlowPort_a flowPort_a(final medium=medium) 
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  FluidHeatFlow.Interfaces.FlowPort_b flowPort_b(final medium=medium) 
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  // 无质量交换
  flowPort_a.m_flow = 0;
  flowPort_b.m_flow = 0;
  // 无能量交换
  flowPort_a.H_flow = 0;
  flowPort_b.H_flow = 0;
annotation (Documentation(info="<html><p>
无信号输出的相对传感器（压降/温差）基类模型。
</p>
<p>
介质的压力、质量流量、温度和焓流量不受影响。
</p>
</html>"), 
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
            -100},{100,100}}), graphics={
        Line(points={{-70,0},{-90,0}}, color={255,0,0}), 
        Line(points={{70,0},{90,0}}, color={255,0,0}), 
        Line(points={{0,-100},{0,-70}}, color={0,0,127}), 
        Text(
          extent={{-150,90},{150,130}}, 
          textString="%name", 
          textColor={0,0,255})}));
end RelativeSensorBase;