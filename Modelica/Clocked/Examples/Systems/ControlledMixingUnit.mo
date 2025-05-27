within Modelica.Clocked.Examples.Systems;
model ControlledMixingUnit 
  "一个简单的混合单元示例，其中使用（离散化的）非线性逆被控对象模型作为前馈控制器。"
  extends Modelica.Icons.Example;

  parameter SI.Frequency freq = 1 / 300 "滤波器的临界频率";
  parameter Real c0(unit = "mol/l") = 0.848 "额定浓度";
  parameter SI.Temperature T0 = 308.5 "额定温度";
  parameter Real a1_inv = 0.2674 "逆受控对象模型的工艺参数（参见帮助中的参考资料）";
  parameter Real a21_inv = 1.815 "逆受控对象模型的工艺参数（参见帮助中的参考资料）";
  parameter Real a22_inv = 0.4682 "逆受控对象模型的工艺参数（参见帮助中的参考资料）";
  parameter Real b_inv = 1.5476 "逆受控对象模型的工艺参数（参见帮助中的参考资料）";
  parameter Real k0_inv = 1.05e14 "逆受控对象模型的工艺参数（参见帮助中的参考资料）";
  parameter Real eps = 34.2894 "过程参数（请参阅帮助中的参考资料）";
  parameter Real x10 = 0.42 "额定浓度与初始浓度之间的相对偏移量";
  parameter Real x20 = 0.01 "额定温度与初始温度之间的相对偏差";
  parameter Real u0 = -0.0224 "初始冷却温度与额定温度之间的相对偏差";
  final parameter Real c_start(unit = "mol/l") = c0 * (1 - x10) "初始浓度";
  final parameter SI.Temperature T_start = T0 * (1 + x20) "初始温度";
  final parameter Real c_high_start(unit = "mol/l") = c0 * (1 - 0.72) "参考浓度";
  final parameter Real T_c_start = T0 * (1 + u0) "初始冷却温度";
  parameter Real pro = 1.5 "受控对象与逆受控对象参数的偏差";
  final parameter Real a1 = a1_inv * pro "设备模型的过程参数（参见帮助中的参考资料）";
  final parameter Real a21 = a21_inv * pro "设备模型的过程参数（参见帮助中的参考资料）";
  final parameter Real a22 = a22_inv * pro "设备模型的过程参数（参见帮助中的参考资料）";
  final parameter Real b = b_inv * pro "设备模型的过程参数（参见帮助中的参考资料）";
  final parameter Real k0 = k0_inv * pro "设备模型的过程参数（参见帮助中的参考资料）";
  Clocked.Examples.Systems.Utilities.ComponentsMixingUnit.MixingUnit invMixingUnit(
    c0 = c0, 
    T0 = T0, 
    a1 = a1_inv, 
    a21 = a21_inv, 
    a22 = a22_inv, 
    b = b_inv, 
    k0 = k0_inv, 
    eps = eps, 
    c(start = c_start, fixed = true), 
    T(start = T_start, 
    fixed = true, 
    stateSelect = StateSelect.always), 
    T_c(start = T_c_start)) 
    annotation(Placement(transformation(extent = {{-12, 14}, {-32, 34}})));
  Modelica.Blocks.Math.Add add 
    annotation(Placement(transformation(extent = {{40, -18}, {56, -2}})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints 
    annotation(Placement(transformation(extent = {{-54, 8}, {-2, 40}})));
  Clocked.Examples.Systems.Utilities.ComponentsMixingUnit.MixingUnit mixingUnit(
    c(start = c_start, fixed = true), 
    T(start = T_start, fixed = true), 
    c0 = c0, 
    T0 = T0, 
    a1 = a1, 
    a21 = a21, 
    a22 = a22, 
    b = b, 
    k0 = k0, 
    eps = eps) 
    annotation(Placement(transformation(extent = {{88, -20}, {108, 0}})));
  Modelica.Blocks.Math.Feedback feedback 
    annotation(Placement(transformation(extent = {{-24, -20}, {-4, 0}})));
  Modelica.Blocks.Math.Gain gain(k = 20) annotation(Placement(transformation(
    extent = {{4, -20}, {24, 0}})));

  Utilities.ComponentsMixingUnit.CriticalDamping filter(
    n = 3, 
    f = freq, 
    x(start = {0.49, 0.49, 0.49}, fixed = {true, false, false})) 
    annotation(Placement(transformation(extent = {{-86, 14}, {-66, 34}})));
  Clocked.RealSignals.Sampler.Hold hold1(y_start = 0) 
    annotation(Placement(transformation(extent = {{66, -16}, {78, -4}})));
  Clocked.RealSignals.Sampler.Sample sample1 
    annotation(Placement(transformation(extent = {{80, -40}, {68, -28}})));
  Clocked.ClockSignals.Clocks.PeriodicRealClock periodicClock1(
    useSolver = true, 
    period = 1, 
    solverMethod = "ExplicitEuler") 
    annotation(Placement(transformation(extent = {{-134, -26}, {-122, -14}})));
  Modelica.Blocks.Sources.Step step(height = c_high_start - c_start, offset = 
    c_start) 
    annotation(Placement(transformation(extent = {{-136, 14}, {-116, 34}})));
  RealSignals.Sampler.SampleClocked sample2 
    annotation(Placement(transformation(extent = {{-108, 18}, {-96, 30}})));
equation
  connect(feedback.y, gain.u) annotation(Line(points = {{-5, -10}, {-5, -10}, 
    {2, -10}}, 
    color = {0, 0, 127}));
  connect(gain.y, add.u2) annotation(Line(
    points = {{25, -10}, {32, -10}, {32, -14.8}, {38.4, -14.8}}, 
    color = {0, 0, 127}));
  connect(inverseBlockConstraints.y2, invMixingUnit.T_c) annotation(Line(
    points = {{-5.9, 24}, {-10, 24}}, 
    color = {0, 0, 127}));
  connect(invMixingUnit.c, inverseBlockConstraints.u2) annotation(Line(
    points = {{-34, 30}, {-38, 30}, {-38, 24}, {-48.8, 24}}, 
    color = {0, 0, 127}));
  connect(invMixingUnit.T, feedback.u1) annotation(Line(
    points = {{-34, 18}, {-46, 18}, {-46, -10}, {-22, -10}}, 
    color = {0, 0, 127}));
  connect(filter.y, inverseBlockConstraints.u1) annotation(Line(
    points = {{-65, 24}, {-56.6, 24}}, 
    color = {0, 0, 127}));
  connect(hold1.y, mixingUnit.T_c) annotation(Line(
    points = {{78.6, -10}, {86, -10}}, 
    color = {0, 0, 127}));
  connect(add.y, hold1.u) annotation(Line(
    points = {{56.8, -10}, {64.8, -10}}, 
    color = {0, 0, 127}));
  connect(sample1.u, mixingUnit.T) annotation(Line(
    points = {{81.2, -34}, {116, -34}, {116, -16}, {110, -16}}, 
    color = {0, 0, 127}));
  connect(sample1.y, feedback.u2) annotation(Line(
    points = {{67.4, -34}, {-14, -34}, {-14, -18}}, 
    color = {0, 0, 127}));
  connect(inverseBlockConstraints.y1, add.u1) annotation(Line(
    points = {{-0.7, 24}, {30, 24}, {30, -5.2}, {38.4, -5.2}}, 
    color = {0, 0, 127}));
  connect(sample2.u, step.y) annotation(Line(
    points = {{-109.2, 24}, {-115, 24}}, 
    color = {0, 0, 127}));
  connect(filter.u, sample2.y) annotation(Line(
    points = {{-88, 24}, {-95.4, 24}}, 
    color = {0, 0, 127}));
  connect(periodicClock1.y, sample2.clock) annotation(Line(
    points = {{-121.4, -20}, {-102, -20}, {-102, 16.8}}, 
    color = {175, 175, 175}, 
    pattern = LinePattern.Dot, 
    thickness = 0.5));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-140, 
    -100}, {120, 100}}), graphics = {Rectangle(extent = {{-90, 44}, 
    {60, -44}}, lineColor = {255, 0, 0}), Text(
    extent = {{12, 42}, {58, 34}}, 
    textColor = {255, 0, 0}, 
    fillColor = {0, 0, 255}, 
    fillPattern = FillPattern.Solid, 
    textString = "controller")}), 
    experiment(StopTime = 300), 
    Documentation(info = "<html><p style=\"text-align: start;\">长期以来，Modelica 一直用于建模先进的非线性控制系统。特别是，Modelica 允许对非线性逆被控对象模型进行半自动处理。在基础文章（Looye等，2005年，详见<a href=\"modelica://Modelica.Clocked.UsersGuide.Literature\" target=\"\">Literature</a>&nbsp; 或<a href=\"https://www.modelica.org/events/Conference2005/online_proceedings/Session3/Session3c3.pdf\" target=\"\">Download</a>&nbsp;）中，描述了这种方法，并提出了几种控制器结构，旨在利用逆被控对象模型来设计控制器。这种方法非常具有吸引力，因为它为整个操作范围内的被控对象设计控制器提供了系统化的流程。这与标准的控制器设计技术形成了对比，后者通常为一个在特定操作点线性化的被控对象模型设计线性控制器。因此，这些控制器的操作范围固有地有限。
</p>
<p style=\"text-align: start;\">直到 Modelica 3.2 版本，带有逆被控对象模型的控制器只能定义为连续时间系统。通过 Modelica 工具的导出机制，它们可以通过代码嵌入的求解器导出，然后在其他环境中作为采样数据系统使用。然而，无法将采样数据系统重新导入到 Modelica 中。
</p>
<p style=\"text-align: start;\">Modelica 3.3 的同步特性以及 Modelica.Clocked 库现在提供了全新的可能性，使得逆模型可以在 Modelica 和 Modelica 仿真环境中作为采样数据系统进行设计和评估。这个方法通过一个简单的例子展示，使用混合单元的非线性被控对象模型（Föllinger O.（1998）：《Nichtlineare Regelungen I》，Oldenbourg Verlag，第8版，第279页），并根据（Looye 等人，2005）将此被控对象模型作为非线性前馈控制器进行利用：
</p>
<p style=\"text-align: start;\">一种物质 A 持续不断地流入混合反应器。在催化剂的作用下，物质发生反应并分解成几种基础物质，这些基础物质被持续去除。反应产生能量，因此反应器通过冷却介质进行冷却。冷却温度 T_c(t)（单位：K）是主要的驱动信号。物质 A 用其浓度 c(t)（单位：mol/l）和温度 T(t)（单位：K）来描述。浓度 c(t) 是主要需要控制的信号，而温度 T(t) 是被测量的信号。这些方程被集中在输入/输出块 &nbsp;<a href=\"modelica://Modelica.Clocked.Examples.Systems.Utilities.ComponentsMixingUnit.MixingUnit\" target=\"\">Utilities.ComponentsMixingUnit.MixingUnit</a>&nbsp;. 中。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Clocked/Examples/ControlledMixingUnit_PlantModel.png\" alt=\"ControlledMixingUnit_PlantModel.png\" data-href=\"\" style=\"\"/>
</p>
<p>
控制系统的设计现在按以下步骤进行
</p>
<h4><span style=\"color: rgb(51, 51, 51);\"><strong>前置滤波器</strong></span></h4><p>
<span style=\"color: rgb(51, 51, 51);\">反转一个模型通常意味着需要对方程进行符号微分，并且需要输入的高阶导数（这些导数通常是不可用的）。一种方法是对输入信号进行滤波，使得 Modelica 工具可以通过滤波器的状态来计算滤波后输入的导数。所需的最小滤波器阶数是通过首先反转连续时间的被控对象模型，从主要需要控制的变量（这里是“c”）到执行器输入（这里是“T_c”）来确定的。这一过程是通过使用 </span><a href=\"modelica://Modelica.Blocks.Math.InverseBlockConstraints\" target=\"\">Modelica.Blocks.Math.InverseBlockConstraints</a>&nbsp; <span style=\"color: rgb(51, 51, 51);\"> 块来实现的，该块允许在前置滤波器设计模块 </span><a href=\"modelica://Modelica.Clocked.Examples.Systems.Utilities.ComponentsMixingUnit.FilterOrder\" target=\"\">Utilities.ComponentsMixingUnit.FilterOrder</a>&nbsp; &nbsp;<span style=\"color: rgb(51, 51, 51);\">中将外部输入连接到输出。</span>
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Clocked/Examples/ControlledMixingUnit_FilterDesign.png\" alt=\"ControlledMixingUnit_FilterDesign.png\" data-href=\"\" style=\"\"/>
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">翻译这个模型将生成连续时间的逆控制对象模型。然而，Modelica 工具会报错，提示需要对模型进行微分，但这需要外部输入 c_ref 的</span><span style=\"color: rgb(51, 51, 51);\"><strong>二阶导数</strong></span><span style=\"color: rgb(51, 51, 51);\">，而该导数是不可用的。结论是，必须在 c_ref 和 c 之间连接一个至少为二阶的低通滤波器，例如 </span><a href=\"modelica://Modelica.Blocks.Continuous.Filter\" target=\"\">Modelica.Blocks.Continuous.Filter</a>&nbsp;<span style=\"color: rgb(51, 51, 51);\">。应该使用那些在阶跃输入下没有“振荡”特性的滤波器类型。因此，组件的 </span><span style=\"color: rgb(51, 51, 51);\"><strong>analogFilter</strong></span><span style=\"color: rgb(51, 51, 51);\"> 参数应选择为 </span><span style=\"color: rgb(51, 51, 51);\"><strong>CriticalDamping</strong></span><span style=\"color: rgb(51, 51, 51);\">（即只有实数极点）或 </span><span style=\"color: rgb(51, 51, 51);\"><strong>Bessel</strong></span><span style=\"color: rgb(51, 51, 51);\">（即几乎没有振荡，但频率响应比 CriticalDamping 更陡峭）。截止频率 </span><span style=\"color: rgb(51, 51, 51);\"><strong>f_cut</strong></span><span style=\"color: rgb(51, 51, 51);\"> 由闭环系统的仿真手动选择。在这个例子中，使用了一个三阶的 CriticalDamping 滤波器（三阶滤波器用于获得更平滑的信号），并且截止频率为 1/300 Hz。</span>
</p>
<h4><span style=\"color: rgb(51, 51, 51);\"><strong>控制器设计</strong></span></h4><p>
混合装置的控制器如下图所示：
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Clocked/Examples/ControlledMixingUnit_Controller.png\" alt=\"ControlledMixingUnit_Controller.png\" data-href=\"\" style=\"\"/>
</p>
<p style=\"text-align: start;\">它包括上述讨论的滤波器。滤波器的输入是参考浓度，该浓度经过低通滤波器处理。滤波器的输出作为输入传递给逆被控对象模型中的浓度 c。该模型计算所需的冷却温度 T_c（作为控制器输出端的期望冷却温度）和所需温度 T（作为反馈控制器的期望值）。控制系统的这一部分是“前馈”部分，用于计算期望的执行器信号。作为反馈控制器，使用了一个简单的 P 控制器，带有一个增益。
</p>
<p style=\"text-align: start;\">在之前的 Modelica 版本中，控制器可以定义为连续时间系统。然而，在 Modelica 3.3 中，现在也可以将控制器定义为采样数据系统。为此，两个输入（sample1 和 sample2）会被采样，并且执行器的输出会被保持（hold1）。然后，控制器部分与一个周期性时钟（通过 sample2）相关联，时钟的采样周期为 1 秒，并且 solverMethod 设置为 \"ExplicitEuler\"。由于控制器部分是一个连续时间系统，因此它会在每次时钟滴答时被离散化，并使用显式欧拉法进行求解（通过从上一个时刻到当前时刻进行积分）。
</p>
<h4><span style=\"color: rgb(51, 51, 51);\">仿真结果</span></h4><p>
如果使用相同的参数来定义被控对象和逆被控对象模型， 则控制器可以完美工作（完美跟随滤波后的参考浓度）。 即使将反向受控对象模型的所有参数增加50％（除了参数 <strong>e</strong>，因为被控对象对其非常敏感）， 控制行为仍然保持合理，如下两幅图所示：
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Clocked/Examples/ControlledMixingUnit_Result.png\" alt=\"ControlledMixingUnit_Result.png\" data-href=\"\" style=\"\"/>
</p>
<p>
上窗口中的绿色曲线是滤波器的（时钟化）输出，即所需浓度。 上窗口中的红色曲线是mixingUnit模型的浓度，即被控对象中的浓度。 显然，浓度相对合理地跟随所需浓度变化。 通过使用更复杂的反馈控制器，可以显著减少控制误差。
</p>
</html>"));
end ControlledMixingUnit;