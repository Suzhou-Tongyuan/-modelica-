within Modelica.Thermal.FluidHeatFlow;
package Sensors "测量接口特性的理想传感器"
  extends Modelica.Icons.SensorsPackage;
  annotation (Documentation(info="<html><p>
该子库包含传感器：
</p>
<li>
PressureSensor：绝对压力</li>
<li>
TemperatureSensor：绝对温度（K）</li>
<li>
RelPressureSensor: 流量端口_a 和流量端口_b 之间的压降</li>
<li>
RelTemperatureSensor: 流量端口_a 和流量端口_b 之间的温度差</li>
<li>
MassFlowSensor：测量质量流量</li>
<li>
VolumeFlowSensor: 测量体积流量</li>
<li>
EnthalpyFlowSensor: 测量焓流量</li>
<p>
某些传感器在测量时不需要访问介质属性、 但有必要在连接器中定义介质（连接检查）。 热力学方程在部分模型（BaseClasses 库）中定义。 所有传感器都被视为无质量，不会改变质量流或焓流。
</p>
</html>"));
end Sensors;