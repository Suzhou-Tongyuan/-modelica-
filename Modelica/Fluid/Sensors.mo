within Modelica.Fluid;
package Sensors 
  "从流体连接器中提取信号的理想传感器组件"
  extends Modelica.Icons.SensorsPackage;

  model Pressure "理想的压力传感器"
    extends Sensors.BaseClasses.PartialAbsoluteSensor;
    extends Modelica.Icons.RoundSensor;
    Modelica.Blocks.Interfaces.RealOutput p(final quantity = "Pressure", 
      final unit = "Pa", 
      displayUnit = "bar", 
      min = 0) "接口压力" 
      annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));
  equation
    p = port.p;
    annotation(
      Icon(coordinateSystem(
      preserveAspectRatio = false, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{70, 0}, {100, 0}}, color = {0, 0, 127}), 
      Line(points = {{0, -70}, {0, -100}}, color = {0, 127, 255}), 
      Text(
      extent = {{-150, 80}, {150, 120}}, 
      textString = "%name", 
      textColor = {0, 0, 255}), 
      Text(
      extent = {{151, -20}, {57, -50}}, 
      textString = "p")}), 
      Documentation(info = "<html>
<p>
该组件可监测其流体接口的绝对压力。该传感器是理想的，即不会影响流体。
</p>
</html>"  ));
  end Pressure;

  model Density "理想的单接口密度传感器"
    extends Sensors.BaseClasses.PartialAbsoluteSensor;
    extends Modelica.Icons.RoundSensor;
    Modelica.Blocks.Interfaces.RealOutput d(final quantity = "Density", 
      final unit = "kg/m3", 
      displayUnit = "g/cm3", 
      min = 0) "接口介质密度" 
      annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));

  equation
    d = Medium.density(Medium.setState_phX(port.p, inStream(port.h_outflow), inStream(port.Xi_outflow)));
    annotation(defaultComponentName = "density", 
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Line(points = {{0, -70}, {0, -100}}, color = {0, 0, 127}), 
      Text(
      extent = {{-150, 80}, {150, 120}}, 
      textString = "%name", 
      textColor = {0, 0, 255}), 
      Text(
      extent = {{154, -31}, {56, -61}}, 
      textString = "d"), 
      Line(points = {{70, 0}, {100, 0}}, color = {0, 0, 127})}), 
      Documentation(info = "<html>
<p>
该组件可监测通过其接口的流体密度。该传感器是理想的，即不会影响流体。
</p>

</html>"  ));
  end Density;

  model DensityTwoPort "理想的双接口密度传感器"
    extends Sensors.BaseClasses.PartialFlowSensor;
    extends Modelica.Icons.RoundSensor;
    Modelica.Blocks.Interfaces.RealOutput d(final quantity = "Density", 
      final unit = "kg/m3", 
      displayUnit = "g/cm3", 
      min = 0) 
      "通过流体的密度" 
      annotation(Placement(transformation(
      origin = {0, 110}, 
      extent = {{10, -10}, {-10, 10}}, 
      rotation = 270)));

  protected
    Medium.Density rho_a_inflow "port_a 流入流体的密度";
    Medium.Density rho_b_inflow 
      "port_b 处流入流体的密度或 rho_a_inflow (若为单向流动)";
  equation
    if allowFlowReversal then
      rho_a_inflow = Medium.density(Medium.setState_phX(port_b.p, port_b.h_outflow, port_b.Xi_outflow));
      rho_b_inflow = Medium.density(Medium.setState_phX(port_a.p, port_a.h_outflow, port_a.Xi_outflow));
      d = Modelica.Fluid.Utilities.regStep(port_a.m_flow, rho_a_inflow, rho_b_inflow, m_flow_small);
    else
      d = Medium.density(Medium.setState_phX(port_b.p, port_b.h_outflow, port_b.Xi_outflow));
      rho_a_inflow = d;
      rho_b_inflow = d;
    end if;
    annotation(defaultComponentName = "density", 
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Text(
      extent = {{102, 124}, {6, 95}}, 
      textString = "d"), 
      Line(points = {{0, 100}, {0, 70}}, color = {0, 0, 127}), 
      Line(points = {{-100, 0}, {-70, 0}}, color = {0, 128, 255}), 
      Line(points = {{70, 0}, {100, 0}}, color = {0, 128, 255})}), 
      Documentation(info = "<html>
<p>
该组件用于监测从 port_a 流向 port_b 的流体密度。传感器是理想的，即不会影响流体。
</p>
</html>"  ));
  end DensityTwoPort;

  model Temperature "理想的单接口温度传感器"
    extends Sensors.BaseClasses.PartialAbsoluteSensor;

    Modelica.Blocks.Interfaces.RealOutput T(final quantity = "ThermodynamicTemperature", 
      final unit = "K", displayUnit = "degC", min = 0) 
      "接口介质温度" 
      annotation(Placement(transformation(extent = {{60, -10}, {80, 10}})));

  equation
    T = Medium.temperature(Medium.setState_phX(port.p, inStream(port.h_outflow), inStream(port.Xi_outflow)));
    annotation(defaultComponentName = "temperature", 
      Documentation(info = "<html>
<p>
该组件可监测通过其接口的流体温度。该传感器是理想的，即不会影响流体。
</p>
</html>"  ), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {
      100, 100}}), graphics = {
      Line(points = {{0, -70}, {0, -100}}, color = {0, 0, 127}), 
      Ellipse(
      extent = {{-20, -98}, {20, -60}}, 
      lineThickness = 0.5, 
      fillColor = {191, 0, 0}, 
      fillPattern = FillPattern.Solid), 
      Rectangle(
      extent = {{-12, 40}, {12, -68}}, 
      lineColor = {191, 0, 0}, 
      fillColor = {191, 0, 0}, 
      fillPattern = FillPattern.Solid), 
      Polygon(
      points = {{-12, 40}, {-12, 80}, {-10, 86}, {-6, 88}, {0, 90}, {6, 88}, {10, 86}, {
      12, 80}, {12, 40}, {-12, 40}}, 
      lineThickness = 0.5), 
      Line(
      points = {{-12, 40}, {-12, -64}}, 
      thickness = 0.5), 
      Line(
      points = {{12, 40}, {12, -64}}, 
      thickness = 0.5), 
      Line(points = {{-40, -20}, {-12, -20}}), 
      Line(points = {{-40, 20}, {-12, 20}}), 
      Line(points = {{-40, 60}, {-12, 60}}), 
      Line(points = {{12, 0}, {60, 0}}, color = {0, 0, 127})}), 
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Ellipse(
      extent = {{-20, -88}, {20, -50}}, 
      lineThickness = 0.5, 
      fillColor = {191, 0, 0}, 
      fillPattern = FillPattern.Solid), 
      Rectangle(
      extent = {{-12, 50}, {12, -58}}, 
      lineColor = {191, 0, 0}, 
      fillColor = {191, 0, 0}, 
      fillPattern = FillPattern.Solid), 
      Polygon(
      points = {{-12, 50}, {-12, 90}, {-10, 96}, {-6, 98}, {0, 100}, {6, 98}, {10, 96}, {
      12, 90}, {12, 50}, {-12, 50}}, 
      lineThickness = 0.5), 
      Line(
      points = {{-12, 50}, {-12, -54}}, 
      thickness = 0.5), 
      Line(
      points = {{12, 50}, {12, -54}}, 
      thickness = 0.5), 
      Line(points = {{-40, -10}, {-12, -10}}), 
      Line(points = {{-40, 30}, {-12, 30}}), 
      Line(points = {{-40, 70}, {-12, 70}}), 
      Text(
      extent = {{126, -30}, {6, -60}}, 
      textString = "T"), 
      Text(
      extent = {{-150, 110}, {150, 150}}, 
      textString = "%name", 
      textColor = {0, 0, 255}), 
      Line(points = {{12, 0}, {60, 0}}, color = {0, 0, 127})}));
  end Temperature;

  model TemperatureTwoPort "理想的双接口温度传感器"
    extends Sensors.BaseClasses.PartialFlowSensor;

    Modelica.Blocks.Interfaces.RealOutput T(final quantity = "ThermodynamicTemperature", 
      final unit = "K", 
      min = 0, 
      displayUnit = "degC") 
      "通过流体的温度" 
      annotation(Placement(transformation(
      origin = {0, 110}, 
      extent = {{10, -10}, {-10, 10}}, 
      rotation = 270)));

  protected
    Medium.Temperature T_a_inflow "port_a 流入流体的温度";
    Medium.Temperature T_b_inflow 
      "port_b 处流入流体的温度或 T_a_inflow (若为单向流动)";
  equation
    if allowFlowReversal then
      T_a_inflow = Medium.temperature(Medium.setState_phX(port_b.p, port_b.h_outflow, port_b.Xi_outflow));
      T_b_inflow = Medium.temperature(Medium.setState_phX(port_a.p, port_a.h_outflow, port_a.Xi_outflow));
      T = Modelica.Fluid.Utilities.regStep(port_a.m_flow, T_a_inflow, T_b_inflow, m_flow_small);
    else
      T = Medium.temperature(Medium.setState_phX(port_b.p, port_b.h_outflow, port_b.Xi_outflow));
      T_a_inflow = T;
      T_b_inflow = T;
    end if;
    annotation(defaultComponentName = "temperature", 
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Line(points = {{0, 100}, {0, 50}}, color = {0, 0, 127}), 
      Line(points = {{-92, 0}, {100, 0}}, color = {0, 128, 255}), 
      Ellipse(
      extent = {{-20, -68}, {20, -30}}, 
      lineThickness = 0.5, 
      fillColor = {191, 0, 0}, 
      fillPattern = FillPattern.Solid), 
      Rectangle(
      extent = {{-12, 50}, {12, -34}}, 
      lineColor = {191, 0, 0}, 
      fillColor = {191, 0, 0}, 
      fillPattern = FillPattern.Solid), 
      Polygon(
      points = {{-12, 50}, {-12, 70}, {-10, 76}, {-6, 78}, {0, 80}, {6, 78}, {10, 76}, {
      12, 70}, {12, 50}, {-12, 50}}, 
      lineThickness = 0.5), 
      Line(
      points = {{-12, 50}, {-12, -35}}, 
      thickness = 0.5), 
      Line(
      points = {{12, 50}, {12, -34}}, 
      thickness = 0.5), 
      Line(points = {{-40, -10}, {-12, -10}}), 
      Line(points = {{-40, 20}, {-12, 20}}), 
      Line(points = {{-40, 50}, {-12, 50}}), 
      Text(
      extent = {{94, 122}, {0, 92}}, 
      textString = "T")}), 
      Documentation(info = "<html>
<p>
该组件可监测流体通过时的温度。该传感器是理想的，即不会影响流体。
</p>
</html>"  ));
  end TemperatureTwoPort;

  model SpecificEnthalpy "理想的单接口比焓传感器"
    extends Sensors.BaseClasses.PartialAbsoluteSensor;
    extends Modelica.Icons.RoundSensor;
    Modelica.Blocks.Interfaces.RealOutput h_out(final quantity = "SpecificEnergy", 
      final unit = "J/kg") 
      "接口介质的比焓" 
      annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));

  equation
    h_out = inStream(port.h_outflow);
    annotation(defaultComponentName = "specificEnthalpy", 
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Line(points = {{0, -70}, {0, -100}}, color = {0, 0, 127}), 
      Text(
      extent = {{-150, 80}, {150, 120}}, 
      textString = "%name", 
      textColor = {0, 0, 255}), 
      Text(
      extent = {{168, -30}, {52, -60}}, 
      textString = "h"), 
      Line(points = {{70, 0}, {100, 0}}, color = {0, 0, 127})}), 
      Documentation(info = "<html>
<p>
该组件可监测通过其接口的流体的比焓。 传感器是理想的，即不会影响流体。
</p>
</html>"  ));
  end SpecificEnthalpy;

  model SpecificEnthalpyTwoPort 
    "理想的双接口比焓传感器"
    extends Sensors.BaseClasses.PartialFlowSensor;
    extends Modelica.Icons.RoundSensor;
    Modelica.Blocks.Interfaces.RealOutput h_out(final quantity = "SpecificEnergy", 
      final unit = "J/kg") 
      "通过流体的比焓" 
      annotation(Placement(transformation(
      origin = {0, 110}, 
      extent = {{10, -10}, {-10, 10}}, 
      rotation = 270)));

  equation
    if allowFlowReversal then
      h_out = Modelica.Fluid.Utilities.regStep(port_a.m_flow, port_b.h_outflow, port_a.h_outflow, m_flow_small);
    else
      h_out = port_b.h_outflow;
    end if;
    annotation(defaultComponentName = "specificEnthalpy", 
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Text(
      extent = {{102, 120}, {0, 90}}, 
      textString = "h"), 
      Line(points = {{0, 100}, {0, 70}}, color = {0, 0, 127}), 
      Line(points = {{-100, 0}, {-70, 0}}, color = {0, 128, 255}), 
      Line(points = {{70, 0}, {100, 0}}, color = {0, 128, 255})}), 
      Documentation(info = "<html>
<p>
该组件可监测流体的比焓，传感器是理想的，即不会影响流体。
</p>
</html>"  ));
  end SpecificEnthalpyTwoPort;

  model SpecificEntropy "理想的单接口比熵传感器"
    extends Sensors.BaseClasses.PartialAbsoluteSensor;
    extends Modelica.Icons.RoundSensor;
    Modelica.Blocks.Interfaces.RealOutput s(final quantity = "SpecificEntropy", 
      final unit = "J/(kg.K)") 
      "接口介质的比熵" 
      annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));

  equation
    s = Medium.specificEntropy(Medium.setState_phX(port.p, inStream(port.h_outflow), inStream(port.Xi_outflow)));
    annotation(defaultComponentName = "specificEntropy", 
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Line(points = {{0, -70}, {0, -100}}, color = {0, 0, 127}), 
      Text(
      extent = {{-150, 80}, {150, 120}}, 
      textString = "%name", 
      textColor = {0, 0, 255}), 
      Text(
      extent = {{156, -24}, {54, -54}}, 
      textString = "s"), 
      Line(points = {{70, 0}, {100, 0}}, color = {0, 0, 127})}), 
      Documentation(info = "<html>
<p>
该组件可监测通过其接口的流体的比熵。该传感器是理想的，即不会影响流体。
</p>
</html>"  ));
  end SpecificEntropy;

  model SpecificEntropyTwoPort "理想的双接口比熵传感器"
    extends Sensors.BaseClasses.PartialFlowSensor;
    extends Modelica.Icons.RoundSensor;
    Modelica.Blocks.Interfaces.RealOutput s(final quantity = "SpecificEntropy", 
      final unit = "J/(kg.K)") 
      "通过流体的比熵" 
      annotation(Placement(transformation(
      origin = {0, 110}, 
      extent = {{10, -10}, {-10, 10}}, 
      rotation = 270)));

  protected
    Medium.SpecificEntropy s_a_inflow 
      "port_a 流入流体的比熵";
    Medium.SpecificEntropy s_b_inflow 
      "流入流体在 port_b 或 s_a_inflow 处的比熵 (若为单向流动)";
  equation
    if allowFlowReversal then
      s_a_inflow = Medium.specificEntropy(Medium.setState_phX(port_b.p, port_b.h_outflow, port_b.Xi_outflow));
      s_b_inflow = Medium.specificEntropy(Medium.setState_phX(port_a.p, port_a.h_outflow, port_a.Xi_outflow));
      s = Modelica.Fluid.Utilities.regStep(port_a.m_flow, s_a_inflow, s_b_inflow, m_flow_small);
    else
      s = Medium.specificEntropy(Medium.setState_phX(port_b.p, port_b.h_outflow, port_b.Xi_outflow));
      s_a_inflow = s;
      s_b_inflow = s;
    end if;
    annotation(defaultComponentName = "specificEntropy", 
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Text(
      extent = {{120, 120}, {0, 90}}, 
      textString = "s"), 
      Line(points = {{0, 100}, {0, 70}}, color = {0, 0, 127}), 
      Line(points = {{-100, 0}, {-70, 0}}, color = {0, 128, 255}), 
      Line(points = {{70, 0}, {100, 0}}, color = {0, 128, 255})}), 
      Documentation(info = "<html>
<p>
该组件可监测流体的比熵，传感器是理想的，即不会影响流体。
</p>
</html>"  ));
  end SpecificEntropyTwoPort;

  model MassFractions "理想的单接口质量分数传感器"
    extends Modelica.Fluid.Sensors.BaseClasses.PartialAbsoluteSensor;
    extends Modelica.Icons.RoundSensor;
    parameter String substanceName = "water" "质量分数名称";

    Modelica.Blocks.Interfaces.RealOutput Xi "接口介质的质量分数" 
      annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));

  protected
    parameter Integer ind(fixed = false) 
      "独立质量分数矢量中的物质指数";
    Medium.MassFraction XiVec[Medium.nXi] 
      "质量分数矢量，因为不支持运算符 inStream 的指数参数，所以需要该矢量";
  initial algorithm
    ind := -1;
    for i in 1:Medium.nXi loop
      if (Modelica.Utilities.Strings.isEqual(Medium.substanceNames[i], substanceName)) then
        ind := i;
      end if;
    end for;
    assert(ind > 0, "质量分数 '" + substanceName + "' 不存在于介质中 '" 
      + Medium.mediumName + "'.\n" 
      + "检查传感器参数和介质型号");
  equation
    XiVec = inStream(port.Xi_outflow);
    Xi = XiVec[ind];
    annotation(defaultComponentName = "massFraction", 
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Line(points = {{0, -70}, {0, -100}}, color = {0, 0, 127}), 
      Text(
      extent = {{-150, 80}, {150, 120}}, 
      textString = "%name", 
      textColor = {0, 0, 255}), 
      Text(
      extent = {{160, -30}, {60, -60}}, 
      textString = "Xi"), 
      Line(points = {{70, 0}, {100, 0}}, color = {0, 0, 127})}), 
      Documentation(info = "<html>
<p>
该组件可监测通过其接口的流体的质量分数。 传感器是理想的，即不会影响流体。
</p>
</html>"    , revisions = "<html>
<ul>
<li>2011-12-14: Stefan Wischhusen: 首次发布。</li>
</ul>
</html>"    ));
  end MassFractions;

  model MassFractionsTwoPort "理想的质量分数双接口传感器"
    extends Modelica.Fluid.Sensors.BaseClasses.PartialFlowSensor;
    extends Modelica.Icons.RoundSensor;
    Modelica.Blocks.Interfaces.RealOutput Xi "接口介质的质量分数" 
      annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, 
      rotation = 90, 
      origin = {0, 110}), iconTransformation(
      extent = {{-10, -10}, {10, 10}}, 
      rotation = 90, 
      origin = {0, 110})));
    parameter String substanceName = "water" "质量分数名称";

  protected
    parameter Integer ind(fixed = false) 
      "独立质量分数矢量中的物质指数";
  initial algorithm
    ind := -1;
    for i in 1:Medium.nXi loop
      if (Modelica.Utilities.Strings.isEqual(Medium.substanceNames[i], substanceName)) then
        ind := i;
      end if;
    end for;
    assert(ind > 0, "质量分数 '" + substanceName + "' 不存在于介质中 '" 
      + Medium.mediumName + "'.\n" 
      + "检查传感器参数和介质型号");
  equation
    if allowFlowReversal then
      Xi = Modelica.Fluid.Utilities.regStep(port_a.m_flow, port_b.Xi_outflow[ind], port_a.Xi_outflow[ind], m_flow_small);
    else
      Xi = port_b.Xi_outflow[ind];
    end if;
    annotation(defaultComponentName = "massFraction", 
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Text(
      extent = {{82, 122}, {0, 92}}, 
      textString = "Xi"), 
      Line(points = {{0, 100}, {0, 70}}, color = {0, 0, 127}), 
      Line(points = {{-100, 0}, {-70, 0}}, color = {0, 128, 255}), 
      Line(points = {{70, 0}, {100, 0}}, color = {0, 128, 255})}), 
      Documentation(info = "<html>
<p>
该组件可监测流体通过时的质量分数。该传感器是理想的，即不会影响流体。
</p> </html>"    , revisions = "<html>
<ul>
<li>2011-12-14: Stefan Wischhusen: 首次发布。</li>
<li>2018-01-04: Stefan Wischhusen: 更正了访问命名物质时出现的故障。</li>
</ul>
</html>"    ));
  end MassFractionsTwoPort;

  model TraceSubstances "理想的单接口微量物质传感器"
    extends Sensors.BaseClasses.PartialAbsoluteSensor;
    extends Modelica.Icons.RoundSensor;
    parameter String substanceName = "CO2" "微量物质名称";

    Modelica.Blocks.Interfaces.RealOutput C "接口介质中的微量物质" 
      annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));

  protected
    parameter Integer ind(fixed = false) 
      "辅助物质矢量中的物质指数";
    Medium.ExtraProperty CVec[Medium.nC](
      quantity = Medium.extraPropertiesNames) 
      "微量物质矢量，因为不支持运算符 inStream 的指数参数，所以需要该矢量";
  initial algorithm
    ind := -1;
    for i in 1:Medium.nC loop
      if (Modelica.Utilities.Strings.isEqual(Medium.extraPropertiesNames[i], substanceName)) then
        ind := i;
      end if;
    end for;
    assert(ind > 0, "微量物质 '" + substanceName + "' 不存在于介质中 '" 
      + Medium.mediumName + "'.\n" 
      + "检查传感器参数和介质型号");
  equation
    CVec = inStream(port.C_outflow);
    C = CVec[ind];
    annotation(defaultComponentName = "traceSubstance", 
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Line(points = {{0, -70}, {0, -100}}, color = {0, 0, 127}), 
      Text(
      extent = {{-150, 80}, {150, 120}}, 
      textString = "%name", 
      textColor = {0, 0, 255}), 
      Text(
      extent = {{160, -30}, {60, -60}}, 
      textString = "C"), 
      Line(points = {{70, 0}, {100, 0}}, color = {0, 0, 127})}), 
      Documentation(info = "<html>
<p>
该组件可监测通过其接口的流体所含的微量物质。该传感器是理想的，即不会影响流体。
</p>
</html>"    ));
  end TraceSubstances;

  model TraceSubstancesTwoPort "适用于微量物质的理想双接口传感器"
    extends Sensors.BaseClasses.PartialFlowSensor;
    extends Modelica.Icons.RoundSensor;
    Modelica.Blocks.Interfaces.RealOutput C 
      "流体中的微量物质" 
      annotation(Placement(transformation(
      origin = {0, 110}, 
      extent = {{10, -10}, {-10, 10}}, 
      rotation = 270)));
    parameter String substanceName = "CO2" "微量物质名称";

  protected
    parameter Integer ind(fixed = false) 
      "辅助物质矢量中的物质指数";
  initial algorithm
    ind := -1;
    for i in 1:Medium.nC loop
      if (Modelica.Utilities.Strings.isEqual(Medium.extraPropertiesNames[i], substanceName)) then
        ind := i;
      end if;
    end for;
    assert(ind > 0, "微量物质 '" + substanceName + "' 不存在于介质中 '" 
      + Medium.mediumName + "'.\n" 
      + "检查传感器参数和介质型号");
  equation
    if allowFlowReversal then
      C = Modelica.Fluid.Utilities.regStep(port_a.m_flow, port_b.C_outflow[ind], port_a.C_outflow[ind], m_flow_small);
    else
      C = port_b.C_outflow[ind];
    end if;
    annotation(defaultComponentName = "traceSubstance", 
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Text(
      extent = {{82, 122}, {0, 92}}, 
      textString = "C"), 
      Line(points = {{0, 100}, {0, 70}}, color = {0, 0, 127}), 
      Line(points = {{-100, 0}, {-70, 0}}, color = {0, 128, 255}), 
      Line(points = {{70, 0}, {100, 0}}, color = {0, 128, 255})}), 
      Documentation(info = "<html>
<p>
该组件可监测流体中的微量物质。 传感器是理想的，即不会影响流体。
</p>
</html>"      ));
  end TraceSubstancesTwoPort;

  model MassFlowRate "理想的质量流量传感器"
    extends Sensors.BaseClasses.PartialFlowSensor;
    extends Modelica.Icons.RoundSensor;
    Modelica.Blocks.Interfaces.RealOutput m_flow(quantity = "MassFlowRate", 
      final unit = "kg/s") 
      "从 port_a 到 port_b 的质量流量" annotation(Placement(
      transformation(
      origin = {0, 110}, 
      extent = {{10, -10}, {-10, 10}}, 
      rotation = 270)));

  equation
    m_flow = port_a.m_flow;
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Line(points = {{70, 0}, {100, 0}}, color = {0, 128, 255}), 
      Text(
      extent = {{162, 120}, {2, 90}}, 
      textString = "m_flow"), 
      Line(points = {{0, 100}, {0, 70}}, color = {0, 0, 127}), 
      Line(points = {{-100, 0}, {-70, 0}}, color = {0, 128, 255})}), 
      Documentation(info = "<html>
<p>
该组件监测从 port_a 流向 port_b 的质量流量。该传感器是理想的，即不会影响流体。
</p>
</html>"  ));
  end MassFlowRate;

  model VolumeFlowRate "理想的体积流量传感器"
    extends Sensors.BaseClasses.PartialFlowSensor;
    extends Modelica.Icons.RoundSensor;
    Modelica.Blocks.Interfaces.RealOutput V_flow(final quantity = "VolumeFlowRate", 
      final unit = "m3/s") 
      "从 port_a 到 port_b 的体积流量" 
      annotation(Placement(transformation(
      origin = {0, 110}, 
      extent = {{10, -10}, {-10, 10}}, 
      rotation = 270)));

  protected
    Medium.Density rho_a_inflow "port_a 流入流体的密度";
    Medium.Density rho_b_inflow 
      "port_b 处流入流体的密度或 rho_a_inflow（若为单向流动）";
    Medium.Density d "通过流体的密度";
  equation
    if allowFlowReversal then
      rho_a_inflow = Medium.density(Medium.setState_phX(port_b.p, port_b.h_outflow, port_b.Xi_outflow));
      rho_b_inflow = Medium.density(Medium.setState_phX(port_a.p, port_a.h_outflow, port_a.Xi_outflow));
      d = Modelica.Fluid.Utilities.regStep(port_a.m_flow, rho_a_inflow, rho_b_inflow, m_flow_small);
    else
      d = Medium.density(Medium.setState_phX(port_b.p, port_b.h_outflow, port_b.Xi_outflow));
      rho_a_inflow = d;
      rho_b_inflow = d;
    end if;
    V_flow = port_a.m_flow / d;
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Text(
      extent = {{160, 120}, {0, 90}}, 
      textString = "V_flow"), 
      Line(points = {{0, 100}, {0, 70}}, color = {0, 0, 127}), 
      Line(points = {{-100, 0}, {-70, 0}}, color = {0, 128, 255}), 
      Line(points = {{70, 0}, {100, 0}}, color = {0, 128, 255})}), 
      Documentation(info = "<html>
<p>
该组件用于监测从 port_a 流向 port_b 的体积流量。该传感器是理想的，即不会影响流体。
</p>
</html>"  ));
  end VolumeFlowRate;

  model RelativePressure "理想的相对压力传感器"
    extends Sensors.BaseClasses.PartialRelativeSensor;

    Modelica.Blocks.Interfaces.RealOutput p_rel(final quantity = "Pressure", 
      final unit = "Pa", 
      displayUnit = "bar") 
      "相对压力信号" annotation(Placement(transformation(
      origin = {0, -90}, 
      extent = {{10, -10}, {-10, 10}}, 
      rotation = 90)));
  equation

    // 相对压力
    p_rel = port_a.p - port_b.p;
    annotation(
      Icon(graphics = {
      Line(points = {{0, -30}, {0, -80}}, color = {0, 0, 127}), 
      Text(
      extent = {{130, -70}, {4, -100}}, 
      textString = "p_rel")}), 
      Documentation(info = "<html>
<p>
该组件确定两个接口之间的相对压力 （\"port_a.p - port_b.p\"），并作为输出信号提供。
该传感器应与其他设备并联，不允许有水流通。
</p>
</html>"  ));
  end RelativePressure;

  model RelativeTemperature "理想的相对温度传感器"
    extends Sensors.BaseClasses.PartialRelativeSensor;

    Modelica.Blocks.Interfaces.RealOutput T_rel(final quantity = "ThermodynamicTemperature", 
      final unit = "K", displayUnit = "degC", min = 0) 
      "相对温度信号" annotation(Placement(
      transformation(
      origin = {0, -90}, 
      extent = {{10, -10}, {-10, 10}}, 
      rotation = 90)));
  equation
    // 相对温度
    T_rel = Medium.temperature(Medium.setState_phX(port_a.p, inStream(port_a.h_outflow), inStream(port_a.Xi_outflow))) - 
      Medium.temperature(Medium.setState_phX(port_b.p, inStream(port_b.h_outflow), inStream(port_b.Xi_outflow)));
    annotation(
      Icon(graphics = {
      Line(points = {{0, -30}, {0, -80}}, color = {0, 0, 127}), 
      Text(
      extent = {{128, -70}, {10, -100}}, 
      textString = "T_rel")}), 
      Documentation(info = "<html>
<p>
该组件确定两个接口之间的相对温度 （\"T(port_a) - T(port_b)\"），并作为输出信号提供。
该传感器应与其他设备并联，不允许有水流通。
</p>
</html>"  ));
  end RelativeTemperature;

  package BaseClasses 
    "传感器库中使用的基础类（只用于构建新组件模型）"
    extends Modelica.Icons.BasesPackage;

    partial model PartialAbsoluteSensor 
      "基类组件，用于对测量潜在变量的传感器进行建模"

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium 
        "传感器中的介质" 
        annotation(choicesAllMatching = true);

      Modelica.Fluid.Interfaces.FluidPort_a port(redeclare package Medium = Medium, m_flow(min = 0)) 
        annotation(Placement(transformation(
        origin = {0, -100}, 
        extent = {{-10, -10}, {10, 10}}, 
        rotation = 90)));

    equation
      port.m_flow = 0;
      port.h_outflow = Medium.h_default;
      port.Xi_outflow = Medium.X_default[1:Medium.nXi];
      port.C_outflow = zeros(Medium.nC);
      annotation(Documentation(info = "<html>
<p>
用于建立<strong>绝对传感器</strong>模型的基类组件。可用于压力传感器模型。
不建议用于温度或密度等其他属性的传感器，因为根据连接拓扑结构的不同，连接器处的焓值可能有不同的含义，
如果需要请使用 <code>PartialFlowSensor</code> 。
</p>
</html>"        ));
    end PartialAbsoluteSensor;

    model PartialRelativeSensor 
      "基类组件，用于对测量两个变量之间差值的传感器进行建模"
      extends Modelica.Icons.RectangularSensor;
      replaceable package Medium = 
        Modelica.Media.Interfaces.PartialMedium "传感器中的介质" annotation(
        choicesAllMatching = true);

      Modelica.Fluid.Interfaces.FluidPort_a port_a(m_flow(min = 0), 
      redeclare package Medium = Medium) 
        annotation(Placement(transformation(extent = {{-110, -10}, {-90, 10}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b(m_flow(min = 0), 
      redeclare package Medium = Medium) 
        annotation(Placement(transformation(extent = {{110, -12}, {90, 8}}), iconTransformation(extent = {{110, -10}, {90, 10}})));

    equation
      // 连接器的零流量方程
      port_a.m_flow = 0;
      port_b.m_flow = 0;

      // 无具体量的方程
      port_a.h_outflow = Medium.h_default;
      port_b.h_outflow = Medium.h_default;
      port_a.Xi_outflow = Medium.X_default[1:Medium.nXi];
      port_b.Xi_outflow = Medium.X_default[1:Medium.nXi];
      port_a.C_outflow = zeros(Medium.nC);
      port_b.C_outflow = zeros(Medium.nC);

      annotation(
        Icon(graphics = {
        Line(points = {{-100, 0}, {-70, 0}}, color = {0, 127, 255}), 
        Line(points = {{70, 0}, {100, 0}}, color = {0, 127, 255}), 
        Text(
        extent = {{-150, 40}, {150, 80}}, 
        textString = "%name", 
        textColor = {0, 0, 255}), 
        Line(
        points = {{32, 3}, {-58, 3}}, 
        color = {0, 128, 255}), 
        Polygon(
        points = {{22, 18}, {62, 3}, {22, -12}, {22, 18}}, 
        lineColor = {0, 128, 255}, 
        fillColor = {0, 128, 255}, 
        fillPattern = FillPattern.Solid)}), 
        Documentation(info = "<html>
<p>
确定该组件的两个接口之间的相对压力 \"port_a.p - port_b.p\"，并作为输出信号提供。
传感器应与其他设备并联，不允许有液体流过。
</p>
</html>"    ));
    end PartialRelativeSensor;

    partial model PartialFlowSensor 
      "基类组件，用于对测量流量特性的传感器进行建模"
      extends Modelica.Fluid.Interfaces.PartialTwoPort;

      parameter Medium.MassFlowRate m_flow_nominal = system.m_flow_nominal 
        "m_flow 的额定值 = port_a.m_flow" 
        annotation(Dialog(tab = "高级"));
      parameter Medium.MassFlowRate m_flow_small(min = 0) = if system.use_eps_Re then system.eps_m_flow * m_flow_nominal else system.m_flow_small 
        "对 |m_flow| < m_flow_small 区域内的双向流进行正则化（要求 m_flow_small > 0）" 
        annotation(Dialog(tab = "高级"));

    equation
      // 质量平衡
      0 = port_a.m_flow + port_b.m_flow;

      // 动量方程（无压力损失）
      port_a.p = port_b.p;

      // 等焓态转化（无能量储存，无能量损失）
      port_a.h_outflow = inStream(port_b.h_outflow);
      port_b.h_outflow = inStream(port_a.h_outflow);

      port_a.Xi_outflow = inStream(port_b.Xi_outflow);
      port_b.Xi_outflow = inStream(port_a.Xi_outflow);

      port_a.C_outflow = inStream(port_b.C_outflow);
      port_b.C_outflow = inStream(port_a.C_outflow);
      annotation(Documentation(info = "<html>
<p>
基类组件，用于为<strong>传感器</strong>建模，该传感器可测量流动的任何强度性质，例如，获取流体连接器之间流动的温度或密度。 
该模型包括零体积平衡方程。继承该基类的传感器模型应添加一个介质模型，以计算所测量的属性。
</p>
</html>"            ));
    end PartialFlowSensor;
    annotation();

  end BaseClasses;
  annotation(preferredView = "info", Documentation(info = "<html>
<p>
传感器库由理想化的<strong>传感器</strong>组件组成，可提供介质模型变量、流体接口输出信号。
这些信号可通过 Modelica.Blocks 库的组件进行进一步处理。
此外，还可以通过进一步处理（例如，通过附加模型块 Modelica.Blocks.FirstOrder，对传感器的时间常数进行建模），建立更真实的传感器模型。
</p>

<p>
对于热力学状态变量温度、比焓、比熵和密度，流体库提供了两种不同类型的传感器：<strong>普通单接口</strong>传感器和<strong>双接口</strong>传感器。</p>

<ul>
<li>
普通<strong>单接口</strong>传感器的优点是无需断开连接，易于从模型中引入和移除。一个潜在的缺点是，获得的数值会随着流量的变化而跳跃。
</li>

<li>
<strong>双接口</strong>传感器的优点是可以调整零流量附近的正则阶跃函数。此外，如果 allowFlowReversal = false，则得到的结果仅限于流入port_a 的值。
</li>
</ul>

<p>
<a href=\"modelica://Modelica.Fluid.Examples.Explanatory.MeasuringTemperature\">Modelica.Fluid.Examples.Explanatory.MeasuringTemperature</a>
通过一个简单的例子展示了单接口和双接口传感器之间的区别。
</p>
</html>", revisions = "<html>
<ul>
<li><em>22 Dec 2008</em>
    by R;uumldiger Franke<br>
    <ul>
    <li>基于 Interfaces.PartialTwoPort 的流量传感器</li>
    <li>将文档改编为流连接器，即减少对两个接口传感器的需求</li>
    </ul>
    </li>
<li><em>4 Dec 2008</em>
    by Michael Wetter<br>
       包括微量物质传感器</li>
<li><em>31 Oct 2007</em>
    by Carsten Heinrich<br>
       更新了传感器模型，包括用于热力学状态变量的单接口和双接口传感器</li>
</ul>
</html>"));
end Sensors;