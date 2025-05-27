within Modelica.Thermal.FluidHeatFlow.Sensors;
model RelTemperatureSensor "温差传感器"

  extends FluidHeatFlow.Interfaces.RelativeSensorBase;
  Modelica.Blocks.Interfaces.RealOutput y(unit="K") 
    "输出信号为温差" 
        annotation (absoluteValue = false, Placement(transformation(
        origin={0,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
equation
  medium.cp*y = flowPort_a.h - flowPort_b.h;
  annotation (
    Documentation(info="<html><p>
温差传感器测量流量端口_a 和流量端口_b 之间的温差。
</p>
<p>
热力学方程的定义是 <a href=\"modelica://Modelica.Thermal.FluidHeatFlow.Interfaces.RelativeSensorBase\" target=\"\">Interfaces.RelativeSensorBase</a>&nbsp;。
</p>
<p>
<strong>注释:</strong> 连接的流量端口具有相同的温度(混合温度)! 由于会发生混合，组件的出口温度可能与连接器的温度不同。 出口温度由相应组件的变量 T 定义。
</p>
</html>"), 
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-30,-10},{30,-70}}, 
          textColor={64,64,64}, 
          textString="K")}));
end RelTemperatureSensor;