within Modelica.Thermal.HeatTransfer.Sources;
model FixedHeatFlow "固定热流边界条件"
  parameter SI.HeatFlowRate Q_flow 
    "端口的固定热流量";
  parameter SI.Temperature T_ref=293.15 
    "参考温度";
  parameter SI.LinearTemperatureCoefficient alpha=0 
    "热流量温度系数";
  Interfaces.HeatPort_b port annotation (Placement(transformation(extent={{90, 
            -10},{110,10}})));
equation
  port.Q_flow = -Q_flow*(1 + alpha*(port.T - T_ref));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Text(
          extent={{-150,100},{150,60}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-150,-55},{150,-85}}, 
          textString="Q_flow=%Q_flow"), 
        Line(
          points={{-100,-20},{48,-20}}, 
          color={191,0,0}, 
          thickness=0.5), 
        Line(
          points={{-100,20},{46,20}}, 
          color={191,0,0}, 
          thickness=0.5), 
        Polygon(
          points={{40,0},{40,40},{70,20},{40,0}}, 
          lineColor={191,0,0}, 
          fillColor={191,0,0}, 
          fillPattern=FillPattern.Solid), 
        Polygon(
          points={{40,-40},{40,0},{70,-20},{40,-40}}, 
          lineColor={191,0,0}, 
          fillColor={191,0,0}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{70,40},{90,-40}}, 
          lineColor={191,0,0}, 
          fillColor={191,0,0}, 
          fillPattern=FillPattern.Solid)}), 
    Documentation(info="<html><p style=\"text-align: start;\">该模型允许在指定端口向热力系统\"注入\"设定的热流率。恒定热流率Q_flow作为参数给定。当参数Q_flow为正值时，热量将流入与FixedHeatFlow组件相连接的部件。
</p>
<p style=\"text-align: start;\">若参数alpha≠0，热流将乘以(1 + alpha*(port.T - T_ref))，用以模拟与温度相关的损耗（该损耗基于参考温度T_ref计算）。
</p>
</html>"));
end FixedHeatFlow;