within Modelica.Electrical.Batteries.UsersGuide;
class Concept "电池模型的概念"
  extends Modelica.Icons.Information;
  annotation (DocumentationClass=true, Documentation(info="<html>
<p>
电池模型的核心是由SOC(电池的充电状态)相关的OCV(开路电压)查找表控制的
<a href=\"modelica://Modelica.Electrical.Analog.Sources.SignalVoltage\">信号电压</a>。
然而，其他依赖关系(例如，温度)尚未实现。
</p>
<p>
电流流入或流出电池时进行测量和积分，从而计算电池中所含的电荷。
相对于名义电荷<code>Qnom</code>，电池中所含的电荷给出了SOC。<br>
查找表为单个电池进行参数化，因此输入必须通过<code>1/(Np*Qnom)</code>进行缩放，
输出必须通过<code>Ns*OCVmax</code>进行缩放。
</p>
<p>
为了模拟自放电，与信号电压和电流传感器并联的导体被实现。
如果自放电被指定为零，则省略导体。
</p>
<p>
一个电阻<code>r0</code>与信号电压串联连接，表示电池的内部电阻。
电阻可以指定为线性依赖于温度。
</p>
<p>
如果选择<a href=\"modelica://Modelica.Electrical.Batteries.BatteryStacks.CellRCStack\">CellRCStack</a>而不是
<a href=\"modelica://Modelica.Electrical.Batteries.BatteryStacks.CellStack\">CellStack</a>，
则串联连接了RC元件以模拟电池的瞬态行为。<br>
这两种模型都可以用于单个电池<code>Ns = Np = 1</code>以及由相同电池构建的堆栈。<br>
请注意，总内部电阻<code>Ri</code>是电阻器<code>r0</code>的电阻和RC元件的电阻之和。
</p>
<p>
除了这些模拟单个电池并通过串联电池的数量<code>Ns</code>和并联电池的数量<code>Np</code>进行缩放的电池之外，
在<a href=\"modelica://Modelica.Electrical.Batteries.BatteryStacksWithSensors\">BatteryStacksWithSensors</a>中还提供了单个电池模型和堆栈。
电池配备了传感器，测量信号在<a href=\"modelica://Modelica.Electrical.Batteries.Interfaces.CellBus\">CellBus</a>中提供。
堆栈模型包含一个<code>Ns</code> x <code>Np</code>单个电池的矩阵，可以根据不同的参数进行参数化
以研究降解电池对整个堆栈行为的影响，以及设计电池管理系统。
堆栈提供<a href=\"modelica://Modelica.Electrical.Batteries.Interfaces.StackBus\">StackBus</a>，其中包含单元的<code>Ns</code> x <code>Np</code>电池总线。
此外，整个堆栈的信号 - 与单个电池相同的信号 - 在BatteryBus中提供。
</p>
<p>
堆栈中的电池的串联和并联连接有两种选项：
</p>
<ul>
<li><code>useAllParallelConnections=true </code>：并联连接<code>Np</code>个电池，并且这些组串联连接。</li>
<li><code>useAllParallelConnections=false</code>：串联连接<code>Ns</code>个电池，并且这些组并联连接。</li>
</ul>
<p>
为了方便起见，块<a href=\"modelica://Modelica.Electrical.Batteries.Utilities.BusTranscription\">BusTranscription</a>将堆栈总线中所有单元总线的信号转换为
<a href=\"modelica://Modelica.Electrical.Batteries.Interfaces.StackBusArrays\">StackBusArrays</a>，排列为每个测量信号的<code>Ns</code> x <code>Np</code>矩阵。
</p>
<p>
有关参数化的详细信息，请参阅<a href=\"modelica://Modelica.Electrical.Batteries.UsersGuide.Parameterization\">UsersGuide.Parameterization</a>。
</p>
</html>"));
end Concept;