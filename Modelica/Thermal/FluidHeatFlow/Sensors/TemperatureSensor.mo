within Modelica.Thermal.FluidHeatFlow.Sensors;
model TemperatureSensor "绝对温度传感器"

  extends FluidHeatFlow.Interfaces.AbsoluteSensor(y(unit="K") 
      "输出信号为绝对温度");
equation
  medium.cp*y = flowPort.h;
annotation (
    Documentation(info="<html><p>
温度传感器测量绝对温度(K)。
</p>
<p>
热力学方程由Interfaces.AbsoluteSensor定义。
</p>
</html>"), 
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-30,-10},{30,-70}}, 
          textColor={64,64,64}, 
          textString="K")}));
end TemperatureSensor;