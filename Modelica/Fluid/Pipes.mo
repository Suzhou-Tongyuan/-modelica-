within Modelica.Fluid;
package Pipes "流体输送设备"
  extends Modelica.Icons.VariantsPackage;

  model StaticPipe "不储存质量或能量的基本管道流动模型"

    // 引用管道基类模型
    extends Modelica.Fluid.Pipes.BaseClasses.PartialStraightPipe;

    // 初始化
    parameter Medium.AbsolutePressure p_a_start = system.p_start "port_a 压力初值" 
      annotation(Dialog(tab = "初始化"));
    parameter Medium.AbsolutePressure p_b_start = p_a_start "port_b 压力初值" 
      annotation(Dialog(tab = "初始化"));
    parameter Medium.MassFlowRate m_flow_start = system.m_flow_start "质量流量初值" 
      annotation(Evaluate = true, Dialog(tab = "初始化"));

    FlowModel flowModel(
    redeclare final package Medium = Medium, 
      final n = 2, 
      states = {Medium.setState_phX(port_a.p, inStream(port_a.h_outflow), inStream(port_a.Xi_outflow)), 
      Medium.setState_phX(port_b.p, inStream(port_b.h_outflow), inStream(port_b.Xi_outflow))}, 
      vs = {port_a.m_flow / Medium.density(flowModel.states[1]) / flowModel.crossAreas[1], 
      -port_b.m_flow / Medium.density(flowModel.states[2]) / flowModel.crossAreas[2]} / nParallel, 
      final momentumDynamics = Types.Dynamics.SteadyState, 
      final allowFlowReversal = allowFlowReversal, 
      final p_a_start = p_a_start, 
      final p_b_start = p_b_start, 
      final m_flow_start = m_flow_start, 
      final nParallel = nParallel, 
      final pathLengths = {length}, 
      final crossAreas = {crossArea, crossArea}, 
      final dimensions = {4 * crossArea / perimeter, 4 * crossArea / perimeter}, 
      final roughnesses = {roughness, roughness}, 
      final dheights = {height_ab}, 
      final g = system.g) "流动模型" 
      annotation(Placement(transformation(extent = {{-38, -18}, {38, 18}})));
  equation
    // 质量平衡
    port_a.m_flow = flowModel.m_flows[1];
    0 = port_a.m_flow + port_b.m_flow;
    port_a.Xi_outflow = inStream(port_b.Xi_outflow);
    port_b.Xi_outflow = inStream(port_a.Xi_outflow);
    port_a.C_outflow = inStream(port_b.C_outflow);
    port_b.C_outflow = inStream(port_a.C_outflow);

    // 能量平衡，考虑势能变化
    // Wb_flow = v*A*dpdx + v*F_fric
    //         = m_flow/d/A * (A*dpdx + A*pressureLoss.dp_fg - F_grav)
    //         = m_flow/d/A * (-A*g*height_ab*d)
    //         = -m_flow*g*height_ab
    port_b.h_outflow = inStream(port_a.h_outflow) - system.g * height_ab;
    port_a.h_outflow = inStream(port_b.h_outflow) + system.g * height_ab;

    annotation(defaultComponentName = "pipe", 
      Documentation(info = "<html><p>
横截面恒定的直管模型，具有稳态质量、动量和能量平衡，即模型不储存质量或能量。
</p>
<p>
存在两种热力学状态，每个流体接口各有一种。 
</p>
<p>
在考虑动量流、摩擦力和重力的情况下，对两种状态进行了动量平衡计算。 
</p>
<p>
使用带有稳态动态设置的 <a href=\"modelica://Modelica.Fluid.Pipes.DynamicPipe\" target=\"\">DynamicPipe</a> 也能获得同样的结果。 目的是将容器或其他设备与存储设备进行简单连接，例如如下模型：
</p>
<ul><li>
<a href=\"modelica://Modelica.Fluid.Examples.Tanks.EmptyTanks\" target=\"\">Examples.Tanks.EmptyTanks</a></li>
<li>
<a href=\"modelica://Modelica.Fluid.Examples.InverseParameterization\" target=\"\">Examples.InverseParameterization</a></li>
</ul><p>
数值问题
</p>
<p>
使用stream连接器时，接口上的热力学状态通常由带存储组件或静态管道上下游来定义，流道中的其他非存储组件可能会因此产生状态转换。 
</p>
<p>
需要注意的是，如果直接连接多个静态管道或其他无存储组件的流动模型，通常会导致非线性方程系统。
</p>
</html>"  ));
  end StaticPipe;

  model DynamicPipe "储存质量和能量的动态管道模型"

    import Modelica.Fluid.Types.ModelStructure;

    // 继承 PartialStraightPipe
    extends Modelica.Fluid.Pipes.BaseClasses.PartialStraightPipe(
      final port_a_exposesState = (modelStructure == ModelStructure.av_b) or (modelStructure == ModelStructure.av_vb), 
      final port_b_exposesState = (modelStructure == ModelStructure.a_vb) or (modelStructure == ModelStructure.av_vb));

    // 继承 PartialTwoPortFlow
    extends BaseClasses.PartialTwoPortFlow(
      final lengths = fill(length / n, n), 
      final crossAreas = fill(crossArea, n), 
      final dimensions = fill(4 * crossArea / perimeter, n), 
      final roughnesses = fill(roughness, n), 
      final dheights = height_ab * dxs);

    // 壁面传热
    parameter Boolean use_HeatTransfer = false "true: 使用传热模型" 
      annotation(Dialog(tab = "假设", group = "传热"));
    replaceable model HeatTransfer = 
      Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.IdealFlowHeatTransfer 
      constrainedby 
      Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.PartialFlowHeatTransfer "壁面传热" 
      annotation(Dialog(tab = "假设", group = "传热", enable = use_HeatTransfer), choicesAllMatching = true);
    Interfaces.HeatPorts_a[nNodes] heatPorts if use_HeatTransfer 
      annotation(Placement(transformation(extent = {{-10, 45}, {10, 65}}), iconTransformation(extent = {{-30, 36}, 
      {32, 52}})));

    HeatTransfer heatTransfer(
    redeclare final package Medium = Medium, 
      final n = n, 
      final nParallel = nParallel, 
      final surfaceAreas = perimeter * lengths, 
      final lengths = lengths, 
      final dimensions = dimensions, 
      final roughnesses = roughnesses, 
      final states = mediums.state, 
      final vs = vs, 
      final use_k = use_HeatTransfer) "传热模型" 
      annotation(Placement(transformation(extent = {{-45, 20}, {-23, 42}})));
    final parameter Real[n] dxs = lengths / sum(lengths) "标准长度";
  equation
    Qb_flows = heatTransfer.Q_flows;
    // Wb_flow = v*A*dpdx + v*F_fric
    //         = v*A*dpdx + v*A*flowModel.dp_fg - v*A*dp_grav
    if n == 1 or useLumpedPressure then
      Wb_flows = dxs * ((vs * dxs) * (crossAreas * dxs) * ((port_b.p - port_a.p) + sum(flowModel.dps_fg) - system.g * (dheights * mediums.d))) * nParallel;
    else
      if modelStructure == ModelStructure.av_vb or modelStructure == ModelStructure.av_b then
        Wb_flows[2:n - 1] = {vs[i] * crossAreas[i] * ((mediums[i + 1].p - mediums[i - 1].p) / 2 + (flowModel.dps_fg[i - 1] + flowModel.dps_fg[i]) / 2 - system.g * dheights[i] * mediums[i].d) for i in 2:n - 1} * nParallel;
      else
        Wb_flows[2:n - 1] = {vs[i] * crossAreas[i] * ((mediums[i + 1].p - mediums[i - 1].p) / 2 + (flowModel.dps_fg[i] + flowModel.dps_fg[i + 1]) / 2 - system.g * dheights[i] * mediums[i].d) for i in 2:n - 1} * nParallel;
      end if;
      if modelStructure == ModelStructure.av_vb then
        Wb_flows[1] = vs[1] * crossAreas[1] * ((mediums[2].p - mediums[1].p) / 2 + flowModel.dps_fg[1] / 2 - system.g * dheights[1] * mediums[1].d) * nParallel;
        Wb_flows[n] = vs[n] * crossAreas[n] * ((mediums[n].p - mediums[n - 1].p) / 2 + flowModel.dps_fg[n - 1] / 2 - system.g * dheights[n] * mediums[n].d) * nParallel;
      elseif modelStructure == ModelStructure.av_b then
        Wb_flows[1] = vs[1] * crossAreas[1] * ((mediums[2].p - mediums[1].p) / 2 + flowModel.dps_fg[1] / 2 - system.g * dheights[1] * mediums[1].d) * nParallel;
        Wb_flows[n] = vs[n] * crossAreas[n] * ((port_b.p - mediums[n - 1].p) / 1.5 + flowModel.dps_fg[n - 1] / 2 + flowModel.dps_fg[n] - system.g * dheights[n] * mediums[n].d) * nParallel;
      elseif modelStructure == ModelStructure.a_vb then
        Wb_flows[1] = vs[1] * crossAreas[1] * ((mediums[2].p - port_a.p) / 1.5 + flowModel.dps_fg[1] + flowModel.dps_fg[2] / 2 - system.g * dheights[1] * mediums[1].d) * nParallel;
        Wb_flows[n] = vs[n] * crossAreas[n] * ((mediums[n].p - mediums[n - 1].p) / 2 + flowModel.dps_fg[n] / 2 - system.g * dheights[n] * mediums[n].d) * nParallel;
      elseif modelStructure == ModelStructure.a_v_b then
        Wb_flows[1] = vs[1] * crossAreas[1] * ((mediums[2].p - port_a.p) / 1.5 + flowModel.dps_fg[1] + flowModel.dps_fg[2] / 2 - system.g * dheights[1] * mediums[1].d) * nParallel;
        Wb_flows[n] = vs[n] * crossAreas[n] * ((port_b.p - mediums[n - 1].p) / 1.5 + flowModel.dps_fg[n] / 2 + flowModel.dps_fg[n + 1] - system.g * dheights[n] * mediums[n].d) * nParallel;
      else
        assert(false, "未知的模型结构");
      end if;
    end if;

    connect(heatPorts, heatTransfer.heatPorts) 
      annotation(Line(points = {{0, 55}, {0, 54}, {-34, 54}, {-34, 38.7}}, color = {191, 0, 0}));
    annotation(defaultComponentName = "pipe", 
      Documentation(info = "<html><p>
对于具有分布式质量、能量和动量平衡的直管模型，提供<a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.BalanceEquations\" target=\"\">UsersGuide.ComponentDefinition.BalanceEquations</a>.中制定的一维流体流动的完整平衡方程。
</p>
<p>
这个通用模型提供了大量可能的参数组合。为了降低模型的复杂性，可针对当前应用场景考虑定义或使用定制模型或两者同时使用，如 <a href=\"modelica://Modelica.Fluid.Examples.HeatExchanger.HeatExchangerSimulation\" target=\"\">HeatExchanger</a>。
</p>
<p>
DynamicPipe 采用有限体积法和动量平衡交错网格方案处理偏微分方程。管道沿流动路径分为n个等间距节块（节点nNodes）。默认值为 nNodes=2。这将在动态管道上产生两个集总质量和能量平衡以及一个集总动量平衡。
</p>
<p>
需要注意的是，如果动态管道直接相连，这通常会导致压力状态的高指数微分代数方程组或通过接口暴露热力学状态的存储模型。如果动态管道连接到一个压力不可分的模型可能导致无效，如具有规定跳跃压力的 Sources.Boundary_pT。在这种情况下，可以适当配置<code><strong>modelStructure</strong></code>，以便在管道的压力状态和非可变边界条件之间实现动量平衡。
</p>
<p>
默认模型结构<code><strong>modelStructure</strong></code>为 <code>av_vb</code>（参见 \"高级 \"选项卡）。<code>nNodes=1</code>, <code>modelStructure=a_v_b</code> 设置可获得最简单的对称配置，以避免潜在的高指数微分代数方程组，因为这可能会引入非线性方程系统。根据所配置的模型结构，第一个和最后一个管道节块或第一个和最后一个动量平衡的流道长度减半。
请参阅基类 <span style=\"color: rgb(51, 51, 51); background-color: rgb(243, 243, 243);\"> </span><a href=\"modelica:///Modelica.Fluid.Pipes.BaseClasses.PartialTwoPortFlow\" target=\"\" style=\"text-align: start; line-height: 1.5;\">Pipes.BaseClasses.PartialTwoPortFlow</a> 的文档，其中也包括非对称配置。
</p>
<p>
传热<code><strong>HeatTransfer</strong></code>组件指定能量平衡的源项 <code>Qb_flows</code>，默认组件使用一个恒定系数，用于散流与通过热接口 <code>heatPorts</code> 显示的节块边界之间的传热。传热模型是可替换的，可以与从<a href=\"modelica:///Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.PartialFlowHeatTransfer\" target=\"\" style=\"text-align: start; line-height: 1.5;\">BaseClasses.HeatTransfer.PartialFlowHeatTransfer<span style=\"color: rgb(51, 51, 51); background-color: rgb(243, 243, 243);\">.</span></a>基类 扩展而来的任何模型进行替换。
</p>
<p>
其预期用途是复杂的管道网络和其他流动装置，如阀门。请参见：
</p>
<ul><li>
<a href=\"modelica://Modelica.Fluid.Examples.BranchingDynamicPipes\" target=\"\">Examples.BranchingDynamicPipes</a></li>
<li>
<a href=\"modelica://Modelica.Fluid.Examples.IncompressibleFluidNetwork\" target=\"\">Examples.IncompressibleFluidNetwork</a>.</li>
</ul></html>"), 
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {
      Rectangle(
      extent = {{-100, 44}, {100, -44}}, 
      fillPattern = FillPattern.HorizontalCylinder, 
      fillColor = {0, 127, 255}), 
      Ellipse(
      extent = {{-72, 10}, {-52, -10}}, 
      fillPattern = FillPattern.Solid), 
      Ellipse(
      extent = {{50, 10}, {70, -10}}, 
      fillPattern = FillPattern.Solid), 
      Text(
      extent = {{-48, 15}, {46, -20}}, 
      textString = "%nNodes")}), 
      Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Rectangle(
      extent = {{-100, 60}, {100, 50}}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Backward), 
      Rectangle(
      extent = {{-100, -50}, {100, -60}}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Backward), 
      Line(
      points = {{100, 45}, {100, 50}}, 
      arrow = {Arrow.None, Arrow.Filled}, 
      pattern = LinePattern.Dot), 
      Line(
      points = {{0, 45}, {0, 50}}, 
      arrow = {Arrow.None, Arrow.Filled}, 
      pattern = LinePattern.Dot), 
      Line(
      points = {{100, -45}, {100, -50}}, 
      arrow = {Arrow.None, Arrow.Filled}, 
      pattern = LinePattern.Dot), 
      Line(
      points = {{0, -45}, {0, -50}}, 
      arrow = {Arrow.None, Arrow.Filled}, 
      pattern = LinePattern.Dot), 
      Line(
      points = {{-50, 60}, {-50, 50}}, 
      pattern = LinePattern.Dot), 
      Line(
      points = {{50, 60}, {50, 50}}, 
      pattern = LinePattern.Dot), 
      Line(
      points = {{0, -50}, {0, -60}}, 
      pattern = LinePattern.Dot)}));
  end DynamicPipe;

  package BaseClasses 
    "Pipes库中使用的基类（用于构建新组件模型）"
    extends Modelica.Icons.BasesPackage;
    partial model PartialStraightPipe "直管模型基类"
      extends Modelica.Fluid.Interfaces.PartialTwoPort;
      // 几何
      // 注：将 nParalle 定义为 Real 类型，以支持逆计算
      parameter Real nParallel(min = 1) = 1 "相同并联管道的数量" 
        annotation(Dialog(group = "几何"));
      parameter SI.Length length "长度" 
        annotation(Dialog(tab = "常规", group = "几何"));
      parameter Boolean isCircular = true 
        "true: 横截面积为圆形" 
        annotation(Evaluate, Dialog(tab = "常规", group = "几何"));
      parameter SI.Diameter diameter "圆形管道的直径" 
        annotation(Dialog(group = "常规", enable = isCircular));
      parameter SI.Area crossArea = Modelica.Constants.pi * diameter * diameter / 4 
        "内部横截面积" 
        annotation(Dialog(tab = "常规", group = "几何", enable = not isCircular));
      parameter SI.Length perimeter(min = 0) = Modelica.Constants.pi * diameter 
        "内径" 
        annotation(Dialog(tab = "常规", group = "几何", enable = not isCircular));
      parameter Modelica.Fluid.Types.Roughness roughness = 2.5e-5 
        "平均表面粗糙度(默认:光滑钢管)" 
        annotation(Dialog(group = "几何"));
      final parameter SI.Volume V = crossArea * length * nParallel "容积";

      // 静压头
      parameter SI.Length height_ab = 0 "port_b 高度 - port_b 高度" 
        annotation(Dialog(group = "静压头"));

      // 压降
      replaceable model FlowModel = 
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow 
        constrainedby 
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.PartialStaggeredFlowModel 
        "壁面摩擦，重力，动量" 
        annotation(Dialog(group = "压降"), choicesAllMatching = true);
    equation
      assert(length >= height_ab, "参数 length 必须大于或等于 height_ab");

      annotation(defaultComponentName = "pipe", Icon(coordinateSystem(
        preserveAspectRatio = false, 
        extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(
        extent = {{-100, 40}, {100, -40}}, 
        fillPattern = FillPattern.Solid, 
        fillColor = {95, 95, 95}, 
        pattern = LinePattern.None), Rectangle(
        extent = {{-100, 44}, {100, -44}}, 
        fillPattern = FillPattern.HorizontalCylinder, 
        fillColor = {0, 127, 255})}), Documentation(info = "<html><p>
一维流动模型的基类。它实例化了一个PartialTwoPort，增加了参数接口和图标图形。
</p>
</html>"  ));
    end PartialStraightPipe;

    partial model PartialTwoPortFlow "离散流动模型基类"

      import Modelica.Fluid.Types.ModelStructure;

      // 继承 PartialTwoPort
      extends Modelica.Fluid.Interfaces.PartialTwoPort(
        final port_a_exposesState = (modelStructure == ModelStructure.av_b) or (modelStructure == ModelStructure.av_vb), 
        final port_b_exposesState = (modelStructure == ModelStructure.a_vb) or (modelStructure == ModelStructure.av_vb));

      // 继承 PartialDistributedVolume
      extends Modelica.Fluid.Interfaces.PartialDistributedVolume(
        final n = nNodes, 
        final fluidVolumes = {crossAreas[i] * lengths[i] for i in 1:n} * nParallel);

      // 几何参数
      parameter Real nParallel(min = 1) = 1 "相同并联设备的数量" 
        annotation(Dialog(group = "几何"));
      parameter SI.Length[n] lengths "管道节块长度" 
        annotation(Dialog(group = "几何"));
      parameter SI.Area[n] crossAreas "管道节块的横截面积" 
        annotation(Dialog(group = "几何"));
      parameter SI.Length[n] dimensions "管道节块的水力直径" 
        annotation(Dialog(group = "几何"));
      parameter Modelica.Fluid.Types.Roughness[n] roughnesses "表面平均粗糙度" 
        annotation(Dialog(group = "几何"));

      // 静压头
      parameter SI.Length[n] dheights = zeros(n) "管道节块高度差" 
        annotation(Dialog(group = "静压头"), Evaluate = true);

      // 假设
      parameter Types.Dynamics momentumDynamics = system.momentumDynamics "动量平衡" 
        annotation(Evaluate = true, Dialog(tab = "假设", group = "动力学"));

      // 初始化
      parameter Medium.MassFlowRate m_flow_start = system.m_flow_start "质量流量初值" 
        annotation(Evaluate = true, Dialog(tab = "初始化"));

      // 离散化
      parameter Integer nNodes(min = 1) = 2 "离散流体容积的数量" 
        annotation(Dialog(tab = "高级"), Evaluate = true);

      parameter Types.ModelStructure modelStructure = Types.ModelStructure.av_vb 
        "确定接口是否存在流量或容积模型" 
        annotation(Dialog(tab = "高级"), Evaluate = true);

      parameter Boolean useLumpedPressure = false "true: 将压力状态合并" 
        annotation(Dialog(tab = "高级"), Evaluate = true);
      final parameter Integer nFM = if useLumpedPressure then nFMLumped else nFMDistributed "flowModel 中流动模型的数量";
      final parameter Integer nFMDistributed = if modelStructure == Types.ModelStructure.a_v_b then n + 1 else if (modelStructure == Types.ModelStructure.a_vb or modelStructure == Types.ModelStructure.av_b) then n else n - 1 "离散流动模型的数量";
      final parameter Integer nFMLumped = if modelStructure == Types.ModelStructure.a_v_b then 2 else 1 "集总流动模型的数量";
      final parameter Integer iLumped = integer(n / 2) + 1 
        "将压力状态合并时使用(useLumpedPressure)，为具有代表性状态的控制量指数" 
        annotation(Evaluate = true);

      // 高级模型选项
      parameter Boolean useInnerPortProperties = false 
        "true: 从内部控制容积获取流体模型的接口特性" 
        annotation(Dialog(tab = "高级"), Evaluate = true);
      Medium.ThermodynamicState state_a 
        "容积外部接口 port_a 定义的状态";
      Medium.ThermodynamicState state_b 
        "容积外部接口 port_b 定义的状态";
      Medium.ThermodynamicState[nFM + 1] statesFM 
        "flowModel 模型的状态向量";

      // 压降模型
      replaceable model FlowModel = 
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow 
        constrainedby 
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.PartialStaggeredFlowModel 
        "壁面摩擦，重力，动量" 
        annotation(Dialog(group = "压降"), choicesAllMatching = true);


      FlowModel flowModel(
      redeclare final package Medium = Medium, 
        final n = nFM + 1, 
        final states = statesFM, 
        final vs = vsFM, 
        final momentumDynamics = momentumDynamics, 
        final allowFlowReversal = allowFlowReversal, 
        final p_a_start = p_a_start, 
        final p_b_start = p_b_start, 
        final m_flow_start = m_flow_start, 
        final nParallel = nParallel, 
        final pathLengths = pathLengths, 
        final crossAreas = crossAreasFM, 
        final dimensions = dimensionsFM, 
        final roughnesses = roughnessesFM, 
        final dheights = dheightsFM, 
        final g = system.g) "流动模型" 
        annotation(Placement(transformation(extent = {{-77, -37}, {75, -19}})));

      // 流量
      Medium.MassFlowRate[n + 1] m_flows(
        each min = if allowFlowReversal then -Modelica.Constants.inf else 0, 
        each start = m_flow_start) 
        "通过节块边界的质量流量";
      Medium.MassFlowRate[n + 1,Medium.nXi] mXi_flows 
        "通过节块边界的独立质量流量";
      Medium.MassFlowRate[n + 1,Medium.nC] mC_flows 
        "通过节块边界的微量物质质量流量";
      Medium.EnthalpyFlowRate[n + 1] H_flows 
        "通过节块边界的焓流";

      SI.Velocity[n] vs = {0.5 * (m_flows[i] + m_flows[i + 1]) / mediums[i].d / crossAreas[i] for i in 1:n} / nParallel 
        "管道节块的平均流速";

      // 模型结构相关的流动几何
    protected
      SI.Length[nFM] pathLengths "流道长度";
      SI.Length[nFM] dheightsFM "管道节块之间的高度差异";
      SI.Area[nFM + 1] crossAreasFM "管道节块的横截面积";
      SI.Velocity[nFM + 1] vsFM "管道节块的平均流速";
      SI.Length[nFM + 1] dimensionsFM "管道节块的水力直径";
      Modelica.Fluid.Types.Roughness[nFM + 1] roughnessesFM "表面平均粗糙度";

    equation
      assert(nNodes > 1 or modelStructure <> ModelStructure.av_vb, 
        "对于模型结构 av_vb 而言，nNodes 至少需要为 2，否则流模型会消失！");
      // 根据模型结构，对流动模型的几何进行交错网格离散处理
      if useLumpedPressure then
        if modelStructure <> ModelStructure.a_v_b then
          pathLengths[1] = sum(lengths);
          dheightsFM[1] = sum(dheights);
          if n == 1 then
            crossAreasFM[1:2] = {crossAreas[1], crossAreas[1]};
            dimensionsFM[1:2] = {dimensions[1], dimensions[1]};
            roughnessesFM[1:2] = {roughnesses[1], roughnesses[1]};
          else  // n > 1
            crossAreasFM[1:2] = {sum(crossAreas[1:iLumped - 1]) / (iLumped - 1), sum(crossAreas[iLumped:n]) / (n - iLumped + 1)};
            dimensionsFM[1:2] = {sum(dimensions[1:iLumped - 1]) / (iLumped - 1), sum(dimensions[iLumped:n]) / (n - iLumped + 1)};
            roughnessesFM[1:2] = {sum(roughnesses[1:iLumped - 1]) / (iLumped - 1), sum(roughnesses[iLumped:n]) / (n - iLumped + 1)};
          end if;
        else
          if n == 1 then
            pathLengths[1:2] = {lengths[1] / 2, lengths[1] / 2};
            dheightsFM[1:2] = {dheights[1] / 2, dheights[1] / 2};
            crossAreasFM[1:3] = {crossAreas[1], crossAreas[1], crossAreas[1]};
            dimensionsFM[1:3] = {dimensions[1], dimensions[1], dimensions[1]};
            roughnessesFM[1:3] = {roughnesses[1], roughnesses[1], roughnesses[1]};
          else  // n > 1
            pathLengths[1:2] = {sum(lengths[1:iLumped - 1]), sum(lengths[iLumped:n])};
            dheightsFM[1:2] = {sum(dheights[1:iLumped - 1]), sum(dheights[iLumped:n])};
            crossAreasFM[1:3] = {sum(crossAreas[1:iLumped - 1]) / (iLumped - 1), sum(crossAreas) / n, sum(crossAreas[iLumped:n]) / (n - iLumped + 1)};
            dimensionsFM[1:3] = {sum(dimensions[1:iLumped - 1]) / (iLumped - 1), sum(dimensions) / n, sum(dimensions[iLumped:n]) / (n - iLumped + 1)};
            roughnessesFM[1:3] = {sum(roughnesses[1:iLumped - 1]) / (iLumped - 1), sum(roughnesses) / n, sum(roughnesses[iLumped:n]) / (n - iLumped + 1)};
          end if;
        end if;
      else
        if modelStructure == ModelStructure.av_vb then
          //nFM = n-1
          if n == 2 then
            pathLengths[1] = lengths[1] + lengths[2];
            dheightsFM[1] = dheights[1] + dheights[2];
          else
            pathLengths[1:n - 1] = cat(1, {lengths[1] + 0.5 * lengths[2]}, 0.5 * (lengths[2:n - 2] + lengths[3:n - 1]), {0.5 * lengths[n - 1] + lengths[n]});
            dheightsFM[1:n - 1] = cat(1, {dheights[1] + 0.5 * dheights[2]}, 0.5 * (dheights[2:n - 2] + dheights[3:n - 1]), {0.5 * dheights[n - 1] + dheights[n]});
          end if;
          crossAreasFM[1:n] = crossAreas;
          dimensionsFM[1:n] = dimensions;
          roughnessesFM[1:n] = roughnesses;
        elseif modelStructure == ModelStructure.av_b then
          //nFM = n
          pathLengths[1:n] = lengths;
          dheightsFM[1:n] = dheights;
          crossAreasFM[1:n + 1] = cat(1, crossAreas[1:n], {crossAreas[n]});
          dimensionsFM[1:n + 1] = cat(1, dimensions[1:n], {dimensions[n]});
          roughnessesFM[1:n + 1] = cat(1, roughnesses[1:n], {roughnesses[n]});
        elseif modelStructure == ModelStructure.a_vb then
          //nFM = n
          pathLengths[1:n] = lengths;
          dheightsFM[1:n] = dheights;
          crossAreasFM[1:n + 1] = cat(1, {crossAreas[1]}, crossAreas[1:n]);
          dimensionsFM[1:n + 1] = cat(1, {dimensions[1]}, dimensions[1:n]);
          roughnessesFM[1:n + 1] = cat(1, {roughnesses[1]}, roughnesses[1:n]);
        elseif modelStructure == ModelStructure.a_v_b then
          //nFM = n+1;
          pathLengths[1:n + 1] = cat(1, {0.5 * lengths[1]}, 0.5 * (lengths[1:n - 1] + lengths[2:n]), {0.5 * lengths[n]});
          dheightsFM[1:n + 1] = cat(1, {0.5 * dheights[1]}, 0.5 * (dheights[1:n - 1] + dheights[2:n]), {0.5 * dheights[n]});
          crossAreasFM[1:n + 2] = cat(1, {crossAreas[1]}, crossAreas[1:n], {crossAreas[n]});
          dimensionsFM[1:n + 2] = cat(1, {dimensions[1]}, dimensions[1:n], {dimensions[n]});
          roughnessesFM[1:n + 2] = cat(1, {roughnesses[1]}, roughnesses[1:n], {roughnesses[n]});
        else
          assert(false, "未知的模型结构");
        end if;
      end if;

      // 质量和能量平衡的源/汇项
      for i in 1:n loop
        mb_flows[i] = m_flows[i] - m_flows[i + 1];
        mbXi_flows[i,:] = mXi_flows[i,:] - mXi_flows[i + 1,:];
        mbC_flows[i,:] = mC_flows[i,:] - mC_flows[i + 1,:];
        Hb_flows[i] = H_flows[i] - H_flows[i + 1];
      end for;

      // 分布式流量, 上游离散化
      for i in 2:n loop
        H_flows[i] = semiLinear(m_flows[i], mediums[i - 1].h, mediums[i].h);
        mXi_flows[i,:] = semiLinear(m_flows[i], mediums[i - 1].Xi, mediums[i].Xi);
        mC_flows[i,:] = semiLinear(m_flows[i], Cs[i - 1,:], Cs[i,:]);
      end for;
      H_flows[1] = semiLinear(port_a.m_flow, inStream(port_a.h_outflow), mediums[1].h);
      H_flows[n + 1] = -semiLinear(port_b.m_flow, inStream(port_b.h_outflow), mediums[n].h);
      mXi_flows[1,:] = semiLinear(port_a.m_flow, inStream(port_a.Xi_outflow), mediums[1].Xi);
      mXi_flows[n + 1,:] = -semiLinear(port_b.m_flow, inStream(port_b.Xi_outflow), mediums[n].Xi);
      mC_flows[1,:] = semiLinear(port_a.m_flow, inStream(port_a.C_outflow), Cs[1,:]);
      mC_flows[n + 1,:] = -semiLinear(port_b.m_flow, inStream(port_b.C_outflow), Cs[n,:]);

      // 边界条件
      port_a.m_flow = m_flows[1];
      port_b.m_flow = -m_flows[n + 1];
      port_a.h_outflow = mediums[1].h;
      port_b.h_outflow = mediums[n].h;
      port_a.Xi_outflow = mediums[1].Xi;
      port_b.Xi_outflow = mediums[n].Xi;
      port_a.C_outflow = Cs[1,:];
      port_b.C_outflow = Cs[n,:];
      // 如果 C 以容积存储, 则下面的两个等式不正确。
      // C 与 Xi 相同看待。
      //port_a.C_outflow = inStream(port_b.C_outflow);
      //port_b.C_outflow = inStream(port_a.C_outflow);

      if useInnerPortProperties and n > 0 then
        state_a = Medium.setState_phX(port_a.p, mediums[1].h, mediums[1].Xi);
        state_b = Medium.setState_phX(port_b.p, mediums[n].h, mediums[n].Xi);
      else
        state_a = Medium.setState_phX(port_a.p, inStream(port_a.h_outflow), inStream(port_a.Xi_outflow));
        state_b = Medium.setState_phX(port_b.p, inStream(port_b.h_outflow), inStream(port_b.Xi_outflow));
      end if;

      // 流量模型的交错网格离散化, 这取决于模型结构
      if useLumpedPressure then
        if modelStructure <> ModelStructure.av_vb then
          // 压力相同
          fill(mediums[1].p, n - 1) = mediums[2:n].p;
        elseif n > 2 then
          // 需要两个压力
          fill(mediums[1].p, iLumped - 2) = mediums[2:iLumped - 1].p;
          fill(mediums[n].p, n - iLumped) = mediums[iLumped:n - 1].p;
        end if;
        if modelStructure == ModelStructure.av_vb then
          port_a.p = mediums[1].p;
          statesFM[1] = mediums[1].state;
          m_flows[iLumped] = flowModel.m_flows[1];
          statesFM[2] = mediums[n].state;
          port_b.p = mediums[n].p;
          vsFM[1] = vs[1:iLumped - 1] * lengths[1:iLumped - 1] / sum(lengths[1:iLumped - 1]);
          vsFM[2] = vs[iLumped:n] * lengths[iLumped:n] / sum(lengths[iLumped:n]);
        elseif modelStructure == ModelStructure.av_b then
          port_a.p = mediums[1].p;
          statesFM[1] = mediums[iLumped].state;
          statesFM[2] = state_b;
          m_flows[n + 1] = flowModel.m_flows[1];
          vsFM[1] = vs * lengths / sum(lengths);
          vsFM[2] = m_flows[n + 1] / Medium.density(state_b) / crossAreas[n] / nParallel;
        elseif modelStructure == ModelStructure.a_vb then
          m_flows[1] = flowModel.m_flows[1];
          statesFM[1] = state_a;
          statesFM[2] = mediums[iLumped].state;
          port_b.p = mediums[n].p;
          vsFM[1] = m_flows[1] / Medium.density(state_a) / crossAreas[1] / nParallel;
          vsFM[2] = vs * lengths / sum(lengths);
        elseif modelStructure == ModelStructure.a_v_b then
          m_flows[1] = flowModel.m_flows[1];
          statesFM[1] = state_a;
          statesFM[2] = mediums[iLumped].state;
          statesFM[3] = state_b;
          m_flows[n + 1] = flowModel.m_flows[2];
          vsFM[1] = m_flows[1] / Medium.density(state_a) / crossAreas[1] / nParallel;
          vsFM[2] = vs * lengths / sum(lengths);
          vsFM[3] = m_flows[n + 1] / Medium.density(state_b) / crossAreas[n] / nParallel;
        else
          assert(false, "未知的模型结构");
        end if;
      else
        if modelStructure == ModelStructure.av_vb then
          //nFM = n-1
          statesFM[1:n] = mediums[1:n].state;
          m_flows[2:n] = flowModel.m_flows[1:n - 1];
          vsFM[1:n] = vs;
          port_a.p = mediums[1].p;
          port_b.p = mediums[n].p;
        elseif modelStructure == ModelStructure.av_b then
          //nFM = n
          statesFM[1:n] = mediums[1:n].state;
          statesFM[n + 1] = state_b;
          m_flows[2:n + 1] = flowModel.m_flows[1:n];
          vsFM[1:n] = vs;
          vsFM[n + 1] = m_flows[n + 1] / Medium.density(state_b) / crossAreas[n] / nParallel;
          port_a.p = mediums[1].p;
        elseif modelStructure == ModelStructure.a_vb then
          //nFM = n
          statesFM[1] = state_a;
          statesFM[2:n + 1] = mediums[1:n].state;
          m_flows[1:n] = flowModel.m_flows[1:n];
          vsFM[1] = m_flows[1] / Medium.density(state_a) / crossAreas[1] / nParallel;
          vsFM[2:n + 1] = vs;
          port_b.p = mediums[n].p;
        elseif modelStructure == ModelStructure.a_v_b then
          //nFM = n+1
          statesFM[1] = state_a;
          statesFM[2:n + 1] = mediums[1:n].state;
          statesFM[n + 2] = state_b;
          m_flows[1:n + 1] = flowModel.m_flows[1:n + 1];
          vsFM[1] = m_flows[1] / Medium.density(state_a) / crossAreas[1] / nParallel;
          vsFM[2:n + 1] = vs;
          vsFM[n + 2] = m_flows[n + 1] / Medium.density(state_b) / crossAreas[n] / nParallel;
        else
          assert(false, "未知的模型结构");
        end if;
      end if;

      annotation(defaultComponentName = "pipe", 
        Documentation(info = "<html><p>
离散流动模型的基类。总体积沿流动路径被分成 n 个管道节块。默认值为 nNodes=2。
</p>
<h4>质量和能量平衡</h4><p>
质量和能量平衡继承自 <a href=\"modelica://Modelica.Fluid.Interfaces.PartialDistributedVolume\" target=\"\">Interfaces.PartialDistributedVolume</a>。
根据有限体积法，在每个节块形成一个总质量平衡和一个能量平衡。如果介质中含有一种以上的成分，则需要添加物质质量平衡。
</p>
<p>
扩展模型需要定义几何形状和管道节块之间的高度差（静压头）。此外，还需要为离散的能量平衡定义两个源项向量：
</p>
<ul><li>
<code><strong>Qb_flows[nNodes]</strong></code>，热流源项，例如，跨节块边界的传热</li>
<li>
<code><strong>Wb_flows[nNodes]</strong></code>，做功源项</li>
</ul><h4>动量平衡</h4><p>
动量平衡由 <code><strong>FlowModel</strong></code> 组件决定，
该组件可以用从 <a href=\"modelica://Modelica.Fluid.Pipes.BaseClasses.FlowModels.PartialStaggeredFlowModel\" target=\"\">BaseClasses.FlowModels.PartialStaggeredFlowModel</a> 派生的任何模型替换。 
默认设置为 <a href=\"modelica://Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow\" target=\"\">DetailedPipeFlow</a>。
</p>
<p>
考虑到
</p>
<ul><li>
摩擦和其他耗散损失造成的压降</li>
<li>
非水平设备的重力效应</li>
<li>
在 <code>flowModel.use_Ib_flows</code> 为 true 的情况下，由于横截面积或流体密度的变化而导致的沿流动路径的流速变化。</li>
</ul><h4>模型结构</h4><p>
动量平衡是按照交错网格法在流道的各节块边界上进行计算的。可配置的模型结构 <code><strong>modelStructure</strong></code> 决定 <code>port_a</code> 和 <code>port_b</code> 边界条件的表述。选项（默认：av_vb）包括：
</p>
<ul><li>
<code>av_vb</code>: 对称设置，n 节点管道节块之间有 n-1 个节点的动量平衡。<code>port_a</code> 和 <code>port_b</code> 分别显示第一个和最后一个热力学状态。
因此，连接两个或更多流动装置可能会对相连管道节块的压力产生高指数微分代数方程。</li>
<li>
<code>a_v_b</code>: 另一种对称设置，在 n 个节点管道节块上设置 n+1 个动量平衡。在 <code>port_a</code> 和第一个管道节块之间以及最后一个管道节块和 <code>port_b</code> 之间各设置一半的动量平衡。
因此，连接两个或两个以上的流体设备会在接口处产生代数压力。为接口压力指定良好的初值对于大型非线性方程系统的求解至关重要。</li>
<li>
<code>av_b</code>: 非对称设置 n 个节点的动量平衡、第 n 个容积和 <code>port_b</code> 之间的动量平衡、势压状态在 <code>port_a</code> Asymmetric setting with nNodes momentum balances, one between nth volume and <code>port_b</code>, potential pressure state at <code>port_a</code></li>
<li>
<code>a_vb</code>: 非对称设置 n 个节点动量平衡，一个在第一容积和 <code>port_a</code> 之间，势压状态在 <code>port_b</code> Asymmetric setting with nNodes momentum balance, one between first volume and <code>port_a</code>, potential pressure state at <code>port_b</code></li>
</ul><p>
当连接两个部件（如两根管道）时，连接点上的动量平衡简化为
</p>
<pre><code >pipe1.port_b.p = pipe2.port_a.p</code></pre><p>
只有当连接两侧的流速保持相同时，这种表达才正确。 如果因直径或流体密度发生明显变化后带来的影响（如动能变化）不能忽略，则应考虑使用拟合。 
这也能兼顾与连接点实际几何形状相关的摩擦损失。
</p>
</html>"    , revisions = "<html>
<ul>
<li><em>5 Dec 2008</em>
by Michael Wetter:<br>
修改了微量物质的质量平衡。使用新公式，微量物质的质量 <code>mC</code> 与组分 <code>mXi</code> 的存储方式相同。</li>
<li><em>Dec 2008</em>
by R&uuml;diger Franke:<br>
从原始的 DistributedPipe 模型派生的模型
<ul>
<li>将质量和能量平衡移至 PartialDistributedVolume</li>
<li>引入可替换的压力损失模型</li>
<li>将所有模型结构和集中压力结合为一个模型</li>
<li>新模型结构av_vb，替代之前的avb</li>
</ul></li>
<li><em>04 Mar 2006</em>
by Katrin Pr&ouml;l&szlig;:<br>
模型添加到流体库中</li>
</ul>
</html>"    ), 
        Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
        100}}), graphics = {Ellipse(
        extent = {{-72, 10}, {-52, -10}}, 
        fillPattern = FillPattern.Solid), Ellipse(
        extent = {{50, 10}, {70, -10}}, 
        fillPattern = FillPattern.Solid)}), 
        Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
        100, 100}}), graphics = {
        Polygon(
        points = {{-100, -50}, {-100, 50}, {100, 60}, {100, -60}, {-100, -50}}, 
        fillColor = {215, 215, 215}, 
        fillPattern = FillPattern.Solid, 
        pattern = LinePattern.None), 
        Polygon(
        points = {{-34, -53}, {-34, 53}, {34, 57}, {34, -57}, {-34, -53}}, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid, 
        pattern = LinePattern.None), 
        Line(
        points = {{-100, -50}, {-100, 50}}, 
        arrow = {Arrow.Filled, Arrow.Filled}, 
        pattern = LinePattern.Dot), 
        Text(
        extent = {{-99, 36}, {-69, 30}}, 
        textColor = {0, 0, 255}, 
        textString = "crossAreas[1]"), 
        Line(
        points = {{-100, 70}, {-34, 70}}, 
        arrow = {Arrow.Filled, Arrow.Filled}, 
        pattern = LinePattern.Dot), 
        Text(
        extent = {{0, 36}, {40, 30}}, 
        textColor = {0, 0, 255}, 
        textString = "crossAreas[2:n-1]"), 
        Line(
        points = {{100, -60}, {100, 60}}, 
        arrow = {Arrow.Filled, Arrow.Filled}, 
        pattern = LinePattern.Dot), 
        Text(
        extent = {{100.5, 36}, {130.5, 30}}, 
        textColor = {0, 0, 255}, 
        textString = "crossAreas[n]"), 
        Line(
        points = {{-34, 52}, {-34, -53}}, 
        pattern = LinePattern.Dash), 
        Line(
        points = {{34, 57}, {34, -57}}, 
        pattern = LinePattern.Dash), 
        Line(
        points = {{34, 70}, {100, 70}}, 
        arrow = {Arrow.Filled, Arrow.Filled}, 
        pattern = LinePattern.Dot), 
        Line(
        points = {{-34, 70}, {34, 70}}, 
        arrow = {Arrow.Filled, Arrow.Filled}, 
        pattern = LinePattern.Dot), 
        Text(
        extent = {{-30, 77}, {30, 71}}, 
        textColor = {0, 0, 255}, 
        textString = "lengths[2:n-1]"), 
        Line(
        points = {{-100, -70}, {0, -70}}, 
        arrow = {Arrow.None, Arrow.Filled}), 
        Text(
        extent = {{-80, -63}, {-20, -69}}, 
        textColor = {0, 0, 255}, 
        textString = "flowModel.dps_fg[1]"), 
        Line(
        points = {{0, -70}, {100, -70}}, 
        arrow = {Arrow.None, Arrow.Filled}), 
        Text(
        extent = {{20.5, -63}, {80, -69}}, 
        textColor = {0, 0, 255}, 
        textString = "flowModel.dps_fg[2:n-1]"), 
        Line(
        points = {{-95, 0}, {-5, 0}}, 
        arrow = {Arrow.None, Arrow.Filled}), 
        Text(
        extent = {{-62, 7}, {-32, 1}}, 
        textColor = {0, 0, 255}, 
        textString = "m_flows[2]"), 
        Line(
        points = {{5, 0}, {95, 0}}, 
        arrow = {Arrow.None, Arrow.Filled}), 
        Text(
        extent = {{34, 7}, {64, 1}}, 
        textColor = {0, 0, 255}, 
        textString = "m_flows[3:n]"), 
        Line(
        points = {{-150, 0}, {-105, 0}}, 
        arrow = {Arrow.None, Arrow.Filled}), 
        Line(
        points = {{105, 0}, {150, 0}}, 
        arrow = {Arrow.None, Arrow.Filled}), 
        Text(
        extent = {{-140, 7}, {-110, 1}}, 
        textColor = {0, 0, 255}, 
        textString = "m_flows[1]"), 
        Text(
        extent = {{111, 7}, {141, 1}}, 
        textColor = {0, 0, 255}, 
        textString = "m_flows[n+1]"), 
        Text(
        extent = {{35, -92}, {100, -98}}, 
        textColor = {0, 0, 255}, 
        textString = "(ModelStructure av_vb, n=3)"), 
        Line(
        points = {{-100, -50}, {-100, -86}}, 
        pattern = LinePattern.Dot), 
        Line(
        points = {{0, -55}, {0, -86}}, 
        pattern = LinePattern.Dot), 
        Line(
        points = {{100, -60}, {100, -86}}, 
        pattern = LinePattern.Dot), 
        Ellipse(
        extent = {{-5, 5}, {5, -5}}, 
        pattern = LinePattern.None, 
        fillPattern = FillPattern.Solid), 
        Text(
        extent = {{3, -4}, {33, -10}}, 
        textColor = {0, 0, 255}, 
        textString = "states[2:n-1]"), 
        Ellipse(
        extent = {{95, 5}, {105, -5}}, 
        pattern = LinePattern.None, 
        fillPattern = FillPattern.Solid), 
        Text(
        extent = {{104, -4}, {124, -10}}, 
        textColor = {0, 0, 255}, 
        textString = "states[n]"), 
        Ellipse(
        extent = {{-105, 5}, {-95, -5}}, 
        pattern = LinePattern.None, 
        fillPattern = FillPattern.Solid), 
        Text(
        extent = {{-96, -4}, {-76, -10}}, 
        textColor = {0, 0, 255}, 
        textString = "states[1]"), 
        Text(
        extent = {{-99.5, 30}, {-69.5, 24}}, 
        textColor = {0, 0, 255}, 
        textString = "dimensions[1]"), 
        Text(
        extent = {{-0.5, 30}, {40, 24}}, 
        textColor = {0, 0, 255}, 
        textString = "dimensions[2:n-1]"), 
        Text(
        extent = {{100.5, 30}, {130.5, 24}}, 
        textColor = {0, 0, 255}, 
        textString = "dimensions[n]"), 
        Line(
        points = {{-34, 73}, {-34, 52}}, 
        pattern = LinePattern.Dot), 
        Line(
        points = {{34, 73}, {34, 57}}, 
        pattern = LinePattern.Dot), 
        Line(
        points = {{-100, 50}, {100, 60}}, 
        thickness = 0.5), 
        Line(
        points = {{-100, -50}, {100, -60}}, 
        thickness = 0.5), 
        Line(
        points = {{-100, 73}, {-100, 50}}, 
        pattern = LinePattern.Dot), 
        Line(
        points = {{100, 73}, {100, 60}}, 
        pattern = LinePattern.Dot), 
        Line(
        points = {{0, -55}, {0, 55}}, 
        arrow = {Arrow.Filled, Arrow.Filled}, 
        pattern = LinePattern.Dot), 
        Line(
        points = {{-34, 11}, {34, 11}}, 
        arrow = {Arrow.None, Arrow.Filled}), 
        Text(
        extent = {{5, 18}, {25, 12}}, 
        textColor = {0, 0, 255}, 
        textString = "vs[2:n-1]"), 
        Text(
        extent = {{-72, 18}, {-62, 12}}, 
        textColor = {0, 0, 255}, 
        textString = "vs[1]"), 
        Line(
        points = {{-100, 11}, {-34, 11}}, 
        arrow = {Arrow.None, Arrow.Filled}), 
        Text(
        extent = {{63, 18}, {73, 12}}, 
        textColor = {0, 0, 255}, 
        textString = "vs[n]"), 
        Line(
        points = {{34, 11}, {100, 11}}, 
        arrow = {Arrow.None, Arrow.Filled}), 
        Text(
        extent = {{-80, -75}, {-20, -81}}, 
        textColor = {0, 0, 255}, 
        textString = "flowModel.pathLengths[1]"), 
        Line(
        points = {{-100, -82}, {0, -82}}, 
        arrow = {Arrow.Filled, Arrow.Filled}), 
        Line(
        points = {{0, -82}, {100, -82}}, 
        arrow = {Arrow.Filled, Arrow.Filled}), 
        Text(
        extent = {{15, -75}, {85, -81}}, 
        textColor = {0, 0, 255}, 
        textString = "flowModel.pathLengths[2:n-1]"), 
        Text(
        extent = {{-100, 77}, {-37, 71}}, 
        textColor = {0, 0, 255}, 
        textString = "lengths[1]"), 
        Text(
        extent = {{34, 77}, {100, 71}}, 
        textColor = {0, 0, 255}, 
        textString = "lengths[n]")}));
    end PartialTwoPortFlow;

    package FlowModels 
      "管道流动模型，包括管壁摩擦、静压头和动量流"
      extends Modelica.Icons.Package;
      partial model PartialStaggeredFlowModel "流动模型中动量平衡的基类"

        // 内部接口
        // 不显示在图形用户界面上；使用该模型时需要硬编码
        replaceable package Medium = 
          Modelica.Media.Interfaces.PartialMedium "组件中的介质" 
          annotation(Dialog(tab = "内部接口", enable = false));

        parameter Integer n = 2 "离散流动容积的数量" 
          annotation(Dialog(tab = "内部接口", enable = false));

        // 输入
        input Medium.ThermodynamicState[n] states "沿着设计流向的热力状态";
        input SI.Velocity[n] vs "流动的平均速度";

        // 几何参数和输入
        parameter Real nParallel "相同并联设备的数量" 
          annotation(Dialog(tab = "内部接口", enable = false, group = "几何"));

        input SI.Area[n] crossAreas "节块边界的过流区域";
        input SI.Length[n] dimensions "流体流动的特征尺寸（管道流动的直径）";
        input Modelica.Fluid.Types.Roughness[n] roughnesses "表面平均粗糙度";

        // 静压头
        input SI.Length[n - 1] dheights "高度(states[2:n]) - 高度(states[1:n-1])";

        parameter SI.Acceleration g = system.g "重力加速度常数" 
          annotation(Dialog(tab = "内部接口", enable = false, group = "静压头"));

        // 假设
        parameter Boolean allowFlowReversal = system.allowFlowReversal 
          "true: 允许反向流动，false: 只能从states[1]流向states[n+1]" 
          annotation(Dialog(tab = "内部接口", enable = false, group = "假设"), Evaluate = true);
        parameter Modelica.Fluid.Types.Dynamics momentumDynamics = system.momentumDynamics "动量平衡" 
          annotation(Dialog(tab = "内部接口", enable = false, group = "假设"), Evaluate = true);

        // 初始化
        parameter Medium.MassFlowRate m_flow_start = system.m_flow_start "质量流量初值" 
          annotation(Dialog(tab = "内部接口", enable = false, group = "初始化"));
        parameter Medium.AbsolutePressure p_a_start "设计流入工况 p[1] 的初值" 
          annotation(Dialog(tab = "内部接口", enable = false, group = "初始化"));
        parameter Medium.AbsolutePressure p_b_start "设计流出工况 p[n+1] 的初值" 
          annotation(Dialog(tab = "内部接口", enable = false, group = "初始化"));

        //
        // 实施动量平衡
        //
        extends Modelica.Fluid.Interfaces.PartialDistributedFlow(
          final m = n - 1);

        // 高级参数
        parameter Boolean useUpstreamScheme = true "false: 平均跨流节块的上下游特性" 
          annotation(Dialog(group = "高级"), Evaluate = true);

        parameter Boolean use_Ib_flows = momentumDynamics <> Types.Dynamics.SteadyState "true: 考虑通过边界的动量差异" 
          annotation(Dialog(group = "高级"), Evaluate = true);

        // 变量
        Medium.Density[n] rhos = if use_rho_nominal then fill(rho_nominal, n) else Medium.density(states);
        Medium.Density[n - 1] rhos_act "每个节块的实际密度";

        Medium.DynamicViscosity[n] mus = if use_mu_nominal then fill(mu_nominal, n) else Medium.dynamicViscosity(states);
        Medium.DynamicViscosity[n - 1] mus_act "每个节块的实际黏度";

        // 变量
        SI.Pressure[n - 1] dps_fg(each start = (p_a_start - p_b_start) / (n - 1)) "状态之间的压降";

        // 雷诺数
        parameter SI.ReynoldsNumber Re_turbulent = 4000 "湍流状态开始，取决于流动装置的类型";
        parameter Boolean show_Res = false "true: 包括雷诺数，以便绘制" 
          annotation(Evaluate = true, Dialog(group = "Diagnostics"));
        SI.ReynoldsNumber[n] Res = Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber(
          vs, 
          rhos, 
          mus, 
          dimensions) if show_Res "雷诺数";
        Medium.MassFlowRate[n - 1] m_flows_turbulent = 
          {nParallel * (crossAreas[i] + crossAreas[i + 1]) / (dimensions[i] + dimensions[i + 1]) * mus_act[i] * Re_turbulent for i in 1:n - 1} if 
          show_Res "湍流开始";
      protected
        parameter Boolean use_rho_nominal = false "true: 使用 rho_nominal, false: 根据介质计算" 
          annotation(Dialog(group = "高级"), Evaluate = true);
        parameter SI.Density rho_nominal = Medium.density_pTX(Medium.p_default, Medium.T_default, Medium.X_default) "额定密度（例如，rho_liquidWater = 995，rho_air = 1.2)" 
          annotation(Dialog(group = "高级", enable = use_rho_nominal));

        parameter Boolean use_mu_nominal = false "true: 使用 mu_nominal, false: 根据介质计算" 
          annotation(Dialog(group = "高级"), Evaluate = true);
        parameter SI.DynamicViscosity mu_nominal = Medium.dynamicViscosity(
          Medium.setState_pTX(
          Medium.p_default, Medium.T_default, Medium.X_default)) 
          "额定动力黏度（例如，mu_liquidWater = 1e-3，mu_air = 1.8e-5）" 
          annotation(Dialog(group = "高级", enable = use_mu_nominal));

      equation
        if not allowFlowReversal then
          rhos_act = rhos[1:n - 1];
          mus_act = mus[1:n - 1];
        elseif not useUpstreamScheme then
          rhos_act = 0.5 * (rhos[1:n - 1] + rhos[2:n]);
          mus_act = 0.5 * (mus[1:n - 1] + mus[2:n]);
        else
          for i in 1:n - 1 loop
            rhos_act[i] = noEvent(if m_flows[i] > 0 then rhos[i] else rhos[i + 1]);
            mus_act[i] = noEvent(if m_flows[i] > 0 then mus[i] else mus[i + 1]);
          end for;
        end if;

        if use_Ib_flows then
          Ib_flows = nParallel * {rhos[i] * vs[i] * vs[i] * crossAreas[i] - rhos[i + 1] * vs[i + 1] * vs[i + 1] * crossAreas[i + 1] for i in 1:n - 1};
        // 也可以使用实际水流的密度 rhos_act，以及质量流量,
        // 如果流体密度在管道节块之间发生变化，则动量守恒:
        //Ib_flows = {((rhos[i]*vs[i])^2*crossAreas[i] - (rhos[i+1]*vs[i+1])^2*crossAreas[i+1])/rhos_act[i] for i in 1:n-1};
        else
          Ib_flows = zeros(n - 1);
        end if;

        Fs_p = nParallel * {0.5 * (crossAreas[i] + crossAreas[i + 1]) * (Medium.pressure(states[i + 1]) - Medium.pressure(states[i])) for i in 1:n - 1};

        // 注意：为帮助翻译，等式用 dps_fg 代替 Fs_fg。
        dps_fg = {Fs_fg[i] / nParallel * 2 / (crossAreas[i] + crossAreas[i + 1]) for i in 1:n - 1};

        annotation(Documentation(info = "<html>
<p>
该基类模型为 <code>n</code> 个设备节块之间的 <code>m=n-1</code> 个流动模型定义了一个通用接口。
流动模型提供稳态或动态动量平衡，默认采用迎风离散方案。继承模型必须添加摩擦力的压降项和重力项。
</p>
<p>
流体在接口中通过给定的介质模型 <code>Medium</code> 的热力学状态数组 <code>states[n]</code>进行指定 。
几何形状由设备节块之间的路径长度数组 <code>pathLengths[n-1]</code> 以及设备节块的横截面积数组 <code>crossAreas[n]</code> 和 粗糙度数组<code>roughnesses[n]</code>进行定义。
此外，不同类型的设备的流体流动特征通过设备段中的特征尺寸数组寸 <code>dimensions[n]</code> 和流体流动的平均速度数组 <code>vs[n]</code> 来描述的。
有关定义示例，请参见 <a href=\"modelica://Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber\">Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber</a>。
</p>
<p>
参数 <code>Re_turbulent</code> 可以指定湍流区的最小质量流量，默认值为 4000，适合管道流动。
由 <code>Re_turbulent</code> 得出的 <code>m_flows_turbulent[n-1]</code> ，可以选择与设备节块的雷诺数 <code>Res[n]</code> 一起计算（<code>show_Res=true</code>）。
</p>
<p>
在此基础模型中，使用了设备各节块的热力学状态 <code>states[n]</code>，预定义了各节块的密度 <code>rhos[n]</code> 和动力黏度 mus[n]</code>，以及流动的实际密度 <code>rhos_act[n-1]</code> 和实际黏度 <code>mus_act[n-1]</code>。
请注意，模型不包括反向流动，因为这需要用扩展模型来处理，例如，用数值平滑或适当触发事件来实现。
</p>
</html>"      ), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, 
          -100}, {100, 100}}), graphics = {Line(
          points = {{-80, -50}, {-80, 50}, {80, -50}, {80, 50}}, 
          color = {0, 0, 255}, 
          thickness = 1), Text(
          extent = {{-40, -50}, {40, -90}}, 
          textString = "%name")}));
      end PartialStaggeredFlowModel;

      model NominalLaminarFlow "NominalLaminarFlow：基于给定标称值的线性层流模型"
        extends 
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.PartialStaggeredFlowModel(
          use_mu_nominal = not show_Res);

        // 运行条件
        parameter SI.AbsolutePressure dp_nominal "额定压降";
        parameter SI.MassFlowRate m_flow_nominal "额定压降对应的质量流量";

        // 假定管道流动和考虑管道层流中的壁面摩擦时的反向参数化。
        // Laminar.massFlowRate_dp:
        //   m_flow = dp*pi*diameter^4*d/(128*length*mu);
        SI.Length[n - 1] pathLengths_nominal = 
          {(dp_nominal / (n - 1) - g * dheights[i]) * Modelica.Constants.pi * ((dimensions[i] + dimensions[i + 1]) / 2) ^ 4 * rhos_act[i] / (128 * mus_act[i]) / 
          (m_flow_nominal / nParallel) for i in 1:n - 1} if show_Res 
          "根据给定的圆管标准值得出的长度";

      equation
        // 线性压降
        if not allowFlowReversal or use_rho_nominal or not useUpstreamScheme then
          dps_fg = {g * dheights[i] * rhos_act[i] for i in 1:n - 1} + dp_nominal / (n - 1) / m_flow_nominal * m_flows;
        else
          dps_fg = {g * dheights[i] * (if m_flows[i] > 0 then rhos[i] else rhos[i + 1]) for i in 1:n - 1} + dp_nominal / (n - 1) / m_flow_nominal * m_flows;
        end if;

        annotation(Documentation(info = "<html>
<p>
该模型定义了在指定的 <code>dp_nominal</code> 和 <code>m_flow_nominal</code> 的层流条件下的简单的线性压力损失。
</p>
<p>
选择 <code>show_Res = true</code> 可分析实际流动和管道长度，以满足给定几何参数横截面积 <code>crossAreas</code>、尺寸 <code>dimensions</code> 和粗糙度 <code>roughnesses</code> 的指定额定值。
</p>
</html>"  ));
      end NominalLaminarFlow;

      partial model PartialGenericPipeFlow 
        "GenericPipeFlow: 带可更换的 WallFriction 的管道流动压降和重力子库"

        parameter Boolean from_dp = momentumDynamics >= Types.Dynamics.SteadyStateInitial "true: 使用m_flow = f(dp), false: dp = f(m_flow)" 
          annotation(Dialog(group = "高级"), Evaluate = true);

        extends 
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.PartialStaggeredFlowModel(
          final Re_turbulent = 4000);

        replaceable package WallFriction = 
          Modelica.Fluid.Pipes.BaseClasses.WallFriction.Detailed 
          constrainedby 
          Modelica.Fluid.Pipes.BaseClasses.WallFriction.PartialWallFriction "壁面摩擦模型" 
          annotation(Dialog(group = "壁面摩擦"), choicesAllMatching = true);

        input SI.Length[n - 1] pathLengths_internal "内部使用的路径长度；将通过扩展类来定义";
        input SI.ReynoldsNumber[n - 1] Res_turbulent_internal = Re_turbulent * ones(n - 1) "内部使用的 Re_turbulent；将通过扩展类来定义";

        // 参数
        parameter SI.AbsolutePressure dp_nominal "额定压降（仅适用于额定模型）";
        parameter SI.MassFlowRate m_flow_nominal "额定质量流量";
        parameter SI.MassFlowRate m_flow_small = if system.use_eps_Re then system.eps_m_flow * m_flow_nominal else system.m_flow_small 
          "如果 |m_flows| < m_flow_small，则在正则化范围内（由于在静压头中较大的不连续性，正则化范围可能更宽）" 
          annotation(Dialog(enable = not from_dp and WallFriction.use_m_flow_small));

      protected
        parameter SI.AbsolutePressure dp_small(start = 1, fixed = false) 
          "如果 |dp| < dp_small，则在正则化范围内（由于在静压头中较大的不连续性，正则化范围可能更宽）" 
          annotation(Dialog(enable = from_dp and WallFriction.use_dp_small));
        final parameter Boolean constantPressureLossCoefficient = 
          use_rho_nominal and (use_mu_nominal or not WallFriction.use_mu) "true: 压力损失与流体状态无关" 
          annotation(Evaluate = true);
        final parameter Boolean continuousFlowReversal = 
          (not useUpstreamScheme) 
          or constantPressureLossCoefficient 
          or not allowFlowReversal 
          "true:  压力损失在零流量附近持续存在" 
          annotation(Evaluate = true);

        SI.Length[n - 1] diameters = 0.5 * (dimensions[1:n - 1] + dimensions[2:n]) 
          "每节块间平均直径";
        SI.AbsolutePressure dp_fric_nominal = 
          sum(WallFriction.pressureLoss_m_flow(
          m_flow_nominal / nParallel, 
          rho_nominal, 
          rho_nominal, 
          mu_nominal, 
          mu_nominal, 
          pathLengths_internal, 
          diameters, 
          (crossAreas[1:n - 1] + crossAreas[2:n]) / 2, 
          (roughnesses[1:n - 1] + roughnesses[2:n]) / 2, 
          m_flow_small / nParallel, 
          Res_turbulent_internal)) 
          "额定条件下的压力损失";

      initial equation
        // 从流量模型初始化 dp_small
        if system.use_eps_Re then
          dp_small = dp_fric_nominal / m_flow_nominal * m_flow_small;
        else
          dp_small = system.dp_small;
        end if;

      equation
        for i in 1:n - 1 loop
          assert(m_flows[i] > -m_flow_small or allowFlowReversal, "即使 allowFlowReversal 为 false，也会发生反向流动");
        end for;

        if continuousFlowReversal then
          // 简单正则化
          if from_dp and not WallFriction.dp_is_zero then
            m_flows = homotopy(
              actual = WallFriction.massFlowRate_dp(
              dps_fg - {g * dheights[i] * rhos_act[i] for i in 1:n - 1}, 
              rhos_act, 
              rhos_act, 
              mus_act, 
              mus_act, 
              pathLengths_internal, 
              diameters, 
              (crossAreas[1:n - 1] + crossAreas[2:n]) / 2, 
              (roughnesses[1:n - 1] + roughnesses[2:n]) / 2, 
              dp_small / (n - 1), 
              Res_turbulent_internal) * nParallel, 
              simplified = m_flow_nominal / dp_nominal * (dps_fg - g * dheights * rho_nominal));
          else
            dps_fg = homotopy(
              actual = WallFriction.pressureLoss_m_flow(
              m_flows / nParallel, 
              rhos_act, 
              rhos_act, 
              mus_act, 
              mus_act, 
              pathLengths_internal, 
              diameters, 
              (crossAreas[1:n - 1] + crossAreas[2:n]) / 2, 
              (roughnesses[1:n - 1] + roughnesses[2:n]) / 2, 
              m_flow_small / nParallel, 
              Res_turbulent_internal) + {g * dheights[i] * rhos_act[i] for i in 1:n - 1}, 
              simplified = dp_nominal / m_flow_nominal * m_flows + g * dheights * rho_nominal);
          end if;
        else
          // 不连续流动逆转和静压头的正则化
          if from_dp and not WallFriction.dp_is_zero then
            m_flows = homotopy(
              actual = WallFriction.massFlowRate_dp_staticHead(
              dps_fg, 
              rhos[1:n - 1], 
              rhos[2:n], 
              mus[1:n - 1], 
              mus[2:n], 
              pathLengths_internal, 
              diameters, 
              g * dheights, 
              (crossAreas[1:n - 1] + crossAreas[2:n]) / 2, 
              (roughnesses[1:n - 1] + roughnesses[2:n]) / 2, 
              dp_small / (n - 1), 
              Res_turbulent_internal) * nParallel, 
              simplified = m_flow_nominal / dp_nominal * (dps_fg - g * dheights * rho_nominal));
          else
            dps_fg = homotopy(
              actual = WallFriction.pressureLoss_m_flow_staticHead(
              m_flows / nParallel, 
              rhos[1:n - 1], 
              rhos[2:n], 
              mus[1:n - 1], 
              mus[2:n], 
              pathLengths_internal, 
              diameters, 
              g * dheights, 
              (crossAreas[1:n - 1] + crossAreas[2:n]) / 2, 
              (roughnesses[1:n - 1] + roughnesses[2:n]) / 2, 
              m_flow_small / nParallel, 
              Res_turbulent_internal), 
              simplified = dp_nominal / m_flow_nominal * m_flows + g * dheights * rho_nominal);
          end if;
        end if;

        annotation(Documentation(info = "<html>
<p>
该模型用于描述<strong>管道内壁摩擦</strong>和<strong>重力</strong>造成的压力损失。
可以通过可替换子库 <strong>WallFriction</strong>（见下面的参数面板）选择不同复杂程度和不同适用范围的相关函数。
管壁摩擦模型的详细信息请参阅<a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.WallFriction\">用户指南</a>。
基本方程如下：
</p>

<blockquote><pre>
dp = &lambda;(Re,&Delta;)*(L/D)*&rho;*v*|v|/2.
</pre></blockquote>

<p>

默认情况下，相关性是根据实际时间的介质数据计算的。
为了减少非线性方程组，参数 <code>use_mu_nominal</code> 和 <code>use_rho_nominal</code> 提供了在所需工作点使用恒定介质值计算相关性的选项。
这可能会加快模拟速度，供更稳定的模拟。
</p>
</html>"              ), Diagram(coordinateSystem(
          preserveAspectRatio = false, 
          extent = {{-100, -100}, {100, 100}}), graphics = {
          Rectangle(
          extent = {{-100, 64}, {100, -64}}, 
          fillColor = {255, 255, 255}, 
          fillPattern = FillPattern.Backward), 
          Rectangle(
          extent = {{-100, 50}, {100, -49}}, 
          fillColor = {255, 255, 255}, 
          fillPattern = FillPattern.Solid), 
          Line(
          points = {{-60, -49}, {-60, 50}}, 
          color = {0, 0, 255}, 
          arrow = {Arrow.Filled, Arrow.Filled}), 
          Text(
          extent = {{-50, 16}, {6, -10}}, 
          textColor = {0, 0, 255}, 
          textString = "diameters"), 
          Line(
          points = {{-100, 74}, {100, 74}}, 
          color = {0, 0, 255}, 
          arrow = {Arrow.Filled, Arrow.Filled}), 
          Text(
          extent = {{-32, 93}, {32, 74}}, 
          textColor = {0, 0, 255}, 
          textString = "pathLengths")}));
      end PartialGenericPipeFlow;

      model NominalTurbulentPipeFlow 
        "NominalTurbulentPipeFlow: 给定额定值下圆管中的二次湍流流动"
        extends 
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.PartialGenericPipeFlow(
        redeclare package WallFriction = 
          Modelica.Fluid.Pipes.BaseClasses.WallFriction.LaminarAndQuadraticTurbulent, 
          use_mu_nominal = not show_Res, 
          pathLengths_internal = pathLengths_nominal, 
          useUpstreamScheme = false, 
          Res_turbulent_internal = Res_turbulent_nominal);

        import Modelica.Constants.pi;

        parameter SI.MassFlowRate m_flow_turbulent(min = 0) = if system.use_eps_Re then 0.1 * m_flow_nominal else system.m_flow_small 
          "湍流从 |m_flows| > m_flow_turbulent 开始(在静压头有较大不连续性时范围可以放宽）" 
          annotation(Dialog(enable = not from_dp and WallFriction.use_m_flow_small));

        // 额定压力损失变量
        SI.Length[n - 1] pathLengths_nominal "额定压力损失和几何决定的路径长度";
        SI.ReynoldsNumber[n - 1] Res_turbulent_nominal "由额定湍流和几何产生的 Re_turbulent";
        Real[n - 1] ks_inv "二次湍流流动系数";
        Real[n - 1] zetas "二次湍流流动系数";

        // 雷诺数
        Medium.AbsolutePressure[n - 1] dps_fg_turbulent(each min = 0) = 
          {(mus_act[i] * diameters[i] * pi / 4) ^ 2 * Re_turbulent ^ 2 / (ks_inv[i] * rhos_act[i]) for i in 1:n - 1} if 
          show_Res "圆管中的湍流起始";

      initial equation
        for i in 1:n loop
          assert(abs(crossAreas[i] - pi / 4 * dimensions[i] ^ 2) < 1e-10 * crossAreas[i], 
            "NominalTurbulentPipeFlow 模型需要圆形管道");
        end for;

      equation
        // WallFriction.QuadraticTurbulent 的反向参数化
        // 注意：代码应与 WallFriction.QuadraticTurbulent 模型共享,
        //       但这需要重新设计 WallFriction 接口 ...
        //   zeta = (length_nominal/diameter)/(2*Math.log10(3.7 /(roughness/diameter)))^2;
        //   k_inv = (pi*diameter*diameter)^2/(8*zeta);
        //   k = rho*k_inv "Factor in m_flow = sqrt(k*dp)";
        //   m_flow_turbulent = pi/4*diameter*mu*Re_turbulent;
        for i in 1:n - 1 loop
          ks_inv[i] = (m_flow_nominal / nParallel) ^ 2 / ((dp_nominal / (n - 1) - g * dheights[i] * rhos_act[i])) / rhos_act[i];
          zetas[i] = (pi * diameters[i] * diameters[i]) ^ 2 / (8 * ks_inv[i]);
          pathLengths_nominal[i] = 
            zetas[i] * diameters[i] * (2 * Modelica.Math.log10(3.7 / ((roughnesses[i] + roughnesses[i + 1]) / 2 / diameters[i]))) ^ 2;
          Res_turbulent_nominal[i] = m_flow_turbulent / nParallel / (pi / 4 * diameters[i] * mus_act[i]);
        end for;

        annotation(Documentation(info = "<html><p>
该模型定义了在指定 <code>dp_nominal</code> 和 <code>m_flow_nominal</code>条件下的湍流压力损失。
它考虑了每个管道节块的流体密度，并为 <a href=\"modelica://Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow\" target=\"\"> TurbulentPipeFlow</a> 
模型的反向参数化获取了适当的流道长度额定值 <code>pathLengths_nominal</code>。
默认情况下，在设置 <code>useUpstreamScheme = false</code> 时会对上下游密度进行平均，以避免在反向流动时出现不连续的流道长度额定值 <code>pathLengths_nominal</code>。
</p>
<p>
几何参数横截面积 <code>crossAreas</code>、直径 <code>diameters</code> 和粗糙度 <code>roughnesses</code> 不会影响该额定压力损失模型的模拟结果。 
但在指定几何参数后，选择计算雷诺数以及 <code>m_flows_turbulent</code> 和 <code>dps_fg_turbulent</code> 就变得有意义了，
并且可与 <code>m_flow_small</code> 和 <code>dp_small</code> 联系起来。
</p>
<p>
<strong>可选变量（如果选择 show_Res）</strong>
</p>
<table style=\"width: auto;\"><tbody><tr><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>物理量</strong></th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>变量名</strong></th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>描述</strong></th></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">雷诺数</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Res[n]</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">管道中每个管道节块的雷诺数</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">质量流量</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">m_flows_turbulent[n-1]</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Re_turbulent=4000 时湍流区起始处的质量流量</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">绝对压力</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">dps_fg_turbulent[n-1]</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">与 m_flows_turbulent 相对应的摩擦和重力造成的压力损失</td></tr></tbody></table><p>
<br>
</p>
</html>"      , revisions = "<html>
<ul>
<li><em>6 Dec 2008</em>
by R&uuml;diger Franke:<br />
模型添加到流体库中</li>
</ul>
</html>"      ));
      end NominalTurbulentPipeFlow;

      model TurbulentPipeFlow "TurbulentPipeFlow: 圆管中的二次湍流（利用mu对层流区进行正则化）"
        extends 
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.PartialGenericPipeFlow(
        redeclare package WallFriction = 
          Modelica.Fluid.Pipes.BaseClasses.WallFriction.LaminarAndQuadraticTurbulent, 
          use_mu_nominal = not show_Res, 
          pathLengths_internal = pathLengths, 
          dp_nominal(start = if system.use_eps_Re then 1 else 1e3 * dp_small, fixed = not system.use_eps_Re), 
          m_flow_nominal = if system.use_eps_Re then system.m_flow_nominal else 1e2 * m_flow_small, 
          Res_turbulent_internal = if use_Re then Re_turbulent * ones(n - 1) else zeros(n - 1));

        import Modelica.Constants.pi;

        parameter Boolean use_Re = system.use_eps_Re "true: 湍流区域由Re定义，否则由m flow small定义" 
          annotation(Evaluate = true);

      initial equation
        for i in 1:n loop
          assert(abs(crossAreas[i] - pi / 4 * dimensions[i] ^ 2) < 1e-10 * crossAreas[i], 
            "NominalTurbulentPipeFlow 模型需要圆形管道");
        end for;
        // 从流量模型初始化 dp_nominal
        if system.use_eps_Re then
          dp_nominal = dp_fric_nominal + g * sum(dheights) * rho_nominal;
        end if;

        annotation(Documentation(info = "<html>
<p>
该模型仅定义了二次湍流区的管壁摩擦：dp = k*m_flow*|m_flow|，
其中 \"k\"取决于密度和管道的粗糙度，并非是雷诺数的函数。但这仅适用于大雷诺数工况。
湍流的压力损失相关性计算可能有助于优化面向湍流的流动模型。
</p>

</html>"  ));
      end TurbulentPipeFlow;

      model DetailedPipeFlow "DetailedPipeFlow: 层流和湍流的详细特征"
        extends 
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.PartialGenericPipeFlow(
        redeclare package WallFriction = 
          Modelica.Fluid.Pipes.BaseClasses.WallFriction.Detailed, 
          pathLengths_internal = pathLengths, 
          dp_nominal(start = 1, fixed = false), 
          m_flow_nominal = if system.use_eps_Re then system.m_flow_nominal else 1e2 * m_flow_small, 
          Res_turbulent_internal = Re_turbulent * ones(n - 1));

      initial equation
        // 从流量模型初始化 dp_nominal
        if system.use_eps_Re then
          dp_nominal = dp_fric_nominal + g * sum(dheights) * rho_nominal;
        else
          dp_nominal = 1e3 * dp_small;
        end if;

        annotation(Documentation(info = "<html><p>
该组件定义了壁面摩擦的完整机制。 详情请参见 <a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.WallFriction\" target=\"\">用户指南</a>&nbsp; &nbsp;。 
下图显示了摩擦损失系数 λ 的函数关系。 根据函数 massFlowRate_dp() 得到了\"红色曲线\"（\"Swamee and Jain\"），而根据函数 pressureLoss_m_flow() 得到了 \"蓝色曲线\"（\"Colebrook-White\"）。
这两个函数互为反函数，在 Re = 1500 ... 4000 之间的过渡区域给出的结果略有不同，以便在不求解非线性方程的情况下获得显式方程。
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Fluid/Pipes/BaseClasses/PipeFriction1.png\" alt=\"PipeFriction1.png\" data-href=\"\" style=\"\">
</p>
<p>
除了壁面摩擦力之外，该组件还能体现出静压头。 对于后者，可以分为两种情况。在如下的情况中，从 a 到 b 的高度变化与密度变化的符号相反。
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Fluid/Pipes/BaseClasses/PipeFrictionStaticHead_case-a.png\" alt=\"PipeFrictionStaticHead_case-a.png\" data-href=\"\" style=\"\">
</p>
<p>
在第二种情况下，从 a 到 b 的高度变化与密度变化的符号相同。
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Fluid/Pipes/BaseClasses/PipeFrictionStaticHead_case-b.png\" alt=\"PipeFrictionStaticHead_case-b.png\" data-href=\"\" style=\"\">
</p>
</html>"  ), Diagram(coordinateSystem(
          preserveAspectRatio = false, 
          extent = {{-100, -100}, {100, 100}}), graphics = {
          Rectangle(
          extent = {{-100, 64}, {100, -64}}, 
          fillColor = {255, 255, 255}, 
          fillPattern = FillPattern.Backward), 
          Rectangle(
          extent = {{-100, 50}, {100, -49}}, 
          fillColor = {255, 255, 255}, 
          fillPattern = FillPattern.Solid), 
          Line(
          points = {{-60, -49}, {-60, 50}}, 
          color = {0, 0, 255}, 
          arrow = {Arrow.Filled, Arrow.Filled}), 
          Text(
          extent = {{-50, 16}, {6, -10}}, 
          textColor = {0, 0, 255}, 
          textString = "diameters"), 
          Line(
          points = {{-100, 74}, {100, 74}}, 
          color = {0, 0, 255}, 
          arrow = {Arrow.Filled, Arrow.Filled})}));
      end DetailedPipeFlow;
      annotation();

    end FlowModels;

    package HeatTransfer "流动模型的传热"
      extends Modelica.Icons.Package;
      partial model PartialFlowHeatTransfer "管道传热相关性的基类"
        extends Modelica.Fluid.Interfaces.PartialHeatTransfer;

        // 为流动传热模型提供额外输入
        input SI.Velocity[n] vs "管道节块内流体流动的平均速度";

        // 流动传热的几何参数和输入
        parameter Real nParallel "相同并联设备的数量" 
          annotation(Dialog(tab = "内部接口", enable = false, group = "几何"));
        input SI.Length[n] lengths "流道长度";
        input SI.Length[n] dimensions "流体流动的特征尺寸（管道流动的直径）";
        input Modelica.Fluid.Types.Roughness[n] roughnesses "表面平均粗糙度";

        annotation(Documentation(info = "<html><p>
<br>流动设备传热模型的基类。<br>
</p>
<p>
几何形状在界面中指定，包括表面区域 <code>surfaceAreas[n]</code>、粗糙度 <code>roughnesses[n]</code> 和流道长度 <code>lengths[n]</code>。 此外，对于不同类型的设备，流体流动的特征还包括特征尺寸 <code>dimensions[n+1]</code> 和流体流动的平均速度 <code>vs[n+1]</code>。 有关定义示例，请参见 <a href=\"modelica://Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber\" target=\"\">Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber</a>。
</p>
</html>"  ), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
          {100, 100}}), graphics = {Rectangle(
          extent = {{-80, 60}, {80, -60}}, 
          pattern = LinePattern.None, 
          fillColor = {255, 0, 0}, 
          fillPattern = FillPattern.HorizontalCylinder), Text(
          extent = {{-40, 22}, {38, -18}}, 
          textString = "%name")}));
      end PartialFlowHeatTransfer;

      model IdealFlowHeatTransfer "IdealHeatTransfer: 无热阻的理想传热"
        extends PartialFlowHeatTransfer;
      equation
        Ts = heatPorts.T;
        annotation(Documentation(info = "<html>
理想的传热，无热阻。
</html>"  ));
      end IdealFlowHeatTransfer;

      model ConstantFlowHeatTransfer "ConstantHeatTransfer: 恒定传热系数"
        extends PartialFlowHeatTransfer;
        parameter SI.CoefficientOfHeatTransfer alpha0 "传热系数";
      equation
        Q_flows = {alpha0 * surfaceAreas[i] * (heatPorts[i].T - Ts[i]) * nParallel for i in 1:n};
        annotation(Documentation(info = "<html>
<p>
具有恒定传热系数的简单传热，用作离散管道模型的默认组件。
</p>
</html>"  ));
      end ConstantFlowHeatTransfer;

      partial model PartialPipeFlowHeatTransfer "有关圆管层流和湍流单相流的努塞尔数传热的传热基类"
        extends PartialFlowHeatTransfer;
        parameter SI.CoefficientOfHeatTransfer alpha0 = 100 "传热系数假设值";
        SI.CoefficientOfHeatTransfer[n] alphas(each start = alpha0) "传热系数";
        Real[n] Res "雷诺数";
        Real[n] Prs "普朗特数";
        Real[n] Nus "努塞尔数";
        Medium.Density[n] ds "密度";
        Medium.DynamicViscosity[n] mus "动力黏度";
        Medium.ThermalConductivity[n] lambdas "热导率";
        SI.Length[n] diameters = dimensions "管流水力直径";
      equation
        ds = Medium.density(states);
        mus = Medium.dynamicViscosity(states);
        lambdas = Medium.thermalConductivity(states);
        Prs = Medium.prandtlNumber(states);
        Res = CharacteristicNumbers.ReynoldsNumber(vs, ds, mus, diameters);
        Nus = CharacteristicNumbers.NusseltNumber(alphas, diameters, lambdas);
        Q_flows = {alphas[i] * surfaceAreas[i] * (heatPorts[i].T - Ts[i]) * nParallel for i in 1:n};
        annotation(Documentation(info = "<html>
<p>
传热模型的基类，这些模型用努塞尔数表示，可用于离散管道模型。
</p>
</html>"  ));
      end PartialPipeFlowHeatTransfer;

      model LocalPipeFlowHeatTransfer "LocalPipeFlowHeatTransfer: 管道中的层流和湍流强制对流，局部系数"
        extends PartialPipeFlowHeatTransfer;
      protected
        Real[n] Nus_turb "湍流的努塞尔数";
        Real[n] Nus_lam "层流的努塞尔数";
        Real Nu_1;
        Real[n] Nus_2;
        Real[n] Xis;
      equation
        Nu_1 = 3.66;
        for i in 1:n loop
          Nus_turb[i] = smooth(0, (Xis[i] / 8) * abs(Res[i]) * Prs[i] / (1 + 12.7 * (Xis[i] / 8) ^ 0.5 * (Prs[i] ^ (2 / 3) - 1)) * (1 + 1 / 3 * (diameters[i] / lengths[i] / (if vs[i] >= 0 then (i - 0.5) else (n - i + 0.5))) ^ (2 / 3)));
          Xis[i] = (1.8 * Modelica.Math.log10(max(1e-10, Res[i])) - 1.5) ^ (-2);
          Nus_lam[i] = (Nu_1 ^ 3 + 0.7 ^ 3 + (Nus_2[i] - 0.7) ^ 3) ^ (1 / 3);
          Nus_2[i] = smooth(0, 1.077 * (abs(Res[i]) * Prs[i] * diameters[i] / lengths[i] / (if vs[i] >= 0 then (i - 0.5) else (n - i + 0.5))) ^ (1 / 3));
          Nus[i] = Modelica.Media.Air.MoistAir.Utilities.spliceFunction(Nus_turb[i], Nus_lam[i], Res[i] - 6150, 3850);
        end for;
        annotation(Documentation(info = "<html>
<p>
管道中层流和湍流的传热模型。应用范围：
</p>
<ul>
<li>完全发展的管流</li>
<li>强制对流</li>
<li>单相牛顿流体</li>
<li>(空间）层流区域中的恒定壁温</li>
<li>0 &le; Re &le; 1e6, 0.6 &le; Pr &le; 100, d/L &le; 1</li>
<li>该关联式仅在湍流区域适用于非圆形管道。使用直径=4*横截面积/周长作为特征长度。</li>
</ul>
<p>
相关性考虑到了沿管道流动的空间位置，该位置在流动反转时会发生不连续的变化。然而，传热系数本身在零流速附近是连续的，但其导数并不连续。
</p>
<h4>参考资料</h4>
<dl><dt>Verein Deutscher Ingenieure (1997):</dt>
<dd><strong>VDI W&auml;rmeatlas</strong>.
Springer Verlag, Ed. 8, 1997.</dd>
</dl>
</html>"      ));
      end LocalPipeFlowHeatTransfer;
      annotation(Documentation(info = "<html><p>
管道模型的传热相关性
</p>
</html>"  ));
    end HeatTransfer;

    package CharacteristicNumbers "计算特征数的函数"
      extends Modelica.Icons.Package;
      function ReynoldsNumber "根据 v、rho、mu 和 D 计算雷诺数"
        extends Modelica.Icons.Function;

        input SI.Velocity v "流体流动的平均速度";
        input SI.Density rho "流体密度";
        input SI.DynamicViscosity mu "动力（绝对）黏度";
        input SI.Length D "特征尺寸（管道水力直径）";
        output SI.ReynoldsNumber Re "雷诺数";
      algorithm
        Re := abs(v) * rho * D / mu;
        annotation(Documentation(info = "<html>
<p>
雷诺数计算
</p>
<blockquote><pre>
Re = |v|&rho;D/&mu;
</pre></blockquote>
<p>
惯性力 (v&rho;) 和粘性力 (D/&mu;) 之间关系的量度。
</p>
<p>
下表列出了不同流体流动设备的特征尺寸 D 和速度 v 的示例：
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th><strong>设备类型</strong></th><th><strong>特征尺寸 D</strong></th><th><strong>速度 v</strong></th></tr>
<tr><td>圆管</td><td>直径</td>
<td>m_flow/&rho;/横截面积</td></tr>
<tr><td>矩形风管</td><td>4*横截面积/周长</td>
<td>m_flow/&rho;/横截面积</td></tr>
<tr><td>宽风管</td><td>平行壁面间的窄距</td>
<td>m_flow/&rho;/横截面积</td></tr>
<tr><td>填充床式反应器</td><td>微粒直径/（1-总体积的流体分数）</td>
<td>m_flow/&rho;/横截面积（不含颗粒）</td></tr>
<tr><td>带旋转搅拌器的设备</td><td>转子直径</td>
<td>转速*转子直径</td></tr>
</table>
</html>"  ));
      end ReynoldsNumber;

      function ReynoldsNumber_m_flow "根据 m_flow、mu、D、A 计算雷诺数"
        extends Modelica.Icons.Function;

        input SI.MassFlowRate m_flow "质量流量";
        input SI.DynamicViscosity mu "动力黏度";
        input SI.Length D "特征尺寸（管道或孔口的水力直径）";
        input SI.Area A = Modelica.Constants.pi / 4 * D * D "流体的横截面积";
        output SI.ReynoldsNumber Re "雷诺数";
      algorithm
        Re := abs(m_flow) * D / A / mu;
        annotation(Documentation(info = "<html>
<p>
简化计算流经管道或节流元件时的雷诺数；使用质量流量 <code>m_flow</code> 代替速度 <code>v</code> 来表示惯性力。
</p>
<blockquote><pre>
Re = |m_flow|*直径/A/&mu;
m_flow = v*&rho;*A
</pre></blockquote>
也可参考 <a href=\"modelica://Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber\">
Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber</a>。

</html>"      ));
      end ReynoldsNumber_m_flow;

      function NusseltNumber "计算努塞尔数"
        extends Modelica.Icons.Function;

        input SI.CoefficientOfHeatTransfer alpha "传热系数";
        input SI.Length D "特征尺寸";
        input SI.ThermalConductivity lambda "热导率";
        output SI.NusseltNumber Nu "努塞尔数";
      algorithm
        Nu := alpha * D / lambda;
        annotation(Documentation(info = "努塞尔数 Nu = alpha*D/lambda"));
      end NusseltNumber;
      annotation();
    end CharacteristicNumbers;

    package WallFriction "由于管壁摩擦导致压降的变量"
      extends Modelica.Icons.Package;
      partial package PartialWallFriction "部分壁面摩擦特性（所有壁面摩擦特性的基础包）"
        extends Modelica.Icons.Package;
        import Modelica.Constants.pi;

        // 子库中要设置的常量
        constant Boolean use_mu = true 
          "true: 在函数中使用 mu_a/mu_b，false: 在函数中不使用 mu_a/mu_b";
        constant Boolean use_roughness = true 
          "true: 在函数中使用粗糙度，false: 在函数中不使用粗糙度";
        constant Boolean use_dp_small = true 
          "true: 在函数中使用 dp_small，false: 在函数中不使用 dp_small";
        constant Boolean use_m_flow_small = true 
          "true: 在函数中使用 m_flow_small，false: 在函数中不使用m_flow_small";
        constant Boolean dp_is_zero = false 
          "true: 没有壁面摩擦，即dp = 0 (无法使用函数 massFlowRate_dp())";
        constant Boolean use_Re_turbulent = true 
          "true: Re_turbulent 输入用于函数，false: Re_turbulent 输入不用于函数";

        // 压降特性函数
        replaceable partial function massFlowRate_dp 
          "计算质量流量 m_flow 与压降 dp 的函数关系，即由于壁面摩擦， m_flow = f(dp)"
          extends Modelica.Icons.Function;

          input SI.Pressure dp "压降(dp = port_a.p - port_b.p)";
          input SI.Density rho_a "port_a 处的密度";
          input SI.Density rho_b "port_b 处的密度";
          input SI.DynamicViscosity mu_a "port_a 处的动力黏度(若use_mu = false，则为假)";
          input SI.DynamicViscosity mu_b "port_b 处的动力黏度(若use_mu = false，则为假)";
          input SI.Length length "管道长度";
          input SI.Diameter diameter "管道内径（水力直径）";
          input SI.Area crossArea = pi * diameter ^ 2 / 4 "内部横截面积";
          input Modelica.Fluid.Types.Roughness roughness = 2.5e-5 
            "管道的绝对粗糙度，默认为光滑钢管(若 use_roughness = false，则为假)";
          input SI.AbsolutePressure dp_small = 1 
            "如果 |dp| < dp_small，对零流量进行正则调整(若 use_dp_small = false，则为假)";
          input SI.ReynoldsNumber Re_turbulent = 4000 
            "如果 Re >= Re_turbulent 则为湍流(若 use_Re_turbulent = false，则为假)";

          output SI.MassFlowRate m_flow "从 port_a 到 port_b 的质量流量";
          annotation(Documentation(info = "<html>

</html>"  ));
        end massFlowRate_dp;

        replaceable partial function massFlowRate_dp_staticHead 
          "计算质量流量 m_flow 与压降 dp 的函数关系，即由于管壁摩擦和静压头 m_flow = f(dp)"
          extends Modelica.Icons.Function;

          input SI.Pressure dp "压降(dp = port_a.p - port_b.p)";
          input SI.Density rho_a "port_a 处的密度";
          input SI.Density rho_b "port_b 处的密度";
          input SI.DynamicViscosity mu_a "port_a 处的动力黏度(若 use_mu = false，则为假)";
          input SI.DynamicViscosity mu_b "port_b 处的动力黏度(若 use_mu = false，则为假)";
          input SI.Length length "管道长度";
          input SI.Diameter diameter "管道内径（水力直径）";
          input Real g_times_height_ab(unit = "m2/s2") "重力与 port_a 和 port_b 的高度差的积";
          input SI.Area crossArea = pi * diameter ^ 2 / 4 "内部横截面积";
          input Modelica.Fluid.Types.Roughness roughness = 2.5e-5 
            "管道的绝对粗糙度，默认为光滑钢管(若 use_roughness = false，则为假)";
          input SI.AbsolutePressure dp_small = 1 
            "如果 |dp| < dp_small，对零流量进行正则调整(若 use_dp_small = false，则为假)";
          input SI.ReynoldsNumber Re_turbulent = 4000 
            "如果 Re >= Re_turbulent 则为湍流(若 use_Re_turbulent = false，则为假)";

          output SI.MassFlowRate m_flow "从 port_a 到 port_b 的质量流量";
          annotation(Documentation(info = "<html>

</html>"  ));
        end massFlowRate_dp_staticHead;

        replaceable partial function pressureLoss_m_flow 
          "计算压降 dp 与质量流量 m_flow 的函数关系，即由于壁面摩擦 dp = f(m_flow)"
          extends Modelica.Icons.Function;

          input SI.MassFlowRate m_flow "从 port_a 到 port_b 的质量流量";
          input SI.Density rho_a "port_a 处的密度";
          input SI.Density rho_b "port_b 处的密度";
          input SI.DynamicViscosity mu_a "port_a 处的动力黏度(若 use_mu = false，则为假)";
          input SI.DynamicViscosity mu_b "port_b 处的动力黏度(若 use_mu = false，则为假)";
          input SI.Length length "管道长度";
          input SI.Diameter diameter "管道内径（水力直径）";
          input SI.Area crossArea = pi * diameter ^ 2 / 4 "内部横截面积";
          input Modelica.Fluid.Types.Roughness roughness = 2.5e-5 
            "管道的绝对粗糙度，默认为光滑钢管(若 use_roughness = false，则为假)";
          input SI.MassFlowRate m_flow_small = 0.01 
            "如果 |m_flow| < m_flow_small，则对零流量进行正则调整(若 use_m_flow_small = false，则为假)";
          input SI.ReynoldsNumber Re_turbulent = 4000 
            "如果 Re >= Re_turbulent 则为湍流(若 use_Re_turbulent = false，则为假)";

          output SI.Pressure dp "压降 (dp = port_a.p - port_b.p)";

          annotation(Documentation(info = "<html>

</html>"  ));
        end pressureLoss_m_flow;

        replaceable partial function pressureLoss_m_flow_staticHead 
          "计算压降 dp 与质量流量 m_flow 的函数关系，即由于管壁摩擦和静压头 dp = f(m_flow)"
          extends Modelica.Icons.Function;

          input SI.MassFlowRate m_flow "从 port_a 到 port_b 的质量流量";
          input SI.Density rho_a "port_a 处的密度";
          input SI.Density rho_b "port_b 处的密度";
          input SI.DynamicViscosity mu_a "port_a 处的动力黏度(若 use_mu = false，则为假)";
          input SI.DynamicViscosity mu_b "port_b 处的动力黏度(若 use_mu = false，则为假)";
          input SI.Length length "管道长度";
          input SI.Diameter diameter "管道内径（水力直径）";
          input Real g_times_height_ab(unit = "m2/s2") "重力与 port_a 和 port_b 的高度差的积";
          input SI.Area crossArea = pi * diameter ^ 2 / 4 "内部横截面积";
          input Modelica.Fluid.Types.Roughness roughness = 2.5e-5 
            "管道的绝对粗糙度，默认为光滑钢管(若 use_roughness = false，则为假)";
          input SI.MassFlowRate m_flow_small = 0.01 
            "如果 |m_flow| < m_flow_small，则对零流量进行正则调整(若 use_m_flow_small = false，则为假)";
          input SI.ReynoldsNumber Re_turbulent = 4000 
            "如果 Re >= Re_turbulent 则为湍流(若 use_Re_turbulent = false，则为假)";

          output SI.Pressure dp "压降 (dp = port_a.p - port_b.p)";

          annotation(Documentation(info = "<html>

</html>"  ));
        end pressureLoss_m_flow_staticHead;
        annotation(Documentation(info = "<html>

</html>"  ));
      end PartialWallFriction;

      package NoFriction "无管壁摩擦，无静压头"
        extends Modelica.Icons.Package;

        extends PartialWallFriction(
          final use_mu = false, 
          final use_roughness = false, 
          final use_dp_small = false, 
          final use_m_flow_small = false, 
          final dp_is_zero = true, 
          final use_Re_turbulent = false);

        redeclare function extends massFlowRate_dp 
          "计算质量流量 m_flow与压降 dp 的函数关系，即由于壁面摩擦引起的 m_flow = f(dp)"

        algorithm
          assert(false, "函数 massFlowRate_dp (选项：from_dp=true) 不能用于 WallFriction.NoFriction。
请使用函数 pressureLoss_m_flow（选项：from_dp=false）代替。"  );

          annotation(Documentation(info = "<html>

</html>"  ));
        end massFlowRate_dp;

        redeclare function extends pressureLoss_m_flow 
          "计算压降 dp 与质量流量 m_flow 的函数关系，即由于壁面摩擦引起的 dp = f(m_flow)"

        algorithm
          dp := 0;
          annotation(Documentation(info = "<html>

</html>"  ));
        end pressureLoss_m_flow;

        redeclare function extends massFlowRate_dp_staticHead 
          "计算质量流量 m_flow 与压力损失 dp 的函数关系，即由于管壁摩擦和静压头引起的 m_flow = f(dp)"

        algorithm
          assert(false, "WallFriction.NoFriction 不能使用函数 massFlowRate_dp（选项：from_dp=true）。
请改用函数 pressureLoss_m_flow（选项：from_dp=false）)"  );
          /*
          函数 massFlowRate_dp (选项：from_dp=true) 不能用于 WallFriction.NoFriction。
          请使用函数 pressureLoss_m_flow（选项：from_dp=false）代替。
          */
          annotation(Documentation(info = "<html>

</html>"  ));
        end massFlowRate_dp_staticHead;

        redeclare function extends pressureLoss_m_flow_staticHead 
          "计算压力损失 dp 与质量流量 m_flow 的函数关系，即由于管壁摩擦和静压头引起的 dp = f(m_flow)"

        /* 
        只包括静压头:
        protected
        Real dp_grav_a = g_times_height_ab*rho_a
        "质量流向沿设计方向时的静压头(a to b)";
        Real dp_grav_b = g_times_height_ab*rho_b
        "质量流向沿设计反方向时的静压头 (b to a)";
        */
        algorithm
          //  dp := Utilities.regStep(m_flow, dp_grav_a, dp_grav_a, m_flow_small);
          dp := 0;
          assert(abs(g_times_height_ab) < Modelica.Constants.small, 
            "WallFriction.NoFriction 不考虑静水压，不能与 height_ab<>0 一起使用!");
          annotation(Documentation(info = "<html>

</html>"  ));
        end pressureLoss_m_flow_staticHead;
        annotation(Documentation(info = "<html>
<p>
该组件将管壁摩擦造成的压力损失设为零，即不考虑管壁摩擦。
</p>
</html>"  ));
      end NoFriction;

      package Laminar 
        "圆管层流中的管壁摩擦（线性相关）"

        extends PartialWallFriction(
          final use_mu = true, 
          final use_roughness = false, 
          final use_dp_small = false, 
          final use_m_flow_small = false, 
          final use_Re_turbulent = false);

        redeclare function extends massFlowRate_dp 
          "计算质量流量 m_flow 与压力损失 dp 的函数关系，即由壁面摩擦引起的 m_flow = f(dp)"

        algorithm
          // 警告：以下公式仅适用于圆管！
          m_flow := dp * Modelica.Constants.pi * diameter ^ 4 * (rho_a + rho_b) / (128 * length * (mu_a + mu_b));
          annotation(Documentation(info = "<html>

</html>"  ));
        end massFlowRate_dp;

        redeclare function extends pressureLoss_m_flow 
          "计算压力损失 dp 与质量流量 m_flow 的函数关系，即由壁面摩擦引起的 dp = f(m_flow)"

        algorithm
          // 警告：以下公式仅适用于圆管！
          dp := m_flow * 128 * length * (mu_a + mu_b) / (Modelica.Constants.pi * diameter ^ 4 * (rho_a + rho_b));
          annotation(Documentation(info = "<html>

</html>"  ));
        end pressureLoss_m_flow;

        redeclare function extends massFlowRate_dp_staticHead 
          "计算质量流量 m_flow 与压降 dp 的函数关系，即由壁面摩擦和静压头引起的 m_flow = f(dp)"

          // 警告：以下公式仅适用于圆管！
        protected
          Real k0inv = Modelica.Constants.pi * diameter ^ 4 / (128 * length) 
            "常数系数";

          SI.Pressure dp_grav_a = g_times_height_ab * rho_a 
            "质量流沿设计方向(a to b)时的静压头";
          SI.Pressure dp_grav_b = g_times_height_ab * rho_b 
            "质量流沿设计反方向(b to a)时的静压头";

          Real dm_flow_ddp_fric_a = k0inv * rho_a / mu_a 
            "如果质量流沿设计方向(a to b)，质量流量相对于 dp 的斜率";
          Real dm_flow_ddp_fric_b = k0inv * rho_b / mu_b 
            "如果质量流沿设计反方向(b to a)，质量流量与 dp 的斜率";

          Real dp_a = max(dp_grav_a, dp_grav_b) + dp_small 
            "m_flow(dp) 关系的正则化区域上限";
          Real dp_b = min(dp_grav_a, dp_grav_b) - dp_small 
            "m_flow(dp) 关系的正则化区域下限";

          SI.MassFlowRate m_flow_a 
            "正则化域上限值";
          SI.MassFlowRate m_flow_b 
            "正则化域下限值";

          // 零质量流量条件的恰当定义
          SI.MassFlowRate m_flow_zero = 0;
          SI.Pressure dp_zero = (dp_grav_a + dp_grav_b) / 2;
          Real dm_flow_ddp_fric_zero;
        algorithm
          /*
          dp = 0.5*zeta/(A^2*d) * m_flow * |m_flow|
          = 0.5 * c0/(|m_flow|*(4/pi)/(D_Re*mu)) / ((pi*(D_Re/2)^2)^2*d) * m_flow*|m_flow|
          = 0.5 * c0*(pi/4)*(D_Re*mu) * 16/(pi^2*D_Re^4*d) * m_flow*|m_flow|
          = 2*c0/(pi*D_Re^3) * mu/d * m_flow
          = k0 * mu/d * m_flow
          k0 = 2*c0/(pi*D_Re^3)
          */

          if dp >= dp_a then
            // 正则化之外的正向流动
            m_flow := dm_flow_ddp_fric_a * (dp - dp_grav_a);
          elseif dp <= dp_b then
            // 正则化之外的负向流动
            m_flow := dm_flow_ddp_fric_b * (dp - dp_grav_b);
          else
            m_flow_a := dm_flow_ddp_fric_a * (dp_a - dp_grav_a);
            m_flow_b := dm_flow_ddp_fric_b * (dp_b - dp_grav_b);

            // 包括一个恰当定义的零质量流量点
            // 从线性剖面斜率 c 中获取合适的斜率（稍后将覆盖 m_flow 的值）
            (m_flow,dm_flow_ddp_fric_zero) := Utilities.regFun3(dp_zero, dp_b, dp_a, m_flow_b, m_flow_a, dm_flow_ddp_fric_b, dm_flow_ddp_fric_a);
            // 进行正则化处理
            if dp > dp_zero then
              m_flow := Utilities.regFun3(dp, dp_zero, dp_a, m_flow_zero, m_flow_a, dm_flow_ddp_fric_zero, dm_flow_ddp_fric_a);
            else
              m_flow := Utilities.regFun3(dp, dp_b, dp_zero, m_flow_b, m_flow_zero, dm_flow_ddp_fric_b, dm_flow_ddp_fric_zero);
            end if;
          end if;
          /*
          m_flow := if dp<dp_b then dm_flow_ddp_b*(dp-dp_grav_b) else
          (if dp>dp_a then dm_flow_ddp_a*(dp-dp_grav_a) else
          Modelica.Fluid.Utilities.regFun3(dp, dp_b, dp_a, dm_flow_ddp_b*(dp_b - dp_grav_b), dm_flow_ddp_a*(dp_a - dp_grav_a), dm_flow_ddp_b, dm_flow_ddp_a));
          */
          annotation(Documentation(info = "<html>

</html>"  ));
        end massFlowRate_dp_staticHead;

        redeclare function extends pressureLoss_m_flow_staticHead 
          "计算压降 dp 与质量流量 m_flow 的函数关系，即由管壁摩擦和静压头引起的 dp = f(m_flow)"

          // 警告：以下公式仅适用于圆管！
        protected
          Real k0 = 128 * length / (Modelica.Constants.pi * diameter ^ 4) 
            "常数系数";

          SI.Pressure dp_grav_a = g_times_height_ab * rho_a 
            "质量流沿设计方向(a to b)时的静压头";
          SI.Pressure dp_grav_b = g_times_height_ab * rho_b 
            "质量流沿设计反方向(b to a)时的静压头";

          Real ddp_dm_flow_a = k0 * mu_a / rho_a 
            "如果质量流沿设计方向(a to b)，dp 相对于质量流量的斜率";
          Real ddp_dm_flow_b = k0 * mu_b / rho_b 
            "如果质量流沿设计反方向(b to a)，dp 相对于质量流量的斜率";

          SI.MassFlowRate m_flow_a = if dp_grav_a >= dp_grav_b then m_flow_small else m_flow_small + (dp_grav_b - dp_grav_a) / ddp_dm_flow_a 
            "dp(m_flow) 关系的正则化区域上限";
          SI.MassFlowRate m_flow_b = if dp_grav_a >= dp_grav_b then -m_flow_small else -m_flow_small - (dp_grav_b - dp_grav_a) / ddp_dm_flow_b 
            "dp(m_flow) 关系的正则化区域下限";

          SI.Pressure dp_a "正则化域上限值";
          SI.Pressure dp_b "正则化域下限值";

          // 零质量流量条件的恰当定义
          SI.MassFlowRate m_flow_zero = 0;
          SI.Pressure dp_zero = (dp_grav_a + dp_grav_b) / 2;
          Real ddp_dm_flow_zero;
        algorithm
          /*
          dp = 0.5*zeta/(A^2*d) * m_flow * |m_flow|
          = 0.5 * c0/(|m_flow|*(4/pi)/(D_Re*mu)) / ((pi*(D_Re/2)^2)^2*d) * m_flow*|m_flow|
          = 0.5 * c0*(pi/4)*(D_Re*mu) * 16/(pi^2*D_Re^4*d) * m_flow*|m_flow|
          = 2*c0/(pi*D_Re^3) * mu/d * m_flow
          = k0 * mu/d * m_flow
          k0 = 2*c0/(pi*D_Re^3)
          */

          if m_flow >= m_flow_a then
            // 正则化之外的正向流动
            dp := (ddp_dm_flow_a * m_flow + dp_grav_a);
          elseif m_flow <= m_flow_b then
            // 正则化之外的负向流动
            dp := (ddp_dm_flow_b * m_flow + dp_grav_b);
          else
            // 正则化参数
            dp_a := ddp_dm_flow_a * m_flow_a + dp_grav_a;
            dp_b := ddp_dm_flow_b * m_flow_b + dp_grav_b;
            // 包括一个恰当定义的零质量流量点
            // 从线性剖面斜率 c 中获取合适的斜率（稍后将覆盖 dp 的值）
            (dp,ddp_dm_flow_zero) := Utilities.regFun3(m_flow_zero, m_flow_b, m_flow_a, dp_b, dp_a, ddp_dm_flow_b, ddp_dm_flow_a);
            // 进行正则化处理
            if m_flow > m_flow_zero then
              dp := Utilities.regFun3(m_flow, m_flow_zero, m_flow_a, dp_zero, dp_a, ddp_dm_flow_zero, ddp_dm_flow_a);
            else
              dp := Utilities.regFun3(m_flow, m_flow_b, m_flow_zero, dp_b, dp_zero, ddp_dm_flow_b, ddp_dm_flow_zero);
            end if;
          end if;
          annotation(Documentation(info = "<html>

</html>"  ));
        end pressureLoss_m_flow_staticHead;
        annotation(Documentation(info = "<html>
<p>
该组件仅定义了壁面摩擦的层流区：dp = k*m_flow，其中 \"k \"取决于密度和动态黏度。
壁面粗糙度对层流没有影响，因此忽略了粗糙度参数。
由于这是一种线性关系，因此出现的方程组通常要简单得多（例如，线性方程组而不是非线性方程组）。
通过使用密度和动力黏度的额定值，方程还可以进一步减少。
</p>

<p>
<a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.WallFriction\">用户指南</a> 
中说明了完整的摩擦机制。本部分仅描述 <strong>Hagen-Poiseuille</strong> 方程。
</p>
<br>

</html>"  ));
      end Laminar;

      package QuadraticTurbulent 
        "圆管中湍流的管壁摩擦力（简单特性，忽略动力黏度 mu）"
        import Modelica.Constants.pi;

        extends PartialWallFriction(
          final use_mu = false, 
          final use_roughness = true, 
          final use_dp_small = true, 
          final use_m_flow_small = true, 
          final use_Re_turbulent = false);

        redeclare function extends massFlowRate_dp 
          "计算质量流量 m_flow 与压降 dp 的函数关系，即由于避免摩擦引起的 m_flow = f(dp)"
          import Modelica.Math;
        protected
          Real zeta;
          Real k_inv;
        algorithm
          /*
          dp = 0.5*zeta*d*v*|v|
          = 0.5*zeta*d*1/(d*A)^2 * m_flow * |m_flow|
          = 0.5*zeta/A^2 *1/d * m_flow * |m_flow|
          = k/d * m_flow * |m_flow|
          k  = 0.5*zeta/A^2
          = 0.5*zeta/(pi*(D/2)^2)^2
          = 8*zeta/(pi*D^2)^2
          */
          assert(roughness > 1e-10, 
            "二次湍流壁面摩擦特性要求粗糙度 > 0");
          zeta := (length / diameter) / (2 * Math.log10(3.7 / (roughness / diameter))) ^ 2;
          // 警告：以下公式仅适用于圆管！
          k_inv := (pi * diameter * diameter) ^ 2 / (8 * zeta);
          m_flow := Modelica.Fluid.Utilities.regRoot2(dp, dp_small, rho_a * k_inv, rho_b * k_inv);
          annotation(smoothOrder = 1, Documentation(info = "<html>

</html>"  ));
        end massFlowRate_dp;

        redeclare function extends pressureLoss_m_flow 
          "计算压降 dp 与质量流流量 m_flow 的函数关系，即由于便面摩擦引起的 dp = f(m_flow)"
          import Modelica.Constants.pi;
          import Modelica.Math;

        protected
          Real zeta;
          Real k;
        algorithm
          /*
          dp = 0.5*zeta*d*v*|v|
          = 0.5*zeta*d*1/(d*A)^2 * m_flow * |m_flow|
          = 0.5*zeta/A^2 *1/d * m_flow * |m_flow|
          = k/d * m_flow * |m_flow|
          k  = 0.5*zeta/A^2
          = 0.5*zeta/(pi*(D/2)^2)^2
          = 8*zeta/(pi*D^2)^2
          */
          assert(roughness > 1e-10, 
            "二次湍流壁面摩擦特性要求粗糙度 > 0");
          zeta := (length / diameter) / (2 * Math.log10(3.7 / (roughness / diameter))) ^ 2;
          // 警告：以下公式仅适用于圆管！
          k := 8 * zeta / (pi * diameter * diameter) ^ 2;
          dp := Modelica.Fluid.Utilities.regSquare2(m_flow, m_flow_small, k / rho_a, k / rho_b);
          annotation(smoothOrder = 1, Documentation(info = "<html>

</html>"  ));
        end pressureLoss_m_flow;

        redeclare function extends massFlowRate_dp_staticHead 
          "计算质量流量 m_flow 与压降 dp 的函数关系，即由于避免摩擦和静压头引起的 m_flow = f(dp)"
          import Modelica.Math;
          import Modelica.Constants.pi;
        protected
          Real zeta = (length / diameter) / (2 * Math.log10(3.7 / (roughness / diameter))) ^ 2;
          // 警告：以下公式仅适用于圆管！
          Real k_inv = (pi * diameter * diameter) ^ 2 / (8 * zeta);

          SI.Pressure dp_grav_a = g_times_height_ab * rho_a 
            "质量流沿设计方向(a to b)时的静压头";
          SI.Pressure dp_grav_b = g_times_height_ab * rho_b 
            "质量流沿设计反方向(b to a)时的静压头";

          Real k1 = rho_a * k_inv "等式 m_flow =  sqrt(k1*(dp-dp_grav_a))中的系数";
          Real k2 = rho_b * k_inv "等式 m_flow = -sqrt(k2*|dp-dp_grav_b|)中的系数";

          Real dp_a = max(dp_grav_a, dp_grav_b) + dp_small 
            "m_flow(dp) 关系的正则化区域上限";
          Real dp_b = min(dp_grav_a, dp_grav_b) - dp_small 
            "m_flow(dp) 关系的正则化区域下限";

          SI.MassFlowRate m_flow_a 
            "正则化域上限值";
          SI.MassFlowRate m_flow_b 
            "正则化域下限值";

          SI.MassFlowRate dm_flow_ddp_fric_a 
            "正则化域上限的导数";
          SI.MassFlowRate dm_flow_ddp_fric_b 
            "正则化域下限的导数";

          // 零质量流量条件的恰当定义
          SI.MassFlowRate m_flow_zero = 0;
          SI.Pressure dp_zero = (dp_grav_a + dp_grav_b) / 2;
          Real dm_flow_ddp_fric_zero;
        algorithm
          /*
          dp = 0.5*zeta*d*v*|v|
          = 0.5*zeta*d*1/(d*A)^2 * m_flow * |m_flow|
          = 0.5*zeta/A^2 *1/d * m_flow * |m_flow|
          = k/d * m_flow * |m_flow|
          k  = 0.5*zeta/A^2
          = 0.5*zeta/(pi*(D/2)^2)^2
          = 8*zeta/(pi*D^2)^2
          */
          assert(roughness > 1e-10, 
            "二次湍流壁面摩擦特性要求粗糙度 > 0");

          if dp >= dp_a then
            // 正则化之外的正向流动
            m_flow := sqrt(k1 * (dp - dp_grav_a));
          elseif dp <= dp_b then
            // 正则化之外的负向流动
            m_flow := -sqrt(k2 * abs(dp - dp_grav_b));
          else
            m_flow_a := sqrt(k1 * (dp_a - dp_grav_a));
            m_flow_b := -sqrt(k2 * abs(dp_b - dp_grav_b));

            dm_flow_ddp_fric_a := k1 / (2 * sqrt(k1 * (dp_a - dp_grav_a)));
            dm_flow_ddp_fric_b := k2 / (2 * sqrt(k2 * abs(dp_b - dp_grav_b)));
            /*  dm_flow_ddp_fric_a := if abs(dp_a - dp_grav_a)>0 then k1/(2*sqrt(k1*(dp_a - dp_grav_a))) else  Modelica.Constants.inf);
            dm_flow_ddp_fric_b := if abs(dp_b - dp_grav_b)>0 then k2/(2*sqrt(k2*abs(dp_b - dp_grav_b))) else Modelica.Constants.inf; */

            // 包括适当定义的零质量流量点
            // 从线性斜率 c 中获取合适的斜率（m_flow 的值稍后会被覆盖）。
            (m_flow,dm_flow_ddp_fric_zero) := Utilities.regFun3(dp_zero, dp_b, dp_a, m_flow_b, m_flow_a, dm_flow_ddp_fric_b, dm_flow_ddp_fric_a);
            // 进行正规化处理
            if dp > dp_zero then
              m_flow := Utilities.regFun3(dp, dp_zero, dp_a, m_flow_zero, m_flow_a, dm_flow_ddp_fric_zero, dm_flow_ddp_fric_a);
            else
              m_flow := Utilities.regFun3(dp, dp_b, dp_zero, m_flow_b, m_flow_zero, dm_flow_ddp_fric_b, dm_flow_ddp_fric_zero);
            end if;
          end if;
          annotation(smoothOrder = 1, Documentation(info = "<html>

</html>"  ));
        end massFlowRate_dp_staticHead;

        redeclare function extends pressureLoss_m_flow_staticHead 
          "计算压降 dp 与质量流量 m_flow 的函数关系，即由管壁摩擦和静压头引起的 dp = f(m_flow)"
          import Modelica.Math;
          import Modelica.Constants.pi;
        protected
          Real zeta = (length / diameter) / (2 * Math.log10(3.7 / (roughness / diameter))) ^ 2;
          // 警告：以下公式仅适用于圆管！
          Real k = 8 * zeta / (pi * diameter * diameter) ^ 2;

          SI.Pressure dp_grav_a = g_times_height_ab * rho_a 
            "质量流沿设计方向(a to b)时的静压头";
          SI.Pressure dp_grav_b = g_times_height_ab * rho_b 
            "质量流沿设计反方向(b to a)时的静压头";

          Real k1 = k / rho_a "If m_flow >= 0 then dp = k1*m_flow^2 + dp_grav_a";
          Real k2 = k / rho_b "If m_flow < 0 then dp = -k2*m_flow^2 + dp_grav_b";

          SI.MassFlowRate m_flow_a = if dp_grav_a >= dp_grav_b then m_flow_small else m_flow_small + sqrt((dp_grav_b - dp_grav_a) / k1) 
            "dp(m_flow) 关系的正则化区域上限";
          SI.MassFlowRate m_flow_b = if dp_grav_a >= dp_grav_b then -m_flow_small else -m_flow_small - sqrt((dp_grav_b - dp_grav_a) / k2) 
            "dp(m_flow) 关系的正则化区域下限";

          SI.Pressure dp_a "正则化域上限值";
          SI.Pressure dp_b "正则化域下限值";

          Real ddp_dm_flow_a 
            "m_flow_a 处压降关于质量流量的导数";
          Real ddp_dm_flow_b 
            "m_flow_b 处压降关于质量流量的导数";

          // 零质量流量条件的恰当定义
          SI.MassFlowRate m_flow_zero = 0;
          SI.Pressure dp_zero = (dp_grav_a + dp_grav_b) / 2;
          Real ddp_dm_flow_zero;

        algorithm
          /*
          dp = 0.5*zeta*d*v*|v|
          = 0.5*zeta*d*1/(d*A)^2 * m_flow * |m_flow|
          = 0.5*zeta/A^2 *1/d * m_flow * |m_flow|
          = k/d * m_flow * |m_flow|
          k  = 0.5*zeta/A^2
          = 0.5*zeta/(pi*(D/2)^2)^2
          = 8*zeta/(pi*D^2)^2
          */
          assert(roughness > 1e-10, 
            "二次湍流壁面摩擦特性要求粗糙度 > 0");

          if m_flow >= m_flow_a then
            // 正则化之外的正向流动
            dp := (k1 * m_flow ^ 2 + dp_grav_a);
          elseif m_flow <= m_flow_b then
            // 正则化之外的负向流动
            dp := (-k2 * m_flow ^ 2 + dp_grav_b);
          else
            // 正则化参数
            dp_a := k1 * m_flow_a ^ 2 + dp_grav_a;
            ddp_dm_flow_a := 2 * k1 * m_flow_a;
            dp_b := -k2 * m_flow_b ^ 2 + dp_grav_b;
            ddp_dm_flow_b := -2 * k2 * m_flow_b;
            // 包括一个恰当定义的零质量流量点
            //从线性剖面斜率 c 中获取合适的斜率（稍后将覆盖 dp 的值）
            (dp,ddp_dm_flow_zero) := Utilities.regFun3(m_flow_zero, m_flow_b, m_flow_a, dp_b, dp_a, ddp_dm_flow_b, ddp_dm_flow_a);
            // 进行正则化处理
            if m_flow > m_flow_zero then
              dp := Utilities.regFun3(m_flow, m_flow_zero, m_flow_a, dp_zero, dp_a, ddp_dm_flow_zero, ddp_dm_flow_a);
            else
              dp := Utilities.regFun3(m_flow, m_flow_b, m_flow_zero, dp_b, dp_zero, ddp_dm_flow_b, ddp_dm_flow_zero);
            end if;
          end if;

          annotation(smoothOrder = 1, Documentation(info = "<html>

</html>"  ));
        end pressureLoss_m_flow_staticHead;
        annotation(Documentation(info = "<html>
<p>
该组件仅定义了壁面摩擦的二次湍流区：dp = k*m_flow*|m_flow|，其中 \"k \"取决于密度和管道的粗糙度，
不再是雷诺数的函数。这种关系仅对大雷诺数有效。
</p>

<p>
<a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.WallFriction\">用户指南</a> 
中说明了完整的摩擦机制。该组件仅描述了大雷诺数的渐近行为，即右侧纵坐标处的值（其中 λ 为常数）。
</p>
<br>

</html>"  ));
      end QuadraticTurbulent;

      package LaminarAndQuadraticTurbulent 
        "圆管中层流和湍流的管壁摩擦（简单特性）"

        extends PartialWallFriction(
          final use_mu = true, 
          final use_roughness = true, 
          final use_dp_small = true, 
          final use_m_flow_small = true, 
          final use_Re_turbulent = true);

        import ln = Modelica.Math.log "以e为底的对数";
        import Modelica.Math.log10 "以10为底的对数";
        import Modelica.Math.exp "指数函数";
        import Modelica.Constants.pi;

        redeclare function extends massFlowRate_dp 
          "计算质量流量 m_flow 与压降 dp 的函数关系，即由壁面摩擦引起的 m_flow = f(dp)"
          import Modelica.Math;
        protected
          Real zeta;
          Real k0;
          Real k_inv;
          Real yd0 "m_flow=m_flow(dp) 在零点的导数";
          SI.AbsolutePressure dp_turbulent;
        algorithm
          /*
          湍流区：
          // 警告：以下公式仅适用于圆管！
          Re = m_flow*(4/pi)/(D_Re*mu)
          dp = 0.5*zeta*rho*v*|v|
          = 0.5*zeta*rho*1/(rho*A)^2 * m_flow * |m_flow|
          = 0.5*zeta/A^2 *1/rho * m_flow * |m_flow|
          = k/rho * m_flow * |m_flow|
          k  = 0.5*zeta/A^2
          = 0.5*zeta/(pi*(D/2)^2)^2
          = 8*zeta/(pi*D^2)^2
          m_flow_turbulent = (pi/4)*D_Re*mu*Re_turbulent
          dp_turbulent     =  k/rho *(D_Re*mu*pi/4)^2 * Re_turbulent^2
          
          根据动力黏度 mu 和密度 rho 的平均值计算湍流区的起点。
          否则，就必须为两个流动方向引入不同的 "delta "值。
          为了简化方法，只使用一个"delta "值。
          
          层流区域：
          // 警告：以下公式仅适用于圆管！
          dp = 0.5*zeta/(A^2*d) * m_flow * |m_flow|
          = 0.5 * c0/(|m_flow|*(4/pi)/(D_Re*mu)) / ((pi*(D_Re/2)^2)^2*d) * m_flow*|m_flow|
          = 0.5 * c0*(pi/4)*(D_Re*mu) * 16/(pi^2*D_Re^4*d) * m_flow*|m_flow|
          = 2*c0/(pi*D_Re^3) * mu/rho * m_flow
          = k0 * mu/rho * m_flow
          k0 = 2*c0/(pi*D_Re^3)
          
          为了使 dp=f(m_flow) 的导数在 m_flow=0 时连续，
          在层流区域使用了 mu 和 d 的平均值：mu/rho = (mu_a + mu_b)/(rho_a + rho_b)。
          如果 data.zetaLaminarKnown = false，则 mu_a 和 mu_b 可能为零（因为是假值），
          因此只有在 zetaLaminarKnown = true 时才进行除法运算。
          */
          assert(roughness > 1e-10, 
            "二次湍流壁面摩擦特性要求粗糙度 > 0");
          // 警告：以下公式仅适用于圆管！
          zeta := (length / diameter) / (2 * Math.log10(3.7 / (roughness / diameter))) ^ 2;
          k0 := 128 * length / (pi * diameter ^ 4);
          k_inv := (pi * diameter * diameter) ^ 2 / (8 * zeta);
          yd0 := (rho_a + rho_b) / (k0 * (mu_a + mu_b));
          dp_turbulent := max(((mu_a + mu_b) * diameter * pi / 8) ^ 2 * Re_turbulent ^ 2 / (k_inv * (rho_a + rho_b) / 2), dp_small);
          m_flow := Modelica.Fluid.Utilities.regRoot2(dp, dp_turbulent, rho_a * k_inv, rho_b * k_inv, 
            use_yd0 = true, yd0 = yd0);
          annotation(smoothOrder = 1, Documentation(info = "<html>

</html>"  ));
        end massFlowRate_dp;

        redeclare function extends pressureLoss_m_flow 
          "计算压降 dp 与质量流量 m_flow 的函数关系，即由壁面摩擦引起的 dp = f(m_flow)"
          import Modelica.Math;
          import Modelica.Constants.pi;

        protected
          Real zeta;
          Real k0;
          Real k;
          Real yd0 "dp = f(m_flow) 在零点的导数";
          SI.MassFlowRate m_flow_turbulent 
            "湍流区域为|m_flow| >= m_flow_turbulent";

        algorithm
          /*
          湍流区：
          Re = m_flow*(4/pi)/(D_Re*mu)
          dp = 0.5*zeta*rho*v*|v|
          = 0.5*zeta*rho*1/(rho*A)^2 * m_flow * |m_flow|
          = 0.5*zeta/A^2 *1/rho * m_flow * |m_flow|
          = k/rho * m_flow * |m_flow|
          k  = 0.5*zeta/A^2
          = 0.5*zeta/(pi*(D/2)^2)^2
          = 8*zeta/(pi*D^2)^2
          m_flow_turbulent = (pi/4)*D_Re*mu*Re_turbulent
          dp_turbulent     =  k/rho *(D_Re*mu*pi/4)^2 * Re_turbulent^2
          
          根据动力黏度 mu 和密度 rho 的平均值计算湍流区的起点。
          否则，就必须为两个流动方向引入不同的 "delta " 值。
          为了简化方法，只使用一个 "delta " 值。
          
          层流区域：
          dp = 0.5*zeta/(A^2*d) * m_flow * |m_flow|
          = 0.5 * c0/(|m_flow|*(4/pi)/(D_Re*mu)) / ((pi*(D_Re/2)^2)^2*d) * m_flow*|m_flow|
          = 0.5 * c0*(pi/4)*(D_Re*mu) * 16/(pi^2*D_Re^4*d) * m_flow*|m_flow|
          = 2*c0/(pi*D_Re^3) * mu/rho * m_flow
          = k0 * mu/rho * m_flow
          k0 = 2*c0/(pi*D_Re^3)
          
          为了使 dp=f(m_flow) 的导数在 m_flow=0 时连续，
          在层流区域使用了 mu 和 d 的平均值：mu/rho = (mu_a + mu_b)/(rho_a + rho_b)。
          */
          assert(roughness > 1e-10, 
            "二次湍流壁面摩擦特性要求粗糙度 > 0");
          // 警告：以下公式仅适用于圆管！
          zeta := (length / diameter) / (2 * Math.log10(3.7 / (roughness / diameter))) ^ 2;
          k0 := 128 * length / (pi * diameter ^ 4);
          k := 8 * zeta / (pi * diameter * diameter) ^ 2;
          yd0 := k0 * (mu_a + mu_b) / (rho_a + rho_b);
          m_flow_turbulent := max((pi / 8) * diameter * (mu_a + mu_b) * Re_turbulent, m_flow_small);
          dp := Modelica.Fluid.Utilities.regSquare2(m_flow, m_flow_turbulent, k / rho_a, k / rho_b, 
            use_yd0 = true, yd0 = yd0);
          annotation(smoothOrder = 1, Documentation(info = "<html>

</html>"  ));
        end pressureLoss_m_flow;

        redeclare function extends massFlowRate_dp_staticHead 
          "计算质量流量 m_flow 与压降 dp 的函数关系，即由管壁摩擦和静压头引起的 m_flow = f(dp)"
          import Modelica.Math;

        protected
          Real Delta(min = 0) = roughness / diameter "相对粗糙度";
          SI.ReynoldsNumber Re1 = min(745 * exp(if Delta <= 0.0065 then 1 else 0.0065 / Delta), Re_turbulent) 
            "层流区与过渡区的边界";
          SI.ReynoldsNumber Re2 = Re_turbulent 
            "过渡区与湍流区的边界";

          SI.Pressure dp_a 
            "m_flow(dp) 关系的正则化域上限";
          SI.Pressure dp_b 
            "m_flow(dp) 关系的正则化域下限";

          SI.MassFlowRate m_flow_a 
            "正则化域上限值";
          SI.MassFlowRate m_flow_b 
            "正则化域下限值";

          SI.MassFlowRate dm_flow_ddp_fric_a 
            "正则化域上限的导数";
          SI.MassFlowRate dm_flow_ddp_fric_b 
            "正则化域下限的导数";

          SI.Pressure dp_grav_a = g_times_height_ab * rho_a 
            "质量流沿设计方向(a to b)时的静压头";
          SI.Pressure dp_grav_b = g_times_height_ab * rho_b 
            "质量流沿设计反方向(b to a)时的静压头";

          // 零质量流量条件的恰当定义
          SI.MassFlowRate m_flow_zero = 0;
          SI.Pressure dp_zero = (dp_grav_a + dp_grav_b) / 2;
          Real dm_flow_ddp_fric_zero;
        algorithm
          assert(roughness > 1e-10, 
            "二次湍流壁面摩擦特性要求粗糙度 > 0");

          dp_a := max(dp_grav_a, dp_grav_b) + dp_small;
          dp_b := min(dp_grav_a, dp_grav_b) - dp_small;

          if dp >= dp_a then
            // 正则化之外的正向流动
            m_flow := Internal.m_flow_of_dp_fric(dp - dp_grav_a, rho_a, rho_b, mu_a, mu_b, length, diameter, crossArea, Re1, Re2, Delta);
          elseif dp <= dp_b then
            // 正则化之外的负向流动
            m_flow := Internal.m_flow_of_dp_fric(dp - dp_grav_b, rho_a, rho_b, mu_a, mu_b, length, diameter, crossArea, Re1, Re2, Delta);
          else
            // 正则化参数
            (m_flow_a,dm_flow_ddp_fric_a) := Internal.m_flow_of_dp_fric(dp_a - dp_grav_a, rho_a, rho_b, mu_a, mu_b, length, diameter, crossArea, Re1, Re2, Delta);
            (m_flow_b,dm_flow_ddp_fric_b) := Internal.m_flow_of_dp_fric(dp_b - dp_grav_b, rho_a, rho_b, mu_a, mu_b, length, diameter, crossArea, Re1, Re2, Delta);
            // 包括一个恰当定义的零质量流量点
            // 从线性斜率 c 中获取合适的斜率（稍后将覆盖 m_flow 的值）
            (m_flow,dm_flow_ddp_fric_zero) := Utilities.regFun3(dp_zero, dp_b, dp_a, m_flow_b, m_flow_a, dm_flow_ddp_fric_b, dm_flow_ddp_fric_a);
            // 进行正则化处理
            if dp > dp_zero then
              m_flow := Utilities.regFun3(dp, dp_zero, dp_a, m_flow_zero, m_flow_a, dm_flow_ddp_fric_zero, dm_flow_ddp_fric_a);
            else
              m_flow := Utilities.regFun3(dp, dp_b, dp_zero, m_flow_b, m_flow_zero, dm_flow_ddp_fric_b, dm_flow_ddp_fric_zero);
            end if;
          end if;
          annotation(smoothOrder = 1, Documentation(info = "<html>

</html>"  ));
        end massFlowRate_dp_staticHead;

        redeclare function extends pressureLoss_m_flow_staticHead 
          "计算压降 dp 与质量流量 m_flow 的函数关系，即由管壁摩擦和静压头引起的 dp = f(m_flow)"
          import Modelica.Math;

        protected
          Real Delta(min = 0) = roughness / diameter "相对粗糙度";
          SI.ReynoldsNumber Re1 = min(745 * exp(if Delta <= 0.0065 then 1 else 0.0065 / Delta), Re_turbulent) 
            "层流区与过渡区的边界";
          SI.ReynoldsNumber Re2 = Re_turbulent 
            "过渡区与湍流区的边界";

          SI.MassFlowRate m_flow_a 
            "dp(m_flow) 关系的正则化域上限";
          SI.MassFlowRate m_flow_b 
            "dp(m_flow) 关系的正则化域下限";

          SI.Pressure dp_a "正则化域上限值";
          SI.Pressure dp_b "正则化域下限值";

          SI.Pressure dp_grav_a = g_times_height_ab * rho_a 
            "质量流沿设计方向(a to b)时的静压头";
          SI.Pressure dp_grav_b = g_times_height_ab * rho_b 
            "质量流沿设计反方向(b to a)时的静压头";

          Real ddp_dm_flow_a 
            "m_flow_a 处压降对质量流量的导数";
          Real ddp_dm_flow_b 
            "m_flow_b 处压降对质量流量的导数";

          // 零质量流量条件的恰当定义
          SI.MassFlowRate m_flow_zero = 0;
          SI.Pressure dp_zero = (dp_grav_a + dp_grav_b) / 2;
          Real ddp_dm_flow_zero;

        algorithm
          assert(roughness > 1e-10, 
            "二次湍流壁面摩擦特性要求粗糙度 > 0");

          m_flow_a := if dp_grav_a < dp_grav_b then 
            Internal.m_flow_of_dp_fric(dp_grav_b - dp_grav_a, rho_a, rho_b, mu_a, mu_b, length, diameter, crossArea, Re1, Re2, Delta) + m_flow_small else 
            m_flow_small;
          m_flow_b := if dp_grav_a < dp_grav_b then 
            Internal.m_flow_of_dp_fric(dp_grav_a - dp_grav_b, rho_a, rho_b, mu_a, mu_b, length, diameter, crossArea, Re1, Re2, Delta) - m_flow_small else 
            -m_flow_small;

          if m_flow >= m_flow_a then
            // 正则化之外的正向流动
            dp := Internal.dp_fric_of_m_flow(m_flow, rho_a, rho_b, mu_a, mu_b, length, diameter, crossArea, Re1, Re2, Delta) + dp_grav_a;
          elseif m_flow <= m_flow_b then
            // 正则化之外的负向流动
            dp := Internal.dp_fric_of_m_flow(m_flow, rho_a, rho_b, mu_a, mu_b, length, diameter, crossArea, Re1, Re2, Delta) + dp_grav_b;
          else
            // 正则化参数
            (dp_a,ddp_dm_flow_a) := Internal.dp_fric_of_m_flow(m_flow_a, rho_a, rho_b, mu_a, mu_b, length, diameter, crossArea, Re1, Re2, Delta);
            dp_a := dp_a + dp_grav_a "将 dp_grav 加入 dp_fric 以获得 dp";
            (dp_b,ddp_dm_flow_b) := Internal.dp_fric_of_m_flow(m_flow_b, rho_a, rho_b, mu_a, mu_b, length, diameter, crossArea, Re1, Re2, Delta);
            dp_b := dp_b + dp_grav_b "将 dp_grav 加入 dp_fric 以获得 dp";
            // 包括一个恰当定义的零质量流量点
            // 从线性斜率 c 中获取合适的斜率（稍后将覆盖 dp 的值）
            (dp,ddp_dm_flow_zero) := Utilities.regFun3(m_flow_zero, m_flow_b, m_flow_a, dp_b, dp_a, ddp_dm_flow_b, ddp_dm_flow_a);
            // 进行正则化处理
            if m_flow > m_flow_zero then
              dp := Utilities.regFun3(m_flow, m_flow_zero, m_flow_a, dp_zero, dp_a, ddp_dm_flow_zero, ddp_dm_flow_a);
            else
              dp := Utilities.regFun3(m_flow, m_flow_b, m_flow_zero, dp_b, dp_zero, ddp_dm_flow_b, ddp_dm_flow_zero);
            end if;
          end if;
          annotation(smoothOrder = 1, Documentation(info = "<html>

</html>"  ));
        end pressureLoss_m_flow_staticHead;

        package Internal 
          "通过摩擦压降计算质量流量，反之亦然"
          extends Modelica.Icons.InternalPackage;
          function m_flow_of_dp_fric 
            "计算质量流量与摩擦产生的压降的函数关系"
            extends Modelica.Icons.Function;

            input SI.Pressure dp_fric 
              "摩擦造成的压降 (dp = port_a.p - port_b.p)";
            input SI.Density rho_a "port_a 的密度";
            input SI.Density rho_b "port_b 的密度";
            input SI.DynamicViscosity mu_a 
              "port_a 的动力黏度 (如果 use_mu = false，则为假)";
            input SI.DynamicViscosity mu_b 
              "port_b 的动力黏度 (如果 use_mu = false，则为假)";
            input SI.Length length "管道长度";
            input SI.Diameter diameter "管道内径（水力直径）";
            input SI.Area crossArea "内部横截面积";
            input SI.ReynoldsNumber Re1 
              "层流区与过渡区的边界";
            input SI.ReynoldsNumber Re2 
              "过渡区与湍流区的边界";
            input Real Delta(min = 0) "相对粗糙度";
            output SI.MassFlowRate m_flow 
              "从 port_a 到 port_b 的质量流量";
            output Real dm_flow_ddp_fric 
              "质量流量对 dp_fric 的导数";
          protected
            SI.DynamicViscosity mu "上游黏度";
            SI.Density rho "上游密度";

            Real zeta;
            Real k0;
            Real k_inv;
            Real dm_flow_ddp_laminar 
              "层流状态下 m_flow=m_flow(dp) 的导数";
            SI.AbsolutePressure dp_fric_turbulent 
              "湍流区域为 |dp_fric| >= dp_fric_turbulent，简单二次相关性";
            SI.AbsolutePressure dp_fric_laminar 
              "层流区域为 |dp_fric| <= dp_fric_laminar";
          algorithm
            /*
            湍流区：
            Re = m_flow*(4/pi)/(D_Re*mu)
            dp = 0.5*zeta*rho*v*|v|
            = 0.5*zeta*rho*1/(rho*A)^2 * m_flow * |m_flow|
            = 0.5*zeta/A^2 *1/rho * m_flow * |m_flow|
            = k/rho * m_flow * |m_flow|
            k  = 0.5*zeta/A^2
            = 0.5*zeta/(pi*(D/2)^2)^2
            = 8*zeta/(pi*D^2)^2
            dp_fric_turbulent     =  k/rho *(D_Re*mu*pi/4)^2 * Re_turbulent^2
            
            层流区域：
            dp = 0.5*zeta/(A^2*d) * m_flow * |m_flow|
            = 0.5 * c0/(|m_flow|*(4/pi)/(D_Re*mu)) / ((pi*(D_Re/2)^2)^2*d) * m_flow*|m_flow|
            = 0.5 * c0*(pi/4)*(D_Re*mu) * 16/(pi^2*D_Re^4*d) * m_flow*|m_flow|
            = 2*c0/(pi*D_Re^3) * mu/rho * m_flow
            = k0 * mu/rho * m_flow
            k0 = 2*c0/(pi*D_Re^3)
            */
            // 确定上游密度和上游黏度
            if dp_fric >= 0 then
              rho := rho_a;
              mu := mu_a;
            else
              rho := rho_b;
              mu := mu_b;
            end if;
            // 二次湍流
            // 警告：以下公式仅适用于圆管！
            zeta := (length / diameter) / (2 * log10(3.7 / (Delta))) ^ 2;
            k_inv := (pi * diameter * diameter) ^ 2 / (8 * zeta);
            dp_fric_turbulent := sign(dp_fric) * (mu * diameter * pi / 4) ^ 2 * Re2 ^ 2 / (k_inv * rho);

            // 层流
            k0 := 128 * length / (pi * diameter ^ 4);
            dm_flow_ddp_laminar := rho / (k0 * mu);
            dp_fric_laminar := sign(dp_fric) * pi * k0 * mu ^ 2 / rho * diameter / 4 * Re1;

            if abs(dp_fric) > abs(dp_fric_turbulent) then
              m_flow := sign(dp_fric) * sqrt(rho * k_inv * abs(dp_fric));
              dm_flow_ddp_fric := 0.5 * rho * k_inv * (rho * k_inv * abs(dp_fric)) ^ (-0.5);
            elseif abs(dp_fric) < abs(dp_fric_laminar) then
              m_flow := dm_flow_ddp_laminar * dp_fric;
              dm_flow_ddp_fric := dm_flow_ddp_laminar;
            else
              // 初步测试表明，这里似乎不需要 log-log 变换
              (m_flow,dm_flow_ddp_fric) := Utilities.cubicHermite_withDerivative(
                dp_fric, dp_fric_laminar, dp_fric_turbulent, dm_flow_ddp_laminar * dp_fric_laminar, 
                sign(dp_fric_turbulent) * sqrt(rho * k_inv * abs(dp_fric_turbulent)), dm_flow_ddp_laminar, 
                if abs(dp_fric_turbulent) > 0 then 0.5 * rho * k_inv * (rho * k_inv * abs(dp_fric_turbulent)) ^ (-0.5) else Modelica.Constants.inf);
            end if;
            annotation(smoothOrder = 1);
          end m_flow_of_dp_fric;

          function dp_fric_of_m_flow 
            "计算摩擦导致的压降与质量流量的函数关系"
            extends Modelica.Icons.Function;

            input SI.MassFlowRate m_flow "从 port_a 到 port_b 的质量流量";
            input SI.Density rho_a "port_a 的密度";
            input SI.Density rho_b "port_b 的密度";
            input SI.DynamicViscosity mu_a 
              "port_a 的动力黏度 (如果 use_mu = false，则为假)";
            input SI.DynamicViscosity mu_b 
              "port_b 的动力黏度 (如果 use_mu = false，则为假)";
            input SI.Length length "管道长度";
            input SI.Diameter diameter "管道内径（水力直径）";
            input SI.Area crossArea "内部横截面积";
            input SI.ReynoldsNumber Re1 
              "层流区与过渡区的边界";
            input SI.ReynoldsNumber Re2 
              "过渡区与湍流区的边界";
            input Real Delta(min = 0) "相对粗糙度";
            output SI.Pressure dp_fric 
              "摩擦造成的压降 (dp_fric = port_a.p - port_b.p - dp_grav)";
            output Real ddp_fric_dm_flow 
              "压降对质量流量的导数";
          protected
            SI.DynamicViscosity mu "上游黏度";
            SI.Density rho "上游密度";
            Real zeta;
            Real k0;
            Real k;
            Real ddp_fric_dm_flow_laminar 
              "dp_fric = f(m_flow) 在零点的导数";
            SI.MassFlowRate m_flow_turbulent 
              "湍流区域为 |m_flow| >= m_flow_turbulent";
            SI.MassFlowRate m_flow_laminar 
              "层流区域为 |m_flow| <= m_flow_laminar";
          algorithm
            /*
            湍流区：
            Re = m_flow*(4/pi)/(D_Re*mu)
            dp = 0.5*zeta*rho*v*|v|
            = 0.5*zeta*rho*1/(rho*A)^2 * m_flow * |m_flow|
            = 0.5*zeta/A^2 *1/rho * m_flow * |m_flow|
            = k/rho * m_flow * |m_flow|
            k  = 0.5*zeta/A^2
            = 0.5*zeta/(pi*(D/2)^2)^2
            = 8*zeta/(pi*D^2)^2
            m_flow_turbulent = (pi/4)*D_Re*mu*Re_turbulent
            
            层流区域：
            dp = 0.5*zeta/(A^2*d) * m_flow * |m_flow|
            = 0.5 * c0/(|m_flow|*(4/pi)/(D_Re*mu)) / ((pi*(D_Re/2)^2)^2*d) * m_flow*|m_flow|
            = 0.5 * c0*(pi/4)*(D_Re*mu) * 16/(pi^2*D_Re^4*d) * m_flow*|m_flow|
            = 2*c0/(pi*D_Re^3) * mu/rho * m_flow
            = k0 * mu/rho * m_flow
            k0 = 2*c0/(pi*D_Re^3)
            */
            // 确定上游密度和上游黏度
            if m_flow >= 0 then
              rho := rho_a;
              mu := mu_a;
            else
              rho := rho_b;
              mu := mu_b;
            end if;

            // 湍流
            // 警告：以下公式仅适用于圆管！
            zeta := (length / diameter) / (2 * log10(3.7 / (Delta))) ^ 2;
            k := 8 * zeta / (pi * diameter * diameter) ^ 2;
            m_flow_turbulent := sign(m_flow) * (pi / 4) * diameter * mu * Re2;

            // 层流
            k0 := 128 * length / (pi * diameter ^ 4);
            ddp_fric_dm_flow_laminar := k0 * mu / rho;
            m_flow_laminar := sign(m_flow) * (pi / 4) * diameter * mu * Re1;

            if abs(m_flow) > abs(m_flow_turbulent) then
              dp_fric := k / rho * m_flow * abs(m_flow);
              ddp_fric_dm_flow := 2 * k / rho * abs(m_flow);
            elseif abs(m_flow) < abs(m_flow_laminar) then
              dp_fric := ddp_fric_dm_flow_laminar * m_flow;
              ddp_fric_dm_flow := ddp_fric_dm_flow_laminar;
            else
              // 初步测试表明，这里似乎不需要 log-log 变换
              (dp_fric,ddp_fric_dm_flow) := Utilities.cubicHermite_withDerivative(
                m_flow, m_flow_laminar, m_flow_turbulent, ddp_fric_dm_flow_laminar * m_flow_laminar, 
                k / rho * m_flow_turbulent * abs(m_flow_turbulent), ddp_fric_dm_flow_laminar, 2 * k / rho * abs(m_flow_turbulent));
            end if;
            annotation(smoothOrder = 1);
          end dp_fric_of_m_flow;
          annotation();
        end Internal;
        annotation(Documentation(info = "<html>
<p>
该组件定义了壁面摩擦的二次湍流区：dp = k*m_flow*|m_flow|，其中 \"k \"取决于密度和管道的粗糙度，
不再是雷诺数的函数。这一关系仅对大雷诺数有效。在 Re=4000 时，可以构造一个多项式，
该多项式在 Re=4000 时平稳地接近常数 λ（对于大雷诺数），并且在质量流量为零时具有与层流壁面摩擦相同的导数。
</p>
</html>"  ));
      end LaminarAndQuadraticTurbulent;

      package Detailed 
        "管道内层流和湍流的管壁摩擦（详细特性）"

        extends PartialWallFriction(
          final use_mu = true, 
          final use_roughness = true, 
          final use_dp_small = true, 
          final use_m_flow_small = true, 
          final use_Re_turbulent = true);

        import ln = Modelica.Math.log "以 e 为底的对数";
        import Modelica.Math.log10 "以 10 为底的对数";
        import Modelica.Math.exp "指数函数";

        redeclare function extends massFlowRate_dp 
          "计算质量流量 m_flow 与压降 dp 的函数关系，即由壁面摩擦引起的 m_flow = f(dp)"
          import Modelica.Math;
        protected
          Real Delta(min = 0) = roughness / diameter "相对粗糙度";
          SI.ReynoldsNumber Re1 = min((745 * Math.exp(if Delta <= 0.0065 then 1 else 0.0065 / Delta)) ^ 0.97, Re_turbulent) 
            "Re 离开层流区曲线";
          SI.ReynoldsNumber Re2 = Re_turbulent "Re 进入湍流区曲线";
          SI.DynamicViscosity mu "上游黏度";
          SI.Density rho "上游密度";
          SI.ReynoldsNumber Re "雷诺数";
          Real lambda2 "修正的摩擦系数 (= lambda*Re^2)";
          function interpolateInRegion2 = Modelica.Fluid.Dissipation.Utilities.Functions.General.CubicInterpolation_Re 
            "过渡区域的三次 Hermite 样条插值" annotation();
        algorithm
          // 确定上游密度、上游黏度和 lambda2
          rho := if dp >= 0 then rho_a else rho_b;
          mu := if dp >= 0 then mu_a else mu_b;
          lambda2 := abs(dp) * 2 * diameter ^ 3 * rho / (length * mu * mu);

          // 在层流假设下确定 Re
          Re := lambda2 / 64;

          // 如果是湍流，则修改 Re
          if Re > Re1 then
            Re := -2 * sqrt(lambda2) * Math.log10(2.51 / sqrt(lambda2) + 0.27 * Delta);
            if Re < Re2 then
              Re := interpolateInRegion2(Re, Re1, Re2, Delta, lambda2);
            end if;
          end if;

          // 确定质量流量
          m_flow := crossArea / diameter * mu * (if dp >= 0 then Re else -Re);
          annotation(smoothOrder = 1, Documentation(info = "<html>

</html>"      ));
        end massFlowRate_dp;

        redeclare function extends pressureLoss_m_flow 
          "计算压降 dp 与质量流量 m_flow 的函数关系，即由壁面摩擦引起的 dp = f(m_flow)"
          import Modelica.Math;
          import Modelica.Constants.pi;
        protected
          Real Delta(min = 0) = roughness / diameter "相对粗糙度";
          SI.ReynoldsNumber Re1 = min(745 * Math.exp(if Delta <= 0.0065 then 1 else 0.0065 / Delta), Re_turbulent) 
            "Re 离开层流区曲线";
          SI.ReynoldsNumber Re2 = Re_turbulent "Re 进入湍流区曲线";
          SI.DynamicViscosity mu "上游黏度";
          SI.Density rho "上游密度";
          SI.ReynoldsNumber Re "雷诺数";
          Real lambda2 "修正的摩擦系数 (= lambda*Re^2)";
          function interpolateInRegion2 = Modelica.Fluid.Dissipation.Utilities.Functions.General.CubicInterpolation_lambda 
            "过渡区域的三次 Hermite 样条插值" annotation();
        algorithm
          // 确定上游密度、上游黏度
          rho := if m_flow >= 0 then rho_a else rho_b;
          mu := if m_flow >= 0 then mu_a else mu_b;

          // 确定 Re，lambda2 和压降 drop
          Re := diameter * abs(m_flow) / (crossArea * mu);
          lambda2 := if Re <= Re1 then 64 * Re else 
            (if Re >= Re2 then 0.25 * (Re / Math.log10(Delta / 3.7 + 5.74 / Re ^ 0.9)) ^ 2 else 
            interpolateInRegion2(Re, Re1, Re2, Delta));
          dp := length * mu * mu / (2 * rho * diameter * diameter * diameter) * 
            (if m_flow >= 0 then lambda2 else -lambda2);
          annotation(smoothOrder = 1, Documentation(info = "<html>

</html>"      ));
        end pressureLoss_m_flow;

        redeclare function extends massFlowRate_dp_staticHead 
          "计算质量流量 m_flow 与压降 dp 的函数关系，即由管壁摩擦和静压头引起的 m_flow = f(dp)"

        protected
          Real Delta(min = 0) = roughness / diameter "相对粗糙度";
          SI.ReynoldsNumber Re "雷诺数";
          SI.ReynoldsNumber Re1 = min((745 * exp(if Delta <= 0.0065 then 1 else 0.0065 / Delta)) ^ 0.97, Re_turbulent) 
            "层流区与过渡区的边界";
          SI.ReynoldsNumber Re2 = Re_turbulent 
            "过渡区与湍流区的边界";
          SI.Pressure dp_a 
            "m_flow(dp) 关系的正则化域上限";
          SI.Pressure dp_b 
            "m_flow(dp) 关系的正则化域下限";
          SI.MassFlowRate m_flow_a 
            "正则化域上限值";
          SI.MassFlowRate m_flow_b 
            "正则化域下限值";

          SI.MassFlowRate dm_flow_ddp_fric_a 
            "正则化域上限的导数";
          SI.MassFlowRate dm_flow_ddp_fric_b 
            "正则化域下限的导数";

          SI.Pressure dp_grav_a = g_times_height_ab * rho_a 
            "质量流沿设计方向(a to b)时的静压头";
          SI.Pressure dp_grav_b = g_times_height_ab * rho_b 
            "质量流沿设计反方向(b to a)时的静压头";

          // 零质量流量条件的恰当定义
          SI.MassFlowRate m_flow_zero = 0;
          SI.Pressure dp_zero = (dp_grav_a + dp_grav_b) / 2;
          Real dm_flow_ddp_fric_zero;

        algorithm
          dp_a := max(dp_grav_a, dp_grav_b) + dp_small;
          dp_b := min(dp_grav_a, dp_grav_b) - dp_small;

          if dp >= dp_a then
            // 正则化之外的正向流动
            m_flow := Internal.m_flow_of_dp_fric(dp - dp_grav_a, rho_a, rho_b, mu_a, mu_b, length, diameter, crossArea, Re1, Re2, Delta);
          elseif dp <= dp_b then
            // 正则化之外的负向流动
            m_flow := Internal.m_flow_of_dp_fric(dp - dp_grav_b, rho_a, rho_b, mu_a, mu_b, length, diameter, crossArea, Re1, Re2, Delta);
          else
            // 正则化参数
            (m_flow_a,dm_flow_ddp_fric_a) := Internal.m_flow_of_dp_fric(dp_a - dp_grav_a, rho_a, rho_b, mu_a, mu_b, length, diameter, crossArea, Re1, Re2, Delta);
            (m_flow_b,dm_flow_ddp_fric_b) := Internal.m_flow_of_dp_fric(dp_b - dp_grav_b, rho_a, rho_b, mu_a, mu_b, length, diameter, crossArea, Re1, Re2, Delta);
            // 包括一个恰当定义的零质量流量点
            // 从线性斜率 c 中获取合适的斜率（稍后将覆盖 m_flow 的值）
            (m_flow,dm_flow_ddp_fric_zero) := Utilities.regFun3(dp_zero, dp_b, dp_a, m_flow_b, m_flow_a, dm_flow_ddp_fric_b, dm_flow_ddp_fric_a);
            // 进行正则化处理
            if dp > dp_zero then
              m_flow := Utilities.regFun3(dp, dp_zero, dp_a, m_flow_zero, m_flow_a, dm_flow_ddp_fric_zero, dm_flow_ddp_fric_a);
            else
              m_flow := Utilities.regFun3(dp, dp_b, dp_zero, m_flow_b, m_flow_zero, dm_flow_ddp_fric_b, dm_flow_ddp_fric_zero);
            end if;
          end if;
          annotation(smoothOrder = 1);
        end massFlowRate_dp_staticHead;

        redeclare function extends pressureLoss_m_flow_staticHead 
          "计算压降 dp 与质量流量 m_flow 的函数关系，即由管壁摩擦和静压头引起的 dp = f(m_flow)"

        protected
          Real Delta(min = 0) = roughness / diameter "相对粗糙度";
          SI.ReynoldsNumber Re1 = min(745 * exp(if Delta <= 0.0065 then 1 else 0.0065 / Delta), Re_turbulent) 
            "层流区与过渡区的边界";
          SI.ReynoldsNumber Re2 = Re_turbulent 
            "过渡区与湍流区的边界";

          SI.MassFlowRate m_flow_a 
            "dp(m_flow) 关系的正则化域上限";
          SI.MassFlowRate m_flow_b 
            "dp(m_flow) 关系的正则化域下限";

          SI.Pressure dp_a "正则化域上限值";
          SI.Pressure dp_b "正则化域下限值";

          SI.Pressure dp_grav_a = g_times_height_ab * rho_a 
            "质量流沿设计方向(a to b)时的静压头";
          SI.Pressure dp_grav_b = g_times_height_ab * rho_b 
            "质量流沿设计反方向(b to a)时的静压头";

          Real ddp_dm_flow_a 
            "m_flow_a 处压降对质量流量的导数";
          Real ddp_dm_flow_b 
            "m_flow_b 处压降对质量流量的导数";

          // 零质量流量条件的恰当定义
          SI.MassFlowRate m_flow_zero = 0;
          SI.Pressure dp_zero = (dp_grav_a + dp_grav_b) / 2;
          Real ddp_dm_flow_zero;

        algorithm
          m_flow_a := if dp_grav_a < dp_grav_b then 
            Internal.m_flow_of_dp_fric(dp_grav_b - dp_grav_a, rho_a, rho_b, mu_a, mu_b, length, diameter, crossArea, Re1, Re2, Delta) + m_flow_small else 
            m_flow_small;
          m_flow_b := if dp_grav_a < dp_grav_b then 
            Internal.m_flow_of_dp_fric(dp_grav_a - dp_grav_b, rho_a, rho_b, mu_a, mu_b, length, diameter, crossArea, Re1, Re2, Delta) - m_flow_small else 
            -m_flow_small;

          if m_flow >= m_flow_a then
            // 正则化之外的正向流动
            dp := Internal.dp_fric_of_m_flow(m_flow, rho_a, rho_b, mu_a, mu_b, length, diameter, crossArea, Re1, Re2, Delta) + dp_grav_a;
          elseif m_flow <= m_flow_b then
            // 正则化之外的负向流动
            dp := Internal.dp_fric_of_m_flow(m_flow, rho_a, rho_b, mu_a, mu_b, length, diameter, crossArea, Re1, Re2, Delta) + dp_grav_b;
          else
            // 正则化参数
            (dp_a,ddp_dm_flow_a) := Internal.dp_fric_of_m_flow(m_flow_a, rho_a, rho_b, mu_a, mu_b, length, diameter, crossArea, Re1, Re2, Delta);
            dp_a := dp_a + dp_grav_a "将 dp_grav 加入 dp_fric 以获得 dp";
            (dp_b,ddp_dm_flow_b) := Internal.dp_fric_of_m_flow(m_flow_b, rho_a, rho_b, mu_a, mu_b, length, diameter, crossArea, Re1, Re2, Delta);
            dp_b := dp_b + dp_grav_b "将 dp_grav 加入 dp_fric 以获得 dp";
            // 包括一个恰当定义的零质量流量点
            // 从线性斜率 c 中获取合适的斜率（稍后将覆盖 dp 的值）
            (dp,ddp_dm_flow_zero) := Utilities.regFun3(m_flow_zero, m_flow_b, m_flow_a, dp_b, dp_a, ddp_dm_flow_b, ddp_dm_flow_a);
            // 进行正则化处理
            if m_flow > m_flow_zero then
              dp := Utilities.regFun3(m_flow, m_flow_zero, m_flow_a, dp_zero, dp_a, ddp_dm_flow_zero, ddp_dm_flow_a);
            else
              dp := Utilities.regFun3(m_flow, m_flow_b, m_flow_zero, dp_b, dp_zero, ddp_dm_flow_b, ddp_dm_flow_zero);
            end if;
          end if;
          annotation(smoothOrder = 1);
        end pressureLoss_m_flow_staticHead;

        package Internal 
          "通过摩擦压降计算质量流量，反之亦然"
          extends Modelica.Icons.InternalPackage;
          function m_flow_of_dp_fric 
            "计算质量流量与摩擦产生的压降的函数关系"
            extends Modelica.Icons.Function;

            input SI.Pressure dp_fric 
              "摩擦造成的压降 (dp = port_a.p - port_b.p)";
            input SI.Density rho_a "port_a 的密度";
            input SI.Density rho_b "port_b 的密度";
            input SI.DynamicViscosity mu_a 
              "port_a 的动力黏度 (如果 use_mu = false，则为假)";
            input SI.DynamicViscosity mu_b 
              "port_b 的动力黏度 (如果 use_mu = false，则为假)";
            input SI.Length length "管道长度";
            input SI.Diameter diameter "管道内径（水力直径）";
            input SI.Area crossArea "内部横截面积";
            input SI.ReynoldsNumber Re1 
              "层流区与过渡区的边界";
            input SI.ReynoldsNumber Re2 
              "过渡区与湍流区的边界";
            input Real Delta(min = 0) "相对粗糙度";
            output SI.MassFlowRate m_flow "从 port_a 到 port_b 的质量流量";
            output Real dm_flow_ddp_fric 
              "质量流量对 dp_fric 的导数";

          protected
            function interpolateInRegion2_withDerivative 
              "使用三次 Hermite 多项式在 log-log 空间进行插值，其中 x=log10(lambda2), y=log10(Re)"
              extends Modelica.Icons.Function;

              input Real lambda2 "已知独立变量";
              input SI.ReynoldsNumber Re1 
                "层流区与过渡区的边界";
              input SI.ReynoldsNumber Re2 
                "过渡区与湍流区的边界";
              input Real Delta(min = 0) "相对粗糙度";
              input SI.Pressure dp_fric 
                "摩擦造成的压降 (dp = port_a.p - port_b.p)";
              output SI.ReynoldsNumber Re "未知的计算变量";
              output Real dRe_ddp "计算值的导数";
              // 点 lg(lambda2(Re1))，导数为 lg(Re1)
            protected
              Real x1 = log10(64 * Re1);
              Real y1 = log10(Re1);
              Real y1d = 1;

              // 点 lg(lambda2(Re2))，导数为 lg(Re2)
              Real aux2 = Delta / 3.7 + 5.74 / Re2 ^ 0.9;
              Real aux3 = log10(aux2);
              Real L2 = 0.25 * (Re2 / aux3) ^ 2;
              Real aux4 = 2.51 / sqrt(L2) + 0.27 * Delta;
              Real aux5 = -2 * sqrt(L2) * log10(aux4);
              Real x2 = log10(L2);
              Real y2 = log10(aux5);
              Real y2d = 0.5 + (2.51 / log(10)) / (aux5 * aux4);

              // 变换空间的关注点
              Real x = log10(lambda2);
              Real y;
              Real dy_dx "变换空间的导数";
            algorithm
              // 插值
              (y,dy_dx) := Utilities.cubicHermite_withDerivative(x, x1, x2, y1, y2, y1d, y2d);

              // 计算值
              Re := 10 ^ y;

              // 计算值的导数
              dRe_ddp := Re / abs(dp_fric) * dy_dx;
              annotation(smoothOrder = 1);
            end interpolateInRegion2_withDerivative;

            SI.DynamicViscosity mu "上游黏度";
            SI.Density rho "上游密度";
            Real lambda2 "修正的摩擦系数 (= lambda*Re^2)";
            SI.ReynoldsNumber Re "雷诺数";
            Real dRe_ddp "dRe/ddp";
            Real aux1;
            Real aux2;

          algorithm
            // 确定上游密度和上游黏度
            if dp_fric >= 0 then
              rho := rho_a;
              mu := mu_a;
            else
              rho := rho_b;
              mu := mu_b;
            end if;

            // 正质量流量
            lambda2 := abs(dp_fric) * 2 * diameter ^ 3 * rho / (length * mu * mu) 
              "已知 lambda2=f(dp)";

            aux1 := (2 * diameter ^ 3 * rho) / (length * mu ^ 2);

            // 在层流假设下确定 Re 和 dRe/ddp
            Re := lambda2 / 64 "Hagen-Poiseuille";
            dRe_ddp := aux1 / 64 "Hagen-Poiseuille";

            // 如果是湍流，则修改 Re
            if Re > Re1 then
              Re := -2 * sqrt(lambda2) * log10(2.51 / sqrt(lambda2) + 0.27 * Delta) 
                "Colebrook-White";
              aux2 := sqrt(aux1 * abs(dp_fric));
              dRe_ddp := 1 / log(10) * (-2 * log(2.51 / aux2 + 0.27 * Delta) * aux1 / (2 * aux2) + 2 * 2.51 / (2 * abs(dp_fric) * (2.51 / aux2 + 0.27 * Delta)));
              if Re < Re2 then
                (Re,dRe_ddp) := interpolateInRegion2_withDerivative(lambda2, Re1, Re2, Delta, dp_fric);
              end if;
            end if;

            // 确定质量流量
            m_flow := crossArea / diameter * mu * (if dp_fric >= 0 then Re else -Re);
            // 用 dp_fric 求质量流量的导数
            dm_flow_ddp_fric := crossArea / diameter * mu * dRe_ddp;
            annotation(smoothOrder = 1);
          end m_flow_of_dp_fric;

          function dp_fric_of_m_flow 
            "计算摩擦导致的压降与质量流量的函数关系"
            extends Modelica.Icons.Function;

            input SI.MassFlowRate m_flow "从 port_a 到 port_b 的质量流量";
            input SI.Density rho_a "port_a 的密度";
            input SI.Density rho_b "port_b 的密度";
            input SI.DynamicViscosity mu_a 
              "port_a 的动力黏度 (如果 use_mu = false，则为假)";
            input SI.DynamicViscosity mu_b 
              "port_b 的动力黏度 (如果 use_mu = false，则为假)";
            input SI.Length length "管道长度";
            input SI.Diameter diameter "管道内径（水力直径）";
            input SI.Area crossArea "内部横截面积";
            input SI.ReynoldsNumber Re1 
              "层流区与过渡区的边界";
            input SI.ReynoldsNumber Re2 
              "过渡区与湍流区的边界";
            input Real Delta(min = 0) "相对粗糙度";
            output SI.Pressure dp_fric 
              "摩擦造成的压降 (dp_fric = port_a.p - port_b.p - dp_grav)";
            output Real ddp_fric_dm_flow 
              "压降对质量流量的导数";

          protected
            function interpolateInRegion2 
              "使用三次 Hermite 多项式在 log-log 空间进行插值，其中 x=log10(Re), y=log10(lambda2)"
              extends Modelica.Icons.Function;

              input SI.ReynoldsNumber Re "已知独立变量";
              input SI.ReynoldsNumber Re1 
                "层流区与过渡区的边界";
              input SI.ReynoldsNumber Re2 
                "过渡区与湍流区的边界";
              input Real Delta(min = 0) "相对粗糙度";
              input SI.MassFlowRate m_flow "从 port_a 到 port_b 的质量流量";
              output Real lambda2 "未知的计算变量";
              output Real dlambda2_dm_flow "计算值的导数";
              // 点 lg(lambda2(Re1))，导数为 lg(Re1)
            protected
              Real x1 = log10(Re1);
              Real y1 = log10(64 * Re1);
              Real y1d = 1;

              // 点 lg(lambda2(Re2))，导数为 lg(Re2)
              Real aux2 = Delta / 3.7 + 5.74 / Re2 ^ 0.9;
              Real aux3 = log10(aux2);
              Real L2 = 0.25 * (Re2 / aux3) ^ 2;
              Real x2 = log10(Re2);
              Real y2 = log10(L2);
              Real y2d = 2 + (2 * 5.74 * 0.9) / (log(aux2) * Re2 ^ 0.9 * aux2);

              // 变换空间的关注点
              Real x = log10(Re);
              Real y;
              Real dy_dx "变换空间的导数";
            algorithm
              // 插值
              (y,dy_dx) := Utilities.cubicHermite_withDerivative(x, x1, x2, y1, y2, y1d, y2d);

              // 计算值
              lambda2 := 10 ^ y;

              // 计算值的导数
              dlambda2_dm_flow := lambda2 / abs(m_flow) * dy_dx;
              annotation(smoothOrder = 1);
            end interpolateInRegion2;

            SI.DynamicViscosity mu "上游黏度";
            SI.Density rho "上游密度";
            SI.ReynoldsNumber Re "雷诺数";
            Real lambda2 "修正的摩擦系数 (= lambda*Re^2)";
            Real dlambda2_dm_flow "dlambda2/dm_flow";
            Real aux1;
            Real aux2;

          algorithm
            // 确定上游密度和上游黏度
            if m_flow >= 0 then
              rho := rho_a;
              mu := mu_a;
            else
              rho := rho_b;
              mu := mu_b;
            end if;

            // 确定雷诺数
            Re := abs(m_flow) * diameter / (crossArea * mu);

            aux1 := diameter / (crossArea * mu);

            // 根据实际情况对 lambda2 使用相关性系数
            if Re <= Re1 then
              lambda2 := 64 * Re "Hagen-Poiseuille";
              dlambda2_dm_flow := 64 * aux1 "Hagen-Poiseuille";
            elseif Re >= Re2 then
              lambda2 := 0.25 * (Re / log10(Delta / 3.7 + 5.74 / Re ^ 0.9)) ^ 2 "Swamee-Jain";
              aux2 := Delta / 3.7 + 5.74 / ((aux1 * abs(m_flow)) ^ 0.9);
              dlambda2_dm_flow := 0.5 * aux1 * Re * log(10) ^ 2 * (1 / (log(aux2) ^ 2) + (5.74 * 0.9) / (log(aux2) ^ 3 * Re ^ 0.9 * aux2)) 
                "Swamee-Jain";
            else
              (lambda2,dlambda2_dm_flow) := interpolateInRegion2(Re, Re1, Re2, Delta, m_flow);
            end if;

            // 根据 lambda2 计算压降
            dp_fric := length * mu * mu / (2 * rho * diameter * diameter * diameter) * 
              (if m_flow >= 0 then lambda2 else -lambda2);

            // 计算 dlambda2/dm_flow 的导数
            ddp_fric_dm_flow := (length * mu ^ 2) / (2 * diameter ^ 3 * rho) * dlambda2_dm_flow;
            annotation(smoothOrder = 1);
          end dp_fric_of_m_flow;
          annotation();
        end Internal;
        annotation(Documentation(info = "<html>
<p>
该组件定义了管壁摩擦的完整范围。详情请参见<a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.WallFriction\">用户指南</a>。
下图显示了摩擦损失因子 λ 的函数关系。
函数 massFlowRate_dp() 定义了 \"红色曲线\"（\"Swamee and Jain\"），
而函数 pressureLoss_m_flow() 则定义了 \"蓝色曲线\"（\"Colebrook-White\"）。
这两个函数互为逆函数，在 Re = 1500 至4000 之间的过渡区域内会给出略有不同的结果，以便获得显式方程而无需求解非线性方程。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Pipes/BaseClasses/PipeFriction1.png\"
alt=\"PipeFriction1.png\">
</div>

<p>
除了壁面摩擦力之外，该组件还能正确地实现静压头。
关于后者，可以区分两种情况。在下一种情况中，从 a 到 b 的高度变化与密度变化的符号相反。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Pipes/BaseClasses/PipeFrictionStaticHead_case-a.png\"
alt=\"PipeFrictionStaticHead_case-a.png\">
</div>

<p>
在第二种情况下，从 a 到 b 的高度变化与密度变化的符号相同。</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Pipes/BaseClasses/PipeFrictionStaticHead_case-b.png\"
alt=\"PipeFrictionStaticHead_case-b.png\">
</div>

</html>"      ));
      end Detailed;
      annotation(Documentation(info = "<html>
<p>
此子库提供用于计算<strong>管道内壁摩擦</strong>造成的压力损失的函数。
每个相关性都由一个库定义，该库通过继承 WallFriction.PartialWallFriction 库而派生。
有关管道壁面摩擦模型的详细信息，请参阅<a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.WallFriction\">用户指南</a>。
方程的不同变体的基本公式如下：
</p>

<blockquote><pre>
dp = &lambda;(Re,&Delta;)*(L/D)*&rho;*v*|v|/2
</pre></blockquote>

<p>
其中摩擦损耗因数 λ 如下图所示：
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Pipes/BaseClasses/PipeFriction1.png\"
alt=\"PipeFriction1.png\">
</div>

</html>"  ));
    end WallFriction;
    annotation();
  end BaseClasses;

  annotation(Documentation(info = "<html>
</html>"));
end Pipes;