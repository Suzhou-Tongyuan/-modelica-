within Modelica.Thermal.FluidHeatFlow.Sensors;
model MassFlowSensor "质量流量传感器"

  extends FluidHeatFlow.Interfaces.FlowSensor(y(unit="kg/s") 
      "质量流量作为输出信号");
equation
  y = V_flow*medium.rho;
  annotation (
    Documentation(info="<html><p>
质量流量传感器测量质量流量。
</p>
<p>
热力学方程由 Interfaces.FlowSensor 定义。
</p>
</html>"), 
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-50,-14},{50,-54}}, 
          textColor={64,64,64}, 
          textString="kg/s")}));
end MassFlowSensor;