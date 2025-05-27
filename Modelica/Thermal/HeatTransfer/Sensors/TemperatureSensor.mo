within Modelica.Thermal.HeatTransfer.Sensors;
model TemperatureSensor "绝对温度传感器(K)"

  Modelica.Blocks.Interfaces.RealOutput T(unit="K") 
    "输出信号为绝对温度" 
    annotation (Placement(transformation(extent={{100,-10},{120,10}}), iconTransformation(extent={{100,-10},{120,10}})));
  Interfaces.HeatPort_a port annotation (Placement(transformation(extent={{
            -110,-10},{-90,10}})));
equation
  T = port.T;
  port.Q_flow = 0;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Ellipse(
          extent={{-20,-98},{20,-60}}, 
          lineThickness=0.5, 
          fillColor={191,0,0}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{-12,40},{12,-68}}, 
          lineColor={191,0,0}, 
          fillColor={191,0,0}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{12,0},{100,0}},color={0,0,127}), 
        Line(points={{-90,0},{-12,0}}, color={191,0,0}), 
        Polygon(
          points={{-12,40},{-12,80},{-10,86},{-6,88},{0,90},{6,88},{10,86}, 
              {12,80},{12,40},{-12,40}}, 
          lineThickness=0.5), 
        Line(
          points={{-12,40},{-12,-64}}, 
          thickness=0.5), 
        Line(
          points={{12,40},{12,-64}}, 
          thickness=0.5), 
        Line(points={{-40,-20},{-12,-20}}), 
        Line(points={{-40,20},{-12,20}}), 
        Line(points={{-40,60},{-12,60}}), 
        Text(
          extent={{-150,140},{150,100}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{20,60},{80,0}}, 
          textColor={64,64,64}, 
          textString="K")}), 
    Documentation(info="<html><p>
该理想绝对温度传感器能够以开尔文（K）为单位输出所连接端口的温度信号。传感器本身与其连接对象之间不存在任何热交互作用，且该传感器模型不存在类似热电偶的响应延迟现象。
</p>
</html>"));
end TemperatureSensor;