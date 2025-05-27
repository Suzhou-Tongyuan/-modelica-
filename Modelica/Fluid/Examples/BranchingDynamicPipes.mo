within Modelica.Fluid.Examples;
model BranchingDynamicPipes 
  "具有动态动量平衡、压力波和流量反向的多路管道连接"
  extends Modelica.Icons.Example;
  replaceable package Medium = Modelica.Media.Air.MoistAir constrainedby 
    Modelica.Media.Interfaces.PartialMedium annotation();
  //replaceable package Medium=Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialMedium;

  inner Modelica.Fluid.System system(energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, 
    momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial) 
    annotation(Placement(transformation(extent = {{-90, 70}, {-70, 90}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(nPorts = 1, 
  redeclare package Medium = Medium, 
    p = 150000) annotation(Placement(
    transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, 
    origin = {0, -80})));
  Pipes.DynamicPipe pipe1(
  redeclare package Medium = Medium, 
    use_T_start = true, 
    nNodes = 5, 
    diameter = 2.54e-2, 
    m_flow_start = 0.02, 
    height_ab = 50, 
    length = 50, 
    p_a_start = 150000, 
    p_b_start = 130000, 
    modelStructure = Modelica.Fluid.Types.ModelStructure.a_v_b) 
    annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, 
    rotation = 90, 
    origin = {0, -50})));
  Pipes.DynamicPipe pipe2(
  redeclare package Medium = Medium, 
    use_T_start = true, 
    nNodes = 5, 
  redeclare model HeatTransfer = 
    Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer, 
    use_HeatTransfer = true, 
    diameter = 2.54e-2, 
    m_flow_start = 0.01, 
    length = 50, 
    height_ab = 25, 
    p_a_start = 130000, 
    p_b_start = 120000, 
    modelStructure = Modelica.Fluid.Types.ModelStructure.av_vb) 
    annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, 
    rotation = 90, 
    origin = {-20, -10})));

  Pipes.DynamicPipe pipe3(
  redeclare package Medium = Medium, 
    use_T_start = true, 
    nNodes = 5, 
    diameter = 2.54e-2, 
    m_flow_start = 0.01, 
    length = 25, 
    height_ab = 25, 
    p_a_start = 130000, 
    p_b_start = 120000, 
    modelStructure = Modelica.Fluid.Types.ModelStructure.a_v_b) 
    annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, 
    rotation = 90, 
    origin = {20, -10})));
  Pipes.DynamicPipe pipe4(
  redeclare package Medium = Medium, 
    use_T_start = true, 
    nNodes = 5, 
    diameter = 2.54e-2, 
    m_flow_start = 0.02, 
    height_ab = 50, 
    length = 50, 
    p_a_start = 120000, 
    p_b_start = 100000, 
    modelStructure = Modelica.Fluid.Types.ModelStructure.a_v_b) 
    annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, 
    rotation = 90, 
    origin = {0, 30})));
  Modelica.Fluid.Sources.Boundary_pT boundary4(nPorts = 1, 
  redeclare package Medium = Medium, 
    use_p_in = true, 
    use_T_in = false, 
    p = 100000) annotation(Placement(
    transformation(extent = {{10, -10}, {-10, 10}}, rotation = 90, 
    origin = {0, 60})));
  Modelica.Blocks.Sources.Ramp ramp1(
    offset = 1e5, 
    startTime = 2, 
    height = 1e5, 
    duration = 0) annotation(Placement(transformation(extent = {{-40, 70}, {-20, 90}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow[pipe2.nNodes] heat2(Q_flow = 200 * 
    pipe2.dxs, alpha = -1e-2 * ones(pipe2.n)) 
    annotation(Placement(transformation(extent = {{-60, -20}, {-40, 0}})));
equation
  connect(ramp1.y, boundary4.p_in) annotation(Line(
    points = {{-19, 80}, {-8, 80}, {-8, 72}}, 
    color = {0, 0, 127}, 
    thickness = 0.5));
  connect(boundary1.ports[1], pipe1.port_a) annotation(Line(
    points = {{0, -70}, {0, -70}, {0, -60}, {0, -60}}, 
    color = {0, 127, 255}, 
    thickness = 0.5));
  connect(pipe1.port_b, pipe2.port_a) annotation(Line(
    points = {{0, -40}, {0, -40}, {0, -30}, {-20, -30}, {-20, -20}}, 
    color = {0, 127, 255}, 
    thickness = 0.5));
  connect(pipe1.port_b, pipe3.port_a) annotation(Line(
    points = {{0, -40}, {0, -40}, {0, -30}, {20, -30}, {20, -20}}, 
    color = {0, 127, 255}, 
    thickness = 0.5));
  connect(pipe2.port_b, pipe4.port_a) annotation(Line(
    points = {{-20, 0}, {-20, 0}, {-20, 10}, {0, 10}, {0, 16}, {0, 20}, {0, 20}}, 
    color = {0, 127, 255}, 
    thickness = 0.5));
  connect(pipe3.port_b, pipe4.port_a) annotation(Line(
    points = {{20, 0}, {20, 0}, {20, 10}, {0, 10}, {0, 16}, {0, 20}, {0, 20}}, 
    color = {0, 127, 255}, 
    thickness = 0.5));
  connect(pipe4.port_b, boundary4.ports[1]) annotation(Line(
    points = {{0, 40}, {0, 50}, {0, 50}}, 
    color = {0, 127, 255}, 
    thickness = 0.5));
  connect(heat2.port, pipe2.heatPorts) 
    annotation(Line(
    points = {{-40, -10}, {-24.4, -10}, {-24.4, -9.9}}, 
    color = {191, 0, 0}, 
    thickness = 0.5));

  annotation(
    Documentation(info = "<html><p>
该模型展示了分布式管道模型在动态能量、质量和动量平衡中的应用。在时间t=2s 时，边界 4 的压力突然升高，导致了压力波的产生和流动方向的反转。
</p>
<p>
将系统对象 \"假设 \"选项卡上的 system.momentumDynamics 从 \"SteadyStateInitial（稳态初始）\"更改为 \"SteadyState（稳态）\"，以假设动量平衡为稳态。
这是该模型库所有模型的默认设置。
</p>
<p>
将介质从潮湿空气（MoistAir）更改为标准水（StandardWater），以研究密度显著不同的介质。请注意由于管道高度差引起的静压头。
</p>
<p>
请注意动态管道(DynamicPipe)模型的modelStructure的适当使用（高级选项卡）。默认的模型结构为 av_vb，即在两个接口都有压力状态的容积。在许多情况下，这种结构具有良好的数值性能，
可以避免连接中的代数环路，例如管道与阀门或配置了 portsData 的容器连接。如果两根管道相连，或者一根管道与具有规定压力的边界相连，会导致高指数微分代数方程。
在这种情况下，可以考虑更改modelStructure。
</p>
<p>
在 BranchingDynamicPipes 示例中，{pipe1,pipe3,pipe4}.modelStructure 被配置为 a_v_b，而 pipe2.modelStructure 仍为 av_vb。
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">这避免了高指数微分代数方程（DAE）和超定初始条件</span>。
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/BranchingDynamicPipes.png\" alt=\"BranchingDynamicPipes.png\" data-href=\"\" style=\"\">
</p>
</html>"), experiment(StopTime = 10), 
    __Dymola_Commands(file(ensureSimulated = true) = 
    "modelica://Modelica/Resources/Scripts/Dymola/Fluid/BranchingDynamicPipes/plotResults.mos" 
    "plotResults"));
end BranchingDynamicPipes;