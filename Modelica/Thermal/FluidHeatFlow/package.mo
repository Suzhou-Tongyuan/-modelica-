within Modelica.Thermal;
package FluidHeatFlow "一维不可压缩热流体流动模型的简单组件"
  extends Modelica.Icons.Package;
  annotation (
    Documentation(info="<html><p>
该库包含非常简单易用的组件，可以根据需要对冷却液流进行建模，例如模拟电机的冷却：
</p>
<li>
组件:如不同类型的管道模型</li>
<li>
示例:一些测试示例</li>
<li>
接口:定义连接器和部分模型(包含核心热力学方程)</li>
<li>
介质:介质属性的定义</li>
<li>
传感器:各种压力、温度、体积、焓流传感器</li>
<li>
源:各种流量源</li>
<p>
<strong>连接器中使用的变量:</strong>
</p>
<li>
压力 p</li>
<li>
质量流量 m_flow</li>
<li>
比焓 h</li>
<li>
焓流量 H_flow</li>
<p>
焓流量可表示为: Enthalpy = cp<sub>constant</sub> * m * T ,这是由介质的流动携带的。
</p>
<p>
<strong>限制和假设:</strong>
</p>
<li>
冷却液流的分流与混合（具有相同比热容 cp 的介质）是可能的。</li>
<li>
流动方向可以反向。</li>
<li>
介质被认为是不可压缩的。</li>
<li>
不考虑介质的混合。</li>
<li>
介质不能发生相变。</li>
<li>
介质物性保持不变。</li>
<li>
压力变化只考虑压降和高度差 rho*g*h (if h &gt; 0)。</li>
<li>
一个用户定义的部分(0..1)的摩擦损失(V_flow*dp)被输送到介质。</li>
<li>
<strong>注意:</strong> 连接的流口具有相同的温度(混合温度)!<br> 由于可能发生混合，因此出口温度可能与连接器的温度不同。<br> 出口温度由对应分量的变量T定义。</li>
<p>
版权所有&copy; 1998-2020，Modelica协会及其贡献者
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics={
      Polygon(
        origin = {11.533,37.938}, 
        lineColor = {0,128,255}, 
        fillColor = {0,128,255}, 
        fillPattern = FillPattern.Solid, 
        points = {{-80,10},{-60,-10},{-80,-30},{-20,-30},{0,-10},{-20,10},{-80,10}}), 
      Polygon(
        origin = {11.533,37.938}, 
        lineColor = {255,0,0}, 
        fillColor = {255,0,0}, 
        fillPattern = FillPattern.Solid, 
        points = {{-40,-90},{-20,-70},{0,-90},{0,-50},{-20,-30},{-40,-50},{-40,-90}}), 
      Polygon(
        origin = {11.533,37.938}, 
        lineColor = {255,128,0}, 
        fillColor = {255,128,0}, 
        fillPattern = FillPattern.Solid, 
        points = {{-20,10},{0,-10},{-20,-30},{40,-30},{60,-10},{40,10},{-20,10}})}));
end FluidHeatFlow;