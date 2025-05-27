within Modelica.Fluid.Examples;
package AST_BatchPlant 
  "多特蒙德大学过程控制实验室 (Engell教授)的试验性批量生产装置模型"
  extends Modelica.Icons.ExamplesPackage;

  model BatchPlant_StandardWater "实验批处理装置"
    extends Modelica.Icons.Example;
    replaceable package BatchMedium = Modelica.Media.Water.StandardWater constrainedby 
      Modelica.Media.Interfaces.PartialTwoPhaseMedium "组件介质" annotation();
    parameter SI.Length pipeDiameter = 0.01 "管道直径";
    BaseClasses.TankWith3InletOutletArraysWithEvaporatorCondensor B5(
    redeclare package Medium = BatchMedium, 
      height = 0.5, 
      n_SidePorts = 1, 
      V0 = 0.001, 
      n_BottomPorts = 1, 
      bottom_pipeArea = {0.0001}, 
      top_pipeArea = {0.0001}, 
      n_TopPorts = 1, 
      min_level_for_heating = 0.0001, 
      level_start = 0.0009, 
      crossArea = 0.05, 
      initType = BaseClasses.Init.InitialValues, 
      side_pipeArea = {0.0001}, 
    redeclare model HeatTransfer = 
      Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.IdealHeatTransfer(k = 
      4.9)) 
      annotation(Placement(transformation(extent = {{-110, -60}, {-30, -20}})));
    Modelica.Fluid.Valves.ValveDiscreteRamp V12(
    redeclare package Medium = BatchMedium, 
      m_flow_nominal = 1, 
      dp_nominal = 100, 
      Topen = 0.1) 
      annotation(Placement(transformation(
      origin = {-90, 2}, 
      extent = {{-10, -10}, {10, 10}}, 
      rotation = 90)));
    Modelica.Fluid.Valves.ValveDiscreteRamp V15(
    redeclare package Medium = BatchMedium, 
      m_flow_nominal = 1, 
      dp_nominal = 100, 
      Topen = 0.1) 
      annotation(Placement(transformation(
      origin = {-90, -82}, 
      extent = {{10, -10}, {-10, 10}}, 
      rotation = 90)));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow HeatB5 
      annotation(Placement(transformation(extent = {{-150, -50}, {-130, -30}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow CoolingB7 
      annotation(Placement(transformation(extent = {{-150, -130}, {-130, -110}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow CoolingB6 
      annotation(Placement(transformation(
      origin = {110, -60}, 
      extent = {{-10, -10}, {10, 10}}, 
      rotation = 180)));

    Modelica.Fluid.Examples.AST_BatchPlant.BaseClasses.Controller controller(
      Transition3(enableTimer = true, waitTime = 60), Transition7(
      condition = true, 
      enableTimer = true, 
      waitTime = 300)) annotation(Placement(transformation(extent = {{60, 38}, 
      {100, 78}})));

    Modelica.Fluid.Valves.ValveDiscreteRamp V11(
    redeclare package Medium = BatchMedium, 
      m_flow_nominal = 1, 
      dp_nominal = 100, 
      Topen = 0.1) 
      annotation(Placement(transformation(extent = {{-50, 80}, {-70, 100}})));
    Modelica.Fluid.Valves.ValveDiscreteRamp V8(
    redeclare package Medium = BatchMedium, 
      m_flow_nominal = 1, 
      dp_nominal = 100, 
      Topen = 0.1) 
      annotation(Placement(transformation(
      origin = {-90, 160}, 
      extent = {{10, -10}, {-10, 10}}, 
      rotation = 90)));
    Modelica.Fluid.Valves.ValveDiscreteRamp V9(
    redeclare package Medium = BatchMedium, 
      m_flow_nominal = 1, 
      dp_nominal = 100, 
      Topen = 0.1) 
      annotation(Placement(transformation(
      origin = {70, 160}, 
      extent = {{10, 10}, {-10, -10}}, 
      rotation = 90)));
    Modelica.Fluid.Valves.ValveDiscreteRamp V2(
    redeclare package Medium = BatchMedium, 
      m_flow_nominal = 1, 
      dp_nominal = 100, 
      Topen = 0.1) 
      annotation(Placement(transformation(extent = {{-60, 230}, {-40, 250}})));
    Modelica.Fluid.Valves.ValveDiscreteRamp V4(
    redeclare package Medium = BatchMedium, 
      m_flow_nominal = 1, 
      dp_nominal = 100, 
      Topen = 0.1) 
      annotation(Placement(transformation(extent = {{40, 230}, {20, 250}})));
    Modelica.Fluid.Valves.ValveDiscreteRamp V3(
    redeclare package Medium = BatchMedium, 
      m_flow_nominal = 1, 
      dp_nominal = 100, 
      Topen = 0.1) 
      annotation(Placement(transformation(extent = {{-150, 210}, {-130, 230}})));
    Fittings.TeeJunctionIdeal volume2(
    redeclare package Medium = BatchMedium) 
      annotation(Placement(transformation(
      origin = {-180, 220}, 
      extent = {{-10, 10}, {10, -10}}, 
      rotation = 90)));
    Modelica.Fluid.Valves.ValveDiscreteRamp V6(
    redeclare package Medium = BatchMedium, 
      m_flow_nominal = 1, 
      dp_nominal = 100, 
      Topen = 0.1) 
      annotation(Placement(transformation(extent = {{130, 210}, {110, 230}})));
    Fittings.TeeJunctionIdeal volume8(
    redeclare package Medium = BatchMedium) 
      annotation(Placement(transformation(
      origin = {160, 220}, 
      extent = {{-10, -10}, {10, 10}}, 
      rotation = 90)));
    Modelica.Fluid.Valves.ValveDiscreteRamp V23(
    redeclare package Medium = BatchMedium, 
      m_flow_nominal = 1, 
      dp_nominal = 100, 
      Topen = 0.1) 
      annotation(Placement(transformation(
      origin = {-110, -250}, 
      extent = {{-10, 10}, {10, -10}}, 
      rotation = 180)));
    Modelica.Fluid.Valves.ValveDiscreteRamp V1(
    redeclare package Medium = BatchMedium, 
      m_flow_nominal = 0.1, 
      dp_nominal = 1000, 
      Topen = 0.1) 
      annotation(Placement(transformation(
      origin = {-180, 110}, 
      extent = {{-10, 10}, {10, -10}}, 
      rotation = 90)));
    Modelica.Fluid.Valves.ValveDiscreteRamp V22(
    redeclare package Medium = BatchMedium, 
      m_flow_nominal = 0.1, 
      dp_nominal = 1000, 
      Topen = 0.1) 
      annotation(Placement(transformation(
      origin = {-180, -170}, 
      extent = {{-10, 10}, {10, -10}}, 
      rotation = 90)));
    Modelica.Fluid.Valves.ValveDiscreteRamp V5(
    redeclare package Medium = BatchMedium, 
      m_flow_nominal = 0.1, 
      dp_nominal = 1000, 
      Topen = 0.1) 
      annotation(Placement(transformation(
      origin = {160, 110}, 
      extent = {{10, -10}, {-10, 10}}, 
      rotation = 270)));
    Modelica.Fluid.Valves.ValveDiscreteRamp V24(
    redeclare package Medium = BatchMedium, 
      m_flow_nominal = 1, 
      dp_nominal = 100, 
      Topen = 0.1) 
      annotation(Placement(transformation(
      origin = {90, -250}, 
      extent = {{10, 10}, {-10, -10}}, 
      rotation = 180)));
    Modelica.Fluid.Valves.ValveDiscreteRamp V25(
    redeclare package Medium = BatchMedium, 
      m_flow_nominal = 0.1, 
      dp_nominal = 1000, 
      Topen = 0.1) 
      annotation(Placement(transformation(
      origin = {160, -170}, 
      extent = {{10, -10}, {-10, 10}}, 
      rotation = 270)));
    Modelica.Fluid.Valves.ValveDiscreteRamp V20(
    redeclare package Medium = BatchMedium, 
      m_flow_nominal = 1, 
      dp_nominal = 100, 
      Topen = 0.1) 
      annotation(Placement(transformation(
      origin = {60, -210}, 
      extent = {{10, 10}, {-10, -10}}, 
      rotation = 90)));
    Modelica.Fluid.Valves.ValveDiscreteRamp V19(
    redeclare package Medium = BatchMedium, 
      m_flow_nominal = 1, 
      dp_nominal = 100, 
      Topen = 0.1) 
      annotation(Placement(transformation(
      origin = {10, -200}, 
      extent = {{-10, 10}, {10, -10}}, 
      rotation = 180)));
    Modelica.Fluid.Valves.ValveDiscreteRamp V10(
    redeclare package Medium = BatchMedium, 
      m_flow_nominal = 1, 
      dp_nominal = 100, 
      Topen = 0.1) 
      annotation(Placement(transformation(
      origin = {-21, -170}, 
      extent = {{10, 10}, {-10, -10}}, 
      rotation = 90)));
    Modelica.Fluid.Valves.ValveDiscreteRamp V21(
    redeclare package Medium = BatchMedium, 
      m_flow_nominal = 1, 
      dp_nominal = 100, 
      Topen = 0.1) 
      annotation(Placement(transformation(
      origin = {30, -250}, 
      extent = {{10, 10}, {-10, -10}}, 
      rotation = 180)));
    Modelica.Fluid.Fittings.TeeJunctionVolume volume5(
    redeclare package Medium = BatchMedium, 
      V = 0.001) annotation(Placement(transformation(extent = {{50, -260}, {70, -240}})));
    Modelica.Fluid.Valves.ValveDiscreteRamp V18(
    redeclare package Medium = BatchMedium, 
      m_flow_nominal = 1, 
      dp_nominal = 100, 
      Topen = 0.1) 
      annotation(Placement(transformation(
      origin = {-50, -200}, 
      extent = {{10, 10}, {-10, -10}}, 
      rotation = 180)));
    Machines.PrescribedPump P1(
    redeclare package Medium = BatchMedium, 
      m_flow_start = 0.1, 
      N_nominal = 200, 
      use_N_in = true, 
    redeclare model Monitoring = 
      Modelica.Fluid.Machines.BaseClasses.PumpMonitoring.PumpMonitoringNPSH, 
      V(displayUnit = "ml") = 0.0001, 
      energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, 
      massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, 
    redeclare function flowCharacteristic = 
      Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow
      (V_flow_nominal = {0, 0.1e-3, 0.15e-3}, head_nominal = {10, 5, 0}), 
      p_a_start = 100000, 
      p_b_start = 100000) 
      annotation(Placement(transformation(extent = {{-140, -260}, {-160, -240}})));
    Machines.PrescribedPump P2(
    redeclare package Medium = BatchMedium, 
      m_flow_start = 0.1, 
      N_nominal = 200, 
      use_N_in = true, 
    redeclare model Monitoring = 
      Modelica.Fluid.Machines.BaseClasses.PumpMonitoring.PumpMonitoringNPSH, 
      V(displayUnit = "ml") = 0.0001, 
      energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, 
      massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, 
    redeclare function flowCharacteristic = 
      Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow
      (V_flow_nominal = {0, 0.1e-3, 0.15e-3}, head_nominal = {10, 5, 0}), 
      p_a_start = 100000, 
      p_b_start = 100000) 
      annotation(Placement(transformation(extent = {{120, -260}, {140, -240}})));
    Modelica.Fluid.Examples.AST_BatchPlant.BaseClasses.TankWithTopPorts B1(
      level_start = 0.2, 
    redeclare package Medium = BatchMedium, 
      height = 0.5, 
      crossArea = 0.05, 
      V0 = 0.0001, 
      nTopPorts = 1, 
      nPorts = 1, 
      portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
      diameter = 0.011, 
      height = 0)}, 
      stiffCharacteristicForEmptyPort = false) 
      annotation(Placement(transformation(extent = {{-110, 180}, 
      {-70, 220}})));
    inner Modelica.Fluid.System system(energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, dp_small = 1000) 
      annotation(Placement(transformation(extent = {{180, 250}, 
      {200, 270}})));
    Modelica.Blocks.Logical.TriggeredTrapezoid P1_on(rising = 0.3, 
      amplitude = 200) 
      annotation(Placement(transformation(extent = {{-122, -230}, {-142, -210}})));
    Modelica.Blocks.Logical.TriggeredTrapezoid P2_on(rising = 0.3, 
      amplitude = 200) 
      annotation(Placement(transformation(extent = {{100, -230}, {120, -210}})));
    Modelica.Fluid.Examples.AST_BatchPlant.BaseClasses.TankWithTopPorts B2(
      level_start = 0.2, 
    redeclare package Medium = BatchMedium, 
      height = 0.5, 
      crossArea = 0.05, 
      V0 = 0.0001, 
      nTopPorts = 1, 
      nPorts = 1, 
      portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
      diameter = 0.011, 
      height = 0)}, 
      stiffCharacteristicForEmptyPort = false) 
      annotation(Placement(transformation(extent = {{50, 180}, 
      {90, 220}})));
    Modelica.Fluid.Examples.AST_BatchPlant.BaseClasses.TankWithTopPorts B3(
    redeclare package Medium = BatchMedium, 
      height = 0.5, 
      crossArea = 0.05, 
      V0 = 0.0001, 
      nTopPorts = 2, 
      nPorts = 2, 
      portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
      diameter = 0.011, 
      height = 0), Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 
      0.011, height = 0)}, 
      level_start = 0.02, 
      stiffCharacteristicForEmptyPort = false) 
      annotation(Placement(transformation(extent = {{-30, 100}, 
      {10, 140}})));
    Modelica.Fluid.Examples.AST_BatchPlant.BaseClasses.TankWithTopPorts B4(
    redeclare package Medium = BatchMedium, 
      height = 0.5, 
      crossArea = 0.05, 
      V0 = 0.0001, 
      level_start = 0.015, 
      nTopPorts = 1, 
      nPorts = 1, 
      portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
      diameter = 0.011, 
      height = 0)}, 
      stiffCharacteristicForEmptyPort = false) 
      annotation(Placement(transformation(extent = {{-110, 30}, 
      {-70, 70}})));
    Modelica.Fluid.Examples.AST_BatchPlant.BaseClasses.TankWithTopPorts B7(
    redeclare package Medium = BatchMedium, 
      V0 = 0.0001, 
      nTopPorts = 1, 
      nPorts = 1, 
      portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
      diameter = 0.011, 
      height = 0)}, 
      level_start = 0.009, 
      height = 0.5, 
      crossArea = 0.05, 
      stiffCharacteristicForEmptyPort = false, 
      use_HeatTransfer = true, 
      T_start = 298, 
    redeclare model HeatTransfer = 
      Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.IdealHeatTransfer(k = 
      4.9)) annotation(Placement(transformation(extent = {{-110, 
      -140}, {-70, -100}})));
    Pipes.DynamicPipe pipeB1B2(
    redeclare package Medium = BatchMedium, 
      length = 1, 
      diameter = pipeDiameter, 
      height_ab = 0) annotation(Placement(transformation(extent = {{0, 230}, {-20, 
      250}})));
    Pipes.StaticPipe pipeB1B3(
    redeclare package Medium = BatchMedium, 
      length = 1, 
    redeclare model FlowModel = 
      Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow, 
      diameter = pipeDiameter, 
      height_ab = -0.1) 
      annotation(Placement(transformation(extent = {{-70, 134}, {-50, 154}})));
    Pipes.StaticPipe pipeB2B3(
    redeclare package Medium = BatchMedium, 
      length = 1, 
    redeclare model FlowModel = 
      Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow, 
      diameter = pipeDiameter, 
      height_ab = -0.1) 
      annotation(Placement(transformation(extent = {{50, 134}, {30, 154}})));
    Pipes.StaticPipe pipeB1B1(
    redeclare package Medium = BatchMedium, 
      diameter = pipeDiameter, 
      length = 1, 
      height_ab = -0.5) 
      annotation(Placement(transformation(
      origin = {-8, 10}, 
      extent = {{10, 10}, {-10, -10}}, 
      rotation = 90)));
    Pipes.StaticPipe pipeB6Pump(
    redeclare package Medium = BatchMedium, 
      length = 0.5, 
      diameter = pipeDiameter, 
      height_ab = -0.5) 
      annotation(Placement(transformation(
      origin = {60, -110}, 
      extent = {{10, 10}, {-10, -10}}, 
      rotation = 90)));
    Pipes.StaticPipe pipeB7Pump(
    redeclare package Medium = BatchMedium, 
      length = 1, 
      diameter = pipeDiameter, 
      height_ab = -0.1) 
      annotation(Placement(transformation(
      origin = {-90, -170}, 
      extent = {{10, 10}, {-10, -10}}, 
      rotation = 90)));
    Pipes.DynamicPipe pipePump1B1(
    redeclare package Medium = BatchMedium, 
      diameter = pipeDiameter, 
      height_ab = 3, 
      length = 3) annotation(Placement(transformation(
      origin = {-180, 10}, 
      extent = {{-10, 10}, {10, -10}}, 
      rotation = 90)));
    Pipes.DynamicPipe pipePump2B2(
    redeclare package Medium = BatchMedium, 
      diameter = pipeDiameter, 
      height_ab = 3, 
      length = 3) annotation(Placement(transformation(
      origin = {160, 10}, 
      extent = {{-10, 10}, {10, -10}}, 
      rotation = 90)));
    Modelica.Fluid.Examples.AST_BatchPlant.BaseClasses.TankWithTopPorts B6(
    redeclare package Medium = BatchMedium, 
      V0 = 0.0001, 
      nTopPorts = 1, 
      height = 0.5, 
      crossArea = 0.05, 
      level_start = 0.02, 
      nPorts = 1, 
      portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
      diameter = 0.011, 
      height = 0)}, 
      stiffCharacteristicForEmptyPort = false, 
      use_HeatTransfer = true, 
      T_start = 298, 
    redeclare model HeatTransfer = 
      Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.IdealHeatTransfer(k = 
      4.9)) annotation(Placement(transformation(extent = {{80, -80}, 
      {40, -40}})));
    Fittings.MultiPort multiPort(redeclare package Medium = BatchMedium, 
      nPorts_b = 3) annotation(Placement(transformation(
      extent = {{4, 10}, {-4, -10}}, 
      rotation = -90, 
      origin = {-20, -228})));
    Modelica.Fluid.Fittings.TeeJunctionVolume volume4(
    redeclare package Medium = BatchMedium, 
      V = 0.001) annotation(Placement(transformation(extent = {{-30, -260}, {-10, 
      -240}})));
  equation
    controller.sensors.LIS_301 = B3.level;
    controller.sensors.QI_302 = 0;  //B3.medium.X[2];
    controller.sensors.LIS_501 = B5.level;
    controller.sensors.QIS_502 = 0;  //B5.medium.X[2];
    controller.sensors.TI_503 = B5.medium.T;
    controller.sensors.LIS_601 = B6.level;
    controller.sensors.TIS_602 = B6.medium.T;
    controller.sensors.LIS_701 = B7.level;
    controller.sensors.TIS_702 = B7.medium.T;

    P1_on.u = controller.actuators.P1;
    P2_on.u = controller.actuators.P2;
    V1.open = controller.actuators.V1;
    V2.open = controller.actuators.V2;
    V3.open = controller.actuators.V3;
    V4.open = controller.actuators.V4;
    V5.open = controller.actuators.V5;
    V6.open = controller.actuators.V6;
    V8.open = controller.actuators.V8;
    V9.open = controller.actuators.V9;
    V10.open = controller.actuators.V10;
    V11.open = controller.actuators.V11;
    V12.open = controller.actuators.V12;
    V15.open = controller.actuators.V15;
    V18.open = controller.actuators.V18;
    V19.open = controller.actuators.V19;
    V20.open = controller.actuators.V20;
    V21.open = controller.actuators.V21;
    V22.open = controller.actuators.V22;
    V23.open = controller.actuators.V23;
    V24.open = controller.actuators.V24;
    V25.open = controller.actuators.V25;
    HeatB5.Q_flow = if controller.actuators.T5_Heater then 20000 else 0;
    CoolingB6.Q_flow = if controller.actuators.T6_Cooling then -2000 else 0;
    CoolingB7.Q_flow = if controller.actuators.T7_Cooling then -2000 else 0;

    connect(V24.port_b, P2.port_a) annotation(Line(points = {{100, -250}, {120, 
      -250}}, color = {0, 127, 255}));
    connect(V15.port_a, B5.BottomFluidPort[1]) annotation(Line(points = {{-90, -72}, 
      {-90, -60.4}}, color = {0, 127, 255}));
    connect(P1_on.y, P1.N_in) annotation(Line(points = {{-143, -220}, {-150, -220}, 
      {-150, -240}}, color = {0, 0, 127}));
    connect(P2_on.y, P2.N_in) annotation(Line(points = {{121, -220}, {130, -220}, {
      130, -240}}, color = {0, 0, 127}));
    connect(B4.ports[1], V12.port_b) annotation(Line(points = {{-90, 29}, {-90, 21}, 
      {-90, 12}}, color = {0, 127, 255}));
    connect(CoolingB7.port, B7.heatPort) annotation(Line(points = {{-130, -120}, {
      -110, -120}}, color = {191, 0, 0}));
    connect(pipeB1B2.port_a, V4.port_b) annotation(Line(points = {{0, 240}, {20, 
      240}}, color = {0, 127, 255}));
    connect(B5.TopFluidPort[1], V12.port_a) annotation(Line(points = {{-90, -19.6}, 
      {-90, -8}}, color = {0, 0, 255}));
    connect(V15.port_b, B7.topPorts[1]) annotation(Line(points = {{-90, -92}, {
      -90, -96}, {-90, -99}, {-90, -99}}, color = {0, 127, 255}));
    connect(pipePump1B1.port_a, V22.port_b) annotation(Line(points = {{-180, 0}, {
      -180, -160}}, color = {0, 127, 255}));
    connect(V25.port_b, pipePump2B2.port_a) annotation(Line(points = {{160, -160}, 
      {160, 0}}, color = {0, 127, 255}));
    connect(B6.topPorts[1], B5.Condensed) annotation(Line(points = {{60, -39}, {60, 
      -28}, {-29.6, -28}}, color = {0, 127, 255}));
    connect(CoolingB6.port, B6.heatPort) annotation(Line(points = {{100, -60}, {80, 
      -60}}, color = {191, 0, 0}));
    connect(HeatB5.port, B5.heatPort) annotation(Line(points = {{-130, -40}, {-110, 
      -40}}, color = {191, 0, 0}));
    connect(V1.port_b, volume2.port_1) annotation(Line(
      points = {{-180, 120}, {-180, 210}}, color = {0, 127, 255}));
    connect(volume8.port_2, V4.port_a) annotation(Line(
      points = {{160, 230}, {160, 240}, {40, 240}}, color = {0, 127, 255}));
    connect(volume8.port_1, V5.port_b) annotation(Line(
      points = {{160, 210}, {160, 120}}, color = {0, 127, 255}));
    connect(volume5.port_1, V21.port_b) annotation(Line(
      points = {{50, -250}, {40, -250}}, color = {0, 127, 255}));
    connect(volume5.port_2, V24.port_a) annotation(Line(
      points = {{70, -250}, {80, -250}}, color = {0, 127, 255}));
    connect(P2.port_b, V25.port_a) annotation(Line(
      points = {{140, -250}, {160, -250}, {160, -180}}, color = {0, 127, 255}));
    connect(V22.port_a, P1.port_b) annotation(Line(
      points = {{-180, -180}, {-180, -250}, {-160, -250}}, color = {0, 127, 255}));
    connect(V5.port_a, pipePump2B2.port_b) annotation(Line(
      points = {{160, 100}, {160, 20}}, color = {0, 127, 255}));
    connect(V1.port_a, pipePump1B1.port_b) annotation(Line(
      points = {{-180, 100}, {-180, 20}}, color = {0, 127, 255}));
    connect(P1.port_a, V23.port_b) annotation(Line(
      points = {{-140, -250}, {-120, -250}}, color = {0, 127, 255}));
    connect(V23.port_a, volume4.port_1) annotation(Line(
      points = {{-100, -250}, {-30, -250}}, color = {0, 127, 255}));
    connect(volume4.port_2, V21.port_a) annotation(Line(
      points = {{-10, -250}, {20, -250}}, color = {0, 127, 255}));
    connect(multiPort.port_a, volume4.port_3) annotation(Line(
      points = {{-20, -232}, {-20, -240}}, color = {0, 127, 255}));
    connect(multiPort.ports_b[3], V19.port_b) annotation(Line(
      points = {{-17.3333, -224}, {-17.3333, -200}, {0, -200}}, color = {0, 127, 255}));
    connect(V18.port_b, multiPort.ports_b[1]) annotation(Line(
      points = {{-40, -200}, {-22.6667, -200}, {-22.6667, -224}}, color = {0, 127, 255}));
    connect(V10.port_b, multiPort.ports_b[2]) annotation(Line(
      points = {{-21, -180}, {-20, -180}, {-20, -224}}, color = {0, 127, 255}));
    connect(V11.port_b, B4.topPorts[1]) annotation(Line(
      points = {{-70, 90}, {-90, 90}, {-90, 71}}, color = {0, 127, 255}));
    connect(B3.ports[1], V11.port_a) annotation(Line(
      points = {{-12, 99}, {-12, 90}, {-50, 90}}, color = {0, 127, 255}));
    connect(V20.port_b, volume5.port_3) annotation(Line(
      points = {{60, -220}, {60, -240}}, color = {0, 127, 255}));
    connect(V2.port_b, pipeB1B2.port_b) annotation(Line(
      points = {{-40, 240}, {-20, 240}}, color = {0, 127, 255}));
    connect(volume2.port_2, V2.port_a) annotation(Line(
      points = {{-180, 230}, {-180, 240}, {-60, 240}}, color = {0, 127, 255}));
    connect(volume2.port_3, V3.port_a) annotation(Line(
      points = {{-170, 220}, {-150, 220}}, color = {0, 127, 255}));
    connect(V3.port_b, B1.topPorts[1]) annotation(Line(
      points = {{-130, 220}, {-120, 220}, {-120, 230}, {-90, 230}, {-90, 221}}, color = {0, 127, 255}));
    connect(volume8.port_3, V6.port_a) annotation(Line(
      points = {{150, 220}, {130, 220}}, color = {0, 127, 255}));
    connect(V6.port_b, B2.topPorts[1]) annotation(Line(
      points = {{110, 220}, {100, 220}, {100, 230}, {70, 230}, {70, 221}}, color = {0, 127, 255}));
    connect(B2.ports[1], V9.port_a) annotation(Line(
      points = {{70, 179}, {70, 175}, {70, 175}, {70, 170}}, color = {0, 127, 255}));
    connect(V9.port_b, pipeB2B3.port_a) annotation(Line(
      points = {{70, 150}, {70, 144}, {50, 144}}, color = {0, 127, 255}));
    connect(pipeB2B3.port_b, B3.topPorts[2]) annotation(Line(
      points = {{30, 144}, {-8, 144}, {-8, 141}, {-8, 141}}, color = {0, 127, 255}));
    connect(B1.ports[1], V8.port_a) annotation(Line(
      points = {{-90, 179}, {-90, 175}, {-90, 175}, {-90, 170}}, color = {0, 127, 255}));
    connect(V8.port_b, pipeB1B3.port_a) annotation(Line(
      points = {{-90, 150}, {-90, 144}, {-70, 144}}, color = {0, 127, 255}));
    connect(B3.topPorts[1], pipeB1B3.port_b) annotation(Line(
      points = {{-12, 141}, {-12, 141}, {-12, 144}, {-50, 144}}, color = {0, 127, 255}));
    connect(B7.ports[1], pipeB7Pump.port_a) annotation(Line(
      points = {{-90, -141}, {-90, -150}, {-90, -150}, {-90, -160}}, color = {0, 127, 255}));
    connect(pipeB7Pump.port_b, V18.port_a) annotation(Line(
      points = {{-90, -180}, {-90, -200}, {-60, -200}}, color = {0, 127, 255}));
    connect(B6.ports[1], pipeB6Pump.port_a) annotation(Line(
      points = {{60, -81}, {60, -90}, {60, -90}, {60, -100}}, color = {0, 127, 255}));
    connect(pipeB6Pump.port_b, V20.port_a) annotation(Line(
      points = {{60, -120}, {60, -200}}, color = {0, 127, 255}));
    connect(V19.port_a, pipeB6Pump.port_b) annotation(Line(
      points = {{20, -200}, {30, -200}, {30, -160}, {60, -160}, {60, -120}}, color = {0, 127, 255}));
    connect(pipeB1B1.port_b, V10.port_a) annotation(Line(
      points = {{-8, 0}, {-8, -80}, {-21, -80}, {-21, -160}}, color = {0, 127, 255}));
    connect(B3.ports[2], pipeB1B1.port_a) annotation(Line(
      points = {{-8, 99}, {-8, 20}, {-8, 20}}, color = {0, 127, 255}));
    annotation(experiment(StopTime = 3600, Interval = 1), 
      __Dymola_Commands(file = 
      "modelica://Modelica/Resources/Scripts/Dymola/Fluid/AST_BatchPlant_StandardWater/plot level.mos" 
      "plot level"), 
      Documentation(info = "<html><p>
该示例的文档可在<a href=\"modelica://Modelica.Fluid.Examples.AST_BatchPlant\" target=\"\">附带软件库</a>&nbsp;中找到。
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/AST_BatchPlant/BatchPlant_StandardWater.png\" alt=\"BatchPlant_StandardWater.png\" data-href=\"\" style=\"\">
</p>
</html>"  ), 
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-200, -280}, {200, 
      280}})));
  end BatchPlant_StandardWater;

  package BaseClasses
    extends Modelica.Icons.BasesPackage;

    block setReal "将输出信号设置为时变实数表达式"

      Modelica.Blocks.Interfaces.RealInput u "设置实数输入值" 
        annotation(Dialog(group = 
        "时变输入信号"), Placement(transformation(extent = {{
        -140, -20}, {-100, 20}})));

      annotation(
        Icon(coordinateSystem(
        preserveAspectRatio = false, 
        extent = {{-100, -100}, {100, 100}}), graphics = {
        Rectangle(
        extent = {{-100, 40}, {100, -40}}, 
        fillColor = {235, 235, 235}, 
        fillPattern = FillPattern.Solid, 
        borderPattern = BorderPattern.Raised), 
        Text(
        extent = {{-96, 15}, {96, -15}}, 
        textString = "%u"), 
        Text(extent = {{-150, 90}, {140, 50}}, textString = "%name")}), 
        Documentation(info = "<html>

</html>"    ));

    end setReal;

    model TankWith3InletOutletArraysWithEvaporatorCondensor 
      "带加热和蒸发功能的水箱"
      import Modelica.Fluid.Examples.AST_BatchPlant.BaseClasses.Init;
      replaceable package Medium = Modelica.Media.Water.WaterIF97_ph 
        constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium 
        "组件中的介质" 
        annotation(choicesAllMatching = true);
      // 水箱参数
      parameter SI.Area crossArea "水箱面积";
      parameter SI.Area top_pipeArea[n_TopPorts] "出水管面积";
      parameter SI.Area side_pipeArea[n_SidePorts] "出水管面积";
      parameter SI.Area bottom_pipeArea[n_BottomPorts] "出水管面积";
      parameter SI.Height height = 10 "水箱高度";
      parameter SI.Volume V0 = 0 "液位为零时的液体容积";
      constant SI.Acceleration g = Modelica.Constants.g_n;
      parameter SI.Height side_heights[n_SidePorts] = zeros(n_SidePorts) "侧边高度";
      parameter SI.Height bottom_heights[n_BottomPorts] = zeros(n_BottomPorts) "底部高度";
      parameter SI.Height top_heights[n_TopPorts] = fill(height, n_TopPorts) "顶部高度";
      parameter SI.Height level_start "初始水箱液位" 
        annotation(Dialog(tab = "初始化"));
      parameter Modelica.Fluid.Examples.AST_BatchPlant.BaseClasses.Init 
        initType = Init.GuessValues 
        "初始化选项" 
        annotation(Dialog(tab = "初始化"));
      parameter Boolean use_T_start = true 
        "true：使用 T_start，否则 h_start" annotation(Dialog(tab = "初始化"), Evaluate = true);
      parameter Medium.Temperature T_start = if use_T_start then 293.15 else 
        Medium.temperature_phX(p_ambient, h_start, X_start) 
        "温度初值" 
        annotation(Dialog(tab = "初始化", enable = use_T_start));
      parameter Medium.SpecificEnthalpy h_start = if use_T_start then Medium.specificEnthalpy_pTX(
        p_ambient, T_start, X_start[1:Medium.nXi]) else 1e4 
        "比焓初值" 
        annotation(Dialog(tab = "初始化", enable = not use_T_start));
      parameter Medium.MassFraction X_start[Medium.nX] = Medium.reference_X 
        "质量分数m_i/m的初值" 
        annotation(Dialog(tab = "初始化", enable = Medium.nXi > 0));
      parameter Medium.AbsolutePressure p_ambient = 101325 
        "水箱表面压力";
      parameter Medium.Temperature T_ambient = 293.15 "水箱表面温度";
      parameter Integer n_TopPorts = 1 "顶部连接器数量";
      parameter Integer n_SidePorts = 1 "侧面连接器数量";
      parameter Integer n_BottomPorts = 1 "底部连接器数量";
      Medium.BaseProperties medium(
        preferredMediumStates = true, 
        p(start = p_ambient), 
        T(start = T_start), 
        Xi(start = X_start[1:Medium.nXi]));
      SI.Height level(
        stateSelect = StateSelect.prefer, 
        min = 0, 
        max = height) "水箱液位高度";
      SI.Volume V(stateSelect = StateSelect.never) "水箱实际容积";
      SI.Energy U "水箱容积的内能";
      Real m(unit = "kg") "水箱容积质量";
      Real mXi[Medium.nXi](each unit = "kg") "独立物质的组分质量";
      // 附加变量
      Real H_flow_BottomPorts[n_BottomPorts];
      Real H_flow_SidePorts[n_SidePorts];
      Real H_flow_TopPorts[n_TopPorts];
      Real m_flow_BottomPorts[n_BottomPorts];
      Real m_flow_SidePorts[n_SidePorts];
      Real m_flow_TopPorts[n_TopPorts];

      Real m_flow_BottomPorts_pos[n_BottomPorts];
      Real m_flow_SidePorts_pos[n_SidePorts];
      Real m_flow_TopPorts_pos[n_TopPorts];
      Real m_flow_pos;
      Medium.MassFlowRate mXi_flow_topPorts[n_TopPorts,Medium.nXi];
      Medium.MassFlowRate mXi_flowBottomPorts[n_BottomPorts,Medium.nXi];
      Medium.MassFlowRate mXi_flow_sidePorts[n_SidePorts,Medium.nXi];

      // 连接器和内胆
      Modelica.Fluid.Interfaces.FluidPort_b BottomFluidPort[n_BottomPorts](
      redeclare package Medium = Medium, 
        m_flow(each start = 0)) 
        annotation(Placement(transformation(
        origin = {-100, -102}, 
        extent = {{-10, -10}, {10, 10}}, 
        rotation = 90)));
      Modelica.Fluid.Interfaces.FluidPort_a TopFluidPort[n_TopPorts](
      redeclare package Medium = Medium, 
        m_flow(each start = 0)) 
        annotation(Placement(transformation(extent = {{-110, 92}, {-90, 112}})));
      Modelica.Fluid.Interfaces.FluidPort_b SideFluidPort[n_SidePorts](
      redeclare package Medium = Medium, 
        m_flow(each start = 0)) 
        annotation(Placement(transformation(extent = {{0, -10}, {20, 10}})));
      Modelica.Fluid.Examples.AST_BatchPlant.BaseClasses.InnerTank InnerTankTop[n_TopPorts](
        each h = medium.h, 
        each p_ambient = p_ambient, 
        each d = medium.d, 
        each Xi = medium.Xi, 
        aboveLevel = {level - top_heights[i] for i in 1:n_TopPorts}, 
        pipeArea = {top_pipeArea[i] for i in 1:n_TopPorts}, 
      redeclare package Medium = Medium) 
        annotation(Placement(transformation(extent = {{-140, 60}, {-120, 80}})));
      Modelica.Fluid.Examples.AST_BatchPlant.BaseClasses.InnerTank 
        InnerTankSide[n_SidePorts](
        each h = medium.h, 
        each p_ambient = p_ambient, 
        each d = medium.d, 
        each Xi = medium.Xi, 
        aboveLevel = {level - side_heights[i] for i in 1:n_SidePorts}, 
        pipeArea = {side_pipeArea[i] for i in 1:n_SidePorts}, 
      redeclare package Medium = Medium) 
        annotation(Placement(transformation(extent = {{-20, 0}, {0, 20}})));
      Modelica.Fluid.Examples.AST_BatchPlant.BaseClasses.InnerTank 
        InnerTankBottom[n_BottomPorts](
        each h = medium.h, 
        each p_ambient = p_ambient, 
        each d = medium.d, 
        each Xi = medium.Xi, 
        aboveLevel = {level - bottom_heights[i] for i in 1:n_BottomPorts}, 
        pipeArea = {bottom_pipeArea[i] for i in 1:n_BottomPorts}, 
      redeclare package Medium = Medium) 
        annotation(Placement(transformation(extent = {{-80, -80}, {-60, -60}})));
      Modelica.Fluid.Interfaces.FluidPort_b Condensed(redeclare package Medium = 
        Medium) 
        annotation(Placement(transformation(extent = {{192, 50}, {212, 70}})));

      // 通过边界的传热
      replaceable model HeatTransfer = 
        Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.IdealHeatTransfer 
        constrainedby 
        Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.PartialVesselHeatTransfer 
        "壁面传热" 
        annotation(Dialog(tab = "假设", group = "传热", enable = use_HeatTransfer), choicesAllMatching = true);
      HeatTransfer heatTransfer(
      redeclare final package Medium = Medium, 
        final n = 1, 
        final states = {medium.state}, 
        surfaceAreas = {crossArea + 2 * sqrt(crossArea * Modelica.Constants.pi) * level}, 
        final use_k = true) 
        annotation(Placement(transformation(
        extent = {{-10, -10}, {30, 30}}, 
        rotation = 90, 
        origin = {-50, -10})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort 
        annotation(Placement(transformation(extent = {{-210, -10}, {-190, 10}})));

      // 蒸发器参数
      parameter SI.Height min_level_for_heating "加热最低液位";

      Medium.SaturationProperties sat 
        "计算饱和特性的状态矢量";
      Medium.SpecificEnthalpy h_v = Medium.dewEnthalpy(sat) 
        "蒸汽的比焓";
      Medium.SpecificEnthalpy h_l = Medium.bubbleEnthalpy(sat) 
        "液体的比焓";
      Medium.SpecificEnthalpy h "液体的实际比焓";
      Medium.Density rho_v = Medium.dewDensity(sat) "气相密度";
      Medium.Density rho_l = Medium.bubbleDensity(sat) "液相密度";
      Medium.Density rho "液相中的实际密度";

    equation
      H_flow_TopPorts = InnerTankTop.H_flow;
      m_flow_TopPorts = InnerTankTop.m_flow;
      mXi_flow_topPorts = InnerTankTop.mXi_flow;

      H_flow_SidePorts = InnerTankSide.H_flow;
      m_flow_SidePorts = InnerTankSide.m_flow;
      mXi_flow_sidePorts = InnerTankSide.mXi_flow;

      H_flow_BottomPorts = InnerTankBottom.H_flow;
      m_flow_BottomPorts = InnerTankBottom.m_flow;
      mXi_flowBottomPorts = InnerTankBottom.mXi_flow;

      for i in 1:n_BottomPorts loop
        m_flow_BottomPorts_pos[i] = (if m_flow_BottomPorts[i] > 0 then 
          m_flow_BottomPorts[i] else 0);
      end for;
      for i in 1:n_SidePorts loop
        m_flow_SidePorts_pos[i] = if m_flow_SidePorts[i] > 0 then m_flow_SidePorts[
          i] else 0;
      end for;
      for i in 1:n_TopPorts loop
        m_flow_TopPorts_pos[i] = if m_flow_TopPorts[i] > 0 then m_flow_TopPorts[i] else 
          0;
      end for;
      for i in 1:n_BottomPorts loop
        connect(InnerTankBottom[i].port, BottomFluidPort[i]) annotation(Line(
          points = {{-70, -81}, {-70, -102}, {-100, -102}}, color = {0, 0, 255}));
      end for;
      for i in 1:n_TopPorts loop
        connect(InnerTankTop[i].port, TopFluidPort[i]) annotation(Line(points = 
          {{-130, 59}, {-92, 59}, {-92, 102}, {-100, 102}}, color = {0, 0, 255}));
      end for;
      for i in 1:n_SidePorts loop
        connect(InnerTankSide[i].port, SideFluidPort[i]) annotation(Line(
          points = {{-10, -1}, {24, -1}, {24, 0}, {10, 0}}, color = {0, 0, 255}));
      end for;

      medium.p = p_ambient;
      // 质量平衡
      der(m) = sum(m_flow_BottomPorts) + sum(m_flow_SidePorts) + sum(
        m_flow_TopPorts) + Condensed.m_flow;
      // 能量平衡

      U = m * medium.h - p_ambient * V "流体内能";
      m = V * medium.d "流体质量";
      V = crossArea * level + V0 "液体容积";
      mXi = m * medium.Xi "流体组分的质量";
      sat.psat = medium.p;
      sat.Tsat = Medium.saturationTemperature(medium.p);

      if noEvent(medium.T < sat.Tsat) then
        if Medium.singleState then
          der(U) = sum(H_flow_BottomPorts) + sum(H_flow_SidePorts) + sum(
            H_flow_TopPorts) + Condensed.m_flow * actualStream(Condensed.h_outflow) + heatTransfer.Q_flows[1] 
            "忽略机械功";
        else
          der(U) = sum(H_flow_BottomPorts) + sum(H_flow_SidePorts) + sum(
            H_flow_TopPorts) + Condensed.m_flow * actualStream(Condensed.h_outflow) - p_ambient * der(V) + 
            heatTransfer.Q_flows[1];
        end if;
        Condensed.h_outflow = h;
        Condensed.m_flow = 0;
        rho = medium.d;
        h = medium.h;
      else
        if Medium.singleState then
          der(U) = sum(H_flow_BottomPorts) + sum(H_flow_SidePorts) + sum(H_flow_TopPorts) 
            + Condensed.m_flow * actualStream(Condensed.h_outflow) 
            "忽略机械功";
        else
          der(U) = sum(H_flow_BottomPorts) + sum(H_flow_SidePorts) + sum(
            H_flow_TopPorts) + Condensed.m_flow * actualStream(Condensed.h_outflow) - p_ambient * der(V);
        end if;
        Condensed.h_outflow = h;
        Condensed.m_flow = -heatTransfer.Q_flows[1] / (h_v - h_l);
        rho = rho_l;  //密度 = 液体密度
        h = h_l;    //焓 = 液体焓
        if noEvent(heatPort.Q_flow > 0.0) then
          assert(noEvent(abs(m_flow_pos) <= 0.01), "尝试在蒸发时加注水油箱。");
        end if;

      end if;

      m_flow_pos = sum(m_flow_TopPorts_pos) + sum(m_flow_SidePorts_pos) + sum(
        m_flow_BottomPorts_pos);

      for i in 1:Medium.nXi loop
        der(mXi[i]) = sum(mXi_flowBottomPorts[:,i]) + 
          sum(mXi_flow_sidePorts[:,i]) + 
          sum(mXi_flow_topPorts[:,i]);
      end for;

      assert(level < height, "水箱溢出。");

      assert(not (heatPort.Q_flow > 0.0 and level <= min_level_for_heating), 
        "试图加热空水箱。");

    initial equation
      if initType == Init.GuessValues then
      // 无初始方程
      elseif initType == Init.InitialValues then
        level = level_start;
        if use_T_start then
          medium.T = T_start;
        else
          medium.h = h_start;
        end if;
        medium.Xi = X_start[1:Medium.nXi];
      elseif initType == Init.SteadyStateHydraulic then
        der(level) = 0;
        if use_T_start then
          medium.T = T_start;
        else
          medium.h = h_start;
        end if;
        medium.Xi = X_start[1:Medium.nXi];
      else
        assert(false, "不支持的初始化选项");
      end if;

    equation
      connect(heatPort, heatTransfer.heatPorts[1]) annotation(Line(
        points = {{-200, 0}, {-87, 0}, {-87, 0}, {-74, 0}}, color = {191, 0, 0}));
      annotation(
        Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-200, -100}, {
        200, 100}}), graphics = {
        Rectangle(
        extent = {{-200, 100}, {0, -100}}, 
        lineColor = {255, 255, 255}, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.VerticalCylinder), 
        Rectangle(
        extent = DynamicSelect({{-200, -100}, {0, 0}}, {{-200, -100}, {0, (-100 
        + 200 * level / height)}}), 
        fillColor = {85, 170, 255}, 
        fillPattern = FillPattern.VerticalCylinder), 
        Line(points = {{-200, 100}, {-200, -100}, {0, -100}, {0, 100}}), 
        Text(
        extent = {{-200, 84}, {0, 48}}, 
        textColor = {0, 0, 255}, 
        textString = "%name"), 
        Polygon(
        points = {{0, 100}, {200, 70}, {200, 50}, {200, 50}, {0, 80}, {0, 100}}, 
        fillPattern = FillPattern.HorizontalCylinder, 
        fillColor = {0, 0, 255}), 
        Polygon(
        points = {{20, 98}, {30, 74}, {52, 84}, {66, 72}, {86, 78}, {98, 66}, {118, 74}, 
        {130, 60}, {144, 70}, {152, 60}, {168, 66}, {180, 54}, {196, 74}, {190, 76}, 
        {180, 64}, {170, 70}, {156, 66}, {148, 76}, {132, 68}, {120, 80}, {100, 74}, 
        {88, 88}, {70, 78}, {50, 92}, {32, 82}, {28, 100}, {20, 98}, {20, 98}}, 
        fillPattern = FillPattern.HorizontalCylinder, 
        fillColor = {170, 255, 255}), 
        Text(
        extent = {{-193, 30}, {-3, 10}}, 
        textString = "level ="), 
        Text(
        extent = {{-195, -38}, {-5, -58}}, 
        textString = DynamicSelect("%level_start", String(
        level, 
        minimumLength = 1, 
        significantDigits = 2)))}), 
        Documentation(info = "<html><p>
该水箱具有与 ”三进三出阵列水箱“ 相同的几何变量，同时还具备热端口（HeatPort）和蒸发的功能。
(假设：气体被立即冷凝，从而形成一种沸腾的液体）。
</p>
<p>
可以使用以下选项对水箱进行初始化：
</p>
<ul><li>
GuessValues: 无明确初始条件</li>
<li>
InitialValues: 指定温度（或比焓）、组分和液位的初始值</li>
<li>
SteadyStateHydraulic: 指定温度（或比热）和组分的初始值；确定初始液位，使液位和压力处于稳定状态。</li>
</ul><p>
不支持完全稳态初始化，因为相应的温度/焓初始方程未确定（稳态时通过接口的流速为零）。
</p>
</html>"    ));
    end TankWith3InletOutletArraysWithEvaporatorCondensor;

    model InnerTank
      replaceable package Medium = 
        Modelica.Media.Interfaces.PartialMedium "组件中的介质" 
        annotation(choicesAllMatching = true);

      Modelica.Fluid.Interfaces.FluidPort_a port(redeclare package Medium = 
        Medium) 
        annotation(Placement(transformation(
        origin = {0, -110}, 
        extent = {{-10, -10}, {10, 10}}, 
        rotation = 90)));
      Boolean m_flow_negative(start = true, fixed = true) 
        "true：质量流量从水箱流出";
      constant SI.Acceleration g = Modelica.Constants.g_n;
      input Real aboveLevel;
      input Real d;
      input Real p_ambient;
      input Real h;
      input Medium.MassFraction Xi[Medium.nXi] 
        "水箱内流体的实际质量分数" annotation(Dialog);
      input Real pipeArea;
      output Real H_flow;
      output Real m_flow;
      output Medium.MassFlowRate mXi_flow[Medium.nXi] 
        "= port.mXi_flow (用于在实数矢量中转换连接器矢量）";
      annotation();

    equation
      m_flow_negative = (pre(m_flow_negative) and not port.p > p_ambient) or (port.m_flow < -1e-6);

      if noEvent(aboveLevel > 0) then
        port.p = aboveLevel * g * d + p_ambient - smooth(2, noEvent(if noEvent(m_flow < 0) then m_flow ^ 2 / (2 * d * pipeArea ^ 2) else 0));
      else
        if pre(m_flow_negative) then
          port.m_flow = 0;
        else
          port.p = p_ambient;
        end if;
      end if;

      H_flow = port.m_flow * actualStream(port.h_outflow);
      m_flow = port.m_flow;
      mXi_flow = port.m_flow * actualStream(port.Xi_outflow);
      port.h_outflow = h;
      port.Xi_outflow = Xi;
    end InnerTank;

    model Controller

      Modelica.Fluid.Examples.AST_BatchPlant.BaseClasses.ControllerUtilities.Port_Sensors 
        sensors 
        annotation(Placement(transformation(extent = {{-360, -40}, {-280, 40}}), 
        iconTransformation(extent = {{-280, -40}, {-200, 40}})));
      Modelica.Fluid.Examples.AST_BatchPlant.BaseClasses.ControllerUtilities.Port_Actuators 
        actuators 
        annotation(Placement(transformation(extent = {{218, -20}, {258, 20}}), 
        iconTransformation(extent = {{200, -20}, {240, 20}})));

      parameter Real w_dilution = 0.003 "稀释";
      parameter Real w_concentrate = 0.005 "浓缩";
      parameter Real startTime = 1 "开始时间";
      parameter Real T5_batch_level = 0.211 "T5 批次级别";

      Modelica.StateGraph.InitialStep InitialStep1(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(extent = {{-180, 90}, {-160, 110}})));
      Modelica.StateGraph.Transition Transition1(enableTimer = true, waitTime = 
        startTime) annotation(Placement(transformation(extent = {{-150, 90}, {
        -130, 110}})));
      Modelica.StateGraph.Step Step1(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(extent = {{-120, 90}, {-100, 110}})));
      Modelica.StateGraph.Transition Transition2(condition = LIS_301 >= 0.13) 
        annotation(Placement(transformation(extent = {{-90, 90}, {-70, 110}})));
      Modelica.StateGraph.Step Step2(nIn = 1, nOut = 1) annotation(Placement(transformation(
        extent = {{-60, 90}, {-40, 110}})));
      Modelica.StateGraph.Transition Transition3(
        condition = true, 
        enableTimer = true, 
        waitTime = 500) 
        annotation(Placement(transformation(extent = {{-30, 90}, {-10, 110}})));
      Modelica.StateGraph.Step Step3(nIn = 1, nOut = 1) annotation(Placement(transformation(
        extent = {{0, 90}, {20, 110}})));
      Modelica.StateGraph.Transition Transition4(condition = LIS_301 <= 0.01) 
        annotation(Placement(transformation(extent = {{30, 90}, {50, 110}})));
      Modelica.StateGraph.Step Step4(nIn = 1, nOut = 1) annotation(Placement(transformation(
        extent = {{60, 90}, {80, 110}})));
      Modelica.StateGraph.Transition Transition5(condition = T5_idle) 
        annotation(Placement(transformation(extent = {{90, 90}, {110, 110}})));
      Modelica.StateGraph.Step Step5(nIn = 1, nOut = 1) annotation(Placement(transformation(
        extent = {{120, 90}, {140, 110}})));
      Modelica.StateGraph.Transition Transition6(condition = LIS_501 >= 
        T5_batch_level) annotation(Placement(transformation(extent = {{150, 
        90}, {170, 110}})));
      Modelica.StateGraph.Step Step6(nIn = 1, nOut = 1) annotation(Placement(transformation(
        extent = {{-120, 30}, {-100, 50}})));
      Modelica.StateGraph.Transition Transition7(
        condition = true, 
        enableTimer = true, 
        waitTime = 300) 
        annotation(Placement(transformation(extent = {{-90, 30}, {-70, 50}})));
      Modelica.StateGraph.Parallel Parallel1 annotation(Placement(
        transformation(extent = {{-234, -100}, {220, 0}})));
      Modelica.StateGraph.Step Step7(nIn = 1, nOut = 1) annotation(Placement(transformation(
        extent = {{-166, -80}, {-146, -60}})));
      Modelica.StateGraph.Step Step8(nIn = 1, nOut = 1) annotation(Placement(transformation(
        extent = {{-110, -80}, {-90, -60}})));
      Modelica.StateGraph.Step Step9(nIn = 1, nOut = 1) annotation(Placement(transformation(
        extent = {{-54, -80}, {-34, -60}})));
      Modelica.StateGraph.Step Step10(nOut = 1, nIn = 1) 
        annotation(Placement(transformation(
        extent = {{76, -80}, {96, -60}})));
      Modelica.StateGraph.Step Step11(nIn = 1, nOut = 1) annotation(Placement(transformation(
        extent = {{134, -80}, {154, -60}})));
      Modelica.StateGraph.Step Step12(nIn = 1, nOut = 1) annotation(Placement(transformation(
        extent = {{-80, -40}, {-60, -20}})));
      Modelica.StateGraph.Step Step13b(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(extent = {{-20, -40}, {0, -20}})));
      Modelica.StateGraph.Step Step14(nIn = 1, nOut = 1) annotation(Placement(transformation(
        extent = {{100, -40}, {120, -20}})));
      Modelica.StateGraph.Transition Transition8(condition = T7_idle) 
        annotation(Placement(transformation(extent = {{-138, -80}, {-118, -60}})));
      Modelica.StateGraph.Transition Transition9(condition = LIS_501 <= 0.01) 
        annotation(Placement(transformation(extent = {{-82, -80}, {-62, -60}})));
      Modelica.StateGraph.Transition Transition10(condition = TIS_702 <= 298) 
        annotation(Placement(transformation(extent = {{-24, -80}, {-4, -60}})));
      Modelica.StateGraph.Transition Transition11(condition = LIS_701 <= 0.01) 
        annotation(Placement(transformation(extent = {{106, -80}, {126, -60}})));
      Modelica.StateGraph.Transition Transition12(condition = TIS_602 <= 298) 
        annotation(Placement(transformation(extent = {{-50, -40}, {-30, -20}})));
      Modelica.StateGraph.Transition Transition13(condition = LIS_601 <= 0.01) 
        annotation(Placement(transformation(extent = {{70, -40}, {90, -20}})));

      Real LIS_301;
      Real LIS_501;
      Real LIS_601;
      Real LIS_701;
      Real QI_302;
      Real QIS_502;
      Real TIS_602;
      Real TIS_702;
      Boolean T5_idle;
      Boolean T7_idle;
      Modelica.StateGraph.TransitionWithSignal TransitionWithSignal1 
        annotation(Placement(transformation(
        origin = {-2, -150}, 
        extent = {{-10, -10}, {10, 10}}, 
        rotation = 180)));
      Modelica.Blocks.Sources.BooleanExpression BooleanExpression1(y = time >= 2500) 
        annotation(Placement(transformation(extent = {{-104, -148}, {-18, -116}})));
      inner Modelica.StateGraph.StateGraphRoot stateGraphRoot 
        annotation(Placement(transformation(extent = {{-180, 140}, {-160, 160}})));
      StateGraph.Step Step13(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(extent = {{40, -40}, {60, -20}})));
      StateGraph.Transition Transition13b(
        condition = true, 
        enableTimer = true, 
        waitTime = 1) 
        annotation(Placement(transformation(extent = {{10, -40}, {30, -20}})));
      StateGraph.Step Step10b(nIn = 1, nOut = 1) 
        annotation(Placement(transformation(extent = {{10, -80}, {30, -60}})));
      StateGraph.Transition Transition10b(
        condition = true, 
        enableTimer = true, 
        waitTime = 1) 
        annotation(Placement(transformation(extent = {{42, -80}, {62, -60}})));
    equation
      LIS_301 = sensors.LIS_301;
      LIS_501 = sensors.LIS_501;
      LIS_601 = sensors.LIS_601;
      LIS_701 = sensors.LIS_701;
      QI_302 = sensors.QI_302;
      QIS_502 = sensors.QIS_502;
      TIS_602 = sensors.TIS_602;
      TIS_702 = sensors.TIS_702;
      T5_idle = not actuators.V12 and not actuators.V15 and not actuators.T5_Heater 
        and sensors.LIS_501 < 0.01;
      T7_idle = not actuators.V15 and not actuators.V18 and not actuators.
        T7_Cooling and sensors.LIS_701 < 0.01;

      actuators.P1 = Step10.active or Step10b.active;
      actuators.P2 = Step13.active or Step13b.active;
      actuators.T5_Heater = Step6.active;
      actuators.T7_Cooling = Step9.active;
      actuators.T6_Cooling = Step12.active;
      actuators.V1 = Step10.active or Step10b.active;
      actuators.V2 = false;
      actuators.V3 = Step10.active;
      actuators.V4 = false;
      actuators.V5 = Step13.active or Step13b.active;
      actuators.V6 = Step13.active;
      actuators.V8 = Step1.active;
      actuators.V9 = Step2.active;
      actuators.V10 = false;
      actuators.V11 = Step3.active;
      actuators.V12 = Step5.active;
      actuators.V15 = Step8.active;
      actuators.V18 = Step10.active;
      actuators.V19 = false;
      actuators.V20 = Step13.active;
      actuators.V21 = false;
      actuators.V22 = Step10.active or Step10b.active;
      actuators.V23 = Step10.active or Step10b.active;
      actuators.V25 = Step13.active or Step13b.active;
      actuators.V24 = Step13.active or Step13b.active;

      connect(InitialStep1.outPort[1], Transition1.inPort) annotation(Line(
        points = {{-159.5, 100}, {-144, 100}}));
      connect(Transition1.outPort, Step1.inPort[1]) annotation(Line(points = {{
        -138.5, 100}, {-121, 100}}));
      connect(Step1.outPort[1], Transition2.inPort) 
        annotation(Line(points = {{-99.5, 100}, {-84, 100}}));
      connect(Transition2.outPort, Step2.inPort[1]) 
        annotation(Line(points = {{-78.5, 100}, {-61, 100}}));
      connect(Step2.outPort[1], Transition3.inPort) 
        annotation(Line(points = {{-39.5, 100}, {-24, 100}}));
      connect(Transition3.outPort, Step3.inPort[1]) 
        annotation(Line(points = {{-18.5, 100}, {-1, 100}}));
      connect(Step3.outPort[1], Transition4.inPort) 
        annotation(Line(points = {{20.5, 100}, {36, 100}}));
      connect(Transition4.outPort, Step4.inPort[1]) 
        annotation(Line(points = {{41.5, 100}, {59, 100}}));
      connect(Step4.outPort[1], Transition5.inPort) 
        annotation(Line(points = {{80.5, 100}, {96, 100}}));
      connect(Transition5.outPort, Step5.inPort[1]) 
        annotation(Line(points = {{101.5, 100}, {119, 100}}));
      connect(Step5.outPort[1], Transition6.inPort) 
        annotation(Line(points = {{140.5, 100}, {156, 100}}));
      connect(Transition6.outPort, Step6.inPort[1]) annotation(Line(points = {{
        161.5, 100}, {184, 100}, {184, 70}, {-160, 70}, {-160, 40}, {-121, 40}}));
      connect(Step6.outPort[1], Transition7.inPort) 
        annotation(Line(points = {{-99.5, 40}, {-84, 40}}));
      connect(Step12.inPort[1], Parallel1.split[1]) annotation(Line(points = {{-81, -30}, 
        {-182.925, -30}, {-182.925, -50}}));
      connect(Step12.outPort[1], Transition12.inPort) 
        annotation(Line(points = {{-59.5, -30}, {-44, -30}}));
      connect(Transition12.outPort, Step13b.inPort[1]) 
        annotation(Line(points = {{-38.5, -30}, {-21, -30}}));
      connect(Transition13.outPort, Step14.inPort[1]) 
        annotation(Line(points = {{81.5, -30}, {99, -30}}));
      connect(Step14.outPort[1], Parallel1.join[1]) annotation(Line(points = {{120.5, 
        -30}, {168.925, -30}, {168.925, -50}}));
      connect(Step7.inPort[1], Parallel1.split[2]) annotation(Line(points = {{-167, -70}, 
        {-182, -70}, {-182, -50}, {-182.925, -50}}));
      connect(Step7.outPort[1], Transition8.inPort) annotation(Line(points = {{-145.5, 
        -70}, {-132, -70}}));
      connect(Transition8.outPort, Step8.inPort[1]) 
        annotation(Line(points = {{-126.5, -70}, {-111, -70}}));
      connect(Step8.outPort[1], Transition9.inPort) 
        annotation(Line(points = {{-89.5, -70}, {-76, -70}}));
      connect(Transition9.outPort, Step9.inPort[1]) 
        annotation(Line(points = {{-70.5, -70}, {-55, -70}}));
      connect(Step9.outPort[1], Transition10.inPort) 
        annotation(Line(points = {{-33.5, -70}, {-18, -70}}));
      connect(Step10.outPort[1], Transition11.inPort) 
        annotation(Line(points = {{96.5, -70}, {112, -70}}));
      connect(Transition11.outPort, Step11.inPort[1]) 
        annotation(Line(points = {{117.5, -70}, {133, -70}}));
      connect(Step11.outPort[1], Parallel1.join[2]) annotation(Line(points = {{154.5, 
        -70}, {174, -70}, {174, -50}, {168.925, -50}}));
      connect(Transition7.outPort, Parallel1.inPort) annotation(Line(points = {{-78.5, 
        40}, {-38, 40}, {-38, 10}, {-252, 10}, {-252, -50}, {-240.81, -50}}));
      connect(TransitionWithSignal1.inPort, Parallel1.outPort) annotation(Line(
        points = {{2, -150}, {238, -150}, {238, -50}, {224.54, -50}}));
      connect(TransitionWithSignal1.outPort, InitialStep1.inPort[1]) annotation(Line(
        points = {{-3.5, -150}, {-270, -150}, {-270, 100}, {-181, 100}}));
      connect(BooleanExpression1.y, TransitionWithSignal1.condition) annotation(Line(
        points = {{-13.7, -132}, {-2, -132}, {-2, -138}}, color = {255, 0, 255}));
      connect(Step13b.outPort[1], Transition13b.inPort) 
        annotation(Line(points = {{0.5, -30}, {16, -30}}, color = {0, 0, 0}));
      connect(Transition13b.outPort, Step13.inPort[1]) 
        annotation(Line(points = {{21.5, -30}, {39, -30}}, color = {0, 0, 0}));
      connect(Step13.outPort[1], Transition13.inPort) 
        annotation(Line(points = {{60.5, -30}, {76, -30}}, color = {0, 0, 0}));
      connect(Transition10.outPort, Step10b.inPort[1]) 
        annotation(Line(points = {{-12.5, -70}, {9, -70}}, color = {0, 0, 0}));
      connect(Step10b.outPort[1], Transition10b.inPort) 
        annotation(Line(points = {{30.5, -70}, {48, -70}}, color = {0, 0, 0}));
      connect(Transition10b.outPort, Step10.inPort[1]) 
        annotation(Line(points = {{53.5, -70}, {75, -70}}, color = {0, 0, 0}));
      annotation(
        Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-200, -200}, {
        200, 200}}), graphics = {
        Rectangle(
        extent = {{-200, 200}, {200, -200}}, 
        lineColor = {0, 0, 255}, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), 
        Text(
        extent = {{-288, 286}, {262, 208}}, 
        textColor = {0, 0, 255}, 
        textString = "%name"), 
        Line(points = {{-48, 0}, {0, 0}}), 
        Rectangle(extent = {{-170, 60}, {-50, -60}}), 
        Line(points = {{0, 40}, {0, -40}}), 
        Line(points = {{0, 0}, {26, 0}}), 
        Polygon(
        points = {{26, 10}, {50, 0}, {26, -10}, {26, 10}}, 
        fillPattern = FillPattern.Solid), 
        Rectangle(extent = {{50, 60}, {170, -60}}), 
        Polygon(
        points = {{-24, 10}, {0, 0}, {-24, -10}, {-24, 10}}, 
        fillPattern = FillPattern.Solid)}), 
        Diagram(coordinateSystem(
        preserveAspectRatio = false, extent = {{-320, -180}, {260, 180}})));
    end Controller;

    package ControllerUtilities
      extends Modelica.Icons.Package;
      class Adapter_Inference
        Port_IdleTanks idleTanks;
        annotation();
      end Adapter_Inference;

      class Adapter_Superposition
        Port_Actuators actuators;
        annotation();
      end Adapter_Superposition;

      class Block_Recipe_TBD
        parameter Real startTime "开始时间";
        parameter Real w_dilution = 0.003 "稀释";
        parameter Real w_concentrate = 0.005 "聚集";
        parameter Real T3_batch_level = 0.1273 "T5 批次水平";
        parameter Real T5_batch_level = 0.211 "T3 批次水平";
        Boolean trig;
        Boolean S0(start = true);
        Boolean S1;
        Boolean S2;
        Boolean S3;
        Boolean S4;
        Boolean S5;
        Boolean S6;
        Boolean S7;
        Boolean S8;
        Boolean S9;
        Boolean S10;
        Boolean S11;
        Boolean S12;
        Boolean S13;
        Boolean S14;
        Boolean tr0;
        Boolean tr1;
        Boolean tr2;
        Boolean tr3;
        Boolean tr4;
        Boolean tr5;
        Boolean tr6;
        Boolean tr7;
        Boolean tr8;
        Boolean tr9;
        Boolean tr10;
        Boolean tr11;
        Boolean tr12;
        Boolean tr13;
        Port_Actuators act annotation(Placement(transformation(extent = {{-110, 
          -10}, {-90, 10}})));
        annotation();
      end Block_Recipe_TBD;

      class BlockMain
        Boolean trig;

        Port_Actuators actuators annotation(Placement(transformation(extent = {{
          90, -10}, {110, 10}})));
        Block_Recipe_TBD Recipe1 annotation(Placement(transformation(extent = {{
          -50, 10}, {-10, 50}})));
        Block_Recipe_TBD Recipe2 annotation(Placement(transformation(extent = {{
          10, 10}, {50, 50}})));
        Adapter_Inference Inference annotation(Placement(transformation(extent = 
          {{-50, -50}, {-10, -10}})));
        Adapter_Superposition Superposition annotation(Placement(
          transformation(extent = {{10, -50}, {50, -10}})));
        annotation();
      end BlockMain;

      class Buffer_Recipe_TBD
        Port_Actuators act;
        Boolean S0;
        Boolean S1;
        Boolean S2;
        Boolean S3;
        Boolean S4;
        Boolean S5;
        Boolean S6;
        Boolean S7;
        Boolean S8;
        Boolean S9;
        Boolean S10;
        Boolean S11;
        Boolean S12;
        Boolean S13;
        Boolean S14;
        annotation();
      end Buffer_Recipe_TBD;

      class BufferMain
        Buffer_Recipe_TBD Recipe1;
        Buffer_Recipe_TBD Recipe2;
        annotation();
      end BufferMain;

      connector Port_Actuators
        output Boolean P1;
        output Boolean P2;
        output Boolean T5_Heater;
        output Boolean T7_Cooling;
        output Boolean T6_Cooling;
        output Boolean V1;
        output Boolean V2;
        output Boolean V3;
        output Boolean V4;
        output Boolean V5;
        output Boolean V6;
        output Boolean V8;
        output Boolean V9;
        output Boolean V10;
        output Boolean V11;
        output Boolean V12;
        output Boolean V15;
        output Boolean V18;
        output Boolean V19;
        output Boolean V20;
        output Boolean V21;
        output Boolean V22;
        output Boolean V23;
        output Boolean V24;
        output Boolean V25;

        annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, 
          -100}, {100, 100}}), graphics = {Polygon(
          points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}}, 
          lineThickness = 0.5, 
          fillColor = {255, 255, 255}, 
          fillPattern = FillPattern.Solid)}), 
          Diagram(coordinateSystem(
          preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), 
          graphics = {Polygon(
          points = {{0, 50}, {100, 0}, {0, -50}, {0, 50}}, 
          lineThickness = 0.5, 
          fillColor = {255, 255, 255}, 
          fillPattern = FillPattern.Solid)}));
      end Port_Actuators;

      connector Port_IdleTanks
        Boolean T5_idle;
        Boolean T7_idle;
        annotation();
      end Port_IdleTanks;

      connector Port_Sensors
        input Real LIS_301;
        input Real QI_302;
        input Real LIS_501;
        input Real QIS_502;
        input Real TI_503;
        input Real LIS_601;
        input Real TIS_602;
        input Real LIS_701;
        input Real TIS_702;
        annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, 
          -100}, {100, 100}}), graphics = {Polygon(
          points = {{-100, 100}, {-100, -100}, {100, 0}, {-100, 100}}, 
          lineThickness = 0.5, 
          fillColor = {215, 215, 215}, 
          fillPattern = FillPattern.Solid)}), 
          Diagram(coordinateSystem(
          preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), 
          graphics = {Polygon(
          points = {{0, 50}, {0, -50}, {100, 0}, {0, 50}}, 
          lineThickness = 0.5, 
          fillColor = {215, 215, 215}, 
          fillPattern = FillPattern.Solid)}));
      end Port_Sensors;
      annotation();
    end ControllerUtilities;

    type Init = enumeration(
      GuessValues 
      "猜测 p、T 或 h、X、C 的值（非固定）", 
      InitialValues "p、T 或 h、X、C 的初始值", 
      SteadyStateMomentum "稳态动量", 
      SteadyStateHydraulic 
      "水力稳态（der(p)=0），对于 p 的猜测值，对于 T、h、X、C 的初始值", 
      SteadyState 
      "稳态（对于 p、T 或 h、X、C 的猜测值）") 
      "枚举以定义初始化选项" 
      annotation(Documentation(info = "<html><p>
整数类型，可以有以下值（通过选择菜单选择）：
</p>
<table style=\"width: auto;\"><tbody><tr><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>Types.Init.</strong></th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>Meaning</strong></th></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">GuessValues</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">用于p、T 或 h、X、C 的初始猜测值（非固定值）</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">InitialValues</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">p、T 或 h、X、C 的初始值</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">SteadyStateMomentum</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">稳态动量</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">SteadyStateHydraulic</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">水力稳态（der(p)=0），对于 p 的猜测值，对于 T、h、X、C 的初始值</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">SteadyState</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">稳态（对于 p、T 或 h、X、C 的猜测值）</td></tr></tbody></table><p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"  ));

    model TankWithTopPorts 
      "带进/出口且顶部设有进液口的水箱"

      import Modelica.Constants;
      import Modelica.Fluid.Fittings.BaseClasses.lossConstant_D_zeta;
      import Modelica.Fluid.Utilities.regRoot2;
      import Modelica.Fluid.Vessels.BaseClasses.VesselPortsData;

      SI.Length level(stateSelect = StateSelect.prefer, start = level_start) 
        "水箱中的液位";

      // 水箱几何参数
      parameter SI.Height height "水箱溢出前的最大液位";
      parameter SI.Area crossArea "水箱的底面积";
      parameter SI.Volume V0 = 0 "液体在液位等于0时的容积";

      // 环境
      parameter Medium.AbsolutePressure p_ambient = system.p_ambient 
        "水箱表面压力" 
        annotation(Dialog(tab = "假设", group = "环境"));
      parameter Medium.Temperature T_ambient = system.T_ambient 
        "水箱表面温度" 
        annotation(Dialog(tab = "假设", group = "环境"));

      // 初始化
      parameter SI.Height level_start(min = 0) = 0.5 * height 
        "水箱水位的初始值" 
        annotation(Dialog(tab = "初始化"));


      //质量和能量平衡
      extends Modelica.Fluid.Interfaces.PartialLumpedVolume(
        final fluidVolume = V, 
        final initialize_p = false, 
        final p_start = p_ambient);

      //接口定义
      parameter Integer nTopPorts = 0 "高度以上的入口数量 (>= 1)" 
        annotation(Dialog(connectorSizing = true));

      Vessels.BaseClasses.VesselFluidPorts_a topPorts[nTopPorts](redeclare package Medium = Medium, m_flow(each start = 0, each min = 0)) 
        "水箱顶部的进口接口（只允许流体从接口进入水箱）" 
        annotation(Placement(transformation(
        extent = {{-20, 0}, {20, 10}}, 
        origin = {0, 100})));

      parameter Integer nPorts = 0 
        "进出口接口的数量（底部和侧面）" 
        annotation(Dialog(connectorSizing = true));
      parameter Modelica.Fluid.Vessels.BaseClasses.VesselPortsData portsData[nPorts] 
        "水箱侧面和底部的进出口接口数据";

      Vessels.BaseClasses.VesselFluidPorts_b ports[nPorts](redeclare package Medium = Medium, m_flow(each start = 0)) 
        "水箱底部或侧面的入口/出口（流体流入或流出接口；接口可能高于液面）" 
        annotation(Placement(transformation(
        extent = {{-20, 0}, {20, -10}}, 
        origin = {0, -100})));

      // 通过边界的传热
      parameter Boolean use_HeatTransfer = false 
        "true：使用传热模型" 
        annotation(Dialog(tab = "假设", group = "传热"));
      replaceable model HeatTransfer = 
        Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.IdealHeatTransfer 
        constrainedby 
        Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.PartialVesselHeatTransfer 
        "壁面传热" 
        annotation(Dialog(tab = "假设", group = "传热", enable = use_HeatTransfer), choicesAllMatching = true);
      HeatTransfer heatTransfer(
      redeclare final package Medium = Medium, 
        final n = 1, 
        final states = {medium.state}, 
        surfaceAreas = {crossArea + 2 * sqrt(crossArea * Modelica.Constants.pi) * level}, 
        final use_k = use_HeatTransfer) 
        annotation(Placement(transformation(
        extent = {{-10, -10}, {30, 30}}, 
        rotation = 90, 
        origin = {-50, -10})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if use_HeatTransfer 
        annotation(Placement(transformation(extent = {{-110, -10}, {-90, 10}})));

      // 高级
      parameter Real hysteresisFactor(min = 0) = 0.1 
        "空管的滞后 = 直径 * hysteresisFactor" 
        annotation(Dialog(tab = "高级", group = "接口属性"));
      parameter Boolean stiffCharacteristicForEmptyPort = false 
        "= true，如果空管端口具有强烈的压力损失特性" 
        annotation(Dialog(tab = "高级", group = "接口属性"), Evaluate = true);
      parameter Real zetaLarge(min = 0) = 1e5 
        "大的压力损失系数，如果质量流出空管端口" 
        annotation(Dialog(tab = "高级", group = "接口属性", enable = stiffCharacteristicForEmptyPort));
      parameter SI.MassFlowRate m_flow_small(min = 0) = system.m_flow_small 
        "零质量流量时的正则化范围" 
        annotation(Dialog(tab = "高级", group = "接口属性", enable = stiffCharacteristicForEmptyPort));

      // 水箱特性
      SI.Volume V(stateSelect = StateSelect.never) "Actual tank volume";
      Medium.EnthalpyFlowRate H_flow_top[nTopPorts] 
        "顶部进入水箱的焓流量";
      Medium.EnthalpyFlowRate port_b_H_flow_bottom[nPorts] 
        "底部进入水箱的焓流量";
      Medium.MassFlowRate mXi_flow_top[nTopPorts,Medium.nXi] 
        "顶部进入水箱的物质质量流量";
      Medium.MassFlowRate port_b_mXi_flow_bottom[nPorts,Medium.nXi] 
        "底部进入水箱的物质质量流量";
      Medium.MassFlowRate mC_flow_top[nTopPorts,Medium.nC] 
        "顶部进入水箱的微量物质质量流量";
      Medium.MassFlowRate port_b_mC_flow_bottom[nPorts,Medium.nC] 
        "底部进入水箱的微量物质质量流量";

    protected
      SI.Area bottomArea[nPorts];
      SI.Diameter ports_emptyPipeHysteresis[nPorts];
      SI.Length levelAbovePort[nPorts] "流体超过底部接口的高度";
      Boolean ports_m_flow_out[nPorts](each start = true, each fixed = true);
      Boolean aboveLevel[nPorts] "true：液位 >= ports[i].height";
      Real zetas_out[nPorts];
      Modelica.Blocks.Interfaces.RealInput portsData_diameter[nPorts] = portsData.diameter if nPorts > 0;
      Modelica.Blocks.Interfaces.RealInput portsData_diameter2[nPorts];
      Modelica.Blocks.Interfaces.RealInput portsData_height[nPorts] = portsData.height if nPorts > 0;
      Modelica.Blocks.Interfaces.RealInput portsData_height2[nPorts];
    equation
      assert(level <= height, "Tank starts to overflow (level = height = " + String(level) + ")");
      assert(m >= 0, "水箱中的质量为零");

      // 计算常量数据
      connect(portsData_diameter, portsData_diameter2);
      connect(portsData_height, portsData_height2);

      for i in 1:nPorts loop
        bottomArea[i] = Constants.pi * (portsData_diameter2[i] / 2) ^ 2;
        ports_emptyPipeHysteresis[i] = portsData_diameter2[i] * hysteresisFactor;
      end for;

      // 一个接口只允许一个连接，以避免不必要的理想混合
      /*
      for i in 1:nTopPorts loop
      assert(cardinality(topPorts[i]) <= 1,"
      topPorts[" + String(i) + "] of volume can at most be connected to one component.
      If two or more connections are present, ideal mixing takes
      place with these connections which is usually not the intention
      of the modeller.
      ");
      end for;
      
      for i in 1:nPorts loop
      assert(cardinality(ports[i]) <= 1,"
      ports[" + String(i) + "] of volume can at most be connected to one component.
      If two or more connections are present, ideal mixing takes
      place with these connections which is usually not the intention
      of the modeller.
      ");
      end for;
      */

      // 整体量
      medium.p = p_ambient;
      V = crossArea * level + V0 "液体容积";

      // Mass balances
      mb_flow = sum(topPorts.m_flow) + sum(ports.m_flow);
      for i in 1:Medium.nXi loop
        mbXi_flow[i] = sum(mXi_flow_top[:,i]) + sum(port_b_mXi_flow_bottom[:,i]);
      end for;
      for i in 1:Medium.nC loop
        mbC_flow[i] = sum(mC_flow_top[:,i]) + sum(port_b_mC_flow_bottom[:,i]);
      end for;

      // 能量平衡
      Hb_flow = sum(H_flow_top) + sum(port_b_H_flow_bottom);
      Qb_flow = heatTransfer.Q_flows[1];
      if Medium.singleState or energyDynamics == Types.Dynamics.SteadyState then
        Wb_flow = 0 
          "忽略机械功，因为介质模型中也忽略了机械功（否则，如果水箱液位发生变化，温度的微小变化将不符合实际情况）";
      else
        Wb_flow = -p_ambient * der(V);
      end if;

      // 顶部接口的属性
      for i in 1:nTopPorts loop
        // 假定流体只从顶部的一个接口流入水箱，反之亦然。
        H_flow_top[i] = topPorts[i].m_flow * actualStream(topPorts[i].h_outflow);
        mXi_flow_top[i,:] = topPorts[i].m_flow * actualStream(topPorts[i].Xi_outflow);
        mC_flow_top[i,:] = topPorts[i].m_flow * actualStream(topPorts[i].C_outflow);
        topPorts[i].p = p_ambient;
        topPorts[i].h_outflow = h_start;
        topPorts[i].Xi_outflow = X_start[1:Medium.nXi];
        topPorts[i].C_outflow = C_start;
      /*
      assert(topPorts[i].m_flow > -1, "Mass flows out of tank via topPorts[" + String(i) + "]\n" +
      "This indicates a wrong model");
      */
      end for;

      // 底部接口的属性
      for i in 1:nPorts loop
        port_b_H_flow_bottom[i] = ports[i].m_flow * actualStream(ports[i].h_outflow);
        port_b_mXi_flow_bottom[i,:] = ports[i].m_flow * actualStream(ports[i].Xi_outflow);
        port_b_mC_flow_bottom[i,:] = ports[i].m_flow * actualStream(ports[i].C_outflow);
        aboveLevel[i] = level >= (portsData_height2[i] + ports_emptyPipeHysteresis[i]) 
          or pre(aboveLevel[i]) and level >= (portsData_height2[i] - ports_emptyPipeHysteresis[i]);
        levelAbovePort[i] = if aboveLevel[i] then level - portsData_height2[i] else 0;
        ports[i].h_outflow = medium.h;
        ports[i].Xi_outflow = medium.Xi;
        ports[i].C_outflow = C;

        if stiffCharacteristicForEmptyPort then
          // 如果接口高于液面，则在流体流出端口时使用大的 Zeta 值（= 小质量流量）。
          zetas_out[i] = 1 + (if aboveLevel[i] then 0 else zetaLarge);
          ports[i].p = p_ambient + levelAbovePort[i] * system.g * medium.d 
            + Modelica.Fluid.Utilities.regSquare2(ports[i].m_flow, m_flow_small, 
            lossConstant_D_zeta(portsData_diameter2[i], 0.01) / medium.d, 
            lossConstant_D_zeta(portsData_diameter2[i], zetas_out[i]) / medium.d);
          ports_m_flow_out[i] = false;

        else
          // 根据 Remelhe/Poschlad 进行处理
          ports_m_flow_out[i] = (pre(ports_m_flow_out[i]) and not ports[i].p > p_ambient) 
            or ports[i].m_flow < -1e-6;
          if aboveLevel[i] then
            ports[i].p = p_ambient + levelAbovePort[i] * system.g * medium.d - 
              smooth(2, noEvent(if ports[i].m_flow < 0 then ports[i].m_flow ^ 2 / 
              (2 * medium.d * bottomArea[i] ^ 2) else 0));
          else
            if pre(ports_m_flow_out[i]) then
              ports[i].m_flow = 0;
            else
              ports[i].p = p_ambient;
            end if;
          end if;
          zetas_out[i] = 0;
        end if;
      end for;

    initial equation
      for i in 1:nPorts loop
        pre(aboveLevel[i]) = level_start >= portsData_height2[i];
      end for;

      if massDynamics == Types.Dynamics.FixedInitial then
        level = level_start;
      elseif massDynamics == Types.Dynamics.SteadyStateInitial then
        der(level) = 0;
      end if;

    equation
      connect(heatPort, heatTransfer.heatPorts[1]) annotation(Line(
        points = {{-100, 0}, {-87, 0}, {-87, 0}, {-74, 0}}, color = {191, 0, 0}));
      annotation(defaultComponentName = "tank", 
        Icon(coordinateSystem(
        preserveAspectRatio = true, 
        extent = {{-100, -100}, {100, 100}}, 
        initialScale = 0.2), graphics = {
        Rectangle(
        extent = {{-100, -100}, {100, 100}}, 
        lineColor = {255, 255, 255}, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.VerticalCylinder), 
        Rectangle(
        extent = DynamicSelect({{-100, -100}, {100, 0}}, {{-100, -100}, {100, (-100 
        + 200 * level / height)}}), 
        fillColor = {85, 170, 255}, 
        fillPattern = FillPattern.VerticalCylinder), 
        Text(
        extent = {{-94, 90}, {95, 60}}, 
        textColor = {0, 0, 255}, 
        textString = "%name"), 
        Text(
        extent = {{-95, 41}, {95, 21}}, 
        textString = "level ="), 
        Line(points = {{-100, 100}, {-100, -100}, {100, -100}, {100, 100}}), 
        Text(
        extent = {{-95, -39}, {95, -59}}, 
        textString = DynamicSelect("%level_start", String(
        level, 
        minimumLength = 1, 
        significantDigits = 2)))}), 
        Documentation(info = "<html><p>
在固定压力 <code>p_ambient</code> 下对环境开放的水箱模型。水箱内装有单一或含多种物质的液体，
假定温度和质量分数一致。
</p>
<p>
在水箱顶部超过<strong>最大加注高度</strong>的位置，有一个流体接口矢量，
称为<strong>顶部接口</strong>（topPorts）。假设流体总是通过这些接口流入水箱（而不会回流到连接器）。
</p>
<p>
<strong>矢量连接口</strong>是位于水箱底部和侧面的流体接口，高度可自行定义。流体可以流出或流入该接口。
水箱的液位可能低于其中一个接口。这种情况的近似值是引入一个较大的压力流量系数，因此在这种情况下，
通过该接口的质量流量非常小。
</p>
<p>
如果水箱开始溢流（即液位 &gt; 高度），则会触发 assert。
</p>
<p>
当图表层在绘图环境中打开时，水箱的水位会动态可视化。请注意，Dymola 中图表动画的速度可通过
<strong> animationSpeed(</strong>) 命令设置，例如 animationSpeed(speed = 10)。
</p>
</html>"    , revisions = "<html>
<ul>
<li><em>Dec. 12, 2008</em> by R&uuml;diger Franke: 
用 BaseClasses.PartialLumpedVolume 中的通用定义替换能量和质量平衡</li>
<li><em>Dec. 8, 2008</em> by Michael Wetter (LBNL):<br>
实现微量物质和多物质介质的跟踪，并补充了顶部出口的缺失方程。</li>
<li><em>Jul. 29, 2006</em> by Martin Otter (DLR):<br>
改进了对高于液面的接口的处理，并简化了实施过程。</li>
<li><em>Jan. 6, 2006</em> by Katja Poschlad, Manuel Remelhe (AST Uni Dortmund),
Martin Otter (DLR):<br>
基于以前的水箱模型，但做了一些改进（顶部、底部、侧面接口；正确处理出口动能和入口总耗散；接口可高于液面）。</li>
</ul>
</html>"    ));
    end TankWithTopPorts;
    annotation();


  end BaseClasses;

  package Test "测试使用过的水箱模型"
    extends Modelica.Icons.ExamplesPackage;

    model OneTank 
      "顶部入口质量流量随时间变化，底部出口通向环境的水箱"
      import Modelica.Units.Conversions.from_bar;
      extends Modelica.Icons.Example;

      Modelica.Fluid.Examples.AST_BatchPlant.BaseClasses.TankWithTopPorts tank(
      redeclare package Medium = 
        Modelica.Media.Water.ConstantPropertyLiquidWater, 
        crossArea = 1, 
        height = 1, 
        portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter = 0.1, height = 0)}, 
        V0 = 0.1, 
        nTopPorts = 1, 
        nPorts = 1, 
        level_start = 0.8, 
        stiffCharacteristicForEmptyPort = false, 
        hysteresisFactor = 0.01) 
        annotation(Placement(transformation(extent = {{0, 0}, {40, 40}})));

      Sources.MassFlowSource_T flowSource(nPorts = 1, 
      redeclare package Medium = 
        Modelica.Media.Water.ConstantPropertyLiquidWater, 
        m_flow = 20, 
        T = system.T_ambient, 
        use_m_flow_in = true) 
        annotation(Placement(transformation(extent = {{-12, 42}, {8, 62}})));
      inner Modelica.Fluid.System system 
        annotation(Placement(transformation(extent = {{70, 72}, 
        {90, 92}})));
      Modelica.Fluid.Sources.Boundary_pT ambient_fixed(nPorts = 1, 
      redeclare package Medium = 
        Modelica.Media.Water.ConstantPropertyLiquidWater, 
        p = system.p_ambient, 
        T = system.T_ambient) 
        annotation(Placement(transformation(extent = {{-14, -50}, {6, -30}})));
      Modelica.Fluid.Pipes.StaticPipe pipe(
      redeclare package Medium = 
        Modelica.Media.Water.ConstantPropertyLiquidWater, 
        length = 1, 
        diameter = 0.1, 
        height_ab = -1) 
        annotation(Placement(transformation(
        origin = {20, -18}, 
        extent = {{10, -10}, {-10, 10}}, 
        rotation = 90)));
      Modelica.Blocks.Sources.TimeTable timeTable(table = [0, 0; 10, 0; 10, 40; 20, 40;
        20, 10; 50, 10; 50, 0; 60, 0; 60, 20; 70, 20; 80, 55; 80, 0; 100, 0]) 
        annotation(Placement(transformation(extent = {{-60, 60}, {-40, 80}})));
    equation
      connect(flowSource.ports[1], tank.topPorts[1]) annotation(Line(points = {{8, 52}, {
        20, 52}, {20, 41}}, color = {0, 127, 255}));
      connect(tank.ports[1], pipe.port_a) annotation(Line(
        points = {{20, -1}, {20, -8}}, color = {0, 127, 255}));
      connect(pipe.port_b, ambient_fixed.ports[1]) annotation(Line(
        points = {{20, -28}, {20, -40}, {6, -40}}, color = {0, 127, 255}));
      connect(timeTable.y, flowSource.m_flow_in) annotation(Line(
        points = {{-39, 70}, {-24, 70}, {-24, 60}, {-12, 60}}, color = {0, 0, 127}));
      annotation(experiment(StopTime = 100));
    end OneTank;

    model TwoTanks
      import Modelica.Units.Conversions.from_bar;
      extends Modelica.Icons.Example;
      parameter Boolean stiffCharacteristicForEmptyPort = true 
        "true：空管道接口的剧烈的压力损失特性";

      inner Modelica.Fluid.System system(energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, 
        massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial) 
        annotation(Placement(transformation(extent = {{40, 62}, 
        {60, 82}})));
      Modelica.Fluid.Examples.AST_BatchPlant.BaseClasses.TankWithTopPorts tank1(
      redeclare package Medium = 
        Modelica.Media.Water.ConstantPropertyLiquidWater, 
        stiffCharacteristicForEmptyPort = stiffCharacteristicForEmptyPort, 
        crossArea = 1, 
        height = 4, 
        level_start = 3, 
        T_start = Modelica.Units.Conversions.from_degC(50), 
        nPorts = 1, 
        portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter = 0.1, height = 0)}) 
        annotation(Placement(transformation(extent = {{-80, 0}, {-40, 40}})));
      Modelica.Fluid.Examples.AST_BatchPlant.BaseClasses.TankWithTopPorts tank2(
      redeclare package Medium = 
        Modelica.Media.Water.ConstantPropertyLiquidWater, 
        stiffCharacteristicForEmptyPort = stiffCharacteristicForEmptyPort, 
        crossArea = 1, 
        height = 4, 
        level_start = 1, 
        T_start = Modelica.Units.Conversions.from_degC(100), 
        nPorts = 1, 
        portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter = 0.1, height = 0)}) 
        annotation(Placement(transformation(extent = {{0, 0}, {40, 40}})));
      Modelica.Fluid.Pipes.StaticPipe pipe(
      redeclare package Medium = 
        Modelica.Media.Water.ConstantPropertyLiquidWater, 
        length = 1, 
        diameter = 0.1) annotation(Placement(transformation(extent = {{-30, -30}, {
        -10, -10}})));
    equation
      connect(tank1.ports[1], pipe.port_a) annotation(Line(points = {{-60, -1}, {-60, 
        -20}, {-30, -20}}, color = {0, 127, 255}));
      connect(pipe.port_b, tank2.ports[1]) annotation(Line(points = {{-10, -20}, {20, 
        -20}, {20, -1}}, color = {0, 127, 255}));
      annotation(experiment(StopTime = 100));
    end TwoTanks;

    model TankWithEmptyingPipe1 
      "展示了一个顶部入口质量流量恒定、底部出口通向环境的水箱"
      import Modelica.Units.Conversions.from_bar;
      extends Modelica.Icons.Example;

      Sources.MassFlowSource_T flowSource(
        nPorts = 1, 
      redeclare package Medium = 
        Modelica.Media.Water.ConstantPropertyLiquidWater, 
        m_flow = 50, 
        T = system.T_ambient) 
        annotation(Placement(transformation(extent = {{-20, 40}, {0, 60}})));
      inner Modelica.Fluid.System system(energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, 
        massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial) 
        annotation(Placement(transformation(extent = {{-100, 60}, 
        {-80, 80}})));
      Modelica.Fluid.Sources.Boundary_pT ambient_fixed(nPorts = 1, 
      redeclare package Medium = 
        Modelica.Media.Water.ConstantPropertyLiquidWater, 
        p = system.p_ambient, 
        T = system.T_ambient) 
        annotation(Placement(transformation(extent = {{-60, -100}, {-40, -80}})));
      Modelica.Fluid.Valves.ValveDiscrete valveDiscrete(
      redeclare package Medium = 
        Modelica.Media.Water.ConstantPropertyLiquidWater, 
        dp_nominal(displayUnit = "Pa") = 1, 
        m_flow_nominal = 100) 
        annotation(Placement(transformation(
        origin = {-20, -50}, 
        extent = {{-10, -10}, {10, 10}}, 
        rotation = 90)));
      Modelica.Blocks.Sources.BooleanConstant open(k = false) 
        annotation(Placement(transformation(extent = {{-60, -60}, {-40, -40}})));
      Modelica.Fluid.Examples.AST_BatchPlant.BaseClasses.TankWithTopPorts tank1(
      redeclare package Medium = 
        Modelica.Media.Water.ConstantPropertyLiquidWater, 
        crossArea = 1, 
        V0 = 0.1, 
        height = 2, 
        level_start = 0.1, 
        nPorts = 2, 
        portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter = 0.05, height = 0), 
        Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter = 0.1, 
        height = 1)}, 
        stiffCharacteristicForEmptyPort = true) 
        annotation(Placement(transformation(extent = {{-40, -20}, {0, 20}})));
      Modelica.Fluid.Pipes.StaticPipe pipe(
      redeclare package Medium = 
        Modelica.Media.Water.ConstantPropertyLiquidWater, 
        length = 1, 
        diameter = 0.1, 
        height_ab = 1) annotation(Placement(transformation(
        origin = {40, 10}, 
        extent = {{-10, -10}, {10, 10}}, 
        rotation = 90)));
    equation
      connect(ambient_fixed.ports[1], valveDiscrete.port_a) annotation(Line(points = {
        {-40, -90}, {-20, -90}, {-20, -60}}, color = {0, 127, 255}));
      connect(open.y, valveDiscrete.open) annotation(Line(points = {{-39, -50}, {-28, 
        -50}}, color = {255, 0, 255}));
      connect(flowSource.ports[1], pipe.port_b) annotation(Line(points = {{0, 50}, {40, 
        50}, {40, 20}}, color = {0, 127, 255}));
      connect(valveDiscrete.port_b, tank1.ports[1]) annotation(Line(points = {{-20, -40}, 
        {-20, -30}, {-20, -21}, {-22, -21}}, color = {0, 127, 255}));
      connect(pipe.port_a, tank1.ports[2]) annotation(Line(points = {{40, 0}, {40, -28}, 
        {-18, -28}, {-18, -20}, {-18, -21}}, color = {0, 127, 255}));
      annotation(experiment(StopTime = 35));
    end TankWithEmptyingPipe1;

    model TankWithEmptyingPipe2 
      "展示了一个顶部入口质量流量恒定、底部出口通向环境的水箱"
      import Modelica.Units.Conversions.from_bar;
      extends Modelica.Icons.Example;

      inner Modelica.Fluid.System system(energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, 
        massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial) 
        annotation(Placement(transformation(extent = {{-100, 60}, 
        {-80, 80}})));
      Modelica.Fluid.Sources.Boundary_pT ambient_fixed(nPorts = 1, 
      redeclare package Medium = 
        Modelica.Media.Water.ConstantPropertyLiquidWater, 
        p = system.p_ambient, 
        T = system.T_ambient) 
        annotation(Placement(transformation(extent = {{-60, -100}, {-40, -80}})));
      Modelica.Fluid.Examples.AST_BatchPlant.BaseClasses.TankWithTopPorts tank1(
      redeclare package Medium = 
        Modelica.Media.Water.ConstantPropertyLiquidWater, 
        crossArea = 1, 
        V0 = 0.1, 
        height = 2, 
        nPorts = 2, 
        portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter = 0.05, height = 0), 
        Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter = 0.1, 
        height = 1)}, 
        level_start = 2, 
        stiffCharacteristicForEmptyPort = true) 
        annotation(Placement(transformation(extent = {{-40, -20}, {0, 20}})));
      Modelica.Fluid.Pipes.StaticPipe pipe1(
      redeclare package Medium = 
        Modelica.Media.Water.ConstantPropertyLiquidWater, 
        length = 1, 
        diameter = 0.1, 
        height_ab = 1) annotation(Placement(transformation(
        origin = {-20, -60}, 
        extent = {{-10, -10}, {10, 10}}, 
        rotation = 90)));

      Modelica.Fluid.Pipes.StaticPipe pipe2(
      redeclare package Medium = 
        Modelica.Media.Water.ConstantPropertyLiquidWater, 
        length = 1, 
        diameter = 0.1, 
        height_ab = 1) annotation(Placement(transformation(
        origin = {30, -60}, 
        extent = {{-10, -10}, {10, 10}}, 
        rotation = 90)));
      Modelica.Fluid.Sources.Boundary_pT ambient_fixed1(nPorts = 1, 
      redeclare package Medium = 
        Modelica.Media.Water.ConstantPropertyLiquidWater, 
        p = system.p_ambient, 
        T = system.T_ambient) 
        annotation(Placement(transformation(extent = {{0, -100}, {20, -80}})));
    equation
      connect(tank1.ports[1], pipe1.port_b) annotation(Line(points = {{-22, -21}, {
        -22, -35}, {-20, -35}, {-20, -50}}, color = {0, 127, 255}));
      connect(ambient_fixed.ports[1], pipe1.port_a) annotation(Line(points = {{-40, -90}, 
        {-20, -90}, {-20, -70}}, color = {0, 127, 255}));
      connect(tank1.ports[2], pipe2.port_b) annotation(Line(points = {{-18, -21}, {
        -18, -21}, {-18, -40}, {30, -40}, {30, -50}}, color = {0, 127, 255}));
      connect(ambient_fixed1.ports[1], pipe2.port_a) annotation(Line(points = {{20, -90}, 
        {30, -90}, {30, -70}}, color = {0, 127, 255}));
      annotation(experiment(StopTime = 120));
    end TankWithEmptyingPipe2;

    model TanksWithEmptyingPipe1 
      "展示了一个顶部入口质量流量恒定、底部出口通向环境的水箱"
      import Modelica.Units.Conversions.from_bar;
      extends Modelica.Icons.Example;

      inner Modelica.Fluid.System system(energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, 
        massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial) 
        annotation(Placement(transformation(extent = {{-100, 60}, 
        {-80, 80}})));
      Modelica.Fluid.Sources.Boundary_pT ambient_fixed1(nPorts = 1, 
      redeclare package Medium = 
        Modelica.Media.Water.ConstantPropertyLiquidWater, 
        p = system.p_ambient, 
        T = system.T_ambient) 
        annotation(Placement(transformation(extent = {{-100, -80}, {-80, -60}})));
      Modelica.Fluid.Examples.AST_BatchPlant.BaseClasses.TankWithTopPorts tank1(
      redeclare package Medium = 
        Modelica.Media.Water.ConstantPropertyLiquidWater, 
        crossArea = 1, 
        V0 = 0.1, 
        height = 2, 
        nPorts = 2, 
        portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter = 0.05, height = 0), 
        Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter = 0.1, 
        height = 1)}, 
        level_start = 2, 
        stiffCharacteristicForEmptyPort = true) 
        annotation(Placement(transformation(extent = {{-80, 0}, {-40, 40}})));
      Modelica.Fluid.Pipes.StaticPipe pipe1(
      redeclare package Medium = 
        Modelica.Media.Water.ConstantPropertyLiquidWater, 
        length = 1, 
        diameter = 0.1, 
        height_ab = 1) annotation(Placement(transformation(
        origin = {-60, -40}, 
        extent = {{-10, -10}, {10, 10}}, 
        rotation = 90)));

      Modelica.Fluid.Pipes.StaticPipe pipe2(
      redeclare package Medium = 
        Modelica.Media.Water.ConstantPropertyLiquidWater, 
        length = 1, 
        diameter = 0.1, 
        height_ab = 1) annotation(Placement(transformation(
        origin = {40, -40}, 
        extent = {{-10, -10}, {10, 10}}, 
        rotation = 90)));
      Modelica.Fluid.Sources.Boundary_pT ambient_fixed2(nPorts = 1, 
      redeclare package Medium = 
        Modelica.Media.Water.ConstantPropertyLiquidWater, 
        p = system.p_ambient, 
        T = system.T_ambient) 
        annotation(Placement(transformation(extent = {{0, -80}, {20, -60}})));
      Modelica.Fluid.Examples.AST_BatchPlant.BaseClasses.TankWithTopPorts tank2(
      redeclare package Medium = 
        Modelica.Media.Water.ConstantPropertyLiquidWater, 
        crossArea = 1, 
        V0 = 0.1, 
        height = 2, 
        nPorts = 2, 
        portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter = 0.05, height = 0), 
        Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter = 0.1, 
        height = 0.5)}, 
        level_start = 0.1, 
        stiffCharacteristicForEmptyPort = true) 
        annotation(Placement(transformation(extent = {{20, 0}, {60, 40}})));
      Modelica.Fluid.Pipes.StaticPipe pipe3(
      redeclare package Medium = 
        Modelica.Media.Water.ConstantPropertyLiquidWater, 
        length = 1, 
        diameter = 0.1, 
        height_ab = -0.5) 
        annotation(Placement(transformation(extent = {{-20, 10}, {0, 30}})));
    equation
      connect(tank1.ports[1], pipe1.port_b) annotation(Line(points = {{-62, -1}, {
        -62, -15}, {-60, -15}, {-60, -30}}, color = {0, 127, 255}));
      connect(ambient_fixed1.ports[1], pipe1.port_a) 
        annotation(Line(points = {{-80, -70}, 
        {-60, -70}, {-60, -50}}, color = {0, 127, 255}));
      connect(ambient_fixed2.ports[1], pipe2.port_a) annotation(Line(points = {{20, -70}, 
        {40, -70}, {40, -50}}, color = {0, 127, 255}));
      connect(tank2.ports[1], pipe2.port_b) 
        annotation(Line(points = {{38, -1}, {38, -15}, {40, -15}, {40, -30}}, color = {0, 127, 255}));
      connect(pipe3.port_a, tank1.ports[2]) annotation(Line(points = {{-20, 20}, {
        -30, 20}, {-30, -10}, {-58, -10}, {-58, 0}, {-58, 0}, {-58, -1}}, color = {0, 127, 
        255}));
      connect(pipe3.port_b, tank2.ports[2]) annotation(Line(points = {{0, 20}, {10, 
        20}, {10, -8}, {38, -8}, {38, 0}, {42, 0}, {42, -1}}, color = {0, 127, 255}));
      annotation(experiment(StopTime = 120));
    end TanksWithEmptyingPipe1;

    model TanksWithEmptyingPipe2 
      "展示了一个顶部入口质量流量恒定、底部出口通向环境的水箱"
      parameter Boolean stiffCharacteristicForEmptyPort = true 
        "若空管道端口具有明显的压降特性，则设为true";
      import Modelica.Units.Conversions.from_bar;
      extends Modelica.Icons.Example;
      replaceable package Medium = 
        Modelica.Media.Water.ConstantPropertyLiquidWater constrainedby 
        Modelica.Media.Interfaces.PartialMedium "组件中的介质" 
        annotation(choicesAllMatching = true);

      inner Modelica.Fluid.System system(energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, 
        massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial) 
        annotation(Placement(transformation(extent = {{-100, 60}, 
        {-80, 80}})));
      Modelica.Fluid.Sources.Boundary_pT ambient_fixed(nPorts = 1, 
      redeclare package Medium = 
        Modelica.Media.Water.ConstantPropertyLiquidWater, 
        p = system.p_ambient, 
        T = system.T_ambient) 
        annotation(Placement(transformation(extent = {{-16, -102}, {-36, -82}})));
      Modelica.Fluid.Valves.ValveDiscrete valveDiscrete(
      redeclare package Medium = 
        Modelica.Media.Water.ConstantPropertyLiquidWater, 
        dp_nominal(displayUnit = "Pa") = 1, 
        m_flow_nominal = 100) 
        annotation(Placement(transformation(
        origin = {-60, -78}, 
        extent = {{-10, -10}, {10, 10}}, 
        rotation = 90)));
      Modelica.Blocks.Sources.BooleanConstant open(k = false) 
        annotation(Placement(transformation(extent = {{-98, -88}, {-78, -68}})));
      Modelica.Fluid.Examples.AST_BatchPlant.BaseClasses.TankWithTopPorts tank3(
      redeclare package Medium = Medium, 
        crossArea = 1, 
        V0 = 0.1, 
        height = 20, 
        nPorts = 2, 
        portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter = 0.05, height = 0), 
        Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter = 0.05, 
        height = 6.5)}, 
        level_start = 6, 
        nTopPorts = 1, 
        stiffCharacteristicForEmptyPort = stiffCharacteristicForEmptyPort) 
        annotation(Placement(transformation(extent = {{-80, -50}, {-40, -10}})));
      Modelica.Fluid.Examples.AST_BatchPlant.BaseClasses.TankWithTopPorts tank1(
      redeclare package Medium = Medium, 
        crossArea = 1, 
        V0 = 0.1, 
        height = 10, 
        nPorts = 1, 
        portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter = 0.1, height = 0)}, 
        level_start = 9, 
        stiffCharacteristicForEmptyPort = stiffCharacteristicForEmptyPort) 
        annotation(Placement(transformation(extent = {{50, 50}, {90, 90}})));
      Modelica.Fluid.Examples.AST_BatchPlant.BaseClasses.TankWithTopPorts tank2(
      redeclare package Medium = Medium, 
        crossArea = 1, 
        V0 = 0.1, 
        height = 10, 
        nPorts = 3, 
        portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter = 0.05, height = 0), 
        Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter = 0.05, 
        height = 2), Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter = 0.1, height = 3)}, 
        level_start = 1, 
        stiffCharacteristicForEmptyPort = stiffCharacteristicForEmptyPort) 
        annotation(Placement(transformation(extent = {{-20, 10}, {20, 50}})));
      Pipes.StaticPipe pipe1(redeclare package Medium = Medium, 
        height_ab = 2, 
        length = 2, 
        diameter = 0.1) annotation(Placement(transformation(
        origin = {70, 30}, 
        extent = {{-10, -10}, {10, 10}}, 
        rotation = 90)));
      Pipes.StaticPipe pipe2(redeclare package Medium = Medium, 
        height_ab = 2, 
        length = 2, 
        diameter = 0.1) annotation(Placement(transformation(
        origin = {0, -22}, 
        extent = {{-10, -10}, {10, 10}}, 
        rotation = 90)));
      Pipes.StaticPipe pipe3(redeclare package Medium = Medium, 
        height_ab = 2, 
        length = 2, 
        diameter = 0.1) annotation(Placement(transformation(
        origin = {-60, 10}, 
        extent = {{-10, -10}, {10, 10}}, 
        rotation = 90)));
    equation
      connect(ambient_fixed.ports[1], valveDiscrete.port_a) annotation(Line(points = {
        {-36, -92}, {-60, -92}, {-60, -88}}, color = {0, 127, 255}));
      connect(open.y, valveDiscrete.open) annotation(Line(points = {{-77, -78}, {-68, 
        -78}}, color = {255, 0, 255}));
      connect(valveDiscrete.port_b, tank3.ports[1]) annotation(Line(points = {{-60, -68}, 
        {-60, -59}, {-60, -51}, {-62, -51}}, color = {0, 127, 255}));
      connect(pipe1.port_b, tank1.ports[1]) annotation(Line(points = {{70, 40}, {
        70, 45}, {70, 49}}, color = {0, 127, 255}));
      connect(pipe2.port_a, tank3.ports[2]) annotation(Line(points = {{
        0, -32}, {0, -48}, {0, -60}, {-58, -60}, {-58, -51}}, color = {0, 127, 255}));
      connect(pipe3.port_a, tank3.topPorts[1]) 
        annotation(Line(points = {{-60, 0}, 
        {-60, -5}, {-60, -9}}, color = {0, 127, 255}));
      connect(pipe3.port_b, tank2.ports[1]) annotation(Line(points = {{-60, 20}, {
        -60, 26}, {-30, 26}, {-30, 0}, {-2, 0}, {-2, 9}, {-2.66667, 9}}, color = {0, 127, 255}));
      connect(pipe1.port_a, tank2.ports[3]) annotation(Line(points = {{70, 20}, {
        70, 0}, {2, 0}, {2, 9}, {2.66667, 9}}, color = {0, 127, 255}));
      connect(pipe2.port_b, tank2.ports[2]) annotation(Line(
        points = {{0, -12}, {0, 9}}, color = {0, 127, 255}));
      annotation(experiment(StopTime = 120));
    end TanksWithEmptyingPipe2;
    annotation();
  end Test;
  annotation(preferredView = "info", Documentation(info = "<html><p>
所考虑的过程是多特蒙德大学过程控制实验室 (AST) 学生实验室中的一套蒸发设备，该设备用于蒸发氯化钠水混合物，从而产生浓度更高的溶液。
学生们的任务是学习如何对过程控制系统进行编程。下图为该批次装置的图片。
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/AST_BatchPlant/AST_BatchPlant1.jpg\" alt=\"AST_BatchPlant1.jpg\" data-href=\"\" style=\"\">
</p>
<p>
流程图见下图。
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/AST_BatchPlant/AST_BatchPlant2.png\" alt=\"AST_BatchPlant2.png\" data-href=\"\" style=\"\">
</p>
<p>
来自水箱 B1 的纯水和来自水箱 B2 的浓氯化钠溶液在混合水箱 B3 中混合。混合后，在水箱 B4 中暂存，然后流入蒸发器 B5。
氯化钠水混合物在此蒸发，直至达到所需的浓度。产生的蒸汽在冷凝器 K1 中冷凝，之后在冷却槽 B6 中进一步冷却。
浓缩后的溶液被送至冷却槽 B7。冷却后的液体由泵 P1 和 P2 重新泵回到加料容器中。水箱之间有几个阀门，由中央控制系统调节。
</p>
<p>
<a href=\"https://www.modelica.org/events/modelica2006/Proceedings/sessions/Session6b3.pdf\" target=\"\">Modelica Conference 2006 paper </a>&nbsp;将更详细地介绍这一案例研究。
</p>
</html>"));
end AST_BatchPlant;