within Modelica.Fluid;
package Vessels "流体储存装置"
  extends Modelica.Icons.VariantsPackage;

  model ClosedVolume "定容封闭水箱"
    import Modelica.Constants.pi;

    // 质量守恒、能量守恒，接口定义
    extends Modelica.Fluid.Vessels.BaseClasses.PartialLumpedVessel(
      final fluidVolume = V, 
      vesselArea = pi * (3 / 4 * V) ^ (2 / 3), 
      heatTransfer(surfaceAreas = {4 * pi * (3 / 4 * V / pi) ^ (2 / 3)}), use_HeatTransfer = false, use_T_start = true);

    parameter SI.Volume V "容积";

  equation
    Wb_flow = 0;
    for i in 1:nPorts loop
      vessel_ps_static[i] = medium.p;
    end for;

    annotation(defaultComponentName = "Volume", 
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
      100, 100}}), graphics = {Ellipse(
      extent = {{-100, 100}, {100, -100}}, 
      fillPattern = FillPattern.Sphere, 
      fillColor = {170, 213, 255}), Text(
      extent = {{-150, 12}, {150, -18}}, 
      textString = "V=%V")}), 
      Documentation(info = "<html><p>
理想混合体积，大小恒定，具有两个流体端口和一个介质模型。其流体性质由上游物理量计算，
如果显示<code>use_portsData=false</code>则节点和介质的压力相等。传热计算通过可用的传热接口进行，
但是如果传热接口没有连接，其传热仍然为0。假设传热区域为球形，其体积 V=4/3*pi*r^3，面积 A=4*pi*r^2，
默认为理想传热，则其热接口的温度与介质温度相等。
</p>
<p>
如果显示为<code>use_portsData=true</code>，则接口压力代表连接管道出口之后或进口之前的压力。
流阻<code>portsData.zeta_in</code>和<code>portsData.zeta_out</code>决定了容积和管道之间的压降，
具体依赖于流动方向。 参见于 <a href=\"modelica://Modelica.Fluid.Vessels.BaseClasses.VesselPortsData\" target=\"\">VesselPortsData</a>
和 <em>[Idelchik, Handbook of Hydraulic Resistance, 2004]</em>.
</p>
</html>"  ));
  end ClosedVolume;

  model OpenTank "敞口水箱"
    import Modelica.Constants.pi;

    // 水箱特性
    SI.Height level(stateSelect = StateSelect.prefer, start = level_start_eps) "水箱液面高度";
    SI.Volume V(stateSelect = StateSelect.never) "水箱实际容积";

    // 水箱几何形状
    parameter SI.Height height "水箱高度";
    parameter SI.Area crossArea "水箱截面积";

    // 环境
    parameter Medium.AbsolutePressure p_ambient = system.p_ambient "水箱表面压力" 
      annotation(Dialog(tab = "假设", group = "环境"));
    parameter Medium.Temperature T_ambient = system.T_ambient "水箱表面温度" 
      annotation(Dialog(tab = "假设", group = "环境"));

    // 初始化
    parameter SI.Height level_start(min = 0) = 0.5 * height 
      "水箱液位的起始值" 
      annotation(Dialog(tab = "初始化"));

    // 质量和能量平衡，接口定义
    extends Modelica.Fluid.Vessels.BaseClasses.PartialLumpedVessel(
      final fluidVolume = V, 
      final fluidLevel = level, 
      final fluidLevel_max = height, 
      final vesselArea = crossArea, 
      heatTransfer(surfaceAreas = {crossArea + 2 * sqrt(crossArea * pi) * level}), 
      final initialize_p = false, 
      final p_start = p_ambient);

  protected
    final parameter SI.Height level_start_eps = max(level_start, Modelica.Constants.eps);

  equation
    V = crossArea * level "Volume of fluid";
    medium.p = p_ambient;

    // 边界项能量平衡
    if Medium.singleState or energyDynamics == Types.Dynamics.SteadyState then
      Wb_flow = 0 
        "忽略机械功，因为介质模型中也忽略了机械功（否则，如果水箱液位发生变化，温度的微小变化将不符合实际情况）";
    else
      Wb_flow = -p_ambient * der(V);
    end if;

    //定义接口属性
    for i in 1:nPorts loop
      vessel_ps_static[i] = max(0, level - portsData_height[i]) * system.g * medium.d + p_ambient;
    end for;

  initial equation
    if massDynamics == Types.Dynamics.FixedInitial then
      level = level_start_eps;
    elseif massDynamics == Types.Dynamics.SteadyStateInitial then
      der(level) = 0;
    end if;

    annotation(defaultComponentName = "tank", 
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}, 
      initialScale = 0.2), graphics = {
      Rectangle(
      extent = {{-100, 100}, {100, -100}}, 
      lineColor = {255, 255, 255}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.VerticalCylinder), 
      Rectangle(
      extent = DynamicSelect({{-100, -100}, {100, 10}}, {{-100, -100}, {100, (-100 
      + 200 * level / height)}}), 
      fillColor = {85, 170, 255}, 
      fillPattern = FillPattern.VerticalCylinder), 
      Line(points = {{-100, 100}, {-100, -100}, {100, -100}, {100, 100}}), 
      Text(
      extent = {{-95, 60}, {95, 40}}, 
      textString = "level ="), 
      Text(
      extent = {{-95, -24}, {95, -44}}, 
      textString = DynamicSelect("%level_start", String(
      level, 
      minimumLength = 1, 
      significantDigits = 2)))}), 
      Documentation(info = "<html>
<p>
这是一个开放于环境并在固定压力<code>p_ambient</code>下的水箱模型。
</p>
<p>
连接器端口向量表示相对于水箱底部位于可配置高度的流体端口。流体可以从每个端口流出或流入。
</p>
以下是做出的假设：
<ul>
<li>水箱填充有密度高于环境介质密度的单一或多组分介质；</li>
<li>液体的密度、温度和质量分数均匀一致；</li>
<li>如果液面超过水箱高度，仿真就会中断。</li>
</ul>
<p>
端口压力表示连接管道出口处（或入口处前方）的压力。
流体阻力 <code>portsData.zeta_in</code> 和 <code>portsData.zeta_out</code> 根据质量流的方向确定水箱和接口之间的耗散压降，
具体取决于质量流的方向。具体请参阅 <a href=\"modelica://Modelica.Fluid.Vessels.BaseClasses.VesselPortsData\" target=\"\">VesselPortsData</a> 和<em>[Idelchik, Handbook of Hydraulic Resistance, 2004]</em>。</p>
<p>
当设置 <code>use_portsData=false</code> 时，接口压力表示各个接口高度处的静压头。
压降与接口处质量流速之间的关系必须由连接组件提供；接口的高度、流入或流出液体的动能和势能不再考虑。
</p>
</html>"  , revisions = "<html>
<ul>
<li><em>Dec. 12, 2008</em> by R&uuml;diger Franke: move port definitions
   to BaseClasses.PartialLumpedVessel; also use energy and mass balance from common base class</li>
<li><em>Dec. 8, 2008</em> by Michael Wetter (LBNL):<br>
Implemented trace substances.</li>
<li><em>Jan. 6, 2006</em> by Katja Poschlad, Manuel Remelhe (AST Uni Dortmund),
   Martin Otter (DLR):<br>
   Implementation based on former tank model.</li>
<li><em>Oct. 29, 2007</em> by Carsten Heinrich (ILK Dresden):<br>
Adapted to the new fluid library interfaces:
<ul> <li>FluidPorts_b is used instead of FluidPort_b (due to it is defined as an array of ports)</li>
    <li>Port name changed from port to ports</li></ul>Updated documentation.</li>
<li><em>Apr. 25, 2006</em> by Katrin Pr&ouml;l&szlig; (TUHH):<br>
Limitation to bottom ports only, added inlet and outlet loss factors.</li>
</ul>
</html>"  ));
  end OpenTank;

  package BaseClasses "Vessels库中使用的基类（用于构建新组件模型）"
    extends Modelica.Icons.BasesPackage;

    partial model PartialLumpedVessel "带有流体接口矢量和可替换传热模型的集总容积"
      extends Modelica.Fluid.Interfaces.PartialLumpedVolume;

      // 接口定义
      parameter Integer nPorts = 0 "接口数量" 
        annotation(Evaluate = true, Dialog(connectorSizing = true, tab = "基本", group = "接口"));
      VesselFluidPorts_b ports[nPorts](redeclare each package Medium = Medium) 
        "流体出入口" 
        annotation(Placement(transformation(extent = {{-40, -10}, {40, 10}}, 
        origin = {0, -100})));

      // 接口性质
      parameter Boolean use_portsData = true "false: 忽略压力损失和动能" 
        annotation(Evaluate = true, Dialog(tab = "基本", group = "接口"));
      parameter Modelica.Fluid.Vessels.BaseClasses.VesselPortsData[if use_portsData then nPorts else 0] 
        portsData "输出/输入接口的数据" 
        annotation(Dialog(tab = "基本", group = "接口", enable = use_portsData));

      parameter Medium.MassFlowRate m_flow_nominal = if system.use_eps_Re then system.m_flow_nominal else 1e2 * system.m_flow_small "额定质量流量" 
        annotation(Dialog(tab = "高级", group = "接口属性"));
      parameter SI.MassFlowRate m_flow_small(min = 0) = if system.use_eps_Re then system.eps_m_flow * m_flow_nominal else system.m_flow_small "质量流量为零时的规范化范围" 
        annotation(Dialog(tab = "高级", group = "接口属性"));
      parameter Boolean use_Re = system.use_eps_Re "true: 湍流区域由 Re 定义，否则由 m_flow_small 定义" 
        annotation(Dialog(tab = "高级", group = "接口属性"), Evaluate = true);

      Medium.EnthalpyFlowRate ports_H_flow[nPorts];
      Medium.MassFlowRate ports_mXi_flow[nPorts,Medium.nXi];
      Medium.MassFlowRate[Medium.nXi] sum_ports_mXi_flow "流经接口的物质质量流量";
      Medium.ExtraPropertyFlowRate ports_mC_flow[nPorts,Medium.nC];
      Medium.ExtraPropertyFlowRate[Medium.nC] sum_ports_mC_flow "微量物质通过接口的质量流量";

      // 边界传热
      parameter Boolean use_HeatTransfer = false "true: 使用传热模型" 
        annotation(Dialog(tab = "假设", group = "传热"));
      replaceable model HeatTransfer = 
        Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.IdealHeatTransfer 
        constrainedby 
        Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.PartialVesselHeatTransfer "壁面传热" 
        annotation(Dialog(tab = "假设", group = "传热", enable = use_HeatTransfer), choicesAllMatching = true);
      HeatTransfer heatTransfer(
      redeclare final package Medium = Medium, 
        final n = 1, 
        final states = {medium.state}, 
        final use_k = use_HeatTransfer) 
        annotation(Placement(transformation(
        extent = {{-10, -10}, {30, 30}}, 
        rotation = 90, 
        origin = {-50, -10})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if use_HeatTransfer 
        annotation(Placement(transformation(extent = {{-110, -10}, {-90, 10}})));

      // 动能守恒
      Medium.Density[nPorts] portInDensities "边界处的流体密度";
      SI.Velocity[nPorts] portVelocities "边界处的流体速度";
      SI.EnergyFlowRate[nPorts] ports_E_flow "边界处的动能和势能";

      // 注意：应激活 fluidLevel_start - portsData.height
      Real[nPorts] s(each start = fluidLevel_max) "接口流量/接口压力曲线; 详细信息参考：Modelica Tutorial: Ideal switching devices";
      Real[nPorts] ports_penetration "流体接口的泄露，取决于液位与接口直径";

      // 接口压力损失的处理
      SI.Area[nPorts] portAreas = {Modelica.Constants.pi / 4 * portsData_diameter[i] ^ 2 for i in 1:nPorts};
      Medium.AbsolutePressure[nPorts] vessel_ps_static "相应接口高度处容器内的静压，流速为0";

      // 湍流区域的判定
      constant SI.ReynoldsNumber Re_turbulent = 100 "cf. 突然膨胀";
      SI.MassFlowRate[nPorts] m_flow_turbulent;

    protected
      input SI.Height fluidLevel = 0 "容器中用于处理接口高度的液体液位";
      parameter SI.Height fluidLevel_max = 1 "容器中最高液体液位";
      parameter SI.Area vesselArea = Modelica.Constants.inf "用于表示接口过流面积的容器面积";

      // use_portsData=false 则忽略接口数据，并且在本案例不需要说明
      // use_portsData=false 则有条件的移除接口数据，通过始终提供与 use_portsData 设置无关的 portsData_diameter 和 portsData_height来简化它们在模型方程中的应用
      // 注意：这可以在工具不支持0维接口数据时提供一种解决方案
      //此外，如果工具不支持零大小的 portsData 记录表，这也是一种变通方法。
      Modelica.Blocks.Interfaces.RealInput[nPorts] 
        portsData_diameter_internal = portsData.diameter if use_portsData and nPorts > 0;
      Modelica.Blocks.Interfaces.RealInput[nPorts] portsData_height_internal = portsData.height if use_portsData and nPorts > 0;
      Modelica.Blocks.Interfaces.RealInput[nPorts] portsData_zeta_in_internal = portsData.zeta_in if use_portsData and nPorts > 0;
      Modelica.Blocks.Interfaces.RealInput[nPorts] portsData_zeta_out_internal = portsData.zeta_out if use_portsData and nPorts > 0;
      Modelica.Blocks.Interfaces.RealInput[nPorts] portsData_diameter;
      Modelica.Blocks.Interfaces.RealInput[nPorts] portsData_height;
      Modelica.Blocks.Interfaces.RealInput[nPorts] portsData_zeta_in;
      Modelica.Blocks.Interfaces.RealInput[nPorts] portsData_zeta_out;
      Modelica.Blocks.Interfaces.BooleanInput[nPorts] regularFlow(each start = true);
      Modelica.Blocks.Interfaces.BooleanInput[nPorts] inFlow(each start = false);

    equation
      mb_flow = sum(ports.m_flow);
      mbXi_flow = sum_ports_mXi_flow;
      mbC_flow = sum_ports_mC_flow;
      Hb_flow = sum(ports_H_flow) + sum(ports_E_flow);
      Qb_flow = heatTransfer.Q_flows[1];

      // 一个接口只允许一个连接，以避免不必要的理想混合
      for i in 1:nPorts loop
        assert(cardinality(ports[i]) <= 1, "
每个容积端口[i]最多只能连接一个分量。
如果存在两个或两个以上的连接，这些连接就会发生理想的混合，这通常不是建模者的意图。增加 nPorts 即可增加一个端口。
"    );
      end for;
      // 检查结果是否正确
      assert(fluidLevel <= fluidLevel_max, "容器溢出 (fluidLevel > fluidLevel_max = " + String(fluidLevel) + ")");
      assert(fluidLevel > -1e-6 * fluidLevel_max, "液位 (= " + String(fluidLevel) + ") 小于零，意味着解决方案失败。");

      // 边界条件

      // 有条件的接口数据的处理
      connect(portsData_diameter, portsData_diameter_internal);
      connect(portsData_height, portsData_height_internal);
      connect(portsData_zeta_in, portsData_zeta_in_internal);
      connect(portsData_zeta_out, portsData_zeta_out_internal);
      if not use_portsData then
        portsData_diameter = zeros(nPorts);
        portsData_height = zeros(nPorts);
        portsData_zeta_in = zeros(nPorts);
        portsData_zeta_out = zeros(nPorts);
      end if;

      // 接口变量的实际定义
      for i in 1:nPorts loop
        portInDensities[i] = Medium.density(Medium.setState_phX(vessel_ps_static[i], inStream(ports[i].h_outflow), inStream(ports[i].Xi_outflow)));
        if use_portsData then
          // dp = 0.5*zeta*d*v*|v|
          // 注意：假设 vessel_ps_static为portVelocities 以避免接口压力的代数循环
          portVelocities[i] = smooth(0, ports[i].m_flow / portAreas[i] / Medium.density(Medium.setState_phX(vessel_ps_static[i], actualStream(ports[i].h_outflow), actualStream(ports[i].Xi_outflow))));
          // 注意：渗透不应太接近零，否则会导致管道空载运行
          ports_penetration[i] = Utilities.regStep(fluidLevel - portsData_height[i] - 0.1 * portsData_diameter[i], 1, 1e-3, 0.1 * portsData_diameter[i]);
          m_flow_turbulent[i] = if not use_Re then m_flow_small else 
            max(m_flow_small, (Modelica.Constants.pi / 8) * portsData_diameter[i] 
            * (Medium.dynamicViscosity(Medium.setState_phX(vessel_ps_static[i], inStream(ports[i].h_outflow), inStream(ports[i].Xi_outflow))) 
            + Medium.dynamicViscosity(medium.state)) * Re_turbulent);
        else
          // 假设接口直径无穷大
          portVelocities[i] = 0;
          ports_penetration[i] = 1;
          m_flow_turbulent[i] = Modelica.Constants.inf;
        end if;

        // 流体流经接口
        regularFlow[i] = fluidLevel >= portsData_height[i];
        inFlow[i] = not regularFlow[i] and (s[i] > 0 or portsData_height[i] >= fluidLevel_max);
        if regularFlow[i] then
          // 正常运行： fluidLevel 高于接口[i]
          // 请注意：>= 也包括默认值0
          if use_portsData then
            /*
            未正则化
            ports[i].p = vessel_ps_static[i] + 0.5*ports[i].m_flow^2/portAreas[i]^2
            * noEvent(if ports[i].m_flow>0 then zeta_in[i]/portInDensities[i] else -zeta_out[i]/medium.d);
            */
            ports[i].p = vessel_ps_static[i] + (0.5 / portAreas[i] ^ 2 * Utilities.regSquare2(ports[i].m_flow, m_flow_turbulent[i], 
              (portsData_zeta_in[i] - 1 + portAreas[i] ^ 2 / vesselArea ^ 2) / portInDensities[i] * ports_penetration[i], 
              (portsData_zeta_out[i] + 1 - portAreas[i] ^ 2 / vesselArea ^ 2) / medium.d / ports_penetration[i]));
          /*
          // 替代公式 m_flow=f(dp); 不允许 portsData_zeta_in[i]=1 
          ports[i].m_flow = smooth(2, portAreas[i]*Utilities.regRoot2(ports[i].p - vessel_ps_static[i], dp_small,
          2*portInDensities[i]/portsData_zeta_in[i],
          2*medium.d/portsData_zeta_out[i]));
          */
          else
            ports[i].p = vessel_ps_static[i];
          end if;
          s[i] = fluidLevel - portsData_height[i];

        elseif inFlow[i] then
          // 接口[i]高于流体水位并有流入
          ports[i].p = vessel_ps_static[i];
          s[i] = ports[i].m_flow;

        else
          // 接口[i]高于流体液面，阻止流出
          ports[i].m_flow = 0;
          s[i] = (ports[i].p - vessel_ps_static[i]) / Medium.p_default * (portsData_height[i] - fluidLevel);
        end if;

        ports[i].h_outflow = medium.h;
        ports[i].Xi_outflow = medium.Xi;
        ports[i].C_outflow = C;

        ports_H_flow[i] = ports[i].m_flow * actualStream(ports[i].h_outflow) "焓流";
        ports_E_flow[i] = ports[i].m_flow * (0.5 * portVelocities[i] * portVelocities[i] + system.g * portsData_height[i]) "动能和势能的流动";
        ports_mXi_flow[i,:] = ports[i].m_flow * actualStream(ports[i].Xi_outflow) "组分质量流量";
        ports_mC_flow[i,:] = ports[i].m_flow * actualStream(ports[i].C_outflow) "微量物质质量流量";
      end for;

      for i in 1:Medium.nXi loop
        sum_ports_mXi_flow[i] = sum(ports_mXi_flow[:,i]);
      end for;

      for i in 1:Medium.nC loop
        sum_ports_mC_flow[i] = sum(ports_mC_flow[:,i]);
      end for;

      connect(heatPort, heatTransfer.heatPorts[1]) annotation(Line(
        points = {{-100, 0}, {-87, 0}, {-87, 0}, {-74, 0}}, color = {191, 0, 0}));
      annotation(
        Documentation(info = "<html><p>
该基类对<strong> </strong>PartialLumpedVolume<strong> </strong>进行了扩展，增加了一个流体接口向量和一个可替换的壁面传热模型。
</p>
<p>
模型假设如下
</p>
<ul><li>
均质介质，即不考虑相分离问题；</li>
<li>
流体中没有动能，即动能耗散为内能；</li>
<li>
假定流体不可压缩时定义容器接口的压力损失；</li>
<li>
假设止回阀起作用，则每个接口都能防止环境介质外流。 如果 <code>fluidlevel &lt; portsData_height[i]</code>，且 <code>ports[i].p &lt; vessel_ps_static[i]</code>，则接口的质量流量设为 0。</li>
</ul><p>
每个接口都有（水力）直径和高出容器底部的高度，可通过<code><strong>portsData</strong></code>记录进行配置。 
另外，也可以使用 <code>use_portsData=false</code>来忽略接口几何形状的影响。 这可能对早期设计研究有用。 
请注意，这意味着假设容器底部的接口直径为无限大。 因此，压力降、接口高度以及流体进出容器的动能和势能都被忽略。
</p>
<p>
扩展模型需要定义以下变量：
</p>
<ul><li>
<code>input fluidVolume</code>，容器中流体的体积；</li>
<li>
<code>vessel_ps_static[nPorts]</code>,在流速为零时，相应接口高度处容器内的静压；</li>
<li>
<code>Wb_flow</code>，能量平衡的功项（work term of the energy balance,），
例如，如果体积或搅拌功率（ stirrer power）不是恒定的，则输入 p*der(V)。（<code>Wb_flow</code>, work term of the energy balance, e.g., p*der(V) if the volume is not constant or stirrer power.）</li>
</ul><p>
扩展模型应定义：
</p>
<ul><li>
<code>parameter vesselArea</code>（默认： Modelica.Constants.inf.m2），即容器面积，与各接口的过流面积相关，以考虑动压效应。</li>
</ul><p>
容器中的液面会可选择的发生变化，这将影响通过可配置的<code>portsData_height[nPorts]</code>接口的流量。 这就是为什么需要定义一个具有液位变化的扩展模型：
</p>
<ul><li>
<code>input fluidLevel (default: 0m)</code>，容器中流体的液位</li>
<li>
<code>parameter fluidLevel_max (default: 1m)</code>，即不得超过的最大高度。 处于或高于 fluidLevel_max 的接口只有流入动作。</li>
</ul><p>
扩展模型不应访问配置对话框中定义的<code>portsData</code> 记录，因为在 <code>use_portsData=false</code> 或 <code>nPorts=0</code> 时，访问 <code>portsData</code> 可能会失败。
</p>
<p>
所以应该预定义变量：
</p>
<ul><li>
<code>portsData_diameter[nPorts]</code>,</li>
<li>
<code>portsData_height[nPorts]</code>,</li>
<li>
<code>portsData_zeta_in[nPorts]</code>,</li>
<li>
<code>portsData_zeta_out[nPorts]</code></li>
</ul><p>
如果需要这些变量，应该进行定义并使用。
</p>
</html>"    , revisions = "<html>
<ul>
<li><em>Jan. 2009</em> by R&uuml;diger Franke: 扩展了接口数据记录和威胁配置端口高度，在能量平衡中考虑流体进出的动能和势能
</li>
<li><em>Dec. 2008</em> by R&uuml;diger Franke: 衍生自 OpenTank，以便使用可配置的接口直径</li>
</ul>
</html>"    ), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
        {100, 100}}), graphics = {Text(
        extent = {{-150, 110}, {150, 150}}, 
        textString = "%name", 
        textColor = {0, 0, 255})}));
    end PartialLumpedVessel;

    package HeatTransfer "容器的传热模型"
      extends Modelica.Icons.Package;

      partial model PartialVesselHeatTransfer "容器传热模型基类"
        extends Modelica.Fluid.Interfaces.PartialHeatTransfer;
        annotation(Documentation(info = "<html><p>
<br>容器传热模型的基类。<br>
</p>
</html>"      ), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
          {100, 100}}), graphics = {Ellipse(
          extent = {{-60, 64}, {60, -56}}, 
          fillPattern = FillPattern.Sphere, 
          fillColor = {232, 0, 0}), Text(
          extent = {{-38, 26}, {40, -14}}, 
          textString = "%name")}));
      end PartialVesselHeatTransfer;

      model IdealHeatTransfer "理想传热，无热阻"
        extends PartialVesselHeatTransfer;

      equation
        Ts = heatPorts.T;

        annotation(Documentation(info = "<html><p>
<br>理想的传热，无热阻。<br>
</p>
</html>"));
      end IdealHeatTransfer;

      model ConstantHeatTransfer "定传热系数传热"
        extends PartialVesselHeatTransfer;
        parameter SI.CoefficientOfHeatTransfer alpha0 "传热系数（恒定）";

      equation
        Q_flows = {(alpha0 + k) * surfaceAreas[i] * (heatPorts[i].T - Ts[i]) for i in 1:n};

        annotation(Documentation(info = "<html><p>
<br>简单的传热关联式，其中传热系数为常数。<br>
</p>
</html>"      ));
      end ConstantHeatTransfer;
      annotation(Documentation(info = "<html>
管道模型的传热相关性
</html>"));

    end HeatTransfer;

    record VesselPortsData 
      "描述容器进口/出口的数据：diameter-入口/出口的内（水力）直径,height-端口距底部的高度,
zeta_out-容器外的流阻，默认为 0.5,适用于小直径且与墙壁齐平的安装情况,zeta_in-容器内的流阻，默认为 1.04，适用于小直径且与墙壁齐平的安装情况"
      extends Modelica.Icons.Record;
      parameter SI.Diameter diameter 
        "入口/出口的内直径（水力直径）";
      parameter SI.Height height = 0 "端口距容器底部的高度";
      parameter Real zeta_out(min = 0) = 0.5 
        "容器外的流阻，默认为 0.5，适用于小直径且与墙壁齐平的安装情况";
      parameter Real zeta_in(min = 0) = 1.04 
        "容器内的流阻，默认为 1.04，适用于小直径且与墙壁齐平的安装情况";
      annotation(preferredView = "info", Documentation(info = "<html>
<h4>容器接口数据</h4>
<p>
这个记录表描述了<strong>容器</strong>的<strong>接口</strong>。其中的变量大多不言自明（见下表）；只有&zeta;损失系数需要进一步讨论。
所有数据均引自Idelchik（1994）。
</p>

<h4>出口系数</h4>

<p>
如果<strong>具有恒定横截面的直管与墙面齐平安装</strong>，其出口压力损失系数为<code>&zeta; = 0.5</code>（Idelchik，第160页，图3-1，第2段）。
</p>
<p>
如果<strong>具有恒定横截面的直管安装在容器内，使其入口距墙的距离</strong> <code>b</code> 处于容器内（Idelchik，第160页，图3-1，第1段），则可以使用下表。
这里，&delta;是管壁厚度。
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<caption align=\"bottom\">出口压力损失系数，入口距墙的距离</caption>
<tr>
<td></td> <td>   </td><th colspan=\"5\" align=\"center\"> b / D_hyd  </th>
</tr>
<tr>
<td></td> <td>   </td><th> 0.000 </th><th> 0.005 </th><th> 0.020 </th><th> 0.100 </th><th> 0.500-&#8734; </th>
</tr>
<tr>
<th rowspan=\"5\" valign=\"middle\">&delta; / D_hyd</th> <th> 0.000 </th><td> 0.50 </td><td> 0.63  </td><td> 0.73  </td><td> 0.86  </td><td>      1.00     </td>
</tr>
<tr>
<th> 0.008 </th><td> 0.50 </td><td> 0.55  </td><td> 0.62  </td><td> 0.74  </td><td>      0.88     </td>
</tr>
<tr>
<th> 0.016 </th><td> 0.50 </td><td> 0.51  </td><td> 0.55  </td><td> 0.64  </td><td>      0.77     </td>
</tr>
<tr>
<th> 0.024 </th><td> 0.50 </td><td> 0.50  </td><td> 0.52  </td><td> 0.58  </td><td>      0.68     </td>
</tr>
<tr>
<th> 0.040 </th><td> 0.50 </td><td> 0.50  </td><td> 0.51  </td><td> 0.51  </td><td>      0.54     </td>
</tr>
</table>

<p>
如果<strong>具有圆形喇叭口入口（集管）且无挡板的直管与墙面齐平安装</strong>，则其压力损失系数可以从下表确定。这里，r是喇叭口入口表面的半径（Idelchik，第164页，图3-4，第b段）。
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<caption align=\"bottom\">出口压力损失系数，喇叭口与墙面齐平</caption>
<tr>
<td></td> <th colspan=\"6\" align=\"center\"> r / D_hyd  </th>
</tr>
<tr>
<td></td> <th> 0.01 </th><th> 0.03 </th><th> 0.05 </th><th> 0.08 </th><th> 0.16 </th><th>&ge;0.20</th>
</tr>
<tr>
<th>&zeta;</th> <td> 0.44 </td><td> 0.31 </td><td> 0.22  </td><td> 0.15  </td><td> 0.06  </td><td>      0.03     </td>
</tr>
</table>

<p>
如果<strong>具有圆形喇叭口入口（集管）且无挡板的直管安装在距墙一段距离处</strong>，则其压力损失系数可以从下表确定。这里，r是喇叭口入口表面的半径（Idelchik，第164页，图3-4，第a段）。
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<caption align=\"bottom\">出口压力损失系数，喇叭口距墙一段距离</caption>
<tr>
<td></td> <th colspan=\"6\" align=\"center\"> r / D_hyd  </th>
</tr>
<tr>
<td></td> <th> 0.01 </th><th> 0.03 </th><th> 0.05 </th><th> 0.08 </th><th> 0.16 </th><th>&ge;0.20</th>
</tr>
<tr>
<th>&zeta;</th> <td> 0.87 </td><td> 0.61 </td><td> 0.40  </td><td> 0.20  </td><td> 0.06  </td><td>      0.03     </td>
</tr>
</table>

<h4>入口系数</h4>

<p>
如果<strong>具有恒定圆形横截面的直管与墙面齐平安装</strong>，其容器入口压力损失系数如下表所示（Idelchik，第209页，图4-2，<code>A_port/A_vessel = 0</code>，以及Idelchik，第640页，图11-1，图表a）。根据文本，<code>m = 9</code> 适用于充分发展的湍流。
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<caption align=\"bottom\">入口压力损失系数，圆管与墙面齐平</caption>
<tr>
<td></td> <th colspan=\"6\" align=\"center\"> m  </th>
</tr>
<tr>
<td></td> <th> 1.0 </th><th> 2.0 </th><th> 3.0 </th><th> 4.0 </th><th> 7.0 </th><th>9.0</th>
</tr>
<tr>
<th>&zeta;</th> <td> 2.70 </td><td> 1.50 </td><td> 1.25  </td><td> 1.15  </td><td> 1.06  </td><td>      1.04     </td>
</tr>
</table>

<p>
对于相对于容器面积较大的接口直径，入口压力损失系数如下表所示（Idelchik，第209页，图4-2，<code>m = 7</code>）。
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<caption align=\"bottom\">入口压力损失系数，圆管与墙面齐平</caption>
<tr>
<td></td> <th colspan=\"6\" align=\"center\"> A_port / A_vessel  </th>
</tr>
<tr>
<td></td> <th> 0.0 </th><th> 0.1 </th><th> 0.2 </th><th> 0.4 </th><th> 0.6 </th><th>0.8</th>
</tr>
<tr>
<th>&zeta;</th> <td> 1.04 </td><td> 0.84 </td><td> 0.67  </td><td> 0.39  </td><td> 0.18  </td><td>      0.06     </td>
</tr>
</table>

<h4>参考文献</h4>

<dl><dt>Idelchik I.E. (1994):</dt>
<dd><a href=\"http://www.bookfinder.com/dir/i/Handbook_of_Hydraulic_Resistance/0849399084/\"><strong>Handbook
of Hydraulic Resistance</strong></a>. 3rd edition, Begell House, ISBN
0-8493-9908-4</dd>
</dl>
</html>"    ));
    end VesselPortsData;

    connector VesselFluidPorts_a 
      "流体连接器,用于水平排列的流体接口矢量（拖动后需添加向量维度）"
      extends Interfaces.FluidPort;
      annotation(defaultComponentName = "ports_b", 
        Diagram(coordinateSystem(
        preserveAspectRatio = false, 
        extent = {{-50, -200}, {50, 200}}, 
        initialScale = 0.2), graphics = {
        Text(extent = {{-75, 130}, {75, 100}}, textString = "%name"), 
        Rectangle(
        extent = {{-25, 100}, {25, -100}}), 
        Ellipse(
        extent = {{-22, 100}, {-10, -100}}, 
        fillColor = {0, 127, 255}, 
        fillPattern = FillPattern.Solid), 
        Ellipse(
        extent = {{-6, 100}, {6, -100}}, 
        fillColor = {0, 127, 255}, 
        fillPattern = FillPattern.Solid), 
        Ellipse(
        extent = {{10, 100}, {22, -100}}, 
        fillColor = {0, 127, 255}, 
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
        extent = {{-44, 200}, {-20, -200}}, 
        fillColor = {0, 127, 255}, 
        fillPattern = FillPattern.Solid), 
        Ellipse(
        extent = {{-12, 200}, {12, -200}}, 
        fillColor = {0, 127, 255}, 
        fillPattern = FillPattern.Solid), 
        Ellipse(
        extent = {{20, 200}, {44, -200}}, 
        fillColor = {0, 127, 255}, 
        fillPattern = FillPattern.Solid)}));
    end VesselFluidPorts_a;

    connector VesselFluidPorts_b 
      "流体连接器,用于水平排列的流体接口矢量（拖动后需添加向量维度）"
      extends Interfaces.FluidPort;
      annotation(defaultComponentName = "ports_b", 
        Diagram(coordinateSystem(
        preserveAspectRatio = false, 
        extent = {{-50, -200}, {50, 200}}, 
        initialScale = 0.2), graphics = {
        Text(extent = {{-75, 130}, {75, 100}}, textString = "%name"), 
        Rectangle(
        extent = {{-25, 100}, {25, -100}}), 
        Ellipse(
        extent = {{-22, 100}, {-10, -100}}, 
        fillColor = {0, 127, 255}, 
        fillPattern = FillPattern.Solid), 
        Ellipse(
        extent = {{-20, -69}, {-12, 69}}, 
        lineColor = {0, 127, 255}, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), 
        Ellipse(
        extent = {{-6, 100}, {6, -100}}, 
        fillColor = {0, 127, 255}, 
        fillPattern = FillPattern.Solid), 
        Ellipse(
        extent = {{10, 100}, {22, -100}}, 
        fillColor = {0, 127, 255}, 
        fillPattern = FillPattern.Solid), 
        Ellipse(
        extent = {{-4, -69}, {4, 69}}, 
        lineColor = {0, 127, 255}, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), 
        Ellipse(
        extent = {{12, -69}, {20, 69}}, 
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
        extent = {{-44, 200}, {-20, -200}}, 
        fillColor = {0, 127, 255}, 
        fillPattern = FillPattern.Solid), 
        Ellipse(
        extent = {{-12, 200}, {12, -200}}, 
        fillColor = {0, 127, 255}, 
        fillPattern = FillPattern.Solid), 
        Ellipse(
        extent = {{20, 200}, {44, -200}}, 
        fillColor = {0, 127, 255}, 
        fillPattern = FillPattern.Solid), 
        Ellipse(
        extent = {{-39, -118.5}, {-25, 113}}, 
        lineColor = {0, 127, 255}, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), 
        Ellipse(
        extent = {{-7, -118.5}, {7, 113}}, 
        lineColor = {0, 127, 255}, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), 
        Ellipse(
        extent = {{25, -117.5}, {39, 114}}, 
        lineColor = {0, 127, 255}, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid)}));
    end VesselFluidPorts_b;
    annotation();
  end BaseClasses;
  annotation(Documentation(info = "<html>

</html>"));
end Vessels;