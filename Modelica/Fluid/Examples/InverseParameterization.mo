within Modelica.Fluid.Examples;
model InverseParameterization 
  "展示了给定额定值下的泵和管道的参数化设置"
  extends Modelica.Icons.Example;

  replaceable package Medium = Modelica.Media.Water.StandardWater annotation();
  //replaceable package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater;

  //parameter Real eps_m_flow_turbulent = 0.0 "湍流 |m_flow| >= eps_m_flow_nominal*m_flow_nominal";
  parameter Real eps_m_flow_turbulent = 0.1 
    "湍流 |m_flow| >= eps_m_flow_nominal*m_flow_nominal";
  //parameter Real eps_m_flow_turbulent = 1 "Turbulent flow |m_flow| >= eps_m_flow_nominal*m_flow_nominal";

  Modelica.Fluid.Sources.Boundary_pT source(
  redeclare package Medium = Medium, 
    nPorts = 1, 
    use_p_in = false, 
    p = 100000) 
    annotation(Placement(transformation(extent = {{-76, 14}, {-64, 26}})));
  Modelica.Fluid.Machines.ControlledPump pump(
    m_flow_nominal = 1, 
    control_m_flow = false, 
    use_p_set = true, 
  redeclare package Medium = Medium, 
    p_a_nominal = 100000, 
    p_b_nominal = 200000) 
    annotation(Placement(transformation(extent = {{-40, 10}, {-20, 30}})));
  Modelica.Fluid.Fittings.SimpleGenericOrifice orifice(
  redeclare package Medium = Medium, 
    diameter = 2.54e-2, 
    use_zeta = false, 
    zeta = 0, 
    dp_nominal = 100000, 
    m_flow_nominal = 1) annotation(Placement(transformation(extent = {{20, 10}, {40, 
    30}})));

  Modelica.Fluid.Sources.Boundary_pT sink(nPorts = 1, redeclare package Medium = Medium, p = 
    100000) 
    annotation(Placement(transformation(extent = {{76, 14}, {64, 26}})));

  inner Modelica.Fluid.System system(m_flow_start = 0.4) 
    annotation(Placement(transformation(extent = {{-90, 50}, {
    -70, 70}})));
  Modelica.Fluid.Pipes.StaticPipe pipe1(
  redeclare package Medium = Medium, 
    flowModel(states(h(each start = 1e5))), 
    diameter = 2.54e-2, 
    length = 0, 
  redeclare model FlowModel = 
    Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalTurbulentPipeFlow(
    show_Res = true, 
    m_flow_nominal = 1, 
    m_flow_turbulent = eps_m_flow_turbulent * 1, 
    dp_nominal = 100000)) 
    annotation(Placement(transformation(extent = {{20, -30}, {40, 
    -10}})));
  Modelica.Fluid.Sources.Boundary_pT sink1(nPorts = 1, 
  redeclare package Medium = Medium, p = 200000) 
    annotation(Placement(transformation(extent = {{76, -26}, {64, -14}})));
  Modelica.Blocks.Sources.Ramp p_set(
    height = 0.2e5, 
    offset = 1.9e5, 
    duration = 8, 
    startTime = 1) 
    annotation(Placement(transformation(extent = {{-50, 40}, {-30, 60}})));
  Modelica.Fluid.Pipes.StaticPipe pipe2(
  redeclare package Medium = Medium, 
    diameter = 2.54e-2, 
    length = 1000, 
  redeclare model FlowModel = 
    Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow(
    show_Res = true, 
    dp_nominal = 100000, 
    m_flow_nominal = 1)) 
    annotation(Placement(transformation(extent = {{20, -70}, {40, 
    -50}})));
  Modelica.Fluid.Sources.Boundary_pT sink2(nPorts = 1, 
  redeclare package Medium = Medium, p = 200000) 
    annotation(Placement(transformation(extent = {{76, -66}, {64, -54}})));
equation
  connect(orifice.port_b, sink.ports[1]) 
    annotation(Line(
    points = {{40, 20}, {64, 20}}, color = {0, 127, 255}));
  connect(source.ports[1], pump.port_a) annotation(Line(
    points = {{-64, 20}, {-40, 20}}, color = {0, 127, 255}));
  connect(pump.port_b, orifice.port_a) 
    annotation(Line(
    points = {{-20, 20}, {20, 20}}, color = {0, 127, 255}));
  connect(pipe1.port_b, sink1.ports[1]) annotation(Line(
    points = {{40, -20}, {64, -20}}, color = {0, 127, 255}));
  connect(pipe1.port_a, pump.port_b) annotation(Line(
    points = {{20, -20}, {0, -20}, {0, 20}, {-20, 20}}, color = {0, 127, 255}));
  connect(p_set.y, pump.p_set) annotation(Line(
    points = {{-29, 50}, {-25, 50}, {-25, 28.2}}, color = {0, 0, 127}));
  connect(pipe2.port_b, sink2.ports[1]) annotation(Line(
    points = {{40, -60}, {64, -60}}, color = {0, 127, 255}));

  connect(pump.port_b, pipe2.port_a) annotation(Line(
    points = {{-20, 20}, {0, 20}, {0, -60}, {20, -60}}, color = {0, 127, 255}));
  annotation(
    __Dymola_Commands(file(ensureSimulated = true) = "modelica://Modelica/Resources/Scripts/Dymola/Fluid/InverseParameterization/plotResults.mos" 
    "plotResults"), 
    experiment(StopTime = 10, Interval = 0.001), 
    Documentation(info = "<html><p>
泵、孔板与两根管道的参数化（基于简单标称值）</span>。说明，管道 1 和管道 2 分别使用标准湍流模型（flowModel NominalTurbulentFlow）
和标准层流模型（flowModel NominalLaminarFlow），不需要指定几何数据。在给定额定压力损失和额定质量流量的情况下，pathLengths_nominal值由内部获得。
</p>
<p>
泵控制着从 1.9 bar 到 2.1 bar 的压力变化。这将导致边界压力为 1 bar 的节流元件质量流量产生适当的梯度。在边界压力为 2 bar 的管道中，流动会发生逆转。
可以使用 plotResults 命令查看泵速 N，理想情况下控制泵速 N 可获得压力梯度。此外，还绘制了满足额定运行条件的内部获得的额定设计值，
雷诺数，m_flows_turbulent 和 dps_fg_turbulent。
</p>
<p>
请注意，pipe2.flowModel.pathLengths_nominal[1] 的大值只有在层流假设下才有意义，而实际管道几乎不存在这种情况。
</p>
<p>
一旦设计出几何结构，就可以很容易地用 TurbulentPipeFlow 或 DetailedPipeFlow 相关性替换 NominalTurbulentPipeFlow 相关性。
同样，也可将受控泵替换为规定泵，以研究实际控制器，或替换为带旋转轴的泵，以研究惯性效应。
</p>
<p>
该模型有一个参数 <strong>eps_m_flow_turbulent</strong>，可用于将流经管道 1 的流体从完全湍流（eps_m_flow_turbulent=0）变为完全层流（eps_m_flow_turbulent&gt;实际流）。
调用 plotResults 可查看 pipe1.port_a.m_flow。将实际流量与 pipe1.flowModel.m_flows_turbulent[1] 联系起来，可以看出对于给定的管道直径，eps_m_flow_turbulent=0.1 是一个合适的选择。
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/InverseParametrization.png\" alt=\"InverseParametrization.png\" data-href=\"\" style=\"\">
</p>
</html>"));
end InverseParameterization;