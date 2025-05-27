within Modelica.Thermal.FluidHeatFlow.Interfaces;
partial model FlowSensor "流量传感器的基类模型"
  extends Modelica.Icons.RoundSensor;
  extends FluidHeatFlow.BaseClasses.TwoPort(
    final m=0, 
    final T0=293.15, 
    final T0fixed=false, 
    final tapT=1);
  Modelica.Blocks.Interfaces.RealOutput y 
    annotation (Placement(transformation(
        origin={0,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
equation
  // 无压降
  dp = 0;
  // 无能量交换
  Q_flow = 0;
annotation (Documentation(info="<html><p>
流量传感器（质量流量/热流量）的基类模型。
</p>
<p>
不影响介质的压力、质量流量、温度和焓流量，但采用混合规则。
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
end FlowSensor;