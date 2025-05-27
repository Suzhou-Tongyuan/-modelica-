within Modelica.Thermal.FluidHeatFlow.Sensors;
model RelPressureSensor "压差传感器"

  extends FluidHeatFlow.Interfaces.RelativeSensorBase;
  Modelica.Blocks.Interfaces.RealOutput y(unit="Pa", displayUnit="bar") 
    "输出信号为压差" 
 annotation (absoluteValue = false, Placement(transformation(
        origin={0,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
equation
  y = flowPort_a.p - flowPort_b.p;
annotation (
    Documentation(info="<html><p>
压差传感器测量流量端口_a 和流量端口_b 之间的压降。
</p>
<p>
热力学方程的定义是 <a href=\"modelica://Modelica.Thermal.FluidHeatFlow.Interfaces.RelativeSensorBase\" target=\"\">Interfaces.RelativeSensorBase</a>&nbsp;。
</p>
</html>"), 
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-30,-10},{30,-70}}, 
          textColor={64,64,64}, 
          textString="Pa")}));
end RelPressureSensor;