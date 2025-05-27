within Modelica.Thermal.HeatTransfer.Sources;
model PrescribedHeatFlow "设定热流边界条件"
  parameter SI.Temperature T_ref=293.15 
    "参考温度";
  parameter SI.LinearTemperatureCoefficient alpha=0 
    "热流量温度系数";
  Modelica.Blocks.Interfaces.RealInput Q_flow(unit="W") 
        annotation (Placement(transformation(
        origin={-100,0}, 
        extent={{20,-20},{-20,20}}, 
        rotation=180)));
  Interfaces.HeatPort_b port annotation (Placement(transformation(extent={{90, 
            -10},{110,10}})));
equation
  port.Q_flow = -Q_flow*(1 + alpha*(port.T - T_ref));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Line(
          points={{-60,-20},{40,-20}}, 
          color={191,0,0}, 
          thickness=0.5), 
        Line(
          points={{-60,20},{40,20}}, 
          color={191,0,0}, 
          thickness=0.5), 
        Line(
          points={{-80,0},{-60,-20}}, 
          color={191,0,0}, 
          thickness=0.5), 
        Line(
          points={{-80,0},{-60,20}}, 
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
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-150,100},{150,60}}, 
          textString="%name", 
          textColor={0,0,255})}), 
    Documentation(info="<html><p>
该模型允许通过指定端口向热力系统\"注入\"设定的热流率。热流量值由输入至模型的信号Q_flow确定。当输入信号为正值时，热量将流入与PrescribedHeatFlow组件相连接的部件。
</p>
<p>
如果参数 alpha 为 0，则热流乘以 (1 + alpha*（port.T - T_ref)) 以模拟与温度有关的损耗（损耗与参考温度 T_ref 有关）。
</p>
</html>"));
end PrescribedHeatFlow;