within Modelica.Thermal.FluidHeatFlow.Sensors;
model VolumeFlowSensor "体积流量传感器"

  extends FluidHeatFlow.Interfaces.FlowSensor(y(unit="m3/s") 
      "输出信号为体积流量");
equation
  y = V_flow;
  annotation (
    Documentation(info="<html>
<p>体积流量传感器测量体积流量。</p>
<p>热力学方程由 Interfaces.FlowSensor 定义。</p>
</html>"), 
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-50,-14},{50,-54}}, 
          textColor={64,64,64}, 
          textString="m3/s")}));
end VolumeFlowSensor;