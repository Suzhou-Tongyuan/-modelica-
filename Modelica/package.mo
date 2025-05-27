package Modelica "Modelica标准库-Version4.0.0.TY.1.Beta-中文试用版"
  extends Modelica.Icons.Package;
  package UsersGuide "用户指南"
    extends Modelica.Icons.Information;

    class Overview "Modelica库概述"
      extends Modelica.Icons.Information;

      annotation(Documentation(info = "<html> 
<p>
Modelica标准库由以下主要子模型库组成：
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>库组件</th> <th>描述</th></tr>

<tr><td>
 <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Lib-Electrical.png\">
 </td>
 <td>
 <a href=\"modelica://Modelica.Electrical.Analog\">Analog</a><br>
模拟电气和电子元件，如电阻、电容、变压器、二极管、晶体管、传输线，开关，电源，传感器。
 </td>
</tr>

<tr><td>
 <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Lib-Digital.png\">
 </td>
 <td>
 <a href=\"modelica://Modelica.Electrical.Digital\">Digital</a><br>
 基于VHDL标准的数字电气组件，如具有9值逻辑的基本逻辑块、延迟、门电路、源、以及2值、3值、4值和9值逻辑之间的转换器。
 </td>
</tr>

<tr><td>
 <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Lib-Machines.png\">
 </td>
 <td>
 <a href=\"modelica://Modelica.Electrical.Machines\">Machines</a><br>
 电气异步、同步和直流电机(电机和发电机)以及三相变压器。
 </td>
</tr>

<tr><td>
 <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Lib-FluxTubes.png\">
 </td>
 <td>
 <a href=\"modelica://Modelica.Magnetic.FluxTubes\">FluxTubes</a><br>
 基于磁通管概念，特别用于建模电磁驱动器。非线性形状、力、泄漏和材料模型。包括钢、电工钢、纯铁、钴铁、镍铁、钕铁硼、钐钴合金等材料的数据。
 </td>
</tr>

<tr><td>
 <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Lib-Translational.png\">
 </td>
 <td>
 <a href=\"modelica://Modelica.Mechanics.Translational\">Translational</a><br>
 一维平动机械系统，例如：滑动质量、带止动质量、弹簧、阻尼器。
 </td>
</tr>

<tr><td>
 <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Lib-Rotational.png\">
 </td>
 <td>
 <a href=\"modelica://Modelica.Mechanics.Rotational\">Rotational</a><br>
  一维转动机械系统，如惯性、齿轮、行星齿轮，方便的定义速度/扭矩依赖的摩擦(离合器、刹车、轴承、……)
 </td>
</tr>

<tr><td width=\"100\">
 <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Lib-MultiBody1.png\"><br>
 <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Lib-MultiBody2.png\">
 </td>
 <td>
 <a href=\"modelica://Modelica.Mechanics.MultiBody\">MultiBody</a>
由关节、体、力和传感器组件组成的三维机械系统。关节可以通过一维转动机械系统库(Rotational)定义的传动系来驱动。
 每个组件都有一个默认的动画。
 组件可以任意连接在一起。
 </td>
</tr>

<tr><td>
 <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Lib-Fluid.png\">
 </td>
 <td>
 <a href=\"modelica://Modelica.Fluid\">Fluid</a><br>
 一维热流体在容器、管道、流体机械、阀门及配件。所有介质来自Modelica.Media库。可以使用介质库(不可压缩或可压缩)，
单一或多种物质，单相或两相介质)。
 </td>
</tr>

<tr><td>
 <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Lib-Media.png\">
 </td>
 <td>
 <a href=\"modelica://Modelica.Media\">Media</a><br>
 提供大规模介质库，包含用于计算介质属性的模型和函数，如h = h(p,T)、d = d(p,T)，
 适用于以下介质：
 <ul>
 <li>1240种气体及其混合物。</li>
 <li>不可压缩的基于表格的液体(h = h(T)等)。</li>
 <li>可压缩液体。</li>
 <li>干空气和湿空气。</li>
 <li>高精度水模型（IF97）。</li>
 </ul>
 </td>
</tr>

<tr><td>
 <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Lib-Thermal.png\">
 </td>
 <td>
 <a href=\"modelica://Modelica.Thermal.FluidHeatFlow\">FluidHeatFlow</a>,
 <a href=\"modelica://Modelica.Thermal.HeatTransfer\">HeatTransfer</a>
  简单的热流体管道流动，特别用于模拟机器的冷却
 与空气或水(管道，泵，阀门，环境，传感器，源)和
 热电容器、热导体、对流、
人体辐射源和传感器。
 </td>
</tr>

<tr><td>
 <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Lib-Blocks1.png\"><br>
 <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Lib-Blocks2.png\">
 </td>
 <td>
 <a href=\"modelica://Modelica.Blocks\">Blocks</a><br>
 输入/输出块用于建模框图和逻辑网络，例如:
 积分，PI，PID，传递函数，线性状态空间系统，
 采样器，单位延迟，离散传递函数，和/或块，
 定时器，迟滞，非线性和路由块，源，表.
 </td>
</tr>

<tr><td>
 <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Lib-Clocked.png\">
 </td>
 <td>
 <a href=\"modelica://Modelica.Clocked\">Clocked</a><br>
  用于精确定义和同步具有不同采样率的采样数据系统的模块。
  连续时间方程可以自动离散化并用于采样数据系统。
  该库基于Modelica 3.3中引入的时钟同步语言元素。
 </td>
</tr>

<tr><td>
 <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Lib-StateGraph.png\">
 </td>
 <td>
 <a href=\"modelica://Modelica.StateGraph\">StateGraph</a><br>
 层次化状态机，具有与Statecharts相似的建模能力。
Modelica作为同步动作语言使用，即保证确定性行为
 </td>
</tr>

<tr><td>
 <blockquote><pre>
A = [1,2,3;
     3,4,5;
     2,1,4];
b = {10,22,12};
x = Matrices.solve(A,b);
Matrices.eigenValues(A);
 </pre></blockquote>
 </td>
 <td>
 <a href=\"modelica://Modelica.Math\">Math</a>,
 <a href=\"modelica://Modelica.Utilities\">Utilities</a><br>
 对向量和矩阵进行操作的函数，例如用于求解线性系统，特征值和奇异值等；
 对字符串、流、文件进行操作的函数，例如：复制和删除文件或对字符串向量进行排序。
 </td>
</tr>

</table>
</html>"                ));
    end Overview;

    class Connectors "连接器"
      extends Modelica.Icons.Information;

      annotation(Documentation(info = "<html><p>
<span style=\"color: rgb(51, 51, 51);\">Modelica标准库定义了各个领域中最重要的基本连接器。如果可能，用户应该使用这些连接器，以便Modelica标准库中的组件与其他库中的组件可以无障碍地组合。以下是定义的基本连接器（势变量、流变量和stream变量的含义在下面的“连接器方程”部分中解释）：</span>
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"1\">
<tr><td><strong>domain</strong></td>
   <td><strong>potential<br>variables</strong></td>
   <td><strong>flow<br>variables</strong></td>
   <td><strong>stream<br>variables</strong></td>
   <td><strong>连接器定义</strong></td>
   <td><strong>图标</strong></td></tr>

<tr><td><strong>electrical<br>analog</strong></td>
   <td>electrical potential</td>
   <td>electrical current</td>
   <td></td>
   <td><a href=\"modelica://Modelica.Electrical.Analog.Interfaces\">Modelica.Electrical.Analog.Interfaces</a>
     <br>Pin, PositivePin, NegativePin</td>
   <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/ElectricalPins.png\"></td></tr>

<tr><td><strong>electrical<br>polyphase</strong></td>
   <td colspan=\"3\">vector of electrical pins</td>
   <td><a href=\"modelica://Modelica.Electrical.Polyphase.Interfaces\">Modelica.Electrical.Polyphase.Interfaces</a>
     <br>Plug, PositivePlug, NegativePlug</td>
   <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/ElectricalPlugs.png\"></td></tr>

<tr><td><strong>electrical<br>space phasor</strong></td>
   <td>2 electrical potentials</td>
   <td>2 electrical currents</td>
   <td></td>
   <td><a href=\"modelica://Modelica.Electrical.Machines.Interfaces\">Modelica.Electrical.Machines.Interfaces</a>
     <br>SpacePhasor</td>
   <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/SpacePhasor.png\"></td></tr>

<tr><td><strong>quasi-static<br>single-phase</strong></td>
   <td>complex electrical potential</td>
   <td>complex electrical current</td>
   <td></td>
   <td><a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces\">
                                       Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces</a>
     <br>Pin, PositivePin, NegativePin</td>
   <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/QuasiStaticSinglePhasePins.png\"></td></tr>

<tr><td><strong>quasi-static<br>polyphase</strong></td>
   <td colspan=\"3\">vector of quasi-static single-phase pins</td>
   <td><a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces\">Modelica.Electrical.QuasiStatic.Polyphase.Interfaces</a>
     <br>Plug, PositivePlug, NegativePlug</td>
   <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/QuasiStaticPolyphasePlugs.png\"></td></tr>

<tr><td><strong>electrical<br>digital</strong></td>
   <td>Integer (1..9)</td>
   <td></td>
   <td></td>
   <td><a href=\"modelica://Modelica.Electrical.Digital.Interfaces\">Modelica.Electrical.Digital.Interfaces</a>
     <br>DigitalSignal, DigitalInput, DigitalOutput</td>
   <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Digital.png\"></td></tr>

<tr><td><strong>magnetic<br>flux tubes</strong></td>
   <td>magnetic potential</td>
   <td>magnetic flux</td>
   <td></td>
   <td>
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Interfaces\">Modelica.Magnetic.FluxTubes.Interfaces</a>
     <br>MagneticPort, PositiveMagneticPort,<br>NegativeMagneticPort</td>
   <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/MagneticPorts.png\"></td></tr>

<tr><td><strong>magnetic<br>fundamental<br>wave</strong></td>
   <td>complex magnetic potential</td>
   <td>complex magnetic flux</td>
   <td></td>
   <td>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces\">Modelica.Magnetic.FundamentalWave.Interfaces</a>
     <br>MagneticPort, PositiveMagneticPort,<br>NegativeMagneticPort</td>
   <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/FundamentalWavePorts.png\"></td></tr>

<tr><td><strong>translational</strong></td>
   <td>distance</td>
   <td>cut-force</td>
   <td></td>
   <td><a href=\"modelica://Modelica.Mechanics.Translational.Interfaces\">Modelica.Mechanics.Translational.Interfaces</a>
     <br>Flange_a, Flange_b</td>
   <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/TranslationalFlanges.png\"></td></tr>

<tr><td><strong>rotational</strong></td>
   <td>angle</td>
   <td>cut-torque</td>
   <td></td>
   <td><a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces\">Modelica.Mechanics.Rotational.Interfaces</a>
     <br>Flange_a, Flange_b</td>
   <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/RotationalFlanges.png\"></td></tr>

<tr><td><strong>3-dim.<br>mechanics</strong></td>
   <td>position vector<br>
    orientation object</td>
   <td>cut-force vector<br>
    cut-torque vector</td>
   <td></td>
   <td><a href=\"modelica://Modelica.Mechanics.MultiBody.Interfaces\">Modelica.Mechanics.MultiBody.Interfaces</a>
     <br>Frame, Frame_a, Frame_b, Frame_resolve</td>
   <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/MultiBodyFrames.png\"></td></tr>

<tr><td><strong>simple<br>fluid flow</strong></td>
   <td>pressure<br>
    specific enthalpy</td>
   <td>mass flow rate<br>
    enthalpy flow rate</td>
   <td></td>
   <td><a href=\"modelica://Modelica.Thermal.FluidHeatFlow.Interfaces\">Modelica.Thermal.FluidHeatFlow.Interfaces</a>
     <br>FlowPort, FlowPort_a, FlowPort_b</td>
   <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/FluidHeatFlowPorts.png\"></td></tr>

<tr><td><strong>thermo<br>fluid flow</strong></td>
   <td>pressure</td>
   <td>mass flow rate</td>
   <td>specific enthalpy<br>mass fractions</td>
   <td>
<a href=\"modelica://Modelica.Fluid.Interfaces\">Modelica.Fluid.Interfaces</a>
     <br>FluidPort, FluidPort_a, FluidPort_b</td>
   <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/FluidPorts.png\"></td></tr>

<tr><td><strong>heat<br>transfer</strong></td>
   <td>temperature</td>
   <td>heat flow rate</td>
   <td></td>
   <td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Interfaces\">Modelica.Thermal.HeatTransfer.Interfaces</a>
     <br>HeatPort, HeatPort_a, HeatPort_b</td>
   <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/ThermalHeatPorts.png\"></td></tr>

<tr><td><strong>blocks</strong></td>
   <td>
    Real variable<br>
    Integer variable<br>
    Boolean variable</td>
   <td></td>
   <td></td>
   <td><a href=\"modelica://Modelica.Blocks.Interfaces\">Modelica.Blocks.Interfaces</a>
     <br>
      RealSignal, RealInput, RealOutput<br>
      IntegerSignal, IntegerInput, IntegerOutput<br>
      BooleanSignal, BooleanInput, BooleanOutput</td>
   <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Signals.png\"></td></tr>

<tr><td><strong>complex<br>blocks</strong></td>
   <td>
    Complex variable</td>
   <td></td>
   <td></td>
   <td><a href=\"modelica://Modelica.ComplexBlocks.Interfaces\">Modelica.ComplexBlocks.Interfaces</a>
     <br>ComplexSignal, ComplexInput, ComplexOutput</td>
   <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/ComplexSignals.png\"></td></tr>

<tr><td><strong>state<br>machine</strong></td>
   <td>Boolean variables<br>
    (occupied, set,<br>
     available, reset)</td>
   <td></td>
   <td></td>
   <td><a href=\"modelica://Modelica.StateGraph.Interfaces\">Modelica.StateGraph.Interfaces</a>
     <br>Step_in, Step_out, Transition_in, Transition_out</td>
   <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/StateGraphPorts.png\"></td></tr>
</table>
<p>

在所有领域中，通常定义2个连接器。变量声明是<strong>相同的</strong>，只是图标不同，<span style=\"color: rgb(51, 51, 51);\">以便于区分附加在同一组件上的属于同一领域的连接器</span>。
</p>
<h4>分层的连接器 </h4><p>
<span style=\"color: rgb(51, 51, 51);\">Modelica 还支持层次化连接器，类似于层次化模型。因此，例如，可以将基本连接器聚集在一起。例如，一个由两个电气插脚组成的电气插头可以被定义为：</span>:
</p>
<p>
<br>
</p>
<pre><code >connector Plug
   import Modelica.Electrical.Analog.Interfaces;
   Interfaces.PositivePin phase;
   Interfaces.NegativePin ground;
end Plug;
</code></pre><p>
<br>
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">通过一个 connect(..) 方程，可以连接两个插头（因此也隐式地连接相位和接地引脚），或者将一个引脚连接器直接连接到插头连接器的相位或接地部分，例如 \"connect(resistor.p, plug.phase)\"。</span>
</p>
<h4>连接器方程</h4><p>
上述列出的连接器变量基本上是通过以下策略确定的：
</p>
<ol><li>
陈述特定物理领域体积的相关平衡方程和边界条件。</li>
<li>
通过取无穷小体积的极限（例如，热领域：温度相同，热流率总和为零）简化第（1）步中的平衡方程和边界条件。</li>
<li>
在连接器中使用第（2）步平衡方程和边界条件所需的变量，并选择适当的Modelica<strong>前缀</strong>，以便这些方程通过Modelica连接语义生成。</li>
</ol><p>
通过一个例子说明Modelica连接语义：三个连接器c1、c2、c3的定义
</p>
<p>
<br>
</p>
<pre><code >connector Demo
  Real        p;  // potential variable
  flow   Real f;  // flow variable
  stream Real s;  // stream variable
end Demo;
</code></pre><p>
<br>
</p>
<p>
连接在一起
</p>
<p>
<br>
</p>
<pre><code >connect(c1,c2);
connect(c1,c3);
</code></pre><p>
<br>
</p>
<p>
则可得出以下方程:
</p>
<p>
<br>
</p>
<pre><code >// 势变量(potential variables)相等
c1.p = c2.p;
c1.p = c3.p;

// 流变量(flow variables)之和为零
0 = c1.f + c2.f + c3.f;

/* 流变量(flow variables)和上游流变量(stream variables)的乘积之和为零
(该隐式方程组在生成代码时显式求解;
\"&lt;undefined&gt;\"部分的定义方式如下，inStream(..)是连续的)。
*/
0 = c1.f*(if c1.f &gt; 0 then s_mix else c1.s) +
    c2.f*(if c2.f &gt; 0 then s_mix else c2.s) +
    c3.f*(if c3.f &gt; 0 then s_mix else c3.s);

inStream(c1.s) = if c1.f &gt; 0 then s_mix else &lt;undefined&gt;;
inStream(c2.s) = if c2.f &gt; 0 then s_mix else &lt;undefined&gt;;
inStream(c3.s) = if c3.f &gt; 0 then s_mix else &lt;undefined&gt;;
</code></pre><p>
<br>
</p>
</html>"            ));
    end Connectors;

    package Conventions "约定"
      extends Modelica.Icons.Information;
      package Documentation "HTML文档"
        extends Modelica.Icons.Information;

        package Format "格式"
          extends Modelica.Icons.Information;

          class Cases "案例"
            extends Modelica.Icons.Information;
            annotation(Documentation(info = "<html><p>
在Modelica文档中，有时必须区分不同的情况。如果大小写区分涉及Modelica参数或变量(布尔表达式)，则应在<code>&lt;code&gt;</code>和<code>&lt;/code&gt;内按照Modelica代码的风格进行比较;</code>
</p>
<h4>示例</h4><h5>示例 1</h5><p>
<code>&lt;p&gt;If &lt;code&gt;useCage == true&lt;/code&gt;, a damper cage is considered in the model...&lt;/p&gt;</code>
</p>
<p>
显示为
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">如果 </span><code>useCage == true</code><span style=\"color: rgb(51, 51, 51);\">，则模型中考虑了阻尼笼。在这种情况下，必须指定笼的参数。</span>
</p>
<p>
对于更复杂的情况，应该使用无序列表。在这种情况下，只有Modelica特定的代码段和布尔表达式.
</p>
<h5>示例 2</h5><p>
<br>
</p>
<pre><code >&lt;ul&gt;
&lt;li&gt; If &lt;code&gt;useCage == true&lt;/code&gt;, a damper cage is considered in the model.
Cage parameters must be specified in this case.&lt;/li&gt;
&lt;li&gt; If &lt;code&gt;useCage == false&lt;/code&gt;, the damper cage is omitted.&lt;/li&gt;
&lt;/ul&gt;
</code></pre><p>
<br>
</p>
<p>
显示为
</p>
<li>
如果<code>useCage == true</code>，则在模型中考虑阻尼笼。 在这种情况下，必须指定保持架参数.</li>
<li>
如果<code>useCage == false</code>，则省略阻尼笼.</li>
<p>
在更面向方程的情况下，可以添加额外的方程或代码段.
</p>
<h5>示例 3</h5><p>
<br>
</p>
<pre><code >&lt;ul&gt;
&lt;li&gt;if &lt;code&gt;usePolar == true&lt;/code&gt;, assign magnitude and angle to output &lt;br&gt;
&lt;!-- insert graphical representation of equations --&gt;
y[i,1] = sqrt( a[i]^2 + b[i]^2 ) &lt;br&gt;
y[i,2] = atan2( b[i], a[i] )
&lt;/li&gt;
&lt;li&gt;if &lt;code&gt;usePolar == false&lt;/code&gt;, assign cosine and sine to output &lt;br&gt;
&lt;!-- insert graphical representation of equations --&gt;
y[i,1] = a[i] &lt;br&gt;
y[i,2] = b[i]
&lt;/li&gt;
&lt;/ul&gt;
</code></pre><p>
<br>
</p>
<p>
显示为
</p>
<li>
如果<code>usePolar == true</code>，则指定输出的幅度和角度<br> <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Documentation/Format/Cases/y_i1_polar.png\" alt=\"y[i,1] = sqrt( a[i]^2 + b[i]^2 )\" data-href=\"\" style=\"\"/><br> <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Documentation/Format/Cases/y_i2_polar.png\" alt=\"y[i,2] = atan2( b[i], a[i] )\" data-href=\"\" style=\"\"/></li>
<li>
如果<code>usePolar == false</code>，将余弦和正弦赋值到输出<br> <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Documentation/Format/Cases/y_i1_rect.png\" alt=\"y[i,1] = a[i]\" data-href=\"\" style=\"\"/><br> <img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Documentation/Format/Cases/y_i2_rect.png\" alt=\" y[i,2] = b[i]\" data-href=\"\" style=\"\"/></li>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"                ));
          end Cases;

          class Code "代码"
            extends Modelica.Icons.Information;

            annotation(Documentation(info = "<html>
<p>
<a href=\"modelica://Modelica.UsersGuide.Conventions.ModelicaCode\">Modelica code</a> 类和实例名的约定;
参数和变量是分开指定的。在本节中总结了如何参考
HTML文档中的Modelica代码。
</p>

<ol>
<li> 对于代码段中的常量、参数和变量<code>&lt;code&gt;</code>
和<code>&lt;/code&gt;</code>应该使用，例如，<br>
<code><strong>parameter</strong> Modelica.Units.SI.Time tStart &quot;Start time&quot;</code></li>
<li> 编写多行或单行代码段作为引用的预格式化文本，即嵌入在
<code>&lt;blockquote&gt;&lt;pre&gt;</code>和<code>&lt;/pre&gt;&lt;/blockquote&gt;</code>标签.</li>
<li> 多行或单行代码不得额外缩进.</li>
<li> 内联代码段可以用<code>&lt;code&gt;</code>和<code>&lt;/code&gt;</code>进行排版.</li>
<li> 在代码段中，使用粗体强调Modelica关键字.</li>
</ol>

<h4>示例</h4>

<h5>示例 1</h5>

<blockquote><pre>
&lt;blockquote&gt;&lt;pre&gt;
&lt;strong&gt;connector&lt;/strong&gt; Frame
...
&lt;strong&gt;flow&lt;/strong&gt; SI.Force f[3] &lt;strong&gt;annotation&lt;/strong&gt;(unassignedMessage=&quot;...&quot;);
&lt;strong&gt;end&lt;/strong&gt; Frame;
&lt;/pre&gt;&lt;/blockquote&gt;
</pre></blockquote>

<p>显示为</p>

<blockquote><pre>
<strong>connector</strong> Frame
...
<strong>flow</strong> SI.Force f[3] <strong>annotation</strong>(unassignedMessage=&quot;...&quot;);
<strong>end</strong> Frame;
</pre></blockquote>

<h5>示例 2</h5>

<blockquote><pre>
&lt;blockquote&gt;&lt;pre&gt;
&lt;strong&gt;parameter&lt;/strong&gt; Modelica.Units.SI.Conductance G=1 &quot;Conductance&quot;;
&lt;/pre&gt;&lt;/blockquote&gt;
</pre></blockquote>

<p>显示为</p>

<blockquote><pre>
<strong>parameter</strong> Modelica.Units.SI.Conductance G=1 &quot;Conductance&quot;;
</pre></blockquote>
</html>"                          ));
          end Code;

          class Equations "方程"
            extends Modelica.Icons.Information;

            annotation(Documentation(info = "<html>

<p>
在<a href=\"http://www.w3c.org/\">HTML</a>文档的上下文中
方程式应该有PNG格式的图形表示。为了这个目的，工具
可以使用特定的数学类型功能。或者是LaTeX到HTML的转换器
<a href=\"http://www.latex2html.org\">LaTeX2HTML</a>，或
<a href=\"http://www.homeschoolmath.net/worksheets/equation_editor.php\">Online Equation Editor</a>
或者可以使用<a href=\"http://www.codecogs.com/latex/eqneditor.php\">codecogs</a>.
</p>

<p>
一个典型的方程，例如，傅里叶合成，可能是这样的<br>
<img
src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Documentation/Format/Equations/fourier.png\"><br>
或<br>
<img
src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Documentation/Format/Equations/sample.png\"
alt=\"y=a_1+a_2\"><br>
在<code>alt</code>标签中，应该存储原始方程，例如:,</p>
<blockquote><pre>
&lt;img
&nbsp;src=&quot;modelica://Modelica/Resources/Images/UsersGuide/Conventions/Documentation/Format/Equations/sample.png&quot;
&nbsp;alt=&quot;y=a_1+a_2&quot;&gt;
</pre></blockquote>

<p>
如果要在文档文本中引用特定的变量和参数，可以使用
图形表示(PNG文件)或斜体字体用于常规物理符号和小写字母
<a href=\"http://www.w3.org/TR/html4/sgml/entities.html\">Greek letters</a>
应该使用。完整的单词变量和完整的单词索引应该在里面拼写
<code>&lt;code&gt;</code>和<code>&lt;/code&gt;</code>。
类型将向量和数组下标设置为下标
<code>&lt;sub&gt;</code>和<code>&lt;/sub&gt;</code>标记。
</p>

<p> 这些变量和参数的例子如下:
<em>&phi;</em>, <em>&phi;</em><sub>ref</sub>, <em>v<sub>2</sub></em>, <code>useDamperCage</code>.
</p>

<h4>编号的方程</h4>

<p>对于编号方程，应该使用带有两列的单行表。方程号应放在右边一栏:</p>

<blockquote><pre>
&lt;table border=&quot;0&quot; cellspacing=&quot;10&quot; cellpadding=&quot;2&quot;&gt;
&lt;tr&gt;
&lt;td&gt;&lt;img
src=&quot;modelica://Modelica/Resources/Images/UsersGuide/Conventions/Documentation/Format/Equations/sample.png&quot;
alt=&quot;y=a_1+a_2&quot;&gt; &lt;/td&gt;
&lt;td&gt;(1)&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
</pre></blockquote>

<p>显示为:</p>

<table border=\"0\" cellspacing=\"10\" cellpadding=\"2\">
<tr>
<td><img
src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Documentation/Format/Equations/sample.png\"
alt=\"y=a_1+a_2\"></td>
<td>(1)</td>
</tr>
</table>

</html>"      ));
          end Equations;

          class Figures "图片"
            extends Modelica.Icons.Information;

            annotation(Documentation(info = "<html>
<p>
图形应特别用于示例，以讨论各自模型的问题和结果。库的开发者仍然鼓励在其他组件的文档中添加图形，以帮助用户理解该库。
</p>

<ol>
<li> 图形必须放置在段落<strong>之外</strong>，以符合HTML规范。</li>
<li> 图形必须<strong>至少</strong>定义<code>src</code>和<code>alt</code>属性，以符合HTML规范。</li>
<li> 技术图形应放置在表格环境中。每个技术图形还应有一个标题。图形标题应以大写字母开头。</li>
<li> 插图可以在没有表格环境的情况下嵌入。</li>
</ol>

<h4>文件的位置</h4>
<p>
<code>PNG</code>文件应该放置在一个文件夹中，该文件夹的结构应与包结构完全一致。
</p>

<h4>示例</h4>

<h5>示例1</h5>

<p>这个示例展示了如何将插图嵌入到
<a href=\"modelica://Modelica.Blocks\">Blocks</a> 包的示例<a href=\"modelica://Modelica.Blocks.Examples.PID_Controller\">PID_Controller</a>中。
</p>

<blockquote><pre>
&lt;img src=&quot;modelica://Modelica/Resources/Images/Blocks/PID_controller.png&quot;
     alt=&quot;PID_controller.png&quot;&gt;
</pre></blockquote>

<h5>示例2</h5>
<p>
这是一个带有图注的技术图形的简单示例。
</p>

<blockquote><pre>
&lt;table border=&quot;0&quot; cellspacing=&quot;0&quot; cellpadding=&quot;2&quot;&gt;
  &lt;caption align=&quot;bottom&quot;&gt;Caption starts with a capital letter&lt;/caption&gt;
  &lt;tr&gt;
    &lt;td&gt;
      &lt;img src=&quot;modelica://Modelica/Resources/Images/Blocks/PID_controller.png&quot;
           alt=&quot;PID_controller.png&quot;&gt;
    &lt;/td&gt;
  &lt;/tr&gt;
&lt;/table&gt;
</pre></blockquote>

<h5>示例3</h5>
<p>
要引用某个图形时，可以添加图形编号。
在这种情况下，图形名称(Fig.)以及图形编号(1, 2, ...)必须使用<code>&lt;strong&gt;</code>和<code>&lt;/strong&gt;</code>标签加粗显示。
</p>
<p>
图形名称和编号应如下所示：<strong>Fig. 1:</strong>
</p>
<p>
图形编号需要手动编号。
</p>

<blockquote><pre>
&lt;table border=&quot;0&quot; cellspacing=&quot;0&quot; cellpadding=&quot;2&quot;&gt;
  &lt;caption align=&quot;bottom&quot;&gt;&lt;strong&gt;Fig. 2:&lt;/strong&gt; Caption starts with a capital letter&lt;/caption&gt;
  &lt;tr&gt;
    &lt;td&gt;
      &lt;img src=&quot;modelica://Modelica/Resources/Images/Blocks/PID_controller.png&quot;
           alt=&quot;PID_controller.png&quot;&gt;
    &lt;/td&gt;
  &lt;/tr&gt;
&lt;/table&gt;
</pre></blockquote>

</html>"                    ));
          end Figures;

          class Hyperlinks "超链接"
            extends Modelica.Icons.Information;

            annotation(Documentation(info = "<html><ol><li>
在引用组件或包时，应始终使用超链接.</li>
<li>
在<code>&lt;a href=\"…\"&gt;</code>和<code>&lt;/a&gt;</code>之间的超链接文本应该包含完整的主包名称.</li>
<li>
指向外部组件的链接应该包含它所引用的包的全名.</li>
<li>
Modelica超链接必须使用该方案 <code>\"modelica://...\"</code></li>
<li>
有关引用Modelica组件的超链接，请参见示例1和2.</li>
<li>
不允许链接到商业网站.</li>
</ol><h4>示例</h4><h5>示例1</h5><p>
<br>
</p>
<pre><code >&lt;a href=\"modelica://Modelica.Mechanics.MultiBody.UsersGuide.Tutorial.LoopStructures.PlanarLoops\"&gt;
Modelica.Mechanics.MultiBody.UsersGuide.Tutorial.LoopStructures.PlanarLoops&lt;/a&gt;
</code></pre><p>
<br>
</p>
<p>
显示为<a href=\"modelica://Modelica.Mechanics.MultiBody.UsersGuide.Tutorial.LoopStructures.PlanarLoops\" target=\"\"><br>Modelica.Mechanics.MultiBody.UsersGuide.Tutorial.LoopStructures.PlanarLoops</a>&nbsp;
</p>
<h5>示例2</h5><p>
<br>
</p>
<pre><code >&lt;p&gt;
The feeder cables are connected to an
&lt;a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.InductionMachines.IM_SquirrelCage\"&gt;
induction machine&lt;/a&gt;.
&lt;/p&gt;
</code></pre><p>
<br>
</p>
<p>
显示为
</p>
<p>
<span style=\"color: rgb(51, 51, 51); background-color: rgb(245, 246, 248);\">供电电缆连接</span>到一个 <a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.InductionMachines.IM_SquirrelCage\" target=\"\"> induction machine</a>&nbsp;.
</p>
<p>
<br>
</p>
</html>"                ));
          end Hyperlinks;

          class Lists "列表"
            extends Modelica.Icons.Information;

            annotation(Documentation(info = "<html><ol><li>
列表必须放在<strong>段落的</strong>之外以符合HTML标准.</li>
<li>
<span style=\"color: rgb(51, 51, 51);\">列表中的项目应以……开始</span></li>
</ol><h4>示例</h4><h5>示例1</h5><p>
这是一个简单的枚举(有序)列表示例
</p>
<p>
<br>
</p>
<pre><code >&lt;ol&gt;
&lt;li&gt;item 1&lt;/li&gt;
&lt;li&gt;item 2&lt;/li&gt;
&lt;/ol&gt;
</code></pre><p>
<br>
</p>
<p>
显示为
</p>
<ol><li>
项目1</li>
<li>
项目2</li>
</ol><h5>示例2</h5><p>
这是一个简单的无编号列表的例子。
</p>
<p>
<br>
</p>
<pre><code >&lt;ul&gt;
&lt;li&gt;item 1&lt;/li&gt;
&lt;li&gt;item 2&lt;/li&gt;
&lt;/ul&gt;
</code></pre><p>
<br>
</p>
<p>
显示为
</p>
<li>
项目1</li>
<li>
项目2</li>
<p>
<br>
</p>
</html>"                ));
          end Lists;

          class References "参考资料"
            extends Modelica.Icons.Information;

            annotation(Documentation(info = "<html>
<ol>
<li> 通过超链接查阅文献[1]，[androov1973]等，并在参考文献小节中总结文献
<a href=\"modelica://Modelica.UsersGuide.Conventions.UsersGuide.References\">Conventions.UsersGuide.References</a>.</li>
<li> 每个参考文献必须至少有一次引用.</li>
</ol>

<h4>示例</h4>

<h5>示例1</h5>

<blockquote><pre>
&lt;p&gt;
More details about electric machine modeling
can be found in [&lt;a href=&quot;modelica://Modelica.UsersGuide.Conventions.UsersGuide.References&quot;&gt;Gao2008&lt;/a&gt;]
and
[&lt;a href=&quot;modelica://Modelica.UsersGuide.Conventions.UsersGuide.References&quot;&gt;Kral2018&lt;/a&gt;, p. 149].
&lt;/p&gt;
</pre></blockquote>
<p>显示为</p>
<p>
更多关于电机建模的细节可以在 [<a href=\"modelica://Modelica.UsersGuide.Conventions.UsersGuide.References\">Gao2008</a>]
和[<a href=\"modelica://Modelica.UsersGuide.Conventions.UsersGuide.References\">Kral2018</a>, p. 149]中查找。
</p>
</html>"                ));
          end References;

          class Tables "表格"
            extends Modelica.Icons.Information;

            annotation(Documentation(info = "<html>
<ol>
<li> 表应该总是用<code>&lt;table&gt;</code>和<code>&lt;/table&gt;</code>来排版。
而不是<code>&lt;pre&gt;</code>和<code>&lt;/pre&gt;</code>.</li>
<li> 表格必须放在<strong>段落的</strong>之外，以符合HTML标准.</li>
<li> 每个表必须有一个表标题.</li>
<li> 表头和条目以大写字母开头.</li>
</ol>

<h4>示例</h4>

<h5>示例1</h5>

<p>这是一个简单的表示例。</p>

<blockquote><pre>
&lt;table border=&quot;1&quot; cellspacing=&quot;0&quot; cellpadding=&quot;2&quot;&gt;
&lt;caption align=&quot;bottom&quot;&gt;Caption starts with a capital letter&lt;/caption&gt;
&lt;tr&gt;
&lt;th&gt;Head 1&lt;/th&gt;
&lt;th&gt;Head 2&lt;/th&gt;
&lt;/tr&gt;
&lt;tr&gt;
&lt;td&gt;Entry 1&lt;/td&gt;
&lt;td&gt;Entry 2&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
&lt;td&gt;Entry 3&lt;/td&gt;
&lt;td&gt;Entry 4&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
</pre></blockquote>
<p>显示为</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<caption align=\"bottom\">Caption starts with a capital letter</caption>
<tr>
<th><strong>Head 1</strong></th>
<th><strong>Head 2</strong></th>
</tr>
<tr>
<td>Entry 1</td>
<td>Entry 2</td>
</tr>
<tr>
<td>Entry 3</td>
<td>Entry 4</td>
</tr>
</table>

<h5>示例2</h5>

<p>在本例的表标题中，表名(Tab.)包括表枚举(1,2，…)
必须使用<code>&lt;strong&gt;</code>和<code>&lt;/strong&gt;</code>粗体显示。表名
和枚举应该像这样:<strong>Tab. 1:</strong>表必须手动枚举.</p>

<blockquote><pre>
&lt;table border=&quot;1&quot; cellspacing=&quot;0&quot; cellpadding=&quot;2&quot;&gt;
&lt;caption align=&quot;bottom&quot;&gt;&lt;strong&gt;Tab 2:&lt;/strong&gt; Caption starts with a capital letter&lt;/caption&gt;
&lt;tr&gt;
&lt;th&gt;Head 1&lt;/th&gt;
&lt;th&gt;Head 2&lt;/th&gt;
&lt;/tr&gt;
&lt;tr&gt;
&lt;td&gt;Entry 1&lt;/td&gt;
&lt;td&gt;Entry 2&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
&lt;td&gt;Entry 3&lt;/td&gt;
&lt;td&gt;Entry 4&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
</pre></blockquote>
<p>显示为</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<caption align=\"bottom\"><strong>Tab. 2:</strong> Caption starts with a capital letter</caption>
<tr>
<th>Head 1</th>
<th>Head 2</th>
</tr>
<tr>
<td>Entry 1</td>
<td>Entry 2</td>
</tr>
<tr>
<td>Entry 3</td>
<td>Entry 4</td>
</tr>
</table>
</html>"                ));
          end Tables;
          annotation(Documentation(info = "<html>

<p>
本节规定了HTML文档的用户指南格式。
文档的<a href=\"modelica://Modelica.UsersGuide.Conventions.Documentation.Structure\">结构</a>是单独指定的。
</p>

<h4>段落</h4>

<ol>
<li> 在每个部分中，段落应该以<code>&lt;p&gt;</code>开头，
     并以<code>&lt;/p&gt;</code>结束。</li>
<li> 不要写纯文本而不放在段落中。</li>
<li> 不要在文本段落中添加人为的换行<code>&lt;br&gt;</code>。
     请使用单独的段落。</li>
<li> 冒号(:)之后，如果新句子开始，则用大写字母；
     对于文本片段，用小写字母继续。</li>
</ol>

<h4>强调</h4>

<ol>
<li> 要将文本设置为<strong>加强字体</strong>(通常被解释为<strong>粗体</strong>)，必须使用标签<code>&lt;strong&gt;</code>和<code>&lt;/strong&gt;</code>。</li>
<li> 对于<em>强调</em>文本片段，必须使用<code>&lt;em&gt;</code>和<code>&lt;/em&gt;</code>。</li>
<li> Modelica术语，如可扩展总线、数组等，无论如何都不应该强调。</li>
</ol>

<h4>文本的大写</h4>

<ol>
<li> 表头和表项应以大写字母开头。</li>
<li> 如果只使用文本片段，则表项应以小写字母开头。</li>
<li> 表格和图表的标题以大写字母开头。</li>
</ol>

</html>"      ));
        end Format;

        class Structure "结构"
          extends Modelica.Icons.Information;

          annotation(Documentation(info = "<html>
<ol>
<li> 在任何Modelica库的HTML文档中，标题中不应该使用标签<code>&lt;h1&gt;</code>、
<code>&lt;h2&gt;</code>和<code>&lt;h3&gt;</code>，因为它们已经被自动生成的文档所使用。</li>
<li> 所使用的标题格式以<code>&lt;h4&gt;</code>开始，以<code>&lt;/h4&gt;</code>结束，例如：
<code>&lt;h4&gt;Description&lt;/h4&gt;</code>。</li>
<li> <code>&lt;h4&gt;</code>和<code>&lt;h5&gt;</code>标题不能以冒号(:)结尾。</li>
<li> 对于额外的结构，<code>&lt;h5&gt;</code>和<code>&lt;/h5&gt;</code>可以如下所示使用。</li>
</ol>

<h4>结构</h4>

<p>
应在每个组件的文件中添加以下部分:
</p>

<ol>
<li> 无附加小节的一般信息，说明类的工作原理</li>
<li> <strong>语法</strong>（仅适用于函数）：显示带有最小和完整输入参数的函数调用语法</li>
<li> <strong>实施</strong>（可选）：解释如何实施</li>
<li> <strong>局限性</strong>（可选）：解释组件的局限性</li>
<li> <strong>注释</strong>（可选）：如果需要/有用</li>
<li> <strong>示例</strong>（可选）：如果需要/有用</li>
<li> <strong>致谢</strong>（可选）：如果需要</li>
<li> <strong>另见</strong>：显示相关模型的超链接</li>
<li> <strong>修订历史</strong>(可选)：如果需要/打算为一个包/模型提供修订历史，
则应将修订历史放在<code>annotation(Documentation(revisions=&quot;...&quot;));</code>中</li>
</ol>

<p>
这些部分应按所列顺序排列。唯一的例外是分层结构的注释和示例，解释如下。
</p>

<h4>补充说明和示例</h4>

<p>某些附加注释或示例可能需要额外的 <code>&lt;h5&gt;</code> 标题。对于注意或示例，可采用以下情况：</p>

<h5>示例1</h5>
<p>
这是单个注意的示例。
</p>

<blockquote><pre>
&lt;h5&gt;Note&lt;/h5&gt;
&lt;p&gt;This is the note.&lt;/p&gt;
</pre></blockquote>

<h5>示例2</h5>
<p>
这是一个非常简单的结构示例。
</p>

<blockquote><pre>
&lt;h5&gt;Notes&lt;/h5&gt;
&lt;p&gt;This is the first note.&lt;/p&gt;
&lt;p&gt;This is the second note.&lt;/p&gt;
</pre></blockquote>

<h5>示例3</h5>
<p>
该示例展示了一个更复杂的枚举结构。
</p>

<blockquote><pre>
&lt;h5&gt;Note 1&lt;/h5&gt;
...
&lt;h5&gt;Note 2&lt;/h5&gt;
...
</pre></blockquote>

<h4>自动创建文档</h4>

<p>
对于参数、连接器以及函数的输入和输出，工具会根据引用的注释自动生成文档。
</p>
</html>"      ));
        end Structure;

        annotation(Documentation(info = "<html>
  <p>
Modelica类的 <a href=\"http://www.w3c.org/\">HTML</a> 文档。
</p>
</html>"      ));
      end Documentation;

      package Terms "术语和拼写"
        extends Modelica.Icons.Information;

        class Electrical "电气术语"
          extends Modelica.Icons.Information;

          annotation(Documentation(info = "<html>

<p>本软件包中列出的术语应符合<a href=\"http://www.electropedia.org/\">Electropedia</a>的规定。.</p>

<table border=\"1\" cellpadding=\"2\" cellspacing=\"0\" >
<caption align=\"bottom\">电气术语拼写表</caption>
<tr>
<th>有待使用</th>
<th>不使用</th>
</tr>
<tr>
<td><a href=\"http://www.electropedia.org/iev/iev.nsf/display?openform&amp;ievref=151-13-54\">cut-off frequency</a></td>
<td>cut off frequency, cutoff frequency, cut-off-frequency, cutoff-frequency</td>
</tr>
<tr>
<td><a href=\"http://www.electropedia.org/iev/iev.nsf/display?openform&amp;ievref=151-11-09\">electromagnetic</a></td>
<td>electro magnetic, electro-magnetic</td>
</tr>
<tr>
<td><a href=\"http://www.electropedia.org/iev/iev.nsf/display?openform&amp;ievref=151-11-10\">electromechanical</a></td>
<td>electro mechanical, electro-mechanical</td>
</tr>
<tr>
<td><a href=\"http://www.electropedia.org/iev/iev.nsf/display?openform&amp;ievref=151-15-21\">no-load</a></td>
<td>noload, no load</td>
</tr>
<tr>
<td><a href=\"http://www.electropedia.org/iev/iev.nsf/display?openform&amp;ievref=141-01-03\">polyphase</a></td>
<td>multi phase, multi-phase, multiphase</td>
</tr>
<tr>
<td><a href=\"http://www.electropedia.org/iev/iev.nsf/display?openform&amp;ievref=113-04-08\">quasi-static</a></td>
<td>quasistatic, quasi static</td>
</tr>
<tr>
<td><a href=\"http://www.electropedia.org/iev/iev.nsf/display?openform&amp;ievref=351-47-17\">set-point</a></td>
<td>set point, setpoint</td>
</tr>
<tr>
<td><a href=\"http://www.electropedia.org/iev/iev.nsf/display?openform&amp;ievref=151-12-04\">short-circuit</a></td>
<td>shortcircuit, short circuit</td>
</tr>
<tr>
<td><a href=\"http://www.electropedia.org/iev/iev.nsf/display?openform&amp;ievref=411-31-13\">single-phase</a></td>
<td>single phase, singlephase, one phase, one-phase, onephase, 1 phase, 1-phase</td>
</tr>
<tr>
<td><a href=\"http://www.electropedia.org/iev/iev.nsf/display?openform&amp;ievref=141-02-10\">star point</a></td>
<td>star-point, starpoint</td>
</tr>
<tr>
<td><a href=\"http://www.electropedia.org/iev/iev.nsf/display?openform&amp;ievref=811-12-22\">three-phase</a></td>
<td>three phase, threephase, 3 phase, 3-phase</td>
</tr>
</table>

</html>"          ));
        end Electrical;

        class Magnetic "电磁术语"
          extends Modelica.Icons.Information;

          annotation(Documentation(info = "<html>

<p>本软件包中列出的术语应符合<a href=\"http://www.electropedia.org/\">Electropedia</a>.</p>

<table border=\"1\" cellpadding=\"2\" cellspacing=\"0\" >
<caption align=\"bottom\">电磁术语拼写表</caption>
<tr>
<th>有待使用</th>
<th>不使用</th>
</tr>
<tr>
<td><a href=\"http://www.electropedia.org/iev/iev.nsf/display?openform&amp;ievref=151-11-09\">electromagnetic</a></td>
<td>electro magnetic, electro-magnetic</td>
</tr>
<tr>
<td><a href=\"http://www.electropedia.org/iev/iev.nsf/display?openform&amp;ievref=121-11-60\">magnetomotive force</a></td>
<td>magneto motive force</td>
</tr>
<tr>
<td><a href=\"http://www.electropedia.org/iev/iev.nsf/display?openform&amp;ievref=113-04-08\">quasi-static</a></td>
<td>quasistatic, quasi static</td>
</tr>
</table>

</html>"          ));
        end Magnetic;
        annotation(Documentation(info = "<html>

<p>这是Modelica标准库中使用的术语文档。</p>

</html>"          ));
      end Terms;

      package ModelicaCode "Modelica代码"
        extends Modelica.Icons.Information;

        class Format "格式"
          extends Modelica.Icons.Information;

          annotation(Documentation(info = "<html>

<h4>评论和注释</h4>
<p>
注释和注解应该以大写字母开头，例如：<br>
<code><strong>parameter</strong> Real a = 1 &quot;Arbitrary factor&quot;;</code><br>
对于布尔参数，描述字符串应该以&quot;= true, &hellip;&quot;开头，例如：<br>
<code><strong>parameter</strong> Boolean useHeatPort = false &quot;= true, if heatPort is enabled&quot;;</code>
</p>
</html>"            ));
        end Format;

        class Naming "命名规则"
          extends Modelica.Icons.Information;

          annotation(Documentation(info = "<html><ol><li>
<strong>类名和实例名</strong>通常用大小写书写 字母，例如“<span style=\"color: rgb(51, 51, 51);\">ElectricCurrent</span>”。<span style=\"color: rgb(51, 51, 51);\">下划线可以用于名称中。然而，需要注意的是，名称中的最后一个下划线可能表示后续字符将作为下标显示</span>。 例如：\"pin_a\" 可渲染为 \"pin<sub>a</sub>\"；.</li>
<li>
<strong>类名</strong>总是以大写字母开头、 函数除外，函数以小写字母开头.</li>
<li>
<strong>实例名</strong>，即<span style=\"color: rgb(51, 51, 51);\">组件实例和变量的名称（常量除外）通常以小写字母开头，只有少数情况下例外（如温度变量用T表示）。</span></li>
<li>
<strong>常量名</strong>，即<span style=\"color: rgb(51, 51, 51);\">以 \\\\\\\\\\\\\\'constant\\\\\\\\\\\\\\' 前缀声明的变量名称遵循常规命名约定（= 大小写字母），通常以大写字母开头，例如：UniformGravity, SteadyState。</span></li>
<li>
具有相同声明的域的两个<strong>连接器</strong> 不同的图标通常用 <code>_a</code>, <code>_b</code> 或者<code>_p</code>, <code>_n</code>, 例如, <code>Flange_a</code>, <code>Flange_b</code>, <code>HeatPort_a</code>, <code>HeatPort_b</code>.</li>
<li>
<strong>连接器类</strong>具有该实例 名称定义在图形层中，而不是在 <a href=\"modelica://Modelica.UsersGuide.Conventions. Icons\" target=\"\">icon</a>&nbsp; 图标层.</li>
</ol><h4>变量名</h4><p>
在下表中列出了典型的变量名。这份清单应该填写完整。
</p>
<table border=\"1\" cellpadding=\"2\" cellspacing=\"0\" >
   <caption align=\"bottom\">Variables and names</caption>
   <tr>
      <th>变量</th>
      <th>量</th>
    </tr>
    <tr>
      <td>a</td>
      <td>加速度</td>
    </tr>
    <tr>
      <td>A</td>
      <td>面积</td>
    </tr>
    <tr>
      <td>C</td>
      <td>电容</td>
    </tr>
    <tr>
      <td>d</td>
      <td>阻尼，密度，直径</td>
    </tr>
    <tr>
      <td>dp</td>
      <td>压降</td>
    </tr>
    <tr>
      <td>e</td>
      <td>比熵</td>
    </tr>
    <tr>
      <td>E</td>
      <td>能量、熵</td>
    </tr>
    <tr>
      <td>eta</td>
      <td>效率</td>
    </tr>
    <tr>
      <td>f</td>
      <td>力、频率</td>
    </tr>
    <tr>
      <td>G</td>
      <td>电导</td>
    </tr>
    <tr>
      <td>h</td>
      <td>高度、比焓</td>
    </tr>
    <tr>
      <td>H</td>
      <td>焓</td>
    </tr>
    <tr>
      <td>HFlow</td>
      <td>焓流</td>
    </tr>
    <tr>
      <td>i</td>
      <td>电流</td>
    </tr>
    <tr>
      <td>J</td>
      <td>惯性</td>
    </tr>
    <tr>
      <td>l</td>
      <td>长度</td>
    </tr>
    <tr>
      <td>L</td>
      <td>电感</td>
    </tr>
    <tr>
      <td>m</td>
      <td>质量</td>
    </tr>
    <tr>
      <td>M</td>
      <td>互感</td>
    </tr>
    <tr>
      <td>mFlow</td>
      <td>质量流量</td>
    </tr>
    <tr>
      <td>p</td>
      <td>压力</td>
    </tr>
    <tr>
      <td>P</td>
      <td>功率</td>
    </tr>
    <tr>
      <td>Q</td>
      <td>热</td>
    </tr>
    <tr>
      <td>Qflow</td>
      <td>热流</td>
    </tr>
    <tr>
      <td>r</td>
      <td>半长轴</td>
    </tr>
    <tr>
      <td>R</td>
      <td>半径、阻力</td>
    </tr>
    <tr>
      <td>t</td>
      <td>时间</td>
    </tr>
    <tr>
      <td>T</td>
      <td>温度</td>
    </tr>
    <tr>
      <td>tau</td>
      <td>扭矩</td>
    </tr>
    <tr>
      <td>U</td>
      <td>内能</td>
    </tr>
    <tr>
      <td>v</td>
      <td>电势、比容、速度、电压</td>
    </tr>
    <tr>
      <td>V</td>
      <td>体积</td>
    </tr>
    <tr>
      <td>w</td>
      <td>角速度</td>
    </tr>
    <tr>
      <td>X</td>
      <td>电抗</td>
    </tr>
    <tr>
      <td>Z</td>
      <td>阻抗</td>
    </tr>
</table>
</html>"            ));
        end Naming;

        class ParameterDefaults "参数默认值"
          extends Modelica.Icons.Information;

          annotation(Documentation(info = "<html>

<p>
在本节中，总结了Modelica标准库(自3.0版本以来)中如何处理默认参数的惯例。
</p>

<p>
该库中的许多模型都有参数声明，用于定义模型的常量，这些常量在仿真前可能会被修改。例如：
</p>

<blockquote><pre>
<strong>model</strong> SpringDamper
<strong>parameter</strong> Real c(final unit=\"N.m/rad\") = 1e5    \"Spring constant\";
<strong>parameter</strong> Real d(final unit=\"N.m.s/rad\") = 0    \"Damping constant\";
<strong>parameter</strong> Modelica.Units.SI.Angle phi_rel0 = 0  \"Unstretched spring angle\";
...
<strong>end</strong> SpringDamper;
</pre></blockquote>

<p>
在Modelica中，可以在参数声明中定义参数的默认值。
在上述示例中，所有参数都进行了此操作。
为所有参数提供默认值可能会导致难以发现的错误，因为建模者可能忘记为参数提供一个有意义的值
(模型虽然能模拟，但由于参数值错误而给出错误的结果)。通常存在以下几种基本情况：
</p>

<ol>
<li> 参数值可以是任何值(例如，弹簧常数或电阻值)，因此用户在所有情况下都应提供一个值。
  如果未提供值，Modelica编译器应发出警告。
</li>

<li> 参数值在超过95%的情况下不会发生变化(例如，初始化或可视化参数，或者上面示例中的参数phi_rel0)。
  在这种情况下，应提供默认参数值，以便模型或函数可以方便地被建模者使用。
</li>

<li> 建模者希望快速使用一个模型，例如：
  <ul>
  <li> 自动检查模型是否仍然能翻译和/或模拟（在库发生某些变化后），</li>
  <li> 通过拖放组件快速演示一个库，</li>
  <li> 实现一个简单的测试模型，以更好地理解所需的组件。</li>
  </ul>
  在所有这些情况下，如果建模者必须首先为所有参数提供显式值，那将不太实际。
  </li>
</ol>

<p>
为了处理(1)和(3)两个目标之间的冲突，Modelica标准库使用两种方法来定义默认参数，如下例所示：
</p>

<blockquote><pre>
<strong>model</strong> SpringDamper
<strong>parameter</strong> Real c(final unit=\"N.m/rad\"  , start = 1e5) \"Spring constant\";
<strong>parameter</strong> Real d(final unit=\"N.m.s/rad\", start = 0)   \"Damping constant\";
<strong>parameter</strong> Modelica.Units.SI.Angle phi_rel0 = 0        \"Unstretched spring angle\";
...
<strong>end</strong> SpringDamper;

SpringDamper sp1;              // warning for \"c\" and \"d\"
SpringDamper sp2(c=1e4, d=0);  // fine, no warning
</pre></blockquote>

<p>
两种定义形式，使用\"start\"值(对于\"c\"和\"d\")和提供声明方程(对于\"phi_rel0\")，都是有效的Modelica，并且定义了参数的值。
根据约定，希望Modelica编译器将在参数<strong>没有</strong>通过声明方程、修饰符方程或初始方程/算法部分定义时触发警告消息。
Modelica编译器可能具有更改此行为的选项，特别是在这种情况下不打印任何消息和/或触发错误而不是警告。
</p>
</html>"        ));
        end ParameterDefaults;
        annotation(Documentation(info = "<html>

<p>本节提供了创建Modelica代码的指南.</p>

</html>"            ));
      end ModelicaCode;

      package UsersGuide "用户指南"
        extends Modelica.Icons.Information;

        class Implementation "实现说明"
          extends Modelica.Icons.Information;

          annotation(Documentation(info = "<html>
<p>
该类汇总了其他地方未说明的有关实现的一般信息。
</p>
<ol>
<li><code>&lt;caption&gt;</code> 标记目前在某些工具中不支持。</li>
<li><code>&amp;sim;</code>符号(即，'&sim;' ) 某些工具目前不支持。</li>
<li><code>&amp;prop;</code>符号(即，'&prop;' ) 某些工具目前不支持。</li>
</ol>
</html>"        ));
        end Implementation;

        class References "参考文献"
          extends Modelica.Icons.References;

          annotation(Documentation(info = "<html>

<ol>
<li> 引文格式应按照 IEEE Transactions 风格统一.</li>
<li> 参考文献的格式应为两栏表格.</li>
</ol>

<p>下面将根据五个例子对参考文献格式进行说明:</p>

<ul>
<li> Journal (or conference) [Gao2008]</li>
<li> Book [Kral2018]</li>
<li> Master&apos;s thesis [Woehrnschimmel1998]</li>
<li> PhD thesis [Farnleitner1999]</li>
<li> Technical report [Marlino2005]</li>
</ul>

<p>还解释了<a href=\"modelica://Modelica.UsersGuide.Conventions.Documentation.Format.References\">引文</a>.</p>

<h4>示例</h4>

<blockquote><pre>
&lt;table border=\"0\" cellspacing=\"0\" cellpadding=\"2\"&gt;
&lt;tr&gt;
&lt;td&gt;[Gao2008]&lt;/td&gt;
&lt;td&gt;Z. Gao, T. G. Habetler, R. G. Harley, and R. S. Colby,
&amp;quot;&lt;a href=&quot;https://ieeexplore.ieee.org/document/4401132&quot;&gt;A sensorless rotor temperature estimator for induction
machines based on a current harmonic spectral estimation scheme&lt;/a&gt;&amp;quot;,
&lt;em&gt;IEEE Transactions on Industrial Electronics&lt;/em&gt;,
vol. 55, no. 1, pp. 407-416, Jan. 2008.
&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
&lt;td&gt;[Kral2018]&lt;/td&gt;
&lt;td&gt;C. Kral,
&lt;em&gt;Modelica - object oriented modeling of polyphase electric machines&lt;/em&gt; (in German),
M&amp;uuml;nchen: Hanser Verlag, 2018, &lt;a href=&quot;https://doi.org/10.3139/9783446457331&quot;&gt;DOI 10.3139/9783446457331&lt;/a&gt;,
ISBN 978-3-446-45551-1.
&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
&lt;td&gt;[Woehrnschimmel1998]&lt;/td&gt;
&lt;td&gt;R. W&amp;ouml;hrnschimmel,
&amp;quot;Simulation, modeling and fault detection for vector
controlled induction machines&amp;quot;,
Master&amp;apos;s thesis, Vienna University of Technology,
Vienna, Austria, 1998.
&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
&lt;td&gt;[Farnleitner1999]&lt;/td&gt;
&lt;td&gt;E. Farnleitner,
&amp;quot;Computational Fluid dynamics analysis for rotating
electrical machinery&amp;quot;,
Ph.D. dissertation, University of Leoben,
Department of Applied Mathematics, Leoben, Austria, 1999.
&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
&lt;td&gt;[Marlino2005]&lt;/td&gt;
&lt;td&gt;L. D. Marlino,
&amp;quot;Oak ridge national laboratory annual progress report for the
power electronics and electric machinery program&amp;quot;,
Oak Ridge National Laboratory, prepared for the U.S. Department of Energy,
Tennessee, USA, Tech. Rep. FY2004 Progress Report, January 2005,
&lt;a href=&quot;https://doi.org/10.2172/974618&quot;&gt;DOI 10.2172/974618&lt;/a&gt;.
&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
</pre></blockquote>

<p>显示为</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<tr>
<td>[Gao2008]</td>
<td>Z. Gao, T. G. Habetler, R. G. Harley, and R. S. Colby,
&quot;<a href=\"https://ieeexplore.ieee.org/document/4401132\">A sensorless rotor temperature estimator for induction
machines based on a current harmonic spectral estimation scheme</a>&quot;,
<em>IEEE Transactions on Industrial Electronics</em>,
vol. 55, no. 1, pp. 407-416, Jan. 2008.
</td>
</tr>
<tr>
<td>[Kral2018]</td>
<td>C. Kral,
<em>Modelica - object oriented modeling of polyphase electric machines</em> (in German),
M&uuml;nchen: Hanser Verlag, 2018, <a href=\"https://doi.org/10.3139/9783446457331\">DOI 10.3139/9783446457331</a>,
ISBN 978-3-446-45551-1.
</td>
</tr>
<tr>
<td>[Woehrnschimmel1998]</td>
<td>R. W&ouml;hrnschimmel,
&quot;Simulation, modeling and fault detection for vector
controlled induction machines&quot;,
Master&apos;s thesis, Vienna University of Technology,
Vienna, Austria, 1998.
</td>
</tr>
<tr>
<td>[Farnleitner1999]</td>
<td>E. Farnleitner,
&quot;Computational Fluid dynamics analysis for rotating
electrical machinery&quot;,
Ph.D. dissertation, University of Leoben,
Department of Applied Mathematics, Leoben, Austria, 1999.
</td>
</tr>
<tr>
<td>[Marlino2005]</td>
<td>L. D. Marlino,
&quot;Oak ridge national laboratory annual progress report for the
power electronics and electric machinery program&quot;,
Oak Ridge National Laboratory, prepared for the U.S. Department of Energy,
Tennessee, USA, Tech. Rep. FY2004 Progress Report, January 2005,
<a href=\"https://doi.org/10.2172/974618\">DOI 10.2172/974618</a>.
</td>
</tr>
</table>

</html>"              ));
        end References;

        class Contact "联系信息"
          extends Modelica.Icons.Contact;

          annotation(Documentation(info = "<html>

<p>
该类汇总了撰稿人的联系信息。
</p>

<h4>示例</h4>

<blockquote><pre>
&lt;p&gt;
Library officers responsible for the maintenance and for the
organization of the development of this library are listed in
&lt;a href=\"modelica://Modelica.UsersGuide.Contact\"&gt;Modelica.UsersGuide.Contact&lt;/a&gt;.
&lt;/p&gt;

&lt;h4&gt;Main authors&lt;/h4&gt;

&lt;p&gt;
&lt;strong&gt;First author's name&lt;/strong&gt;&lt;br&gt;
First author's address&lt;br&gt;
next address line&lt;br&gt;
email: &lt;a href=\"mailto:author1@example.org\"&gt;author1@example.org&lt;/a&gt;&lt;br&gt;
web: &lt;a href=&quot;https://www.example.org&quot;&gt;https://www.example.org&lt;/a&gt;
&lt;/p&gt;

&lt;p&gt;
&lt;strong&gt;Second author's name&lt;/strong&gt;&lt;br&gt;
Second author's address&lt;br&gt;
next address line&lt;br&gt;
email: &lt;a href=\"mailto:author2@example.org\"&gt;author2@example.org&lt;/a&gt;
&lt;/p&gt;

&lt;h4&gt;Contributors to this library&lt;/h4&gt;

&lt;ul&gt;
&nbsp; &lt;li&gt;Person one&lt;/li&gt;
&nbsp; &lt;li&gt;...&lt;/li&gt;
&lt;/ul&gt;

&lt;h4&gt;Acknowledgements&lt;/h4&gt;

&lt;p&gt;
The authors would like to thank following persons for their support ...
&lt;/p&gt;

OR

&lt;p&gt;
We are thankful to our colleagues [names] who provided expertise to develop this library...
&lt;/p&gt;

OR

&lt;p&gt;
The [partial] financial support for the development of this library by [organization]
is highly appreciated.
&lt;/p&gt;

OR whatever
</pre></blockquote>
<p>显示为</p>
<p>
负责维护和组织发展该库的库管理员名单如下
<a href=\"modelica://Modelica.UsersGuide.Contact\">Modelica.UsersGuide.Contact</a>.
</p>

<h4>主要作者</h4>

<p>
<strong>第一作者姓名</strong><br>
第一作者地址<br>
下一地址行<br>
email: <a href=\"mailto:author1@example.org\">author1@example.org</a><br>
web: <a href=\"https://www.example.org\">https://www.example.org</a>
</p>

<p>
<strong>第二作者姓名</strong><br>
第二作者地址<br>
下一地址行<br>
email: <a href=\"mailto:author2@example.org\">author2@example.org</a><br>
</p>

<h4>本库的贡献者</h4>

<ul>
<li>第一人</li>
<li>...</li>
</ul>

<h4>致谢</h4>

<p>
作者感谢以下人员的支持 ...
</p>
</html>"              ));
        end Contact;

        class RevisionHistory "修订历史"
          extends Modelica.Icons.ReleaseNotes;

          annotation(Documentation(info = "<html>

<ol>
<li> 修订历史需要回答以下问题：
与以前的版本和修订相比，有哪些变化和有哪些改进。</li>
<li> 修订历史包括每个类和/或包的开发历史文档.</li>
<li> 版本号，日期，作者和评论应包括在内。
如果在实施时不知道版本号，应该使用一个虚拟版本号，例如<code>3.x.x</code>。版本日期为文件最后更改的日期。</li>
</ol>

<h5>示例</h5>

<blockquote><pre>
&lt;table border=\"1\" cellspacing=\"0\" cellpadding=\"2\"&gt;
&lt;tr&gt;
&lt;th&gt;Version&lt;/th&gt;
&lt;th&gt;Date&lt;/th&gt;
&lt;th&gt;Author&lt;/th&gt;
&lt;th&gt;Comment&lt;/th&gt;
&lt;/tr&gt;
...
&lt;tr&gt;
&lt;td&gt;1.0.1&lt;/td&gt;
&lt;td&gt;2008-05-26&lt;/td&gt;
&lt;td&gt;A. Haumer&lt;br&gt;C. Kral&lt;/td&gt;
&lt;td&gt;Fixed bug in documentation&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
&lt;td&gt;1.0.0&lt;/td&gt;
&lt;td&gt;2008-05-21&lt;/td&gt;
&lt;td&gt;A. Haumer&lt;/td&gt;
&lt;td&gt;Initial version&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
</pre></blockquote>

<p>这段代码出现在下面的\"Revisions\"一节中。</p>

</html>"      , 
            revisions = "<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr>
<th>版本</th>
<th>日期</th>
<th>作者</th>
<th>评论</th>
</tr>
<tr>
<td>3.2.3</td>
<td>2017-07-04</td>
<td>C. Kral</td>
<td>增加了关于版本号和日期的注释，请参阅
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2219\">#2219</a></td>
</tr>
<tr>
<td>1.1.0</td>
<td>2010-04-22</td>
<td>C. Kral</td>
<td>将约定迁移到MSL的UsersGuide</td>
</tr>
<tr>
<td>1.0.5</td>
<td>2010-03-11</td>
<td>D. Winkler</td>
<td>更新了新的 'modelica://' URIs的图像链接指南，添加了联系方式</td>
</tr>
<tr>
<td>1.0.4</td>
<td>2009-09-28</td>
<td>C. Kral</td>
<td>应用了第63届Modelica设计会议上讨论的方程新规则</td>
</tr>
<tr>
<td>1.0.3</td>
<td>2008-05-26</td>
<td>D. Winkler</td>
<td>布局修复和增强</td>
</tr>
<tr>
<td>1.0.1</td>
<td>2008-05-26</td>
<td>A. Haumer<br>C. Kral</td>
<td>修复了文档中的错误</td>
</tr>
<tr>
<td>1.0.0</td>
<td>2008-05-21</td>
<td>A. Haumer</td>
<td>初始版本</td>
</tr>
</table>
</html>"      ));
        end RevisionHistory;

        annotation(Documentation(info = "<html>
<p>每个包的用户指南应包括以下内容：</p>
<ol>
<li> 库负责人和合著者的<a href=\"modelica://Modelica.UsersGuide.Conventions.UsersGuide.Contact\">联系信息</a></li>
<li> 可选的<a href=\"modelica://Modelica.UsersGuide.Conventions.UsersGuide.Implementation\">实现说明</a>，提供有关实现的一般信息</li>
<li> <a href=\"modelica://Modelica.UsersGuide.Conventions.UsersGuide.References\">参考文献</a>，用于总结该包的文献</li>
<li> <a href=\"modelica://Modelica.UsersGuide.Conventions.UsersGuide.RevisionHistory\">修订历史</a>，总结该包的最重要更改和改进</li>
</ol>
</html>"      ));
      end UsersGuide;

      class Icons "图标设计"
        extends Modelica.Icons.Information;
        annotation(Documentation(info = "<html>

<p>Modelica类的图标应考虑以下准则:</p>

<h4>颜色和形状</h4>

<p>一个组件的主图标颜色对于一个库的所有组件应该是相同的。图标的白色填充区域不能用来隐藏图标的某些部分，参见
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2031\">#2031</a>。
在Modelica标准库中应用以下配色方案:</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<caption align=\"bottom\">Color schemes applied to particular libraries</caption>
<tr>
<th>包</th>
<th>颜色RGB代码</th>
<th>颜色样例</th>
</tr>
<tr>
<td>Modelica.Blocks</td>
<td>{0,0,127}</td>
<td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleBlocks.png\"></td>
</tr>
<tr>
<td>Modelica.ComplexBlocks</td>
<td>{85,170,255}</td>
<td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleComplexBlocks.png\"></td>
</tr>
<tr>
<td>Modelica.Clocked</td>
<td>{95,95,95}</td>
<td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleClocked.png\"></td>
</tr>
<tr>
<td>Modelica.StateGraph</td>
<td>{0,0,0}</td>
<td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleStateGraph.png\"></td>
</tr>
<tr>
<td>Modelica.Electrical.Analog</td>
<td>{0,0,255}</td>
<td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleElectricalAnalog.png\"></td>
</tr>
<tr>
<td>Modelica.Electrical.Digital</td>
<td>{128,0,128}</td>
<td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleElectricalDigital.png\"></td>
</tr>
<tr>
<td>Modelica.Electrical.Machines</td>
<td>{0,0,255}</td>
<td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleElectricalMachines.png\"></td>
</tr>
<tr>
<td>Modelica.Electrical.Polyphase</td>
<td>{0,0,255}</td>
<td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleElectricalPolyphase.png\"></td>
</tr>
<tr>
<td>Modelica.Electrical.QuasiStatic</td>
<td>{85,170,255}</td>
<td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleElectricalQuasiStatic.png\"></td>
</tr>
<tr>
<td>Modelica.Electrical.Spice3</td>
<td> {170,85,255}</td>
<td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleElectricalSpice3.png\"></td>
</tr>
<tr>
<td>Modelica.Magnetic.FluxTubes</td>
<td>{255,127,0}</td>
<td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleMagneticFluxTubes.png\"></td>
</tr>
<tr>
<td>Modelica.Magnetic.FundamentalWave</td>
<td>{255,127,0}</td>
<td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleMagneticFundamentalWave.png\"></td>
</tr>
<tr>
<td>Modelica.Magnetic.QuasiStatic</td>
<td>{255,170,85}</td>
<td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleMagneticQuasiStatic.png\"></td>
</tr>
<tr>
<td>Modelica.Mechanics.MultiBody</td>
<td>{192,192,192}</td>
<td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleMechanicsMultiBody.png\"></td>
</tr>
<tr>
<td>Modelica.Mechanics.Rotational</td>
<td>{95,95,95}</td>
<td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleMechanicsRotational.png\"></td>
</tr>
<tr>
<td>Modelica.Mechanics.Translational</td>
<td>{0,127,0}</td>
<td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleMechanicsTranslational.png\"></td>
</tr>
<tr>
<td>Modelica.Fluid</td>
<td>{0,127,255}</td>
<td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleFluid.png\"></td>
</tr>
<tr>
<td>Modelica.Media</td>
<td>none</td>
<td></td>
</tr>
<tr>
<td>Modelica.Thermal.FluidHeatFlow</td>
<td>{0,0,255}</td>
<td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleThermalFluidHeatFlow.png\"></td>
</tr>
<tr>
<td>Modelica.Thermal.HeatTransfer</td>
<td>{191,0,0}</td>
<td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icons/colorSampleThermalHeatTransfer.png\"></td>
</tr>
<tr>
<td>Modelica.Math</td>
<td>none</td>
<td></td>
</tr>
<tr>
<td>Modelica.ComplexMath</td>
<td>none</td>
<td></td>
</tr>
<tr>
<td>Modelica.Utilities</td>
<td>none</td>
<td></td>
</tr>
<tr>
<td>Modelica.Constants</td>
<td>none</td>
<td></td>
</tr>
<tr>
<td>Modelica.Icons</td>
<td>none</td>
<td></td>
</tr>
<tr>
<td>Modelica.Units</td>
<td>none</td>
<td></td>
</tr>
</table>

<h4>图标尺寸</h4>

<p>Modelica类的图标不得明显大于或小于默认的200单位×200单位的图像限制。默认的图像限制是</p>
<ul>
<li>-100单位 &le; 水平坐标 &le; +100单位</li>
<li>-100单位 &le; 垂直坐标 &le; +100单位</li>
</ul>
<p>如果可能，图标应该这样设计：在图标的垂直图示范围内显示图标名称<code>%name</code>和最重要的参数。</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<caption align=\"bottom\"><strong>Fig. 1</strong>: (a) Typical icon, (b) including dimensions</caption>
<tr>
<td> (a)
<img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icon_name.png\"
 alt=\"Typical placement of component name\">
</td>
<td> (b)
<img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icon_name_dimensions.png\"
 alt=\"Typical dimensions of icon and its entities\">
</td>
</tr>
</table>

<h4>组件名称</h4>

<p>组件名称<code>%name</code>应为RGB(0,0,255)的蓝色。</p>
<ul>
<li>文字高度：40个单位</li>
<li>文字宽度：300个单位</li>
</ul>
<p>文本应位于实际图标上方。如果有足够的空间，则显示组件名称的文本上限
应在图标上方边界下方10个单位，见 <strong>Fig.&nbsp;1</strong>.</p>

<p>如果图标的大小相当于整个图标范围的200个单位x 200个单位，例如方块，
组件名称应放置在图标上方，图标与下方文本框之间垂直留出10个单位的空间，参见 <strong>Fig.&nbsp;2</strong>.</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<caption align=\"bottom\"><strong>Fig. 2</strong>: Block component name</caption>
<tr>
<td>
<img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Block_name.png\"
 alt=\"Placement of block component name\">
</td>
</tr>
</table>

<p>如果在顶部图标边界处有一个连接器，并且很明显该连接器会影响模型
行为比较类似的模型没有这样的连接器，然后一行从连接器到实际的图标
为保持设计的平直，应避免出现这种情况，见图4</strong>。如果需要使用指示连接器依赖项的行，则
这条线应该被打断，这样这条线就不会干扰组件的名称.</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<caption align=\"bottom\"><strong>Fig. 3</strong>: Component name between actual icon and connector</caption>
<tr>
<td>
<img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icon_name_connector_above.png\"
 alt=\"Component name placed between actual icon and connector\">
</td>
</tr>
</table>

<p>在某些情况下，如果没有其他选择，组件名称必须放在实际图标的下方，请参见. <strong>Fig.&nbsp;4</strong>.</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<caption align=\"bottom\"><strong>Fig. 4</strong>: Component name below actual icon</caption>
<tr>
<td>
<img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icon_name_below.png\"
 alt=\"Icon with name placed below it\">
</td>
</tr>
</table>

<h4>参数名称</h4>

<p>一个重要的参数应该放在图标下面，见 <strong>Fig.&nbsp;1</strong> and <strong>Fig.&nbsp;2</strong>. The parameter name shall be RGB (0,0,0) black color.</p>
<ul>
<li>文字高度:40个单位(或30个单位，最低20个单位，如果需要)</li>
<li>文字宽度:300个单位</li>
</ul>
<p>参数文本框应位于实际图标下方10个单位.
</p>

<h4>连接器的位置</h4>

<p>物理连接器应始终位于图标边界上。输入输出连接器应置于图标外侧，见<strong>Fig. 2</strong>和<strong>Fig. 3</strong>。
首选的连接器位置是:</p>
<ul>
<li>在图标图的四个角，参见 <strong>Fig.&nbsp;5</strong></li>
<li>在图标的垂直或水平对称线上，参见 <strong>Fig.&nbsp;1&ndash;3</strong></li>
<li>如果需要，备选连接点应位于20个单元(或10个单元)的栅格中，参见 <strong>Fig.&nbsp;4</strong></li>
</ul>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<caption align=\"bottom\"><strong>Fig. 5</strong>: Connectors located at the four corners of the icon diagram</caption>
<tr>
<td>
<img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icon_connector_corner.png\"
 alt=\"Icon of connector corner\">
</td>
</tr>
</table>

<h4>传感器</h4>

<p>
基于<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2628\">#2628</a>
传感器应用设计:
</p>

<ul>
<li>传感器输出应以其SI单位表示，而不是其数量;适当的国际单位制应符合的单位定义
<a href=\"modelica://Modelica.Units.SI\">Modelica.Units.SI</a>,
例如，热流用<strong>W</strong>表示，扭矩用<strong>N.m</strong>表示。</li>
<li>SI单位的文本颜色为{64,64,64}，采用RGB编码</li>
<li>对于具有单一输出信号的传感器，SI单位应放置在传感器内。
看到 <strong>Fig.&nbsp;6</strong> and <strong>7</strong>
<ul>
<li>在<a href=\"modelica://Modelica.Icons.RoundSensor\">round sensor</a>文本大小应为
<ul>
<li>二者之一 <code>{{-30,-10},{30,-70}}</code> (<strong>Fig.&nbsp;6(a)</strong>)</li>
<li>或者 <code>{{-50,-12},{50,-48}}</code> (<strong>Fig.&nbsp;6(b)</strong>), 取决于更好的可读性</li>
</ul></li>

<li>在<a href=\"modelica://Modelica.Icons.RectangularSensor\">rectangular sensor</a>文本大小应为
<code>{{-24,20},{66,-40}}</code> (<strong>Fig.&nbsp;7</strong>)</li>
</ul></li>
<li>对于具有多个输出信号的传感器，应将SI单位放在输出信号旁边;
信号连接器和SI单位可能重叠，见 <strong>Fig.&nbsp;8</strong>
<ul>
<li>文字高度:40个单位(或30个单位，最低20个单位，如果需要)</li>
<li>文字宽度:40个单位(或30个单位，至少20个单位，如果需要)</li>
</ul></li>
</ul>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<caption align=\"bottom\"><strong>Fig. 6</strong>: Round sensor with (a) short and (b) longer SI unit</caption>
<tr>
<td> (a)
<img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icon_sensor_round.png\"
 alt=\"Icon of connector corner\">
</td>
<td> (b)
<img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icon_sensor_round2.png\"
 alt=\"Icon of connector corner\">
</td>
</tr>
</table>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<caption align=\"bottom\"><strong>Fig. 7</strong>: Rectangular sensor </caption>
<tr>
<td>
<img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icon_sensor_rectangular.png\"
 alt=\"Icon of connector corner\">
</td>
</tr>
</table>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<caption align=\"bottom\"><strong>Fig. 8</strong>: Sensor with multiple signal outputs and SI units located next to the output connectors</caption>
<tr>
<td>
<img src=\"modelica://Modelica/Resources/Images/UsersGuide/Conventions/Icon_sensor_multi.png\"
 alt=\"Icon of connector corner\">
</td>
</tr>
</table>

<h4>图层</h4>

<p>图层的目的是包含图形组件，如果没有图形组件，则图层应为空。
尤其不要将图表层作为图标层的副本。
不得在图表层中添加图形插图，但可以在 HTML 文档中添加.</p>
</html>"                              ));
      end Icons;
      annotation(DocumentationClass = true, Documentation(info = "<html>
<p>Modelica 主软件包应符合本文档的用户指南：</p>
<ol>
<li> <a href=\"modelica://Modelica.UsersGuide.Conventions.ModelicaCode\">Modelica code</a>的约定</li>
<li> 一致的<a href=\"modelica://Modelica.UsersGuide.Conventions.Documentation\">HTML documentation</a></li>
<li> 主包采用的结构
<ul>
<li> <a href=\"modelica://Modelica.UsersGuide.Conventions.UsersGuide\">用户指南</a></li>
<li> <strong>示例</strong>包含演示库用法的模型。</li>
<li> <strong>组件</strong> -- 如果是复杂的库，可以建立更详细的结构。</li>
<li> <strong>传感器</strong></li>
<li> <strong>源</strong></li>
<li> <strong>接口</strong>包含连接器和简单的部分接口模型。</li>
<li> <strong>基础类</strong>包含除微分方程和平衡方程之外的物理方程的局部模型。</li>
<li> <strong>类型</strong>包含类型、枚举和选择定义。</li>
</ul></li>
<li> 这些软件包应按所列顺序排列。</li>
</ol>
</html>"            ));
    end Conventions;

    package ReleaseNotes "发布说明"
      extends Modelica.Icons.ReleaseNotes;

      class VersionManagement "版本管理"
        extends Modelica.Icons.ReleaseNotes;

        annotation(Documentation(info = "<html>
<h4>开发分支</h4>
<p>
Modelica标准库的进一步开发和维护通过Modelica协会的公共<a href=\"https://github.com/modelica/ModelicaStandardLibrary.git\">GitHub repository</a>仓库中的两个分支进行。
自4.0.0版本起，Modelica标准库采用语义化版本控制(semantic versioning)，遵循以下约定：
</p>
 <blockquote><strong><code>MAJOR.MINOR.BUGFIX</code></strong></blockquote>
<p>
这种版本管理机制提供了一种清晰的方式来维护发布和修复bug，灵感来自于(但不完全相同于)<a href=\"https://semver.org\">https://semver.org</a>。
</p>

<h5>主开发分支</h5>
<p>
名称：\"master\"
</p>

<p>
该分支包含当前的开发版本，即所有的bug修复和新特性。
在包含新特性之前，这些特性必须经过测试。
然而，通常不会对新版本执行全面的测试。
这个版本通常只由Modelica标准库的开发者使用，Modelica用户一般不会使用该版本。
</p>

<h5>维护分支</h5>
<p>
名称：\"maint/4.0.x\"
</p>

<p>
该分支包含已发布的Modelica标准库版本(例如v4.0.0)，并包括自发布日期以来的所有bug修复(包括连续的<code>BUGFIX</code>版本4.0.1、4.0.2等，直到发布新的<code>MINOR</code>或<code>MAJOR</code>版本为止；
也就是说，原版本不会再发布进一步的<code>BUGFIX</code>版本(例如4.0.x))。
这些bug修复可能尚未使用所有测试用例或与其他Modelica库进行充分测试。
目标是，任何供应商都可以随时使用此版本来发布其软件的新版本，以便将最新的bug修复纳入其中。
</p>

<h4>贡献工作流程</h4>
<p>
一般的<a href=\"https://guides.github.com/activities/forking/\">贡献工作流程</a>通常如下:
</p>

<ol>
<li>使用GitHub仓库页面上的<a href=\"https://help.github.com/articles/fork-a-repo/\">Fork按钮</a>，将仓库fork到你的账户。</li>
<li>将fork的仓库克隆到你的本地计算机。如果bug修复需要合并到维护分支，确保切换到维护分支。</li>
<li>创建一个新的主题分支，并给它起一个有意义的名字，例如：\"issue2161-fix-formula\"。</li>
<li>进行代码修改并提交，每次提交一个修改。<br>
   单个提交可以复制到其他分支。<br>
   多个提交可以合并成一个，但拆分提交是困难的。</li>
<li>完成后，将你的主题分支推送到你的fork仓库。</li>
<li>前往上游仓库<a href=\"https://github.com/modelica/ModelicaStandardLibrary.git\">https://github.com/modelica/ModelicaStandardLibrary.git</a>并提交一个<a href=\"https://help.github.com/articles/about-pull-requests/\">Pull Request</a>(PR)。
   <ul>
   <li>如果PR与某个问题相关，请通过问题编号引用，例如：#2161。</li>
   <li>一旦提交了Pull Request，你可以与合作者讨论并<a href=\"https://help.github.com/articles/about-pull-request-reviews/\">审查</a>潜在的更改，并在更改合并到仓库之前添加后续的提交。</li>
   <li>如果你还没有签署Modelica协会的贡献者许可协议(CLA)，你需要一次性完成签署。<br>
       你可以通过CLA Assistant服务和你的GitHub账户电子签署CLA，无需扫描和邮寄任何文件。</li>
   </ul></li>
<li>根据要求更新你的分支。如果有必要，将最新的\"master\"分支合并到你的主题分支，并解决所有合并冲突。</li>
</ol>

<p>
对于维护分支的更改，有一些特殊的指南。
</p>

<ul>
<li>对维护分支的每个更改，必须同时在\"master\"分支中进行cherry-pick操作(见上文)。
</li>
<li>当需要发布新的<code>BUGFIX</code>版本时，需要更新\"version\"和\"versionDate\"注释。</li>

<p>示例：
         <blockquote><pre>
annotation(version      = \"4.0.1\",
           versionDate  = \"2020-09-29\",
           dateModified = \"2020-09-29 07:40:19Z\",
           revisionId   = \"$F&#8203;ormat:%h %ci$\")
         </pre></blockquote>
</p>
<p>
\"dateModfied\"是可选的，但可能有助于确定发布的确切创建时间。
\"revisionId\"字段是一个特殊的注释，用于标识所发布的确切提交版本。
<br>
     示例:
     <blockquote>
     运行导出命令\"<code>git archive -o msl.zip v4.0.0</code>\"将把上述的\"revisionId\"占位符展开为类似以下内容：
        <blockquote><pre>revisionId = \"c04e23a0d 2020-04-01 12:00:00 +0200$\"</pre></blockquote>
     </blockquote>
     </li>
</ul>

<p>
作为建议，对维护分支的有效bug修复可能包括以下一种或多种更改：
</p>

<ul>
<li> 修正方程式。</li>
<li> 修正声明中的quantity/unit/defaultUnit属性。</li>
<li> 改进/修复文档。</li>
<li> 不允许在类(模型、包等)的公共部分或任何部分类的部分中引入新名称。否则，用户可能会使用这个新名称，并在存储其模型并使用旧的bug修复版本加载时，发生错误。</li>
<li> 只有在绝对必要修复bug时，才能在非部分类的保护部分引入新名称。这样做可能会导致向后不兼容，因为用户可能已经从这个类继承，并且已经使用了相同的名称。</li>
</ul>
</html>"              ));
      end VersionManagement;
      class Version_4_0_0_TY_1_build_2 "Version 4.0.0.TY.1 build 2 (December 30, 2024)"
        extends Modelica.Icons.ReleaseNotes;

        annotation (Documentation(info="<html><p>
<span style=\"font-size: 22px;\"><strong>版本说明</strong></span>
</p>
<p>
<span style=\"font-size: 19px;\"><strong>Version4.0.0.TY.1 build 2，2024.12.30</strong></span>
</p>
<p>
1.新增9个Blocks模型，具体见下表：
</p>
<table style=\"width: 100%;\"><tbody><tr><th colSpan=\"1\" rowSpan=\"1\" width=\"137.44\">模型名称</th><th colSpan=\"1\" rowSpan=\"1\" width=\"293.36\">模型路径</th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">功能描述</th></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">TriangleWave</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Blocks.Sources.TriangleWave</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">产生三角波信号</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">UnitDelayImproved</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Blocks.Discrete.UnitDelayImproved</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">单位延迟改进优化版本</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Relay</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Blocks.Nonlinear.Relay</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">两个常量之间切换输出</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">SlidingModeController</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Blocks.Discrete.SlidingModeController</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">滑模控制器块实现基于迟滞的滑模控制（SMC）</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">TimeSampler</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Blocks.Continuous.TimeSampler</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">根据仿真时间进行输入信号保持</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Pow</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Blocks.Math.Pow</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">幂函数块</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">LookupTable1D</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Blocks.Tables.NTables.LookupTable1D</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">一维查找表</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">LookupTable2D</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Blocks.Tables.NTables.LookupTable2D</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">二维查找表</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">LookupTable3D</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Blocks.Tables.NTables.LookupTable3D</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">三维查找表</td></tr></tbody></table><p>
2.新增6个Blocks案例模型，具体见下表：
</p>
<table style=\"width: 100%;\"><tbody><tr><th colSpan=\"1\" rowSpan=\"1\" width=\"223.56\">案例名称</th><th colSpan=\"1\" rowSpan=\"1\" width=\"359.08\">案例路径</th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">案例描述</th></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">SlidingModeControllerExample</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Blocks.Examples.SlidingModeControllerExample</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">滑膜控制例子展示</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">TimeSamplerTest</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Blocks.Examples.TimeSamplerTest</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">信号保持例子</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">LookupTable1D</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Blocks.Examples.LookupTable1D</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">一维查找表案例，其中断点和表格数据来自模型参数</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">LookupTable1D_File</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Blocks.Examples.LookupTable1D_File</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">一维查找表案例，其中断点和表格数据来自文件读取</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">LookupTable2D</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Blocks.Examples.LookupTable2D</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">二维查找表案例，其中断点和表格数据来自模型参数</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">LookupTable3D</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Blocks.Examples.LookupTable3D</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">三维查找表案例，其中断点和表格数据来自模型参数</td></tr></tbody></table><p>
3.优化PIDs模型，具体见下表；
</p>
<table style=\"width: 100%;\"><tbody><tr><th colSpan=\"1\" rowSpan=\"1\" width=\"196.24\">模型名称</th><th colSpan=\"1\" rowSpan=\"1\" width=\"381.96\">模型路径</th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">优化说明</th></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">PIDs</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Blocks.Continuous.PIDs</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">增加模式选择</td></tr></tbody></table><p>
<br>
</p>
</html>"                ));
      end Version_4_0_0_TY_1_build_2;
      class Version_4_0_0_TY_1_build_1 "Version 4.0.0.TY.1 build 1 (September 30, 2024)"
        extends Modelica.Icons.ReleaseNotes;

        annotation(Documentation(info = "<html><p>
<span style=\"font-size: 22px;\"><strong>版本说明</strong></span>
</p>
<p>
<span style=\"font-size: 19px;\"><strong>Version4.0.0.TY.1 build 1，2024.09.30</strong></span>
</p>
<p>
1.新增15个Blocks、Media模型和函数，具体见下表：
</p>
<table style=\"width: 100%;\"><tbody><tr><th colSpan=\"1\" rowSpan=\"1\" width=\"205.56\">模型名称</th><th colSpan=\"1\" rowSpan=\"1\" width=\"648.72\">模型路径</th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">功能描述</th></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">StateSpaceAlg</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Blocks.Continuous</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">优化后的状态空间法模型</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">AxFn</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Blocks.Continuous.Internal.Filter.Utilities.AxFn</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">用于StateSpaceAlg调用函数</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">PID_Parallel</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Blocks.Continuous.PID_Parallel</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">并联PID控制器模型</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">PIDs</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Blocks.Continuous.PIDs</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">理想的PID控制器和并联控制器两种可选</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">MultiVector</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Blocks.Math.MultiVector</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">向量的标量乘法: y[n] = k*u[n]</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">DivVector</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Blocks.Math.DivVector</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">向量的标量除法：y[n] = u[n]/k</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">VectorAdd</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Blocks.Math.VectorAdd</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">向量加法: y[n] = k1*u1[n]+k2*u2[n]</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">VI2VO</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Blocks.Interfaces.VI2VO</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">接口基类，用于VectorAdd调用</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">BooleanUnitDelay</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Blocks.Discrete.BooleanUnitDelay</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">单位延迟块，输入输出为布尔接口</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">IntergerUnitDelay</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Blocks.Discrete.IntergerUnitDelay</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">单位延迟块，输入输出为整型接口</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">density_derp_h</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Media.IdealGases.Common.SingleGasNasa.density_derp_h</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">求解定比焓下密度关于压力的偏导数</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">density_derh_p</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Media.IdealGases.Common.SingleGasNasa.density_derh_p</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">求解定压力下密度关于比焓的偏导数</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">density_derp_h</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Media.IdealGases.Common.MixtureGasNasa.density_derp_h</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">求解定比焓下密度关于压力的偏导数</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">density_derh_p</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Media.IdealGases.Common.MixtureGasNasa.density_derh_p</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">求解定压力下密度关于比焓的偏导数</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">setSat_p_diff2</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Media.Interfaces.PartialTwoPhaseMedium.setSat_p_diff2</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">setSat_p函数，2阶可微</td></tr></tbody></table><p>
2.新增4个Blocks、StateGraph案例模型，具体见下表：
</p>
<table style=\"width: 100%;\"><tbody><tr><th colSpan=\"1\" rowSpan=\"1\" width=\"211.64\">案例名称</th><th colSpan=\"1\" rowSpan=\"1\" width=\"644.44\">案例路径</th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">案例描述</th></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">StateSpaceComparison</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Blocks.Examples.StateSpaceComparison</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">展示StateSpace和StateSpaceAlg模型在相同条件下计算结果</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">VectorOperation</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Blocks.Examples.VectorOperation</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">向量运算案例</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Vertical_Launch</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.StateGraph.Examples.Vertical_Launch</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">示例演示了顺序操作过程</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">System_Controller</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.StateGraph.Examples.System_Controller</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">示例演示了状态机控制系统的整体应用</td></tr></tbody></table><p>
3.优化1个StateGraph状态机模型，具体见下表；
</p>
<table style=\"width: 100%;\"><tbody><tr><th colSpan=\"1\" rowSpan=\"1\" width=\"211\">模型名称</th><th colSpan=\"1\" rowSpan=\"1\" width=\"650.12\">模型路径</th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">优化说明</th></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">PartialStep</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.StateGraph.Interfaces.PartialStep</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">解决状态机模型的版本兼容性问题</td></tr></tbody></table><p>
4.修复Modelica.Icons图标等兼容问题。
</p>
</html>"            ));
      end Version_4_0_0_TY_1_build_1;
      class Version_4_0_0_TY_1 "Version 4.0.0.TY.1 (June 30, 2024)"
        extends Modelica.Icons.ReleaseNotes;

        annotation(Documentation(info = "<html><p>
<span style=\"font-size: 22px;\"><strong>版本说明</strong></span>
</p>
<p>
<span style=\"font-size: 19px;\"><strong>V4.0.0.TY.1，2024.06.30</strong></span>
</p>
<p style=\"text-align: left;\"><span style=\"font-family: 微软雅黑;\"> 1. </span><span style=\"color: rgb(51, 51, 51);\">同元标准库初版发布；</span>
</p>
<p style=\"text-align: left;\"><span style=\"font-family: 微软雅黑;\"> 2. </span><span style=\"color: rgb(51, 51, 51);\">适配同元商业模型库，在标准库Molideca4.0基础上新增标准库Molideca3.2.3部分内容，详见下表1；</span>
</p>
<p style=\"text-align: left;\"><span style=\"font-family: 微软雅黑;\"> 3. </span><span style=\"color: rgb(51, 51, 51);\">新增RealFFTWithOutput模型，增加两个输出接口y_amplitudes、y_phases；</span>
</p>
<p style=\"text-align: left;\"><span style=\"font-family: 微软雅黑;\"> 4. 新增</span><span style=\"color: rgb(0, 0, 0);\">TransferFunctionDia模型，传递函数清晰，分子分母可动态显示在图标层；</span>
</p>
<p style=\"text-align: left;\"><span style=\"color: rgb(0, 0, 0);\"> 5. 新增IntegerSwitch、IntegerGreater、Equality、IntegerEquality模型。</span>
</p>
<p>
<br>
</p>
<p>
同元基础模型库Versions 4.0.0.TY.1相对于Modelica标准库4.0.0的更新如下：<br>表1 新增模型列表:
</p>
<table style=\"width: 100%;\"><tbody><tr><th colSpan=\"1\" rowSpan=\"1\" width=\"470\">模型路径</th><th colSpan=\"1\" rowSpan=\"1\" width=\"434.6\">模型描述</th></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>Modelica.Blocks</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Blocks.Sources.Clock(隐藏)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">生成当前时间信号</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Blocks.Tables.Internal.readTimeTableData</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">从文本或MATLAB文件中读取表格数据</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Blocks.Tables.Internal.readTable1DData</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">从文本或MATLAB文件中读取表格数据</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Blocks.Tables.Internal.readTable2DData</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">从文本或MATLAB文件中读取表格数据</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Blocks.Types.InitPlD</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">定义PID和LimPID模块初始化的枚举</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>Modelica.Electrical</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Electrical.Analog,Basic.HeatingResistor</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">温度相关电阻</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Electrical.Analog.ldeal.ldealGyrator</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">理想回转器</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Electrical.MultiPhase (隐藏)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">用于单相或多相电气元件的库</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>Modelica.Mechanics</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Mechanics.MultiBody.Types.Init</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">初始化类型</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Mechanics.MultiBody.lcons.Motorlcon</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">电机图标</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>Modelica.Fluid</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Fluid.Examples.ControlledTankSystem.Utilities.RadioButton</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">按下时将其输出设置为“true”,并在\"reset”元素变为“true”时重置的按钮</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>Modelica.Media</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Media.Common.OneNonlinearEquation</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">以可靠有效的方式确定一个未知数的非线性代数方程的解，没有导数</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>Modelica.Math</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Math.Vectors.Utilities.householderVector</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">计算一个归一化向量以将向量a映射到向量b上</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Math.Vectors.Utilities.householderReflection</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">在具有正交向量u的平面上反映向量a</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Math.Matrices.LAPACK.dgegv</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">计算(A，B)系统的广义特征值</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Math.Matrices.LAPACK.dgelsx</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">计算秩缺陷A的实线性最小二乘问题的最小范数解</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Math.Matrices.LAPACK.dgelsx vec</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">计算秩缺陷A的实线性最小二乘问题的最小范数解</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Math.Matrices.LAPACK.dgeqpf</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">计算具有列透视的正方形或矩形矩阵A的QR因式分解</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Math.Matrices.Utilities.householderReflection</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">在具有正交向量u的平面上映射矩阵A的每个向量</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Math.Matrices.Utilities.householderSimilarityTransformation</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">相似性变换</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Math.tempinterpol1</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">线性插值</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.Math.tempInterpol2</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">矢量化线性插值</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>Modelica.lcons</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Modelica.lcons.RotationalSensor(隐藏)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">角度传感器图标</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>Modelica.Slunits(隐藏)</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">单位定义库</td></tr></tbody></table><p>

<br>
</p>
</html>"          ));
      end Version_4_0_0_TY_1;

      class Version_4_0_0 "Version 4.0.0 (June 4, 2020)"
        extends Modelica.Icons.ReleaseNotes;

        annotation(Documentation(info = "<html>
<p>
版本4.0.0与之前的版本<strong>不</strong>兼容。提供了一个经过测试的转换脚本，用于将3.x.y版本的模型和库转换为新版本。简要概述：
</p>
<ul>
<li>本次发布解决了大约<a href=\"modelica://Modelica/Resources/Documentation/Version-4.0.0/ResolvedGitHubIssues.html\">649个问题(包括432个拉取请求)</a>。</li>
<li>该版本基于最新的Modelica语言标准版本3.4。</li>
<li>库版本(即\"4.0.0\")遵循使用约定<code>MAJOR.MINOR.BUGFIX</code>的语义版本控制。
(参见<a href=\"modelica://Modelica.UsersGuide.ReleaseNotes.VersionManagement\">Version Management</a>查看详细信息)
并且与Modelica语言标准所使用的版本解耦。</li>
<li>已替换 3.x.y 版本中的过时类。</li>
<li>无法自动转换为替代实现的过时类已被移动到库ObsoleteModelica4。</li>
<li>本次版本的主要改进集中在类命名、包结构、约定和编码风格、图标、文档风格以及示例模型等方面的整体质量提升。以下子库已被重命名：
  <ol>
    <li>Modelica.SIunits &rarr; Modelica.Units.{SI, NonSI, Conversions}</li>
    <li>Modelica.Electrical.MultiPhase &rarr; Modelica.Electrical.Polyphase</li>
    <li>Modelica.Electrical.QuasiStationary &rarr; Modelica.Electrical.QuasiStatic</li>
  </ol></li>
<li>所使用的开源第三方软件组件的许可证以及Modelica标准库本身的BSD 3-Clause许可证可作为单独的<a href=\"modelica://Modelica/Resources/Licenses\">resources</a>提供。</li>
</ul>

<p>
Modelica版本4.0.0与版本3.2.3之间的确切差异已在<a href=\"modelica://Modelica/Resources/Documentation/Version-4.0.0/DifferencesTo323.html\">对比表</a>中总结。
</p>

<p>
以下<font color=\"blue\"><strong>Modelica packages</strong></font>已经过测试，它们与此版本的Modelica包兼容(按字母顺序列出)。
在此，使用Modelica版本3.2.3和Modelica版本的软件包生成了所列软件包的仿真结果与4.0.0 Beta.1版本产生的仿真结果进行了比较。
这些测试是由Dymola 2020/2020x/2021执行的：
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <th>Library</th>
    <th>Version</th>
    <th>Library provider</th>
  </tr>
  <tr>
    <td><a href=\"https://github.com/lbl-srg/modelica-buildings/issues/1789\">Buildings</a></td>
    <td>&nbsp;&gt;&nbsp;6.0.0</td>
    <td>LBNL</td>
  </tr>
  <tr>
    <td>BrushlessDCDrives</td>
    <td>1.1.1</td>
    <td>Dassault Syst&egrave;mes</td>
  </tr>
  <tr>
    <td>Clara</td>
    <td>1.5.0</td>
    <td>XRG Simulation GmbH and TLK-Thermo GmbH</td>
  </tr>
  <tr>
    <td>ClaraPlus</td>
    <td>1.3.0</td>
    <td>XRG Simulation GmbH and TLK-Thermo GmbH</td>
  </tr>
  <tr>
    <td>DriveControl</td>
    <td>4.0.0</td>
    <td>Anton Haumer</td>
  </tr>
  <tr>
    <td>DymolaModels</td>
    <td>1.1</td>
    <td>Dassault Syst&egrave;mes</td>
  </tr>
  <tr>
    <td>EDrives</td>
    <td>1.0.1</td>
    <td>Anton Haumer and Christian Kral</td>
  </tr>
  <tr>
    <td>ElectricalMachines</td>
    <td>0.9.1</td>
    <td>Anton Haumer</td>
  </tr>
  <tr>
    <td>ElectricPowerSystems</td>
    <td>1.3.1</td>
    <td>Dassault Syst&egrave;mes</td>
  </tr>
  <tr>
    <td>ElectrifiedPowertrains</td>
    <td>1.3.2</td>
    <td>Dassault Syst&egrave;mes</td>
  </tr>
  <tr>
    <td>ElectroMechanicalDrives</td>
    <td>2.2.0</td>
    <td>Christian Kral</td>
  </tr>
  <tr>
    <td>EMOTH</td>
    <td>1.4.1</td>
    <td>Anton Haumer</td>
  </tr>
  <tr>
    <td>HanserModelica</td>
    <td>1.1.0</td>
    <td>Christian Kral</td>
  </tr>
  <tr>
    <td>IBPSA</td>
    <td>&nbsp;&gt;&nbsp;3.0.0</td>
    <td>IBPSA Project 1</td>
  </tr>
  <tr>
    <td>KeywordIO</td>
    <td>0.9.0</td>
    <td>Christian Kral</td>
  </tr>
  <tr>
    <td>Modelica_DeviceDrivers</td>
    <td>1.8.1</td>
    <td>DLR, ESI ITI, and Linköping University (PELAB)</td>
  </tr>
  <tr>
    <td>Optimization</td>
    <td>2.2.4</td>
    <td>DLR</td>
  </tr>
  <tr>
    <td>PhotoVoltaics</td>
    <td>1.6.0</td>
    <td>Christian Kral</td>
  </tr>
  <tr>
    <td>PlanarMechanics</td>
    <td>1.4.1</td>
    <td>Dirk Zimmer</td>
  </tr>
  <tr>
    <td>Testing</td>
    <td>1.3</td>
    <td>Dassault Syst&egrave;mes</td>
  </tr>
  <tr>
    <td>ThermalSystems</td>
    <td>1.6.0</td>
    <td>TLK-Thermo GmbH</td>
  </tr>
  <tr>
    <td>TIL</td>
    <td>3.9.0</td>
    <td>TLK-Thermo GmbH</td>
  </tr>
  <tr>
    <td>TILMedia</td>
    <td>3.9.0</td>
    <td>TLK-Thermo GmbH</td>
  </tr>
  <tr>
    <td>TSMedia</td>
    <td>1.6.0</td>
    <td>TLK-Thermo GmbH</td>
  </tr>
  <tr>
    <td>VehicleInterfaces</td>
    <td>1.2.5</td>
    <td>Modelica Association</td>
  </tr>
  <tr>
    <td>WindPowerPlants</td>
    <td>1.2.0</td>
    <td>Christian Kral</td>
  </tr>
</table>

<p><br>
新增了以下<font color=\"blue\"><strong>新库</strong></font>:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><a href=\"modelica://Modelica.Clocked\">Modelica.Clocked</a></td>
    <td>该库可用于精确定义和同步不同采样率的采样数据系统。<br>这个库以前是
<a href=\"https://github.com/modelica/Modelica_Synchronous\">Modelica_Synchronous</a>。
(这个库是DLR与达索系统(Dassault system &egrave;mes Lund)密切合作开发的。)
    </td></tr>
<tr><td><a href=\"modelica://Modelica.Electrical.Batteries\">Modelica.Electrical.Batteries</a></td>
    <td>这个库提供了简单的电池模型.<br>
    (这个库是由Anton Haumer和Christian Kral开发的.)
    </td></tr>
</table>

<p><br>
以下<font color=\"blue\"><strong>新组件</strong></font>已添加到<font color=\"blue\"><strong>现有的</strong></font>库中:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><strong>Modelica.Blocks.Sources</strong></td></tr>
<tr><td>SineVariableFrequencyAndAmplitude<br>CosineVariableFrequencyAndAmplitude</td>
    <td>增加变幅变频信号源;提供了正弦和余弦波形。</td></tr>
<tr><td>Sinc</td>
    <td>增加信号源 <code> amplitude*sin(2*&pi;*f*t)/(2*&pi;*f*t)</code>.</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.Analog.Sources</strong></td></tr>
<tr><td>SineVoltageVariableFrequencyAndAmplitude<br>CosineVoltageVariableFrequencyAndAmplitude<br>SineCurrentVariableFrequencyAndAmplitude<br>CosineCurrentVariableFrequencyAndAmplitude</td>
    <td>增加可变振幅和频率的电压和电流源;提供了正弦和余弦波形.</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.Machines.Sensors</strong></td></tr>
<tr><td>SinCosResolver</td>
    <td>增加了两个正弦和两个余弦轨道的解析器，用于驱动控制应用.</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.Machines.Utilities</strong></td></tr>
<tr><td>SwitchYDwithArc</td>
    <td>增加了带弧线模型的三角形开关和两个开关事件之间的时间延迟.</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.PowerConverters</strong></td></tr>
<tr><td>ACAC</td>
    <td>增加了单相和多相可控硅模型(AC/AC转换器).</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Magnetic.FluxTubes.Shapes.FixedShape</strong></td></tr>
<tr><td>HollowCylinderCircumferentialFlux<br>Toroid</td>
    <td>增加了空心圆柱体和圆截面环面的周向通量模型。</td></tr>
<tr><td colspan=\"2\"><strong>Magnetic.QuasiStatic.FluxTubes.Shapes.FixedShape</strong></td></tr>
<tr><td>HollowCylinderCircumferentialFlux<br>Toroid</td>
    <td>增加了空心圆柱体和圆截面环面的周向通量模型.</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Mechanics.MultiBody.Visualizers.Advanced</strong></td></tr>
<tr><td>Vector</td>
    <td>增加了用于矢量(力，扭矩等)可视化的三维动画</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Mechanics.Translational.Components</strong></td></tr>
<tr><td>RollingResistance</td>
    <td>包含倾斜和滚动阻力系数的滚动车轮的附加阻力.</td></tr>
<tr><td>Vehicle</td>
    <td>增加了考虑质量和惯性、阻力和滚动阻力、倾斜阻力的简单车辆模型.</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Math</strong></td></tr>
<tr><td>BooleanVectors.andTrue</td>
    <td>类似于<code>allTrue</code>，但在空输入向量上返回<code>true</code>.</td></tr>
<tr><td>Matrices.LAPACK.dgeqp3</td>
    <td>计算方形或矩形矩阵的列枢轴QR分解.</td></tr>
<tr><td>Random.Utilities.automaticLocalSeed</td>
    <td>根据实例名创建一个自动本地种子。</td></tr>
</table>

<p><br>
以下<font color=\"blue\"><strong>现有组件</strong></font> <font color=\"blue\"><strong>以<font color=\"blue\"><strong>向后兼容</strong></font>的方式进行了</strong></font>改进:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><strong>Modelica.Blocks.Sources</strong></td></tr>
<tr><td>CombiTimeTable</td>
    <td>增加二阶导数和修改Akima插值.</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Blocks.Tables</strong></td></tr>
<tr><td>CombiTable1Ds<br>CombiTable1Dv</td>
    <td>增加了二阶导数和修改的Akima插值.</td></tr>
<tr><td>CombiTable2Ds<br>CombiTable2Dv</td>
    <td>附加二阶导数.</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.Analog.Basic</strong></td></tr>
<tr><td>Gyrator</td>
    <td>在去除了IdealGyrator后作为广义的gyrator模型.</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.Analog.Ideal</strong></td></tr>
<tr><td>IdealizedOpAmpLimited</td>
    <td>运算放大器增加同伦.</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.Semiconductors</strong></td></tr>
<tr><td>NPN<br>PNP</td>
    <td>增加可选基板连接器.</td></tr>
</table>

<p><br>
以下<font color=\"blue\"><strong> </strong>现有组件</strong></font>已被<font color=\"blue\"><strong>以<font color=\"blue\"><strong>不向后兼容</strong></font>的方式更改</strong></font>:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><strong>Modelica.Blocks</strong></td></tr>
<tr><td>Nonlinear.Limiter<br>Nonlinear.VariableLimiter</td>
    <td>多余的参数<code>limitsAtInit</code>已被删除。</td></tr>
<tr><td>Continuous.PID</td>
    <td>初始化选项<code>initType</code>&nbsp;=&nbsp;<code>InitPID.DoNotUse_InitialIntegratorState</code>仅初始化集成商状态已被删除。此选项已被转换为初始化集成商状态和派生状态，即<code>initType</code>&nbsp;=&nbsp;<code>Init.InitialState</code>.</td></tr>
<tr><td>Continuous.LimPID</td>
    <td>多余的参数<code>limitsAtInit</code>已被删除。<br>初始化选项<code>initType</code> = <code>InitPID. DoNotUse_InitialIntegratorState</code>仅初始化集成商状态已被删除。此选项已被转换为初始化集成商状态和派生状态，即<code>initType</code> = <code>Init. InitialState</code>.</td></tr>
<tr><td>Nonlinear.DeadZone</td>
    <td>多余的参数<code>deadZoneAtInit</code>已被删除.</td></tr>
<tr><td>Interfaces.PartialNoise<br>Noise.UniformNoise<br>Noise.NormalNoise<br>Noise.TruncatedNormalNoise<br>Noise.BandLimitedWhiteNoise</td>
    <td>如果<code>useAutomaticLocalSeed</code>设置为true，则作为Modelica.Math.Random.Utilities.automaticLocalSeed中更新计算的副作用，<code>localSeed</code>参数的计算方式会有所不同。</td></tr>
<tr><td>Types.InitPID</td>
    <td>枚举类型已转换为<code>Types.Init</code>，除了可选的<code>InitPID.DoNotUse_InitialIntegratorState</code>，转换为<code>Init.InitialState</code>导致不同的初始化行为.</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.Machines.Utilities</strong></td></tr>
<tr><td>SwitchYD</td>
    <td><a href=\"modelica://Modelica.Electrical.Polyphase.Ideal.IdealCommutingSwitch\">IdealCommutingSwitch</a>被<a href=\"modelica://Modelica.Electrical.Polyphase.Ideal.IdealOpeningSwitch\">IdealOpeningSwitch</a>和<a href=\"modelica://Modelica.Electrical.Polyphase.Ideal.IdealClosingSwitch\">IdealClosingSwitch</a>允许两个切换动作之间的时间延迟。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.Spice3</strong></td></tr>
<tr><td>Internal.MOS2<br>Semiconductors.M_NMOS2<br>Semiconductors.M_PMOS2</td>
    <td>最后一个参数<code>vp</code>已被删除。<br>已删除过时的变量<code>cc_obsolete</code>、<code>icqmGB</code>、<code>icqmGS</code>、<code>icqmGD</code>、<code>MOScapgd</code>、<code>MOScapgs</code>、<code>MOScapgb</code>、<code>qm</code>和<code>vDS</code>。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities</strong></td></tr>
<tr><td>SwitchYD</td>
    <td><a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Ideal. IdealCommutingSwitch\">IdealCommutingSwitch</a>被<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Ideal. IdealOpeningSwitch\">IdealOpeningSwitch</a>和<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Ideal. IdealClosingSwitch\">IdealClosingSwitch</a>允许两个切换动作之间的时间延迟。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Mechanics.MultiBody.Forces</strong></td></tr>
<tr><td>WorldForce</td>
    <td>参数<code>diameter</code>和<code>N_to_m</code>已被删除。</td></tr>
<tr><td>WorldTorque</td>
    <td>参数<code>diameter</code>和<code>Nm_to_m</code>已被删除.</td></tr>
<tr><td>WorldForceAndTorque</td>
    <td>删除了<code>forceDiameter</code>、<code>torqueDiameter</code>、<code>N_to_m</code>和<code>Nm_to_m</code>参数。</td></tr>
<tr><td>Force</td>
    <td>参数<code>N_to_m</code>已被删除。</td></tr>
<tr><td>Torque</td>
    <td>参数<code>Nm_to_m</code>已被删除。</td></tr>
<tr><td>ForceAndTorque</td>
    <td>参数<code>N_to_m</code>和<code>Nm_to_m</code>已被删除。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Mechanics.MultiBody.Joints</strong></td></tr>
<tr><td>Prismatic</td>
    <td>多余的常量<code>s_offset</code>已被删除。</td></tr>
<tr><td>Revolute</td>
    <td>多余的常数<code>phi_offset</code>已被删除。</td></tr>
<tr><td>FreeMotion<br>FreeMotionScalarInit</td>
    <td>参数<code>arrowDiameter</code>已被删除。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Mechanics.MultiBody.Parts</strong></td></tr>
<tr><td>Body</td>
    <td>多余的参数<code>z_a_start</code>已被删除。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Mechanics.MultiBody.Sensors</strong></td></tr>
<tr><td>AbsoluteSensor<br>RelativeSensor<br>Distance</td>
    <td>参数<code>arrowDiameter</code>已被删除。</td></tr>
<tr><td>CutForce</td>
    <td>参数<code>forceDiameter</code>和<code>N_to_m</code>已被删除。</td></tr>
<tr><td>CutForce</td>
    <td>参数<code>torqueDiameter</code>和<code>Nm_to_m</code>已被删除。</td></tr>
<tr><td>CutForceAndTorque</td>
    <td>删除了<code>forceDiameter</code>、<code>torqueDiameter</code>、<code>N_to_m</code>和<code>Nm_to_m</code>参数。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Mechanics.MultiBody.Visualizers</strong></td></tr>
<tr><td>Advanced.Arrow<br>Advanced.DoubleArrow<br>FixedArrow<br>SignalArrow</td>
    <td>参数<code>直径</code>已被删除。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Fluid.Machines</strong></td></tr>
<tr><td>PartialPump</td>
    <td>多余的参数<code>show_NPSHa</code>已被删除。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Thermal.HeatTransfer</strong></td></tr>
<tr><td>Fahrenheit.FromKelvin<br>Rankine.FromKelvin<br>Rankine.ToKelvin</td>
    <td>多余的参数<code>n</code>已被删除。</td></tr>
</table>

<p><br>
以下<font color=\"red\"><strong>critical errors</strong></font>已被修复(即错误)
这可能导致错误的模拟结果):
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><strong>Modelica.Blocks.Math</strong></td></tr>
<tr><td>Pythagoras</td>
    <td>如果<code>u1IsHypotenuse</code>为<code>true</code>，则不正确考虑负<code>y2</code>的情况。这已经被纠正了。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.Semiconductors</strong></td></tr>
<tr><td>Diode</td>
    <td>修正了当前方程中的单位误差。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.Spice3.Additionals</strong></td></tr>
<tr><td>poly</td>
    <td>没有正确考虑单系数单变量的情况。这已经被纠正了。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Fluid.Dissipation.PressureLoss.General</strong></td></tr>
<tr><td>dp_volumeFlowRate_DP<br>dp_volumeFlowRate_MFLOW</td>
    <td>如果压降是体积流量的线性函数，则计算质量流量是不正确的。这已经被纠正了。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Media.Air.MoistAir</strong></td></tr>
<tr><td>density_derX<br>s_pTX<br>s_pTX_der</td>
    <td>这个计算是错误的。这已经被纠正了。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Media.Air.ReferenceAir.Air_Base</strong></td></tr>
<tr><td>BaseProperties</td>
    <td>比气常数<code>R_s</code>单位考虑不正确。这已经被纠正了。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Media.IdealGases.Common.Functions</strong></td></tr>
<tr><td>s0_Tlow_der</td>
    <td>这个计算是错误的。这已经被纠正了。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Media.IdealGases.Common.MixtureGasNasa</strong></td></tr>
<tr><td>T_hX</td>
    <td>不考虑函数输入<code> excenthform </code>、<code>refChoice</code>和<code>h_off</code>。这已经被纠正了。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Media.Incompressible.TableBased</strong></td></tr>
<tr><td>T_ph</td>
    <td>没有考虑压力疏忽。这已经被纠正了。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Media.R134a.R134a_ph</strong></td></tr>
<tr><td>setState_pTX</td>
    <td>只适用于单相情况:计算密度的牛顿迭代可能收敛到错误的根。这已经得到了改进。</td></tr>
<tr><td>setState_dTX<br>setState_psX</td>
    <td>The calculation was wrong in two-phase regime. This has been corrected.</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Utilities.System</strong></td></tr>
<tr><td>getTime</td>
    <td>只有在为Windows操作系统编译实现源文件(modelicinternal .c)时，才能正确返回月份和年份。这已经被纠正了。</td></tr>
</table>
</html>"                  ));
      end Version_4_0_0;

      class Version_3_2_3 "Version 3.2.3 (January 23, 2019)"
        extends Modelica.Icons.ReleaseNotes;

        annotation(Documentation(info = "<html>
<p>
版本3.2.3向后兼容版本3.2.2，也就是说，使用版本3.0、3.0.1、3.1、3.2、3.2.1或3.2.2开发的模型在版本3.2.3中无需任何修改也能正常工作。
本版本是一次\"清理\"更新，主要强调质量改进和工具兼容性。
目标是所有<a href=\"https://www.modelica.org/tools\">Modelica工具</a>都能支持此包，并以相同的方式进行解析。简要概述：
</p>

<ul>
<li>大约<a href=\"modelica://Modelica/Resources/Documentation/Version-3.2.3/ResolvedGitHubIssues.html\">557 issues (包括pull requests)</a>
已在此版本中解决。</li>
<li>新增了<strong>94个</strong>组件模型和模块，<strong>36个</strong>示例模型和<strong>9个</strong>函数。</li>
<li>许可证已更改为BSD 3-clause，请访问: <a href=\"https://modelica.org/licenses/modelica-3-clause-bsd\">https://modelica.org/licenses/modelica-3-clause-bsd</a>.</li>
</ul>

<p>
版本3.2.3与版本3.2.2之间的确切差异已在<a href=\"modelica://Modelica/Resources/Documentation/Version-3.2.3/DifferencesTo322.html\">对比表</a>中总结。
</p>

<p><br>
以下<font color=\"blue\"><strong>新增库</strong></font>:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes\">Modelica.Magnetic.QuasiStatic.FluxTubes</a></td>
    <td>
    该库为研究具有集总磁网络的准静态电磁器件提供了模型
以类似的方式 <a href=\"modelica://Modelica.Magnetic.FluxTubes\">Modelica.Magnetic.FluxTubes</a>.<br>
    (这个库是由Christian Kral开发的。)
    </td></tr>
<tr><td><a href=\"modelica://Modelica.Electrical.Machines.Examples.ControlledDCDrives\">Modelica.Electrical.Machines.Examples.ControlledDCDrives</a></td>
    <td>
    这个库演示了永磁直流电机的控制:电流控制，速度控制和位置控制
以及子库Utilities中的必要组件。<br>
    (这个库是由Anton Haumer开发的。)
    </td></tr>
</table>

<p><br>
新增了以下<font color=\"blue\"><strong>组件</strong></font
<font color=\"blue\"><strong>现有</strong></font>库:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><strong>Modelica.Blocks.Interfaces.Adaptors</strong></td></tr>
<tr><td width=\"150\">FlowToPotentialAdaptor<br>PotentialToFlowAdaptor</td>
    <td> 用于生成fmu的部分适配器，可选地考虑一阶和二阶导数;
对于不同域中的一致组件。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Blocks.Math</strong></td></tr>
<tr><td width=\"150\">Power</td>
    <td>计算输入信号的功率。</td></tr>
<tr><td width=\"150\">WrapAngle</td>
    <td> 将输入端的角度信号封装到区间 ]-&pi;, &pi;] or [0, 2&pi;[.</td></tr>
<tr><td width=\"150\">Pythagoras</td>
    <td> 这个块确定两条腿的斜边或者一条腿与另一条腿的斜边。</td></tr>
<tr><td width=\"150\">TotalHarmonicDistortion</td>
    <td> 这个模块计算输入信号的THD。</td></tr>
<tr><td width=\"150\">RealFFT</td>
    <td> 该块对输入进行采样并计算FFT，在模拟结束时将结果写入mat文件。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Blocks.Routing</strong></td></tr>
<tr><td width=\"150\">Multiplex</td>
    <td>用于<em>任意</em>数量输入信号的多路复用器块</td></tr>
<tr><td width=\"150\">DeMultiplex</td>
    <td>用于<em>任意</em>数量输出信号的解复用器块</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Blocks.Tables</strong></td></tr>
<tr><td width=\"150\">CombiTable2Dv</td>
    <td>CombiTable2D(二维表查找)的变体，具有矢量输入和矢量输出</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.ComplexBlocks.Routing</strong></td></tr>
<tr><td width=\"150\">Replicator<br>ExtractSignal<br>Extractor<br>ComplexPassThrough</td>
    <td> 类似于实际实现的复杂实现。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.ComplexBlocks.ComplexMath</strong></td></tr>
<tr><td width=\"150\">Bode</td>
    <td> 确定伯德图的变量。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.ComplexBlocks.Sources</strong></td></tr>
<tr><td width=\"150\">RampPhasor</td>
    <td> 相位源具有恒定角度和倾斜振幅的相量源</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.Analog.Basic</strong></td></tr>
<tr><td width=\"150\">GeneralCurrentToVoltageAdaptor<br>GeneralVoltageToCurrentAdaptor</td>
    <td> 用于产生fmu的适配器，可选地考虑一阶和二阶导数。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.Analog.Sensors</strong></td></tr>
<tr><td width=\"150\">MultiSensor</td>
    <td> 同时测量电压、电流和功率。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.Polyphase.Sensors</strong></td></tr>
<tr><td width=\"150\">MultiSensor</td>
    <td> 同时测量各相电压、电流、有功功率及总功率。</td></tr>
<tr><td width=\"150\">AronSensor</td>
    <td> 用Aron电路中的两个单相功率传感器测量三相系统的有功功率。</td></tr>
<tr><td width=\"150\">ReactivePowerSensor</td>
    <td> 测量三相系统的无功功率。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.Machines.Examples</strong></td></tr>
<tr><td width=\"150\">SMEE_DOL</td>
    <td> 电激励同步电机，通过阻尼笼直接在线启动;
通过增加激励电压来同步。</td></tr>
<tr><td width=\"150\">SMR_DOL</td>
    <td> 同步磁阻电机，通过阻尼笼直接在线启动;
达到同步速度时同步。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.Machines.Sensors</strong></td></tr>
<tr><td width=\"150\">HallSensor</td>
    <td> 简单的霍尔传感器模型，测量与相位1方向对齐的角度。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.PowerConverters.DCAC.Control</strong></td></tr>
<tr><td width=\"150\">PWM<br>SVPWM<br>IntersectivePWM</td>
    <td> 标准三相pwm算法:空间矢量和相交。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.PowerConverters.DCDC</strong></td></tr>
<tr><td width=\"150\">ChopperStepUp</td>
    <td> 升压斩波器(升压转换器)模型。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.QuasiStatic.SinglePhase.Sensors</strong></td></tr>
<tr><td width=\"150\">MultiSensor</td>
    <td> 同时测量电压、电流和视在功率。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.QuasiStatic.Polyphase.Sensors</strong></td></tr>
<tr><td width=\"150\">MultiSensor</td>
    <td> 同时测量m相电压、电流、视在功率及总视在功率。</td></tr>
<tr><td width=\"150\">AronSensor</td>
    <td> 用Aron电路中的两个单相功率传感器测量三相系统的有功功率.</td></tr>
<tr><td width=\"150\">ReactivePowerSensor</td>
    <td> 测量三相系统的无功功率。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.QuasiStatic.{SinglePhase, Polyphase}.Sources</strong></td></tr>
<tr><td width=\"150\">FrequencySweepVoltageSource<br>FrequencySweepCurrentSource</td>
    <td> 电压源和电流源集成扫频。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Mechanics.MultiBody</strong></td></tr>
<tr><td width=\"150\">Visualizers.Rectangle</td>
    <td>矩形平面</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Mechanics.Rotational.Components</strong></td></tr>
<tr><td width=\"150\">GeneralAngleToTorqueAdaptor<br>GeneralTorqueToAngleAdaptor</td>
    <td> 用于生成fmu的适配器，可选地考虑一阶和二阶导数。<br>
注意:这些适配器给出的结果与:<br>
         AngleToTorqueAdaptor<br>TorqueToAngleAdaptor<br>
         但是从<a href=\"modelica://Modelica.Blocks.Interfaces.Adaptors\">Modelica.Blocks.Interfaces.Adaptors</a>
就像其他领域的适配器一样.</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Mechanics.Rotational.Sources</strong></td></tr>
<tr><td width=\"150\">EddyCurrentTorque</td>
    <td> 旋转涡流制动器。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Mechanics.Translational.Components</strong></td></tr>
<tr><td width=\"150\">GeneralForceToPositionAdaptor<br>GeneralPositionToForceAdaptor</td>
    <td> 用于产生fmu的适配器，可选地考虑一阶和二阶导数。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Mechanics.Translational.Sources</strong></td></tr>
<tr><td width=\"150\">EddyCurrentForce</td>
    <td> 平动涡流制动器。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Magnetic.FundamentalWave.Examples</strong></td></tr>
<tr><td width=\"150\"> </td>
    <td> 许多新的基本波机测试实例。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Magnetic.QuasiStatic.FundamentalWave.Sensors</strong></td></tr>
<tr><td width=\"150\">RotorDisplacementAngle</td>
    <td> 测量准静态机器的转子位移角。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Thermal.HeatTransfer.Components</strong></td></tr>
<tr><td width=\"150\">GeneralHeatFlowToTemperatureAdaptor<br>GeneralTemperatureToHeatFlowAdaptor</td>
    <td> 用于产生fmu的适配器，可选地考虑一阶导数。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Thermal.FluidHeatFlow.Examples</strong></td></tr>
<tr><td width=\"150\">WaterPump<br>TestOpenTank<br>TwoTanks<br>TestCylinder</td>
    <td> 新的示例测试和演示了新的问题。增强的组件。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Thermal.FluidHeatFlow.Components</strong></td></tr>
<tr><td width=\"150\">Pipe</td>
    <td> 一个带有可选heatPort的管道模型，它取代了isolatedPipe和heatedPipe。</td></tr>
<tr><td width=\"150\">OpenTank</td>
    <td> 一个简单的开放式水箱模型。</td></tr>
<tr><td width=\"150\">Cylinder</td>
    <td> 具有平移凸缘的活塞/气缸的简单模型。</td></tr>
<tr><td width=\"150\">OneWayValve</td>
    <td> 一个简单的单向阀模型(相当于一个电气理想二极管)</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Thermal.FluidHeatFlow.Media</strong></td></tr>
<tr><td width=\"150\">Water_10degC<br>Water_90degC<br>Glycol20_20degC<br>Glycol50_20degC<br>MineralOil</td>
    <td> 定义媒体属性的几个新记录。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Thermal.FluidHeatFlow.Interfaces</strong></td></tr>
<tr><td width=\"150\">SinglePortLeft</td>
    <td> 取代(现在已经过时的)部分模型Ambient，也用于Sources.AbsolutePressure。</td></tr>
<tr><td width=\"150\">SinglePortBottom</td>
    <td> 与SinglePortLeft相同，但在底部有flowPort;用于新组件。OpenTank模型。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Constants</strong></td></tr>
<tr><td width=\"150\">q</td>
    <td> 电子的基本电荷。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Icons</strong></td></tr>
<tr><td width=\"150\">FunctionsPackage</td>
    <td> 此图标表示包含函数的包。</td></tr>
<tr><td width=\"150\">RecordPackage</td>
    <td> 此图标表示包含记录的包。</td></tr>
</table>

<p><br>
<font color=\"blue\"><strong>现有组件</strong></font>
已被标记为<font color=\"blue\"><strong>过时</strong></font>并将被
<font color=\"blue\"><strong>已移除</strong></font><font color=\"blue\"><strong>现有组件</strong></font>
已被标记为<font color=\"blue\"><strong>过时</strong></font>并将被
<font color=\"blue\"><strong>已移除</strong></font>
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><strong>Modelica.Blocks.Interfaces.Adaptors</strong></td></tr>
<tr><td>SendReal<br>SendBoolean<br>SendInteger<br>ReceiveReal<br>ReceiveBoolean<br>ReceiveInteger</td>
    <td>使用可扩展连接器代替。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.StateGraph.Temporary</strong></td></tr>
<tr><td>SetRealParameter</td>
    <td>使用参数Real代替。</td></tr>
<tr><td>anyTrue</td>
    <td>使用 Modelica.Math.BooleanVectors.anyTrue 代替.</td></tr>
<tr><td>allTrue</td>
    <td>Use Modelica.Math.BooleanVectors.allTrue instead 代替.</td></tr>
<tr><td>RadioButton</td>
    <td>使用 future model from Modelica.Blocks.Interaction 代替.</td></tr>
<tr><td>NumericValue</td>
    <td>使用 Modelica.Blocks.Interaction.Show.RealValue 代替.</td></tr>
<tr><td>IndicatorLamp</td>
    <td>使用 Modelica.Blocks.Interaction.Show.BooleanValue 代替.</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.Digital.Converters</strong></td></tr>
<tr><td>LogicToXO1<br>LogicToXO1Z</td>
    <td>使用 LogicToX01 or LogicToX01Z 代替。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.Machines</strong></td></tr>
<tr><td>BasicMachines.Components.BasicTransformer</td>
    <td>使用 Interfaces.PartialBasicTransformer 代替.</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.Spice3.Internal</strong></td></tr>
<tr><td>BJT</td>
    <td>使用 BJT2 代替.</td></tr>
<tr><td>Bjt3.*</td>
    <td>使用 revised classes 代替.</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Mechanics.MultiBody</strong></td></tr>
<tr><td>Examples.Loops.Utilities.GasForce</td>
    <td>使用 Examples.Loops.Utilities.GasForce2 代替.</td></tr>
<tr><td>Sensors.TansformAbsoluteVector<br>Sensors.TansformRelativeVector</td>
    <td>使用 Sensors.TransformAbsoluteVector or Sensors.TransformRelativeVector 代替.</td></tr>
<tr><td>Visualizers.Ground</td>
    <td>使用 ground plane visualization of World or Visualizers.Rectangle 代替.</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Fluid.Icons</strong></td></tr>
<tr><td>VariantLibrary<br>BaseClassLibrary</td>
    <td>使用 icons from Modelica.Icons 代替.</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Media.Examples</strong></td></tr>
<tr><td>Tests.Components.*</td>
    <td>使用 classes from Utilities 代替.</td></tr>
<tr><td>TestOnly.*<br>Tests.MediaTestModels.*</td>
    <td>使用 test models from ModelicaTest.Media 代替.</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Thermal.FluidHeatFlow</strong></td></tr>
<tr><td>Components.IsolatedPipe<br>Components.HeatedPipe</td>
    <td>从新的管道模型扩展到可选的heatPort。</td></tr>
<tr><td>Interfaces.Ambient</td>
    <td>从 SinglePortLeft.</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Math</strong></td></tr>
<tr><td>baseIcon1<br>baseIcon2</td>
    <td>使用 icons from Modelica.Math.Icons 代替.</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Icons</strong></td></tr>
<tr><td>Library<br>Library2<br>GearIcon<br>MotorIcon<br>Info</td>
    <td>使用 (substitute) icons from Modelica.Icons, Modelica.Mechanics.Rotational.Icons or Modelica.Electrical.Machines.Icons 代替.</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.SIunits.Conversions.NonSIunits</strong></td></tr>
<tr><td>FirstOrderTemperaturCoefficient<br>SecondOrderTemperaturCoefficient</td>
    <td>使用 Modelica.SIunits.LinearTemperatureCoefficientResistance or Modelica.SIunits.QuadraticTemperatureCoefficientResistance 代替.</td></tr>
</table>

<p><br>
<font color=\"blue\"><strong>现有组件</strong></font>
<font color=\"blue\"><strong> </strong></font>在
<font color=\"blue\"><strong>向后兼容</strong></font>方式:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><strong>Modelica.Blocks.Continuous</strong></td></tr>
<tr><td>Integrator<br>LimIntegrator</td>
    <td>增加了可选的重置和设定值输入。</td></tr>
<tr><td>LimPID</td>
    <td>增加了一个可选的前馈输入。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Blocks.Sources</strong></td></tr>
<tr><td>CombiTimeTable</td>
    <td>在线性插值和非复制样本点情况下，不考虑间隔边界处的时间事件。这已经通过引入新的参数<code>timeEvents</code>得到了推广，默认选项总是在间隔边界处生成时间事件，这可能导致更慢，但更准确的模拟。</td></tr>
<tr><td>BooleanTable<br>IntegerTable</td>
    <td>增加了设置开始时间，移位时间和外推类型的选项，特别是设置周期性外推。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Blocks.Tables</strong></td></tr>
<tr><td>CombiTable1D<br>CombiTable1Ds<br>CombiTable2D</td>
    <td>增加了设置外推类型的选项，并可选择在外推表输入时打印警告。</td></tr>
</table>

<p><br>
以下<font color=\"blue\"><strong> </strong>现有组件</strong></font>已被<font color=\"blue\"><strong>以<font color=\"blue\"><strong>不向后兼容</strong></font>的方式更改</strong></font>:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><strong>Modelica.Blocks</strong></td></tr>
<tr><td>Interfaces.PartialNoise<br>Noise.UniformNoise<br>Noise.NormalNoise<br>Noise.TruncatedNormalNoise<br>Noise.BandLimitedWhiteNoise</td>
    <td>作为修正计算的副作用 Modelica.Math.Random.Utilities.impureRandomInteger 如果<code>useAutomaticLocalSeed</code>设置为true，则<code>localSeed</code>参数的计算方式不同。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Mechanics.MultiBody</strong></td></tr>
<tr><td>World</td>
    <td>添加了新的参数<code>animateGround</code>用于可选地平面可视化。<br>
将World模型(MSL 3.0、3.0.1、3.1、3.2、3.2.1或3.2.2)复制为自己的World模型并将其用作内部世界组件的用户可能已经破坏了他们的模型。
通常，对于具有子类型的MSL模型(由于内部/外部)，强烈建议从这个MSL模型扩展，而不是复制它。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Media.Interfaces</strong></td></tr>
<tr><td>PartialMedium</td>
    <td>增加了新的常量<code>C_default</code>作为介质中痕量物质的默认值。<br>
如果用户从PartialMedium包继承创建了自己的介质，并且已经添加了C_default常量，那么可能会破坏他们的模型。<br>
复制了PartialMedium包(MSL 3.0、3.0.1、3.1、3.2、3.2.1或3.2.2)作为自己的Medium包的用户可能已经破坏了他们的模型。
通常，对于具有子类型的MSL类(由于可替换声明)，强烈建议从这个MSL类扩展，而不是复制它。</td></tr>
</table>

<p><br>
以下<font color=\"red\"><strong>临界错误</strong></font>已被修复(即错误)
这可能导致错误的模拟结果):
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><strong>Modelica.Blocks.Sources</strong></td></tr>
<tr><td>TimeTable</td>
    <td>无法再确定<code>时间表</code>输出的导数。这已经被纠正了。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Media.Air</strong></td></tr>
<tr><td>MoistAir.molarMass<br>ReferenceMoistAir.molarMass</td>
    <td>函数输出<code>MM</code>计算错误。处理步骤这已经被纠正了。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Media.IdealGases.Common.Functions</strong></td></tr>
<tr><td>thermalConductivityEstimate</td>
    <td>函数输出<code>lambda</code>的计算对于修改后的Eucken相关是错误的，即如果<code>方法</code>被设置为2。这已经被纠正了。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Media.IdealGases.Common.SingleGasesData</strong></td></tr>
<tr><td>CH2<br>CH3<br>CH3OOH<br>C2CL2<br>C2CL4<br>C2CL6<br>C2HCL<br>C2HCL3<br>CH2CO_ketene<br>O_CH_2O<br>HO_CO_2OH<br>CH2BrminusCOOH<br>C2H3CL<br>CH2CLminusCOOH<br>HO2<br>HO2minus<br>OD<br>ODminus</td>
    <td><code>blow</code>、<code>ahigh</code>和<code>bhigh</code>的系数是错误的。这已经被纠正了。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Media.IdealGases.Common.MixtureGasNasa</strong></td></tr>
<tr><td>mixtureViscosityChung</td>
    <td>函数输出<code>etaMixture</code>的计算错误。这已经被纠正了。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Media.Incompressible.TableBased</strong></td></tr>
<tr><td>BaseProperties</td>
    <td>对于基于表格的介质，气体常数<code>R</code>的单位没有被正确考虑。这已经被纠正了。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Math.Random.Utilities</strong></td></tr>
<tr><td>impureRandomInteger</td>
    <td>没有计算函数输出<code>y</code>以产生最小值<code>imin</code>为1的离散均匀分布。这已经被纠正了。</td></tr>
</table>

</html>"                  ));
      end Version_3_2_3;

      class Version_3_2_2 "Version 3.2.2 (April 3, 2016)"
        extends Modelica.Icons.ReleaseNotes;

        annotation(Documentation(info = "<html>
<p>
版本3.2.2向后兼容版本3.2.1，即使用
版本3.0、3.0.1、3.1、3.2或3.2.1也可以在不做任何更改的情况下与版本3.2.2一起工作
(通常不重要的、不向后兼容的更改除外)
外部对象库，以及3.2.1 Build.3中针对非圆形管道引入的一个错误修复
如果用户基于构造新的管道模型，则可能是非向后兼容的
Modelica.Fluid.Pipes.BaseClasses.WallFriction。PartialWallFriction(详情见下文)。
</p>

<ul>
<li> 这个版本的Modelica包<strong>与</strong>完全兼容
Modelica Specification <strong>3.2 revision 2</strong>.<br>&nbsp;
     </li>

<li> 关于<strong>240</strong>票据已在此版本和以前的维护版本中修复:
     <ul>
     <li> <strong>Version 3.2.1 Build.3</strong>(2015年7月30日)相对于3.2.1 Build.2(2013年8月14日):<br>
关于<a href=\"modelica://Modelica/Resources/Documentation/Version-3.2.1/ResolvedTracTickets-build-3.html\">103 tickets</a>
已在此维护版本中修复。<br>&nbsp;</li>

     <li> <strong>Version 3.2.1 Build.4</strong> (September 30, 2015)相对于3.2.1 Build.3 (July 30, 2015):
          <ul>
            <li> 关于<a href=\"modelica://Modelica/Resources/Documentation/Version-3.2.1/ResolvedTracTickets-build-4.html\">10 tickets</a>
本维护版本已修复。关键票:</li>

            <li> 票<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1768\">1768</a>
修复了 <a href=\"modelica://Modelica.Blocks.Sources.CombiTimeTable\">CombiTimeTable</a>的问题
(使用时间步长大于表分辨率的固定时间步长积分器时输出错误)。</li>

            <li> 票<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1758\">1758</a>
说明对
<a href=\"modelica://Modelica.Fluid.Examples.HeatingSystem\">Modelica.Fluid.Examples.HeatingSystem</a>
如果设置选项“用于检查Modelica语义的迂腐模式”，则在Dymola 2016中失败。
由于以下原因，此问题未在库中修复:<br>
                 Modelica。流体库使用特定模式来定义生成的某些参数
在参数的循环依赖中，如果只考虑事件信息。
根据Modelica规范3.2修订版2，这是不允许的
(因此Dymola 2016正确报告错误，如果迂腐标志设置)。
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1320\">1320</a>
这个问题在Modelica Specification 3.3 revision 1中通过允许
如果在计算参数时循环消失，则循环参数定义
有注释Evaluate=true的。Modelica。流体在这方面是正确的
Modelica规范3.3修订版
                 更改Modelica。3.2.1版本的流体库。4 .使无循环参数依赖
(a)会导致不向后兼容吗
更改和(b)使用Modelica。流体不太方便。对于这个
Modelica的理由。液体没有改变。(实际上，这意味着例如
在Dymola 2016中的迂腐标志需要关闭，当使用
Modelica。流体库在版本3.2.1构建4和任何以前的版本)。</li>

            <li> 在票<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1757\">1757</a>它是(正确地)说明
<a href=\"modelica://Modelica.Media.Examples.PsychrometricData\">PsychrometricData</a>
从Modelica.Media.Air.MoistAir.PsychrometricData移出，这是一个不向后兼容的更改。
这种非向后兼容的更改是可以接受的，因为它修复了循环依赖(模型引用)
(它所在的包)，详细信息请参见ticket
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1679\">1679</a>。
修复这张票被视为更高的优先级，作为一个小缺点
一个示例模型被移动(这个被移动的模型没有移动的概率非常高)
可用于任何用户模型)。<br>&nbsp;
                </li>
          </ul>
     </li>
     <li> <strong>版本3.2.2 Build.2</strong>(2016年3月16日)相对于3.2.1 Build.4(2015年9月30日):<br>
关于<a href=\"modelica://Modelica/Resources/Documentation/Version-3.2.2/ResolvedTracTickets.html\">130 tickets</a>
已修复此版本。<br>
          ModelicaStandardTables对象库(Lib，.dll，.a，.so(取决于工具)有
ModelicaStandardTables</strong>、<strong>ModelicaMatIO</strong>、<strong>zlib</strong>和new
对象库<strong>ModelicaIO</strong>已添加。<br>
          对于<strong>工具供应商</strong>来说，如果过去使用过相同的对象库，这可能是一个非向后兼容的更改
获取Modelica包的不同版本。
<a href=\"modelica://Modelica/Resources/C-Sources/readme.txt\">Resources/C-Sources/readme.txt</a>
详细解释了这个问题以及如何解决它。
对于<strong>用户</strong>来说，如果他/她实现了一个
自己的外部C接口函数到ModelicaStandardTables中的一个函数，
ModelicaMatIO或zlib库。在这种情况下，这些函数的库注释需要是
改编。< br >,</li>
     </ul>
</li>
<li> 在版本3.2.1 Build.3中，在的函数中引入了一个新的参数crossArea
类的一个微妙的bug
非圆管的管道摩擦计算，见<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1601\">#1601</a>
和<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1656\">#1656</a>。
如果用户使用了Modelica.Fluid的管道模型。管道，这并不重要，因为管道模型已经
以完全向后兼容的方式改进。但是，如果用户基于构造了自己的管道模型
调用PartialWallFriction包，并调用PartialWallFriction中定义的函数
位置(而不是命名)参数，则会出现单元警告或错误(取决于工具)
和特定于工具的设置)，因为新的参数crossArea有单位[m2]和之前的
这里的参数是粗糙度，单位是[m]。如果忽略警告，则模拟结果
将是错误的，因为交叉面积被用作粗糙度。用户需要通过
调整他/她的管道模型，以便在函数调用中使用crossArea;
或者使用命名函数参数。
</li>
</ul>

<p>
包Modelica版本3.2.2和版本3.2.1之间的确切区别是
总结为以下两个对比表:
</p>
<ul>
<li><a href=\"modelica://Modelica/Resources/Documentation/Version-3.2.2/Differences322To321Build4.html\">Difference 3.2.2 to 3.2.1 Build 4</a>,</li>
<li><a href=\"modelica://Modelica/Resources/Documentation/Version-3.2.2/Differences321Build4toBuild2.html\">Difference 3.2.1 Build 4 to 3.2.1 Build 2</a>.</li>
</ul>

<p>
这个版本的软件包Modelica和随附的ModelicaTest已经用
以下工具(按字母顺序列出)。在测试的时候，一些
工具可能还不支持完整的Modelica包。有关测试的更多详细信息
看到 <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1867\">#1867</a>):
</p>

<ul>
<li> <strong>Dymola 2017 Beta.1</strong> (Windows 64位，\"Check\"带有迂腐标志，即严格检查
Modelica合规性，以及“使用仿真检查”)。<br>
     <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1924\">#1924</a>:
     3.2.2+build.0-beta的回归测试。2使用Dymola 2017 Dev 4相对
3.2.1 +构建。4参考文件<br>
     <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1949\">#1949</a>:
     3.2.2+build.0-beta的回归测试。3使用Dymola 2017 Beta 1相对
3.2.1 +构建。4参考文件</li>
<li> <strong>LMS Imagine.Lab Amesim 14.2</strong> 和 <strong>LMS Imagine.Lab Amesim 15 (development build)</strong>.
     未发现以前未报告的回归。</li>
<li> <strong>Maplesim Parser</strong></li>
<li> <strong>OpenModelica 1.9.4 Beta.2</strong> (Windows, Linux, Mac)</li>
</ul>

<p>
以下Modelica软件包已经测试确认，与此版本的Modelica软件包兼容(按字母顺序列表):
</p>

<ul>
<li>AirConditioning Library 1.12 (Modelon)</li>
<li>Buildings 2.1.0 (LBNL)</li>
<li>Electric Power Library 2.2.3 (Modelon)</li>
<li>Engine Dynamics Library 1.2.5 (Modelon)</li>
<li>FlexibleBodies 2.2 (DLR)</li>
<li>FlightDynamics 1.0.1 (DLR)</li>
<li>FluidDissipation 1.1.8 (XRG Simulation)</li>
<li>Fuel Cell Library 1.3.3 (Modelon)</li>
<li>Heat Exchanger Library 1.4.1 (Modelon)</li>
<li>Human Comfort Library 2.1.0 (XRG Simulation)</li>
<li>HVAC Library 2.1.0 (XRG Simulation)</li>
<li>Hydraulics Library 4.4 (Modelon)</li>
<li>Hydronics Library 2.1.0 (XRG Simulation)</li>
<li>Hydro Power Library 2.6 (Modelon)</li>
<li>Liquid Cooling Library 1.5 (Modelon)</li>
<li>Modelica_Synchronous 0.92.1</li>
<li>Modelica_LinearSystems2 2.3.4</li>
<li>Modelica_StateGraph2 2.0.3</li>
<li>Optimization 2.2.2 (DLR)</li>
<li>PowerTrain 2.4.0 (DLR)</li>
<li>Pneumatics Library 2.0 (Modelon)</li>
<li>Thermal Power Library 1.12 (Modelon)</li>
<li>Vapor Cycle Library 1.3 (Modelon)</li>
<li>Vehicle Dynamics Library 2.3 (Modelon)</li>
</ul>

<p><br>
以下<font color=\"blue\"><strong>新增库</strong></font>:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><a href=\"modelica://Modelica.Electrical.PowerConverters\">Modelica.Electrical.PowerConverters</a></td>
    <td>
    该库提供整流器，逆变器和DC/DC转换器的模型。<br>
    (这个库是由Christian Kral和Anton Haumer开发的。)
    </td></tr>

<tr><td><a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave\">Modelica.Magnetic.QuasiStatic.FundamentalWave</a></td>
    <td>
    该库提供并联多相电机(感应电机，同步电机)的准静态模型(具有相同的参数但不同的电连接器)。
<a href=\"modelica://Modelica.Magnetic.FundamentalWave\">Modelica.Magnetic.FundamentalWave</a>.<br>
准静态意味着忽略电瞬变，假定电压和电流是正弦的。机械瞬态和热瞬态被考虑在内。<br>
此库与<a href=\"modelica://Modelica.Electrical.QuasiStatic\">Modelica.Electrical.QuasiStatic</a>组合使用时特别有用。
库，以便快速模拟具有正弦电流和电压的电路。<br>
(这个库是由Christian Kral和Anton Haumer开发的。)
    </td></tr>

<tr><td>子程序库 <a href=\"modelica://Modelica.Magnetic.FluxTubes\">Modelica.Magnetic.FluxTubes</a></td>
    <td>
   增加了铁磁(静态)和涡流(动态)迟滞效应和永磁体模型的新元素。
FluxTubes。还扩展了材料包，提供了多种磁性材料的磁滞数据。这些数据部分是基于自己的测量。
对于铁磁迟滞的建模，采用了两种不同的迟滞模型:简单的Tellinen模型和相当大的Tellinen模型
更详细的Preisach滞回模型。增加了以下包:
  <ul>
  <li><a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis\">FluxTubes.UsersGuide.Hysteresis</a></li>
  <li><a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.Hysteresis\">FluxTubes.Examples.Hysteresis</a></li>
  <li><a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets\">FluxTubes.Shapes.HysteresisAndMagnets</a></li>
  <li><a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HysteresisEverettParameter\">FluxTubes.Material.HysteresisEverettParameter</a></li>
  <li><a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HysteresisTableData\">FluxTubes.Material.HysteresisTableData</a></li>
  </ul>
    (这些扩展是由Johannes Ziske和Thomas B&ouml;drich开发的，作为<a href=\"http://www.cleansky.eu/\">Clean Sky</a> JTI项目的一部分;
项目编号:296369;主题:
   <a href=\"https://cordis.europa.eu/project/rcn/101194_en.html\">JTI-CS-2011-1-SGO-02-026</a>;
   MOMOLIB - Modelica介质、磁系统和小波模型库的开发.
     高度赞赏欧洲联盟为这一发展提供的部分财政支持).
    </td></tr>

<tr><td><strong>噪声</strong>建模的子库</td>
    <td>
   添加了几个新的子库，允许对可再现噪声进行建模。
最重要的新子库是(详细信息见下文):
  <ul>
  <li><a href=\"modelica://Modelica.Blocks.Noise\">Modelica.Blocks.Noise</a></li>
  <li><a href=\"modelica://Modelica.Math.Random\">Modelica.Math.Random</a></li>
  <li><a href=\"modelica://Modelica.Math.Distributions\">Modelica.Math.Distributions</a></li>
  <li><a href=\"modelica://Modelica.Math.Special\">Modelica.Math.Special</a></li>
  </ul>
  (这些扩展由Andreas Kl&ouml;ckner、Frans van der Linden、Dirk Zimmer和Martin Otter开发
DLR系统动力学与控制研究所).
    </td></tr>

<tr><td><a href=\"modelica://Modelica.Utilities\">Modelica.Utilities</a> functions for <strong>matrix read/write</strong></td>
    <td>
   新函数提供在<a href=\"modelica://Modelica.Utilities.Streams\">Modelica.Utilities.Streams</a>
子库将MATLAB MAT格式的矩阵写入文件，并从文件中读取这种格式的矩阵。
这些函数支持MATLAB MAT格式v4, v6, v7和v7.3(如果工具支持HDF5)。
此外，还提供了示例模型
<a href=\"modelica://Modelica.Utilities.Examples\">Modelica.Utilities.Examples</a>
演示这些函数在模型中的用法。欲了解更多详情，请参阅下文。<br>
(这些扩展是由ITI GmbH的Thomas Beutlich开发的)。
    </td></tr>

<tr><td><a href=\"modelica://Modelica.Math\">Modelica.Math</a> sublibrary for <strong>FFT</strong></td>
    <td>
   新的子库<a href=\"modelica://Modelica.Math.FastFourierTransform\">FastFourierTransform</a>
提供实用和方便的函数来计算快速傅里叶变换(FFT)。
另外，还提供了两个示例来演示如何在连续时间期间计算FFT
模拟并将结果存储在文件中。欲了解更多详情，请参阅下文。<br>
(这些扩展是由Martin Kuhn和Martin Otter开发的
DLR系统动力学与控制研究所)。
    </td></tr>
</table>

<p><br>
新增了以下<font color=\"blue\"><strong>组件</strong></font
<font color=\"blue\"><strong>现有</strong></font>库:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><strong>Modelica.Blocks.Examples</strong></td></tr>
<tr><td width=\"150\">NoiseExamples</td>
    <td> 中块的用法有几个示例
新建子库Blocks.Noise。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Blocks.Interfaces</strong></td></tr>
<tr><td width=\"150\">PartialNoise</td>
    <td> 部分噪声发生器(Blocks.Noise中噪声发生器的基类)</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Blocks.Math</strong></td></tr>
<tr><td width=\"150\">ContinuousMean</td>
    <td> 计算其输入信号的经验期望(平均值)值</td></tr>
<tr><td width=\"150\">Variance</td>
    <td> 计算其输入信号的经验方差</td></tr>
<tr><td width=\"150\">StandardDeviation</td>
    <td> 计算其输入信号的经验标准差</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Blocks.Noise</strong></td></tr>
<tr><td width=\"150\">GlobalSeed</td>
    <td> 定义子库Noise块的全局设置，
特别是定义了全局种子值</td></tr>
<tr><td width=\"150\">UniformNoise</td>
    <td> 均匀分布的噪声发生器</td></tr>
<tr><td width=\"150\">NormalNoise</td>
    <td> 具有正态分布的噪声发生器</td></tr>
<tr><td width=\"150\">TruncatedNormalNoise</td>
    <td> 截断正态分布的噪声发生器</td></tr>
<tr><td width=\"150\">BandLimitedWhiteNoise</td>
    <td> 噪声发生器产生正态分布的带限白噪声</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.ComplexBlocks.Examples</strong></td></tr>
<tr><td width=\"150\">ShowTransferFunction</td>
    <td> 示例演示块TransferFunction的用法.</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.ComplexBlocks.ComplexMath</strong></td></tr>
<tr><td width=\"150\">TransferFunction</td>
    <td> 这个块允许定义一个复传递函数(取决于频率输入w)来获得复输出y.</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.ComplexBlocks.Sources</strong></td></tr>
<tr><td width=\"150\">LogFrequencySweep</td>
    <td> w的对数执行从log10(wMin)到log10(wMax)的线性渐变，输出是这个对数渐变的十进制幂。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Machines.Examples</strong></td></tr>
<tr><td width=\"150\">ControlledDCDrives</td>
    <td>电流，速度和位置控制直流永磁驱动</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Mechanics.Rotational.Examples.Utilities.</strong></td></tr>
<tr><td width=\"150\">SpringDamperNoRelativeStates</td>
    <td>引入修复票据<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1375\">1375</a></td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Mechanics.Rotational.Components.</strong></td></tr>
<tr><td width=\"150\">ElastoBacklash2</td>
    <td>反弹的另一种模式。与现有的ElastoBacklash的区别
组件是当接触发生时产生一个事件，并且该接触力矩
在这种情况下，变化是不连续的。对于某些用户模型，这种变体的反弹模型
导致显著更快的模拟。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Fluid.Examples.</strong></td></tr>
<tr><td width=\"150\">NonCircularPipes</td>
    <td>介绍了检查票的修复<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1601\">1681</a></td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Media.Examples.</strong></td></tr>
<tr><td width=\"150\">PsychrometricData</td>
    <td>引入修复票据 <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1679\">1679</a></td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Math.Matrices.</strong></td></tr>
<tr><td width=\"150\">balanceABC</td>
    <td> 返回系统的平衡形式[a,B;C,0]
通过状态转变来改善其状况</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Math.Random.Generators.</strong></td></tr>
<tr><td width=\"150\">Xorshift64star</td>
    <td> 随机数生成器xorshift64*</td></tr>
<tr><td width=\"150\">Xorshift128plus </td>
    <td> 随机数生成器xorshift128+</td></tr>
<tr><td width=\"150\">Xorshift1024star</td>
    <td> 随机数生成器xorshift1024*</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Math.Random.Utilities.</strong></td></tr>
<tr><td width=\"150\">initialStateWithXorshift64star</td>
    <td> 返回随机数生成器的初始状态向量(基于xorshift64star算法)</td></tr>
<tr><td width=\"150\">automaticGlobalSeed </td>
    <td> 从当前时间和进程id创建一个自动整数种子(=不纯函数)</td></tr>
<tr><td width=\"150\">initializeImpureRandom </td>
    <td> 初始化非纯随机数生成器的内部状态</td></tr>
<tr><td width=\"150\">impureRandom</td>
    <td> 不纯随机数生成器(带有隐藏状态向量)</td></tr>
<tr><td width=\"150\">impureRandomInteger </td>
    <td> 用于整数值的非纯随机数生成器(带有隐藏状态向量)</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Math.Distributions.</strong></td></tr>
<tr><td width=\"150\">Uniform</td>
    <td> 均匀分布函数库(函数:密度，累积，分位数)</td></tr>
<tr><td width=\"150\">Normal</td>
    <td> 正态分布函数库(函数:密度，累积，分位数)</td></tr>
<tr><td width=\"150\">TruncatedNormal </td>
    <td> 截断的正态分布函数库(函数:密度，累积，分位数)</td></tr>
<tr><td width=\"150\">Weibull</td>
    <td> 威布尔分布函数库(函数:密度、累积、分位数)</td></tr>
<tr><td width=\"150\">TruncatedWeibull </td>
    <td> 截断威布尔分布函数库(函数:密度，累积，分位数)</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Math.Special.</strong></td></tr>
<tr><td width=\"150\">erf</td>
    <td>误差函数 erf(u) = 2/sqrt(pi)*Integral_0_u exp(-t^2)*d</td></tr>
<tr><td width=\"150\">erfc</td>
    <td>互补误差函数 erfc(u) = 1 - erf(u)</td></tr>
<tr><td width=\"150\">erfInv</td>
    <td>逆误差函数: u = erf(erfInv(u))</td></tr>
<tr><td width=\"150\">erfcInv </td>
    <td>逆互补误差函数: u = erfc(erfcInv(u))</td></tr>
<tr><td width=\"150\">sinc </td>
    <td>非标准化sinc函数: sinc(u) = sin(u)/u</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Math.FastFourierTransform.</strong></td></tr>
<tr><td width=\"150\">realFFTinfo </td>
    <td>打印关于给定f_max和f_resolution的真实FFT的信息</td></tr>
<tr><td width=\"150\">realFFTsamplePoints </td>
    <td>返回一个真实FFT的采样点数</td></tr>
<tr><td width=\"150\">realFFT</td>
    <td>真实FFT的返回幅度和相位矢量</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Utilities.Streams.</strong></td></tr>
<tr><td width=\"150\">readMatrixSize</td>
    <td>从MATLAB MAT文件中读取实矩阵的维度</td></tr>
<tr><td width=\"150\">readRealMatrix</td>
    <td>从MATLAB MAT文件中读取实矩阵</td></tr>
<tr><td width=\"150\">writeRealMatrix</td>
    <td>将实矩阵写入MATLAB MAT文件</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Utilities.Strings.</strong></td></tr>
<tr><td width=\"150\">hashString</td>
    <td>创建String的散列值</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Utilities.System.</strong></td></tr>
<tr><td width=\"150\">getTime</td>
    <td>检索本地时间(在本地时区中)</td></tr>
<tr><td width=\"150\">getPid</td>
    <td>检索当前进程id</td></tr>
</table>

<p><br>
以下<font color=\"blue\"><strong> </strong>现有组件</strong></font>已被<font color=\"blue\"><strong>以<font color=\"blue\"><strong>不向后兼容</strong></font>的方式更改</strong></font>:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><strong>Electrical.Analog.Semiconductors.</strong></td></tr>
<tr><td> HeatingDiode </td>
          <td> 删除受保护变量k \"Boltzmann's constant\".<br>
                            根据已知常数计算受保护常数q \"Electron charge\"，而不是定义受保护变量q.</td></tr>
<tr><td> HeatingNPN<br>
                      HeatingPNP </td>
          <td> 去掉了参数K \"Boltzmann's constant\"和q \"Elementary electronic charge\".<br>
                            从已知常数中计算受保护的常数q \"Electron charge\".<br>
                            使用这些参数的用户可能会破坏他们的模型;
这种改变(尽管形式上不向后兼容)为用户提供了更安全的使用方式。</td></tr>
</table>

</html>"                  ));
      end Version_3_2_2;

      class Version_3_2_1 "Version 3.2.1 (August 14, 2013)"
        extends Modelica.Icons.ReleaseNotes;

        annotation(Documentation(info = "<html>
<p>
版本3.2.1向后兼容版本3.2，即使用
版本3.0、3.0.1、3.1或3.2也可以在版本3.2.1上运行而不需要任何更改。
这个版本是一个“清理”，主要强调质量改进和
工具兼容。目标就是这样
<a href=\"https://www.modelica.org/tools\">Modelica tools</a>将支持这个包
也会用同样的方式来解释。简短的概述:
</p>

<ul>
<li> 这个版本的Modelica包<strong>与</strong>完全兼容
Modelica Specification <strong>3.2 revision 2</strong>.<br>
(特别是在Modelica包中使用的一些操作符，
例如“root”，已在3.2 rev. 2中标准化，
以及供应商特定的注释。此外,
规范中有模棱两可/不清楚的描述
纠正/改进。包的一个重要改进
Modelica和ModelicaTest的初始化已经完全定义
在所有示例模型中，为了使所有工具都能产生相同的结果
不依赖于工具启发式)。
     </li>

<li> 关于<a href=\"modelica://Modelica/Resources/Documentation/Version-3.2.1/ResolvedTracTickets.html\">400 tickets</a>
已经修复了这个版本，和
特别是所有的合规问题和所有相关的缺陷问题。
     </li>

<li> 已经提供了<strong>表块</strong>的开源实现
通过<a href=\"http://www.itisim.com\">ITI GmbH</a>。这项工作一直
<a href=\"https://www.modelica.org/news_items/call-texts-to-improve-modelica-2012/2012-12-20-Call-for-quotation-for-MSL-tables.pdf/at_download/file\">paid by Modelica Association</a>。
因此，Modelica包的所有部分现在都可用了
在自由实现中。此外，表块中还添加了新功能
通过这个实现:
     <ul>
     <li>表输出可以区分一次。</li>
     <li>支持二进制MATLAB MATLAB文件格式v6和v7</li>
     <li>新选项ConstantSegments参数平滑</li>
     <li>为参数Extrapolation增加了NoExtrapolation选项</li>
     <li>支持C-Code中提供的表(usertab.c，用于没有文件系统的实时系统)</li>
     </ul></li>

<li> Wolfram Research重新设计了<strong>图标</strong>，以提供更现代的视图。</li>

<li> The <strong>Modelica.Media.Air.MoistAir</strong> 媒体模型得到了改进，使其
可在190…647 K(以前:240…400 K)。</li>

<li> 空气(<strong>ReferenceAir</strong>)新媒体模型，工作范围大:30…2000 K,
0…2000mpa)，对于湿空气(<strong>)，参考enemoistair </strong>具有较大的工作范围:
143.15……2000 k, 0…10 MPa;但是慢了1-2个数量级
Modelica.Media.Air.MoistAir),
制冷剂<strong>R134a</strong>均包含在Modelica中。媒体库才能
改进空调系统的建模，特别是在飞机上。
这些模型是由
<a href=\"http://www.xrg-simulation.de/\">XRG Simulation GmbH</a>
作为<a href=\"http://www.cleansky.eu/\">Clean Sky</a> JTI项目的一部分
(项目编号:296369;主题:JTI-CS-2011-1-SGO-02-026)。
欧洲联盟为这一发展提供的部分财政支持
非常感谢。</li>

<li> 新增了<strong>60</strong>模型和块以及<strong>90</strong>函数，详细信息见下文。</li>

</ul>

<p>
这个版本的软件包Modelica和随附的ModelicaTest已经用
以下工具(按字母顺序列出)。在测试的时候，一些
工具可能还不支持完整的Modelica包):
</p>

<ul>
<li> CyModelica</li>
<li> Dymola 2014 (Windows 64 bit)<br>
     关于Modelica 3.2的回归测试结果是可用的
在机票 <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1114\">#1114</a>.</li>
<li> Dymola 2014 FD01开发与迂腐标志(Windows 64位)<br>
(\"pedantic flag\"意味着严格遵守Modelica检查。
Dymola 2014因为迂腐的标志而失败，例如，因为注释DocumentationClass
在这个Dymola版本发布的时候还没有标准化)。</li>
<li> Maplesim Parser</li>
<li> MWorks 3.2</li>
<li> OpenModelica 1.9.0 Beta4+dev (Windows, Linux, Mac)<br>
     每日构建的测试报告是可用的
     <a href=\"https://trac.openmodelica.org/OpenModelica/wiki\">here</a>.
     </li>
<li> SimulationX 3.6</li>
</ul>

<p>
以下Modelica包已经经过测试，它们可以与Modelica包的这个版本一起工作
(按字母顺序列表):
</p>

<ul>
<li> Buildings 1.4 (LBNL)</li>
<li> FlexibleBodies 2.0.1 (DLR)</li>
<li> Modelica_Synchronous 0.91 (DLR)</li>
<li> Optimization 2.2 (DLR)</li>
<li> PowerTrain 2.2.0 (DLR)</li>
</ul>

<p>
新的开源表已经由T. Beutlich (ITI)进行了测试:
</p>

<ul>
<li> Modelica测试模型，以检查与先前表实现的兼容性
(在ModelicaTest.Tables中可用)。
使用SimulationX 3.5.707(32位)和
Dymola 2013 FD01(32位)。此外，在OpenModelica中进行了基本检查
确保它在一般情况下是有效的。
     </li>
<li> 两个C源文件(Modelica/Resources/C- sources/ ModelicaStandardTables.c;ModelicaMatIO.c)
已经过测试，可以成功编译以下平台<br>
     &nbsp;&nbsp;&nbsp;Windows 32 and 64 bit<br>
     &nbsp;&nbsp;&nbsp;Linux 32 and 64 bit<br>
     &nbsp;&nbsp;&nbsp;dSPACE SCALEXIO<br>
     &nbsp;&nbsp;&nbsp;dSPACE DS1005 (no file system)<br>
     &nbsp;&nbsp;&nbsp;dSPACE DS1006 (no file system)<br>
     &nbsp;&nbsp;&nbsp;dSPACE DS1401 (no file system)
     </li>
<li> 以下编译器/环境已用于平台评估<br>
     &nbsp;&nbsp;&nbsp;Microsoft compilers (VC6 and &ge; VS2005 (Win32 and x64))<br>
     &nbsp;&nbsp;&nbsp;MinGW (GCC 4.4.0 and GCC 4.7.2)<br>
     &nbsp;&nbsp;&nbsp;Cygwin (GCC 4.3.0)<br>
     &nbsp;&nbsp;&nbsp;Open WATCOM 1.3<br>
     &nbsp;&nbsp;&nbsp;LCC 2.4.1<br>
     &nbsp;&nbsp;&nbsp;Borland C/C++ (free command line tools) 5.5<br>
     &nbsp;&nbsp;&nbsp;GCC 4.x on Linux<br>
     &nbsp;&nbsp;&nbsp;GCC 3.3.5 (for DS1006)<br>
     &nbsp;&nbsp;&nbsp;Microtec PowerPC Compiler 3.7 (for DS1005)
     </li>
</ul>

<p>
软件包Modelica版本3.2和版本3.2.1之间的确切区别是
总结为
<a href=\"modelica://Modelica/Resources/Documentation/Version-3.2.1/DifferencesTo32.html\">comparison table</a>.
</p>

<p>
大约有<strong>400个</strong>跟踪票在这个版本中被修复了。给出了概述
<a href=\"modelica://Modelica/Resources/Documentation/Version-3.2.1/ResolvedTracTickets.html\">here</a>。
点击一张票就能得到有关它的所有信息。
</p>

<p><br>
新增了以下<font color=\"blue\"><strong>组件</strong></font
到<font color=\"blue\"><strong>现有的</strong></font>库:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><strong>Modelica.Blocks.Logical.</strong></td></tr>
<tr><td width=\"150\"> RSFlipFlop</td>
    <td> 基本RS触发器</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Blocks.Math.</strong></td></tr>
<tr><td width=\"150\"> MinMax</td>
    <td>输出输入向量的最小和最大元素 </td></tr>
<tr><td width=\"150\"> LinearDependency </td>
    <td>输出两个输入的线性组合 </td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Blocks.Nonlinear.</strong></td></tr>
<tr><td width=\"150\"> SlewRateLimiter</td>
    <td> 限制信号的转换速率 </td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Digital.Memories</strong></td></tr>
<tr><td width=\"150\"> DLATRAM</td>
    <td> 级别敏感随机存取存储器 </td></tr>
<tr><td width=\"150\"> DLATROM</td>
    <td> 级别敏感只读内存 </td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.Digital.Multiplexers</strong></td></tr>
<tr><td width=\"150\"> MUX2x1</td>
    <td> 用于多值逻辑的双输入复用器(2个数据输入，1个选择输入，1个输出) </td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Machines.Examples.InductionMachines.</strong></td></tr>
<tr><td width=\"150\"> IMC_Initialize </td>
    <td> 的稳态初始化示例 InductionMachineSquirrelCage </td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.Machines.Examples.SynchronousMachines.</strong></td></tr>
<tr><td width=\"150\"> SMPM_VoltageSource </td>
    <td> 由FOC提供的永磁体同步机示例 </td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Polyphase.Examples.</strong></td></tr>
<tr><td width=\"150\"> TestSensors </td>
    <td> 多相准irms传感器的例子:一个正弦源馈入一个由电阻和电感组成的负载 </td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.Polyphase.Sensors.</strong></td></tr>
<tr><td width=\"150\"> VoltageQuasiRMSSensor </td>
    <td> 用于多相系统的连续准电压有效值传感器 </td></tr>
<tr><td width=\"150\"> CurrentQuasiRMSSensor </td>
    <td> 多相系统连续准电流有效值传感器 </td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.Polyphase.Blocks.</strong></td></tr>
<tr><td width=\"150\"> QuasiRMS </td>
    <td> 确定多相系统的准均方根值 </td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.Polyphase.Functions.</strong></td></tr>
<tr><td width=\"150\"> quasiRMS </td>
    <td> 计算输入的连续准均方根值 </td></tr>
<tr><td width=\"150\"> activePower </td>
    <td> 计算输入电压和电流的有功功率 </td></tr>
<tr><td width=\"150\"> symmetricOrientation </td>
    <td> 所产生的基波场相量的方向 </td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Spice3.Examples.</strong></td></tr>
<tr><td width=\"150\"> CoupledInductors<br>
                                      CascodeCircuit<br>
                                      Spice3BenchmarkDifferentialPair<br>
                                      Spice3BenchmarkMosfetCharacterization<br>
                                      Spice3BenchmarkRtlInverter<br>
                                      Spice3BenchmarkFourBitBinaryAdder</td>
    <td> Spice3版本e3用户手册中的Spice3示例和基准 </td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.Spice3.Basic.</strong></td></tr>
<tr><td width=\"150\"> K_CoupledInductors</td>
    <td> 电感耦合通过耦合系数K </td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.Spice3.Semiconductors.</strong></td></tr>
<tr><td width=\"150\"> M_NMOS2<br>
                                      M_PMOS2<br>
                                      ModelcardMOS2</td>
    <td>  固定电平2的N/P沟道MOSFET晶体管 </td></tr>
<tr><td width=\"150\"> J_NJFJFE<br>
                                      J_PJFJFE<br>
                                      ModelcardJFET</td>
    <td>  N/ p沟道结场效应晶体管 </td></tr>
<tr><td width=\"150\"> C_Capacitor<br>
                                      ModelcardCAPACITOR</td>
    <td>  半导体电容器模型 </td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.</strong></td></tr>
<tr><td width=\"150\"> IMC_DOL_Polyphase<br>
                                      IMS_Start_Polyphase<br>
                                      SMPM_Inverter_Polyphase<br>
                                      SMEE_Generator_Polyphase<br>
                                      SMR_Inverter_Polyphase</td>
    <td> 多相电机实例 </td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Fluid.Sensors.</strong></td></tr>
<tr><td width=\"150\"> MassFractions<br>
                                      MassFractionsTwoPort</td>
    <td> 理想质量分数传感器 </td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Media.</strong></td></tr>
<tr><td width=\"150\">R134a</td>
    <td> R134a(四氟乙烷)介质型号范围为(0.0039 bar ..700条,
169.85 k ..455 K)</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Media.Air.</strong></td></tr>
<tr><td width=\"150\"> ReferenceAir</td>
    <td> 详细的干空气模型，工作范围大(130…2000 k, 0…2000 MPa)
基于亥姆霍兹状态方程</td></tr>
<tr><td width=\"150\"> ReferenceMoistAir</td>
    <td> 详细的湿空气模型(143.15…2000 K)</td></tr>
<tr><td width=\"150\"> MoistAir</td>
    <td> 湿气介质的功能温度范围从
                        240 - 400 K to  190 - 647 K.</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Media.Air.MoistAir.</strong></td></tr>
<tr><td width=\"150\"> velocityOfSound<br>
                                      isobaricExpansionCoefficient<br>
                                      isothermalCompressibility<br>
                                      density_derp_h<br>
                                      density_derh_p<br>
                                      density_derp_T<br>
                                      density_derT_p<br>
                                      density_derX<br>
                                      molarMass<br>
                                      T_psX<br>
                                      setState_psX<br>
                                      s_pTX<br>
                                      s_pTX_der<br>
                                      isentropicEnthalpy</td>
    <td> 返回湿空气介质模型的附加属性的函数</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Thermal.HeatTransfer.Components.</strong></td></tr>
<tr><td width=\"150\"> ThermalResistor</td>
    <td> 集热元件传递热量而不储存热量 (dT = R*Q_flow) </td></tr>
<tr><td width=\"150\"> ConvectiveResistor</td>
    <td> 热对流的集总热元件 (dT = Rc*Q_flow) </td></tr>

<tr><td colspan=\"2\"><strong>Modelica.MultiBody.Examples.Constraints.</strong></td></tr>
<tr><td width=\"150\"> PrismaticConstraint<br>
                        RevoluteConstraint<br>
                        SphericalConstraint<br>
                        UniversalConstraint</td>
    <td> 通过与标准关节进行比较，演示新的Joints.Constraints关节的使用。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.MultiBody.Joints.Constraints.</strong></td></tr>
<tr><td width=\"150\"> Prismatic<br>
                        Revolute<br>
                        Spherical<br>
                        Universal</td>
    <td> 关节元件被形式化为运动学约束。这些元件旨在打破运动学环，通常能比(标准的)自动处理方法更高效、可靠地处理环。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Mechanics.Rotational.</strong></td></tr>
<tr><td width=\"150\"> MultiSensor</td>
    <td> 理想的传感器，以测量扭矩和功率之间的两个法兰和绝对角速度 </td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Mechanics.Translational.</strong></td></tr>
<tr><td width=\"150\"> MultiSensor</td>
    <td> 测量两个法兰之间的绝对速度、力和功率的理想传感器 </td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Math.</strong></td></tr>
<tr><td width=\"150\"> isPowerOf2</td>
    <td> 确定输入的整数是否是2的幂 </td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Math.Vectors.</strong></td></tr>
<tr><td width=\"150\"> normalizedWithAssert</td>
    <td> 返回归一化向量，使长度= 1(触发零向量断言) </td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Math.BooleanVectors.</strong></td></tr>
<tr><td width=\"150\"> countTrue</td>
    <td> 返回布尔向量中为真条目的个数  </td></tr>
<tr><td width=\"150\"> enumerate</td>
    <td> 枚举布尔向量中的真项(假项为0) </td></tr>
<tr><td width=\"150\"> index</td>
    <td> 返回布尔向量的真项的下标</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Utilities.Files.</strong></td></tr>
<tr><td width=\"150\"> loadResource</td>
    <td> 返回URI的绝对路径名或本地文件名  </td></tr>

<tr><td colspan=\"2\"><strong>Modelica.SIunits.</strong></td></tr>
<tr><td width=\"150\"> PressureDifference<br>
                        MolarDensity<br>
                        MolarEnergy<br>
                        MolarEnthalpy<br>
                        TimeAging<br>
                        ChargeAging<br>
                        PerUnit<br>
                        DerPressureByDensity<br>
                        DerPressureByTemperature</td>
    <td> 新的SI单位类型 </td></tr>
</table>
</html>"                  ));
      end Version_3_2_1;

      class Version_3_2 "Version 3.2 (Oct. 25, 2010)"
        extends Modelica.Icons.ReleaseNotes;

        annotation(Documentation(info = "<html>

<p>
版本3.2向后兼容版本3.1，也就是说，使用
版本3.0、3.0.1或3.1无需任何更改就可以与版本3.2一起工作。
这个版本是一个重大的改进:
</p>

<ul>
<li> 新增了<strong>357</strong>模型和块以及<strong>295</strong>函数。</li>

<li>包括<strong>7个</strong>新库。</li>

<li> 图书馆的图标是新设计的，以提供一个现代的，统一的视图，
参见<a href=\"modelica://Modelica.Icons\">Modelica.Icons</a>。</li>

<li> 所有非modelica文件，如图像、pdf文件、c源文件、
脚本被移动到新目录\"Modelica\\Resources\"。
此外，所有文件引用都更改为uri，如
Modelica 3.1(例如，具有文件名的文件
 \"Modelica/Resources/Images/xxx\"被引用为
     \"modelica://Modelica/Resources/Images/xxx\").</li>

<li>所有散热的物理模型(如电气元件，
电机，轴承，阻尼器等)，现在有一个可选的热端口
如果被激活，耗散的能量就会流向。
这将大大提高热效率的设计研究
技术系统。</li>

<li> 所有的电机都在
<a href=\"modelica://Modelica.Electrical.Machines\">Machines</a>机器
库现在有一个“损失”选项卡在参数菜单中可选
机型损耗如摩擦损耗、定子铁芯损耗等
或杂散负载损耗。</li>

<li> 所有的电机都在
<a href=\"modelica://Modelica.Electrical.Machines\">Machines</a>机器
库现在有一个“powerBalance”结果记录，
总结转换功率和损耗。</li>
</ul>

<p>
版本3.2略微基于Modelica规范3.2。它使用
以下新语言元素(与Modelica Specification 3.1相比):
</p>

<ul>
<li> 操作符记录和重载操作符。</li>
<li> 函数作为函数的输入参数。</li>
<li> 改进的可扩展连接器(在expandable中声明的变量
如果未被引用，连接器将被忽略)。</li>
</ul>

<p>
很大一部分新类都是用
部分财政支援
<a href=\"http://www.bmbf.de/en/index.php\">BMBF</a>
(BMBF F&ouml;rderkennzeichen: 01IS07022F)
在<a href=\"http://www.itea2.org\">ITEA2</a>项目内
EUROSYSLIB。
我们非常感谢这笔资金。
</p>

<p>
新增了以下<font color=\"blue\"><strong>new libraries</strong></font>:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><a href=\"modelica://Complex\">Complex</a></td>
    <td>
    这是Modelica标准库之外的顶级记录。
它用于复数，并包含重载操作符。
从用户的角度来看，Complex的使用方式与
内置类型Real。例子:<br>
    <code>&nbsp;  Real     a    = 2;</code><br>
    <code>&nbsp;  Complex  j    = Modelica.ComplexMath.j;</code><br>
    <code>&nbsp;  Complex  b    = 2 + 3*j;</code><br>
    <code>&nbsp;  Complex  c    = (2*b + a)/b;</code><br>
    <code>&nbsp;  Complex  d    = Modelica.ComplexMath.sin(c);</code><br>
    <code>&nbsp;  Complex  v[3] = {b/2, c, 2*d};</code><br>
    (这个库是由Marcus Baur, DLR开发的。)
    </td></tr>

<tr><td><a href=\"modelica://Modelica.ComplexBlocks\">Modelica.ComplexBlocks</a></td>
    <td>
    复杂信号的基本输入/输出控制块库。<br>
这个库与new库结合使用时特别有用
    <a href=\"modelica://Modelica.Electrical.QuasiStatic\">Modelica.Electrical.QuasiStatic</a>
    库，以便建立非常快速的模拟电路与周期
电流和电压。<br>
    (这个库是由Anton Haumer开发的。)
    </td></tr>

<tr><td><a href=\"modelica://Modelica.Electrical.QuasiStatic\">Modelica.Electrical.QuasiStatic</a></td>
    <td>
    类静态电气单相和多相交流仿真库。<br>
    这个库允许非常快速地模拟正弦电路
只考虑电流和电压的准静态、周期性部分
忽略非周期瞬态。<br>
    (这个库是由Anton Haumer和Christian Kral开发的。)
    </td></tr>

<tr><td><a href=\"modelica://Modelica.Electrical.Spice3\">Modelica.Electrical.Spice3</a></td>
    <td>
    图书馆与伯克利的组件
    <a href=\"http://bwrc.eecs.berkeley.edu/Classes/IcBook/SPICE/\">SPICE3</a>
    simulator:<br>
    R, C, L，受控和独立源，半导体器件型号
(MOSFET 1级，双极结晶体管，二极管，半导体电阻)。
这些组件已经过1000多个测试模型的密集测试
并与SPICE3模拟器的结果进行了比较。所有的测试模型给出相同的结果
结果在Dymola 7.4中相对于伯克利SPICE3模拟器上升到相对
积分器的容差。<br>
    这个库允许对电子电路进行详细的模拟。
二级SPICE3模型的工作，即更详细的模型，正在进行中。
此外，一种自动转换的预处理器正在开发中
将SPICE网表转换为Modelica模型，以便许多可用
SPICE3模型可以直接用于Modelica模型。<br>
    (这个图书馆是由德累斯顿的弗劳恩霍夫协会开发的。)
    </td></tr>

<tr><td><a href=\"modelica://Modelica.Magnetic.FundamentalWave\">Modelica.Magnetic.FundamentalWave</a></td>
    <td>
     电机磁基波效应库
应用于三相电机。
该库是Modelica.Electrical.Machines库的替代方法。
类的严格面向对象是这个库的一大优点
组成电机模型的电气和磁性部件。
这允许更容易地合并更详细的物理效果
电子机器。
从教学的角度来看，这个图书馆对该领域的学生非常有益
电气工程专业的。<br>
     (这个库是由Christian Kral和Anton Haumer开发的
2000年Michael Beuschel提供的一个库的想法和源代码。)
    </td></tr>

<tr><td><a href=\"modelica://Modelica.Fluid.Dissipation\">Modelica.Fluid.Dissipation</a></td>
    <td>
     具有计算对流传热和压力损失特性的函数库。<br>
(这个库是由Thorben Vahlenkamp和Stefan Wischhusen开发的
XRG仿真有限公司)
    </td></tr>

<tr><td><a href=\"modelica://Modelica.ComplexMath\">Modelica.ComplexMath</a></td>
    <td>
    复杂数学函数库(例如，sin, cos)和函数操作库
在复向量上。<br>
    (这个库是由DLR-RM的Marcus Baur、Anton Haumer和
HansJ&uuml; rg Wiesmann。)
    </td></tr>
</table>

<p><br>
新增了以下<font color=\"blue\"><strong>组件</strong></font>
到<font color=\"blue\"><strong>现有的</strong></font>库:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><strong>Modelica.UsersGuide</strong></td></tr>
<tr><td> Conventions
                      </td>
    <td> 大大改进了Modelica标准库的“约定”。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Blocks.Examples</strong></td></tr>
<tr><td> Filter<br>
                      FilterWithDifferentation<br>
                      FilterWithRiseTime<br>
                      RealNetwork1<br>
                      IntegerNetwork1<br>
                      BooleanNetwork1<br>
                      Interaction1
                      </td>
    <td> 新引入的块组件的示例。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Blocks.Continuous</strong></td></tr>
<tr><td> Filter </td>
    <td> 连续低通，高通，带通和带阻
临界阻尼、贝塞尔、巴特沃斯和切比雪夫型iir滤波器。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Blocks.Interaction.Show</strong></td></tr>
<tr><td> RealValue<br>
                      IntegerValue<br>
                      BooleanValue</td>
    <td> 块，用于显示图表动画中变量的值。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Blocks.Interfaces</strong></td></tr>
<tr><td> RealVectorInput<br>
                      IntegerVectorInput<br>
                      BooleanVectorInput<br>
                      PartialRealMISO<br>
                      PartialIntegerSISO<br>
                      PartialIntegerMISO<br>
                      PartialBooleanSISO_small<br>
                      PartialBooleanMISO
                      </td>
    <td> 用于新块组件的接口和部分块。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Blocks.Math</strong></td></tr>
<tr><td> MultiSum<br>
                      MultiProduct<br>
                      MultiSwitch </td>
    <td> 对1、2、…进行求和、乘积和交换块N的输入
(基于connectorSizing注释来处理的向量
连接器以方便的方式)。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Blocks.MathInteger</strong></td></tr>
<tr><td> MultiSwitch<br>
                      Sum<br>
                      Product<br>
                      TriggeredAdd</td>
    <td> 整数信号的数学块。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Blocks.Boolean</strong></td></tr>
<tr><td> MultiSwitch<br>
                      And<br>
                      Or<br>
                      Xor<br>
                      Nand<br>
                      Nor<br>
                      Not<br>
                      RisingEdge<br>
                      FallingEdge<br>
                      ChangingEdge<br>
                      OnDelay</td>
    <td> 布尔信号的数学块。
其中一些块也可以在库中使用
                      <a href=\"modelica://Modelica.Blocks.Logical\">Logical</a>.
                      新的设计基于connectorSizing注释，它允许
方便地处理任意数量的输入信号
(例如，“And”块有1、2、…，N个输入，而不是只有2个输入
在 <a href=\"modelica://Modelica.Blocks.Logical\">Logical</a> library).
                      此外，图标更小，以便图表区域更小
更好地利用</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Blocks.Sources</strong></td></tr>
<tr><td> RadioButtonSource</td>
    <td> 模拟单选按钮的布尔信号源。</td></tr>
<tr><td> IntegerTable</td>
    <td> 生成一个基于表矩阵的整数输出信号
具有[time, yi]值。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Analog.Examples</strong></td></tr>
<tr><td> SimpleTriacCircuit,<br>
                      IdealTriacCircuit,<br>
                      AD_DA_conversion </td>
    <td> 新引入的模拟组件的示例。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Analog.Ideal</strong></td></tr>
<tr><td> IdealTriac,<br>
                      AD_Converter,<br>
                      DA_Converter </td>
    <td> 模数转换和数模转换，理想可控硅(基于理想晶闸管)。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Analog.Semiconductors</strong></td></tr>
<tr><td> SimpleTriac </td>
    <td> 基于半导体晶闸管模型的简单可控硅。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Digital.Examples</strong></td></tr>
<tr><td>  Delay_example,<br>
                       DFFREG_example,<br>
                       DFFREGL_example,<br>
                       DFFREGSRH_example,<br>
                       DFFREGSRL_example,<br>
                       DLATREG_example,<br>
                       DLATREGL_example,<br>
                       DLATREGSRH_example,<br>
                       DLATREGSRL_example,<br>
                       NXFER_example,<br>
                       NRXFER_example,<br>
                       BUF3S_example,<br>
                       INV3S_example,<br>
                       WiredX_example </td>
    <td> 新引入的数字组件的示例。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Digital.Interfaces</strong></td></tr>
<tr><td> UX01,<br>
                      Strength,<br>
                      MIMO </td>
    <td> 新引入的数字组件的接口。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Digital.Tables</strong></td></tr>
<tr><td> ResolutionTable,<br>
                      StrengthMap,<br>
                      NXferTable,<br>
                      NRXferTable,<br>
                      PXferTable,<br>
                      PRXferTable,<br>
                      Buf3sTable,<br>
                      Buf3slTable </td>
    <td> 新的数字表组件。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Digital.Delay</strong></td></tr>
<tr><td> InertialDelaySensitiveVector </td>
    <td> 新的数字延迟组件。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Digital.Registers</strong></td></tr>
<tr><td> DFFR,<br>
                      DFFREG,<br>
                      DFFREGL,<br>
                      DFFSR,<br>
                      DFFREGSRH,<br>
                      DFFREGSRL,<br>
                      DLATR,<br>
                      DLATREG,<br>
                      DLATREGL,<br>
                      DLATSR,<br>
                      DLATREGSRH,<br>
                      DLATREGSRL </td>
    <td> 各种寄存器组件(触发器和锁存器的集合)
根据VHDL标准。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Digital.Tristates</strong></td></tr>
<tr><td> NXFERGATE,<br>
                      NRXFERGATE,<br>
                      PXFERGATE,<br>
                      PRXFERGATE,<br>
                      BUF3S,<br>
                      BUF3SL,<br>
                      INV3S,<br>
                      INV3SL,<br>
                      WiredX </td>
    <td> 传输门，缓冲器，逆变器和有线节点。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Polyphase.Basic</strong></td></tr>
<tr><td> MutualInductor </td>
    <td> 多相电感提供互感矩阵模型。</td></tr>
<tr><td> ZeroInductor </td>
    <td> 多相零序电感。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Machines</strong></td></tr>
<tr><td> Examples </td>
    <td> 根据机器类型结构:<br>
                      InductionMachines<br>
                      SynchronousMachines<br>
                      DCMachines<br>
                      Transformers </td></tr>
<tr><td> Losses.* </td>
    <td> 电机和变压器损耗的参数记录和模型(如适用):<br>
                      Friction losses<br>
                      Brush losses<br>
                      Stray Load losses<br>
                      Core losses (only eddy current losses but no hysteresis losses; not for transformers) </td></tr>
<tr><td> Thermal.* </td>
    <td> 简单的热环境，连接到机器的热口，<br>
以及材料常数和效用函数。</td></tr>
<tr><td> Icons.* </td>
    <td> 瞬态和准静态电机和变压器的图标。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Machines.Examples.InductionMachines.</strong></td></tr>
<tr><td> AIMC_withLosses </td>
    <td> 带损耗的鼠笼感应电机 </td></tr>
<tr><td> AIMC_Transformer </td>
    <td> 鼠笼式变压器起动感应电机 </td></tr>
<tr><td> AIMC_withLosses </td>
    <td> 带损耗鼠笼感应电机的试验实例 </td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Machines.Examples.SynchronousMachines.</strong></td></tr>
<tr><td> SMPM_CurrentSource </td>
    <td> 由电流源供电的永磁同步电机 </td></tr>
<tr><td> SMEE_LoadDump </td>
    <td> 带电压控制器的电励磁同步电机</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Machines.Examples.DCMachines.</strong></td></tr>
<tr><td> DCSE_SinglePhase </td>
    <td> 串联励磁直流电机，由正弦电压供电 </td></tr>
<tr><td> DCPM_Temperature </td>
    <td> 永磁直流电机，演示变温 </td></tr>
<tr><td> DCPM_Cooling </td>
    <td> 永磁直流电机，加上一个简单的热模型 </td></tr>
<tr><td> DCPM_QuasiStatic </td>
    <td> 永磁直流电动机，瞬态和准静态模型的比较 </td></tr>
<tr><td> DCPM_Losses </td>
    <td> 永磁直流电机，有损耗与无损耗机型对比 </td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Machines.BasicMachines.QuasiStaticDCMachines.</strong></td></tr>
<tr><td> DC_PermanentMagnet<br>
                      DC_ElectricalExcited<br>
                      DC_SeriesExcited </td>
    <td> 准静态直流电机，即忽略电瞬变 </td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Machines.BasicMachines.Components.</strong></td></tr>
<tr><td> InductorDC </td>
    <td> 如果布尔参数quasstatic = true，则忽略der(i)的电感器模型 </td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Machines.Interfaces.</strong></td></tr>
<tr><td>  ThermalPortTransformer<br>
                       PowerBalanceTransformer </td>
    <td> 用于电机和变压器的热端口和功率平衡。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Machines.Utilities</strong></td></tr>
<tr><td> SwitchedRheostat </td>
    <td> 开关变阻器，用于启动带滑动转子的感应电动机。</td></tr>
<tr><td> RampedRheostat </td>
    <td> 斜坡式变阻器，用于启动带滑动转子的感应电动机。</td></tr>
<tr><td> SynchronousMachineData </td>
    <td> 计算了带电励磁(和阻尼器)的同步电机模型的参数
根据技术说明中通常给出的参数，
根据标准 EN 60034-4:2008 Appendix C.</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Mechanics.MultiBody.Examples.Elementary.</strong></td></tr>
<tr><td> HeatLosses </td>
    <td> 演示热损失的建模。</td></tr>
<tr><td> UserDefinedGravityField </td>
    <td> 演示用户自定义重力场的建模。</td></tr>
<tr><td> Surfaces </td>
    <td> 演示正弦曲面的可视化，<br>
                      还有一个环面和一个由表面构成的轮子。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Mechanics.MultiBody.Joints.</strong></td></tr>
<tr><td> FreeMotionScalarInit </td>
    <td> 允许初始化和状态选择的自由运动关节<br>
                      相关向量的单个元素<br>
                      (例如，初始化r_rel_a[2]，但不初始化r_rel_a的其他元素;<br>
                      这个新组件修复了票据
                      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/274\">#274</a>) </td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Mechanics.MultiBody.Visualizers.</strong></td></tr>
<tr><td> Torus </td>
    <td> 想象一个环面。</td></tr>
<tr><td> VoluminousWheel </td>
    <td> 想象一个巨大的轮子。</td></tr>
<tr><td> PipeWithScalarField </td>
    <td> 沿着管道轴显示带有标量场量的管道。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Mechanics.MultiBody.Visualizers.ColorMaps.</strong></td></tr>
<tr><td> jet<br>
                      hot<br>
                      gray<br>
                      spring<br>
                      summer<br>
                      autumn<br>
                      winter </td>
    <td> 返回不同颜色映射的函数。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Mechanics.MultiBody.Visualizers.Colors.</strong></td></tr>
<tr><td> colorMapToSvg </td>
    <td> 以svg(可缩放矢量图形)格式保存颜色地图。</td></tr>
<tr><td> scalarToColor </td>
    <td> 使用颜色映射将标量映射到颜色。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Mechanics.MultiBody.Visualizers.Advanced.</strong></td></tr>
<tr><td> Surface </td>
    <td> 可视化一个可移动的、参数化的表面;<br>
                      表面特性由函数提供<br>
                      (这个新组件修复了票据
                       <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/181\">#181</a>)</td></tr>
<tr><td> PipeWithScalarField </td>
    <td> 可视化带有标量场的管道。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Mechanics.MultiBody.Visualizers.Advanced.SurfaceCharacteristics.</strong></td></tr>
<tr><td> torus </td>
    <td> 定义环面表面特征的函数。</td></tr>
<tr><td> pipeWithScalarField </td>
    <td> 定义管道表面特性的函数<br>
                      其中标量字段值沿管道轴以颜色显示。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Mechanics.Rotational.Examples.</strong></td></tr>
<tr><td> HeatLosses </td>
    <td> 演示热损失的建模。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Mechanics.Translational.Examples.</strong></td></tr>
<tr><td> HeatLosses </td>
    <td> 演示热损失的建模。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Fluid.Fittings.Bends</strong></td></tr>
<tr><td> CurvedBend<br>
                      EdgedBend</td>
    <td> 新的管件(压力损失)组件。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Fluid.Fittings.Orifices.</strong></td></tr>
<tr><td> ThickEdgedOrifice</td>
    <td> 新的管件(压力损失)组件。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Fluid.Fittings.GenericResistances.</strong></td></tr>
<tr><td> VolumeFlowRate</td>
    <td> 新的管件(压力损失)组件。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Math</strong></td></tr>
<tr><td> isEqual </td>
    <td> 确定两个实标量在数值上是否相同。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Math.Vectors</strong></td></tr>
<tr><td> find </td>
    <td> 找到向量中的元素。</td></tr>
<tr><td> toString </td>
    <td> 将实向量转换为字符串。</td></tr>
<tr><td> interpolate </td>
    <td> 在一个向量内插。</td></tr>
<tr><td> relNodePositions </td>
    <td> 相对节点位置的返回向量(0..1)。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Math.Vectors.Utilities</strong></td></tr>
<tr><td> householderVector<br>
                      householderReflection<br>
                      roots </td>
    <td> 新引入的函数所使用的向量的效用函数，
但只有专家才会感兴趣。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Math.Matrices</strong></td></tr>
<tr><td> continuousRiccati<br>
                      discreteRiccati </td>
    <td> 连续时间和离散时间的返回解
代数Riccati方程。</td></tr>
<tr><td> continuousSylvester<br>
                      discreteSylvester </td>
    <td> 连续时间和离散时间的返回解
分别为Sylvester方程。</td></tr>
<tr><td> continuousLyapunov<br>
                      discreteLyapunov </td>
    <td> 连续时间和离散时间的返回解
李雅普诺夫方程。</td></tr>
<tr><td> trace </td>
    <td> 返回矩阵的轨迹。</td></tr>
<tr><td> conditionNumber </td>
    <td> 计算矩阵的条件数。</td></tr>
<tr><td> rcond </td>
    <td> 估计矩阵的互反条件数。</td></tr>
<tr><td> nullSpace </td>
    <td> 返回矩阵零空间的标准正交基。</td></tr>
<tr><td> toString </td>
    <td> 将矩阵转换为其字符串表示形式。</td></tr>
<tr><td> flipLeftRight </td>
    <td> 在左/右方向翻转矩阵的列。</td></tr>
<tr><td> flipUpDown </td>
    <td> 在上下方向翻转矩阵的行。</td></tr>
<tr><td> cholesky </td>
    <td> 执行实对称正定矩阵的Cholesky分解。</td></tr>
<tr><td> hessenberg </td>
    <td> 把一个矩阵变换成上海森伯格形式。</td></tr>
<tr><td> realSchur </td>
    <td> 计算矩阵的实舒尔形式。</td></tr>
<tr><td> frobeniusNorm </td>
    <td> 返回矩阵的Frobenius范数。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Math.Matrices.LAPACK.</strong></td></tr>
<tr><td> dtrevc<br>
                      dpotrf<br>
                      dtrsm<br>
                      dgees<br>
                      dtrsen<br>
                      dgesvx<br>
                      dhseqr<br>
                      dlange<br>
                      dgecon<br>
                      dgehrd<br>
                      dgeqrf<br>
                      dggevx<br>
                      dgesdd<br>
                      dggev<br>
                      dggevx<br>
                      dhgeqz<br>
                      dormhr<br>
                      dormqr<br>
                      dorghr</td>
    <td> LAPACK的新接口功能
通常不应直接使用，而应间接使用
Modelica.Math.Matrices)。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Math.Matrices.Utilities.</strong></td></tr>
<tr><td> reorderRSF<br>
                      continuousRiccatiIterative<br>
                      discreteRiccatiIterative<br>
                      eigenvaluesHessenberg<br>
                      toUpperHessenberg<br>
                      householderReflection<br>
                      householderSimilarityTransformation<br>
                      findLokal_tk</td>
    <td> 新引入的函数所使用的矩阵的效用函数，
但只有专家才会感兴趣。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Math.Nonlinear</strong></td></tr>
<tr><td> quadratureLobatto </td>
    <td> 使用自适应Lobatto规则返回被积函数的积分。</td></tr>
<tr><td> solveOneNonlinearEquation </td>
    <td> 解f(u) = 0是一种可靠有效的方法
(f(u_min)和f(u_max)必须有不同的符号)。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Math.Nonlinear.Examples.</strong></td></tr>
<tr><td> quadratureLobatto1<br>
                      quadratureLobatto2<br>
                      solveNonlinearEquations1<br>
                      solveNonlinearEquations2 </td>
    <td> 演示Modelica.Math.Nonlinear函数用法的示例
对函数进行积分并求解标量非线性方程。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Math.BooleanVectors.</strong></td></tr>
<tr><td> allTrue </td>
    <td> 如果布尔输入向量的所有元素都为真，则返回真。</td></tr>
<tr><td> anyTrue </td>
    <td> 如果布尔输入向量中至少有一个元素为真，则返回真。</td></tr>
<tr><td> oneTrue </td>
    <td> 如果布尔输入向量中只有一个元素为真，则返回真。</td></tr>
<tr><td> firstTrueIndex </td>
    <td> 返回布尔向量的第一个元素的索引
为真并返回0，如果没有元素为真 </td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Icons.</strong></td></tr>
<tr><td> Information<br>
                      Contact<br>
                      ReleaseNotes<br>
                      References<br>
                      ExamplesPackage<br>
                      Example<br>
                      Package<br>
                      BasesPackage<br>
                      VariantsPackage<br>
                      InterfacesPackage<br>
                      SourcesPackage<br>
                      SensorsPackage<br>
                      MaterialPropertiesPackage<br>
                      MaterialProperty </td>
    <td> 新的图标，以获得不同类别的统一视图
的包。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.SIunits.</strong></td></tr>
<tr><td> ComplexCurrent<br>
                      ComplexCurrentSlope<br>
                      ComplexCurrentDensity<br>
                      ComplexElectricPotential<br>
                      ComplexPotentialDifference<br>
                      ComplexVoltage<br>
                      ComplexVoltageSlope<br>
                      ComplexElectricFieldStrength<br>
                      ComplexElectricFluxDensity<br>
                      ComplexElectricFlux<br>
                      ComplexMagneticFieldStrength<br>
                      ComplexMagneticPotential<br>
                      ComplexMagneticPotentialDifference<br>
                      ComplexMagnetomotiveForce<br>
                      ComplexMagneticFluxDensity<br>
                      ComplexMagneticFlux<br>
                      ComplexReluctance<br>
                      ComplexImpedance<br>
                      ComplexAdmittance<br>
                      ComplexPower</td>
    <td> 在使用复杂变量的物理模型中使用的单位，例如:,<br>
                      <a href=\"modelica://Modelica.Electrical.QuasiStatic\">Modelica.Electrical.QuasiStatic</a>,
                      <a href=\"modelica://Modelica.Magnetic.FundamentalWave\">Modelica.Magnetic.FundamentalWave</a> </td></tr>
<tr><td> ImpulseFlowRate<br>
                      AngularImpulseFlowRate</td>
    <td> 新的机械单位。</td></tr>
</table>

<p><br>
<font color=\"blue\"><strong>现有组件</strong></font>
<font color=\"blue\"><strong> </strong></font>在
<font color=\"blue\"><strong>向后兼容</strong></font>方式:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><strong>Modelica.Blocks.Sources.</strong></td></tr>
<tr><td> Pulse<br>
                      SawTooth </td>
    <td> 引入了新的参数\"nperiod\"来定义周期的数量
对于信号类型。默认值是“无限周期”
(nperiods = 1)。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.</strong></td></tr>
<tr><td> Polyphase.*</td>
    <td> 所有的耗散组件现在有一个可选的热端口连接器
耗散的损耗以热的形式传递到其中。
                       </td></tr>
<tr><td> Machines.*</td>
    <td> 适用于所有电机(异步、同步感应电机、直流电机)
并增加了变压器损耗模型(如适用):<br>
                      温度相关电阻(欧姆损耗)<br>
                      摩擦损失<br>
                      刷损失<br>
                      杂散负载损耗<br>
                      铁芯损耗(只有涡流损耗，没有磁滞损耗);不适用于变压器)<br>
                      默认情况下，温度依赖性和损耗设置为零。<br><br>
                      适用于所有电机(异步、同步感应电机、直流电机)
并增加了变压器条件热端口，
如果被激活，耗散的损耗就会流向它。
热端口包含一个<a href=\"modelica://Modelica.Thermal.HeatTransfer.Interfaces.HeatPort\">HeatPort</a>
对于特定机器类型的每个损耗源。<br><br>
                      适用于所有电机(异步、同步感应电机、直流电机)
添加了\"powerBalance\"结果记录，汇总了转换后的功率和损耗。
                       </td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Mechanics.</strong></td></tr>
<tr><td> MultiBody.*<br>
                      Rotational.*<br>
                      Translational.*</td>
    <td> Modelica中的所有耗散分量。力学现在有了
可选的热端口连接器，耗散的能量是
以热的形式传递。<br>
                      Modelica中的所有图标。力学是统一的
Modelica。块库:<br>
                      \"%name\": width: -150 .. 150, height: 40, color: blue<br>
                      other text: height: 30, color: black
                       </td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Mechanics.MultiBody.</strong></td></tr>
<tr><td> World </td>
    <td> 函数gravityAcceleration是可替换的，因此需要重新声明
产生用户定义的重力场。
                       </td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Fluid.Valves.</strong></td></tr>
<tr><td> ValveIncompressible<br>
                      ValveVaporizing<br>
                      ValveCompressible</td>
    <td> (a) 模型引入了可选的开孔信号滤波
开启/关闭驱动器的延时时间。在本例中，是可选的
可以定义leakageOpening来模拟泄漏流和/或
在某些情况下提高数字。
(b)在某些情况下改进了阀门特性的规范化
所以它是二次可微的(smooth=2)
而不是连续的(平滑=0)。</td>
                      </tr>

<tr><td colspan=\"2\"><strong>Modelica.Fluid.Sources.</strong></td></tr>
<tr><td> FixedBoundary<br>
                      Boundary_pT<br>
                      Boundary_ph</td>
    <td> 改变了实现方式，使无非线性代数
如果给定的变量(例如p,T,X)存在，则出现方程系统
不对应于介质状态(如p,h,X)。这是
通过使用适当的“setState_xxx”调用来计算
从给定变量得到的中等状态。如果一个非线性方程
类中的专用处理程序解决
setState_xxx(..)函数，但在模型中，该方程组为
不可见的。</td>
                      </tr>

<tr><td colspan=\"2\"><strong>Modelica.Media.Interfaces.</strong></td></tr>
<tr><td> PartialMedium </td>
    <td> 类型SpecificEnthalpy、SpecificEntropy、
由于报告的用户问题，SpecificHeatCapacity增加。<br>
引入新的常量C_nominal来提供标称值
痕量物质(用于Modelica)。流体避免数值问题;
这个修复票
                      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/393\">#393</a>).</td>
                      </tr>

<tr><td colspan=\"2\"><strong>Modelica.Thermal.</strong></td></tr>
<tr><td> HeatTransfer.*</td>
    <td> 所有的图标都是统一的
Modelica.Blocks库:<br>
                      \"%name\": width: -150 .. 150, height: 40, color: blue<br>
                      other text: height: 30, color: black
                       </td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Math.Matrices</strong></td></tr>
<tr><td> QR </td>
    <td> 已经添加了一个布尔输入\"pivoting\" (现在是QR(A, pivoting))来提供不进行pivoting (QR(A, false))的QR分解。默认值是pivot =true。</td></tr>
</table>

<p><br>
以下<font color=\"red\"><strong>critical errors</strong></font>已被修复(即错误)
这可能导致错误的模拟结果):
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><strong>Modelica.Electrical.Digital.Delay.</strong></td></tr>
<tr><td> InertialDelaySensitive </td>
    <td> 以决定是否上升延迟(tLH)或
使用下降延迟(tHL)，即“前一个”值
必须使用输出y，而不是参数的“前一个”值
输入x (delayType = delayTable[y_old, x])
delayType = delayTable[x_old, x])。这已经被纠正了。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Mechanics.MultiBody.Parts.</strong></td></tr>
<tr><td> BodyBox<br>
                      BodyCylinder </td>
    <td> 修复的机票
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/373\">#373</a>:
\"Center of Mass\"计算为normalize(r)*length/2。这是
只有当盒子/圆柱连接在frame_a和frame_b之间时才正确。
如果事实并非如此，那么计算就错了。
使用正确的公式将其固定:<br>
                      r_shape + normalize(lengthDirection)*length/2</td></tr>
<tr><td> BodyShape<br>
                      BodyBox<br>
                      BodyCylinder </td>
    <td> 修复的机票
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/300\">#300</a>:
如果参数enforceStates=true，则发生错误。
这个问题已经解决了。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Mechanics.Rotational.Components.</strong></td></tr>
<tr><td> LossyGear</td>
    <td> 在驱动法兰不明显的情况下，部件可以
导致事件迭代不收敛。这个问题已经修复了
(车票上有详细说明
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/108\">#108</a>
在
<a href=\"modelica://Modelica/Resources/Documentation/Mechanics/Lossy-Gear-Bug_Solution.pdf\">attachment</a>
这张票)。</td></tr>

<tr><td> Gearbox</td>
    <td> 如果useSupport=false，则内部LossyGear的支撑法兰
模型已连接到(禁用)支持连接器。结果，
LossyGear是“自由浮动的”。这已经被纠正了。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Fluid.Pipes.</strong></td></tr>
<tr><td> DynamicPipe</td>
    <td> 修正了动态质量，能量和动量平衡的错误
对于nParallel&gt;1的管道。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.</strong></td></tr>
<tr><td> PartialPipeFlowHeatTransfer</td>
    <td> 传热通径雷诺数的计算
如果nParallel&gt;1;
这个局部模型由LocalPipeFlowHeatTransfer使用
对于管道中的层流和湍流强迫对流。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Media.Interfaces.PartialLinearFluid</strong></td></tr>
<tr><td> setState_psX</td>
    <td> 符号错误修正。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Media.CompressibleLiquids.</strong></td></tr>
<tr><td> LinearColdWater</td>
    <td> 修正了导热系数和粘度的错误值。</td></tr>

</table>

<p><br>
以下<font color=\"red\"><strong>不重要的错误</strong></font>已被修复(即错误)
<font color=\"red\"><strong>不是</strong></font>会导致错误的模拟结果，但是，例如:
单元错误或文档中有错误):
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><strong>Modelica.Math.Matrices.LAPACK</strong></td></tr>
<tr><td> dgesv_vec<br>
                        dgesv<br>
                        dgetrs<br>
                        dgetrf<br>
                        dgetrs_vec<br>
                        dgetri<br>
                        dgeqpf<br>
                        dorgqr<br>
                        dgesvx<br>
                        dtrsyl</td>
    <td> 用于指定矩阵前导维的整数输入有一个下界1(例如，lda=max(1,n))
为了避免在空矩阵的情况下出现不正确的值(例如，lda=0)。<br>
指示LAPACK例程成功调用的Integer变量“info”已被转换为输出，其中它曾是受保护的变量。</td></tr>
</table>

<p><br>
以下跟踪票已被修复:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><strong>Modelica</strong></td></tr>
<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/155\">#155</a></td>
    <td>错误地使用了“fillColor”和“fillPattern”注释</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/211\">#211</a></td>
    <td>MSL中未定义的函数realString</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/216\">#216</a></td>
    <td>使MSL 3.2版本更符合Modelica 3.1</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/218\">#218</a></td>
    <td>将“Modelica://”- uri替换为“Modelica://”- uri</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/271\">#271</a></td>
    <td>MSL 3.1中的URI错误</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/292\">#292</a></td>
    <td>删除空 \"\" annotations\"</td>
</tr>
<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/294\">#294</a></td>
    <td>输入错误 'w.r.t' --> 'w.r.t.'</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/296\">#296</a></td>
    <td>统一免责声明信息，改进不良风格的\"here\"链接</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/333\">#333</a></td>
    <td>修正表单的实数格式 `.[0-9]+`</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/347\">#347</a></td>
    <td>MSL 3.2中无效的URI</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/355\">#355</a></td>
    <td>非标准的注释</td>
</tr>

<tr><td colspan=\"2\"><br><strong>Modelica.Blocks</strong></td></tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/227\">#227</a></td>
    <td>通过在一些块中添加'unit=\"1\"'来增强单元推导功能</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/349\">#349</a></td>
    <td>Blocks/Continuous.mo中的注释不正确</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/374\">#374</a></td>
    <td>中根本没有值的参数 Modelica.Blocks.Continuous.TransferFunction</td>
</tr>

<tr><td colspan=\"2\"><br><strong>Modelica.Constants</strong></td></tr>
<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/356\">#356</a></td>
    <td>加上欧拉-马斯切罗尼常数 Modelica.Constants</td>
</tr>

<tr><td colspan=\"2\"><br><strong>Modelica.Electrical.Analog</strong></td></tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/346\">#346</a></td>
    <td>多文本输入 Modelica.Electrical.Analog.Basic.Conductor</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/363\">#363</a></td>
    <td>索引表达式中实数和整数的混合 Modelica.Electrical.Analog.Lines</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/384\">#384</a></td>
    <td>某些示例中的注释不完整</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/396\">#396</a></td>
    <td>错误的 Modelica.Electrical.Analog.Ideal.ControlledIdealIntermediateSwitch</td>
</tr>

<tr><td colspan=\"2\"><br><strong>Modelica.Machines</strong></td></tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/276\">#276</a></td>
    <td>改进/修复Modelica.Electrical.Machines的文档</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/288\">#288</a></td>
    <td>描述机器的热概念</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/301\">#301</a></td>
    <td>Electrical.Machines.Examples示例文档需要更新</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/306\">#306</a></td>
    <td>合并`Modelica.Electrical.Machines.Icons`的内容。图标变成了`Modelica.Icons`图标的</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/362\">#362</a></td>
    <td>直流电机的不完全示例模型</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/375\">#375</a></td>
    <td>奇异的最终参数没有值，只有一个起始值</td>
</tr>

<tr><td colspan=\"2\"><br><strong>Modelica.Electrical.Polyphase</strong></td></tr>
<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/173\">#173</a></td>
    <td>m相互感器</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/200\">#200</a></td>
    <td>调整多相到模拟</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/277\">#277</a></td>
    <td>改进/修复Modelica.Electrical.Polyphase的文档</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/352\">#352</a></td>
    <td>Modelica.Electrical.Polyphase.Sources.SignalVoltage中的奇数注释</td>
</tr>

<tr><td colspan=\"2\"><br><strong>Modelica.Fluid</strong></td></tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/215\">#215</a></td>
    <td>错误的 Modelica.Fluid.Pipes.DynamicPipe</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/219\">#219</a></td>
    <td>Fluid.Examples.HeatExchanger: 热传递关闭，无法开启</td>
</tr>

<tr><td colspan=\"2\"><br><strong>Modelica.Math</strong></td></tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/348\">#348</a></td>
    <td>文档中的小错误</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/371\">#371</a></td>
    <td>Modelica.Math声明为\"C\"而非\"builtin\"\"的数学函数</td>
</tr>

<tr><td colspan=\"2\"><br><strong>Modelica.Mechanics.MultiBody</strong></td></tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/50\">#50</a></td>
    <td>LineForce处理潜在根时出错</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/71\">#71</a></td>
    <td>MultiBody.World可更换</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/181\">#181</a></td>
    <td>三维表面可视化</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/210\">#210</a></td>
    <td>描述内齿轮丢失</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/242\">#242</a></td>
    <td>缺少MultiBody中修饰符的每个限定符。</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/251\">#251</a></td>
    <td>对BodyShape使用enforceStates=true会导致错误</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/255\">#255</a></td>
    <td>在Revolute处理非归一化旋转轴时出错</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/268\">#268</a></td>
    <td>MultiBody中的非标准注释,Examples.Systems.RobotR3</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/269\">#269</a></td>
    <td>目的是 MultiBody.Examples.Systems.RobotR3.Components.InternalConnectors?</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/272\">#272</a></td>
    <td>函数的World.gravityAcceleration不应该被保护</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/274\">#274</a></td>
    <td>方便和强大的初始化的框架运动学</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/286\">#286</a></td>
    <td>在Multibody/Frames.mo中出现错字</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/300\">#300</a></td>
    <td>在BodyShape, BodyBox, body圆柱体中，强制执行参数管理不正确</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/320\">#320</a></td>
    <td>用`showStartAttribute`替换非标准注释</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/373\">#373</a></td>
    <td>Modelica力学中的错误</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/389\">#389</a></td>
    <td>Shape.rxvisobj在Arrow/DoubleArrow中被错误引用</td>
</tr>

<tr><td colspan=\"2\"><br><strong>Modelica.Mechanics.Rotational</strong></td></tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/108\">#108</a></td>
    <td>模型\"Lossy Gear\"的问题及其解决方法</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/278\">#278</a></td>
    <td>改进/修复Modelica.Mechanics.Rotational的文档</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/381\">#381</a></td>
    <td>修正了Modelica.Mechanics.Rotational.Gearbox</td>
</tr>

<tr><td colspan=\"2\"><br><strong>Modelica.Mechanics.Translational</strong></td></tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/279\">#279</a></td>
    <td>改进/修复Modelica.Mechanics.Translational的文档</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/310\">#310</a></td>
    <td>Modelica.Mechanics.Translational中的错误图像链接</td>
</tr>

<tr><td colspan=\"2\"><br><strong>Modelica.Media</strong></td></tr>
<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/72\">#72</a></td>
    <td>Modelica.Media中没有为所有媒体提供PartialMedium函数。</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/217\">#217</a></td>
    <td>缺少图像文件Air.png</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/224\">#224</a></td>
    <td>在waterBaseProp_dT中的dpT计算</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/393\">#393</a></td>
    <td>在Modelica中提供C_nominal。允许传播的媒体
值，避免错误的数值结果</td>
</tr>

<tr><td colspan=\"2\"><br><strong>Modelica.StateGraph</strong></td></tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/206\">#206</a></td>
    <td>StateGraph.mo中的语法错误</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/261\">#261</a></td>
    <td>Modelica.StateGraph应该提到Modelica_StateGraph2的可用性</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/354\">#354</a></td>
    <td>Modelica.StateGraph.Temporary.NumericValue中的错误注释</td>
</tr>

<tr><td colspan=\"2\"><br><strong>Modelica.Thermal.FluidHeatFlow</strong></td></tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/280\">#280</a></td>
    <td>改进/修复Modelica.Thermal.FluidHeatFlow的文档</td>
</tr>

<tr><td colspan=\"2\"><br><strong>Modelica.Thermal.HeatTransfer</strong></td></tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/281\">#281</a></td>
    <td>改进/修复Modelica.Thermal.HeatTransfer文档</td>
</tr>

<tr><td colspan=\"2\"><br><strong>Modelica.UsersGuide</strong></td></tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/198\">#198</a></td>
    <td>MSL中组件的名称不符合命名约定</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/204\">#204</a></td>
    <td>对用户指南中版本管理部分的小修正</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/244\">#244</a></td>
    <td>更新用户指南的联系人部分</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/267\">#267</a></td>
    <td>MSL-Documentation:方程式不应该在右侧编号吗?</td>
</tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/299\">#299</a></td>
    <td>SVN关键字扩展导致版本管理用户指南部分混乱</td>
</tr>

<tr><td colspan=\"2\"><br><strong>Modelica.Utilities</strong></td></tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/249\">#249</a></td>
    <td>modelicutilities .h中的文档错误</td>
</tr>

<tr><td colspan=\"2\"><br><strong>ModelicaServices</strong></td></tr>

<tr><td>
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/248\">#248</a></td>
    <td>MSL 3.1中ModelicaServices的No uses语句</td>
</tr>

</table>

<p>
Note:
</p>
<ul>
<li> 库
<a href=\"https://github.com/modelica-deprecated/Modelica_FundamentalWave\">Modelica_FundamentalWave</a>
和
<a href=\"https://github.com/modelica-deprecated/Modelica_Quasistationary\">Modelica_QuasiStationary</a>
以改进的形式包含在本版本中。</li>
<li> 从图书馆
<a href=\"https://github.com/modelica/Modelica_LinearSystems2\">Modelica_LinearSystems2</a>
的子程序库
数学。复杂的数学。向量和数学。矩阵包含在这个版本中
以改良的形式。</li>
<li> 从图书馆
<a href=\"https://github.com/modelica/Modelica_StateGraph2\">Modelica_StateGraph2</a>,
子库Blocks以改进的形式包含在这个版本中。</li>
</ul>
</html>"            ));
      end Version_3_2;

      class Version_3_1 "Version 3.1 (August 14, 2009)"
        extends Modelica.Icons.ReleaseNotes;

        annotation(Documentation(info = "<html>

<p>
3.1版本向后兼容3.0和3.0.1版本，
也就是说，使用3.0或3.0.1版本开发的模型将在没有任何插件的情况下工作
3.1版也有变化。
</p>

<p>
版本3.1略微基于Modelica规范3.1。它使用
以下是新的语言元素(与Modelica规范3.0相比):
</p>

<ul>
<li> 前缀<u>stream</u>和内置操作符<u>inStream(..)</u>
和<u>actualStream(..)</u> Modelica.Fluid。</li>
<li> Modelica.Fluid中的注释<u>connectorSizing</u></li>
<li> Modelica.Media中的注释<u>inverse</u></li>
<li> 注释<u>versionBuild</u>、<u>dateModified</u>、
<u>revisionId</u>在Modelica包的根级注释中，
改进版本处理。</li>
<li> 修饰符可用于连接器实例(因此是平衡模型)
限制较少)。这使得实现成为可能
条件连接器(支持和热端口)的旋转，
翻译和电子库更简单。</li>
</ul>

<p>
以下<font color=\"blue\"><strong>new libraries</strong></font>:
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><a href=\"modelica://Modelica.Fluid\">Modelica.Fluid</a></td>
    <td>
     模型1-dim的组件。热流体在容器、管道、
流体机械、阀门及配件。所有来自
Modelica。可以使用媒体库(不可压缩或可压缩)，
单一或多种物质，一相或两相介质)。
该库使用了Modelica Specification 3.1中的流概念。
    </td></tr>

<tr><td><a href=\"modelica://Modelica.Magnetic.FluxTubes\">Modelica.Magnetic.FluxTubes</a></td>
    <td>
     基于磁通管概念的磁性器件模型组件。
尤其是对模特来说
电磁致动器。非线性形状、受力、泄漏等
材料模型。材料数据为钢材、电薄板、纯铁、
钴铁，镍铁，NdFeB, Sm2Co17等。
    </td></tr>

<tr><td><a href=\"modelica://ModelicaServices\">ModelicaServices</a></td>
    <td>
     新的顶层包，将包含将在项目中使用的功能和模型
Modelica标准库，它需要特定于工具的实现。
ModelicaServices然后在Modelica包中使用。
在第一个版本中，3-dim。动画模型Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape
被移动到ModelicaServices。工具供应商现在可以提供他们自己的实现
动画的。
    </td></tr>
</table>

<p><br>
新增了以下<font color=\"blue\"><strong>组件</strong></font
<font color=\"blue\"><strong>现有</strong></font>库:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><strong>Modelica.</strong></td></tr>
<tr><td> versionBuild<br>versionDate<br>dateModified<br>revisionId </td>
    <td> Modelica 3.1为版本处理添加了新的注解。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.UsersGuide.ReleaseNotes.</strong></td></tr>
<tr><td> VersionManagement </td>
    <td> 从以前的ReleaseNotes的信息层复制(使其更
(可见)并使之适应新的可能性
Modelica规范3.1。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Blocks.Math.</strong></td></tr>
<tr><td> RectangularToPolar<br>
                      PolarToRectangular </td>
    <td> 在矩形和极坐标形式之间转换的新块
空间相位。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Blocks.Routing.</strong></td></tr>
<tr><td> Replicator </td>
    <td> 将一个输入信号复制到许多输出信号的新块。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Analog.Examples.</strong></td></tr>
<tr><td> AmplifierWithOpAmpDetailed<br>
                      HeatingResistor<br>
                      CompareTransformers<br>
                      OvervoltageProtection<br>
                      ControlledSwitchWithArc<br>
                      SwitchWithArc<br>
                      ThyristorBehaviourTest</td>
    <td> 新示例演示新组件的使用。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Analog.Basic.</strong></td></tr>
<tr><td> OpAmpDetailed<br>
                      TranslationalEMF<br>
                      M_Transformer</td>
    <td> 运算放大器的新详细模型。<br>
                      新电动力由电能转化为机械平动能。<br>
具有可选择电感数量的通用变压器</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Analog.Ideal.</strong></td></tr>
<tr><td> OpenerWithArc<br>
                      CloserWithArc<br>
                      ControlledOpenerWithArc<br>
                      ControlledCloserWithArc</td>
    <td> 新的开关，简单的电弧模型。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Analog.Interfaces.</strong></td></tr>
<tr><td> ConditionalHeatPort</td>
    <td> 添加条件HeatPort的新局部模型
电气部件</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Analog.Lines.</strong></td></tr>
<tr><td> M_Oline</td>
    <td> 新增多线模型，线数和段数均可选择。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Analog.Semiconductors.</strong></td></tr>
<tr><td> ZDiode<br>Thyristor</td>
    <td> 齐纳二极管与3个工作区域和简单的晶闸管模型。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Polyphase.Ideal.</strong></td></tr>
<tr><td> OpenerWithArc<br>CloserWithArc</td>
    <td> 具有简单电弧模型的新型开关(如Modelica.Electrical.Analog.Ideal.)。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Mechanics.MultiBody.Examples.Elementary.</strong></td></tr>
<tr><td> RollingWheel<br>
                      RollingWheelSetDriving<br>
                      RollingWheelSetPulling</td>
    <td> 新示例演示新组件的使用。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Mechanics.MultiBody.Joints.</strong></td></tr>
<tr><td> RollingWheel<br>
                      RollingWheelSet</td>
    <td> 新的关节(没有质量，没有惯性)描述一个
理想辊轮和理想辊轮组组成
两个轮子在平面上滚动z=0。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Mechanics.MultiBody.Parts.</strong></td></tr>
<tr><td> RollingWheel<br>
                      RollingWheelSet</td>
    <td> 新型理想滚轮和理想滚轮组组成
两个轮子在平面上滚动z=0。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Mechanics.MultiBody.Visualizers.</strong></td></tr>
<tr><td> Ground</td>
    <td> 可视化地面的新模型(z=0处的方框)。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Mechanics.Rotational.Interfaces.</strong></td></tr>
<tr><td> PartialElementaryOneFlangeAndSupport2<br>
                      PartialElementaryTwoFlangesAndSupport2</td>
    <td> 新的局部模型有一个和两个法兰和支撑法兰
与前面的实现一样简单得多。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Mechanics.Translational.Interfaces.</strong></td></tr>
<tr><td> PartialElementaryOneFlangeAndSupport2<br>
                      PartialElementaryTwoFlangesAndSupport2</td>
    <td> 新的局部模型有一个和两个法兰和支撑法兰
与前面的实现一样简单得多。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Media.IdealGases.Common.MixtureGasNasa.</strong></td></tr>
<tr><td> setSmoothState</td>
    <td> 返回热力学状态，使其平滑逼近:
如果x &gt;0则state_a else state_b。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Utilities.Internal.</strong></td></tr>
<tr><td> PartialModelicaServices</td>
    <td> 的接口描述的新包
需要依赖于工具的模型和功能
实现(目前只有\"Shape\"为3-dim。动画,
但将来会延长)</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Thermal.HeatTransfer.Components.</strong></td></tr>
<tr><td> ThermalCollector</td>
    <td> 新的辅助模型来收集热流
从m个热口变为1个热口;
适用于多相电阻(带加热器)
作为m个端口的连接点。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Icons.</strong></td></tr>
<tr><td> VariantLibrary<br>
                      BaseClassLibrary<br>
                      ObsoleteModel</td>
    <td> 新的图标(VariantLibrary和BaseClassLibrary)被移动
从Modelica_Fluid。图标到这个地方)。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.SIunits.</strong></td></tr>
<tr><td> ElectricalForceConstant </td>
    <td> 新增类型 (#190).</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.SIunits.Conversions.</strong></td></tr>
<tr><td> from_Hz<br>
                      to_Hz</td>
    <td> 在频率[Hz]和之间转换的新功能
角速度[1/s]。 (#156) </td></tr>

</table>

<p><br>
<font color=\"blue\"><strong>现有组件</strong></font>
<font color=\"blue\"><strong> </strong></font>在
<font color=\"blue\"><strong>向后兼容</strong></font>方式:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><strong>Modelica.</strong></td></tr>
<tr><td> Blocks<br>Mechanics<br>StateGraph </td>
    <td> 提供示例缺少的参数值
(这些参数只有起始值)</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Analog.Basic</strong></td></tr>
<tr><td> Resistor, Conductor, VariableResistor, VariableConductor</td>
    <td> 增加了用于耦合到热网络的条件热端口。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Analog.Ideal</strong></td></tr>
<tr><td> Thyristors, Switches, IdealDiode</td>
    <td> 增加了用于耦合到热网络的条件热端口。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Analog.Semiconductors</strong></td></tr>
<tr><td> Diode, ZDiode, PMOS, NMOS, NPN, PNP</td>
    <td> 增加了用于耦合到热网络的条件热端口。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Polyphase.Basic</strong></td></tr>
<tr><td> Resistor, Conductor, VariableResistor, VariableConductor</td>
    <td> 添加了用于耦合到热网的条件热口(如Modelica.Electrical.Analog)。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Polyphase.Ideal</strong></td></tr>
<tr><td> Thyristors, Switches, IdealDiode</td>
    <td> 添加了用于耦合到热网的条件热口(如Modelica.Electrical.Analog)。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Mechanics.MultiBody.Visualizers.Advanced.</strong></td></tr>
<tr><td> Shape </td>
    <td> 从ModelicaServices继承的新实现。这允许
工具供应商提供自己的Shape实现。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.StateGraph.</strong></td></tr>
<tr><td> Examples </td>
    <td> 在所有示例模型的顶层引入了\"StateGraphRoot\"。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.StateGraph.Interfaces.</strong></td></tr>
<tr><td> StateGraphRoot<br>PartialCompositeStep<br>CompositeStepState </td>
    <td> 替换错误的Modelica代码\"flow output Real xxx\"
\"Real dummy; flow Real xxx;\"。
作为一个副作用，几个\"blocks\"必须被更改为\"models\"。</td></tr>
<tr><td> PartialStep </td>
    <td> 通过将受保护的外部连接器装入模型来更改模型。
否则，流量变量的符号可能会有所不同
Modelica 3.0和3.1中。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Utilities.Examples.</strong></td></tr>
<tr><td> expression </td>
    <td> 将局部变量\"operator\"改为\"opString\"，因为\"operator\"
是Modelica 3.1中的保留关键字 </td></tr>
</table>

<p><br>
以下<font color=\"red\"><strong>uncritical errors</strong></font>已被修复(即错误)
<font color=\"red\"><strong>not</strong></font>会导致错误的模拟结果，但是，例如:
单元错误或文档中有错误):
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><strong>Modelica.</strong></td></tr>
<tr><td> 许多模型</td>
    <td> 删除了注释fillColor和fillPattern的错误用法
在文本注释中 (#155, #185).</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.Machines</strong></td></tr>
<tr><td> 所有机型</td>
    <td> 实例化电阻器的条件热端口
(这是Modelica.Electrical.Analog和Modelica.Electrical.Polyphase的新功能)
直到为机器设计的热连接器实现之前，最终关闭。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Media.Air.MoistAir</strong></td></tr>
<tr><td> saturationPressureLiquid<br>
                      sublimationPressureIce<br>
                      saturationPressure</td>
          <td> 对于这三个函数，修正了<code>derivative</code>注释中的错误。然而，的效果
这个错误是次要的，因为Modelica工具允许通过
<code>smoothOrder</code>注释</td>
</tr>
<tr><td colspan=\"2\"><strong>Modelica.Math.Matrices.</strong></td></tr>
<tr><td> eigenValues</td>
    <td> 错误文件更正 (#162)</td></tr>
</table>

</html>"            ));
      end Version_3_1;

      class Version_3_0_1 "Version 3.0.1 (Jan. 27, 2009)"
        extends Modelica.Icons.ReleaseNotes;

         annotation (Documentation(info="<html>

<p>
该Modelica软件包根据Modelica License 2许可证提供，不再遵循Modelica License 1.1许可证。
Modelica协会将Modelica License 1.1更改为新许可证文本的原因如下
(请注意，以下文本并不是对Modelica License 2的法律解释。如有冲突，应以许可证语言为准)：
</p>

<ol>
<li> 许可方和被许可方的权利更加明确。例如：
         <ul>
         <li> 许可的作品（原始作品）可以在开源和商业软件中以未修改的形式使用（被许可方不能更改许可证，且作品必须免费提供）</li>
         <li> 如果从根据Modelica License 2许可证发布的Modelica包中复制一个模型组件，并进行修改以适应建模者的需求，
              那么修改后的结果可以根据任何许可证进行授权（包括商业许可证）。</li>
         <li> 实际上，无法将Modelica License 2下的Modelica包的许可证更改为其他许可证。
              也就是说，被许可方不能通过添加材料或更改类来更改许可证，
              因此作品必须保持在Modelica License 2下（更准确地说，如果被许可方对“整体上代表原创作品”的原始作品进行了修改，
              他/她可以将许可证更改为其他许可证。
              然而，对于一个Modelica包来说，这通常需要大量的更改，通常是不现实的）。</li>
         <li> 如果使用根据Modelica License 2许可证发布的Modelica包构建了可执行文件，
              则该可执行文件可以根据任何许可证进行授权（包括商业许可证）。</li>
         </ul>
         我们希望这种在开源贡献者、商业Modelica环境和Modelica用户之间的妥协，
         能够激励更多的人在Modelica License 2下自由地提供他们的Modelica包。<br><br></li>
<li> 还增加了几个新条款，以使对许可方和被许可方的法律诉讼更不可能发生（从而进一步降低小风险）。</li>
</ol>

<p><br>
以下<font color=\"blue\"><strong>新组件</strong></font>已添加到<font color=\"blue\"><strong>现有</strong></font>库中：
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><strong>Electrical.Analog.Basic.</strong></td></tr>
<tr><td>M_Transformer</td>
          <td> 变压器，允许选择电感的数量。电感和耦合电感可以任意选择。</td></tr>

<tr><td colspan=\"2\"><strong>Electrical.Analog.Lines.</strong></td></tr>
<tr><td>M_OLine</td>
          <td> 分段线路模型，支持使用多条线路，即用户可以选择段数和单条线路的数量。该模型允许研究多条线路上的现象，如互感或电容影响。</td></tr>
<tr><td colspan=\"2\"><strong>Mechanics.Translational.Components.Examples.</strong></td></tr>
<tr><td>Brake</td>
          <td> 演示了平移制动组件的使用。</td></tr>
<tr><td colspan=\"2\"><strong>Media.Interfaces.PartialMedium.</strong></td></tr>
<tr><td>ThermoStates</td>
          <td> 用于标识介质独立变量的枚举类型(pT、ph、phX、pTX、dTX)。
为每种介质提供了该枚举的实现。(这对于不使用PartialMedium.BaseProperties模型的流体库非常有用)。</td></tr>
<tr><td>setSmoothState</td>
          <td> 一个函数，返回平滑近似的热力学状态：
如果 x > 0，则为 state_a，否则为 state_b。
(这对于流体库中的压力降组件很有用，在这些组件中，需要计算上游密度和/或粘度，并且这些属性应该在零质量流率下平滑变化)。
为每种介质提供了该函数的实现。</td></tr>
<tr><td colspan=\"2\"><strong>Media.Common.</strong></td></tr>
<tr><td>smoothStep</td>
          <td> 近似一般步骤，使得特性是连续且可微的。</td></tr>
<tr><td colspan=\"2\"><strong>Media.UsersGuide.</strong></td></tr>
<tr><td>Future</td>
          <td> 对即将发布的Modelica.Media版本的目标和变化进行简要描述。</td></tr>
<tr><td colspan=\"2\"><strong>Media.Media.Air.MoistAir.</strong></td></tr>
<tr><td>isentropicExponent</td>
          <td> 实现了接口中缺失的函数。</td></tr>
<tr><td>isentropicEnthalpyApproximation</td>
<td> 实现了一个近似等熵焓变化的函数。只有在流体中没有液体时，此近似才是正确的。</td></tr>
</table>

<p><br>
以下<font color=\"blue\"><strong>现有组件</strong></font>已被<font color=\"blue\"><strong>更改</strong></font>(以<font color=\"blue\"><strong>向后兼容</strong></font>的方式)：
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><strong>Mechanics.Rotational.Interfaces.</strong></td></tr>
<tr><td> PartialFriction </td>
          <td> 改进了摩擦模型，使得在某些情况下，迭代次数大大减少。</td>
</tr>

<tr><td colspan=\"2\"><strong>Mechanics.Translational.Components.Examples.</strong></td></tr>
<tr><td> Friction </td>
          <td> 增加了第三种变体，其中摩擦使用SupportFriction组件进行建模。</td></tr>

<tr><td colspan=\"2\"><strong>Mechanics.Translational.Components.</strong></td></tr>
<tr><td> MassWithStopAndFriction </td>
          <td> 改进了摩擦模型，使得在某些情况下，迭代次数大大减少。</td>
</tr>

<tr><td colspan=\"2\"><strong>Mechanics.Translational.Interfaces.</strong></td></tr>
<tr><td> PartialFriction </td>
          <td> 改进了摩擦模型，使得在某些情况下，迭代次数大大减少。</td>
</tr>

<tr><td colspan=\"2\"><strong>Media.Examples.</strong></td></tr>
<tr><td> SimpleLiquidWater<br>
                                                IdealGasH20<br>
                                                WaterIF97<br>
                                                MixtureGases<br>
                                                MoistAir </td>
          <td> 添加了方程以测试新的setSmoothState(..)函数，包括这些函数的解析导数。</td></tr>

<tr><td colspan=\"2\"><strong>Media.Interfaces.PartialLinearFluid.</strong></td></tr>
<tr><td> setState_pTX<br>
                                                setState_phX<br>
                                                setState_psX<br>
                                                setState_dTX </td>
          <td> 将函数重写为一个语句，以便通常可以内联。</td></tr>

<tr><td colspan=\"2\"><strong>Media.Interfaces.PartialLinearFluid.</strong></td></tr>
<tr><td> 一致使用reference_d代替density(state) </td>
          <td> 此更改是为了与解析反函数保持一致。</td></tr>

<tr><td colspan=\"2\"><strong>Media.Air.MoistAir.</strong></td></tr>
<tr><td> T_phX </td>
          <td> 非线性求解器计算T(温度)从p、h、X(压力、焓、质量分数)变化的区间，从200..6000改为240..400K。</td></tr>

</table>

<p><br>
以下<font color=\"red\"><strong>关键错误</strong></font>已被修复(即可能导致错误仿真结果的错误)：
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><strong>Mechanics.MultiBody.Forces</strong></td></tr>
<tr><td> WorldTorque </td>
          <td> 参数\"ResolveInFrame\"没有被传播，因此始终使用默认值（在世界坐标系中求解），与该参数的设置无关。</td>
</tr>
<tr><td> WorldForceAndTorque </td>
          <td> 参数\"ResolveInFrame\"没有被传播，因此始终使用默认值（在世界坐标系中求解），与该参数的设置无关。<br>
此外，内部使用了WorldTorque而不是Internal.BasicWorldTorque，因此worldTorque的可视化被执行了两次。</td>
</tr>
<tr><td colspan=\"2\"><strong>Mechanics.MultiBody.Sensors</strong></td></tr>
<tr><td> AbsoluteSensor </td>
          <td> 速度、加速度和角加速度是通过在resolveInFrame坐标系中求导得到的。
          这个问题已经修正，现在首先将向量转换到世界坐标系，再在世界坐标系中求导，最后再转换回resolveInFrame坐标系。
          高级菜单中的参数resolveInFrameAfterDifferentiation变得多余，已被移除。</td>
</tr>
<tr><td> AbsoluteVelocity </td>
          <td> 速度是通过在resolveInFrame坐标系中求导得到的。
          这个问题已经修正，现在首先将速度转换到世界坐标系，再在世界坐标系中求导，最后再转换回resolveInFrame坐标系。</td>
</tr>
<tr><td> RelativeSensor </td>
          <td> 如果resolveInFrame ≠ frame_resolve且resolveInFrameAfterDifferentiation = frame_resolve，会发生平移误差，因为在这种情况下未启用 frame_resolve。此问题已被修正。</td>
</tr>
<tr><td> RelativeVelocity </td>
          <td> 速度是通过在resolveInFrame坐标系中求导得到的。这个问题已被修正，现在首先将相对位置转换到frame_a坐标系，再在该坐标系中求导，最后转换回resolveInFrame坐标系。</td>
</tr>
<tr><td> TransformRelativeVector </td>
          <td> 转换错误，因为frame_r_in和frame_r_out参数没有被传递到执行转换的子模型中。此问题已被修正。</td>
</tr>
<tr><td colspan=\"2\"><strong>Mechanics.Translational.Components.</strong></td></tr>
<tr><td> SupportFriction<br>
                                                Brake </td>
          <td> 摩擦力的符号是错误的，因此摩擦力加速而不是减速。这个问题已经修复。</td>
</tr>
<tr><td> SupportFriction</td>
          <td> 该组件仅对固定支撑有效。这个问题已经修复。</td>
</tr>
<tr><td colspan=\"2\"><strong>Media.Interfaces.</strong></td></tr>
<tr><td> PartialSimpleMedium<br>
                                                PartialSimpleIdealGasMedium </td>
          <td> BaseProperties.p没有被定义为优选状态，而BaseProperties.T始终被定义为优选状态。这个问题已经通过在参数preferredMediumState = true时将p和T定义为优选状态来修复。
这个错误的影响是，质量m被选作状态而不是p，如果使用默认初始化，则m=0可能不会得到预期的行为。这意味着仿真结果本身并不错误，但数值计算不够精确，如果模型依赖默认初始值，结果可能与预期不符。</td>
</tr>

</table>

<p><br>
以下<font color=\"red\"><strong>非关键错误</strong></font>已经修复(即<font color=\"red\"><strong>不会</strong></font>导致错误仿真结果，但例如单位错误或文档中的错误)：
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><strong>Blocks.Math.</strong></td></tr>
<tr><td> InverseBlockConstraint </td>
          <td> 将注释preserveAspectRatio从true改为false。</td>
</tr>

<tr><td colspan=\"2\"><strong>Blocks.Sources.</strong></td></tr>
<tr><td> RealExpression<br>
                                                IntegerExpression<br>
                                                BooleanExpression </td>
          <td> 将注释preserveAspectRatio从true改为false。</td>
</tr>

<tr><td colspan=\"2\"><strong>Electrical.Analog.Basic.</strong></td></tr>
<tr><td> SaturatingInductor</td>
          <td> 将非标准的\"arctan\"函数替换为\"atan\"函数。</td>
</tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Digital.</strong></td></tr>
<tr><td> UsersGuide</td>
          <td> 删除了空的文档占位符，并添加了版本1.0.7的缺失发布注释。</td>
</tr>

<tr><td colspan=\"2\"><strong>Modelica.Mechanics.Translational.Components.</strong></td></tr>
<tr><td> MassWithStopAndFriction </td>
          <td> 更改了reinit(..)的使用方式，使其按照语言规范仅对一个变量出现一次(如果工具能够模拟该模型，则没有区别)。</td>
</tr>

<tr><td colspan=\"2\"><strong>Media.Interfaces.PartialSimpleMedium</strong></td></tr>
<tr><td> pressure<br>
                                                temperature<br>
                                                density<br>
                                                specificEnthalpy </td>
          <td> 添加了缺失的函数。</td>
</tr>

</table>

</html>"      ));
      end Version_3_0_1;

      class Version_3_0 "Version 3.0 (March 1, 2008)"
        extends Modelica.Icons.ReleaseNotes;

        annotation(Documentation(info = "<html>
<p>
3.0版本<strong>与以前的版本不向后兼容。</strong>
提供了转换脚本来转换模型和库
将旧版本转换为新版本。因此,转换
应该是自动的。
</p>

<p>
以下是整个库的变化:
</p>

<ul>
<li> 在Modelica语言3.0版本中，有几个限制
引入以允许更好的检查，例如，必须平衡所有级别的模型
(方程数=未知变量数-未知变量有
在使用组件时定义)。Modelica的几个模型
标准库没有满足这些新的限制
要么移动到库<a href=\"https://github.com/modelica-deprecated/ObsoleteModelica3\">ObsoleteModelica3</a>(例如，Blocks.Math.TwoInputs)
或者必须以不同的方式实施
(例如,Media.Interfaces.PartialMedium.BaseProperties)。
Modelica标准库3.0版满足的所有限制
Modelica语言3.0版。<br>&nbsp;
         </li>

<li> 描述图标和图表层布局的图形注释
从Modelica语言版本1更改为Modelica语言版本3。
这提供了几个重要的改进:<br>特别是坐标系统
的图标和图表层不再耦合，因此的大小
图标层可以独立于图表层的大小进行更改。
还可以定义组件图标的宽高比在更改时保持不变
它在模型中的大小。设置此标志，以便Modelica的所有图标
标准库保持其长宽比。这有点不向后兼容:
如果在使用来自Modelica的组件时没有保持长宽比
标准库，它现在调整大小，以保持长宽比。<br>&nbsp;</li>

<li> 删除所有非标准注释:<br>
         (1) 删除注释，但没有效果
                 (e.g., \"__Dymola_experimentSetupOutput\", \"Window\", \"Terminal\" removed).<br>
         (2) 将注释重命名为标准名称 (e.g., \"Hide\" renamed to \"HideResult\").<br>
         (3) 将注释重命名为特定于供应商的名称
                 (e.g., \"checkBox\" renamed to \"__Dymola_checkBox\").<br>&nbsp;</li>

<li> 所有模拟枚举(通过包和常量定义)都已被
替换为\"real\"枚举。用户模型自动正确
已转换，前提是用户模型先前使用了包常量。
<strong>对枚举直接使用文字值的现有模型可能会屈服
在某些情况下，错误的结果</strong>(如果是模拟枚举的第一个常量)
值为0，而枚举的第一个值为1)。<br>&nbsp;</li>

<li> 操作符\"cardinality\"将在下一个版本中被删除
Modelica语言，因为它是一个反射运算符，而且它的用法很重要
减少了高级模型检查的可能性(例如，保证模型
是\"balanced\"，即方程和未知数的数量相同，
获取该组件的所有有效用法)。作为对这一变化的准备，所有
包含\"cardinality(..)\"运算符的模型将被重写:如果可能的话
操作员被移除。如果这是不可能的，它只用于断言
检查，例如，连接器至少连接一次或连接准确
一次。在下一个Modelica语言版本中，将引入新的语言元素
指定不使用基数运算符的属性检查。一旦这些
语言元素可用，基数运算符将被完全删除
来自Modelica标准库。<br>
         关于基数(…)操作符的更改通常不是向后的
兼容的。这就是变化的原因
旋转和平移库(见下文)。<br>&nbsp;</li>

<li> <strong>旋转</strong>和<strong>平移</strong>库的设计已经改变
(特别是要删除基数运算符(..)，见上文):
         <ul>
         <li> 组件有一个<strong>useSupport</strong>标志来启用或禁用支持法兰。
如果支撑法兰开启，则必须连接。如果已禁用，则必须禁用
不连接，然后组件内部接地。接地
在图标中显示。</li>
         <li> 所有力/扭矩元件的相对角度/距离和相对速度
(需要相对速度)在默认情况下由\"StateSelect.prefer\",即
使用这些变量作为首选状态。这改善了数字，如果
过程中绝对角度或绝对距离不断增加
操作(如汽车车轮的传动轴)。这种影响是相对的
角度/距离和速度被用作状态，这些变量的大小是
有限的。以前，默认是使用绝对角度/距离
每个惯量/质量的绝对速度缺点是
角度和(或)距离是不断增大的状态变量。<br>
                  一个显著的优点是，默认初始化通常更好，
因为相对角度/距离的默认值为零通常是
用户希望拥有。比方说，之前加载被初始化为非零
角度，然后必须明确地表示出弹性耦合电机惯量
也是用这个值初始化的。这是现在，不再需要。自默认设置以来
标称值通常为1，对于一个相对量来说，标称值过大
将相对角度/距离改为1e-4。</li>
         <li> 这两个图书馆已经在子图书馆中进行了重组以应对
随着组件数量的增加。</li>
         <li> 最后，翻译库已经
使其尽可能与旋转库相似，例如，添加missing
组件。<br>&nbsp;</li>
         </ul></li>

<li> 初始化的多体，旋转和动库有
通过删除\"initType\"参数而大大简化了
使用开始/固定值。这种设计假定工具具有特殊的支持
用于参数菜单中的起始/固定值。<br>&nbsp;</li>

<li> Modelica标准库中定义的几乎所有参数都是
用默认方程定义，例如:
<blockquote><pre><strong>parameter</strong> Modelica.SIunits.Resistance R=1; </pre></blockquote>
物理参数，如电阻，质量，传动比，没有意义
默认情况下，在几乎所有情况下，相应组件的用户都必须这样做
为这些参数提供值。如果用户忘记了这一点，一个工具
无法提供诊断，因为库中存在默认值
(如电阻为1欧姆)。在大多数情况下，模型将模拟，但不会
由于参数值错误，给出错误的结果。为了改善这种情况，所有的身体
Modelica标准库中的参数声明已经更改，因此
之前的默认值将成为起始值。例如，上面
声明更改为:
<blockquote><pre><strong>parameter</strong> Modelica.SIunits.Resistance R(start=1); </pre></blockquote>
这是一个向后兼容的更改，从角度来看是完全等价的
Modelica语言。但是，建议工具将打印警告
或者，如果定义了参数的起始值，则可以选择一条错误消息，但是
没有通过修改给出参数的值。此外，预计，
参数菜单的输入字段为空，如果没有定义默认方程，
但这只是一个起始值。这清楚地向建模者显示了一个值必须
被提供。</li>
</ul>

<p><br>
新增了以下<font color=\"blue\"><strong>组件</strong></font
到<font color=\"blue\"><strong>现有的</strong></font>库(注意，括号中的名称
是3.0版本中引入的新子库名称):
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><strong>Blocks.Examples.</strong></td></tr>
<tr><td>InverseModel</td>
          <td> 演示了逆模型的构造。</td></tr>

<tr><td colspan=\"2\"><strong>Blocks.Math.</strong></td></tr>
<tr><td>InverseBlockConstraints</td>
          <td> 通过要求两个输入来构造逆模型
两个输出是相同的(替换之前的，
不平衡，双输入和双输出块)。</td></tr>

<tr><td colspan=\"2\"><strong>Electrical.Machines.Utilities</strong></td></tr>
<tr><td>TransformerData</td>
          <td> 根据变压器标称数据计算所需阻抗(参数)的记录。</td></tr>

<tr><td colspan=\"2\"><strong>Mechanics.MultiBody.Examples.Rotational3DEffects</strong></td></tr>
<tr><td> GyroscopicEffects<br>
                                                ActuatedDrive<br>
                                                MovingActuatedDrive<br>
                                                GearConstraint </td>
          <td> 演示旋转库用法的新示例
结合多体部件。</td>
</tr>

<tr><td colspan=\"2\"><strong>Mechanics.MultiBody.Sensors</strong></td></tr>
<tr><td> AbsolutePosition<br>
                                                AbsoluteVelocity<br>
                                                AbsoluteAngles<br>
                                                AbsoluteAngularVelocity<br>
                                                RelativePosition<br>
                                                RelativeVelocity<br>
                                                RelativeAngles<br>
                                                RelativeAngularVelocity</td>
          <td> 新的传感器测量一个矢量。</td>
</tr>
<tr><td> TransformAbsoluteVector<br>
                                                TransformRelativeVector</td>
          <td> 将绝对矢量和/或相对矢量转换为另一个坐标系。</td>
</tr>

<tr><td colspan=\"2\"><strong>Mechanics.Rotational.(Components)</strong></td></tr>
<tr><td> Disc </td>
          <td> 右法兰相对于左法兰旋转一个固定的角度</td></tr>
<tr><td> IdealRollingWheel </td>
          <td> 简单的1-dim。无惯性的理想滚轮模型</td></tr>

<tr><td colspan=\"2\"><strong>Mechanics.Translational.Sensors</strong></td></tr>
<tr><td>RelPositionSensor<br>RelSpeedSensor<br>RelAccSensor<br>PowerSensor</td>
          <td> 相对位置传感器，即两个法兰之间的距离<br>
                                                相对速度传感器<br>
                                                相对加速度传感器<br>
                                                理想功率传感器</td></tr>
<tr><td colspan=\"2\"><strong>Mechanics.Translational(.Components)</strong></td></tr>
<tr><td>SupportFriction<br>Brake<br>InitializeFlange</td>
          <td> 由支撑引起的摩擦模型<br>
                                                基于库仑摩擦的制动器模型<br>
                                                用预先定义的位置、速度和加速度初始化法兰.</td></tr>
<tr><td colspan=\"2\"><strong>Mechanics.Translational(.Sources)</strong></td></tr>
<tr><td>Force2<br>LinearSpeedDependentForce<br>QuadraticSpeedDependentForce<br>
                                           ConstantForce<br>ConstantSpeed<br>ForceStep</td>
          <td> 作用在两个法兰上的力<br>
                                                力线性依赖于法兰速度<br>
                                                力二次依赖于法兰速度<br>
                                                恒力源<br>
                                                恒速源<br>
                                                力步</td></tr>
</table>

<p><br>
<font color=\"blue\"><strong>现有组件</strong></font>
<font color=\"blue\"><strong> </strong></font>在a
<font color=\"blue\"><strong>不向后兼容</strong></font>方式
(转换脚本转换模型和库
将旧版本转换为新版本。因此,转换
应该是自动的):
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><strong>Blocks.Continuous.</strong></td></tr>
<tr><td> CriticalDamping </td>
          <td> 新参数\"normalized\"定义是否提供过滤器
以规范化或非规范化的形式。默认值是\"normalized = true\"。
之前的实现是一个非规范化的过滤器。
转换脚本会自动引入修饰符
\"normalized=false\"。</td></tr>

<tr><td colspan=\"2\"><strong>Blocks.Interfaces.</strong></td></tr>
<tr><td> RealInput<br>
                                                RealOutput</td>
          <td> 删除了\"SignalType\"，因为它是从一个可替换的类扩展而来的
Modelica 3不允许这样做。<br>转换脚本
移除SignalType的修饰符。</td></tr>

<tr><td> RealSignal<br>
                                                IntegerSignal<br>
                                                BooleanSignal</td>
          <td> 移动到库<a href=\"https://github.com/modelica-deprecated/ObsoleteModelica3\">ObsoleteModelica3</a>，因为这些连接器
在Modelica 3中不再允许<br>
                                                (需要输入和/或输出前缀).</td></tr>

<tr><td colspan=\"2\"><strong>Blocks.Interfaces.Adaptors.</strong></td></tr>
<tr><td> AdaptorReal<br>
                                                AdaptorBoolean<br>
                                                AdaptorInteger</td>
          <td> 移动到库<a href=\"https://github.com/modelica-deprecated/ObsoleteModelica3\">ObsoleteModelica3</a>，因为模型不\"balanced\"。
这些是在Real, Boolean, Integer之间完全过时的适配器<br>
1.6和&ge版本的信号连接器;2.1 Modelica标准库。</td></tr>

<tr><td colspan=\"2\"><strong>Blocks.Math.</strong></td></tr>
<tr><td> ConvertAllUnits</td>
          <td> 移动到库<a href=\"https://github.com/modelica-deprecated/ObsoleteModelica3\">ObsoleteModelica3</a>，因为从一个可替换的类扩展
Modelica 3不允许这样做。<br>可以重写模型以使用可替换的组件。然而，有关的信息在这种情况下，转换<br>不能在图标中显示。</td></tr>

<tr><td colspan=\"2\"><strong>Blocks.Math.UnitConversions.</strong></td></tr>
<tr><td> TwoInputs<br>
                                                TwoOutputs</td>
          <td> 移动到库<a href=\"https://github.com/modelica-deprecated/ObsoleteModelica3\">ObsoleteModelica3</a>，因为模型不\"balanced\"。
新组件<br>\"InverseBlockConstraints\"
具有相同的功能，但是\"balanced\"。.</td></tr>

<tr><td colspan=\"2\"><strong>Electrical.Analog.Basic.</strong></td></tr>
<tr><td> HeatingResistor</td>
          <td> 必须连接heatPort;否则必须使用组件电阻(没有热端口)。<br>
cardinality()仅用于检查heatPort是否连接。</td></tr>

<tr><td colspan=\"2\"><strong>Electrical.Polyphase.Examples.</strong></td></tr>
<tr><td> </td>
          <td> 将示例中使用的组件的实例名更改为最新样式。</td></tr>

<tr><td colspan=\"2\"><strong>Electrical.Machines.</strong></td></tr>
<tr><td> </td>
          <td> 移动包<code>Machines.Examples.Utilities</code> to <code>Machines.Utilities</code></td></tr>
<tr><td> </td>
          <td> 移除所有非si单位;特别是在DCMachines中<br>
                                                参数NonSIunits.AngularVelocity_rpm rpmNominal被<br>
                              https://ydlunacommon-cdn.nosdn.127.net/a1cae97a858953df57e2d0b44df2f376.png                  parameter SIunits.AngularVelocity wNominal</td></tr>
<tr><td> </td>
          <td> 修改了以下组件变量和参数的名称，使其更简洁:<br>
                                                从所有同步机器中删除了后缀“DamperCage”
由于用户可以选择是否存在阻尼笼。<br><code>
                                                RotorAngle……RotorDisplacementAngle<br>
                                                J_Rotor ... Jr<br>
                                                Rr ........ Rrd (damper of synchronous machines)<br>
                                                Lrsigma ... Lrsigmad (damper of synchronous machines)<br>
                                                phi_mechanical ... phiMechanical<br>
                                                w_mechanical ..... wMechanical<br>
                                                rpm_mechanical ... rpmMechanical<br>
                                                tau_electrical ... tauElectrical<br>
                                                tau_shaft ........ tauShaft<br>
                                                TurnsRatio ....... turnsRatio    (AIMS)<br>
                                                VsNom ............ VsNominal     (AIMS)<br>
                                                Vr_Lr ............ VrLockedRotor (AIMS)<br>
                                                DamperCage ....... useDamperCage (synchronous machines)<br>
                                                V0 ............... VsOpenCicuit  (SMPM)<br>
                                                Ie0 .............. IeOpenCicuit  (SMEE)
                                                </code></td></tr>
<tr><td>Interfaces.</td>
          <td> 将尽可能多的代码从特定的机器模型移动到部分以减少冗余代码。</td></tr>
<tr><td>Interfaces.Adapter</td>
          <td> 移除以避免基数;相反，已经实现了以下解决方案:</td></tr>
<tr><td>Sensors.RotorDisplacementAngle<br>Interfaces.PartialBasicMachine</td>
          <td> <code>参数Boolean useSupport=false \"启用/禁用(=固定定子)支持\"</code><br>
                                                旋转支撑连接器只存在于 <code>useSupport = true;</code><br>
                                                否则定子内部固定。</td></tr>

<tr><td colspan=\"2\"><strong>Electrical.Machines.Examples.</strong></td></tr>
<tr><td> </td>
          <td> 将示例的名称改为更有意义的名称。<br>
                                                将示例中使用的组件的实例名更改为最新样式。</td></tr>
<tr><td>SMEE_Generator</td>
          <td> 初始化<code>smee.phiMechanical</code> 和 <code>fixed=true</code></td></tr>

<tr><td colspan=\"2\"><strong>Mechanics.MultiBody.</strong></td></tr>
<tr><td> World</td>
          <td> 将参数driveTrainMechanics3D的默认值从false更改为true。<br>
                                                3-dim。在Rotor1D, Mounting1D和BevelGear1D的效果因此采取<br>
                                                默认情况下考虑(以前只有这种情况，如果
世界。driveTrainMechanics3D被显式设置)。</td></tr>

<tr><td colspan=\"2\"><strong>Mechanics.MultiBody.Forces.</strong></td></tr>
<tr><td> FrameForce<br>
                                                FrameTorque<br>
                                                FrameForceAndTorque</td>
          <td> 模型删除，因为功能现在可以通过Force, Torque, ForceAndTorque</td></tr>
<tr><td> WorldForce<br>
                                                WorldTorque<br>
                                                WorldForceAndTorque<br>
                                                Force<br>
                                                Torque<br>
                                                ForceAndTorque</td>
          <td> 连接器frame_resolve可通过参数resolveInFrame可选地启用<br>.
                                                力和力矩，并在所有有意义的框架中进行解析通过枚举resolveInFrame。</td></tr>

<tr><td colspan=\"2\"><strong>Mechanics.MultiBody.Frames.</strong></td></tr>
<tr><td> length<br>
                                                normalize</td>
          <td> 删除了函数，因为在Modelica.Math.Vectors中也可用
                                                <br>转换脚本相应地更改引用。</td></tr>

<tr><td colspan=\"2\"><strong>Mechanics.MultiBody.Joints.</strong></td></tr>
<tr><td> Prismatic<br>
                                                ActuatedPrismatic<br>
                                                Revolute<br>
                                                ActuatedRevolute<br>
                                                Cylindrical<br>
                                                Universal<br>
                                                Planar<br>
                                                Spherical<br>
                                                FreeMotion</td>
          <td> 更改初始化，将初始值参数替换为启动/固定的属性。<br>
                                                当正确支持start/fixed属性时在参数菜单中使用Modelica工具，<br>
                                                的初始化大大简化了用户和实现要简单得多。<br>
                                                将参数\"enforceStates\"替换为更通用的内置枚举stateSelect=StateSelection.xxx。<br>
                                                自动转换脚本从\"old\"形式转换为\"new\"形式。</td></tr>
<tr><td> Revolute<br>
                                                ActuatedRevolute</td>
          <td> 的\"Advanced\"菜单中的\"planarCutJoint\"参数\"ActuatedRevolute\"删除。<br>
                                                引入了一个新的联合\"RevolutePlanarLoopConstraint\"来定义约束转动关节<br>作为平面环上的切割关节。这种改变是必要的，以便转动关节可以在高级模型检查中正确使用<br>。<br>
                                                已移除转动关节。旋转接头法兰连接件<br>可以通过参数useaxis法兰来启用。</td></tr>
<tr><td> Prismatic<br>
                                                ActuatedPrismatic</td>
          <td> 已移除ActuatedPrismatic关节。移动接头的法兰连接件<br>
                                                可以使用参数useaxis法兰.</td></tr>
<tr><td> Assemblies</td>
          <td> 装配接头的实现略有改变，使注释\"structurallyIncomplete\"<br>可以删除(所有装配接头模型现在都是“平衡的”)。</td></tr>

<tr><td colspan=\"2\"><strong>Mechanics.MultiBody.Joints.Internal</strong></td></tr>
<tr><td> RevoluteWithLengthConstraint<br>
                                                PrismaticWithLengthConstraint</td>
          <td> 这些接头不应该被MultiBody库的用户使用。
它们只是用来建立
MultiBody.Joints.Assemblies.JointXYZ关节。
这两个关节已经改变在一个稍微不向后兼容
方式，以便在程序集中使用。JointXYZ关节导致
平衡模型(<strong>没有为这个更改提供转换
用户不应该使用这些接头，转换也会
复杂的</strong>):
                                                在Modelica标准库3.0版本之前的版本中，
激活扭矩/力投影方程是可能的
(=切割扭矩/-力投射到旋转/平移
轴必须等于
通过参数<strong>axisTorqueBalance</strong>得到驱动力矩/法兰轴的力)。
这是不可能的，因为否则这个模型就不存在了
\"balanced\"(=与方程相同数量的未知数)。相反,当
在3.0及以后的版本中使用此模型，扭矩/力
投影方程必须在关节的高级菜单中提供
关节。球面和关节。UniversalSpherical
通过新的参数\"constraintResidue\"。</td></tr>

<tr><td colspan=\"2\"><strong>Mechanics.MultiBody.Parts.</strong></td></tr>
<tr><td> BodyBox<br>
                                                BodyCylinder</td>
          <td> 将参数密度单位由g/cm3改为SI单位kg/m3
以便进行更严格的单元检查。<br>转换脚本相乘
以前的密度值为1000。</td></tr>
<tr><td> Body<br>
                                                BodyShape<br>
                                                BodyBox<br>
                                                BodyCylinder<br>
                                                PointMass
                                                Rotor1D</td>
          <td> 更改初始化，将初始值参数替换为启动/固定的属性。<br>
                                                当正确支持start/fixed属性时在参数菜单中使用Modelica工具，<br>
                                                的初始化大大简化了用户和实现要简单得多。<br>自动转换脚本
将初始化的\"old\" 形式转换为\"new\"形式。</td></tr>

<tr><td colspan=\"2\"><strong>Mechanics.MultiBody.Sensors.</strong></td></tr>
<tr><td> AbsoluteSensor<br>
                                                RelativeSensor<br>
                                                CutForceAndTorque</td>
          <td> 传感器元件的新设计:通过布尔参数<br>
                                                各自矢量的信号连接器被启用/禁用。<br>
                                                将模型自动转换为这种新设计是不可能的。<br>
                                                相反，现有模型中的引用被更改为ObsoleteModelice3。<br>
                                                这意味着必须手动调整这些模型。</td></tr>
<tr><td> CutForce<br>
                                                CutTorque</td>
          <td> 稍微有点新设计。力和/或扭矩组件可以是在world、frame_a或frame_resolved中解析。<br>
                                                现有模型将自动转换。</td></tr>

<tr><td colspan=\"2\"><strong>Mechanics.Rotational.</strong></td></tr>
<tr><td> </td>
          <td> 将组件移动到结构化子包(源、组件)</td></tr>
<tr><td> Inertia<br>
                                                SpringDamper<br>
                                                RelativeStates</td>
          <td> 更改初始化，将初始值参数替换为
启动/固定的属性。<br>
                                                当正确支持start/fixed属性时
在参数菜单中使用Modelica工具，<br>
                                                的初始化大大简化了
用户和实现要简单得多。<br>
                                                替换了\"Inertia\"和\"stateSelection\"中的\"stateSelection\"参数
通过内置枚举<br>stateSelect=StateSelection.xxx。
介绍了“RelativeStates”中的“stateSelect”枚举。<br>
                                                自动转换脚本
从\"old\"形式转换为\"new\"形式。</td></tr>
<tr><td> LossyGear<br>
                                                GearBox</td>
          <td> 将传动比参数\"i\"重命名为\"ratio\"，以便有一个
一致的命名约定。<br>
                                                现有模型将自动转换。</td></tr>
<tr><td> SpringDamper<br>
                                                ElastoBacklash<br>
                                                Clutch<br>
                                                OneWayClutch</td>
          <td> 如果可能的话，使用相对数量(phi_rel, w_rel)作为状态
(由于StateSelect.prefer)。<br>
                                                在大多数情况下，传动系统中的相对状态更适合作为
绝对的州。<br>此更改可能会对所选状态进行更改
现有的模型。<br>
                                                这可能会产生问题，例如，初始化不是
在用户模型中完全定义，<br>自默认
初始化启发式可能给出不同的初始值。</td></tr>

<tr><td colspan=\"2\"><strong>Mechanics.Translational.</strong></td></tr>
<tr><td> </td>
          <td> 将组件移动到结构化子包(源、组件)</td></tr>
<tr><td> </td>
          <td> 对应于旋转的适应</td></tr>
<tr><td> Stop</td>
          <td> 重命名为Components.MassWithStopAndFriction更简洁。<br>
                                                MassWithStopAndFriction不支持连接器，<br>
                                                由于速度v的重新定义，反作用力不能以有意义的方式建模。<br>
                                                在硬停止的合理实施可行之前，可以使用旧模式。</td></tr>
<tr><td colspan=\"2\"><strong>Media.</strong></td></tr>
<tr><td> constant nX<br>
                                                constant nXi<br>
                                                constant reference_X<br>
                                                BaseProperties</td>
          <td> 包常数nX = nS，现在总是如此，即使对单种介质也是如此。这也允许定义只有一个元素的混合物。包常数nXi=如果fixedX则0否则如果reducedX或nS==1则nS - 1否则nS。这就要求所有单一物种介质的BaseProperties都有一个额外的等式来定义组合X为{1.0}(或reference_X，对于单一物种来说是{1.0})。这也意味着所有用户定义的单一物种媒介都需要根据该方程进行更新.</td></tr>

<tr><td colspan=\"2\"><strong>SIunits.</strong></td></tr>
<tr><td> CelsiusTemperature </td>
          <td> 移除，因为没有SI单位。转换脚本更改对的引用
                                                SIunits.Conversions.NonSIunits.Temperature_degC </td></tr>
<tr><td> ThermodynamicTemperature<br>
                                                TemperatureDifference</td>
          <td> 添加注释 \"absoluteValue=true/false\"
                                                为了使单元检查成为可能<br>
                                                (单元检查器需要知道对于一个有偏移的单元，
它是作为绝对数字还是作为相对数字使用)</td></tr>

<tr><td colspan=\"2\"><strong>SIunits.Conversions.NonSIunits.</strong></td></tr>
<tr><td> Temperature_degC<br>
                                                Temperature_degF<br>
                                                Temperature_degRk </td>
          <td> 添加注释 \"absoluteValue=true\"
                                                为了使单元检查成为可能<br>
                                                (单元检查器需要知道对于一个有偏移的单元，
它是作为绝对数字还是作为相对数字使用)</td></tr>

<tr><td colspan=\"2\"><strong>StateGraph.Examples.</strong></td></tr>
<tr><td> ControlledTanks </td>
          <td> ControlledTanks的连接器不符合新要求
Modelica的限制这个问题已经解决了。</td></tr>
<tr><td> Utilities </td>
          <td> 用连接器inflow1, inflow2代替流入，流出，
Outflow1, outflow2带有适当的输入/输出前缀in
以满足Modelica 3到达的限制
在平衡模型中。没有提供转换，因为
太困难了，因为非向后兼容的更改是在
一个例子。</td></tr>

<tr><td colspan=\"2\"><strong>Thermal.FluidHeatFlow.Sensors.</strong></td></tr>
<tr><td><br>
                                                pSensor<br>TSensor<br>dpSensor<br>dTSensor<br>m_flowSensor<br>V_flowSensor<br>H_flowSensor</td>
          <td> 重新命名为:<br>
                                                PressureSensor<br>TemperatureSensor<br>RelPressureSensor<br>RelTemperatureSensor<br>MassFlowSensor<br>VolumeFlowSensor<br>EnthalpyFlowSensor
                                                </td></tr>

<tr><td colspan=\"2\"><strong>Thermal.FluidHeatFlow.Sources.</strong></td></tr>
<tr><td> Ambient<br>PrescribedAmbient</td>
          <td> 可作为一个组合组件Ambient<br>
                                                布尔参数usePressureInput和useTemperatureInput决定
压力和/或温度是否恒定或规定</td></tr>
<tr><td> ConstantVolumeFlow<br>PrescribedVolumeFlow</td>
          <td> 可用作为一个组合组件VolumeFlow<br>
                                                布尔参数useVolumeFlowInput决定
体积流量是否恒定或规定</td></tr>
<tr><td> ConstantPressureIncrease<br>PrescribedPressureIncrease</td>
          <td> 可作为一个组合组件PressureIncrease<br>
                                                布尔参数usepressureincreeinput决定
压力增加是恒定的还是规定的</td></tr>

<tr><td colspan=\"2\"><strong>Thermal.FluidHeatFlow.Examples.</strong></td></tr>
<tr><td> </td>
          <td> 将示例中使用的组件的实例名更改为最新样式。</td></tr>

<tr><td colspan=\"2\"><strong>Thermal.HeatTransfer.(Components)</strong></td></tr>
<tr><td> HeatCapacitor</td>
          <td> 初始化改变:移除SteadyStateStart。而不是
T和der_T<br>(初始温度及其导数)的起始/固定值。</td></tr>

<tr><td><br><br>HeatCapacitor<br>ThermalConductor<br>ThermalConvection<br>BodyRadiation<br><br>
                                                TemperatureSensor<br>RelTemperatureSensor<br>HeatFlowSensor<br><br>
                                                FixedTemperature<br>PrescribedTemperature<br>FixedHeatFlow<br>PrescribedHeatFlow</td>
          <td> 将组件移动到子包中:<br><br>
                                                Components.HeatCapacitor<br>Components.ThermalConductor<br>Components.ThermalConvection<br>Components.BodyRadiation<br><br>
                                                Sensors.TemperatureSensor<br>Sensors.RelTemperatureSensor<br>Sensors.HeatFlowSensor<br><br>
                                                Sources.FixedTemperature<br>Sources.PrescribedTemperature<br>Sources.FixedHeatFlow<br>Sources.PrescribedHeatFlow
                                                </td></tr>

<tr><td colspan=\"2\"><strong>Thermal.FluidHeatFlow.Examples.</strong></td></tr>
<tr><td> </td>
          <td> 将示例中使用的组件的实例名更改为最新样式。</td></tr>
</table>

<p><br>
<font color=\"blue\"><strong>现有组件</strong></font>
<font color=\"blue\"><strong> </strong></font>在
<font color=\"blue\"><strong>向后兼容</strong></font>方式:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr><td> <strong>Modelica.*</strong> </td>
          <td> 参数声明，输入和输出函数参数没有描述
字符串通过提供有意义的描述文本改进了<br>。
                                                </td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Blocks.Continuous.</strong></td></tr>
<tr><td> TransferFunction </td>
          <td> 引入了控制器规范状态的内部缩放
为了扩大传递函数的范围，其中默认
模拟器的相对公差是足够的。</td>
</tr>

<tr><td> Butterworth<br>CriticalDamping </td>
          <td> 改进了文档，增加了滤波器特性图。</td></tr>

<tr><td colspan=\"2\"><strong>Electrical.Analog.Basic.</strong></td></tr>
<tr><td> EMF </td>
          <td> 新参数\"useSupport\"可选地启用支持连接器。</td></tr>

<tr><td colspan=\"2\"><strong>Icons.</strong></td></tr>
<tr><td> RectangularSensor<br>
                                                RoundSensor</td>
          <td> 从图表层中删除绘图(只保留绘图)
图标层)，<br>，以便这个图标可以在某些情况下使用
在图层中拖动组件。</td></tr>

<tr><td colspan=\"2\"><strong>Math.Vectors.</strong></td></tr>
<tr><td> normalize</td>
          <td> 实现变化，使结果始终是连续的<br>
                                                (以前，对于小向量不是这样的:normalize(eps,eps)).
                                                </td></tr>

<tr><td colspan=\"2\"><strong>Mechanics.MultiBody.</strong></td></tr>
<tr><td> </td>
          <td> 重命名非标准关键字defineBranch, defineRoot, definePotentialRoot，
isroot到标准名称:<br>
                                                Connections.branch/.root/.potentialRoot/.isRooted.</td></tr>
<tr><td> Frames </td>
          <td> 为所有单行函数添加注释\"Inline=true\"
(应该全部内联).</td></tr>
<tr><td colspan=\"2\"><strong>Mechanics.MultiBody.Parts.</strong></td></tr>
<tr><td> Mounting1D<br>
                                                Rotor1D<br>
                                                BevelGear1D</td>
          <td> 更改了实现，不再使用连接器修饰符
变量<br>，因为这违反了对的限制
Modelica 3的“平衡模型”.</td></tr>

<tr><td colspan=\"2\"><strong>Mechanics.Rotational.</strong></td></tr>
<tr><td> InitializeFlange</td>
          <td> 更改了实现，以便计数未知和
方程可以不需要参数的实际值。</td></tr>

<tr><td colspan=\"2\"><strong>Thermal.FluidHeatFlow.Interfaces.</strong></td></tr>
<tr><td>TwoPort</td>
          <td> 引入<code>参数Real tapT(final min=0, final max=1)=1</code><br>，用于定义heatPort的温度
在进口和出口之间。</td></tr>

<tr><td colspan=\"2\"><strong>StateGraph.</strong></td></tr>
<tr><td> InitialStep<br>
                                                InitialStepWithSignal<br>
                                                Step<br>
                                                StepWithSignal</td>
          <td> 更改了实现，不再使用输出修饰符
变量<br>，因为这违反了对的限制
Modelica 3的“平衡模型”。</td></tr>

</table>

<p><br>
以下<font color=\"red\"><strong>临界错误</strong></font>已被修复(即错误)
这可能导致错误的模拟结果):
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><strong>Electrical.Analog.Examples.</strong></td></tr>
<tr><td> CauerLowPassSC </td>
          <td> 修正了Capacitor1的Rn和Rp计算错误
                                                (C=clock/R 替代 C=clock*R) </td>
</tr>

<tr><td colspan=\"2\"><strong>Mechanics.MultiBody.Parts.</strong></td></tr>
<tr><td> Rotor1D </td>
          <td> 三维反作用力力矩不完全正确，最终屈服
有些情况会导致错误的结果。这个bug不应该影响
多体系统的运动，但只有约束力矩
有时不正确。</td>
</tr>

<tr><td colspan=\"2\"><strong>Mechanics.Rotational.</strong></td></tr>
<tr><td> ElastoBacklash </td>
          <td> 如果阻尼力矩过大，则反力力矩
可以“拉”，这是非物理的。这个成分是
在这种情况下，新写了限制阻尼力矩
这样“拉动”力矩就不会再发生。此外,
在初始化期间，特征是连续的
减少数值误差。相对角度和相对
如果可能的话，角速度被用作状态
(优选)，因为相对数量通常领先
为了更好的行为。  </td>
</tr>
<tr><td> Position<br>Speed<br>Accelerate<br>Move</td>
          <td> 法兰的运动被错误地定义为绝对运动;
这是相对于连接器支持进行修正的。<br>
对于Accelerate来说，必须重新命名
RealInput a到a_ref，以及起始值
Phi_start到。Start和w_start到w_start。
转换脚本执行必要的转换
现有模型自动。</td>
</tr>
<tr><td colspan=\"2\"><strong>Media.Interfaces.</strong></td></tr>
<tr><td> PartialSimpleIdealGasMedium </td>
          <td> 校正了参考温度的不一致。这可能会给
函数的不同结果:<br>
                                                specificEnthalpy, specificInternalEnergy, specificGibbsEnergy,
                                                specificHelmholtzEnergy.</td>
</tr>
<tr><td colspan=\"2\"><strong>Media.Air.</strong></td></tr>
<tr><td> specificEntropy </td>
          <td> 修正了理想气体混合物熵计算中的小错误。</td>
</tr>
<tr><td colspan=\"2\"><strong>Media.IdealGases.Common.MixtureGasNasa</strong></td></tr>
<tr><td> specificEntropy </td>
          <td> 修正了理想气体混合物熵计算中的小错误。</td>
</tr>
</table>

<p><br>
以下<font color=\"red\"><strong>uncritical errors</strong></font> 已被修复(即错误)
<font color=\"red\"><strong>not</strong></font>会导致错误的模拟结果，但是，例如:
单元错误或文档中有错误):
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><strong>Blocks.Tables.</strong></td></tr>
<tr><td> CombiTable2D</td>
          <td> Documentation improved.</td>
</tr>

<tr><td colspan=\"2\"><strong>Electrica.Digital.Gates</strong></td></tr>
<tr><td> AndGate<br>
                                                NandGate<br>
                                                OrGate<br>
                                                NorGate<br>
                                                XorGate<br>
                                                XnorGate</td>
          <td> 输入的数量没有正确传播到所包含的基本模型。<br>这给出了一个翻译错误，如果数字的输入被更改(而不是使用默认值)。</td>
</tr>

<tr><td colspan=\"2\"><strong>Electrica.Digital.Sources</strong></td></tr>
<tr><td> Pulse </td>
          <td> 模型以不同的方式实现，因此关于\"cannot properly initialize\"的警告消息消失。</td>
</tr>

<tr><td colspan=\"2\"><strong>Mechanics.Rotational.</strong></td></tr>
<tr><td> BearingFriction<br>
                                                Clutch<br>
                                                OneWayClutch<br>
                                                Brake<br>
                                                Gear </td>
          <td> D表参数的声明从表[:，:]到表[:，2]。</td>
</tr>

<tr><td colspan=\"2\"><strong>Modelica.Mechanics.MultiBody.Examples.Loops.Utilities.</strong></td></tr>
<tr><td> GasForce </td>
          <td> 单位变量\"press\"修正(从Pa到bar)</td>
</tr>

<tr><td colspan=\"2\"><strong>StateGraph.Examples.</strong></td></tr>
<tr><td>SimpleFriction</td>
          <td> 内部参数k用适当的单位定义和计算。</td></tr>

<tr><td colspan=\"2\"><strong>Thermal.FluidHeatFlow.Interfaces.</strong></td></tr>
<tr><td>SimpleFriction</td>
          <td> 内部参数k用适当的单位定义和计算。</td></tr>

</table>

</html>"            ));
      end Version_3_0;

      class Version_2_2_2 "Version 2.2.2 (Aug. 31, 2007)"
        extends Modelica.Icons.ReleaseNotes;

        annotation(Documentation(info = "<html>
<p>
版本2.2.2向后兼容版本2.2.1和2.2
以下例外情况:
</p>
<ul>
<li> 删除了Modelica.Media.Interfaces.PartialTwoPhaseMediumWithCache包
(这还没有被利用)。</li>
<li> 中媒体包的移除
类型不兼容的Modelica.Media.IdealGases.SingleGases
Modelica.Media.Interfaces.PartialMedium。部分介质，因为流体常数
缺少记录定义，
有关详情，请参阅
          <a href=\"modelica://Modelica.Media.IdealGases\">Modelica.Media.IdealGases</a>
         (this is seen as a bug fix).</li>
</ul>

<p>
2.2.2版本与之前版本的区别概述
版本2.2.1如下所示。完全不同(但没有)
文档中的差异)可在
<a href=\"modelica://Modelica/Resources/Documentation/Differences-Modelica-221-222.html\">Differences-Modelica-221-222.html</a>。
这个比较文件是用Dymola的
ModelManagement.compare函数。
</p>

<p>
在这个版本中，<strong>no</strong>添加了新的库。<strong>documentation</strong>
整个图书馆都得到了改善。
</p>

<p><br>
新增了以下<font color=\"blue\"><strong>组件</strong></font
<font color=\"blue\"><strong>现有</strong></font>库:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><strong>Blocks.Logical.</strong></td></tr>
<tr><td> TerminateSimulation</td>
          <td> 根据给定条件终止模拟。</td>
</tr>

<tr><td colspan=\"2\"><strong>Blocks.Routing.</strong></td></tr>
<tr><td> RealPassThrough<br>
                   IntegerPassThrough<br>
                   BooleanPassThrough</td>
          <td> 将信号从输入传递到输出
(由于限制，可与总线结合使用
可扩展连接器).</td>
</tr>

<tr><td colspan=\"2\"><strong>Blocks.Sources.</strong></td></tr>
<tr><td> KinematicPTP2 </td>
          <td> 直接给出q,qd,qdd作为输出(而不仅仅是qdd作为KinematicPTP)。
          </td>
</tr>

<tr><td colspan=\"2\"><strong>Electrical.Machines.Examples.</strong></td></tr>
<tr><td> TransformerTestbench </td>
          <td> 变压器Testbench
          </td></tr>
<tr><td> Rectifier6pulse </td>
          <td> 6脉冲整流器与1变压器
          </td>
</tr>
<tr><td> Rectifier12pulse </td>
          <td> 12脉冲整流器与2个变压器
          </td>
</tr>
<tr><td> AIMC_Steinmetz </td>
          <td> 感应电机鼠笼与Steinmetz连接
          </td>
</tr>

<tr><td colspan=\"2\"><strong>Electrical.Machines.BasicMachines.Components.</strong></td></tr>
<tr><td> BasicAIM </td>
          <td> 感应电机部分型号
          </td></tr>
<tr><td> BasicSM </td>
          <td> 同步电机部分型号
          </td></tr>
<tr><td> PartialAirGap </td>
          <td> 部分气隙模型
          </td></tr>
<tr><td> BasicDCMachine </td>
          <td> 部分型号为直流电机
          </td></tr>
<tr><td> PartialAirGapDC </td>
          <td> 直流电机的局部气隙模型
          </td></tr>
<tr><td> BasicTransformer </td>
          <td> 三相变压器局部模型
          </td></tr>
<tr><td> PartialCore </td>
          <td> 三绕组变压器铁心的局部模型
          </td></tr>
<tr><td> IdealCore </td>
          <td> 理想的三绕组变压器
          </td>
</tr>

<tr><td colspan=\"2\"><strong>Electrical.Machines.BasicMachines.</strong></td></tr>
<tr><td> Transformers </td>
          <td> 技术三相变压器子库
          </td>
</tr>

<tr><td colspan=\"2\"><strong>Electrical.Machines.Interfaces.</strong></td></tr>
<tr><td> Adapter </td>
          <td> 电机模型外壳适配器
          </td>
</tr>
<tr><td colspan=\"2\"><strong>Math.</strong></td></tr>
<tr><td> Vectors </td>
          <td> 新的操作向量的函数库
          </td>
</tr>
<tr><td> atan3 </td>
          <td> 四象限正切反比(选择最接近给定角y0的解)
          </td>
</tr>
<tr><td> asinh </td>
          <td> sinh(面积双曲正弦)的倒数
          </td>
</tr>
<tr><td> acosh </td>
          <td> cosh的逆(面积双曲余弦)
          </td>
</tr>

<tr><td colspan=\"2\"><strong>Math.Vectors</strong></td></tr>
<tr><td> isEqual </td>
          <td> 确定两个实向量是否在数值上相同
          </td>
</tr>
<tr><td> norm </td>
          <td> 返回向量的p范数
          </td></tr>
<tr><td> length </td>
          <td> 返回向量的长度(如果执行进一步的符号处理，不如使用norm())
          </td></tr>
<tr><td> normalize </td>
          <td> 返回归一化向量，使长度= 1，并防止零向量的零除法
          </td></tr>
<tr><td> reverse </td>
          <td> 反向向量元素(例如，v[1]成为最后一个元素)
          </td></tr>
<tr><td> sort </td>
          <td> 对vector中的元素按升序或降序排序
          </td></tr>

<tr><td colspan=\"2\"><strong>Math.Matrices</strong></td></tr>
<tr><td> solve2 </td>
          <td> 用B矩阵求解线性方程组A*X=B
(部分旋转的高斯消去)
          </td>
</tr>
<tr><td> LU_solve2 </td>
          <td> 用B矩阵求解线性方程组P*L*U*X=B
和一个LU分解(从LU(..))
          </td></tr>

<tr><td colspan=\"2\"><strong>Mechanics.Rotational.</strong></td></tr>
<tr><td> InitializeFlange </td>
          <td> 根据给定的信号初始化法兰
(如果初始化信号由信号总线提供，则有用)。
          </td>
</tr>

<tr><td colspan=\"2\"><strong>Media.Interfaces.PartialMedium.</strong></td></tr>
<tr><td> density_pTX </td>
          <td> 从p, T和X或Xi返回密度
          </td>
</tr>

<tr><td colspan=\"2\"><strong>Media.Interfaces.PartialTwoPhaseMedium.</strong></td></tr>
<tr><td> BaseProperties </td>
          <td> 两相介质的基本性质(p, d, T, h, u, R, MM, x)
          </td>
</tr>
<tr><td> molarMass </td>
          <td> 返回介质的摩尔质量
          </td>
</tr>
<tr><td> saturationPressure_sat </td>
          <td> 返回饱和压力
          </td>
</tr>
<tr><td> saturationTemperature_sat </td>
          <td> 返回饱和温度
          </td>
</tr>
<tr><td> saturationTemperature_derp_sat </td>
          <td> 饱和温度随压力的返回导数
          </td>
</tr>  <tr><td> setState_px </td>
          <td> 从压力和蒸气质量返回热力学状态
          </td>
</tr>  <tr><td> setState_Tx </td>
          <td> 从温度和蒸气质量返回热力学状态
          </td>
</tr>  <tr><td> vapourQuality </td>
          <td> 回汽质量
          </td>
</tr>

<tr><td colspan=\"2\"><strong>Media.Interfaces.</strong></td></tr>
<tr><td> PartialLinearFluid </td>
          <td> 常数cp的一般纯液体模型;压缩系数和热膨胀系数
          </td>
</tr>

<tr><td colspan=\"2\"><strong>Media.Air.MoistAir.</strong></td></tr>
<tr><td> massFraction_pTphi </td>
          <td> 从相对湿度和T中返回蒸汽质量分数
          </td>
</tr>
<tr><td> saturationTemperature </td>
          <td> 从(分)压力返回饱和温度
通过饱和压力函数的数值反演
          </td>
</tr>
<tr><td> enthalpyOfWater </td>
          <td> 返回水(固体/液体)的比焓
温度产生的大气压力
          </td>
</tr>
<tr><td> enthalpyOfWater_der </td>
          <td> 返回enthalpyOfWater()\"函数的导数
          </td>
</tr>
<tr><td> PsychrometricData </td>
          <td> 模型生成的情节数据的干湿图
          </td>
</tr>
<tr><td colspan=\"2\"><strong>Media.CompressibleLiquids.</strong><br>
          新的简单可压缩液体模型子库</td></tr>
<tr><td> LinearColdWater </td>
          <td> 具有线性可压缩性的冷水模型
          </td>
</tr>
<tr><td> LinearWater_pT_Ambient </td>
          <td> 液体，线性压缩率水模型在1.01325巴及摄氏25度
          </td>
</tr>
<tr><td colspan=\"2\"><strong>SIunits.</strong></td></tr>
<tr><td> TemperatureDifference </td>
          <td> 温差类型
          </td>
</tr>
</table>

<p><br>
<font color=\"blue\"><strong>现有组件</strong></font>
<font color=\"blue\"><strong>改进</strong></font>:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><strong>Blocks.Examples.</strong></td></tr>
<tr><td> BusUsage</td>
          <td> 例子从\"old\"改为\"new\"公交车的概念用
可扩展的连接器。</td></tr>

<tr><td colspan=\"2\"><strong>Blocks.Discrete.</strong></td></tr>
<tr><td> ZeroOrderHold</td>
          <td> 示例输出ySample从\"protected\"移到\"public\"
具有新属性(start=0, fixed=true)的部分。
          </td>
</tr>
<tr><td> TransferFunction</td>
          <td> 具有新属性的离散状态x(每个start=0，每个fixed=0)。
          </td>
</tr>

<tr><td colspan=\"2\"><strong>Electrical.</strong></td></tr>
<tr><td> Analog<br>Polyphase</td>
          <td> 改进了一些图标。
          </td>
</tr>

<tr><td colspan=\"2\"><strong>Electrical.Digital.Interfaces.</strong></td></tr>
<tr><td> MISO</td>
          <td> 从这个部分块中删除了\"algorithm\"。
          </td>
</tr>

<tr><td colspan=\"2\"><strong>Electrical.Digital.Delay.</strong></td></tr>
<tr><td> DelayParams</td>
          <td> 从这个部分块中删除了\"algorithm\"。
          </td>
</tr>

<tr><td colspan=\"2\"><strong>Electrical.Digital.Delay.</strong></td></tr>
<tr><td> DelayParams</td>
          <td> 从这个部分块中删除了\"algorithm\".
          </td>
</tr>
<tr><td> TransportDelay</td>
          <td>  如果延迟时间为零，则为无穷小的延迟
通过pre(x)引入(以前使用\"x\")。
          </td>
</tr>

<tr><td colspan=\"2\"><strong>Electrical.Digital.Sources.</strong></td></tr>
<tr><td> Clock<br>Step</td>
          <td> 将if-conditions从\"xxx < time\"改为\"time >= xxx\"
(根据Modelica规范，在第二种情况下
应该触发一个时间事件，即，此更改导致
可能是为了更快的模拟)。
          </td>
</tr>

<tr><td colspan=\"2\"><strong>Electrical.Digital.Converters.</strong></td></tr>
<tr><td> BooleanToLogic<br>
                   LogicToBoolean<br>
                   RealToLogic<br>
                   LogicToReal</td>
          <td> 从\"algorithm\"改为\"equation\"部分允许更好的符号预处理
          </td>
</tr>

<tr><td colspan=\"2\"><strong>Electrical.</strong></td></tr>
<tr><td> Machines</td>
          <td> 稍微改进了文档，有错别字文档修正
          </td>
</tr>

<tr><td colspan=\"2\"><strong>Electrical.Machines.Examples.</strong></td></tr>
<tr><td> AIMS_start</td>
          <td> 将QuadraticLoadTorque1(TorqueDirection=true)改为
QuadraticLoadTorque1(TorqueDirection=false)，因为更现实
          </td>
</tr>

<tr><td colspan=\"2\"><strong>Electrical.Machines.Interfaces.</strong></td></tr>
<tr><td> PartialBasicMachine</td>
          <td> 介绍了支承法兰的建模方法壳体的反作用力
          </td>
</tr>

<tr><td colspan=\"2\"><strong>Electrical.Machines.Sensors.</strong></td></tr>
<tr><td> Rotorangle</td>
          <td> 介绍了支承法兰的建模方法壳体的反作用力
          </td>
</tr>

<tr><td colspan=\"2\"><strong>Mechanics.MultiBody.Examples.Elementary.</strong></td></tr>
<tr><td> PointMassesWithGravity</td>
          <td> 加入两个点质量，用一条直线力连接来演示
此外，这是如何工作的。点质量的连接
，在新的实例中进行了演示
PointMassesWithGravity(有困难的方向
没有在PointMass对象中定义，因此有些
如果与…连接，需要特别处理
三维元素，其中点质量的方向不是
由这些元素决定的</td>
</tr>

<tr><td colspan=\"2\"><strong>Mechanics.MultiBody.Examples.Systems.</strong></td></tr>
<tr><td> RobotR3</td>
          <td> 从\"old\"到\"new\"总线概念，带有可扩展的连接器。
将非标准Modelica函数\"constrain()\"替换为
标准Modelica组件。因此，非标准函数
在Modelica标准库中不再使用constraint()。</td>
</tr>

<tr><td colspan=\"2\"><strong>Mechanics.MultiBody.Frames.Orientation.</strong></td></tr>
<tr><td> equalityConstraint</td>
          <td> 对equalityConstraint函数使用更好的残差。
由此，得到了一个运动学的非线性方程组
循环以一种更好的方式制定(范围)
期望的结果是非线性方程的唯一解
方程组变得更大)。</td>
</tr>

<tr><td colspan=\"2\"><strong>Mechanics.MultiBody.</strong></td></tr>
<tr><td> Visualizers.</td>
          <td> 删除(误导)注释\"structurallyIncomplete\"
在本分库的模型中
          </td>
</tr>

<tr><td colspan=\"2\"><strong>Mechanics.Rotational.</strong></td></tr>
<tr><td> 例子</td>
          <td> 对于这个子库中的所有模型:
                   <ul>
                   <li> 在所有要计算的示例中包含一个住房对象所有支持力矩。</li>
                   <li> 由修饰符通过
惯性组件初始化菜单参数。</li>
                   <li> 删除了\"encapsulated\"和不必要的\"import\".</li>
                   <li> 在注释中包含了\"StopTime\".</li>
                   </ul>
          </td>
</tr>

<tr><td colspan=\"2\"><strong>Mechanics.Rotational.Interfaces.</strong></td></tr>
<tr><td> FrictionBase</td>
          <td> 引入了\"fixed=true\"布尔变量startForward，
startBackward,模式。
          </td>
</tr>

<tr><td colspan=\"2\"><strong>Mechanics.Translational.Interfaces.</strong></td></tr>
<tr><td> FrictionBase</td>
          <td> 引入了\"fixed=true\"布尔变量startForward，
startBackward,模式。
          </td>
</tr>

<tr><td colspan=\"2\"><strong>Media.UsersGuide.MediumUsage.</strong></td></tr>
<tr><td> TwoPhase</td>
          <td> 改进了文档并演示了新引入的功能
          </td>
</tr>

<tr><td colspan=\"2\"><strong>Media.Examples.</strong></td></tr>
<tr><td> WaterIF97</td>
          <td> 提供(缺少)变量单位 V, dV, H_flow_ext, m, U.
          </td>
</tr>

<tr><td colspan=\"2\"><strong> Media.Interfaces.</strong></td></tr>
<tr><td> PartialMedium</td>
          <td> 最终修饰符从nX和nXi中删除，以允许
定制介质型号，如制冷剂与油的混合物等。
          </td>
</tr>
<tr><td> PartialCondensingGases</td>
          <td> 包括输入参数FixedPhase的属性\"min=1, max=2\"
为函数setDewState和setBubbleState，以保证
输入参数是正确的)。
          </td>
</tr>

<tr><td colspan=\"2\"><strong> Media.Interfaces.PartialMedium.</strong></td></tr>
<tr><td> BaseProperties</td>
          <td> 新的布尔参数\"standardOrderComponents\"。
如果为true，则从1-sum(Xi) (= default)计算最后一个元素向量X
否则，在PartialMedium中没有给出方程。
          </td>
</tr>
<tr><td> IsentropicExponent</td>
          <td> \"max\" value changed from 1.7 to 500000
          </td>
</tr>
<tr><td> setState_pTX<br>
                   setState_phX<br>
                   setState_psX<br>
                   setState_dTX<br>
                   specificEnthalpy_pTX<br>
                   temperature_phX<br>
                   density_phX<br>
                   temperature_psX<br>
                   density_psX<br>
                   specificEnthalpy_psX</td>
          <td> 引入了输入参数\"X\"的默认值\"reference_X\"。
          </td>
</tr>

<tr><td colspan=\"2\"><strong> Media.Interfaces.PartialSimpleMedium.</strong></td></tr>
<tr><td> setState_pTX<br>
                   setState_phX<br>
                   setState_psX<br>
                   setState_dTX</td>
          <td> 引入了输入参数\"X\"的默认值\"reference_X\".
          </td>
</tr>

<tr><td colspan=\"2\"><strong> Media.Interfaces.PartialSimpleIdealGasMedium.</strong></td></tr>
<tr><td> setState_pTX<br>
                   setState_phX<br>
                   setState_psX<br>
                   setState_dTX</td>
          <td> 引入了输入参数\"X\"的默认值\"reference_X\".
          </td>
</tr>

<tr><td colspan=\"2\"><strong> Media.Air.MoistAir.</strong></td></tr>
<tr><td> setState_pTX<br>
                   setState_phX<br>
                   setState_dTX</td>
          <td> 引入了输入参数\"X\"的默认值\"reference_X\".
          </td>
</tr>

<tr><td colspan=\"2\"><strong> Media.IdealGases.Common.SingleGasNasa.</strong></td></tr>
<tr><td> setState_pTX<br>
                   setState_phX<br>
                   setState_psX<br>
                   setState_dTX</td>
          <td> 引入了输入参数\"X\"的默认值\"reference_X\".
          </td>
</tr>

<tr><td colspan=\"2\"><strong> Media.IdealGases.Common.MixtureGasNasa.</strong></td></tr>
<tr><td> setState_pTX<br>
                   setState_phX<br>
                   setState_psX<br>
                   setState_dTX<br>
                   h_TX</td>
          <td> 引入了输入参数\"X\"的默认值\"reference_X\".
          </td>
</tr>

<tr><td colspan=\"2\"><strong> Media.Common.</strong></td></tr>
<tr><td> IF97PhaseBoundaryProperties<br>
                   gibbsToBridgmansTables </td>
          <td> 引入变量vt, vp的单位。
          </td>
</tr>
<tr><td> SaturationProperties</td>
          <td> 引入可变dpT单元。
          </td>
</tr>
<tr><td> BridgmansTables</td>
          <td> 引进单位为dfs、dgs。
          </td>
</tr>

<tr><td colspan=\"2\"><strong> Media.Common.ThermoFluidSpecial.</strong></td></tr>
<tr><td> gibbsToProps_ph<br>
                   gibbsToProps_ph<br>
                   gibbsToBoundaryProps<br>
                   gibbsToProps_dT<br>
                   gibbsToProps_pT</td>
          <td> 引入变量vt, vp的单位。
          </td></tr>
<tr><td> TwoPhaseToProps_ph</td>
          <td> 引入变量dht, dhd, detph的单位。
          </td>
</tr>

<tr><td colspan=\"2\"><strong> Media.</strong></td></tr>
<tr><td> MoistAir</td>
          <td> 湿空气模型的文件编制有明显改善。
          </td>
</tr>

<tr><td colspan=\"2\"><strong> Media.MoistAir.</strong></td></tr>
<tr><td> enthalpyOfVaporization</td>
          <td> 由线性相关取代，因为更简单，更在整个地区都是准确的。
          </td>
</tr>

<tr><td colspan=\"2\"><strong> Media.Water.IF97_Utilities.BaseIF97.Regions.</strong></td></tr>
<tr><td> drhovl_dp</td>
          <td> 引入变量dd_dp的单位。
          </td>
</tr>

<tr><td colspan=\"2\"><strong> Thermal.</strong></td></tr>
<tr><td> FluidHeatFlow</td>
          <td> 引入了新的参数tapT(0..1)来定义温度的线性组合flowPort_a (tapT=0)和flowPort_b (tapT=1)温度。
          </td>
</tr>
</table>

<p><br>
以下<font color=\"red\"><strong>critical errors</strong></font>已被修复(即错误)
这可能导致错误的模拟结果):
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><strong>Electrical.Machines.BasicMachines.Components.</strong></td></tr>
<tr><td> ElectricalExcitation</td>
          <td> 励磁电压ve计算为
                   \"spacePhasor_r.v_[1]*TurnsRatio*3/2\" 替代
                   \"spacePhasor_r.v_[1]*TurnsRatio
           </td>
</tr>

<tr><td colspan=\"2\"><strong>Mechanics.MultiBody.Parts.</strong></td></tr>
<tr><td> FixedRotation</td>
          <td> 错误纠正了扭力平衡在
以下情况(因为向量r没有变换
从frame_a到frame_b;注意这种特殊情况在实践中很少发生):
<ul><li> frame_b位于更靠近根的生成树中
(通常是frame_a)。</li>
                           <li> 从frame_a到frame_b的向量r不为零。</li>
                   </ul>
           </td>
</tr>

<tr><td> PointMass</td>
         <td> 如果一个PointMass模型被连接，那么没有方程存在
为了计算它的方向对象，方向是任意的
设置为单位旋转。在某些情况下，这可能导致错误的整体
模型，这取决于如何使用PointMass模型。出于这个原因，
这种情况现在会导致错误(通过assert(..))并给出解释
如何解决这个问题。
           </td>
</tr>

<tr><td colspan=\"2\"><strong>Media.Interfaces.PartialPureSubstance.</strong></td></tr>
<tr><td> pressure_dT<br>
                   specificEnthalpy_dT
          </td>
          <td> 将错误调用从\"setState_pTX\"更改为\"setState_dTX\"
           </td>
</tr>

<tr><td colspan=\"2\"><strong>Media.Interfaces.PartialTwoPhaseMedium.</strong></td></tr>
<tr><td> pressure_dT<br>
                   specificEnthalpy_dT
          </td>
          <td> 将错误调用从\"setState_pTX\"更改为\"setState_dTX\"
           </td>
</tr>

<tr><td colspan=\"2\"><strong>Media.Common.ThermoFluidSpecial.</strong></td></tr>
<tr><td> gibbsToProps_dT<br>
                   helmholtzToProps_ph<br>
                   helmholtzToProps_pT<br>
                   helmholtzToProps_dT</td>
          <td> 修正方程式错误 </td>
</tr>

<tr><td colspan=\"2\"><strong>Media.Common.</strong></td></tr>
<tr><td> helmholtzToBridgmansTables<br>
                   helmholtzToExtraDerivs</td>
          <td> 修正方程式错误 </td>
</tr>

<tr><td colspan=\"2\"><strong>Media.IdealGases.Common.SingleGasNasa.</strong></td></tr>
<tr><td> density_derp_T</td>
          <td> 修正了偏导数方程中的错误</td>
</tr>

<tr><td colspan=\"2\"><strong>Media.Water.IF97_Utilities.</strong></td></tr>
<tr><td> BaseIF97.Inverses.dtofps3<br>
                   isentropicExponent_props_ph<br>
                   isentropicExponent_props_pT<br>
                   isentropicExponent_props_dT</td>
          <td> 修正方程式错误 </td>
</tr>

<tr><td colspan=\"2\"><strong>Media.Air.MoistAir.</strong></td></tr>
<tr><td> h_pTX</td>
          <td> 错误在setState_phX由于错误的向量大小在h_pTX更正。此外，语法错误纠正:
                   <ul><li> 在函数massFractionpTphi中是一个方程符号在算法中使用。</li>
                           <li> 去掉两个连续的分号</li>
                   </ul>
          </td>
</tr>

<tr><td colspan=\"2\"><strong>Media.Water.</strong></td></tr>
<tr><td> waterConstants</td>
          <td> 修正了临界摩尔体积方程中的错误。
          </td>
</tr>

<tr><td colspan=\"2\"><strong>Media.Water.IF97_Utilities.BaseIF97.Regions.</strong></td></tr>
<tr><td> region_ph<br>
                   region_ps</td>
          <td> 修正了区域确定的错误。
          </td>
</tr>

<tr><td> boilingcurve_p<br>
                   dewcurve_p</td>
          <td> 修正了plim方程中的错误。
          </td>
</tr>
</table>

<p><br>
以下<font color=\"red\"><strong>不重要的错误</strong></font>已被修复(即错误)
<font color=\"red\"><strong>不是</strong></font>会导致错误的模拟结果，但是，例如:
单元错误或文档中有错误):
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><strong>Blocks.</strong></td></tr>
<tr><td> Examples</td>
          <td> 修正了公交车示例模型描述文本中的错别字。
           </td>
</tr>

<tr><td colspan=\"2\"><strong>Blocks.Continuous.</strong></td></tr>
<tr><td> LimIntegrator</td>
          <td> 删除了不正确的平滑(0，…)，因为表达式可能不连续。
           </td>
</tr>

<tr><td colspan=\"2\"><strong>Blocks.Math.UnitConversions.</strong></td></tr>
<tr><td> block_To_kWh<br>block_From_kWh</td>
          <td> 将单位从\"kWh\"修正为(语法正确)\"kW.h\".
           </td>
</tr>

<tr><td colspan=\"2\"><strong>Electrical.Analog.Examples.</strong></td></tr>
<tr><td> HeatingNPN_OrGate</td>
          <td> 包含起始值，以便初始化成功的 </td>
</tr>

<tr><td colspan=\"2\"><strong>Electrical.Analog.Lines.</strong></td></tr>
<tr><td> OLine</td>
          <td> 将单位从\"Siemens/m\"修正为\"S/m\"。
           </td></tr>
<tr><td> TLine2</td>
          <td> 更改了参数NL(规范化长度)的错误类型SIunits.Length到实。
           </td>
</tr>

<tr><td colspan=\"2\"><strong>Electrical.Digital.Delay.</strong></td></tr>
<tr><td> TransportDelay</td>
          <td> 更正语法错误
                   (\":=\" 在方程部分中，由Dymola无声地转换为 \"=\").
           </td>
</tr>

<tr><td colspan=\"2\"><strong>Electrical.Digital</strong></td></tr>
<tr><td> Converters</td>
          <td> 更正语法错误
                   (\":=\" 在方程部分中，由Dymola无声地转换为 \"=\").
           </td>
</tr>

<tr><td colspan=\"2\"><strong>Electrical.Polyphase.Basic.</strong></td></tr>
<tr><td> Conductor</td>
          <td> 从SIunits中更改了错误的参数G类型。抵抗SIunits.Conductance。
           </td>
</tr>

<tr><td colspan=\"2\"><strong>Electrical.Polyphase.Interfaces.</strong></td></tr>
<tr><td> Plug<br></td>
          <td> 制造使用的\"pin\"连接器非图形(否则，
有困难连接到插头)。
           </td>
</tr>

<tr><td colspan=\"2\"><strong>Electrical.Polyphase.Sources.</strong></td></tr>
<tr><td> SineCurrent</td>
          <td> 更改了错误的参数偏移类型。电压SIunits.Current。
           </td>
</tr>

<tr><td colspan=\"2\"><strong>Mechanics.MultiBody.Examples.Loops.</strong></td></tr>
<tr><td> EngineV6</td>
          <td> 修正了一些气缸的错误曲柄偏置并改进了这个例子。
           </td>
</tr>

<tr><td colspan=\"2\"><strong>Mechanics.MultiBody.Examples.Loops.Utilities.</strong></td></tr>
<tr><td> GasForce</td>
          <td> 错误单位更正:
                   \"SIunitsPosition x,y\" to \"Real x,y\";
           \"SIunits.Pressure press\" to \"SIunits.Conversions.NonSIunits.Pressure_bar\"
           </td>
</tr>
<tr><td> GasForce2</td>
          <td> 纠错单位: \"SIunits.Position x\" to \"Real x\".
           </td>
</tr>
<tr><td> EngineV6_analytic</td>
          <td> 修正了一些气缸的错误曲柄偏置。
           </td>
</tr>

<tr><td colspan=\"2\"><strong>Mechanics.MultiBody.Interfaces.</strong></td></tr>
<tr><td> PartialLineForce</td>
          <td> 纠正错误的单位: \"SIunits.Position eRod_a\" to \"Real eRod_a\";
           </td>
</tr>
<tr><td> FlangeWithBearingAdaptor </td>
          <td> 如果includeBearingConnector = false，则连接器\"fr\"
+ \"ame\"不是
移除。只要连接到\"frame\"的元素决定
非流动变量，这没问题。在更正版本中，\"frame\"
在本例中被有条件地删除。</td>
</tr>

<tr><td colspan=\"2\"><strong>Mechanics.MultiBody.Forces.</strong></td></tr>
<tr><td> ForceAndTorque</td>
          <td> 纠正错误的单位: \"SIunits.Force t_b_0\" to \"SIunits.Torque t_b_0\".
           </td>
</tr>
<tr><td> LineForceWithTwoMasses</td>
          <td> 纠正错误单元: \"SIunits.Position e_rel_0\" to \"Real e_rel_0\".
           </td>
</tr>

<tr><td colspan=\"2\"><strong>Mechanics.MultiBody.Frames.</strong></td></tr>
<tr><td> axisRotation</td>
          <td> 纠正错误单元: \"SIunits.Angle der_angle\" to
                        \"SIunits.AngularVelocity der_angle\".
           </td>
</tr>

<tr><td colspan=\"2\"><strong>Mechanics.MultiBody.Joints.Assemblies.</strong></td></tr>
<tr><td> JointUSP<br>JointSSP</td>
          <td> 纠正错误单元: \"SIunits.Position aux\"  to \"Real\"
           </td>
</tr>

<tr><td colspan=\"2\"><strong>Mechanics.MultiBody.Sensors.</strong></td></tr>
<tr><td> AbsoluteSensor</td>
          <td> 纠正错误单位: \"SIunits.Acceleration angles\" to
                   \"SIunits.Angle angles\" and
                   \"SIunits.Velocity w_abs_0\" to \"SIunits.AngularVelocity w_abs_0\"
           </td>
</tr>
<tr><td> RelativeSensor</td>
          <td> 纠正错误单位: \"SIunits.Acceleration angles\" to
                   \"SIunits.Angle angles\"
           </td>
</tr>
<tr><td> Distance</td>
          <td> 纠正错误单位: \"SIunits.Length L2\" to \"SIunits.Area L2\" and
                   SIunits.Length s_small2\" to \"SIunits.Area s_small2\"
           </td>
</tr>

<tr><td colspan=\"2\"><strong>Mechanics.MultiBody.Visualizers.Advanced.</strong></td></tr>
<tr><td> Shape</td>
          <td> 改变\"MultiBody.Types. Color color\"改为\"Real color[3]\"，since
\"Types. Color\"是\"Integer color[3]\"，并且已经出现了倒退
在使用\"color\" 之前的模型的兼容性问题
\"Types.Color\"。
           </td>
</tr>

<tr><td colspan=\"2\"><strong>Mechanics.Rotational.Interfaces.</strong></td></tr>
<tr><td> FrictionBase</td>
          <td> 用新变量\"unitAngularAcceleration\"和重写方程
\"unitTorque\"，以便方程在方面是正确的
对于单位(以前，变量\"s\"既可以是扭矩也可以是扭矩)
角加速度，这会导致单元不兼容)
           </td>
</tr>

<tr><td colspan=\"2\"><strong>Mechanics.Rotational.</strong></td></tr>
<tr><td> OneWayClutch<br>LossyGear</td>
          <td> 用新变量\"unitAngularAcceleration\"和重写方程
\"unitTorque\"，以便方程在方面是正确的
对于单位(以前，变量\"s\"既可以是扭矩也可以是扭矩)
角加速度，这会导致单元不兼容)
           </td>
</tr>

<tr><td colspan=\"2\"><strong>Mechanics.Translational.Interfaces.</strong></td></tr>
<tr><td> FrictionBase</td>
          <td> 用新变量\"unitAngularAcceleration\"和重写方程
\"unitTorque\"，以便方程在方面是正确的
对于单位(以前，变量\"s\"既可以是扭矩也可以是扭矩)
角加速度，这会导致单元不兼容)
           </td>
</tr>

<tr><td colspan=\"2\"><strong>Mechanics.Translational.</strong></td></tr>
<tr><td> Speed</td>
          <td> 修正单位v_ref从SIunits.Position到SIunits.Velocity
           </td>
</tr>

<tr><td colspan=\"2\"><strong>Media.Examples.Tests.Components.</strong></td></tr>
<tr><td> PartialTestModel<br>PartialTestModel2</td>
          <td> h_start的修正单位 \"SIunits.Density\" to \"SIunits.SpecificEnthalpy\"
           </td>
</tr>

<tr><td colspan=\"2\"><strong>Media.Examples.SolveOneNonlinearEquation.</strong></td></tr>
<tr><td> Inverse_sh_T
                   InverseIncompressible_sh_T<br>
                   Inverse_sh_TX</td>
          <td> 改写方程，使量纲(单位)分析正确。
           </td>
</tr>

<tr><td colspan=\"2\"><strong>Media.Incompressible.Examples.</strong></td></tr>
<tr><td> TestGlycol</td>
          <td> 改写方程，使量纲(单位)分析正确。
           </td>
</tr>

<tr><td colspan=\"2\"><strong>Media.Interfaces.PartialTwoPhaseMedium.</strong></td></tr>
<tr><td> dBubbleDensity_dPressure<br>dDewDensity_dPressure</td>
          <td> 从\"DerDensityByEnthalpy\"更改了错误的ddldp类型
\"DerDensityByPressure\"。
           </td>
</tr>

<tr><td colspan=\"2\"><strong>Media.Common.ThermoFluidSpecial.</strong></td></tr>
<tr><td> ThermoProperties</td>
          <td> 换错单位:
                   \"SIunits.DerEnergyByPressure dupT\" to \"Real dupT\" and
                   \"SIunits.DerEnergyByDensity dudT\" to \"Real dudT\"
           </td>
</tr>
<tr><td> ThermoProperties_ph</td>
          <td> 更改了错误的单位 \"SIunits.DerEnergyByPressure duph\" to \"Real duph\"
           </td>
</tr>
<tr><td> ThermoProperties_pT</td>
          <td> 更改了错误的单位 \"SIunits.DerEnergyByPressure dupT\" to \"Real dupT\"
           </td>
</tr>
<tr><td> ThermoProperties_dT</td>
          <td>  更改了错误的单位 \"SIunits.DerEnergyByDensity dudT\" to \"Real dudT\"
           </td>
</tr>

<tr><td colspan=\"2\"><strong>Media.IdealGases.Common.SingleGasNasa.</strong></td></tr>
<tr><td> cp_Tlow_der</td>
          <td> 更改了错误的单位 \"SIunits.Temperature dT\" to \"Real dT\".
           </td>
</tr>

<tr><td colspan=\"2\"><strong>Media.Water.IF97_Utilities.BaseIF97.Basic.</strong></td></tr>
<tr><td> p1_hs<br>
                   h2ab_s<br>
                   p2a_hs<br>
                   p2b_hs<br>
                   p2c_hs<br>
                   h3ab_p<br>
                   T3a_ph<br>
                   T3b_ph<br>
                   v3a_ph<br>
                   v3b_ph<br>
                   T3a_ps<br>
                   T3b_ps<br>
                   v3a_ps<br>
                   v3b_ps</td>
          <td> 更改了错误的变量单位 h/hstar, s, sstar from
                   \"SIunits.Enthalpy\" to \"SIunits.SpecificEnthalpy\",
                   \"SIunits.SpecificEntropy\", \"SIunits.SpecificEntropy
           </td>
</tr>

<tr><td colspan=\"2\"><strong>Media.Water.IF97_Utilities.BaseIF97.Transport.</strong></td></tr>
<tr><td> cond_dTp</td>
          <td> 更改错误的单位 TREL, rhoREL, lambdaREL from
                   \"SIunits.Temperature\", \"SIunit.Density\", \"SIunits.ThermalConductivity\"
                   to \"Real\".
           </td>
</tr>

<tr><td colspan=\"2\"><strong>Media.Water.IF97_Utilities.BaseIF97.Inverses.</strong></td></tr>
<tr><td> tofps5<br>tofpst5</td>
          <td> 改变了错误的职业单位 \"SIunits.SpecificEnthalpy\" to
                   \"SIunits.SpecificEntropy\".
           </td>
</tr>

<tr><td colspan=\"2\"><strong>Media.Water.IF97_Utilities.</strong></td></tr>
<tr><td> waterBaseProp_ph</td>
          <td> 改进了有效性极限的计算。
           </td>
</tr>

        <tr><td colspan=\"2\"><strong>Thermal.</strong></td></tr>
<tr><td> FluidHeatFlow<br>HeatTransfer</td>
          <td> 纠正了错误的单位\"SIunits.Temperature\"。温度差的温度
变量\"SIunits.TemperatureDifference\"。
           </td>
</tr>

</table>

</html>"            ));
      end Version_2_2_2;

      class Version_2_2_1 "Version 2.2.1 (March 24, 2006)"
        extends Modelica.Icons.ReleaseNotes;

        annotation(Documentation(info = "<html>

<p>
版本2.2.1向后兼容版本2.2。
</p>

<p>
在这个版本中，<strong>no</strong>添加了新的库。
主要改进如下:
</p>

<ul>
<li> Modelica标准库的<strong>Documentation</strong>为
大大改善:<br>
         在Dymola 6中，引入了自动添加表的新特性
对于类内容和组件接口定义(参数和
连接器)到信息层。因此，相应的(部分)
以前出现在Modelica标准库中的表已被修改
移除。Dymola 6的新特性有一个显著的优点
现在保证所有表都是最新的。<br>
         此外，通过添加适当的
描述文本参数，连接器实例，功能输入
并输出参数等，以便自动生成
表中没有空条目。还有新的子库用户指南
增加了旋转单元和旋转单元，并在顶部添加了用户指南
level (Modelica.UsersGuide)已得到改进。<br>&nbsp;</li>

<li> 初始化选项已经被添加到Modelica.Blocks.<strong>Continuous</strong>
block (NoInit, SteadyState, InitialState, InitialOutput)。如果InitialOutput
，则提供块输出作为初始条件。美国
的初始化，然后尽可能接近稳定状态。
此外，连续的。清块已明显
改进了，文档也更好了。<br>&nbsp;</li>

<li> Modelica.<strong>Media</strong>库得到了显著改进:<br>
新增函数setState_pTX, setState_phX, setState_psX, setState_dTX
已经添加到PartialMedium来计算独立的介质变量
(=介质状态)从p,T,X，或从p,h,X或从p,s,X或从
d, T, X。然后为所有有趣的媒介变量提供函数
从它的中态计算它们。所有这些函数都是
以健壮的方式实现所有媒体(除了少数例外，如果
泛型函数对于特定的介质没有意义)。</li>
</ul>

<p>
以下<strong>新组件</strong>被添加到<strong>现有的</strong>库中:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td colspan=\"2\"><strong>Modelica.Blocks.Examples.</strong></td></tr>
<tr><td> PID_Controller</td>
          <td> 的用法示例
Blocks.Continuous.LimPID块。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Blocks.Math.</strong></td></tr>
<tr><td> UnitConversions.*</td>
          <td> 提供单元转换块的新包。
UnitConversions.ConvertAllBlocks 允许选择所有
菜单中的可用转换。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.Machines.BasicMachines.SynchronousMachines.</strong></td></tr>
<tr><td> SM_ElectricalExcitedDamperCage</td>
          <td> 带阻尼笼的电励磁同步电机</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.Machines.BasicMachines.Components.</strong></td></tr>
<tr><td> ElectricalExcitation </td>
          <td> 电励磁为电励磁同步
感应的机器</td></tr>
<tr><td> DamperCage</td>
          <td> 电励磁同步用非对称阻尼笼
感应的机器。至少用户必须指定阻尼器
d轴电阻和杂散电感;如果他遗漏了
q轴的参数与d轴的值相同
假设有对称阻尼器。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.Machines.Examples.</strong></td></tr>
<tr><td> SMEE_Gen </td>
          <td> 测试例7:electricalexcitedsynchronousmmachine
作为发电机</td></tr>
<tr><td> Utilities.TerminalBox</td>
          <td> 端子箱供三相感应电机选用
要么是星星(为什么)?还是?连接</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Math.Matrices.</strong></td></tr>
<tr><td> equalityLeastSquares</td>
          <td> 求解线性等式约束下的最小二乘问题:<br>
                  min|A*x-a|^2 subject to B*x=b</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Mechanics.MultiBody.</strong></td></tr>
<tr><td> Parts.PointMass</td>
          <td> 点质量，即忽略惯性张量的物体。</td></tr>
<tr><td> Interfaces.FlangeWithBearing</td>
          <td> 连接器由1-dim组成。转动法兰及其
3-dim。轴承架。</td></tr>
<tr><td> Interfaces.FlangeWithBearingAdaptor</td>
          <td> 适配器，允许直接连接到子连接器
的FlangeWithBearing.</td></tr>
<tr><td> Types.SpecularCoefficient</td>
          <td> 定义镜面系数的新类型。</td></tr>
<tr><td> Types.ShapeExtra</td>
          <td> 新类型用于定义视觉形状对象的额外数据
为这些数据的文档设置一个中心位置。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Mechanics.MultiBody.Examples.Elementary</strong></td></tr>
<tr><td> PointGravityWithPointMasses</td>
          <td> 中心重力场中两点质量的例子.</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Mechanics.Rotational.</strong></td></tr>
<tr><td>UsersGuide</td>
          <td> 已根据前面的文档添加了用户指南
在旋转的包文档中存在。</td></tr>
<tr><td>Sensors.PowerSensor</td>
          <td> 测量两个连接器之间能量流的新组件
旋转库。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Mechanics.Translational.</strong></td></tr>
<tr><td>Speed</td>
          <td> 移动平移法兰的新部件
根据参考速度</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Media.Interfaces.PartialMedium.</strong></td></tr>
<tr><td>specificEnthalpy_pTX</td>
          <td> 新的函数可以计算压强和温度下的比焓
还有质量分数。</td></tr>
<tr><td>temperature_phX</td>
          <td> 用压强，比焓计算温度的新函数，
还有质量分数。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Icons.</strong></td></tr>
<tr><td> SignalBus</td>
          <td> 信号总线图标</td></tr>
<tr><td> SignalSubBus</td>
          <td> 信号子总线图标</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.SIunits.</strong></td></tr>
<tr><td>UsersGuide</td>
          <td> 增加了一个用户指南，描述了单元处理.</td></tr>
<tr><td> Resistance<br>
                   Conductance</td>
          <td> 从这些类型中删除属性'min=0'。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Thermal.FluidHeatFlow.</strong></td></tr>
<tr><td> Components.Valve</td>
          <td> 简单控制阀，线性或
指数的特点。</td></tr>
<tr><td> Sources. IdealPump </td>
          <td> 简单理想的泵(泵)。风机)取决于轴的转速;
压力增量与体积流量的关系定义为线性关系
函数。 Torque * Speed = Pressure increase * Volume flow
                   (without losses).</td></tr>
<tr><td> Examples.PumpAndValve </td>
          <td> 阀门测试样例.</td></tr>
<tr><td> Examples.PumpDropOut </td>
          <td> 退出1泵测试半线性的行为.</td></tr>
<tr><td> Examples.ParallelPumpDropOut </td>
          <td> 退出2并联泵测试半线性的行为。</td></tr>
<tr><td> Examples.OneMass </td>
          <td> 冷却1个热质量来测试半线性的行为.</td></tr>
<tr><td> Examples.TwoMass </td>
          <td> 冷却2个热质量来测试半线性的行为.</td></tr>
</table>

<p>
以下<strong>组件</strong>得到了改进:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td colspan=\"2\"><strong>Modelica.</strong></td></tr>
<tr><td> UsersGuide</td>
          <td> 改进了Modelica标准库的用户指南和包描述.</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Blocks.Interfaces.</strong></td></tr>
<tr><td> RealInput<br>
                   BooleanInput<br>
                   IntegerInput</td>
          <td> 拖动其中一个连接器时，将显示宽度和高度
是标准图标的2倍。在此之前,
这些连接器被拖拽，然后手动放大
在Modelica标准库中是原来的2倍。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Blocks.</strong></td></tr>
<tr><td> Continuous.*</td>
          <td> 初始化选项添加到所有块中
(NoInit, SteadyState, InitialState, InitialOutput)
新参数limitsAtInit用于关闭限制
在初始化期间的阈值整合器或LimPID</td></tr>
<tr><td> Continuous.LimPID</td>
          <td> 可选择P, PI, PD, PID控制器。
文档显著改进.</td></tr>
<tr><td> Nonlinear.Limiter<br>
                   Nonlinear.VariableLimiter<br>
                   Nonlinear.Deadzone</td>
          <td> 新参数limitsAtInit/deadZoneAtInit关闭限制
或者初始化时的死区</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Analog. </strong></td></tr>
<tr><td> Sources</td>
          <td> 图标改进(+/-添加到电压源，箭头添加到
电流源).</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Analog.Semiconductors. </strong></td></tr>
<tr><td> Diode</td>
          <td> 包括Smooth()运算符以改进数值.</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Machines.BasicMachines.SynchronousMachines. </strong></td></tr>
<tr><td> SM_PermanentMagnetDamperCage<br>
                   SM_ElectricalExcitedDamperCage<br>
                   SM_ReluctanceRotorDamperCage</td>
          <td> 用户可以选择\"DamperCage = false\" (默认为true)。
从模型中删除阻尼笼的所有方程.</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.Machines.BasicMachines.InductionMachines. </strong></td></tr>
<tr><td> IM_SlipRing</td>
          <td> 更容易参数化:如果用户选择 \"useTurnsRatio = false\"
                   (默认值:true，这与之前的行为相同),
                        参数TurnsRatio是从内部计算的
定子电压和锁定转子电压.</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Math.Matrices.</strong></td></tr>
<tr><td>leastSquares</td>
          <td>最小二乘问题中的A矩阵可能是缺秩的。
之前要求A是满级的。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Mechanics.MultiBody.</strong></td></tr>
<tr><td>所有的模型</td>
          <td> <ul>
                   <li> 所有具有动画信息的组件都有一个新变量
<strong>镜面系数</strong>定义环境光的反射。
默认值是world.defaultSpecularCoefficient
默认值为0.7。通过更改world.defaultSpecularCoefficient
所有组件的镜面系数都被改变
显式设置不同。因为镜面系数是一个变量
(并且没有参数)，它可以在模拟期间更改。自
注释(Dialog)中，该变量仍然出现在
参数菜单。<br>
                                以前，使用恒定的镜面系数0.7
对于所有组件。</li>
                   <li> 所有组件的变量<strong>color</strong>不再是参数
而是一个输入变量。同样，包<strong>Visualizers</strong>中的所有参数，
除<strong>外，shapeType</strong>不再是参数，而是
定义为带有注释的输入变量(对话框)。因此，
所有这些变量仍然出现在参数菜单中，但它们可以
在模拟过程中进行更改(例如，颜色可能用于
显示部件的温度)。</li>
                   <li> 所有菜单都已更改，以遵循Modelica 2.2注释
“对话框，组，选项卡，启用”(以前，一个非标准的Dymola
使用了菜单定义)。还有，“enable”注释
在所有菜单中使用
如果要忽略输入，则禁用输入字段。</li>
                   <li> 现在所有可视形状都是用条件声明定义的
(如果动画关闭，则删除它们)。在此之前,
这些(受保护的)对象是由数组定义的
维度0或1。</li>
                   </ul></td></tr>

<tr><td>Frames.resolveRelative</td>
          <td> 这个函数的导数作为函数相加并定义为
一个注释。在某些情况下，工具以前
难以自动区分内联函数。</td></tr>

<tr><td>Forces.*</td>
          <td> 缩放因子N_to_m和Nm_to_m不再是默认值
值为1000，但默认值为world.defaultN_to_m (=1000)
和world.defaultNm_to_m(=1000)。这允许更改
世界上所有力和力矩的比例因子
对象。</td></tr>
<tr><td>Interfaces.Frame.a<br>
                  Interfaces.Frame.b<br>
                  Interfaces.Frame_resolve</td>
          <td> Frame连接器现在围绕原点居中，以减轻压力
使用。形状被改变了，因此图标是一个因素
大1.6的标准图标(以前，图标有一个
拖拽时的标准尺寸，然后手动放大图标
在MultiBody库中，在y方向上增加1.5倍;
16的高度允许在标准网格尺寸2)上轻松定位。
修改图标和图表图层边框的双线宽度
到单线宽度，并在进行连接时连接
线条是深灰色，不再是黑色，看起来更好。</td></tr>
<tr><td>Joints.Assemblies.*</td>
          <td> 当拖动装配接头时，图标是2的因数
比标准图标大。图标文本和连接器有
这个放大图标的标准尺寸(和不是2的因数)
和以前一样大)。</td></tr>
<tr><td>Types.*</td>
          <td> 所有类型现在都有一个相应的图标来可视化内容
在包浏览器中(以前，类型没有图标).</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Mechanics.Rotational.</strong></td></tr>
<tr><td> Inertia</td>
          <td> 添加了初始化和状态选择。</td></tr>
<tr><td> SpringDamper</td>
          <td> 添加了初始化和状态选择。</td></tr>
<tr><td> Move</td>
          <td> 完全基于Modelica 2.2语言的新实现
(以前，使用了Dymola特定的约束(…)函数).</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Mechanics.Translational.</strong></td></tr>
<tr><td> Move</td>
          <td> 完全基于Modelica 2.2语言的新实现
(以前，使用了Dymola特定的约束(…)函数)。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Thermal.FluidHeatFlow.Interfaces.</strong></td></tr>
<tr><td> SimpleFriction</td>
          <td> 计算从压降和体积流动的摩擦损失。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Thermal.FluidHeatFlow.Components.</strong></td></tr>
<tr><td> IsolatedPipe<br>
                   HeatedPipe</td>
          <td> 增加大地高度作为压力变化的来源;
进料摩擦损失按简单摩擦量计算
介质的能量平衡。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Media.Interfaces.PartialMedium.FluidConstants.</strong></td></tr>
<tr><td>HCRIT0</td><td>基本物质的临界比焓
方程(流体介质模型的基本公式)。</td></tr>
<tr><td>SCRIT0</td><td>基本物质的临界比熵
方程(流体介质模型基本公式).</td></tr>
<tr><td>deltah</td><td>之间的焓偏移量(默认为0)
流体模型的比焓和用户可见
模型中的比焓: deltah = h_model - h_fundamentalEquation.
</td></tr>
<tr><td>deltas</td><td>之间的熵偏移量(默认为0)
流体模型的比熵和用户可见
模型中的比熵: deltas = s_model - s_fundamentalEquation.</td></tr>
<tr><td>T_default</td><td>介质温度的默认值(用于初始化)</td></tr>
<tr><td>h_default</td><td>介质特定焓的默认值(用于初始化)</td></tr>
<tr><td>p_default</td><td>介质压力的默认值(用于初始化)</td></tr>
<tr><td>X_default</td><td>介质质量分数的默认值(用于初始化)</td></tr>
</table>
<p>
以下<strong>错误</strong>已被修复:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td colspan=\"2\"><strong>Modelica.Blocks.Tables.</strong></td></tr>
<tr><td>CombiTable1D<br>
                  CombiTable1Ds<br>
                  CombiTable2D</td>
          <td> 参数“tableOnFile”现在决定是否从表中读取
文件或从参数\"table\"使用。先前，if \"fileName\"不是
\" name \"，总是从文件\"fileName\"独立读取表
“tableOnFile”的设置。这已被更正。<br>
此外，表的初始化现在在
when-子句不再在参数声明中，因为有些
工具在某些情况下对参数声明进行评估
一次，然后不必要地读取表几次
(并且占用更多内存)。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Blocks.Sources.</strong></td></tr>
<tr><td>CombiTimeTable</td>
          <td> 与Modelica.Blocks.Tables中的表相同的错误修复/改进
如上所述。</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Analog.Semiconductors. </strong></td></tr>
<tr><td> PMOS<br>
                   NMOS<br>
                   HeatingPMOS<br>
                   HeatingNMOS</td>
          <td> 漏源电阻RDS的电阻实际上是
RDS/v，其中v=Beta*(W+dW)/(L+dL)。正确的公式是没有
除以v的除法。这已经被纠正了。<br>
在大多数应用程序中，这个错误修复应该不会产生根本性的影响。
在默认情况下(Beta=1e-5)，漏源电阻为
因子1e5太大，在默认情况下
错误的值1e12，虽然它应该有值1e7。的影响
这种抵抗实际上没有任何效果。</td></tr>

<tr><td colspan=\"2\"> <strong>Modelica.Media.IdealGases.Common.SingleGasNasa.</strong></td></tr>
<tr><td> dynamicViscosityLowPressure</td>
          <td> 粘度和导热系数(需要粘度作为输入)
对极性气体和气体混合物的计算有误吗
(即偶极矩不为0.0)。这个问题已在2.2.1版中修复。</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Utilities.Streams.</strong></td></tr>
<tr><td>readLine</td>
          <td> 根据c实现，流没有正确关闭。
这已通过添加\"Streams.close(..)\"得到纠正。
读取文件内容后。</td></tr>

</table>
</html>"            ));
      end Version_2_2_1;

      class Version_2_2 "Version 2.2 (April 6, 2005)"
        extends Modelica.Icons.ReleaseNotes;

        annotation(Documentation(info = "<html>

<p>
版本2.2向后兼容版本2.1。</p>

<p>
新增了以下<strong>类库</strong>:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><a href=\"modelica://Modelica.Media\">Modelica.Media</a></td>
          <td> 特别是液体和气体的性质模型
                   <ul>
                   <li>1241个详细的气体模型,</li>
                   <li> 潮湿的空气,</li>
                   <li> 高精度水模型(按IAPWS/IF97标准),</li>
                   <li> 不可压缩介质由表定义(cp(T)， rho(T)， eta(T)等由表定义)。</li>
                   </ul>
                   用户可以方便地定义气体之间的混合物
1241气体模型。这些模型是
设计在动态模拟中工作良好。他们
是基于一个新的标准接口的媒体吗
单一或多种物质，一个或多个相
具有以下特点:
                   <ul>
                   <li> 介质模型的自变量不影响
流体连接器端口的定义或如何
必须实现平衡方程。<br>
使用的自变量: \"p,T\", \"p,T,X\", \"p,h\", \"d,T\".</li>
                   <li> 可选变量，例如，动态粘度，只计算
如果需要的话。</li>
                   <li> 在效率方面实现了中等模型
动态仿真。</li>
                   </ul>
          </td></tr>
<tr><td><a href=\"modelica://Modelica.Thermal.FluidHeatFlow\">Modelica.Thermal.FluidHeatFlow</a></td>
          <td> 简单组件为1-dim。，不可压缩热流体流动
模拟冷却剂流动，如电机的流动。
组件可以任意连接在一起(=理想的混合)
在连接点处)和流体可能会反向流动。
</td></tr>
</table>
<p>
中执行了以下<strong>更改</strong>
<strong>Modelica.Mechanics.MultiBody</strong> 库:
</p>
<ul>
<li> 组件多体。世界有了一个新的参数
<strong>driveTrainMechanics3D</strong>。如果设置为<strong>true</strong>，则3D机械效果
MultiBody.Parts。考虑了Mounting1D/Rotor1D/BevelGear1D。如果设置为
<strong>false</strong> (= default)，这些元素中的3D机械效果
都不被考虑在内吗
连接3D部件的框架连接器被禁用(全部禁用)
连接到这样一个被禁用的连接器也被禁用，由于
Modelica语言中条件声明的新特性2.2)</li>
<li> 所有引用都指向\"MultiBody.xxx\"
已更改为\"Modelica.Mechanics.MultiBodys.xxx\"的顺序，之后
在Modelica库之外复制组件，即引用
仍然有效。</li>
</ul>
</html>"            ));
      end Version_2_2;

      class Version_2_1 "Version 2.1 (Nov. 11, 2004)"
        extends Modelica.Icons.ReleaseNotes;

         annotation (Documentation(info="<html>

<p> 这是与之前版本的Modelica标准库相比的一个重大变化，因为<strong>包含了许多新库</strong>和组件，并且输入/输出块（Modelica.Blocks）已大大简化：</p>
<ul>
<li> 定义了一个没有层次结构的输入/输出连接器（这是由于Modelica语言的新特性）。例如，块 \"FirstOrder\" 的输入信号以前是通过 \"FirstOrder.inPort.signal[1]\" 访问的。现在通过 \"FirstOrder.u\" 来访问。这简化了特别是对初学者的理解和使用。</li>
<li> 对<strong>Modelica.Blocks</strong> 库进行了去向量化。现在Modelica.Blocks库中的所有块都是标量块。因此，块的参数现在是标量，不再是向量。例如，一个名为 \"amplitude\" 的参数，之前的值可能是 \"{1}\"，现在的值为 \"1\"。这简化了特别是对初学者的理解和使用。<br>
         如果需要一个块的向量，可以通过给实例添加一个维度轻松实现。例如，\"Constant const[3](k={1,2,3})\" 定义了三个 Constant 块。新方法的另一个优点是，Modelica.Blocks 的实现更加简化，易于理解。</li>
</ul>

<p>
讨论过的Modelica.Blocks的变化不向后兼容。提供了一个脚本，可以<strong>自动</strong>将模型转换为新版本。在少数情况下，这个脚本可能无法转换。在这种情况下，需要手动转换模型。在执行自动转换之前，您应该先备份模型。</p>
<p>
已添加以下 <strong>新库</strong>：</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><a href=\"modelica://Modelica.Electrical.Digital\">Modelica.Electrical.Digital</a></td>
          <td>基于 2、3、4 和 9 值逻辑的数字电气组件<br>
                  按照 VHDL 标准</td></tr>
<tr><td><a href=\"modelica://Modelica.Electrical.Machines\">Modelica.Electrical.Machines</a></td>
          <td>异步、同步和直流电动机及发电机模型</td></tr>
<tr><td><a href=\"modelica://Modelica.Math.Matrices\">Modelica.Math.Matrices</a></td>
          <td>操作矩阵的函数，如 solve() (A*x=b)、leastSquares()、<br>
                  norm()、LU()、QR()、特征值、奇异值、exp() 等</td></tr>
<tr><td><a href=\"modelica://Modelica.StateGraph\">Modelica.StateGraph</a></td>
          <td>使用<br>
                   <strong>分层状态机</strong> 和 <strong>Modelica</strong> 作为 <strong>动作语言</strong> 方便地建模 <strong>离散事件</strong> 和 <strong>反应性</strong> 系统。<br>
                   它基于 JGrafchart 和 Grafcet，具有与 StateCharts 相似的建模能力。它避免了通常使用的动作语言的缺陷。<br>
                   此库使得 ModelicaAdditions.PetriNets 库变得过时。</td></tr>
<tr><td><a href=\"modelica://Modelica.Utilities.Files\">Modelica.Utilities.Files</a></td>
          <td>用于操作文件和目录的函数（复制、移动、删除文件等）</td></tr>
<tr><td><a href=\"modelica://Modelica.Utilities.Streams\">Modelica.Utilities.Streams</a></td>
          <td>从文件读取并写入文件（print、readLine、readFile、error 等）</td></tr>
<tr><td><a href=\"modelica://Modelica.Utilities.Strings\">Modelica.Utilities.Strings</a></td>
          <td>字符串操作（子串、查找、替换、排序、扫描标记等）</td></tr>
<tr><td><a href=\"modelica://Modelica.Utilities.System\">Modelica.Utilities.System</a></td>
          <td>获取/设置当前目录，获取/设置环境变量，执行 shell 命令等</td></tr>
</table>
<p>
以下是现有库的改进，并已作为 <strong>新库</strong> 添加。
（使用之前库的模型会自动转换为新子库）</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><a href=\"modelica://Modelica.Blocks.Discrete\">Modelica.Blocks.Discrete</a></td>
          <td>具有固定采样周期的离散输入/输出块<br>
                   （来自 ModelicaAdditions.Blocks.Discrete）</td></tr>
<tr><td><a href=\"modelica://Modelica.Blocks.Logical\">Modelica.Blocks.Logical</a></td>
          <td>具有布尔输入和输出信号的逻辑组件<br>
                   （来自 ModelicaAdditions.Blocks.Logical）</td></tr>
<tr><td><a href=\"modelica://Modelica.Blocks.Nonlinear\">Modelica.Blocks.Nonlinear</a></td>
          <td>具有间断或不可微分代数控制块，如变量限制器、<br>
                   固定、变量和帕德延迟等。（来自 ModelicaAdditions.Blocks.Nonlinear）</td></tr>
<tr><td><a href=\"modelica://Modelica.Blocks.Routing\">Modelica.Blocks.Routing</a></td>
          <td>用于组合和提取信号的块，如多路复用器<br>
                   （来自 ModelicaAdditions.Blocks.Multiplexer）</td></tr>
<tr><td><a href=\"modelica://Modelica.Blocks.Tables\">Modelica.Blocks.Tables</a></td>
          <td>一维和二维表格插值。CombiTimeTable 在 Modelica.Blocks.Sources 中可用<br>
                   （来自 ModelicaAdditions.Tables）</td></tr>
<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody\">Modelica.Mechanics.MultiBody</a></td>
          <td>用于建模三维机械系统运动的组件。包含
                   体、关节、力和传感器组件，运动学环路的解析处理，
                   具有质量的力元件，3D 力元件的串联/并联连接等。
                   （来自 MultiBody 1.0，其中使用了新的信号连接器；
                   使 ModelicaAdditions.MultiBody 库过时）</td></tr>
</table>
<p>
因此，ModelicaAdditions库已经过时，因为所有组件要么已包含在Modelica库中，要么被更强大的库（MultiBody、StateGraph）替代。
</p>
<p>
以下是已添加到<strong>现有</strong>库中的<strong>新组件</strong>。
</p>


<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td colspan=\"2\"><strong>Modelica.Blocks.Logical.</strong></td></tr>
<tr><td>Pre</td>
          <td>y = pre(u): 通过一个极小的时间延迟打破代数循环（事件迭代将继续，直到 u = pre(u)）</td></tr>
<tr><td>Edge</td>
          <td>y = edge(u): 如果输入 u 有上升沿，则输出 y 为真</td></tr>
<tr><td>FallingEdge</td>
          <td>y = edge(not u): 如果输入 u 有下降沿，则输出 y 为真</td></tr>
<tr><td>Change</td>
          <td>y = change(u): 如果输入 u 有上升沿或下降沿，则输出 y 为真</td></tr>
<tr><td>GreaterEqual</td>
          <td>如果输入 u1 大于或等于输入 u2，则输出 y 为真</td></tr>
<tr><td>Less</td>
          <td>如果输入 u1 小于输入 u2，则输出 y 为真</td></tr>
<tr><td>LessEqual</td>
          <td>如果输入 u1 小于或等于输入 u2，则输出 y 为真</td></tr>
<tr><td>Timer</td>
          <td>定时器，从布尔输入变为真的时间开始计时</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Blocks.Math.</strong></td></tr>
<tr><td>BooleanToReal</td>
          <td>将布尔信号转换为实数信号</td></tr>
<tr><td>BooleanToInteger</td>
          <td>将布尔信号转换为整数信号</td></tr>
<tr><td>RealToBoolean</td>
          <td>将实数信号转换为布尔信号</td></tr>
<tr><td>IntegerToBoolean</td>
          <td>将整数信号转换为布尔信号</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Blocks.Sources.</strong></td></tr>
<tr><td>RealExpression</td>
          <td>将输出信号设置为一个随时间变化的实数表达式</td></tr>
<tr><td>IntegerExpression</td>
          <td>将输出信号设置为一个随时间变化的整数表达式</td></tr>
<tr><td>BooleanExpression</td>
          <td>将输出信号设置为一个随时间变化的布尔表达式</td></tr>
<tr><td>BooleanTable</td>
          <td>基于时间瞬间的向量生成一个布尔输出信号</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Mechanics.MultiBody.</strong></td></tr>
<tr><td>Frames.from_T2</td>
          <td>从变换矩阵T和其导数der(T)返回方向对象R</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Mechanics.Rotational.</strong></td></tr>
<tr><td>LinearSpeedDependentTorque</td>
          <td>扭矩与速度的线性依赖关系（作为负载扭矩作用）</td></tr>
<tr><td>QuadraticSpeedDependentTorque</td>
          <td>扭矩与速度的二次依赖关系（作为负载扭矩作用）</td></tr>
<tr><td>ConstantTorque</td>
          <td>常数扭矩，不依赖于速度（作为负载扭矩作用）</td></tr>
<tr><td>ConstantSpeed</td>
          <td>常数速度，不依赖于扭矩（作为负载扭矩作用）</td></tr>
<tr><td>TorqueStep</td>
          <td>常数扭矩，不依赖于速度（作为负载扭矩作用）</td></tr>
</table>
<p>
以下<strong>已修复的错误</strong>：
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td colspan=\"2\"><strong>Modelica.Mechanics.MultiBody.Forces.</strong></td></tr>
<tr><td>LineForceWithMass<br>
                  Spring</td>
          <td>如果线性力或弹簧组件的质量不为零，质量被（隐式地）处理为“质量*质量”，而不是作为“质量”处理</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Mechanics.Rotational.</strong></td></tr>
<tr><td>Speed</td>
          <td>如果参数 exact=<strong>false</strong>，则滤波器错误（位置被滤波，而不是速度输入信号）</td></tr>
</table>
<p>
其他更改：
</p>
<ul>
<li>现在所有连接器在图层中更小。这使得在图示中使用连接器和组件时布局更美观</li>
<li>为所有连接器定义了默认实例名称，根据Modelica 2.1中引入的新注释。例如，当从旋转库将连接器\"Flange_a\"拖动到图层时，默认的连接器实例名称为\"flange_a\"，而不是\"Flange_a1\"。</li>
<li>Modelica.Mechanics.Rotational连接器的形状从方形更改为圆形</li>
<li>Modelica.Mechanics.Translational连接器的颜色从绿色更改为深绿色，以便更好地看到连接线，特别是在打印时。</li>
<li>Modelica.Blocks连接器的实数信号的颜色从蓝色更改为深蓝色，以便与电气信号区分开来。</li>
</ul>
</html>"                ));
      end Version_2_1;

      class Version_1_6 "Version 1.6 (June 21, 2004)"
        extends Modelica.Icons.ReleaseNotes;

        annotation(Documentation(info = "<html>

<p> 增加了1个新的库(Electrical.Polyphase)， 17个新的组件，
改进了3个现有组件
在Modelica。电库和改进型3种
在Modelica。SIunits图书馆。此外,
已启动本用户指南。的改进
更详细地说:
</p>
<p>
<strong>新组件</strong>
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td colspan=\"2\"><strong>Modelica.Electrical.Analog.Basic.</strong></td></tr>
<tr><td>SaturatingInductor</td>
          <td>饱和电感器的简单模型</td></tr>
<tr><td>VariableResistor</td>
          <td>可变电阻的理想线性电阻器</td></tr>
<tr><td>VariableConductor</td>
          <td>可变电导的理想线性电导体</td></tr>
<tr><td>VariableCapacitor</td>
          <td>理想的可变电容线性电容器</td></tr>
<tr><td>VariableInductor</td>
          <td>理想的可变电感线性电感器</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.Analog.Semiconductors.</strong></td></tr>
<tr><td>HeatingDiode</td>
          <td>Simple diode with heating port</td></tr>
<tr><td>HeatingNMOS</td>
          <td>简单的MOS晶体管与加热端口</td></tr>
<tr><td>HeatingPMOS</td>
          <td>带加热端口的简单PMOS晶体管</td></tr>
<tr><td>HeatingNPN</td>
          <td>简单的NPN BJT根据Ebers-Moll加热端口</td></tr>
<tr><td>HeatingPNP</td>
          <td>简单的PNP BJT根据Ebers-Moll加热端口</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.Polyphase</strong><br>
          多相电路的新库</td></tr>
</table>
<p>
<strong>新的例子</strong>
</p>
<p>
以下新示例已添加到
Modelica.Electrical.Analog.Examples:
</p>
<p>
CharacteristicThyristors,
CharacteristicIdealDiodes,
HeatingNPN_OrGate,
HeatingMOSInverter,
HeatingRectifier,
Rectifier,
ShowSaturatingInductor
ShowVariableResistor
</p>
<p>
<strong>改进现有组件</strong>
</p>
<p>在库Modelica.Electrical.Analog.Ideal，
为组件引入了膝电压
理想晶闸管，理想晶闸管，理想二极管依次排列
这些理想元素的近似得到了改进
不需要太多的计算。</p>
<p> 在Modelica.SIunits库，进行了以下更改
已制作:</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td>Inductance</td>
          <td>min=0 removed</td></tr>
<tr><td>SelfInductance</td>
          <td>min=0 added</td></tr>
<tr><td>ThermodynamicTemperature</td>
          <td>min=0 added</td></tr>
</table>
</html>"                  ));
      end Version_1_6;

      class Version_1_5 "Version 1.5 (Dec. 16, 2002)"
        extends Modelica.Icons.ReleaseNotes;

        annotation(Documentation(info = "<html>

<p> 增加了55个新组件。特别增加了新的包
<strong>Thermal.HeatTransfer</strong>
传热，在力学中增加模型<strong>LossyGear</strong>。旋转
对齿轮效率和轴承摩擦进行了新的建模
在电气学中增加了10个新模型。模拟和
增加了其他几个新模型并改进了现有模型。
</p>
<p>
<strong>新组件</strong>
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td colspan=\"2\"><strong>Modelica.Blocks.</strong></td></tr>
<tr><td>Continuous.Der</td><td>输入的导数(=解析微分)</td></tr>
<tr><td><strong><em>Examples</em></strong></td><td>这个包的组件的演示示例</td></tr>
<tr><td>Nonlinear.VariableLimiter</td><td>用可变极限限制信号的范围</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Blocks.Interfaces.</strong></td></tr>
<tr><td>RealPort</td><td>实端口(输入/输出都可能)</td></tr>
<tr><td>IntegerPort</td><td>整数端口(可以同时输入/输出)</td></tr>
<tr><td>BooleanPort</td><td>布尔端口(输入/输出都可能)</td></tr>
<tr><td>SIMO</td><td>单输入多输出连续控制块</td></tr>
<tr><td>IntegerBlockIcon</td><td>整数块的基本图形布局</td></tr>
<tr><td>IntegerMO</td><td>多整数输出连续控制块</td></tr>
<tr><td>IntegerSignalSource</td><td>连续整数信号源的基类</td></tr>
<tr><td>IntegerMIBooleanMOs</td><td>多个整数输入多个布尔输出具有相同输入和输出数量的连续控制块</td></tr>
<tr><td>BooleanMIMOs</td><td>多输入多输出连续控制块，具有相同数量的布尔型输入和输出</td></tr>
<tr><td><strong><em>BusAdaptors</em></strong></td><td>组件向总线发送信号或从总线接收信号</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Blocks.Math.</strong></td></tr>
<tr><td>RealToInteger</td><td>将实数信号转换为整数信号</td></tr>
<tr><td>IntegerToReal</td><td>将整数转换为实信号</td></tr>
<tr><td>Max</td><td>通过最大的信号</td></tr>
<tr><td>Min</td><td>通过最小的信号</td></tr>
<tr><td>Edge</td><td>表示布尔信号的上升沿</td></tr>
<tr><td>BooleanChange</td><td>指示布尔信号变化</td></tr>
<tr><td>IntegerChange</td><td>指示整数信号变化</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Blocks.Sources.</strong></td></tr>
<tr><td>IntegerConstant</td><td>生成Integer类型的常量信号</td></tr>
<tr><td>IntegerStep</td><td>生成整数类型的步进信号</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.Analog.Basic.</strong></td></tr>
<tr><td>HeatingResistor</td><td>温度相关电阻器</td></tr>
<tr><td>OpAmp</td><td>具有局限性的简单运放非理想模型</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Electrical.Analog.Ideal.</strong></td></tr>
<tr><td>IdealCommutingSwitch</td><td>理想的通勤开关</td></tr>
<tr><td>IdealIntermediateSwitch</td><td>理想中间开关</td></tr>
<tr><td>ControlledIdealCommutingSwitch</td><td>可控理想交换开关</td></tr>
<tr><td>ControlledIdealIntermediateSwitch</td><td>可控理想中间开关</td></tr>
<tr><td>IdealOpAmpLimited</td><td>理想的运算放大器与限制</td></tr>
<tr><td>IdealOpeningSwitch</td><td>理想的开关</td></tr>
<tr><td>IdealClosingSwitch</td><td>理想闭合器</td></tr>
<tr><td>ControlledIdealOpeningSwitch</td><td>可控理想开关</td></tr>
<tr><td>ControlledIdealClosingSwitch</td><td>受控理想闭合器</td></tr>

<tr><td colspan=\"2\"><strong>Modelica.Electrical.Analog.Lines.</strong></td></tr>
<tr><td>TLine1</td><td>无损传输线 (Z0, TD)</td></tr>
<tr><td>TLine2</td><td>无损传输线 (Z0, F, NL)</td></tr>
<tr><td>TLine2</td><td>无损传输线 (Z0, F)</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Icons.</strong></td></tr>
<tr><td>Function</td><td>函数图标</td></tr>
<tr><td>Record</td><td>记录图标</td></tr>
<tr><td>Enumeration</td><td>枚举图标</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Math.</strong></td></tr>
<tr><td>tempInterpol2</td><td>矢量化线性插值的临时例程(将被删除)</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.Mechanics.Rotational.</strong></td></tr>
<tr><td>Examples.LossyGearDemo1</td><td>举例说明齿轮效率可能导致卡滞运动</td></tr>
<tr><td>Examples.LossyGearDemo2</td><td>loss gear和BearingFriction的组合示例</td></tr>
<tr><td>LossyGear</td><td>齿轮啮合效率和轴承摩擦(卡/滚动可能)</td></tr>
<tr><td>Gear2</td><td>齿轮箱的现实模型(基于LossyGear)</td></tr>
<tr><td colspan=\"2\"><strong>Modelica.SIunits.</strong></td></tr>
<tr><td><strong><em>Conversions</em></strong></td><td>与非SI单位之间的转换函数和非SI单位的类型定义</td></tr>
<tr><td>EnergyFlowRate</td><td>Same definition as <em>Power</em></td></tr>
<tr><td>EnthalpyFlowRate</td><td><code>Real (final quantity=\"EnthalpyFlowRate\", final unit=\"W\")</code></td></tr>
<tr><td colspan=\"2\"><strong>Modelica.</strong></td></tr>
<tr><td><strong><em>Thermal.HeatTransfer</em></strong></td><td>集总元件的一维传热</td></tr>
<tr><td colspan=\"2\"><strong>ModelicaAdditions.Blocks.Discrete.</strong></td></tr>
<tr><td>TriggeredSampler</td><td>触发连续信号采样</td></tr>
<tr><td>TriggeredMax</td><td>计算触发时刻连续信号的最大值、绝对值</td></tr>
<tr><td colspan=\"2\"><strong>ModelicaAdditions.Blocks.Logical.Interfaces.</strong></td></tr>
<tr><td>BooleanMIRealMOs</td><td>多布尔输入多实输出连续控制块，输入输出数量相同</td></tr>
<tr><td>RealMIBooleanMOs</td><td>多个实数输入多个布尔输出具有相同输入和输出数量的连续控制块</td></tr>
<tr><td colspan=\"2\"><strong>ModelicaAdditions.Blocks.Logical.</strong></td></tr>
<tr><td>TriggeredTrapezoid</td><td>触发梯形发生器</td></tr>
<tr><td>Hysteresis</td><td>变换实数布尔与迟滞</td></tr>
<tr><td>OnOffController</td><td>开关控制器</td></tr>
<tr><td>Compare</td><td>如果inPort1的信号大于inPort2的信号，则为True</td></tr>
<tr><td>ZeroCrossing</td><td>触发输入信号过零</td></tr>
<tr><td colspan=\"2\"><strong>ModelicaAdditions.</strong></td></tr>
<tr><td>Blocks.Multiplexer.Extractor</td><td>从依赖IntegerRealInput索引的信号向量中提取标量信号</td></tr>
<tr><td>Tables.CombiTable1Ds</td><td>只有一个输入的一维表查找(矩阵/文件)</td></tr>
</table>
<p>
<strong>包有关的变化</strong>
</p>
<ul>
<li>所有将<strong>封装为</strong>的示例模型</li>
<li>大写常量更改为小写 (cf. Modelica.Constants)</li>
<li>引入Modelica.SIunits.Wavelength，由于打字错误</li>
<li>引入了modelicaadditions.blocks.logic.interfaces.由于错别字的比较</li>
<li>更改了*的这些组件。块到<code>块</code>类中，这些块不是块类型的</li>
<li>* .Interfaces改变。相对传感器到<code>部分</code>模型</li>
</ul>
<p>
<strong>职业专用的变化</strong>
</p>
<p>
<em>Modelica.SIunits</em>
</p>
<p>从<em>Mass</em>和<em>MassFlowRate</em>的quantity属性中删除了<code>final</code>.</p>
<p>
<em>Modelica.Blocks.Math.Sum</em>
</p>
<p>实现了避免算法部分，这将导致昂贵的函数调用.</p>
<p><em>Modelica.Blocks.Sources.Step</em></p>
<blockquote><pre>
block Step \"Generate step signals of type Real\"
  parameter Real height[:]={1} \"Heights of steps\";
<strong> // parameter Real offset[:]={0} \"Offsets of output signals\";
// parameter SIunits.Time startTime[:]={0} \"Output = offset for time < startTime\";
// extends Interfaces.MO          (final nout=max([size(height, 1); size(offset, 1); size(startTime, 1)]));
  extends Interfaces.SignalSource(final nout=max([size(height, 1); size(offset, 1); size(startTime, 1)]));</strong>
</pre></blockquote>
<p><em>Modelica.Blocks.Sources.Exponentials</em></p>
<p>由Modelica.Math.exp取代了内置函数<code>exp</code>的使用。</p>
<p><em>Modelica.Blocks.Sources.TimeTable</em></p>
<p>接口定义更改为</p>
<blockquote><pre>
parameter Real table[:, :]=[0, 0; 1, 1; 2, 4] \"Table matrix (time = first column)\";
</pre></blockquote>
<p>to</p>
<blockquote><pre>
parameter Real table[:, <strong>2</strong>]=[0, 0; 1, 1; 2, 4] \"Table matrix (time = first column)\";
</pre></blockquote>
<p>子函数也是这样 <em>getInterpolationCoefficients</em>.</p>
<p>Bug in <em>getInterpolationCoefficients</em> for startTime <> 0 fixed:</p>
<blockquote><pre>
...
  end if;
end if;
<strong>// Take into account startTime \"a*(time - startTime) + b\"
b := b - a*startTime;</strong>
end getInterpolationCoefficients;
</pre></blockquote>
<p><em>Modelica.Blocks.Sources.BooleanStep</em></p>
<blockquote><pre>
block BooleanStep \"Generate step signals of type Boolean\"
  parameter SIunits.Time startTime[:]={0} \"Time instants of steps\";
  <strong>parameter Boolean startValue[size(startTime, 1)]=fill(false, size(startTime, 1)) \"Output before startTime\";</strong>
  extends Interfaces.BooleanSignalSource(final nout=size(startTime, 1));
equation
  for i in 1:nout loop
<strong>//   outPort.signal[i] = time >= startTime[i];
    outPort.signal[i] = if time >= startTime[i] then not startValue[i] else startValue[i];</strong>
  end for;
end BooleanStep;
</pre></blockquote>
<p>
<em>Modelica.Electrical.Analog</em></p>
<p>修正了Beta值和默认值的表，将它们除以1000
(与NAND-example模型中使用的值一致):
</p>
<ul>
<li>Semiconductors.PMOS</li>
<li>Semiconductors.NMOS</li>
</ul>
<p>更正了trapapezoidcurrent的参数默认值、单位和描述。
这使得参数与其在模型中的使用保持一致。
指定参数值的模型不会更改。
未指定参数值的模型以前没有生成梯形。
</p>
<p>图标图层背景从透明变为白色:</p>
<ul>
<li>Basic.Gyrator</li>
<li>Basic.EMF</li>
<li>Ideal.Idle</li>
<li>Ideal.Short</li>
</ul>
<p>Basic.Transformer: 用'|'替换文档中的无效转义字符'\\ '和'\\[newline]'.</p>
<p><em>Modelica.Mechanics.Rotational</em></p>
<p>从图层的法兰上删除箭头和名称文档</p>
<p><em>Modelica.Mechanics.Rotational.Interfaces.FrictionBase</em></p>
<p><em>Modelica.Mechanics.Rotational.Position</em></p>
<p>Replaced <code>reinit</code> by <code>initial equation</code></p>
<p><em>Modelica.Mechanics.Rotational.RelativeStates</em></p>
<p>修正了使用修饰符<code>stateSelect = stateSelect。首选</code>作为实现</p>
<p><em>Modelica.Mechanics.Translational.Interfaces.flange_b</em></p>
<p>属性<strong>fillColor=7</strong>添加到图标图层上的矩形，即现在
填充白色，不再透明。</p>
<p><em>Modelica.Mechanics.Translational.Position</em></p>
<p>将<code>reinit</code>替换为<code>初始方程</code></p>
<p><em>Modelica.Mechanics.Translational.RelativeStates</em></p>
<p>修正了使用修饰符<code>stateSelect = stateSelect。首选</code>作为实现</p>
<p><em>Modelica.Mechanics.Translational.Stop</em></p>
<p>Use <code>stateSelect = StateSelect.prefer</code>.</p>
<p><em>Modelica.Mechanics.Translational.Examples.PreLoad</em></p>
<p>改进文档和坐标系统使用的例子。</p>
<p><em>ModelicaAdditions.Blocks.Nonlinear.PadeDelay</em></p>
<p>将<code>reinit</code>替换为<code>初始方程</code></p>
<p><em>ModelicaAdditions.HeatFlow1D.Interfaces</em></p>
<p>连接器<em>Surface_a</em>和<em>Surface_b</em>的定义:<br>
<code>flow SIunits.HeatFlux q;</code> changed to <code>flow SIunits.HeatFlowRate q;</code></p>
<p><em>MultiBody.Parts.InertialSystem</em></p>
<p>图标纠正.</p>
</html>"            ));
      end Version_1_5;

      class Version_1_4 "Version 1.4 (June 28, 2001)"
        extends Modelica.Icons.ReleaseNotes;

        annotation(Documentation(info = "<html>

<ul>
<li>修复了几个小bug。</li>
<li>新的模型：<br>
        Modelica.Blocks.Interfaces.IntegerRealInput/IntegerRealOutput,<br>
        Modelica.Blocks.Math.TwoInputs/TwoOutputs<br>
        Modelica.Electrical.Analog.Ideal.IdealOpAmp3Pin,<br>
        Modelica.Mechanics.Rotational.Move,<br>
        Modelica.Mechanics.Translational.Move.<br>
        </li>
</ul>
<hr>
<h4>Version 1.4.1beta1 (February 12, 2001)</h4>
<p> 适配到 Modelica 1.4</p>
<hr>
<h4>Version 1.3.2beta2 (June 20, 2000)</h4>
<ul>
        <li>新增子包Modelica.Mechanics.<strong>Translational</strong></li>
        <li>对Modelica.Mechanics.<strong>Rotational</strong>的更改：<br>
           新增元素：
<blockquote><pre>
IdealGearR2T    Ideal gear transforming rotational in translational motion.
Position        Forced movement of a flange with a reference angle
                                   given as input signal
RelativeStates  Definition of relative state variables
</pre></blockquote>
</li>
        <li>对Modelica.<strong>SIunits</strong>的更改：<br>
          引入了新类型：<br>
          type Temperature = ThermodynamicTemperature;<br>
          types DerDensityByEnthalpy, DerDensityByPressure,
          DerDensityByTemperature, DerEnthalpyByPressure,
          DerEnergyByDensity, DerEnergyByPressure<br>
          移除了\"final\"属性，从而使这些值可以被修改，以缩小允许的值范围。<br>
          从\"Stress\"类型中移除了\"Quantity=Stress\"，以便\"Stress\"类型可以与\"Pressure\"类型连接。</li>
        <li>对Modelica.<strong>Icons</strong>的更改：<br>
           新增了电机和齿轮箱的图标。</li>
        <li>对Modelica.<strong>Blocks.Interfaces</strong>的更改：<br>
           在Blocks.Interfaces.RealInput/RealOutput中引入了可替换的信号类型：
<blockquote><pre>
replaceable type SignalType = Real
</pre></blockquote>
           以便输入/输出块的信号类型可以更改为物理类型，例如：
<blockquote><pre>
Sine sin1(outPort(redeclare type SignalType=Modelica.SIunits.Torque))
</pre></blockquote>
</li>
</ul>
<hr>
<h4>Version 1.3.1 (Dec. 13, 1999)</h4>
<p>
库的首次官方发布。
</p>
</html>"      ));
      end Version_1_4;
      annotation(Documentation(info = "<html>

<p>
本节总结了对Modelica标准库所做的更改。
此外，在<a href=\"modelica://Modelica.UsersGuide.ReleaseNotes.VersionManagement\">Modelica.UsersGuide.ReleaseNotes.VersionManagement</a>中解释了版本的管理方式。
这对于维护(修复 bug)版本尤为重要，因为在这些版本中，主版本号不会发生变化。
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><a href=\"modelica://Modelica.UsersGuide.ReleaseNotes.Version_4_0_0\">Version 4.0.0</a></td><td>June 4, 2020</td></tr>
<tr><td><a href=\"modelica://Modelica.UsersGuide.ReleaseNotes.Version_3_2_3\">Version 3.2.3</a></td><td>January 23, 2019</td></tr>
<tr><td><a href=\"modelica://Modelica.UsersGuide.ReleaseNotes.Version_3_2_2\">Version 3.2.2</a></td><td>April 3, 2016</td></tr>
<tr><td><a href=\"modelica://Modelica.UsersGuide.ReleaseNotes.Version_3_2_1\">Version 3.2.1</a></td><td>August 14, 2013</td></tr>
<tr><td><a href=\"modelica://Modelica.UsersGuide.ReleaseNotes.Version_3_2\">Version 3.2</a></td><td>Oct. 25, 2010</td></tr>
<tr><td><a href=\"modelica://Modelica.UsersGuide.ReleaseNotes.Version_3_1\">Version 3.1</a></td><td>August 14, 2009</td></tr>
<tr><td><a href=\"modelica://Modelica.UsersGuide.ReleaseNotes.Version_3_0_1\">Version 3.0.1</a></td><td>Jan. 27, 2009</td></tr>
<tr><td><a href=\"modelica://Modelica.UsersGuide.ReleaseNotes.Version_3_0\">Version 3.0</a></td><td>March 1, 2008</td></tr>
<tr><td><a href=\"modelica://Modelica.UsersGuide.ReleaseNotes.Version_2_2_2\">Version 2.2.2</a></td><td>Aug. 31, 2007</td></tr>
<tr><td><a href=\"modelica://Modelica.UsersGuide.ReleaseNotes.Version_2_2_1\">Version 2.2.1</a></td><td>March 24, 2006</td></tr>
<tr><td><a href=\"modelica://Modelica.UsersGuide.ReleaseNotes.Version_2_2\">Version 2.2</a></td><td>April 6, 2005</td></tr>
<tr><td><a href=\"modelica://Modelica.UsersGuide.ReleaseNotes.Version_2_1\">Version 2.1</a></td><td>Nov. 11, 2004</td></tr>
<tr><td><a href=\"modelica://Modelica.UsersGuide.ReleaseNotes.Version_1_6\">Version 1.6</a></td><td>June 21, 2004</td></tr>
<tr><td><a href=\"modelica://Modelica.UsersGuide.ReleaseNotes.Version_1_5\">Version 1.5</a></td><td>Dec. 16, 2002</td></tr>
<tr><td><a href=\"modelica://Modelica.UsersGuide.ReleaseNotes.Version_1_4\">Version 1.4</a></td><td>June 28, 2001</td></tr>
</table>
</html>"            ));
    end ReleaseNotes;

    class Contact "联系方式"
      extends Modelica.Icons.Contact;

      annotation(Documentation(info = "<html>
<dl><dt>Modelica标准库(这个Modelica包)是由来自不同组织的贡献者开发的(参见下面的列表)。它是由<a href=\"https://modelica.org/licenses/modelica-3-clause-bsd\">BSD 3-Clause License</a>授权的：</dt>
<dt><br /></dt>
<dd>Modelica协会 </dd>
<dd>(Ideella F&ouml;reningar 822003-8858 in Link&ouml;ping)</dd>
<dd>c/o PELAB, IDA, Link&ouml;pings Universitet</dd>
<dd>S-58183 Link&ouml;ping</dd>
<dd>Sweden</dd>
<dd>email: <a href=\"mailto:Board@Modelica.org\">Board@Modelica.org</a></dd>
<dd>web: <a href=\"https://www.Modelica.org\">https://www.Modelica.org</a></dd>
<dd><br /></dd>

<dt>这个Modelica包的开发(从版本3.2.3开始)由以下组织：</dt>
<dd><a href=\"https://github.com/beutlich\">Thomas Beutlich</a>和<a href=\"https://github.com/dietmarw\">Dietmar Winkler</a></dd>
<dd><br /></dd>

<dt>这个Modelica 3.2.2版本包的开发是由：</dt>
<dd><a href=\"https://www.haumer.at/eindex.htm\">Anton Haumer</a></dd>
<dd>Technical Consulting &amp; Electrical Engineering</dd>
<dd>D-93049 Regensburg</dd>
<dd>Germany</dd>
<dd>email: <a href=\"mailto:A.Haumer@Haumer.at\">A.Haumer@Haumer.at</a></dd>
<dd><br /></dd>

<dt>这个Modelica包的开发直到并包括版本3.2.1是由以下组织的：</dt>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a></dd>
<dd>German Aerospace Center (DLR)</dd>
<dd>Robotics and Mechatronics Center (RMC)</dd>
<dd>Institute of System Dynamics and Control (SR)</dd>
<dd>Postfach 1116</dd>
<dd>D-82230 Wessling</dd>
<dd>Germany</dd>
<dd>email: <a href=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</a></dd>
</dl>
<p>自2007年底以来，Modelica包的子库开发由Modelica协会指定的个人和/或组织的<strong>库负责人</strong>组织。
负责人负责维护和进一步组织开发工作。
其他人员也可以作出贡献，但库的改进和/或变更的最终决定由负责的库负责人做出。
为了使一个新的子库或子库的新版本准备好发布，负责的库官员会将变更报告给Modelica协会的成员，并在做出最终决定之前，将该库提供给感兴趣的方进行Beta测试。
子库的新版本发布由Modelica协会成员投票正式决定。</p>
<p>截至2020年3月7日，以下人员被指定为库负责人：</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>Sublibraries</strong> </td>
   <td><strong>Library officers</strong></td>
</tr>

<tr>
<td align=\"left\">UsersGuide</td>
<td align=\"left\">Christian Kral, Jakub Tobolar</td>
</tr>
<tr>
<td align=\"left\">Blocks</td>
<td align=\"left\">Martin Otter, Anton Haumer</td>
</tr>
<tr>
<td align=\"left\">Clocked</td>
<td align=\"left\">Christoff B&uuml;rger, Bernhard Thiele</td>
</tr>
<tr>
<td align=\"left\">ComplexBlocks</td>
<td align=\"left\">Anton Haumer, Christian Kral</td>
</tr>
<tr>
<td align=\"left\">Blocks.Tables</td>
<td align=\"left\">Thomas Beutlich, Martin Otter, Anton Haumer</td>
</tr>
<tr>
<td align=\"left\">StateGraph</td>
<td align=\"left\">Hans Olsson, Martin Otter</td>
</tr>
<tr>
<td align=\"left\">Electrical.Analog</td>
<td align=\"left\">Christoph Clauss, Anton Haumer, Christian Kral, Kristin Majetta</td>
</tr>
<tr>
<td align=\"left\">Electrical.Batteries</td>
<td align=\"left\">Anton Haumer, Christian Kral</td>
</tr>
<tr>
<td align=\"left\">Electrical.Digital</td>
<td align=\"left\">Christoph Clauss, Kristin Majetta</td>
</tr>
<tr>
<td align=\"left\">Electrical.Machines</td>
<td align=\"left\">Anton Haumer, Christian Kral</td>
</tr>
<tr>
<td align=\"left\">Electrical.Polyphase</td>
<td align=\"left\">Anton Haumer, Christian Kral</td>
</tr>
<tr>
<td align=\"left\">Electrical.PowerConverters</td>
<td align=\"left\">Christian Kral, Anton Haumer</td>
</tr>
<tr>
<td align=\"left\">Electrical.QuasiStatic</td>
<td align=\"left\">Anton Haumer, Christian Kral</td>
</tr>
<tr>
<td align=\"left\">Electrical.Spice3</td>
<td align=\"left\">Christoph Clauss, Kristin Majetta, Joe Riel</td>
</tr>
<tr>
<td align=\"left\">Magnetic.FluxTubes</td>
<td align=\"left\">Thomas B&ouml;drich, Anton Haumer, Christian Kral, Johannes Ziske</td>
</tr>
<tr>
<td align=\"left\">Magnetic.FundamentalWave</td>
<td align=\"left\">Anton Haumer, Christian Kral</td>
</tr>
<tr>
<td align=\"left\">Magnetic.QuasiStatic</td>
<td align=\"left\">Anton Haumer, Christian Kral</td>
</tr>
<tr>
<td align=\"left\">Mechanics.MultiBody</td>
<td align=\"left\">Martin Otter, Jakub Tobolar</td>
</tr>
<tr>
<td align=\"left\">Mechanics.Rotational</td>
<td align=\"left\">Anton Haumer, Christian Kral, Martin Otter, Jakub Tobolar</td>
</tr>
<tr>
<td align=\"left\">Mechanics.Translational</td>
<td align=\"left\">Anton Haumer, Christian Kral, Martin Otter, Jakub Tobolar</td>
</tr>
<tr>
<td align=\"left\">Fluid</td>
<td align=\"left\">Francesco Casella, R&uuml;diger Franke, Hubertus Tummescheit</td>
</tr>
<tr>
<td align=\"left\">Fluid.Dissipation</td>
<td align=\"left\">Francesco Casella, Stefan Wischhusen</td>
</tr>
<tr>
<td align=\"left\">Media</td>
<td align=\"left\">Francesco Casella, R&uuml;diger Franke, Hubertus Tummescheit</td>
</tr>
<tr>
<td align=\"left\">Thermal.FluidHeatFlow</td>
<td align=\"left\">Anton Haumer, Christian Kral</td>
</tr>
<tr>
<td align=\"left\">Thermal.HeatTransfer</td>
<td align=\"left\">Anton Haumer, Christian Kral</td>
</tr>
<tr>
<td align=\"left\">Math</td>
<td align=\"left\">Hans Olsson, Martin Otter</td>
</tr>
<tr>
<td align=\"left\">ComplexMath</td>
<td align=\"left\">Anton Haumer, Christian Kral, Martin Otter</td>
</tr>
<tr>
<td align=\"left\">Utilities</td>
<td align=\"left\">Dag Br&uuml;ck, Hans Olsson, Martin Otter</td>
</tr>
<tr>
<td align=\"left\">Constants</td>
<td align=\"left\">Hans Olsson, Martin Otter</td>
</tr>
<tr>
<td align=\"left\">Icons</td>
<td align=\"left\">Christian Kral, Jakub Tobolar</td>
</tr>
<tr>
<td align=\"left\">Units</td>
<td align=\"left\">Christian Kral, Martin Otter</td>
</tr>
<tr>
<td align=\"left\">C-Sources</td>
<td align=\"left\">Thomas Beutlich, Hans Olsson, Martin Sj&ouml;lund</td>
</tr>
<tr>
<td align=\"left\">Reference</td>
<td align=\"left\">Hans Olsson, Dietmar Winkler</td>
</tr>
<tr>
<td align=\"left\">Services</td>
<td align=\"left\">Hans Olsson, Martin Otter</td>
</tr>
<tr>
<td align=\"left\">Complex</td>
<td align=\"left\">Anton Haumer, Christian Kral</td>
</tr>
<tr>
<td align=\"left\">Test</td>
<td align=\"left\">Leo Gall, Martin Otter</td>
</tr>
<tr>
<td align=\"left\">TestOverdetermined</td>
<td align=\"left\">Leo Gall, Martin Otter</td>
</tr>
<tr>
<td align=\"left\">TestConversion4</td>
<td align=\"left\">Leo Gall, Martin Otter</td>
</tr>
<tr>
<td align=\"left\">ObsoleteModelica4</td>
<td align=\"left\">Hans Olsson, Martin Otter</td>
</tr>
</table>

<p>
以下人员直接参与了Modelica包的实现(还有许多人对设计作出了贡献)：
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>Marcus Baur</strong></td>
   <td>previously at:<br>Institute of System Dynamics and Control<br>
     DLR, German Aerospace Center,<br>
     Oberpfaffenhofen, Germany</td>
   <td>Complex<br>
                      Modelica.Math.Vectors<br>
                      Modelica.Math.Matrices</td>
</tr>

<tr><td><strong>Peter Beater</strong></td>
   <td>University of Paderborn, Germany</td>
   <td>Modelica.Mechanics.Translational</td>
</tr>

<tr><td><strong>Thomas Beutlich</strong></td>
   <td>previously at:<br>ESI ITI GmbH, Germany</td>
   <td>Modelica.Blocks.Sources.CombiTimeTable<br>
                      Modelica.Blocks.Tables</td>
</tr>

<tr><td><strong>Thomas B&ouml;drich</strong></td>
   <td>Dresden University of Technology, Germany</td>
   <td>Modelica.Magnetic.FluxTubes</td>
</tr>

<tr><td><strong>Dag Br&uuml;ck</strong></td>
   <td>Dassault Syst&egrave;mes AB, Lund, Sweden</td>
   <td>Modelica.Utilities</td>
</tr>

<tr><td><strong>Francesco Casella</strong></td>
   <td>Politecnico di Milano, Milano, Italy</td>
   <td>Modelica.Fluid<br>
                      Modelica.Media</td>
</tr>

<tr><td><strong>Christoph Clauss</strong></td>
   <td>until 2016:<br>
     Fraunhofer Institute for Integrated Circuits,<br>
     Dresden, Germany</td>
   <td>Modelica.Electrical.Analog<br>
                      Modelica.Electrical.Digital<br>
                      Modelica.Electrical.Spice3</td>
</tr>

<tr><td><strong>Jonas Eborn</strong></td>
   <td>Modelon AB, Lund, Sweden</td>
   <td>Modelica.Media</td>
</tr>

<tr><td><strong>Hilding Elmqvist</strong></td>
   <td>Mogram AB, Lund, Sweden<br>
     until 2015:<br>
     Dassault Syst&egrave;mes AB, Lund, Sweden</td>
   <td>Modelica.Mechanics.MultiBody<br>
                      Modelica.Fluid<br>
                      Modelica.Media<br>
                      Modelica.StateGraph<br>
                      Modelica.Utilities<br>
                      Conversion from 1.6 to 2.0</td>
</tr>

<tr><td><strong>R&uuml;diger Franke</strong></td>
   <td>ABB Corporate Research,<br>Ladenburg, Germany</td>
   <td>Modelica.Fluid<br>
                      Modelica.Media</td>
</tr>

<tr><td><strong>Manuel Gr&auml;ber</strong></td>
   <td>Institut f&uuml;r Thermodynamik,<br>
     Technische Universit&auml;t Braunschweig, Germany</td>
   <td>Modelica.Fluid</td>
</tr>

<tr><td><strong>Anton Haumer</strong></td>
   <td>Consultant, Regensburg,<br>Germany</td>
   <td>Modelica.ComplexBlocks<br>
                      Modelica.Electrical.Machines<br>
                      Modelica.Electrical.Polyphase<br>
                      Modelica.Electrical.QuasiStatic<br>
                      Modelica.Magnetics.FundamentalWave<br>
                      Modelica.Mechanics.Rotational<br>
                      Modelica.Mechanics.Translational<br>
                      Modelica.Thermal.FluidHeatFlow<br>
                      Modelica.Thermal.HeatTransfer<br>
                      Modelica.ComplexMath<br>
                      Conversion from 1.6 to 2.0<br>
                      Conversion from 2.2 to 3.0</td>
</tr>

<tr><td><strong>Hans-Dieter Joos</strong></td>
   <td>previously at:<br>Institute of System Dynamics and Control<br>
     DLR, German Aerospace Center,<br>
     Oberpfaffenhofen, Germany</td>
   <td>Modelica.Math.Matrices</td>
</tr>

<tr><td><strong>Christian Kral</strong></td>
   <td>Modeling and Simulation of Electric Machines, Drives and Mechatronic Systems,<br>
     Vienna, Austria</td>
   <td>Modelica.ComplexBlocks<br>
                      Modelica.Electrical.Machines<br>
                      Modelica.Electrical.Polyphase<br>
                      Modelica.Electrical.QuasiStatic<br>
                      Modelica.Magnetics.FundamentalWave<br>
                      Modelica.Mechanics.Rotational<br>
                      Modelica.Mechanics.Translational<br>
                      Modelica.Thermal.FluidHeatFlow<br>
                      Modelica.Thermal.HeatTransfer<br>
                      Modelica.ComplexMath
  </td>
</tr>

<tr><td><strong>Sven Erik Mattsson</strong></td>
   <td>until 2015:<br>
     Dassault Syst&egrave;mes AB, Lund, Sweden</td>
   <td>Modelica.Mechanics.MultiBody</td>
</tr>

<tr><td><strong>Hans Olsson</strong></td>
   <td>Dassault Syst&egrave;mes AB, Lund, Sweden</td>
   <td>Modelica.Blocks<br>
                      Modelica.Math.Matrices<br>
                      Modelica.Utilities<br>
                      Conversion from 1.6 to 2.0<br>
                      Conversion from 2.2 to 3.0</td>
</tr>

<tr><td><strong>Martin Otter</strong></td>
   <td>Institute of System Dynamics and Control<br>
     DLR, German Aerospace Center,<br>
     Oberpfaffenhofen, Germany</td>
   <td>Complex<br>
                      Modelica.Blocks<br>
                      Modelica.Fluid<br>
                      Modelica.Mechanics.MultiBody<br>
                      Modelica.Mechanics.Rotational<br>
                      Modelica.Mechanics.Translational<br>
                      Modelica.Math<br>
                      Modelica.ComplexMath<br>
                      Modelica.Media<br>
                      Modelica.SIunits<br>
                      Modelica.StateGraph<br>
                      Modelica.Thermal.HeatTransfer<br>
                      Modelica.Utilities<br>
                      ModelicaReference<br>
                      Conversion from 1.6 to 2.0<br>
                      Conversion from 2.2 to 3.0</td>
</tr>

<tr><td><strong>Katrin Pr&ouml;l&szlig;</strong></td>
   <td>previously at:<br>Modelon Deutschland GmbH, Hamburg, Germany<br>
     until 2008:<br>
     Department of Technical Thermodynamics,<br>
     Technical University Hamburg-Harburg,<br>Germany</td>
   <td>Modelica.Fluid<br>
                            Modelica.Media</td>
</tr>

<tr><td><strong>Christoph C. Richter</strong></td>
   <td>until 2009:<br>
     Institut f&uuml;r Thermodynamik,<br>
     Technische Universit&auml;t Braunschweig,<br>
     Germany</td>
   <td>Modelica.Fluid<br>
                      Modelica.Media</td>
</tr>

<tr><td><strong>Andr&eacute; Schneider</strong></td>
   <td>Fraunhofer Institute for Integrated Circuits,<br>Dresden, Germany</td>
   <td>Modelica.Electrical.Analog<br>
     Modelica.Electrical.Digital</td>
</tr>
<tr><td><strong>Christian Schweiger</strong></td>
   <td>until 2006:<br>
     Institute of System Dynamics and Control,<br>
     DLR, German Aerospace Center,<br>
     Oberpfaffenhofen, Germany</td>
   <td>Modelica.Mechanics.Rotational<br>
                      ModelicaReference<br>
                      Conversion from 1.6 to 2.0</td>
</tr>

<tr><td><strong>Michael Sielemann</strong></td>
   <td>Modelon Deutschland GmbH, Munich, Germany<br>
     previously at:<br>
     Institute of System Dynamics and Control<br>
     DLR, German Aerospace Center,<br>
     Oberpfaffenhofen, Germany</td>
   <td>Modelica.Fluid<br>
                      Modelica.Media</td>
</tr>

<tr><td><strong>Michael Tiller</strong></td>
   <td>Xogeny Inc., Canton, MI, U.S.A.<br>
     previously at:<br>
     Emmeskay, Inc., Dearborn, MI, U.S.A.<br>
     previously at:<br>
     Ford Motor Company, Dearborn, MI, U.S.A.</td>
   <td>Modelica.Media<br>
                      Modelica.Thermal.HeatTransfer</td>
</tr>

<tr><td><strong>Hubertus Tummescheit</strong></td>
   <td>Modelon, Inc., Hartford, CT, U.S.A.</td>
   <td>Modelica.Media<br>
                      Modelica.Thermal.HeatTransfer</td>
</tr>

<tr><td><strong>Thorsten Vahlenkamp</strong></td>
   <td>until 2010:<br>
                     XRG Simulation GmbH, Hamburg, Germany</td>
   <td>Modelica.Fluid.Dissipation</td>
</tr>

<tr><td><strong>Nico Walter</strong></td>
   <td>Master thesis at HTWK Leipzig<br>
     (Prof. R. M&uuml;ller) and<br>
     DLR Oberpfaffenhofen, Germany</td>
   <td>Modelica.Math.Matrices</td>
</tr>

<tr><td><strong>Michael Wetter</strong></td>
   <td>Lawrence Berkeley National Laboratory, Berkeley, CA, U.S.A.</td>
   <td>Modelica.Fluid</td>
</tr>

<tr><td><strong>Hans-J&uuml;rg Wiesmann</strong></td>
   <td>Switzerland</td>
   <td>Modelica.ComplexMath</td>
</tr>

<tr><td><strong>Stefan Wischhusen</strong></td>
   <td>XRG Simulation GmbH, Hamburg, Germany</td>
   <td>Modelica.Fluid.Dissipation<br>
                      Modelica.Media</td>
</tr>
</table>

</html>"            ));

    end Contact;

    annotation(DocumentationClass = true, Documentation(info="<html>
<p>
<strong>Modelica</strong>包是一个<strong>标准化的</strong>和<strong>预定义的</strong>包，
它与Modelica语言一起由Modelica协会开发，详见<a href=\"https://www.Modelica.org\">https://www.Modelica.org</a>。
它也被称为<strong>Modelica标准库</strong>。
该库提供了常量、类型、连接器、抽象模型和各种学科的模型组件。
</p>
<p>
这是一份简短的适用于整个库的<strong>用户指南</strong>。
一些主要子库有自己的用户指南，可通过以下链接访问：
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr>
  <td><a href=\"modelica://Modelica.ComplexBlocks.UsersGuide\">ComplexBlocks</a></td>
  <td>带有复数信号的基本输入/输出控制模块库</td>
</tr>

<tr><td><a href=\"modelica://Modelica.Electrical.Digital.UsersGuide\">Digital</a>
   </td>
   <td>基于VHDL标准的数字电气元件库 (2-,3-,4-,9-valued logic)</td>
</tr>

<tr>
  <td><a href=\"modelica://Modelica.Fluid.Dissipation.UsersGuide\">Dissipation</a></td>
  <td>对流传热和压力损失特性函数库</td>
</tr>

<tr><td><a href=\"modelica://Modelica.Fluid.UsersGuide\">Fluid</a></td>
    <td>使用Modelica.Media介质描述的一维热流体流动模型库</td>
</tr>

<tr>
  <td><a href=\"modelica://Modelica.Thermal.FluidHeatFlow.UsersGuide\">FluidHeatFlow</a></td>
  <td>一维不可压缩热流体流动模型的简单组件库</td>
</tr>

<tr><td><a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide\">FluxTubes</a>
    </td>
   <td>用于建模具有集中磁网络的电磁设备的库</td>
</tr>

<tr>
  <td><a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide\">FundamentalWave</a></td>
  <td>电机磁基波效应库</td>
</tr>

<tr>
  <td><a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.UsersGuide\">FundamentalWave</a></td>
  <td>准静态基波电机库</td>
</tr>

<tr>
  <td><a href=\"modelica://Modelica.Electrical.Machines.UsersGuide\">Machines</a></td>
  <td>电机库</td>
</tr>

<tr><td><a href=\"modelica://Modelica.Media.UsersGuide\">Media</a>
    </td>
   <td>介质属性模型库</td>
</tr>

<tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.UsersGuide\">MultiBody</a>
    </td>
   <td>三维机械系统模型库</td>
</tr>

<tr>
  <td><a href=\"modelica://Modelica.Electrical.Polyphase.UsersGuide\">Polyphase</a></td>
  <td>用于单相或多相电气组件的库</td>
</tr>

<tr>
  <td><a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide\">PowerConverters</a></td>
  <td>整流器、逆变器和DC/DC转换器库</td>
</tr>

<tr>
  <td><a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide\">QuasiStatic</a></td>
  <td>准静态电气单相和多相交流模拟库</td>
</tr>

<tr><td><a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide\">Rotational</a>
    </td>
   <td>一维转动机械系统建模库</td>
</tr>

<tr>
  <td><a href=\"modelica://Modelica.Electrical.Spice3.UsersGuide\">Spice3</a></td>
  <td>Berkeley SPICE3仿真器组件库</td>
</tr>

<tr><td><a href=\"modelica://Modelica.StateGraph.UsersGuide\">StateGraph</a>
    </td>
   <td>通过层次状态机建模离散事件和响应系统的库</td>
</tr>

<tr><td><a href=\"modelica://Modelica.Mechanics.Translational.UsersGuide\">Translational</a>
    </td>
   <td>一维平动机械系统建模库</td>
</tr>

<tr><td><a href=\"modelica://Modelica.Units.UsersGuide\">Units</a> </td>
   <td>类型定义库</td>
</tr>

<tr><td><a href=\"modelica://Modelica.Utilities.UsersGuide\">Utilities</a>
    </td>
   <td>专门用于脚本编写的实用函数库(文件、流、字符串、系统)</td>
</tr>
</table>

</html>"    ));
  end UsersGuide;

  annotation(
    preferredView = "info", 
    version = "4.0.0.TY.1", 
    versionDate = "2025-04-18", 
    dateModified = "2025-04-18 15:00:00Z", 
    revisionId = "e2983375f2 2024-04-04 08:28:31 +0200", 
    uses(Complex(version = "4.0.0.TY.1"), ModelicaServices(version = "4.0.0.TY.1")), 
    conversion(
    from(version = {"3.0", "3.0.1", "3.1", "3.2", "3.2.1", "3.2.2", "3.2.3"}, script = "modelica://Modelica/Resources/Scripts/Conversion/ConvertModelica_from_3.2.3_to_4.0.0.mos")), 
    Icon(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}), graphics = {
    Polygon(
    origin = {-6.9888, 20.048}, 
    pattern = LinePattern.None, 
    fillPattern = FillPattern.Solid, 
    points = {{-93.0112, 10.3188}, {-93.0112, 10.3188}, {-73.011, 24.6}, {-63.011, 31.221}, {-51.219, 36.777}, {-39.842, 38.629}, {-31.376, 36.248}, {-25.819, 29.369}, {-24.232, 22.49}, {-23.703, 17.463}, {-15.501, 25.135}, {-6.24, 32.015}, {3.02, 36.777}, {15.191, 39.423}, {27.097, 37.306}, {32.653, 29.633}, {35.035, 20.108}, {43.501, 28.046}, {54.085, 35.19}, {65.991, 39.952}, {77.897, 39.688}, {87.422, 33.338}, {91.126, 21.696}, {90.068, 9.525}, {86.099, -1.058}, {79.749, -10.054}, {71.283, -21.431}, {62.816, -33.337}, {60.964, -32.808}, {70.489, -16.14}, {77.368, -2.381}, {81.072, 10.054}, {79.749, 19.05}, {72.605, 24.342}, {61.758, 23.019}, {49.587, 14.817}, {39.003, 4.763}, {29.214, -6.085}, {21.012, -16.669}, {13.339, -26.458}, {5.401, -36.777}, {-1.213, -46.037}, {-6.24, -53.446}, {-8.092, -52.387}, {-0.684, -40.746}, {5.401, -30.692}, {12.81, -17.198}, {19.424, -3.969}, {23.658, 7.938}, {22.335, 18.785}, {16.514, 23.283}, {8.047, 23.019}, {-1.478, 19.05}, {-11.267, 11.113}, {-19.734, 2.381}, {-29.259, -8.202}, {-38.519, -19.579}, {-48.044, -31.221}, {-56.511, -43.392}, {-64.449, -55.298}, {-72.386, -66.939}, {-77.678, -74.612}, {-79.53, -74.083}, {-71.857, -61.383}, {-62.861, -46.037}, {-52.278, -28.046}, {-44.869, -15.346}, {-38.784, -2.117}, {-35.344, 8.731}, {-36.403, 19.844}, {-42.488, 23.813}, {-52.013, 22.49}, {-60.744, 16.933}, {-68.947, 10.054}, {-76.884, 2.646}, {-93.0112, -12.1707}, {-93.0112, -12.1707}}, 
    smooth = Smooth.Bezier), 
    Ellipse(
    origin = {40.8208, -37.7602}, 
    fillColor = {161, 0, 4}, 
    pattern = LinePattern.None, 
    fillPattern = FillPattern.Solid, 
    extent = {{-17.8562, -17.8563}, {17.8563, 17.8562}})}), 
    Documentation(info = "<html>
<div>
<img src=\"modelica://Modelica/Resources/Images/Logos/Modelica_Libraries.svg\" width=\"250\">
</div>

<p>
<strong>Modelica&reg;</strong>包是一个<strong>标准化的</strong>和<strong>免费的</strong>包，
它是由<strong>Modelica协会项目-模型库</strong>开发的。</p>
<p>
它的开发与Modelica协会的Modelica®语言相协调，参见<a href=\"https://www.Modelica.org\">https://www.Modelica.org</a>。
它也被称为<strong>Modelica标准库</strong>。它在许多基于标准化接口定义的领域中提供模型组件。在下图中给出了一些典型的例子:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/UsersGuide/ModelicaLibraries.png\">
</div>

<p>
有关介绍，请特别参阅：
</p>
<ul>
<li> <a href=\"modelica://Modelica.UsersGuide.Overview\">Overview</a>
  概述了Modelica标准库，位于<a href=\"modelica://Modelica.UsersGuide\">User's Guide</a>内。</li>
<li><a href=\"modelica://Modelica.UsersGuide.ReleaseNotes\">Release Notes</a>
 总结了该软件包新版本的变化。</li>
<li> <a href=\"modelica://Modelica.UsersGuide.Contact\">Contact</a>
  列出了Modelica标准库的贡献者。</li>
<li> 各库中的<strong>Examples</strong>包演示了如何使用相应子库中的组件。</li>
</ul>

<p>
此版本的Modelica标准库包括
</p>
<ul>
<li><strong>1417</strong> 个组件模型和模块，</li>
<li><strong>512</strong> 个示例模型，以及</li>
<li><strong>1219</strong> 个函数</li>
</ul>
<p>
它们都是直接可用的类(= 公共类、非局部类、非内部类和非过时类的数量)。它是完全兼容
<a href=\"https://modelica.org/documents/ModelicaSpec34.pdf\">Modelica Specification version 3.4</a>的，
并且已经使用来自不同供应商的Modelica工具进行了测试。
</p>

<p>
<strong> Modelica协会根据3-Clause BSD许可证授权</strong><br>
Copyright &copy; 1998-2020, Modelica协会和<a href=\"modelica://Modelica.UsersGuide.Contact\">贡献者</a>.
</p>

<p>
<em>此Modelica包为<u>免费的</u>软件包，使用风险完全由<u>您自行承担</u>；它可以在3-Clause BSD许可证的条款下被重新分发和/或修改。有关许可条件(包括免责声明)，请访问<a href=\"https://modelica.org/licenses/modelica-3-clause-bsd\">https://modelica.org/licenses/modelica-3-clause-bsd</a>。</em>
</p>

<p>
<strong>Modelica&reg;</strong>是Modelica协会的注册商标。
</p>
</html>"));
end Modelica;