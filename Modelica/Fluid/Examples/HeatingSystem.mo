within Modelica.Fluid.Examples;
model HeatingSystem "加热系统的简化模型"
  extends Modelica.Icons.Example;
  replaceable package Medium = 
    Modelica.Media.CompressibleLiquids.LinearWater_pT_Ambient 
    constrainedby Modelica.Media.Interfaces.PartialMedium annotation();
  Modelica.Fluid.Vessels.OpenTank tank(
  redeclare package Medium = Medium, 
    crossArea = 0.01, 
    height = 2, 
    level_start = 1, 
    nPorts = 2, 
    massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, 
    use_HeatTransfer = true, 
    portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 
    0.01), Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 
    0.01)}, 
  redeclare model HeatTransfer = 
    Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.IdealHeatTransfer(k = 10), 
    ports(each p(start = 1.1e5)), 
    T_start = Modelica.Units.Conversions.from_degC(20)) 
    annotation(Placement(transformation(extent = {{-80, 30}, {-60, 50}})));
  Machines.ControlledPump pump(
  redeclare package Medium = Medium, 
    N_nominal = 1500, 
    use_T_start = true, 
    T_start = Modelica.Units.Conversions.from_degC(40), 
    m_flow_start = 0.01, 
    m_flow_nominal = 0.01, 
    control_m_flow = false, 
    allowFlowReversal = false, 
    p_a_start = 110000, 
    p_b_start = 130000, 
    p_a_nominal = 110000, 
    p_b_nominal = 130000) 
    annotation(Placement(transformation(extent = {{-50, 10}, {-30, 30}})));
  Modelica.Fluid.Valves.ValveIncompressible valve(
  redeclare package Medium = Medium, 
    CvData = Modelica.Fluid.Types.CvTypes.OpPoint, 
    port_b(p(start = 1.1e5)), 
    m_flow_nominal = 0.01, 
    show_T = true, 
    allowFlowReversal = false, 
    dp_start = 18000, 
    dp_nominal = 10000) 
    annotation(Placement(transformation(extent = {{60, -80}, {40, -60}})));
protected
  Modelica.Blocks.Interfaces.RealOutput m_flow(unit = "kg/s") 
    annotation(Placement(transformation(extent = {{-6, 34}, {6, 46}})));
public
  Sensors.MassFlowRate sensor_m_flow(redeclare package Medium = Medium) 
    annotation(Placement(transformation(extent = {{-20, 10}, {0, 30}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature T_ambient(T = system.T_ambient) 
    annotation(Placement(transformation(extent = {{-14, -27}, {0, -13}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor wall(G = 1.6e3 / 20) 
    annotation(Placement(transformation(
    origin = {10, -48}, 
    extent = {{8, -10}, {-8, 10}}, 
    rotation = 90)));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow burner(
    Q_flow = 1.6e3, 
    T_ref = 343.15, 
    alpha = -0.5) 
    annotation(Placement(transformation(extent = {{16, 30}, {36, 50}})));
  inner Modelica.Fluid.System system(
    m_flow_small = 1e-4, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial) 
    annotation(Placement(transformation(extent = {{-90, 70}, {
    -70, 90}})));
  Pipes.DynamicPipe heater(
  redeclare package Medium = Medium, 
    use_T_start = true, 
    T_start = Modelica.Units.Conversions.from_degC(80), 
    length = 2, 
  redeclare model HeatTransfer = 
    Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.IdealFlowHeatTransfer, 
    diameter = 0.01, 
    nNodes = 1, 
  redeclare model FlowModel = 
    Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow, 
    use_HeatTransfer = true, 
    modelStructure = Modelica.Fluid.Types.ModelStructure.a_v_b, 
    p_a_start = 130000) 
    annotation(Placement(transformation(extent = {{30, 10}, {50, 30}})));
  Pipes.DynamicPipe radiator(
    use_T_start = true, 
  redeclare package Medium = Medium, 
    port_b(p(start = 1.1e5)), 
    length = 10, 
    T_start = Modelica.Units.Conversions.from_degC(40), 
  redeclare model HeatTransfer = 
    Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.IdealFlowHeatTransfer, 
    diameter = 0.01, 
    nNodes = 1, 
  redeclare model FlowModel = 
    Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow, 
    use_HeatTransfer = true, 
    modelStructure = Modelica.Fluid.Types.ModelStructure.a_v_b, 
    p_a_start = 110000, 
    state_a(p(start = 110000)), 
    state_b(p(start = 110000))) 
    annotation(Placement(transformation(extent = {{20, -80}, {0, -60}})));
protected
  Modelica.Blocks.Interfaces.RealOutput T_forward(unit = "K") 
    annotation(Placement(transformation(extent = {{74, 34}, {86, 46}})));
  Modelica.Blocks.Interfaces.RealOutput T_return(unit = "K") 
    annotation(Placement(transformation(extent = {{-46, -56}, {-58, -44}})));
public
  Modelica.Fluid.Sensors.Temperature sensor_T_forward(redeclare package Medium 
    = Medium) 
    annotation(Placement(transformation(extent = {{50, 30}, {70, 50}})));
  Modelica.Fluid.Sensors.Temperature sensor_T_return(redeclare package Medium 
    = Medium) 
    annotation(Placement(transformation(extent = {{-20, -60}, {-40, -40}})));
protected
  Modelica.Blocks.Interfaces.RealOutput tankLevel(unit = "m") 
    annotation(Placement(transformation(extent = {{-56, 34}, 
    {-44, 46}})));
public
  Modelica.Blocks.Sources.Step handle(
    startTime = 2000, 
    height = 0.9, 
    offset = 0.1) annotation(Placement(transformation(extent = {{26, -27}, {40, -13}})));
  Pipes.DynamicPipe pipe(
  redeclare package Medium = Medium, 
    use_T_start = true, 
    T_start = Modelica.Units.Conversions.from_degC(80), 
  redeclare model HeatTransfer = 
    Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.IdealFlowHeatTransfer, 
    diameter = 0.01, 
  redeclare model FlowModel = 
    Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow, 
    length = 10, 
    p_a_start = 130000) 
    annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, 
    rotation = -90, 
    origin = {80, -20})));
equation
  tankLevel = tank.level;
  connect(sensor_m_flow.m_flow, m_flow) annotation(Line(points = {{-10, 31}, 
    {-10, 40}, {0, 40}}, color = {0, 0, 127}));
  connect(sensor_m_flow.port_b, heater.port_a) 
    annotation(Line(points = {{0, 20}, {0, 
    20}, {30, 20}}, color = {0, 127, 255}));
  connect(T_ambient.port, wall.port_a) annotation(Line(
    points = {{0, -20}, {10, -20}, {10, -40}}, color = {191, 0, 0}));
  connect(sensor_T_forward.T, T_forward) annotation(Line(points = {{67, 40}, {
    80, 40}}, color = {0, 0, 127}));
  connect(radiator.port_a, valve.port_b) annotation(Line(points = {{20, -70}, {20, 
    -70}, {40, -70}}, color = {0, 127, 255}));
  connect(sensor_T_return.port, radiator.port_b) 
    annotation(Line(points = {{-30, -60}, 
    {-30, -70}, {0, -70}}, color = {0, 127, 255}));
  connect(tank.ports[2], pump.port_a) annotation(Line(
    points = {{-68, 30}, {-68, 20}, {-50, 20}}, color = {0, 127, 255}));
  connect(handle.y, valve.opening) annotation(Line(
    points = {{40.7, -20}, {50, -20}, {50, -62}}, color = {0, 0, 127}));
  connect(pump.port_b, sensor_m_flow.port_a) 
    annotation(Line(
    points = {{-30, 20}, {-20, 20}}, color = {0, 127, 255}));
  connect(sensor_T_return.T, T_return) annotation(Line(
    points = {{-37, -50}, {-52, -50}}, color = {0, 0, 127}));
  connect(burner.port, heater.heatPorts[1]) 
    annotation(Line(
    points = {{36, 40}, {40.1, 40}, {40.1, 24.4}}, color = {191, 0, 0}));
  connect(wall.port_b, radiator.heatPorts[1]) annotation(Line(
    points = {{10, -56}, {10, -65.6}, {9.9, -65.6}}, color = {191, 0, 0}));
  connect(sensor_T_forward.port, heater.port_b) 
    annotation(Line(
    points = {{60, 30}, {60, 20}, {50, 20}}, color = {0, 127, 255}));
  connect(heater.port_b, pipe.port_a) annotation(Line(
    points = {{50, 20}, {80, 20}, {80, -10}}, color = {0, 127, 255}));
  connect(pipe.port_b, valve.port_a) annotation(Line(
    points = {{80, -30}, {80, -70}, {60, -70}}, color = {0, 127, 255}));
  connect(radiator.port_b, tank.ports[1]) annotation(Line(
    points = {{0, -70}, {-72, -70}, {-72, 30}}, color = {0, 127, 255}));
  annotation(Documentation(info = 
    "<html><p>
一个带有封闭流动循环的简单加热系统。 在仿真时间为2000秒后，阀门完全打开。
一个简单的理想化控制嵌入到相应的组件中，使得供暖系统可以通过阀门进行调节： 泵控制回路压力，燃烧器控制介质温度。
</p>
<p>
可以根据 <code>system.energyDynamics</code> 的不同设置（请参阅系统对象的 \"假设 \"选项卡）研究温度和流量。
</p>
<ul><li>
当 <code>system.energyDynamics==Types.Dynamics.FixedInitial</code> 时，状态在仿真期间需要找到稳态值。</li>
<li>
当 <code>system.energyDynamics==Types.Dynamics.SteadyStateInitial</code> (默认设置) 时，仿真从稳态开始。</li>
<li>
当 <code>system.energyDynamics==Types.Dynamics.SteadyState</code> 时，除了一个动态状态外的所有动态状态都被消除。
剩余的状态 <code>tank.m</code> 用于解释封闭流动循环。在稳态模拟中，流出量和流入量相等，因此它是恒定的。</li>
</ul><p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">
注意：1）闭式循环系统通常会导致质量流量的循环等式依赖，并使压力无法确定。
因此，将 </span>tank.massDynamics<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">
（即通过水箱液位确定端口压力的参数）局部修改为 </span>Types.Dynamics.FixedInitial<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\"> 
以解决此问题</span>。
</p>
<p>
 <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
 2）水箱与外部环境热隔离，确保在加热系统零流量（如仿真初始阶段 </span>valveOpening.offset=0<span style=\"color: rgba(0, 0, 0, 0.9);
 font-size: 16px;\">）时水箱温度仍可明确求解</span>但是，<span style=\"color: rgba(0, 0, 0, 0.9);
 font-size: 16px;\">管道被假设为完全绝热。若需在阀门全关状态下获取稳态解，需额外定义管道与环境间的热耦合关系</span>。
</p>
<p>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
 3）<span style=\"color: rgba(0, 0, 0, 0.9);
 font-size: 16px;\">加热器与管道间的理想化直连（导致端口压力相等）被视为高指数微分代数方程（DAE）问题，
 而非基于压力损失关联的非线性方程组</span>。<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">
 可额外引入压力损失关联式（如适配不同管径的接头模型）来表征加热器与管道间的连接特性</span>。
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/HeatingSystem.png\" alt=\"HeatingSystem.png\" data-href=\"\" style=\"\">
</p>
</html>"), experiment(StopTime = 6000), 
    __Dymola_Commands(file(ensureSimulated = true) = 
    "modelica://Modelica/Resources/Scripts/Dymola/Fluid/HeatingSystem/plotResults.mos" 
    "plotResults"));
end HeatingSystem;