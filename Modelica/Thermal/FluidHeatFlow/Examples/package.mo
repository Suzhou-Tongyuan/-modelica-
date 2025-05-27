within Modelica.Thermal.FluidHeatFlow;
package Examples "演示热流体组件用法的示例"
  extends Modelica.Icons.ExamplesPackage;
  annotation (Documentation(info="<html><p>
该子库包含测试示例:
</p>
<ol><li>
SimpleCooling: 热量通过介质流动散失</li>
<li>
ParallelCooling: 两个热源通过合并的介质流散热</li>
<li>
IndirectCooling: 热量通过两个冷却循环散发</li>
<li>
PumpAndValve: 演示理想泵和阀门的使用方法</li>
<li>
PumpDropOut: 演示关闭和重新启动泵</li>
<li>
ParallelPumpDropOut: 演示并联回路中泵的停机和重启过程</li>
<li>
OneMass: 通过冷却液流冷却质量(热容量)</li>
<li>
TwoMass: 通过两个平行的冷却液流对两个质量(热容量)进行冷却</li>
<li>
WaterPump: 水泵站</li>
<li>
TestOpenTank: 测试 <a href=\"modelica://Modelica.Thermal.FluidHeatFlow.Components.OpenTank\" target=\"\">OpenTank</a>&nbsp; 模型</li>
<li>
TwoTanks: 两个连接的<a href=\"modelica://Modelica.Thermal.FluidHeatFlow.Components.OpenTank\" target=\"\">OpenTank</a>&nbsp; 模型</li>
<li>
TestCylinder: 测试 <a href=\"modelica://Modelica.Thermal.FluidHeatFlow.Components.Cylinder\" target=\"\">Cylinder</a>&nbsp; 模型</li>
</ol></html>"));
end Examples;