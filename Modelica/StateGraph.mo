within Modelica;
package StateGraph 
  "层次状态机组件库，用于建模离散事件和响应式系统"

  extends Modelica.Icons.Package;
  import Modelica.Units.SI;
  package UsersGuide "状态图模型库用户指南"
    extends Modelica.Icons.Information;

    class OverView "概述"
      extends Modelica.Icons.Information;

      annotation(Documentation(info = "<html><p>
本节将概述该库最重要的功能。
</p>
<h4 style=\"text-align: start; line-height: 1.5;\"><span style=\"color: rgb(51, 51, 51);\">步骤和转换</span></h4><p>
<strong>StateGraph</strong>是一种增强的有限状态机。 它基于 JGrafchart 方法，并利用了 Modelica 的 “动作”语言特性。 JGrafchart 是 Grafcet 的进一步发展， 包含了 Grafcet/Sequential Function Charts 中没有的 StateCharts 元素。 因此，StateGraph 库具有与 StateCharts 相似的建模能力， 但避免了 StateCharts 的一些不足之处。
</p>
<p>
StateGraphs 的基本元素是 <strong>steps</strong> 和 <strong>transitions</strong>：
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/StateGraph/UsersGuide/StepAndTransition1.png\" alt=\"\" data-href=\"\" style=\"\"/>
</p>
<p>
<strong>Steps</strong> 表示 StateGraph 可能具有的状态。 如果一个步骤处于激活状态， 则该步骤的布尔变量 <strong>active</strong> 为 <strong>true</strong>。 如果该步骤处于停用状态，则 <strong>active</strong> = <strong>false</strong>。 初始时，所有 ”常规“ 步骤都是停用的。 <strong>InitialStep</strong> 对象是初始时激活的步骤。 它们的特征是一个双方框（见上图）。
</p>
<p>
<strong>Transitions</strong> <span style=\"color: rgb(51, 51, 51);\">用于改变状态图（StateGraph）的状态。当与转换输入连接的步骤处于激活状态时，连接到该转换输出的步骤被停用，并且转换条件为真，此时转换触发。这意味着与转换输入连接的步骤被停用，而与转换输出连接的步骤被激活。</span>
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">转换</span><span style=\"color: rgb(51, 51, 51);\"><strong>条件</strong></span><span style=\"color: rgb(51, 51, 51);\">是通过转换对象的参数菜单定义的。点击上图中的对象 \"transition1\"，会出现以下菜单：</span>
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/StateGraph/UsersGuide/StepAndTransition2.png\" alt=\"\" data-href=\"\" style=\"\"/>
</p>
<p>
在输入字段 “<strong>condition</strong>” 中， 可以给出任何类型的时变布尔表达式 （在 Modelica 符号中，这是对时变变量 <strong>condition</strong> 的修改）。 只要该条件为真，就可以启动转换。 此外，还可以通过 <strong>enableTimer</strong>（见上面的菜单）激活一个计时器， 并提供一个 <strong>等待时间</strong>。 在这种情况下，转换的启动会根据提供的等待时间而延迟。 <span style=\"color: rgb(51, 51, 51);\">转换</span>条件和等待时间显示在<span style=\"color: rgb(51, 51, 51);\">转换</span>图标中。
</p>
<p>
在上例中，模拟从 <strong>initialStep</strong> 开始。 1 秒后， <strong>transition1</strong> 触发，<strong>step1</strong> 开始激活。 再过一秒，<strong>transition2</strong> 触发，<strong>initialStep</strong> 再次激活。 再过一秒，<strong>step1</strong> 再次激活，依此类推。
</p>
<p>
在 JGrafcharts、Grafcet 和 Sequential Function Charts 中， 步骤和转换网络是自上而下绘制的。 在 StateGraphs 中，由于步骤和转换是带有输入和输出连接器的块， 可以任意放置和连接，因此没有定义特定的方向。 通常情况下，最实用的方法是从左向右定义网络， 如上面的示例，因为这样便于阅读图标上的标签。
</p>
<h4><span style=\"color: rgb(51, 51, 51);\">条件和动作</span></h4><p>
通过 <strong>TransitionWithSignal</strong> 模块，触发条件可以作为布尔输入信号， 而不是转换菜单中的条目。下图给出了一个例子：
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/StateGraph/UsersGuide/StepAndTransition3.png\" alt=\"\" data-href=\"\" style=\"\"/>
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">组件 \"step\" 是 \"StepWithSignal\" 的一个实例，它是一个常规的步骤，其中活动标志作为布尔输出信号可用。该输出连接到来自 \"Modelica.Blocks.Logical\" 库的组件 \"Timer\"。该定时器测量从布尔输入（即步骤的活动标志）变为真时刻起，到当前时刻的时间。定时器与比较组件连接。当定时器达到 1 秒时，输出为真。该信号作为转换的条件输入。因此，\"transition2\" 会在步骤 \"step\" 激活 1 秒后触发。当然，任何具有布尔输出信号的其他 Modelica 块也可以连接到此类转换块的条件输入。</span>
</p>
<p>
转换条件可以通过逻辑库中的逻辑模块网络计算（如上图所示）， 也可以通过 “SetBoolean” 组件以文本形式定义任何类型的逻辑表达式（如下图所示）：
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/StateGraph/UsersGuide/StepAndTransition4.png\" alt=\"\" data-href=\"\" style=\"\"/>
</p>
<p>
通过程序模块 “<strong>SetBoolean</strong>”， 可以提供一个时间变化表达式， 作为对输出信号 <strong>y</strong> 的修改（见上图中图标为 “timer.y &gt; 1” 的程序模块）。 输出信号可以反过来连接到 TransitionWithSignal 模块的条件输入端。
</p>
<p>
“<strong>SetBoolean</strong>” 程序模块还可以根据激活的步骤计算布尔信号。 在上图中，当 “step” 处于活动状态时， 图标文字为 “step.active” 的程序模块的输出为真， 否则为假（注意，“SetBoolean” 的图标文字显示了输出信号 “y” 的修改）。 该信号可用于计算物理系统模型中的预期 <strong>actions</strong>。 例如，当状态图处于 “step1” 或 “step4” 时，如果 <strong>valve</strong> 处于打开状态， 可以使用以下条件将 “SetBoolean” 模块连接到阀门模型：
</p>
<p>
<br>
</p>
<pre><code >valve = step1.active or step2.active
</code></pre><p>
<br>
</p>
<p>
通过 Modelica 运算符 <strong>edge</strong>(..) 和 <strong>change</strong>(...)， 可以在需要时使用取决于布尔表达式上升沿和下降沿的条件。
</p>
<p>
在 JGrafcharts、Grafcet、Sequential Function Charts 和 StateCharts 中， 可<strong>在一个步骤内</strong>制定 <strong>actions</strong>。 这些操作可分为 <strong>entry</strong> 操作、<strong>normal</strong> 操作、<strong>exit</strong> 操作和 <strong>abort</strong> 操作。 例如，一个阀门可以通过一个步骤的进入动作打开，也可以通过同一步骤的退出动作关闭。 在 StateGraphs 中，由于 Modelica 的 “<span style=\"color: rgb(51, 51, 51);\"><strong>单一赋值规则</strong></span>”要求每个变量只能由一个等式定义， 因此（幸运的是）这是不可能的。 取而代之的是上述方法。 例如，通过 “SetBoolean” 组件，当 StateGraph 处于特定步骤时，阀门变量将被设置为 true。
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">StateGraph 的这个特性</span><span style=\"color: rgb(51, 51, 51);\"><strong>非常有用</strong></span><span style=\"color: rgb(51, 51, 51);\">，因为它允许 Modelica 翻译器</span><span style=\"color: rgb(51, 51, 51);\"><strong>保证</strong></span><span style=\"color: rgb(51, 51, 51);\">给定的 StateGraph 始终具有</span><span style=\"color: rgb(51, 51, 51);\"><strong>确定性</strong></span><span style=\"color: rgb(51, 51, 51);\">的行为且没有冲突。在其他方法中，这要复杂得多。例如，如果两个步骤并行执行且两个步骤的操作都修改了同一个变量，结果要么是非确定性的，要么必须定义非显式的规则来确定哪个操作具有优先权。在 StateGraph 中，翻译器会检测到这种情况并导致错误，因为有两个方程计算同一个变量。StateGraph 方法的其他优点包括：</span>
</p>
<li>
<span style=\"color: rgb(51, 51, 51);\">一个 JGrafchart 或 StateChart 可能需要访问在步骤中定义的变量，而这些变量位于模型的更高层次结构中。因此，通常会在整个网络中使用全局变量，即使网络是分层结构的。在 StateGraph 中，这并不是必须的，因为 StateGraph 外部的物理系统可以通过层次化名称访问步骤或转换状态。这意味着不需要全局变量，因为 StateGraph 中的局部变量可以从 StateGraph 外部的局部变量访问</span>。</li>
<li>
<span style=\"color: rgb(51, 51, 51);\">对于用户来说，理解非图形化定义中提供的信息更为简单，因为每个变量只在一个地方定义。在其他方法中，同一变量的设置和重设在整个网络中显得杂乱无章</span>。</li>
<p>
为了强调这些方法之间的重要区别、 假设状态机有如下层次结构：
</p>
<p>
<br>
</p>
<pre><code >stateMachine.superstate1.superstate2.step1
</code></pre><p>
<br>
</p>
<p>
例如，在 “step1” 中，StateChart 可以访问变量 “stateMachine.openValve” ，比如说，作为 “入口操作：openValve = true”。 这种典型的用法有一个严重的缺点，就是不能在另一个上下文中使用 “superstate1” 作为组件。 因为 “step1” 引用了这个组件之外的一个特定名称。
</p>
<p>
在 StateGraph 中，通常会有一个 “SetBoolean” 组件 在 “stateMachine” 组件中声明：
</p>
<p>
<br>
</p>
<pre><code >openValve = superstate1.superstate2.step1.active;
</code></pre><p>
<br>
</p>
<p>
因此，“superstate1” 组件可以在另一种情况下使用，因为它不依赖于使用环境。
</p>
<h4><span style=\"color: rgb(51, 51, 51);\">执行模型</span></h4><p>
<span style=\"color: rgb(51, 51, 51);\">StateGraph 的执行模型源自其 Modelica 实现：给定所有步骤的状态，即每个步骤是否处于激活状态，所有步骤的方程、转换、转换条件、动作等被排序，从而形成一个执行序列，用于计算步骤的新值。如果发生冲突，例如方程的数量多于变量，或者存在布尔变量之间的代数循环，则会触发异常。一旦所有方程被处理完毕，所有步骤的激活变量会更新为新计算的值。之后，方程会再次被评估。当没有步骤再改变其状态，即没有转换再触发时，迭代停止。然后，模拟会持续进行，直到触发新的事件（当某个关系的值发生变化时）</span>。
</p>
<p>
利用 Modelica 的 “sample(...)” 运算符， StateGraph 也可以在离散控制器中执行， 该控制器在固定的时间时刻被调用。 此外，Modelica 语言本身也直接支持时钟状态机，请参见 <a href=\"https://specification.modelica.org/v3.4/Ch17.html\" target=\"\">Section 17 (State Machines) of the Modelica 3.4 specification</a>&nbsp; &nbsp;.
</p>
<h4><span style=\"color: rgb(51, 51, 51);\">并行和替代执行</span></h4><p>
并行活动可由 <strong>Parallel</strong> 组件定义， 替代活动可由 <strong>Alternative</strong> 件定义。 下图给出了这两个组件的示例。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/StateGraph/UsersGuide/Parallel1.png\" alt=\"\" data-href=\"\" style=\"\"/>
</p>
<p>
在这里，从 “step2” 到 “step5” 的分支与 “step1” 并行执行。 只有当所有并行分支的最终步骤同时激活时，与并行分支组件输出相连的转换才能触发。 上图是状态图动画的截图： 每当一个步骤处于活动状态或一个转换可以触发时，相应的组件就会被标记为 <strong>绿色</strong>。
</p>
<p>
“step2” 至 “step5” 中的三个分支交替执行， 取决于 “transition3” 、“transition4” 和 “transition4a” 中哪个转换条件先触发。 由于三个转换条件都在 1 秒后触发，因此它们都是活动分支的候选条件。 如果有两个或更多的转换条件在同一时刻触发，则会进行优先选择： 备选和并行分量有一个连接器向量。 每个分支都必须与连接器向量中的一个条目相连。 数字最小的条目优先级最高。
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">并行（Parallel）、替代（Alternative）和步骤（Step）组件具有连接器的向量。这些向量的维度在相应的参数菜单中设置。例如，在“并行”组件中：</span>
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/StateGraph/UsersGuide/Parallel2.png\" alt=\"\" data-href=\"\" style=\"\"/>
</p>
<p>
目前在 Dymola 中，当一个分支 连接到分量矢量时，会弹出以下菜单，以便定义 连接组件的矢量索引：
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/StateGraph/UsersGuide/Parallel3.png\" alt=\"\" data-href=\"\" style=\"\"/>
</p>
<h4><span style=\"color: rgb(51, 51, 51);\">复合步骤、挂起和恢复端口</span></h4><p>
通过使用 <strong>CompositeStep</strong>，可以对 StateGraph 进行分层结构化。 这是一个继承自 <strong>PartialCompositeStep</strong> 的组件。 下图给出了一个例子（来自 Examples.ControlledTanks）：
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/StateGraph/UsersGuide/CompositeStep1.png\" alt=\"\" data-href=\"\" style=\"\"/>
</p>
<p>
CompositeStep 组件包含一个本地状态图， 由一个或多个输入转换进入，由一个或多个输出转换离开。 此外，其他需要的信号也可能进入 CompositeStep。 CompositeStep 具有与 “usual” 步进类似的属性： 一旦 CompositeStep 中至少有一个步进处于激活状态，CompositeStep 即处于 <strong>active</strong>。 变量 <strong>active</strong> 定义了 CompositeStep 的状态。
</p>
<p>
此外，CompositeStep 还有一个 <strong>suspend</strong> 端口。 每当与该端口相连的转换触发时，该复合步骤就会立即退出。 当通过挂起端口离开复合步骤时，复合步骤的内部状态将被保存， 即保存复合步骤中所有步骤的活动标志。可以通过恢复端口进入 <strong>resume</strong> 步骤。 在这种情况下，挂起转换的内部状态将被重建，复合步骤将继续执行挂起转换启动前的状态 （这与 StateCharts 或 JGrafcharts 的历史端口相对应）。
</p>
<p>
一个复合步骤可以包含其他复合步骤。 在每个层面上，一个复合步骤及其所有内容都可以通过其挂起端口离开 （实际上，存在一个挂起连接器向量，即一个复合步骤可能会由于不同的转换而中止）。
</p>
<p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"));
    end OverView;

    class FirstExample "第一例"
      extends Modelica.Icons.Information;

      annotation(Documentation(info = "<html>
<p>
第一个例子将会在这里给出（尚未完成）。
</p>
</html>"));
    end FirstExample;

    class ApplicationExample "应用示例"
      extends Modelica.Icons.Information;

      annotation(Documentation(info = "<html><p>
本节将提供一个更加现实但简单的应用示例， 以展示StateGraph库的各种功能。 此示例展示了来自Isolde Dressler硕士论文中的双罐系统控制 (<a href=\"modelica://Modelica.StateGraph.UsersGuide.Literature\" target=\"\">see literature</a>&nbsp; ).
</p>
<p>
在下图中展示了模型的顶层结构。 该模型可作为 StateGraph.Examples.ControlledTanks 获取。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/StateGraph/UsersGuide/ControlledTanks1.png\" alt=\"\" data-href=\"\" style=\"\"/>
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">在图的右侧，展示了两个水箱。在顶部部分，存在一个大型流体源，当阀门1打开时，流体可以注入</span><span style=\"color: rgb(51, 51, 51);\"><strong>tank1</strong></span><span style=\"color: rgb(51, 51, 51);\">。</span><span style=\"color: rgb(51, 51, 51);\"><strong>tank1</strong></span><span style=\"color: rgb(51, 51, 51);\">可以通过位于</span><span style=\"color: rgb(51, 51, 51);\"><strong>tank2</strong></span><span style=\"color: rgb(51, 51, 51);\">底部的</span><span style=\"color: rgb(51, 51, 51);\"><strong>valve2</strong></span><span style=\"color: rgb(51, 51, 51);\">排空，进而填充第二个</span><span style=\"color: rgb(51, 51, 51);\"><strong>tank2</strong></span><span style=\"color: rgb(51, 51, 51);\">，而</span><span style=\"color: rgb(51, 51, 51);\"><strong>tank2</strong></span><span style=\"color: rgb(51, 51, 51);\">则通过</span><span style=\"color: rgb(51, 51, 51);\"><strong>valve3</strong></span><span style=\"color: rgb(51, 51, 51);\">排空。水箱的实际水位被测量，并作为信号 level1 和 level2 提供给 tankController。</span>
</p>
<p>
<strong>tankController</strong> 由三个按钮控制： <span style=\"color: rgb(51, 51, 51);\">分别是启动（start）、停止（stop）和关闭（shut，表示停机）</span>。 这些按钮是互斥的，这意味着当其中一个按钮被按下（即其状态为 <strong>true</strong>）时， 另外两个按钮就不会被按下（即它们的状态为 <strong>false</strong>）。 当 <strong>start</strong> 按钮被按下时，会进行 “normal” 操作，即填充和排空两个水箱：
</p>
<ol><li>
阀门1打开，水箱1开始填充。</li>
<li>
当水箱1达到其填充水位限制时，关闭阀门1。</li>
<li>
等待一段时间后，打开阀门2，流体从水箱1流入水箱2。</li>
<li>
当水箱1排空时，关闭阀门2。</li>
<li>
等待一段时间后，打开阀门3，流体从水箱2流出。</li>
<li>
当水箱2排空时，关闭阀门3。</li>
</ol><p>
以上的 “normal” 过程可以受以下按钮的影响：
</p>
<li>
按钮 <strong>start</strong> 启动上述过程。 当在 “stop” 或 “shut” 操作后按下此按钮时，过程操作继续进行。</li>
<li>
按钮 <strong>stop</strong> 通过关闭所有阀门停止上述过程。 然后，控制器等待进一步的输入（要么是 “start” 操作，要么是 “shut” 操作）。</li>
<li>
按钮 <strong>shut</strong> 用于关闭过程，通过立即排空两个储罐。 完成此操作后，过程回到其起始配置。 点击 “start” 按钮可以重新启动过程。</li>
<p>
<strong>tankController</strong> 的实现如下图所示：
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/StateGraph/UsersGuide/ControlledTanks2.png\" alt=\"\" data-href=\"\" style=\"\"/>
</p>
<p>
当按下 \"<strong>start</strong>\" 按钮时， 状态图位于复合步骤 \"<strong>makeProduct</strong>\" 内。 在正常操作期间，只有当tank2为空时，才会离开这个复合步骤。 之后，复合步骤会立即重新进入。
</p>
<p>
当按下 \"<strong>stop</strong>\" 按钮时， \"makeProduct\" 复合步骤会立即通过 \"<strong>suspend</strong>\" 端口终止， 并且状态图等待在步骤 \"<strong>s2</strong>\" 中等待进一步的命令。 当按下 \"<strong>start</strong>\" 按钮时， 通过其 <strong>resume</strong> 端口重新进入复合步骤， 并且 “normal” 操作会从被suspend转换中中止的状态继续。 如果按下 \"<strong>shut</strong>\" 按钮， 则状态图会在 \"<strong>emptyTanks</strong>\" 步骤中等待， 直到两个储罐都为空，然后在初始步骤 \"<strong>s1</strong>\" 等待进一步输入。
</p>
<p>
阀门的开启和关闭并 <strong>not</strong> 直接在 stateGraph 中定义。 相反，通过 \"<strong>setValveX</strong>\" 组件计算阀门的布尔状态。 例如，“setValve2” 的输出y计算为：
</p>
<p>
<br>
</p>
<pre><code >y = makeProduct.fillTank2.active or emptyTanks.active
</code></pre><p>
<br>
</p>
<p>
即，当步骤 “makeProduct.fillTank2” 或步骤 “emptyTanks” 处于活动状态时， 阀门2处于打开状态。否则，阀门2处于关闭状态。
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"));
    end ApplicationExample;

    class ComparisonWithStateGraph2 "与StateGraph2的比较"
      extends Modelica.Icons.Information;

      annotation(Documentation(info = "<html><p>
一个进化但非标准符合的Modelica库，名为 “Modelica_StateGraph2”， 可以从以下地方获取<a href=\"https://github.com/HansOlsson/Modelica_StateGraph2\" target=\"\">https://github.com/HansOlsson/Modelica_StateGraph2</a>&nbsp;。 下面是关于与Modelica.StateGraph的比较。 第三选项，特别适用于离散控制器建模的时钟状态机，作为内置的 Modelica 语言元素提供， 详见 <a href=\"https://specification.modelica.org/v3.4/Ch17.html\" target=\"\">Section 17 (State Machines) of the Modelica 3.4 specification</a>&nbsp;。
</p>
<p>
Modelica_StateGraph2库（以下简称 <u>StateGraph2</u>） 基于对当前 Modelica.StateGraph 库（以下简称 <u>StateGraph1</u>）的经验， 并且是对 StateGraph1 的显著进一步发展。 此外，它在很大程度上基于文章（Malmheden等，2008年）， 详见下文的文献，但使用了不同的实现技术，如该文章所述。 相比 StateGraph1 库，StateGraph2 库有以下改进之处：
</p>
<li>
<strong>3 Basic Components (Step, Transition, Parallel)</strong><br> 所有组件的多个版本都合并为一个版本（例如，一个 Step 而不是4个 Step 组件）。 这样做更容易理解，使用起来更方便。 “Parallel” 组件既用作 “composite step”（因此只有一个分支）， 也用作 ”parallel step“（因此有多个执行分支）。 <br> </li>
<li>
<strong>Safer state machines</strong><br> 现在不再可能构造错误的状态机， 即不会违反图的属性（例如，两个初始步骤，或者在并行组件之外错误分支）。 与 StateGraph1 相反，在 StateGraph2 中，这种错误的图形不会导致错误， 但会导致意外的仿真结果。 尽管如此，状态机的其他理想属性， 如 “no deadlock”、“lifeliness” 或 “every step reachable”，目前在 StateGraph2 中还不能（保证）。 <br> </li>
<li>
<strong>Composite, autonomous, synchronized, preempted subgraphs</strong><br> 在 StateGraph1 中，复合步骤和并行步骤的描述方式更为优化和强大。 复合步骤可以通过组件 “Parallel” 或从 “PartialParallel” 继承来实现。 第一种选择的优势在于使用简便（无需构建新类或实例化该类，且易于访问变量，因为不需要构建新的层次结构）， 而第二种选择的优势在于引入了一个 Modelica 层次结构（对于大型子图很有用）。 在这两种情况下，都有各种选项可供选择，例如通过启用/禁用不同的端口来实现。</li>
<ol><li>
<span style=\"color: rgb(51, 51, 51);\">自主子图（分支并行执行，且自主进行）</span></li>
<li>
<span style=\"color: rgb(51, 51, 51);\">同步子图（分支并行执行，在离开子图之前通过 outPort 进行同步）</span></li>
<li>
<span style=\"color: rgb(51, 51, 51);\">具有抢占和异常处理的子图（并行步骤可以通过 suspend 端口被中断，并通过 resume 端口继续执行）</span><br><span style=\"color: rgb(51, 51, 51);\">这一过程是通过启用/禁用不同的端口来实现的。</span><br></li>
</ol><li>
<strong>No infinite looping</strong>:<br> 与 StateGraph1 一样，有两种类型的转换： 即时转换（在事件迭代期间，所有立即转换都会触发，直到不再有转换条件为真） 和延迟转换（一个转换只有在延迟后才会触发）。 与S tateGraph1 相反，在 StateGraph2 中，每个循环必须至少有一个延迟转换。 如果不是这种情况，就会出现翻译错误，即模型包含一个布尔之间的代数循环， 名称为 “checkOneDelayedTransitionPerLoop”。 <br> &nbsp; &nbsp; &nbsp; 该属性保证，在有限次迭代后，对 StateGraph2 的事件迭代会收敛， 前提是模型构建者在与 StateGraph2 相关联的操作中未引入不安全的构造 （例如，在方程部分的when子句之外使用 “i = pre(i) + 1” 将导致事件迭代永远不会停止）。<br> &nbsp; &nbsp; &nbsp; 可以通过在循环中的一个转换中设置参数 \"loopCheck = <strong>false</strong>\" 来关闭这个特性， 而不是在这个位置使用 “delayed transition” （在即时转换很重要且转换条件不可能在同一时刻触发的情况下）。</li>
<h4> Literature </h4><p>
Modelica_StateGraph2 库在《Otter等人，2009年》中有详细描述，并额外基于以下参考文献：
</p>
<p>
André, C. (2003):
</p>
<p>
<a href=\"http://www.i3s.unice.fr/~map/WEBSPORTS/Documents/2003a2005/SSMsemantics.pdf\" target=\"\"><br>Semantics of S.S.M (Safe State Machine)</a>&nbsp;.<br>I3S Laboratory, UMR 6070 University of Nice-Sophia Antipolis / CNRS.<br>
</p>
<p>
Årzén K.-E. (2004):
</p>
<p>
<strong>JGrafchart User Manual. Version 1.5</strong>.<br>Department of Automatic Control, Lund Institute of Technology,<br>Lund, Sweden, Feb. 13, 2004.<br>
</p>
<p>
Dressler I. (2004):
</p>
<p>
<a href=\"http://lup.lub.lu.se/student-papers/record/8848017/file/8859434.pdf\" target=\"\"><br>Code Generation From JGrafchart to Modelica</a>&nbsp;.<br>Master thesis, supervisor: Karl-Erik Årzén,<br>Department of Automatic Control, Lund Institute of Technology,<br>Lund, Sweden, March 30, 2004.<br>
</p>
<p>
Elmqvist H., Mattsson S.E., Otter M. (2001):
</p>
<p>
<strong>Object-Oriented and Hybrid Modeling in Modelica</strong>.<br>Journal Europeen des systemes automatises (JESA),<br>Volume 35 - n. 1, 2001.<br>
</p>
<p>
Harel, D. (1987):
</p>
<p>
<a href=\"http://www.inf.ed.ac.uk/teaching/courses/seoc1/2005_2006/resources/statecharts.pdf\" target=\"\"><br>A Visual Formalism for Complex Systems</a>&nbsp;.<br>Science of Computer Programming 8, 231-274. Department of Applied Mathematics,<br>The Weizmann Institute of Science, Rehovot, Israel.<br>
</p>
<p>
Malmheden M. (2007):
</p>
<p>
<a href=\"http://lup.lub.lu.se/student-papers/record/8847773/file/8859375.pdf\" target=\"\"><br>ModeGraph - A Mode-Automata-Based Modelica Library for Embedded Control</a>&nbsp;.<br>Master thesis, Department of Automatic Control, Lund University, Sweden.<br>
</p>
<p>
Malmheden M., Elmqvist H., Mattsson S.E., Henrisson D., Otter M. (2008):
</p>
<p>
<a href=\"https://www.modelica.org/events/modelica2008/Proceedings/sessions/session3a3.pdf\" target=\"\"><br>ModeGraph - A Modelica Library for Embedded Control based on Mode-Automata</a>&nbsp;.<br>Modelica\\'2008 Conference, March 3-4, 2008.<br>
</p>
<p>
Maraninchi F., Rémond, Y. (2002):
</p>
<p>
<a href=\"http://dx.doi.org/10.1016/S0167-6423(02)00093-X\" target=\"\">Mode-Automata:<br>A New Domain-Specific Construct for the Development of Safe Critical Systems</a>&nbsp;.<br>
</p>
<p>
Mosterman P., Otter M., Elmqvist H. (1998):
</p>
<p>
<a href=\"https://www.modelica.org/publications/papers/scsc98fp.pdf\" target=\"\"><br>Modeling Petri Nets as Local Constraint Equations for<br>Hybrid Systems using Modelica</a>&nbsp;.<br>SCSC\\'98, Reno, Nevada, USA,<br>Society for Computer Simulation International, pp. 314-319, 1998.<br>
</p>
<p>
Otter M., Malmheden M., Elmqvist H., Mattsson S.E., Johnsson C. (2009):
</p>
<p>
<a href=\"https://www.modelica.org/events/modelica2009\" target=\"\"><br>A New Formalism for Modeling of Reactive and Hybrid Systems</a>&nbsp;.<br>Modelica\\'2009 Conference, Como, Italy, Sept. 20-22, 2009.<br>
</p>
</html>"));
    end ComparisonWithStateGraph2;

    class ReleaseNotes "版本说明"
      extends Modelica.Icons.ReleaseNotes;

      annotation(Documentation(info = "<html>
<h4>Version 0.87, 2004-06-23</h4>
<ul>
<li> 包含在 Modelica 标准库 2.0 Beta 1 中，使用了新的模块连接器。
相应地修改了所有模块连接器和逻辑库的引用。
</li>
</ul>
<h4>Version 0.86, 2004-06-20</h4>
<ul>
<li> 新增了用于代替执行路径和并行执行路径的新组件 “Alternative” 和 “Parallel”。
</li>
<li> 步骤现在具有输入和输出连接器向量，以支持多个步骤之间的多重连接。
</li>
<li> 移除了组件 “AlternativeSplit”、“AlternativeJoin”、
“ParallelSplit” 和 “ParallelJoin”，
因为新增的组件（“Alternative”、“Parallel”、步骤的向量连接器）
具有相同的建模能力，但更安全和更方便。
</li>
<li> 移除了步骤中的定时器（可以将逻辑库的 “Timer” 组件附加到
“StepWithSignal” 组件的 “active” 端口）。
注意，大多数情况下，使用转换的内置定时器更加方便和高效。
</li>
<li> 组件 “StepInitial” 更名为 “InitialStep”。</li>
<li> 在逻辑子库中新增了 “Timer” 组件。</li>
<li> 更新并改进了库的文档。</li>
</ul>
<h4>Version 0.85, 2004-06-17</h4>
<ul>
<li> 将 “MacroStep” 重命名为 “CompositeStep”，
并将 MacroStep 的端口从 “abort” 改为 “suspend”，
将 “history” 改为 “resume”。
</li>
<li> 支持嵌套的 “CompositeStep” 组件，
基于 Dymola 引入的嵌套内部/外部组件的实验性功能。
这意味着 CompositeSteps 可以在每个级别上被暂停和恢复。
</li>
<li> 新增示例 “Examples.ShowExceptions”，演示了嵌套 CompositeSteps 的新功能。
</li>
<li> 新增包 “Logical”。它包含 ModelicaAdditions.Blocks.Logical 的所有组件，
但使用了新的模块连接器和更好看的图标。此外，还添加了逻辑块。
</li>
<li> 改进了 StateGraph 库中多个组件的图标。</li>
</ul>
<h4>Version 0.83, 2004-05-21</h4>
<ul>
<li> “abort” 和 “history” 连接器在 CompositeStep 的图表层中不再可见，
因为在 CompositeStep 中不允许连接到它们。
</li>
<li> 缩小了 CompositeStep 的图表/图标尺寸（从200/-200 到 150/-150）。
</li>
<li> 改进了 “SetBoolean/SetInteger/SetReal” 组件的图标。</li>
<li> 将 “ParameterReal” 重命名为 “SetRealParameter”。</li>
</ul>
<h4>Version 0.82, 2004-05-18</h4>
<p>
已经实施了一个首版，并提供给其他人使用。
</p>
</html>"));
    end ReleaseNotes;

    class Literature "参考文献"
      extends Modelica.Icons.References;

      annotation(Documentation(info = "<html>
<p>
StateGraph库基于以下参考资料：
</p>
<dl>
<dt>&Aring;rz&eacute;n K.-E. (2004):</dt>
<dd> <strong>JGrafchart User Manual. Version 1.5</strong>.
Department of Automatic Control, Lund Institute of Technology,
Lund, Sweden, Feb. 13<br>&nbsp;</dd>
<dt>Dressler I. (2004):</dt>
<dd> <strong>Code Generation From JGrafchart to Modelica</strong>.
Master thesis, supervisor: Karl-Erik &Aring;rz&eacute;n,
Department of Automatic Control, Lund Institute of Technology,
Lund, Sweden, March 30<br>&nbsp;</dd>
<dt>Elmqvist H., Mattsson S.E., Otter M. (2001):</dt>
<dd> <strong>Object-Oriented and Hybrid Modeling in Modelica</strong>.
Journal Europeen des systemes automatises (JESA),
Volume 35 - n. 1.<br>&nbsp;</dd>
<dt>Mosterman P., Otter M., Elmqvist H. (1998):</dt>
<dd> <strong>Modeling Petri Nets as Local Constraint Equations for
Hybrid Systems using Modelica</strong>.
SCSC'98, Reno, Nevada, USA,
Society for Computer Simulation International, pp. 314-319.
</dd>
</dl>
</html>"));

    end Literature;

    class Contact "联系"
      extends Modelica.Icons.Contact;

      annotation(Documentation(info = "<html>
<h4>主要作者</h4>

<p>
<a href=\"http://www.robotic.dlr.de/Martin.Otter/\"><strong>Martin Otter</strong></a><br>
Deutsches Zentrum f&uuml;r Luft- und Raumfahrt e.V. (DLR)<br>
Institut f&uuml;r Systemdynamik und Regelungstechnik (DLR-SR)<br>
Forschungszentrum Oberpfaffenhofen<br>
D-82234 Wessling<br>
Germany<br>
email: <a href=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</a>
</p>

<h4>致谢</h4>

<ul>
<li> 这个库的开发受到了Isolde Dressler的硕士论文的启发
（<a href=\"modelica://Modelica.StateGraph.UsersGuide.Literature\">see literature</a>），
论文中设计并实现了从JGrafchart到Modelica的编译器。
该项目由瑞典隆德技术大学自动控制系的Karl-Erik &Aring;rz&eacute;n教授指导的。
</li>
<li> 这个库还受益于德国研究基金委员会（Deutsche Forschungsgemeinschaft）赞助的 
“Continuous-Discrete Dynamic Systems”（KONDISK）重点研究计划的项目（Schwerpunktprogramm），
该计划由支持号码为OT174/1-2和EN152/22-2的资助。
对此支持表示最诚挚的感谢。
</li>
<li> 该库中基本组件的实现是通过描述带有方程的有限状态机来实现的，
其基础理论来源于(Elmqvist, Mattsson and Otter, 2001)的工作，
该工作又借鉴了(Mosterman, Otter and Elmqvist, 1998)的思想
(详见<a href=\"modelica://Modelica.StateGraph.UsersGuide.Literature\">literature</a>)。
</li>
</ul>
</html>"));

    end Contact;

    annotation(DocumentationClass = true, Documentation(info = "<html><p>
库 <strong>StateGraph</strong> 是一个<strong>开源</strong>的 Modelica 软件包， 为<strong>离散事件</strong>和<strong>响应式</strong>系统建模提供了便捷的组件。 本软件包包含库的用户指南，内容如下：
</p>
<ol><li>
<a href=\"modelica://Modelica.StateGraph.UsersGuide.OverView\" target=\"\">Overview of library</a>&nbsp;概述了库的情况。</li>
<li>
<a href=\"modelica://Modelica.StateGraph.UsersGuide.FirstExample\" target=\"\">A first example</a>&nbsp;第一个示例演示了如何使用该库。</li>
<li>
<a href=\"modelica://Modelica.StateGraph.UsersGuide.ApplicationExample\" target=\"\">An application example</a>&nbsp; &nbsp;展示了双油箱系统控制的各种功能。</li>
<li>
<a href=\"modelica://Modelica.StateGraph.UsersGuide.ComparisonWithStateGraph2\" target=\"\">Comparison with StateGraph2</a>&nbsp;将 Modelica.StateGraph 与改进版 Modelica_StateGraph2 进行比较。</li>
<li>
<a href=\"modelica://Modelica.StateGraph.UsersGuide.ReleaseNotes\" target=\"\">Release Notes</a>&nbsp;总结了该库不同版本之间的差异。</li>
<li>
<a href=\"modelica://Modelica.StateGraph.UsersGuide.Literature\" target=\"\">Literature</a>&nbsp;提供了用于设计和实现此库的参考资料。</li>
<li>
<a href=\"modelica://Modelica.StateGraph.UsersGuide.Contact\" target=\"\">Contact</a>&nbsp;提供该库的作者的信息以及致谢。</li>
</ol></html>"));
  end UsersGuide;

  package Examples 
    "示例演示状态图模型库组件的用法"
    extends Modelica.Icons.ExamplesPackage;

    model FirstExample "第一个简单的状态图示例"
      extends Modelica.Icons.Example;
      InitialStep initialStep(nIn = 1, nOut = 1) annotation(Placement(transformation(extent = {{-48, 0}, 
        {-28, 20}})));
      Transition transition1(enableTimer = true, waitTime = 1) 
        annotation(Placement(transformation(extent = {{-20, 0}, {0, 20}})));
      Step step(nIn = 1, nOut = 1) annotation(Placement(transformation(extent = {{10, 0}, {30, 20}})));
      Transition transition2(enableTimer = true, waitTime = 2) 
        annotation(Placement(transformation(extent = {{40, 0}, {60, 20}})));
      inner StateGraphRoot stateGraphRoot 
        annotation(Placement(transformation(extent = {{-80, 60}, {-60, 80}})));
    equation

      connect(initialStep.outPort[1], transition1.inPort) 
        annotation(Line(points = {{-27.5, 10}, {-14, 10}}));
      connect(transition1.outPort, step.inPort[1]) 
        annotation(Line(points = {{-8.5, 10}, {9, 10}}));
      connect(step.outPort[1], transition2.inPort) 
        annotation(Line(points = {{30.5, 10}, {46, 10}}));
      connect(transition2.outPort, initialStep.inPort[1]) annotation(Line(points = 
        {{51.5, 10}, {70, 10}, {70, 32}, {-62, 32}, {-62, 10}, {-49, 10}}));
      annotation(experiment(StopTime = 5.5), Documentation(info = "<html><p>
<br>
</p>
</html>"));
    end FirstExample;

    model FirstExample_Variant2 
      "第一个简单状态图示例的变体"
      extends Modelica.Icons.Example;
      InitialStep initialStep(nIn = 1, nOut = 1) annotation(Placement(transformation(extent = {{-70, 0}, {-50, 20}})));
      Transition transition1(enableTimer = true, waitTime = 1) 
        annotation(Placement(transformation(extent = {{-42, 0}, {-22, 20}})));
      StepWithSignal step(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(extent = {{-14, 0}, {6, 20}})));
      TransitionWithSignal transition2 
        annotation(Placement(transformation(extent = {{52, 0}, {72, 20}})));
      Modelica.Blocks.Logical.Timer timer annotation(Placement(transformation(
        extent = {{6, -40}, {26, -20}})));
      Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqual(threshold = 0.5) 
        annotation(Placement(transformation(extent = {{36, -40}, {56, -20}})));
      inner StateGraphRoot stateGraphRoot 
        annotation(Placement(transformation(extent = {{-80, 60}, {-60, 80}})));
    equation

      connect(initialStep.outPort[1], transition1.inPort) 
        annotation(Line(points = {{-49.5, 10}, {-36, 10}}));

      connect(transition1.outPort, step.inPort[1]) 
        annotation(Line(points = {{-30.5, 10}, {-15, 10}}));
      connect(step.active, timer.u) annotation(Line(points = {{-4, -1}, {-4, -30}, {4, 
        -30}}, color = {255, 0, 255}));
      connect(step.outPort[1], transition2.inPort) 
        annotation(Line(points = {{6.5, 10}, {58, 10}}));
      connect(timer.y, greaterEqual.u) 
        annotation(Line(points = {{27, -30}, {34, -30}}, color = {0, 0, 255}));
      connect(greaterEqual.y, transition2.condition) annotation(Line(points = {{57, 
        -30}, {62, -30}, {62, -2}}, color = {255, 0, 255}));
      connect(transition2.outPort, initialStep.inPort[1]) annotation(Line(points = 
        {{63.5, 10}, {82, 10}, {82, 32}, {-80, 32}, {-80, 10}, {-71, 10}}));
      annotation(experiment(StopTime = 5.5, Algorithm = Dassl, StartTime = 0, Tolerance = 0.0001, NumberOfIntervals = 500), __MWORKS(ContinueSimConfig(SaveContinueFile = "false", SaveBeforeStop = "false", NumberBeforeStop = 1, FixedContinueInterval = "false", ContinueIntervalLength = 0.924, ContinueTimeVector)));
    end FirstExample_Variant2;

    model FirstExample_Variant3 
      "第一个简单状态图示例的变体"
      extends Modelica.Icons.Example;
      InitialStep initialStep(nIn = 1, nOut = 1) annotation(Placement(transformation(extent = {{-70, 0}, {-50, 20}})));
      Transition transition1(enableTimer = true, waitTime = 1) 
        annotation(Placement(transformation(extent = {{-42, 0}, {-22, 20}})));
      StepWithSignal step(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(extent = {{-14, 0}, {6, 20}})));
      TransitionWithSignal transition2(enableTimer = false) 
        annotation(Placement(transformation(extent = {{56, 0}, {76, 20}})));
      Modelica.Blocks.Logical.Timer timer annotation(Placement(transformation(
        origin = {-4, -30}, 
        extent = {{-10, -10}, {10, 10}}, 
        rotation = 270)));
      Modelica.Blocks.Sources.BooleanExpression SetBoolean1(y = timer.y > 0.5) annotation(Placement(
        transformation(extent = {{28, -40}, {60, -20}})));
      Modelica.Blocks.Sources.BooleanExpression SetBoolean2(y = step.active) annotation(Placement(
        transformation(extent = {{-68, -40}, {-36, -20}})));
      inner StateGraphRoot stateGraphRoot 
        annotation(Placement(transformation(extent = {{-80, 60}, {-60, 80}})));
    equation

      connect(initialStep.outPort[1], transition1.inPort) 
        annotation(Line(points = {{-49.5, 10}, {-36, 10}}));

      connect(transition1.outPort, step.inPort[1]) 
        annotation(Line(points = {{-30.5, 10}, {-15, 10}}));
      connect(step.active, timer.u) annotation(Line(points = {{-4, -1}, {-4, -9.5}, {
        -4, -18}, {-4, -18}}, color = {255, 0, 255}));
      connect(step.outPort[1], transition2.inPort) 
        annotation(Line(points = {{6.5, 10}, {62, 10}}));
      connect(transition2.outPort, initialStep.inPort[1]) annotation(Line(points = 
        {{67.5, 10}, {82, 10}, {82, 32}, {-80, 32}, {-80, 10}, {-71, 10}}));
      connect(SetBoolean1.y, transition2.condition) annotation(Line(points = {{
        61.6, -30}, {66, -30}, {66, -2}}, color = {255, 0, 255}));
      annotation(experiment(StopTime = 5.5));
    end FirstExample_Variant3;

    model ExecutionPaths 
      "演示并行和替代执行路径的示例"

      extends Modelica.Icons.Example;

      InitialStep step0(nIn = 1, nOut = 1) annotation(
        Placement(transformation(extent = {{-140, -100}, {-120, -80}})));
      Transition transition1(enableTimer = true, waitTime = 1) 
        annotation(Placement(
        transformation(extent = {{-100, -100}, {-80, -80}})));
      Step step1(nIn = 1, nOut = 1) annotation(
        Placement(transformation(extent = {{-10, -40}, {10, -20}})));
      Transition transition2(enableTimer = true, waitTime = 1) 
        annotation(Placement(
        transformation(extent = {{90, -100}, {110, -80}})));
      Step step6(nIn = 1, nOut = 1) annotation(Placement(
        transformation(extent = {{120, -100}, {140, -80}})));
      Step step2(nIn = 1, nOut = 1) annotation(
        Placement(transformation(extent = {{-98, 40}, {-78, 60}})));
      Transition transition3(enableTimer = true, waitTime = 1) 
        annotation(Placement(
        transformation(extent = {{-42, 80}, {-22, 100}})));
      Transition transition4(enableTimer = true, waitTime = 1) 
        annotation(Placement(
        transformation(extent = {{-42, 40}, {-22, 60}})));
      Step step3(nIn = 1, nOut = 1) annotation(Placement(
        transformation(extent = {{-8, 80}, {12, 100}})));
      Step step4(nIn = 1, nOut = 1) annotation(Placement(
        transformation(extent = {{-8, 40}, {12, 60}})));
      Transition transition5(enableTimer = true, waitTime = 3) 
        annotation(Placement(
        transformation(extent = {{26, 80}, {46, 100}})));
      Transition transition6(enableTimer = true, waitTime = 1) 
        annotation(Placement(
        transformation(extent = {{26, 40}, {46, 60}})));
      Step step5(nIn = 1, nOut = 1) annotation(Placement(
        transformation(extent = {{80, 40}, {100, 60}})));
      Modelica.Blocks.Sources.RealExpression setReal(y = time) 
        annotation(Placement(transformation(extent = {{21, -160}, {41, -140}})));
      TransitionWithSignal transition7 annotation(Placement(transformation(
        extent = {{9, -134}, {-11, -114}})));
      Modelica.Blocks.Sources.BooleanExpression setCondition(y = time >= 7) 
        annotation(Placement(transformation(extent = {{-77, -160}, {-19, -140}})));
      Transition transition4a(enableTimer = true, waitTime = 1) 
        annotation(Placement(transformation(extent = {{-42, 0}, {-22, 20}})));
      Step step4a(nIn = 1, nOut = 1) annotation(Placement(
        transformation(extent = {{-8, 0}, {12, 20}})));
      Transition transition6a(enableTimer = true, waitTime = 2) 
        annotation(Placement(
        transformation(extent = {{26, 0}, {46, 20}})));
      Modelica.Blocks.Interaction.Show.RealValue NumericValue1(
        significantDigits = 3) 
        annotation(Placement(transformation(extent = {{61, -160}, {81, -140}})));
      Alternative alternative(nBranches = 3) annotation(Placement(transformation(
        extent = {{-70, -10}, {72, 110}})));
      Parallel Parallel1(nBranches = 2) annotation(Placement(transformation(extent = {{-154, -50}, 
        {152, 120}})));
      inner StateGraphRoot stateGraphRoot 
        annotation(Placement(transformation(extent = {{-160, 120}, {-140, 140}})));
    equation
      connect(transition3.outPort, step3.inPort[1]) 
        annotation(Line(points = {{-30.5, 90}, {-9, 90}}));
      connect(step3.outPort[1], transition5.inPort) 
        annotation(Line(points = {{12.5, 90}, {32, 90}}));
      connect(transition4.outPort, step4.inPort[1]) 
        annotation(Line(points = {{-30.5, 50}, {-9, 50}}));
      connect(step4.outPort[1], transition6.inPort) 
        annotation(Line(points = {{12.5, 50}, {32, 50}}));
      connect(transition7.outPort, step0.inPort[1]) annotation(Line(points = {{
        -2.5, -124}, {-149, -124}, {-149, -90}, {-141, -90}}));
      connect(step6.outPort[1], transition7.inPort) annotation(Line(points = {{
        140.5, -90}, {150, -90}, {150, -124}, {3, -124}}));
      connect(transition4a.outPort, step4a.inPort[1]) 
        annotation(Line(points = {{-30.5, 10}, {-9, 10}}));
      connect(step4a.outPort[1], transition6a.inPort) 
        annotation(Line(points = {{12.5, 10}, {32, 10}}));
      connect(setCondition.y, transition7.condition) annotation(Line(points = {{
        -16.1, -150}, {-1, -150}, {-1, -136}}, color = {255, 0, 255}));
      connect(setReal.y, NumericValue1.numberPort) annotation(Line(
        points = {{42, -150}, {59, -150}}, color = {0, 0, 255}));
      connect(transition3.inPort, alternative.split[1]) annotation(Line(points = {{-36, 90}, 
        {-55.09, 90}, {-55.9, 50.0}}));
      connect(transition4.inPort, alternative.split[2]) annotation(Line(points = {{-36, 50}, 
        {-55.09, 50}}));
      connect(transition4a.inPort, alternative.split[3]) annotation(Line(points = {{-36, 10}, 
        {-45.0125, 10}, {-45.0125, 10}, {-55.09, 10}}));
      connect(transition5.outPort, alternative.join[1]) annotation(Line(points = {{37.5, 90}, 
        {57.09, 90}, {57.09, 50}}));
      connect(transition6.outPort, alternative.join[2]) annotation(Line(points = {{37.5, 50}, 
        {57.09, 50}}));
      connect(transition6a.outPort, alternative.join[3]) annotation(Line(points = {{37.5, 10}, 
        {46.7625, 10}, {46.7625, 10}, {57.09, 10}}));
      connect(step2.outPort[1], alternative.inPort) annotation(Line(points = {{
        -77.5, 50}, {-72.13, 50}}));
      connect(alternative.outPort, step5.inPort[1]) 
        annotation(Line(points = {{73.42, 50}, {79, 50}}));
      connect(step2.inPort[1], Parallel1.split[1]) annotation(Line(points = {{-99, 
        50}, {-118, 50}, {-118, 78}, {-119.575, 78}, {-119.575, 77.5}}));
      connect(step1.outPort[1], Parallel1.join[2]) annotation(Line(points = {{10.5, 
        -30}, {118, -30}, {118, -7.5}, {117.575, -7.5}}));
      connect(step0.outPort[1], transition1.inPort) annotation(Line(points = {{
        -119.5, -90}, {-94, -90}}));
      connect(transition2.outPort, step6.inPort[1]) annotation(Line(points = {{
        101.5, -90}, {119, -90}}));
      connect(transition1.outPort, Parallel1.inPort) annotation(Line(points = {{
        -88.5, -90}, {-70, -90}, {-70, -64}, {-174, -64}, {-174, 35}, {-158.59, 35}}));
      connect(Parallel1.outPort, transition2.inPort) annotation(Line(points = {{
        155.06, 35}, {168, 35}, {168, -60}, {80, -60}, {80, -90}, {96, -90}}));
      connect(step5.outPort[1], Parallel1.join[1]) annotation(Line(points = {{
        100.5, 50}, {116, 50}, {116, 77.5}, {117.575, 77.5}}));
      connect(Parallel1.split[2], step1.inPort[1]) annotation(Line(points = {{
        -119.575, -7.5}, {-118, -8}, {-118, -30}, {-11, -30}}));
      annotation(
        Documentation(info = "<html>
<p>
这是一个示例，展示了如何使用 StateGraph 模型来建模 <strong>parallel</strong> 活动。
当 transition1 触发后（经过1秒），会同时执行两个分支。
经过6秒后，这两个分支会同步，以达到步骤6。
</p>
<p>
在模拟模型之前，尝试确定执行哪个分支的替代序列。
请注意，替代序列根据端口索引具有优先级
（alternative.split[1] 具有比 alternative.split[2] 更高的触发优先级）。
</p>
</html>"), experiment(StopTime = 15.5), 
        Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}})));
    end ExecutionPaths;

    model ShowCompositeStep 
      "演示由状态图描述的并行活动的示例"

      extends Modelica.Icons.Example;

      Utilities.CompositeStep compositeStep 
        annotation(Placement(transformation(
        extent = {{-10, 5}, {20, 35}})));
      InitialStep step0(nIn = 1, nOut = 1) annotation(
        Placement(transformation(extent = {{-89, -10}, {-69, 10}})));
      Transition transition1(enableTimer = true, waitTime = 1) 
        annotation(Placement(
        transformation(extent = {{-59, -10}, {-39, 10}})));
      Step step1(nIn = 1, nOut = 1) annotation(Placement(
        transformation(extent = {{-4, -30}, {16, -10}})));
      Transition transition2(enableTimer = true, waitTime = 1) 
        annotation(Placement(
        transformation(extent = {{45, -10}, {65, 10}})));
      Step step6(nIn = 1, nOut = 1) annotation(Placement(
        transformation(extent = {{71, -10}, {91, 10}})));
      TransitionWithSignal transition7 annotation(Placement(transformation(
        extent = {{10, -70}, {-10, -50}})));
      Parallel Parallel1 annotation(Placement(transformation(extent = {{-30, -40}, {
        36, 40}})));
      Modelica.Blocks.Sources.BooleanExpression setCondition(y = time >= 7) 
        annotation(Placement(transformation(extent = {{-40, -90}, {-10, -70}})));
      inner StateGraphRoot stateGraphRoot 
        annotation(Placement(transformation(extent = {{-90, 50}, {-70, 70}})));
    equation
      connect(step0.outPort[1], transition1.inPort) 
        annotation(Line(points = {{-68.5, 0}, {-53, 0}}));
      connect(transition7.outPort, step0.inPort[1]) annotation(Line(points = {{
        -1.5, -60}, {-98, -60}, {-98, 0}, {-90, 0}}));
      connect(step6.outPort[1], transition7.inPort) annotation(Line(points = {{
        91.5, 0}, {96, 0}, {96, -60}, {4, -60}}));
      connect(transition2.outPort, step6.inPort[1]) annotation(Line(
        points = {{56.5, 0}, {70, 0}}));
      connect(transition1.outPort, Parallel1.inPort) annotation(Line(points = {{-47.5, 0}, 
        {-30.99, 0}}));
      connect(Parallel1.outPort, transition2.inPort) annotation(Line(points = {{36.66, 0}, 
        {51, 0}}));
      connect(compositeStep.inPort, Parallel1.split[1]) 
        annotation(Line(points = {{-11, 20}, 
        {-22.575, 20}}));
      connect(compositeStep.outPort, Parallel1.join[1]) 
        annotation(Line(points = {{20.5, 20}, 
        {28.575, 20}}));
      connect(step1.inPort[1], Parallel1.split[2]) annotation(Line(points = {{-5, -20}, 
        {-10, -20}, {-10, -20}, {-14, -20}, {-14, -20}, {-22.575, -20}}));
      connect(step1.outPort[1], Parallel1.join[2]) annotation(Line(points = {{16.5, 
        -20}, {28.575, -20}}));
      connect(setCondition.y, transition7.condition) annotation(Line(points = {{
        -8.5, -80}, {0, -80}, {0, -72}}, color = {255, 0, 255}));
      annotation(
        Documentation(info = "<html>
<p>
这个例子与 “ExecutionPaths” 相同，唯一的区别是替代路径被包含在一个 “CompositeStep” 中。
</p>
</html>"), experiment(StopTime = 15));
    end ShowCompositeStep;

    model ShowExceptions 
      "示例演示分层结构的状态图如何暂停和恢复不同层级的操作"

      extends Modelica.Icons.Example;

      Utilities.CompositeStep1 compositeStep annotation(Placement(transformation(extent = {{
        -20, 25}, {10, 55}})));
      InitialStep initialStep(nIn = 1, nOut = 1) annotation(
        Placement(transformation(extent = {{-80, 30}, {-60, 50}})));
      Transition transition1(enableTimer = true, waitTime = 1) 
        annotation(Placement(
        transformation(extent = {{-50, 30}, {-30, 50}})));
      Transition transition2(enableTimer = true, waitTime = 1) 
        annotation(Placement(
        transformation(extent = {{20, 30}, {40, 50}})));
      Transition transition3(enableTimer = true, waitTime = 2) 
        annotation(Placement(
        transformation(extent = {{-55, -30}, {-35, -10}})));
      Step step1(nIn = 1, nOut = 1) annotation(Placement(transformation(extent = {{-24, -30}, {-4, -10}})));
      Transition transition4(enableTimer = true, waitTime = 1) 
        annotation(Placement(
        transformation(extent = {{10, -30}, {30, -10}})));
      inner StateGraphRoot stateGraphRoot 
        annotation(Placement(transformation(extent = {{-90, -80}, {-70, -60}})));
    equation

      connect(transition1.outPort, compositeStep.inPort) 
        annotation(Line(points = {{-38.5, 40}, {-21, 40}}));
      connect(initialStep.outPort[1], transition1.inPort) 
        annotation(Line(points = {{-59.5, 40}, {-44, 40}}));
      connect(compositeStep.outPort, transition2.inPort) 
        annotation(Line(points = {{10.5, 40}, {26, 40}}));
      connect(transition2.outPort, initialStep.inPort[1]) annotation(Line(points = 
        {{31.5, 40}, {46, 40}, {46, 80}, {-90, 80}, {-90, 40}, {-81, 40}}));
      connect(compositeStep.suspend[1], transition3.inPort) 
        annotation(Line(points = {{-12.5, 
        24.5}, {-12.5, 10}, {-60, 10}, {-60, -20}, {-49, -20}}));
      connect(transition3.outPort, step1.inPort[1]) annotation(Line(points = {{
        -43.5, -20}, {-25, -20}}));
      connect(step1.outPort[1], transition4.inPort) 
        annotation(Line(points = {{-3.5, -20}, {16, -20}}));
      connect(transition4.outPort, compositeStep.resume[1]) 
        annotation(Line(points = {{21.5, 
        -20}, {40, -20}, {40, 10}, {2.5, 10}, {2.5, 24}}));
      annotation(
        Documentation(info = "<html><p>
<span style=\"color: rgb(51, 51, 51);\">CompositeStep \"compositeStep\" 是一个层次化的 StateGraph，包含两个其他子图。当组件 \"compositeStep\" 被挂起时，\"compositeStep\" 内的所有步骤都会被停用。通过进入 \"compositeStep\" 的 \"resume\" 端口，所有步骤会根据它们在离开 \"compositeStep\" 的 \"suspend\" 端口之前的设置被激活。</span>
</p>
</html>"), experiment(StopTime = 20));
    end ShowExceptions;

    model ControlledTanks 
      "演示油箱加注/清空系统的控制器"
      extends Modelica.Icons.Example;
      Utilities.TankController tankController 
        annotation(Placement(transformation(extent = {{-50, -20}, {-10, 20}})));
      Modelica.Blocks.Sources.RadioButtonSource start(reset = {stop.on, shut.on}, 
        buttonTimeTable = {1, 13, 15, 19}) 
        annotation(Placement(transformation(extent = {{-90, 20}, {-70, 40}})));
      Modelica.Blocks.Sources.RadioButtonSource stop(reset = {start.on, shut.on}, 
        buttonTimeTable = {13, 15, 19, 21}) 
        annotation(Placement(transformation(extent = {{-90, -10}, {-70, 10}})));
      Modelica.Blocks.Sources.RadioButtonSource shut(reset = {start.on, stop.on}, 
        buttonTimeTable = {21, 100}) 
        annotation(Placement(transformation(extent = {{-90, -40}, {-70, -20}})));

      Utilities.Tank tank1 annotation(Placement(transformation(extent = {{10, 20}, {
        60, 70}})));
      Utilities.Tank tank2 annotation(Placement(transformation(extent = {{34, -60}, 
        {84, -10}})));
      Utilities.valve valve1 
        annotation(Placement(transformation(
        origin = {22.5, 72}, 
        extent = {{-5.5, -5.5}, {5.5, 5.5}}, 
        rotation = 270)));
      Utilities.Source source annotation(Placement(transformation(extent = {{12.5, 
        80.5}, {32.5, 100.5}})));
      Utilities.valve valve2 annotation(Placement(transformation(
        origin = {46.5, 13}, 
        extent = {{-7, -8}, {7, 8}}, 
        rotation = 270)));
      Utilities.valve valve3 
        annotation(Placement(transformation(
        origin = {73.5, -77}, 
        extent = {{-7, -8}, {7, 8}}, 
        rotation = 270)));
      inner StateGraphRoot stateGraphRoot 
        annotation(Placement(transformation(extent = {{-90, 75}, {-70, 95}})));
    equation
      connect(tank1.outflow1, valve2.outflow1) annotation(Line(
        points = {{50, 33.75}, {50, 26.875}, {46.5, 26.875}, {46.5, 16.5}}, 
        thickness = 0.5));
      connect(tank2.inflow1, valve2.inflow1) annotation(Line(
        points = {{46.5, -18.75}, {46.5, 9.5}}, 
        thickness = 0.5));
      connect(tank2.outflow1, valve3.outflow1) annotation(Line(
        points = {{74, -46.25}, {74, -73.5}, {73.5, -73.5}}, 
        thickness = 0.5));
      connect(tank1.inflow1, valve1.inflow1) annotation(Line(
        points = {{22.5, 61.25}, {22.5, 69.25}}, 
        thickness = 0.5));
      connect(shut.on, tankController.shut) annotation(Line(points = {{-69, -30}, {
        -62, -30}, {-62, -12}, {-52, -12}}, color = {255, 0, 255}));
      connect(stop.on, tankController.stop) annotation(Line(points = {{-69, 0}, {-52, 
        0}}, color = {255, 0, 255}));
      connect(start.on, tankController.start) annotation(Line(points = {{-69, 30}, {
        -60, 30}, {-60, 12}, {-52, 12}}, color = {255, 0, 255}));
      connect(tank1.levelSensor, tankController.level1) annotation(Line(points = {
        {17.25, 40}, {-30, 40}, {-30, 60}, {-97, 60}, {-97, -50}, {-42, -50}, {-42, 
        -22}}, color = {0, 0, 255}));
      connect(tank2.levelSensor, tankController.level2) annotation(Line(points = {
        {41.25, -40}, {-18, -40}, {-18, -22}}, color = {0, 0, 255}));
      connect(tankController.valve1, valve1.valveControl) annotation(Line(points = 
        {{-9, 12}, {10, 12}, {10, 72}, {18.1, 72}}, color = {255, 0, 255}));
      connect(tankController.valve2, valve2.valveControl) annotation(Line(points = {{-9, 0}, {
        30, 0}, {30, 13}, {40.1, 13}}, color = {255, 0, 255}));
      connect(tankController.valve3, valve3.valveControl) annotation(Line(points = 
        {{-9, -12}, {23, -12}, {23, -77}, {67.1, -77}}, color = {255, 0, 255}));

      connect(source.outflow1, valve1.outflow1) annotation(Line(
        points = {{22.5, 85.5}, {22.5, 74.75}}, 
        thickness = 0.5));

      annotation(experiment(StopTime = 100), 
        Documentation(info = "<html><p>
本示例演示了油箱加注/排空系统的控制器。 该示例来自 Dressler (2004)，参见<a href=\"modelica://Modelica.StateGraph.UsersGuide.Literature\" target=\"\">Literature</a>&nbsp;。 基本操作是对两个储罐进行充填和排空：
</p>
<ol><li>
阀门1打开，将液体灌入罐1。</li>
<li>
当罐1达到其填充水平限制时，关闭阀门1。</li>
<li>
经过一段等待时间后，阀门2打开，液体从罐1流入罐2。</li>
<li>
当罐1为空时，关闭阀门2。</li>
<li>
经过一段等待时间后，阀门3打开，液体从罐2流出。</li>
<li>
当罐3为空时，关闭阀门3。</li>
</ol><p>
以上描述的 “normal” 流程可以受到三个按钮的影响：
</p>
<li>
<span style=\"color: rgb(51, 51, 51);\">按钮</span><span style=\"color: rgb(51, 51, 51);\"><strong> start</strong></span><span style=\"color: rgb(51, 51, 51);\"> 启动上述过程。当此按钮在 \"stop\" 或 \"shut\" 操作后被按下时，过程操作将继续进行</span>。</li>
<li>
<span style=\"color: rgb(51, 51, 51);\">按钮 </span><span style=\"color: rgb(51, 51, 51);\"><strong>stop</strong></span><span style=\"color: rgb(51, 51, 51);\"> 通过关闭所有阀门来停止上述过程。然后，控制器等待进一步的输入（可以是 \"start\" 或 \"shut\" 操作）</span>。</li>
<li>
<span style=\"color: rgb(51, 51, 51);\">按钮 </span><span style=\"color: rgb(51, 51, 51);\"><strong>shut</strong></span><span style=\"color: rgb(51, 51, 51);\"> 用于关闭过程，通过同时排空两个水箱。当这一操作完成后，过程将恢复到其初始配置。点击 \"start\" 将重新启动过程</span>。</li>
</html>"));
    end ControlledTanks;
    model Vertical_Launch "这是顺序动作的示例"
      extends Modelica.Icons.Example;
      Modelica.Units.SI.Length x "前向位移";
      Modelica.Units.SI.Velocity v "前向速度";
      Modelica.Units.SI.Angle angle "垂直角度";
      Modelica.Units.SI.AngularVelocity w "垂直角速度";
      Modelica.StateGraph.InitialStepWithSignal initialStepWithSignal(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(origin = {-138, 8}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.TransitionWithSignal transitionWithSignal 
        annotation(Placement(transformation(origin = {-98, 8}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.StepWithSignal stepWithSignal(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(origin = {-58, 8}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.TransitionWithSignal transition(enableTimer = false, waitTime = 10) 
        annotation(Placement(transformation(origin = {-18, 8}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.StepWithSignal stepWithSignal1(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(origin = {22, 8}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.TransitionWithSignal transitionWithSignal1(enableTimer = false, waitTime = 3) 
        annotation(Placement(transformation(origin = {62, 8}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.StepWithSignal stepWithSignal2(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(origin = {94, 8}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.TransitionWithSignal transitionWithSignal2 
        annotation(Placement(transformation(origin = {126, 8}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.StepWithSignal stepWithSignal3(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(origin = {158, 8}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y = if time < 7 then false else true) 
        annotation(Placement(transformation(origin = {-138, -38}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression2(y = if (x >= 10 and time > 20) then true else false) 
        annotation(Placement(transformation(origin = {22, -38}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression3(y = if angle < 90 / 180 * 3.14 then false else true) 
        annotation(Placement(transformation(origin = {94, -38}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Continuous.Integrator integrator[2];
      Modelica.Blocks.Sources.BooleanExpression booleanExpression4(y = if x >= 10 then true else false) 
        annotation(Placement(transformation(origin = {-58, -38}, 
        extent = {{-10, -10}, {10, 10}})));
    equation
      when stepWithSignal.active then
        v = 1;
      elsewhen stepWithSignal1.active then
        v = 0;
      end when;
      integrator[1].u = v;
      integrator[1].y = x;
      when stepWithSignal2.active then
        w = 6 / 180 * 3.14;
      elsewhen stepWithSignal3.active then
        w = 0;
      end when;
      integrator[2].u = w;
      integrator[2].y = angle;

      connect(initialStepWithSignal.outPort[1], transitionWithSignal.inPort) 
        annotation(Line(origin = {-115, 8}, 
        points = {{-12.5, 0}, {13, 0}}, 
        color = {0, 0, 0}));
      connect(transitionWithSignal.outPort, stepWithSignal.inPort[1]) 
        annotation(Line(origin = {-83, 8}, 
        points = {{-13.5, 0}, {14, 0}}, 
        color = {0, 0, 0}));
      connect(stepWithSignal.outPort[1], transition.inPort) 
        annotation(Line(origin = {-35, 8}, 
        points = {{-12.5, 0}, {13, 0}}, 
        color = {0, 0, 0}));
      connect(transition.outPort, stepWithSignal1.inPort[1]) 
        annotation(Line(origin = {-3, 8}, 
        points = {{-13.5, 0}, {14, 0}}, 
        color = {0, 0, 0}));
      connect(stepWithSignal1.outPort[1], transitionWithSignal1.inPort) 
        annotation(Line(origin = {45, 8}, 
        points = {{-12.5, 0}, {13, 0}}, 
        color = {0, 0, 0}));
      connect(transitionWithSignal1.outPort, stepWithSignal2.inPort[1]) 
        annotation(Line(origin = {73, 8}, 
        points = {{-9.5, 0}, {10, 0}}, 
        color = {0, 0, 0}));
      connect(stepWithSignal2.outPort[1], transitionWithSignal2.inPort) 
        annotation(Line(origin = {113, 8}, 
        points = {{-8.5, 0}, {9, 0}}, 
        color = {0, 0, 0}));
      connect(transitionWithSignal2.outPort, stepWithSignal3.inPort[1]) 
        annotation(Line(origin = {137, 8}, 
        points = {{-9.5, 0}, {10, 0}}, 
        color = {0, 0, 0}));
      connect(booleanExpression1.y, transitionWithSignal.condition) 
        annotation(Line(origin = {-112, -21}, 
        points = {{-15, -17}, {14, -17}, {14, 17}}, 
        color = {255, 0, 255}));
      connect(booleanExpression2.y, transitionWithSignal1.condition) 
        annotation(Line(origin = {8, -21}, 
        points = {{25, -17}, {54, -17}, {54, 17}}, 
        color = {255, 0, 255}));
      connect(booleanExpression3.y, transitionWithSignal2.condition) 
        annotation(Line(origin = {116, -21}, 
        points = {{-11, -17}, {10, -17}, {10, 17}}, 
        color = {255, 0, 255}));
      connect(booleanExpression4.y, transition.condition) 
        annotation(Line(origin = {-32, -21}, 
        points = {{-15, -17}, {14, -17}, {14, 17}}, 
        color = {255, 0, 255}));
      annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, 
        grid = {2, 2}), graphics = {Text(origin = {22, 47.5}, 
        extent = {{-65, 22.5}, {65, -22.5}}, 
        textString = "Raise command", 
        textStyle = {TextStyle.Bold})}), Documentation(info = "<html><p>
在接收到启动命令(<strong>stepWithSignal.active=true</strong>)后，车辆首先前进并在到达指定位置后停止(<strong>stepWithSignal1.active=true</strong>)。 <span style=\"color: rgb(31, 31, 31);\">接收到升起命令后开始升起</span>(<strong>stepWithSignal2.active=true</strong>)<span style=\"color: rgb(31, 31, 31);\">，并在升起达到设定角度时停止</span>(<strong>stepWithSignal3.active=true</strong>)<span style=\"color: rgb(31, 31, 31);\">。</span>
</p>
<p>
<img src=\"data:image/png;base64,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BRQCDhk2nSZAgAABAgQIECBQp8Dteg3X3s+k7/Pfbi/bXyftoE53oyZAgAABAgQIEDi2gELAseOn9wQIECBAgAABAgQIECBAgAABAgQIECBA4K2AQsBbHh8SIECAAAECBAgQIECAAAECBAgQIECAAIFjCygEHDt+ek+AAAECBAgQIECAAAECBAgQIECAAAECBN4KKAS85fEhAQIECBAgQIAAAQIECBAgQIAAAQIECBA4toBCwLHjp/cECBAgQIAAAQIECBAgQIAAAQIECBAgQOCtgELAWx4fEiBAgAABAgQIECBAgAABAgQIECBAgACBYwsoBBw7fnpPgAABAgQIECBAgAABAgQIECBAgAABAgTeCigEvOXxIQECBAgQIECAAAECBAgQIECAAAECBAgQOLaAQsCx46f3BAgQIECAAAECBAgQIECAAAECBAgQIEDgrYBCwFseHxIgQIAAAQIECBAgQIAAAQIECBAgQIAAgWMLKAQcO356T4AAAQIECBAgQIAAAQIECBAgQIAAAQIE3gooBLzl8SEBAgQIECBAgAABAgQIECBAgAABAgQIEDi2wOn//u//gh8G5oA5YA6YA+aAOWAOmAPmgDlgDpgD5oA5YA6YA+aAOWAOmAPmQJlzwIqAYxdy9J4AAQIECBAgQIAAAQIECBAgQIAAAQIECLwVUAh4y+NDAgQIECBAgAABAgQIECBAgAABAgQIECBwbAGFgGPHT+8JECBAgAABAgQIECBAgAABAgQIECBAgMBbAYWAtzw+JECAAAECBAgQIECAAAECBAgQIECAAAECxxZQCDh2/PSeAAECBAgQIECAAAECBAgQIECAAAECBAi8FVAIeMvjQwIECBAgQIAAAQIECBAgQIAAAQIECBAgcGwBhYBjx0/vCRAgQIAAAQIECBAgQIAAAQIECBAgQIDAWwGFgLc8PiRAgAABAgQIECBAgAABAgQIECBAgAABAscWUAg4dvz0ngABAgQIECBAgAABAgQIECBAgAABAgQIvBVQCHjLM/zhP//8E/79918/DMwBc8AcMAfMAXPAHDAHzAFzwBwwB8wBc8AcMAfMAXPAHDAHdjkH2vPY3Z+dFgKuoTmdQnPtutl/vIXL+RROp+7nHC63fpv2dWq7oW3H32uLAP0///vf//pveU0gWeC///5LbqshgSEBOWhIxXupAnJQqpR2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D/DK04vJQQoBCUGYKgQkNOlUAgQIECBAgAABAgQIECBAgAABAgQIECCwqIBCQAKnQkACnlMJECBAgAABAgQIECBAgAABAgQIECBAIIuAQkAC81QhIOZSjIRunVq4gEvBCg9whunJQRmQC+5CDio4uJmmJgdlgi60Gzmo0MBmmpb8kwm64G7koIKDm2FqclAG5MK7kIMKD/DK04vJQQoBCUGYKgQkNOlUAgQIECBAgAABAgQIECBAgAABAgQIECCwqIBCQAKnQkACnlMJECBAgAABAgQIECBAgAABAgQIECBAIIuAQkAC81QhIOZSjIRunVq4gEvBCg9whunJQRmQC+5CDio4uJmmJgdlgi60Gzmo0MBmmpb8kwm64G7koIKDm2FqclAG5MK7kIMKD/DK04vJQQoBCUGYKgQkNOlUAgQIECBAgAABAgQIECBAgAABAgQIECCwqIBCQAKnQkACnlMJECBAgAABAgQIECBAgAABAgQIECBAIIuAQkAC81QhIOZSjIRunVq4gEvBCg9whunJQRmQC+5CDio4uJmmJgdlgi60Gzmo0MBmmpb8kwm64G7koIKDm2FqclAG5MK7kIMKD/DK04vJQQoBCUGYKgQkNOlUAgQIECBAgAABAgQIECBAgAABAgQIECCwqIBCQAKnQkACnlMJECBAgAABAgQIECBAgAABAgQIECBAIIuAQkAC81QhIOZSjIRunVq4gEvBCg9whunJQRmQC+5CDio4uJmmJgdlgi60Gzmo0MBmmpb8kwm64G7koIKDm2FqclAG5MK7kIMKD/DK04vJQbsvBFxOh6bdkP/7Ojbn65jstTkfY44bO3f8talCwPjRXiVAgAABAgQIECBAgAABAgQIECBAgAABAvkFdl0IuJ6PzeF4bsJ9/64wMCwGXJpTWyw4XR7C48c93o56oBAQxeQgAgQIECBAgAABAgQIECBAgAABAgQIEPihwL4LAdewBNArvm763woGh1PzVwZoj309rm8h9vtUISDmUozYPhxXn4BLweqL+dIzloOWFq2rPTmornivMVs5aA3VetqUg+qJ9RozlX/WUK2rTTmorngvPVs5aGnR+tqTg+qL+ZIzjslBuy4EjGPdbwH0uFLg/jy4GqA/r7sqYFgg6N/9/H2qEPD5TEcQIECAAAECBAgQIECAAAECBAgQIECAAIE8AgUWAgZ/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BAgQIEBg3wIKAfuOn9ETIECAAAECBAgQIECAAAECBAgQIECAAIG3AgoBb3m8SYAAAQIECBAgQIAAAQIECBAgQIAAAQIE9i2gELDv+Bk9AQIECBAgQIAAAQIECBAgQIAAAQIECBB4K6AQ8JbHmwQIECBAgAABAgQIECBAgAABAgQIECBAYN8CCgH7jp/REyBAgAABAgQIECBAgAABAgQIECBAgACBtwIKAW95vEmAAAECBAgQIECAAAECBAgQIECAAAECBPYtoBCw7/gZPQECBAgQIECAAAECBAgQIECAAAECBAgQeCugEPCWx5sECBAgQIAAAQIECBAgQIAAAQIECBAgQGDfAgoB+46f0RMgQIAAAQIECBAgQIAAAQIECBAgQIAAgbcCCgFvebxJgAABAgQIECBAgAABAgQIECBAgAABAgT2LaAQsO/4GT0BAgQIECBAgAABAgQIECBAgAABAgQIEHgrcPjnn38aXwysAWvAGrAGrAFrwBqwBqwBa8AasAasAWvAGrAGrAFrwBqwBqyBMteAKwLe1km8SYAAAQIECBAgQIAAAQIECBAgQIAAAQIE9i2gELDv+Bk9AQIECBAgQIAAAQIECBAgQIAAAQIECBB4K6AQ8JbHmwQIECBAgAABAgQIECBAgAABAgQIECBAYN8CCgH7jp/REyBAgAABAgQIECBAgAABAgQIECBAgACBtwIKAW95vEmAAAECBAgQIECAAAECBAgQIECAAAECBPYtoBCw7/gZPQECBAgQIECAAAECBAgQIECAAAECBAgQeCugEPCWx5sECBAgQIAAAQIECBAgQIAAAQIECBAgQGDfAgoB+46f0RMgQIAAAQIECBAgQIAAAQIECBAf14KMAAAgAElEQVQgQIAAgbcCCgFvebxJgAABAgQIECBAgAABAgQIECBAgAABAgT2LaAQsO/4GT0BAgQIECBAgAABAgQIECBAgAABAgQIEHgroBDwlmf8zX///bf5v//7P18MrAFrwBqwBqwBa8AasAasAWvAGrAGrAFrwBqwBqwBa8AasAY2uQbafez+v50VAi7N6XBoTpd++O+/X06H5nAIv47N+fr+nJh32yLA8L///vtv+JLnBKIF/ve//0Uf60ACYwJy0JiK12IF5KBYKcdNCchBUzJejxGQg2KUHDMlIP9MyXg9VkAOipVy3JiAHDSm4rU5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\" alt=\"image.png\" data-href=\"\" style=\"\"/>
</p>
</html>"), experiment(Algorithm = Dassl, InlineIntegrator = false, InlineStepSize = false, NumberOfIntervals = 500, StartTime = 0, StopTime = 50, Tolerance = 0.0001), __MWORKS(ContinueSimConfig(SaveContinueFile = "false", SaveBeforeStop = "false", NumberBeforeStop = 1, FixedContinueInterval = "false", ContinueIntervalLength = 2.5, ContinueTimeVector), ResultViewerManager(resultViewers = {
        ResultViewer(name = "Example", executeTrigger = executeTrigger.SimulationFinished, commands = {
        CreatePlot(id = 1, position = [619, 0, 617, 668], y = ["x"], x_display_unit = "s", y_display_units = ["m"], y_axis = [1], legends = [" x [m]"], legend_layout = 7, legend_frame = True, left_title_type = 2, left_title = "length[m]", bottom_title_type = 2, bottom_title = "time[s]", right_title_type = 2, fix_time_range_value = 6.95291e-310), 
        CreatePlot(id = 1, position = [619, 0, 617, 668], y = ["angle"], x_display_unit = "s", y_display_units = ["deg"], y_axis = [1], legend_layout = 7, legend_frame = True, left_title_type = 2, left_title = "angle[deg]", bottom_title_type = 2, bottom_title = "time[s]", right_title_type = 2, fix_time_range_value = 6.95291e-310, sub_plot = [2, 1]), 
        CreatePlot(id = 1, position = [619, 0, 617, 668], y = ["stepWithSignal.active", "stepWithSignal1.active", "stepWithSignal2.active", "stepWithSignal3.active"], x_display_unit = "s", y_axis = [1, 1, 1, 1], legend_layout = 7, legend_frame = True, left_title_type = 2, left_title = "sign[1]", bottom_title_type = 2, bottom_title = "time[s]", right_title_type = 2, fix_time_range_value = 6.95291e-310, sub_plot = [3, 1])})
        })));
    end Vertical_Launch;
    model System_Controller "示例演示状态机控制系统的整体应用"
      extends Modelica.Icons.Example;
      Modelica.SIunits.Height h[4] "每个支腿的高度，其中 h[1] 是左前腿的高度，h[2] 是右前腿的高度，h[3] 是左后腿的高度，h[4] 是右后腿的高度";
      Modelica.SIunits.Velocity v[4] "每条腿伸展的速度";
      Modelica.SIunits.Angle alpha "平台倾斜角度";
      Modelica.StateGraph.InitialStepWithSignal initialStepWithSignal(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(origin = {-406, -50}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.TransitionWithSignal transitionWithSignal(enableTimer = true, waitTime = 2) 
        annotation(Placement(transformation(origin = {-362, -50}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.Parallel parallel(nBranches = 4) 
        annotation(Placement(transformation(origin = {-161.125, -50}, 
        extent = {{-93.625, -92.6875}, {93.625, 92.6875}})));
      Modelica.StateGraph.StepWithSignal stepWithSignal(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(origin = {-203.5, 14}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.TransitionWithSignal transitionWithSignal1 
        annotation(Placement(transformation(origin = {-161.5, 14}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.StepWithSignal stepWithSignal1(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(origin = {-123.5, 14}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.StepWithSignal stepWithSignal2(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(origin = {-203.5, -28.5}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.TransitionWithSignal transitionWithSignal2 
        annotation(Placement(transformation(origin = {-161.5, -28.5}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.StepWithSignal stepWithSignal3(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(origin = {-123.5, -28.5}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.StepWithSignal stepWithSignal4(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(origin = {-203.5, -76}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.TransitionWithSignal transitionWithSignal3 
        annotation(Placement(transformation(origin = {-161.5, -76}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.StepWithSignal stepWithSignal5(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(origin = {-123.5, -76}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.StepWithSignal stepWithSignal6(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(origin = {-203.5, -120}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.TransitionWithSignal transitionWithSignal4 
        annotation(Placement(transformation(origin = {-161.5, -120}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.StepWithSignal stepWithSignal7(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(origin = {-123.5, -120}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.Alternative alternative(nBranches = 3) 
        annotation(Placement(transformation(origin = {103.375, -50.6875}, 
        extent = {{-100.625, -92.6875}, {100.625, 92.6875}})));
      Modelica.StateGraph.StepWithSignal stepWithSignal8(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(origin = {-22, -50}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.Transition transition(enableTimer = true, waitTime = 2) 
        annotation(Placement(transformation(origin = {-49.75, -50}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.StepWithSignal stepWithSignal9(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(origin = {-322.125, -50}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.TransitionWithSignal transitionWithSignal5(enableTimer = true, waitTime = 2) 
        annotation(Placement(transformation(origin = {-282.25, -50}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.TransitionWithSignal transitionWithSignal6(enableTimer = true, waitTime = 2) 
        annotation(Placement(transformation(origin = {52, 2}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.StepWithSignal stepWithSignal10(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(origin = {128.125, 2}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.Transition transition1(enableTimer = true, waitTime = 2) 
        annotation(Placement(transformation(origin = {154, 2}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.TransitionWithSignal transitionWithSignal7(enableTimer = true, waitTime = 2) 
        annotation(Placement(transformation(origin = {52, -50}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.StepWithSignal stepWithSignal11(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(origin = {77.375, -50}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.Transition transition2(enableTimer = true, waitTime = 2) 
        annotation(Placement(transformation(origin = {154, -50}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.TransitionWithSignal transitionWithSignal8(enableTimer = true, waitTime = 2) 
        annotation(Placement(transformation(origin = {52, -102}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.StepWithSignal stepWithSignal12(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(origin = {77.375, -102}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.Transition transition3(enableTimer = true, waitTime = 2) 
        annotation(Placement(transformation(origin = {154, -102}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.StepWithSignal stepWithSignal14(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(origin = {238.625, -51.3125}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.Parallel parallel1(nBranches = 4) 
        annotation(Placement(transformation(origin = {404.375, -50.6875}, 
        extent = {{-93.625, -92.6875}, {93.625, 92.6875}})));
      Modelica.StateGraph.StepWithSignal stepWithSignal15(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(origin = {362, 13.3125}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.TransitionWithSignal transitionWithSignal10(enableTimer = false, waitTime = 2) 
        annotation(Placement(transformation(origin = {404, 13.3125}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.StepWithSignal stepWithSignal16(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(origin = {442, 13.3125}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.StepWithSignal stepWithSignal17(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(origin = {362, -29.1875}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.TransitionWithSignal transitionWithSignal11(enableTimer = false, waitTime = 2) 
        annotation(Placement(transformation(origin = {404, -29.1875}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.StepWithSignal stepWithSignal18(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(origin = {442, -29.1875}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.StepWithSignal stepWithSignal19(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(origin = {362, -76.6875}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.TransitionWithSignal transitionWithSignal12(enableTimer = false, waitTime = 2) 
        annotation(Placement(transformation(origin = {404, -76.6875}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.StepWithSignal stepWithSignal20(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(origin = {442, -76.6875}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.StepWithSignal stepWithSignal21(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(origin = {362, -120.6875}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.TransitionWithSignal transitionWithSignal13(enableTimer = false, waitTime = 2) 
        annotation(Placement(transformation(origin = {404, -120.6875}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.StepWithSignal stepWithSignal22(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(origin = {442, -120.6875}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.Transition transition4(enableTimer = true, waitTime = 2) 
        annotation(Placement(transformation(origin = {266.5, -51.3125}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Math.Gain gain(k = 57.3) 
        annotation(Placement(transformation(origin = {258.25, -180}, 
        extent = {{10, -10}, {-10, 10}})));
      Modelica.Blocks.Math.Abs abs1 annotation(Placement(transformation(origin = {180.25, -180}, 
        extent = {{10, -10}, {-10, 10}})));
      Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold = 0.1) 
        annotation(Placement(transformation(origin = {134.25, -180}, 
        extent = {{10, -10}, {-10, 10}})));
      Modelica.Blocks.Logical.GreaterEqualThreshold lessThreshold1(threshold = 0.1) annotation(Placement(transformation(origin = {134.25, -216}, 
        extent = {{10, -10}, {-10, 10}})));
      Modelica.Blocks.Logical.LessEqualThreshold lessThreshold2(threshold = -0.1) annotation(Placement(transformation(origin = {134.25, -256}, 
        extent = {{10, -10}, {-10, 10}})));
      Modelica.Blocks.Sources.RealExpression realExpression15(y = alpha) 
        annotation(Placement(transformation(origin = {306.25, -180}, 
        extent = {{10, -10}, {-10, 10}})));
      Modelica.Blocks.Logical.LessThreshold lessThreshold7(threshold = 180) 
        annotation(Placement(transformation(origin = {134.25, -300}, 
        extent = {{10, -10}, {-10, 10}})));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression(y = if integrator[1].y >= 0.5 then true else false) 
        annotation(Placement(transformation(origin = {-258, -6}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y = if integrator[2].y >= 0.5 then true else false) 
        annotation(Placement(transformation(origin = {-258, -68}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression2(y = if integrator[3].y >= 0.5 then true else false) 
        annotation(Placement(transformation(origin = {-258, -96}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression3(y = if integrator[4].y >= 0.5 then true else false) 
        annotation(Placement(transformation(origin = {-258, -156}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression5(y = if integrator[1].y <= 0 then true else false) 
        annotation(Placement(transformation(origin = {304.25, -6.6875}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression6(y = if integrator[2].y <= 0 then true else false) 
        annotation(Placement(transformation(origin = {304.25, -76.6875}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression7(y = if integrator[3].y <= 0 then true else false) 
        annotation(Placement(transformation(origin = {304.25, -102.6875}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression8(y = if integrator[4].y <= 0 then true else false) 
        annotation(Placement(transformation(origin = {304.25, -148.6875}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.StepWithSignal stepWithSignal23(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(origin = {562, -50.6875}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.Transition transition5(enableTimer = true, waitTime = 2) 
        annotation(Placement(transformation(origin = {525, -50.6875}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression9(y = if time < 1 then false else true) 
        annotation(Placement(transformation(origin = {-406, -96}, 
        extent = {{-10, -10}, {10, 10}})));
      inner Modelica.StateGraph.StateGraphRoot stateGraphRoot 
        annotation(Placement(transformation(origin = {-406, 14}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.TransitionWithSignal transitionWithSignal15 
        annotation(Placement(transformation(origin = {102.75, -50}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.StepWithSignal stepWithSignal25(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(origin = {128.125, -50}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.TransitionWithSignal transitionWithSignal16 
        annotation(Placement(transformation(origin = {102.75, -102}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.StateGraph.StepWithSignal stepWithSignal26(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(origin = {128.125, -102}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Continuous.Integrator integrator[4];

    equation
      when stepWithSignal.active then
        v[1] = 0.1;
      elsewhen stepWithSignal1.active then
        v[1] = 0;
      elsewhen stepWithSignal15.active then
        v[1] = -0.1;
      elsewhen stepWithSignal11.active then
        v[1] = -0.01;
      elsewhen stepWithSignal16.active or stepWithSignal10.active or stepWithSignal25.active or stepWithSignal26.active then
        v[1] = 0;
      end when;
      integrator[1].u = v[1];
      integrator[1].y + 0.1 = h[1];

      when stepWithSignal2.active then
        v[2] = 0.1;
      elsewhen stepWithSignal3.active then
        v[2] = 0;
      elsewhen stepWithSignal17.active then
        v[2] = -0.1;
      elsewhen stepWithSignal11.active then
        v[2] = -0.01;
      elsewhen stepWithSignal18.active or stepWithSignal10.active or stepWithSignal25.active or stepWithSignal26.active then
        v[2] = 0;
      end when;
      integrator[2].u = v[2];
      integrator[2].y + 0.1 = h[2];
      when stepWithSignal4.active then
        v[3] = 0.1;
      elsewhen stepWithSignal5.active then
        v[3] = 0;
      elsewhen stepWithSignal19.active then
        v[3] = -0.1;
      elsewhen stepWithSignal12.active then
        v[3] = 0.01;
      elsewhen stepWithSignal20.active or stepWithSignal10.active or stepWithSignal25.active or stepWithSignal26.active then
        v[3] = 0;
      end when;
      integrator[3].u = v[3];
      integrator[3].y = h[3];
      when stepWithSignal6.active then
        v[4] = 0.1;
      elsewhen stepWithSignal7.active then
        v[4] = 0;
      elsewhen stepWithSignal21.active then
        v[4] = -0.1;
      elsewhen stepWithSignal12.active then
        v[3] = 0.01;
      elsewhen stepWithSignal22.active or stepWithSignal10.active or stepWithSignal25.active or stepWithSignal26.active then
        v[4] = 0;
      end when;
      integrator[4].u = v[4];
      integrator[4].y = h[4];
      alpha = Modelica.Math.atan((h[1] - h[3]) / 5);

      connect(initialStepWithSignal.outPort[1], transitionWithSignal.inPort) 
        annotation(Line(origin = {-382, -50}, 
        points = {{-13.5, 0}, {16, 0}}, 
        color = {0, 0, 0}));
      connect(parallel.split[1], stepWithSignal.inPort[1]) 
        annotation(Line(origin = {-237, -18}, 
        points = {{3.31563, -32}, {3.31563, 32}, {22.5, 32}}, 
        color = {0, 0, 0}));
      connect(parallel.split[2], stepWithSignal2.inPort[1]) 
        annotation(Line(origin = {-237, -39}, 
        points = {{3.31563, -11}, {3.31563, 10.5}, {22.5, 10.5}}, 
        color = {0, 0, 0}));
      connect(parallel.split[3], stepWithSignal4.inPort[1]) 
        annotation(Line(origin = {-237, -63}, 
        points = {{3.31563, 13}, {3.31563, -13}, {22.5, -13}}, 
        color = {0, 0, 0}));
      connect(parallel.split[4], stepWithSignal6.inPort[1]) 
        annotation(Line(origin = {-237, -85}, 
        points = {{3.31563, 35}, {3.31563, -35}, {22.5, -35}}, 
        color = {0, 0, 0}));
      connect(stepWithSignal.outPort[1], transitionWithSignal1.inPort) 
        annotation(Line(origin = {-179, 14}, 
        points = {{-14, 0}, {13.5, 0}}, 
        color = {0, 0, 0}));
      connect(stepWithSignal2.outPort[1], transitionWithSignal2.inPort) 
        annotation(Line(origin = {-179, -28}, 
        points = {{-14, -0.5}, {13.5, -0.5}}, 
        color = {0, 0, 0}));
      connect(stepWithSignal4.outPort[1], transitionWithSignal3.inPort) 
        annotation(Line(origin = {-179, -76}, 
        points = {{-14, 0}, {13.5, 0}}, 
        color = {0, 0, 0}));
      connect(stepWithSignal6.outPort[1], transitionWithSignal4.inPort) 
        annotation(Line(origin = {-179, -120}, 
        points = {{-14, 1.42109e-14}, {13.5, 1.42109e-14}}, 
        color = {0, 0, 0}));
      connect(transitionWithSignal1.outPort, stepWithSignal1.inPort[1]) 
        annotation(Line(origin = {-147, 14}, 
        points = {{-13, 0}, {12.5, 0}}, 
        color = {0, 0, 0}));
      connect(transitionWithSignal2.outPort, stepWithSignal3.inPort[1]) 
        annotation(Line(origin = {-147, -28}, 
        points = {{-13, -0.5}, {12.5, -0.5}}, 
        color = {0, 0, 0}));
      connect(transitionWithSignal3.outPort, stepWithSignal5.inPort[1]) 
        annotation(Line(origin = {-147, -76}, 
        points = {{-13, 0}, {12.5, 0}}, 
        color = {0, 0, 0}));
      connect(transitionWithSignal4.outPort, stepWithSignal7.inPort[1]) 
        annotation(Line(origin = {-147, -120}, 
        points = {{-13, 1.42109e-14}, {12.5, 1.42109e-14}}, 
        color = {0, 0, 0}));
      connect(stepWithSignal1.outPort[1], parallel.join[1]) 
        annotation(Line(origin = {-101, -18}, 
        points = {{-12, 32}, {12.4344, 32}, {12.4344, -32}}, 
        color = {0, 0, 0}));
      connect(stepWithSignal3.outPort[1], parallel.join[2]) 
        annotation(Line(origin = {-101, -39}, 
        points = {{-12, 10.5}, {12.4344, 10.5}, {12.4344, -11}}, 
        color = {0, 0, 0}));
      connect(stepWithSignal5.outPort[1], parallel.join[3]) 
        annotation(Line(origin = {-101, -63}, 
        points = {{-12, -13}, {12.4344, -13}, {12.4344, 13}}, 
        color = {0, 0, 0}));
      connect(stepWithSignal7.outPort[1], parallel.join[4]) 
        annotation(Line(origin = {-101, -85}, 
        points = {{-12, -35}, {12.4344, -35}, {12.4344, 35}}, 
        color = {0, 0, 0}));
      connect(parallel.outPort, transition.inPort) 
        annotation(Line(origin = {-55, -50}, 
        points = {{-10.6275, 0}, {1.25, 0}}, 
        color = {0, 0, 0}));
      connect(transition.outPort, stepWithSignal8.inPort[1]) 
        annotation(Line(origin = {-28, -50}, 
        points = {{-20.25, 0}, {-5, 0}}, 
        color = {0, 0, 0}));
      connect(stepWithSignal8.outPort[1], alternative.inPort) 
        annotation(Line(origin = {24, -50}, 
        points = {{-35.5, 0}, {-24.2687, 0}, {-24.2687, -0.6875}}, 
        color = {0, 0, 0}));
      connect(transitionWithSignal.outPort, stepWithSignal9.inPort[1]) 
        annotation(Line(origin = {-347, -50}, 
        points = {{-13.5, 0}, {13.875, 0}}, 
        color = {0, 0, 0}));
      connect(transitionWithSignal5.inPort, stepWithSignal9.outPort[1]) 
        annotation(Line(origin = {-299, -50}, 
        points = {{12.75, 0}, {-12.625, 0}}, 
        color = {0, 0, 0}));
      connect(transitionWithSignal5.outPort, parallel.inPort) 
        annotation(Line(origin = {-269, -50}, 
        points = {{-11.75, 0}, {11.4412, 0}}, 
        color = {0, 0, 0}));
      connect(alternative.split[1], transitionWithSignal6.inPort) 
        annotation(Line(origin = {30, -24}, 
        points = {{-3.4675, -26.6875}, {-3.4675, 26}, {18, 26}}, 
        color = {0, 0, 0}));
      connect(alternative.split[2], transitionWithSignal7.inPort) 
        annotation(Line(origin = {39, -50}, 
        points = {{-12.4675, -0.6875}, {9, -0.6875}, {9, 0}}, 
        color = {0, 0, 0}));
      connect(alternative.split[3], transitionWithSignal8.inPort) 
        annotation(Line(origin = {30, -76}, 
        points = {{-3.4675, 25.3125}, {-3.4675, -26}, {18, -26}}, 
        color = {0, 0, 0}));
      connect(transitionWithSignal6.outPort, stepWithSignal10.inPort[1]) 
        annotation(Line(origin = {60, 2}, 
        points = {{-6.5, 0}, {57.125, 0}}, 
        color = {0, 0, 0}));
      connect(transition1.outPort, alternative.join[1]) 
        annotation(Line(origin = {120, -24}, 
        points = {{35.5, 26}, {85.4675, 26}, {85.4675, -26.6875}}, 
        color = {0, 0, 0}));
      connect(transitionWithSignal7.outPort, stepWithSignal11.inPort[1]) 
        annotation(Line(origin = {60, -50}, 
        points = {{-6.5, 0}, {6.375, 0}}, 
        color = {0, 0, 0}));
      connect(transitionWithSignal8.outPort, stepWithSignal12.inPort[1]) 
        annotation(Line(origin = {60, -102}, 
        points = {{-6.5, 0}, {6.375, 0}}, 
        color = {0, 0, 0}));
      connect(transition2.outPort, alternative.join[2]) 
        annotation(Line(origin = {120, -50}, 
        points = {{35.5, 0}, {85.4675, 0}, {85.4675, -0.6875}}, 
        color = {0, 0, 0}));
      connect(transition3.outPort, alternative.join[3]) 
        annotation(Line(origin = {120, -76}, 
        points = {{35.5, -26}, {85.4675, -26}, {85.4675, 25.3125}}, 
        color = {0, 0, 0}));
      connect(parallel1.split[1], stepWithSignal15.inPort[1]) 
        annotation(Line(origin = {328.5, -18.6875}, 
        points = {{3.31563, -32}, {3.31563, 32}, {22.5, 32}}, 
        color = {0, 0, 0}));
      connect(parallel1.split[2], stepWithSignal17.inPort[1]) 
        annotation(Line(origin = {328.5, -39.6875}, 
        points = {{3.31563, -11}, {3.31563, 10.5}, {22.5, 10.5}}, 
        color = {0, 0, 0}));
      connect(parallel1.split[3], stepWithSignal19.inPort[1]) 
        annotation(Line(origin = {328.5, -63.6875}, 
        points = {{3.31563, 13}, {3.31563, -13}, {22.5, -13}}, 
        color = {0, 0, 0}));
      connect(parallel1.split[4], stepWithSignal21.inPort[1]) 
        annotation(Line(origin = {328.5, -85.6875}, 
        points = {{3.31563, 35}, {3.31563, -35}, {22.5, -35}}, 
        color = {0, 0, 0}));
      connect(stepWithSignal15.outPort[1], transitionWithSignal10.inPort) 
        annotation(Line(origin = {386.5, 13.3125}, 
        points = {{-14, 0}, {13.5, 0}}, 
        color = {0, 0, 0}));
      connect(stepWithSignal17.outPort[1], transitionWithSignal11.inPort) 
        annotation(Line(origin = {386.5, -28.6875}, 
        points = {{-14, -0.5}, {13.5, -0.5}}, 
        color = {0, 0, 0}));
      connect(stepWithSignal19.outPort[1], transitionWithSignal12.inPort) 
        annotation(Line(origin = {386.5, -76.6875}, 
        points = {{-14, 0}, {13.5, 0}}, 
        color = {0, 0, 0}));
      connect(stepWithSignal21.outPort[1], transitionWithSignal13.inPort) 
        annotation(Line(origin = {386.5, -120.6875}, 
        points = {{-14, 0}, {13.5, 0}}, 
        color = {0, 0, 0}));
      connect(transitionWithSignal10.outPort, stepWithSignal16.inPort[1]) 
        annotation(Line(origin = {418.5, 13.3125}, 
        points = {{-13, 0}, {12.5, 0}}, 
        color = {0, 0, 0}));
      connect(transitionWithSignal11.outPort, stepWithSignal18.inPort[1]) 
        annotation(Line(origin = {418.5, -28.6875}, 
        points = {{-13, -0.5}, {12.5, -0.5}}, 
        color = {0, 0, 0}));
      connect(transitionWithSignal12.outPort, stepWithSignal20.inPort[1]) 
        annotation(Line(origin = {418.5, -76.6875}, 
        points = {{-13, 0}, {12.5, 0}}, 
        color = {0, 0, 0}));
      connect(transitionWithSignal13.outPort, stepWithSignal22.inPort[1]) 
        annotation(Line(origin = {418.5, -120.6875}, 
        points = {{-13, 0}, {12.5, 0}}, 
        color = {0, 0, 0}));
      connect(stepWithSignal14.outPort[1], transition4.inPort) 
        annotation(Line(origin = {255.625, -51.625}, 
        points = {{-6.5, 0.3125}, {6.875, 0.3125}}, 
        color = {0, 0, 0}));
      connect(transition4.outPort, parallel1.inPort) 
        annotation(Line(origin = {274.625, -50.625}, 
        points = {{-6.625, -0.6875}, {33.3162, -0.6875}, {33.3162, -0.0625}}, 
        color = {0, 0, 0}));
      connect(realExpression15.y, gain.u) 
        annotation(Line(origin = {283, -180}, 
        points = {{12.25, 0}, {-12.75, 0}}, 
        color = {0, 0, 127}));
      connect(abs1.u, gain.y) 
        annotation(Line(origin = {220, -180}, 
        points = {{-27.75, 0}, {27.25, 0}}, 
        color = {0, 0, 127}));
      connect(lessThreshold.u, abs1.y) 
        annotation(Line(origin = {158, -180}, 
        points = {{-11.75, 0}, {11.25, 0}}, 
        color = {0, 0, 127}));
      connect(lessThreshold1.u, gain.y) 
        annotation(Line(origin = {197, -198}, 
        points = {{-50.75, -18}, {29, -18}, {29, 18}, {50.25, 18}}, 
        color = {0, 0, 127}), __MWORKS(BlockSystem(NamedSignal)));
      connect(lessThreshold2.u, gain.y) 
        annotation(Line(origin = {197, -218}, 
        points = {{-50.75, -38}, {29, -38}, {29, 38}, {50.25, 38}}, 
        color = {0, 0, 127}), __MWORKS(BlockSystem(NamedSignal)));
      connect(lessThreshold7.u, gain.y) 
        annotation(Line(origin = {197, -251}, 
        points = {{-50.75, -49}, {29, -49}, {29, 71}, {50.25, 71}}, 
        color = {0, 0, 127}), __MWORKS(BlockSystem(NamedSignal)));
      connect(transitionWithSignal5.condition, lessThreshold7.y) 
        annotation(Line(origin = {-79, -185}, 
        points = {{-203.25, 123}, {-203.25, -115}, {202.25, -115}}, 
        color = {255, 0, 255}));
      connect(transitionWithSignal8.condition, lessThreshold2.y) 
        annotation(Line(origin = {88, -178}, 
        points = {{-36, 64}, {-36, -78}, {35.25, -78}}, 
        color = {255, 0, 255}));
      connect(transitionWithSignal7.condition, lessThreshold1.y) 
        annotation(Line(origin = {88, -132}, 
        points = {{-36, 70}, {-36, 56}, {-26, 56}, {-26, -84}, {35.25, -84}}, 
        color = {255, 0, 255}));
      connect(transitionWithSignal6.condition, lessThreshold.y) 
        annotation(Line(origin = {88, -88}, 
        points = {{-36, 78}, {-36, 64}, {6, 64}, {6, -92}, {35.25, -92}}, 
        color = {255, 0, 255}));
      connect(booleanExpression.y, transitionWithSignal1.condition) 
        annotation(Line(origin = {-204, 2}, 
        points = {{-43, -8}, {42.5, -8}, {42.5, 0}}, 
        color = {255, 0, 255}));
      connect(transitionWithSignal2.condition, booleanExpression1.y) 
        annotation(Line(origin = {-118, -29}, 
        points = {{-43.5, -11.5}, {-43.5, -27}, {-108, -27}, {-108, -39}, {-129, -39}}, 
        color = {255, 0, 255}));
      connect(booleanExpression2.y, transitionWithSignal3.condition) 
        annotation(Line(origin = {-204, -90}, 
        points = {{-43, -6}, {42.5, -6}, {42.5, 2}}, 
        color = {255, 0, 255}));
      connect(booleanExpression3.y, transitionWithSignal4.condition) 
        annotation(Line(origin = {-204, -144}, 
        points = {{-43, -12}, {42.5, -12}, {42.5, 12}}, 
        color = {255, 0, 255}));
      connect(booleanExpression8.y, transitionWithSignal13.condition) 
        annotation(Line(origin = {360, -140.6875}, 
        points = {{-44.75, -8}, {44, -8}, {44, 8}}, 
        color = {255, 0, 255}));
      connect(booleanExpression7.y, transitionWithSignal12.condition) 
        annotation(Line(origin = {360, -95.6875}, 
        points = {{-44.75, -7}, {44, -7}, {44, 7}}, 
        color = {255, 0, 255}));
      connect(booleanExpression6.y, transitionWithSignal11.condition) 
        annotation(Line(origin = {360, -58.6875}, 
        points = {{-44.75, -18}, {-18, -18}, {-18, 8}, {44, 8}, {44, 17.5}}, 
        color = {255, 0, 255}));
      connect(booleanExpression5.y, transitionWithSignal10.condition) 
        annotation(Line(origin = {360, -2.6875}, 
        points = {{-44.75, -4}, {44, -4}, {44, 4}}, 
        color = {255, 0, 255}));
      connect(stepWithSignal16.outPort[1], parallel1.join[1]) 
        annotation(Line(origin = {465, -18.6875}, 
        points = {{-12.5, 32}, {11.9344, 32}, {11.9344, -32}}, 
        color = {0, 0, 0}));
      connect(stepWithSignal18.outPort[1], parallel1.join[2]) 
        annotation(Line(origin = {465, -39.6875}, 
        points = {{-12.5, 10.5}, {11.9344, 10.5}, {11.9344, -11}}, 
        color = {0, 0, 0}));
      connect(stepWithSignal20.outPort[1], parallel1.join[3]) 
        annotation(Line(origin = {465, -63.6875}, 
        points = {{-12.5, -13}, {11.9344, -13}, {11.9344, 13}}, 
        color = {0, 0, 0}));
      connect(stepWithSignal22.outPort[1], parallel1.join[4]) 
        annotation(Line(origin = {465, -85.6875}, 
        points = {{-12.5, -35}, {11.9344, -35}, {11.9344, 35}}, 
        color = {0, 0, 0}));
      connect(parallel1.outPort, transition5.inPort) 
        annotation(Line(origin = {510, -50.6875}, 
        points = {{-10.1275, 0}, {11, 0}}, 
        color = {0, 0, 0}));
      connect(transition5.outPort, stepWithSignal23.inPort[1]) 
        annotation(Line(origin = {539, -50.6875}, 
        points = {{-12.5, 0}, {12, 0}}, 
        color = {0, 0, 0}));
      connect(booleanExpression9.y, transitionWithSignal.condition) 
        annotation(Line(origin = {-378, -79}, 
        points = {{-17, -17}, {16, -17}, {16, 17}}, 
        color = {255, 0, 255}));
      connect(stepWithSignal11.outPort[1], transitionWithSignal15.inPort) 
        annotation(Line(origin = {93, -50}, 
        points = {{-5.125, 0}, {5.75, 0}}, 
        color = {0, 0, 0}));
      connect(transitionWithSignal15.outPort, stepWithSignal25.inPort[1]) 
        annotation(Line(origin = {111, -50}, 
        points = {{-6.75, 0}, {6.125, 0}}, 
        color = {0, 0, 0}));
      connect(stepWithSignal25.outPort[1], transition2.inPort) 
        annotation(Line(origin = {144, -50}, 
        points = {{-5.375, 0}, {6, 0}}, 
        color = {0, 0, 0}));
      connect(stepWithSignal12.outPort[1], transitionWithSignal16.inPort) 
        annotation(Line(origin = {93, -102}, 
        points = {{-5.125, 0}, {5.75, 0}}, 
        color = {0, 0, 0}));
      connect(transitionWithSignal16.outPort, stepWithSignal26.inPort[1]) 
        annotation(Line(origin = {111, -102}, 
        points = {{-6.75, 0}, {6.125, 0}}, 
        color = {0, 0, 0}));
      connect(stepWithSignal26.outPort[1], transition3.inPort) 
        annotation(Line(origin = {144, -102}, 
        points = {{-5.375, 0}, {6, 0}}, 
        color = {0, 0, 0}));
      connect(stepWithSignal10.outPort[1], transition1.inPort) 
        annotation(Line(origin = {119, 2}, 
        points = {{19.625, 0}, {31, 0}}, 
        color = {0, 0, 0}));
      connect(transitionWithSignal15.condition, lessThreshold.y) 
        annotation(Line(origin = {113, -121}, 
        points = {{-10.25, 59}, {-10.25, 51}, {-3, 51}, {-3, -59}, {10.25, -59}}, 
        color = {255, 0, 255}), __MWORKS(BlockSystem(NamedSignal)));
      connect(transitionWithSignal16.condition, lessThreshold.y) 
        annotation(Line(origin = {113, -147}, 
        points = {{-10.25, 33}, {-10.25, 25}, {-3, 25}, {-3, -33}, {10.25, -33}}, 
        color = {255, 0, 255}), __MWORKS(BlockSystem(NamedSignal)));
      connect(alternative.outPort, stepWithSignal14.inPort[1]) 
        annotation(Line(origin = {203.625, -50.9375}, 
        points = {{2.3875, 0.25}, {24, 0.25}, {24, -0.375}}, 
        color = {0, 0, 0}));
      annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, 
        grid = {2, 2}), graphics = {Text(origin = {-161.125, 78}, 
        extent = {{-93.625, 43}, {93.625, -43}}, 
        textString = "
放置支腿指令", 
        textStyle = {TextStyle.Bold}), Text(origin = {404, 67.5625}, 
        extent = {{-100.625, 32.09375}, {100.625, -32.09375}}, 
        textString = "接收支腿指令", 
        textStyle = {TextStyle.Bold}), Text(origin = {103.375, 67.5625}, 
        extent = {{-78.8125, 21.75}, {78.8125, -21.75}}, 
        textString = "平衡指令", 
        textStyle = {TextStyle.Bold}), Text(origin = {-364.5, 67.5625}, 
        extent = {{-52.375, 21.75}, {52.375, -21.75}}, 
        textString = "车辆启动", 
        textStyle = {TextStyle.Bold})}), experiment(Algorithm = Dassl, StartTime = 0, StopTime = 50, Tolerance = 0.0001, InlineIntegrator = false, InlineStepSize = false, Interval = 0.001), __MWORKS(ContinueSimConfig(SaveContinueFile = "false", SaveBeforeStop = "false", NumberBeforeStop = 1, FixedContinueInterval = "false", ContinueIntervalLength = 8.334, ContinueTimeVector), ResultViewerManager(resultViewers = {
        ResultViewer(name = "Example1", executeTrigger = executeTrigger.None, commands = {
        CreatePlot(id = 1, position = [976, 0, 974, 1132], y = ["h[1]", "h[2]", "h[3]", "h[4]"], x_display_unit = "s", y_display_units = ["m", "m", "m", "m"], y_axis = [1, 1, 1, 1], legend_layout = 7, legend_frame = True, left_title_type = 2, left_title = "高度[m]", bottom_title_type = 2, bottom_title = "时间[s]", fix_time_range_value = 6.95295e-310), 
        CreatePlot(id = 1, position = [976, 0, 974, 1132], y = ["alpha"], x_display_unit = "s", y_display_units = ["deg"], y_axis = [1], legend_layout = 13, legend_frame = True, left_title_type = 2, left_title = "角度[deg]", bottom_title_type = 2, bottom_title = "时间[s]", fix_time_range_value = 6.95295e-310, sub_plot = [2, 1]), 
        CreatePlot(id = 1, position = [976, 0, 974, 1132], y = ["stepWithSignal9.active", "stepWithSignal.active", "stepWithSignal1.active", "stepWithSignal11.active", "stepWithSignal25.active", "stepWithSignal15.active", "stepWithSignal16.active"], x_display_unit = "s", y_axis = [1, 1, 1, 1, 1, 1, 1], legend_layout = 7, legend_frame = True, left_title_type = 2, left_title = "信号[1]", bottom_title_type = 2, bottom_title = "时间[s]", fix_time_range_value = 6.95295e-310, sub_plot = [3, 1])}), 
        ResultViewer(name = "Example", executeTrigger = executeTrigger.SimulationFinished, commands = {
        CreatePlot(id = 2, position = [976, 0, 974, 1132], y = ["h[1]", "h[2]", "h[3]", "h[4]"], x_display_unit = "s", y_display_units = ["m", "m", "m", "m"], y_axis = [1, 1, 1, 1], legend_layout = 7, legend_frame = True, left_title_type = 2, left_title = "高度[m]", bottom_title_type = 2, bottom_title = "时间[s]", fix_time_range_value = 6.95295e-310), 
        CreatePlot(id = 2, position = [976, 0, 974, 1132], y = ["alpha"], x_display_unit = "s", y_display_units = ["deg"], y_axis = [1], legend_layout = 13, legend_frame = True, left_title_type = 2, left_title = "角度[deg]", bottom_title_type = 2, bottom_title = "时间[s]", fix_time_range_value = 6.95295e-310, sub_plot = [2, 1]), 
        CreatePlot(id = 2, position = [976, 0, 974, 1132], y = ["stepWithSignal9.active", "stepWithSignal.active", "stepWithSignal1.active", "stepWithSignal11.active", "stepWithSignal25.active", "stepWithSignal15.active", "stepWithSignal16.active"], x_display_unit = "s", y_axis = [1, 1, 1, 1, 1, 1, 1], legend_layout = 7, legend_frame = True, left_title_type = 2, left_title = "信号[1]", bottom_title_type = 2, bottom_title = "时间[s]", fix_time_range_value = 6.95295e-310, sub_plot = [3, 1])})
        })), Documentation(info = "<html><p>
这个示例展示了通过状态机控制车辆的启动、支腿伸展、平衡和支腿收回指令。
</p>
<p>
车辆启动后 (<strong>stepWithSignal9.active=true</strong>), 以第一个支腿为例，在接收到放置支腿指令后 (<strong>stepWithSignal.active=true</strong>), 四个支腿开始伸展。当接收到支腿伸展到位的指令 (<strong>stepWithSignal1.active=true</strong>) 后，支腿停止伸展。只有当四个支腿都完全伸展到位时，支腿放置动作才算完成。
</p>
<p>
当支腿放置动作完成后，平台需要进行平衡。如果倾斜角度在[-0.1-0.1度]之间 (<strong>stepWithSignal10.active=true</strong>)，则无需进行平衡。若倾斜角度大于0.1度，则启动前向平衡模式 (<strong>stepWithSignal11.active=true</strong>)，直到平衡结束，倾斜角度回到[-0.1-0.1度]之间 (<strong>stepWithSignal25.active=true</strong>)。如果倾斜角度小于-0.1度，则启动后向平衡模式 (<strong>stepWithSignal12.active=true</strong>)，直到平衡结束，倾斜角度回到[-0.1-0.1度]之间 (<strong>stepWithSignal26.active=true</strong>)。
</p>
<p>
在接收到支腿收回指令后 (<strong>stepWithSignal15.active=true</strong>)，四个支腿开始收回。当接收到支腿收回到位的指令 (<strong>stepWithSignal16.active=true</strong>) 后，支腿停止收回。只有当四个支腿都完全收回到位时，支腿收回动作才算完成。
</p>
<p>
<img src=\"data:image/png;base64,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\" alt=\"image.png\" data-href=\"\" style=\"\"/>
</p>
</html>"));
    end System_Controller;

    package Utilities "示例的实用组件"
      extends Modelica.Icons.UtilitiesPackage;

      model TankController "水箱系统控制器"
        extends StateGraph.Interfaces.PartialStateGraphIcon;
        parameter Real limit = 0.98 "水箱1的极限水位";
        parameter SI.Time waitTime = 3 "等待时间";

        InitialStep s1(nIn = 2, nOut = 1) 
          annotation(Placement(transformation(extent = {{-72, 30}, {-52, 50}})));
        MakeProduct makeProduct(limit = limit, waitTime = waitTime) 
          annotation(Placement(transformation(extent = {{-20, 25}, {10, 55}})));
        Transition T1(condition = start) 
          annotation(Placement(transformation(extent = {{-50, 50}, {-30, 30}})));
        Transition T2(condition = level2 < 0.001) 
          annotation(Placement(transformation(extent = {{27, 50}, {47, 30}})));
        Transition T3(condition = stop) 
          annotation(Placement(transformation(
          origin = {-23, -1}, 
          extent = {{-10, -10}, {10, 10}}, 
          rotation = 270)));
        Step s2(nIn = 1, nOut = 2) 
          annotation(Placement(transformation(extent = {{-50, -60}, {-30, -40}})));
        Transition T4(condition = start) 
          annotation(Placement(transformation(
          origin = {10, -1}, 
          extent = {{-10, -10}, {10, 10}}, 
          rotation = 90)));
        Transition T5(condition = shut) annotation(Placement(transformation(extent = 
          {{-6, -60}, {14, -40}})));
        Step emptyTanks(nIn = 1, nOut = 1) annotation(Placement(transformation(extent = {{22, -60}, {42, -40}})));
        Transition T6(condition = level1 + level2 < 0.001) 
          annotation(Placement(transformation(extent = {{45, -60}, {65, -40}})));
        Modelica.Blocks.Interfaces.BooleanInput start 
          annotation(Placement(transformation(extent = {{-120, 50}, {-100, 70}})));
        Modelica.Blocks.Interfaces.BooleanInput stop 
          annotation(Placement(transformation(extent = {{-120, -10}, {-100, 10}})));
        Modelica.Blocks.Interfaces.BooleanInput shut 
          annotation(Placement(transformation(extent = {{-120, -70}, {-100, -50}})));
        Modelica.Blocks.Interfaces.RealInput level1 
          annotation(Placement(transformation(
          origin = {-60, -110}, 
          extent = {{-10, -10}, {10, 10}}, 
          rotation = 90)));
        Modelica.Blocks.Interfaces.RealInput level2 
          annotation(Placement(transformation(
          origin = {60, -110}, 
          extent = {{-10, -10}, {10, 10}}, 
          rotation = 90)));
        Modelica.Blocks.Interfaces.BooleanOutput valve1 
          annotation(Placement(transformation(extent = {{100, 55}, {110, 65}})));
        Modelica.Blocks.Interfaces.BooleanOutput valve2 
          annotation(Placement(transformation(extent = {{100, -5}, {110, 5}})));
        Modelica.Blocks.Interfaces.BooleanOutput valve3 
          annotation(Placement(transformation(extent = {{100, -65}, {110, -55}})));
        Modelica.Blocks.Sources.BooleanExpression setValve1(y = makeProduct.fillTank1.active) 
          annotation(Placement(transformation(extent = {{20, 73}, {80, 92}})));
        Modelica.Blocks.Sources.BooleanExpression setValve2(y = makeProduct.fillTank2.active or emptyTanks.active) 
          annotation(Placement(transformation(extent = {{-25, -89}, {80, -68}})));
        Modelica.Blocks.Sources.BooleanExpression setValve3(y = makeProduct.emptyTank2.active or emptyTanks.active) 
          annotation(Placement(transformation(extent = {{-26, -100}, {80, -80}})));
      equation

        connect(s1.outPort[1], T1.inPort) 
          annotation(Line(
          points = {{-51.5, 40}, {-44, 40}}));
        connect(T1.outPort, makeProduct.inPort) annotation(Line(
          points = {{-38.5, 40}, {-21, 40}}));
        connect(makeProduct.outPort, T2.inPort) annotation(Line(
          points = {{10.5, 40}, {33, 40}}));
        connect(T5.outPort, emptyTanks.inPort[1]) 
          annotation(Line(
          points = {{5.5, -50}, {21, -50}}));
        connect(emptyTanks.outPort[1], T6.inPort) 
          annotation(Line(
          points = {{42.5, -50}, {51, -50}}));
        connect(setValve1.y, valve1) 
          annotation(Line(points = {{83, 82.5}, {90, 82.5}, {90, 60}, {105, 60}}, color = {
          255, 0, 255}));
        connect(setValve2.y, valve2) 
          annotation(Line(points = {{85.25, -78.5}, {90, -78.5}, {90, 0}, {105, 0}}, color = {255, 0, 255}));
        connect(setValve3.y, valve3) annotation(Line(points = {{85.3, -90}, {95, -90}, 
          {95, -60}, {105, -60}}, color = {255, 0, 255}));
        connect(makeProduct.suspend[1], T3.inPort) 
          annotation(Line(points = {{-12.5, 
          24.5}, {-12.5, 12}, {-23, 12}, {-23, 3}}));
        connect(T3.outPort, s2.inPort[1]) 
          annotation(Line(points = {{-23, -2.5}, {-23, 
          -20}, {-66, -20}, {-66, -50}, {-51, -50}}));
        connect(T4.outPort, makeProduct.resume[1]) 
          annotation(Line(points = {{10, 0.5}, 
          {10, 15}, {2.5, 15}, {2.5, 24}}));
        connect(level1, makeProduct.level1) annotation(Line(points = {{-60, -110}, {
          -60, -80}, {-80, -80}, {-80, 20}, {-30, 20}, {-30, 28}, {-22, 28}}, color = {0, 0, 255}));
        connect(s2.outPort[1], T5.inPort) annotation(Line(points = {{-29.5, -49.75}, 
          {-30, -49.75}, {-30, -50}, {0, -50}}));
        connect(s2.outPort[2], T4.inPort) annotation(Line(points = {{-29.5, -50.25}, 
          {-29, -50}, {-8, -50}, {-8, -25}, {10, -25}, {10, -5}}));
        connect(T2.outPort, s1.inPort[1]) annotation(Line(points = {{38.5, 40}, {70, 
          40}, {70, 70}, {-84, 70}, {-84, 40}, {-73, 40}, {-73, 40.5}}));
        connect(T6.outPort, s1.inPort[2]) annotation(Line(points = {{56.5, -50}, {70, 
          -50}, {70, 70}, {-84, 70}, {-84, 40}, {-74, 40}, {-73, 39.5}}));
        annotation(
          Diagram(coordinateSystem(
          preserveAspectRatio = true, 
          extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}})}), 
          Icon(coordinateSystem(
          preserveAspectRatio = true, 
          extent = {{-100, -100}, {100, 100}}), graphics = {
          Text(
          extent = {{-100, 68}, {-32, 54}}, 
          textString = "start"), 
          Text(
          extent = {{-100, 6}, {-32, -8}}, 
          textString = "stop"), 
          Text(
          extent = {{-100, -54}, {-32, -68}}, 
          textString = "shut"), 
          Text(
          extent = {{-94, -82}, {-18, -96}}, 
          textString = "level1"), 
          Text(
          extent = {{24, -84}, {96, -98}}, 
          textString = "level2"), 
          Text(
          extent = {{31, 68}, {99, 54}}, 
          textString = "valve1"), 
          Text(
          extent = {{33, 9}, {101, -5}}, 
          textString = "valve2"), 
          Text(
          extent = {{34, -53}, {102, -67}}, 
          textString = "valve3")}));
      end TankController;

      model MakeProduct 
        "状态机定义何时加注或清空油箱"
        extends StateGraph.PartialCompositeStep;
        parameter Real limit = 0.98 "水箱1的极限水位";
        parameter SI.Time waitTime = 3 "等待时间";

        Modelica.Blocks.Interfaces.RealInput level1 
          annotation(Placement(transformation(extent = {{-190, -140}, {-150, -100}})));
        Step fillTank1(nIn = 1, nOut = 1) annotation(Placement(transformation(extent = {{-140, -10}, {-120, 10}})));
        Transition T1(condition = level1 > limit) 
          annotation(Placement(transformation(extent = {{-110, -10}, {-90, 10}})));
        Step fillTank2(nIn = 1, nOut = 1) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}})));
        Transition T3(condition = level1 < 0.001) 
          annotation(Placement(transformation(extent = {{20, -10}, {40, 10}})));
        Step emptyTank2(nIn = 1, nOut = 1) annotation(Placement(transformation(extent = {{120, -10}, {140, 10}})));
        Step wait1(nIn = 1, nOut = 1) annotation(Placement(transformation(extent = {{-80, -10}, {-60, 10}})));
        Transition T2(enableTimer = true, waitTime = waitTime) 
          annotation(Placement(transformation(extent = {{-50, -10}, {-30, 10}})));
        Step wait2(nIn = 1, nOut = 1) annotation(Placement(transformation(extent = {{54, -10}, {74, 10}})));
        Transition T4(enableTimer = true, waitTime = waitTime) 
          annotation(Placement(transformation(extent = {{82, -10}, {102, 10}})));
        annotation();
      equation
        connect(fillTank1.inPort[1], inPort) 
          annotation(Line(
          points = {{-141, 0}, {-160, 0}}));
        connect(fillTank1.outPort[1], T1.inPort) 
          annotation(Line(
          points = {{-119.5, 0}, {-104, 0}}));
        connect(fillTank2.outPort[1], T3.inPort) 
          annotation(Line(
          points = {{10.5, 0}, {26, 0}}));
        connect(emptyTank2.outPort[1], outPort) 
          annotation(Line(
          points = {{140.5, 0}, {155, 0}}));
        connect(wait1.outPort[1], T2.inPort) 
          annotation(Line(points = {{-59.5, 0}, {-44, 
          0}}));
        connect(T2.outPort, fillTank2.inPort[1]) 
          annotation(Line(points = {{-38.5, 0}, 
          {-11, 0}}));
        connect(T1.outPort, wait1.inPort[1]) 
          annotation(Line(points = {{-98.5, 0}, {-81, 
          0}}));
        connect(wait2.outPort[1], T4.inPort) 
          annotation(Line(points = {{74.5, 0}, {88, 0}}));
        connect(T3.outPort, wait2.inPort[1]) 
          annotation(Line(points = {{31.5, 0}, {53, 0}}));
        connect(T4.outPort, emptyTank2.inPort[1]) 
          annotation(Line(points = {{93.5, 0}, 
          {119, 0}}));
      end MakeProduct;

      connector Inflow1 
        "流入连接器(这是Isolde Dressler硕士论文项目副本)"

        input SI.VolumeFlowRate Fi "流入";
        annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
          -100}, {100, 100}}), graphics = {Polygon(
          points = {{-100, -100}, {0, 100}, {100, -100}, {-100, -100}}, 
          lineThickness = 0.5, 
          fillColor = {255, 255, 255}, 
          fillPattern = FillPattern.Solid)}));
      end Inflow1;

      connector Inflow2 
        "流入连接器(这是Isolde Dressler硕士论文项目副本)"

        output SI.VolumeFlowRate Fi "流入";
        annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
          -100}, {100, 100}}), graphics = {Polygon(
          points = {{-100, -100}, {0, 100}, {100, -100}, {-100, -100}}, 
          lineThickness = 0.5, 
          fillColor = {255, 255, 255}, 
          fillPattern = FillPattern.Solid)}));
      end Inflow2;

      connector Outflow1 
        "流出连接器(这是Isolde Dressler硕士论文项目副本)"

        output SI.VolumeFlowRate Fo "流出";
        input Boolean open "阀门开启";
        annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
          -100}, {100, 100}}), graphics = {Polygon(
          points = {{-100, 100}, {0, -100}, {100, 100}, {-100, 100}}, 
          lineThickness = 0.5, 
          fillColor = {255, 255, 255}, 
          fillPattern = FillPattern.Solid)}));
      end Outflow1;

      connector Outflow2 
        "流出连接器(这是Isolde Dressler硕士论文项目副本)"

        input SI.VolumeFlowRate Fo "流出";
        output Boolean open "阀门开启";
        annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
          -100}, {100, 100}}), graphics = {Polygon(
          points = {{-100, 100}, {0, -100}, {100, 100}, {-100, 100}}, 
          lineThickness = 0.5, 
          fillColor = {255, 255, 255}, 
          fillPattern = FillPattern.Solid)}));
      end Outflow2;

      model valve 
        "简单阀门模型(这是Isolde Dressler硕士论文项目副本)"

        Modelica.Blocks.Interfaces.BooleanInput valveControl 
          annotation(Placement(transformation(
          origin = {0, -80}, 
          extent = {{-20, -20}, {20, 20}}, 
          rotation = 90)));
        Modelica.StateGraph.Examples.Utilities.Inflow2 inflow1 
          annotation(Placement(transformation(
          origin = {50, 0}, 
          extent = {{-50, -50}, {50, 50}}, 
          rotation = 90)));
        Modelica.StateGraph.Examples.Utilities.Outflow2 outflow1 
          annotation(Placement(transformation(
          origin = {-50, 0}, 
          extent = {{-50, -50}, {50, 50}}, 
          rotation = 90)));
      equation
        outflow1.Fo = inflow1.Fi;
        outflow1.open = valveControl;
        annotation(
          Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {
          Line(points = {{0, -60}, {0, 0}}, color = {255, 0, 255})}), 
          Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {
          Line(
          points = {{20, 20}, {20, 20}}, 
          thickness = 0.5), 
          Text(
          extent = {{-131, 125}, {136, 67}}, 
          textColor = {0, 0, 255}, 
          textString = "%name"), 
          Line(
          points = {{0, 0}, {0, -60}}, 
          color = {255, 0, 255})}));
      end valve;

      model Tank 
        "简单水箱模型(这是Isolde Dressler硕士论文项目副本)"

        Modelica.Blocks.Interfaces.RealOutput levelSensor 
          annotation(Placement(transformation(extent = {{-61, -30}, {-81, -10}})));

        Modelica.StateGraph.Examples.Utilities.Inflow1 inflow1 
          annotation(Placement(transformation(extent = {{-55, 60}, {-45, 
          70}})));
        Modelica.StateGraph.Examples.Utilities.Outflow1 outflow1 
          annotation(Placement(transformation(extent = {{55, -50}, {
          65, -40}})));
        Real level(start = 0, fixed = true) "Tank level in % of max height";
        parameter Real A = 1 "水箱地面面积m^2";
        parameter Real a = 0.2 "排水孔面积m^2";
        parameter Real hmax = 1 "水箱最大高度m";
        constant Real g = Modelica.Constants.g_n;
      equation
        der(level) = (inflow1.Fi - outflow1.Fo) / (hmax * A);
        if outflow1.open then
          outflow1.Fo = sqrt(max(0, 2 * g * hmax * level)) * a;
        else
          outflow1.Fo = 0;
        end if;
        levelSensor = level;

        annotation(
          Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {
          Text(
          extent = {{-122, -82}, {88, -42}}, 
          textString = "%name", 
          textColor = {0, 0, 255}), 
          Rectangle(
          extent = {{-60, 60}, {80, -40}}, 
          lineThickness = 0.5, 
          fillColor = {255, 255, 255}, 
          fillPattern = FillPattern.Solid), 
          Rectangle(
          extent = DynamicSelect({{-60, -40}, {-60, -40}}, {{-60, -40}, {80, (-40 
          + level * 100)}}), 
          lineThickness = 0.5, 
          fillPattern = FillPattern.HorizontalCylinder, 
          fillColor = {191, 0, 95})}));
      end Tank;

      model Source 
        "简单的信号源模型(这是Isolde Dressler硕士论文项目副本)"

        Modelica.StateGraph.Examples.Utilities.Outflow1 outflow1 
          annotation(Placement(transformation(extent = {{-10, -60}, {10, -40}})));
        parameter Real maxflow = 1 "流出源的最大流量";
      equation
        if outflow1.open then
          outflow1.Fo = maxflow;
        else
          outflow1.Fo = 0;
        end if;
        annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
          -100}, {100, 100}}), graphics = {Rectangle(
          extent = {{-80, 40}, {80, -40}}, 
          lineThickness = 0.5, 
          fillColor = {255, 255, 255}, 
          fillPattern = FillPattern.Solid), Text(
          extent = {{-144, 54}, {152, 114}}, 
          textString = "%name", 
          textColor = {0, 0, 255})}));
      end Source;

      model CompositeStep 
        "演示复合步骤的状态机(用于StateGraph.Examples.ShowCompositeStep)"
        extends StateGraph.PartialCompositeStep;
        Transition transition3(enableTimer = true, waitTime = 1) 
          annotation(Placement(
          transformation(extent = {{-64, 50}, {-44, 70}})));
        Transition transition4(enableTimer = true, waitTime = 1) 
          annotation(Placement(
          transformation(extent = {{-64, -10}, {-44, 10}})));
        Step step3(nIn = 1, nOut = 1) annotation(
          Placement(transformation(extent = {{-10, 50}, {10, 70}})));
        Step step4(nIn = 1, nOut = 1) annotation(
          Placement(transformation(extent = {{-10, -10}, {10, 10}})));
        Transition transition5(enableTimer = true, waitTime = 2) 
          annotation(Placement(
          transformation(extent = {{36, 50}, {56, 70}})));
        Transition transition6(enableTimer = true, waitTime = 2) 
          annotation(Placement(
          transformation(extent = {{36, -10}, {56, 10}})));
        Transition transition4a(enableTimer = true, waitTime = 1) 
          annotation(Placement(
          transformation(extent = {{-64, -70}, {-44, -50}})));
        Step step4a(nIn = 1, nOut = 1) annotation(
          Placement(transformation(extent = {{-10, -70}, {10, -50}})));
        Transition transition6a(enableTimer = true, waitTime = 2) 
          annotation(Placement(
          transformation(extent = {{36, -70}, {56, -50}})));
        Step initStep(nIn = 1, nOut = 1) annotation(Placement(transformation(extent = {{-140, -10}, {-120, 10}})));
        Step exitStep(nIn = 1, nOut = 1) annotation(Placement(transformation(extent = {{120, -10}, {140, 10}})));
        Alternative Alternative1(nBranches = 3) annotation(Placement(
          transformation(extent = {{-98, -90}, {98, 90}})));
        annotation();
      equation
        connect(transition3.outPort, step3.inPort[1]) 
          annotation(Line(points = {{-52.5, 60}, {-11, 60}}));
        connect(step3.outPort[1], transition5.inPort) 
          annotation(Line(points = {{10.5, 60}, {42, 60}}));
        connect(transition4.outPort, step4.inPort[1]) 
          annotation(Line(points = {{-52.5, 0}, {-11, 0}}));
        connect(step4.outPort[1], transition6.inPort) 
          annotation(Line(points = {{10.5, 0}, {42, 0}}));
        connect(transition4a.outPort, step4a.inPort[1]) 
          annotation(Line(points = {{-52.5, -60}, {-11, -60}}));
        connect(step4a.outPort[1], transition6a.inPort) 
          annotation(Line(points = {{10.5, -60}, {42, -60}}));
        connect(initStep.inPort[1], inPort) 
          annotation(Line(points = {{-141, 0}, {-160, 0}}));
        connect(exitStep.outPort[1], outPort) 
          annotation(Line(points = {{140.5, 0}, {155, 0}}));
        connect(initStep.outPort[1], Alternative1.inPort) annotation(Line(points = {{-119.5, 
          0}, {-100.94, 0}}));
        connect(Alternative1.outPort, exitStep.inPort[1]) 
          annotation(Line(points = {{99.96, 0}, {119, 0}}));
        connect(transition3.inPort, Alternative1.split[1]) annotation(Line(origin = {-67.71, 60}, 
          points = {{9.71, 0}, {-2.29, 0}, {-2.29, -60}, {-9.71, -60}}));
        connect(transition4.inPort, Alternative1.split[2]) annotation(Line(
          points = {{-58, 0}, {-67.975, 0}, {-77.42, 0}}));
        connect(transition4a.inPort, Alternative1.split[3]) annotation(Line(
          points = {{-58, -60}, {-67.975, -60}, {-77.42, -60}}));
        connect(transition5.outPort, Alternative1.join[1]) annotation(Line(origin = {62.46, 60}, 
          points = {{-14.96, 0}, {-2.46, 0}, {-2.46, -60}, {14.96, -60}}));
        connect(transition6.outPort, Alternative1.join[2]) annotation(Line(
          points = {{47.5, 0}, {60.725, 0}, {77.42, 0}}));
        connect(transition6a.outPort, Alternative1.join[3]) annotation(Line(
          points = {{47.5, -60}, {60.725, -60}, {77.42, -60}}));
      end CompositeStep;

      model CompositeStep1 
        "用于演示异常的复合步骤(在StateGraph.Examples.ShowExceptions中)"
        extends PartialCompositeStep;
        Transition transition1(
          enableTimer = false, 
          waitTime = 0, 
          condition = time >= 8) 
          annotation(Placement(
          transformation(extent = {{-60, 20}, {-40, 40}})));
        Step initStep(nIn = 1, nOut = 1) annotation(Placement(transformation(extent = {{-140, -10}, {-120, 10}})));
        Step exitStep(nIn = 1, nOut = 1) annotation(Placement(transformation(extent = {{110, -10}, {130, 10}})));
        CompositeStep2 compositeStep11(waitTime = 3) 
          annotation(Placement(transformation(
          extent = {{-20, 15}, {10, 45}})));
        CompositeStep2 compositeStep12(waitTime = 2) 
          annotation(Placement(transformation(
          extent = {{-20, -45}, {10, -15}})));
        Transition transition2(
          condition = time >= 4, 
          enableTimer = false, 
          waitTime = 0) 
          annotation(Placement(
          transformation(extent = {{-61, -40}, {-41, -20}})));
        Transition transition3(enableTimer = false, waitTime = 0) 
          annotation(Placement(
          transformation(extent = {{29, 20}, {49, 40}})));
        Transition transition4(enableTimer = false, waitTime = 0) 
          annotation(Placement(
          transformation(extent = {{29, -40}, {49, -20}})));
        Alternative Alternative1 annotation(Placement(transformation(extent = {{
          -100, -60}, {89, 60}})));
        annotation();
      equation
        connect(exitStep.outPort[1], outPort) 
          annotation(Line(points = {{130.5, 0}, {155, 0}}));
        connect(initStep.inPort[1], inPort) 
          annotation(Line(points = {{-141, 0}, {-160, 0}}));
        connect(transition1.outPort, compositeStep11.inPort) 
          annotation(Line(points = {{-48.5, 30}, {-21, 30}}));
        connect(transition2.outPort, compositeStep12.inPort) 
          annotation(Line(points = {{
          -49.5, -30}, {-21, -30}}));
        connect(compositeStep11.outPort, transition3.inPort) 
          annotation(Line(points = {{10.5, 30}, {35, 30}}));
        connect(compositeStep12.outPort, transition4.inPort) 
          annotation(Line(points = {{
          10.5, -30}, {35, -30}}));
        connect(initStep.outPort[1], Alternative1.inPort) annotation(Line(points = 
          {{-119.5, 0}, {-102.835, 0}}));
        connect(Alternative1.outPort, exitStep.inPort[1]) 
          annotation(Line(points = {{90.89, 0}, {109, 0}}));
        connect(transition1.inPort, Alternative1.split[1]) annotation(Line(
          points = {{-54, 30}, {-68, 30}, {-68, 0}, {-80.155, 0}}));
        connect(transition2.inPort, Alternative1.split[2]) annotation(Line(
          points = {{-55, -30}, {-68, -30}, {-68, 0}, {-80.155, 0}}));
        connect(transition3.outPort, Alternative1.join[1]) annotation(Line(
          points = {{40.5, 30}, {54, 30}, {54, 0}, {69.155, 0}}));
        connect(transition4.outPort, Alternative1.join[2]) annotation(Line(
          points = {{40.5, -30}, {54, -30}, {54, 0}, {69.155, 0}}));
      end CompositeStep1;

      model CompositeStep2 
        "用于演示异常的复合步骤(在StateGraph.Examples.ShowExceptions中)"
        extends PartialCompositeStep;
        Transition transition(enableTimer = true, waitTime = waitTime) 
          annotation(Placement(transformation(extent = {{-30, -10}, {-10, 10}})));
        Step initStep(nIn = 1, nOut = 1) annotation(Placement(transformation(extent = {{-140, -10}, {-120, 10}})));
        Step exitStep(nIn = 1, nOut = 1) annotation(Placement(transformation(extent = {{110, -10}, {130, 10}})));
        parameter SI.Time waitTime = 2 "该复合步骤的等待时间";
        annotation();
      equation
        connect(exitStep.outPort[1], outPort) 
          annotation(Line(points = {{130.5, 0}, {155, 0}}));
        connect(initStep.inPort[1], inPort) 
          annotation(Line(points = {{-141, 0}, {-160, 0}}));
        connect(initStep.outPort[1], transition.inPort) 
          annotation(Line(points = {{-119.5, 0}, {-24, 0}}));
        connect(transition.outPort, exitStep.inPort[1]) 
          annotation(Line(points = {{-18.5, 0}, {109, 0}}));
      end CompositeStep2;
      annotation();

    end Utilities;
    annotation();
  end Examples;

  package Interfaces "连接器和部分模型"
    extends Modelica.Icons.InterfacesPackage;

    connector Step_in "步骤的输入端口"
      output Boolean occupied "=true，如果步骤处于活动状态" annotation(HideResult = true);
      input Boolean set "=true，如果转换触发且步骤被激活" annotation(HideResult = true);
      annotation(
        Icon(coordinateSystem(
        preserveAspectRatio = true, 
        extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(
        points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}}, 
        fillPattern = FillPattern.Solid)}), 
        Diagram(coordinateSystem(
        preserveAspectRatio = true, 
        extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(
        points = {{0, 50}, {100, 0}, {0, -50}, {0, 50}}, 
        fillPattern = FillPattern.Solid), Text(
        extent = {{-141, 100}, {100, 60}}, 
        textString = "%name")}));
    end Step_in;

    connector Step_out "步骤的输出端口"
      output Boolean available "=true，如果步骤处于活动状态" annotation(HideResult = true);

      input Boolean reset "=true，如果转换触发且步骤被激活" 
        annotation(HideResult = true);

      annotation(Icon(coordinateSystem(
        preserveAspectRatio = true, 
        extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(
        extent = {{-100, 100}, {100, -100}}, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid)}), 
        Diagram(coordinateSystem(
        preserveAspectRatio = true, 
        extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(
        extent = {{-100, 50}, {0, -50}}, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), Text(
        extent = {{-100, 100}, {186, 58}}, 
        textString = "%name")}));
    end Step_out;

    connector Transition_in "转换的输入端口"
      input Boolean available 
        "= true，如果与转换输入相连的步骤处于活动状态" 
        annotation(HideResult = true);
      output Boolean reset 
        "= true，如果转换触发，且与转换输入相连的步骤被停用" 
        annotation(HideResult = true);

      annotation(Icon(coordinateSystem(
        preserveAspectRatio = true, 
        extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(
        points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}}, 
        fillPattern = FillPattern.Solid)}), 
        Diagram(coordinateSystem(
        preserveAspectRatio = true, 
        extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(
        points = {{0, 50}, {100, 0}, {0, -50}, {0, 50}}, 
        fillPattern = FillPattern.Solid), Text(
        extent = {{-141, 100}, {100, 60}}, 
        textString = "%name")}));
    end Transition_in;

    connector Transition_out "转换的输出端口"
      input Boolean occupied 
        "= true，如果与转换输入相连的步骤处于活动状态" 
        annotation(HideResult = true);
      output Boolean set 
        "= true，如果转换触发，且与转换输入相连的步骤被停用" 
        annotation(HideResult = true);

      annotation(Icon(coordinateSystem(
        preserveAspectRatio = true, 
        extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(
        extent = {{-100, 100}, {100, -100}}, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid)}), 
        Diagram(coordinateSystem(
        preserveAspectRatio = true, 
        extent = {{-100, -100}, {100, 100}}), graphics = {Text(
        extent = {{-100, 100}, {146, 60}}, 
        textString = "%name"), Rectangle(
        extent = {{-100, 50}, {0, -50}}, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid)}));
    end Transition_out;

    connector CompositeStep_resume 
      "步进的输入端口(用于复合步进的简历连接器)"
      output Boolean occupied "= true，如果步骤处于活动状态" annotation(HideResult = true);
      input Boolean set "= true，如果转换触发且步骤被激活" 
        annotation(HideResult = true);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Polygon(
        points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}}, 
        fillPattern = FillPattern.Solid)}));
    end CompositeStep_resume;

    connector CompositeStep_suspend 
      "步进的输出端口(用于复合步进的悬挂连接器)"

      output Boolean available "= true，如果步骤处于活动状态" annotation(HideResult = true);

      input Boolean reset "= true，如果转换触发且步骤停用" 
        annotation(HideResult = true);

      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Rectangle(
        extent = {{-100, 100}, {100, -100}}, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid)}), Documentation(info = "<html><p>
<br>
</p>
</html>"));
    end CompositeStep_suspend;

    connector CompositeStepStatePort_in 
      "复合步骤与复合步骤内普通步骤之间的通信端口(暂停/恢复为输入端)"

      input Boolean suspend 
        "= true，如果复合步骤的暂停转换触发";
      input Boolean resume "== true，如果CompositeStep的恢复转换触发";
      Real activeStepsDummy 
        "假变量，表示连接器符合连接器的限制条件" annotation(HideResult = true);
      flow Real activeSteps "复合步骤中的活动步骤数";
      annotation();
    end CompositeStepStatePort_in;

    connector CompositeStepStatePort_out 
      "复合步骤与复合步骤内普通步骤之间的通信端口(挂起/恢复是输出)"

      output Boolean suspend 
        "== true，如果复合步骤的暂停转换触发";
      output Boolean resume "= true，如果CompositeStep的恢复转换触发";
      Real activeStepsDummy 
        "假变量，表示连接器符合连接器的限制条件" annotation(HideResult = true);
      flow Real activeSteps "复合步骤中的活动步骤数";
      annotation();
    end CompositeStepStatePort_out;

    partial block PartialStep 
      "带一个输入和一个输出端口的基础步骤"

      parameter Integer nIn(min = 0) = 1 "输入连接数" annotation(Dialog(connectorSizing = true), HideResult = true);
      parameter Integer nOut(min = 0) = 1 "输出连接数" annotation(Dialog(connectorSizing = true), HideResult = true);

      /* 引入 localActive 是因为组件 "Step "具有布尔变量 "active
          和组件 "StepWithSignal "定义了连接器实例 "active
      而且这两个组件都继承自 PartialStep
      */
      output Boolean localActive 
        "= true，如果步骤已激活，否则步骤未激活" 
        annotation(HideResult = true);
      Interfaces.Step_in inPort[nIn] "步进输入连接器矢量" 
        annotation(Placement(transformation(extent = {{-120, 10}, {-100, -10}})));
      Interfaces.Step_out outPort[nOut] "步进输出连接器矢量" 
        annotation(Placement(transformation(extent = {{100, 5}, {110, -5}})));
    protected
      outer Interfaces.CompositeStepState stateGraphRoot;
      model OuterStatePort
        CompositeStepStatePort_in subgraphStatePort;
        input Boolean localActive;
        annotation();
      equation
        subgraphStatePort.activeSteps = if localActive then 1.0 else 0.0;
      end OuterStatePort;
      OuterStatePort outerStatePort(localActive = localActive);

      Boolean newActive "下一次迭代中的活跃值" 
        annotation(HideResult = true);
      Boolean oldActive "复合步骤终止时的活动值";
      annotation();
    initial equation
      pre(newActive) = pre(localActive);
      pre(oldActive) = pre(localActive);
    equation
      connect(outerStatePort.subgraphStatePort, stateGraphRoot.subgraphStatePort);

      // 检查与连接器的连接是否正确
      for i in 1:nIn loop

        assert(cardinality(inPort[i]) <= 1, 
          "Connector is connected to more than one transition (this is not allowed)");
      end for;

      for i in 1:nOut loop

        assert(cardinality(outPort[i]) <= 1, 
          "Connector is connected to more than one transition (this is not allowed)");
      end for;

      // 设置活动状态
      localActive = pre(newActive);
      newActive = if outerStatePort.subgraphStatePort.resume then 
        oldActive else 
        (Modelica.Math.BooleanVectors.anyTrue(inPort.set) or 
        localActive 
        and not Modelica.Math.BooleanVectors.anyTrue(outPort.reset)) 
        and not outerStatePort.subgraphStatePort.suspend;

      // 记住暂停操作的状态
      when outerStatePort.subgraphStatePort.suspend then
        oldActive = localActive;
      end when;

      // 报告状态到输入和输出的转换
      for i in 1:nIn loop
        inPort[i].occupied = if i == 1 then localActive else 
          inPort[i - 1].occupied or 
          inPort[i - 1].set;
      end for;

      for i in 1:nOut loop
        outPort[i].available = if i == 1 then localActive else 
          outPort[i - 1].available and not 
          outPort[i - 1].reset;
      end for;

      // 默认设置，如果未连接输入端口或输出端口
      for i in 1:nIn loop
        if cardinality(inPort[i]) == 0 then
          inPort[i].set = false;
        end if;
      end for;

      for i in 1:nOut loop
        if cardinality(outPort[i]) == 0 then
          outPort[i].reset = false;
        end if;
      end for;
    end PartialStep;

    partial block PartialTransition 
      "带输入和输出连接的基础转换"
      input Boolean localCondition "= true，如果转换可以启动" 
        annotation(HideResult = true);
      parameter Boolean enableTimer = false "= true，如果计时器已启用" 
        annotation(Evaluate = true, Dialog(group = "计时器"));
      parameter SI.Time waitTime(min = 0) = 0 
        "转换触发前的等待时间" 
        annotation(Dialog(group = "计时器", enable = enableTimer));
      output SI.Time t 
        "实际等待时间(当t>waitTime时将触发转换)";
      output Boolean enableFire "= true，如果所有触发条件均为真";
      output Boolean fire "= true，如果转换触发" annotation(HideResult = true);

      StateGraph.Interfaces.Transition_in inPort 
        "转换输入连接器矢量" 
        annotation(Placement(transformation(extent = {{-50, -10}, {-30, 10}})));
      StateGraph.Interfaces.Transition_out outPort 
        "转换输出连接器矢量" 
        annotation(Placement(transformation(extent = {{10, -5}, {20, 5}})));
    protected
      discrete SI.Time t_start 
        "如果 waitTime 为零，则启动转换的瞬间时间";
      Real t_dummy;
      annotation();
    initial equation
      pre(t_start) = time;
      pre(enableFire) = false;
    equation
      assert(cardinality(inPort) == 1, 
        "Connector inPort is not connected to exactly one other connector");
      assert(cardinality(outPort) == 1, 
        "Connector outPort is not connected to exactly one other connector");

      // 计时器的处理
      if enableTimer then
        when enableFire then
          t_start = time;
        end when;
        t_dummy = time - t_start;
        t = if enableFire then t_dummy else 0;
        fire = enableFire and time >= t_start + waitTime;
      else
        when false then
          t_start = pre(t_start);
        end when;
        t_dummy = 0;
        t = 0;
        fire = enableFire;
      end if;

      // 确定触发设置并向相关步骤报告
      enableFire = localCondition and inPort.available and not outPort.occupied;
      inPort.reset = fire;
      outPort.set = fire;
    end PartialTransition;

    partial block PartialStateGraphIcon "状态图对象的图标"

      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Rectangle(
        extent = {{-100, 100}, {100, -100}}, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), Text(
        extent = {{160, 110}, {-160, 150}}, 
        textString = "%name", 
        textColor = {0, 0, 255})}));
    end PartialStateGraphIcon;

    model CompositeStepState 
      "复合步骤与复合步骤中的步骤之间的通信通道"

      output Boolean suspend = false "= true，如果复合步骤的暂停转换触发";
      output Boolean resume = false "= true，如果CompositeStep的恢复转换触发";
      CompositeStepStatePort_out subgraphStatePort;

    /*
    missingInnerMessage = "没有在StateGraph的最高层定义\"stateGraphRoot\"组件。
    系统会自动引入一个stateGraphRoot组件。
    为了消除此消息，请将StateGraph.StateGraphRoot拖入模型的顶层。");
    */
    equation
      suspend = subgraphStatePort.suspend;
      resume = subgraphStatePort.resume;
      subgraphStatePort.activeStepsDummy = 0;
      annotation(
        defaultComponentName = "stateGraphRoot", 
        defaultComponentPrefixes = "inner", 
        missingInnerMessage = "一个\"stateGraphRoot\"组件被自动引入");
    end CompositeStepState;
    annotation();
  end Interfaces;

  block InitialStep "初始步骤(模拟开始时激活的步骤)"

    output Boolean active 
      "= true，如果步骤已激活，否则步骤未激活";

    extends Interfaces.PartialStep;

  initial equation
    active = true;
  equation
    active = localActive;
    annotation(
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Text(
      extent = {{-200, 110}, {200, 150}}, 
      textString = "%name", 
      textColor = {0, 0, 255}), 
      Rectangle(
      extent = {{-100, 100}, {100, -100}}, 
      fillColor = DynamicSelect({255, 255, 255}, if active then {0, 255, 0} else {255, 255, 255}), 
      fillPattern = FillPattern.Solid), 
      Rectangle(extent = {{-80, 80}, {80, -80}})}), 
      Diagram(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Rectangle(extent = {{-80, 80}, {80, -80}})}));
  end InitialStep;

  block InitialStepWithSignal 
    "初始步骤(模拟开始时处于活动状态的步骤)。当步骤处于活动状态时，连接器\"active\"为true"

    extends Interfaces.PartialStep;

    Modelica.Blocks.Interfaces.BooleanOutput active 
      annotation(Placement(transformation(
      origin = {0, -110}, 
      extent = {{-10, -10}, {10, 10}}, 
      rotation = 270)));
  initial equation
    active = true;
  equation
    active = localActive;
    annotation(Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
      -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Rectangle(extent = {{-80, 80}, {80, -80}})}), 
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Text(
      extent = {{-200, 110}, {200, 150}}, 
      textString = "%name", 
      textColor = {0, 0, 255}), 
      Rectangle(
      extent = {{-100, 100}, {100, -100}}, 
      fillColor = DynamicSelect({255, 255, 255}, if active then {0, 255, 0} else {255, 255, 255}), 
      fillPattern = FillPattern.Solid), 
      Text(
      extent = {{-92, -50}, {94, -68}}, 
      textString = "active"), 
      Rectangle(extent = {{-80, 80}, {80, -80}})}), Documentation(info = "<html><p>
<br>
</p>
</html>"));
  end InitialStepWithSignal;

  block Step "普通步骤(模拟开始时未激活的步骤)"

    output Boolean active 
      "= true，如果步骤已激活，否则步骤未激活";

    extends Interfaces.PartialStep;

  initial equation
    active = false;
  equation
    active = localActive;
    annotation(
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {Text(
      extent = {{-200, 110}, {200, 150}}, 
      textString = "%name", 
      textColor = {0, 0, 255}), Rectangle(
      extent = {{-100, 100}, {100, -100}}, 
      fillColor = DynamicSelect({255, 255, 255}, if active then {0, 255, 0} else {255, 255, 255}), 
      fillPattern = FillPattern.Solid)}), 
      Diagram(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}})}));
  end Step;

  block StepWithSignal 
    "普通步骤(模拟开始时未激活的步骤)。当步骤处于活动状态时，连接器\"active\"为true"

    extends Interfaces.PartialStep;

    Modelica.Blocks.Interfaces.BooleanOutput active 
      annotation(Placement(transformation(
      origin = {0, -110}, 
      extent = {{-10, -10}, {10, 10}}, 
      rotation = 270)));
  initial equation
    active = false;
  equation
    active = localActive;
    annotation(Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
      -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}})}), 
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Text(
      extent = {{-200, 110}, {200, 150}}, 
      textString = "%name", 
      textColor = {0, 0, 255}), 
      Rectangle(
      extent = {{-100, 100}, {100, -100}}, 
      fillColor = DynamicSelect({255, 255, 255}, if active then {0, 255, 0} else {255, 255, 255}), 
      fillPattern = FillPattern.Solid), 
      Text(
      extent = {{-92, -74}, {94, -92}}, 
      textString = "active")}));
  end StepWithSignal;

  block Transition 
    "通过修改变量条件设置的触发条件转换"

    input Boolean condition = true 
      "= true，如果转换可能触发(表达式随时间变化)" 
      annotation(Dialog(group = "触发条件"));

    extends Interfaces.PartialTransition(final localCondition = condition);

    annotation(
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Rectangle(
      extent = {{-10, 100}, {10, -100}}, 
      fillColor = DynamicSelect({0, 0, 0}, if enableFire then {0, 255, 0} else {0, 0, 0}), 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-30, 0}, {-10, 0}}), 
      Text(
      extent = {{200, 110}, {-200, 150}}, 
      textString = "%name", 
      textColor = {0, 0, 255}), 
      Text(
      visible = enableTimer, 
      extent = {{20, 20}, {200, 45}}, 
      textString = "%waitTime"), 
      Text(
      extent = {{-200, -120}, {200, -145}}, 
      textColor = DynamicSelect({0, 0, 0}, if condition then {0, 255, 0} else {0, 0, 0}), 
      textString = "%condition")}), 
      Diagram(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-31, 0}, {-11, 0}}), 
      Rectangle(
      extent = {{-10, 100}, {10, -100}}, 
      fillPattern = FillPattern.Solid)}));

  end Transition;

  block TransitionWithSignal 
    "通过布尔输入信号设置的触发条件转换"

    Modelica.Blocks.Interfaces.BooleanInput condition 
      annotation(Placement(transformation(
      origin = {0, -120}, 
      extent = {{-20, -20}, {20, 20}}, 
      rotation = 90)));

    extends Interfaces.PartialTransition(final localCondition = condition);

    annotation(
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Text(
      visible = enableTimer, 
      extent = {{20, 20}, {200, 45}}, 
      textString = "%waitTime"), 
      Rectangle(
      extent = {{-10, 100}, {10, -100}}, 
      fillColor = DynamicSelect({0, 0, 0}, if enableFire then {0, 255, 0} else {0, 0, 0}), 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-30, 0}, {-10, 0}}), 
      Text(
      extent = {{200, 110}, {-200, 150}}, 
      textString = "%name", 
      textColor = {0, 0, 255}), 
      Ellipse(
      extent = {{7, -81}, {-7, -95}}, 
      lineColor = DynamicSelect({0, 0, 0}, if condition then {0, 255, 0} else {0, 0, 0}), 
      fillColor = DynamicSelect({0, 0, 0}, if condition then {0, 255, 0} else {0, 0, 0}), 
      fillPattern = FillPattern.Solid)}), 
      Diagram(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-31, 0}, {-11, 0}}), 
      Rectangle(
      extent = {{-10, 100}, {10, -100}}, 
      fillPattern = FillPattern.Solid)}));
  end TransitionWithSignal;

  block Alternative 
    "执行路径的替代分支（在两个步骤之间使用组件）"

    parameter Integer nBranches(min = 1) = 2 "备选分支数量";
    Interfaces.Transition_in inPort 
      annotation(Placement(transformation(extent = {{-106, 
      -3}, {-100, 3}})));
    Interfaces.Transition_out outPort 
      annotation(Placement(transformation(extent = {{100, 
      -2}, {104, 2}})));
    Step_in_forAlternative join[nBranches] 
      annotation(Placement(transformation(extent = 
      {{78, 100}, {80, -100}})));
    Step_out_forAlternative split[nBranches] 
      annotation(Placement(transformation(
      extent = {{-78, 100}, {-80, -100}})));

    connector Step_in_forAlternative 
      "步骤的输入端口(有特殊图标，可在组件\"Alternative\"中使用)"

      output Boolean occupied "=true，如果步骤处于活动状态" 
        annotation(HideResult = true);
      input Boolean set "=true，如果转换触发且步骤被激活" 
        annotation(HideResult = true);

      annotation(Icon(coordinateSystem(
        extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(
        extent = {{-100, 100}, {100, -100}}, 
        fillColor = {175, 175, 175}, 
        fillPattern = FillPattern.Solid)}), 
        Diagram(coordinateSystem(
        extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(
        extent = {{-100, 100}, {100, -100}}, 
        fillColor = {175, 175, 175}, 
        fillPattern = FillPattern.Solid)}));
    end Step_in_forAlternative;

    connector Step_out_forAlternative 
      "步骤的输出端口(有特殊图标，可在组件\"Alternative\"中使用)"

      output Boolean available "=true，如果步骤处于活动状态" 
        annotation(HideResult = true);
      input Boolean reset "=true，如果转换触发且步骤被激活" 
        annotation(HideResult = true);

      annotation(Icon(coordinateSystem(
        extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(
        extent = {{-100, 100}, {100, -100}}, 
        fillColor = {175, 175, 175}, 
        fillPattern = FillPattern.Solid)}), 
        Diagram(coordinateSystem(
        extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(
        extent = {{-100, 100}, {100, -100}}, 
        fillColor = {175, 175, 175}, 
        fillPattern = FillPattern.Solid)}));
    end Step_out_forAlternative;

  equation
    // 检查连接器的连接情况

    assert(cardinality(inPort) == 1, 
      "Connector inPort is not connected to exactly one other connector");

    assert(cardinality(outPort) == 1, 
      "Connector outPort is not connected to exactly one other connector");

    for i in 1:nBranches loop

      assert(cardinality(split[i]) == 1, 
        "Connector is not connected to exactly one other connector");

      assert(cardinality(join[i]) == 1, 
        "Connector is not connected to exactly one other connector");

    end for;

    // 在连接器之间传播标志

    for i in 1:nBranches loop
      split[i].available = if i == 1 then inPort.available else 
        split[i - 1].available and not split[i - 1].reset;

    end for;
    join.occupied = fill(outPort.occupied, nBranches);
    inPort.reset = Modelica.Math.BooleanVectors.anyTrue(split.reset);
    outPort.set = Modelica.Math.BooleanVectors.anyTrue(join.set);
    annotation(
      Icon(coordinateSystem(
      preserveAspectRatio = false, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(
      points = {{-80, 100}, {80, 100}}, 
      pattern = LinePattern.Dot), 
      Line(
      points = {{-80, -100}, {80, -100}}, 
      pattern = LinePattern.Dot), 
      Line(points = {{-100, 0}, {-80, 0}}), 
      Line(points = {{80, 0}, {100, 0}})}), 
      Diagram(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-100, 0}, {-80, 0}}), 
      Line(points = {{80, 0}, {100, 0}})}));
  end Alternative;

  block Parallel 
    "执行路径的并行分支（在两个转换之间使用组件）"

    parameter Integer nBranches(min = 1) = 2 
      "并行执行的并行分支数";
    Interfaces.Step_in inPort annotation(Placement(transformation(extent = {{-106, 
      -3}, {-100, 3}})));
    Interfaces.Step_out outPort annotation(Placement(transformation(extent = {{100, 
      -2}, {104, 2}})));
    Transition_in_forParallel join[nBranches] 
      annotation(Placement(transformation(extent = 
      {{75, 100}, {80, -100}})));
    Transition_out_forParallel split[nBranches] 
      annotation(Placement(transformation(
      extent = {{-75, 100}, {-80, -100}})));

    connector Transition_in_forParallel 
      "转换的输入端口(有特殊图标，可在组件\"Parallel\"中使用)"

      input Boolean available 
        "=true，如果与转换输入相连的步骤处于活动状态" 
        annotation(HideResult = true);
      output Boolean reset 
        "=true，如果转换触发，且与转换输入相连的步骤被停用" 
        annotation(HideResult = true);

      annotation(Icon(coordinateSystem(
        extent = {{-100, -100}, {100, 100}}), graphics = {
        Rectangle(
        extent = {{-100, 100}, {100, -100}}, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), 
        Rectangle(
        extent = {{-100, 100}, {100, -100}}, 
        lineColor = {255, 255, 255}, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), 
        Line(
        points = {{-100, 100}, {-100, -100}}, 
        thickness = 0.5), 
        Line(
        points = {{100, 100}, {100, -100}}, 
        thickness = 0.5)}), Diagram(coordinateSystem(
        extent = {{-100, -100}, {100, 100}}), graphics = {
        Rectangle(
        extent = {{-100, 100}, {100, -100}}, 
        lineColor = {255, 255, 255}, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), 
        Line(
        points = {{-100, 100}, {-100, -100}}, 
        thickness = 0.5), 
        Line(
        points = {{100, 100}, {100, -100}}, 
        thickness = 0.5)}));
    end Transition_in_forParallel;

    connector Transition_out_forParallel 
      "转换的输出端口(有特殊图标，可在组件\"Parallel\"中使用)"

      input Boolean occupied 
        "=true，如果与转换输入相连的步骤处于活动状态" 
        annotation(HideResult = true);
      output Boolean set 
        "=true，如果转换触发，且与转换输入相连的步骤被停用" 
        annotation(HideResult = true);

      annotation(Icon(coordinateSystem(
        extent = {{-100, -100}, {100, 100}}), graphics = {
        Rectangle(
        extent = {{-100, 100}, {100, -100}}, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), 
        Rectangle(
        extent = {{-100, 100}, {100, -100}}, 
        lineColor = {255, 255, 255}, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), 
        Line(
        points = {{-100, 100}, {-100, -100}}, 
        thickness = 0.5), 
        Line(
        points = {{100, 100}, {100, -100}}, 
        thickness = 0.5)}), 
        Diagram(coordinateSystem(
        extent = {{-100, -100}, {100, 100}}), graphics = {
        Rectangle(
        extent = {{-100, 100}, {100, -100}}, 
        lineColor = {255, 255, 255}, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), 
        Line(
        points = {{-100, 100}, {-100, -100}}, 
        thickness = 0.5), 
        Line(
        points = {{100, 100}, {100, -100}}, 
        thickness = 0.5)}));
    end Transition_out_forParallel;

  equation
    // 检查连接器的连接情况

    assert(cardinality(inPort) == 1, 
      "Connector inPort is not connected to exactly one other connector");

    assert(cardinality(outPort) == 1, 
      "Connector outPort is not connected to exactly one other connector");

    for i in 1:nBranches loop

      assert(cardinality(split[i]) == 1, 
        "Connector is not connected to exactly one other connector");

      assert(cardinality(join[i]) == 1, 
        "Connector is not connected to exactly one other connector");

    end for;

    // 在连接器之间传播标志
    split.set = fill(inPort.set, nBranches);
    join.reset = fill(outPort.reset, nBranches);
    inPort.occupied = Modelica.Math.BooleanVectors.anyTrue(split.occupied);
    outPort.available = Modelica.Math.BooleanVectors.andTrue(join.available);
    annotation(
      Icon(coordinateSystem(
      preserveAspectRatio = false, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{-100, 0}, {-80, 0}}), 
      Line(points = {{80, 0}, {100, 0}}), 
      Line(
      points = {{-80, 100}, {80, 100}}, 
      pattern = LinePattern.Dot), 
      Line(
      points = {{-80, -100}, {80, -100}}, 
      pattern = LinePattern.Dot)}), 
      Diagram(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-100, 0}, {-80, 0}}), 
      Line(points = {{80, 0}, {100, 0}})}));
  end Parallel;

  partial model PartialCompositeStep 
    "内部具有状态图的复合步骤"

    parameter Integer nSuspend = 1 "暂停端口数" annotation(Dialog(group = "额外连接"));
    parameter Integer nResume = 1 "恢复端口数" annotation(Dialog(group = "额外连接"));

    /* 状态图的根(stateGraphRoot)的修改是相对于\"inner\"定义的，即它被报告给所有位于CompositeStep内的组件
    */
    inner outer StateGraph.Interfaces.CompositeStepState stateGraphRoot(
      suspend = Modelica.Math.BooleanVectors.anyTrue(suspend.reset) or outerState.subgraphStatePort.suspend, 
      resume = Modelica.Math.BooleanVectors.anyTrue(resume.set) or outerState.subgraphStatePort.resume) 
      "复合步骤与复合步骤内各步骤之间的通信端口";
    output Boolean active 
      "=true，如果步骤已激活，否则步骤未激活";
    StateGraph.Interfaces.Step_in inPort annotation(Placement(transformation(
      extent = {{-170, 10}, {-150, -10}})));
    StateGraph.Interfaces.Step_out outPort annotation(Placement(transformation(
      extent = {{150, 5}, {160, -5}})));
    StateGraph.Interfaces.CompositeStep_suspend suspend[nSuspend] 
      annotation(Placement(transformation(
      origin = {-75, -155}, 
      extent = {{-5, 5}, {5, -5}}, 
      rotation = 270)));
    StateGraph.Interfaces.CompositeStep_resume resume[nResume] 
      annotation(Placement(transformation(
      origin = {75, -160}, 
      extent = {{-10, -10}, {10, 10}}, 
      rotation = 90)));

    model OuterState 
      "模块包含与外部状态连接的端口GraphRoot"
      Interfaces.CompositeStepStatePort_in subgraphStatePort 
        "连接到外部状态的端口GraphRoot";
      input Boolean active;
      annotation();
    equation
      subgraphStatePort.activeSteps = if active then 1.0 else 0.0;
    end OuterState;
    OuterState outerState(active = active);

  protected
    model InnerState
      outer Interfaces.CompositeStepState stateGraphRoot;
      annotation();
    end InnerState;
    InnerState innerState;

    Boolean newActive "下一次迭代中的active值" 
      annotation(HideResult = true);
    Integer activeSteps "复合步骤中的活动步骤数";
  initial equation
    pre(newActive) = false;
    // pre(active) = pre(newActive);
  equation
    // 连接到外部复合步骤
    connect(outerState.subgraphStatePort, stateGraphRoot.subgraphStatePort);

    // 设置CompositeStep的激活标志
    activeSteps = -integer(innerState.stateGraphRoot.subgraphStatePort.activeSteps);
    active = pre(newActive);

    /* 在以下情况下，复合步骤处于活动状态
    - 复合步骤中至少有一个步骤处于活动状态，且
    - 暂停转换没有触发，且
    - 上一级复合步骤的暂停转换没有触发，或
    - 复合步骤中没有任何步骤处于活动状态，且
    - 恢复转换启动或上一级复合步骤的恢复转换启动
    启动，或上一级复合步骤的恢复转换启动。
    */
    // newActive = activeSteps > 0，且不是 suspend.reset 或 resume.set;
    newActive = activeSteps > 0 and not Modelica.Math.BooleanVectors.anyTrue(suspend.reset) and not 
      outerState.subgraphStatePort.suspend or 
      Modelica.Math.BooleanVectors.anyTrue(resume.set) or outerState.subgraphStatePort.resume;

    // 报告暂停和恢复转换的状态

    for i in 1:nResume loop
      resume[i].occupied = if i == 1 then active else 
        resume[i - 1].occupied or 
        resume[i - 1].set;

    end for;

    for i in 1:nSuspend loop
      suspend[i].available = if i == 1 then active else 
        suspend[i - 1].available and not 
        suspend[i - 1].reset;

    end for;

    /* 检查连接器的连接是否正确
    必要时设置适当的默认值
    */

    for i in 1:nSuspend loop

      assert(cardinality(suspend[i]) <= 1, 
        "Connector suspend[" + String(i) + "] of the CompositeStep is connected
to more than one transition");

      if cardinality(suspend[i]) == 0 then
        suspend[i].reset = false;

      end if;

    end for;

    for i in 1:nResume loop

      assert(cardinality(resume[i]) <= 1, 
        "Connector resume[" + String(i) + "] of the CompositeStep is connected
to more than one transition");

      if cardinality(resume[i]) == 0 then
        resume[i].set = false;

      end if;

    end for;

    /* Dymola 尚不完全支持零大小的连接器。
    如果连接器应具有零维度，则需要将连接器的维度设置为1。
    在这种情况下，还需要将连接器变量设置为默认值。
    */

    if cardinality(inPort) < 2 then
      inPort.occupied = false;
      inPort.set = false;

    end if;

    if cardinality(outPort) < 2 then
      outPort.available = false;
      outPort.reset = false;

    end if;

    // 检查inPort/outPort连接

    assert(cardinality(inPort) <= 2, 
      "CompositeStep的连接器inPort有超过2个连接。
它应该只有一个从外部到inPort的连接，以及一个从CompositeStep内部的某个步骤到inPort的连接。");

    assert(cardinality(outPort) <= 2, 
      "CompositeStep的连接器outPort有超过2个连接。
它应该只有一个从outPort到CompositeStep外部的连接，以及一个从CompositeStep内部的某个步骤到outPort连接器的连接。");

    annotation(
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-150, -150}, {150, 150}}), graphics = {
      Text(
      extent = {{-250, 160}, {250, 200}}, 
      textString = "%name", 
      textColor = {0, 0, 255}), 
      Rectangle(
      extent = {{-150, 150}, {150, -150}}, 
      fillColor = DynamicSelect({255, 255, 255}, if active then {0, 255, 0} else {255, 255, 255}), 
      fillPattern = FillPattern.Solid), 
      Text(
      extent = {{4, -115}, {145, -130}}, 
      textString = "resume"), 
      Text(
      extent = {{-144, -114}, {-3, -129}}, 
      textString = "suspend")}), 
      Diagram(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-150, -150}, {150, 150}}), graphics = {Rectangle(extent = {{-150, 150}, {150, -150}})}));
  end PartialCompositeStep;

  model StateGraphRoot 
    "状态图的根(必须出现在状态图的最高层)"

    extends StateGraph.Interfaces.CompositeStepState;
    output Integer activeSteps "状态图中的活动步数";

  equation
    activeSteps = -integer(subgraphStatePort.activeSteps);
    annotation(
      defaultComponentName = "stateGraphRoot", 
      defaultComponentPrefixes = "inner", 
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Text(
      extent = {{-200, 110}, {200, 150}}, 
      textString = "%name", 
      textColor = {0, 0, 255}), 
      Rectangle(
      extent = {{-100, 100}, {100, -100}}), 
      Text(
      extent = {{-92, 78}, {96, 34}}, 
      textString = "root"), 
      Rectangle(extent = {{-82, -6}, {-44, -40}}), 
      Line(points = {{0, 10}, {0, -60}}), 
      Rectangle(extent = {{48, -6}, {86, -40}}), 
      Polygon(
      points = {{-12, -16}, {0, -22}, {-12, -28}, {-12, -16}}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-44, -22}, {-12, -22}}), 
      Polygon(
      points = {{36, -16}, {48, -22}, {36, -28}, {36, -16}}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{0, -22}, {36, -22}})}), 
      Documentation(info = "<html><p>
在StateGraph的最高级别上，必须存在一个StateGraphRoot的实例。
</p>
<p>
StateGraphRoot对象是必需的，因为所有Step对象都具有到\"nearest\" CompositeStep(它继承自PartialCompositeStep) 的\"outer\"引用，特别是通过\"suspend\"端口中止CompositeStep。 即使没有\"CompositeStep\"存在，在最高级别也需要相应的\"inner\"定义，这由StateGraphRoot对象提供。
</p>
</html>"));
  end StateGraphRoot;

  annotation(
    Documentation(info = "<html><p>
注意，这个库有一个更加改进的版本叫做 “Modelica_StateGraph2”。 如果您的Modelica工具还没有分发这个库，您可以从以下地方下载： <a href=\"https://github.com/modelica/Modelica_StateGraph2\" target=\"\">https://github.com/modelica/Modelica_StateGraph2</a>&nbsp;。 在<a href=\"modelica://Modelica.StateGraph.UsersGuide.ComparisonWithStateGraph2\" target=\"\">Users Guide</a>&nbsp;中给出了详细的比较。 强烈建议使用Modelica_StateGraph2而不是Modelica.StateGraph。
</p>
<p>
<strong>StateGraph</strong>库是一个<strong>免费</strong>的Modelica包， 提供了一种方便的方式来建立<strong>离散事件</strong>和<strong>响应式</strong>系统模型。 它基于JGrafchart方法，并利用 Modelica 特性来支持“action”语言。 JGrafchart 是对 Grafcet 的进一步发展， 包括 StateCharts 中 Grafcet/Sequential Function Charts中不存在的元素。 因此，StateGraph库具有类似于 StateCharts 的建模能力， 但避免了StateCharts的一些缺陷。
</p>
<p>
请特别注意以下内容作为介绍：
</p>
<li>
<a href=\"modelica://Modelica.StateGraph.UsersGuide\" target=\"\">StateGraph.UsersGuide</a>&nbsp; 讨论了如何使用此库的最重要方面。</li>
<li>
<a href=\"modelica://Modelica.StateGraph.Examples\" target=\"\">StateGraph.Examples</a>&nbsp; 包含演示如何使用此库的示例。</li>
<p>
这个库生成的典型模型如下图所示。 左侧是一个带有水箱控制器的双水箱系统， 右侧显示了水箱控制器的顶层部分，以 StateGraph 形式呈现。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/StateGraph/UsersGuide/ControlledTanks1_small.png\" alt=\"\" data-href=\"\" style=\"\"/><img src=\"modelica://Modelica/Resources/Images/StateGraph/UsersGuide/ControlledTanks2_small.png\" alt=\"\" data-href=\"\" style=\"\"/>
</p>
<p>
StateGraph库相对于JGrafcharts、Grafcet、Sequential Function Charts和StateCharts的 独特之处在于Modelica的 “<span style=\"color: rgb(51, 51, 51);\">单一赋值规则</span>”，即每个变量必须由一个方程精确定义。 这导致了与这些形式化方法中不同的 “action” 定义。 其优势在于，翻译器可以通过方程排序确定有用的评估顺序，或者在不可能的情况下报告错误， 例如，因为模型可能导致非确定性或死锁。 作为副作用，这也导致了更简单、更易于理解的模型， 全局变量不再是必需的（而在JGrafcharts、Grafcet、Sequential Function Charts和StateCharts中， 几乎总是需要全局变量）。
</p>
<p>
Copyright &copy; 1998-2020，Modelica协会及其贡献者
</p>
</html>"), Icon(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}), graphics = {
    Rectangle(
    origin = {-70.0, -0.0}, 
    fillColor = {255, 255, 255}, 
    extent = {{-20.0, -20.0}, {20.0, 20.0}}), 
    Rectangle(
    origin = {70.0, -0.0}, 
    fillColor = {255, 255, 255}, 
    extent = {{-20.0, -20.0}, {20.0, 20.0}}), 
    Line(points = {{0.0, 50.0}, {0.0, -50.0}}), 
    Polygon(
    origin = {-16.6667, 0.0}, 
    pattern = LinePattern.None, 
    fillPattern = FillPattern.Solid, 
    points = {{-3.3333, 10.0}, {16.667, 0.0}, {-3.3333, -10.0}}), 
    Line(origin = {-35.0, 0.0}, points = {{15.0, 0.0}, {-15.0, 0.0}}), 
    Polygon(
    origin = {33.3333, 0.0}, 
    pattern = LinePattern.None, 
    fillPattern = FillPattern.Solid, 
    points = {{-3.3333, 10.0}, {16.667, 0.0}, {-3.3333, -10.0}}), 
    Line(origin = {15.0, -0.0}, points = {{15.0, 0.0}, {-15.0, -0.0}})}));
end StateGraph;