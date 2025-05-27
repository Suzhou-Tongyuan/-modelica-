within Modelica.Fluid.Examples;
model IncompressibleFluidNetwork 
  "管道多向连接和不可压缩介质模型"
  extends Modelica.Icons.Example;

  parameter Types.ModelStructure pipeModelStructure = Modelica.Fluid.Types.ModelStructure.av_vb "离散管道模型中的模型结构";

  replaceable package Medium = 
    Modelica.Media.Incompressible.Examples.Glycol47 
    constrainedby Modelica.Media.Interfaces.PartialMedium annotation();

  import Modelica.Fluid.Types.Dynamics;
  parameter Dynamics systemMassDynamics = if Medium.singleState then Dynamics.SteadyState else Dynamics.SteadyStateInitial "质量平衡方程";

  Sources.Boundary_pT source(nPorts = 1, 
  redeclare package Medium = Medium, 
    p = 5.0e5, 
    T = 300) annotation(Placement(transformation(extent = {{-98, -6}, {-86, 6}})));
  Pipes.DynamicPipe 
    pipe1(
    use_T_start = true, 
    length = 10, 
    diameter = 2.5e-2, 
  redeclare package Medium = Medium, 
    modelStructure = pipeModelStructure, 
  redeclare model FlowModel = 
    Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow) 
    annotation(Placement(transformation(
    extent = {{-80, -10}, {-60, 10}})));

  Pipes.DynamicPipe pipe2(
    use_T_start = true, 
    diameter = 2.5e-2, 
  redeclare package Medium = Medium, 
    length = 0.5, 
    modelStructure = pipeModelStructure, 
  redeclare model FlowModel = 
    Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow) 
    annotation(Placement(transformation(
    origin = {-50, 20}, 
    extent = {{-10, -10}, {10, 10}}, 
    rotation = 90)));

  Pipes.DynamicPipe pipe3(
    use_T_start = true, 
    diameter = 2.5e-2, 
  redeclare package Medium = Medium, 
    length = 0.5, 
    modelStructure = pipeModelStructure, 
  redeclare model FlowModel = 
    Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow) 
    annotation(Placement(transformation(
    origin = {-50, -20}, 
    extent = {{-10, -10}, {10, 10}}, 
    rotation = 270)));
  Pipes.DynamicPipe pipe4(
    use_T_start = true, 
    diameter = 2.5e-2, 
  redeclare package Medium = Medium, 
    length = 2, 
    modelStructure = pipeModelStructure, 
    use_HeatTransfer = true, 
  redeclare model FlowModel = 
    Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow) 
    annotation(Placement(transformation(
    extent = {{-20, -50}, {0, -30}})));
  Pipes.DynamicPipe pipe6(
    use_T_start = true, 
    diameter = 2.5e-2, 
  redeclare package Medium = Medium, 
    length = 20, 
    modelStructure = pipeModelStructure, 
  redeclare model FlowModel = 
    Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow) 
    annotation(Placement(transformation(
    extent = {{20, -50}, {40, -30}})));
  Valves.ValveIncompressible valve1(
  redeclare package Medium = Medium, 
    m_flow_nominal = 1, 
    rho_nominal = 1000, 
    CvData = Modelica.Fluid.Types.CvTypes.Av, 
    Av = 2.5e-2 ^ 2 / 4 * Modelica.Constants.pi, 
    dp_nominal = 30000) 
    annotation(Placement(transformation(extent = {{-46, 30}, {-26, 50}})));
  Valves.ValveIncompressible valve2(
  redeclare package Medium = Medium, 
    m_flow_nominal = 1, 
    rho_nominal = 1000, 
    CvData = Modelica.Fluid.Types.CvTypes.Av, 
    Av = 2.5e-2 ^ 2 / 4 * Modelica.Constants.pi, 
    dp_nominal = 30000) 
    annotation(Placement(transformation(extent = {{-46, -30}, {-26, -50}})));
  Pipes.DynamicPipe pipe7(
    use_T_start = true, 
    length = 10, 
    diameter = 2.5e-2, 
  redeclare package Medium = Medium, 
    modelStructure = pipeModelStructure, 
    use_HeatTransfer = true, 
  redeclare model FlowModel = 
    Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow) 
    annotation(Placement(transformation(
    extent = {{-20, 30}, {0, 50}})));
  Valves.ValveIncompressible valve3(
  redeclare package Medium = Medium, 
    m_flow_nominal = 1, 
    rho_nominal = 1000, 
    CvData = Modelica.Fluid.Types.CvTypes.Av, 
    Av = 2.5e-2 ^ 2 / 4 * Modelica.Constants.pi, 
    dp_nominal = 30000) 
    annotation(Placement(transformation(extent = {{80, 0}, {100, 20}})));
  Sources.Boundary_pT sink(nPorts = 1, 
  redeclare package Medium = Medium, 
    T = 300, 
    p = 1.0e5) 
    annotation(Placement(transformation(extent = {{118, 4}, {106, 16}})));
  inner Modelica.Fluid.System system(
    massDynamics = systemMassDynamics, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, 
    use_eps_Re = true) annotation(Placement(transformation(extent = {{90, -92}, {
    110, -72}})));
  Modelica.Blocks.Sources.Step valveOpening1(
    offset = 1, 
    startTime = 50, 
    height = -1) annotation(Placement(transformation(extent = {{-80, 80}, {-60, 60}})));
  Modelica.Blocks.Sources.Step valveOpening2(
    offset = 1, 
    height = -0.5, 
    startTime = 100) 
    annotation(Placement(transformation(extent = {{-80, -60}, {-60, 
    -80}})));
  Modelica.Blocks.Sources.Step valveOpening3(
    offset = 1, 
    startTime = 150, 
    height = -0.5) annotation(Placement(transformation(extent = {{60, 80}, {80, 60}})));
  Pipes.DynamicPipe pipe8(
    use_T_start = true, 
    length = 10, 
    diameter = 2.5e-2, 
  redeclare package Medium = Medium, 
    modelStructure = pipeModelStructure, 
    use_HeatTransfer = true, 
  redeclare model FlowModel = 
    Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow) 
    annotation(Placement(transformation(
    origin = {10, 10}, 
    extent = {{-10, 10}, {10, -10}}, 
    rotation = 270)));
  Pipes.DynamicPipe pipe9(
    use_T_start = true, 
    length = 10, 
    diameter = 2.5e-2, 
  redeclare package Medium = Medium, 
    modelStructure = pipeModelStructure, 
    use_HeatTransfer = true, 
  redeclare model FlowModel = 
    Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow) 
    annotation(Placement(transformation(
    extent = {{20, 30}, {40, 50}})));
  Pipes.DynamicPipe pipe10(
    use_T_start = true, 
    length = 10, 
    diameter = 2.5e-2, 
  redeclare package Medium = Medium, 
    modelStructure = pipeModelStructure, 
    use_HeatTransfer = true, 
  redeclare model FlowModel = 
    Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow) 
    annotation(Placement(transformation(
    extent = {{20, -30}, {40, -10}})));
  Pipes.DynamicPipe pipe5(
    use_T_start = true, 
    diameter = 2.5e-2, 
  redeclare package Medium = Medium, 
    length = 20, 
    modelStructure = pipeModelStructure, 
  redeclare model FlowModel = 
    Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow) 
    annotation(Placement(transformation(
    extent = {{20, -70}, {40, -50}})));
  Thermal.HeatTransfer.Sources.FixedHeatFlow[pipe8.nNodes] heat8(Q_flow = 16e3 * 
    pipe8.dxs) 
    annotation(Placement(transformation(extent = {{-20, 0}, {0, 20}})));
  Pipes.DynamicPipe pipe11(
    use_T_start = true, 
    diameter = 2.5e-2, 
  redeclare package Medium = Medium, 
    modelStructure = pipeModelStructure, 
  redeclare model FlowModel = 
    Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow, 
    length = 0.5) annotation(Placement(transformation(
    extent = {{54, 0}, {74, 20}})));
equation
  connect(source.ports[1], pipe1.port_a) annotation(Line(points = {{-86, 0}, {-80, 
    0}}, color = {0, 127, 255}));
  connect(pipe1.port_b, pipe3.port_a) annotation(Line(points = {{-60, 0}, {-50, 0}, 
    {-50, -10}}, color = {0, 127, 255}));
  connect(pipe1.port_b, pipe2.port_a) annotation(Line(points = {{-60, 0}, {-50, 0}, 
    {-50, 10}}, color = {0, 127, 255}));
  connect(pipe2.port_b, valve1.port_a) annotation(Line(points = {{-50, 30}, {-50, 
    40}, {-46, 40}}, color = {0, 127, 255}));
  connect(valve2.port_b, pipe4.port_a) annotation(Line(points = {{-26, -40}, {-26, 
    -40}, {-20, -40}}, color = {0, 127, 255}));
  connect(pipe3.port_b, valve2.port_a) annotation(Line(points = {{-50, -30}, {-50, 
    -40}, {-46, -40}}, color = {0, 127, 255}));
  connect(valve1.port_b, pipe7.port_a) annotation(Line(points = {{-26, 40}, {-26, 
    40}, {-20, 40}}, color = {0, 127, 255}));
  connect(valve3.port_b, sink.ports[1]) annotation(Line(points = {{100, 10}, {100, 
    10}, {106, 10}}, color = {0, 127, 255}));
  connect(valveOpening1.y, valve1.opening) annotation(Line(points = {{-59, 70}, {
    -36, 70}, {-36, 48}}, color = {0, 0, 127}));
  connect(valveOpening2.y, valve2.opening) annotation(Line(points = {{-59, -70}, {
    -36, -70}, {-36, -48}}, color = {0, 0, 127}));
  connect(valveOpening3.y, valve3.opening) annotation(Line(points = {{81, 70}, {90, 
    70}, {90, 18}}, color = {0, 0, 127}));
  connect(pipe7.port_b, pipe9.port_a) 
    annotation(Line(points = {{0, 40}, {0, 40}, {20, 40}}, color = {0, 127, 255}));
  connect(pipe7.port_b, pipe8.port_a) annotation(Line(points = {{0, 40}, {10, 40}, {
    10, 20}}, color = {0, 127, 255}));
  connect(pipe8.port_b, pipe10.port_a) annotation(Line(points = {{10, 0}, {10, -20}, 
    {20, -20}}, color = {0, 127, 255}));
  connect(pipe4.port_b, pipe6.port_a) annotation(Line(
    points = {{0, -40}, {20, -40}}, color = {0, 127, 255}));
  connect(pipe8.port_b, pipe4.port_b) annotation(Line(
    points = {{10, 0}, {10, -40}, {0, -40}}, color = {0, 127, 255}));
  connect(pipe5.port_a, pipe4.port_b) annotation(Line(
    points = {{20, -60}, {10, -60}, {10, -40}, {0, -40}}, color = {0, 127, 255}));
  connect(heat8.port, pipe8.heatPorts) annotation(Line(
    points = {{0, 10}, {6, 10}, {6, 9.9}, {5.6, 9.9}}, color = {191, 0, 0}));
  connect(pipe5.port_b, pipe6.port_b) annotation(Line(
    points = {{40, -60}, {50, -60}, {50, -40}, {40, -40}}, color = {0, 127, 255}));
  connect(pipe6.port_b, pipe10.port_b) annotation(Line(
    points = {{40, -40}, {50, -40}, {50, -20}, {40, -20}}, color = {0, 127, 255}));
  connect(pipe11.port_b, valve3.port_a) annotation(Line(
    points = {{74, 10}, {80, 10}}, color = {0, 127, 255}));
  connect(pipe9.port_b, pipe11.port_a) annotation(Line(
    points = {{40, 40}, {50, 40}, {50, 10}, {54, 10}}, color = {0, 127, 255}));
  connect(pipe10.port_b, pipe11.port_a) annotation(Line(
    points = {{40, -20}, {50, -20}, {50, 10}, {54, 10}}, color = {0, 127, 255}));
  annotation(Documentation(info = "<html><p>
这个例子展示了两个方面：多向连接的处理和不可压缩介质模型的使用。
</p>
<p>
11 个 nNodes=2 的管道模型分别引入了 22 个温度状态和 22 个压力状态。
当配置 <strong>pipeModelStructure =a_v_b</strong> 时，管道接口的流量模型构成了压力的代数循环。
常见的解决方法是在关键连接处引入 \"混合体积\"。
</p>
<p>
<strong>StandardWaterOnePhase</strong>.在这里，
我们使用 <a href=\"modelica://Modelica.Fluid.Pipes.DynamicPipe\" target=\"\">动态管道</a>&nbsp;
模型的默认管道模型结构 <strong>pipeModelStructure=av_vb </strong>来处理这个问题。
每条管道都将外部流动节块的状态显示在各自的流体接口。因此，所有连接管道节块的压力都被归并到整个连接集的质量平衡中。
总体而言，这种高指数微分代数方程处理方法可将压力状态减少到 9 个，从而避免了连接中的代数循环。这可以通过类似的严格介质模型，
如<strong> StandardWaterOnePhase </strong>进行研究。
</p>
<p>
在不可压缩介质模型（如使用的 <strong>Glycol47</strong>）中，压力动态完全消失。在这种情况下，
假设稳态质量平衡似乎是合理的（见 system.massDynamics 中使用的参数 systemMassDynamics，位于假设选项卡）。
</p>
<p>
需要注意的是，在流体接口采用 stream 概念时，尽管压力被叠加在一起，但连接管道节块的能量和物质平衡仍然是相互独立的。模拟结果如下：
</p>
<ol><li>
模拟开始时，所有管道的初始温度均为 system.T_ambient。管道 8 上游或旁路（包括管道 9）的温度接近于源头温度 26.85 摄氏度。
管道 8 下游的温度值较高，这取决于与加热流体的混合情况，参见管道 10。</li>
<li>
50 秒后，1 号阀门完全关闭。这导致管道 8 的流量逆转。现在，加热流体从管道 8 流向管道 9。请注意，由于没有流体流入管道 7，与之相连的管道 7 的温度保持不变。管道 10 的温度降至边界温度。</li>
<li>
100 秒后，阀门 2 关闭一半，从而影响质量流量和温度。</li>
<li>
150 秒后，5 号阀门关闭一半，从而影响质量流量和温度。</li>
</ol><p style=\"text-align: center;\">
相关管道中的流体温度通过热接口显示出来。
<img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/IncompressibleFluidNetwork.png\" alt=\"IncompressibleFluidNetwork.png\" data-href=\"\" style=\"\">
</p>
</html>"), 
    experiment(StopTime = 200), 
    __Dymola_Commands(file = 
    "modelica://Modelica/Resources/Scripts/Dymola/Fluid/IncompressibleFluidNetwork/plotResults.mos" 
    "plotResults"), 
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {120, 
    100}})), 
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {120, 
    100}})));
end IncompressibleFluidNetwork;