within Modelica.Fluid;
package Interfaces 
  "稳态和非稳态、混和相、多物质、不可压缩和可压缩流动的接口"

  extends Modelica.Icons.InterfacesPackage;

  connector FluidPort 
    "管网中准一维流体流动的接口(不可压缩或可压缩、单相或多相、一种或多种物质)"

    replaceable package Medium = Modelica.Media.Interfaces.PartialMedium 
      "介质模型" annotation(choicesAllMatching = true);

    flow Medium.MassFlowRate m_flow 
      "从接口进入组件的质量流量";
    Medium.AbsolutePressure p "接口处热力学压力";
    stream Medium.SpecificEnthalpy h_outflow 
      "m_flow<0时接口附近热力学比焓";
    stream Medium.MassFraction Xi_outflow[Medium.nXi] 
      "如果 m_flow < 0, 靠近连接点的独立混合物的质量分数 m_i/m";
    stream Medium.ExtraProperty C_outflow[Medium.nC] 
      "如果 m_flow < 0, 靠近连接点的性质 c_i/m";
    annotation();
  end FluidPort;

  connector FluidPort_a "设计入口处的通用流体连接器"
    extends FluidPort;
    annotation(defaultComponentName = "port_a", 
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, 
      -100}, {100, 100}}), graphics = {Ellipse(
      extent = {{-40, 40}, {40, -40}}, 
      fillColor = {0, 127, 255}, 
      fillPattern = FillPattern.Solid), Text(extent = {{-150, 110}, {150, 50}}, 
      textString = "%name")}), 
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {
      100, 100}}), graphics = {Ellipse(
      extent = {{-100, 100}, {100, -100}}, 
      lineColor = {0, 127, 255}, 
      fillColor = {0, 127, 255}, 
      fillPattern = FillPattern.Solid), Ellipse(
      extent = {{-100, 100}, {100, -100}}, 
      fillColor = {0, 127, 255}, 
      fillPattern = FillPattern.Solid)}));
  end FluidPort_a;

  connector FluidPort_b "设计出口处的通用流体连接器"
    extends FluidPort;
    annotation(defaultComponentName = "port_b", 
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, 
      -100}, {100, 100}}), graphics = {
      Ellipse(
      extent = {{-40, 40}, {40, -40}}, 
      fillColor = {0, 127, 255}, 
      fillPattern = FillPattern.Solid), 
      Ellipse(
      extent = {{-30, 30}, {30, -30}}, 
      lineColor = {0, 127, 255}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid), 
      Text(extent = {{-150, 110}, {150, 50}}, textString = "%name")}), 
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {
      100, 100}}), graphics = {
      Ellipse(
      extent = {{-100, 100}, {100, -100}}, 
      lineColor = {0, 127, 255}, 
      fillColor = {0, 127, 255}, 
      fillPattern = FillPattern.Solid), 
      Ellipse(
      extent = {{-100, 100}, {100, -100}}, 
      fillColor = {0, 127, 255}, 
      fillPattern = FillPattern.Solid), 
      Ellipse(
      extent = {{-80, 80}, {80, -80}}, 
      lineColor = {0, 127, 255}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid)}));
  end FluidPort_b;

  connector FluidPorts_a 
    "流体连接器, 用于流体接口的矢量(向量维度必须在拖动后添加)."
    extends FluidPort;
    annotation(defaultComponentName = "ports_a", 
      Diagram(coordinateSystem(
      preserveAspectRatio = false, 
      extent = {{-50, -200}, {50, 200}}, 
      initialScale = 0.2), graphics = {
      Text(extent = {{-75, 130}, {75, 100}}, textString = "%name"), 
      Rectangle(
      extent = {{25, -100}, {-25, 100}}, 
      lineColor = {0, 127, 255}), 
      Ellipse(
      extent = {{-25, 90}, {25, 40}}, 
      fillColor = {0, 127, 255}, 
      fillPattern = FillPattern.Solid), 
      Ellipse(
      extent = {{-25, 25}, {25, -25}}, 
      fillColor = {0, 127, 255}, 
      fillPattern = FillPattern.Solid), 
      Ellipse(
      extent = {{-25, -40}, {25, -90}}, 
      fillColor = {0, 127, 255}, 
      fillPattern = FillPattern.Solid)}), 
      Icon(coordinateSystem(
      preserveAspectRatio = false, 
      extent = {{-50, -200}, {50, 200}}, 
      initialScale = 0.2), graphics = {
      Rectangle(
      extent = {{50, -200}, {-50, 200}}, 
      lineColor = {0, 127, 255}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid), 
      Ellipse(
      extent = {{-50, 180}, {50, 80}}, 
      fillColor = {0, 127, 255}, 
      fillPattern = FillPattern.Solid), 
      Ellipse(
      extent = {{-50, 50}, {50, -50}}, 
      fillColor = {0, 127, 255}, 
      fillPattern = FillPattern.Solid), 
      Ellipse(
      extent = {{-50, -80}, {50, -180}}, 
      fillColor = {0, 127, 255}, 
      fillPattern = FillPattern.Solid)}));
  end FluidPorts_a;

  connector FluidPorts_b 
    "流体连接器, 用于流体接口的矢量(向量维度必须在拖动后添加)."
    extends FluidPort;
    annotation(defaultComponentName = "ports_b", 
      Diagram(coordinateSystem(
      preserveAspectRatio = false, 
      extent = {{-50, -200}, {50, 200}}, 
      initialScale = 0.2), graphics = {
      Text(extent = {{-75, 130}, {75, 100}}, textString = "%name"), 
      Rectangle(
      extent = {{-25, 100}, {25, -100}}), 
      Ellipse(
      extent = {{-25, 90}, {25, 40}}, 
      fillColor = {0, 127, 255}, 
      fillPattern = FillPattern.Solid), 
      Ellipse(
      extent = {{-25, 25}, {25, -25}}, 
      fillColor = {0, 127, 255}, 
      fillPattern = FillPattern.Solid), 
      Ellipse(
      extent = {{-25, -40}, {25, -90}}, 
      fillColor = {0, 127, 255}, 
      fillPattern = FillPattern.Solid), 
      Ellipse(
      extent = {{-15, -50}, {15, -80}}, 
      lineColor = {0, 127, 255}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid), 
      Ellipse(
      extent = {{-15, 15}, {15, -15}}, 
      lineColor = {0, 127, 255}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid), 
      Ellipse(
      extent = {{-15, 50}, {15, 80}}, 
      lineColor = {0, 127, 255}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid)}), 
      Icon(coordinateSystem(
      preserveAspectRatio = false, 
      extent = {{-50, -200}, {50, 200}}, 
      initialScale = 0.2), graphics = {
      Rectangle(
      extent = {{-50, 200}, {50, -200}}, 
      lineColor = {0, 127, 255}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid), 
      Ellipse(
      extent = {{-50, 180}, {50, 80}}, 
      fillColor = {0, 127, 255}, 
      fillPattern = FillPattern.Solid), 
      Ellipse(
      extent = {{-50, 50}, {50, -50}}, 
      fillColor = {0, 127, 255}, 
      fillPattern = FillPattern.Solid), 
      Ellipse(
      extent = {{-50, -80}, {50, -180}}, 
      fillColor = {0, 127, 255}, 
      fillPattern = FillPattern.Solid), 
      Ellipse(
      extent = {{-30, 30}, {30, -30}}, 
      lineColor = {0, 127, 255}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid), 
      Ellipse(
      extent = {{-30, 100}, {30, 160}}, 
      lineColor = {0, 127, 255}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid), 
      Ellipse(
      extent = {{-30, -100}, {30, -160}}, 
      lineColor = {0, 127, 255}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid)}));
  end FluidPorts_b;

  partial model PartialTwoPort "带两个接口的基类组件"
    import Modelica.Constants;
    outer Modelica.Fluid.System system "全局属性";

    replaceable package Medium = 
      Modelica.Media.Interfaces.PartialMedium "组件中的介质" 
      annotation(choicesAllMatching = true);

    parameter Boolean allowFlowReversal = system.allowFlowReversal 
      "true: 允许反向流, false: 只能从 port_a 流向 port_b" 
      annotation(Dialog(tab = "假设"), Evaluate = true);

    Modelica.Fluid.Interfaces.FluidPort_a port_a(
    redeclare package Medium = Medium, 
      m_flow(min = if allowFlowReversal then -Constants.inf else 0)) 
      "流体连接器 a(正向设计流向是从 port_a 到 port_b)" 
      annotation(Placement(transformation(extent = {{-110, -10}, {-90, 10}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b(
    redeclare package Medium = Medium, 
      m_flow(max = if allowFlowReversal then +Constants.inf else 0)) 
      "流体连接器 b(正向设计流向是从 port_a 到 port_b)" 
      annotation(Placement(transformation(extent = {{110, -10}, {90, 10}}), iconTransformation(extent = {{110, -10}, {90, 10}})));
    // 模型结构, 例如用于可视化的结构
  protected
    parameter Boolean port_a_exposesState = false 
      "true: port_a 显示了流体容积的状态";
    parameter Boolean port_b_exposesState = false 
      "true: port_b.p 显示了流体容积的状态";
    parameter Boolean showDesignFlowDirection = true 
      "false: 隐藏模型图标中的箭头";

    annotation(
      Documentation(info = "<html>
<p>
该基类模型为具有两个接口的组件定义了一个接口。
根据参数 <code><strong>allowFlowReversal</strong></code> 预先定义了设计流动方向和流动逆转的处理方法。
组件可以传输流体，也可以在内部存储给定的<code><strong>流体介质</strong></code>。
</p>
<p>
通过 port_a 或接口 port_b 直接访问内部质量或能量存储的扩展模型应适当重新定义受保护的参数 <code><strong>port_a_exposesState</strong></code> 和 <code><strong>port_b_exposesState</strong></code>。
为了更好地理解流体模型图，这将在接口图标上直观地显示出来。
</p>
</html>"), 
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Polygon(
      points = {{20, -70}, {60, -85}, {20, -100}, {20, -70}}, 
      lineColor = {0, 128, 255}, 
      fillColor = {0, 128, 255}, 
      fillPattern = FillPattern.Solid, 
      visible = showDesignFlowDirection), 
      Polygon(
      points = {{20, -75}, {50, -85}, {20, -95}, {20, -75}}, 
      lineColor = {255, 255, 255}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid, 
      visible = allowFlowReversal), 
      Line(
      points = {{55, -85}, {-60, -85}}, 
      color = {0, 128, 255}, 
      visible = showDesignFlowDirection), 
      Text(
      extent = {{-149, -114}, {151, -154}}, 
      textColor = {0, 0, 255}, 
      textString = "%name"), 
      Ellipse(
      extent = {{-110, 26}, {-90, -24}}, 
      fillPattern = FillPattern.Solid, 
      visible = port_a_exposesState), 
      Ellipse(
      extent = {{90, 25}, {110, -25}}, 
      fillPattern = FillPattern.Solid, 
      visible = port_b_exposesState)}));
  end PartialTwoPort;

  partial model PartialTwoPortTransport 
    "在两个接口之间输送流体而不储存质量或能量的基类元件"

    extends PartialTwoPort(
      final port_a_exposesState = false, 
      final port_b_exposesState = false);

    // 高级
    // 注意: dp_start 的值应由衍生模型根据本地 dp_nominal 值加以完善
    parameter Medium.AbsolutePressure dp_start(min = -Modelica.Constants.inf) = 0.01 * system.p_start 
      "猜测 dp = port_a.p - port_b.p" 
      annotation(Dialog(tab = "高级"));
    parameter Medium.MassFlowRate m_flow_start = system.m_flow_start 
      "猜测 m_flow = port_a.m_flow" 
      annotation(Dialog(tab = "高级"));
    // 注意: m_flow_small 的值应由衍生模型根据本地 m_flow_nominal 值加以完善
    parameter Medium.MassFlowRate m_flow_small = if system.use_eps_Re then system.eps_m_flow * system.m_flow_nominal else system.m_flow_small 
      "零流量正则化的小质量流量" 
      annotation(Dialog(tab = "高级"));

    // 诊断
    parameter Boolean show_T = true 
      "true: 如果计算了 port_a 和 port_b 的温度" 
      annotation(Dialog(tab = "高级", group = "诊断"));
    parameter Boolean show_V_flow = true 
      "true: 如果计算了流入口的体积流量" 
      annotation(Dialog(tab = "高级", group = "诊断"));

    // 变量
    Medium.MassFlowRate m_flow(
      min = if allowFlowReversal then -Modelica.Constants.inf else 0, 
      start = m_flow_start) "设计流向的质量流量";
    SI.Pressure dp(start = dp_start) 
      "port_a 和 port_b 之间的压力差(= port_a.p - port_b.p)";

    SI.VolumeFlowRate V_flow = 
      m_flow / Modelica.Fluid.Utilities.regStep(m_flow, 
      Medium.density(state_a), 
      Medium.density(state_b), 
      m_flow_small) if show_V_flow 
      "流入口的体积流量(从 port_a 流向 port_b 接口时为正值)";

    Medium.Temperature port_a_T = 
      Modelica.Fluid.Utilities.regStep(port_a.m_flow, 
      Medium.temperature(state_a), 
      Medium.temperature(Medium.setState_phX(port_a.p, port_a.h_outflow, port_a.Xi_outflow)), 
      m_flow_small) if show_T 
      "若 show_T = true, 靠近 port_a 接口的温度";
    Medium.Temperature port_b_T = 
      Modelica.Fluid.Utilities.regStep(port_b.m_flow, 
      Medium.temperature(state_b), 
      Medium.temperature(Medium.setState_phX(port_b.p, port_b.h_outflow, port_b.Xi_outflow)), 
      m_flow_small) if show_T 
      "若 show_T = true, 靠近 port_b 接口的温度";
  protected
    Medium.ThermodynamicState state_a "通过 port_a 的流入介质的状态";
    Medium.ThermodynamicState state_b "通过 port_b 的流入介质的状态";
  equation
    // 介质状态
    state_a = Medium.setState_phX(port_a.p, inStream(port_a.h_outflow), inStream(port_a.Xi_outflow));
    state_b = Medium.setState_phX(port_b.p, inStream(port_b.h_outflow), inStream(port_b.Xi_outflow));

    // 设计流向的压降
    dp = port_a.p - port_b.p;

    // 质量流的设计方向
    m_flow = port_a.m_flow;
    assert(m_flow > -m_flow_small or allowFlowReversal, "即使 allowFlowReversal 为 false，也会发生反向流动。");

    // 质量平衡 (无存储)
    port_a.m_flow + port_b.m_flow = 0;

    // 物质输运
    port_a.Xi_outflow = inStream(port_b.Xi_outflow);
    port_b.Xi_outflow = inStream(port_a.Xi_outflow);

    port_a.C_outflow = inStream(port_b.C_outflow);
    port_b.C_outflow = inStream(port_a.C_outflow);

    annotation(
      Documentation(info = "<html>
<p>
该组件在两个接口之间输送流体，不存储质量或能量。但可以与环境进行类似功形式的能量交换。
<code>PartialTwoPortTransport</code> 可作为节流元件、阀门和简单流体机械等设备的基类。
</p>
<p>
使用该组件的扩展类需要添加三个等式：
</p>
<ul>
<li>动量平衡，说明压降 <code>dp</code> 与质量流量 <code>m_flow</code> 之间的关系</li>
<li>设计方向的 <code>port_b.h_outflow</code></li>
<li>反方向的 <code>port_a.h_outflow</code></li>
</ul>
<p>
此外，应为以下参数分配适当的值：
</p>
<ul>
<li>用于猜测压降的 <code>dp_start</code></li>
<li>用于正则化零流量的 <code>m_flow_small</code></li>
</ul>
</html>"  ));
  end PartialTwoPortTransport;

  connector HeatPorts_a 
    "热接口连接器, 用于热接口的矢量(向量维度必须在拖动后添加)."
    extends Modelica.Thermal.HeatTransfer.Interfaces.HeatPort;
    annotation(defaultComponentName = "heatPorts_a", 
      Icon(coordinateSystem(
      preserveAspectRatio = false, 
      extent = {{-200, -50}, {200, 50}}, 
      initialScale = 0.2), graphics = {
      Rectangle(
      extent = {{-201, 50}, {200, -50}}, 
      lineColor = {127, 0, 0}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid), 
      Rectangle(
      extent = {{-171, 45}, {-83, -45}}, 
      lineColor = {127, 0, 0}, 
      fillColor = {127, 0, 0}, 
      fillPattern = FillPattern.Solid), 
      Rectangle(
      extent = {{-45, 45}, {43, -45}}, 
      lineColor = {127, 0, 0}, 
      fillColor = {127, 0, 0}, 
      fillPattern = FillPattern.Solid), 
      Rectangle(
      extent = {{82, 45}, {170, -45}}, 
      lineColor = {127, 0, 0}, 
      fillColor = {127, 0, 0}, 
      fillPattern = FillPattern.Solid)}));
  end HeatPorts_a;

  connector HeatPorts_b 
    "热接口连接器, 用于热接口的矢量(向量维度必须在拖动后添加)."
    extends Modelica.Thermal.HeatTransfer.Interfaces.HeatPort;
    annotation(defaultComponentName = "heatPorts_b", 
      Icon(coordinateSystem(
      preserveAspectRatio = false, 
      extent = {{-200, -50}, {200, 50}}, 
      initialScale = 0.2), graphics = {
      Rectangle(
      extent = {{-200, 50}, {200, -51}}, 
      lineColor = {127, 0, 0}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid), 
      Rectangle(
      extent = {{-170, 44}, {-82, -46}}, 
      lineColor = {127, 0, 0}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid), 
      Rectangle(
      extent = {{-44, 46}, {44, -44}}, 
      lineColor = {127, 0, 0}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid), 
      Rectangle(
      extent = {{82, 45}, {170, -45}}, 
      lineColor = {127, 0, 0}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid)}));
  end HeatPorts_b;

  partial model PartialHeatTransfer "传热模型的通用接口"

    // 参量
    replaceable package Medium = Modelica.Media.Interfaces.PartialMedium "组件中的介质" 
      annotation(Dialog(tab = "内部接口", enable = false));

    parameter Integer n = 1 "传热段数" 
      annotation(Dialog(tab = "内部接口", enable = false), Evaluate = true);

    // 为传热模型提供输入
    input Medium.ThermodynamicState[n] states "流段的热力学状态";

    input SI.Area[n] surfaceAreas "传热面积";

    // 传热模型定义的输出
    output SI.HeatFlowRate[n] Q_flows "热流量";

    // 参量
    parameter Boolean use_k = false "true: 使用k值计算传热" 
      annotation(Dialog(tab = "内部接口", enable = false));
    parameter SI.CoefficientOfHeatTransfer k = 0 "对环境的传热系数" 
      annotation(Dialog(group = "环境"), Evaluate = true);
    parameter SI.Temperature T_ambient = system.T_ambient "环境温度" 
      annotation(Dialog(group = "环境"));
    outer Modelica.Fluid.System system "全局属性";

    // 热接口
    Modelica.Fluid.Interfaces.HeatPorts_a[n] heatPorts "到边界组件的热接口" 
      annotation(Placement(transformation(extent = {{-10, 60}, {10, 80}}), iconTransformation(extent = {{-20, 60}, {20, 80}})));

    // 变量
    SI.Temperature[n] Ts = Medium.temperature(states) "由流体状态定义的温度";

  equation
    if use_k then
      Q_flows = heatPorts.Q_flow + {k * surfaceAreas[i] * (T_ambient - heatPorts[i].T) for i in 1:n};
    else
      Q_flows = heatPorts.Q_flow;
    end if;

    annotation(Documentation(info = "<html><p>
该组件是传热模型的通用接口. 流经 n 个流段边界的热流率 <code>Q_flows[n]</code>是给定流体介质<code>Medium</code>的流段热力学状态<code>states</code>、表面<code>surfaceAreas[n]</code> 和边界温度<code>heatPorts[n].T</code>的函数.
</p>
<p>
热损失系数 <code>k</code> 可用来模拟 <code>heatPorts.T</code> 和 <code>T_ambient</code>之间的绝热模型.
</p>
<p>
执行该接口的扩展模型需要定义一个方程： 预定义流体温度 <code>Ts[n]</code>、边界温度 <code>heatPorts[n].T</code> 和热流量<code>Q_flows[n]</code>之间的关系.
</p>
</html>"));
  end PartialHeatTransfer;

  partial model PartialLumpedVolume 
    "质量守恒、能量守恒的集总容积"
    import Modelica.Fluid.Types;
    import Modelica.Fluid.Types.Dynamics;
    import Modelica.Media.Interfaces.Choices.IndependentVariables;

    outer Modelica.Fluid.System system "全局属性";
    replaceable package Medium = 
      Modelica.Media.Interfaces.PartialMedium "组件中的介质" 
      annotation(choicesAllMatching = true);

    // 为容量模型提供的输入
    input SI.Volume fluidVolume "容积";

    // 假设
    parameter Types.Dynamics energyDynamics = system.energyDynamics "能量平衡公式" 
      annotation(Evaluate = true, Dialog(tab = "假设", group = "动力学"));
    parameter Types.Dynamics massDynamics = system.massDynamics "质量平衡公式" 
      annotation(Evaluate = true, Dialog(tab = "假设", group = "动力学"));
    final parameter Types.Dynamics substanceDynamics = massDynamics "物质平衡公式" 
      annotation(Evaluate = true, Dialog(tab = "假设", group = "动力学"));
    final parameter Types.Dynamics traceDynamics = massDynamics "微量物质平衡公式" 
      annotation(Evaluate = true, Dialog(tab = "假设", group = "动力学"));

    // 初始化
    parameter Medium.AbsolutePressure p_start = system.p_start "压力初始值" 
      annotation(Dialog(tab = "初始化"));
    parameter Boolean use_T_start = true "true: 使用 use T_start, false: 使用 h_start" 
      annotation(Dialog(tab = "初始化"), Evaluate = true);
    parameter Medium.Temperature T_start = 
      if use_T_start then system.T_start else Medium.temperature_phX(p_start, h_start, X_start) "温度初始值" 
      annotation(Dialog(tab = "初始化", enable = use_T_start));
    parameter Medium.SpecificEnthalpy h_start = 
      if use_T_start then Medium.specificEnthalpy_pTX(p_start, T_start, X_start) else Medium.h_default "比热初始值" 
      annotation(Dialog(tab = "初始化", enable = not use_T_start));
    parameter Medium.MassFraction X_start[Medium.nX] = Medium.X_default "质量分数的起始值 m_i/m" 
      annotation(Dialog(tab = "初始化", enable = Medium.nXi > 0));
    parameter Medium.ExtraProperty C_start[Medium.nC](
      quantity = Medium.extraPropertiesNames) = Medium.C_default "微量物质的起始值" 
      annotation(Dialog(tab = "初始化", enable = Medium.nC > 0));

    Medium.BaseProperties medium(
      preferredMediumStates = (if energyDynamics == Dynamics.SteadyState and 
      massDynamics == Dynamics.SteadyState then false else true), 
      p(start = p_start), 
      h(start = h_start), 
      T(start = T_start), 
      Xi(start = X_start[1:Medium.nXi]));
    SI.Energy U "流体内能";
    SI.Mass m "流体质量";
    SI.Mass[Medium.nXi] mXi "流体中独立组分的质量";
    SI.Mass[Medium.nC] mC "流体中微量物质的质量";
    // 这里需要添加 C, 因为与 Xi 不同, 这里有 medium.Xi,
    // 没有可变的 medium.C
    Medium.ExtraProperty C[Medium.nC] "微量物质混合物含量";

    // 需要由扩展类定义的变量
    SI.MassFlowRate mb_flow "流经边界的质量流量";
    SI.MassFlowRate[Medium.nXi] mbXi_flow "流经边界的物质质量流量";
    Medium.ExtraPropertyFlowRate[Medium.nC] mbC_flow "流经边界的微量物质的质量流量";
    SI.EnthalpyFlowRate Hb_flow "流经边界或能量源/汇的焓";
    SI.HeatFlowRate Qb_flow "流经边界或能量源/汇的热量";
    SI.Power Wb_flow "流经边界或源项的功";
  protected
    parameter Boolean initialize_p = not Medium.singleState "true: 则建立压力初始方程";
    Real[Medium.nC] mC_scaled(min = fill(Modelica.Constants.eps, Medium.nC)) "流体中微量物质的比重";
  equation
    assert(not (energyDynamics <> Dynamics.SteadyState and massDynamics == Dynamics.SteadyState) or Medium.singleState, 
      "如果 fluidVolume 是固定的，则动力学选项和不储存质量介质的组合不好。");

    // 总物理量
    m = fluidVolume * medium.d;
    mXi = m * medium.Xi;
    U = m * medium.u;
    mC = m * C;

    // 能量和质量平衡
    if energyDynamics == Dynamics.SteadyState then
      0 = Hb_flow + Qb_flow + Wb_flow;
    else
      der(U) = Hb_flow + Qb_flow + Wb_flow;
    end if;

    if massDynamics == Dynamics.SteadyState then
      0 = mb_flow;
    else
      der(m) = mb_flow;
    end if;

    if substanceDynamics == Dynamics.SteadyState then
      zeros(Medium.nXi) = mbXi_flow;
    else
      der(mXi) = mbXi_flow;
    end if;

    if traceDynamics == Dynamics.SteadyState then
      zeros(Medium.nC) = mbC_flow;
    else
      der(mC_scaled) = mbC_flow ./ Medium.C_nominal;
    end if;
    mC = mC_scaled .* Medium.C_nominal;

  initial equation
    // 平衡初始化
    if energyDynamics == Dynamics.FixedInitial then
      /*
      if use_T_start then
      medium.T = T_start;
      else
      medium.h = h_start;
      end if;
      */
      if Medium.ThermoStates == IndependentVariables.ph or 
        Medium.ThermoStates == IndependentVariables.phX then
        medium.h = h_start;
      else
        medium.T = T_start;
      end if;
    elseif energyDynamics == Dynamics.SteadyStateInitial then
      /*
      if use_T_start then
      der(medium.T) = 0;
      else
      der(medium.h) = 0;
      end if;
      */
      if Medium.ThermoStates == IndependentVariables.ph or 
        Medium.ThermoStates == IndependentVariables.phX then
        der(medium.h) = 0;
      else
        der(medium.T) = 0;
      end if;
    end if;

    if massDynamics == Dynamics.FixedInitial then
      if initialize_p then
        medium.p = p_start;
      end if;
    elseif massDynamics == Dynamics.SteadyStateInitial then
      if initialize_p then
        der(medium.p) = 0;
      end if;
    end if;

    if substanceDynamics == Dynamics.FixedInitial then
      medium.Xi = X_start[1:Medium.nXi];
    elseif substanceDynamics == Dynamics.SteadyStateInitial then
      der(medium.Xi) = zeros(Medium.nXi);
    end if;

    if traceDynamics == Dynamics.FixedInitial then
      mC_scaled = m * C_start[1:Medium.nC] ./ Medium.C_nominal;
    elseif traceDynamics == Dynamics.SteadyStateInitial then
      der(mC_scaled) = zeros(Medium.nC);
    end if;

    annotation(
      Documentation(info = "<html><p>
理想混合流体容积的接口和基类, 具有储存质量和能量的能力. 下列边界流和源项是能量平衡的一部分, 必须在扩展类中指定：
</p>
<ul><li>
<code><strong>Qb_flow</strong></code>, 例如通过边界段的对流或潜热；</li>
</ul><ul><li>
<code><strong>Wb_flow</strong></code>, 功项, 例如 ：如果体积不是恒定, 则为p*der(fluidVolume.</li>
</ul><p>
元件体积 <code><strong>fluidVolume</strong></code>是一个输入值, 需要在扩展类中设置, 以完成模型.
</p>
<p>
其他源项必须通过扩展类来定义, 以便流体流过边界段：
</p>
<ul><li>
<code><strong>Hb_flow</strong></code>, 焓,</li>
<li>
<code><strong>mb_flow</strong></code>, 质量流量,</li>
<li>
<code><strong>mbXi_flow</strong></code>, 物质质量流量,</li>
<li>
<code><strong>mbC_flow</strong></code>, 微量物质质量流量.</li>
</ul></html>"      ));
  end PartialLumpedVolume;

  partial model PartialLumpedFlow 
    "集总动量平衡的基类"

    outer Modelica.Fluid.System system "全局属性";

    replaceable package Medium = 
      Modelica.Media.Interfaces.PartialMedium "组件中的介质" annotation();

    parameter Boolean allowFlowReversal = system.allowFlowReversal 
      "true: 允许反向流动, false: 只能沿设计方向流动(m_flow >= 0)" 
      annotation(Dialog(tab = "假设"), Evaluate = true);

    // 为流量模型提供输入
    input SI.Length pathLength "流道长度";

    // 流程模型定义的变量
    Medium.MassFlowRate m_flow(
      min = if allowFlowReversal then -Modelica.Constants.inf else 0, 
      start = m_flow_start, 
      stateSelect = if momentumDynamics == Types.Dynamics.SteadyState then StateSelect.default else 
      StateSelect.prefer) 
      "状态之间的质量流量";

    // 参数
    parameter Modelica.Fluid.Types.Dynamics momentumDynamics = system.momentumDynamics 
      "动量平衡公式" 
      annotation(Dialog(tab = "假设", group = "动力学"), Evaluate = true);

    parameter Medium.MassFlowRate m_flow_start = system.m_flow_start 
      "质量流量初值" 
      annotation(Dialog(tab = "初始化"));

    // 全部量
    SI.Momentum I "流动节块的动量";

    // 由扩展模型定义的源项和力(未使用时为零)
    SI.Force Ib_flow "动量的跨边界传递";
    SI.Force F_p "压力";
    SI.Force F_fg "摩擦力和重力";

  equation
    // 全部量
    I = m_flow * pathLength;

    // 动量平衡
    if momentumDynamics == Types.Dynamics.SteadyState then
      0 = Ib_flow - F_p - F_fg;
    else
      der(I) = Ib_flow - F_p - F_fg;
    end if;

  initial equation
    if momentumDynamics == Types.Dynamics.FixedInitial then
      m_flow = m_flow_start;
    elseif momentumDynamics == Types.Dynamics.SteadyStateInitial then
      der(m_flow) = 0;
    end if;

    annotation(
      Documentation(info = "<html>
<p>
动量平衡的接口和基类，用于定义流动模型中给定<code>介质</code>的质量流量 <code><strong>m_flow</strong></code>。
</p>
<p>
以下边界的流动和力项是动量平衡的一部分，必须在扩展模型中指定（如果不考虑，则设为零）：
</p>
<ul>
<li><code><strong>Ib_flow</strong></code>，通过模型边界的动量流</li>
<li><code><strong>F_p[m]</strong></code>，压力</li>
<li><code><strong>F_fg[m]</strong></code>，摩擦力和重力</li>
</ul>
<p>
流动路径的长度 <code><strong>pathLength</strong></code> 是一个输入值，需要在扩展类中设置以补全模型。
</p>
</html>"  ));
  end PartialLumpedFlow;

  partial model PartialDistributedVolume 
    "离散容积模型的基类"
    import Modelica.Fluid.Types;
    import Modelica.Fluid.Types.Dynamics;
    import Modelica.Media.Interfaces.Choices.IndependentVariables;
    outer Modelica.Fluid.System system "系统属性";

    replaceable package Medium = 
      Modelica.Media.Interfaces.PartialMedium "组件中的介质" 
      annotation(choicesAllMatching = true);

    // 离散化
    parameter Integer n = 2 "离散容积的数量";

    // 为容积模型提供的输入
    input SI.Volume[n] fluidVolumes 
      "容积离散化, 在扩展类中确定";

    // 假设
    parameter Types.Dynamics energyDynamics = system.energyDynamics 
      "能量平衡公式" 
      annotation(Evaluate = true, Dialog(tab = "假设", group = "动力学"));
    parameter Types.Dynamics massDynamics = system.massDynamics 
      "质量平衡公式" 
      annotation(Evaluate = true, Dialog(tab = "假设", group = "动力学"));
    final parameter Types.Dynamics substanceDynamics = massDynamics 
      "物质平衡公式" 
      annotation(Evaluate = true, Dialog(tab = "假设", group = "动力学"));
    final parameter Types.Dynamics traceDynamics = massDynamics 
      "微量物质平衡公式" 
      annotation(Evaluate = true, Dialog(tab = "假设", group = "动力学"));

    //初始化
    parameter Medium.AbsolutePressure p_a_start = system.p_start 
      "port a 的压力初值" 
      annotation(Dialog(tab = "初始化"));
    parameter Medium.AbsolutePressure p_b_start = p_a_start 
      "port b 的压力初值" 
      annotation(Dialog(tab = "初始化"));
    final parameter Medium.AbsolutePressure[n] ps_start = if n > 1 then linspace(
      p_a_start, p_b_start, n) else {(p_a_start + p_b_start) / 2} 
      "压力初值";

    parameter Boolean use_T_start = true "true: 使用 T 初值, 否则使用 h 初值" 
      annotation(Evaluate = true, Dialog(tab = "初始化"));

    parameter Medium.Temperature T_start = if use_T_start then system.T_start else 
      Medium.temperature_phX(
      (p_a_start + p_b_start) / 2, 
      h_start, 
      X_start) "温度初值" 
      annotation(Evaluate = true, Dialog(tab = "初始化", enable = use_T_start));
    parameter Medium.SpecificEnthalpy h_start = if use_T_start then 
      Medium.specificEnthalpy_pTX(
      (p_a_start + p_b_start) / 2, 
      T_start, 
      X_start) else Medium.h_default "比焓初值" 
      annotation(Evaluate = true, Dialog(tab = "初始化", enable = not use_T_start));
    parameter Medium.MassFraction X_start[Medium.nX] = Medium.X_default 
      "质量分数的初值 m_i/m" 
      annotation(Dialog(tab = "初始化", enable = Medium.nXi > 0));
    parameter Medium.ExtraProperty C_start[Medium.nC](
      quantity = Medium.extraPropertiesNames) = Medium.C_default 
      "微量物质初值" 
      annotation(Dialog(tab = "初始化", enable = Medium.nC > 0));

    // 全部量
    SI.Energy[n] Us "流体内能";
    SI.Mass[n] ms "流体质量";
    SI.Mass[n,Medium.nXi] mXis "物质质量";
    SI.Mass[n,Medium.nC] mCs "微量物质质量";
    // 这里需要添加 C, 因为与 Xi 不同, Xi 有 medium[:].Xi 变量, 而这里没有 medium[:].C 变量.
    SI.Mass[n,Medium.nC] mCs_scaled "按比例缩放的微量物质质量";
    Medium.ExtraProperty Cs[n,Medium.nC] "微量物质混合物含量";

    Medium.BaseProperties[n] mediums(
      each preferredMediumStates = true, 
      p(start = ps_start), 
      each h(start = h_start), 
      each T(start = T_start), 
      each Xi(start = X_start[1:Medium.nXi]));

    //源项, 必须由扩展模型定义(如果未使用, 则归零)
    Medium.MassFlowRate[n] mb_flows "质量流量, 源或汇";
    Medium.MassFlowRate[n,Medium.nXi] mbXi_flows 
      "独立质量流量、源或汇";
    Medium.ExtraPropertyFlowRate[n,Medium.nC] mbC_flows 
      "微量物质的质量流量, 源或汇";
    SI.EnthalpyFlowRate[n] Hb_flows "焓流, 源或汇";
    SI.HeatFlowRate[n] Qb_flows "热流量, 源或汇";
    SI.Power[n] Wb_flows "机械功率、p*der(V)等";

  protected
    parameter Boolean initialize_p = not Medium.singleState 
      "true: 建立压力初始方程";

  equation
    assert(not (energyDynamics <> Dynamics.SteadyState and massDynamics == Dynamics.SteadyState) or Medium.singleState, 
      "如果 fluidVolume 是固定的，则动力学选项和不储存质量介质的组合不好。");

    // 全部量
    for i in 1:n loop
      ms[i] = fluidVolumes[i] * mediums[i].d;
      mXis[i,:] = ms[i] * mediums[i].Xi;
      mCs[i,:] = ms[i] * Cs[i,:];
      Us[i] = ms[i] * mediums[i].u;
    end for;

    // 能量和质量平衡
    if energyDynamics == Dynamics.SteadyState then
      for i in 1:n loop
        0 = Hb_flows[i] + Wb_flows[i] + Qb_flows[i];
      end for;
    else
      for i in 1:n loop
        der(Us[i]) = Hb_flows[i] + Wb_flows[i] + Qb_flows[i];
      end for;
    end if;
    if massDynamics == Dynamics.SteadyState then
      for i in 1:n loop
        0 = mb_flows[i];
      end for;
    else
      for i in 1:n loop
        der(ms[i]) = mb_flows[i];
      end for;
    end if;
    if substanceDynamics == Dynamics.SteadyState then
      for i in 1:n loop
        zeros(Medium.nXi) = mbXi_flows[i,:];
      end for;
    else
      for i in 1:n loop
        der(mXis[i,:]) = mbXi_flows[i,:];
      end for;
    end if;
    if traceDynamics == Dynamics.SteadyState then
      for i in 1:n loop
        zeros(Medium.nC) = mbC_flows[i,:];
      end for;
    else
      for i in 1:n loop
        der(mCs_scaled[i,:]) = mbC_flows[i,:] ./ Medium.C_nominal;
        mCs[i,:] = mCs_scaled[i,:] .* Medium.C_nominal;
      end for;
    end if;

  initial equation
    // 平衡初始化
    if energyDynamics == Dynamics.FixedInitial then
      /*
      if use_T_start then
      mediums.T = fill(T_start, n);
      else
      mediums.h = fill(h_start, n);
      end if;
      */
      if Medium.ThermoStates == IndependentVariables.ph or 
        Medium.ThermoStates == IndependentVariables.phX then
        mediums.h = fill(h_start, n);
      else
        mediums.T = fill(T_start, n);
      end if;

    elseif energyDynamics == Dynamics.SteadyStateInitial then
      /*
      if use_T_start then
      der(mediums.T) = zeros(n);
      else
      der(mediums.h) = zeros(n);
      end if;
      */
      if Medium.ThermoStates == IndependentVariables.ph or 
        Medium.ThermoStates == IndependentVariables.phX then
        der(mediums.h) = zeros(n);
      else
        der(mediums.T) = zeros(n);
      end if;
    end if;

    if massDynamics == Dynamics.FixedInitial then
      if initialize_p then
        mediums.p = ps_start;
      end if;
    elseif massDynamics == Dynamics.SteadyStateInitial then
      if initialize_p then
        der(mediums.p) = zeros(n);
      end if;
    end if;

    if substanceDynamics == Dynamics.FixedInitial then
      mediums.Xi = fill(X_start[1:Medium.nXi], n);
    elseif substanceDynamics == Dynamics.SteadyStateInitial then
      for i in 1:n loop
        der(mediums[i].Xi) = zeros(Medium.nXi);
      end for;
    end if;

    if traceDynamics == Dynamics.FixedInitial then
      Cs = fill(C_start[1:Medium.nC], n);
    elseif traceDynamics == Dynamics.SteadyStateInitial then
      for i in 1:n loop
        der(mCs[i,:]) = zeros(Medium.nC);
      end for;
    end if;

    annotation(Documentation(info = "<html>
<p>
用于 <code><strong>n</strong></code> 个理想混合流体容积的接口和基类，可存储质量和能量。其目的是根据有限体积法对流体流动进行一维空间离散建模。
以下边界流动和源项是能量平衡的一部分，必须在扩展类中指定：
</p>
<ul>
<li><code><strong>Qb_flows[n]</strong></code>，热流项，例如跨节块边界的传热热流</li>
<li><code><strong>Wb_flows[n]</strong></code>，功项</li>
</ul>
<p>
组件容积 <code><strong>fluidVolumes[n]</strong></code> 是一个输入，需要在扩展类中设置，以补全模型。
</p>
<p>
其他边界项必须通过扩展类来定义，以便流体通过节块边界：
</p>
<ul>
<li><code><strong>Hb_flows[n]</strong></code>，焓</li>
<li><code><strong>mb_flows[n]</strong></code>，质量流量</li>
<li><code><strong>mbXi_flows[n]</strong></code>，物质的质量流量</li>
<li><code><strong>mbC_flows[n]</strong></code>，微量物质质量流量</li>
</ul>
</html>"    ));
  end PartialDistributedVolume;

  partial model PartialDistributedFlow 
    "离散动量平衡基类"

    outer Modelica.Fluid.System system "全局属性";

    replaceable package Medium = 
      Modelica.Media.Interfaces.PartialMedium "组件中的介质" annotation();

    parameter Boolean allowFlowReversal = system.allowFlowReversal 
      "true: 允许反向流动, false: 只能沿设计方向流动(m_flows >= zeros(m))" 
      annotation(Dialog(tab = "假设"), Evaluate = true);

    // 离散化
    parameter Integer m = 1 "流动节块数量";

    // 为流量模型提供输入
    input SI.Length[m] pathLengths "流道长度";

    // 动量模型定义的变量
    Medium.MassFlowRate[m] m_flows(
      each min = if allowFlowReversal then -Modelica.Constants.inf else 0, 
      each start = m_flow_start, 
      each stateSelect = if momentumDynamics == Types.Dynamics.SteadyState then StateSelect.default else 
      StateSelect.prefer) 
      "状态之间的质量流量";

    // 参数
    parameter Modelica.Fluid.Types.Dynamics momentumDynamics = system.momentumDynamics 
      "动量平衡公式" 
      annotation(Dialog(tab = "假设", group = "动力学"), Evaluate = true);

    parameter Medium.MassFlowRate m_flow_start = system.m_flow_start 
      "质量流量初值" 
      annotation(Dialog(tab = "初始化"));

    // 全部量
    SI.Momentum[m] Is "流动节块的动量";

    // 由扩展模型定义的源项和力(未使用时为零)
    SI.Force[m] Ib_flows "动量的跨边界传递";
    SI.Force[m] Fs_p "压力";
    SI.Force[m] Fs_fg "摩擦力和重力";

  equation
    // 全部量
    Is = {m_flows[i] * pathLengths[i] for i in 1:m};

    // 动量平衡
    if momentumDynamics == Types.Dynamics.SteadyState then
      zeros(m) = Ib_flows - Fs_p - Fs_fg;
    else
      der(Is) = Ib_flows - Fs_p - Fs_fg;
    end if;

  initial equation
    if momentumDynamics == Types.Dynamics.FixedInitial then
      m_flows = fill(m_flow_start, m);
    elseif momentumDynamics == Types.Dynamics.SteadyStateInitial then
      der(m_flows) = zeros(m);
    end if;

    annotation(
      Documentation(info = "<html>
<p>
<code><strong>m</strong></code> 个动量平衡的接口和基类，用于定义给定介质在 <code><strong>m</strong></code> 个流动节块中的质量流量 <code><strong>m_flows[m]</strong></code>。
</p>
<p>
下列边界的流动和力项是动量平衡的一部分，必须在扩展模型中指定（如果不考虑，则设为零）：
</p>
<ul>
<li><code><strong>Ib_flows[m]</strong></code>，跨节块边界的动量流</li>
<li><code><strong>Fs_p[m]</strong></code>，压力</li>
<li><code><strong>Fs_fg[m]</strong></code>，摩擦力和重力</li>
</ul>
<p>
流道的长度 <code><strong>pathLengths[m]</strong></code> 是一个输入值，需要在扩展类中设置才能补全模型。
</p>
</html>"));
  end PartialDistributedFlow;

  partial model PartialPressureLoss 
    "面积相同的port_a和port_b压力损失函数的基本流量模型"
    extends Modelica.Fluid.Interfaces.PartialTwoPortTransport;
  protected
    parameter Medium.ThermodynamicState state_dp_small = Medium.setState_pTX(
      Medium.reference_p, 
      Medium.reference_T, 
      Medium.reference_X) "计算 dp_small 的介质状态";
    Medium.Density d_a 
      "当流体从 port_a 接口流向 port_b 时, port_a 的密度";
    Medium.Density d_b 
      "如果 allowFlowReversal=true, 则为流体从 port_b 流向 port_a 时 port_b 的密度, 否则为 d_a";
    Medium.DynamicViscosity eta_a 
      "当流体从 port_a 接口流向 port_b 时, port_a 的动力黏度";
    Medium.DynamicViscosity eta_b 
      "如果 allowFlowReversal=true, 则为流体从 port_b 流向 port_a 时 port_b 的动力黏度, 否则为 eta_a";
    annotation();
  equation
    // 等焓状态转换(无能量储存, 无能量损失)
    port_a.h_outflow = inStream(port_b.h_outflow);
    port_b.h_outflow = inStream(port_a.h_outflow);

    // 介质属性
    d_a = Medium.density(state_a);
    eta_a = Medium.dynamicViscosity(state_a);
    if allowFlowReversal then
      d_b = Medium.density(state_b);
      eta_b = Medium.dynamicViscosity(state_b);
    else
      d_b = d_a;
      eta_b = eta_a;
    end if;

  end PartialPressureLoss;

annotation(Documentation(info = "<html>

</html>", revisions = "<html>
<ul>
<li><em>June 9th, 2008</em>
       by Michael Sielemann: 在第57届设计会议(Lund)决策后引入了流关键字。</li>
<li><em>May 30, 2007</em>
       by Christoph Richter: 将所有内容移回到 Modelica.Fluid 的原始位置。</li>
<li><em>Apr. 20, 2007</em>
       by Christoph Richter: 将原始库的一部分从 Modelica.Fluid 移至 Modelica 2.2.2 的开发分支。</li>
<li><em>Nov. 2, 2005</em>
       by Francesco Casella: 在第45届设计会议后进行了重构。</li>
<li><em>Nov. 20-21, 2002</em>
       by Hilding Elmqvist, Mike Tiller, Allan Watson, John Batteh, Chuck Newman, Jonas Eborn: 在第32届 Modelica 设计会议上进行了改进。</li>
<li><em>Nov. 11, 2002</em>
       by Hilding Elmqvist, Martin Otter: 改进版本。</li>
<li><em>Nov. 6, 2002</em>
       by Hilding Elmqvist: 第一个版本。</li>
<li><em>Aug. 11, 2002</em>
       by Martin Otter: 根据与 Hilding Elmqvist 和 Hubertus Tummescheit 的讨论进行了改进。<br>
       PortVicinity 模型在基础模型中手动扩展。<br>
       用于组件的体积重命名为 PartialComponentVolume。<br>
       引入了一个新的体积模型 \"Fluid.Components.PortVolume\"，它具有与其连接的端口的介质性质。<br>
       Fluid.Interfaces.PartialTwoPortTransport 是一个基本的两端口传输元件组件，而 PartialTwoPort 是一个容器组件。</li>
</ul>
</html>"));


end Interfaces;