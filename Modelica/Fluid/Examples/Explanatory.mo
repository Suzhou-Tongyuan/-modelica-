within Modelica.Fluid.Examples;
package Explanatory 
  "举例说明需要特别注意的事项"
  extends Modelica.Icons.ExamplesPackage;

  model MeasuringTemperature 
    "使用单接口（带或不带显式连接模型）和双接口传感器测量流体温度的区别"
    extends Modelica.Icons.Example;
    Modelica.Fluid.Sensors.Temperature T_onePort(redeclare package Medium = 
      Modelica.Media.Water.StandardWater) 
      annotation(Placement(transformation(extent = {{-20, 40}, {0, 60}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort T_twoPort(redeclare package Medium = 
      Modelica.Media.Water.StandardWater) 
      annotation(Placement(transformation(extent = {{-20, -20}, {0, 0}})));
    inner Modelica.Fluid.System system(energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial) 
      annotation(Placement(transformation(
      extent = {{-100, 56}, {-80, 76}})));
    Modelica.Fluid.Vessels.OpenTank openTankCold2(nPorts = 1, 
    redeclare package Medium = Modelica.Media.Water.StandardWater, 
      height = 2, 
      crossArea = 2, 
      portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 0.05)}, 
      level_start = 0.975, 
      T_start = 293.15) annotation(Placement(transformation(extent = {{20, 6}, {
      40, 26}})));
    Modelica.Fluid.Vessels.OpenTank openTankCold1(
    redeclare package Medium = Modelica.Media.Water.StandardWater, 
      height = 2, 
      crossArea = 2, 
      portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 0.05)}, 
      nPorts = 1, 
      level_start = 0.975, 
      T_start = 293.15) annotation(Placement(transformation(extent = {{20, 60}, 
      {40, 80}})));
    Modelica.Fluid.Vessels.OpenTank openTankHot1(nPorts = 1, 
      level_start = 1, 
    redeclare package Medium = Modelica.Media.Water.StandardWater, 
      height = 2, 
      crossArea = 2, 
      portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 0.05)}, 
      T_start = 353.15) annotation(Placement(transformation(extent = {{60, 40}, 
      {80, 60}})));
    Modelica.Fluid.Vessels.OpenTank openTankHot2(nPorts = 1, 
      level_start = 1, 
    redeclare package Medium = Modelica.Media.Water.StandardWater, 
      height = 2, 
      crossArea = 2, 
      portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 0.05)}, 
      T_start = 353.15) annotation(Placement(transformation(extent = {{60, -10}, 
      {80, 10}})));
    Modelica.Fluid.Sources.MassFlowSource_T mFlow1(
      nPorts = 1, 
      medium(sat(psat(start = 1e5))), 
    redeclare package Medium = Modelica.Media.Water.StandardWater, 
      use_m_flow_in = true, 
      use_T_in = false, 
      T = 323.15) annotation(Placement(transformation(extent = 
      {{-60, 30}, {-40, 50}})));
    Modelica.Fluid.Sources.MassFlowSource_T mFlow2(
      nPorts = 1, 
      medium(sat(psat(start = 1e5))), 
    redeclare package Medium = Modelica.Media.Water.StandardWater, 
      use_m_flow_in = true, 
      T = 323.15) annotation(Placement(transformation(extent = 
      {{-60, -20}, {-40, 0}})));
    Modelica.Blocks.Sources.Sine sine(f = 1) 
      annotation(Placement(transformation(extent = 
      {{-100, 10}, {-80, 30}})));
    Modelica.Fluid.Sensors.Temperature T_junction(redeclare package Medium = 
      Modelica.Media.Water.StandardWater) 
      annotation(Placement(transformation(extent = {{-20, -80}, {0, -60}})));
    Modelica.Fluid.Vessels.OpenTank openTankCold3(nPorts = 1, 
    redeclare package Medium = Modelica.Media.Water.StandardWater, 
      height = 2, 
      crossArea = 2, 
      portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 0.05)}, 
      level_start = 0.975, 
      T_start = 293.15) annotation(Placement(transformation(extent = {{20, -60}, 
      {40, -40}})));
    Modelica.Fluid.Vessels.OpenTank openTankHot3(nPorts = 1, 
      level_start = 1, 
    redeclare package Medium = Modelica.Media.Water.StandardWater, 
      height = 2, 
      crossArea = 2, 
      portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 0.05)}, 
      T_start = 353.15) annotation(Placement(transformation(extent = {{60, -80}, 
      {80, -60}})));
    Modelica.Fluid.Sources.MassFlowSource_T mFlow3(
      nPorts = 1, 
      medium(sat(psat(start = 1e5))), 
    redeclare package Medium = Modelica.Media.Water.StandardWater, 
      use_m_flow_in = true, 
      T = 323.15) annotation(Placement(transformation(extent = 
      {{-60, -90}, {-40, -70}})));
    Modelica.Fluid.Fittings.TeeJunctionIdeal junctionIdeal(
    redeclare package Medium = 
      Modelica.Media.Water.StandardWater) 
      annotation(Placement(transformation(extent = {{20, -90}, {40, -70}})));
  equation
    connect(mFlow2.ports[1], T_twoPort.port_a) annotation(Line(
      points = {{-40, -10}, {-20, -10}}, color = {0, 127, 255}));
    connect(mFlow1.ports[1], T_onePort.port) annotation(Line(
      points = {{-40, 40}, {-10, 40}}, color = {0, 127, 255}));
    connect(sine.y, mFlow1.m_flow_in) annotation(Line(
      points = {{-79, 20}, {-70, 20}, {-70, 48}, {-60, 48}}, color = {0, 0, 127}));
    connect(sine.y, mFlow2.m_flow_in) annotation(Line(
      points = {{-79, 20}, {-70, 20}, {-70, -2}, {-60, -2}}, color = {0, 0, 127}));
    connect(mFlow3.ports[1], T_junction.port) annotation(Line(
      points = {{-40, -80}, {-10, -80}}, color = {0, 127, 255}));
    connect(sine.y, mFlow3.m_flow_in) annotation(Line(
      points = {{-79, 20}, {-70, 20}, {-70, -72}, {-60, -72}}, color = {0, 0, 127}));
    connect(T_junction.port, junctionIdeal.port_1) annotation(Line(
      points = {{-10, -80}, {20, -80}}, color = {0, 127, 255}));
    connect(T_twoPort.port_b, openTankCold2.ports[1]) annotation(Line(
      points = {{0, -10}, {0, -10}, {30, -10}, {30, 6}}, color = {0, 127, 255}));
    connect(T_onePort.port, openTankHot1.ports[1]) annotation(Line(
      points = {{-10, 40}, {-10, 40}, {70, 40}}, color = {0, 127, 255}));
    connect(T_twoPort.port_b, openTankHot2.ports[1]) annotation(Line(
      points = {{0, -10}, {30, -10}, {70, -10}}, color = {0, 127, 255}));
    connect(junctionIdeal.port_3, openTankCold3.ports[1]) annotation(Line(points = {{30, -70}, 
      {30, -65}, {30, -60}}, color = {0, 127, 255}));
    connect(junctionIdeal.port_2, openTankHot3.ports[1]) annotation(Line(points = {{40, -80}, 
      {55.5, -80}, {70, -80}}, color = {0, 127, 255}));
    connect(T_onePort.port, openTankCold1.ports[1]) annotation(Line(
      points = {{-10, 40}, {30, 40}, {30, 60}}, color = {0, 127, 255}));
    annotation(Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
      -100}, {100, 100}}), graphics = {
      Text(
      extent = {{42, 52}, {62, 46}}, 
      textString = "T=80"), 
      Text(
      extent = {{-4, 76}, {18, 70}}, 
      textString = "T=20"), 
      Text(
      extent = {{-62, 20}, {-36, 12}}, 
      textString = "T=50")}), 
      Documentation(info="<html><p>
该模型展示了单接口和双接口温度传感器在使用和不使用显式结点模型时出现的差异。如下图所示，同一系统有 3 种不同的变化。在所有情况下，都定义了完全相同的流体系统。唯一不同的是如何测量温度：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/Explanatory/MeasuringTemperature1.png\" alt=\"MeasuringTemperature1.png\" data-href=\"\" style=\"\">
</p>
<p>
预先设定的质量流量使流体从蓄水池流向水箱，0.5 秒后质量流体从水箱流向蓄水池。蓄水池的温度为 50 摄氏度，而水箱的初始温度分别为 20 摄氏度和 80 摄氏度。水箱的初始高度总是使流体从冷水箱流出。当流体从蓄水池流向水箱时，与冷水箱混合后进入热水箱。
当流体从水箱流向蓄水池时，两个水箱中的冷水和热水首先混合，然后流向蓄水池。
</p>
<p>
单接口传感器测量连接点的混合温度。因此 T_onePort.T（下图中的蓝色曲线）就是混合点的温度。双接口传感器测量的是上游侧的温度。因此，T_twoPort.T（下图中的红色曲线与绿色曲线相同）首先显示的是蓄水池的温度，
然后是流体从水箱流向蓄水池时的混合温度。T_junction.T（下图中的绿色曲线）的测量结果也是如此，因为单接口传感器连接在质量流量边界和接头之间，而且由于混合是在接头进行的，因此 T_twoPort.T 也出现相同的情况。
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/Explanatory/MeasuringTemperature2.png\" alt=\"MeasuringTemperature2.png\" data-href=\"\" style=\"\">
</p>
</html>"  ), 
      experiment(StopTime = 1.1));
  end MeasuringTemperature;

  model MomentumBalanceFittings 
    "说明动量项在动量平衡中起主要作用的情况"
    extends Modelica.Icons.Example;
    Modelica.Fluid.Sources.Boundary_pT leftBoundary1(
    redeclare package Medium = Modelica.Media.Water.StandardWaterOnePhase, 
      nPorts = 1, 
      p = 100000) 
      annotation(Placement(transformation(extent = {{-80, 20}, {-60, 40}})));
    Modelica.Fluid.Sources.Boundary_pT rightBoundary1(
    redeclare package Medium = Modelica.Media.Water.StandardWaterOnePhase, 
      nPorts = 1, 
      p = 110000) 
      annotation(Placement(transformation(extent = {{80, 20}, {60, 40}})));
    Modelica.Fluid.Fittings.AbruptAdaptor suddenExpansion1(
      diameter_a = 0.1, 
      diameter_b = 0.2, 
    redeclare package Medium = Modelica.Media.Water.StandardWaterOnePhase, 
      show_totalPressures = true, 
      show_portVelocities = true) 
      annotation(Placement(transformation(extent = {{-12, 20}, {8, 40}})));
    Modelica.Fluid.Sources.Boundary_pT leftBoundary2(
    redeclare package Medium = Modelica.Media.Water.StandardWaterOnePhase, 
      nPorts = 1, 
      p = 100000) 
      annotation(Placement(transformation(extent = {{-90, -40}, {-70, -20}})));
    Modelica.Fluid.Sources.Boundary_pT rightBoundary2(
    redeclare package Medium = Modelica.Media.Water.StandardWaterOnePhase, 
      nPorts = 1, 
      p = 110000) 
      annotation(Placement(transformation(extent = {{90, -40}, {70, -20}})));
    Modelica.Fluid.Fittings.AbruptAdaptor suddenExpansion2(
      diameter_a = diameter_a, 
      diameter_b = diameter_b, 
      port_b(p(start = 1e5)), 
      m_flow_start = -10, 
      F_fg(start = 100), 
    redeclare package Medium = Modelica.Media.Water.StandardWaterOnePhase, 
      show_totalPressures = true, 
      show_portVelocities = true) 
      annotation(Placement(transformation(extent = {{-10, -40}, {10, -20}})));
    Modelica.Fluid.Fittings.AbruptAdaptor leftAdaptor(
      diameter_a = 0.1, 
    redeclare package Medium = Modelica.Media.Water.StandardWaterOnePhase, 
      diameter_b = 1e60) 
      annotation(Placement(transformation(extent = {{-40, -40}, {-60, -20}})));
    Modelica.Fluid.Fittings.AbruptAdaptor rightAdaptor(
    redeclare package Medium = Modelica.Media.Water.StandardWaterOnePhase, 
      diameter_a = 0.2, 
      diameter_b = 1e60) 
      annotation(Placement(transformation(extent = {{40, -40}, {60, -20}})));
    parameter Real diameter_a = 0.1 annotation(Evaluate = true, HideResult = true);
    parameter Real diameter_b = 0.2 annotation(Evaluate = true, HideResult = true);
    inner System system 
      annotation(Placement(transformation(extent = {{-92, 56}, {-72, 76}})));
  equation
    connect(leftBoundary1.ports[1], suddenExpansion1.port_a) annotation(Line(
      points = {{-60, 30}, {-12, 30}}, color = {0, 127, 255}));
    connect(suddenExpansion1.port_b, rightBoundary1.ports[1]) annotation(Line(
      points = {{8, 30}, {60, 30}}, color = {0, 127, 255}));
    connect(leftAdaptor.port_b, leftBoundary2.ports[1]) annotation(Line(
      points = {{-60, -30}, {-70, -30}}, color = {0, 127, 255}));
    connect(leftAdaptor.port_a, suddenExpansion2.port_a) annotation(Line(
      points = {{-40, -30}, {-10, -30}}, color = {0, 127, 255}));
    connect(suddenExpansion2.port_b, rightAdaptor.port_a) annotation(Line(
      points = {{10, -30}, {40, -30}}, color = {0, 127, 255}));
    connect(rightAdaptor.port_b, rightBoundary2.ports[1]) annotation(Line(
      points = {{60, -30}, {70, -30}}, color = {0, 127, 255}));
    annotation(
      Documentation(info="<html><p>
本例显示了突扩/突缩模型的使用，该模型与两个规定静压的边界条件相连。请注意，右侧边界的规定静压高于左侧边界。尽管如此，流体还是从左向右流动。
</p>
<p>
原因是边界条件模拟的是无限直径的蓄水池，因此流速为零。然而，突扩模型的两端直径是有限的，而且正如《用户指南》<a href=\"modelica://Modelica.Fluid.UsersGuide.Overview\" target=\"\">Overview </a>&nbsp;概述中解释的那样，这种连接方式并不完全符合动量平衡的要求。使用简单的 <code>connect()</code> 语句，忽略动量项的差值，在本模型中并不合理： 在左边界条件下，它为零，而在突扩的左侧，它有一个非零值，在所示模型中忽略它是不合理的，因为几乎没有摩擦，因此动能影响占主导地位。只有明确模拟这些影响才能得到正确的结果。
</p>
<p>
为此，在模型中加入了两个额外的突扩/缩。直径被设置为接近边界的大值（<code>1e60</code>），而适当值则接近原始模型。现在，这些附加组件引入了精确的动量平衡，结果与预期一致。
</p>
<p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">总压为模型分析提供额外视角。将AbruptAdaptors（突扩/突缩接头）高级选项卡中的</span>show_totalPressures<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">参数设为true后，总压将被纳入模型并支持可视化。由此可验证：即使在上游模型中，</span><span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\"><strong>总压</strong></span><span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">也始终沿流动方向递减</span>。
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/Explanatory/MomentumBalanceFittings.png\" alt=\"MomentumBalanceFittings.png\" data-href=\"\" style=\"\">
</p>
</html>"  ), 
      __Dymola_Commands(file = 
      "modelica://Modelica/Resources/Scripts/Dymola/Fluid/MomentumBalanceFittings/Plot the model results.mos" 
      "Plot the model results"), 
      experiment(StopTime = 1.1));
  end MomentumBalanceFittings;
  annotation();
end Explanatory;