within Modelica;
package Media "介质物性模型库"
  extends Modelica.Icons.Package;
  import Modelica.Units.SI;
  import Cv = Modelica.Units.Conversions;

  package UsersGuide "用户指南"
    extends Modelica.Icons.Information;

    package MediumUsage "介质库用法"
      extends Modelica.Icons.Information;

      class BasicUsage "基本用法"
        extends Modelica.Icons.Information;

        annotation(Documentation(info = "<html>
  <h4>介质模型的基本用法</h4>
  <p>
Modelica.Media 中的介质模型由继承自基类 Modelica.Media.Interfaces.PartialMedium 的库提供。每个库定义：
</p>
<li>介质<strong>常数</strong>（如化学物质的数量、分子数据、临界性质等）。</li>
<li>一个 BaseProperties <strong>模型</strong>，用于计算流体的基本热力学性质；</li>
<li><strong>setState_XXX </strong>函数，用于根据
不同的输入参数（如密度、温度和组分，即 setState_dTX ）计算热力学状态记录；</li>
<li><strong>函数</strong>用于计算附加性质（如饱和性质、黏度、导热系数等）。</li>
<p>
如上所述，有两种不同的基本使用介质库的方法，这将在以下部分中详细描述。一种方法是使用模型 BaseProperties。 
对于任意介质模型，其每个BaseProperties实例均会为介质模型中声明的下述<strong>5+nXi个变量</strong>提供<strong>3+nXi个
方程</strong>（其中nXi表示独立质量分数数量，具体说明见下文）：
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>变量</strong></td>
      <td><strong>单位</strong></td>
      <td><strong>描述</strong></td></tr>
  <tr><td>T</td>
      <td>K</td>
      <td>温度</td></tr>
  <tr><td>p</td>
      <td>Pa</td>
      <td>绝对压力</td></tr>
  <tr><td>d</td>
      <td>kg/m3</td>
      <td>密度</td></tr>
  <tr><td>u</td>
      <td>J/kg</td>
      <td>比内能</td></tr>
  <tr><td>h</td>
      <td>J/kg</td>
      <td>比焓 (h = u + p/d)</td></tr>
  <tr><td>Xi[nXi]</td>
      <td>kg/kg</td>
      <td>独立质量分数m_i/m</td></tr>
  <tr><td>X[nX]</td>
      <td>kg/kg</td>
      <td>所有质量分数m_i/m.在 BaseProperties 中定义X为:<br>
          X = <strong>if</strong> reducedX <strong>then</strong> vector([Xi; 1-<strong>sum</strong>(Xi)])
          <strong>else</strong> Xi </td></tr>
</table>
<p>
<strong>两个</strong>变量（p、d、h或u）以及<strong>质量分数 </strong>Xi 是<strong>独立</strong>变量，
介质模型基本上提供方程来计算剩余变量，包括完整的质量分数矢量X（关于Xi和X的更多细节见下文）。
</p>
<p>
在组件中，介质模型的最基本用法如下：
</p>
<pre><code >model Pump
replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
\"介质模型\" annotation (choicesAllMatching = true);
Medium.BaseProperties medium_a \"a处（例如port_a）的介质性质\";
// 使用介质变量（medium_a.p, medium_a.T, medium_a.h, ...）
...
end Pump;
</code></pre><p>
第二种方法是使用setState_XXX函数从中计算热力学状态记录，然后可以从中计算所有其他热力学状态变量（见
<a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition.BasicDefinition\" target=\"\">
介质的基本定义</a>&nbsp;，了解更多关于 ThermodynamicState 的详细信息）。setState_XXX 函数
接受X或Xi（见下文解释）并将在内部决定用户提供的这两种成分中的哪一个。PartialMedium中提供了四个基本的 setState_XXX 函数：
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>函数</strong></td>
      <td><strong>描述</strong></td>
      <td><strong>单组分介质的简写</strong></td></tr>
  <tr><td>setState_dTX</td>
      <td>从密度、温度和组成X或Xi计算热力学状态</td>
      <td>setState_dT</td></tr>
  <tr><td>setState_phX</td>
      <td>从压力、比焓和组成X或Xi计算热力学状态</td>
      <td>setState_ph</td></tr>
  <tr><td>setState_psX</td>
      <td>从压力、比熵和组成X或Xi计算热力学状态</td>
      <td>setState_ps</td></tr>
  <tr><td>setState_pTX</td>
      <td>从压力、温度和组成X或Xi计算热力学状态</td>
      <td>setState_pT</td></tr>
</table>
<p>
解释BaseProperties的基本用法的简单示例如下：
</p>
<pre><code >model Pump
replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
\"介质模型\" annotation (choicesAllMatching = true);
Medium.ThermodynamicState state_a \"a处（例如port_a）的介质性质\";
// 从热力学状态记录计算介质变量（pressure(state_a), temperature(state_a),
// specificEnthalpy(state_a), ...）
...
end Pump;
</code></pre>
<p>
所有介质模型直接或间接地是 Modelica.Media.Interfaces.PartialMedium 的子库。
因此，组件中的介质模型应继承自此基类。通过注解\"choicesAllMatching = true\"，定义工具应显示一个选择框，
其中包含继承自 PartialMedium 的所有加载库。下图给出了一个示例：
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Media/UsersGuide/MediumUsage/mediumMenu.png\" alt=\"medium selection menu\">
</div>

<p>
选择一个介质模型会导致如下方程：
</p>
<pre><code >
Pump pump(redeclare package Medium = Modelica.Media.Water.SimpleLiquidWater);
</code></pre><p>
通常，介质模型与流体连接器的变量相关联。因此，需要在模型中定义方程，将连接器中的变量与介质模型中的变量关联：
</p>
<pre><code >model Pump
replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
\"介质模型\" annotation (choicesAllMatching = true);
Medium.BaseProperties medium_a \"port_a的介质性质\";
// 定义流体接口 port_a
...
equation
medium.p = port_a.p;
medium.h = port_a.h;
medium.Xi = port_a.Xi;
...
end Pump;
</code></pre><p>
在使用BaseProperties的情况下，或者
</p>
<pre><code >model Pump
replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
\"介质模型\" annotation (choicesAllMatching = true);
Medium.ThermodynamicState state_a \"port_a的介质热力学状态记录\";
// 定义流体接口port_a
...
equation
state_a = Medium.setState_phX(port_a.p, port_a.h, port_a.Xi) // 如果port_a包含变量
                                                             // p, h和Xi
...
end Pump;
</code></pre><p>
在使用 ThermodynamicState 的情况下。
</p>
<p>
如果组件模型要处理单组分和多组分流体，则模型中必须包含质量分数相关方程（上文：medium.Xi = port_a.Xi）。
根据 Modelica 语义，如果 Xi 的维度为零，即对于单组分介质，质量分数的方程将被忽略。请注意，通过“介质定义”部分中概述的特定技术，
介质模型中的自变量不需要与连接器中的变量相同，并且仍然可以获得与使用相同变量的效率。
</p>
<p>
如果流体由单一物质组成，<strong>nXi = 0 </strong>且不存在质量分数矢量 Xi。如果流体由 nS 种物质组成，
介质模型可以定义独立质量分数的数量 <strong>nXi </strong>为 <strong>nS</strong>、<strong>nS-1 </strong>或零。
在所有情况下，都必须在相应组件中给出 nXi 种物质的平衡方程（见下文讨论）。请注意，如果 nXi = nS，
模型中不存在质量分数之间的约束“sum(Xi)=1”；在这种情况下，有必要为 Xi 提供一致的初始值，使得 sum(Xi) = 1。
</p>
<p>
将Xi定义为独立质量分数的原因在于：流体组件库可通过仅使用独立质量分数Xi实现，而后通过介质模型定义Xi的具体解释方式：
</p>
<li>
如果 Xi = nS，则在模拟期间忽略约束方程 sum(X) = 1。通过确保 X 的初始条件满足此约束，通常可以保证 sum(X) = 1 的误差保持很小，
尽管模拟期间不显式使用此约束方程。如果混合物的成分变得非常小，这种方法通常是有用的。如果通过方程 1 - sum(X[1:nX-1]) 计算出这样的小量，
可能会出现较大的数值误差，最好通过相应的平衡方程计算。</li>
<li>
如果 Xi = nS-1，则在流体组件中使用真正的独立质量分数，并通过 X[nX] = 1 - sum(Xi) 计算 X 的最后一个成分。
这对于例如湿空气（MoistAir）很有用，在不引入数值问题的情况下，状态的数量应尽可能少。</li>
<li>
如果 Xi = 0，则假定成分 reference_X 的参考值。这在所有成分始终恒定的情况下（例如具有固定成分边界的回路）很有用，可以避免这种成分状态。</li>
<p>
基于 Xi、reference_X 以及是否为 nS 或 nS-1 的信息，在 PartialMedium.BaseProperties 中计算完整的质量分数矢量 <strong>X[nX]</strong>。
对于单组分介质，nX = 0，因此也没有 X 矢量。对于多组分介质，nX = nS，X 始终包含所有质量分数矢量。
为了减少与流体组件库的混淆，“Xi”具有“HideResult=true”注解，这意味着此变量不会显示在绘图窗口中。
在绘图窗口中显示 X，并且该矢量始终包含所有质量分数。
</p>
</html>"      ));
      end BasicUsage;

      class BalanceVolume "平衡容积"
        extends Modelica.Icons.Information;

        annotation(Documentation(info = "<html><p>
流体库通常具有一个流体连接器接口的平衡容积组件，满足质量和能量平衡，在不同的网格组件上满足动量平衡。平衡容积组件，称为 JunctionVolume，主要应按如下方式实现 （参见实现示例在 <a href=\"modelica://Modelica.Media.Examples.Utilities.PortVolume\" target=\"\"> Modelica.Media.Examples.Utilities.PortVolume</a>&nbsp;）：
</p>
<pre><code >model JunctionVolume
import Modelica.Units.SI;
import Modelica.Media.Examples.Utilities.FluidPort_a;

parameter SI.Volume V = 1e-6 \"junction容积的固定大小\";
replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
\"介质模型\" annotation (choicesAllMatching = true);

FluidPort_a port(redeclare package Medium = Medium);
Medium.BaseProperties medium(preferredMediumStates = true);

SI.Energy U              \"junction容积的内能\";
SI.Mass   M              \"junction容积的质量\";
SI.Mass   MX[Medium.nXi] \"junction容积的独立物质质量\";
equation
medium.p   = port.p;
medium.h   = port.h;
medium.Xi = port.Xi;

M  = V*medium.d;                  // junction容积的质量
MX = M*medium.Xi;                 // junction容积的质量分数
U  = M*medium.u;                  // junction容积的内能

der(M)  = port.m_flow;    // 质量平衡
der(MX) = port.mX_flow;   // 物质质量平衡
der(U)  = port.H_flow;    // 能量平衡
end JunctionVolume;
</code></pre><p>
假设使用 Modelica.Media.Air.SimpleAir 介质模型与上述 JunctionVolume 模型一起使用。此介质模型使用压力 p 和温度 T 作为独立变量。如果在\"medium\"的声明中将标志\"preferredMediumStates\"设置为 <strong>true</strong>，那么此介质模型的独立变量将获得属性\"stateSelect = StateSelect.prefer\"，即，如果可能，Modelica 翻译器应将这些变量用作状态变量。基本上，这意味着存在状态变量 p,T 和状态变量U,M 之间的约束。因此，Modelica 工具将<strong>自动</strong>对介质方程式进行求导，并在代码生成时使用以下方程式（注意，与 X 相关的方程被移除，因为 SimpleAir 仅包含一种物质）：
</p>
<pre><code >M  = V*medium.d;
U  = M*medium.u;

// 平衡方程
der(M)  = port.m_flow;
der(U)  = port.H_flow;

// 为了得到更简单的项，引入了缩写
p = medium.p;
T = medium.T;
d = medium.d;
u = medium.u;
h = medium.h;

// 介质方程
d = fd(p,T);
h = fh(p,T);
u = h - p/d;

// 由于指数约简，Modelica 工具自动推导出的方程
der(U) = der(M)*u + M*der(u);
der(M) = V*der(d);
der(u) = der(h) - der(p)/d - p/der(d);
der(d) = der(fd,p)*der(p) + der(fd,T)*der(T);
der(h) = der(fh,p)*der(p) + der(fd,T)*der(T);
</code></pre><p>
注意，\"der(y,x)\" 是一个运算符，在上面的例子中表示 y 对 x 的偏导数（此运算符将在 Modelica 语言的下一个版本中包含）。 本库中所有介质模型的编写均确保至少提供介质变量对自变量的偏导数，其实现方式包括两种情形：直接给出可符号微分的显式方程，或提供对应函数（如上述fd函数）的导数定义。Modelica 工具将上述方程转化为以 p 和 T 为状态的微分方程，即将生成方程来计算 <strong>der</strong>(p) 和 <strong>der</strong>(T) 作为 p 和 T 的函数。
</p>
<p>
注意，当 preferredMediumStates = <strong>false</strong> 时，不会进行微分，并且 Modelica 编译器将使用出现在微分形式中的变量作为状态变量，即 M 和 U。这样做的缺点是，对于许多介质来说，要从 M 和 U 计算出固有特性 p、d、T、u、h，就需要非线性方程组。
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"      ));
      end BalanceVolume;

      class ShortPipe "短管"
        extends Modelica.Icons.Information;

        annotation(Documentation(info = "<html><p>
流体库中有两个接口的组件，不存储质量或能量，并在其两个接口之间满足动量方程，例如短管。在大多数情况下，这意味着存在一个方程将两个接口之间的压降与从一个接口到另一个接口的质量流量相关联。由于不存储质量或能量，因此不存在热力学变量的微分方程。这种类型的组件模型通常具有以下结构 （参见实现示例在 <a href=\"modelica://Modelica.Media.Examples.Utilities.ShortPipe\" target=\"\"> Modelica.Media.Examples.Utilities.ShortPipe</a>&nbsp;）：
</p>
<pre><code >model ShortPipe
import Modelica.Units.SI;
import Modelica.Media.Examples.Utilities;

// 定义压降方程的参数

replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
\"介质模型\" annotation (choicesAllMatching = true);

Utilities.FluidPort_a port_a (redeclare package Medium = Medium);
Utilities.FluidPort_b port_b (redeclare package Medium = Medium);

SI.Pressure dp = port_a.p - port_b.p \"压降\";
Medium.BaseProperties medium_a \"port_a 的介质性质\";
Medium.BaseProperties medium_b \"port_b 的介质性质\";
equation
// 定义接口的介质模型
medium_a.p   = port_a.p;
medium_a.h   = port_a.h;
medium_a.Xi = port_a.Xi;

medium_b.p   = port_b.p;
medium_b.h   = port_b.h;
medium_b.Xi = port_b.Xi;

// 处理反向和零流量（semiLinear 是 Modelica 内置运算符）
port_a.H_flow   = semiLinear(port_a.m_flow, port_a.h, port_b.h);
port_a.mXi_flow = semiLinear(port_a.m_flow, port_a.Xi, port_b.Xi);

// 能量、质量和物质质量平衡
port_a.H_flow + port_b.H_flow = 0;
port_a.m_flow + port_b.m_flow = 0;
port_a.mXi_flow + port_b.mXi_flow = zeros(Medium.nXi);

// 提供方程: port_a.m_flow = f(dp)
end ShortPipe;
</code></pre><p>
<strong>semiLinear</strong>(..) 运算符基本定义为：
</p>
<pre><code >semiLinear(m_flow, ha, hb) = if m_flow ≥ 0 then m_flow*ha else m_flow*hb;
</code></pre><p>
即，根据流动方向，计算来自 port_a 或 port_b 性质的焓流。此运算符的详细信息见 <a href=\"modelica://ModelicaReference.Operators.\\\\\\\\\\'semiLinear()\\\\\\\\\\'\" target=\"\"> <a href=\"modelica:///ModelicaReference.Operators.\\'semiLinear()\\'\" target=\"\" style=\"text-align: start; line-height: 1.5;\">ModelicaReference.Operators.\\'semiLinear()\\'</a>&nbsp;</a>&nbsp;。特别是，Modelica 规范中定义了处理 m_flow = 0 的规则，可以“有意义地”处理。特别是，如果 n 个流体组件（如管道）连接在一起，并且使用上述的流体连接器，那么在 medium1.h, medium2.h, medium3.h, ..., port1.h, port2.h, port3.h, ..., port1.H_flow, port2.H_flow, port3.H_flow, ...之间出现一个线性方程组。semiLinear(..) 运算符的规则允许以下线性方程组的解：
</p>
<li>
n = 2（两个组件连接在一起）：<br> 线性方程组可以解析求解，因此，不存在零质量流量的问题。</li>
<li>
n &gt; 2（超过两个组件连接在一起）：<br> 线性方程组在模拟过程中以数值方法求解。对于 m_flow = 0，线性方程组变得奇异并且有无限多个解。模拟器可以使用最接近前一时间步解的解（“最小二乘解”）。从物理上讲，解是由通常被忽略的扩散决定的。如果包含扩散，线性系统就是常规的。</li>
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
</html>"      ));
      end ShortPipe;

      class OptionalProperties "可选性质"
        extends Modelica.Icons.Information;

        annotation(Documentation(info = "<html>
  <p>
在某些情况下需要额外的介质性质，需要这些可选性质的组件必须调用以下表中列出的函数之一。
它们在基类 <a href=\"modelica://Modelica.Media.Interfaces.PartialMedium\" target=\"\">PartialMedium </a>&nbsp; 
中定义为基类函数， 然后（可选择地）在实际介质库中实现。 
如果一个组件调用了这样的可选函数而介质库没有为该函数提供新的实现， 则在翻译时会打印错误消息，
因为该函数是\"partial\"（基类）函数，即不完整。 所有函数的参数都在<strong>状态</strong>记录表中，
由 BaseProperties 模型自动定义或使用 setState_XXX 函数专门计算， 它包含计算所有附加性质所需的最小热力学变量数。
在表中假设存在以下形式的声明：
</pre></blockquote>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>函数调用</strong></td>
      <td><strong>单位</strong></td>
      <td><strong>说明</strong></td></tr>
  <tr><td>Medium.dynamicViscosity(state)</td>
      <td>Pa.s</td>
      <td>动力黏度</td></tr>
  <tr><td>Medium.thermalConductivity(state)</td>
      <td>W/(m.K)</td>
      <td>导热系数</td></tr>
  <tr><td>Medium.prandtlNumber(state)</td>
      <td>1</td>
      <td>普朗特数</td></tr>
  <tr><td>Medium.specificEntropy(state)</td>
      <td>J/(kg.K)</td>
      <td>比熵</td></tr>
  <tr><td>Medium.specificHeatCapacityCp(state)</td>
      <td>J/(kg.K)</td>
      <td>定压比热容</td></tr>
  <tr><td>Medium.specificHeatCapacityCv(state)</td>
      <td>J/(kg.K)</td>
      <td>定容比热容</td></tr>
  <tr><td>Medium.isentropicExponent(state)</td>
      <td>1</td>
      <td>等熵指数</td></tr>
  <tr><td>Medium.isentropicEnthatlpy(pressure, state)</td>
      <td>J/kg</td>
      <td>等熵焓</td></tr>
  <tr><td>Medium.velocityOfSound(state)</td>
      <td>m/s</td>
      <td>声速</td></tr>
  <tr><td>Medium.isobaricExpansionCoefficient(state)</td>
      <td>1/K</td>
      <td>等压膨胀系数</td></tr>
  <tr><td>Medium.isothermalCompressibility(state)</td>
      <td>1/Pa</td>
      <td>等温压缩系数</td></tr>
  <tr><td>Medium.density_derp_h(state)</td>
      <td>kg/(m3.Pa)</td>
      <td>定焓下密度对压力的导数</td></tr>
  <tr><td>Medium.density_derh_p(state)</td>
      <td>kg2/(m3.J)</td>
      <td>定压下密度对焓的导数</td></tr>
  <tr><td>Medium.density_derp_T(state)</td>
      <td>kg/(m3.Pa)</td>
      <td>定温下密度对压力的导数</td></tr>
  <tr><td>Medium.density_derT_p(state)</td>
      <td>kg/(m3.K)</td>
      <td>定压下密度对温度的导数</td></tr>
  <tr><td>Medium.density_derX(state)</td>
      <td>kg/m3</td>
      <td>密度对质量分数的导数</td></tr>
  <tr><td>Medium.molarMass(state)</td>
      <td>kg/mol</td>
      <td>摩尔质量</td></tr>
</table>
<p>
为了方便用户，还提供了一些简化形式，允许在不显式使用 ThermodynamicState 记录表的情况下计算某些热力学状态变量。
这些简化形式例如在初始方程部分计算一致的初始值时非常有用。让我们以 temperature_phX(p,h,X) 函数为例。
此函数从压力、比焓和成分 X（或 Xi）计算温度，是以下形式的简化：
</p>
<pre><code >temperature(setState_phX(p,h,X))
</code></pre><p>
以下函数在 PartialMedium 中预定义（如果有用，可以在实际介质实现库中添加其他函数）：
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td>Medium.specificEnthalpy_pTX(p,T,X)</td>
      <td>J/kg</td>
      <td>p, T, X 下的比焓</td></tr>
  <tr><td>Medium.temperature_phX(p,h,X)</td>
      <td>K</td>
      <td>p, h, X 下的温度</td></tr>
  <tr><td>Medium.density_phX(p,h,X)</td>
      <td>kg/m3</td>
      <td>p, h, X 下的密度</td></tr>
  <tr><td>Medium.temperature_psX(p,s,X)</td>
      <td>K</td>
      <td>p, s, X 下的温度</td></tr>
  <tr><td>Medium.specificEnthalpy_psX(p,s,X)</td>
      <td>J/(kg.K)</td>
      <td>p, s, X 下的比熵</td></tr>
</table>
<p>
例如假设在短管的压降方程中需要动力黏度 eta。那么，短管的模型必须改为：
</p>
<pre><code >model ShortPipe
...
Medium.BaseProperties medium_a \"port_a 的介质性质\";
Medium.BaseProperties medium_b \"port_b 的介质性质\";
...
Medium.DynamicViscosity eta;
...
eta = if port_a.m_flow &gt; 0 then
Medium.dynamicViscosity(medium_a.state)
else
Medium.dynamicViscosity(medium_b.state);
// 在压降方程中使用 eta: port_a.m_flow = f(dp, eta)
end ShortPipe;
</code></pre><p>
注意，\"Medium.DynamicViscosity\" 是在 Modelica.Interfaces.PartialMedium 中定义的类型，具体定义为：
</p>
<pre><code >import Modelica.Units.SI;
type DynamicViscosity = SI.DynamicViscosity (
min=0,
max=1.e8,
nominal=1.e-3,
start=1.e-3);
</code></pre><p>
每个介质模型都可以修改属性，以提供例如适应介质的最小值、最大值、额定值和初始值。 此外，还在 PartialMedium 中定义了其他类型，
例如 AbsolutePressure、Density、MassFlowRate 等。尽可能地，在模型中应使用这些介质特定的类型，以便自动利用关于额定值或初始值的介质信息。
</p>
</html>"      ));
      end OptionalProperties;

      class Constants "常量"
        extends Modelica.Icons.Information;

        annotation(Documentation(info="<html>
  <p>
每个介质模型提供以下<strong>常量</strong>。例如， 
如果一个介质被声明为：
</p>
<pre><code >replaceable package Medium = Modelica.Media.Interfaces.PartialMedium;
</code></pre><p>
则定义了常量 \"Medium.mediumName\", \"Medium.nX\" 等：
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>类型</strong></td>
      <td><strong>名称</strong></td>
      <td><strong>描述</strong></td></tr>
  <tr><td>String</td><td>mediumName</td>
      <td>介质的唯一名称（通常用于检查连接在一起的不同组件中的介质是否相同，通过在连接器中提供 Medium.mediumName 作为质量流量的属性）。</td></tr>
  <tr><td>String</td><td>substanceNames[nS]</td>
      <td>组成介质的物质名称如果只有一种物质存在，substanceNames = {mediumName}。</td></tr>
  <tr><td>String</td><td>extraPropertiesNames[nC]</td>
      <td>除质量和能量平衡之外的其他运输物质名称。</td></tr>
  <tr><td>Boolean</td><td>singleState</td>
      <td>= <strong>true</strong>, 如果u（比内能）和d（密度）不依赖于压力，而仅作为单一热力学变量（温度或焓）及多物质介质Xi（质量分数）的函数时。通常，这个标志对于不可压缩介质为 <strong>true</strong> 。在模型中，该参数用于确定包含质量与能量平衡的体积单元所需的初始条件数量：1+nXi (singleState=<strong>true</strong>) 或 2+nXi (singleState=<strong>true</strong>)。</td></tr>
  <tr><td>AbsolutePressure</td><td>reference_p</td>
      <td>介质的参考压力</td></tr>
  <tr><td>MassFraction</td><td>reference_X[nX]</td>
      <td>介质的参考组分</td></tr>
  <tr><td>AbsolutePressure</td><td>p_default</td>
      <td>介质的压力默认值（用于初始化）</td></tr>
  <tr><td>Temperature</td><td>T_default</td>
      <td>介质的温度默认值（用于初始化）</td></tr>
  <tr><td>SpecificEnthalpy</td><td>h_default</td>
      <td>介质的比焓默认值（用于初始化）</td></tr>
  <tr><td>MassFraction</td><td>X_default[nX]</td>
      <td>介质的质量分数默认值（用于初始化）</td></tr>
  <tr><td>Integer</td><td>nS</td>
      <td>介质中包含的物质数量。</td></tr>
  <tr><td>Integer</td><td>nX</td>
      <td>完整质量分数矢量 X 的大小 nX=nS。</td></tr>
  <tr><td>Integer</td><td>nXi</td>
      <td>独立质量分数的数量。如果只有一种物质，则 nXi = 0 。</td></tr>
  <tr><td>Boolean</td><td>reducedX</td>
      <td>= <strong>true</strong>,如果介质有单一物质，或介质模型有多种物质且包含方程 sum(X) = 1。
      在这两种情况下，nXi = nS - 1 (除非 fixedX = true)<br>
          = <strong>false</strong>, 如果介质有多种物质且不包含方程 sum(X)=1，即 nXi = nX = nS (除非 fixedX = true)       
       </td></tr>
  <tr><td>Boolean</td><td>fixedX</td>
      <td>= <strong>false</strong>: 介质的组成可以变化，由 nXi 独立质量分数决定（见上文 reducedX）。<br>
          = <strong>true</strong>: 介质的组成始终为 reference_X，且 nXi = 0。</td></tr>
  <tr><td>FluidConstants</td><td>fluidConstants[nS]</td>
      <td>介质每种物质的临界、三相点、分子及其他标准数据。</td></tr>
</table>

<p>
在 PartialMedium 中定义的记录表 FluidConstants 包含以下元素
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>类型</strong></td>
      <td><strong>名称</strong></td>
      <td><strong>描述</strong></td></tr>

  <tr><td>String</td>
      <td>iupacName</td>
      <td>完整的 IUPAC 名称</td></tr>

  <tr><td>String</td>
      <td>casRegistryNumber</td>
      <td>化学文摘序列号</td></tr>

  <tr><td>String</td>
      <td>chemicalFormula</td>
      <td>化学式（总式，按照 Hill 命名法</td></tr>

  <tr><td>String</td>
      <td>structureFormula</td>
      <td>化学结构式</td></tr>

  <tr><td>MolarMass</td>
      <td>molarMass</td>
      <td>摩尔质量</td></tr>
</table>

<p>
该记录表在层级下的基类（如 PartialTwoPhaseMedium 或 PartialMixtureMedium）中进一步扩展，可能包含以下部分或全部元素
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td>Temperature</td>
      <td>criticalTemperature</td>
      <td>临界温度</td></tr>

  <tr><td>AbsolutePressure</td>
      <td>criticalPressure</td>
      <td>临界压力</td></tr>

  <tr><td>MolarVolume</td>
      <td>criticalMolarVolume</td>
      <td>临界摩尔容积</td></tr>

  <tr><td>Real</td>
      <td>acentricFactor</td>
      <td>Pitzer 非中心因子</td></tr>

  <tr><td>Temperature</td>
      <td>triplePointTemperature</td>
      <td>三相点温度</td></tr>

  <tr><td>AbsolutePressure</td>
      <td>triplePointPressure</td>
      <td>三相点压力</td></tr>

  <tr><td>Temperature</td>
      <td>meltingPoint</td>
      <td>101325 Pa 下的熔点</td></tr>

  <tr><td>Temperature</td>
      <td>normalBoilingPoint</td>
      <td>正常沸点（在 101325 Pa 下）</td></tr>

  <tr><td>DipoleMoment</td>
      <td>dipoleMoment</td>
      <td>分子的偶极矩，以德拜为单位（1 debye = 3.33564e10-30 C.m）</td></tr>

  <tr><td>Boolean</td>
      <td>hasIdealGasHeatCapacity</td>
      <td>如果理想气体热容量可用，则为 true</td></tr>

  <tr><td>Boolean</td>
      <td>hasCriticalData</td>
      <td>如果临界数据已知，则为 true</td></tr>

  <tr><td>Boolean</td>
      <td>hasDipoleMoment</td>
      <td>如果已知偶极矩，则为 true</td></tr>

  <tr><td>Boolean</td>
      <td>hasFundamentalEquation</td>
      <td>如果有基本方程，则为 true</td></tr>

  <tr><td>Boolean</td>
      <td>hasLiquidHeatCapacity</td>
      <td>如果液体热容量可用，则为 true</td></tr>

  <tr><td>Boolean</td>
      <td>hasSolidHeatCapacity</td>
      <td>如果固体热容量可用，则为 true</td></tr>

  <tr><td>Boolean</td>
      <td>hasAccurateViscosityData</td>
      <td>如果有准确的动力黏度数据，则为 true</td></tr>

  <tr><td>Boolean</td>
      <td>hasAccurateConductivityData</td>
      <td>如果有准确的导热性数据，则为 true</td></tr>

  <tr><td>Boolean</td>
      <td>hasVapourPressureCurve</td>
      <td>如果已知蒸气压数据，例如 Antoine 系数，则为 true</td></tr>

  <tr><td>Boolean</td>
      <td>hasAcentricFactor</td>
      <td>如果已知 Pitzer 非中心因子，则为 true</td></tr>

  <tr><td>SpecificEnthalpy</td>
      <td>HCRIT0</td>
      <td>基本方程的临界比焓</td></tr>

  <tr><td>SpecificEntropy</td>
      <td>SCRIT0</td>
      <td>基本方程的临界比熵</td></tr>

  <tr><td>SpecificEnthalpy</td>
      <td>deltah</td>
      <td>比焓模型 (h_m) 与基本方程 (h_f) 的差值 (h_m - h_f)</td></tr>

  <tr><td>SpecificEntropy</td>
      <td>deltas</td>
      <td>比熵模型 (s_m) 与基本方程 (s_f) 的差值(s_m - s_f)</td></tr>

</table>

</html>"      ));
      end Constants;

      class TwoPhase "两相介质"
        extends Modelica.Icons.Information;

        annotation(Documentation(info = "<html>
  <p>
适用于单相或两相条件的介质模型需继承自 <a href=\"modelica://Modelica.Media.Interfaces.PartialTwoPhaseMedium\" target=\"\"> Modelica.Media.Interfaces.PartialTwoPhaseMedium</a>&nbsp; &nbsp;（继承自 PartialMedium）。这些介质模型的基本用法与前面的部分所述相同，但在此基础上扩展了专用于潜在两相介质的特殊功能模块。
</p>
<p>
提供了以下附加介质<strong>常量</strong>：
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>类型</strong></td>
      <td><strong>名称</strong></td>
      <td><strong>描述</strong></td></tr>
  <tr><td>Boolean</td>
      <td>smoothModel</td>
      <td>如果此标志为 false（默认值），则在跨越 饱和边界时触发事件；否则，不生成事件。</td></tr>
  <tr><td>Boolean</td>
      <td>onePhase</td>
      <td>如果此标志为 true，则介质模型假定它永远不会在双相区域中调用。当用户确定它将始终在单相区域中工作时，这有助于加快两相介质的计算速度。
默认值：false。</td></tr>
</table>
<p>
setState_ph()、setState_ps()、setState_dT() 和 setState_pT() 函数有一个额外的输入， 名为 <em>phase</em>。
如果未指定 phase 输入或其值为零，则 setState 函数将根据其他输入值确定相态。 输入 phase = 1 将强制 setState 函数返回对应于单相状态的状态矢量，
而 phase = 2 将强制 setState 函数返回对应于两相状态的状态矢量，如下例所示：
</p>
<p>
<br>
</p>
<pre><code >replaceable package Medium = Modelica.Media.Interfaces.PartialTwoPhaseMedium;
Medium.ThermodynamicState state, state1, state2;
equation
// 设置状态，给定压力和比焓
// 相态由 (p, h) 值确定，并可以从状态记录中检索
state = Medium.setState_ph(p, h);
phase = state1.phase;

// 强制用单相状态方程计算状态
// 不论 (p, h) 值如何
state1 = Medium.setState_ph(p, h, 1);

// 强制用两相状态方程计算状态
// 不论 (p, h) 值如何
state2 = Medium.setState_ph(p, h, 2);
</code></pre><p>
<br>
</p>
<p>
此功能可用于以下目的：
</p>
<li>
如果提前知道介质的相态，可节省计算时间；</li>
<li>
在两个输入对应于饱和边界上的点时明确确定相态（导数函数在边界两侧的值有显著不同）；</li>
<li>
获取亚稳态的性质，如过热水或过冷蒸汽。</li>
<p>
定义了许多额外的可选函数来计算饱和介质的性质，无论是液体（泡点）还是蒸汽（露点）。
此类函数的参数为 SaturationProperties 记录，可以从饱和压力或饱和温度开始设置，如下例所示。
</p>
<p>
<br>
</p>
<pre><code >replaceable package Medium = Modelica.Media.Interfaces.PartialTwoPhaseMedium;
Medium.SaturationProperties sat_p;
Medium.SaturationProperties sat_T;
equation
// 设置 sat_p 为压力 p 下的饱和性质
sat_p = Medium.setSat_p(p);

// 计算压力 p 下的饱和性质
saturationTemperature_p = Medium.saturationTemperature_sat(sat_p);
bubble_density_p =        Medium.bubbleDensity(sat_p);
dew_enthalpy_p   =        Medium.dewEnthalpy(sat_p);

// 设置 sat_T 为温度 T 下的饱和性质
sat_T = Medium.setSat_T(T);

// 计算温度 T 下的饱和性质
saturationTemperature_T = Medium.saturationPressure_sat(sat_T);
bubble_density_T =        Medium.bubbleDensity(sat_T);
dew_enthalpy_T =          Medium.dewEnthalpy(sat_T);
</code></pre><p>
<br>
</p>
<p>
参考定义压力 p、温度 T 和 SaturationProperties 记录 sat 的模型，提供了以下函数：
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>函数调用</strong></td>
      <td><strong>单位</strong></td>
      <td><strong>描述</strong></td></tr>
  <tr><td>Medium.saturationPressure(T)</td>
      <td>Pa</td>
      <td>温度 T 下的饱和压力</td></tr>
  <tr><td>Medium.saturationTemperature(p)</td>
      <td>K</td>
      <td>压力 p 下的饱和温度</td></tr>
  <tr><td>Medium.saturationTemperature_derp(p)</td>
      <td>K/Pa</td>
      <td>饱和温度对压力的导数</td></tr>
  <tr><td>Medium.saturationTemperature_sat(sat)</td>
      <td>K</td>
      <td>饱和温度</td></tr>
  <tr><td>Medium.saturationPressure_sat(sat)</td>
      <td>Pa</td>
      <td>饱和压力</td></tr>
  <tr><td>Medium.bubbleEnthalpy(sat)</td>
      <td>J/kg</td>
      <td>泡点比焓</td></tr>
  <tr><td>Medium.dewEnthalpy(sat)</td>
      <td>J/kg</td>
      <td>露点比焓</td></tr>
  <tr><td>Medium.bubbleEntropy(sat)</td>
      <td>J/(kg.K)</td>
      <td>泡点比熵</td></tr>
  <tr><td>Medium.dewEntropy(sat)</td>
      <td>J/(kg.K)</td>
      <td>露点比熵</td></tr>
  <tr><td>Medium.bubbleDensity(sat)</td>
      <td>kg/m3</td>
      <td>泡点密度</td></tr>
  <tr><td>Medium.dewDensity(sat)</td>
      <td>kg/m3</td>
      <td>露点密度</td></tr>
  <tr><td>Medium.saturationTemperature_derp_sat(sat)</td>
      <td>K/Pa</td>
      <td>饱和温度对压力的导数</td></tr>
  <tr><td>Medium.dBubbleDensity_dPressure(sat)</td>
      <td>kg/(m3.Pa)</td>
      <td>泡点密度对压力的导数</td></tr>
  <tr><td>Medium.dDewDensity_dPressure(sat)</td>
      <td>kg/(m3.Pa)</td>
      <td>露点密度对压力的导数</td></tr>
  <tr><td>Medium.dBubbleEnthalpy_dPressure(sat)</td>
      <td>J/(kg.Pa)</td>
      <td>泡点比焓对压力的导数</td></tr>
  <tr><td>Medium.dDewEnthalpy_dPressure(sat)</td>
      <td>J/(kg.Pa)</td>
      <td>露点比焓对压力的导数</td></tr>
  <tr><td>Medium.surfaceTension(sat)</td>
      <td>N/m</td>
      <td>液相和气相之间的表面张力</td></tr>
</table>
<p>
有时需要在热力学平面内（紧邻饱和穹顶内部或外部）计算流体性质。在这种情况下，可以获得 ThermodynamicState 状态矢量的实例，
然后使用它来调用已为单相介质定义的附加函数。
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>Function call</strong></td>
      <td><strong>Description</strong></td></tr>
  <tr><td>Medium.setBubbleState(sat, phase)</td>
      <td>获得对应于泡点的热力学状态矢量。
如果 phase==1（默认），状态位于单相侧；
如果 phase==2，状态位于两相侧。</td></tr>
  <tr><td>Medium.setDewState(sat, phase)</td>
      <td>获得对应于露点的热力学状态矢量。
如果 phase==1（默认），状态位于单相侧；
如果 phase==2，状态位于两相侧。</td></tr>
</table>
<p>
以下是一些示例：
</p>
<p>
<br>
</p>
<pre><code >replaceable package Medium = Modelica.Media.Interfaces.PartialTwoPhaseMedium;
Medium.SaturationProperties sat;
Medium.ThermodynamicState   dew_1;    // 露点，单相侧
Medium.ThermodynamicState   bubble_2; // 泡点，两相侧
equation
// 设置 sat 为压力 p 下的饱和性质
sat = setSat_p(p);

// 计算露点性质，（默认）单相侧
dew_1 = setDewState(sat);
cpDew = Medium.specificHeatCapacityCp(dew_1);
drho_dp_h_1 = Medium.density_derp_h(dew_1);

// 计算泡点性质，两相侧
bubble_2    = setBubbleState(sat, 2);
drho_dp_h_2 = Medium.density_derp_h(bubble_2);
</pre></blockquote>
</html>"      ));
      end TwoPhase;

      class Initialization "初始化"
        extends Modelica.Icons.Information;

        annotation(Documentation(info = "<html><p>
当介质模型用于平衡容积时，存在独立介质变量的微分方程， 因此需要提供初始条件。 可以选择以下几种方式：
</p>
<h4>稳态初始化</h4><p>
Modelica 目前没有语言元素来定义稳态初始化。在 Modelica 仿真环境 Dymola 中， 可以设置以下选项：
</p>
<pre><code >Advanced.DefaultSteadyStateInitialization = true
</code></pre><p>
然后，通过自动将适当的状态导数设置为零来提供缺少的初始条件。
</p>
<h4>显式起始值或初始方程</h4><p>
可以使用 \"start\" 和 \"fixed\" 属性定义显式起始值。需要知道独立变量的数量 nx， 可以从介质常量中推导出（nx = nXi + <strong>如果</strong> singleState <strong>则</strong> 1 <strong>否则</strong> 2）。 然后，可以为 nx 变量（= p, T, d, u, h, Xi）从 Medium.BaseProperties 定义起始值或初始方程，例如：
</p>
<pre><code >   replaceable package Medium = Medium.Interfaces.PartialMedium;
   Medium.BaseProperties medium1 (p(start=1e5, fixed=not Medium.singleState),
                                  T(start=300, fixed=true));
   Medium.BaseProperties medium2;
initial equation
   if not Medium.singleState then
      medium2.p = 1e5;
   end if;
   medium2.T = 300;
equation
</code></pre><p>
如果没有为独立介质变量提供初始条件，则可能会出现非线性方程组， 以根据提供的初始条件计算独立介质变量的初始值。
</p>
<h4>猜测值</h4><p>
如果在初始化期间出现非线性方程组，例如在稳态初始化的情况下， 必须通过 \"start\" 属性（和 fixed=false）提供非线性方程组迭代变量的猜测值。 然而，通常事先不知道哪些变量被选为非线性方程组的迭代变量。 可以选择以下几种方式：
</p>
<li>
不提供初值，并希望介质特定类型具有有意义的初值，例如在 \"Medium.AbsolutePressure\" 中</li>
<li>
为 BaseProperties 模型的所有变量提供起始值，即 p, T, d, u, h, Xi。</li>
<li>
确定非线性方程组的迭代变量，并为这些变量提供初值。 在 Modelica 仿真环境 Dymola 中，可以通过设置命令 <code><strong>Advanced.OutputModelicaCode = true</strong></code> 并检查设置此选项时生成的文件 \"dsmodel.mof\" 来确定迭代变量（搜索 \"nonlinear\"）。</li>
<p>
<br>
</p>
</html>"      ));
      end Initialization;

      annotation(DocumentationClass = true, Documentation(info = "<html><p>
内容：
</p>
<ol><li>
<a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.BasicUsage\" target=\"\">介质模型的基本用法</a>&nbsp;</li>
<li>
<a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.BalanceVolume\" target=\"\">用于平衡容积的介质模型</a>&nbsp;</li>
<li>
<a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.ShortPipe\" target=\"\">用于压力损失的介质模型</a>&nbsp;</li>
<li>
<a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.OptionalProperties\" target=\"\">可选介质属性</a>&nbsp;</li>
<li>
<a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.Constants\" target=\"\">介质模型提供的常数</a>&nbsp;</li>
<li>
<a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.TwoPhase\" target=\"\">两相介质</a>&nbsp;</li>
<li>
<a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.Initialization\" target=\"\">初始化</a>&nbsp;</li>
</ol><p>
关于如何正确使用Modelica.Media介质库的典型示例可参考ModelicaTest.Media.TestsWithFluid库。 
在 <a href=\"modelica://Modelica.Media.Examples.Utilities\" target=\"\">Modelica.Media.Examples.Utilities</a>&nbsp; 
中定义了流体库的核心基础组件。更多包含简单管网结构的补充介质模型示例可在 
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/tree/master/ModelicaTest\" target=\"\">ModelicaTest 库</a>&nbsp; 
的 <code>ModelicaTest.Media.TestsWithFluid.MediaTestModels</code> 路径下查阅。
</p>
</html>"      ));
    end MediumUsage;

    package MediumDefinition "介质定义"
      extends Modelica.Icons.Information;

      class BasicStructure "基本结构"
        extends Modelica.Icons.Information;

        annotation(Documentation(info = "<html><p>
Modelica.Media 的介质模型本质上是一个<strong>库</strong>，包含以下定义：
</p>
<ul><li>
<strong>常量</strong>的定义，例如介质名称。</li>
<li>
库中的一个<strong>模型</strong>，包含了与 5+nXi 个主要介质变量相关的 3 个基本热力学方程。</li>
<li>
<strong>可选函数</strong>用于计算仅在某些情况下需要的介质性质，如动力黏度。这些可选函数并不需要每个介质模型都提供。</li>
<li>
<strong>类型</strong>定义，这些定义适用于特定介质。例如，定义了一个<strong>温度</strong>类型，其中的属性<strong>最小值</strong>和<strong>最大值</strong>定义了介质的有效区域，并给出了合适的默认起始值。在设备模型中，建议使用这些类型定义，例如用于参数，以便尽早检查介质限制，并使非线性方程组的迭代变量获得合理的起始值。</li>
</ul><p>
注意，尽管我们使用<strong>介质模型</strong>这个术语，它实际上是一个 Modelica <strong>库</strong>，其中包含了完成一个<strong>介质模型</strong>所需的所有常量和定义。介质的基本接口由 Modelica.Media.Interfaces.PartialMedium 定义，结构如下：
</p>
<pre><code >partial package PartialMedium
import Modelica.Units.SI;
constant String           mediumName = \"\";
constant String           substanceNames[:] = {mediumName};
constant String           extraPropertiesNames[:] = fill(\"\",0);
constant Boolean          singleState = false;
constant Boolean          reducedX = true;
constant Boolean          fixedX = false;
constant AbsolutePressure reference_p = 101325;
constant MassFraction     reference_X[nX]=fill(1/nX,nX);
constant AbsolutePressure p_default = 101325;
constant Temperature      T_default = Modelica.Units.Conversions.from_degC(20);
constant SpecificEnthalpy h_default =
specificEnthalpy_pTX(p_default, T_default, X_default);
constant MassFraction     X_default[nX]=reference_X;
final constant Integer    nS  = size(substanceNames,1);
final constant Integer    nX  = nS;
final constant Integer    nXi = if fixedX then 0
else if reducedX or nS == 1
then nS-1 else nS;
final constant Integer    nC  = size(extraPropertiesNames,1);
constant FluidConstants[nS] fluidConstants;

replaceable record BasePropertiesRecord
AbsolutePressure p;
Density d;
Temperature T;
SpecificEnthalpy h;
SpecificInternalEnergy u;
MassFraction[nX] X;
MassFraction[nXi] Xi;
SpecificHeatCapacity R_s;
MolarMass MM;
end BasePropertiesRecord;

replaceable partial model BaseProperties
extends BasePropertiesRecord;
ThermodynamicState state;
parameter Boolean preferredMediumStates=false;
Modelica.Units.NonSI.Temperature_degC T_degC =
Modelica.Units.Conversions.to_degC(T)
Modelica.Units.NonSI.Pressure_bar p_bar =
Modelica.Units.Conversions.to_bar(p)
equation
Xi = X[1:nXi];
if nX &gt; 1 then
if fixedX then
X = reference_X;
elseif reducedX then
X[nX] = 1 - sum(Xi);
end if;
end if;
// equations such as
//    d = d(p,T);
//    u = u(p,T);
//    h = u + p/d;
//    state.p = p;
//    state.T = T;
// 将出现在实际介质实现中，但在基类中没有，因为 ThermodynamicState 记录表仍为空
end BaseProperties

replaceable record ThermodynamicState
// 基类中没有“标准”热力学变量
// 但在继承 PartialMedium 的实际介质中会定义
// 例如：
//    AbsolutePressure p \"介质的绝对压力\";
//    Temperature      T \"介质的温度\";
end ThermodynamicState;

// 可选介质性质
replaceable partial function dynamicViscosity
input  ThermodynamicState state;
output DynamicViscosity eta;
end dynamicViscosity;

// 其他可选函数

// 介质特定类型
type AbsolutePressure = SI.AbsolutePressure (
min     = 0,
max     = 1.e8,
nominal = 1.e5,
start   = 1.e5);
type DynamicViscosity = ...;
// 其他类型定义
end PartialMedium;
</code></pre><p>
我们将在接下来的段落中讨论这个库的所有部分。实际介质模型应继承自 PartialMedium，并需要提供各种部分的实现。
</p>
<p>
库开头的一些常量尚未赋值（这在 Modelica 中是有效的），但在继承 PartialMedium 库时必须提供一个值。可以在模型翻译之前修改给定的值或设置 <strong>final </strong>前缀。 使用常量而不是模型 BaseProperties 中的参数的原因是某些常量在不允许参数的上下文中使用。例如，在连接器定义中，独立质量分数 nXi 的数量用作矢量 Xi 的维数。在定义连接器时，只能访问库中的<em>常量</em>，而不能访问模型中的<em>参数</em>，因为连接器不能包含 BaseProperties 的实例。
</p>
<p>
记录表 BasePropertiesRecord 包含平衡方程中主要使用的变量。每个介质的模型 BaseProperties 必须为这些变量提供三个方程，外加两个用于气体常数和摩尔质量的方程。
</p>
<p>
可选介质性质由函数定义，例如用于计算动力黏度的函数 dynamicViscosity（见上述代码部分）。这些函数的参数是 ThermodynamicState 记录表，定义在 BaseProperties 中，包含计算所有可选性质所需的最小热力学变量。 这种构造大大简化了使用方式，如下代码片段所示：
</p>
<pre><code >replaceable package Medium = Modelica.Media.Interfaces.PartialMedium;
Medium.BaseProperties   medium;
Medium.DynamicViscosity eta;
...
U   = m*medium.u; //Internal energy
eta = Medium.dynamicViscosity(medium.state);
</code></pre><p>
Medium 是满足 PartialMedium 要求的介质库（使用上述模型时，必须通过重新声明提供 Medium 的值）。介质组件是模型 Medium.BaseProperties 的一个实例，包含核心介质方程。该模型中的变量可以通过点标注的方式访问，如 medium.u 或 medium.T。如果需要计算可选介质变量，则调用实际 Medium 库中的相应函数，例如 Medium.dynamicViscosity。medium.state 向量可以作为该函数的输入参数，其字段与 BaseProperties 中的字段通过适当的等式保持一致，这些等式包含在 BaseProperties 中（见上文）。
</p>
<p>
如果一个介质模型没有提供所有可选函数的实现，并且在模型中调用了这些函数，则在翻译期间会发生错误，因为未重新声明的可选函数具有<em>基类(partial )</em> 属性。例如，如果介质模型中未提供 dynamicViscosity 函数而使用了它，则只能使用没有参考黏度的简单压降损失模型，而不能使用复杂的模型。
</p>
<p>
在 PartialMedium 库底部，存在类型声明，这些类型在 PartialMedium 库的所有其他部分中使用，并应在访问介质模型的所有模型和连接器中使用。原因是定义了最小值、最大值、额定值和起始值，这些值可以根据特定介质进行调整。例如，AbsolutePressure 的额定值为 10<sup>5</sup> Pa。如果使用的水蒸气简单模型仅在 100 °C 以上有效，则应将 Temperature 类型的最小值设置为该值。最小值和最大值对于参数也很重要，以便在给出超出有效区域的数据时尽早获得信息。如果变量用作微分方程的状态或非线性方程组的迭代变量，额定属性作为缩放值也很重要。如果变量被用作非线性方程组中的迭代变量，start 属性对于提供一个有意义的默认起始值或猜测值非常有用。请注意，所有这些属性都可以通过以下方式进行设置：
</p>
<pre><code >package MyMedium
extends Modelica.Media.Interfaces.PartialMedium(
...
Temperature(min=373));
end MyMedium;
</code></pre><p>
PartialMedium.MassFlowRate 类型定义为
</p>
<pre><code >type MassFlowRate = SI.MassFlowRate
(quantity = \"MassFlowRate.\" + mediumName);
</code></pre><p>
注意，每个介质模型中必须定义的常量 mediumName 用于 quantity 属性。例如，如果 mediumName = SimpleLiquidWater，则 quantity 属性的值为 MassFlowRate.SimpleLiquidWater。此类型应在流体库的连接器定义中使用：
</p>
<pre><code >connector FluidPort
replaceable package Medium = Modelica.Media.Interfaces.PartialMedium;
flow Medium.MassFlowRate m_flow;
...
end FluidPort;
</code></pre><p>
在使用此连接器的模型中，必须定义实际的 Medium。只有在相应属性未定义或具有相同值的情况下，才能将连接器连接在一起。由于 mediumName 是 MassFlowRate 的 quantity 属性的一部分，因此不可将不同介质模型的连接器连接在一起。
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"  ));
      end BasicStructure;

      class BasicDefinition "基本定义"
        extends Modelica.Icons.Information;

        annotation(Documentation(info = "<html><p>
现在，让我们详细讨论新介质模型的定义。请参考 <a href=\"modelica://Modelica.Media.Interfaces.TemplateMedium\" target=\"\"> Modelica.Media.Interfaces.TemplateMedium</a> 获取新介质模型代码的模板。现在，考虑一个单一物质的介质模型。
</p>
<p>
新介质模型是通过继承 Modelica.Media.Interfaces.PartialMedium 并设置以下库常量来获得的：
</p>
<ul><li>
mediumName 是包含介质名称的字符串。</li>
<li>
substanceNames 是包含构成介质的物质名称的字符串向量。在本例中，它只包含 mediumName。</li>
<li>
如果 BaseProperties 中的 u 和 d 不依赖于压力，可以将 singleState 设置为 true。换句话说，密度不依赖于压力（不可压缩流体），并假设 u 也不依赖于压力。这对于具有高密度和低可压缩性的流体（例如中等压力下的液体）是有用的；由于低可压缩性效应而产生的快速状态将被自动避免。</li>
<li>
对于单一物质介质，reducedX = true，因为根本不需要质量分数。</li>
</ul><p>
也可以更改 Medium 定义类型的默认 min、max、<span style=\"color: rgb(51, 51, 51);\">nominal</span> 和 start 属性（请参阅 TemplateMedium）。
</p>
<p>
所有其他库常量，例如 nX、nXi、nS，都是由基库 Interfaces.PartialMedium 的声明自动设置的。
</p>
<p>
第二步是为 BaseProperties 模型提供实现，该模型在基类 Interfaces.PartialMedium 中部分定义。对于单一物质介质，必须从 p、T、d、u、h 中选择两个独立状态变量，并编写三个方程来提供其余变量的值。然后必须添加两个方程来计算摩尔质量 MM 和气体常数 R_s。
</p>
<p>
第三步是考虑在基类 PartialMedium 中定义的基类函数中要实现的可选函数。必须选择可以作为所有这些函数输入的最小状态变量集，并将其包含在 ThermodynamicState 记录表的重新声明中。随后，必须将方程添加到 BaseProperties 中，以便 BaseProperties 内部的记录表实例（名为 \"state\"）保持更新。例如，假设所有附加属性都可以作为 p 和 T 的函数来计算。那么，ThermodynamicState 应重新声明如下：
</p>
<pre><code >redeclare replaceable record ThermodynamicState
AbsolutePressure p \"介质的绝对压力\";
Temperature T \"介质的温度\";
end ThermodynamicState;
</code></pre><p>
并且应将以下方程添加到 BaseProperties 中：
</p>
<pre><code >state.p = p;
state.T = T;
</code></pre><p>
现在可以通过重新声明基类中定义的函数并添加其算法来实现附加函数，例如：
</p>
<pre><code >redeclare function extends dynamicViscosity \"返回动力黏度\"
algorithm
eta := 10 - state.T*0.3 + state.p*0.2;
end dynamicViscosity;
</code></pre><p>
<br>
</p>
<p>
<br>
</p>
</html>"  ));
      end BasicDefinition;

      class MultipleSubstances "多物质"
        extends Modelica.Icons.Information;

        annotation(Documentation(info = "<html><p>
在编写多物质介质的模型时，一个基本问题是如何考虑流体的质量分数。如果有 nS 种物质，则也有 nS 个质量分数；然而，其中一个是多余的，因为 sum(X) = 1。因此，关于独立质量分数 nXi 的数量，基本上有两种选择：
</p>
<ul><li>
<em>简化状态模型（Reduced-state models）</em>：reducedX = <strong>true</strong> 并且 nXi = nS - 1。在这种情况下，独立质量分数 nXi 的数量是最小的。完整状态矢量 X 由基类 Interfaces.PartialMedium.BaseProperties 中声明的方程提供：前 nXi 个元素等于 Xi，最后一个元素为 1 - sum(Xi)。</li>
<li>
<em>完整状态模型（Full-state models）</em>：reducedX = <strong>false</strong> 并且 nXi = nS。在这种情况下，Xi = X，即，组成矢量的所有元素都被视为独立变量，并且约束 sum(X) = 1 不会明确写出。尽管这种类型的模型较复杂，因为它提供了一个额外的状态变量，但它可能更不容易出现由该约束引起的数值和符号问题。</li>
<li>
<em>固定成分模型（Fixed-composition models）</em>：fixedX = <strong>true</strong> 并且 nXi = 0。在这种情况下，X = reference_X，即，组成矢量的所有元素都是固定的。</li>
</ul><p>
介质实现者可以将 reducedX 声明为 <strong>final</strong>。这样只需要提供一个实现。例如，Modelica.Media.IdealGases 模型声明 <strong>final</strong> reducedX = <strong>false</strong>，因此实现可以始终假设 nXi = nX。同样，Air.MoistAir 声明 <strong>final</strong> reducedX = <strong>true</strong>，并始终假设 nXi = nX - 1 = 1。
</p>
<p>
也可以让 reducedX 可修改。在这种情况下，BaseProperties 模型和所有附加函数应该检查 reducedX 的实际值，并提供相应的实现。
</p>
<p>
如果 fixedX 是可修改的，则实现也应适当地处理 fixedX = true 的情况。
</p>
<p>
流体接口应始终使用大小为 Xi 的组成矢量，例如在 Modelica.Fluid 库中：
</p>
<pre><code >connector FluidPort
replaceable package Medium = Modelica.Media.Interfaces.PartialMedium;
Medium.AbsolutePressure      p;
flow Medium.MassFlowRate     m_flow;

Medium.SpecificEnthalpy      h;
flow Medium.EnthalpyFlowRate H_flow;

Medium.MassFraction          Xi    [Medium.nXi];
flow Medium.MassFlowRate     mX_flow[Medium.nXi];
end FluidPort;
</code></pre><p>
有关更多详细信息，请参考 <a href=\"modelica://Modelica.Media.IdealGases.Common.MixtureGasNasa\" target=\"\"> MixtureGasNasa 模型</a> 和 <a href=\"modelica://Modelica.Media.Air.MoistAir\" target=\"\"> MoistAir 模型</a> 的实现。
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"  ));
      end MultipleSubstances;

      class SpecificEnthalpyAsFunction "焓作为函数"
        extends Modelica.Icons.Information;

        annotation(Documentation(info = "<html><p>
如果压力 p 和比焓 h <strong>不</strong> 作为独立介质变量，则比焓应通过一个 Modelica 函数计算，该函数的输入参数仅为独立介质变量，不应通过方程计算。例如，如果 p 和 T 用作独立介质变量，则应定义一个函数 h_pT(p,T) 来计算 h：
</p>
<pre><code >h = h_pT(p,T);
</code></pre><p>
这条规则的原因需要更长的解释。简而言之，如果 h 不是通过 Modelica 函数计算的，并且该函数在独立介质变量中是非线性的，那么如果使用 Modelica.Fluid 库中的 FluidPort 接口，在每个连接点都会出现非线性方程组。只有当上述规则得到满足时，工具才能在大多数情况下消除这些非线性方程组。
</p>
<p>
FluidPort 接口的基本思想是，可以将两个或多个组件连接在一起，并且自动在连接点处满足质量和能量平衡，即生成理想混合方程。请注意，动量平衡仅在直线连接时是正确的。如果“理想混合”不足，则必须引入一个特殊组件来定义混合方程。
</p>
<p>
组件中的质量和动量平衡方程是从沿管道流动方向的偏微分方程推导出来的：
</p>
<p>
<img src=\"D:/GDM/SYSLINK/modelica2/Modelica/Resources/Images/Media/UsersGuide/MediumDefinition/BalanceEquations1.png\" alt=\"\" data-href=\"\" style=\"\"/>
</p>
<p>
请注意，F<sub>F</sub> 是 fanning 摩擦系数。能量平衡可以以不同的形式给出。通常，它表示为：
</p>
<p>
<img src=\"D:/GDM/SYSLINK/modelica2/Modelica/Resources/Images/Media/UsersGuide/MediumDefinition/EnergyBalance1.png\" alt=\"\" data-href=\"\" style=\"\"/>
</p>
<p>
这种形式描述了容积的内能、动能和势能的变化，作为流入和流出流体的函数。将动量平衡乘以流速 v 并从上述能量平衡中减去，得到以下能量平衡的替代形式：
</p>
<p>
<img src=\"D:/GDM/SYSLINK/modelica2/Modelica/Resources/Images/Media/UsersGuide/MediumDefinition/EnergyBalance2.png\" alt=\"\" data-href=\"\" style=\"\"/>
</p>
<p>
这种形式的优点是动能和势能不再是能量平衡的一部分，因此能量平衡大大简化了（例如，由于速度存在于能量平衡中，第一种形式会出现额外的非线性方程组；在第二种形式中，这种情况不会发生，并且它在高速情况下仍然有效）。
</p>
<p>
现在假设上述能量平衡的第二种形式用于所有组件，并且所有组件都使用以下 FluidPort 接口：
</p>
<pre><code >connector FluidPort
replaceable package Medium = Modelica.Media.Interfaces.PartialMedium;
Medium.AbsolutePressure      p;
flow Medium.MassFlowRate     m_flow;

Medium.SpecificEnthalpy      h;
flow Medium.EnthalpyFlowRate H_flow;

Medium.MassFraction          Xi    [Medium.nXi];
flow Medium.MassFlowRate     mX_flow[Medium.nXi];
end FluidPort;
</code></pre><p>
例如，假设将三个组件连接在一起，并且介质是单一物质流体。这将产生以下连接方程：
</p>
<pre><code >p1=p2=p3;
h1=h2=h3;
0 = m_flow1 + m_flow2 + m_flow3;
0 = H_flow1 + H_flow2 + H_flow3;
</code></pre><p>
这些是连接点内一个微小容积的质量平衡和能量平衡（形式2），假设在此容积中没有储存质量或能量。换句话说，连接方程是描述理想混合的方程。在假设三个流的速度矢量相同（特别是它们是平行的）的情况下，动量平衡也得到了满足：
</p>
<pre><code >0 = m_flow1*v1 + m_flow2*v2 + m_flow3*v3;
= v*(m_flow1 + m_flow2 + m_flow3);
= 0;
</code></pre><p>
因此，通过上述接口可以以几乎任意方式连接组件，因为每个连接自动满足平衡方程。然而，这种方法有一个缺点：如果将两个组件连接在一起，则连接器两侧的介质变量是相同的，由于连接器，只存在两个方程
</p>
<pre><code >p1 = p2;
h1 = h2;
</code></pre><p>
假设 p,T 是独立介质变量，并且介质性质是在连接的一侧计算的。这意味着，基本上存在以下方程：
</p>
<pre><code >h1 = h(p1,T1);
h2 = h(p2,T2);
p1 = p2;
h1 = h2;
</code></pre><p>
这些方程可以通过以下方式求解：
</p>
<pre><code >h1 := h(p1,T1)
p2 := p1;
h2 := h1;
0  := h2 - h(p2,T2);   // T2 的非线性方程组
</code></pre><p>
这意味着 T2 是通过求解非线性方程组计算的。如果 h1 和 h2 是通过 Modelica 函数提供的，Modelica 编译器可以将这个非线性方程组替换为以下方程：
</p>
<pre><code >T2 := T1;
</code></pre><p>
因为在别名替换之后，有两个函数调用
</p>
<pre><code >h1 := h(p1,T1);
h1 := h(p1,T2);
</code></pre><p>
由于函数调用的左侧和第一个参数相同，第二个参数 T1 和 T2 必须相同，因此 T2 := T1。这种类型的分析只有在比焓定义为独立介质变量的函数时才有可能。
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"  ));
      end SpecificEnthalpyAsFunction;

      class StaticStateSelection "静态状态选择"
        extends Modelica.Icons.Information;

        annotation(Documentation(info = "<html><p>
在实现介质模型时，如果没有预先采取预防措施，则在使用介质模型时很容易出现非线性代数方程组。本节解释了如何避免由不必要的动态状态选择导致的非线性方程组。
</p>
<p>
介质模型应以一种方式实现，使得工具能够在平衡容积中静态地（在翻译期间）选择介质的状态。这只有在以特定方式编写介质方程时才有可能。否则，工具必须在模拟过程中动态选择状态。由于介质方程通常是非线性的，这意味着在每个平衡容积中都会出现非线性代数方程组。
</p>
<p>
假设平衡容积中的介质方程以以下方式定义：
</p>
<pre><code >package Medium = Modelica.Media.Interfaces.PartialMedium;
Medium.BaseProperties medium;
equation
// 质量平衡
der(M)  = port_a.m_flow + port_b.m_flow;
der(MX) = port_a_mX_flow + port_b_mX_flow;
M = V*medium.d;
MX = M*medium.X;

// 能量平衡
U = M*medium.u;
der(U) = port_a.H_flow+port_b.H_flow;
</code></pre><p>
<strong>单一物质介质</strong>
</p>
<p>
由单一物质组成的介质必须定义 \"p,T,d,u,h\" 中的两个变量，并设置 stateSelect=StateSelect.prefer，如果 BaseProperties.preferredMediumStates = <strong>true</strong>，并且必须提供其他三个变量作为这些状态的函数。这导致：
</p>
<ul><li>
静态状态选择（无动态选择）。</li>
<li>
两个状态导数的线性方程组。</li>
</ul><p>
<strong>单一物质介质示例</strong>
</p>
<p>
p, T 是优选状态（即，设置了 StateSelect.prefer），并且有三个方程以以下形式编写：
</p>
<pre><code >d = fd(p,T)
u = fu(p,T)
h = fh(p,T)
</code></pre><p>
指数减少导致以下方程：
</p>
<pre><code >der(M) = V*der(d)
der(U) = der(M)*u + M*der(u)
der(d) = der(fd,p)*der(p) + der(fd,T)*der(T)
der(u) = der(fu,p)*der(p) + der(fu,T)*der(T)
</code></pre><p>
请注意，<strong>der</strong>(y,x) 是 y 关于 x 的偏导数，并且此运算符在 Modelica 中仅用于声明偏导数函数，见<a href=\"https://specification.modelica.org/v3.4/Ch12.html#partial-derivatives-of-functions\" target=\"\">Modelica 3.4 规范第 12.7.2 节（函数的偏导数）</a>。
</p>
<p>
上述方程意味着，如果 p,T 是从积分器提供的状态，则所有函数，如 fd(p,T) 或 <strong>der</strong>(fd,p) 都可以作为状态的函数进行求值。通过消元 <strong>der</strong>(M), <strong>der</strong>(U), <strong>der</strong>(d), <strong>der</strong>(u)，整个系统得到了 <strong>der</strong>(p) 和 <strong>der</strong>(T) 的线性方程组。
</p>
<p>
<strong>单一物质介质反例</strong>
</p>
<p>
一个单一物质的理想气体形式如下
</p>
<pre><code >redeclare model extends BaseProperties(
T(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
p(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default)
equation
h = h(T);
u = h - R_s*T;
p = d*R_s*T;
...
end BaseProperties;
</code></pre><p>
如果 p, T 是优选状态，则这些方程<strong>不是</strong>以推荐形式编写的，因为 d 不是 p 和 T 的函数。如果 p,T 是状态，则需要求解密度：
</p>
<pre><code >d = p/(R_s*T)
</code></pre><p>
如果 T 或 R_s 为零，这将导致除以零。工具不知道 R_s 或 T 不能为零。因此，工具必须假定 p, T <strong>不能</strong> 始终被选择为状态，必须使用另一种静态状态选择或动态状态选择。唯一的其他静态状态选择是 d,T，因为 h,u,p 是 d,T 的函数。 然而，作为潜在状态，只有出现在微分方程中的变量和声明为 StateSelect.prefer 或 StateSelect.always 的变量才会被使用。由于“d”没有出现在微分方程中，并且声明为 StateSelect.default，因此不能被选择为状态。 因此，工具必须在模拟过程中动态选择状态。由于上述方程是非线性的，并且它们用于动态状态选择，因此在每个平衡容积中存在一个非线性方程组。
</p>
<p>
总结，对于单一物质的理想气体介质，有以下两种可能性来实现静态状态选择和线性方程组：
</p>
<ol><li>
使用 p,T 作为优选状态，并以以下形式编写密度方程：d = p/(T*R_s)</li>
<li>
使用 d,T 作为优选状态，并以以下形式编写压力方程：p = d*T*R_s</li>
</ol><p>
所有其他设置（其他/无优选状态等）都会导致动态状态选择和平衡容积的非线性方程组。
</p>
<p>
<strong>多物质介质</strong>
</p>
<p>
由多种物质组成的介质必须定义 \"p,T,d,u,h\" 中的两个变量以及质量分数 Xi，并设置 stateSelect=StateSelect.prefer（如果 BaseProperties.preferredMediumStates = <strong>true</strong>），并且必须提供其他三个变量作为这些状态的函数。只有这样，工具才能进行静态选择。
</p>
<p>
<strong>多物质介质示例：</strong>
</p>
<p>
p, T 和 Xi 定义为优选状态，方程以以下形式编写：
</p>
<pre><code >d = fp(p,T,Xi);
u = fu(p,T,Xi);
h = fh(p,T,Xi);
</code></pre><p>
由于平衡方程以以下形式编写：
</p>
<pre><code >M = V*medium.d;
MXi = M*medium.Xi;
</code></pre><p>
在平衡方程中出现在微分方程中的变量 M 和 MXi 以 d 和 Xi 的函数形式提供，并且由于 d 是 p, T 和 Xi 的函数，因此可以直接从所需状态计算 M 和 MXi。这意味着可以进行静态状态选择。
</p>
<p>
<br>
</p>
</html>"  ));
      end StaticStateSelection;

      class TestOfMedium "介质测试"
        extends Modelica.Icons.Information;

        annotation(Documentation(info = "<html>
<p>
在实现新的介质模型后，应该对其进行测试。已经提供了一个基本测试模型 Modelica.Media.Examples.Utilities.PartialTestModel，可以按以下方式使用：
</p>

<blockquote><pre>
<strong>model</strong> TestOfMyMedium
<strong>extends</strong> Modelica.Media.Examples.Utilities.PartialTestModel(
    <strong>redeclare package</strong> Medium = MyMedium);
<strong>end</strong> TestOfMyMedium;
</pre></blockquote>

<p>
可能需要根据介质的有效范围调整或更改初始值。上述模型应能翻译并模拟。如果介质模型按照前面章节（以及 Modelica 译码器具有适当的算法实现）中给出的建议编写，则应在各处仅进行静态状态选择，并且不存在非线性方程组，前提是 h 是一个独立的介质变量或只是 T 的函数。如果 h 是例如 h=h(p,T) 的函数，则会出现一个无法避免的非线性方程组。
</p>

<p>
上述测试模型可用于测试最基本的属性。当然，还应进行更多测试。
</p>

</html>"  ));
      end TestOfMedium;
      annotation(DocumentationClass = true, Documentation(info = "<html><p>
如果要引入一个新的介质模型，请将库 <a href=\"modelica://Modelica.Media.Interfaces.TemplateMedium\" target=\"\"> Modelica.Media.Interfaces.TemplateMedium</a> 复制到所需位置，移除库中的 \"partial\" 关键字，并提供 Modelica 源代码注释中要求的信息。 这里给出了 TemplateMedium 库不同部分的更详细描述：
</p>
<ol><li>
<a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition.BasicStructure\" target=\"\"> 介质接口的基本结构</a></li>
<li>
<a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition.BasicDefinition\" target=\"\"> 介质模型的基本定义</a></li>
<li>
<a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition.MultipleSubstances\" target=\"\"> 多种物质</a></li>
<li>
<a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition.SpecificEnthalpyAsFunction\" target=\"\"> 作为函数的比焓</a></li>
<li>
<a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition.StaticStateSelection\" target=\"\"> 静态状态选择</a></li>
<li>
<a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition.TestOfMedium\" target=\"\"> 介质模型测试</a></li>
</ol></html>"  ));

    end MediumDefinition;

    class ReleaseNotes "发布说明"
      extends Modelica.Icons.ReleaseNotes;
      annotation(Documentation(info = "<html><h4>Version included in Modelica 3.0</h4><p>
请参阅 MSL 的顶级发布说明。
</p>
<h4>Version 1.0, 2005-03-01</h4><p>
库中有许多改进，例如提供理想气体的混合物、基于表格的介质、所有介质的测试套件、改进和更新的用户指南。
</p>
<h4>Version 0.9, 2004-10-18</h4><ul><li>
将库内的重声明/扩展从实验特性更改为 Modelica 2.1 引入的语言关键词。</li>
<li>
重新引入库\"Water.SaltWater\"以测试物质混合物（该介质模型不描述水和盐的真实混合）。</li>
<li>
开始改进 Modelica.Media.UsersGuide.MediumDefinition.BasicStructure 中的文档</li>
</ul><h4>Version 0.792, 2003-10-28</h4><p>
这是在 Modelica 2003 会议上首次向公众提供的版本（供评估）。
</p>
</html>"  ));
    end ReleaseNotes;

    class Contact "联系方式"
      extends Modelica.Icons.Contact;
      annotation(Documentation(info = "<html><h4>库负责人和主要作者</h4><p>
<strong>Hubertus Tummescheit</strong><br> Modelon AB<br> Ideon Science Park<br> SE-22730 Lund, Sweden<br> email: <a href=\"mailto:Hubertus.Tummescheit@Modelon.se\" target=\"\">Hubertus.Tummescheit@Modelon.se</a>
</p>
<h4>致谢</h4><p>
这个库的开发是一个合作的成果，许多人作出了贡献：
</p>
<ul><li>
介质模型的主要部分由 Hubertus Tummescheit 在 ThermoFluid 库中实现， 并得到了 Jonas Eborn 和 Falko Jens Wagner 的帮助。这些介质模型已被转换为 Modelica.Media 接口定义， 并由 Hubertus Tummescheit 进行了改进。</li>
<li>
Modelica.Media 库开发的工作由 Martin Otter 组织，他也参与了设计， 实现了部分通用模型，贡献了用户指南并提供了通用测试套件 Modelica.Media.Examples.Tests。</li>
<li>
基于库的介质模型接口的基本想法来自 Michael Tiller，他也参与了设计。</li>
<li>
介质模型接口的初步设计来自 Hilding Elmqvist。在以下 Modelica 设计会议上， 设计和实现得到了进一步改进：<br> Dearborn, Nov. 20-22, 2002<br> Dearborn, Sept. 2-4, 2003<br> Lund Jan. 28-30, 2004<br> Munich, May 26-28, 2004<br> Lund, Aug. 30-31, 2004<br> Dearborn, Nov. 15-17, 2004<br> Cremona Jan. 31 - Feb. 2, 2005。</li>
<li>
Hans Olsson, Sven Erik Mattsson 和 Hilding Elmqvist 开发了符号转换算法，并在 Dymola 中实现， 显著提高了效率（例如，避免非线性方程组）。</li>
<li>
Katrin Pröß 实现了湿空气模型。</li>
<li>
Rüdiger Franke 进行了 Modelica.Media 和 Modelica_Fluid 库的首次实际测试，并提供了宝贵的反馈。</li>
<li>
Francesco Casella 是最不懈的工作者，是水及理想气体性质测试者。他也对用户指南作出了贡献。</li>
<li>
John Batteh, Daniel Bouskela, Jonas Eborn, Andreas Idebrant, Charles Newman, Gerhart Schmitz 和 ThermoFluid 库的用户提供了许多有用的评论和反馈。</li>
</ul><p>
<br>
</p>
</html>"  ));
    end Contact;

    annotation(DocumentationClass = true, Documentation(info = "<html><p>
<strong>Modelica.Media</strong>库是一个<strong>免费的</strong>Modelica库，
提供流体介质模型的标准接口和基于此接口的特定介质模型。
<span style=\"color: rgba(0, 0, 0, 0.9); background-color: rgb(255, 255, 255); font-size: 16px;\">
流</span>体介质模型为组件模型的<strong>质量</strong>和<strong>能量</strong>平衡中所使用的强度热力学变量定义<strong>代数</strong>方程。 
另外，还可以计算动力黏度或导热系数等附加介质性质。介质模型可以为<strong>单一</strong>和<strong>多种物质</strong>的流体，
并且可以是<strong>单相</strong>和<strong>多相</strong>的。
</p>
<p>
该库的很大一部分提供了可直接使用的特定介质模型。该库可用于所有类型的 Modelica 流体库，
这些库可能具有不同的连接器和设计理念。它尤其适用于 Modelica.Fluid 库（用于单相和多相单质和混合物流动的一维热流体流动组件）。
Modelica.Media 库具有以下主要功能：
</p>
<li>
平衡方程和介质模型方程相互独立。 这意味着所使用的介质模型通常不会影响平衡方程的计算。
例如，对于使用压力和温度或压力和比焓作为自变量的介质，以及不可压缩和可压缩介质模型，都使用相同的平衡方程。
Modelica 工具将有足够的信息生成与传统（耦合）定义一样高效的代码。
此功能在 <a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition.StaticStateSelection\" target=\"\">静态状态选择</a>&nbsp;
部分中有更详细的描述。</li>
<li>
动力黏度等可选变量只有在相应组件需要时才会计算。</li>
<li>
介质模型的自变量不影响流体连接接口的定义。 特别地，介质模型的实现方式使得连接器仅需包含最少数量的独立介质变量，
同时仍能获得与通过连接器传递所有介质变量（将流体端口从一个组件传递至下一组件）相同的计算效率（后一种方法的限制在于单个流体端口仅能连接两个组件，无法实现多组件互联）。
请注意，Modelica.Fluid 库使用第一种方法，即在连接器中包含一组独立的介质变量。</li>
<li>
介质模型的实现考虑到高效的动态模拟。例如，两相介质模型在相变边界触发状态事件（因为介质变量在该点上不可微分）。</li>
<p>
本用户指南包括以下主要部分：
</p>
<li>
<a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage\" target=\"\">介质使用</a>&nbsp; 
&nbsp;描述如何在组件模型中使用本库中的介质模型。</li>
<li>
<a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition\" target=\"\">介质定义</a>&nbsp; 
&nbsp;描述如何定义一个新的流体介质模型。</li>
<li>
<a href=\"modelica://Modelica.Media.UsersGuide.ReleaseNotes\" target=\"\">发布说明</a>&nbsp; 
&nbsp;总结库发布的更改。</li>
<li>
<a href=\"modelica://Modelica.Media.UsersGuide.Contact\" target=\"\">联系方式</a>&nbsp; 
&nbsp;提供关于库作者的信息以及致谢。</li>
</html>"  ));
  end UsersGuide;

  package Examples "物性模型使用示例"

    extends Modelica.Icons.ExamplesPackage;

    model SimpleLiquidWater "Water.SimpleLiquidWater介质模型示例"
      extends Modelica.Icons.Example;

      parameter SI.Volume V = 1 "容积";
      parameter SI.EnthalpyFlowRate H_flow_ext = 1.e6 
        "流入容积的恒定焓流";

      package Medium = Water.ConstantPropertyLiquidWater(SpecificEnthalpy(max = 
        1e6)) "介质模型" annotation();
      Medium.BaseProperties medium(T(start = 300, fixed = true));

      Medium.BaseProperties medium2;
      Medium.ThermodynamicState state;
      Real m_flow_ext2;
      Real der_p;
      Real der_T;

      SI.Mass m(start = 1.0);
      SI.InternalEnergy U;

      // 使用介质中的类声明
      Medium.MassFlowRate m_flow_ext;
      Medium.DynamicViscosity eta = Medium.dynamicViscosity(state);
      Medium.SpecificHeatCapacity cv = Medium.specificHeatCapacityCv(state);
    equation
      medium.p = 1.0e5;
      m = medium.d * V;
      U = m * medium.u;

      // 质量平衡
      der(m) = m_flow_ext;

      // 能量平衡
      der(U) = H_flow_ext;

      // 平滑状态
      medium2.p = 1e5 * time / 10;
      medium2.T = 330;
      m_flow_ext2 = time - 30;
      state = Medium.setSmoothState(
        m_flow_ext2, 
        medium.state, 
        medium2.state, 
        10);
      der_p = der(state.p);
      der_T = der(state.T);
      annotation(experiment(StopTime = 100), Documentation(info = "<html>

</html>"));
    end SimpleLiquidWater;

    model IdealGasH2O "理想气体H2O介质模型示例"
      extends Modelica.Icons.Example;
      package Medium = IdealGases.SingleGases.H2O "介质模型" annotation();
      Medium.ThermodynamicState state "热力状态";
      Medium.ThermodynamicState state2;
      Medium.SpecificHeatCapacity cp = Medium.specificHeatCapacityCp(state);
      Medium.SpecificHeatCapacity cv = Medium.specificHeatCapacityCv(state);
      Medium.IsentropicExponent k = Medium.isentropicExponent(state);
      Medium.SpecificEntropy s = Medium.specificEntropy(state);
      //  Medium.SpecificEntropy s2=Medium.specificEntropy(state2);
      Medium.VelocityOfSound a = Medium.velocityOfSound(state);
      Real beta = Medium.isobaricExpansionCoefficient(state);
      Real gamma = Medium.isothermalCompressibility(state);
      Medium.SpecificEnthalpy h_is = Medium.isentropicEnthalpyApproximation(2.0, 
        state);

      Medium.ThermodynamicState smoothState;
      Real m_flow_ext;
      Real der_p;
      Real der_T;

    equation
      state.p = 100000.0;
      state.T = 200 + 1000 * time;
      state2.p = 2.0e5;
      state2.T = 500.0;
      //  s2 = s;

      // 平滑状态
      m_flow_ext = time - 0.5;
      smoothState = Medium.setSmoothState(
        m_flow_ext, 
        state, 
        state2, 
        0.1);
      der_p = der(smoothState.p);
      der_T = der(smoothState.T);

      annotation(Documentation(info = "<html><p>
使用理想气体属性以及如何计算等熵焓变化的示例。所实现的函数为近似实现，但通常具有较高精度——第二个介质记录medium2的引入，正是为了对比评估该近似方法的准确性。
</p>
</html>"), experiment(StopTime = 1));
    end IdealGasH2O;

    model WaterIF97 "WaterIF97介质模型示例"
      extends Modelica.Icons.Example;
      package Medium = Water.StandardWater "介质模型" annotation();
      Medium.BaseProperties medium(
        p(start = 1.e5, 
        fixed = true, 
        stateSelect = StateSelect.prefer), 
        h(start = 1.0e5, 
        fixed = true, 
        stateSelect = StateSelect.prefer), 
        T(start = 275.0), 
        d(start = 999.0));
      SI.Volume V(start = 0.1, fixed = true);
      parameter SI.VolumeFlowRate dV = 0.0 
        "容积的恒定时间导数";
      parameter Medium.MassFlowRate m_flow_ext = 0 
        "流入容积的恒定质量流量";
      parameter Medium.EnthalpyFlowRate H_flow_ext = 10000 
        "流入容积的恒定焓流";
      SI.Mass m "容积的质量";
      SI.InternalEnergy U "容积的内能";

      Medium.ThermodynamicState state2;
      Medium.ThermodynamicState state;
      Real m_flow_ext2;
      Real der_p;
      Real der_T;

    equation
      der(V) = dV;
      m = medium.d * V;
      U = m * medium.u;

      // 质量守恒
      der(m) = m_flow_ext;

      // 能量守恒
      der(U) = H_flow_ext;

      // 平滑状态
      m_flow_ext2 = time - 0.5;
      state2 = Medium.setState_pT(1e5 * (1 + time), 300 + 200 * time);
      state = Medium.setSmoothState(
        m_flow_ext2, 
        medium.state, 
        state2, 
        0.05);
      der_p = der(state.p);
      der_T = der(state.T);
      annotation(Documentation(info = "<html>

</html>"), experiment(StopTime = 1));
    end WaterIF97;

    model MixtureGases "气体混合物介质模型示例"
      extends Modelica.Icons.Example;

      parameter SI.Volume V = 1 "容积1和容积2的体积";
      parameter SI.MassFlowRate m_flow_ext = 0.01 
        "流入容积1和容积2的恒定质量流量";
      parameter SI.EnthalpyFlowRate H_flow_ext = 5000 
        "流入容积1和容积2的恒定焓流";

      package Medium1 = Modelica.Media.IdealGases.MixtureGases.CombustionAir 
        "介质模型" annotation();
      Medium1.BaseProperties medium1(
        p(start = 1.e5, 
        fixed = true, 
        stateSelect = StateSelect.prefer), 
        T(start = 300, 
        fixed = true, 
        stateSelect = StateSelect.prefer), 
        X(start = {0.8, 0.2}));
      Real m1(quantity = Medium1.mediumName, start = 1.0);
      SI.InternalEnergy U1;
      Medium1.SpecificHeatCapacity cp1 = Medium1.specificHeatCapacityCp(medium1.state);
      Medium1.DynamicViscosity eta1 = Medium1.dynamicViscosity(medium1.state);
      Medium1.ThermalConductivity lambda1 = Medium1.thermalConductivity(medium1.state);

      package Medium2 = Modelica.Media.IdealGases.MixtureGases.SimpleNaturalGas 
        "介质模型" annotation();
      Medium2.BaseProperties medium2(
        p(start = 1.e5, 
        fixed = true, 
        stateSelect = StateSelect.prefer), 
        T(start = 300, 
        fixed = true, 
        stateSelect = StateSelect.prefer), 
        X(start = {0.1, 0.1, 0.1, 0.2, 0.2, 0.3}));
      Real m2(quantity = Medium2.mediumName, start = 1.0);
      SI.InternalEnergy U2;
      Medium2.SpecificHeatCapacity cp2 = Medium2.specificHeatCapacityCp(medium2.state);
      Medium2.DynamicViscosity eta2 = Medium2.dynamicViscosity(medium2.state);
      Medium2.ThermalConductivity lambda2 = Medium2.thermalConductivity(medium2.state);

      Medium2.ThermodynamicState state2 = Medium2.setState_pTX(
        1.005e5, 
        302, 
        {0.3, 0.2, 0.2, 0.1, 0.1, 0.1});
      Medium2.ThermodynamicState smoothState;
      Real m_flow_ext2;
      Real der_p;
      Real der_T;

    equation
      medium1.X = {0.8, 0.2};
      m1 = medium1.d * V;
      U1 = m1 * medium1.u;
      der(m1) = m_flow_ext;
      der(U1) = H_flow_ext;

      medium2.X = {0.1, 0.1, 0.1, 0.2, 0.2, 0.3};
      m2 = medium2.d * V;
      U2 = m2 * medium2.u;
      der(m2) = m_flow_ext;
      der(U2) = H_flow_ext;

      // 平滑状态
      m_flow_ext2 = time - 0.5;
      smoothState = Medium2.setSmoothState(
        m_flow_ext2, 
        medium2.state, 
        state2, 
        0.2);
      der_p = der(smoothState.p);
      der_T = der(smoothState.T);
      annotation(Documentation(info = "<html>

</html>"), experiment(StopTime = 1));
    end MixtureGases;

    model MoistAir "湿空气介质模型示例"
      extends Modelica.Icons.Example;
      package Medium = Air.MoistAir "介质模型" annotation();
      Medium.BaseProperties medium(
        T(start = 274.0, fixed = true), 
        X(start = {0.95, 0.05}), 
        p(start = 1.0e5, fixed = true));
      //  Medium.SpecificEntropy s=Medium.specificEntropy(medium);
      //  Medium.SpecificEnthalpy h_is = Medium.isentropicEnthalpyApproximation(medium, 2.0e5);
      parameter Medium.MolarMass[2] MMx = {Medium.dryair.MM, Medium.steam.MM} 
        "摩尔质量向量(由干空气和水蒸气组成)";
      Medium.MolarMass MM = 1 / ((1 - medium.X[1]) / MMx[1] + medium.X[1] / MMx[2]) 
        "混合物气体部分的摩尔质量";
      //  Real[4] dddX=Medium.density_derX(medium,MM);

      Medium.ThermodynamicState state1;
      Medium.ThermodynamicState state2;
      Medium.ThermodynamicState smoothState;
      Real m_flow_ext;
      Real der_p;
      Real der_T;
    protected
      constant SI.Time unitTime = 1;
    equation
      der(medium.p) = 0.0;
      der(medium.T) = 90;
      medium.X[Medium.Air] = 0.95;
      //    medium.X[Medium.Water] = 0.05;
      // one simple assumption only for quick testing:
      //  medium.X_liquidWater = if medium.X_sat < medium.X[2] then medium.X[2] - medium.X_sat else 0.0;

      // 平滑状态
      m_flow_ext = time - 0.5;
      state1.p = 1.e5 * (1 + time);
      state1.T = 300 + 10 * time;
      state1.X = {time, 1 - time} / unitTime;
      state2.p = 1.e5 * (1 + time / 2);
      state2.T = 340 - 20 * time;
      state2.X = {0.5 * time, 1 - 0.5 * time} / unitTime;
      smoothState = Medium.setSmoothState(
        m_flow_ext, 
        state1, 
        state2, 
        0.2);
      der_p = der(smoothState.p);
      der_T = der(smoothState.T);
      annotation(Documentation(info = "<html>

</html>"), experiment(StopTime = 1.0, Tolerance = 1e-005));
    end MoistAir;

    model PsychrometricData "计算焓湿图曲线绘图数据"
      extends Modelica.Icons.Example;
      package Medium = Modelica.Media.Air.MoistAir "介质模型" annotation();
      parameter SI.Pressure p_const = 1e5 "压力";
      parameter Integer n_T = 11 "等温线数量";
      parameter SI.Temperature T_min = 253.15 "最低等温线";
      parameter SI.Temperature T_step = 10 
        "两根等温线间的温度步长";
      parameter Integer n_h = 16 "等比焓线数目";
      parameter SI.SpecificEnthalpy h_min = -20e3 
        "最低等比焓线";
      parameter SI.SpecificEnthalpy h_step = 1e4 
        "两根等比焓线间的比焓步长";
      parameter Integer n_phi = 10 
        "等相对湿度线数目";
      parameter Real phi_min = 0.1 "最低等湿线";
      parameter Real phi_step = 0.1 "两根等湿线间的步长";
      parameter SI.MassFraction x_min = 0.00 
        "图中的最小绝对湿度";
      parameter SI.MassFraction x_max = 0.03 
        "图中的最大绝对湿度";
      parameter SI.Time t = 1 "仿真时间";

      final parameter SI.Temperature[n_T] T_const = {T_min - T_step + i * 
        T_step for i in 1:n_T} "恒定温度";
      final parameter SI.SpecificEnthalpy[n_h] h_const = {(i - 1) * h_step + 
        h_min for i in 1:n_h} "恒定比焓";
      final parameter Real[n_phi] phi_const = {(i - 1) * phi_step + phi_min for i in 
        1:n_phi} "恒定相对湿度";
      final parameter Real diagSlope = Medium.enthalpyOfVaporization(273.15) 
        "旋转图表，使零度等温线在雾区之外成为水平线";
      final parameter SI.MassFraction x_start = x_min 
        "初始绝对湿度(kg水/kg干空气)";

      SI.MassFraction x(start = x_start) 
        "绝对湿度(kg水/kg干空气)";
      SI.SpecificEnthalpy[n_T] hx_T "恒定温度下的h_1+x";
      SI.SpecificEnthalpy[n_h] hx_h(start = h_const, each fixed = true) 
        "恒定h_1+x";
      SI.SpecificEnthalpy[n_phi] hx_phi "恒定相对湿度下的h_1+x";
      SI.SpecificEnthalpy[n_T] y_T "恒定温度下的焓图";
      SI.SpecificEnthalpy[n_h] y_h "恒定比焓下的焓图";
      SI.SpecificEnthalpy[n_phi] y_phi "恒定相对湿度的焓图";
      Medium.BaseProperties[n_T] medium_T "恒定温度下的介质物性";
      Medium.BaseProperties[n_phi] medium_phi "恒定相对湿度的介质物性";

    protected
      SI.Pressure[n_phi] ps_phi "等湿线上的饱和压力";
      SI.Temperature[n_phi] T_phi(each start = 290);
      Boolean[n_T] fog(start = fill(false, n_T)) 
        "在等温线与phi=1相交处是否触发事件";
      SI.Pressure[n_T] pd "沿等温线的蒸汽分压";
    initial equation
      x = x_min;
    equation

      der(x) = (x_max - x_min) / t;

      for i in 1:n_T loop
        medium_T[i].T = T_const[i];
        medium_T[i].p = p_const;
        medium_T[i].Xi = {x / (1 + x)};
        hx_T[i] = medium_T[i].h * (medium_T[i].x_water + 1);
        y_T[i] = hx_T[i] - diagSlope * x;

        // 触发事件
        pd[i] = medium_T[i].Xi[1] * medium_T[i].MM / Medium.MMX[1] * p_const;
        fog[i] = pd[i] >= Medium.saturationPressure(T_const[i]);
      end for;
      for i in 1:n_h loop
        der(hx_h[i]) = 0.0;
        y_h[i] = hx_h[i] - diagSlope * x;
      end for;
      for i in 1:n_phi loop
        medium_phi[i].p = p_const;
        ps_phi[i] = p_const * x / phi_const[i] / (Medium.k_mair + x);
        T_phi[i] = if x < 5e-6 then 200 else Medium.saturationTemperature(
          ps_phi[i]);
        medium_phi[i].T = T_phi[i];
        medium_phi[i].Xi = {x / (1 + x)};
        hx_phi[i] = medium_phi[i].h * (medium_phi[i].x_water + 1);
        y_phi[i] = hx_phi[i] - diagSlope * x;
      end for;

      annotation(Documentation(info = "<html><p>
该模型可从本资料库的湿空气模型中生成气压数据，并绘制成图表。最常见的两种图表是莫利图和湿度图。前者在一些欧洲国家广泛使用，而后者在英美国家更为常见。在莫利图中，比热是根据绝对湿度绘制的，而在湿度图中则相反。<br> 必须注意的是，两个轴变量的关系并非直角，绝对湿度的斜率等于 0 °C 时的汽化焓。为了更好地读取和减少雾区，可将湿度轴旋转以获得直角图。这两种图表通常都包含附加信息，如等值线或热量比的辅助刻度。本模式和以下图表省略了这些信息。湿度图数据的其他重要特征包括：所有质量特定变量（如绝对湿度、比焓等）均以千克干空气为单位表示，并且在 0 °C 和零湿度条件下，它们的基准焓值为 0。
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Media/Air/Mollier.png\"><br>
<img src=\"modelica://Modelica/Resources/Images/Media/Air/PsycroChart.png\">
</div>
<p>
<strong>图例:</strong> 蓝色 - 恒定比焓，红色 - 恒定温度，黑色 - 恒定相对湿度
</p>
<p>
该模型在莫利图表或湿度图表中提供恒定比焓、温度和相对湿度线的数据，如上图所示。有关限制和有效范围，请参阅 <a href=\"modelica://Modelica.Media.Air.MoistAir\" target=\"\">MoistAir package description</a>。在该模型中，绝对湿度<strong> x</strong> 随时间增加。为绘制图表而调整的比焓可从以下公式中获得：
</p>
<ul><li>
<strong>y_h</strong>: 恒定比焓</li>
<li>
<strong>y_T</strong>: 恒定温度</li>
<li>
<strong>y_phi</strong>: 恒定相对湿度</li>
</ul></html>"), experiment(StopTime = 1.0, Interval = 0.001));
    end PsychrometricData;

    package TwoPhaseWater "扩展StandardWater介质库"
      extends Modelica.Media.Water.StandardWater;
      redeclare model extends BaseProperties 
        "使StandardWater.BaseProperties不可替换，以便在模型ExtendedProperties中可继承"
        annotation();
      end BaseProperties;

      model ExtendedProperties "两相物性"
        extends BaseProperties;
        ThermodynamicState dew "露点线上物性";
        ThermodynamicState bubble "泡点线上物性";
        ThermodynamicState bubble2 "泡点线上物性，在两相侧";
        DynamicViscosity eta "粘度如果处于两相状态,则使用McAdams混合规则)";
        DynamicViscosity eta_d "露点线上粘度";
        DynamicViscosity eta_b "泡点线上粘度";
        ThermalConductivity lambda_d "露点线上导热系数";
        ThermalConductivity lambda_b "泡点线上导热系数";
        SpecificHeatCapacity cp_d "露点线上比热";
        SpecificHeatCapacity cp_b "泡点线上比热";
        Real ddhp;
        Real ddhp_d;
        Real ddhp_b "导数";
        Real ddph;
        Real ddph_d;
        Real ddph_b "导数";
        Real ddhp_b2;
        Real ddph_b2 "导数";
        // 无导数
        MassFraction x "蒸汽质量分数";
        Real dTp;
        Real dTp2;
        SpecificEntropy s_b;
        SpecificEntropy s_d;
      equation
        eta = if phase == 1 then dynamicViscosity(state) else 1 / (x / eta_d + (1 - x) 
          / eta_b);
        dew = setDewState(sat);
        bubble = setBubbleState(sat);
        bubble2 = setBubbleState(sat, 2);
        x = (h - bubble.h) / max(dew.h - bubble.h, 1e-6);
        eta_d = dynamicViscosity(dew);
        eta_b = dynamicViscosity(bubble);
        lambda_d = thermalConductivity(dew);
        lambda_b = thermalConductivity(bubble);
        cp_d = specificHeatCapacityCp(dew);
        cp_b = specificHeatCapacityCp(bubble);
        s_d = specificEntropy(dew);
        s_b = specificEntropy(bubble);
        ddph = density_derp_h(state);
        ddph_d = density_derp_h(dew);
        ddph_b = density_derp_h(bubble);
        ddhp = density_derh_p(state);
        ddhp_d = density_derh_p(dew);
        ddhp_b = density_derh_p(bubble);
        ddhp_b2 = density_derh_p(bubble2);
        ddph_b2 = density_derp_h(bubble2);
        dTp = saturationTemperature_derp(p);
        dTp2 = (1 / dew.d - 1 / bubble.d) / max(s_d - s_b, 1e-6);
        annotation(Documentation(info = "<html>
</html>"));
      end ExtendedProperties;

      model TestTwoPhaseStates "两相水模型测试"
        extends Modelica.Icons.Example;
        ExtendedProperties medium(p(start = 2000.0, fixed = true), h(start = 8.0e5, 
          fixed = true));
        parameter Real dh(unit = "J/(kg.s)", displayUnit = "kJ/(kg.s)") = 80000.0 "介质比焓的导数";
        parameter Real dp(unit = "Pa/s", displayUnit = "bar/s") = 1.0e6 "介质压力的导数";
      equation
        der(medium.p) = dp;
        der(medium.h) = dh;
        annotation(experiment(StopTime = 22, Interval = 0.01), Documentation(info = "<html><p>
详细信息请参阅示例TwoPhaseWater库的说明文档。
</p>
</html>"));
      end TestTwoPhaseStates;
      annotation(Documentation(info = "<html><h4>示例：TwoPhaseWater</h4>
<p>TwoPhaseWater库演示了如何用标准水库中的最小属性集扩展简洁的 BaseProperties，使其具有两相情况下所需的大多数属性。该模型还演示了如何计算介质模型的附加属性。在这种情况下，建立的新介质模型比默认模型具有更多的属性，标准 BaseProperties 被用作基础。对于附加属性，用户必须：</h4><ol><li>
声明所需类型的新变量，例如，\"<span style=\"color: rgb(51, 51, 255);\">DynamicViscosity eta</span>\"。</li>
<li>
通过调用库中的函数计算该变量，例如，<span style=\"color: rgb(51, 51, 255);\">eta = dynamicViscosity(state)</span>。请注意，ThermodynamicState的实例用作函数的输入。这个实例“state”在PartialMedium中声明，因此在每个介质模型中都可用。用户不必知道计算动力黏度所需的实际变量，因为状态实例保证包含所需的内容。</li>
<li>
<span style=\"color: rgb(255, 0, 0);\">注意</span>： 在两相区域中，许多属性的定义并不完善，如果在该区域调用函数，可能会返回不想要的值。用户有责任处理这种情况。本示例使用几种可能的模型之一来计算两相流的平均黏度。在两相模型中，通常需要在两相圆顶外部的相边界（就在边界上）计算特性。为了计算那里的热力学状态，我们提供了两个辅助函数：<strong>setDewState(sat)</strong> 和 <strong>setBubbleState(sat)</strong>。它们将 SaturationProperties 的一个实例作为输入。默认情况下，它们处于单相状态，但如果将可选的相位参数设置为 2，则输出会强制处于相边界内。只有在计算 cv 等导数时才需要这样做，因为边界两侧的导数是不同的。计算相边界属性的通常步骤如下：<br></li>
</ol><ol><li>
声明ThermodynamicState的一个实例，例如，\"ThermodynamicState dew\"。</li>
<li>
使用SaturationProperties的一个实例计算状态，例如，dew = setDewState(sat)</li>
<li>
根据需要在相界面上计算属性，例如，\"cp_d = specificHeatCapacityCp(dew)\"。<br></li>
</ol><p>
示例模型TestTwoPhaseStates测试了扩展属性
</p>
<p>
同样的过程可以用来计算其他状态点的属性，例如，在计算等熵参考状态时。
</p>
</html>"));
    end TwoPhaseWater;

    package ReferenceAir 
      "干空气和湿空气介质模型示例"
      extends Modelica.Icons.ExamplesPackage;

      model DryAir1 "干空气示例1"
        extends Modelica.Icons.Example;
        extends Modelica.Media.Examples.Utilities.PartialTestModel(
        redeclare package Medium = Modelica.Media.Air.ReferenceAir.Air_pT);
        annotation(experiment(StopTime = 1.01));
      end DryAir1;

      model DryAir2 "干空气示例2"
        extends Modelica.Icons.Example;
        extends Modelica.Media.Examples.Utilities.PartialTestModel2(
        redeclare package Medium = Modelica.Media.Air.ReferenceAir.Air_pT);
        annotation(experiment(StopTime = 1.01));
      end DryAir2;

      model MoistAir "湿空气示例"
        extends Modelica.Icons.Example;
        parameter SI.Temperature T_start = 274 
          "温度初值";
        parameter SI.Pressure p_start = 1e5 
          "压力初值";
        package Medium = Modelica.Media.Air.ReferenceMoistAir "介质模型" annotation();
        Medium.BaseProperties medium(
          T(start = T_start, fixed = true), 
          X(start = {0.95, 0.05}), 
          p(start = p_start, fixed = true));
        parameter Medium.MolarMass[2] MMx = {Medium.dryair.MM, Medium.steam.MM} 
          "摩尔质量向量(由干空气和蒸气组成)";
        Medium.MolarMass MM = 1 / ((1 - medium.X[1]) / MMx[1] + medium.X[1] / MMx[2]) 
          "混合物气体部分摩尔质量";
        Medium.ThermodynamicState state1;
        Medium.ThermodynamicState state2;
        Medium.ThermodynamicState smoothState(T(start = T_start), p(start = p_start));
        Real m_flow_ext;
        Real der_p;
        Real der_T;
      protected
        constant SI.Time unitTime = 1;
      equation
        der(medium.p) = 0.0;
        der(medium.T) = 90;
        medium.X[Medium.Air] = 0.95;
        m_flow_ext = time - 0.5;
        state1.p = 1.e5 * (1 + time);
        state1.T = 300 + 10 * time;
        state1.X = {time, 1 - time} / unitTime;
        state2.p = 1.e5 * (1 + time / 2);
        state2.T = 340 - 20 * time;
        state2.X = {0.5 * time, 1 - 0.5 * time} / unitTime;
        smoothState = Medium.setSmoothState(
          m_flow_ext, 
          state1, 
          state2, 
          0.2);
        der_p = der(smoothState.p);
        der_T = der(smoothState.T);
        annotation(experiment(StopTime = 1.0, Tolerance = 1e-005));
      end MoistAir;

      model MoistAir1 "湿空气示例1"
        extends Modelica.Icons.Example;
        extends Modelica.Media.Examples.Utilities.PartialTestModel(
        redeclare package Medium = Modelica.Media.Air.ReferenceMoistAir);
        annotation(experiment(StopTime = 1.01));
      end MoistAir1;

      model MoistAir2 "湿空气示例2"
        extends Modelica.Icons.Example;
        extends Modelica.Media.Examples.Utilities.PartialTestModel2(
        redeclare package Medium = Modelica.Media.Air.ReferenceMoistAir);
        annotation(experiment(StopTime = 1.01));
      end MoistAir2;

      model Inverse_sh_T 
        "已知h或s,根据h = h_pT(p, T),s = s_pT(p, T)求T"
        extends Modelica.Icons.Example;

        import Medium = Modelica.Media.Air.ReferenceAir.Air_pT "介质模型";

        parameter SI.Temperature T_min = 300 
          "温度从T_min(time=0)线性变化增加到T_max(time=1)";
        parameter SI.Temperature T_max = 500 
          "温度从T_min(time=0)线性变化增加到T_max(time=1)";
        parameter SI.Pressure p = 1.0e5 "压力";
        final parameter SI.SpecificEnthalpy h_min = 
          Medium.specificEnthalpy(Medium.setState_pT(p, T_min)) 
          "T_min时的比焓";
        final parameter SI.SpecificEnthalpy h_max = 
          Medium.specificEnthalpy(Medium.setState_pT(p, T_max)) 
          "T_max时的比焓";
        final parameter SI.SpecificEntropy s_min = 
          Medium.specificEntropy(Medium.setState_pT(p, T_min)) 
          "T_min时的比熵";
        final parameter SI.SpecificEntropy s_max = 
          Medium.specificEntropy(Medium.setState_pT(p, T_max)) 
          "T_max时的比熵";
        SI.SpecificEnthalpy h1 "预定义比焓";
        SI.SpecificEnthalpy h2 
          "根据T计算的比焓(= h1 required)";
        SI.SpecificEntropy s1 "预定义的比熵";
        SI.SpecificEntropy s2 
          "根据T计算的比熵 (= h1 required)";
        SI.Temperature Th "根据h1计算的温度";
        SI.Temperature Ts "根据s1计算的温度";

      protected
        constant SI.Time timeUnit = 1.0;

      equation
        // 定义比焓和比熵
        h1 = if time < 0 then h_min else if time >= 1 then h_max else h_min + time 
          / timeUnit * (h_max - h_min);
        s1 = if time < 0 then s_min else if time >= 1 then s_max else s_min + time 
          / timeUnit * (s_max - s_min);

        // 计算温度
        Th = Medium.temperature_phX(
          p, 
          h1, 
          fill(0.0, 0));
        Ts = Medium.temperature_psX(
          p, 
          s1, 
          fill(0.0, 0));

        // 检查 (h2必须与h1相等)
        h2 = Medium.specificEnthalpy_pTX(
          p, 
          Th, 
          fill(0.0, 0));
        s2 = Medium.specificEntropy_pTX(
          p, 
          Ts, 
          fill(0, 0));
        assert(abs(h1 - h2) < 1e-3, "反算h错误");
        assert(abs(s1 - s2) < 1e-3, "反算s错误");
        annotation(experiment(StopTime = 1));
      end Inverse_sh_T;

      model Inverse_sh_TX 
        "已知h或s,根据h = h_pTX(p, T, X),s = s_pTX(p, T, X)求T"
        extends Modelica.Icons.Example;

        import Medium = Modelica.Media.Air.ReferenceMoistAir "介质模型";

        parameter SI.Temperature T_min = 300 
          "温度从T_min(time=0)线性变化增加到T_max(time=1)";
        parameter SI.Temperature T_max = 500 
          "温度从T_min(time=0)线性变化增加到T_max(time=1)";
        parameter SI.Pressure p = 1.0e5 "压力";
        parameter SI.MassFraction[:] X = Modelica.Media.Air.ReferenceMoistAir.reference_X 
          "质量分数向量";
        final parameter SI.SpecificEnthalpy h_min = 
          Modelica.Media.Air.ReferenceMoistAir.specificEnthalpy(
          Modelica.Media.Air.ReferenceMoistAir.setState_pTX(
          p, 
          T_min, 
          X)) "Specific enthalpy at T_min";
        final parameter SI.SpecificEnthalpy h_max = 
          Modelica.Media.Air.ReferenceMoistAir.specificEnthalpy(
          Modelica.Media.Air.ReferenceMoistAir.setState_pTX(
          p, 
          T_max, 
          X)) "Specific enthalpy at T_max";
        final parameter SI.SpecificEntropy s_min = 
          Modelica.Media.Air.ReferenceMoistAir.specificEntropy(
          Modelica.Media.Air.ReferenceMoistAir.setState_pTX(
          p, 
          T_min, 
          X)) "Specific entropy at T_min";
        final parameter SI.SpecificEntropy s_max = 
          Modelica.Media.Air.ReferenceMoistAir.specificEntropy(
          Modelica.Media.Air.ReferenceMoistAir.setState_pTX(
          p, 
          T_max, 
          X)) "Specific entropy at T_max";
        SI.SpecificEnthalpy h1 "预定义比焓";
        SI.SpecificEnthalpy h2 
          "根据T计算的比焓(= h1 required)";
        SI.SpecificEntropy s1 "预定义的比熵";
        SI.SpecificEntropy s2 
          "根据T计算的比熵 (= h1 required)";
        SI.Temperature Th "根据h1计算的温度";
        SI.Temperature Ts "根据s1计算的温度";

      protected
        constant SI.Time timeUnit = 1.0;

      equation
        // 定义比焓
        h1 = if time < 0 then h_min else if time >= 1 then h_max else h_min + time 
          / timeUnit * (h_max - h_min);
        s1 = if time < 0 then s_min else if time >= 1 then s_max else s_min + time 
          / timeUnit * (s_max - s_min);

        // 计算温度
        Th = Medium.temperature_phX(
          p, 
          h1, 
          X);
        Ts = Medium.temperature_psX(
          p, 
          s1, 
          X);

        // 检查 (h2必须与h1相等)
        h2 = Medium.specificEnthalpy_pTX(
          p, 
          Th, 
          X);
        s2 = Medium.specificEntropy_pTX(
          p, 
          Ts, 
          X);
        assert(abs(h1 - h2) < 1e-3, "反算h错误");
        assert(abs(s1 - s2) < 1e-3, "反算s错误");

        annotation(experiment(StopTime = 1), Documentation(info = "<html>

</html>"));
      end Inverse_sh_TX;
      annotation();
    end ReferenceAir;

    package R134a "R134a介质模型示例"
      extends Modelica.Icons.ExamplesPackage;

      model R134a1 "R134a示例1"
        extends Modelica.Icons.Example;
        extends Modelica.Media.Examples.Utilities.PartialTestModel(
        redeclare package Medium = Modelica.Media.R134a.R134a_ph, 
          h_start = 107390, 
          fixedMassFlowRate(use_T_ambient = false), 
          volume(use_T_start = false), 
          ambient(use_T_ambient = false));
        annotation(experiment(StopTime = 1.01));
      end R134a1;

      model R134a2 "R134a示例2"
        extends Modelica.Icons.Example;
        extends Modelica.Media.Examples.Utilities.PartialTestModel2(
        redeclare package Medium = Modelica.Media.R134a.R134a_ph, 
          h_start = 107390, 
          fixedMassFlowRate(use_T_ambient = false), 
          volume(use_T_start = false), 
          ambient(use_T_ambient = false));
        annotation(experiment(StopTime = 1.01));
      end R134a2;
      annotation();
    end R134a;

    package SolveOneNonlinearEquation 
      "示范如何求解一个未知数的非线性方程"
      extends Modelica.Icons.ExamplesPackage;

      model Inverse_sine "已知y,求解y = A*sin(w*x)得x"
        import Modelica.Utilities.Streams.print;
        extends Modelica.Icons.Example;

        parameter Real y_zero = 0.5 "A*sin(w*x)的期望值";
        parameter Real x_min = -1.7 "x_zero的最小值";
        parameter Real x_max = 1.7 "x_zero的最大值";
        parameter Real A = 1 "正弦振幅";
        parameter Real w = 1 "正弦角频率";
        Real x_zero "y_zero = A*sin(w*x_zero)";

        function f_nonlinear "定义正弦函数为待解的非线性方程"
          extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
          input Real A = 1 "正弦振幅";
          input Real w = 1 "正弦角频率";
          input Real s = 0 "正弦位移";
          annotation();
        algorithm
          y := A * Modelica.Math.sin(w * u) + s;
        end f_nonlinear;

      equation
        x_zero = Modelica.Math.Nonlinear.solveOneNonlinearEquation(
          function f_nonlinear(A = A, w = w, s = -y_zero), x_min, x_max);

        print("x_zero = " + String(x_zero) + ", y_zero = " + String(y_zero) + 
          ", A*sin(w*x_zero) = " + String(A * Modelica.Math.sin(w * x_zero)));
        annotation(experiment(StopTime = 0), Documentation(info = "<html>
<p>
这个模型解决了以下非线性方程
</p>

<blockquote><pre>
y = A*sin(w*x); -> 给定y，确定x
</pre></blockquote>

<p>
翻译模型\"Inverse_sine\"
并仿真0秒。结果将打印到输出窗口。
</p>

</html>"));
      end Inverse_sine;

      model Inverse_sh_T 
        "已知NASA理想气体的h或s,根据h = h_T(T),s = s_T(T)求T"
        extends Modelica.Icons.Example;

        replaceable package Medium = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.IdealGases.Common.SingleGasNasa 
          "介质模型" 
          annotation(choicesAllMatching = true);

        parameter SI.Temperature T_min = 300 
          "温度从T_min(time=0)线性变化增加到T_max(time=1)";
        parameter SI.Temperature T_max = 500 
          "温度从T_min(time=0)线性变化增加到T_max(time=1)";
        parameter SI.Pressure p = 1.0e5 "压力";
        final parameter SI.SpecificEnthalpy h_min = Medium.specificEnthalpy(
          Medium.setState_pT(p, T_min)) "T_min时的比焓";
        final parameter SI.SpecificEnthalpy h_max = Medium.specificEnthalpy(
          Medium.setState_pT(p, T_max)) "T_max时的比焓";
        final parameter SI.SpecificEntropy s_min = Medium.specificEntropy(
          Medium.setState_pT(p, T_min)) "T_min时的比熵";
        final parameter SI.SpecificEntropy s_max = Medium.specificEntropy(
          Medium.setState_pT(p, T_max)) "T_max时的比熵";
        SI.SpecificEnthalpy h1(start = h_min, fixed = true) 
          "预定义比焓";
        SI.SpecificEnthalpy h2 
          "根据Th计算的比焓(= h1 required)";
        SI.SpecificEntropy s1(start = s_min, fixed = true) 
          "预定义的比熵";
        SI.SpecificEntropy s2 "根据Ts计算的比熵(= s1 required)";
        SI.Temperature Th "根据h1计算的温度";
        SI.Temperature Ts "根据s1计算的温度";

      protected
        constant SI.Time timeUnit = 1.0;

      equation
        // 定义比焓和比熵
        der(h1) = if time < 1.0 then 1 / timeUnit * (h_max - h_min) else 0.0;
        der(s1) = if time < 1.0 then 1 / timeUnit * (s_max - s_min) else 0.0;

        // 计算温度
        Th = Medium.temperature_phX(p, h1, fill(0.0, 0));
        Ts = Medium.temperature_psX(p, s1, fill(0.0, 0));

        // 检查(h2必须与h1相等,s2必须与s1相等)
        h2 = Medium.specificEnthalpy_pTX(p, Th, fill(0.0, 0));
        s2 = Medium.specificEntropy(Medium.setState_pT(p, Ts));
        annotation(experiment(StopTime = 1), Documentation(info = "<html>
<p>
这个模型通过数值反演函数<a href=\"modelica://Modelica.Media.IdealGases.Common.Functions.h_T\">Modelica.Media.IdealGases.Common.Functions.h_T</a>计算预定义特定焓<code>h1</code>的温度<code>Th</code>。
特定焓<code>h2</code>是从温度<code>Th</code>计算的检查变量，必须与<code>h1</code>相同。
</p>

<p>
类似地，温度<code>Ts</code>是通过数值反演函数<a href=\"modelica://Modelica.Media.IdealGases.Common.Functions.s0_T\">Modelica.Media.IdealGases.Common.Functions.s0_T</a>计算预定义特定熵<code>s1</code>的。
特定熵<code>s2</code>是从温度<code>Ts</code>计算的检查变量，必须与<code>s1</code>相同。
</p>

<p>
在这两种情况下，反函数的数值计算由函数<a href=\"modelica://Modelica.Math.Nonlinear.solveOneNonlinearEquation\">Modelica.Math.Nonlinear.solveOneNonlinearEquation</a>执行。
</p>

</html>"));
      end Inverse_sh_T;

      model InverseIncompressible_sh_T 
        "不可压缩介质的逆运算"
        extends Modelica.Icons.Example;

        replaceable package Medium = 
          Modelica.Media.Incompressible.Examples.Glycol47 "介质模型" 
          annotation(choicesAllMatching = true);

        parameter SI.Temperature T_min = Medium.T_min 
          "温度从T_min(time=0)线性变化增加到T_max(time=1)";
        parameter SI.Temperature T_max = Medium.T_max 
          "温度从T_min(time=0)线性变化增加到T_max(time=1)";
        parameter SI.Pressure p = 1.0e5 "压力";
        final parameter SI.SpecificEnthalpy h_min = Medium.h_T(Medium.T_min) 
          "T_min时的比焓";
        final parameter SI.SpecificEnthalpy h_max = Medium.h_T(Medium.T_max) 
          "T_max时的比焓";
        final parameter SI.SpecificEntropy s_min = Medium.specificEntropy(
          Medium.setState_pT(p, T_min)) "T_min时的比熵";
        final parameter SI.SpecificEntropy s_max = Medium.specificEntropy(
          Medium.setState_pT(p, T_max)) "T_max时比熵";

        SI.SpecificEnthalpy h1(start = h_min, fixed = true) 
          "预定义比焓";
        SI.SpecificEnthalpy h2 
          "根据Th计算的比焓(= h1 required)";
        SI.SpecificEntropy s1(start = s_min, fixed = true) 
          "预定义比熵";
        SI.SpecificEntropy s2 "根据Ts计算的比熵(= s1 required)";
        SI.Temperature Th "根据h1计算的温度";
        SI.Temperature Ts "根据s1计算的温度";

      protected
        constant SI.Time timeUnit = 1.0;

      equation
        // 定义比焓和比熵
        der(h1) = if time < 1.0 then 1 / timeUnit * (h_max - h_min) else 0.0;
        der(s1) = if time < 1.0 then 1 / timeUnit * (s_max - s_min) else 0.0;

        // 计算温度
        Th = Medium.temperature_phX(p, h1, fill(0.0, 0));
        Ts = Medium.temperature_psX(p, s1, fill(0.0, 0));

        // 检查(h2必须与h1相等,s2必须与s1相等)
        h2 = Medium.specificEnthalpy_pTX(p, Th, fill(0.0, 0));
        s2 = Medium.specificEntropy(Medium.setState_pT(p, Ts));
        annotation(experiment(StopTime = 1), Documentation(info = "<html>
<p>
这个模型通过数值反演函数<a href=\"modelica://Modelica.Media.Incompressible.TableBased.h_T\">Modelica.Media.Incompressible.TableBased.h_T</a>计算预定义特定焓<code>h1</code>的温度<code>Th</code>。
特定焓<code>h2</code>是从温度<code>Th</code>计算的检查变量，必须与<code>h1</code>相同。
</p>

<p>
类似地，温度<code>Ts</code>是通过数值反演函数<a href=\"modelica://Modelica.Media.Incompressible.TableBased.s_T\">Modelica.Media.Incompressible.TableBased.s_T</a>计算预定义特定熵<code>s1</code>的。
特定熵<code>s2</code>是从温度<code>Ts</code>计算的检查变量，必须与<code>s1</code>相同。
</p>

<p>
在这两种情况下，反函数的数值计算由函数<a href=\"modelica://Modelica.Math.Nonlinear.solveOneNonlinearEquation\">Modelica.Math.Nonlinear.solveOneNonlinearEquation</a>执行。
</p>

</html>"));
      end InverseIncompressible_sh_T;

      model Inverse_sh_TX 
        "已知NASA理想气体的h,根据h = h_TX(TX)求T"
        extends Modelica.Icons.Example;

        replaceable package Medium = 
          Modelica.Media.IdealGases.MixtureGases.FlueGasLambdaOnePlus 
          constrainedby Modelica.Media.IdealGases.Common.MixtureGasNasa 
          "介质模型" annotation(choicesAllMatching = true);

        parameter SI.Temperature T_min = 300 
          "温度从T_min(time=0)线性变化增加到T_max(time=1)";
        parameter SI.Temperature T_max = 500 
          "温度从T_min(time=0)线性变化增加到T_max(time=1)";
        parameter SI.Pressure p = 1.0e5 "压力";
        final parameter SI.SpecificEnthalpy h_min = Medium.h_TX(T_min, X) 
          "T_min时的比焓";
        final parameter SI.SpecificEnthalpy h_max = Medium.h_TX(T_max, X) 
          "T_max时的比焓";
        final parameter SI.SpecificEntropy s_min = Medium.specificEntropy(
          Medium.setState_pTX(p, T_min, Medium.reference_X)) "T_min时的比熵";
        final parameter SI.SpecificEntropy s_max = Medium.specificEntropy(
          Medium.setState_pTX(p, T_max, Medium.reference_X)) "T_max时的比熵";
        SI.SpecificEnthalpy h1(start = h_min, fixed = true) 
          "预定义比焓";
        SI.SpecificEnthalpy h2 
          "根据Th计算的比焓(= h1 required)";
        SI.SpecificEntropy s1(start = s_min, fixed = true) 
          "预定义比熵";
        SI.SpecificEntropy s2 "根据Ts计算的比熵(= s1 required)";
        SI.Temperature Th "根据h1计算的温度";
        SI.Temperature Ts "根据s1计算的温度";
        parameter SI.MassFraction[4] X = Medium.reference_X "质量分数向量";

      protected
        constant SI.Time timeUnit = 1.0;

      equation
        // 定义比焓和比熵
        der(h1) = if time < 1.0 then 1 / timeUnit * (h_max - h_min) else 0.0;
        der(s1) = if time < 1.0 then 1 / timeUnit * (s_max - s_min) else 0.0;

        // 计算温度
        Th = Medium.temperature_phX(p, h1, X);
        Ts = Medium.temperature_psX(p, s1, X);

        // 检查(h2必须与h1相等,s2必须与s1相等)
        h2 = Medium.specificEnthalpy_pTX(p, Th, X);
        s2 = Medium.specificEntropy(Medium.setState_pTX(p, Ts, X));
        annotation(experiment(StopTime = 1), Documentation(info = "<html>
<p>
这个模型通过数值反演函数<a href=\"modelica://Modelica.Media.IdealGases.Common.Functions.h_T\">Modelica.Media.IdealGases.Common.Functions.h_T</a>计算预定义特定焓<code>h1</code>的温度<code>Th</code>。
特定焓<code>h2</code>是从温度<code>Th</code>计算的检查变量，必须与<code>h1</code>相同。
</p>

<p>
类似地，温度<code>Ts</code>是通过数值反演函数<a href=\"modelica://Modelica.Media.IdealGases.Common.Functions.s0_T\">Modelica.Media.IdealGases.Common.Functions.s0_T</a>计算预定义特定熵<code>s1</code>的。
特定熵<code>s2</code>是从温度<code>Ts</code>计算的检查变量，必须与<code>s1</code>相同。
</p>

<p>
在这两种情况下，反函数的数值计算由函数<a href=\"modelica://Modelica.Math.Nonlinear.solveOneNonlinearEquation\">Modelica.Math.Nonlinear.solveOneNonlinearEquation</a>执行。
</p>

</html>"));
      end Inverse_sh_TX;

      annotation(Documentation(info = "<html>
<p>
这个库演示了如何使用函数<a href=\"modelica://Modelica.Math.Nonlinear.solveOneNonlinearEquation\">solveOneNonlinearEquation</a>来解一个未知数的非线性代数方程。
</p>
</html>"));
    end SolveOneNonlinearEquation;

    package Utilities 
      "介质模型测例中所需的函数,接口和模型"

      extends Modelica.Icons.UtilitiesPackage;

      connector FluidPort 
        "在管网中的准一维流动接口(不可压缩或可压缩,单相或多相,单组分或多组分)"
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium 
          "介质模型" annotation(choicesAllMatching = true);

        Medium.AbsolutePressure p "接口处压力";
        flow Medium.MassFlowRate m_flow 
          "接口处进入组件的质量流量";

        Medium.SpecificEnthalpy h 
          "接口处混合比焓";
        flow Medium.EnthalpyFlowRate H_flow 
          "进入组件的焓流(if m_flow > 0, H_flow = m_flow*h)";

        Medium.MassFraction Xi[Medium.nXi] 
          "接口处混合物各组分质量分数 m_i/m";
        flow Medium.MassFlowRate mXi_flow[Medium.nXi] 
          "接口处进入组件的混合物各组分质量流量(if m_flow > 0, mX_flow = m_flow*X)";

        Medium.ExtraProperty C[Medium.nC] 
          "接口处流体性质 c_i/m";
        flow Medium.ExtraPropertyFlowRate mC_flow[Medium.nC] 
          "接口处进入组件的辅助属性的流速(if m_flow > 0, mC_flow = m_flow*C)";

        annotation(Documentation(info = "<html>

</html>"));
      end FluidPort;

      connector FluidPort_a "实心图标的流体接口"
        extends FluidPort;
        annotation(
          Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
          {100, 100}}), graphics = {Ellipse(
          extent = {{-100, 100}, {100, -100}}, 
          lineColor = {0, 127, 255}, 
          fillColor = {0, 127, 255}, 
          fillPattern = FillPattern.Solid), Ellipse(
          extent = {{-100, 100}, {100, -100}}, 
          fillColor = {0, 127, 255}, 
          fillPattern = FillPattern.Solid), Text(
          extent = {{-88, 206}, {112, 112}}, 
          textString = "%name", 
          textColor = {0, 0, 255})}), 
          Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
          100, 100}}), graphics = {Ellipse(
          extent = {{-100, 100}, {100, -100}}, 
          lineColor = {0, 127, 255}, 
          fillColor = {0, 127, 255}, 
          fillPattern = FillPattern.Solid), Ellipse(
          extent = {{-100, 100}, {100, -100}}, 
          fillColor = {0, 127, 255}, 
          fillPattern = FillPattern.Solid)}), 
          Documentation(info = "<html>Modelica.Media.Examples.Tests.Components.FluidPort_a
</html>"));
      end FluidPort_a;

      connector FluidPort_b "空心图标的流体接口"
        extends FluidPort;
        annotation(
          Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
          {100, 100}}), graphics = {Ellipse(
          extent = {{-100, 100}, {100, -100}}, 
          lineColor = {0, 127, 255}, 
          fillColor = {0, 127, 255}, 
          fillPattern = FillPattern.Solid), Ellipse(
          extent = {{-100, 100}, {100, -100}}, 
          fillColor = {0, 127, 255}, 
          fillPattern = FillPattern.Solid), Ellipse(
          extent = {{-80, 80}, {80, -80}}, 
          lineColor = {0, 127, 255}, 
          fillColor = {255, 255, 255}, 
          fillPattern = FillPattern.Solid), Text(
          extent = {{-88, 192}, {112, 98}}, 
          textString = "%name", 
          textColor = {0, 0, 255})}), 
          Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
          100, 100}}), graphics = {Ellipse(
          extent = {{-100, 100}, {100, -100}}, 
          lineColor = {0, 127, 255}, 
          fillColor = {0, 127, 255}, 
          fillPattern = FillPattern.Solid), Ellipse(
          extent = {{-100, 100}, {100, -100}}, 
          fillColor = {0, 127, 255}, 
          fillPattern = FillPattern.Solid), Ellipse(
          extent = {{-80, 80}, {80, -80}}, 
          lineColor = {0, 127, 255}, 
          fillColor = {255, 255, 255}, 
          fillPattern = FillPattern.Solid)}), 
          Documentation(info = "<html>

</html>"));
      end FluidPort_b;

      model PortVolume 
        "有限体积方法的单接口定容容积"
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium 
          "介质模型" annotation(choicesAllMatching = true);

        parameter SI.Volume V = 1e-6 "容积接口的固定体积";

        parameter Boolean use_p_start = true "选择p_start或d_start" 
          annotation(Evaluate = true, Dialog(group = 
          "初始压力或初始密度"));
        parameter Medium.AbsolutePressure p_start = 101325 "初始压力" 
          annotation(Dialog(group = "初始压力或初始密度", 
          enable = use_p_start));
        parameter Medium.Density d_start = 1 "初始密度" annotation(Dialog(
          group = "初始压力或初始密度", enable = not 
          use_p_start));
        parameter Boolean use_T_start = true "选择T_start或h_start" 
          annotation(Evaluate = true, Dialog(group = 
          "初始温度或初始比焓"));
        parameter Medium.Temperature T_start = 
          Modelica.Units.Conversions.from_degC(20) "初始温度" 
          annotation(Dialog(group = 
          "初始温度或初始比焓", enable = 
          use_T_start));
        parameter Medium.SpecificEnthalpy h_start = 1.e4 
          "初始比焓" annotation(Dialog(group = 
          "初始温度或初始比焓", enable = not 
          use_T_start));
        parameter Medium.MassFraction X_start[Medium.nX] 
          "初始质量分数 m_i/m" annotation(Dialog(group = 
          "仅用于多组分流动", enable = Medium.nX > 0));

        FluidPort_a port(redeclare package Medium = Medium) annotation(
          Placement(transformation(extent = {{-10, -10}, {10, 10}})));
        Medium.BaseProperties medium(preferredMediumStates = true);
        SI.Energy U "容积的内能";
        SI.Mass m "容积的质量";
        SI.Mass mXi[Medium.nXi] 
          "容积接口的独立物质质量";

      initial equation
        if not Medium.singleState then
          if use_p_start then
            medium.p = p_start;
          else
            medium.d = d_start;
          end if;
        end if;

        if use_T_start then
          medium.T = T_start;
        else
          medium.h = h_start;
        end if;

        medium.Xi = X_start[1:Medium.nXi];
      equation
        // 将接口关联到介质变量
        medium.p = port.p;
        medium.h = port.h;
        medium.Xi = port.Xi;

        // 总量
        m = V * medium.d;
        mXi = m * medium.Xi;
        U = m * medium.u;

        // 质量和能量守恒
        der(m) = port.m_flow;
        der(mXi) = port.mXi_flow;
        der(U) = port.H_flow;
        annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
          -100}, {100, 100}}), graphics = {Ellipse(
          extent = {{-100, 100}, {100, -100}}, 
          fillPattern = FillPattern.Sphere, 
          fillColor = {170, 213, 255}), Text(
          extent = {{-150, 150}, {150, 110}}, 
          textString = "%name", 
          textColor = {0, 0, 255}), Text(
          extent = {{-150, -110}, {150, -150}}, 
          textString = "V=%V")}), Documentation(info = "<html><p>
该组件为<strong>固定大小的容积</strong>建模，该容积与所连接的<strong>流体接口</strong>相关联。这意味着容积内的所有介质属性都与接口介质属性相同。特别是，体积内的比焓（= medium.h）始终与接口内的比焓（port.h = medium.h）相同。通常，在根据有限体积法将部件离散化为内部接口的体积（仅存储能量和质量）和内部接口之间的传输元素（仅传输能量、质量和动量，传输过程中不存储这些量）时，会使用该模型。
</p>
</html>"));
      end PortVolume;

      model FixedMassFlowRate 
        "理想泵,在固定温度和质量分数下,从一个大储液池产生恒定的质量流量"
        parameter Medium.MassFlowRate m_flow 
          "从无限大储液池到流体接口的固定质量流量";

        parameter Boolean use_T_ambient = true "选择T_ambient或h_ambient" 
          annotation(Evaluate = true, Dialog(group = 
          "环境温度或环境比焓"));
        parameter Medium.Temperature T_ambient = 
          Modelica.Units.Conversions.from_degC(20) "环境温度" 
          annotation(Dialog(group = 
          "环境温度或环境比焓", enable = 
          use_T_ambient));
        parameter Medium.SpecificEnthalpy h_ambient = 1.e4 
          "环境比焓" annotation(Dialog(group = 
          "环境温度或环境比焓", enable = not 
          use_T_ambient));
        parameter Medium.MassFraction X_ambient[Medium.nX] 
          "储液池的环境质量分数 m_i/m";

        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium 
          "介质模型" annotation(choicesAllMatching = true);

        Medium.BaseProperties medium "源中的介质";
        FluidPort_b port(redeclare package Medium = Medium) annotation(
          Placement(transformation(extent = {{100, -10}, {120, 10}})));
      equation
        if use_T_ambient then
          medium.T = T_ambient;
        else
          medium.h = h_ambient;
        end if;

        medium.Xi = X_ambient[1:Medium.nXi];
        medium.p = port.p;
        port.m_flow = -m_flow;
        port.mXi_flow = semiLinear(
          port.m_flow, 
          port.Xi, 
          medium.Xi);
        port.H_flow = semiLinear(
          port.m_flow, 
          port.h, 
          medium.h);
        annotation(Icon(coordinateSystem(
          preserveAspectRatio = true, 
          extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(
          extent = {{20, 60}, {100, -60}}, 
          fillPattern = FillPattern.HorizontalCylinder, 
          fillColor = {192, 192, 192}), Rectangle(
          extent = {{38, 40}, {100, -40}}, 
          fillPattern = FillPattern.HorizontalCylinder, 
          fillColor = {0, 127, 255}), Ellipse(
          extent = {{-100, 80}, {60, -80}}, 
          fillColor = {255, 255, 255}, 
          fillPattern = FillPattern.Solid, 
          lineColor = {0, 0, 255}), Polygon(
          points = {{-60, 70}, {60, 0}, {-60, -68}, {-60, 70}}, 
          lineColor = {0, 0, 255}, 
          fillColor = {0, 0, 255}, 
          fillPattern = FillPattern.Solid), Text(
          extent = {{-54, 32}, {16, -30}}, 
          textColor = {255, 0, 0}, 
          textString = "m"), Text(
          extent = {{-150, 150}, {150, 110}}, 
          textString = "%name", 
          textColor = {0, 0, 255}), Text(
          extent = {{-150, -110}, {150, -150}}, 
          textString = "%m_flow"), Ellipse(
          extent = {{-26, 30}, {-18, 22}}, 
          lineColor = {255, 0, 0}, 
          fillColor = {255, 0, 0}, 
          fillPattern = FillPattern.Solid)}), Documentation(info = "<html>

</html>"));
      end FixedMassFlowRate;

      model FixedAmbient 
        "环境压力、温度和质量分数源"
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium 
          "介质模型" annotation(choicesAllMatching = true);

        parameter Boolean use_p_ambient = true "选择p_ambient或d_ambient" 
          annotation(Evaluate = true, Dialog(group = 
          "环境压力或环境密度"));
        parameter Medium.AbsolutePressure p_ambient = 101325 "环境压力" 
          annotation(Dialog(group = "环境压力或环境密度", 
          enable = use_p_ambient));
        parameter Medium.Density d_ambient = 1 "环境密度" annotation(
          Dialog(group = "环境压力或环境密度", enable = not 
          use_p_ambient));
        parameter Boolean use_T_ambient = true "选择T_ambient或h_ambient" 
          annotation(Evaluate = true, Dialog(group = 
          "环境温度或环境比焓"));
        parameter Medium.Temperature T_ambient = 
          Modelica.Units.Conversions.from_degC(20) "环境温度" 
          annotation(Dialog(group = 
          "环境温度或环境比焓", enable = 
          use_T_ambient));
        parameter Medium.SpecificEnthalpy h_ambient = 1.e4 
          "环境比焓" annotation(Dialog(group = 
          "环境温度或环境比焓", enable = not 
          use_T_ambient));
        parameter Medium.MassFraction X_ambient[Medium.nX] 
          "环境质量分数 m_i/m" annotation(Dialog(group = 
          "仅用于多组分流动", enable = Medium.nX > 0));

        Medium.BaseProperties medium "源中的介质";
        FluidPort_b port(redeclare package Medium = Medium) annotation(
          Placement(transformation(extent = {{100, -10}, {120, 10}})));

      equation
        if use_p_ambient or Medium.singleState then
          medium.p = p_ambient;
        else
          medium.d = d_ambient;
        end if;

        if use_T_ambient then
          medium.T = T_ambient;
        else
          medium.h = h_ambient;
        end if;

        medium.Xi = X_ambient[1:Medium.nXi];

        port.p = medium.p;
        port.H_flow = semiLinear(
          port.m_flow, 
          port.h, 
          medium.h);
        port.mXi_flow = semiLinear(
          port.m_flow, 
          port.Xi, 
          medium.Xi);
        annotation(Icon(coordinateSystem(
          preserveAspectRatio = true, 
          extent = {{-100, -100}, {100, 100}}), graphics = {Ellipse(
          extent = {{-100, 100}, {100, -100}}, 
          fillPattern = FillPattern.Sphere, 
          fillColor = {0, 127, 255}), Text(
          extent = {{-150, 150}, {150, 110}}, 
          textString = "%name", 
          textColor = {0, 0, 255})}), Documentation(info = "<html><p>
模型 <strong>FixedAmbient_pt</strong> 定义了环境条件的常数值:
</p>
<ul><li>
环境压力。</li>
<li>
环境温度。</li>
<li>
环境质量分数(仅适用于多组分流体)。</li>
</ul><p>
请注意，只有当质量流量从环境流向接口时，环境温度和质量分数才会起作用。如果质量从接口流向环境，则环境定义(除环境压力外)不起作用。
</p>
</html>"));
      end FixedAmbient;

      model ShortPipe "简单的管道压力损失"
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium 
          "介质模型" annotation(choicesAllMatching = true);

        parameter Medium.AbsolutePressure dp_nominal(min = 1e-10) 
          "额定压降";
        parameter Medium.MassFlowRate m_flow_nominal(min = 1e-10) 
          "额定压降下的额定质量流量";

        FluidPort_a port_a(redeclare package Medium = Medium) annotation(
          Placement(transformation(extent = {{-120, -10}, {-100, 10}})));
        FluidPort_b port_b(redeclare package Medium = Medium) annotation(
          Placement(transformation(extent = {{120, -10}, {100, 10}})));
        // Medium.BaseProperties medium_a(p=port_a.p, h=port_a.h, Xi=port_a.Xi)
        //   "Medium properties in port_a";
        // Medium.BaseProperties medium_b(p=port_b.p, h=port_b.h, Xi=port_b.Xi)
        //   "Medium properties in port_b";
        Medium.MassFlowRate m_flow 
          "从port_a到port_b的质量流量 (m_flow>0为设计流向)";
        SI.Pressure dp "从port_a到port_b的压降";
      equation
        /* 处理反向和零流量 */
        port_a.H_flow = semiLinear(
          port_a.m_flow, 
          port_a.h, 
          port_b.h);
        port_a.mXi_flow = semiLinear(
          port_a.m_flow, 
          port_a.Xi, 
          port_b.Xi);

        /* 能量,质量和物质质量平衡 */
        port_a.H_flow + port_b.H_flow = 0;
        port_a.m_flow + port_b.m_flow = 0;
        port_a.mXi_flow + port_b.mXi_flow = zeros(Medium.nXi);

        // 定义质量流量的方向
        m_flow = port_a.m_flow;

        // 压降
        dp = port_a.p - port_b.p;
        m_flow = (m_flow_nominal / dp_nominal) * dp;
        annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
          -100}, {100, 100}}), graphics = {Rectangle(
          extent = {{-100, 60}, {100, -60}}, 
          fillPattern = FillPattern.HorizontalCylinder, 
          fillColor = {192, 192, 192}), Rectangle(
          extent = {{-100, 34}, {100, -36}}, 
          fillPattern = FillPattern.HorizontalCylinder, 
          fillColor = {0, 127, 255}), Text(
          extent = {{-150, 110}, {150, 70}}, 
          textString = "%name", textColor = {0, 0, 255}), Text(
          extent = {{-150, -70}, {150, -110}}, 
          textString = "k=%m_flow_nominal/%dp_nominal")}), 
          Documentation(info = "<html>
<p>
模型 <strong>ShortPipe</strong> 定义了一个简单的管道模型，其中压力损失是由摩擦引起的。假设管道中没有储存质量或能量。
</p>
</html>"));
      end ShortPipe;

      partial model PartialTestModel "介质模型示例的基类模型"

        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium 
          "介质模型" annotation(choicesAllMatching = true);
        parameter SI.AbsolutePressure p_start = Medium.p_default 
          "压力初值";
        parameter SI.Temperature T_start = Medium.T_default 
          "温度初值";
        parameter SI.SpecificEnthalpy h_start = Medium.h_default 
          "比焓初值";
        parameter Real X_start[Medium.nX] = Medium.X_default 
          "质量分数初值";

        /*
        parameter SI.AbsolutePressure p_start = 1.0e5 "Initial value of pressure";
        parameter SI.Temperature T_start = 300 "Initial value of temperature";
        parameter SI.Density h_start = 1 "Initial value of specific enthalpy";
        parameter Real X_start[Medium.nX] = Medium.reference_X
        "Initial value of mass fractions";
        */
        PortVolume volume(
        redeclare package Medium = Medium, 
          p_start = p_start, 
          T_start = T_start, 
          h_start = h_start, 
          X_start = X_start, 
          V = 0.1) annotation(Placement(transformation(extent = {{-40, 0}, {-20, 20}})));
        FixedMassFlowRate fixedMassFlowRate(
        redeclare package Medium = Medium, 
          T_ambient = 1.2 * T_start, 
          h_ambient = 1.2 * h_start, 
          m_flow = 1, 
          X_ambient = 0.5 * X_start) annotation(Placement(transformation(extent = {{
          -80, 0}, {-60, 20}})));
        FixedAmbient ambient(
        redeclare package Medium = Medium, 
          T_ambient = T_start, 
          h_ambient = h_start, 
          X_ambient = X_start, 
          p_ambient = p_start) annotation(Placement(transformation(extent = {{60, 0}, 
          {40, 20}})));
        ShortPipe shortPipe(
        redeclare package Medium = Medium, 
          m_flow_nominal = 1, 
          dp_nominal = 0.1e5) annotation(Placement(transformation(extent = {{0, 0}, 
          {20, 20}})));
      equation
        connect(fixedMassFlowRate.port, volume.port) 
          annotation(Line(points = {{-59, 10}, {-30, 10}}, color = {0, 127, 255}));
        connect(volume.port, shortPipe.port_a) 
          annotation(Line(points = {{-30, 10}, {-1, 10}}, color = {0, 127, 255}));
        connect(shortPipe.port_b, ambient.port) 
          annotation(Line(points = {{21, 10}, {39, 10}}, color = {0, 127, 255}));
        annotation(Documentation(info = "<html>

</html>"));
      end PartialTestModel;

      partial model PartialTestModel2 
        "稍大点的介质示例模型基类"
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium 
          "介质模型" annotation(choicesAllMatching = true);
        parameter SI.AbsolutePressure p_start = 1.0e5 "压力初值";
        parameter SI.Temperature T_start = 300 "温度初值";
        parameter SI.SpecificEnthalpy h_start = 1 
          "比焓初值";
        parameter Real X_start[Medium.nX] = Medium.reference_X 
          "质量分数初值";
        PortVolume volume(
        redeclare package Medium = Medium, 
          p_start = p_start, 
          T_start = T_start, 
          h_start = h_start, 
          X_start = X_start, 
          V = 0.1) annotation(Placement(transformation(extent = {{-60, 0}, {-40, 20}})));
        FixedMassFlowRate fixedMassFlowRate(
        redeclare package Medium = Medium, 
          T_ambient = 1.2 * T_start, 
          h_ambient = 1.2 * h_start, 
          m_flow = 1, 
          X_ambient = 0.5 * X_start) annotation(Placement(transformation(extent = {{
          -100, 0}, {-80, 20}})));
        FixedAmbient ambient(
        redeclare package Medium = Medium, 
          T_ambient = T_start, 
          h_ambient = h_start, 
          X_ambient = X_start, 
          p_ambient = p_start) annotation(Placement(transformation(extent = {{92, 0}, 
          {72, 20}})));
        ShortPipe shortPipe(
        redeclare package Medium = Medium, 
          m_flow_nominal = 1, 
          dp_nominal = 0.1e5) annotation(Placement(transformation(extent = {{-30, 0}, 
          {-10, 20}})));
        PortVolume volume1(
        redeclare package Medium = Medium, 
          p_start = p_start, 
          T_start = T_start, 
          h_start = h_start, 
          X_start = X_start, 
          V = 0.1) annotation(Placement(transformation(extent = {{0, 0}, {20, 20}})));
        ShortPipe shortPipe1(
        redeclare package Medium = Medium, 
          m_flow_nominal = 1, 
          dp_nominal = 0.1e5) annotation(Placement(transformation(extent = {{36, 0}, 
          {56, 20}})));
      equation
        connect(fixedMassFlowRate.port, volume.port) 
          annotation(Line(points = {{-79, 10}, {-50, 10}}, color = {0, 127, 255}));
        connect(volume.port, shortPipe.port_a) 
          annotation(Line(points = {{-50, 10}, {-31, 10}}, color = {0, 127, 255}));
        connect(volume1.port, shortPipe1.port_a) 
          annotation(Line(points = {{10, 10}, {35, 10}}, color = {0, 127, 255}));
        connect(shortPipe.port_b, volume1.port) 
          annotation(Line(points = {{-9, 10}, {10, 10}}, color = {0, 127, 255}));
        connect(shortPipe1.port_b, ambient.port) 
          annotation(Line(points = {{57, 10}, {71, 10}}, color = {0, 127, 255}));
        annotation(Documentation(info = "<html>

</html>"));
      end PartialTestModel2;
      annotation(Documentation(info = "<html>

</html>"));
    end Utilities;
    annotation(Documentation(info = "<html><h4>实例</h4><h4><strong>流体的物理特性需要多种不同的变体，因此一个库只能提供最常见情况下的模型。通过以下示例，我们将演示如何使用 Modelica.Media 中现有的库和函数，针对高级应用场景定制这些模型。高层级函数的设计目标，是尽可能抽象化不同介质所基于的不同变量这一事实，例如理想气体需要压力和温度，而许多制冷剂基于密度和温度的亥姆霍兹函数，水物性则常以压力与比焓为基准。介质属性既需要用于控制容积动态状态方程的求解，也存在于众多与容积动态状态无关的热力学状态场景中，例如壁面温度、等熵参考状态或相边界处的计算。库的一般结构如下：</strong></h4><li>
每种介质都有一个名为 BaseProperties 的模型。BaseProperties 包含动态控制体积模型所需的最小介质属性集。</li>
<li>
BaseProperties 的每个实例都包含一条 \"状态 \"记录，它是所有计算属性函数的输入。如果这些函数需要更多的输入，例如摩尔质量（molarMass），则可在库中作为常量访问。</li>
<li>
计算任何其他参考点属性的最简单方法是声明一个 ThermodynamicState 的实例，并将其作为任意属性函数的输入。<br></li>
<p>
在 Modelica.Media.Examples.Tests.Components 中提供了一个小型的通用体积、管道、泵和环境模型库，以演示如何使用 Modelica.Media 模型实现流体组件。该库还用于测试 Modelica.Media.Examples.Tests.MediaTestModels 中的所有介质模型。
</p>
</html>"));
  end Examples;

  package Interfaces "介质模型接口"
    extends Modelica.Icons.InterfacesPackage;

    partial package TemplateMedium "介质模型模板"
      /* 对于新介质，复制此包并从上面的包定义中删除"partial"关键字。
      下面的语句从PartialMedium扩展，并设置一些库的常量,根据介质设置合适的常数。
      请注意，其他常数(如nX、nXi)将通过基类Interfaces.PartialMedium中给定的定义自动定义。
      */
      extends Modelica.Media.Interfaces.PartialMedium(
        final mediumName = "NameOfMedium", 
        final substanceNames = {mediumName}, 
        final singleState = false, 
        final reducedX = true, 
        final fixedX = true, 
        Temperature(
        min = 273, 
        max = 450, 
        start = 323));

      // 此处设置介质常数
      constant SpecificHeatCapacity cp_const = 123456 
        "恒压下的比焓常数";

      /* 矢量substanceNames是必需的，因为物质的数量是根据其大小确定的。
      在这里，我们假设是单组分介质。
      如果u和d不依赖于压力，而只依赖于热量变量（温度或焓），则singleState为true。
      否则，设置为false。
      对于单组分介质，只需将reducedX和fixedX设置为true，无需考虑介质组成。
      否则，如果介质模型具有nS-1个独立质量分数，将最终的reducedX设置为true；
      如果介质模型具有nS个独立质量分数（nS为物质的数量），则将reducedX设置为false。
      如果混合物具有固定的组成，请将fixedX设置为true，否则设置为false。
      reducedX和fixedX的可变性前缀通常应设为final，因为其他方程式是基于这些值的。
      
      也可以重新声明在基类Interfaces.PartialMedium中定义的Medium类型的min、max和start属性
      （这里显示了Temperature的示例）。
      min和max属性应根据介质模型的有效范围设置，而start属性应是非线性求解器迭代初始化的合理默认值。
      */

      /* 提供在PartialMedium中定义的BaseProperties模型的实现方法。
      从p、T、d、u、h中选择两个独立变量。
      如果有多种物质，则其他独立变量是质量分数“Xi”。
      通过3个方程来计算剩余变量作为独立变量的函数。
      还需要提供两个额外方程来设置介质的气体常数R_s和摩尔质量MM。
      最后，根据其定义（请参阅下面的ThermodynamicState），
      应该设置在基类Interfaces.PartialMedium.BaseProperties中定义的热力学状态向量。
      对于基类Interfaces.PartialMedium.BaseProperties中已包含的从Xi[nXi]计算向量X[nX]，
      不应在此重复。下面的代码片段用于具有p、T作为独立变量的单一物质介质。
      */

      redeclare model extends BaseProperties(final standardOrderComponents = true) 
        "介质的基础属性"
        annotation();

      equation
        d = 1;
        h = cp_const * T;
        u = h - p / d;
        MM = 0.024;
        R_s = Modelica.Constants.R / MM;
        state.p = p;
        state.T = T;
      end BaseProperties;

      /* 提供以下可选属性的实现。如果不可用，请删除相应的函数。
      记录“ThermodynamicState”包含所有函数的输入参数，
      并与PartialMedium中使用的类型定义一起定义。
      该记录通常包含两个变量“p、T、d、h”（例如，medium.T）。
      */
      redeclare replaceable record ThermodynamicState 
        "定义热力状态"
        extends Modelica.Icons.Record;
        AbsolutePressure p "介质的绝对压力";
        Temperature T "介质的温度";
        annotation(Documentation(info = "<html>

</html>"));
      end ThermodynamicState;

      redeclare function extends dynamicViscosity "计算动力黏度"
      algorithm
        eta := 10 - state.T * 0.3 + state.p * 0.2;
        annotation(Documentation(info = "<html>

</html>"));
      end dynamicViscosity;

      redeclare function extends thermalConductivity 
        "计算导热系数"
      algorithm
        lambda := 0;
        annotation(Documentation(info = "<html>

</html>"));
      end thermalConductivity;

      redeclare function extends specificEntropy "计算比熵"
      algorithm
        s := 0;
        annotation(Documentation(info = "<html>

</html>"));
      end specificEntropy;

      redeclare function extends specificHeatCapacityCp 
        "计算定压比热"
      algorithm
        cp := 0;
        annotation(Documentation(info = "<html>

</html>"));
      end specificHeatCapacityCp;

      redeclare function extends specificHeatCapacityCv 
        "计算定容比热"
      algorithm
        cv := 0;
        annotation(Documentation(info = "<html>

</html>"));
      end specificHeatCapacityCv;

      redeclare function extends isentropicExponent "计算绝热指数"
        extends Modelica.Icons.Function;
      algorithm
        gamma := 1;
        annotation(Documentation(info = "<html>

</html>"));
      end isentropicExponent;

      redeclare function extends velocityOfSound "计算声速"
        extends Modelica.Icons.Function;
      algorithm
        a := 0;
        annotation(Documentation(info = "<html>

</html>"));
      end velocityOfSound;

      annotation(Documentation(info = "<html>
<p>
这个库是一个用于新介质模型的模板。要创建一个新的介质模型，只需复制此库，
将库中的\"partial\"关键字移除，并提供Modelica源代码注释中请求的信息。
</p>
</html>"));
    end TemplateMedium;

    partial package PartialMedium 
      "介质物性基类(所有介质子库的基础库)"
      extends Modelica.Media.Interfaces.Types;
      extends Modelica.Icons.MaterialPropertiesPackage;

      // 介质中需要设置的常数
      constant Modelica.Media.Interfaces.Choices.IndependentVariables 
        ThermoStates "独立变量的枚举类型";
      constant String mediumName = "unusablePartialMedium" "介质名称";
      constant String substanceNames[:] = {mediumName} 
        "混合物组分的名称,单组分时设为substanceNames={mediumName}";
      constant String extraPropertiesNames[:] = fill("", 0) 
        "额外输运性质的名称。如果未使用,设为extraPropertiesNames=fill(,0)";
      constant Boolean singleState 
        "= true,u和d不是压力的函数";
      constant Boolean reducedX = true 
        "= true,介质使用方程 sum(X) = 1.0;如果为单组分,则设置reducedX=true（详细信息请参阅文档）";
      constant Boolean fixedX = false 
        "= true, 介质使用方程 X = reference_X";
      constant AbsolutePressure reference_p = 101325 
        "介质的参考压力: 默认为1个大气压";
      constant Temperature reference_T = 298.15 
        "介质的参考温度: 默认为25℃";
      constant MassFraction reference_X[nX] = fill(1 / nX, nX) 
        "介质默认质量分数";
      constant AbsolutePressure p_default = 101325 
        "介质默认压力 (用于初始化)";
      constant Temperature T_default = Modelica.Units.Conversions.from_degC(20) 
        "介质默认温度 (用于初始化)";
      constant SpecificEnthalpy h_default = specificEnthalpy_pTX(
        p_default, 
        T_default, 
        X_default) 
        "介质默认比焓 (用于初始化)";
      constant MassFraction X_default[nX] = reference_X 
        "介质默认质量分数 (用于初始化)";
      constant ExtraProperty C_default[nC] = fill(0, nC) 
        "介质默认微量物质 (用于初始化)";

      final constant Integer nS = size(substanceNames, 1) "物质数量";
      constant Integer nX = nS "质量分数数量";
      constant Integer nXi = if fixedX then 0 else if reducedX then nS - 1 else nS 
        "结构独立质量分数的数量(详细信息请参阅文档)";

      final constant Integer nC = size(extraPropertiesNames, 1) 
        "额外输运属性数量(超出标准质量平衡)";
      constant Real C_nominal[nC](min = fill(Modelica.Constants.eps, nC)) = 1.0e-6 * 
        ones(nC) "默认额外属性的额定值";
      replaceable record FluidConstants = 
        Modelica.Media.Interfaces.Types.Basic.FluidConstants 
        "介质的临界,三相,分子和其他标准数据" annotation();

      replaceable record ThermodynamicState 
        "可作为每个介质函数输入参数的最小变量集合"
        extends Modelica.Icons.Record;
        annotation();
      end ThermodynamicState;

      replaceable partial model BaseProperties 
        "介质的基础物性(p, d, T, h, u, R_s, MM , X 和 Xi)"
        InputAbsolutePressure p "介质的绝对压力";
        InputMassFraction[nXi] Xi(start = reference_X[1:nXi]) 
          "结构独立质量分数";
        InputSpecificEnthalpy h "介质的比焓";
        Density d "介质的密度";
        Temperature T "介质的温度";
        MassFraction[nX] X(start = reference_X) 
          "质量分数(=组分质量/总质量 m_i/m)";
        SpecificInternalEnergy u "介质的比内能";
        SpecificHeatCapacity R_s "气体常数(若适用混合物)";
        MolarMass MM "摩尔质量(混合物或单组分流体)";
        ThermodynamicState state 
          "可选函数的热力学状态记录";
        parameter Boolean preferredMediumStates = false 
          "= true,StateSelect.prefer将用于介质的独立物性变量" 
          annotation(Evaluate = true, Dialog(tab = "高级"));
        parameter Boolean standardOrderComponents = true 
          "=true且reducedX=true,X的最后一个元素将由其他计算";
        Modelica.Units.NonSI.Temperature_degC T_degC = 
          Modelica.Units.Conversions.to_degC(T) 
          "介质温度[degC]";
        Modelica.Units.NonSI.Pressure_bar p_bar = 
          Modelica.Units.Conversions.to_bar(p) 
          "介质绝对压力[bar]";

        // 定义本地连接器,用于方程平衡检查
        connector InputAbsolutePressure = input SI.AbsolutePressure 
          "压力作为输入的单个连接器" annotation();
        connector InputSpecificEnthalpy = input SI.SpecificEnthalpy 
          "比焓作为输入的单个连接器" annotation();
        connector InputMassFraction = input SI.MassFraction 
          "质量分数作为输入的单个连接器" annotation();

      equation
        if standardOrderComponents then
          Xi = X[1:nXi];

          if fixedX then
            X = reference_X;
          end if;
          if reducedX and not fixedX then
            X[nX] = 1 - sum(Xi);
          end if;
          for i in 1:nX loop
            assert(X[i] >= -1.e-5 and X[i] <= 1 + 1.e-5, "物质的质量分数 X[" + 
              String(i) + "] = " + String(X[i]) + 
              substanceNames[i] + "\nof medium " + mediumName + 
              " 不在 0...1 的范围内");
          end for;

        end if;

        assert(p >= 0.0, "介质压力 (= " + String(p) + " Pa) \"" + 
          mediumName + "\" 为负数\n(温度 = " + String(T) + " K)");
        annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
          -100}, {100, 100}}), graphics = {Rectangle(
          extent = {{-100, 100}, {100, -100}}, 
          fillColor = {255, 255, 255}, 
          fillPattern = FillPattern.Solid, 
          lineColor = {0, 0, 255}), Text(
          extent = {{-152, 164}, {152, 102}}, 
          textString = "%name", 
          textColor = {0, 0, 255})}), Documentation(info = "<html>
<p>
模型<strong>BaseProperties</strong>是PartialMedium包中的一个模型，包含了每个介质模型都应支持的最少数量变量的声明。具体介质从模型<strong>BaseProperties</strong>继承，并提供基本属性的方程。
</p>
<p>
BaseProperties模型包含以下<strong>7+nXi个变量</strong>（nXi是PartialMedium包中定义的独立质量分数的数量）：
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>变量</strong></td>
<td><strong>单位</strong></td>
<td><strong>描述</strong></td></tr>
<tr><td>T</td>
<td>K</td>
<td>温度</td></tr>
<tr><td>p</td>
<td>Pa</td>
<td>绝对压力</td></tr>
<tr><td>d</td>
<td>kg/m3</td>
<td>密度</td></tr>
<tr><td>h</td>
<td>J/kg</td>
<td>比焓</td></tr>
<tr><td>u</td>
<td>J/kg</td>
<td>比内能</td></tr>
<tr><td>Xi[nXi]</td>
<td>kg/kg</td>
<td>结构独立质量分数</td></tr>
<tr><td>R_s</td>
<td>J/(kg.K)</td>
<td>比气体常数（如果适用，则为混合物）</td></tr>
<tr><td>MM</td>
<td>kg/mol</td>
<td>摩尔质量</td></tr>
</table>
<p>
为了实现实际的介质模型，可以从这个基本模型扩展，并添加<strong>5个方程</strong>，这些方程提供这些变量之间的关系。还必须添加方程以设置ThermodynamicState记录状态中的所有变量。</p>
<p>
如果standardOrderComponents=true，则完整的组成向量X[nX]由包含在此基类中的方程确定，具体取决于独立质量分数向量Xi[nXi]。</p>
<p>使用BaseProperties模型时，还必须提供额外的<strong>2 + nXi</strong>方程，以完全指定热力学条件。应用于p、h和nXi的输入连接器限定符间接声明了缺失方程的数量，允许Modelica工具进行高级方程平衡检查。
请注意，这并不意味着附加方程应该是连接方程，也不意味着必须提供完全那些变量才能完成模型。
有关更多信息，请参见<a href=\"modelica://Modelica.Media.UsersGuide\">Modelica.Media用户指南</a>，以及<a href=\"https://specification.modelica.org/v3.4/Ch4.html#balanced-models\">Modelica 3.4规范的第4.7节（平衡模型）</a>。
</p>
</html>"));
      end BaseProperties;

      replaceable partial function setState_pTX 
        "根据p,T和组分X或Xi计算热力状态"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input Temperature T "温度";
        input MassFraction X[:] = reference_X "质量分数";
        output ThermodynamicState state "热力状态记录";
        annotation();
      end setState_pTX;

      replaceable partial function setState_phX 
        "根据p,h和组分X或Xi计算热力状态"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input SpecificEnthalpy h "比焓";
        input MassFraction X[:] = reference_X "质量分数";
        output ThermodynamicState state "热力状态记录";
        annotation();
      end setState_phX;

      replaceable partial function setState_psX 
        "根据p,s和组分X或Xi计算热力状态"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input SpecificEntropy s "比熵";
        input MassFraction X[:] = reference_X "质量分数";
        output ThermodynamicState state "热力状态记录";
        annotation();
      end setState_psX;

      replaceable partial function setState_dTX 
        "根据p,d和组分X或Xi计算热力状态"
        extends Modelica.Icons.Function;
        input Density d "密度";
        input Temperature T "温度";
        input MassFraction X[:] = reference_X "质量分数";
        output ThermodynamicState state "热力状态记录";
        annotation();
      end setState_dTX;

      replaceable partial function setSmoothState 
        "返回热力学状态,使其平滑逼近：如果x>0,则为state_a,否则为state_b"
        extends Modelica.Icons.Function;
        input Real x "m_flow或dp";
        input ThermodynamicState state_a "x>0时的热力状态";
        input ThermodynamicState state_b "x<0时的热力状态";
        input Real x_small(min = 0) 
          "在区域-x_small < x < x_small内进行平滑过渡";
        output ThermodynamicState state 
          "平滑的热力学状态对于所有x(连续且可微)";
        annotation(Documentation(info = "<html>
<p>
这个函数用于近似方程
</p>
<blockquote><pre>
state = <strong>if</strong> x &gt; 0 <strong>then</strong> state_a <strong>else</strong> state_b;
</pre></blockquote>

<p>
通过一个平滑特性，使得表达式连续且可微分：
</p>

<blockquote><pre>
state := <strong>smooth</strong>(1, <strong>if</strong> x &gt;  x_small <strong>then</strong> state_a <strong>else</strong>
<strong>if</strong> x &lt; -x_small <strong>then</strong> state_b <strong>else</strong> f(state_a, state_b));
</pre></blockquote>

<p>
这是通过在热力学状态记录的每个元素上应用函数 <strong>Media.Common.smoothStep</strong>(..) 来执行的。
</p>

<p>
如果<strong>质量分数</strong> X[:] 使用这个函数近似，则可以对所有的 <strong>nX</strong> 质量分数执行这个操作，而不是对 nX-1 个质量分数执行，并通过质量分数约束 sum(X)=1 计算最后一个。原因是近似函数具有以下属性：sum(state.X) = 1，前提是 sum(state_a.X) = sum(state_b.X) = 1。
这可以通过在 abs(x) &lt; x_small 区域内评估近似函数来证明（否则 state.X 要么是 state_a.X 要么是 state_b.X）：
</p>

<blockquote><pre>
X[1]  = smoothStep(x, X_a[1] , X_b[1] , x_small);
X[2]  = smoothStep(x, X_a[2] , X_b[2] , x_small);
...
X[nX] = smoothStep(x, X_a[nX], X_b[nX], x_small);
</pre></blockquote>

<p>
或者
</p>

<blockquote><pre>
X[1]  = c*(X_a[1]  - X_b[1])  + (X_a[1]  + X_b[1])/2
X[2]  = c*(X_a[2]  - X_b[2])  + (X_a[2]  + X_b[2])/2;
...
X[nX] = c*(X_a[nX] - X_b[nX]) + (X_a[nX] + X_b[nX])/2;
c     = (x/x_small)*((x/x_small)^2 - 3)/4
</pre></blockquote>

<p>
所有质量分数求和的结果为
</p>

<blockquote><pre>
sum(X) = c*(sum(X_a) - sum(X_b)) + (sum(X_a) + sum(X_b))/2
= c*(1 - 1) + (1 + 1)/2
= 1
</pre></blockquote>

</html>"));
      end setSmoothState;

      replaceable partial function dynamicViscosity "计算动力黏度"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "热力状态记录";
        output DynamicViscosity eta "动力黏度";
        annotation();
      end dynamicViscosity;

      replaceable partial function thermalConductivity 
        "计算导热系数"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "热力状态记录";
        output ThermalConductivity lambda "导热系数";
        annotation();
      end thermalConductivity;

      replaceable function prandtlNumber "计算普朗特数"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "热力状态记录";
        output PrandtlNumber Pr "普朗特数";
        annotation();
      algorithm
        Pr := dynamicViscosity(state) * specificHeatCapacityCp(state) / 
          thermalConductivity(state);
      end prandtlNumber;

      replaceable partial function pressure "计算压力"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "热力状态记录";
        output AbsolutePressure p "压力";
        annotation();
      end pressure;

      replaceable partial function temperature "计算温度"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "热力状态记录";
        output Temperature T "温度";
        annotation();
      end temperature;

      replaceable partial function density "计算密度"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "热力状态记录";
        output Density d "密度";
        annotation();
      end density;

      replaceable partial function specificEnthalpy "计算比焓"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "热力状态记录";
        output SpecificEnthalpy h "比焓";
        annotation();
      end specificEnthalpy;

      replaceable partial function specificInternalEnergy 
        "计算比内能"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "热力状态记录";
        output SpecificEnergy u "比内能";
        annotation();
      end specificInternalEnergy;

      replaceable partial function specificEntropy "计算比熵"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "热力状态记录";
        output SpecificEntropy s "比熵";
        annotation();
      end specificEntropy;

      replaceable partial function specificGibbsEnergy 
        "计算比吉布斯能"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "热力状态记录";
        output SpecificEnergy g "比吉布斯能";
        annotation();
      end specificGibbsEnergy;

      replaceable partial function specificHelmholtzEnergy 
        "计算比亥姆霍兹能"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "热力状态记录";
        output SpecificEnergy f "比亥姆霍兹能";
        annotation();
      end specificHelmholtzEnergy;

      replaceable partial function specificHeatCapacityCp 
        "计算定压比热"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "热力状态记录";
        output SpecificHeatCapacity cp 
          "定压比热";
        annotation();
      end specificHeatCapacityCp;

      function heatCapacity_cp = specificHeatCapacityCp 
        "定压比热函数别名" annotation();

      replaceable partial function specificHeatCapacityCv 
        "计算定容比热"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "热力状态记录";
        output SpecificHeatCapacity cv 
          "定容比热";
        annotation();
      end specificHeatCapacityCv;

      function heatCapacity_cv = specificHeatCapacityCv 
        "定容比热函数别名" annotation();

      replaceable partial function isentropicExponent 
        "计算等熵指数"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "热力状态记录";
        output IsentropicExponent gamma "等熵指数";
        annotation();
      end isentropicExponent;

      replaceable partial function isentropicEnthalpy 
        "计算等熵焓降"
        extends Modelica.Icons.Function;
        input AbsolutePressure p_downstream "下游压力";
        input ThermodynamicState refState "熵的参考状态";
        output SpecificEnthalpy h_is "等熵焓降";
        annotation(Documentation(info = "<html>
<p>
这个函数计算等熵状态转换：
</p>
<ol>
<li> 介质处于特定状态 refState。</li>
<li> 在假设从 refState 到 h_is 的状态转换是在特定熵变化 ds = 0 的条件下进行的，并且状态 h_is 的压力为 p_downstream，假定上游和下游的组成 X 是相同的。</li>
</ol>

</html>"));
      end isentropicEnthalpy;

      replaceable partial function velocityOfSound "计算声速"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "热力状态记录";
        output VelocityOfSound a "声速";
        annotation();
      end velocityOfSound;

      replaceable partial function isobaricExpansionCoefficient 
        "计算等压膨胀系数"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "热力状态记录";
        output IsobaricExpansionCoefficient beta "等压膨胀系数";
        annotation(Documentation(info = "<html>
<blockquote><pre>
beta is defined as  1/v * der(v,T), with v = 1/d, at constant pressure p.
</pre></blockquote>
</html>"));
      end isobaricExpansionCoefficient;

      function beta = isobaricExpansionCoefficient 
        "等压膨胀系数函数别名" annotation();

      replaceable partial function isothermalCompressibility 
        "计算等温压缩系数"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "热力状态记录";
        output SI.IsothermalCompressibility kappa "等温压缩系数";
        annotation(Documentation(info = "<html>
<blockquote><pre>

kappa is defined as - 1/v * der(v,p), with v = 1/d at constant temperature T.

</pre></blockquote>
</html>"));
      end isothermalCompressibility;

      function kappa = isothermalCompressibility 
        "等温压缩系数别名" annotation();

      // explicit derivative functions for finite element models
      replaceable partial function density_derp_h 
        "计算定比焓下,密度关于压力的偏导数"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "热力状态记录";
        output DerDensityByPressure ddph "密度关于压力的偏导数";
        annotation();
      end density_derp_h;

      replaceable partial function density_derh_p 
        "计算定压下,密度关于比焓的偏导数"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "热力状态记录";
        output DerDensityByEnthalpy ddhp 
          "密度关于比焓的偏导数";
        annotation();
      end density_derh_p;

      replaceable partial function density_derp_T 
        "计算定温下,密度关于压力的偏导数"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "热力状态记录";
        output DerDensityByPressure ddpT "密度关于压力的偏导数";
        annotation();
      end density_derp_T;

      replaceable partial function density_derT_p 
        "计算定压下,密度关于温度的偏导数"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "热力状态记录";
        output DerDensityByTemperature ddTp 
          "密度关于温度的偏导数";
        annotation();
      end density_derT_p;

      replaceable partial function density_derX 
        "计算密度关于质量分数的偏导数"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "热力状态记录";
        output Density[nX] dddX "密度关于质量分数的偏导数";
        annotation();
      end density_derX;

      replaceable partial function molarMass 
        "计算介质摩尔质量"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "热力状态记录";
        output MolarMass MM "混合摩尔质量";
        annotation();
      end molarMass;

      replaceable function specificEnthalpy_pTX 
        "根据p,T和X或Xi计算比焓"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input Temperature T "温度";
        input MassFraction X[:] = reference_X "质量分数";
        output SpecificEnthalpy h "比焓";
      algorithm
        h := specificEnthalpy(setState_pTX(
          p, 
          T, 
          X));
        annotation(inverse(T = temperature_phX(
          p, 
          h, 
          X)));
      end specificEnthalpy_pTX;

      replaceable function specificEntropy_pTX 
        "根据p,T和X或Xi计算比熵"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input Temperature T "温度";
        input MassFraction X[:] = reference_X "质量分数";
        output SpecificEntropy s "比熵";
      algorithm
        s := specificEntropy(setState_pTX(
          p, 
          T, 
          X));

        annotation(inverse(T = temperature_psX(
          p, 
          s, 
          X)));
      end specificEntropy_pTX;

      replaceable function density_pTX "根据p,T和X或Xi计算密度"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input Temperature T "温度";
        input MassFraction X[:] "质量分数";
        output Density d "密度";
        annotation();
      algorithm
        d := density(setState_pTX(
          p, 
          T, 
          X));
      end density_pTX;

      replaceable function temperature_phX 
        "根据p,h和X或Xi计算温度"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input SpecificEnthalpy h "比焓";
        input MassFraction X[:] = reference_X "质量分数";
        output Temperature T "温度";
        annotation();
      algorithm
        T := temperature(setState_phX(
          p, 
          h, 
          X));
      end temperature_phX;

      replaceable function density_phX "根据p,h和X或Xi计算密度"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input SpecificEnthalpy h "比焓";
        input MassFraction X[:] = reference_X "质量分数";
        output Density d "密度";
        annotation();
      algorithm
        d := density(setState_phX(
          p, 
          h, 
          X));
      end density_phX;

      replaceable function temperature_psX 
        "根据p,s和X或Xi计算温度"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input SpecificEntropy s "比熵";
        input MassFraction X[:] = reference_X "质量分数";
        output Temperature T "温度";
      algorithm
        T := temperature(setState_psX(
          p, 
          s, 
          X));
        annotation(inverse(s = specificEntropy_pTX(
          p, 
          T, 
          X)));
      end temperature_psX;

      replaceable function density_psX "根据p,s和X或Xi计算密度"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input SpecificEntropy s "比熵";
        input MassFraction X[:] = reference_X "质量分数";
        output Density d "密度";
        annotation();
      algorithm
        d := density(setState_psX(
          p, 
          s, 
          X));
      end density_psX;

      replaceable function specificEnthalpy_psX 
        "根据p,s和X或Xi计算比焓"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input SpecificEntropy s "比熵";
        input MassFraction X[:] = reference_X "质量分数";
        output SpecificEnthalpy h "比焓";
        annotation();
      algorithm
        h := specificEnthalpy(setState_psX(
          p, 
          s, 
          X));
      end specificEnthalpy_psX;

      type MassFlowRate = SI.MassFlowRate(
        quantity = "MassFlowRate." + mediumName, 
        min = -1.0e5, 
        max = 1.e5) "具有介质特定属性的质量流量类" annotation();

      annotation(Documentation(info = "<html><p>
<strong>PartialMedium</strong>库包含了介质的所有声明。 这意味着定义了所有介质都应支持的常量、模型和函数（其中一些是可选的）。 介质库继承自<strong>PartialMedium</strong>，并为介质提供方程。 此库的详细信息在<a href=\"modelica://Modelica.Media.UsersGuide\" target=\"\">Modelica.Media.UsersGuide</a>中描述。
</p>
</html>", revisions = "<html>

</html>"));
    end PartialMedium;

    partial package PartialPureSubstance 
      "用于单一化学物质纯净物的基类"
      extends PartialMedium(final reducedX = true, final fixedX = true);

      replaceable function setState_pT "根据p和T计算热力状态"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input Temperature T "温度";
        output ThermodynamicState state "热力状态记录";
        annotation();
      algorithm
        state := setState_pTX(
          p, 
          T, 
          fill(0, 0));
      end setState_pT;

      replaceable function setState_ph "根据p和h计算热力状态"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input SpecificEnthalpy h "比焓";
        output ThermodynamicState state "热力状态记录";
        annotation();
      algorithm
        state := setState_phX(
          p, 
          h, 
          fill(0, 0));
      end setState_ph;

      replaceable function setState_ps "根据p和s计算热力状态"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input SpecificEntropy s "比熵";
        output ThermodynamicState state "热力状态记录";
        annotation();
      algorithm
        state := setState_psX(
          p, 
          s, 
          fill(0, 0));
      end setState_ps;

      replaceable function setState_dT "根据d和T计算热力状态"
        extends Modelica.Icons.Function;
        input Density d "密度";
        input Temperature T "温度";
        output ThermodynamicState state "热力状态记录";
        annotation();
      algorithm
        state := setState_dTX(
          d, 
          T, 
          fill(0, 0));
      end setState_dT;

      replaceable function density_ph "根据p和h计算密度"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input SpecificEnthalpy h "比焓";
        output Density d "密度";
        annotation();
      algorithm
        d := density_phX(
          p, 
          h, 
          fill(0, 0));
      end density_ph;

      replaceable function temperature_ph "根据p和T计算温度"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input SpecificEnthalpy h "比焓";
        output Temperature T "温度";
        annotation();
      algorithm
        T := temperature_phX(
          p, 
          h, 
          fill(0, 0));
      end temperature_ph;

      replaceable function pressure_dT "根据d和T计算压力"
        extends Modelica.Icons.Function;
        input Density d "密度";
        input Temperature T "温度";
        output AbsolutePressure p "压力";
        annotation();
      algorithm
        p := pressure(setState_dTX(
          d, 
          T, 
          fill(0, 0)));
      end pressure_dT;

      replaceable function specificEnthalpy_dT 
        "根据d和T计算比焓"
        extends Modelica.Icons.Function;
        input Density d "密度";
        input Temperature T "温度";
        output SpecificEnthalpy h "比焓";
        annotation();
      algorithm
        h := specificEnthalpy(setState_dTX(
          d, 
          T, 
          fill(0, 0)));
      end specificEnthalpy_dT;

      replaceable function specificEnthalpy_ps 
        "根据p和s计算比焓"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input SpecificEntropy s "比熵";
        output SpecificEnthalpy h "比焓";
        annotation();
      algorithm
        h := specificEnthalpy_psX(
          p, 
          s, 
          fill(0, 0));
      end specificEnthalpy_ps;

      replaceable function temperature_ps "根据p和s计算温度"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input SpecificEntropy s "比熵";
        output Temperature T "温度";
        annotation();
      algorithm
        T := temperature_psX(
          p, 
          s, 
          fill(0, 0));
      end temperature_ps;

      replaceable function density_ps "根据p和s计算密度"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input SpecificEntropy s "比熵";
        output Density d "密度";
        annotation();
      algorithm
        d := density_psX(
          p, 
          s, 
          fill(0, 0));
      end density_ps;

      replaceable function specificEnthalpy_pT 
        "根据p和T计算比焓"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input Temperature T "温度";
        output SpecificEnthalpy h "比焓";
        annotation();
      algorithm
        h := specificEnthalpy_pTX(
          p, 
          T, 
          fill(0, 0));
      end specificEnthalpy_pT;

      replaceable function density_pT "根据p和T计算密度"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input Temperature T "温度";
        output Density d "密度";
        annotation();
      algorithm
        d := density(setState_pTX(
          p, 
          T, 
          fill(0, 0)));
      end density_pT;

      redeclare replaceable partial model extends BaseProperties(final
        standardOrderComponents = true)annotation();

      end BaseProperties;
      annotation();
    end PartialPureSubstance;

    partial package PartialLinearFluid 
      "具有恒定定压比热、等温压缩系数和热膨胀系数的通用纯液体模型"

      extends Interfaces.PartialPureSubstance(ThermoStates = Modelica.Media.Interfaces.Choices.IndependentVariables.pTX, 
        singleState = false);
      constant SpecificHeatCapacity cp_const 
        "定压比热";
      constant IsobaricExpansionCoefficient beta_const 
        "定压下热膨胀系数";
      constant SI.IsothermalCompressibility kappa_const 
        "等温压缩系数";
      constant MolarMass MM_const "摩尔质量";
      constant Density reference_d "基准条件下的密度";
      constant SpecificEnthalpy reference_h 
        "基准条件下的比焓";
      constant SpecificEntropy reference_s 
        "基准条件下的比熵";
      constant Boolean constantJacobian 
        "=true,在基准条件下热力学雅各比矩阵中的条目是常数";

      redeclare record ThermodynamicState 
        "唯一确定热力学状态的变量组"
        extends Modelica.Icons.Record;
        AbsolutePressure p "介质绝对压力";
        Temperature T "介质温度";
        annotation();
      end ThermodynamicState;

      redeclare model extends BaseProperties(T(stateSelect = if 
        preferredMediumStates then StateSelect.prefer else StateSelect.default), 
        p(stateSelect = if preferredMediumStates then StateSelect.prefer else 
        StateSelect.default)) "介质基础属性"
        annotation();
      equation
        d = (1 + (p - reference_p) * kappa_const - (T - reference_T) * beta_const) * 
          reference_d;
        h = reference_h + (T - reference_T) * cp_const + (p - reference_p) * (1 - 
          beta_const * reference_T) / reference_d;
        u = h - p / d;
        p = state.p;
        T = state.T;
        MM = MM_const;
        R_s = Modelica.Constants.R / MM;
      end BaseProperties;

      redeclare function extends setState_pTX 
        "根据p和T计算热力状态(无需X)"
        annotation();
      algorithm
        state := ThermodynamicState(p = p, T = T);
      end setState_pTX;

      redeclare function extends setState_phX 
        "根据p和h计算热力状态(无需X)"
        annotation();
      algorithm
        state := ThermodynamicState(p = p, T = (h - reference_h - (p - reference_p) * (
          (1 - beta_const * reference_T) / reference_d)) / cp_const + reference_T);
      end setState_phX;

      redeclare function extends setState_psX 
        "根据p和s计算热力状态(无需X)"
        annotation();
      algorithm
        state := ThermodynamicState(p = p, T = reference_T * cp_const / (cp_const - s + 
          reference_s + (p - reference_p) * (-beta_const / reference_d)));
      end setState_psX;

      redeclare function extends setState_dTX 
        "根据d和T计算热力状态(无需X)"
        annotation();
      algorithm
        state := ThermodynamicState(p = ((d - reference_d) + (T - reference_T) 
          * beta_const * reference_d) / (reference_d * kappa_const) + reference_p, T = T);
      end setState_dTX;

      redeclare function extends setSmoothState 
        "返回热力学状态,使其平滑逼近：如果x>0,则为state_a,否则为state_b"
        annotation();
      algorithm
        state := ThermodynamicState(p = Media.Common.smoothStep(
          x, 
          state_a.p, 
          state_b.p, 
          x_small), T = Media.Common.smoothStep(
          x, 
          state_a.T, 
          state_b.T, 
          x_small));
      end setSmoothState;

      redeclare function extends pressure 
        "根据热力状态计算压力"
        annotation();
      algorithm
        p := state.p;
      end pressure;

      redeclare function extends temperature 
        "根据热力状态计算温度"
        annotation();
      algorithm
        T := state.T;
      end temperature;

      redeclare function extends density 
        "根据热力状态计算密度"
        annotation();
      algorithm
        d := (1 + (state.p - reference_p) * kappa_const - (state.T - reference_T) * 
          beta_const) * reference_d;
      end density;

      redeclare function extends specificEnthalpy 
        "根据热力状态计算比焓"
        annotation();
      algorithm
        h := reference_h + (state.T - reference_T) * cp_const + (state.p - 
          reference_p) * (1 - beta_const * reference_T) / reference_d;
      end specificEnthalpy;

      redeclare function extends specificEntropy 
        "根据热力状态计算比熵"
        annotation();
      algorithm
        s := reference_s + (state.T - reference_T) * cp_const / state.T + (state.p - 
          reference_p) * (-beta_const / reference_d);
      end specificEntropy;

      redeclare function extends specificInternalEnergy 
        "根据热力状态计算比内能"
        annotation();
      algorithm
        u := specificEnthalpy(state) - state.p / reference_d;
      end specificInternalEnergy;

      redeclare function extends specificGibbsEnergy 
        "根据热力状态计算比吉布斯能"
        extends Modelica.Icons.Function;
        annotation();
      algorithm
        g := specificEnthalpy(state) - state.T * specificEntropy(state);
      end specificGibbsEnergy;

      redeclare function extends specificHelmholtzEnergy 
        "根据热力状态计算比亥姆霍兹能"
        extends Modelica.Icons.Function;
        annotation();
      algorithm
        f := specificInternalEnergy(state) - state.T * specificEntropy(state);
      end specificHelmholtzEnergy;

      redeclare function extends velocityOfSound 
        "根据热力状态计算声速"
        extends Modelica.Icons.Function;
        annotation();
      algorithm
        a := sqrt(max(0, 1 / (kappa_const * density(state) - beta_const * beta_const * 
          state.T / cp_const)));
      end velocityOfSound;

      redeclare function extends isentropicExponent 
        "根据热力状态计算等熵指数"
        extends Modelica.Icons.Function;
        annotation();
      algorithm
        gamma := 1 / (state.p * kappa_const) * cp_const / specificHeatCapacityCv(state);
      end isentropicExponent;

      redeclare function extends isentropicEnthalpy "计算等熵焓"

      /* Previous wrong equation:
      
      protected
      SpecificEntropy s_upstream = specificEntropy(refState)
      "Specific entropy at component inlet";
      ThermodynamicState downstreamState "State at downstream location";
      algorithm
      downstreamState.p := p_downstream;
      downstreamState.T := reference_T*cp_const/
      (s_upstream -reference_s -(p_downstream-reference_p)*(-beta_const/reference_d) - cp_const);
      h_is := specificEnthalpy(downstreamState);
      */
      algorithm
        /* s := reference_s + (refState.T-reference_T)*cp_const/refState.T +
        (refState.p-reference_p)*(-beta_const/reference_d)
        = reference_s + (state.T-reference_T)*cp_const/state.T +
        (p_downstream-reference_p)*(-beta_const/reference_d);
        
        (state.T-reference_T)*cp_const/state.T
        = (refState.T-reference_T)*cp_const/refState.T + (refState.p-reference_p)*(-beta_const/reference_d)
        - (p_downstream-reference_p)*(-beta_const/reference_d)
        = (refState.T-reference_T)*cp_const/refState.T + (refState.p-p_downstream)*(-beta_const/reference_d)
        
        (x - reference_T)/x = k
        x - reference_T = k*x
        (1-k)*x = reference_T
        x = reference_T/(1-k);
        
        state.T = reference_T/(1 - ((refState.T-reference_T)*cp_const/refState.T + (refState.p-p_downstream)*(-beta_const/reference_d))/cp_const)
        */

        h_is := specificEnthalpy(setState_pTX(
          p_downstream, 
          reference_T / (1 - ((refState.T - reference_T) / refState.T + (
          refState.p - p_downstream) * (-beta_const / (reference_d * cp_const)))), 
          reference_X));
        annotation(Documentation(info = "<html>
<p>
使用了一个小的近似：使用参考密度代替真实密度，后者需要数值解。
</p>
</html>"));
      end isentropicEnthalpy;

      redeclare function extends specificHeatCapacityCp 
        "计算定压比热"
        annotation();
      algorithm
        cp := cp_const;
      end specificHeatCapacityCp;

      redeclare function extends specificHeatCapacityCv 
        "根据热力状态计算定容比热"
        annotation();
      algorithm
        cv := if constantJacobian then cp_const - reference_T * beta_const * 
          beta_const / (kappa_const * reference_d) else state.T * beta_const * beta_const 
          / (kappa_const * reference_d);
      end specificHeatCapacityCv;

      redeclare function extends isothermalCompressibility 
        "计算等温压缩系数kappa"
        annotation();
      algorithm
        kappa := kappa_const;
      end isothermalCompressibility;

      redeclare function extends isobaricExpansionCoefficient 
        "计算等压膨胀系数"
        annotation();
      algorithm
        beta := beta_const;
      end isobaricExpansionCoefficient;

      redeclare function extends density_derp_h 
        "计算定比焓下,密度关于压力的偏导数"
        annotation();
      algorithm
        ddph := if constantJacobian then kappa_const * reference_d + (beta_const * (1 
          - reference_T * beta_const)) / cp_const else kappa_const * density(state) + 
          (beta_const * (1 - temperature(state) * beta_const)) / cp_const;
      end density_derp_h;

      redeclare function extends density_derh_p 
        "计算定压下,密度关于比焓的偏导数"
        annotation();
      algorithm
        ddhp := if constantJacobian then -beta_const * reference_d / cp_const else -
          beta_const * density(state) / cp_const;
      end density_derh_p;

      redeclare function extends density_derp_T 
        "计算定温下,密度关于压力的偏导数"
        annotation();
      algorithm
        ddpT := if constantJacobian then kappa_const * reference_d else kappa_const 
          * density(state);
      end density_derp_T;

      redeclare function extends density_derT_p 
        "计算定压下,密度关于温度的偏导数"
        annotation();
      algorithm
        ddTp := if constantJacobian then -beta_const * reference_d else -beta_const 
          * density(state);
      end density_derT_p;

      redeclare function extends density_derX 
        "计算定压定温下,密度关于质量分数的偏导数"
        annotation();
      algorithm
        dddX := fill(0, nX);
      end density_derX;

      redeclare function extends molarMass "计算摩尔质量"
        annotation();
      algorithm
        MM := MM_const;
      end molarMass;

      function T_ph "根据p和h计算温度"
        extends Modelica.Icons.Function;
        input SpecificEnthalpy h "比焓";
        input AbsolutePressure p "压力";
        output Temperature T "温度";
        annotation();
      algorithm
        T := (h - reference_h - (p - reference_p) * ((1 - beta_const * reference_T) / 
          reference_d)) / cp_const + reference_T;
      end T_ph;

      function T_ps "根据p和s计算温度"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input SpecificEntropy s "比熵";
        output Temperature T "温度";
        annotation();
      algorithm
        T := reference_T * cp_const / (s - reference_s - (p - reference_p) * (-
          beta_const / reference_d) - cp_const);
      end T_ps;

      annotation(Documentation(info = "<html><h4>线性可压缩流体模型</h4><p>
这个线性可压缩流体模型基于以下假设：
</p>
<li>
在恒压条件下的比热容（cp）是恒定的</li>
<li>
等压膨胀系数（beta）是恒定的</li>
<li>
等温压缩系数（kappa）是恒定的</li>
<li>
压力和温度作为状态</li>
<li>
密度对比焓（h）、熵（s）、内能（u）和定容热容（cv）的影响被忽略。</li>
<p>
这意味着密度是温度和压力的线性函数。为完整定义该模型，需要基于状态压力p和温度T的参考值计算得到一系列恒定参考参数。该模型可视为对完整非线性流体模型的线性化处理（但并非在所有热力学坐标下都呈现线性关系）。参考值需要：
</p>
<ol><li>
密度（reference_d），</li>
<li>
比焓（reference_h），</li>
<li>
比熵（reference_s）。</li>
</ol><p>
除此之外，用户还需要定义摩尔质量 MM_const。请注意，可通过以下方式定义流体：基于完整非线性流体模型计算参考值，即利用流体库中定义的标准函数计算库内预定义常数（具体示例参见液体库）。
</p>
<p>
为了避免在 T_ph 和 T_ps 函数中对温度进行数值反算，在计算 h、s、u 和 cv 时始终将密度设为参考密度。对于液体（本模型仅用于液体），这样做的相对误差最多为 1e-3 至 1e-4。如果在计算 h、s、u 和 cv 时将 reference_d 替换为调用 density(state)，那么基于其他假设的模型将更加 \"正确\"。求解T_ps需采用数值方法，而T_ph可通过二次函数进行符号解析。由于液体密度变化微小，此类近似引入的误差可忽略不计。
</p>
<h4>效率考虑</h4><p>
使用简单线性流体模型的主要原因之一是为了实现高性能计算。为提升运行效率，存在多种可权衡的折衷方案及优化途径，其中部分选项可通过标志位调控。本模型采用以下设计准则：
</p>
<li>
所有正向评估（使用 ThermodynamicState 记录作为输入）都严格遵循上述假设。</li>
<li>
如果库中将标志 <strong>constantJacobian</strong> 设置为 true，则所有通常出现在热力学雅可比矩阵中的函数（specificHeatCapacityCv、density_derp_h、density_derh_p、density_derp_T、density_derT_p）将在参考条件（即使用参考密度）而不是当前压力和温度的密度下进行评估。这使得可以在编译时评估热力学雅可比矩阵。</li>
<li>
对于使用状态以外的其他输入的反函数（例如压力 p 和比焓 h），反算将使用参考状态，无论何时需要进行符号反算。</li>
<li>
如果 <strong>constantJacobian</strong> 标志设置为 false，则以上列表中的函数将根据上述假设进行精确计算。</li>
<li>
</li>
<li>
<strong>作者：</strong></li>
<li>
Francesco Casella<br><br>Dipartimento di Elettronica e Informazione<br><br>Politecnico di Milano<br><br>Via Ponzio 34/5<br><br>I-20133 Milano, Italy<br><br>email: <a href=\"mailto:casella@elet.polimi.it\" target=\"\">casella@elet.polimi.it</a>&nbsp;<br><br>和<br><br>Hubertus Tummescheit<br><br>Modelon AB<br><br>Ideon Science Park<br><br>SE-22730 Lund, Sweden<br><br>email: <a href=\"mailto:Hubertus.Tummescheit@Modelon.se\" target=\"\">Hubertus.Tummescheit@Modelon.se</a>&nbsp;</li>
</html>"));
    end PartialLinearFluid;

    partial package PartialMixtureMedium 
      "多种化学纯物质混合物的基类"
      extends PartialMedium(redeclare replaceable record FluidConstants = 
        Modelica.Media.Interfaces.Types.IdealGas.FluidConstants);

      redeclare replaceable record extends ThermodynamicState 
        "热力学状态"
        AbsolutePressure p "介质绝对压力";
        Temperature T "介质温度";
        MassFraction[nX] X(start = reference_X) 
          "质量分数(=组分质量/总质量 m_i/m)";
        annotation();
      end ThermodynamicState;

      constant FluidConstants[nS] fluidConstants "流体常数";

      replaceable function gasConstant 
        "计算混合物气体常数(液体也可)"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "热力学状态记录";
        output SI.SpecificHeatCapacity R_s "混合气体常数";
        annotation();
      end gasConstant;

      function moleToMassFractions "根据摩尔分数计算质量分数X"
        extends Modelica.Icons.Function;
        input SI.MoleFraction moleFractions[:] "混合物摩尔分数";
        input MolarMass[:] MMX "组分的摩尔质量";
        output SI.MassFraction X[size(moleFractions, 1)] 
          "气体混合物质量分数";
      protected
        MolarMass Mmix = moleFractions * MMX "混合物摩尔质量";
      algorithm
        for i in 1:size(moleFractions, 1) loop
          X[i] := moleFractions[i] * MMX[i] / Mmix;
        end for;
        annotation(smoothOrder = 5);
      end moleToMassFractions;

      function massToMoleFractions "根据质量分数X计算摩尔分数"
        extends Modelica.Icons.Function;
        input SI.MassFraction X[:] "混合物质量分数";
        input SI.MolarMass[:] MMX "组分的摩尔质量";
        output SI.MoleFraction moleFractions[size(X, 1)] 
          "气体混合物的摩尔分数";
      protected
        Real invMMX[size(X, 1)] "摩尔质量的倒数";
        SI.MolarMass Mmix "混合物的摩尔质量";
      algorithm
        for i in 1:size(X, 1) loop
          invMMX[i] := 1 / MMX[i];
        end for;
        Mmix := 1 / (X * invMMX);
        for i in 1:size(X, 1) loop
          moleFractions[i] := Mmix * X[i] / MMX[i];
        end for;
        annotation(smoothOrder = 5);
      end massToMoleFractions;
      annotation();

    end PartialMixtureMedium;

    partial package PartialCondensingGases 
      "可凝结与不可凝结气体混合物的基类"
      extends PartialMixtureMedium(ThermoStates = Modelica.Media.Interfaces.Choices.IndependentVariables.pTX);

      replaceable partial function saturationPressure 
        "计算冷凝流体的饱和压力"
        extends Modelica.Icons.Function;
        input Temperature Tsat "饱和温度";
        output AbsolutePressure psat "饱和压力";
        annotation();
      end saturationPressure;

      replaceable partial function enthalpyOfVaporization 
        "计算冷凝流体的汽化焓"
        extends Modelica.Icons.Function;
        input Temperature T "温度";
        output SpecificEnthalpy r0 "汽化焓";
        annotation();
      end enthalpyOfVaporization;

      replaceable partial function enthalpyOfLiquid 
        "计算冷凝流体的液体焓"
        extends Modelica.Icons.Function;
        input Temperature T "温度";
        output SpecificEnthalpy h "液体焓";
        annotation();
      end enthalpyOfLiquid;

      replaceable partial function enthalpyOfGas 
        "计算非冷凝气体混合物的焓"
        extends Modelica.Icons.Function;
        input Temperature T "温度";
        input MassFraction[:] X "质量分数向量";
        output SpecificEnthalpy h "比焓";
        annotation();
      end enthalpyOfGas;

      replaceable partial function enthalpyOfCondensingGas 
        "计算冷凝气体(通常是蒸汽)的焓"
        extends Modelica.Icons.Function;
        input Temperature T "温度";
        output SpecificEnthalpy h "比焓";
        annotation();
      end enthalpyOfCondensingGas;

      replaceable partial function enthalpyOfNonCondensingGas 
        "计算非冷凝介质的焓"
        extends Modelica.Icons.Function;
        input Temperature T "温度";
        output SpecificEnthalpy h "比焓";
        annotation();
      end enthalpyOfNonCondensingGas;
      annotation();
    end PartialCondensingGases;

    partial package PartialRealCondensingGases 
      "用于真实的可凝结和不可凝结气体混合物的基类"
      extends Modelica.Media.Interfaces.PartialMixtureMedium(
      redeclare replaceable record FluidConstants = 
        Modelica.Media.Interfaces.Types.TwoPhase.FluidConstants);

      replaceable partial function saturationPressure 
        "计算冷凝流体的饱和压力"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "热力状态记录";
        output AbsolutePressure psat "饱和压力";
        annotation();
      end saturationPressure;

      replaceable partial function saturationTemperature 
        "计算冷凝流体的饱和温度"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "热力状态记录";
        output Temperature Tsat "饱和温度";
        annotation();
      end saturationTemperature;

      replaceable partial function massFractionSaturation 
        "计算饱和质量分数"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "热力状态记录";
        output MassFraction[:] Xsat "饱和质量分数";
        annotation();
      end massFractionSaturation;

      replaceable partial function massFraction_pTphi 
        "根据压力,温度和相对湿度计算质量分数"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input Temperature T "温度";
        input Real phi "相对湿度";
        output MassFraction[:] X "质量分数";
        annotation();
      end massFraction_pTphi;

      replaceable partial function relativeHumidity "计算相对湿度"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "热力状态记录";
        output Real phi "相对湿度";
        annotation();
      end relativeHumidity;

      replaceable partial function enthalpyOfVaporization 
        "计算冷凝流体的汽化焓"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "热力状态记录";
        output SpecificEnthalpy r0 "汽化焓";
        annotation();
      end enthalpyOfVaporization;

      replaceable partial function enthalpyOfLiquid 
        "计算冷凝流体的液体焓"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "热力状态记录";
        output SpecificEnthalpy h "液体焓";
        annotation();
      end enthalpyOfLiquid;

      replaceable partial function enthalpyOfGas 
        "计算非冷凝气体混合物的焓"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "热力状态记录";
        output SpecificEnthalpy h "比焓";
        annotation();
      end enthalpyOfGas;

      replaceable partial function enthalpyOfCondensingGas 
        "计算冷凝气体(通常是蒸汽)的焓"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "热力状态记录";
        output SpecificEnthalpy h "比焓";
        annotation();
      end enthalpyOfCondensingGas;

      replaceable partial function enthalpyOfNonCondensingGas 
        "计算非冷凝介质的焓"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "热力状态记录";
        output SpecificEnthalpy h "比焓";
        annotation();
      end enthalpyOfNonCondensingGas;

      replaceable partial function specificEntropy_phX 
        "根据压力,比焓和质量分数计算比熵"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input SpecificEnthalpy h "比焓";
        input MassFraction X[:] = reference_X "质量分数";
        output SpecificEntropy s "比熵";
        annotation();
      algorithm
        s := specificEntropy(setState_phX(
          p, 
          h, 
          X));
      end specificEntropy_phX;
      annotation();

    end PartialRealCondensingGases;

    partial package PartialTwoPhaseMedium 
      "单物质的两相介质基类"
      extends PartialPureSubstance(redeclare replaceable record FluidConstants = 
        Modelica.Media.Interfaces.Types.TwoPhase.FluidConstants);
      constant Boolean smoothModel = false 
        "=true,(导出)模型不应该生成状态事件";
      constant Boolean onePhase = false 
        "=true,(导出)不应该使用两相输入进行调用";

      constant FluidConstants[nS] fluidConstants "流体常数";

      redeclare replaceable record extends ThermodynamicState 
        "两相介质热力状态"
        FixedPhase phase(min = 0, max = 2) 
          "流体的相态:2-两相,1-单相,0-未知,e.g.,交互使用";
        annotation();
      end ThermodynamicState;

      redeclare replaceable partial model extends BaseProperties 
        "两相介质的基础属性(p, d, T, h, u, R_s, MM, sat)"
        SaturationProperties sat "介质压力下的饱和物性";
        annotation();
      end BaseProperties;

      replaceable partial function setDewState 
        "计算露点线上的热力状态"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "饱和点";
        input FixedPhase phase(
          min = 1, 
          max = 2) = 1 "相态:默认为单相";
        output ThermodynamicState state "完整的热力学状态信息";
        annotation();
      end setDewState;

      replaceable partial function setBubbleState 
        "计算泡点线上的热力状态"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "饱和点";
        input FixedPhase phase(
          min = 1, 
          max = 2) = 1 "相态:默认为单相";
        output ThermodynamicState state "完整的热力学状态信息";
        annotation();
      end setBubbleState;

      redeclare replaceable partial function extends setState_dTX 
        "根据d,T和组分X或Xi计算热力状态"
        input FixedPhase phase = 0 
          "2-两相,1-单相,0-未知";
        annotation();
      end setState_dTX;

      redeclare replaceable partial function extends setState_phX 
        "根据p,h和组分X或Xi计算热力状态"
        input FixedPhase phase = 0 
          "2-两相,1-单相,0-未知";
        annotation();
      end setState_phX;

      redeclare replaceable partial function extends setState_psX 
        "根据p,s和组分X或Xi计算热力状态"
        input FixedPhase phase = 0 
          "2-两相,1-单相,0-未知";
        annotation();
      end setState_psX;

      redeclare replaceable partial function extends setState_pTX 
        "根据p,T和组分X或Xi计算热力状态"
        input FixedPhase phase = 0 
          "2-两相,1-单相,0-未知";
        annotation();
      end setState_pTX;

      replaceable function setSat_T 
        "根据T计算饱和状态物性"
        extends Modelica.Icons.Function;
        input Temperature T "温度";
        output SaturationProperties sat "饱和物性记录类";
        annotation();
      algorithm
        sat.Tsat := T;
        sat.psat := saturationPressure(T);
      end setSat_T;

      replaceable function setSat_p 
        "根据p计算饱和状态物性"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        output SaturationProperties sat "饱和物性记录类";
        annotation();
      algorithm
        sat.psat := p;
        sat.Tsat := saturationTemperature(p);
      end setSat_p;
      replaceable function setSat_p_diff2 
        "从压力返回饱和性质记录，二阶可微"
        extends Modelica.Icons.Function;
        input Types.AbsolutePressure p "压力";
        output Types.SaturationProperties sat "饱和物性记录类";
      algorithm
        sat.psat := p;
        sat.Tsat := saturationTemperature(p);
        annotation(smoothOrder = 2);
      end setSat_p_diff2;

      replaceable partial function bubbleEnthalpy 
        "计算泡点比焓"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "饱和物性记录类";
        output SI.SpecificEnthalpy hl "沸腾曲线的比焓";
        annotation();
      end bubbleEnthalpy;

      replaceable partial function dewEnthalpy 
        "计算露点比焓"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "饱和物性记录类";
        output SI.SpecificEnthalpy hv "露点曲线的比焓";
        annotation();
      end dewEnthalpy;

      replaceable partial function bubbleEntropy 
        "计算泡点比熵"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "饱和物性记录类";
        output SI.SpecificEntropy sl "沸腾曲线的比熵";
        annotation();
      end bubbleEntropy;

      replaceable partial function dewEntropy "计算露点比熵"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "饱和物性记录类";
        output SI.SpecificEntropy sv "露点曲线比熵";
        annotation();
      end dewEntropy;

      replaceable partial function bubbleDensity "计算泡点密度"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "饱和物性记录类";
        output Density dl "沸腾曲线密度";
        annotation();
      end bubbleDensity;

      replaceable partial function dewDensity "计算露点密度"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "饱和物性记录类";
        output Density dv "露点曲线密度";
        annotation();
      end dewDensity;

      replaceable partial function saturationPressure 
        "计算饱和压力"
        extends Modelica.Icons.Function;
        input Temperature T "温度";
        output AbsolutePressure p "饱和压力";
        annotation();
      end saturationPressure;

      replaceable partial function saturationTemperature 
        "计算饱和温度"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        output Temperature T "饱和温度";
        annotation();
      end saturationTemperature;

      replaceable function saturationPressure_sat "计算饱和压力"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "饱和物性记录";
        output AbsolutePressure p "饱和压力";
        annotation();
      algorithm
        p := sat.psat;
      end saturationPressure_sat;

      replaceable function saturationTemperature_sat 
        "计算饱和温度"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "饱和物性记录";
        output Temperature T "饱和温度";
        annotation();
      algorithm
        T := sat.Tsat;
      end saturationTemperature_sat;

      replaceable partial function saturationTemperature_derp 
        "计算饱和温度关于压力的偏导数"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        output DerTemperatureByPressure dTp 
          "饱和温度关于压力的偏导数";
        annotation();
      end saturationTemperature_derp;

      replaceable function saturationTemperature_derp_sat 
        "计算饱和温度关于压力的偏导数"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "饱和物性记录";
        output DerTemperatureByPressure dTp 
          "饱和温度关于压力的偏导数";
        annotation();
      algorithm
        dTp := saturationTemperature_derp(sat.psat);
      end saturationTemperature_derp_sat;

      replaceable partial function surfaceTension 
        "计算两相区表面张力"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "饱和物性记录";
        output SurfaceTension sigma 
          "两相区表面张力";
        annotation();
      end surfaceTension;

      redeclare replaceable function extends molarMass 
        "计算介质摩尔质量"
        annotation();
      algorithm
        MM := fluidConstants[1].molarMass;
      end molarMass;

      replaceable partial function dBubbleDensity_dPressure 
        "计算泡点密度偏导数"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "饱和物性记录";
        output DerDensityByPressure ddldp "沸腾曲线上密度的偏导数";
        annotation();
      end dBubbleDensity_dPressure;

      replaceable partial function dDewDensity_dPressure 
        "计算露点密度偏导数"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "饱和物性记录类";
        output DerDensityByPressure ddvdp "饱和蒸汽密度的导数";
        annotation();
      end dDewDensity_dPressure;

      replaceable partial function dBubbleEnthalpy_dPressure 
        "计算泡点比焓的偏导数"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "饱和物性记录";
        output DerEnthalpyByPressure dhldp 
          "沸点曲线上比焓的偏导数";
        annotation();
      end dBubbleEnthalpy_dPressure;

      replaceable partial function dDewEnthalpy_dPressure 
        "计算露点比焓的偏导数"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "饱和物性记录";
        output DerEnthalpyByPressure dhvdp 
          "饱和蒸汽比焓的导数";
        annotation();
      end dDewEnthalpy_dPressure;

      redeclare replaceable function specificEnthalpy_pTX 
        "根据p、T和X计算比焓"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input Temperature T "温度";
        input MassFraction X[:] "质量分数";
        input FixedPhase phase = 0 
          "2-两相,1-单相,0-未知";
        output SpecificEnthalpy h "p、T、X处的比焓";
        annotation();
      algorithm
        h := specificEnthalpy(setState_pTX(
          p, 
          T, 
          X, 
          phase));
      end specificEnthalpy_pTX;

      redeclare replaceable function temperature_phX 
        "根据p、h和X计算温度"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input SpecificEnthalpy h "比焓";
        input MassFraction X[:] "质量分数";
        input FixedPhase phase = 0 
          "2-两相,1-单相,0-未知";
        output Temperature T "温度";
        annotation();
      algorithm
        T := temperature(setState_phX(
          p, 
          h, 
          X, 
          phase));
      end temperature_phX;

      redeclare replaceable function density_phX 
        "根据P、h和X计算密度"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input SpecificEnthalpy h "比焓";
        input MassFraction X[:] "质量分数";
        input FixedPhase phase = 0 
          "2-两相,1-单相,0-未知";
        output Density d "密度";
        annotation();
      algorithm
        d := density(setState_phX(
          p, 
          h, 
          X, 
          phase));
      end density_phX;

      redeclare replaceable function temperature_psX 
        "根据p、s和X计算温度"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input SpecificEntropy s "比熵";
        input MassFraction X[:] "质量分数";
        input FixedPhase phase = 0 
          "2-两相,1-单相,0-未知";
        output Temperature T "温度";
        annotation();
      algorithm
        T := temperature(setState_psX(
          p, 
          s, 
          X, 
          phase));
      end temperature_psX;

      redeclare replaceable function density_psX 
        "根据p、s和X计算密度"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input SpecificEntropy s "比熵";
        input MassFraction X[:] "质量分数";
        input FixedPhase phase = 0 
          "2-两相,1-单相,0-未知";
        output Density d "密度";
        annotation();
      algorithm
        d := density(setState_psX(
          p, 
          s, 
          X, 
          phase));
      end density_psX;

      redeclare replaceable function specificEnthalpy_psX 
        "根据p、s和X计算比焓"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input SpecificEntropy s "比熵";
        input MassFraction X[:] "质量分数";
        input FixedPhase phase = 0 
          "2-两相,1-单相,0-未知";
        output SpecificEnthalpy h "比焓";
        annotation();
      algorithm
        h := specificEnthalpy(setState_psX(
          p, 
          s, 
          X, 
          phase));
      end specificEnthalpy_psX;

      redeclare replaceable function setState_pT 
        "根据p和T计算热力状态"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input Temperature T "温度";
        input FixedPhase phase = 0 
          "2-两相,1-单相,0-未知";
        output ThermodynamicState state "热力状态记录";
        annotation();
      algorithm
        state := setState_pTX(
          p, 
          T, 
          fill(0, 0), 
          phase);
      end setState_pT;

      redeclare replaceable function setState_ph 
        "根据p和h计算热力状态"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input SpecificEnthalpy h "比焓";
        input FixedPhase phase = 0 
          "2-两相,1-单相,0-未知";
        output ThermodynamicState state "热力状态记录";
        annotation();
      algorithm
        state := setState_phX(
          p, 
          h, 
          fill(0, 0), 
          phase);
      end setState_ph;

      redeclare replaceable function setState_ps 
        "根据p和s计算热力状态"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input SpecificEntropy s "比熵";
        input FixedPhase phase = 0 
          "2-两相,1-单相,0-未知";
        output ThermodynamicState state "热力状态记录";
        annotation();
      algorithm
        state := setState_psX(
          p, 
          s, 
          fill(0, 0), 
          phase);
      end setState_ps;

      redeclare replaceable function setState_dT 
        "根据d和T计算热力状态"
        extends Modelica.Icons.Function;
        input Density d "密度";
        input Temperature T "温度";
        input FixedPhase phase = 0 
          "2-两相,1-单相,0-未知";
        output ThermodynamicState state "热力状态记录";
        annotation();
      algorithm
        state := setState_dTX(
          d, 
          T, 
          fill(0, 0), 
          phase);
      end setState_dT;

      replaceable function setState_px 
        "根据p和x计算热力状态"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input MassFraction x "蒸汽质量分数";
        output ThermodynamicState state "热力状态记录";
        annotation();
      algorithm
        state := setState_ph(
          p, 
          (1 - x) * bubbleEnthalpy(setSat_p(p)) + x * dewEnthalpy(setSat_p(p)), 
          2);
      end setState_px;

      replaceable function setState_Tx 
        "根据T和x算热力状态"
        extends Modelica.Icons.Function;
        input Temperature T "温度";
        input MassFraction x "蒸汽质量分数";
        output ThermodynamicState state "热力状态记录";
        annotation();
      algorithm
        state := setState_ph(
          saturationPressure_sat(setSat_T(T)), 
          (1 - x) * bubbleEnthalpy(setSat_T(T)) + x * dewEnthalpy(setSat_T(T)), 
          2);
      end setState_Tx;

      replaceable function vapourQuality "计算蒸汽质量分数"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "热力状态记录";
        output MassFraction x "蒸汽质量分数";
      protected
        constant SpecificEnthalpy eps = 1e-8;
        annotation();
      algorithm
        x := min(max((specificEnthalpy(state) - bubbleEnthalpy(setSat_p(pressure(
          state)))) / (dewEnthalpy(setSat_p(pressure(state))) - bubbleEnthalpy(
          setSat_p(pressure(state))) + eps), 0), 1);
      end vapourQuality;

      redeclare replaceable function density_ph "根据p和h计算密度"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input SpecificEnthalpy h "比焓";
        input FixedPhase phase = 0 
          "2-两相,1-单相,0-未知";
        output Density d "密度";
        annotation();
      algorithm
        d := density_phX(
          p, 
          h, 
          fill(0, 0), 
          phase);
      end density_ph;

      redeclare replaceable function temperature_ph 
        "根据p和h计算温度"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input SpecificEnthalpy h "比焓";
        input FixedPhase phase = 0 
          "2-两相,1-单相,0-未知";
        output Temperature T "温度";
        annotation();
      algorithm
        T := temperature_phX(
          p, 
          h, 
          fill(0, 0), 
          phase);
      end temperature_ph;

      redeclare replaceable function pressure_dT "根据d和T计算压力"
        extends Modelica.Icons.Function;
        input Density d "密度";
        input Temperature T "温度";
        input FixedPhase phase = 0 
          "2-两相,1-单相,0-未知";
        output AbsolutePressure p "压力";
        annotation();
      algorithm
        p := pressure(setState_dTX(
          d, 
          T, 
          fill(0, 0), 
          phase));
      end pressure_dT;

      redeclare replaceable function specificEnthalpy_dT 
        "根据d和T计算比焓"
        extends Modelica.Icons.Function;
        input Density d "密度";
        input Temperature T "温度";
        input FixedPhase phase = 0 
          "2-两相,1-单相,0-未知";
        output SpecificEnthalpy h "比焓";
        annotation();
      algorithm
        h := specificEnthalpy(setState_dTX(
          d, 
          T, 
          fill(0, 0), 
          phase));
      end specificEnthalpy_dT;

      redeclare replaceable function specificEnthalpy_ps 
        "根据p和s计算比焓"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input SpecificEntropy s "比熵";
        input FixedPhase phase = 0 
          "2-两相,1-单相,0-未知";
        output SpecificEnthalpy h "比焓";
        annotation();
      algorithm
        h := specificEnthalpy_psX(
          p, 
          s, 
          fill(0, 0));
      end specificEnthalpy_ps;

      redeclare replaceable function temperature_ps 
        "根据p和s计算温度"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input SpecificEntropy s "比熵";
        input FixedPhase phase = 0 
          "2-两相,1-单相,0-未知";
        output Temperature T "温度";
        annotation();
      algorithm
        T := temperature_psX(
          p, 
          s, 
          fill(0, 0), 
          phase);
      end temperature_ps;

      redeclare replaceable function density_ps 
        "根据p和s计算密度"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input SpecificEntropy s "比熵";
        input FixedPhase phase = 0 
          "2-两相,1-单相,0-未知";
        output Density d "密度";
        annotation();
      algorithm
        d := density_psX(
          p, 
          s, 
          fill(0, 0), 
          phase);
      end density_ps;

      redeclare replaceable function specificEnthalpy_pT 
        "根据p和T计算比焓"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input Temperature T "温度";
        input FixedPhase phase = 0 
          "2-两相,1-单相,0-未知";
        output SpecificEnthalpy h "比焓";
        annotation();
      algorithm
        h := specificEnthalpy_pTX(
          p, 
          T, 
          fill(0, 0), 
          phase);
      end specificEnthalpy_pT;

      redeclare replaceable function density_pT 
        "根据p和T计算密度"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input Temperature T "温度";
        input FixedPhase phase = 0 
          "2-两相,1-单相,0-未知";
        output Density d "密度";
        annotation();
      algorithm
        d := density(setState_pTX(
          p, 
          T, 
          fill(0, 0), 
          phase));
      end density_pT;
      annotation();
    end PartialTwoPhaseMedium;

    partial package PartialSimpleMedium 
      "u和h与温度线性关系,所有其他量都是常量(尤其是密度)的介质模型基类"

      extends Interfaces.PartialPureSubstance(final ThermoStates = Modelica.Media.Interfaces.Choices.IndependentVariables.pT, 
        final singleState = true);

      constant SpecificHeatCapacity cp_const 
        "恒压比热容常数";
      constant SpecificHeatCapacity cv_const 
        "恒容比热容常数";
      constant Density d_const "恒定密度";
      constant DynamicViscosity eta_const "恒定动力黏度";
      constant ThermalConductivity lambda_const "恒定导热系数";
      constant VelocityOfSound a_const "恒定声速";
      constant Temperature T_min "介质模型的最低温度";
      constant Temperature T_max "介质模型的最高温度";
      constant Temperature T0 = reference_T "零焓温度";
      constant MolarMass MM_const "摩尔质量";

      constant FluidConstants[nS] fluidConstants "流体常数";

      redeclare record extends ThermodynamicState "热力学状态"
        AbsolutePressure p "介质的绝对压力";
        Temperature T "介质的温度";
        annotation();
      end ThermodynamicState;

      redeclare replaceable model extends BaseProperties(T(stateSelect = if 
        preferredMediumStates then StateSelect.prefer else StateSelect.default), 
        p(stateSelect = if preferredMediumStates then StateSelect.prefer else 
        StateSelect.default)) "基本性质"
      equation
        assert(T >= T_min and T <= T_max, "
温度 T (= " + String(T) + " K) 不在允许范围内 (" + String(T_min) + " K <= T <= " + String(T_max) + " K)
介质模型 \"" + mediumName + "\" 要求。
");

        // h = cp_const*(T-T0);
        h = specificEnthalpy_pTX(
          p, 
          T, 
          X);
        u = cv_const * (T - T0);
        d = d_const;
        R_s = 0;
        MM = MM_const;
        state.T = T;
        state.p = p;
        annotation(Documentation(info = "<html>
<p>
这是最简单的不可压缩介质模型，其中比焓 h 和比内能 u 只是温度 T 的函数，
其他提供的介质量都假设为常量。
注意，压力项 p/d 的（小）影响被忽略。
</p>
</html>"));
      end BaseProperties;

      redeclare function setState_pTX 
        "根据 p、T 和 X 或 Xi 计算热力状态"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input Temperature T "温度";
        input MassFraction X[:] = reference_X "质量分数";
        output ThermodynamicState state "热力学状态记录";
        annotation();
      algorithm
        state := ThermodynamicState(p = p, T = T);
      end setState_pTX;

      redeclare function setState_phX 
        "根据 p、h 和 X 或 Xi 计算热力状态"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input SpecificEnthalpy h "比焓";
        input MassFraction X[:] = reference_X "质量分数";
        output ThermodynamicState state "热力学状态记录";
        annotation();
      algorithm
        state := ThermodynamicState(p = p, T = T0 + h / cp_const);
      end setState_phX;

      redeclare replaceable function setState_psX 
        "根据 p、s 和 X 或 Xi 计算热力状态"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input SpecificEntropy s "比熵";
        input MassFraction X[:] = reference_X "质量分数";
        output ThermodynamicState state "热力学状态记录";
        annotation();
      algorithm
        state := ThermodynamicState(p = p, T = Modelica.Math.exp(s / cp_const + 
          Modelica.Math.log(reference_T))) 
          "这里使用了不可压缩极限，具有 cp 作为热容";
      end setState_psX;

      redeclare function setState_dTX 
        "根据 d、T 和 X 或 Xi 计算热力状态"
        extends Modelica.Icons.Function;
        input Density d "密度";
        input Temperature T "温度";
        input MassFraction X[:] = reference_X "质量分数";
        output ThermodynamicState state "热力学状态记录";
        annotation();
      algorithm
        assert(false, 
          "无法根据温度和密度计算压力，因为对于不可压缩流体，这样的计算是不可能的！");
      end setState_dTX;

      redeclare function extends setSmoothState 
        "计算热力学状态，以平滑地逼近：如果 x > 0 则 state_a，否则 state_b"
        annotation();
      algorithm
        state := ThermodynamicState(p = Media.Common.smoothStep(
          x, 
          state_a.p, 
          state_b.p, 
          x_small), T = Media.Common.smoothStep(
          x, 
          state_a.T, 
          state_b.T, 
          x_small));
      end setSmoothState;

      redeclare function extends dynamicViscosity "计算动力黏度"
        annotation();

      algorithm
        eta := eta_const;
      end dynamicViscosity;

      redeclare function extends thermalConductivity 
        "计算导热系数"
        annotation();

      algorithm
        lambda := lambda_const;
      end thermalConductivity;

      redeclare function extends pressure "计算压力"
        annotation();

      algorithm
        p := state.p;
      end pressure;

      redeclare function extends temperature "计算温度"
        annotation();

      algorithm
        T := state.T;
      end temperature;

      redeclare function extends density "计算密度"
        annotation();

      algorithm
        d := d_const;
      end density;

      redeclare function extends specificEnthalpy "计算比焓"
        annotation();

      algorithm
        h := cp_const * (state.T - T0);
      end specificEnthalpy;

      redeclare function extends specificHeatCapacityCp 
        "计算定压比热容"
        annotation();

      algorithm
        cp := cp_const;
      end specificHeatCapacityCp;

      redeclare function extends specificHeatCapacityCv 
        "计算定容比热容"
        annotation();

      algorithm
        cv := cv_const;
      end specificHeatCapacityCv;

      redeclare function extends isentropicExponent "计算等熵指数"
        annotation();

      algorithm
        gamma := cp_const / cv_const;
      end isentropicExponent;

      redeclare function extends velocityOfSound "计算声速"
        annotation();

      algorithm
        a := a_const;
      end velocityOfSound;

      redeclare function specificEnthalpy_pTX 
        "根据 p、T 和 X 或 Xi 计算比焓"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input Temperature T "温度";
        input MassFraction X[nX] "质量分数";
        output SpecificEnthalpy h "比焓";
      algorithm
        h := cp_const * (T - T0);
        annotation(Documentation(info = "<html>
<p>
这个函数计算流体的比焓，但忽略了压力项 p/d 的（小）影响。
</p>
</html>"));
      end specificEnthalpy_pTX;

      redeclare function temperature_phX 
        "根据 p、h 和 X 或 Xi 计算温度"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input SpecificEnthalpy h "比焓";
        input MassFraction X[nX] "质量分数";
        output Temperature T "温度";
        annotation();
      algorithm
        T := T0 + h / cp_const;
      end temperature_phX;

      redeclare function density_phX "根据 p、h 和 X 或 Xi 计算密度"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input SpecificEnthalpy h "比焓";
        input MassFraction X[nX] "质量分数";
        output Density d "密度";
        annotation();
      algorithm
        d := density(setState_phX(
          p, 
          h, 
          X));
      end density_phX;

      redeclare function extends specificInternalEnergy 
        "计算比内能"
        extends Modelica.Icons.Function;
      algorithm
        //  u := cv_const*(state.T - T0) - reference_p/d_const;
        u := cv_const * (state.T - T0);
        annotation(Documentation(info = "<html>
<p>
这个函数计算流体的比内能，但忽略了压力项 p/d 的（小）影响。
</p>
</html>"));
      end specificInternalEnergy;

      redeclare function extends specificEntropy "计算比熵"
        extends Modelica.Icons.Function;
        annotation();
      algorithm
        s := cv_const * Modelica.Math.log(state.T / T0);
      end specificEntropy;

      redeclare function extends specificGibbsEnergy 
        "计算比吉布斯能"
        extends Modelica.Icons.Function;
        annotation();
      algorithm
        g := specificEnthalpy(state) - state.T * specificEntropy(state);
      end specificGibbsEnergy;

      redeclare function extends specificHelmholtzEnergy 
        "计算比亥姆霍兹能"
        extends Modelica.Icons.Function;
        annotation();
      algorithm
        f := specificInternalEnergy(state) - state.T * specificEntropy(state);
      end specificHelmholtzEnergy;

      redeclare function extends isentropicEnthalpy "计算等熵焓"
        annotation();
      algorithm
        h_is := cp_const * (temperature(refState) - T0);
      end isentropicEnthalpy;

      redeclare function extends isobaricExpansionCoefficient 
        "计算等压膨胀系数"
        annotation();
      algorithm
        beta := 0.0;
      end isobaricExpansionCoefficient;

      redeclare function extends isothermalCompressibility 
        "计算等温压缩系数"
        annotation();
      algorithm
        kappa := 0;
      end isothermalCompressibility;

      redeclare function extends density_derp_T 
        "计算密度对压力的偏导数（在恒温下）"
        annotation();
      algorithm
        ddpT := 0;
      end density_derp_T;

      redeclare function extends density_derT_p 
        "计算密度对温度的偏导数（在恒压下）"
        annotation();
      algorithm
        ddTp := 0;
      end density_derT_p;

      redeclare function extends density_derX 
        "计算密度对质量分数的偏导数（在恒压恒温下）"
        annotation();
      algorithm
        dddX := fill(0, nX);
      end density_derX;

      redeclare function extends molarMass "计算介质的摩尔质量"
        annotation();
      algorithm
        MM := MM_const;
      end molarMass;
      annotation();
    end PartialSimpleMedium;

    partial package PartialSimpleIdealGasMedium 
      "定cp和cv的理想气体的介质模型(其他所有量如输运性质保持恒定)"

      extends Interfaces.PartialPureSubstance(
      redeclare replaceable record FluidConstants = 
        Modelica.Media.Interfaces.Types.Basic.FluidConstants, 
        ThermoStates = Modelica.Media.Interfaces.Choices.IndependentVariables.pT, 
        final singleState = false);

      constant SpecificHeatCapacity cp_const 
        "恒定的定压比热容";
      constant SpecificHeatCapacity cv_const = cp_const - R_gas 
        "恒定的定容比热容";
      constant SpecificHeatCapacity R_gas "介质的比气体常数";
      constant MolarMass MM_const "摩尔质量";
      constant DynamicViscosity eta_const "恒定的动力黏度";
      constant ThermalConductivity lambda_const "恒定的导热系数";
      constant Temperature T_min "介质模型有效的最低温度";
      constant Temperature T_max "介质模型有效的最高温度";
      constant Temperature T0 = reference_T "零焓温度";
      constant FluidConstants[nS] fluidConstants "流体常数";

      redeclare record extends ThermodynamicState 
        "理想气体的热力学状态"
        AbsolutePressure p "介质的绝对压力";
        Temperature T "介质的温度";
        annotation();
      end ThermodynamicState;

      redeclare replaceable model extends BaseProperties(T(stateSelect = if 
        preferredMediumStates then StateSelect.prefer else StateSelect.default), 
        p(stateSelect = if preferredMediumStates then StateSelect.prefer else 
        StateSelect.default)) "理想气体的基本属性"
      equation
        assert(T >= T_min and T <= T_max, "
温度 T (= " + String(T) + " K) 不在允许范围内 (" + String(T_min) + " K <= T <= " + String(T_max) + " K)
这是由介质模型 \"" + mediumName + "\" 所要求的。
");
        h = specificEnthalpy_pTX(
          p, 
          T, 
          X);
        u = h - R_s * T;
        R_s = R_gas;
        d = p / (R_s * T);
        MM = MM_const;
        state.T = T;
        state.p = p;
        annotation(Documentation(info = "<html><p>
这是最简单的不可压缩介质模型，其中比焓 h 和比内能 u 仅为温度 T 的函数，所有其他提供的介质量假设为恒定。
</p>
</html>"));
      end BaseProperties;

      redeclare function setState_pTX 
        "根据 p、T 和 X 或 Xi 计算热力学状态"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input Temperature T "温度";
        input MassFraction X[:] = reference_X "质量分数";
        output ThermodynamicState state "热力学状态记录";
        annotation();
      algorithm
        state := ThermodynamicState(p = p, T = T);
      end setState_pTX;

      redeclare function setState_phX 
        "根据 p、h 和 X 或 Xi 计算热力学状态"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input SpecificEnthalpy h "比焓";
        input MassFraction X[:] = reference_X "质量分数";
        output ThermodynamicState state "热力学状态记录";
        annotation();
      algorithm
        state := ThermodynamicState(p = p, T = T0 + h / cp_const);
      end setState_phX;

      redeclare replaceable function setState_psX 
        "根据 p、s 和 X 或 Xi 计算热力学状态"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input SpecificEntropy s "比熵";
        input MassFraction X[:] = reference_X "质量分数";
        output ThermodynamicState state "热力学状态记录";
        annotation();
      algorithm
        state := ThermodynamicState(p = p, T = Modelica.Math.exp(s / cp_const + 
          Modelica.Math.log(reference_T) + R_gas * Modelica.Math.log(p / reference_p)));
      end setState_psX;

      redeclare function setState_dTX 
        "根据 d、T 和 X 或 Xi 计算热力学状态"
        extends Modelica.Icons.Function;
        input Density d "密度";
        input Temperature T "温度";
        input MassFraction X[:] = reference_X "质量分数";
        output ThermodynamicState state "热力学状态记录";
        annotation();
      algorithm
        state := ThermodynamicState(p = d * R_gas * T, T = T);
      end setState_dTX;

      redeclare function extends setSmoothState 
        "计算光滑逼近热力学状态: 如果 x > 0 则为 state_a 否则为 state_b"
        annotation();
      algorithm
        state := ThermodynamicState(p = Media.Common.smoothStep(
          x, 
          state_a.p, 
          state_b.p, 
          x_small), T = Media.Common.smoothStep(
          x, 
          state_a.T, 
          state_b.T, 
          x_small));
      end setSmoothState;

      redeclare function extends pressure "计算理想气体的压力"
        annotation();

      algorithm
        p := state.p;
      end pressure;

      redeclare function extends temperature "计算理想气体的温度"
        annotation();

      algorithm
        T := state.T;
      end temperature;

      redeclare function extends density "计算理想气体的密度"
        annotation();
      algorithm
        d := state.p / (R_gas * state.T);
      end density;

      redeclare function extends specificEnthalpy "计算比焓"
        extends Modelica.Icons.Function;
        annotation();
      algorithm
        h := cp_const * (state.T - T0);
      end specificEnthalpy;

      redeclare function extends specificInternalEnergy 
        "计算比内能"
        extends Modelica.Icons.Function;
        annotation();
      algorithm
        u := cp_const * (state.T - T0) - R_gas * state.T;
      end specificInternalEnergy;

      redeclare function extends specificEntropy "计算比熵"
        extends Modelica.Icons.Function;
        annotation();
      algorithm
        s := cp_const * Modelica.Math.log(state.T / T0) - R_gas * Modelica.Math.log(
          state.p / reference_p);
      end specificEntropy;

      redeclare function extends specificGibbsEnergy 
        "计算比吉布斯能"
        extends Modelica.Icons.Function;
        annotation();
      algorithm
        g := cp_const * (state.T - T0) - state.T * specificEntropy(state);
      end specificGibbsEnergy;

      redeclare function extends specificHelmholtzEnergy 
        "计算比亥姆霍兹能"
        extends Modelica.Icons.Function;
        annotation();
      algorithm
        f := specificInternalEnergy(state) - state.T * specificEntropy(state);
      end specificHelmholtzEnergy;

      redeclare function extends dynamicViscosity "计算动力黏度"
        annotation();

      algorithm
        eta := eta_const;
      end dynamicViscosity;

      redeclare function extends thermalConductivity 
        "计算导热系数"
        annotation();

      algorithm
        lambda := lambda_const;
      end thermalConductivity;

      redeclare function extends specificHeatCapacityCp 
        "计算定压比热容"
        annotation();

      algorithm
        cp := cp_const;
      end specificHeatCapacityCp;

      redeclare function extends specificHeatCapacityCv 
        "计算定容比热容"
        annotation();

      algorithm
        cv := cv_const;
      end specificHeatCapacityCv;

      redeclare function extends isentropicExponent "计算等熵指数"
        annotation();

      algorithm
        gamma := cp_const / cv_const;
      end isentropicExponent;

      redeclare function extends velocityOfSound "计算声速"
        annotation();

      algorithm
        a := sqrt(cp_const / cv_const * R_gas * state.T);
      end velocityOfSound;

      redeclare function specificEnthalpy_pTX 
        "根据 p、T 和 X 或 Xi 计算比焓"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input Temperature T "温度";
        input MassFraction X[:] "质量分数";
        output SpecificEnthalpy h "在 p、T、X 下的比焓";
        annotation();
      algorithm
        h := cp_const * (T - T0);
      end specificEnthalpy_pTX;

      redeclare function temperature_phX 
        "根据 p、h 和 X 或 Xi 计算温度"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input SpecificEnthalpy h "比焓";
        input MassFraction X[:] "质量分数";
        output Temperature T "温度";
        annotation();
      algorithm
        T := h / cp_const + T0;
      end temperature_phX;

      redeclare function density_phX "根据 p、h 和 X 或 Xi 计算密度"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "压力";
        input SpecificEnthalpy h "比焓";
        input MassFraction X[:] "质量分数";
        output Density d "密度";
        annotation();
      algorithm
        d := density(setState_phX(
          p, 
          h, 
          X));
      end density_phX;

      redeclare function extends isentropicEnthalpy "计算等熵焓"
        annotation();
      algorithm
        /* s = cp_const*log(refState.T/T0) - R_gas*log(refState.p/reference_p)
        = cp_const*log(state.T/T0) - R_gas*log(p_downstream/reference_p)
        
        log(state.T) = log(refState.T) +
        (R_gas/cp_const)*(log(p_downstream/reference_p) - log(refState.p/reference_p))
        = log(refState.T) + (R_gas/cp_const)*log(p_downstream/refState.p)
        = log(refState.T) + log( (p_downstream/refState.p)^(R_gas/cp_const) )
        state.T = refstate.T*(p_downstream/refstate.p)^(R_gas/cp_const)
        */
        h_is := cp_const * (refState.T * (p_downstream / refState.p) ^ (R_gas / cp_const) 
          - T0);
      end isentropicEnthalpy;

      redeclare function extends isobaricExpansionCoefficient 
        "计算等压膨胀系数"
        annotation();
      algorithm
        /* beta = 1/v * der(v,T), with v = 1/d, at constant pressure p:
        v = R_s*T/p
        der(v,T) = R_s/p
        beta = p/(R_s*T)*R_s/p
        = 1/T
        */

        beta := 1 / state.T;
      end isobaricExpansionCoefficient;

      redeclare function extends isothermalCompressibility 
        "计算等温压缩系数"
        annotation();
      algorithm
        /* kappa = - 1/v * der(v,p), with v = 1/d at constant temperature T.
        v = R_s*T/p
        der(v,T) = -R_s*T/p^2
        kappa = p/(R_s*T)*R_s*T/p^2
        = 1/p
        */
        kappa := 1 / state.p;
      end isothermalCompressibility;

      redeclare function extends density_derp_T 
        "计算密度对压力的偏导数 (保持温度不变)"
        annotation();
      algorithm
        /*  d = p/(R_s*T)
        ddpT = 1/(R_s*T)
        */
        ddpT := 1 / (R_gas * state.T);
      end density_derp_T;

      redeclare function extends density_derT_p 
        "计算密度对温度的偏导数 (保持压力不变)"
        annotation();
      algorithm
        /*  d = p/(R_s*T)
        ddpT = -p/(R_s*T^2)
        */
        ddTp := -state.p / (R_gas * state.T * state.T);
      end density_derT_p;

      redeclare function extends density_derX 
        "计算密度对质量分数的偏导数 (保持压力和温度不变)"
        annotation();
      algorithm
        dddX := fill(0, nX);
      end density_derX;

      redeclare function extends molarMass "计算介质的摩尔质量"
        annotation();
      algorithm
        MM := MM_const;
      end molarMass;
      annotation();
    end PartialSimpleIdealGasMedium;

    package Choices "用于定义菜单选择的类型和常量"
      extends Modelica.Icons.Package;

      type IndependentVariables = enumeration(
        T "温度", 
        pT "压力, 温度", 
        ph "压力, 比焓", 
        phX "压力, 比焓, 质量分数", 
        pTX "压力, 温度, 质量分数", 
        dTX "密度, 温度, 质量分数") 
        "定义介质独立变量的枚举" annotation();

      type Init = enumeration(
        NoInit "无初始化", 
        InitialStates "初始化介质状态", 
        SteadyState "初始化为稳态", 
        SteadyMass 
        "初始化密度或压力为稳态") 
        "定义流体流动初始化的枚举" annotation(Evaluate = 
        true);

      type ReferenceEnthalpy = enumeration(
        ZeroAt0K 
        "焓在 0K 时为 0 (默认), 如果不包括生成焓", 
        ZeroAt25C 
        "焓在 25 摄氏度时为 0, 如果不包括生成焓", 
        UserDefined 
        "用户定义的参考焓在 293.15 K (25 摄氏度)时使用") 
        "定义介质参考焓的枚举" annotation(
        Evaluate = true);

      type ReferenceEntropy = enumeration(
        ZeroAt0K "熵在 0K 时为 0 (默认)", 
        ZeroAt0C "熵在 0 摄氏度时为 0", 
        UserDefined 
        "用户定义的参考熵在293.15 K (25 摄氏度)时使用") 
        "定义介质参考熵的枚举" annotation(
        Evaluate = true);

      type pd = enumeration(
        default "默认 (没有 p 或 d 的边界条件)", 
        p_known "p_known (已知压力 p)", 
        d_known "d_known (已知密度 d)") 
        "定义边界条件中是否已知 p 或 d 的枚举" 
        annotation(Evaluate = true);

      type Th = enumeration(
        default "默认 (没有 T 或 h 的边界条件)", 
        T_known "T_known (已知温度 T)", 
        h_known "h_known (已知比焓 h)") 
        "定义边界条件中是否已知 T 或 h 的枚举" 
        annotation(Evaluate = true);

      annotation(Documentation(info = "<html><p>
用于所有类型流体的枚举和数据类型
</p>
<p>
注意: 参考焓可能需要用生成焓扩展。
</p>
</html>"));
    end Choices;

    package Types "用于流体模型的类型"
      extends Modelica.Icons.Package;

      type AbsolutePressure = SI.AbsolutePressure(
        min = 0, 
        max = 1.e8, 
        nominal = 1.e5, 
        start = 1.e5) 
        "具有介质特定属性的绝对压力类型" annotation();

      type Density = SI.Density(
        min = 0, 
        max = 1.e5, 
        nominal = 1, 
        start = 1) 
        "具有介质特定属性的密度类型" annotation();

      type DynamicViscosity = SI.DynamicViscosity(
        min = 0, 
        max = 1.e8, 
        nominal = 1.e-3, 
        start = 1.e-3) 
        "具有介质特定属性的动力黏度类型" annotation();

      type EnthalpyFlowRate = SI.EnthalpyFlowRate(
        nominal = 1000.0, 
        min = -1.0e8, 
        max = 1.e8) 
        "具有介质特定属性的焓流类型" annotation();

      type MassFraction = Real(
        quantity = "MassFraction", 
        final unit = "kg/kg", 
        min = 0, 
        max = 1, 
        nominal = 0.1) 
        "具有介质特定属性的质量分数类型" annotation();

      type MoleFraction = Real(
        quantity = "MoleFraction", 
        final unit = "mol/mol", 
        min = 0, 
        max = 1, 
        nominal = 0.1) 
        "具有介质特定属性的摩尔分数类型" annotation();

      type MolarMass = SI.MolarMass(
        min = 0.001, 
        max = 0.25, 
        nominal = 0.032) 
        "具有介质特定属性的摩尔质量类型" annotation();

      type MolarVolume = SI.MolarVolume(
        min = 1e-6, 
        max = 1.0e6, 
        nominal = 1.0) 
        "具有介质特定属性的摩尔体积类型" annotation();

      type IsentropicExponent = SI.RatioOfSpecificHeatCapacities(
        min = 1, 
        max = 500000, 
        nominal = 1.2, 
        start = 1.2) 
        "具有介质特定属性的等熵指数类型" annotation();

      type SpecificEnergy = SI.SpecificEnergy(
        min = -1.0e8, 
        max = 1.e8, 
        nominal = 1.e6) 
        "具有介质特定属性的比能类型" annotation();

      type SpecificInternalEnergy = SpecificEnergy 
        "具有介质特定属性的比内能类型" annotation();

      type SpecificEnthalpy = SI.SpecificEnthalpy(
        min = -1.0e10, 
        max = 1.e10, 
        nominal = 1.e6) 
        "具有介质特定属性的比焓类型" annotation();

      type SpecificEntropy = SI.SpecificEntropy(
        min = -1.e7, 
        max = 1.e7, 
        nominal = 1.e3) 
        "具有介质特定属性的比熵类型" annotation();

      type SpecificHeatCapacity = SI.SpecificHeatCapacity(
        min = 0, 
        max = 1.e7, 
        nominal = 1.e3, 
        start = 1.e3) 
        "具有介质特定属性的比热容类型" annotation();

      type SurfaceTension = SI.SurfaceTension 
        "具有介质特定属性的表面张力类型" annotation();

      type Temperature = SI.Temperature(
        min = 1, 
        max = 1.e4, 
        nominal = 300, 
        start = 288.15) 
        "具有介质特定属性的温度类型" annotation();

      type ThermalConductivity = SI.ThermalConductivity(
        min = 0, 
        max = 500, 
        nominal = 1, 
        start = 1) 
        "具有介质特定属性的导热系数类型" annotation();

      type PrandtlNumber = SI.PrandtlNumber(
        min = 1e-3, 
        max = 1e5, 
        nominal = 1.0) 
        "具有介质特定属性的普朗特数类型" annotation();

      type VelocityOfSound = SI.Velocity(
        min = 0, 
        max = 1.e5, 
        nominal = 1000, 
        start = 1000) 
        "具有介质特定属性的声速类型" annotation();

      type ExtraProperty = Real(min = 0.0, start = 1.0) 
        "流动中输运的质量特性，未指定类型" annotation();

      type CumulativeExtraProperty = Real(min = 0.0, start = 1.0) 
        "未指定的守恒积分类型，质量特性" annotation();

      type ExtraPropertyFlowRate = Real(unit = "kg/s") 
        "未指定的流量类型，质量特性" annotation();

      type IsobaricExpansionCoefficient = Real(
        min = 0, 
        max = 1.0e8, 
        unit = "1/K") 
        "具有介质特定属性的等压膨胀系数类型" annotation();

      type DipoleMoment = Real(
        min = 0.0, 
        max = 2.0, 
        unit = "debye", 
        quantity = "ElectricDipoleMoment") 
        "具有介质特定属性的偶极矩类型" annotation();

      type DerDensityByPressure = SI.DerDensityByPressure 
        "具有介质特定属性的密度对压力的偏导数类型" annotation();

      type DerDensityByEnthalpy = SI.DerDensityByEnthalpy 
        "具有介质特定属性的密度对焓的偏导数类型" annotation();

      type DerEnthalpyByPressure = SI.DerEnthalpyByPressure 
        "具有介质特定属性的焓对压力的偏导数类型" annotation();

      type DerDensityByTemperature = SI.DerDensityByTemperature 
        "具有介质特定属性的密度对温度的偏导数类型" annotation();

      type DerTemperatureByPressure = Real(final unit = "K/Pa") 
        "具有介质特定属性的温度对压力的偏导数类型" annotation();

      replaceable record SaturationProperties 
        "两相介质的饱和特性"
        extends Modelica.Icons.Record;
        AbsolutePressure psat "饱和压力";
        Temperature Tsat "饱和温度";
        annotation();
      end SaturationProperties;

      record FluidLimits "流体模型的有效性限制"
        extends Modelica.Icons.Record;
        Temperature TMIN "最低温度";
        Temperature TMAX "最高温度";
        Density DMIN "最低密度";
        Density DMAX "最高密度";
        AbsolutePressure PMIN "最低压力";
        AbsolutePressure PMAX "最高压力";
        SpecificEnthalpy HMIN "最低焓";
        SpecificEnthalpy HMAX "最高焓";
        SpecificEntropy SMIN "最低熵";
        SpecificEntropy SMAX "最高熵";
        annotation(Documentation(info = "<html><p>
最小压力通常仅适用于液态，最小密度为经验设定（用于限制非线性系统迭代次数），焓/熵限值为逆向迭代安全防护机制。
</p>
</html>"));
      end FluidLimits;

      type FixedPhase = Integer(min = 0, max = 2) 
        "流体相态：1 为单相，2 为两相，0 为未知，例如交互使用" annotation();

      package Basic 
        "用于多种详细程度的记录的最基础版本"
        extends Icons.Package;

        record FluidConstants 
          "流体的临界、三相、分子和其他标准数据"
          extends Modelica.Icons.Record;
          String iupacName 
            "完整的 IUPAC 名称（如果不存在，则使用常用名称）";
          String casRegistryNumber 
            "化学序列号（如果存在）";
          String chemicalFormula 
            "化学式（按照 Hill 命名法）";
          String structureFormula "化学结构式";
          MolarMass molarMass "摩尔质量";
          annotation();
        end FluidConstants;
        annotation();

      end Basic;

      package IdealGas 
        "用于多种详细程度的理想气体记录表"
        extends Icons.Package;

        record FluidConstants "扩展流体常数"
          extends Modelica.Media.Interfaces.Types.Basic.FluidConstants;
          Temperature criticalTemperature "临界温度";
          AbsolutePressure criticalPressure "临界压力";
          MolarVolume criticalMolarVolume "临界摩尔体积";
          Real acentricFactor "Pitzer 偏心系数";
          //   Temperature triplePointTemperature "三相点温度";
          //   AbsolutePressure triplePointPressure "三相点压力";
          Temperature meltingPoint "在 101325 Pa 时的熔点";
          Temperature normalBoilingPoint "额定沸点（在 101325 Pa 时）";
          DipoleMoment dipoleMoment 
            "分子的偶极矩，单位为 debye(1 debye = 3.33564e10-30 C.m)";
          Boolean hasIdealGasHeatCapacity = false 
            "如果理想气体的比热容可用，则为 true";
          Boolean hasCriticalData = false 
            "如果已知临界数据，则为 true";
          Boolean hasDipoleMoment = false 
            "如果已知偶极矩，则为 true";
          Boolean hasFundamentalEquation = false 
            "如果有基本方程，则为 true";
          Boolean hasLiquidHeatCapacity = false 
            "如果液体的比热容可用，则为 true";
          Boolean hasSolidHeatCapacity = false 
            "如果固体的比热容可用，则为 true";
          Boolean hasAccurateViscosityData = false 
            "如果黏度函数的准确数据可用，则为 true";
          Boolean hasAccurateConductivityData = false 
            "如果导热系数的准确数据可用，则为 true";
          Boolean hasVapourPressureCurve = false 
            "如果已知蒸汽压力数据，例如 Antoine 系数，则为 true";
          Boolean hasAcentricFactor = false 
            "如果已知 Pitzer 偏心系数，则为 true";
          SpecificEnthalpy HCRIT0 = 0.0 
            "基本方程的临界比焓";
          SpecificEntropy SCRIT0 = 0.0 
            "基本方程的临界比熵";
          SpecificEnthalpy deltah = 0.0 
            "比焓模型 (h_m) 和基本方程 (h_f) 之间的差异 (h_m - h_f)";
          SpecificEntropy deltas = 0.0 
            "比熵模型 (s_m) 和基本方程 (s_f) 之间的差异 (s_m - s_f)";
          annotation();
        end FluidConstants;
        annotation();
      end IdealGas;

      package TwoPhase 
        "用于多种详细程度的两相流体记录表"
        extends Icons.Package;

        record FluidConstants "扩展流体常数"
          extends Modelica.Media.Interfaces.Types.Basic.FluidConstants;
          Temperature criticalTemperature "临界温度";
          AbsolutePressure criticalPressure "临界压力";
          MolarVolume criticalMolarVolume "临界摩尔体积";
          Real acentricFactor "Pitzer 偏心系数";
          Temperature triplePointTemperature "三相点温度";
          AbsolutePressure triplePointPressure "三相点压力";
          Temperature meltingPoint "在 101325 Pa 时的熔点";
          Temperature normalBoilingPoint "正常沸点（在 101325 Pa 时）";
          DipoleMoment dipoleMoment 
            "分子的偶极矩，单位为 debye（1 debye = 3.33564e10-30 C.m）";
          Boolean hasIdealGasHeatCapacity = false 
            "如果理想气体的比热容可用，则为 true";
          Boolean hasCriticalData = false 
            "如果已知临界数据，则为 true";
          Boolean hasDipoleMoment = false 
            "如果已知偶极矩，则为 true";
          Boolean hasFundamentalEquation = false 
            "如果有基本方程，则为 true";
          Boolean hasLiquidHeatCapacity = false 
            "如果液体的比热容可用，则为 true";
          Boolean hasSolidHeatCapacity = false 
            "如果固体的比热容可用，则为 true";
          Boolean hasAccurateViscosityData = false 
            "如果黏度函数的准确数据可用，则为 true";
          Boolean hasAccurateConductivityData = false 
            "如果导热系数的准确数据可用，则为 true";
          Boolean hasVapourPressureCurve = false 
            "如果已知蒸汽压力数据，例如 Antoine 系数，则为 true";
          Boolean hasAcentricFactor = false 
            "如果已知 Pitzer 偏心系数，则为 true";
          SpecificEnthalpy HCRIT0 = 0.0 
            "基本方程的临界比焓";
          SpecificEntropy SCRIT0 = 0.0 
            "基本方程的临界比熵";
          SpecificEnthalpy deltah = 0.0 
            "比焓模型 (h_m) 和基本方程 (h_f) 之间的差异 (h_m - h_f)";
          SpecificEntropy deltas = 0.0 
            "比熵模型 (s_m) 和基本方程 (s_f) 之间的差异 (s_m - s_f)";
          annotation();
        end FluidConstants;
        annotation();
      end TwoPhase;
      annotation();

    end Types;
    annotation(Documentation(info = "<html>
<p>
这个库提供了不同类型介质的基本接口定义。
</p>
</html>"));
  end Interfaces;

  package Common "流体性质的数据结构和基本函数"
    extends Modelica.Icons.Package;

    type Rate = Real(final quantity = "Rate", final unit = "s-1") annotation();
    type MolarFlowRate = Real(final quantity = "MolarFlowRate", final unit = "mol/s") annotation();
    type MolarReactionRate = Real(final quantity = "MolarReactionRate", final unit = 
      "mol/(m3.s)") annotation();
    type MolarEnthalpy = Real(final quantity = "MolarEnthalpy", final unit = "J/mol") annotation();
    type DerDensityByEntropy = Real(final quantity = "DerDensityByEntropy", final
      unit = "kg2.K/(m3.J)") annotation();
    type DerEnergyByPressure = Real(final quantity = "DerEnergyByPressure", final
      unit = "J/Pa") annotation();
    type DerEnergyByMoles = Real(final quantity = "DerEnergyByMoles", final unit = 
      "J/mol") annotation();
    type DerEntropyByTemperature = Real(final quantity = "DerEntropyByTemperature", 
      final unit = "J/K2") annotation();
    type DerEntropyByPressure = Real(final quantity = "DerEntropyByPressure", 
      final unit = "J/(K.Pa)") annotation();
    type DerEntropyByMoles = Real(final quantity = "DerEntropyByMoles", final unit = 
      "J/(mol.K)") annotation();
    type DerPressureByDensity = Real(final quantity = "DerPressureByDensity", 
      final unit = "Pa.m3/kg") annotation();
    type DerPressureBySpecificVolume = Real(final quantity = 
      "DerPressureBySpecificVolume", final unit = "Pa.kg/m3") annotation();
    type DerPressureByTemperature = Real(final quantity = 
      "DerPressureByTemperature", final unit = "Pa/K") annotation();
    type DerVolumeByTemperature = Real(final quantity = "DerVolumeByTemperature", 
      final unit = "m3/K") annotation();
    type DerVolumeByPressure = Real(final quantity = "DerVolumeByPressure", final
      unit = "m3/Pa") annotation();
    type DerVolumeByMoles = Real(final quantity = "DerVolumeByMoles", final unit = 
      "m3/mol") annotation();
    type IsenthalpicExponent = Real(final quantity = "IsenthalpicExponent", unit = 
      "1") annotation();
    type IsentropicExponent = Real(final quantity = "IsentropicExponent", unit = "1") annotation();
    type IsobaricVolumeExpansionCoefficient = Real(final quantity = 
      "IsobaricVolumeExpansionCoefficient", unit = "1/K") annotation();
    type IsochoricPressureCoefficient = Real(final quantity = 
      "IsochoricPressureCoefficient", unit = "1/K") annotation();
    type IsothermalCompressibility = Real(final quantity = 
      "IsothermalCompressibility", unit = "1/Pa") annotation();
    type JouleThomsonCoefficient = Real(final quantity = "JouleThomsonCoefficient", 
      unit = "K/Pa") annotation();

    // 引入最小-最大-额定值
    constant Real MINPOS = 1.0e-9 
      "最小的物理变量值，总是 > 0.0";

    constant SI.Area AMIN = MINPOS "最小初始面积";
    constant SI.Area AMAX = 1.0e5 "最大初始面积";
    constant SI.Area ANOM = 1.0 "额定初始面积";
    constant SI.AmountOfSubstance MOLMIN = -1.0 * MINPOS "最小摩尔数";
    constant SI.AmountOfSubstance MOLMAX = 1.0e8 "最大摩尔数";
    constant SI.AmountOfSubstance MOLNOM = 1.0 "额定摩尔数";
    constant SI.Density DMIN = 1e-6 "最小初始密度";
    constant SI.Density DMAX = 30.0e3 "最大初始密度";
    constant SI.Density DNOM = 1.0 "额定初始密度";
    constant SI.ThermalConductivity LAMMIN = MINPOS "最小导热系数";
    constant SI.ThermalConductivity LAMNOM = 1.0 "额定导热系数";
    constant SI.ThermalConductivity LAMMAX = 1000.0 "最大导热系数";
    constant SI.DynamicViscosity ETAMIN = MINPOS "最小初始动力黏度";
    constant SI.DynamicViscosity ETAMAX = 1.0e8 "最大初始动力黏度";
    constant SI.DynamicViscosity ETANOM = 100.0 "额定初始动力黏度";
    constant SI.Energy EMIN = -1.0e10 "最小初始能量";
    constant SI.Energy EMAX = 1.0e10 "最大初始能量";
    constant SI.Energy ENOM = 1.0e3 "额定初始能量";
    constant SI.Entropy SMIN = -1.0e6 "最小初始熵";
    constant SI.Entropy SMAX = 1.0e6 "最大初始熵";
    constant SI.Entropy SNOM = 1.0e3 "额定初始熵";
    constant SI.MassFlowRate MDOTMIN = -1.0e5 "最小初始质量流量";
    constant SI.MassFlowRate MDOTMAX = 1.0e5 "最大初始质量流量";
    constant SI.MassFlowRate MDOTNOM = 1.0 "额定初始质量流量";
    constant SI.MassFraction MASSXMIN = -1.0 * MINPOS "最小初始质量分数";
    constant SI.MassFraction MASSXMAX = 1.0 "最大初始质量分数";
    constant SI.MassFraction MASSXNOM = 0.1 "额定初始质量分数";
    constant SI.Mass MMIN = -1.0 * MINPOS "最小初始质量";
    constant SI.Mass MMAX = 1.0e8 "最大初始质量";
    constant SI.Mass MNOM = 1.0 "额定初始质量";
    constant SI.MolarMass MMMIN = 0.001 "最小初始摩尔质量";
    constant SI.MolarMass MMMAX = 250.0 "最大初始摩尔质量";
    constant SI.MolarMass MMNOM = 0.2 "额定初始摩尔质量";
    constant SI.MoleFraction MOLEYMIN = -1.0 * MINPOS "最小初始摩尔分数";
    constant SI.MoleFraction MOLEYMAX = 1.0 "最大初始摩尔分数";
    constant SI.MoleFraction MOLEYNOM = 0.1 "额定初始摩尔分数";
    constant SI.MomentumFlux GMIN = -1.0e8 "最小初始动量通量";
    constant SI.MomentumFlux GMAX = 1.0e8 "最大初始动量通量";
    constant SI.MomentumFlux GNOM = 1.0 "额定初始动量通量";
    constant SI.Power POWMIN = -1.0e8 "最小初始功率或热量";
    constant SI.Power POWMAX = 1.0e8 "最大初始功率或热量";
    constant SI.Power POWNOM = 1.0e3 "额定初始功率或热量";
    constant SI.Pressure PMIN = 1.0e4 "最小初始压力";
    constant SI.Pressure PMAX = 1.0e8 "最大初始压力";
    constant SI.Pressure PNOM = 1.0e5 "额定初始压力";
    constant SI.Pressure COMPPMIN = -1.0 * MINPOS "最小初始压力";
    constant SI.Pressure COMPPMAX = 1.0e8 "最大初始压力";
    constant SI.Pressure COMPPNOM = 1.0e5 "额定初始压力";
    constant SI.RatioOfSpecificHeatCapacities KAPPAMIN = 1.0 
      "最小初始比热容指数";
    constant SI.RatioOfSpecificHeatCapacities KAPPAMAX = 1.7 
      "最大初始比热容指数";
    constant SI.RatioOfSpecificHeatCapacities KAPPANOM = 1.2 
      "额定初始比热容指数";
    constant SI.SpecificEnergy SEMIN = -1.0e8 "最小初始比能";
    constant SI.SpecificEnergy SEMAX = 1.0e8 "最大初始比能";
    constant SI.SpecificEnergy SENOM = 1.0e6 "额定初始比能";
    constant SI.SpecificEnthalpy SHMIN = -1.0e8 "最小初始比焓";
    constant SI.SpecificEnthalpy SHMAX = 1.0e8 "最大初始比焓";
    constant SI.SpecificEnthalpy SHNOM = 1.0e6 "额定初始比焓";
    constant SI.SpecificEntropy SSMIN = -1.0e6 "最小初始比熵";
    constant SI.SpecificEntropy SSMAX = 1.0e6 "最大初始比熵";
    constant SI.SpecificEntropy SSNOM = 1.0e3 "额定初始比熵";
    constant SI.SpecificHeatCapacity CPMIN = MINPOS 
      "最小初始比热容";
    constant SI.SpecificHeatCapacity CPMAX = 1.0e6 
      "最大初始比热容";
    constant SI.SpecificHeatCapacity CPNOM = 1.0e3 
      "额定初始比热容";
    constant SI.Temperature TMIN = 1.0 "最小初始温度";
    constant SI.Temperature TMAX = 6000.0 "最大初始温度";
    constant SI.Temperature TNOM = 320.0 "额定初始温度";
    constant SI.ThermalConductivity LMIN = MINPOS 
      "最小初始导热系数";
    constant SI.ThermalConductivity LMAX = 500.0 
      "最大初始导热系数";
    constant SI.ThermalConductivity LNOM = 1.0 "额定初始导热系数";
    constant SI.Velocity VELMIN = -1.0e5 "最小初始速度";
    constant SI.Velocity VELMAX = 1.0e5 "最大初始速度";
    constant SI.Velocity VELNOM = 1.0 "额定初始速度";
    constant SI.Volume VMIN = 0.0 "最小初始体积";
    constant SI.Volume VMAX = 1.0e5 "最大初始体积";
    constant SI.Volume VNOM = 1.0e-3 "额定初始体积";

    package ThermoFluidSpecial "ThermoFluid 库使用的性质记录表"
      extends Modelica.Icons.Package;

      record FixedIGProperties "理想气体的常量性质"
        extends Modelica.Icons.Record;
        parameter Integer nspecies(min = 1) "组分数量";
        SI.MolarMass[nspecies] MM "组分的摩尔质量";
        Real[nspecies] invMM "组分摩尔质量的倒数";
        SI.SpecificHeatCapacity[nspecies] R_s "气体常数";
        SI.SpecificEnthalpy[nspecies] Hf "在 298.15K 时的生成焓";
        SI.SpecificEnthalpy[nspecies] H0 "H0(298.15K) - H0(0K)";
        annotation();
      end FixedIGProperties;

      record ThermoBaseVars
        extends Modelica.Icons.Record;
        parameter Integer n(min = 1) "离散化数量";
        parameter Integer nspecies(min = 1) "组分数量";
        SI.Pressure[n] p(
          min = PMIN, 
          max = PMAX, 
          nominal = PNOM, 
          start = fill(1.0e5, n)) "压力";
        SI.Temperature[n] T(
          min = TMIN, 
          max = TMAX, 
          nominal = TNOM) "温度";
        SI.Density[n] d(
          min = DMIN, 
          max = DMAX, 
          nominal = DNOM) "密度";
        SI.SpecificEnthalpy[n] h(
          min = SHMIN, 
          max = SHMAX, 
          nominal = SHNOM) "比焓";
        SI.SpecificEntropy[n] s(
          min = SSMIN, 
          max = SSMAX, 
          nominal = SSNOM) "比熵";
        SI.RatioOfSpecificHeatCapacities[n] kappa "比热容比 cp/cv";
        SI.Mass[n] M(
          min = MMIN, 
          max = MMAX, 
          nominal = MNOM) "总质量";
        SI.Energy[n] U(
          min = EMIN, 
          max = EMAX, 
          nominal = ENOM) "内能";
        SI.MassFlowRate[n] dM(
          min = MDOTMIN, 
          max = MDOTMAX, 
          nominal = MDOTNOM) "总质量变化";
        SI.Power[n] dU(
          min = POWMIN, 
          max = POWMAX, 
          nominal = POWNOM) "内能变化";
        SI.Volume[n] V(
          min = VMIN, 
          max = VMAX, 
          nominal = VNOM) "体积";
        SI.MassFraction[n,nspecies] mass_x(
          min = MASSXMIN, 
          max = MASSXMAX, 
          nominal = MASSXNOM) "质量分数";
        SI.MoleFraction[n,nspecies] mole_y(
          min = MOLEYMIN, 
          max = MOLEYMAX, 
          nominal = MOLEYNOM) "摩尔分数";
        SI.Mass[n,nspecies] M_x(
          min = MMIN, 
          max = MMAX, 
          nominal = MNOM) "组分质量";
        SI.MassFlowRate[n,nspecies] dM_x(
          min = MDOTMIN, 
          max = MDOTMAX, 
          nominal = MDOTNOM) "组分质量变化率";
        MolarFlowRate[n,nspecies] dZ(
          min = -1.0e6, 
          max = 1.0e6, 
          nominal = 0.0) "组分摩尔变化率";
        MolarFlowRate[n,nspecies] rZ(
          min = -1.0e6, 
          max = 1.0e6, 
          nominal = 0.0) "反应（源）摩尔速率";
        SI.MolarMass[n] MM(
          min = MMMIN, 
          max = MMMAX, 
          nominal = MMNOM) "混合物的摩尔质量";
        SI.AmountOfSubstance[n] Moles(
          min = MOLMIN, 
          max = MOLMAX, 
          nominal = MOLNOM) "总摩尔数";
        SI.AmountOfSubstance[n,nspecies] Moles_z(
          min = MOLMIN, 
          max = MOLMAX, 
          nominal = MOLNOM) "摩尔向量";
        annotation(Documentation(info = "<html>
                         <h4>模型描述</h4>
                              <p>
                              <strong>ThermoBaseVars</strong> 被所有介质性质模型和定义质量和能量守恒的动态状态模型继承。因此，它是任何介质模型或动态状态模型的限制类的最佳选择。
                           </p>
                              </html>"));
      end ThermoBaseVars;

      record ThermoProperties 
        "所有状态模型的热力学基础属性数据"
        extends Modelica.Icons.Record;
        parameter Integer nspecies(min = 1) "组分数量";
        SI.Temperature T(
          min = TMIN, 
          max = TMAX, 
          nominal = TNOM) "温度";
        SI.Density d(
          min = DMIN, 
          max = DMAX, 
          nominal = DNOM) "密度";
        SI.Pressure p(
          min = PMIN, 
          max = PMAX, 
          nominal = PNOM) "压力";
        SI.Volume V(
          min = VMIN, 
          max = VMAX, 
          nominal = VNOM) "体积";
        SI.SpecificEnthalpy h(
          min = SHMIN, 
          max = SHMAX, 
          nominal = SHNOM) "比焓";
        SI.SpecificEnergy u(
          min = SEMIN, 
          max = SEMAX, 
          nominal = SENOM) "比内能";
        SI.SpecificEntropy s(
          min = SSMIN, 
          max = SSMAX, 
          nominal = SSNOM) "比熵";
        SI.SpecificGibbsFreeEnergy g(
          min = SHMIN, 
          max = SHMAX, 
          nominal = SHNOM) "比吉布斯自由能";
        SI.SpecificHeatCapacity cp(
          min = CPMIN, 
          max = CPMAX, 
          nominal = CPNOM) "定压比热容";
        SI.SpecificHeatCapacity cv(
          min = CPMIN, 
          max = CPMAX, 
          nominal = CPNOM) "定容比热容";
        SI.SpecificHeatCapacity R_s(
          min = CPMIN, 
          max = CPMAX, 
          nominal = CPNOM) "气体常数";
        SI.MolarMass MM(
          min = MMMIN, 
          max = MMMAX, 
          nominal = MMNOM) "混合物的摩尔质量";
        SI.MassFraction[nspecies] mass_x(
          min = MASSXMIN, 
          max = MASSXMAX, 
          nominal = MASSXNOM) "质量分数";
        SI.MoleFraction[nspecies] mole_y(
          min = MOLEYMIN, 
          max = MOLEYMAX, 
          nominal = MOLEYNOM) "摩尔分数";
        SI.RatioOfSpecificHeatCapacities kappa "比热容比（cp/cv）";
        SI.DerDensityByTemperature ddTp 
          "在恒压下密度对温度的导数";
        SI.DerDensityByPressure ddpT 
          "在恒温下密度对压力的导数";
        Real dupT(unit = "m3.kg-1") 
          "在恒温下内能对压力的导数";
        Real dudT(unit = "(J.m3)/(kg2)") 
          "在恒温下内能对密度的导数";
        SI.SpecificHeatCapacity duTp 
          "在恒压下内能对温度的导数";
        SI.SpecificEnergy ddx[nspecies] 
          "密度对质量组成变化的导数向量";
        SI.SpecificEnergy[nspecies] compu(
          min = SEMIN, 
          max = SEMAX, 
          nominal = SENOM) "组分的内能";
        SI.Pressure[nspecies] compp(
          min = COMPPMIN, 
          max = COMPPMAX, 
          nominal = COMPPNOM) "组分的分压力";
        SI.Velocity a(
          min = VELMIN, 
          max = VELMAX, 
          nominal = VELNOM) "声速";
        SI.HeatCapacity dUTZ 
          "在恒摩尔数下内能对温度的导数";
        SI.MolarInternalEnergy[nspecies] dUZT 
          "在恒温下内能对摩尔数的导数";
        SI.SpecificEnthalpy[nspecies] dHMxT(
          min = SEMIN, 
          max = SEMAX, 
          nominal = SENOM) 
          "在恒温下总焓对组分质量的导数";
        Real dpT "压力对温度的导数";
        Real dpZ[nspecies] "压力对摩尔数的导数";
        annotation(Documentation(info = "<html>
    <h4>模型描述</h4>
    <p>
    一个用于介质属性模型的基础类，可与 ThermoFluid 库中大多数动态状态版本一起使用。目前用于所有理想气体模型。
  </p>
    </html>"));
      end ThermoProperties;
      record ThermoProperties_ph 
        "压力 p 和比焓 h 作为动态状态的热力学属性数据"

        extends Modelica.Icons.Record;
        SI.Temperature T(
          min = 1.0e-9, 
          max = 10000.0, 
          nominal = 298.15) "温度";
        SI.Density d(
          min = 1.0e-9, 
          max = 10000.0, 
          nominal = 10.0) "密度";
        SI.SpecificEnergy u(
          min = -1.0e8, 
          max = 1.0e8, 
          nominal = 1.0e6) "比内能";
        SI.SpecificEntropy s(
          min = -1.0e6, 
          max = 1.0e6, 
          nominal = 1.0e3) "比熵";
        SI.SpecificHeatCapacity cp(
          min = 1.0, 
          max = 1.0e6, 
          nominal = 1000.0) "定压比热容";
        SI.SpecificHeatCapacity cv(
          min = 1.0, 
          max = 1.0e6, 
          nominal = 1000.0) "定容比热容";
        SI.SpecificHeatCapacity R_s(
          min = 1.0, 
          max = 1.0e6, 
          nominal = 1000.0) "气体常数";
        SI.RatioOfSpecificHeatCapacities kappa "比热容比（cp/cv）";
        SI.Velocity a(
          min = 1.0, 
          max = 10000.0, 
          nominal = 300.0) "声速";
        SI.DerDensityByEnthalpy ddhp 
          "在恒压下密度对焓的导数";
        SI.DerDensityByPressure ddph 
          "在恒焓下密度对压力的导数";
        Real duph(unit = "m3/kg") 
          "在恒焓下内能对压力的导数";
        Real duhp(unit = "1") 
          "在恒压下内能对焓的导数";
        annotation(Documentation(info = "<html>
<h4>模型描述</h4>
<p>
一个用于介质属性模型的基础类，使用压力和焓作为动态状态。
这是一个适用于可能处于两相和液相区域的流体的首选模型。
</p>
</html>"));
      end ThermoProperties_ph;

      record ThermoProperties_pT 
        "压力 p 和温度 T 作为动态状态的热力学属性数据"

        extends Modelica.Icons.Record;
        SI.Density d(
          min = 1.0e-9, 
          max = 10000.0, 
          nominal = 10.0) "密度";
        SI.SpecificEnthalpy h(
          min = -1.0e8, 
          max = 1.0e8, 
          nominal = 1.0e6) "比焓";
        SI.SpecificEnergy u(
          min = -1.0e8, 
          max = 1.0e8, 
          nominal = 1.0e6) "比内能";
        SI.SpecificEntropy s(
          min = -1.0e6, 
          max = 1.0e6, 
          nominal = 1.0e3) "比熵";
        SI.SpecificHeatCapacity cp(
          min = 1.0, 
          max = 1.0e6, 
          nominal = 1000.0) "定压比热容";
        SI.SpecificHeatCapacity cv(
          min = 1.0, 
          max = 1.0e6, 
          nominal = 1000.0) "定容比热容";
        SI.SpecificHeatCapacity R_s(
          min = 1.0, 
          max = 1.0e6, 
          nominal = 1000.0) "气体常数";
        SI.RatioOfSpecificHeatCapacities kappa "比热容比（cp/cv）";
        SI.Velocity a(
          min = 1.0, 
          max = 10000.0, 
          nominal = 300.0) "声速";
        SI.DerDensityByTemperature ddTp 
          "在恒压下密度对温度的导数";
        SI.DerDensityByPressure ddpT 
          "在恒温下密度对压力的导数";
        Real dupT(unit = "m3.kg-1") 
          "在恒温下内能对压力的导数";
        SI.SpecificHeatCapacity duTp 
          "在恒压下内能对温度的导数";
        annotation(Documentation(info = "<html>
<h4>模型描述</h4>
<p>
一个用于介质属性模型的基础类，使用压力和温度作为动态状态。
这是一个适用于可能处于气相和液相区域的流体，但从不处于两相区域的合理模型。
</p>
</html>"));
      end ThermoProperties_pT;
      record ThermoProperties_dT 
        "密度 d 和温度 T 作为动态状态的热力学属性数据"

        extends Modelica.Icons.Record;
        SI.Pressure p(
          min = 1.0, 
          max = 1.0e9, 
          nominal = 1.0e5) "压力";
        SI.SpecificEnthalpy h(
          min = -1.0e8, 
          max = 1.0e8, 
          nominal = 1.0e6) "比焓";
        SI.SpecificEnergy u(
          min = -1.0e8, 
          max = 1.0e8, 
          nominal = 1.0e6) "比内能";
        SI.SpecificEntropy s(
          min = -1.0e6, 
          max = 1.0e6, 
          nominal = 1.0e3) "比熵";
        SI.SpecificHeatCapacity cp(
          min = 1.0, 
          max = 1.0e6, 
          nominal = 1000.0) "定压比热容";
        SI.SpecificHeatCapacity cv(
          min = 1.0, 
          max = 1.0e6, 
          nominal = 1000.0) "定容比热容";
        SI.SpecificHeatCapacity R_s(
          min = 1.0, 
          max = 1.0e6, 
          nominal = 1000.0) "气体常数";
        SI.RatioOfSpecificHeatCapacities kappa "比热容比（cp/cv）";
        SI.Velocity a(
          min = 1.0, 
          max = 10000.0, 
          nominal = 300.0) "声速";
        Real dudT(unit = "m5/(kg.s2)") 
          "在恒温下内能对密度的导数";
        annotation(Documentation(info = "<html>
<h4>模型描述</h4>
<p>
一个用于介质属性模型的基础类，使用密度和温度作为动态状态。
这是一个适用于可能处于气相、液相和两相区域的流体的合理模型。该模型在数值上不太适合用于液体，除非压力始终高于临界压力的约 80%。
</p>
</html>"));
      end ThermoProperties_dT;

      // record GibbsDerivs

      // "无量纲吉布斯函数对无量纲压力和温度的导数"
      // extends Modelica.Icons.Record;
      // Real pi "无量纲压力";
      // Real tau "无量纲温度";
      // Real g "无量纲吉布斯函数";
      // Real gpi "g 对 pi 的导数";
      // Real gpipi "g 对 pi 的二阶导数";
      // Real gtau "g 对 tau 的导数";
      // Real gtautau "g 对 tau 的二阶导数";
      // Real gtaupi "g 对 pi 和 tau 的混合导数";
      // end GibbsDerivs;

      // record HelmholtzDerivs

      // "无量纲亥姆霍兹函数对无量纲压力、密度和温度的导数"
      // extends Modelica.Icons.Record;
      // Real delta "无量纲密度";
      // Real tau "无量纲温度";
      // Real f "无量纲亥姆霍兹函数";
      // Real fdelta "f 对 delta 的导数";
      // Real fdeltadelta "f 对 delta 的二阶导数";
      // Real ftau "f 对 tau 的导数";
      // Real ftautau "f 对 tau 的二阶导数";
      // Real fdeltatau "f 对 pi 和 tau 的混合导数";
      // end HelmholtzDerivs;

      record TransportProps "输运属性记录表"
        extends Modelica.Icons.Record;
        SI.DynamicViscosity eta;
        SI.ThermalConductivity lam;
        annotation();
      end TransportProps;

      function gibbsToProps_ph 
        "根据无量纲吉布斯函数计算压力和比焓作为状态的属性记录表"

        extends Modelica.Icons.Function;
        input GibbsDerivs g "无量纲吉布斯函数的导数";
        output ThermoProperties_ph pro 
          "压力和比焓作为动态状态的属性记录表";
      protected
        Real vt(unit = "m3.kg-1.K-1") 
          "比容对温度的导数";
        Real vp(unit = "m4.kg-2.s2") 
          "比容对压力的导数";
        annotation();
      algorithm
        pro.T := g.T;
        pro.R_s := g.R_s;
        pro.d := g.p / (pro.R_s * pro.T * g.pi * g.gpi);
        pro.u := g.T * g.R_s * (g.tau * g.gtau - g.pi * g.gpi);
        pro.s := pro.R_s * (g.tau * g.gtau - g.g);
        pro.cp := -pro.R_s * g.tau * g.tau * g.gtautau;
        pro.cv := pro.R_s * (-g.tau * g.tau * g.gtautau + (g.gpi - g.tau * g.gtaupi) * (g.gpi 
          - g.tau * g.gtaupi) / (g.gpipi));
        pro.a := abs(g.R_s * g.T * (g.gpi * g.gpi / ((g.gpi - g.tau * g.gtaupi) * (g.gpi - g.tau 
          * g.gtaupi) / (g.tau * g.tau * g.gtautau) - g.gpipi))) ^ 0.5;
        vt := g.R_s / g.p * (g.pi * g.gpi - g.tau * g.pi * g.gtaupi);
        vp := g.R_s * g.T / (g.p * g.p) * g.pi * g.pi * g.gpipi;
        pro.kappa := -1 / (pro.d * g.p) * pro.cp / (vp * pro.cp + vt * vt * g.T);
        pro.ddhp := -pro.d * pro.d * vt / (pro.cp);
        pro.ddph := -pro.d * pro.d * (vp * pro.cp - vt / pro.d + g.T * vt * vt) / pro.cp;
        pro.duph := -1 / pro.d + g.p / (pro.d * pro.d) * pro.ddph;
        pro.duhp := 1 + g.p / (pro.d * pro.d) * pro.ddhp;
      end gibbsToProps_ph;
      function gibbsToBoundaryProps 
        "根据无量纲吉布斯函数计算相边界属性记录表"

        extends Modelica.Icons.Function;
        input GibbsDerivs g "无量纲吉布斯函数的导数";
        output PhaseBoundaryProperties sat "相边界属性";
      protected
        Real vt(unit = "m3.kg-1.K-1") 
          "比容对温度的导数";
        Real vp(unit = "m4.kg-2.s2") 
          "比容对压力的导数";
        annotation();
      algorithm
        sat.d := g.p / (g.R_s * g.T * g.pi * g.gpi);
        sat.h := g.R_s * g.T * g.tau * g.gtau;
        sat.u := g.T * g.R_s * (g.tau * g.gtau - g.pi * g.gpi);
        sat.s := g.R_s * (g.tau * g.gtau - g.g);
        sat.cp := -g.R_s * g.tau * g.tau * g.gtautau;
        sat.cv := g.R_s * (-g.tau * g.tau * g.gtautau + (g.gpi - g.tau * g.gtaupi) * (g.gpi 
          - g.tau * g.gtaupi) / (g.gpipi));
        vt := g.R_s / g.p * (g.pi * g.gpi - g.tau * g.pi * g.gtaupi);
        vp := g.R_s * g.T / (g.p * g.p) * g.pi * g.pi * g.gpipi;
        // sat.kappa := -1/(sat.d*g.p)*sat.cp/(vp*sat.cp + vt*vt*g.T);
        sat.pt := -g.p / g.T * (g.gpi - g.tau * g.gtaupi) / (g.gpipi * g.pi);
        sat.pd := -g.R_s * g.T * g.gpi * g.gpi / (g.gpipi);
      end gibbsToBoundaryProps;

      function gibbsToProps_dT 
        "根据无量纲吉布斯函数计算密度和温度作为状态的属性记录表"

        extends Modelica.Icons.Function;
        input GibbsDerivs g "无量纲吉布斯函数的导数";
        output ThermoProperties_dT pro 
          "密度和温度作为动态状态的属性记录表";
      protected
        Real vt(unit = "m3.kg-1.K-1") 
          "比容对温度的导数";
        Real vp(unit = "m4.kg-2.s2") 
          "比容对压力的导数";
        SI.Density d;
        annotation();
      algorithm
        pro.R_s := g.R_s;
        pro.p := g.p;
        pro.u := g.T * g.R_s * (g.tau * g.gtau - g.pi * g.gpi);
        pro.h := g.R_s * g.T * g.tau * g.gtau;
        pro.s := pro.R_s * (g.tau * g.gtau - g.g);
        pro.cp := -pro.R_s * g.tau * g.tau * g.gtautau;
        pro.cv := pro.R_s * (-g.tau * g.tau * g.gtautau + (g.gpi - g.tau * g.gtaupi) * (g.gpi 
          - g.tau * g.gtaupi) / g.gpipi);
        vt := g.R_s / g.p * (g.pi * g.gpi - g.tau * g.pi * g.gtaupi);
        vp := g.R_s * g.T / (g.p * g.p) * g.pi * g.pi * g.gpipi;
        pro.kappa := -1 / ((g.p / (pro.R_s * g.T * g.pi * g.gpi)) * g.p) * pro.cp / (vp * pro.cp + vt 
          * vt * g.T);
        pro.a := abs(g.R_s * g.T * (g.gpi * g.gpi / ((g.gpi - g.tau * g.gtaupi) * (g.gpi - g.tau 
          * g.gtaupi) / (g.tau * g.tau * g.gtautau) - g.gpipi))) ^ 0.5;

        d := g.p / (pro.R_s * g.T * g.pi * g.gpi);
        pro.dudT := (pro.p - g.T * vt / vp) / (d * d);
      end gibbsToProps_dT;

      function gibbsToProps_pT 
        "根据无量纲吉布斯函数计算压力和温度作为状态的属性记录表"

        extends Modelica.Icons.Function;
        input GibbsDerivs g "无量纲吉布斯函数的导数";
        output ThermoProperties_pT pro 
          "压力和温度作为动态状态的属性记录表";
      protected
        Real vt(unit = "m3.kg-1.K-1") 
          "比容对温度的导数";
        Real vp(unit = "m4.kg-2.s2") 
          "比容对压力的导数";
        annotation();
      algorithm
        pro.R_s := g.R_s;
        pro.d := g.p / (pro.R_s * g.T * g.pi * g.gpi);
        pro.u := g.T * g.R_s * (g.tau * g.gtau - g.pi * g.gpi);
        pro.h := g.R_s * g.T * g.tau * g.gtau;
        pro.s := pro.R_s * (g.tau * g.gtau - g.g);
        pro.cp := -pro.R_s * g.tau * g.tau * g.gtautau;
        pro.cv := pro.R_s * (-g.tau * g.tau * g.gtautau + (g.gpi - g.tau * g.gtaupi) * (g.gpi 
          - g.tau * g.gtaupi) / g.gpipi);
        vt := g.R_s / g.p * (g.pi * g.gpi - g.tau * g.pi * g.gtaupi);
        vp := g.R_s * g.T / (g.p * g.p) * g.pi * g.pi * g.gpipi;
        pro.kappa := -1 / (pro.d * g.p) * pro.cp / (vp * pro.cp + vt * vt * g.T);
        pro.a := abs(g.R_s * g.T * (g.gpi * g.gpi / ((g.gpi - g.tau * g.gtaupi) * (g.gpi - g.tau 
          * g.gtaupi) / (g.tau * g.tau * g.gtautau) - g.gpipi))) ^ 0.5;
        pro.ddpT := -(pro.d * pro.d) * vp;
        pro.ddTp := -(pro.d * pro.d) * vt;
        pro.duTp := pro.cp - g.p * vt;
        pro.dupT := -g.T * vt - g.p * vp;
      end gibbsToProps_pT;
      function helmholtzToProps_ph 
        "根据无量纲亥姆霍兹函数计算压力和比焓作为状态的属性记录表"

        extends Modelica.Icons.Function;
        input HelmholtzDerivs f "无量纲亥姆霍兹函数的导数";
        output ThermoProperties_ph pro 
          "压力和比焓作为动态状态的属性记录表";
      protected
        SI.Pressure p "压力";
        DerPressureByDensity pd "压力对密度的导数";
        DerPressureByTemperature pt "压力对温度的导数";
        DerPressureBySpecificVolume pv 
          "压力对比容的导数";
        annotation();
      algorithm
        pro.d := f.d;
        pro.T := f.T;
        pro.R_s := f.R_s;
        pro.s := f.R_s * (f.tau * f.ftau - f.f);
        pro.u := f.R_s * f.T * f.tau * f.ftau;
        p := pro.d * pro.R_s * pro.T * f.delta * f.fdelta;
        pd := f.R_s * f.T * f.delta * (2.0 * f.fdelta + f.delta * f.fdeltadelta);
        pt := f.R_s * f.d * f.delta * (f.fdelta - f.tau * f.fdeltatau);
        pv := -pd * f.d * f.d;

        // 在临界点附近计算cp可能会有问题 (cp -> 无穷大)。
        pro.cp := f.R_s * (-f.tau * f.tau * f.ftautau + (f.delta * f.fdelta - f.delta * f.tau 
          * f.fdeltatau) ^ 2 / (2 * f.delta * f.fdelta + f.delta * f.delta * f.fdeltadelta));
        pro.cv := f.R_s * (-f.tau * f.tau * f.ftautau);
        pro.kappa := 1 / (f.d * f.R_s * f.d * f.T * f.delta * f.fdelta) * ((-pv * pro.cv + pt * pt * f.T) 
          / (pro.cv));
        pro.a := abs(f.R_s * f.T * (2 * f.delta * f.fdelta + f.delta * f.delta * f.fdeltadelta 
          - ((f.delta * f.fdelta - f.delta * f.tau * f.fdeltatau) * (f.delta * f.fdelta - 
          f.delta * f.tau * f.fdeltatau)) / (f.tau * f.tau * f.ftautau))) ^ 0.5;
        pro.ddph := (f.d * (pro.cv * f.d + pt)) / (f.d * f.d * pd * pro.cv + f.T * pt * pt);
        pro.ddhp := -f.d * f.d * pt / (f.d * f.d * pd * pro.cv + f.T * pt * pt);
        pro.duph := -1 / pro.d + p / (pro.d * pro.d) * pro.ddph;
        pro.duhp := 1 + p / (pro.d * pro.d) * pro.ddhp;
      end helmholtzToProps_ph;
      function helmholtzToProps_pT 
        "根据无量纲亥姆霍兹函数计算压力和温度作为状态的属性记录表"

        extends Modelica.Icons.Function;
        input HelmholtzDerivs f "无量纲亥姆霍兹函数的导数";
        output ThermoProperties_pT pro 
          "压力和温度作为动态状态的属性记录表";
      protected
        DerPressureByDensity pd "压力对密度的导数";
        DerPressureByTemperature pt "压力对温度的导数";
        DerPressureBySpecificVolume pv 
          "压力对比容的导数";
        IsobaricVolumeExpansionCoefficient alpha 
          "等压体积膨胀系数";
        // beta in Bejan
        IsothermalCompressibility gamma "等温压缩系数";
        // kappa in Bejan
        SI.Pressure p "压力";
        annotation();
      algorithm
        pro.d := f.d;
        pro.R_s := f.R_s;
        pro.s := f.R_s * (f.tau * f.ftau - f.f);
        pro.h := f.R_s * f.T * (f.tau * f.ftau + f.delta * f.fdelta);
        pro.u := f.R_s * f.T * f.tau * f.ftau;
        pd := f.R_s * f.T * f.delta * (2.0 * f.fdelta + f.delta * f.fdeltadelta);
        pt := f.R_s * f.d * f.delta * (f.fdelta - f.tau * f.fdeltatau);
        pv := -(f.d * f.d) * pd;
        alpha := -f.d * pt / pv;
        gamma := -f.d / pv;
        p := f.R_s * f.d * f.T * f.delta * f.fdelta;
        // 在临界点附近计算cp可能会有问题 (cp -> 无穷大)。
        pro.cp := f.R_s * (-f.tau * f.tau * f.ftautau + (f.delta * f.fdelta - f.delta * f.tau 
          * f.fdeltatau) ^ 2 / (2 * f.delta * f.fdelta + f.delta * f.delta * f.fdeltadelta));
        pro.cv := f.R_s * (-f.tau * f.tau * f.ftautau);
        pro.kappa := 1 / (f.d * f.R_s * f.d * f.T * f.delta * f.fdelta) * ((-pv * pro.cv + pt * pt * f.T) 
          / (pro.cv));
        pro.a := abs(f.R_s * f.T * (2 * f.delta * f.fdelta + f.delta * f.delta * f.fdeltadelta 
          - ((f.delta * f.fdelta - f.delta * f.tau * f.fdeltatau) * (f.delta * f.fdelta - 
          f.delta * f.tau * f.fdeltatau)) / (f.tau * f.tau * f.ftautau))) ^ 0.5;
        pro.ddTp := -pt / pd;
        pro.ddpT := 1 / pd;
        //最后两行的单位问题
        pro.dupT := gamma * p / f.d - alpha * f.T / f.d;
        pro.duTp := pro.cp - alpha * p / f.d;
      end helmholtzToProps_pT;

      function helmholtzToProps_dT 
        "根据无量纲亥姆霍兹函数计算密度和温度作为状态的属性记录表"

        extends Modelica.Icons.Function;
        input HelmholtzDerivs f "无量纲亥姆霍兹函数的导数";
        output ThermoProperties_dT pro 
          "密度和温度作为动态状态的属性记录表";
      protected
        DerPressureByTemperature pt "压力对温度的导数";
        DerPressureBySpecificVolume pv "压力对比容的导数";
        annotation();
      algorithm
        pro.p := f.R_s * f.d * f.T * f.delta * f.fdelta;
        pro.R_s := f.R_s;
        pro.s := f.R_s * (f.tau * f.ftau - f.f);
        pro.h := f.R_s * f.T * (f.tau * f.ftau + f.delta * f.fdelta);
        pro.u := f.R_s * f.T * f.tau * f.ftau;
        pv := -(f.d * f.d) * f.R_s * f.T * f.delta * (2.0 * f.fdelta + f.delta * f.fdeltadelta);
        pt := f.R_s * f.d * f.delta * (f.fdelta - f.tau * f.fdeltatau);

        // 在临界点附近计算cp可能会有问题 (cp -> 无穷大)。
        pro.cp := f.R_s * (-f.tau * f.tau * f.ftautau + (f.delta * f.fdelta - f.delta * f.tau 
          * f.fdeltatau) ^ 2 / (2 * f.delta * f.fdelta + f.delta * f.delta * f.fdeltadelta));
        pro.cv := f.R_s * (-f.tau * f.tau * f.ftautau);
        pro.kappa := 1 / (f.d * pro.p) * ((-pv * pro.cv + pt * pt * f.T) / (pro.cv));
        pro.a := abs(f.R_s * f.T * (2 * f.delta * f.fdelta + f.delta * f.delta * f.fdeltadelta 
          - ((f.delta * f.fdelta - f.delta * f.tau * f.fdeltatau) * (f.delta * f.fdelta - 
          f.delta * f.tau * f.fdeltatau)) / (f.tau * f.tau * f.ftautau))) ^ 0.5;
        pro.dudT := (pro.p - f.T * pt) / (f.d * f.d);
      end helmholtzToProps_dT;
      function TwoPhaseToProps_ph 
        "根据饱和性质计算压力和比焓作为状态的属性记录表"

        extends Modelica.Icons.Function;
        input SaturationProperties sat "饱和性质记录表";
        output ThermoProperties_ph pro 
          "压力和比焓作为动态状态的属性记录表";
      protected
        Real dht(unit = "(J/kg)/K") 
          "比焓对温度的导数";
        Real dhd(unit = "(J/kg)/(kg/m3)") 
          "比焓对密度的导数";
        Real detph(unit = "m4.s4/(K.s8)") "热力学行列式";
        annotation();
      algorithm
        pro.d := sat.d;
        pro.T := sat.T;
        pro.u := sat.u;
        pro.s := sat.s;
        pro.cv := sat.cv;
        pro.R_s := sat.R_s;
        pro.cp := Modelica.Constants.inf;
        pro.kappa := -1 / (sat.d * sat.p) * sat.dpT * sat.dpT * sat.T / sat.cv;
        pro.a := Modelica.Constants.inf;
        dht := sat.cv + sat.dpT / sat.d;
        dhd := -sat.T * sat.dpT / (sat.d * sat.d);
        detph := -sat.dpT * dhd;
        pro.ddph := dht / detph;
        pro.ddhp := -sat.dpT / detph;
      end TwoPhaseToProps_ph;
      function TwoPhaseToProps_dT 
        "根据饱和性质计算密度和温度作为状态的属性记录表"

        extends Modelica.Icons.Function;
        input SaturationProperties sat "饱和性质";
        output ThermoProperties_dT pro 
          "密度和温度作为动态状态的属性记录表";
        annotation();
      algorithm
        pro.p := sat.p;
        pro.h := sat.h;
        pro.u := sat.u;
        pro.s := sat.s;
        pro.cv := sat.cv;
        pro.cp := Modelica.Constants.inf;
        pro.R_s := sat.R_s;
        pro.kappa := -1 / (sat.d * sat.p) * sat.dpT * sat.dpT * sat.T / sat.cv;
        pro.a := Modelica.Constants.inf;
        pro.dudT := (sat.p - sat.T * sat.dpT) / (sat.d * sat.d);
      end TwoPhaseToProps_dT;
      annotation();

    end ThermoFluidSpecial;
  public
    record SaturationProperties "在两相区域内的物性"
      extends Modelica.Icons.Record;
      SI.Temperature T "温度";
      SI.Density d "密度";
      SI.Pressure p "压力";
      SI.SpecificEnergy u "单位质量内能";
      SI.SpecificEnthalpy h "单位质量焓";
      SI.SpecificEntropy s "单位质量熵";
      SI.SpecificHeatCapacity cp "定压比热容";
      SI.SpecificHeatCapacity cv "定容比热容";
      SI.SpecificHeatCapacity R_s "气体常数";
      SI.RatioOfSpecificHeatCapacities kappa "等熵膨胀系数";
      PhaseBoundaryProperties liq 
        "沸腾曲线上的热力学基础性质";
      PhaseBoundaryProperties vap 
        "露点曲线上的热力学基础性质";
      Real dpT(unit = "Pa/K") 
        "饱和压力关于温度的导数";
      SI.MassFraction x "蒸汽质量分数";
      annotation();
    end SaturationProperties;

    record SaturationBoundaryProperties 
      "两相区域边界上的物性，包括一些导数"

      extends Modelica.Icons.Record;
      SI.Temperature T "饱和温度";
      SI.Density dl "液态密度";
      SI.Density dv "气态密度";
      SI.SpecificEnthalpy hl "液态单位质量焓";
      SI.SpecificEnthalpy hv "气态单位质量焓";
      Real dTp "温度关于饱和压力的导数";
      Real ddldp "沸腾曲线上密度关于压力的导数";
      Real ddvdp "露点曲线上密度关于压力的导数";
      Real dhldp "沸腾曲线上焓关于压力的导数";
      Real dhvdp "露点曲线上焓关于压力的导数";
      SI.MassFraction x "蒸汽质量分数";
      annotation();
    end SaturationBoundaryProperties;

    record IF97BaseTwoPhase "IF97 中间属性数据记录表"
      extends Modelica.Icons.Record;
      Integer phase(start = 0) 
        "相态：2表示两相，1表示一相，0表示未知";
      Integer region(min = 1, max = 5) "IF97 区域";
      SI.Pressure p "压力";
      SI.Temperature T "温度";
      SI.SpecificEnthalpy h "单位质量焓";
      SI.SpecificHeatCapacity R_s "气体常数";
      SI.SpecificHeatCapacity cp "定压比热容";
      SI.SpecificHeatCapacity cv "定容比热容";
      SI.Density rho "密度";
      SI.SpecificEntropy s "单位质量熵";
      DerPressureByTemperature pt "压力关于温度的导数";
      DerPressureByDensity pd "压力关于密度的导数";
      Real vt "单位体积内能量关于温度的导数";
      Real vp "单位体积内能量关于压力的导数";
      Real x "干度";
      Real dpT "饱和曲线上 dp/dT 的导数";
      annotation();
    end IF97BaseTwoPhase;

    record IF97PhaseBoundaryProperties 
      "IF97 蒸汽表相界面上的热力学基础性质"

      extends Modelica.Icons.Record;
      Boolean region3boundary "如果是两相与三相区域之间的界面则为 true";
      SI.SpecificHeatCapacity R_s "比热容";
      SI.Temperature T "温度";
      SI.Density d "密度";
      SI.SpecificEnthalpy h "单位质量焓";
      SI.SpecificEntropy s "单位质量熵";
      SI.SpecificHeatCapacity cp "定压比热容";
      SI.SpecificHeatCapacity cv "定容比热容";
      DerPressureByTemperature dpT "饱和曲线上 dp/dT 的导数";
      DerPressureByTemperature pt "压力关于温度的导数";
      DerPressureByDensity pd "压力关于密度的导数";
      Real vt(unit = "m3/(kg.K)") 
        "单位质量体积关于温度的导数";
      Real vp(unit = "m3/(kg.Pa)") "单位质量体积关于压力的导数";
      annotation();
    end IF97PhaseBoundaryProperties;

    record GibbsDerivs 
      "吉布斯函数无量纲形式关于无量纲压力和温度的导数"

      extends Modelica.Icons.Record;
      SI.Pressure p "压力";
      SI.Temperature T "温度";
      SI.SpecificHeatCapacity R_s "比热容";
      Real pi(unit = "1") "无量纲压力";
      Real tau(unit = "1") "无量纲温度";
      Real g(unit = "1") "无量纲吉布斯函数";
      Real gpi(unit = "1") "g 关于 pi 的导数";
      Real gpipi(unit = "1") "g 关于 pi 的二阶导数";
      Real gtau(unit = "1") "g 关于 tau 的导数";
      Real gtautau(unit = "1") "g 关于 tau 的二阶导数";
      Real gtaupi(unit = "1") "g 关于 pi 和 tau 的混合导数";
      annotation();
    end GibbsDerivs;

    record HelmholtzDerivs 
      "亥姆霍兹函数无量纲形式关于无量纲压力、密度和温度的导数"
      extends Modelica.Icons.Record;
      SI.Density d "密度";
      SI.Temperature T "温度";
      SI.SpecificHeatCapacity R_s "比热容";
      Real delta(unit = "1") "无量纲密度";
      Real tau(unit = "1") "无量纲温度";
      Real f(unit = "1") "无量纲亥姆霍兹函数";
      Real fdelta(unit = "1") "f 关于 delta 的导数";
      Real fdeltadelta(unit = "1") "f 关于 delta 的二阶导数";
      Real ftau(unit = "1") "f 关于 tau 的导数";
      Real ftautau(unit = "1") "f 关于 tau 的二阶导数";
      Real fdeltatau(unit = "1") "f 关于 delta 和 tau 的混合导数";
      annotation();
    end HelmholtzDerivs;

    record TwoPhaseTransportProps 
      "定义在两相区域中需要的两相边界上的属性"
      extends Modelica.Icons.Record;
      SI.Density d_vap "露点上的密度";
      SI.Density d_liq "泡点上的密度";
      SI.DynamicViscosity eta_vap "露点上的动力黏度";
      SI.DynamicViscosity eta_liq "泡点上的动力黏度";
      SI.ThermalConductivity lam_vap "露点上的导热系数";
      SI.ThermalConductivity lam_liq "泡点上的导热系数";
      SI.SpecificHeatCapacity cp_vap "露点上的定压比热容";
      SI.SpecificHeatCapacity cp_liq "泡点上的定压比热容";
      SI.MassFraction x "蒸汽质量分数";
      annotation();
    end TwoPhaseTransportProps;

    record PhaseBoundaryProperties 
      "相界面上的热力学基础性质"
      extends Modelica.Icons.Record;
      SI.Density d "密度";
      SI.SpecificEnthalpy h "单位质量焓";
      SI.SpecificEnergy u "单位质量内能";
      SI.SpecificEntropy s "单位质量熵";
      SI.SpecificHeatCapacity cp "定压比热容";
      SI.SpecificHeatCapacity cv "定容比热容";
      DerPressureByTemperature pt "压力关于温度的导数";
      DerPressureByDensity pd "压力关于密度的导数";
      annotation();
    end PhaseBoundaryProperties;

    record NewtonDerivatives_ph 
      "亥姆霍兹函数快速逆运算的导数：p & h"

      extends Modelica.Icons.Record;
      SI.Pressure p "压力";
      SI.SpecificEnthalpy h "单位质量焓";
      DerPressureByDensity pd "压力关于密度的导数";
      DerPressureByTemperature pt "压力关于温度的导数";
      Real hd "单位质量焓关于密度的导数";
      Real ht "单位质量焓关于温度的导数";
      annotation();
    end NewtonDerivatives_ph;

    record NewtonDerivatives_ps 
      "亥姆霍兹函数快速逆运算的导数：p & s"

      extends Modelica.Icons.Record;
      SI.Pressure p "压力";
      SI.SpecificEntropy s "单位质量熵";
      DerPressureByDensity pd "压力关于密度的导数";
      DerPressureByTemperature pt "压力关于温度的导数";
      Real sd "单位质量熵关于密度的导数";
      Real st "单位质量熵关于温度的导数";
      annotation();
    end NewtonDerivatives_ps;

    record NewtonDerivatives_pT 
      "亥姆霍兹函数快速逆运算的导数：p & T"

      extends Modelica.Icons.Record;
      SI.Pressure p "压力";
      DerPressureByDensity pd "压力关于密度的导数";
      annotation();
    end NewtonDerivatives_pT;

    record ExtraDerivatives "额外的热力学导数"
      extends Modelica.Icons.Record;
      IsentropicExponent kappa "等熵膨胀系数";
      // Bejan 中的 k
      IsenthalpicExponent theta "等焓指数";
      // 与 kappa 相同，但在恒定 h 时的导数
      IsobaricVolumeExpansionCoefficient alpha 
        "等压体积膨胀系数";
      // Bejan 中 的beta
      IsochoricPressureCoefficient beta "等容压缩系数";
      // Bejan 中的 beta
      IsothermalCompressibility gamma "等温压缩系数";
      // Bejan 中的 kappa
      JouleThomsonCoefficient mu "焦耳-汤姆逊系数";
      annotation();
      // Bejan 中的 mu_J
    end ExtraDerivatives;

    record BridgmansTables 
      "如果给出前七个变量，则计算 Bridgmans 表中的所有项目"
      extends Modelica.Icons.Record;
      // 前 7 个变量需要在函数中计算！
      SI.SpecificVolume v "比容";
      SI.Pressure p "压力";
      SI.Temperature T "温度";
      SI.SpecificEntropy s "比熵";
      SI.SpecificHeatCapacity cp "定压比热容";
      IsobaricVolumeExpansionCoefficient alpha 
        "等压体积膨胀系数";
      // Bejan 中的 beta
      IsothermalCompressibility gamma "等温压缩系数";
      // Bejan 中的 kappa
      // 压力的导数
      Real dTp = 1 "Bridgmans 表中的系数，使用信息见下方";
      Real dpT = -dTp "Bridgmans 表中的系数，使用信息见下方";
      Real dvp = alpha * v "Bridgmans 表中的系数，使用信息见下方";
      Real dpv = -dvp "Bridgmans 表中的系数，使用信息见下方";
      Real dsp = cp / T "Bridgmans 表中的系数，使用信息见下方";
      Real dps = -dsp "Bridgmans 表中的系数，使用信息见下方";
      Real dup = cp - alpha * p * v 
        "Bridgmans 表中的系数，使用信息见下方";
      Real dpu = -dup "Bridgmans 表中的系数，使用信息见下方";
      Real dhp = cp "Bridgmans 表中的系数，使用信息见下方";
      Real dph = -dhp "Bridgmans 表中的系数，使用信息见下方";
      Real dfp = -s - alpha * p * v 
        "Bridgmans 表中的系数，使用信息见下方";
      Real dpf = -dfp "Bridgmans 表中的系数，使用信息见下方";
      Real dgp = -s "Bridgmans 表中的系数，使用信息见下方";
      Real dpg = -dgp "Bridgmans表 中的系数，使用信息见下方";
      // 在恒定温度时的导数
      Real dvT = gamma * v "Bridgmans 表中的系数，使用信息见下方";
      Real dTv = -dvT "Bridgmans 表中的系数，使用信息见下方";
      Real dsT = alpha * v "Bridgmans 表中的系数，使用信息见下方";
      Real dTs = -dsT "Bridgmans 表中的系数，使用信息见下方";
      Real duT = alpha * T * v - gamma * p * v 
        "Bridgmans 表中的系数，使用信息见下方";
      Real dTu = -duT "Bridgmans 表中的系数，使用信息见下方";
      Real dhT = -v + alpha * T * v 
        "Bridgmans 表中的系数，使用信息见下方";
      Real dTh = -dhT "Bridgmans 表中的系数，使用信息见下方";
      Real dfT = -gamma * p * v "Bridgmans 表中的系数，使用信息见下方";
      Real dTf = -dfT "Bridgmans 表中的系数，使用信息见下方";
      Real dgT = -v "Bridgmans 表中的系数，使用信息见下方";
      Real dTg = -dgT "Bridgmans 表中的系数，使用信息见下方";
      // 在恒定比容时的导数
      Real dsv = alpha * alpha * v * v - gamma * v * cp / T 
        "Bridgmans 表中的系数，使用信息见下方";
      Real dvs = -dsv "Bridgmans表中的系数，使用信息见下方";
      Real duv = T * alpha * alpha * v * v - gamma * v * cp 
        "Bridgmans 表中的系数，使用信息见下方";
      Real dvu = -duv "Bridgmans表中的系数，使用信息见下方";
      Real dhv = T * alpha * alpha * v * v - alpha * v * v - gamma * v * cp 
        "Bridgmans 表中的系数，使用信息见下方";
      Real dvh = -dhv "Bridgmans 表中的系数，使用信息见下方";
      Real dfv = gamma * v * s "Bridgmans 表中的系数，使用信息见下方";
      Real dvf = -dfv "Bridgmans 表中的系数，使用信息见下方";
      Real dgv = gamma * v * s - alpha * v * v 
        "Bridgmans 表中的系数，使用信息见下方";
      Real dvg = -dgv "Bridgmans 表中的系数，使用信息见下方";
      // 在恒定熵时的导数
      Real dus = dsv * p "Bridgmans 表中的系数，使用信息见下方";
      Real dsu = -dus "Bridgmans 表中的系数，使用信息见下方";
      Real dhs = -v * cp / T "Bridgmans 表中的系数，使用信息见下方";
      Real dsh = -dhs "Bridgmans 表中的系数，使用信息见下方";
      Real dfs = alpha * v * s + dus 
        "Bridgmans 表中的系数，使用信息见下方";
      Real dsf = -dfs "Bridgmans表中的系数，使用信息见下方";
      Real dgs = alpha * v * s - v * cp / T 
        "Bridgmans 表中的系数，使用信息见下方";
      Real dsg = -dgs "Bridgmans 表中的系数，使用信息见下方";
      // 在恒定内能时的导数
      Real dhu = p * alpha * v * v + gamma * v * cp * p - v * cp - p * T * alpha * alpha * v * v 
        "Bridgmans 表中的系数，使用信息见下方";
      Real duh = -dhu "Bridgmans 表中的系数，使用信息见下方";
      Real dfu = s * T * alpha * v - gamma * v * cp * p - gamma * v * s * p + p * T * alpha * alpha * v * v 
        "Bridgmans 表中的系数，使用信息见下方";
      Real duf = -dfu "Bridgmans表中的系数，使用信息见下方";
      Real dgu = alpha * v * v * p + alpha * v * s * T - v * cp - gamma * v * s * p 
        "Bridgmans 表中的系数，使用信息见下方";
      Real dug = -dgu "Bridgmans表中的系数，使用信息见下方";
      // 在恒定焓时的导数
      Real dfh = (s - v * alpha * p) * (v - v * alpha * T) - gamma * v * cp * p 
        "Bridgmans 表中的系数，使用信息见下方";
      Real dhf = -dfh "Bridgmans表中的系数，使用信息见下方";
      Real dgh = alpha * v * s * T - v * (s + cp) 
        "Bridgmans 表中的系数，使用信息见下方";
      Real dhg = -dgh "Bridgmans表中的系数，使用信息见下方";
      // 在恒定 g 时的导数
      Real dfg = gamma * v * s * p - v * s - alpha * v * v * p 
        "Bridgmans 表中的系数，使用信息见下方";
      Real dgf = -dfg "Bridgmans表中的系数，使用信息见下方";
      annotation(Documentation(info = "<html>
<p>
重要：尚未考虑相平衡条件。
这意味着 Bridgman 的表在两相区域中尚不起作用。
某些导数为 0 或无穷大。
注意：不要直接使用 Bridgmans 表中的值，所有
导数都被计算为表中两个条目的商。
最后一个字母表示在导数中保持不变的变量。
第二个字母是导数涉及的两个变量，第一个字母始终是 d，以提醒不同
</p>

<blockquote><pre>
示例 1：获得比容恒定时比熵 s 关于温度 T 的导数（与恒定密度相同）
恒定体积-->最后一个字母 v
温度-->第二个字母 T
比熵-->第二个字母 s
-->所需值为 dsv/dTv
已知变量：
温度 T
压力 p
比容 v
内能 u
焓 h
比熵 s
比亥姆霍兹能量 f
比吉布斯焓 g
未包含但有用：
密度 d
为了转换涉及密度的导数，使用以下规则：
在恒定密度==在恒定比容时
ddx/dyx = -d*d*dvx/dyx，其中y，x是T，p，u，h，s，f，g中的任何一个
dyx/ddx = -1/(d*d)dyx/dvx，其中y，x是T，p，u，h，s，f，g中的任何一个
使用示例假设水作为介质：
model BridgmansTablesForWater
extends ThermoFluid.BaseClasses.MediumModels.Water.WaterSteamMedium_ph;
Real derOfsByTAtConstantv \"比容恒定时比熵s关于温度T的导数\"
ThermoFluid.BaseClasses.MediumModels.Common.ExtraDerivatives dpro;
ThermoFluid.BaseClasses.MediumModels.Common.BridgmansTables bt;
equation
dpro = ThermoFluid.BaseClasses.MediumModels.SteamIF97.extraDerivs_pT(p[1],T[1]);
bt.p = p[1];
bt.T = T[1];
bt.v = 1/pro[1].d;
bt.s = pro[1].s;
bt.cp = pro[1].cp;
bt.alpha = dpro.alpha;
bt.gamma = dpro.gamma;
derOfsByTAtConstantv =  bt.dsv/bt.dTv;
                ...
end BridgmansTablesForWater;
                </pre></blockquote>

                </html>"));
    end BridgmansTables;

    record FundamentalConstants "介质的常数"
      extends Modelica.Icons.Record;
      SI.MolarHeatCapacity R_bar;
      SI.SpecificHeatCapacity R_s;
      SI.MolarMass MM;
      SI.MolarDensity rhored;
      SI.Temperature Tred;
      SI.AbsolutePressure pred;
      SI.SpecificEnthalpy h_off;
      SI.SpecificEntropy s_off;
      annotation();
    end FundamentalConstants;
    record AuxiliaryProperties "中间属性数据记录表"
      extends Modelica.Icons.Record;
      SI.Pressure p "压力";
      SI.Temperature T "温度";
      SI.SpecificEnthalpy h "比焓";
      SI.SpecificHeatCapacity R_s "气体常数";
      SI.SpecificHeatCapacity cp "定压比热容";
      SI.SpecificHeatCapacity cv "定容比热容";
      SI.Density rho "密度";
      SI.SpecificEntropy s "比熵";
      SI.DerPressureByTemperature pt "压力对温度的导数";
      SI.DerPressureByDensity pd "压力对密度的导数";
      Real vt "比容对温度的导数";
      Real vp "比容对压力的导数";
      annotation();
    end AuxiliaryProperties;

    record GibbsDerivs2 
      "吉布斯函数关于压力和温度的导数"

      extends Modelica.Icons.Record;
      SI.Pressure p "压力";
      SI.Temperature T "温度";
      SI.SpecificHeatCapacity R_s "比热容";
      Real pi(unit = "1") "无量纲压力";
      Real theta(unit = "1") "无量纲温度";
      Real g(unit = "J/kg") "吉布斯函数";
      Real gp(unit = "m3/kg") "g 对 p 的导数";
      Real gpp(unit = "m3/(kg.Pa)") "g 对 p 的二阶导数";
      Real gT(unit = "J/(kg.K)") "g 对 T 的导数";
      Real gTT(unit = "J/(kg.K2)") "g 对 T 的二阶导数";
      Real gTp(unit = "m3/(kg.K)") "g 对 T 和 p 的混合导数";
      annotation();
    end GibbsDerivs2;

    record NewtonDerivatives_dT 
      "用于快速逆向计算吉布斯函数的导数"
      extends Modelica.Icons.Record;
      SI.SpecificVolume v "比容";
      Real vp "比容对压力的导数";
      annotation();
    end NewtonDerivatives_dT;
    function gibbsToBridgmansTables 
      "根据吉布斯函数计算 Bridgman 表的基本系数"
      extends Modelica.Icons.Function;
      input GibbsDerivs g "吉布斯函数的无量纲导数";
      output SI.SpecificVolume v "比容";
      output SI.Pressure p = g.p "压力";
      output SI.Temperature T = g.T "温度";
      output SI.SpecificEntropy s "比熵";
      output SI.SpecificHeatCapacity cp "定压比热容";
      output IsobaricVolumeExpansionCoefficient alpha 
        "等压体积膨胀系数";
      // beta in Bejan
      output IsothermalCompressibility gamma "等温压缩系数";
      // kappa in Bejan
    protected
      Real vt(unit = "m3/(kg.K)") 
        "比容对温度的导数";
      Real vp(unit = "m4.kg-2.s2") "比容对压力的导数";
      annotation();
    algorithm
      vt := g.R_s / g.p * (g.pi * g.gpi - g.tau * g.pi * g.gtaupi);
      vp := g.R_s * g.T / (g.p * g.p) * g.pi * g.pi * g.gpipi;
      v := (g.R_s * g.T * g.pi * g.gpi) / g.p;
      s := g.R_s * (g.tau * g.gtau - g.g);
      cp := -g.R_s * g.tau * g.tau * g.gtautau;
      alpha := vt / v;
      gamma := -vp / v;
    end gibbsToBridgmansTables;
    function helmholtzToBridgmansTables 
      "根据亥姆霍兹能量计算 Bridgman 表的基本系数"
      extends Modelica.Icons.Function;
      input HelmholtzDerivs f "亥姆霍兹函数的无量纲导数";
      output SI.SpecificVolume v = 1 / f.d "比容";
      output SI.Pressure p "压力";
      output SI.Temperature T = f.T "温度";
      output SI.SpecificEntropy s "比熵";
      output SI.SpecificHeatCapacity cp "定压比热容";
      output IsobaricVolumeExpansionCoefficient alpha 
        "等压体积膨胀系数";
      // beta in Bejan
      output IsothermalCompressibility gamma "等温压缩系数";
      // kappa in Bejan
    protected
      DerPressureByTemperature pt "压力对温度的导数";
      DerPressureBySpecificVolume pv 
        "压力对比容的导数";
      SI.SpecificHeatCapacity cv "等容比热容";
      annotation();
    algorithm
      p := f.R_s * f.d * f.T * f.delta * f.fdelta;
      pv := -(f.d * f.d) * f.R_s * f.T * f.delta * (2.0 * f.fdelta + f.delta * f.fdeltadelta);
      pt := f.R_s * f.d * f.delta * (f.fdelta - f.tau * f.fdeltatau);
      s := f.R_s * (f.tau * f.ftau - f.f);
      alpha := -f.d * pt / pv;
      gamma := -f.d / pv;
      cp := f.R_s * (-f.tau * f.tau * f.ftautau + (f.delta * f.fdelta - f.delta * f.tau * f.fdeltatau) 
        ^ 2 / (2 * f.delta * f.fdelta + f.delta * f.delta * f.fdeltadelta));
    end helmholtzToBridgmansTables;
    function gibbsToBoundaryProps 
      "根据无量纲吉布斯函数计算相界属性记录表"
      extends Modelica.Icons.Function;
      input GibbsDerivs g "吉布斯函数的无量纲导数";
      output PhaseBoundaryProperties sat "相界属性";
    protected
      Real vt "比容对温度的导数";
      Real vp "比容对压力的导数";
      annotation();
    algorithm
      sat.d := g.p / (g.R_s * g.T * g.pi * g.gpi);
      sat.h := g.R_s * g.T * g.tau * g.gtau;
      sat.u := g.T * g.R_s * (g.tau * g.gtau - g.pi * g.gpi);
      sat.s := g.R_s * (g.tau * g.gtau - g.g);
      sat.cp := -g.R_s * g.tau * g.tau * g.gtautau;
      sat.cv := g.R_s * (-g.tau * g.tau * g.gtautau + (g.gpi - g.tau * g.gtaupi) * (g.gpi - g.tau 
        * g.gtaupi) / (g.gpipi));
      vt := g.R_s / g.p * (g.pi * g.gpi - g.tau * g.pi * g.gtaupi);
      vp := g.R_s * g.T / (g.p * g.p) * g.pi * g.pi * g.gpipi;
      // sat.kappa := -1/(sat.d*g.p)*sat.cp/(vp*sat.cp + vt*vt*g.T);
      sat.pt := -g.p / g.T * (g.gpi - g.tau * g.gtaupi) / (g.gpipi * g.pi);
      sat.pd := -g.R_s * g.T * g.gpi * g.gpi / (g.gpipi);
    end gibbsToBoundaryProps;
    function helmholtzToBoundaryProps 
      "根据无量纲亥姆霍兹函数计算相界属性记录表"
      extends Modelica.Icons.Function;
      input HelmholtzDerivs f "亥姆霍兹函数的无量纲导数";
      output PhaseBoundaryProperties sat "相界属性记录表";
    protected
      SI.Pressure p "压力";
      annotation();
    algorithm
      p := f.R_s * f.d * f.T * f.delta * f.fdelta;
      sat.d := f.d;
      sat.h := f.R_s * f.T * (f.tau * f.ftau + f.delta * f.fdelta);
      sat.s := f.R_s * (f.tau * f.ftau - f.f);
      sat.u := f.R_s * f.T * f.tau * f.ftau;
      sat.cp := f.R_s * (-f.tau * f.tau * f.ftautau + (f.delta * f.fdelta - f.delta * f.tau * f.fdeltatau) 
        ^ 2 / (2 * f.delta * f.fdelta + f.delta * f.delta * f.fdeltadelta));
      sat.cv := f.R_s * (-f.tau * f.tau * f.ftautau);
      sat.pt := f.R_s * f.d * f.delta * (f.fdelta - f.tau * f.fdeltatau);
      sat.pd := f.R_s * f.T * f.delta * (2.0 * f.fdelta + f.delta * f.fdeltadelta);
    end helmholtzToBoundaryProps;
    function cv2Phase 
      "计算两相区域内的等容比热容量"
      extends Modelica.Icons.Function;
      input PhaseBoundaryProperties liq "沸腾曲线上的性质";
      input PhaseBoundaryProperties vap "冷凝曲线上的性质";
      input SI.MassFraction x "蒸汽质量分数";
      input SI.Temperature T "温度";
      input SI.Pressure p "压力";
      output SI.SpecificHeatCapacity cv "等容比热容量";
    protected
      Real dpT "压力对温度的导数";
      Real dxv "蒸汽质量分数对比容的导数";
      Real dvTl "液体比容对温度的导数";
      Real dvTv "蒸汽比容对温度的导数";
      Real duTl "液体比内能对温度的导数";
      Real duTv "蒸汽比内能对温度的导数";
      Real dxt "蒸汽质量分数对温度的导数";
      annotation();
    algorithm
      dxv := if (liq.d <> vap.d) then liq.d * vap.d / (liq.d - vap.d) else 0.0;
      dpT := (vap.s - liq.s) * dxv;
      // 在临界点不正确
      dvTl := (liq.pt - dpT) / liq.pd / liq.d / liq.d;
      dvTv := (vap.pt - dpT) / vap.pd / vap.d / vap.d;
      dxt := -dxv * (dvTl + x * (dvTv - dvTl));
      duTl := liq.cv + (T * liq.pt - p) * dvTl;
      duTv := vap.cv + (T * vap.pt - p) * dvTv;
      cv := duTl + x * (duTv - duTl) + dxt * (vap.u - liq.u);
    end cv2Phase;
    function cvdpT2Phase 
      "计算两相区域内的等容比热容和压力对温度的导数"
      extends Modelica.Icons.Function;
      input PhaseBoundaryProperties liq "沸腾曲线上的属性";
      input PhaseBoundaryProperties vap "凝结曲线上的属性";
      input SI.MassFraction x "蒸汽质量分数";
      input SI.Temperature T "温度";
      input SI.Pressure p "属性";
      output SI.SpecificHeatCapacity cv "等容比热容";
      output Real dpT "压力对温度的导数";
    protected
      Real dxv "蒸汽质量分数对比容的导数";
      Real dvTl "液体比容对温度的导数";
      Real dvTv "蒸汽比容对温度的导数";
      Real duTl "液体比内能对温度的导数";
      Real duTv "蒸汽比内能对温度的导数";
      Real dxt "蒸汽质量分数对温度的导数";
      annotation();
    algorithm
      dxv := if (liq.d <> vap.d) then liq.d * vap.d / (liq.d - vap.d) else 0.0;
      dpT := (vap.s - liq.s) * dxv;
      // 在临界点不正确
      dvTl := (liq.pt - dpT) / liq.pd / liq.d / liq.d;
      dvTv := (vap.pt - dpT) / vap.pd / vap.d / vap.d;
      dxt := -dxv * (dvTl + x * (dvTv - dvTl));
      duTl := liq.cv + (T * liq.pt - p) * dvTl;
      duTv := vap.cv + (T * vap.pt - p) * dvTv;
      cv := duTl + x * (duTv - duTl) + dxt * (vap.u - liq.u);
    end cvdpT2Phase;
    function gibbsToExtraDerivs 
      "根据无量纲吉布斯函数计算额外的热力学导数"
      extends Modelica.Icons.Function;
      input GibbsDerivs g "吉布斯函数的无量纲导数";
      output ExtraDerivatives dpro "额外的属性导数";
    protected
      Real vt "比容对温度的导数";
      Real vp "比容对压力的导数";
      SI.Density d "密度";
      SI.SpecificVolume v "比容";
      SI.SpecificHeatCapacity cv "等容热容";
      SI.SpecificHeatCapacity cp "等压热容";
      annotation();
    algorithm
      d := g.p / (g.R_s * g.T * g.pi * g.gpi);
      v := 1 / d;
      vt := g.R_s / g.p * (g.pi * g.gpi - g.tau * g.pi * g.gtaupi);
      vp := g.R_s * g.T / (g.p * g.p) * g.pi * g.pi * g.gpipi;
      cp := -g.R_s * g.tau * g.tau * g.gtautau;
      cv := g.R_s * (-g.tau * g.tau * g.gtautau + (g.gpi - g.tau * g.gtaupi) * (g.gpi - g.tau 
        * g.gtaupi) / g.gpipi);
      dpro.kappa := -1 / (d * g.p) * cp / (vp * cp + vt * vt * g.T);
      dpro.theta := cp / (d * g.p * (-vp * cp + vt * v - g.T * vt * vt));
      dpro.alpha := d * vt;
      dpro.beta := -vt / (g.p * vp);
      dpro.gamma := -d * vp;
      dpro.mu := -(v - g.T * vt) / cp;
    end gibbsToExtraDerivs;
    function helmholtzToExtraDerivs 
      "根据无量纲亥姆霍兹函数计算额外的热力学导数"
      extends Modelica.Icons.Function;
      input HelmholtzDerivs f "亥姆霍兹函数的无量纲导数";
      output ExtraDerivatives dpro "额外的属性导数";
    protected
      SI.Pressure p "压力";
      SI.SpecificVolume v "比容";
      DerPressureByTemperature pt "压力对温度的导数";
      DerPressureBySpecificVolume pv "压力对比容的导数";
      SI.SpecificHeatCapacity cv "等容热容";
      annotation();
    algorithm
      v := 1 / f.d;
      p := f.R_s * f.d * f.T * f.delta * f.fdelta;
      pv := -(f.d * f.d) * f.R_s * f.T * f.delta * (2.0 * f.fdelta + f.delta * f.fdeltadelta);
      pt := f.R_s * f.d * f.delta * (f.fdelta - f.tau * f.fdeltatau);
      cv := f.R_s * (-f.tau * f.tau * f.ftautau);
      dpro.kappa := 1 / (f.d * p) * ((-pv * cv + pt * pt * f.T) / (cv));
      dpro.theta := -1 / (f.d * p) * ((-pv * cv + f.T * pt * pt) / (cv + pt * v));
      dpro.alpha := -f.d * pt / pv;
      dpro.beta := pt / p;
      dpro.gamma := -f.d / pv;
      dpro.mu := (v * pv + f.T * pt) / (pt * pt * f.T - pv * cv);
    end helmholtzToExtraDerivs;
    function Helmholtz_ph 
      "用于计算根据p和h计算d和t的解析导数的函数"
      extends Modelica.Icons.Function;
      input HelmholtzDerivs f "亥姆霍兹函数的无量纲导数";
      output NewtonDerivatives_ph nderivs "用于根据p和h计算d和t的牛顿迭代的导数";
    protected
      SI.SpecificHeatCapacity cv "等容热容";
      annotation();
    algorithm
      cv := -f.R_s * (f.tau * f.tau * f.ftautau);
      nderivs.p := f.d * f.R_s * f.T * f.delta * f.fdelta;
      nderivs.h := f.R_s * f.T * (f.tau * f.ftau + f.delta * f.fdelta);
      nderivs.pd := f.R_s * f.T * f.delta * (2.0 * f.fdelta + f.delta * f.fdeltadelta);
      nderivs.pt := f.R_s * f.d * f.delta * (f.fdelta - f.tau * f.fdeltatau);
      nderivs.ht := cv + nderivs.pt / f.d;
      nderivs.hd := (nderivs.pd - f.T * nderivs.pt / f.d) / f.d;
    end Helmholtz_ph;
    function Helmholtz_pT 
      "计算根据p和t计算d和t的解析导数的函数"
      extends Modelica.Icons.Function;
      input HelmholtzDerivs f "亥姆霍兹函数的无量纲导数";
      output NewtonDerivatives_pT nderivs 
        "用于根据p和t计算d和t的牛顿迭代的导数";
      annotation();
    algorithm
      nderivs.p := f.d * f.R_s * f.T * f.delta * f.fdelta;
      nderivs.pd := f.R_s * f.T * f.delta * (2.0 * f.fdelta + f.delta * f.fdeltadelta);
    end Helmholtz_pT;

    function Helmholtz_ps 
      "计算根据p和s计算d和t的解析导数的函数"
      extends Modelica.Icons.Function;
      input HelmholtzDerivs f "亥姆霍兹函数的无量纲导数";
      output NewtonDerivatives_ps nderivs 
        "用于根据p和s计算d和t的牛顿迭代的导数";
    protected
      SI.SpecificHeatCapacity cv "等容热容";
      annotation();
    algorithm
      cv := -f.R_s * (f.tau * f.tau * f.ftautau);
      nderivs.p := f.d * f.R_s * f.T * f.delta * f.fdelta;
      nderivs.s := f.R_s * (f.tau * f.ftau - f.f);
      nderivs.pd := f.R_s * f.T * f.delta * (2.0 * f.fdelta + f.delta * f.fdeltadelta);
      nderivs.pt := f.R_s * f.d * f.delta * (f.fdelta - f.tau * f.fdeltatau);
      nderivs.st := cv / f.T;
      nderivs.sd := -nderivs.pt / (f.d * f.d);
    end Helmholtz_ps;
    function smoothStep 
      "对一般阶跃函数的近似，使得特征是连续且可微的"
      extends Modelica.Icons.Function;
      input Real x "自变量值";
      input Real y1 "x > 0 时的纵坐标值";
      input Real y2 "x < 0 时的纵坐标值";
      input Real x_small(min = 0) = 1e-5 
        "用于近似 -x_small <= x <= x_small 的阶跃函数; 要求 x_small > 0";
      output Real y "近似值，使得 y = if x > 0 then y1 else y2";
    algorithm
      y := smooth(1, if x > x_small then y1 else if x < -x_small then y2 else if 
        abs(x_small) > 0 then (x / x_small) * ((x / x_small) ^ 2 - 3) * (y2 - y1) / 4 + (y1 
        + y2) / 2 else (y1 + y2) / 2);

      annotation(
        Inline = true, 
        smoothOrder = 1, 
        Documentation(revisions = "<html>
<ul>
<li><em>April 29, 2008</em>
    by <a href=\"mailto:Martin.Otter@DLR.de\">Martin Otter</a>:<br>
    设计并实现。</li>
<li><em>August 12, 2008</em>
    by <a href=\"mailto:Michael.Sielemann@dlr.de\">Michael Sielemann</a>:<br>
    对极限情况 <code>x_small -> 0</code> 进行了微小修改，以避免除以零。</li>
</ul>
</html>", info = "<html>
<p>
该函数用于近似方程
</p>
<blockquote><pre>
y = <strong>if</strong> x &gt; 0 <strong>then</strong> y1 <strong>else</strong> y2;
</pre></blockquote>

<p>
通过平滑特征，使得表达式是连续且可微的:
</p>

<blockquote><pre>
y = <strong>smooth</strong>(1, <strong>if</strong> x &gt;  x_small <strong>then</strong> y1 <strong>else</strong>
              <strong>if</strong> x &lt; -x_small <strong>then</strong> y2 <strong>else</strong> f(y1, y2));
</pre></blockquote>

<p>
在区间 -x_small &lt; x &lt; x_small 中使用二次多项式进行平滑过渡，使得从 y1 过渡到 y2。
</p>

<p>
如果使用该函数近似 <strong>质量分数</strong> X[:]，那么可以对所有的 <strong>nX</strong> 质量分数进行近似，
而不是对 nX-1 个质量分数进行近似，然后通过质量分数约束 sum(X)=1 计算最后一个质量分数。
原因是该近似函数具有以下性质：sum(X) = 1，前提是 sum(X_a) = sum(X_b) = 1
（其中 y1=X_a[i]，y2=X_b[i]）。
可以通过在 abs(x) &lt; x_small 区域评估近似函数来证明这一点（否则 X 要么是 X_a 要么是 X_b）:
</p>

<blockquote><pre>
X[1]  = smoothStep(x, X_a[1] , X_b[1] , x_small);
X[2]  = smoothStep(x, X_a[2] , X_b[2] , x_small);
   ...
X[nX] = smoothStep(x, X_a[nX], X_b[nX], x_small);
</pre></blockquote>

<p>
或者
</p>

<blockquote><pre>
X[1]  = c*(X_a[1]  - X_b[1])  + (X_a[1]  + X_b[1])/2
X[2]  = c*(X_a[2]  - X_b[2])  + (X_a[2]  + X_b[2])/2;
   ...
X[nX] = c*(X_a[nX] - X_b[nX]) + (X_a[nX] + X_b[nX])/2;
c     = (x/x_small)*((x/x_small)^2 - 3)/4
</pre></blockquote>

<p>
将所有质量分数相加得到
</p>

<blockquote><pre>
sum(X) = c*(sum(X_a) - sum(X_b)) + (sum(X_a) + sum(X_b))/2
       = c*(1 - 1) + (1 + 1)/2
       = 1
</pre></blockquote>
</html>"));
    end smoothStep;
    function Gibbs2_ph 
      "计算根据p和h计算T的解析导数的函数"
      extends Modelica.Icons.Function;
      input Modelica.Media.Common.GibbsDerivs2 g 
        "吉布斯函数的无量纲导数";
      output Modelica.Media.Common.NewtonDerivatives_ph nderivs 
        "用于根据p和h计算d和t的牛顿迭代的导数";
      annotation();

    algorithm
      nderivs.h := g.g - g.T * g.gT;
      nderivs.ht := -g.T * g.gTT;

      //假值 - 不要使用
      nderivs.p := 0.0;
      nderivs.pd := 0.0;
      nderivs.pt := 0.0;
      nderivs.hd := 0.0;
    end Gibbs2_ph;

    function Gibbs2_dT 
      "计算根据d和T计算p的解析导数的函数"
      extends Modelica.Icons.Function;
      input Modelica.Media.Common.GibbsDerivs2 g 
        "吉布斯函数的无量纲导数";
      output Modelica.Media.Common.NewtonDerivatives_dT nderivs 
        "用于根据d和T计算p的牛顿迭代的导数";
      annotation();

    algorithm
      nderivs.v := g.gp;
      nderivs.vp := nderivs.v * g.gpp / g.gp;
    end Gibbs2_dT;

    function Gibbs2_ps 
      "计算根据p和s计算d和t的解析导数的函数"

      extends Modelica.Icons.Function;
      input Modelica.Media.Common.GibbsDerivs2 g 
        "吉布斯函数的无量纲导数";
      output Modelica.Media.Common.NewtonDerivatives_ps nderivs 
        "用于根据p和s计算T的牛顿迭代的导数";
      annotation();

    algorithm
      nderivs.s := -g.gT;
      nderivs.st := -g.gTT;

      //假值 - 不要使用
      nderivs.p := 0.0;
      nderivs.pd := 0.0;
      nderivs.pt := 0.0;
      nderivs.sd := 0.0;
    end Gibbs2_ps;
    annotation(Documentation(info = "<html><h4>库描述</h4><p>
Modelica.Media.Common 提供了许多物性子库共享的记录和函数。尽管具体的模型可能不同，但高精度流体物性模型具有很多共同的结构。这些物性模型中共享的公共数据结构和计算方法都收集在这个库中。
</p>
</html>", revisions = "<html>
      <ul>
      <li>首次实现: <em>2000 年 7 月</em>
      由 Hubertus Tummescheit 实现，ThermoFluid Library 的 Jonas Eborn 和 Falko Jens Wagner 提供帮助
      </li>
      <li>代码重组织、增强文档、添加额外函数: <em>2002 年 12 月</em>
      由 Hubertus Tummescheit 实现，并移至 Modelica
                            properties library。</li>
      <li>包含到 Modelica.Media: 2003 年 9 月</li>
      </ul>

      <address>作者: Hubertus Tummescheit,<br>
      瑞典隆德大学<br>
      自动控制系<br>
      邮箱 118, 22100 隆德, 瑞典<br>
      电子邮件: hubertus@control.lth.se
      </address>
</html>"));
    package OneNonLinearEquation 
      "在可靠和高效的方式中确定一元非线性代数方程的解，无需导数"
      extends Modelica.Icons.Package;

      replaceable record f_nonlinear_Data 
        "函数 f_nonlinear 的特定数据"
        extends Modelica.Icons.Record;
        annotation();
      end f_nonlinear_Data;

      replaceable partial function f_nonlinear 
        "一元非线性代数方程：y = f_nonlinear(x,p,X)的解"
        extends Modelica.Icons.Function;
        input Real x "函数的自变量";
        input Real p = 0.0 "忽略的变量（这里始终用于压力）";
        input Real[:] X = fill(0, 0) 
          "忽略的变量（这里始终用于组分）";
        input f_nonlinear_Data f_nonlinear_data 
          "函数的额外数据";
        output Real y "= f_nonlinear(x)";
        annotation();
      end f_nonlinear;

      replaceable function solve 
        "解决 f_nonlinear(x_zero)=y_zero；f_nonlinear(x_min) - y_zero 和 f_nonlinear(x_max)-y_zero 必须具有不同的符号"
        import Modelica.Utilities.Streams.error;
        extends Modelica.Icons.Function;
        input Real y_zero 
          "确定 x_zero，使得 f_nonlinear(x_zero) = y_zero";
        input Real x_min "x 的最小值";
        input Real x_max "x 的最大值";
        input Real pressure = 0.0 
          "忽略的变量（这里始终用于压力）";
        input Real[:] X = fill(0, 0) 
          "忽略的变量（这里始终用于组分）";
        input f_nonlinear_Data f_nonlinear_data 
          "函数 f_nonlinear 的额外数据";
        input Real x_tol = 100 * Modelica.Constants.eps 
          "结果的相对容差";
        output Real x_zero "f_nonlinear(x_zero) = y_zero";
      protected
        constant Real eps = Modelica.Constants.eps "机械精度";
        constant Real x_eps = 1e-10 
          "对 x_min、x_max 进行轻微修改，因为 x_min、x_max 通常恰好在边界 T_min/h_min。小的数值噪声可能使区间无效";
        Real x_min2 = x_min - x_eps;
        Real x_max2 = x_max + x_eps;
        Real a = x_min2 "当前最佳最小区间值";
        Real b = x_max2 "当前最佳最大区间值";
        Real c "中间点 a <= c <= b";
        Real d;
        Real e "b - a";
        Real m;
        Real s;
        Real p;
        Real q;
        Real r;
        Real tol;
        Real fa "= f_nonlinear(a) - y_zero";
        Real fb "= f_nonlinear(b) - y_zero";
        Real fc;
        Boolean found = false;
        annotation();
      algorithm
        // 检查 f(x_min) 和 f(x_max) 是否有不同的符号
        fa := f_nonlinear(
          x_min2, 
          pressure, 
          X, 
          f_nonlinear_data) - y_zero;
        fb := f_nonlinear(
          x_max2, 
          pressure, 
          X, 
          f_nonlinear_data) - y_zero;
        fc := fb;
        if fa > 0.0 and fb > 0.0 or fa < 0.0 and fb < 0.0 then
          error(
            "OneNonLinearEquation.solve(..) 的参数 x_min 和 x_max\n" 
            + "不包围单个非线性方程的根:\n" + 
            "  x_min  = " + String(x_min2) + "\n" + "  x_max  = " + String(x_max2) 
            + "\n" + "  y_zero = " + String(y_zero) + "\n" + 
            "  fa = f(x_min) - y_zero = " + String(fa) + "\n" + 
            "  fb = f(x_max) - y_zero = " + String(fb) + "\n" + 
            "fa 和 fb 必须具有相反的符号，但实际上并非如此");
        end if;

        // 初始化变量
        c := a;
        fc := fa;
        e := b - a;
        d := e;

        // 搜索循环
        while not found loop
          if abs(fc) < abs(fb) then
            a := b;
            b := c;
            c := a;
            fa := fb;
            fb := fc;
            fc := fa;
          end if;

          tol := 2 * eps * abs(b) + x_tol;
          m := (c - b) / 2;

          if abs(m) <= tol or fb == 0.0 then
            // 找到根（区间足够小）
            found := true;
            x_zero := b;

          else
            // 确定是否需要二分法
            if abs(e) < tol or abs(fa) <= abs(fb) then
              e := m;
              d := e;
            else
              s := fb / fa;
              if a == c then
                // 线性插值
                p := 2 * m * s;
                q := 1 - s;
              else
                // 反二次插值
                q := fa / fc;
                r := fb / fc;
                p := s * (2 * m * q * (q - r) - (b - a) * (r - 1));
                q := (q - 1) * (r - 1) * (s - 1);
              end if;

              if p > 0 then
                q := -q;
              else
                p := -p;
              end if;

              s := e;
              e := d;
              if 2 * p < 3 * m * q - abs(tol * q) and p < abs(0.5 * s * q) then
                // 插值成功
                d := p / q;
              else
                // 使用二分法
                e := m;
                d := e;
              end if;
            end if;

            // 最佳猜测值定义为 "a"
            a := b;
            fa := fb;
            b := b + (if abs(d) > tol then d else if m > 0 then tol else -tol);
            fb := f_nonlinear(
              b, 
              pressure, 
              X, 
              f_nonlinear_data) - y_zero;

            if fb > 0 and fc > 0 or fb < 0 and fc < 0 then
              // 初始化变量
              c := a;
              fc := fa;
              e := b - a;
              d := e;
            end if;
          end if;
        end while;
      end solve;

      annotation(Documentation(info = "<html><p>
此函数目前应仅在 Modelica.Media 中使用，因为它可能会在将来被另一种方法替代， 其中工具负责解决非线性方程。
</p>
<p>
此库可以可靠地确定一个未知数 \"x\" 的一个非线性代数方程 \"y=f(x)\" 的解。作为输入，必须给出非线性函数的期望值 y，以及包含解的区间 x_min、x_max， 即 \"f(x_min) - y\" 和 \"f(x_max) - y\" 必须具有不同的符号。如果可能， 则通过反二次插值（通过最后3个点计算通过二次多项式的插值并计算零点）计算较小的区间。 如果这种方法失败，则使用二分法，它总是将区间减小一半。 反二次插值法具有超线性收敛性。这大致与全局收敛牛顿方法的收敛速度相同， 但无需计算非线性函数的导数。求解器函数是 Algol 60 程序\"zero\"到 Modelica 的直接映射，参考自：
</p>
<p>
Brent R.P.:
</p>
<p>
<strong>Algorithms for Minimization without derivatives</strong>.<br>Prentice Hall, 1973, pp. 58-59。
</p>
<p>
由于 Modelica 语言当前的限制（无法将函数引用传递给函数）， 因此使用此求解器对用户定义的函数进行构造有点复杂（此方法来自于Hans Olsson，Dassault Systèmes AB）。用户必须以以下方式提供一个库：
</p>
<pre><code >package MyNonLinearSolver
extends OneNonLinearEquation;

redeclare record extends Data
// 定义要传递给用户函数的数据
...
end Data;

redeclare function extends f_nonlinear
algorithm
// 计算非线性方程：y = f(x, Data)
end f_nonlinear;

// 当前 Dymola 必须存在的虚拟定义
redeclare function extends solve
end solve;
end MyNonLinearSolver;

x_zero = MyNonLinearSolver.solve(y_zero, x_min, x_max, data=data);
</code></pre><p>
<br>
</p>
<p>
<br>
</p>
</html>"));

    end OneNonLinearEquation;

  end Common;
  annotation(preferredView = "info", Documentation(info = "<html>
<p>
该库包含介质的<a href=\"modelica://Modelica.Media.Interfaces\" target=\"\">接口
</a>&nbsp;定义，以及以下单组分和多组分流体的属性模型，其中包括单相和多相流体：
</p>
<li>
<a href=\"modelica://Modelica.Media.IdealGases\" target=\"\">理想气体：</a>&nbsp;<br> 
1241个基于NASA Glenn系数的高精度气体模型，以及基于相同数据的理想气体混合物模型。</li>
<li>
<a href=\"modelica://Modelica.Media.Water\" target=\"\">水模型：</a>&nbsp;<br> 
常物性液态水，WaterIF97（根据IAPWS/IF97标准的高精度水模型）。</li>
<li>
<a href=\"modelica://Modelica.Media.Air\" target=\"\">空气模型：</a>&nbsp;<br> 
SimpleAir，DryAirNasa，ReferenceAir，MoistAir，ReferenceMoistAir。</li>
<li>
<a href=\"modelica://Modelica.Media.Incompressible\" target=\"\"> 不可压介质：</a>&nbsp;<br> 
基于表格的不可压缩流体模型（属性由表格rho(T)，HeatCapacity_cp(T)等定义）。</li>
<li>
<a href=\"modelica://Modelica.Media.CompressibleLiquids\" target=\"\"> 可压缩液体：</a>&nbsp;<br> 
具有线性压缩性的简单液体模型</li>
<li><a href=\"modelica://Modelica.Media.R134a\" target=\"\">四氟乙烷制冷剂（R134a）</a>&nbsp; </li>
<p>
以下部分在初次使用该库时很有用：
</p>
<li><a href=\"modelica://Modelica.Media.UsersGuide\" target=\"\">Modelica.Media.UsersGuide</a>&nbsp;。</li>
<li><a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage\" target=\"\">Modelica.Media.UsersGuide.MediumUsage</a>&nbsp;
描述了如何在组件模型中使用介质模型。</li>
<li><a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition\" target=\"\">Modelica.Media.UsersGuide.MediumDefinition</a>&nbsp; 
描述了如何定义新的流体介质模型。</li>
<li>
<a href=\"modelica://Modelica.Media.UsersGuide.ReleaseNotes\" target=\"\">Modelica.Media.UsersGuide.ReleaseNotes</a>&nbsp;
总结了库发布的更改。</li>
<li><a href=\"modelica://Modelica.Media.Examples\" target=\"\">Modelica.Media.Examples</a>&nbsp; 
包含演示该库用法的示例。</li>
<p>
版权所有 &copy; 1998-2020，Modelica Association和贡献者
</p>
</html>", revisions = "<html>
<ul>
<li><em>2017年2月1日</em>由Thomas Beutlich修正：<br>
修正了一些理想气体（CH2，CH3，CH3OOH，C2CL2，C2CL4，C2CL6，C2HCL，C2HCL3，CH2CO_ketene，O_CH_2O，HO_CO_2OH，CH2BrminusCOOH，C2H3CL，CH2CLminusCOOH，HO2，HO2minus，OD，ODminus）NASA Glenn系数的数据错误，参见<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1922\">#1922</a></li>
<li><em>2013年5月16日</em>由Stefan Wischhusen（XRG Simulation）添加：<br>
添加了新的介质模型Air.ReferenceMoistAir，Air.ReferenceAir，R134a。</li>
<li><em>2011年5月25日</em>由Francesco Casella添加：<br>为Water，TableBased，MixtureGasNasa，SimpleAir和MoistAir本地类型添加了min/max属性。</li>
<li><em>2011年5月25日</em>由Stefan Wischhusen添加：<br>添加了属性多项式拟合的个别设置。</li>
</ul>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), 
    graphics = {
    Line(
    points = {{-76, -80}, {-62, -30}, {-32, 40}, {4, 66}, {48, 66}, {73, 45}, {62, -8}, {48, -50}, {38, -80}}, 
    color = {64, 64, 64}, 
    smooth = Smooth.Bezier), 
    Line(
    points = {{-40, 20}, {68, 20}}, 
    color = {175, 175, 175}), 
    Line(
    points = {{-40, 20}, {-44, 88}, {-44, 88}}, 
    color = {175, 175, 175}), 
    Line(
    points = {{68, 20}, {86, -58}}, 
    color = {175, 175, 175}), 
    Line(
    points = {{-60, -28}, {56, -28}}, 
    color = {175, 175, 175}), 
    Line(
    points = {{-60, -28}, {-74, 84}, {-74, 84}}, 
    color = {175, 175, 175}), 
    Line(
    points = {{56, -28}, {70, -80}}, 
    color = {175, 175, 175}), 
    Line(
    points = {{-76, -80}, {38, -80}}, 
    color = {175, 175, 175}), 
    Line(
    points = {{-76, -80}, {-94, -16}, {-94, -16}}, 
    color = {175, 175, 175})}));
end Media;