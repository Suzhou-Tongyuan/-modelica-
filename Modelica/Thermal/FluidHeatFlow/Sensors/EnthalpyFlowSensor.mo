within Modelica.Thermal.FluidHeatFlow.Sensors;
model EnthalpyFlowSensor "焓流量传感器"

  extends FluidHeatFlow.Interfaces.FlowSensor(y(unit="W") 
      "焓流作为输出信号");
equation
  y = flowPort_a.H_flow;
  annotation (
    Documentation(info="<html>
<p>焓流量传感器测量焓流量。</p>
<p>热力学方程由 Interfaces.FlowSensor 定义。</p>
</html>"), 
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-30,-10},{30,-70}}, 
          textColor={64,64,64}, 
          textString="W")}));
end EnthalpyFlowSensor;