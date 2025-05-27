within Modelica.Thermal.FluidHeatFlow.Interfaces;
partial model AbsoluteSensor "绝对传感器的基类模型"
  extends Modelica.Icons.RoundSensor;
  parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium() 
    "传感器介质" annotation (choicesAllMatching=true);
  FluidHeatFlow.Interfaces.FlowPort_a flowPort(final medium=medium) 
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.RealOutput y 
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  // 无质量交换
  flowPort.m_flow = 0;
  // 无能量交换
  flowPort.H_flow = 0;
annotation (Documentation(info="<html><p>
绝对传感器(压力/温度)的基类模型。
</p>
<p>
介质的压力、质量流量、温度和焓流量不受影响。
</p>
</html>"), 
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
            -100},{100,100}}), graphics={
        Line(points={{-70,0},{-90,0}}, color={255,0,0}), 
        Line(points={{70,0},{100,0}}, color={0,0,127}), 
        Text(
          extent={{-150,90},{150,130}}, 
          textString="%name", 
          textColor={0,0,255})}));
end AbsoluteSensor;