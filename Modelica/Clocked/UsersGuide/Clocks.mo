within Modelica.Clocked.UsersGuide;
class Clocks "时钟"
  extends Modelica.Icons.Information;
  annotation(Documentation(info="<html><p>
Modelica.Clocked库的一个核心元素是 <strong>clock</strong>。 以下是关于时钟的最重要信息摘要。 如需更多详情，请参阅 Modelica 语言规范第16章（适用于Modelica语言版本 ≥ 3.3）。
</p>
<p>
<strong>Clock</strong> 类型是一种基本数据类型（引入于Modelica 3.3版本，除了实数、整数、布尔和字符串之外）， 用于定义特定分区何时处于活动状态，该分区包含一组方程。 从Modelica语言版本3.3开始，每个变量和每个方程要么是连续时间的， 要么与一个时钟精确关联。这一特性在下面的图中进行了可视化展示， 其中c(ti)表示在特定时间点ti处活动的时钟，而r(ti)是与该时钟关联的变量。 时钟变量仅在其对应的时钟处于活动状态时才具有值：
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Clocked/Clocks/clockSignals.png\" alt=\"Clock variables and clocked variables\" data-href=\"\" style=\"\"/>
</p>
<p>
与 RealInput、RealOutput 等类似， 子库 <a href=\"modelica://Modelica.Clocked.ClockSignals.Interfaces\" target=\"\">ClockSignal.Interfaces</a>&nbsp; &nbsp;中也定义了名为 ClockInput 和 ClockOutput 的时钟输入和输出连接器， 以便通过连接传播时钟。 时钟信号可通过 <a href=\"modelica://Modelica.Clocked.ClockSignals.Clocks\" target=\"\">ClockSignals.Clocks</a>&nbsp; &nbsp;子库中的一个模块生成：
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Clocked/Clocks/clocks.png\" alt=\"Sublibrary ClockSignals.Clocks\" data-href=\"\" style=\"\"/>
</p>
<p>
上图中模块的输出信号为时钟信号，默认情况下以灰色虚线表示。
</p>
<p>
通过 <a href=\"modelica://Modelica.Clocked.ClockSignals.Sampler\" target=\"\">ClockSignals.Sampler</a>&nbsp; &nbsp;子库的模块， <span style=\"color: rgb(51, 51, 51);\">可以对时钟信号进行子采样、超采样或移位采样，从而生成新的时钟信号。例如，使用以下模型，一个周期为 0.1 秒的时钟信号被以 3 倍的因子进行子采样，因此生成一个周期为 0.3 秒的时钟信号</span>：
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Clocked/Clocks/subSampledClockExample.png\" alt=\"Sub-sample example model\" data-href=\"\" style=\"\"/><br><img src=\"modelica://Modelica/Resources/Images/Clocked/Clocks/subSampledClockResult.png\" alt=\"Sub-sample example plot\" data-href=\"\" style=\"\"/>
</p>
<p>
与同步语言中一样，时钟在活动时用 <strong>true</strong> 值表示。 这些衍生时钟之间的关系是 <span style=\"color: rgb(51, 51, 51);\"><strong>精确的</strong></span>， 因此可以保证在每个\"periodicRealClock.y\"时钟的第3个节拍时， \"subSample.y\"时钟是活动的。
</p>
<p>
如果一个时钟与一个时钟驱动的连续时间分区相关联， 那么必须定义一个 <strong>积分器</strong>，用于从上一个时钟节拍积分到当前时钟节拍。 这可以通过设置参数 <strong>useSolver</strong> = <strong>true</strong>， 并且用参数 <strong>solver</strong> 定义积分方法（以字符串形式）。 这两个参数位于一个时钟信号生成模块的 <strong>Advanced</strong> 选项卡中。 可能的积分方法取决于工具的支持。 通常，每个工具至少支持 \"External\"（使用仿真环境中选择的积分器） 和 \"ExplicitEuler\"（显式欧拉方法）这两种解算器。 有关示例，请参见 <a href=\"modelica://Modelica.Clocked.Examples.Systems.ControlledMixingUnit\" target=\"\">Examples.Systems.ControlledMixingUnit</a>&nbsp; .
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">时钟分区是一组相互依赖的方程式，其中边界变量使用采样保持运算符进行标记。如果一个时钟分区不包含运算符 </span><strong>der</strong><span style=\"color: rgb(51, 51, 51);\">、</span><strong>delay</strong><span style=\"color: rgb(51, 51, 51);\">、</span><strong>spatialDistribution</strong><span style=\"color: rgb(51, 51, 51);\">、任何与事件相关的运算符（除了 </span><strong>noEvent(…)</strong><span style=\"color: rgb(51, 51, 51);\">），并且没有带布尔条件的</span><span style=\"color: rgb(51, 51, 51);\"><strong> </strong></span><strong>when</strong><span style=\"color: rgb(51, 51, 51);\"> 子句，那么它就是一个时钟离散时间分区，也就是说，它是一个通过差分方程描述的标准采样数据系统。如果一个时钟分区既不是时钟离散时间分区，也不包含运算符 </span><strong>previous</strong><span style=\"color: rgb(51, 51, 51);\"> 或 </span><strong>interval</strong><span style=\"color: rgb(51, 51, 51);\">，那么它就是一个时钟离散化连续时间分区。这样的分区必须通过求解方法来解决。如果两种特性都不满足，例如在同一分区中同时使用运算符 </span><strong>previous</strong><span style=\"color: rgb(51, 51, 51);\"> 和 </span><strong>der</strong><span style=\"color: rgb(51, 51, 51);\">，则会出现错误。在时钟离散时间分区中，所有事件生成机制不再适用，特别是关系运算符和内置的事件触发运算符将不会触发事件。</span>
</p>
</html>"));
end Clocks;