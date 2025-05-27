within Modelica.Fluid.Examples;
package DrumBoiler 
  "汽包锅炉示例，参见 Franke, Rode, Krüger: On-line Optimization of Drum Boiler Startup, 3rd International Modelica Conference, Linköping, 2003"
  extends Modelica.Icons.ExamplesPackage;
  model DrumBoiler 
    "完整的汽包锅炉模型，包括蒸发器和辅助部件"
    extends Modelica.Icons.Example;
    parameter Boolean use_inputs = false 
      "true: 使用外部输入，否则使用内部包含的测试数据";
    Modelica.Fluid.Examples.DrumBoiler.BaseClasses.EquilibriumDrumBoiler 
      evaporator(
      m_D = 300e3, 
      cp_D = 500, 
      V_t = 100, 
      V_l_start = 67, 
    redeclare package Medium = Modelica.Media.Water.StandardWater, 
      energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, 
      massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, 
      p_start = 100000) annotation(Placement(transformation(extent = {{-46, -30}, 
      {-26, -10}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow furnace 
      annotation(Placement(transformation(
      origin = {-36, -53}, 
      extent = {{-10, -10}, {10, 10}}, 
      rotation = 90)));
    Modelica.Fluid.Sources.FixedBoundary sink(nPorts = 1, p = Cv.from_bar(0.5), 
    redeclare package Medium = Modelica.Media.Water.StandardWaterOnePhase, 
      T = 500) 
      annotation(Placement(transformation(
      origin = {90, -20}, 
      extent = {{-10, -10}, {10, 10}}, 
      rotation = 180)));
    Modelica.Fluid.Sensors.MassFlowRate massFlowRate(redeclare package Medium = 
      Modelica.Media.Water.StandardWater) 
      annotation(Placement(transformation(
      origin = {30, -20}, 
      extent = {{10, 10}, {-10, -10}}, 
      rotation = 180)));
    Modelica.Fluid.Sensors.Temperature temperature(redeclare package Medium 
      = Modelica.Media.Water.StandardWater) 
      annotation(Placement(transformation(
      origin = {-3, -1}, 
      extent = {{10, 10}, {-10, -10}}, 
      rotation = 180)));
    Modelica.Fluid.Sensors.Pressure pressure(redeclare package Medium = 
      Modelica.Media.Water.StandardWater) 
      annotation(Placement(transformation(extent = {{10, 18}, {30, 38}})));
    Modelica.Blocks.Continuous.PI controller(T = 120, k = 10, initType = Modelica.Blocks.Types.Init.InitialState) 
      annotation(Placement(transformation(extent = {{-49, 23}, {-63, 37}})));
    Modelica.Fluid.Sources.MassFlowSource_h pump(nPorts = 1, 
      h = 5e5, redeclare package Medium = 
      Modelica.Media.Water.StandardWater, 
      use_m_flow_in = true) 
      annotation(Placement(transformation(extent = {{-80, -30}, {-60, -10}})));
    Modelica.Blocks.Math.Feedback feedback 
      annotation(Placement(transformation(extent = {{-22, 20}, {-42, 40}})));
    Modelica.Blocks.Sources.Constant levelSetPoint(k = 67) 
      annotation(Placement(transformation(extent = {{-38, 48}, {-24, 62}})));
    Modelica.Blocks.Interfaces.RealOutput T_S(final unit = "degC") "蒸汽温度" 
      annotation(Placement(transformation(extent = {{100, 48}, {112, 60}})));
    Modelica.Blocks.Interfaces.RealOutput p_S(final unit = "bar") "蒸汽压力" 
      annotation(Placement(transformation(extent = {{100, 22}, {112, 34}})));
    Modelica.Blocks.Interfaces.RealOutput qm_S(unit = "kg/s") "蒸汽流量" 
      annotation(Placement(transformation(extent = {{100, -2}, {112, 10}})));
    Modelica.Blocks.Interfaces.RealOutput V_l(unit = "m3") "汽包内液体容量" 
      annotation(Placement(transformation(extent = {{100, 74}, {112, 86}})));
  public
    Modelica.Blocks.Math.Gain MW2W(k = 1e6) 
      annotation(Placement(transformation(extent = {{-54, -75.5}, {-44, -64.5}})));
    Modelica.Blocks.Math.Gain Pa2bar(k = 1e-5) annotation(Placement(
      transformation(extent = {{37, 23}, {47, 33}})));
    Modelica.Thermal.HeatTransfer.Celsius.FromKelvin K2degC 
      annotation(Placement(transformation(extent = {{38, 49}, {48, 59}})));
    Modelica.Blocks.Nonlinear.Limiter limiter(uMin = 0, uMax = 500) 
      annotation(Placement(transformation(
      origin = {-78, 30}, 
      extent = {{-7, 7}, {7, -7}}, 
      rotation = 180)));
    Modelica.Fluid.Valves.ValveLinear SteamValve(redeclare package Medium = 
      Modelica.Media.Water.StandardWater, 
      dp_nominal = 9000000, 
      m_flow_nominal = 180) 
      annotation(Placement(transformation(extent = {{50, -10}, {70, -30}})));

    inner Modelica.Fluid.System system 
      annotation(Placement(transformation(extent = {{-90, 70}, {-70, 90}})));
    Modelica.Blocks.Sources.TimeTable q_F_Tab(table = [0, 0; 3600, 400; 7210,
      400]) if not use_inputs annotation(Placement(transformation(extent = {{-90, -80}, {-70, -60}})));
    Modelica.Blocks.Sources.TimeTable Y_Valve_Tab(table = [0, 0; 900, 1; 7210, 1]) if not use_inputs 
      annotation(Placement(transformation(extent = {{30, -80}, {50, -60}})));
    Blocks.Interfaces.RealInput q_F(unit = "MW") if 
      use_inputs "燃料流量" 
      annotation(Placement(transformation(extent = {{-112, -56}, {-100, -44}})));
    Blocks.Interfaces.RealInput Y_Valve if use_inputs "阀门开度" 
      annotation(Placement(transformation(extent = {{-112, -96}, {-100, -84}})));
  equation
    connect(furnace.port, evaporator.heatPort) 
      annotation(Line(points = {{-36, -43}, {-36, -30}}, color = {191, 0, 0}));
    connect(controller.u, feedback.y) 
      annotation(Line(points = {{-47.6, 30}, {-41, 30}}, color = {0, 0, 127}));
    connect(massFlowRate.m_flow, qm_S) 
      annotation(Line(points = {{30, -9}, {30, 4}, {106, 4}}, color = {0, 0, 127}));
    connect(evaporator.V, V_l) 
      annotation(Line(points = {{-32, -9}, {-32, 16}, {-4, 16}, {-4, 80}, {106, 80}}, color = {0, 0, 127}));
    connect(MW2W.y, furnace.Q_flow) annotation(Line(points = {{-43.5, -70}, {-36, 
      -70}, {-36, -63}}, color = {0, 0, 127}));
    connect(pressure.p, Pa2bar.u) 
      annotation(Line(points = {{31, 28}, {36, 28}}, color = {0, 0, 127}));
    connect(Pa2bar.y, p_S) 
      annotation(Line(points = {{47.5, 28}, {106, 28}}, color = {0, 0, 127}));
    connect(K2degC.Celsius, T_S) annotation(Line(points = {{48.5, 54}, {106, 54}}, color = {0, 0, 127}));
    connect(controller.y, limiter.u) annotation(Line(points = {{-63.7, 30}, {-69.6, 
      30}}, color = {0, 0, 127}));
    connect(limiter.y, pump.m_flow_in) annotation(Line(points = {{-85.7, 30}, {-90, 
      30}, {-90, -12}, {-80, -12}}, color = {0, 0, 127}));
    connect(temperature.T, K2degC.Kelvin) annotation(Line(points = {{4, -1}, {4, -1}, 
      {8, -1}, {8, 54}, {37, 54}}, color = {0, 0, 127}));
    connect(pressure.port, massFlowRate.port_a) annotation(Line(points = {{20, 18}, {
      20, -20}}, color = {0, 127, 255}));
    connect(pump.ports[1], evaporator.port_a) annotation(Line(points = {{-60, -20}, 
      {-46, -20}}, color = {0, 127, 255}));
    connect(massFlowRate.port_b, SteamValve.port_a) annotation(Line(points = {{
      40, -20}, {50, -20}}, color = {0, 127, 255}));
    connect(SteamValve.port_b, sink.ports[1]) annotation(Line(points = {{70, -20}, {75, 
      -20}, {80, -20}}, color = {0, 127, 255}));
    connect(evaporator.port_b, massFlowRate.port_a) annotation(Line(points = {{
      -26, -20}, {20, -20}}, color = {0, 127, 255}));
    connect(temperature.port, massFlowRate.port_a) annotation(Line(
      points = {{-3, -11}, {-3, -20}, {20, -20}}, color = {0, 127, 255}));
    connect(q_F_Tab.y, MW2W.u) annotation(Line(
      points = {{-69, -70}, {-55, -70}}, color = {0, 0, 127}));
    connect(Y_Valve_Tab.y, SteamValve.opening) annotation(Line(
      points = {{51, -70}, {60, -70}, {60, -28}}, color = {0, 0, 127}));
    connect(q_F, MW2W.u) annotation(Line(
      points = {{-106, -50}, {-62, -50}, {-62, -70}, {-55, -70}}, color = {0, 0, 127}));
    connect(Y_Valve, SteamValve.opening) annotation(Line(
      points = {{-106, -90}, {60, -90}, {60, -28}}, color = {0, 0, 127}));
    connect(evaporator.V, feedback.u2) annotation(Line(
      points = {{-32, -9}, {-32, 22}}, color = {0, 0, 127}));
    connect(levelSetPoint.y, feedback.u1) annotation(Line(
      points = {{-23.3, 55}, {-16, 55}, {-16, 30}, {-24, 30}}, color = {0, 0, 127}));
    annotation(
      Icon(coordinateSystem(
      preserveAspectRatio = false, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Text(
      extent = {{-151, 165}, {138, 102}}, 
      textColor = {0, 0, 255}, 
      textString = "%name"), 
      Text(
      extent = {{-79, 67}, {67, 21}}, 
      textString = "drum"), 
      Text(
      extent = {{-90, -14}, {88, -64}}, 
      textString = "boiler")}), 
      experiment(StopTime = 5400), 
      Documentation(info = "<html><p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/DrumBoiler/DrumBoiler.png\" alt=\"DrumBoiler.png\" data-href=\"\" style=\"\"/>
</p>
</html>"));
  end DrumBoiler;

  package BaseClasses "汽包锅炉示例的附加组件"
    extends Modelica.Icons.BasesPackage;
    model EquilibriumDrumBoiler 
      "具有两种状态的简化蒸发器，参见 Åström, Bell: Drum-boiler dynamics, Automatica 36, 2000, pp.363-378"
      extends Modelica.Fluid.Interfaces.PartialTwoPort(
        final port_a_exposesState = true, 
        final port_b_exposesState = true, 
      redeclare replaceable package Medium = 
        Modelica.Media.Water.StandardWater 
        constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium);
      import Modelica.Constants;
      import Modelica.Fluid.Types;
      parameter SI.Mass m_D "汽包周围金属的质量";
      parameter Medium.SpecificHeatCapacity cp_D 
        "汽包金属的比热容";
      parameter SI.Volume V_t "汽包内部总容积";
      parameter Medium.AbsolutePressure p_start = system.p_start 
        "压力初值" 
        annotation(Dialog(tab = "初始化"));
      parameter SI.Volume V_l_start = V_t / 2 
        "液体容积初值" 
        annotation(Dialog(tab = "初始化"));
      // 假设
      parameter Boolean allowFlowReversal = system.allowFlowReversal 
        "true：如果启用了流量反向，否则将流量限制在设计方向上 (port_a -> port_b)" 
        annotation(Dialog(tab = "假设"), Evaluate = true);
      parameter Types.Dynamics energyDynamics = system.energyDynamics 
        "能量平衡公式" 
        annotation(Evaluate = true, Dialog(tab = "假设", group = "动力学"));
      parameter Types.Dynamics massDynamics = system.massDynamics 
        "质量平衡公式" 
        annotation(Evaluate = true, Dialog(tab = "假设", group = "动力学"));

      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort 
        annotation(Placement(transformation(extent = {{-10, -110}, {10, -90}})));
      Modelica.Blocks.Interfaces.RealOutput V(unit = "m3") "液体容积" 
        annotation(Placement(transformation(
        origin = {40, 110}, 
        extent = {{-10, -10}, {10, 10}}, 
        rotation = 90)));

      Medium.SaturationProperties sat 
        "计算饱和性质的状态矢量";
      Medium.AbsolutePressure p(start = p_start, stateSelect = StateSelect.prefer) 
        "锅炉内部的压力";
      Medium.Temperature T "锅炉内的温度";
      SI.Volume V_v "蒸汽相容积";
      SI.Volume V_l(start = V_l_start, stateSelect = StateSelect.prefer) 
        "液体相容积";
      Medium.SpecificEnthalpy h_v = Medium.dewEnthalpy(sat) 
        "蒸汽的比焓";
      Medium.SpecificEnthalpy h_l = Medium.bubbleEnthalpy(sat) 
        "液体的比焓";
      Medium.Density rho_v = Medium.dewDensity(sat) "蒸汽相密度";
      Medium.Density rho_l = Medium.bubbleDensity(sat) "液体相密度";
      SI.Mass m "锅炉的总质量";
      SI.Energy U "内能";
      Medium.Temperature T_D = heatPort.T "锅炉的温度";
      SI.HeatFlowRate q_F = heatPort.Q_flow "炉内热流量";
      Medium.SpecificEnthalpy h_W = inStream(port_a.h_outflow) 
        "给水的比焓（当质量流入锅炉时，接近给水口的比焓）";
      Medium.SpecificEnthalpy h_S = inStream(port_b.h_outflow) 
        "蒸汽的比焓（当质量流入锅炉时，接近蒸汽口的比焓）";
      SI.MassFlowRate qm_W = port_a.m_flow "给水质量流量";
      SI.MassFlowRate qm_S = port_b.m_flow "蒸汽质量流量";
    /*outer Modelica.Fluid.Components.FluidOptions fluidOptions
    "全局默认选项";*/
    equation
      // 平衡方程
      m = rho_v * V_v + rho_l * V_l + m_D "总质量";
      U = rho_v * V_v * h_v + rho_l * V_l * h_l - p * V_t + m_D * cp_D * T_D "总能量";
      if massDynamics == Types.Dynamics.SteadyState then
        0 = qm_W + qm_S "稳态质量平衡";
      else
        der(m) = qm_W + qm_S "动态质量平衡";
      end if;
      if energyDynamics == Types.Dynamics.SteadyState then
        0 = q_F + port_a.m_flow * actualStream(port_a.h_outflow) 
          + port_b.m_flow * actualStream(port_b.h_outflow) 
          "稳态能量平衡";
      else
        der(U) = q_F 
          + port_a.m_flow * actualStream(port_a.h_outflow) 
          + port_b.m_flow * actualStream(port_b.h_outflow) 
          "动态能量平衡";
      end if;
      V_t = V_l + V_v;

      // 饱和液体和蒸汽的性质
      sat.psat = p;
      sat.Tsat = T;
      sat.Tsat = Medium.saturationTemperature(p);

      // 金属和水之间的理想热传递
      T_D = T;

      // 接口处的边界条件
      port_a.p = p;
      port_a.h_outflow = h_l;
      port_b.p = p;
      port_b.h_outflow = h_v;

      // 液体容积
      V = V_l;

      // 检查两相平衡是否确实可行
      assert(p < Medium.fluidConstants[1].criticalPressure - 10000, 
        "蒸发器模型需要亚临界压力");
    initial equation
      // 初始条件
      // 注意：p 表示能量，受 T_sat 的约束
      if energyDynamics == Types.Dynamics.FixedInitial then
        p = p_start;
      elseif energyDynamics == Types.Dynamics.SteadyStateInitial then
        der(p) = 0;
      end if;

      if massDynamics == Types.Dynamics.FixedInitial then
        V_l = V_l_start;
      elseif energyDynamics == Types.Dynamics.SteadyStateInitial then
        der(V_l) = 0;
      end if;
      annotation(
        Icon(coordinateSystem(
        preserveAspectRatio = false, 
        extent = {{-100, -100}, {100, 100}}), graphics = {
        Rectangle(
        extent = {{-100, 64}, {100, -64}}, 
        fillPattern = FillPattern.Backward, 
        fillColor = {135, 135, 135}), 
        Rectangle(
        extent = {{-100, -44}, {100, 44}}, 
        fillPattern = FillPattern.HorizontalCylinder, 
        fillColor = {255, 255, 255}), 
        Rectangle(
        extent = DynamicSelect({{-100, -44}, {100, 44}}, 
        {{-100, -44}, {(-100 + 200 * V_l / V_t), 44}}), 
        fillPattern = FillPattern.HorizontalCylinder, 
        fillColor = {0, 127, 255}), 
        Ellipse(
        extent = {{18, 0}, {48, -29}}, 
        lineColor = {0, 0, 255}, 
        pattern = LinePattern.None, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), 
        Ellipse(
        extent = {{-1, 29}, {29, 0}}, 
        lineColor = {0, 0, 255}, 
        pattern = LinePattern.None, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), 
        Ellipse(
        extent = {{43, 31}, {73, 2}}, 
        lineColor = {0, 0, 255}, 
        pattern = LinePattern.None, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), 
        Ellipse(
        extent = {{-31, 1}, {-1, -28}}, 
        lineColor = {0, 0, 255}, 
        pattern = LinePattern.None, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), 
        Ellipse(
        extent = {{50, 15}, {80, -14}}, 
        lineColor = {0, 0, 255}, 
        pattern = LinePattern.None, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), 
        Ellipse(
        extent = {{-72, 25}, {-42, -4}}, 
        lineColor = {0, 0, 255}, 
        pattern = LinePattern.None, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), 
        Ellipse(
        extent = {{71, -11}, {101, -40}}, 
        lineColor = {0, 0, 255}, 
        pattern = LinePattern.None, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), 
        Ellipse(
        extent = {{72, 28}, {102, -1}}, 
        lineColor = {0, 0, 255}, 
        pattern = LinePattern.None, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), 
        Ellipse(
        extent = {{71, 40}, {101, 11}}, 
        lineColor = {0, 0, 255}, 
        pattern = LinePattern.None, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), 
        Line(points = {{0, -64}, {0, -100}}, color = {191, 0, 0}), 
        Line(points = {{40, 100}, {40, 64}}, color = {0, 0, 127}), 
        Ellipse(
        extent = {{58, -11}, {88, -40}}, 
        lineColor = {0, 0, 255}, 
        pattern = LinePattern.None, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), 
        Ellipse(
        extent = {{71, 1}, {101, -28}}, 
        lineColor = {0, 0, 255}, 
        pattern = LinePattern.None, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid)}), 
        Documentation(revisions = "<html>
<ul>
<li><em>Dec 2008</em>
by R&uuml;diger Franke:<br>
适应新的 Types.Dynamics 的初始化</li>
<li><em>2 Nov 2005</em>
by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
修正了初始化选项</li>
<li><em>6 Sep 2005</em><br>
由 R&uuml;diger Franke 建模<br>
参见 Franke, Rode, Kr&uuml;ger: On-line Optimization of Drum Boiler Startup, 3rd International Modelica Conference, Link&ouml;ping, 2003.<br>
在第45次设计会议后进行了修改</li>
</ul>
</html>"    , info = "<html><p>
具有两种状态的简化蒸发器模型。<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">
该模型假设组件内部处于两相平衡状态，饱和蒸汽从蒸汽出口排出</span>。
</p>
<p>
参考文献：Åström, Bell: Drum-boiler dynamics, Automatica 36, 2000, pp.363-378
</p>
</html>"    ));
    end EquilibriumDrumBoiler;
    annotation();
  end BaseClasses;
  annotation();
end DrumBoiler;