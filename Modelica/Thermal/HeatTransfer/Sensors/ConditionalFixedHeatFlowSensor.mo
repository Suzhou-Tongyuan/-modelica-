within Modelica.Thermal.HeatTransfer.Sensors;
model ConditionalFixedHeatFlowSensor 
  "热流传感器，条件固定温度"
  extends Modelica.Icons.RoundSensor;
  parameter Boolean useFixedTemperature(start=false) 
    "如果为true，固定温度" 
    annotation(Evaluate=true);
  HeatTransfer.Interfaces.HeatPort_a port_a 
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  HeatTransfer.Interfaces.HeatPort_b port_b 
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  HeatTransfer.Sources.FixedTemperature fixedTemperature(final T(displayUnit= 
          "K") = 293.15) if useFixedTemperature annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-50,-30})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow(unit="W") 
    "输出信号为从端口_a 到端口_b 的热流量" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={0,-110})));
equation
  connect(heatFlowSensor.port_b, port_b) annotation (Line(
      points={{10,0},{100,0}}, color={191,0,0}));
  connect(port_a, heatFlowSensor.port_a) annotation (Line(
      points={{-100,0},{-10,0}}, color={191,0,0}));
  connect(fixedTemperature.port, heatFlowSensor.port_a) annotation (Line(
      points={{-50,-20},{-50,0},{-10,0}}, color={191,0,0}));
  connect(heatFlowSensor.Q_flow, Q_flow) annotation (Line(
      points={{0,-11},{0,-110}},color={0,0,127}));
  annotation (defaultComponentName="heatFlowSensor", 
    Icon(graphics={
      Line(points={{0,-70},{0,-100}},  color = {0,0,127}), 
        Text(
          extent={{-150,120},{150,80}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Line(
          points={{-90,0},{-70,0}}, 
          color={191,0,0}, 
          pattern=LinePattern.Dash), 
        Line(
          points={{70,0},{90,0}}, 
          color={191,0,0}, 
          pattern=LinePattern.Dash), 
        Text(
          extent={{-30,-10},{30,-70}}, 
          textColor={64,64,64}, 
          textString="W")}, 
        coordinateSystem(extent = {{-100,-100},{100,100}}, 
          preserveAspectRatio = true)), 
    Documentation(info="<html><p>
如果 useFixedTemperature = false，则该传感器的作用与普通传感器<a href=\"modelica://Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor\" target=\"\">HeatFlowSensor</a>&nbsp;相同。 
</p>
<p>
如果 useFixedTemperature = true，则假设该传感器的两个热端口连接被有条件断开，此时测得的热流量Q_flow将自动归零。为避免出现奇异方程组，传感器温度将被设定为293.15 K。
</p>
</html>"));
end ConditionalFixedHeatFlowSensor;