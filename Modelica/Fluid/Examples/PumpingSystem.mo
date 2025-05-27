within Modelica.Fluid.Examples;
model PumpingSystem "饮用水泵送系统模型"
  extends Modelica.Icons.Example;
  replaceable package Medium = Modelica.Media.Water.StandardWaterOnePhase 
    constrainedby Modelica.Media.Interfaces.PartialMedium annotation();
  //replaceable package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater
  //  constrainedby Modelica.Media.Interfaces.PartialMedium;
  Modelica.Fluid.Sources.FixedBoundary source(
    nPorts = 1, 
    use_T = true, 
    T = Modelica.Units.Conversions.from_degC(20), 
    p = system.p_ambient, 
  redeclare package Medium = Medium) 
    annotation(Placement(transformation(extent = {{-100, -80}, {-80, -60}})));
  Modelica.Fluid.Pipes.StaticPipe pipe(
    allowFlowReversal = true, 
    length = 100, 
    height_ab = 50, 
    diameter = 0.3, 
  redeclare package Medium = Medium) 
    annotation(Placement(transformation(
    origin = {-30, -51}, 
    extent = {{-9, -10}, {11, 10}}, 
    rotation = 90)));
  Machines.PrescribedPump pumps(
    checkValve = true, 
    checkValveHomotopy = Modelica.Fluid.Types.CheckValveHomotopyType.Closed, 
    N_nominal = 1200, 
  redeclare function flowCharacteristic = 
    Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow(
    V_flow_nominal = {0, 0.25, 0.5}, head_nominal = {100, 60, 0}), 
    use_N_in = true, 
    nParallel = 1, 
    energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, 
    V(displayUnit = "l") = 0.05, 
    massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, 
  redeclare package Medium = Medium, 
    p_b_start = 600000, 
    T_start = system.T_start) 
    annotation(Placement(transformation(extent = {{-68, -80}, {-48, -60}})));
  Modelica.Fluid.Vessels.OpenTank reservoir(
    T_start = Modelica.Units.Conversions.from_degC(20), 
    use_portsData = true, 
    crossArea = 50, 
    level_start = 2.2, 
    height = 3, 
    nPorts = 3, 
    portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 0.3), 
    Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 0.3), 
    Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 0.01)}, 
  redeclare package Medium = Medium) 
    annotation(Placement(transformation(extent = {{-20, -16}, {0, 4}})));
  Modelica.Fluid.Valves.ValveLinear userValve(
    allowFlowReversal = false, 
    dp_nominal = 200000, 
    m_flow_nominal = 400, 
  redeclare package Medium = Medium) 
    annotation(Placement(transformation(extent = {{58, -38}, {74, -22}})));
  Modelica.Fluid.Sources.FixedBoundary sink(
    p = system.p_ambient, 
    T = system.T_ambient, 
    nPorts = 2, 
  redeclare package Medium = Medium) 
    annotation(Placement(transformation(extent = {{100, -40}, {80, -20}})));
  Modelica.Blocks.Sources.Step valveOpening(startTime = 200, offset = 1e-6) 
    annotation(Placement(transformation(extent = {{56, 0}, {76, 20}})));
  Modelica.Blocks.Sources.Constant RelativePressureSetPoint(k = 2e4) 
    annotation(Placement(transformation(extent = {{-100, 60}, {-80, 80}})));
  Modelica.Blocks.Logical.OnOffController controller(bandwidth = 4000, 
    pre_y_start = false) 
    annotation(Placement(transformation(extent = {{-40, 60}, {
    -20, 80}})));
  Modelica.Blocks.Logical.TriggeredTrapezoid PumpRPMGenerator(
    rising = 3, 
    falling = 3, 
    amplitude = 1200, 
    offset = 0.001) annotation(Placement(transformation(extent = {{0, 60}, {20, 80}})));
  Modelica.Fluid.Sensors.RelativePressure reservoirPressure(redeclare package Medium = Medium) 
    annotation(Placement(transformation(extent = {{10, -12}, {30, -32}})));
  Modelica.Blocks.Continuous.FirstOrder PT1(
    T = 2, 
    initType = Modelica.Blocks.Types.Init.InitialState, 
    y_start = 0) 
    annotation(Placement(transformation(extent = {{40, 60}, {60, 80}})));
  inner Modelica.Fluid.System system(energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial) 
    annotation(Placement(transformation(extent = 
    {{60, -96}, {80, -76}})));
equation
  connect(userValve.port_b, sink.ports[1]) annotation(Line(points = {{74, -30}, 
    {77, -30}, {77, -28}, {80, -28}}, color = {0, 127, 255}));
  connect(source.ports[1], pumps.port_a) annotation(Line(points = {{-80, -70}, {
    -74, -70}, {-68, -70}}, color = {0, 127, 255}));
  connect(valveOpening.y, userValve.opening) annotation(Line(points = {{77, 10}, {
    98, 10}, {98, -12}, {66, -12}, {66, -23.6}}, color = {0, 0, 127}));
  connect(RelativePressureSetPoint.y, controller.reference) 
    annotation(Line(points = {{
    -79, 70}, {-60, 70}, {-60, 76}, {-42, 76}}, color = {0, 0, 127}));
  connect(controller.y, PumpRPMGenerator.u) 
    annotation(Line(points = {{-19, 70}, {-2, 70}}, color = {255, 0, 255}));
  connect(reservoirPressure.p_rel, controller.u) annotation(Line(points = {{20, 
    -13}, {20, 50}, {-52, 50}, {-52, 64}, {-42, 64}}, color = {0, 0, 127}));
  connect(reservoirPressure.port_b, sink.ports[2]) annotation(Line(
    points = {{30, -22}, {44, -22}, {44, -48}, {80, -48}, {80, -32}}, 
    color = {0, 127, 255}, 
    pattern = LinePattern.Dot));
  connect(PumpRPMGenerator.y, PT1.u) 
    annotation(Line(points = {{21, 70}, {38, 70}}, color = {0, 0, 127}));
  connect(PT1.y, pumps.N_in) annotation(Line(points = {{61, 70}, {74, 70}, {74, 30}, {
    -58, 30}, {-58, -60}}, color = {0, 0, 127}));
  connect(pipe.port_a, pumps.port_b) annotation(Line(points = {{-30, -60}, 
    {-30, -70}, {-48, -70}}, color = {0, 127, 255}));
  connect(reservoir.ports[1], pipe.port_b) annotation(Line(
    points = {{-12.6667, -16}, {-12.6667, -30}, {-30, -30}, {-30, -40}}, color = {0, 127, 255}));
  connect(reservoir.ports[3], reservoirPressure.port_a) annotation(Line(
    points = {{-7.33333, -16}, {-7, -16}, {-7, -22}, {10, -22}}, 
    color = {0, 127, 255}, 
    pattern = LinePattern.Dot));
  connect(reservoir.ports[2], userValve.port_a) annotation(Line(
    points = {{-10, -16}, {-10, -30}, {58, -30}}, color = {0, 127, 255}));
  annotation(
    Documentation(info = "<html><p>
水从水源被泵（安装有止回阀）抽取，经管道输送至比水源高50米的水库。
用户用水需求通过等效阀门模拟，该阀门与水库相连</span>。
</p>
<p>
水控制器是一个简单的开关控制器，根据塔底处测得的表压进行调节；控制器的输出是泵的转速，由一阶系统的输出来表示。
为了避免流特性中的奇异性，使用了一个很小但非零的转速来表示泵的待机状态。
</p>
<p>
当仿真开始时，水位高于设定点，因此泵控制器的初始状态为关闭。启用泵的止回阀。为了便于解决初始化问题，
设置了 <code>homotopyType</code> 参数。
</p>
<p>
仿真时间为2000秒。当时间 t=200 时打开阀门，泵开始启停，以保持水库水位约2米，这大致相当于200 mbar 的表压。
</p>
<p style=\"text-align: center;\">
<img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/PumpingSystem.png\" alt=\"PumpingSystem.png\" data-href=\"\" style=\"\">
</p>
</html>", revisions = "<html>
<ul>
<li><em>Jan 2009</em>
    by R&uuml;diger Franke:<br>
       减小管道和水库口径；使用单独的接口测量水库压力，避免由于压力损失引起的干扰。</li>
<li><em>1 Oct 2007</em>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       更新参数</li>
<li><em>2 Nov 2005</em>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       创建</li>
</ul>
</html>"), 
    experiment(
    StopTime = 2000, 
    Interval = 0.4, 
    Tolerance = 1e-006));
end PumpingSystem;