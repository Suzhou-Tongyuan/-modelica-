within Modelica.Thermal.FluidHeatFlow.Sensors;
model PressureSensor "绝对压力传感器"

  extends FluidHeatFlow.Interfaces.AbsoluteSensor(y(unit="Pa", displayUnit= 
          "bar") "输出信号为绝对压力");
equation
  y = flowPort.p;
  annotation (
    Documentation(info="<html>
<p>压力传感器测量绝对压力。</p>
<p>热力学方程由 Interfaces.AbsoluteSensor 定义。</p>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-30,-10},{30,-70}}, 
          textColor={64,64,64}, 
          textString="Pa")}));
end PressureSensor;