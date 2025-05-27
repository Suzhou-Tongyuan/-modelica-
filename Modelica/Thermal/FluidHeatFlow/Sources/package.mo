within Modelica.Thermal.FluidHeatFlow;
package Sources "理想的流体源，如环境、体积流"
  extends Modelica.Icons.SourcesPackage;
  annotation (Documentation(info="<html><p>
该子库包含不同类型的源：
</p>
<li>
具有恒定或规定压力和温度的环境</li>
<li>
绝对压力用于定义封闭式冷却循环的压力水平</li>
<li>
恒定流量和规定流量</li>
<li>
恒定和规定的压力增加</li>
<li>
带机械法兰的简易泵</li>
<p>
部分模型（BaseClasses 库）中定义了热力学方程。 所有风机/水泵均视为无损耗，不改变焓流量。
</p>
</html>"));
end Sources;