within Modelica;
package Fluid "基于Modelica.Media介质构建的一维热流体流动模型库"
  extends Modelica.Icons.Package;
  import Modelica.Units.SI;
  import Cv = Modelica.Units.Conversions;
  package UsersGuide "用户指南"
    extends Modelica.Icons.Information;
    class Overview "概述"
      extends Modelica.Icons.Information;
      annotation(Documentation(info = "<html><p>
Modelica.Fluid库提供了基本接口和组件，用于管网系统中一维热流体流动的建模。 本库的设计目标并非涵盖所有应用场景，这主要基于两方面考虑：一是流体流动涉及范围过于广泛；二是针对特殊应用场景可以通过更简化的组件接口开发专用库。 相反，该库（Modelica.Fluid ）的核心目标在于提供一个<strong>标准化的组件集</strong>并<strong>示范实现方式</strong>，比如展示如何在Modelica中构建流体库组件，重点解决例如连接器设计、逆向流动处理和初始化等关键难题。
</p>
<p>
本库具有以下核心功能特性：
</p>
<li>
Modelica.Fluid.Interfaces.FluidPort_a/_b 连接器专为<strong>单物质</strong>或<strong>混合物质</strong>（可选多相态）的一维流动设计。 其核心特性包括：介质兼容性，能够支持所有Modelica.Media 介质模型；维度优化，对单一物质介质，混合物质相关数组维度归零，编译时自动取消冗余数据结构； 并利用通用接口设计通过编译期优化避免特殊场景的性能损耗。<br></li>
<li>
Modelica.Fluid 库中的组件设计遵循介质兼容性最大化原则：通用兼容性，绝大多数组件（如传感器/源组件）支持所有的 Modelica.Media 介质模型；特殊限制，部分组件因物理机制需要特定介质类型（如蒸发器要求两相介质） （扩展自Modelica.Media.Interfaces.PartialTwoPhaseMedium）。 <br></li>
<li>
为了简化组件中的初始化过程，当前存在如下限制：只支持以 T（温度）、(p,T)（压力-温度）、(p,h)（压力-比焓）、(T,X)（温度-质量分数向量）、(p,T,X) （压力-温度-质量分数向量）或 (p,h,X) （压力-比焓-质量分数向量）作为自变量的介质模型。 其他类型的介质模型，例如，以（T,d）（温度-密度）为自变量的模型在理论上也是可行的，但这需要重新编写组件初始化代码。（注，T为温度，p为压力，d为密度，h为比焓，X为质量分数向量）。 <br></li>
<li>
所有组件均适用于<strong>不可压缩</strong>和<strong>可压缩</strong>介质。 若介质为不可压缩类型，则通过略微调整组件的初始化过程即可实现兼容；而对于不可压缩介质，组件的核心方程不会受此属性影响。<br></li>
<li>
所有组件均支持流体的双向流动，即<strong>允许逆向流动</strong>。但用户可选择声明组件内的流动仅遵循设计方向（如从入口到出口的单向流动），从而提升仿真代码的执行速度。<br></li>
<li>
两个或多个组件可相互连接，这意味着所有连接端口的压力相等，且质量流量总和为零（即满足质量守恒定律）。 比焓、质量分数及微量物质将根据质量流量进行混合。<br></li>
<li>
<strong>动量平衡</strong>和<strong>能量平衡</strong>仅在连接<strong>两个等径端口</strong>时才能严格满足。对于其他所有连接情况（如异径连接），由于忽略动能效应与摩擦效应，上述平衡将采用近似处理。若特定问题中动能或摩擦效应具有显著影响（例如需要精确计算动压头时），应使用显式定义的管件或接头模型。在摩擦效应主导的系统（如长管道系统）或由泵等设备决定流量的场景中，动压头通常可忽略不计，用户可参考<a href=\"modelica://Modelica.Fluid.Examples.Explanatory.MomentumBalanceFittings\" target=\"\">Modelica.Fluid.Examples.Explanatory.MomentumBalanceFittings </a>&nbsp; 模型（及其文档），该案例展示了动量平衡对动压头的依赖性，此时必须要使用显式管件模型才能获得正确的结果。 <br></li>
<li>
尽管存在上述限制，组件之间的连接方式并无硬性约束。然而，仿真性能往往高度依赖于模型结构及建模假设。具体而言，直接连接流体容积组件，通常会导致压力变量形成高阶微分代数方程（High-index DAEs）增加求解复杂度； 直接连接流动模型，通常会产生隐式非线性代数方程组，需迭代求解。 <br></li>
</html>"));
    end Overview;
    class GettingStarted "入门指南"
      extends Modelica.Icons.Information;
      annotation(Documentation(info = "<html><p>
建议优先研究 <a href=\"modelica://Modelica.Fluid.Examples\" target=\"\">示例模型库</a>&nbsp;， 其中包含覆盖多领域应用的标准化建模方案。
</p>
</html>"));
    end GettingStarted;
    package ComponentDefinition "组件定义"
      extends Modelica.Icons.Information;
      class FluidConnectors "流体连接器"
        extends Modelica.Icons.Information;
       annotation(Documentation(info="<html><p>
本节将阐述流体连接器的设计原理。
</p>
<p>
流体连接器表征设备中允许流体携带其热力学属性流入或流出组件的物理接口（例如法兰），且假设这些法兰在空间中是固定不动的。
</p>
<p>
流体连接器的主要设计目标是实现组件的任意互连，并确保当两个或多个组件在某一节点连接时（如下图所示），关键守恒方程（如质量、能量守恒）能够自动满足。
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Fluid/UsersGuide/ComponentDefinition/MixingConnections.png\" alt=\"MixingConnections.png\" data-href=\"\" style=\"\">
</p>
<p>
在此类情况下，守恒方程基于<strong>理想混合假设</strong>，即每个组件的上游离散格式采用在无限小时间段内理想混合所得到的变量值。若需要更真实地建模（考虑混合过程中的能量损失）， 则需在连接点处引入显式混合模型。
</p>
<h4>单组分介质</h4><p>
对于单组分介质，Modelica.Fluid.Interfaces.FluidPort 中的连接器定义简化为
</p>
<pre><code >connector FluidPort
replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
\"流体的介质模型\";
flow Medium.MassFlowRate m_flow
\"从连接点流入组件的质量流量\";
Medium.AbsolutePressure p
\"连接点处的热力学压力\";
stream Medium.SpecificEnthalpy h_outflow
\"如果 m_flow &lt; 0，则接近连接点的特定热力学焓\";
end FluidPort;
</code></pre><p>
第一条语句定义流经连接器的介质。 在介质包中，定义了介质特定类型，例如 \"Medium.AbsolutePressure\"， 这些类型包含介质特定的最小值(min)、最大值(max)和标准值(nominal)属性。此外，Medium.MassFlowRate 的定义方式如下：
</p>
<pre><code >type MassFlowRate = SI.MassFlowRate(
quantity = \"MassFlowRate.\" + mediumName);
</code></pre><p>
通常在当前库设计下，必须显示地为回路中的每个组件选择介质模型。该模型随后会传播到端口，Modelica编译器将检查连接接口的量纲(quantity)和单位(unit)属性是否一致。 因此，
若连接的 FluidPorts 不具有相同介质名称的介质模型，将触发错误。 <br> &nbsp; &nbsp; &nbsp; 根据 Modelica 3.4 规范，
流体模型无法直接通过端口实现自动传播， 但具体实现可由Modelica 工具支持。例如，在Dymola中，可通过设置<code>Advanced.MediaPropagation</code>=<code>1</code>启用回路中介质模型的自动传播功能。
</p>
<p>
热力学压力是一种<strong>势</strong>变量，这意味着连接两个或多个接口时，其端口压力必须相等。
</p>
<p>
质量流量是一种<strong>流</strong>变量，这意味着连接两个或多个接口时，所有流量的代数和必须为零。
</p>
<p>
最后一个变量是 <strong>stream</strong> 变量，即由流变量携带的比参数（如比焓、浓度）。无论实际流向如何，连接器上的量始终对应于假设流体流出连接点时接近连接点的值。 
这种机制可避免质量流量过零时出现奇异性。另一流动方向的流属性可通过内置运算符 inStream(..) 获取， 
而实际流动方向的流属性则可以通过内置运算符 <a href=\"https://specification.modelica.org/v3.4/Ch15.html#stream-operator-actualstream\" target=\"\">actualStream(..) </a>&nbsp; &nbsp;获取。
</p>
<p>
<span style=\"color: rgb(31, 35, 40);\"> &nbsp; &nbsp; &nbsp; 这些运算符对应的实际方程由工具自动引入并求解。从原理上，它们应用于连接端口组的平衡方程：
sum(flow_variable) = 0 和 sum(flow_variable*stream_variable_at_connection) = 0。 
具体而言，第一个方程是质量守恒方程 sum(m_flow) = 0， 第二个方程是连接点的能量守恒方程 sum(m_flow*h_connection) = 0。</span>
</p>
<p>
在端口 <span style=\"color: rgb(51, 51, 51);\">port_a </span>和 <span style=\"color: rgb(51, 51, 51);\">port_</span>b 一对一连接的简单场景中，
inStream(port_a.h_outflow)直接返回 port_b.h_outflow。 
对于多向连接的情况，工具将生成混合方程，并特别处理零流量附近的不连续性。 更多技术细节可参考相关
<a href=\"modelica://Modelica/Resources/Documentation/Fluid/Stream-Connectors-Overview-Rationale.pdf\" target=\"\">演示文稿</a>&nbsp; &nbsp;，
其中详细阐述了流属性(stream)的设计原理与底层实现机制。
</p>
<p>
连接器应仅包含描述接口所需的最少变量集，否则在某些场景下将引发连接约束。因此，连接器中不存在冗余变量，例如，温度 T 未被显示声明，因其可以通过连接器变量压力 p 与比焓 h 计算获得。
</p>
<p>
以下通过两个简单的示例阐释流连接器的建模方法。第一个示例为混合两股流体的刚性绝热容积模型，在能量平衡方程中为简化分析将动能项与重力项予以忽略。
</p>
<pre><code >model MixingVolume \"混合两股流动的容积\"
import Modelica.Units.SI;
replaceable package Medium = Modelica.Media.Interfaces.PartialPureSubstance;
FluidPort port_a(redeclare package Medium = Medium) \"流体连接器a\";
FluidPort port_b(redeclare package Medium = Medium) \"流体连接器b\";
parameter SI.Volume V \"设备的体积\";
SI.Mass             m \"设备中的质量\";
SI.Energy           U \"设备内的内能\";
Medium.BaseProperties medium(preferredMediumStates=true) \"设备中的介质\";
equation
// 定义接口变量
port_a.p         = medium.p;
port_b.p         = medium.p;
port_a.h_outflow = medium.h;  // 如果 m_flow &lt; 0，则流变量始终对应于
port_b.h_outflow = medium.h;  // 流体保持量（流出）的属性

// 总量
m = V*medium.d;
U = m*medium.u;
// 质量与能量守恒（actualStream(..) 是流变量 Stream 的内置运算符，根据流动方向计算正确的焓值h）
der(m) = port_a.m_flow + port_b.m_flow;
der(U) = port_a.m_flow*actualStream(port_a.h_outflow) +
port_b.m_flow*actualStream(port_b.h_outflow);
end MixingVolume;
</code></pre><p>
第二个示例是描述两个端口间集总压力损失的组件模型，无能量储存和热传递。假设为等焓变换（忽略入口与出口间的动能和势能变化）。
</p>
<pre><code >model PressureLoss \"压力损失组件\"
replaceable package Medium = Modelica.Media.Interfaces.PartialPureSubstance;
FluidPort port_a(redeclare package Medium = Medium) \"流体连接器a\";
FluidPort port_b(redeclare package Medium = Medium) \"流体连接器b\";
Medium.ThermodynamicState port_a_state_inflow \"流入时 port_a 的状态\";
Medium.ThermodynamicState port_b_state_inflow \"流入时 port_b 的状态\";
Medium.Density d_a \"port_a 处的密度（若处于流入状态）\";
Medium.Density d_b \"port_b 处的密度（若处于流入状态）\";
replaceable function f = SomeSpecificMassFlowFunction
\"质量流量计算函数\";
equation
// 流入流体的介质状态
port_a_state_inflow = Medium.setState_phX(port_a.p, inStream(port_a.h_outflow));
port_b_state_inflow = Medium.setState_phX(port_b.p, inStream(port_b.h_outflow));
// 质量守恒
0 = port_a.m_flow + port_b.m_flow;
// 在等焓状态变化（无能量储存和损失）条件下，焓流在端口间的瞬时传递
port_a.h_outflow = inStream(port_b.h_outflow);
port_b.h_outflow = inStream(port_a.h_outflow);
// （正则化的）动量平衡
port_a.m_flow = f(port_a.p - port_b.p, d_a, d_b);
end PressureLoss;
</code></pre><p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">如果多个这样的组件串联在两个具有存储功能的模型之间，特定焓值会在两个方向上传播， 并可供所有压力损失组件使用，
即使质量流量通过零值时也不会出现问题。函数f则根据端口a和端口b之间的压力差（port_a.p - port_b.p）的符号选择使用d_a或d_b，并在零附近进行适当的正则化以避免不连续性。</span>
</p>
<p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\"> &nbsp; &nbsp; &nbsp;请注意，这些模型是高度理想化的，旨在解释流连接器的概念。库中的设备模型则更加完整，
能够处理诸如初始化、稳态与动态建模、外部传热等问题</span>。
</p>
<h4>多组分介质</h4><p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">Modelica.Fluid 能够处理包含多种物质的流体模型，因此其组成可以通过质量分数向量来表征</span>。
</p>
<pre><code >connector FluidPort
replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
\"流体的介质模型\";
flow Medium.MassFlowRate m_flow
\"从连接点流入组件的质量流量\";
Medium.AbsolutePressure p
\"连接点的热力学压力\";
stream Medium.SpecificEnthalpy h_outflow
\"如果质量流量 m_flow &lt; 0，连接点附近的特定热力学焓值将按此条件处理\";
stream Medium.MassFraction Xi_outflow[Medium.nXi]
\"如果质量流量 m_flow &lt; 0，连接点附近的独立混合物质量分数 m_i/m 将按此条件处理\";
stream Medium.ExtraProperty C_outflow[Medium.nC]
\"如果质量流量 m_flow &lt; 0，连接点附近的属性 c_i/m 将按此条件处理\";
end FluidPort;
</code></pre><p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">质量分数向量 Xi 和 C 也是流体的流变量，因为它们是随质量流量一起传输的。 相应的连接方程为 sum(m_flow * Xi) 和 sum(m_flow * C)，
这些方程对应于各单一物质的质量平衡。向量 Xi 包含流体主要成分的质量分数，并与压力 p 和焓 h 一起用于确定流体的热力学状态。 向量 C 包含微量成分的质量分数，这些微量成分在质量平衡中被考虑，但在计算流体性质时被忽略。
这使得可以从现有的介质模型轻松声明和使用含有微量成分的介质模型（例如，在湿空气中添加 CO2 微量成分以用于空调模型）</span>。
</p>
<h4>连接点平衡方程中的近似</h4><p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">综上所述，当两个或多个类型为 FluidPort 的端口连接时，工具会生成以下方程</span>：
</p>
<pre><code >sum(port_j.m_flow) = 0;               // 总质量平衡
port_j = port_k;                      // 动量平衡
sum(port_j.m_flow*h_connection) = 0;  // 能量平衡
sum(port_j.m_flow*Xi_connection) = 0; // 单组分质量平衡
sum(port_j.m_flow*C_connection) = 0;  // 微量组分质量平衡
</code></pre><p>
需要<strong>重点</strong>牢记
</p>
<li>
质量平衡始终是精确的；</li>
<li>
<span style=\"font-size: 16px;\">动量和能量平衡只有在两个相同直径的端口连接时才是精确的，因为此时没有摩擦且流体速度不变。</span></li>
<p>
在其他所有情况下，即不同直径和/或多个接口连接时：
</p>
<li>
动量平衡不考虑摩擦效应和因速度变化而引起的压力变化。</li>
<li>
因此，动量平衡中可能会出现与动压 ρv<sup>2</sup>/2 同数量级的误差。</li>
<li>
能量平衡不考虑动能项（由于连接体积的无限小，重力项相互抵消）。因此，动量平衡中可能存在与动能 v^2/2 同数量级的误差。</li>
<p>
在许多应用中，当流体速度较低且主要关注热现象时，<span style=\"font-size: 16px;\">这些近似处理通常被采用，并能得出可接受的结果</span>。 
在所有其他情况下，应使用显示的接头和连接模型，以适当的详细程度对动力学现象进行精确建模。
</p>
</html>"      ));
      end FluidConnectors;

      class BalanceEquations "平衡方程"
        extends Modelica.Icons.Information;
        annotation(Documentation(info="<html><p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\"> </span><span style=\"font-size: 16px;\">对于沿坐标“x”的一维流动，存在以下偏微分方程</span>
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 质量平衡</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">
<img src=\"modelica://Modelica/Resources/Images/Fluid/UsersGuide/ComponentDefinition/massBalance.png\" alt=\"massBalance.png\" data-href=\"\" style=\"\"/>
</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 动量平衡</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 
<img src=\"modelica://Modelica/Resources/Images/Fluid/UsersGuide/ComponentDefinition/momentumBalance.png\" alt=\"momentumBalance.png\" data-href=\"\" style=\"\"/>
</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 能量平衡 1</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 
<img src=\"modelica://Modelica/Resources/Images/Fluid/UsersGuide/ComponentDefinition/energyBalance1.png\" alt=\"energyBalance1.png\" data-href=\"\" style=\"\"/>
</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 管道摩擦</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 
<img src=\"modelica://Modelica/Resources/Images/Fluid/UsersGuide/ComponentDefinition/pipeFriction.png\" alt=\"pipeFriction.png\" data-href=\"\" style=\"\"/>
</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">x：独立空间坐标（流动沿坐标x）<br><br>t：时间<br><br>v(x,t)：
平均速度<br><br>p(x,t)：平均压力<br><br>T(x,t)：平均温度<br><br>ρ(x,t)：平均密度<br><br>u(x,t)：比内能<br><br>z(x)：地面以上高度<br><br>A(x)：垂直于x方向的面积<br><br>g：
重力常数<br><br>f：法宁摩擦因子<br><br>S：周长</td></tr></tbody></table><p>
将动量平衡乘以 \"v\"，再从上述能量平衡 1 中减去 \"v\"，即可得出另一种能量平衡。即 \"能量平衡 2\"：
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 能量平衡 2</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 
<img src=\"modelica://Modelica/Resources/Images/Fluid/UsersGuide/ComponentDefinition/energyBalance2.png\" alt=\"energyBalance2.png\" data-href=\"\" style=\"\"/>
</td></tr></tbody></table><p>
该表述将流体的内部能量与流体流动的动能分开。 内部能量由能量平衡 2 处理，动能同样由动量平衡处理。 能量平衡 2 简化了与动能无关的介质特性评估和许多流体模型的表述。
通过考虑能量平衡和动量平衡之间的相互依存关系，实现了能量的整体守恒。
</p>
<p>
库中的某些组件，如DynamicPipe，使用能量平衡 2 方程实现了对质量、动量和能量的严格守衡。其他组件，如 Valves 和 Fittings，忽略了动能和势能变化对能量平衡的影响，因为它们通常与热流变化相比不重要。
StaticPipe 组件忽略了动能的影响，但在平衡中包含了可能很大的势能。
</p>
<p>
所有建模假设和简化均在组件文档中说明；请注意，一些假设可能在组件继承的基类中说明。
</p>
</html>"      ));
      end BalanceEquations;

      class UpstreamDiscretization "上游离散化"
        extends Modelica.Icons.Information;
        annotation(Documentation(info = "<html><p>
在执行流体组件时，会遇到一个难题，即密集量（如 p、T、ρ）的值应该从<strong>上游</strong>体积中获取。
例如，如果流体从容积 A 流向容积 B，则容积 B 的密集量对两个容积之间的流体没有影响。另一方面，如果流动方向颠倒，则容积 A 的密集量对两个容积之间的流体没有影响。
</p>
<p>
在 Modelica.Fluid 库中，使用以下代码片段处理这种情况 （来自 Interfaces.PartialTwoPortTransport）：
</p>
<pre><code >replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
annotation(choicesAllMatching = true);

Interfaces.FluidPort_a port_a(redeclare package Medium = Medium);
Interfaces.FluidPort_b port_b(redeclare package Medium = Medium);

Medium.ThermodynamicState port_a_state_inflow
\"流入质量流的 port_a 附近的介质状态\";
Medium.ThermodynamicState port_b_state_inflow
\"流入质量流的 port_b 附近的介质状态\";

equation
// 等焓状态转换（无能量存储和能量损失）
port_a.h_outflow  = inStream(port_b.h_outflow);
port_b.h_outflow  = inStream(port_a.h_outflow);

port_a.Xi_outflow = inStream(port_b.Xi_outflow);
port_b.Xi_outflow = inStream(port_a.Xi_outflow);

// 质量平衡
port_a.m_flow + port_b.m_flow = 0;

// 流入介质的介质状态
port_a_state_inflow = Medium.setState_phX(port_a.p, port_b.h_outflow, port_b.Xi_outflow);
port_b_state_inflow = Medium.setState_phX(port_b.p, port_a.h_outflow, port_a.Xi_outflow);

// 当质量流入到各个接口时的密度
port_a_rho_inflow = Medium.density(port_a_state_inflow);
port_b_rho_inflow = Medium.density(port_b_state_inflow);

// 压降关联（k_ab、k_ba 是两个流动方向的损失因子；例如，对于一个圆形装置：k = 8*zeta/(pi*diameter)^2)^2)
m_flow = Utilities.regRoot2(port_a.p - port_b.p, dp_small,
port_a_rho_inflow/k1, port_b_rho_inflow/k2);
</code></pre><p>
流入介质的介质状态可用于计算密度和动力黏度，进而可用于建立压降方程。 不能使用标准的压降方程
</p>
<pre><code >dp = port_a - port_b;
m_flow = sqrt(2/(zeta*diameter))*if dp &gt;= 0 then  sqrt(dp)
else -sqrt(-dp)
</code></pre><p>
因为该函数在 dp=0 处有无穷导数。因此，必须使用 Modelica.Fluid.Utilities 的一种正则化函数来对零质量流量附近区域进行正则化。 
这需要同时具有两个方向的密度和/或其他介质属性。这些介质属性可以从两个接口处的流入流体的介质状态计算得到。
</p>
<p>
如果上述组件连接在两个容积之间，即 port_a 和 port_b 中的独立介质变量通常是状态，那么 port_a.h 和 port_b.h 要么是状态（即模型中的已知量），
要么是根据状态计算出来的。无论哪种情况，它们都是 \"已知 \"的。在这种情况下，所有方程都可以直接计算，不会有任何问题。 
零质量流量或反向质量流量不会造成任何问题，因为介质特性总是在两个流动方向上计算得出，然后用于正则化函数。
</p>
<p>
如果连接了 3 个或更多个组件，则可以证明出现了一个非线性代数方程组。 这些方程被有意地写成这样的形式，以便工具可以选择质量流速和压力作为此系统的迭代变量。
其优势在于这些迭代变量是连续的，甚至常常是可微的。 使用介质状态作为迭代变量的替代方法不好，因为对于反向流动，T、h、d 是不连续的。
</p>
</html>"      ));
      end UpstreamDiscretization;

      class RegularizingCharacteristics "正则化特性"
        extends Modelica.Icons.Information;
        annotation(Documentation(info = "<html><p>
压力降方程和其他流体特性通常由<strong>半经验</strong>公式进行计算。然而遗憾的是，半经验公式的开发者几乎从未考虑过这些方程可能会在仿真程序中使用。
因此，这些半经验公式几乎无法直接套用，必须稍加修改或调整，以避免出现明显的仿真问题。<span style=\"color: rgba(0, 0, 0, 0.9); 
font-size: 16px;\">下文将通过示例说明可能产生的问题及特性正则化方法</span>：
</p>
<h4>平方根函数</h4><p>
在多个经验公式中，存在以下形式的表达式，例如用于管道湍流工况的压降计算：
</p>
<pre><code >y = if x &lt; 0 then -sqrt( abs(x) ) else sqrt(x)
</code></pre><p>
下图显示了此特性的图表：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Fluid/UsersGuide/ComponentDefinition/sqrt.png\" alt=\"sqrt.png\" data-href=\"\" style=\"\">
</p>
<p>
这个函数在 x=0 处的导数是无穷大。而在现实中，这样的函数是不存在的。例如，对于管道流动，当速度很小时流动变为层流，因此在零点附近，sqrt() 函数被线性函数替代。
由于层流区域通常没有太大的实际意义，因此采用了上述近似值。
</p>
<p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">上述直接实现方式在Modelica中无法正常工作，因为当x&lt;0的符号变化时会触发事件</span>。
为了检测此事件，<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">系统会执行事件迭代。在事件迭代过程中，当前活动的if分支不会改变</span>。
例如，假设 x 为正数（即处于\"else \"分支），且将变为负数。在事件迭代过程中，x 会略微为负，但仍会执行\"else \"分支，即计算sqrt(x)。
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">由于此时计算结果为虚数，将导致错误</span>。可以通过 <strong>noEvent</strong>() 操作符显示关闭事件检测来解决此问题：
</p>
<pre><code >y = if noEvent(x &lt; 0) then -sqrt( abs(x) ) else sqrt(x)
</code></pre><p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">尽管如此，优质积分器在x=0附近仍可能表现不佳，因为它们会检测到导数在此处发生剧烈变化，从而大幅缩减积分步长</span>。
</p>
<p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">针对此问题存在多种解决方案：在x=0附近区域，可将sqrt()函数替换为三阶多项式。
该多项式的构造需满足与sqrt()函数平滑衔接，即整体函数保持连续且一阶导数连续。在Modelica.Fluid库中，此类关键函数的实现位于子库Modelica.Fluid.Utilities内。
上述sqrt()类函数通过Utilities.regRoot()函数计算，其定义如下</span>：
</p>
<pre><code >y := x/(x*x+delta*delta)^0.25;
</code></pre><p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">其中\"delta\"定义了零点附近用于替代sqrt()函数的小区域范围。该函数的曲线形态与原函数几乎完全一致，
但其在x=0处具有有限导数，且可无限次微分。当采用默认值delta=0.01时，该函数与regRoot(x)在x=0.01附近的差异约为16%，在x=0.1处差异降至0.25%，在x=1处差异仅为0.0025%</span>。
</p>
</html>"      ));
      end RegularizingCharacteristics;

      class WallFriction "壁面摩擦"
        extends Modelica.Icons.Information;
        annotation(Documentation(info = "<html><p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">在压力损失分析中，一个重要的特例是准稳态流动假设下（即质量流量变化缓慢）的管壁摩擦阻力。
本节将阐述Modelica.Fluid库如何处理</span><span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\"><strong>非均匀粗糙度</strong></span>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">管道的此类问题</span>，其中包括光滑管道作为特例
（请参阅 <a href=\"modelica://Modelica.Fluid.Pipes.BaseClasses.WallFriction\" target=\"\">Pipes.BaseClasses.WallFriction</a>&nbsp; &nbsp;）。
为实现数值适定描述，该处理方法采用了非标准化的建模策略。
</p>
<p>
对于圆形截面的管道，其压降计算公式如下：
</p>
<pre><code >dp = λ(Re,Δ)*(L/D)*ρ*v*|v|/2
= λ(Re,Δ)*8*L/(π^2*D^5*ρ)*m_flow*|m_flow|
= λ2(Re,Δ)*k2*sign(m_flow);

其中Re     = |v|*D*ρ/μ
= |m_flow|*4/(π*D*μ)
m_flow = A*v*ρ
A      = π*(D/2)^2
λ2     = λ*Re^2
k2     = L*μ^2/(2*D^3*ρ)
</code></pre><p>
其中
</p>
<li>
L 是管道的长度。</li>
<li>
D 是管道的直径。如果管道的截面非圆形，则 D = 4*A/P，其中 A 是横截面积，P 是湿周。</li>
<li>
λ = λ(Re,Δ) 是\"常规\"壁摩擦系数。</li>
<li>
λ2 = λ*Re^2 是用于获得数值计算良好的摩擦系数。</li>
<li>
Re = |v|*D*ρ/μ 是雷诺数。</li>
<li>
Δ = δ/D 是相对粗糙度，其中 \"δ\" 是绝对\"粗糙度\"，即管道中凹凸的平均高度 (δ 可能会随时间而变化，因为在使用过程中凹凸表面可能增长，
参见 <em>[Idelchik 1994, p. 85, Tables 2-1, 2-2])</em>。</li>
<li>
ρ 是上游密度。</li>
<li>
μ 是上游动力黏度。</li>
<li>
v 是平均速度。</li>
<p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">采用含λ的第一种形式常见于教科书</span>， 参见下图中的“蓝色”曲线：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Fluid/Pipes/BaseClasses/PipeFriction1.png\" alt=\"PipeFriction1\" data-href=\"\" style=\"\">
</p>
<p>
该种形式不适用于仿真程序，因为当雷诺数 Re &lt; 2000，则λ = 64/Re，<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">即当质量流量为零时（此时Re=0）会出现除零错误</span>。 
对于仿真模型而言，<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">摩擦系数λ2 = λ</span><span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\"><em>Re²更为实用，
因为在Re &lt; 2000时λ2 = 64</em></span><span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">Re，从而避免了零质量流量下的数值问题。λ2的特性如下图所示，并被应用于Modelica.Fluid库</span>：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Fluid/Pipes/BaseClasses/PipeFriction2.png\" alt=\"PipeFriction2\" data-href=\"\" style=\"\">
</p>
<p>
压力损失特性分为三个区域：
</p>
<li>
<strong>区域 1</strong>: 当雷诺数 <strong>Re ≤ 2000</strong>，流动为<strong>层流</strong>，在稳态流动、恒定压力梯度、恒定密度和黏度的假设条件下<span style=\"color: rgba(0, 0, 0, 0.9); 
font-size: 16px;\">（即Hagen-Poiseuille流动）</span>，采用了 3 维 Navier-Stokes 方程（动量和质量平衡）的精确解，推导得 λ2 = 64*Re。<br></li>
<li>
<strong>区域 3</strong>: 当雷诺数 <strong>Re ≥ 4000</strong>，流动进入<strong>湍流状态</strong>。 
根据计算方向（<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">参见下文\"逆向公式\"</span>），<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">
将选用两种显式方程之一</span>。若压降 dp已知，则 λ2 = |dp|/k2。Colebrook-White 方程 <em>[Colebrook 1939; Idelchik 1994, p. 83, eq. (2-9)] </em>: &nbsp;给出了 Re 和 λ 之间的隐式关系。
通过代入 λ2 = λ*Re^2 可以对 Re 进行分析求解， 最终，质量流量 m_flow通过 m_flow = Re*π*D*μ/4*sign(dp) &nbsp;计算得出。 <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">
上述图中的</span><span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\"><strong>红色</strong></span><span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">曲线即对应此方法</span>。
<br> 如果假设已知质量流量（因此雷诺数Re也隐式确定），<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">则通过适用于λ2的</span> Colebrook-White 方程<span style=\"color: rgba(0, 0, 0, 0.9); 
font-size: 16px;\">逆函数近似式</span><em>[Swamee and Jain 1976; Miller 1990, p. 191, eq.(8.4)]</em>，计算 λ2： 随后通过公式 dp = k2*λ2*sign(m_flow)计算压降。
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">上述图中的</span><span style=\"color: rgba(0, 0, 0, 0.9); 
font-size: 16px;\"><strong>蓝色</strong></span><span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">曲线即对应此方法</span>。<br></li>
<li>
<strong>区域 2</strong>: <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">当雷诺数处于</span> <strong>2000 ≤ Re ≤ 4000</strong>区间时，
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">流动处于层流与湍流之间的过渡区域。此时λ2的取值不仅取决于雷诺数和相对粗糙度，还受其他复杂因素影响，因此该区域仅能采用粗略的近似方法进行估算</span>。</li>
<p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">层流区域的偏离程度与相对粗糙度相关。只有当管道光滑时，才能在Re=2000时维持层流状态</span>。
根据 <em>[Samoilenko 1968; Idelchik 1994, p. 81, sect. 2.1.21]</em> <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">偏离雷诺数Re1的计算公式为：
该公式对应上图中的</span><span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\"><strong>蓝色</strong></span><span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">曲线</span>。
<br> <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">在Re1=Re1(δ/D)至Re2=4000的过渡区间内，λ2通过在\"lg(λ2) - lg(Re)\"坐标系中采用三次多项式进行近似（参见上图），
确保该多项式在Re1和Re2处的一阶导数连续。为避免求解</span>非线性方程<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">，针对正向公式（已知压降求流量）和逆向公式（已知流量求压降）分别采用不同的三次多项式。
这会导致λ2的计算结果存在微小差异（即红蓝曲线间的偏差）。该处理方式具有合理性，因为过渡区流动特性本身存在不确定性（实际摩擦系数受多因素影响），且实际工程中的运行工况通常不处于该区域</span>。
</p>
<p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">绝对粗糙度δ通常需通过经验估算</span>。 <em>[Idelchik 1994, pp. 105-109, Table 2-5; Miller 1990, p. 190, Table 8-1]</em> 
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">中列举了多种材料的典型值。简要归纳如下</span>：
</p>
<table style=\"width: 100%;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>光滑管道</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">拉制黄铜，铜，铝，玻璃等材料
</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">δ = 0.0025 mm</td></tr><tr><td colSpan=\"1\" rowSpan=\"3\" width=\"auto\"><strong>钢管</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">新光滑管道</td>
<td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">δ = 0.025 mm</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">砂浆衬里，表面处理一般</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">δ = 0.1 mm</td>
</tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">
严重生锈</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">δ = 1 mm</td></tr><tr><td colSpan=\"1\" rowSpan=\"3\" width=\"auto\"><strong>混凝土管</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">钢模板，顶级工艺</td>
<td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">δ = 0.025 mm</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">钢模板，一般工艺</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">δ = 0.1 mm</td></tr><tr>
<td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">块状衬里</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">δ = 1 mm</td></tr></tbody></table><p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">上述方程适用于不可压缩流动。对于马赫数Ma ≤ 0.6的可压缩流动（Ma为马赫数），该方程仍可适用，此时λ值的最大误差约为3%。对于更广泛区域内的气体压缩性影响，
可采用Voronin提出的公式进行修正</span><em>[Voronin 1959; Idelchik 1994, p. 97, sect. 2.1.81]</em>：
</p>
<pre><code >λ_comp = λ*(1 + (κ-1)/2 * Ma^2)^(-0.47)
</code></pre><p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">式中，κ为等熵指数（对于理想气体，κ等于定压比热容cp与定容比热容cv的比值）。仅在狭窄的跨音速区域以及超音速流速条件下（此时λ_comp系数约降低15%）才会观察到显著的压缩性影响
</span><em>[Idelchik 1994, p. 97, sect. 2.1.81]</em>。 <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">当前版本的Modelica.Fluid库尚未包含该修正项。此外需注意，现有压降模型仅适用于稳态或质量流量缓变工况。当流体加速度较大时，压降还会受质量流量变化频率的影响</span>。
</p>
<h4>逆向公式</h4><p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">在\"高级设置\"菜单中，可通过参数\"from_dp\"选择压降方程的实际计算形式（</span><span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\"><strong>默认值</strong></span><span style=\"color: rgba(0, 0, 0, 0.9); 
font-size: 16px;\">为from_dp =</span><span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\"><strong> true</strong></span><span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">）</span>：
</p>
<pre><code >from_dp = true:   m_flow = f1(dp)
= false:  dp     = f2(m_flow)
</code></pre><p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">当需要求解逆向压降函数时，设置\"from_dp\"参数可有效避免非线性方程组的求解</span>。
</p>
<h4>总结</h4><p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">管道壁面摩擦压降模型以两种形式提供：m_flow = f1(dp, Δ)（已知压降求流量）或dp = f2(m_flow, Δ)（已知流量求压降）。该模型具有连续可导特性，
采用显式表达式无需迭代求解</span>非线性方程<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">，且在低质量流量工况下仍能保持良好收敛性。该压降模型既可作为独立模块用于静态动量平衡分析，
也可作为摩擦压降项嵌入动态动量平衡方程。其适用范围涵盖不可压缩流动及马赫数Ma ≤ 0.6的可压缩流动。</span>小质量流速下也能表现良好。该压力降模型可单独用于静态动量平衡，也可作为摩擦压力降项用于动态动量平衡。
它适用于马赫数不超过 0.6 的不可压缩和可压缩流动。
</p>
<h4>参考文献</h4><p>
Colebrook F. (1939):
</p>
<p>
<strong>Turbulent flow in pipes with particular reference to the transition region between the smooth and rough pipe laws</strong>.<br> &nbsp; &nbsp; J. Inst. Civ. Eng. no. 4, 14-25.
</p>
<p>
Idelchik I.E. (1994):
</p>
<p>
<a href=\"http://www.bookfinder.com/dir/i/Handbook_of_Hydraulic_Resistance/0849399084/\" target=\"\"><strong>Handbook of Hydraulic Resistance</strong></a>&nbsp; &nbsp;. 3rd edition, Begell House, ISBN 0-8493-9908-4
</p>
<p>
Miller D. S. (1990):
</p>
<p>
<strong>Internal flow systems</strong>.<br>2nd edition. Cranfield:BHRA(Information Services).
</p>
<p>
Samoilenko L.A. (1968):
</p>
<p>
<strong>Investigation of the Hydraulic Resistance of Pipelines in the Zone of Transition from Laminar into Turbulent Motion</strong>.<br> &nbsp; &nbsp;Thesis (Cand. of Technical Science), Leningrad.
</p>
<p>
Swamee P.K. and Jain A.K. (1976):
</p>
<p>
<strong>Explicit equations for pipe-flow problems</strong>.<br> &nbsp; &nbsp; Proc. ASCE, J.Hydraul. Div., 102 (HY5), pp. 657-664.
</p>
<p>
Voronin F.S. (1959):
</p>
<p>
<strong>Effect of contraction on the friction coefficient in a turbulent gas flow</strong>.<br> &nbsp; &nbsp; &nbsp; Inzh. Fiz. Zh., vol. 2, no. 11, pp. 81-85.
</p>
</html>"      ));
      end WallFriction;

      class ValveCharacteristics "阀门特性"
        extends Modelica.Icons.Information;
        annotation(Documentation(info = "<html><p>
<a href=\"modelica://Modelica.Fluid.Valves\" target=\"\">Modelica.Fluid.Valves</a>&nbsp; &nbsp;<span style=\"color: rgba(0, 0, 0, 0.9);
font-size: 16px;\">模块中的控制阀参数Kv与Cv被定义为无量纲量，但在参数描述中仍标注了单位。这种处理方式的原因如下</span>：
</p>
<p>
阀门的基本方程是：
</p>
<pre><code >q = Av*sqrt(dp/rho)
</code></pre><p>
在国际单位制中，[q] 的单位是 m3/s，[dp]的单位 是 Pa，[rho] 的单位是 [kg/m3]，而 Av 是流通面积（单位<span style=\"color: rgba(0, 0, 0, 0.9); 
font-size: 16px;\">m²</span>）。<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">该方程本质上源于伯努利定律，其中Av约为阀喉面积的1.4倍。
实际应用中，阀喉面积通常远小于平方米量级——根据具体工况，其范围一般在数平方毫米至数平方厘米之间。因此，工程实践中常采用以下简化公式</span>：
</p>
<p>
欧洲：
</p>
<pre><code >q = Kv sqrt(dp/(rho/rho0))，其中 [q] = m3/h，[dp] = bar
</code></pre><p>
美国：
</p>
<pre><code >q = Cv sqrt(dp/(rho/rho0))，其中 [q] = USG/min，[dp] = psi
</code></pre><p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">上述两种情况下，rho0均指4℃冷水的密度（999 kg/m³）。需注意，这些方程中使用的是相对密度（相对于rho0），
而非绝对密度值</span>。
</p>
<p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">由此可得</span>，Kv = 1e6/27.7*Av，Cv = 1e6/24*Av，<span style=\"color: rgba(0, 0, 0, 0.9); 
font-size: 16px;\">尽管美国和欧洲工程师使用的公式不同，但得益于系数巧合（1e6/27.7 ≈ 36,100，1e6/24 ≈ 41,667），两者计算得到的Kv和Cv数值在典型工业应用场景中
（通常为几十至几百单位）差异较小，因此双方工程师均能接受该参数体系</span>。
</p>
<p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">当前存在两个问题。首先，根据单位制不同，方程形式会发生变化：采用SI单位制时使用绝对密度，
而采用非SI单位制时则使用相对密度。因此，Av与Cv/Kv的物理量纲（而不仅仅是单位！）存在本质差异</span>。
</p>
<p>
其次，Kv 和 Cv 的单位通常标记为\"m3/h\"和\"USG/min\"，<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">
但根据上述方程可知其实际量纲应为m³/(h·√bar)和USG/(min·√psi)。例如，某阀门标称Kv=10 m³/h，其物理含义为\"在1 bar压降下可流通10 m³/h\"。
尽管从严格量纲分析角度，这种单位表示法存在理论缺陷（如未体现压力平方根关系），但工程实践中普遍接受省略√Pa或√bar的简化标注方式。</span>
</p>
<p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">您可能认为这种处理方式有悖常理（确实如此，尤其在向他人解释时），
但实际情况是，任何阀门样本或技术资料中均不会以平方米为单位提供流通系数Av。即便在欧洲，Cv仍是最常用的参数，其次为Kv。
因此，若要求用户以平方米为单位输入Av，将极大降低参数输入的便捷性</span>。
</p>
<p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">Modelica.Fluid.ControlValves模块采用了一种实用化处理策略：承认Cv与Kv参数的实际单位并非m³/h或USG/min，
因此无法直接利用常规单位转换机制。在接口设计上，将Cv/Kv定义为无量纲系数，仅在参数注释中保留\"m³/h\"等标识作为辅助记忆标签，同时在模型内部通过合理量纲的转换公式实现单位标准化处理。</span>
</p>
</html>"      ));
      end ValveCharacteristics;

      annotation(Documentation(info = "<html><p>
 &nbsp; &nbsp; &nbsp;本节阐述了 Modelica.Fluid 库中组件的实现机制。 若需要在 Modelica.Fluid 库或自定义库中引入新组件，开发者需要特别关注本节讨论的关键问题。
</p>
<p>
本节部分内容基于以下论文：
</p>
<p>
Elmqvist H., Tummescheit H., and Otter M.:
</p>
<p>
<strong>Object-Oriented Modeling of Thermo-Fluid Systems</strong>.<br> &nbsp; Modelica 2003 Conference, Linköping, Sweden,<br> &nbsp; pp. 269-286, Nov. 3-4, 2003.<br> &nbsp; 下载链接:<br> &nbsp; <a href=\"https://www.modelica.org/events/Conference2003/papers/h40_Elmqvist_fluid.pdf\" target=\"\">https://www.modelica.org/events/Conference2003/papers/h40_Elmqvist_fluid.pdf</a>&nbsp;<br>请注意，连接器的设计相较于论文中所述版本已进行变更。<br>
</p>
</html>"));
    end ComponentDefinition;

    package BuildingSystemModels "构建系统模型"
      extends Modelica.Icons.Information;
      class SystemComponent "系统组件"
        extends Modelica.Icons.Information;
        annotation(Documentation(info = "<html><p>
Modelica.Fluid 库的设计要求系统的每个模型都必须在顶层包含一个 <code>System</code> 组件的实例，
就像 多体（MultiBody ）库的 <code>World</code> 模型一样。该System 组件包含描述组件所处环境的关键参数（如环境压力、温度和重力加速度），
并为库中模型提供统一使用的默认参数设置。<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">
这些参数通过inner/outer变量机制传递至各子组件。对于分层结构的系统模型，可选择在顶层仅放置单个System组件，或在多个层级设置不同System组件，
此时各组件仅影响其所在层级及以下层级的子系统</span>。
</p>
<p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">System模型中定义的所有参数将作为系统内各组件参数的默认值。
需注意，用户始终可以通过在特定组件实例中重新设定参数值，实现对该组件参数的本地化覆盖</span>。
</p>
<li>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">在System模型的\"通用\"选项卡中，可集中设置所有组件默认使用的环境变量
（压力、温度及重力加速度）</span>。</li>
<li>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">在System模型的\"假设条件\"选项卡中，可统一修改所有组件默认采用的建模假设</span>
（请参阅后面的 <em>自定义系统模型</em> 部分）。</li>
<li>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">在System模型的\"初始化\"选项卡中，可定义模型中质量流量、压力及温度的默认初始值。
通过为涉及此类变量的非线性方程组提供合理的初始猜测值，有助于提升非线性求解器的收敛性</span>。</li>
<li>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">在System模型的\"高级\"选项卡中，包含部分组件高级设置参数的默认值</span>。</li>
<p>
切记<strong>在系统模型的顶层添加一个 System 组件</strong>，<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">否则模型编译时将报错</span>。
工具会自动将其命名为 <code>system</code>，<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">确保所有其他组件均可识别该组件</span>。
</p>
</html>"        ));
      end SystemComponent;

      class MediumDefinition "定义介质模型"
        extends Modelica.Icons.Information;
        annotation(Documentation(info = "<html><p>
Modelica.Fluid 中的所有模型均通过 Modelica.Media 包定义的介质模型计算流体属性。<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">
用户亦可自定义流体模型</span>，但需要确保其继承自 Modelica.Media.Interfaces 中定义的接口规范。
</p>
<p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">Modelica.Fluid库中的所有组件均采用名为</span>
<code>Medium</code><span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">的可替换介质包：模型基于通用流体编写，
用户可通过重新声明该包在构建系统模型时指定具体流体模型。具体实现方式包括以下几种：</span>
</p>
<li>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">若多个组件使用相同介质，可通过图形界面批量选中这些组件（因其介质参数均命名为Medium），
并统一设置其介质模型</span>。</li>
<li>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">用户还可在模型中声明一个或多个（可替换的）介质包，随后将其用于各独立组件的参数配置</span>。</li>
</html>"        ));
      end MediumDefinition;

      class CustomizingModel "系统模型的定制化"
        extends Modelica.Icons.Information;
        annotation(Documentation(info = "<html><p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">构建系统模型后，用户可通过合理配置System组件的默认参数（及/或特定组件的参数设置），
灵活调整模型近似度以实现不同精度的仿真需求</span>。
</p>
<p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">在\"假设条件\"选项卡中</span> | allowFlowReversal 
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">参数用于控制是否模拟逆向流动工况（即与设计方向相反的流动方向）。
默认情况下，模型会考虑逆向流动，但这将显著增加方程复杂度，因为需要根据流向建立条件方程。若预先确定某组件（或整个系统）的流动始终沿设计方向，
将该参数设为false可大幅提升仿真速度并增强代码鲁棒性。</span>
</p>
<p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">在\"假设条件 | 动态特性\"选项卡中，各标志位支持对组件的质量、能量及动量方程进行不同精度的近似建模</span>。
</p>
<li>
DynamicFreeInitial：<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">当考虑动态方程（非零存储量）时，系统不会提供初始方程，
此时初始值将作为非线性求解器的迭代初值使用</span>。</li>
<li>
FixedInitial：<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">当考虑动态方程（非零存储量）时，系统将包含初始方程，
并将状态变量固定为组件参数提供的初始值</span>。</li>
<li>
SteadyStateInitial：<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">当考虑动态方程（非零存储量）时，系统将包含初始方程，
声明状态变量导数为零（稳态初始化），并将初始值作为非线性求解器的迭代初值使用</span>。</li>
<li>
SteadyState：<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">当采用代数（或静态）平衡方程（无存储量）时，
初始值将作为非线性求解器的迭代初值使用</span>。</li>
<p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">用户仅需通过图形界面简单勾选，即可忽略整个系统（或部分子系统）中质量、动量及能量的存储效应，
并在动态模型中调整初始化类型。需注意，某些参数组合可能存在冲突，导致模型编译报错</span>。
</p>
</html>"     ));
      end CustomizingModel;
      annotation(Documentation(info = "<html><p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">本节为快速入门指南，旨在讲解如何使用Modelica.Fluid构建系统模型。
内容涵盖关键概念，包括系统组件（System）的配置、介质模型（Medium）在系统中的定义方法，以及Modelica.Fluid模型库中常见的参数自定义选项</span>。
</p>
</html>"     ));
    end BuildingSystemModels;

    class ReleaseNotes "版本说明"
      extends Modelica.Icons.ReleaseNotes;
      annotation(Documentation(info="<html><h4>版本 1.1, 2009-06-21</h4><p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">Modelica_Fluid库（修订版本号r2625）已作为Modelica.Fluid集成至Modelica标准库3.1版本中</span>。
</p>
<h4>版本 1.0, 2009-01-28</h4><p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">Modelica_Fluid库已针对版本发布完成重构与最终优化</span>：
</p>
<ul><li>
代码重构<br> <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">此次重构实属必要，因旧版Modelica.Fluid Streams Beta3仍保留长期开发的历史痕迹，
而核心设计理念已趋于稳定。具体修改细节请查阅版本控制（SVN）日志记录</span>。</li>
<li>
设备导向的包命名<br> <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">原Junctions（连接件）与PressureLosses（压力损失）子包已合并至新子包Fittings（管件）中。
原Pumps（泵）及Volumes.SweptVolume（扫掠容积）合并形成Machines（流体机械）子包的初始版本。原Volumes（容积）包现更名为Vessels（容器）</span>。</li>
<li>
完整实现一维流体流动建模<br> 用户指南 <a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.BalanceEquations\" target=\"\"> UsersGuide.ComponentDefinition.BalanceEquations</a>&nbsp; 
中所述的平衡方程现已完整实现。 包含通用的边界流动项与源项的<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\"> 
模型实现位于以下路径</span>：<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">特定模型通过组合这些平衡方程，并根据实际需求定义边界流动项及源项</span>。 
<br>例如<br>Vessels、Machines 和 Fittings 的所有非三维质量和能量平衡均已用 PartialLumpedVolume 代替。<br>Pipes 的质量和能量平衡基于 PartialDistributedVolume实现。
<br><br>参见 <a href=\"modelica://Modelica.Fluid.Examples.BranchingDynamicPipes\" target=\"\">Examples.BranchingDynamicPipes</a>&nbsp; &nbsp;以完整平衡方程应用为例。</li>
<li>
分布式流动模型连接的新方法<br> &nbsp;交错网格法为模型连接方式提供了多种选择。<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\"> 此前主流建模方法是将完整质量守恒方程置于管道模型中，
并通过端口暴露半动量守恒方程（对应ModelStructure a_v_b结构）。此方法会导致连接集中压力/流量关系形成非线性方程组。 现引入新的默认结构av_vb，将完整动量守恒方程置于模型中，并通过端口暴露半质量守恒方程（av_vb替代原avb结构）。
此方式可避免非线性方程组，但需在连接集中处理高指标微分代数方程（DAE）。 此外，可引入SuddenExpansion等管件模型，以处理连接流动模型间流通截面积突变的情况</span>。</li>
<li>
新增 Vessels.BaseClasses.PartialLumpedVessel 基类，用于<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">处理ClosedVolume（封闭容积）、 
SimpleTank（简单储罐）及SweptVolume（扫掠容积）的端口连接与水力阻力计算</span>。</li>
<li>
明确建模假设</li>
</ul><p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\"> &nbsp; &nbsp;文档内容已扩展，以更清晰地阐述模型假设。 
特别地，用户指南</span><a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.FluidConnectors\" target=\"\"> 
UsersGuide.ComponentDefinition.FluidConnectors</a>&nbsp; &nbsp;<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\"> 
现已明确：端口表征的为热力学焓（与滞止焓相区别）及热力学压力/静压（与总压相区别）</span>。 示例中新增原理说明包，<span style=\"color: rgba(0, 0, 0, 0.9); 
font-size: 16px;\">用于演示静压与总压的差异及其潜在影响， 
详见 </span><a href=\"modelica://Modelica.Fluid.Examples.Explanatory.MomentumBalanceFittings\" target=\"\">Examples.Explanatory.MomentumBalanceFittings</a>&nbsp;
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\"> &nbsp; 。</span>
</p>
<ul><li>
系统（前身为环境）</li>
</ul><p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\"> &nbsp; &nbsp;全局System对象的功能已扩展，现支持为建模假设、初始化及高级参数设置提供通用默认值。
这些默认值虽因库的不同应用场景而异，但出于便捷性考量仍予以保留。特别地，现可系统级统一指定稳态初始化与全稳态仿真。新增Types.Init.Dynamics类型，将稳态条件与初始条件整合。 原Types.Init类型已弃用。</span>
</p>
<p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\"> 详见示例</span> <a href=\"modelica://Modelica.Fluid.Examples.HeatingSystem\" target=\"\">Examples.HeatingSystem</a>&nbsp; &nbsp;。
</p>
<ul><li>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">泵类模型已扩展，以更完善地处理零流量工况及与环境的热交换效应</span> <br> <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">
原有的简化质量与能量平衡方程已被严格数学公式替代。 此外，现可配置可选传热模型以表征泵体与环境或壳体间的热交换效应</span>。<br> <span style=\"color: rgba(0, 0, 0, 0.9); 
font-size: 16px;\">详见示例</span> <a href=\"modelica://Modelica.Fluid.Machines.BaseClasses.PartialPump\" target=\"\">Machines.BaseClasses.PartialPump</a>&nbsp; &nbsp;。</li>
<li>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">阀门模型已针对流动反向工况进行细化改进</span><br> 所有阀门模型现均采用上游离散化方法处理流动反向工况。</li>
<li>
微量物质的完善<br> Modelica.Fluid 现在为微量物质提供了完善的处理方案，<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">可便捷添加至现有介质模型中，
以便研究其在流体系统中的输运与分布规律</span>。<br> <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\"> 
详见示例</span> <a href=\"modelica://Modelica.Fluid.Examples.TraceSubstances.RoomCO2WithControls\" target=\"\">Examples.TraceSubstances.RoomCO2WithControls</a>&nbsp; &nbsp;。</li>
<li>
容积矢量化接口<br> 像 \"容器\"（Vessels）和 \"边界\"（Sources）这样通常具有较大体积的模型的接口已被矢量化。以前将多个流动模型连接到相同容积模型的接口会导致 stream 变量在体积外部连接集中产生意外的混合方程。 
当使用多个接口时，混合发生在体积内部。 此外，引入了 <a href=\"modelica://Modelica.Fluid.Fittings.MultiPort\" target=\"\">Fittings.MultiPort</a>&nbsp; 。 它可以连接到像管道这样的组件上， 
这些组件本身没有矢量化的接口。</li>
<li>
具有额定操作条件的流模型的反参数化<br> 流动模型已新增或扩展以支持使用额定值进行参数化 （Machines.ControlledPump、Orifices.SimpleGenericOrifice、Pipes.BaseClasses.FlowModels.NominalTurbulentFlow）。
如果几何形状和流动特性不是首要考虑的话，这些模型适用于系统建模的早期阶段。由于这些模型使用相同的接口、基类和命名规则， 因此可以很容易地在以后要考虑更详细的模型时进行替换。 
<br> 参见 <a href=\"modelica://Modelica.Fluid.Examples.InverseParameterization\" target=\"\">Examples.InverseParameterization</a>&nbsp; </li>
<li>
可替换的传热模型<br> <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">除管道模型外，容器（Vessels）与旋转机械（Machines）现均支持可替换的传热模型。
所有传热模型均为可选配置项。 传热模型通过所涉及流动段的介质（Medium）及热力学状态（ThermodynamicState）进行参数化。
</span><br> 参见 <a href=\"modelica://Modelica.Fluid.Interfaces.PartialHeatTransfer\" target=\"\">Interfaces.PartialHeatTransfer</a>&nbsp;。</li>
<li>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">所有示例现均已通过验证（基于Dymola 7.1平台运行）</span>。<br> <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\"> 
示例库新增原关键测试案例HeatingSystem（供热系统）与IncompressibleFluidNetwork（不可压缩流体网络）。此外，HeatExchangers（换热器模型）已迁移至Examples目录下</span>。</li>
</ul><h4>版本 1.0 Streams Beta 3, 2008-10-12</h4><p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">Modelica.Fluid库功能已进一步优化完善</span>：
</p>
<ul><li>
体积、水箱、接头<br> &nbsp;<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">新增断言（</span>assert<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">）机制， 
强制要求每个端口至多被连接一次。若用户进行多重连接，系统将默认对连接组件进行理想混合，而此情形几乎总与用户预期相悖</span>。</li>
<li>
环境<br> <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">将\"Ambient\"更名为\"System\"，并对相关模型进行适配。 
新增默认参数system.flowDirection（流动方向）及注释型参数system.initType（初始化类型）。system.flowDirection现作为双端口组件的默认流动方向配置项</span>。</li>
<li>
通用接头<br> 已修正 flowDirection（流动方向） 的规范定义。<br> 新增 HeatPort（热端口）接口。</li>
<li>
离散流动基类模型<br>流速<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">计算已调整为采用端口上游属性</span>。<br> 修正并统一了 p_start[*] 参数的初始化方法。</li>
<li>
离散管道模型<br> 对<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">端口密度与粘度的处理方式已调整为与集总管道模型一致，从而避免质量流量过零或趋近于零时触发事件</span>。
<br> 雷诺数计算已修正。<br> 新增了测试模型 DistributedPipeClosingValve<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">（分布式管道关断阀）</span>。</li>
<li>
控制阀<br> 将 flowCharacteristic 更名为 valveCharacteristic。<br> 删除了参数 Kv，

<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">并在线性阀与离散阀接口中新增dp_nom（额定压降）与m_flow_nom（额定质量流量）参数，
同时补充相关测试案例</span>。<br> <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">示例模型已适配新版LinearValve（线性阀）与DiscreteValve（离散阀），采用额定值替代Kv参数</span>。
<br> <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">默认流量系数选择策略已调整为基于工况点(</span> OpPoint)。</li>
<li>
修复了控制阀模型中 Kv 和 Cv 的单位。</li>
<li>
阀门相关测试案例已更新。</li>
<li>
修复Modelica.Fluid.Test.TestComponents.Pumps.TestWaterPump2 中<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">因复杂重声明引发的缺陷</span>。</li>
<li>
调整AST_BatchPlant模型，<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">使其通过\"Check\"检查（仿真在600秒后仍会失败）</span>。</li>
<li>
引入density_pTX(Medium.p_default, Medium.T_default, Medium.X_default) 作为密度标称值的默认计算方式（原采用字面值如1000）。</li>
<li>
泵<br> <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">泵模型的能量平衡方程已更新（消除除零风险，修复多个与Np相关的缺陷）
</span><br> <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">新增两项泵测试案例</span>。
<br> <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">泵初始化选项已修正</span>。</li>
<li>
泵基类<br> 能量平衡相关说明已添加为注释<br> 原\"h=0\" 替换为 \"h=Medium.h_default\"，<span style=\"color: rgba(0, 0, 0, 0.9); 
font-size: 16px;\">以避免当介质模型中h=0超出有效范围时触发断言错误</span>。<br> <span style=\"color: rgba(0, 0, 0, 0.9); 
font-size: 16px;\">流体端口统一沿中线布局，且尺寸规格与所有其他组件保持一致</span>。</li>
<li>
泵模型<br> <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">输入端口尺寸已调整为与标准输入接口一致</span>。
<br> <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">图标文本更改为输入端口</span> \"N_in [rpm]\"。
<br> <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">外部与内部输入接口均新增\"rev/min\"（转/分钟）单位标注</span>。</li>
<li>
阀门基类<br> <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">图标填充色设为白色（fillcolor=white）。
</span><br> <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">线条粗细统一为单线（Thickness = Single），以解决部分场景下图标显示异常问题。</span></li>
<li>
所有组件<br> 将 %name 颜色从黑色更改为蓝色 （<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">
此变更源于Modelica版本兼容问题：Modelica 2默认蓝色，而Modelica 3默认黑色，Dymola未对此差异进行自动适配</span>）。</li>
<li>
边界<br> <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">若对应输入项被禁用，则其关联的图标元素将自动隐藏</span>。</li>
<li>
阀门、管道、压损元件、换热器及双端口传感器<br> <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">在图标中新增从port_a到port_b的\"设计流向\"箭头标识</span>。</li>
<li>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">将System模块中的默认初始化配置移至注释（当前尚未生效）。</span></li>
<li>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">在用户手册中补充Francesco关于阀门Kv、Cv参数的说明，并在相关阀门模型中添加对应文档链接。</span></li>
</ul><p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">库模型静态检查（“Check”）已通过。除以下例外情况外，库内所有测试模型的仿真验证（“Check with Simulation”）均成功完成</span>：
</p>
<ul><li>
Examples.AST_BatchPlant.BatchPlant_StandardWater<br> <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">需在后续版本中修复（需投入较多工作量）</span>。</li>
<li>
Test.TestOverdeterminedSteadyStateInit.Test5<br> Test.TestOverdeterminedSteadyStateInit.Test6<br> <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">
此类测试案例存在初始条件过定义问题，需研究处理方法。模型无法仿真是当前面临的核心问题。</span></li>
</ul><h4>版本 1.0 Streams Beta 2, 2008-10-08</h4><p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">Modelica.Fluid库已升级至Modelica 3版本，并自动转换为符合Modelica标准库3.0规范。其他变更包括</span>：
</p>
<ul><li>
模拟枚举变为真实枚举。</li>
<li>
改进了 ControlValves 代码</li>
<li>
使用 stream 关键字替换了流连接器的注释</li>
<li>
使用 inStream() 替代 inflow()</li>
<li>
使用 m_flow*actualStream(h_outflow) 替代 streamFlow() 或 semiLinear(m_flow, inStream(h_outflow), medium.h)</li>
<li>
移除了 Modelica.Fluid.Media 及其所有引用（因为现在可以 在 MSL3.0 的 Modelica.Media 中找到）。</li>
<li>
为具有多物质的介质修复了 PartialLumpedVolume</li>
<li>
新函数 \"Utilities.RegFun3\" 用于静态头的正则化</li>
<li>
使用新的 RegFun3 函数修复了静态头模型中的密度 （ticket 7）</li>
<li>
修复了 MixingVolume 中的小错误：<br> 在从 PartialLumpedVolume 继承时，V_lumped 和 Wb_flow <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">
被错误地设置为修饰符</span>，<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">但二者并未声明为输入参数。此操作在 Modelica 3 中不被允许。
已通过将修饰符替换为方程（equations）修复该问题</span>。</li>
<li>
Modelica.Fluid.Sources.FixedBoundary<br> 引入了 p_default、T_default、h_default 作为默认值，<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">
以避免因参数缺失导致持续输出警告信息</span>。</li>
<li>
Modelica.Fluid.Sources.Boundary_pT<br> Modelica.Fluid.Sources.Boundary_ph<br> Modelica.Fluid.Sources.MassFlowSource_T<br> 将参数 reference_p、reference_T 的默认值统一更改为
p_default、T_default（<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">此前部分参数使用</span> xx_default，<span style=\"color: rgba(0, 0, 0, 0.9); 
font-size: 16px;\">部分使用</span> reference_xx， <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">统一命名方式更合理</span>）</li>
<li>
Modelica.Fluid.Pipes.BaseClasses.PartialDistributedFlow<br> 添加了参数 \"rho_nominal\" 的默认值，该默认值通过 Medium.density_pTX(Medium.p_default, Medium.T_default, Medium.X_default) 计算得到，
用以避免不必要的警告消息。 一旦 \"Medium.rho_default\"可用，<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">应将其替换为该值</span>。</li>
<li>
Modelica.Fluid.Pipes.DistributedPipe<br> Modelica.Fluid.Pipes.DistributedPipeSb<br> Modelica.Fluid.Pipes.DistributedPipeSa<br> 
为参数 \"mu_nominal\" 添加了默认值 （通过动态粘度<span style=\"color: rgb(51, 51, 51);\">dynamicViscosity</span>(..) 函数，基于默认的 p、T、X 值计算得出）。</li>
<li>
Modelica.Fluid.Pipes.BaseClasses.PartialDistributedFlowLumpedPressure<br> 将默认值 \"rho_nominal=0.01\" 替换为 Medium.density_pTX(Medium.p_default, Medium.T_default, Medium.X_default)</li>
<li>
Modelica.Fluid.Volumes.OpenTank<br> Modelica.Fluid.Volumes.Tank<br> <span style=\"color: rgba(0, 0, 0, 0.9); 
font-size: 16px;\">修正了端口图标（从 Modelica 2 自动转换至 Modelica 3 时尺寸错误）</span>。</li>
<li>
Examples.BranchingDistributedPipes<br> Modelica.Fluid.Test.TestComponents.Junctions.TestGenericJunction<br> Modelica.Fluid.Test.TestComponents.Pipes.TestDistributedPipe01<br> 
在连接点组件中未定义参数 dp_nom、m_flow_nom ，<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">现已补充其数值</span>。</li>
<li>
PressureLosses.BaseClasses.QuadraticTurbulent.BaseModel<br> \"parameter LossFactorData data\" 没有默认值或起始值，将模型改为 \"部分模型\"，以避免出现警告信息。</li>
</ul><h4>版本 1.0 流体 Beta 1, 2008-05-02</h4><p>
将连接器更改为流连接器，并调整了以下子库：
</p>
<ul><li>
体积</li>
<li>
压力损失</li>
<li>
传感器</li>
<li>
边界</li>
<li>
控制阀</li>
<li>
热交换器</li>
<li>
连接点</li>
<li>
管道</li>
<li>
泵</li>
<li>
测试和示例（大多数示例和测试正在模拟）</li>
</ul><p>
其他变更：
</p>
<ul><li>
在 Modelica.Fluid.Interfaces 中引入了支持矢量图标的 HeatPorts接口</li>
<li>
已删除Modelica.Fluid.WorkInProgress模块，<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">因其迁移至流连接器（stream connectors）的工作量过大</span></li>
<li>
新增 Modelica.Fluid.Media（因为 Modelica.Media 中缺少必要函数，该模块包含 ConstantLiquidWater 介质模型）</li>
<li>
新增两个附加的 LumpedPipes 测试案例 （用于识别层级连接的流连接器的问题）。</li>
<li>
已删除TestPortVolumes测试模块，<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">因流连接器（stream connectors）不再支持</span>PortVolumes 的实现方式</li>
<li>
阀门引入了泄漏流量</li>
<li>
修正了 DrumBoiler 示例</li>
<li>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">为传感器（温度 T、焓 h 等）添加正则化处理，以消除双向流中的不连续性</span></li>
<li>
修正了静压头中的密度计算</li>
<li>
新增函数 Utilities.regUnitStep、regStep</li>
<li>
新增组件（TestComponents.Sensors.TestOnePortSensors1/.TestOnePortSensors2l， TestRegStep）</li>
<li>
部分双端口传输模型<br></li>
<li>
泵基类（PartialPump）：删除了 p_nom参数，因其不再需要（仅保留 dp_nom）</li>
<li>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">统一了所有组件图标中的</span> \"%name\" <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">显示格式，
并优化了视觉效果</span>）</li>
<li>
将阀门的泄漏流量的默认值更改为零。</li>
<li>
修正了 Modelica.Fluid.Junctions.MassFlowRatio 以便编译 （inflow(..) 目前仅支持标量，而不支持矢量）</li>
<li>
添加了脚本库 libraryinfo.mos，以便 Modelica.Fluid 自动出现在 Dymola 库窗口中（提供的库在 MODELICAPATH 中）</li>
<li>
将 semiLinear(..) 替换为 streamFlow(..)（<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">尚未全部替换完成</span>）</li>
<li>
在边界的参数菜单中引入了复选框（更方便使用）</li>
<li>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">双端口传输模型（</span>TwoPortTransport）<br> <span style=\"color: rgba(0, 0, 0, 0.9);
font-size: 16px;\">修正了体积流量</span>V_flow以及可选端口温度 port_a_T、port_b_T的计算，<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">并纠正了温度计算中的错误</span></li>
<li>
油箱（Tank）：<br> 将底部管道直径的默认值从 0 更改为 0.1，<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">以避免未连接且未修改时出现除以零的错误</span>。</li>
<li>
Modelica.Fluid.ControlValves.ValveVaporizing：<br> 由于 PartialTwoPortTransport 的更改，port_a_T_inflow 不再存在，并且将其用法删除。</li>
<li>
Modelica.Fluid.Test.TestComponents.Sensors.TestTemperatureSensor：<br> 由于 PartialTwoPortTransport 的更改， p_start 不再存在，并且删除了其用法。</li>
<li>
引入了 VersionBuild，并自动更新 VersionBuild/VersionDate</li>
</ul><h4>版本 1.0 Beta 4, 2008-04-26</h4><p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">根据自上一测试版以来 Modelica 设计会议的讨论内容进行了更新。当前版本已进入“冻结”状态，
以便后续切换至采用流变量（stream variables）的全新连接器设计版本</span>。
</p>
<h4>版本 1.0 Beta 3, 2007-06-05</h4><p>
根据自 Modelica\\\\'2006 会议以来的设计会议讨论，<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">
本次更新包含以下调整：优化初始化流程、重构 </span>Source<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\"> 组件（需启用输入连接器）、
改进 </span>tank<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\"> 组件功能、将测试模型从 </span>Examples<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\"> 
迁移至新建的 </span>Test<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\"> 包并新增多项测试等。此版本与 1.0 Beta 2 存在轻微的前向不兼容性</span>。
</p>
<h4>版本 1.0 Beta 2, 2006-08-28</h4><p>
对软件包进行了大幅重构，并新增若干组件。 新增示例模型（ControlledTankSystem、AST_BatchPlant）。
</p>
<h4>版本 0.96, 2006-01-08</h4><ul><li>
新库 Modelica.Fluid.PressureLosses。</li>
<li>
新库 Modelica.Fluid.WorkInProgress。</li>
<li>
Modelica.Fluid.Components 中的新组件：<br> ShortPipe、OpenTank、ValveDiscrete、StaticHead。</li>
<li>
Modelica.Fluid.Examples 中的新组件。</li>
<li>
改进用户指南。</li>
</ul><h4>版本 0.910, 2005-10-25</h4><ul><li>
根据第 41-45 次 Modelica 设计会议上的决定进行更改 （详细信息，请参阅会议纪要）。</li>
</ul><h4>版本 0.900, 2004-10-18</h4><ul><li>
根据 <span style=\"color: rgb(51, 51, 51);\">Dresden </span>第 40 次 Modelica 设计会议上的决定进行更改 （也请参阅会议纪要）。</li>
</ul><h4>版本 0.794, 2004-05-31</h4><ul><li>
Sensors.mo、Examples/DrumBoiler.mo：扩展传感器，使用户可以选择测量单位。</li>
<li>
Components.mo、Types.mo：将组件和类型移动到 Examples。</li>
<li>
将示例从<strong>文件</strong> Modelica.Fluid/package.mo 移动到 Modelica.Media/Examples 的 <strong>子目录</strong>，并创建单独的子库文件。这样可以简化由不同作者维护示例的工作</li>
<li>
将接口从文件 Modelica.Fluid/package.mo 移动到 Modelica.Fluid/Interfaces.mo</li>
</ul><h4>版本 0.793, 2004-05-18</h4><ul><li>
删除了 \"semiLinear\" 函数，因为在 Dymola 中作为 Modelica 2.1 内置运算符可用。</li>
<li>
修正了 \"Components.ShortPipe\" 中的小错误。</li>
<li>
修正了 \"Components.Orifice\" 中的错误 （dp 先前是在 Interfaces.PartialTwoPortTransport 中计算的， 但这已被删除且在 Orifice 中未更新）。</li>
</ul><h4>版本 0.792, 2003-11-07</h4><p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">此版本为针对 Modelica’2003 的若干改动整合而成的首个稳定版本</span>。 
但Modelica.Fluid <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">库目前仍远未达到可纳入</span> Modelica 标准库的成熟度。
</p>
<h4>先前版本</h4><ul><li>
<em>2003年10月</em><br> 由 Martin Otter：根据 Modelica.Media 库的最新设计进行了调整。<br> 由 Rüdiger Franke：包含了传感器组件和 Modelica.Fluid.Examples.DrumBoiler 示例。</li>
<li>
<em>2003年9月</em><br> 由 Martin Otter：根据 2003年9月2-4日在迪尔伯恩举行的 Modelica 设计会议的决定进行了更改。 
流体库分为两个包：Modelica.Media 包含介质模型，Modelica.Fluid 包含流体流动组件。 Modelica.Media 独立于 Modelica.Fluid，也可以从其他可能具有不同设计的包中使用，例如 Modelica.Fluid。</li>
<li>
<em>2003年8月</em><br> 由 Martin Otter：改进了文档，PortVicinity（现在称为 semiLinear）手动扩展， 两种不同的体积类型，将质量分数的数量从 n 更改为 n-1，以使得模型用于单一物质更容易，
并且不需要在方程中处理特殊情况（先前需要删除单一物质流动的质量分数方程；现在它们会自动删除，因为维度为零，而不是以前的一个）， 包含了检查介质模型有效性的 assert，包含了介质模型中的动力黏度，根据界面的更改改进了示例和介质模型，
根据 Dymola 5.1 中的新功能改进了菜单。添加了一个含管道摩擦损失详细模型的库 \"Components.ShortPipe\"，适用范围非常广泛。</li>
<li>
<em>2003年2月</em><br> 由 Martin Otter：包含了几个基本组件和湿空气模型。一些基本组件，例如 FixedAmbient，是从 Anton Haumer 的 SimpleFlow 流体库中适应的版本。</li>
<li>
<em>2002年12月</em><br> 由 Hubertus Tummescheit： 高精度水模型的改进版本（从 ThermoFluid 库复制，代码重组织，增强文档，额外功能）。</li>
<li>
<em>2002年11月30日</em><br> 由 Martin Otter：根据设计会议的设计改进： 适应了 Modelica 标准库 1.5， 添加了 \"choicesAllMatching=true\" 注释， 
在 \"Interfaces\" 中添加了简短的文档， 添加了之前版本的 \"Examples\" 和 \"Media\" 包（之前称为 \"Properties\"）并将其调整为更新的 \"Interfaces\" 库。</li>
<li>
<em>2002年11月20-21日</em><br> 由 Hilding Elmqvist、Mike Tiller、Allan Watson、John Batteh、Chuck Newman、Jonas Eborn：在第32次 Modelica 设计会议上进行了改进。</li>
<li>
<em>2002年11月11日</em><br> 由 Hilding Elmqvist、Martin Otter：改进版本。</li>
<li>
<em>2002年11月6日</em><br> 由 Hilding Elmqvist：基本设计的第一个版本。</li>
</ul></html>"    ));
    end ReleaseNotes;

    class Contact "联系方式"
      extends Modelica.Icons.Contact;
      annotation(Documentation(info = "<html><h4>库管理员</h4><p>
<strong>Francesco Casella</strong><br> Dipartimento di Elettronica e Informazione<br> Politecnico di Milano<br> Via Ponzio 34/5<br> I-20133 Milano, 意大利<br> 
电子邮件: <a href=\"mailto:casella@elet.polimi.it\" target=\"\">casella@elet.polimi.it</a>&nbsp; 
</p>
<p>
<strong>Rüdiger Franke</strong><br> ABB AG<br> PTSP-E22<br> Kallstadter Str. 1<br> D-68163, 德国<br> 
电子邮件: <a href=\"mailto:ruediger.franke@de.abb.com\" target=\"\">ruediger.franke@de.abb.com</a>&nbsp; 
</p>
<h4>致谢</h4><p>
该库的开发是一项协作工作，许多人都做出了贡献。
</p>
<li>
此库的先前设计（直到 2008 年初）基于论文： Elmqvist H., Tummescheit H., and Otter M.: 
<a href=\"https://www.modelica.org/events/Conference2003/papers/h40_Elmqvist_fluid.pdf\" target=\"\">
热流体系统的面向对象建模</a>&nbsp; &nbsp;。 Modelica 2003 会议，瑞典林雪平，2003年11月3-4日，第269-286页。
<br> 此设计已经部分改变，特别是通过引入流的概念。</li>
<li>
Fluid 库的开发在 2002-2004 年由 Martin Otter 组织，自 2004 年以来由 Francesco Casella 组织，
自 2008 年以来由 Francesco Casella 和 Rüdiger Franke 共同组织。</li>
<li>
Francesco Casella 包含了他的 ThermoPower library 中的几个组件，并进行了一些重写。Modelica.Fluid 中使用的流连接器概念
是基于他为 ThermoPower library 开发的类似概念。</li>
<li>
Rüdiger Franke 将流连接器概念作为 ThermoPower 概念的扩展和改进版本引入。在 2008 年11月至2009年1月期间，他对库进行了大规模的重组和改进。</li>
<li>
Michael Wetter 一致地在 Modelica.Fluid 中引入了痕量成分，并在 Examples.TraceSubstances 下提供了相应的示例。</li>
<li>
以下人员为流组件模型、示例以及库的进一步设计做出了贡献 （按字母顺序排列）：
<br> John Batteh、 Francesco Casella、Jonas Eborn、Hilding Elmqvist、 
Rüdiger Franke、Manuel Gräber、Henning Knigge、 Sven Erik Mattsson、Chuck Newman、Hans Olsson、
Martin Otter、Katrin Prölß、 Christoph Richter、Michael Sielemann、Mike Tiller、Hubertus Tummescheit、 Allan Watson、Michael Wetter。</li>
<p>
感谢德国ABB和德国航空航天中心（DLR）在 BMBF（BMBF Förderkennzeichen: 01IS07022F）的部分资金支持，
用于该库在 <a href=\"http://www.itea2.org\" target=\"\">ITEA</a>&nbsp;项目 EUROSYSLIB 中的进一步开发。
</p>
</html>"    ));
    end Contact;
    annotation(DocumentationClass = true, Documentation(info = "<html><p>
<span style=\"color: rgb(51, 51, 51);\"><strong> &nbsp; &nbsp; &nbsp; Modelica.Fluid</strong></span><span style=\"color: rgb(51, 51, 51);\">库是一个</span><span style=\"color: rgb(51, 51, 51);\"><strong>开源</strong></span><span style=\"color: rgb(51, 51, 51);\">的Modelica包，提供用于管网系统中</span><span style=\"color: rgb(51, 51, 51);\"><strong>一维热流体流动</strong></span><span style=\"color: rgb(51, 51, 51);\">建模的组件。其核心特性在于实现了组件方程、介质模型、压损关联式与热关联式之间的解耦设计。 所有组件均基于Modelica.Media 库中的介质模型构建，这意味着该库可兼容处理可压缩/不可压缩介质，单组分/多组分介质以及单相/多相介质等多种流体类型。</span>
</p>
</html>"));
  end UsersGuide;

  annotation(Icon(graphics = {
    Polygon(points = {{-70, 26}, {68, -44}, {68, 26}, {2, -10}, {-70, -42}, {-70, 26}}), 
    Line(points = {{2, 42}, {2, -10}}), 
    Rectangle(
    extent = {{-18, 50}, {22, 42}}, 
    fillPattern = FillPattern.Solid)}), preferredView = "info", 
    Documentation(info = "<html><p>
<strong> &nbsp; &nbsp; &nbsp; &nbsp;Modelica.Fluid</strong>库是一个<strong>开源</strong>的Modelica包，为模拟容器、管道、流体机械、阀门和接头系统中的 <strong>1维热流体流动</strong>提供建模组件。 其独特优势在于实现了组件方程、介质模型、压损关联式与热关联式之间的解耦设计。 所有组件均基于Modelica.Media 库中的介质模型构建，这意味着该库可兼容处理可压缩/不可压缩介质，单组分/多组分介质以及单相/多相介质等多种流体类型。
</p>
<p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\"> &nbsp; &nbsp; &nbsp; &nbsp;通过下图所示的闭环流动循环加热系统案例，可直观展示该库的多个核心功能特性。仅需在系统对象中修改一个配置参数，即可实现模型方程在稳态仿真与动态仿真模式间的切换，并支持固定初始条件或稳态初始条件两种初始化方式</span>。
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Fluid/HeatingSystem.png\" alt=\"HeatingSystem.png\" data-href=\"\" style=\"\">
</p>
<p>
 &nbsp; &nbsp; &nbsp; 相较于早期版本，Modelica.Fluid库的连接器（connector）设计采用了<strong>非向后兼容</strong>的更新，引入了Modelica 3.1中新增的“流连接器（stream connector）”概念，这一改进显著提升了仿真的可靠性。 （详情请参见 <a href=\"modelica://Modelica/Resources/Documentation/Fluid/Stream-Connectors-Overview-Rationale.pdf\" target=\"\">Stream-Connectors-Overview-Rationale.pdf</a>&nbsp;）。
</p>
<p>
初次使用本库时，推荐重点阅读以下章节：
</p>
<li>
<a href=\"modelica://Modelica.Fluid.UsersGuide\" target=\"\">Modelica.Fluid.UsersGuide</a>&nbsp;；</li>
<li>
<a href=\"modelica://Modelica.Fluid.UsersGuide.ReleaseNotes\" target=\"\">Modelica.Fluid.UsersGuide.ReleaseNotes</a>&nbsp; 概述各版本库的变更摘要；</li>
<li>
<a href=\"modelica://Modelica.Fluid.Examples\" target=\"\">Modelica.Fluid.Examples</a>&nbsp; 包含演示该库用法的示例。</li>
<p>
版权所有&copy; 2002-2020，Modelica协会及贡献者
</p>
</html>"));
end Fluid;