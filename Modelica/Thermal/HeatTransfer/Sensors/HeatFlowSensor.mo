within Modelica.Thermal.HeatTransfer.Sensors;
model HeatFlowSensor "热流量传感器"
  extends Modelica.Icons.RoundSensor;
  Modelica.Blocks.Interfaces.RealOutput Q_flow(unit="W") 
    "输出信号为从端口_a 到端口_b 的热流量" annotation (Placement(
        transformation(
        origin={0,-110}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270), iconTransformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={0,-110})));
  Interfaces.HeatPort_a port_a annotation (Placement(transformation(extent={{
            -110,-10},{-90,10}})));
  Interfaces.HeatPort_b port_b annotation (Placement(transformation(extent={{
            90,-10},{110,10}})));
equation
  port_a.T = port_b.T;
  port_a.Q_flow + port_b.Q_flow = 0;
  Q_flow = port_a.Q_flow;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Line(points={{-70,0},{-90,0}}, color={191,0,0}), 
        Line(points={{70,0},{90,0}}, color={191,0,0}), 
        Line(points={{0,-70},{0,-100}},color={0,0,127}), 
        Text(
          extent={{-150,120},{150,80}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-30,-10},{30,-70}}, 
          textColor={64,64,64}, 
          textString="W")}), 
    Documentation(info="<html><p>
该模型能够监测流经组件的热流率（W）。在保持传感器两端温差为零的条件下，所测得的热流率即为通过传感器的实际热流量。作为理想模型，其本身不会吸收任何能量，且不会对所在系统的热响应产生直接影响。当热流从端口a流向端口b时，输出信号为正值。
</p>
</html>"));
end HeatFlowSensor;