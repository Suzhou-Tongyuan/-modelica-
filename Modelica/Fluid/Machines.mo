within Modelica.Fluid;
package Machines 
  "流体能量和机械能转换装置"
  extends Modelica.Icons.VariantsPackage;
  model SweptVolume "根据活塞位置变化的缸"
    import Modelica.Constants.pi;

    parameter SI.Area pistonCrossArea "活塞横截面积";
    parameter SI.Volume clearance "活塞行程为零时的剩余容积";

    SI.Volume V "流体体积";

    // 质量和能量平衡，定义接口
    extends Modelica.Fluid.Vessels.BaseClasses.PartialLumpedVessel(
      final fluidVolume = V, 
      heatTransfer(surfaceAreas={pistonCrossArea+2*sqrt(pistonCrossArea*pi)*(flange.s+clearance/pistonCrossArea)}));

    Modelica.Mechanics.Translational.Interfaces.Flange_b flange "活塞平移法兰 " 
      annotation (Placement(transformation(
            extent={{-10,90},{10,110}})));

  equation
    assert(flange.s >= 0, "活塞行程（由flange.s确定）不得小于零！");

    // 容积
    V = clearance + flange.s * pistonCrossArea;

    0 = flange.f + (medium.p - system.p_ambient) * pistonCrossArea;

    // 能量平衡
    Wb_flow = medium.p * pistonCrossArea * (-der(flange.s));

    // 接口压力的定义
    for i in 1:nPorts loop
      vessel_ps_static[i] = medium.p;
    end for;

    annotation (Icon(coordinateSystem(preserveAspectRatio=true, 
            extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            extent={{-50,36},{50,-90}}, 
            lineColor={0,0,255}, 
            pattern=LinePattern.None, 
            lineThickness=1, 
            fillColor={170,213,255}, 
            fillPattern=FillPattern.Solid), 
          Polygon(
            points={{-52,62},{-48,62},{-48,-30},{-52,-30},{-52,62}}, 
            lineColor={95,95,95}, 
            fillColor={135,135,135}, 
            fillPattern=FillPattern.Backward), 
          Polygon(
            points={{48,60},{52,60},{52,-34},{48,-34},{48,60}}, 
            lineColor={95,95,95}, 
            fillColor={135,135,135}, 
            fillPattern=FillPattern.Backward), 
          Rectangle(
            extent={{-48,40},{48,30}}, 
            lineColor={95,95,95}, 
            fillColor={135,135,135}, 
            fillPattern=FillPattern.Forward), 
          Rectangle(
            extent={{-6,92},{6,40}}, 
            lineColor={95,95,95}, 
            fillColor={135,135,135}, 
            fillPattern=FillPattern.Forward), 
          Polygon(
            points={{-48,-90},{48,-90},{48,70},{52,70},{52,-94},{-52,-94},{-52, 
                70},{-48,70},{-48,-90}}, 
            lineColor={95,95,95}, 
            fillColor={135,135,135}, 
            fillPattern=FillPattern.Backward), 
          Line(
            visible=use_HeatTransfer, 
            points={{-100,0},{-52,0}}, 
            color={198,0,0}), 
          Line(points={{-40,0},{40,0}},     color={95,127,95}, 
            origin={-70,32}, 
            rotation=90), 
          Polygon(
            points={{15,0},{-15,10},{-15,-10},{15,0}}, 
            lineColor={95,127,95}, 
            fillColor={95,127,95}, 
            fillPattern=FillPattern.Solid, 
            origin={-70,84}, 
            rotation=90)}), 
      Documentation(info="<html><p>
缸内不同的混合体积取决于如下因素：
</p>
<ul><li>
活塞横截面积</li>
<li>
法兰位置提供的活塞行程</li>
<li>
间隙（法兰位置= 0 处的容积 ）</li>
</ul><p>
损失忽略不计。轴功率完全转化为流体的机械功。
</p>
<p>
法兰位置必须等于或大于零。否则模拟将终止。法兰的作用力来自介质和环境压力之间的压力差以及活塞的横截面积。使用该组件时，需要一个具有内部属性的环境模型顶层实例。
</p>
<p>
两个流体接口的压力等于容积内的介质压力。模型中不包含吸入或排出阀。
</p>
<p>
热接口直接与介质相连。热接口的温度等于介质温度。模型中不包括气缸和活塞的热容量。
</p>
</html>",revisions="<html>
<ul>
<li><em>29 Oct 2007</em>
by Carsten Heinrich:<br>
模型添加到流体库中</li>
</ul>
</html>"));
  end SweptVolume;

  model Pump "轴上有机械连接器的离心泵"
    extends Modelica.Fluid.Machines.BaseClasses.PartialPump;
    SI.Angle phi "轴角度";
    SI.AngularVelocity omega "轴角速度";
    Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft 
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  equation
    phi = shaft.phi;
    omega = der(phi);
    N = Modelica.Units.Conversions.to_rpm(omega);
    W_single = omega*shaft.tau;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
              100}}), graphics={Rectangle(
            extent={{-10,100},{10,78}}, 
            fillPattern=FillPattern.VerticalCylinder, 
            fillColor={95,95,95})}), 
    Documentation(info="<html><p>
该模型描述了一个离心泵（或 n 个并联泵组<code>nParallel</code>），其轴上有一个机械旋转连接器，当需要对泵驱动明确建模时使用。在 n 个并联泵<code>nParallel</code>的情况下，机械连接器是相对于单个泵而言的。
</p>
<p>
该模型引用<code>PartialPump</code>
</p>
</html>",revisions="<html>
<ul>
<li><em>31 Oct 2005</em>
by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
模型添加到流体库中</li>
</ul>
</html>"));
  end Pump;

  model ControlledPump "理想控制质量流量的离心泵"
    import Modelica.Units.NonSI.AngularVelocity_rpm;
    extends Modelica.Fluid.Machines.BaseClasses.PartialPump(
      N_nominal=1500, 
      N(start=N_nominal), 
      redeclare replaceable function flowCharacteristic = 
          Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow
          ( V_flow_nominal={0, V_flow_op, 1.5*V_flow_op}, 
            head_nominal={2*head_op, head_op, 0}));

    // 额定值
    parameter Medium.AbsolutePressure p_a_nominal 
      "预设泵特性的额定入口压力";
    parameter Medium.AbsolutePressure p_b_nominal 
      "额定出口压力，如果不使用 control_m_flow 和 use_p_set，则为固定值";
    parameter Medium.MassFlowRate m_flow_nominal 
      "额定质量流量，如果使用 control_m_flow 和 use_p_set，则为固定值";

    // 控制内容
    parameter Boolean control_m_flow = true "false: 控制出口压力 port_b.p 而不是 m_flow" 
      annotation(Evaluate = true);
    parameter Boolean use_m_flow_set = false "true: 使用输入信号 m_flow_set 代替 m_flow_nominal" 
      annotation (Dialog(enable = control_m_flow));
    parameter Boolean use_p_set = false "true: 使用输入信号 p_set 代替 p_b_nominal" 
      annotation (Dialog(enable = not control_m_flow));

    // 典型特性
    final parameter SI.VolumeFlowRate V_flow_op = m_flow_nominal/rho_nominal "根据额定值计算的运行体积流量";
    final parameter SI.Position head_op = (p_b_nominal-p_a_nominal)/(rho_nominal*g) "根据额定值计算的运行泵扬程";

    Modelica.Blocks.Interfaces.RealInput m_flow_set(unit="kg/s") if use_m_flow_set "规定质量流量" 
      annotation (Placement(transformation(
          extent={{-20,-20},{20,20}}, 
          rotation=-90, 
          origin={-50,82})));
    Modelica.Blocks.Interfaces.RealInput p_set(unit="Pa") if use_p_set "规定出口压力" 
      annotation (Placement(transformation(
          extent={{-20,-20},{20,20}}, 
          rotation=-90, 
          origin={50,82})));

  protected
    Modelica.Blocks.Interfaces.RealInput m_flow_set_internal(unit="kg/s") "输入流量信号";
    Modelica.Blocks.Interfaces.RealInput p_set_internal(unit="Pa") "输入压力信号";
  equation
    // 理想控制
    if control_m_flow then
      m_flow = m_flow_set_internal;
    else
      dp_pump = p_set_internal - port_a.p;
    end if;

    // 当 use_m_flow_set = false 时的内部连接器值
    if not use_m_flow_set then
      m_flow_set_internal = m_flow_nominal;
    end if;
    if not use_p_set then
      p_set_internal = p_b_nominal;
    end if;
    connect(m_flow_set, m_flow_set_internal);
    connect(p_set, p_set_internal);

    annotation (defaultComponentName="pump", 
      Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100, 
              100}}), graphics={Text(
            visible=use_p_set, 
            extent={{82,108},{176,92}}, 
            textString="p_set"), Text(
            visible=use_m_flow_set, 
            extent={{-20,108},{170,92}}, 
            textString="m_flow_set")}), 
      Documentation(info="<html><p>
该模型描述了可以理想控制质量流量或压力的离心泵（或一组泵<code>nParallel</code>）。
</p>
<p>
额定值用于预定义一个示例泵的特性并定义泵的运行。可选择启用输入连接器 <code>m_flow_set</code>或 <code>p_set</code>，以提供随时间变化的设定点。
</p>
<p>
如果对泵的特性不是首要研究对象，可使用此模型。实际特性可以稍后配置为适当的转速N，随后可将该模型替换为带旋转轴的泵或额定泵。
</p>
</html>",revisions="<html>
<ul>
<li><em>15 Dec 2008</em>
by R&uuml;diger Franke:<br />
Model added to the Fluid library</li>
</ul>
</html>"));
  end ControlledPump;

  model PrescribedPump "理想控制转速的离心泵"
    extends Modelica.Fluid.Machines.BaseClasses.PartialPump;
    parameter Boolean use_N_in = false "从输入接口获取转速";
    parameter Modelica.Units.NonSI.AngularVelocity_rpm 
      N_const = N_nominal "恒定转速" 
      annotation(Dialog(enable = not use_N_in));
    Modelica.Blocks.Interfaces.RealInput N_in(unit="rev/min") if use_N_in "规定转速" 
      annotation (Placement(transformation(
          extent={{-20,-20},{20,20}}, 
          rotation=-90, 
          origin={0,100}), iconTransformation(
          extent={{-20,-20},{20,20}}, 
          rotation=-90, 
          origin={0,100})));

  protected
    Modelica.Blocks.Interfaces.RealInput N_in_internal(unit="rev/min") 
      "输入转速信号";
  equation
    // 仅当 use_p_in = true 时才激活连接
    connect(N_in, N_in_internal);
    // use_p_in = false 时的内部连接器值
    if not use_N_in then
      N_in_internal = N_const;
    end if;
    // 设置 N 的下限，以避免零速度时出现奇点
    N = max(N_in_internal,1e-3) "转速";

    annotation (defaultComponentName="pump", 
      Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100, 
              100}}), graphics={Text(
            visible=use_N_in, 
            extent={{14,98},{178,82}}, 
            textString="N_in [rpm]")}), 
      Documentation(info="<html><p>
该模型描述了一个具有规定转速的离心泵（或一组泵<code>nParallel</code>），转速可以是固定的，也可以由外部信号提供。
</p>
<p>
该模型引用基类 <code>PartialPum</code>
</p>
<p>
如果 <code>N_in</code> 输入连接器已连接，它将提供泵的转速（rpm）；否则，将假定恒定转速<code>n_const</code>（可以与 <code>N_nominal</code>（额定转速）不同）。
</p>
</html>",revisions="<html>
<ul>
<li><em>31 Oct 2005</em>
by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
模型添加到流体库中</li>
</ul>
</html>"));
  end PrescribedPump;

  package BaseClasses 
    "机械库中使用的基类（仅用于构建新组件模型）"
    extends Modelica.Icons.BasesPackage;

    partial model PartialPump "离心泵基本模型"
      import Modelica.Units.NonSI;
      import Modelica.Constants;

      extends Modelica.Fluid.Interfaces.PartialTwoPort(
        port_b_exposesState = energyDynamics <> Types.Dynamics.SteadyState or massDynamics <> Types.Dynamics.SteadyState, 
        port_a(
        p(start = p_a_start), 
        m_flow(start = m_flow_start, 
        min = if allowFlowReversal and not checkValve then -Constants.inf else 0)), 
        port_b(
        p(start = p_b_start), 
        m_flow(start = -m_flow_start, 
        max = if allowFlowReversal and not checkValve then +Constants.inf else 0)));

      // 初始化
      parameter Medium.AbsolutePressure p_a_start = system.p_start 
        "入口压力猜测值" 
        annotation(Dialog(tab = "初始化"));
      parameter Medium.AbsolutePressure p_b_start = p_a_start 
        "出口压力猜测值" 
        annotation(Dialog(tab = "初始化"));
      parameter Medium.MassFlowRate m_flow_start = system.m_flow_start 
        "猜测 m_flow = port_a.m_flow" 
        annotation(Dialog(tab = "初始化"));
      parameter Types.CheckValveHomotopyType checkValveHomotopy = Types.CheckValveHomotopyType.NoHomotopy "= 初始化时阀门是关闭、打开还是未知" 
        annotation(Dialog(tab = "初始化"));
      final parameter SI.VolumeFlowRate V_flow_single_init = m_flow_start / rho_nominal / nParallel 
        "用于简化初始化模型";
      final parameter SI.Position delta_head_init = flowCharacteristic(V_flow_single_init * 1.1) - flowCharacteristic(V_flow_single_init) 
        "初始化点流量增加 10% 的 Delta head";

      // 特征曲线
      parameter Integer nParallel(min = 1) = 1 "并联泵数量" 
        annotation(Dialog(group = "特征"));
      replaceable function flowCharacteristic = 
        PumpCharacteristics.baseFlow 
        "额定转速和密度下 扬程-体积流量关系" 
        annotation(Dialog(group = "特征"), choicesAllMatching = true);


      parameter NonSI.AngularVelocity_rpm N_nominal 
        "流量特性的额定转速" 
        annotation(Dialog(group = "特征"));
      parameter Medium.Density rho_nominal = Medium.density_pTX(Medium.p_default, Medium.T_default, Medium.X_default) 
        "额定流体密度" 
        annotation(Dialog(group = "特征"));
      parameter Boolean use_powerCharacteristic = false 
        "使用功率特性（相对于效率特性）" 
        annotation(Evaluate = true, Dialog(group = "特征"));
      replaceable function powerCharacteristic = 
        PumpCharacteristics.quadraticPower(
        V_flow_nominal = {0, 0, 0}, W_nominal = {0, 0, 0}) 
        "额定转速和密度下的功耗-体积流量的关系" 
        annotation(Dialog(group = "特征", enable = use_powerCharacteristic), 
        choicesAllMatching = true);



      replaceable function efficiencyCharacteristic = 
        PumpCharacteristics.constantEfficiency(eta_nominal = 0.8) constrainedby 
        PumpCharacteristics.baseEfficiency 
        "额定转速和密度下的效率-体积流量的关系" 
        annotation(Dialog(group = "特征", enable = not use_powerCharacteristic), 
        choicesAllMatching = true);




      // 假设
      parameter Boolean checkValve = false "true: 禁止反向流" 
        annotation(Dialog(tab = "假设"), Evaluate = true);

      parameter SI.Volume V = 0 "泵容积" 
        annotation(Dialog(tab = "假设"), Evaluate = true);

      // 能量和质量平衡
      extends Modelica.Fluid.Interfaces.PartialLumpedVolume(
        final fluidVolume = V, 
        energyDynamics = Types.Dynamics.SteadyState, 
        massDynamics = Types.Dynamics.SteadyState, 
        final p_start = p_b_start);

      // 通过边界的传热，例如增加外壳
      parameter Boolean use_HeatTransfer = false 
        "true: 使用传热模型，例如对一个外壳" 
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
        surfaceAreas = {4 * Modelica.Constants.pi * (3 / 4 * V / Modelica.Constants.pi) ^ (2 / 3)}, 
        final states = {medium.state}, 
        final use_k = use_HeatTransfer) 
        annotation(Placement(transformation(
        extent = {{-10, -10}, {30, 30}}, 
        rotation = 180, 
        origin = {50, -10})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if use_HeatTransfer 
        annotation(Placement(transformation(extent = {{30, -70}, {50, -50}})));

      // 变量
      final parameter SI.Acceleration g = system.g "重力加速度";
      Medium.Density rho = medium.d;
      SI.Pressure dp_pump = port_b.p - port_a.p "压力变化";
      SI.Position head = dp_pump / (rho * g) "泵压头";
      SI.MassFlowRate m_flow = port_a.m_flow "总质量流量";
      SI.MassFlowRate m_flow_single = m_flow / nParallel 
        "质量流量（单泵）";
      SI.VolumeFlowRate V_flow "总体积流量";
      SI.VolumeFlowRate V_flow_single(start = m_flow_start / rho_nominal / nParallel) 
        "体积流量（单泵）";
      NonSI.AngularVelocity_rpm N(start = N_nominal) "轴转速";
      SI.Power W_single "功耗（单泵）";
      SI.Power W_total = W_single * nParallel "总功耗";
      Real eta "总效率";
      final constant Medium.MassFlowRate unit_m_flow = 1 annotation(HideResult = true);
      Real s(start = m_flow_start / unit_m_flow) 
        "参数形式的流量曲线（质量流量或水头）的曲线横坐标";

      // 诊断
      replaceable model Monitoring = 
        Modelica.Fluid.Machines.BaseClasses.PumpMonitoring.PumpMonitoringBase 
        constrainedby 
        Modelica.Fluid.Machines.BaseClasses.PumpMonitoring.PumpMonitoringBase 
        "可选的泵监视器" 
        annotation(Dialog(tab = "高级", group = "诊断"), choicesAllMatching = true);
      Monitoring monitoring(
      redeclare final package Medium = Medium, 
        final state_in = Medium.setState_phX(port_a.p, inStream(port_a.h_outflow), inStream(port_a.Xi_outflow)), 
        final state = medium.state) "监测模型" 
        annotation(Placement(transformation(extent = {{-64, -42}, {-20, 0}})));
    protected
      constant SI.Position unitHead = 1;
      constant SI.MassFlowRate unitMassFlowRate = 1;

    equation
      // 流量方程
      V_flow = homotopy(m_flow / rho, 
        m_flow / rho_nominal);
      V_flow_single = V_flow / nParallel;
      if not checkValve then
        // 不带止回阀的常规流量特性
        // 简化模型在初始化点使用了水头曲线切线的近似值
        head = homotopy((N / N_nominal) ^ 2 * flowCharacteristic(V_flow_single * N_nominal / N), 
          N / N_nominal * (flowCharacteristic(V_flow_single_init) + (V_flow_single - V_flow_single_init) * noEvent(if abs(V_flow_single_init) > 0 then delta_head_init / (0.1 * V_flow_single_init) else 0)));
        s = 0;
      else
        // 止回阀打开时的流量特性
        // 简化模型在初始化点使用了水头曲线切线的近似值
        // 或在止回阀关闭的情况下初始化系统时零流量的垂线
        if checkValveHomotopy == Types.CheckValveHomotopyType.NoHomotopy then
          head = if s > 0 then (N / N_nominal) ^ 2 * flowCharacteristic(V_flow_single * N_nominal / N) 
            else (N / N_nominal) ^ 2 * flowCharacteristic(0) - s * unitHead;
          V_flow_single = if s > 0 then s * unitMassFlowRate / rho else 0;
        else
          head = homotopy(if s > 0 then (N / N_nominal) ^ 2 * flowCharacteristic(V_flow_single * N_nominal / N) 
            else (N / N_nominal) ^ 2 * flowCharacteristic(0) - s * unitHead, 
            if checkValveHomotopy == Types.CheckValveHomotopyType.Open then 
            N / N_nominal * (flowCharacteristic(V_flow_single_init) + (V_flow_single - V_flow_single_init) * noEvent(if abs(V_flow_single_init) > 0 then delta_head_init / (0.1 * V_flow_single_init) else 0)) 
            else 
            N / N_nominal * flowCharacteristic(0) - s * unitHead);
          V_flow_single = homotopy(if s > 0 then s * unitMassFlowRate / rho else 0, 
            if checkValveHomotopy == Types.CheckValveHomotopyType.Open then s * unitMassFlowRate / rho_nominal else 0);
        end if;
      end if;
      // 功耗
      if use_powerCharacteristic then
        W_single = homotopy((N / N_nominal) ^ 3 * (rho / rho_nominal) * powerCharacteristic(V_flow_single * N_nominal / N), 
          N / N_nominal * V_flow_single / V_flow_single_init * powerCharacteristic(V_flow_single_init));
        eta = dp_pump * V_flow_single / W_single;
      else
        eta = homotopy(efficiencyCharacteristic(V_flow_single * (N_nominal / N)), 
          efficiencyCharacteristic(V_flow_single_init));
        W_single = homotopy(dp_pump * V_flow_single / eta, 
          dp_pump * V_flow_single_init / eta);
      end if;

      // 能量平衡
      Wb_flow = W_total;
      Qb_flow = heatTransfer.Q_flows[1];
      Hb_flow = port_a.m_flow * actualStream(port_a.h_outflow) + 
        port_b.m_flow * actualStream(port_b.h_outflow);

      // 接口
      port_a.h_outflow = medium.h;
      port_b.h_outflow = medium.h;
      port_b.p = medium.p 
        "出口压力等于介质压力，其中包括 Wb_flow";

      // 质量平衡
      mb_flow = port_a.m_flow + port_b.m_flow;

      mbXi_flow = port_a.m_flow * actualStream(port_a.Xi_outflow) + 
        port_b.m_flow * actualStream(port_b.Xi_outflow);
      port_a.Xi_outflow = medium.Xi;
      port_b.Xi_outflow = medium.Xi;

      mbC_flow = port_a.m_flow * actualStream(port_a.C_outflow) + 
        port_b.m_flow * actualStream(port_b.C_outflow);
      port_a.C_outflow = C;
      port_b.C_outflow = C;

      connect(heatTransfer.heatPorts[1], heatPort) annotation(Line(
        points = {{40, -34}, {40, -60}}, color = {127, 0, 0}));
      annotation(
        Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
        100}}), graphics = {
        Rectangle(
        extent = {{-100, 46}, {100, -46}}, 
        fillColor = {0, 127, 255}, 
        fillPattern = FillPattern.HorizontalCylinder), 
        Polygon(
        points = {{-48, -60}, {-72, -100}, {72, -100}, {48, -60}, {-48, -60}}, 
        lineColor = {0, 0, 255}, 
        pattern = LinePattern.None, 
        fillPattern = FillPattern.VerticalCylinder), 
        Ellipse(
        extent = {{-80, 80}, {80, -80}}, 
        fillPattern = FillPattern.Sphere, 
        fillColor = {0, 100, 199}), 
        Polygon(
        points = {{-28, 30}, {-28, -30}, {50, -2}, {-28, 30}}, 
        pattern = LinePattern.None, 
        fillPattern = FillPattern.HorizontalCylinder, 
        fillColor = {255, 255, 255})}), 
        Documentation(info = "<html>
<p>这是泵的基本模型</p>
<p>该模型描述了一个离心泵或一组 n 个相同的并联泵 <code>nParallel</code>。
泵模型以运动相似性理论为基础：根据额定运行条件（转速和流体密度）给出泵的特性，然后根据相似性方程调整到实际运行条件。</p>

<p><strong>泵特性</strong></p>
<p> 名义水力特性（扬程与体积流量的关系）由可替换函数 <code>flowCharacteristic</code> 给出。</p>
<p> 泵的能量平衡有两种指定方式：</p>
<ul>
<li><code>use_powerCharacteristic = false</code> (默认选项）：可替换函数 <code>efficiencyCharacteristic</code>（额定条件下效率与体积流量的关系）用于确定效率和功耗。默认效率为 0.8。</li>
<li><code>use_powerCharacteristic = true</code>：可替换函数 <code>powerCharacteristic</code>（额定条件下功耗与体积流量的关系）用于确定功耗和效率。使用 <code>powerCharacteristic</code> 可指定零流量下的非零功耗。</li>
</ul>
<p>
<code>PumpCharacteristics</code> 子库中提供了多个函数，用于指定在额定条件下作为某些工作点函数的特性。
</p>
<p>
根据<code>checkValve</code> 参数值的不同，该型号要么支持逆流条件，要么内置止回阀以避免逆流。
</p>
<p>
可以通过指定泵内流体的体积V，并选择适当的动态质量和能量平衡假设（见下文），来考虑泵内流体的质量和能量存储；
这在零流量条件下计算出口焓值时，有助于避免计算中的奇异性。
如果始终避免零流量条件，可以通过保持默认值V = 0来忽略这种动态效应，从而避免模式中的快速状态变量。
</p>

<p><strong>动力选项</strong></p>
<p>
默认情况下，假设稳态的质量和能量平衡，忽略泵内流体的滞留量；
如果流量始终为正值，则此配置效果良好。可以通过设置相应的动态参数来实现动态质量和能量平衡。
这在零流量或质量流量反转时，有助于避免计算中的奇异性。
如果初始条件指出质量流量不为零，则可以使用 <code>SteadyStateInitial</code> 条件，否则建议使用 <code>FixedInitial</code> 条件，以避免不确定的初始条件。
</p>

<p><strong>传热</strong></p>
<p>
布尔参数 <code>use_HeatTransfer</code> 可以设为 true，以便考虑与环境换热或对外壳进行建模。
如果希望在阀门阻止流体流动的情况下，模拟一台在零流量时具有实际功率特性 <code>powerCharacteristic</code> 的泵，这可能是必要的。
</p>

<p><strong>气蚀诊断</strong></p>
<p>
可替换的监测子模型可配置为 PumpMonitoringNPSH，以便计算可用的净正吸入压头并检查是否发生气蚀，前提是使用了两相介质模型（参见高级选项卡）。
</p>
</html>"    , 
        revisions = "<html>
<ul>
<li><em>8 Jan 2013</em>
by R&uuml;diger Franke:<br>
将NPSH诊断从PartialPump移至可替换的子模型PumpMonitoring.PumpMonitoringNPSH（参见工单#646）/li>
<li><em>Dec 2008</em>
by R&uuml;diger Franke:<br>
<ul>
<li>用严格公式替换了简化的质量和能量平衡（基类PartialLumpedVolume）</li>
<li>引入了定义Qb_flow的可选热传递模型</li>
<li>启用了checkValve运行时的事件，以支持在port_a之前打开离散阀</li>
</ul></li>
<li><em>31 Oct 2005</em>
by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
模型添加到流体库中</li>
</ul>
</html>"    ));
    end PartialPump;

  package PumpCharacteristics "泵特性函数"
    extends Modelica.Icons.Package;
    import Modelica.Units.NonSI;

    partial function baseFlow "泵流量特性的基本函数"
      extends Modelica.Icons.Function;
      input SI.VolumeFlowRate V_flow "体积流量";
      output SI.Position head "泵扬程";
      annotation();
    end baseFlow;

    partial function basePower 
        "泵功率消耗特性的基本函数"
      extends Modelica.Icons.Function;
      input SI.VolumeFlowRate V_flow "体积流量";
      output SI.Power consumption "功耗";
      annotation();
    end basePower;

      partial function baseEfficiency "效率特性基本函数"
        extends Modelica.Icons.Function;
        input SI.VolumeFlowRate V_flow "体积流量";
        output Real eta "效率";
        annotation();
      end baseEfficiency;

      function linearFlow "线性流量特性"
        extends baseFlow;
        input SI.VolumeFlowRate V_flow_nominal[2] 
          "两个工作点的体积流量（单泵）" annotation(Dialog);
        input SI.Position head_nominal[2] "两个工作点的泵扬程" annotation(Dialog);
        /* 确定系数的线性方程:
        head_nominal[1] = c[1] + V_flow_nominal[1]*c[2];
        head_nominal[2] = c[1] + V_flow_nominal[2]*c[2];
        */
      protected
        Real c[2] = Modelica.Math.Matrices.solve([ones(2), V_flow_nominal], head_nominal) 
          "线性水头曲线系数";
        annotation();
      algorithm
        assert(c[2] <= -Modelica.Constants.small, 
          "错误的泵曲线 -- head_nominal 必须随 V_flow_nominal 的增加而单调递减", 
          level = AssertionLevel.warning);
        // 流量方程: head = q*c[1] + c[2];
        head := c[1] + V_flow * c[2];
      end linearFlow;

      function quadraticFlow 
        "二次流特性，包括线性外推法"
        extends baseFlow;
        input SI.VolumeFlowRate V_flow_nominal[3] 
          "三个工作点的体积流量（单泵）" annotation(Dialog);
        input SI.Position head_nominal[3] "三个工作点的泵扬程" annotation(Dialog);
      protected
        Real V_flow_nominal2[3] = {V_flow_nominal[1] ^ 2, V_flow_nominal[2] ^ 2, V_flow_nominal[3] ^ 2} 
          "额定流量的平方";
        /* 确定系数的线性方程:
        head_nominal[1] = c[1] + V_flow_nominal[1]*c[2] + V_flow_nominal[1]^2*c[3];
        head_nominal[2] = c[1] + V_flow_nominal[2]*c[2] + V_flow_nominal[2]^2*c[3];
        head_nominal[3] = c[1] + V_flow_nominal[3]*c[2] + V_flow_nominal[3]^2*c[3];
        */
        Real c[3] = Modelica.Math.Matrices.solve([ones(3), V_flow_nominal, V_flow_nominal2], head_nominal) 
          "二次水头曲线系数";
        SI.VolumeFlowRate V_flow_min = min(V_flow_nominal);
        SI.VolumeFlowRate V_flow_max = max(V_flow_nominal);
      algorithm
        assert(max(c[2] .+ 2 * c[3] * V_flow_nominal) <= -Modelica.Constants.small, 
          "错误的泵曲线 -- head_nominal 必须随 V_flow_nominal 的增加而单调递减", 
          level = AssertionLevel.warning);
        if V_flow < V_flow_min then
          head := max(head_nominal) + (V_flow - V_flow_min) * (c[2] + 2 * c[3] * V_flow_min);
        elseif V_flow > V_flow_max then
          head := min(head_nominal) + (V_flow - V_flow_max) * (c[2] + 2 * c[3] * V_flow_max);
        else
          // 流量方程: head  = c[1] + V_flow*c[2] + V_flow^2*c[3];
          head := c[1] + V_flow * (c[2] + V_flow * c[3]);
        end if;

        annotation(Documentation(revisions = "<html>
<ul>
<li><em>Jan 2013</em>
by R&uuml;diger Franke:<br>
在指定点外进行线性外推法扩展</li>
</ul>
</html>"      ));
      end quadraticFlow;

    function polynomialFlow 
        "多项式流量特性，包括线性外推法"
      extends baseFlow;
      input SI.VolumeFlowRate V_flow_nominal[:] 
          "N 个工作点的体积流量（单泵）" annotation(Dialog);
      input SI.Position head_nominal[:] "N 个工作点的泵扬程" annotation(Dialog);
      protected
      Integer N = size(V_flow_nominal,1) "额定运行点数量";
      Real V_flow_nominal_pow[N,N] = {{if j > 1 then V_flow_nominal[i]^(j-1) else 1 for j in 1:N} for i in 1:N} 
          "行：不同的运行点；列：功率递增";
      /* 确定系数的线性方程（例如 N=3）:
  head_nominal[1] = c[1] + V_flow_nominal[1]*c[2] + V_flow_nominal[1]^2*c[3];
  head_nominal[2] = c[1] + V_flow_nominal[2]*c[2] + V_flow_nominal[2]^2*c[3];
  head_nominal[3] = c[1] + V_flow_nominal[3]*c[2] + V_flow_nominal[3]^2*c[3];
  */
      Real c[size(V_flow_nominal,1)] = Modelica.Math.Matrices.solve(V_flow_nominal_pow,head_nominal) 
          "多项式水头曲线系数";
      SI.VolumeFlowRate V_flow_min = min(V_flow_nominal);
      SI.VolumeFlowRate V_flow_max = max(V_flow_nominal);
      Real max_dhdV = c[2] + max(sum((i-1)*V_flow_nominal.^(i-2)*c[i] for i in 3:N));
      Real poly;
    algorithm
      assert(max_dhdV <= -Modelica.Constants.small, 
             "错误的泵曲线 -- head_nominal 必须随 V_flow_nominal 的增加而单调递减", 
             level=AssertionLevel.warning);
      if V_flow < V_flow_min then
        //head := max(head_nominal) + (V_flow-V_flow_min)*(c[2]+sum((i-1)*V_flow_min^(i-2)*c[i] for i in 3:N));
        poly := c[N]*(N-1);
        for i in 1:N-2 loop
          poly := V_flow_min*poly + c[N-i]*(N-i-1);
        end for;
        head := max(head_nominal) + (V_flow-V_flow_min)*poly;
      elseif V_flow > V_flow_max then
        //head := min(head_nominal) + (V_flow-V_flow_max)*(c[2]+sum((i-1)*V_flow_max^(i-2)*c[i] for i in 3:N));
        poly := c[N]*(N-1);
        for i in 1:N-2 loop
          poly := V_flow_max*poly + c[N-i]*(N-i-1);
        end for;
        head := min(head_nominal) + (V_flow-V_flow_max)*poly;
      else
        // Flow equation (example N=3): head  = c[1] + V_flow*c[2] + V_flow^2*c[3];
        // 注意: 只有在 Na 值较低的情况下，数值计算才是有效的。
        //head := sum(V_flow^(i-1)*c[i] for i in 1:N);
        poly := c[N];
        for i in 1:N-1 loop
          poly := V_flow*poly + c[N-i];
         end for;
        head := poly;
      end if;

      annotation(Documentation(revisions="<html>
<ul>
<li><em>Jan 2013</em>
by R&uuml;diger Franke:<br>
扩展了指定点外的线性外推法，并重新进行了多项式评估</li>
</ul>
</html>"    ));
    end polynomialFlow;

    function constantEfficiency "固定效率特性"
       extends baseEfficiency;
       input Real eta_nominal "额定效率" annotation(Dialog);
      annotation();
    algorithm
      eta := eta_nominal;
    end constantEfficiency;

      function linearPower "线性功耗特性"
        extends basePower;
        input SI.VolumeFlowRate V_flow_nominal[2] 
          "两个工作点的体积流量（单泵）" annotation(Dialog);
        input SI.Power W_nominal[2] "两个工作点的功耗" annotation(Dialog);
        /* 确定系数的线性方程:
        W_nominal[1] = c[1] + V_flow_nominal[1]*c[2];
        W_nominal[2] = c[1] + V_flow_nominal[2]*c[2];
        */
      protected
        Real c[2] = Modelica.Math.Matrices.solve([ones(3), V_flow_nominal], W_nominal) 
          "线性功耗曲线系数";
        annotation();
      algorithm
        consumption := c[1] + V_flow * c[2];
      end linearPower;

      function quadraticPower "二次功耗特性"
        extends basePower;
        input SI.VolumeFlowRate V_flow_nominal[3] 
          "三个工作点的体积流量（单泵）" 
          annotation(Dialog);
        input SI.Power W_nominal[3] 
          "三个工作点的功耗" annotation(Dialog);
      protected
        Real V_flow_nominal2[3] = {V_flow_nominal[1] ^ 2, V_flow_nominal[2] ^ 2, V_flow_nominal[3] ^ 2} 
          "额定流量的平方";
        /* 确定系数的线性方程:
        W_nominal[1] = c[1] + V_flow_nominal[1]*c[2] + V_flow_nominal[1]^2*c[3];
        W_nominal[2] = c[1] + V_flow_nominal[2]*c[2] + V_flow_nominal[2]^2*c[3];
        W_nominal[3] = c[1] + V_flow_nominal[3]*c[2] + V_flow_nominal[3]^2*c[3];
        */
        Real c[3] = Modelica.Math.Matrices.solve([ones(3), V_flow_nominal, V_flow_nominal2], W_nominal) 
          "二次功耗曲线系数";
        annotation();
      algorithm
        consumption := c[1] + V_flow * c[2] + V_flow ^ 2 * c[3];
      end quadraticPower;
    annotation();

  end PumpCharacteristics;

    package PumpMonitoring "泵运行监视器"
      extends Modelica.Icons.Package;
      model PumpMonitoringBase "泵监测接口"
        outer Modelica.Fluid.System system "全局属性";
        //
        // 内部接口
        // 不在图形用户界面显示; 在使用该模型时需要硬编码
        //
        replaceable package Medium = 
          Modelica.Media.Interfaces.PartialMedium "组件中的介质" 
            annotation(Dialog(tab="内部接口",enable=false));

        // 输入
        input Medium.ThermodynamicState state_in 
          "入流的热力学状态";
        input Medium.ThermodynamicState state "泵内的热力学状态";
        annotation();

      end PumpMonitoringBase;

      model PumpMonitoringNPSH "监测净正吸入压头(NPSH)"
        extends PumpMonitoringBase(redeclare replaceable package Medium = 
          Modelica.Media.Interfaces.PartialTwoPhaseMedium);
        Medium.Density rho_in = Medium.density(state_in) 
          "入口 port_a 的液体密度";
        SI.Position NPSHa=NPSPa/(rho_in*system.g) 
          "可用净正吸入压头";
        SI.Pressure NPSPa=assertPositiveDifference(Medium.pressure(state_in), Medium.saturationPressure(Medium.temperature(state_in)), 
                                                   "在泵入口发生气蚀") 
          "可用的净正吸入压力";
        SI.Pressure NPDPa=assertPositiveDifference(Medium.pressure(state), Medium.saturationPressure(Medium.temperature(state)), 
                                                   "在泵内发生气蚀") 
          "可用净正向排出压力";
        annotation();
      end PumpMonitoringNPSH;

      function assertPositiveDifference
        extends Modelica.Icons.Function;
        input SI.Pressure p;
        input SI.Pressure p_sat;
        input String message;
        output SI.Pressure dp;
        annotation();
      algorithm
        dp := p - p_sat;
        assert(p >= p_sat, message);
      end assertPositiveDifference;
      annotation();
    end PumpMonitoring;
    annotation();
  end BaseClasses;
  annotation (Documentation(info="<html>

</html>"));
end Machines;