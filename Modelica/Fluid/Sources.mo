within Modelica.Fluid;
package Sources "定义固定或规定的边界条件"
  extends Modelica.Icons.SourcesPackage;
  model FixedBoundary "边界组件"
    import Modelica.Media.Interfaces.Choices.IndependentVariables;
    extends Sources.BaseClasses.PartialSource;
    parameter Boolean use_p = true "选择 p 或 d" 
      annotation(Evaluate = true, 
      Dialog(group = "边界压力或边界密度"));
    parameter Medium.AbsolutePressure p = Medium.p_default "边界压力" 
      annotation(Dialog(group = "边界压力或边界密度", 
      enable = use_p));
    parameter Medium.Density d = 
      (if use_T then Medium.density_pTX(
      Medium.p_default, Medium.T_default, Medium.X_default) 
      else Medium.density_phX(
      Medium.p_default, Medium.h_default, Medium.X_default)) 
      "边界密度" 
      annotation(Dialog(group = "边界压力或边界密度", 
      enable = not use_p));
    parameter Boolean use_T = true "选择 T 或 h" 
      annotation(Evaluate = true, 
      Dialog(group = "边界温度或边界比焓"));
    parameter Medium.Temperature T = Medium.T_default "边界温度" 
      annotation(Dialog(group = "边界温度或边界比焓", 
      enable = use_T));
    parameter Medium.SpecificEnthalpy h = Medium.h_default 
      "边界比焓" 
      annotation(Dialog(group = "边界温度或边界比焓", 
      enable = not use_T));
    parameter Medium.MassFraction X[Medium.nX](
      quantity = Medium.substanceNames) = Medium.X_default 
      "边界质量分数 m_i/m" 
      annotation(Dialog(group = "仅适用于多物质流", enable = Medium.nXi > 0));
    parameter Medium.ExtraProperty C[Medium.nC](
      quantity = Medium.extraPropertiesNames) = Medium.C_default 
      "边界微量物质" 
      annotation(Dialog(group = "仅用于微量物质流", enable = Medium.nC > 0));
  protected
    Medium.ThermodynamicState state;
  equation
    Modelica.Fluid.Utilities.checkBoundary(Medium.mediumName, Medium.substanceNames, 
      Medium.singleState, use_p, X, 
      "固定边界");
    if use_p or Medium.singleState then
      // p 给定
      if use_T then
        // p,T,X given
        state = Medium.setState_pTX(p, T, X);
      else
        // p,h,X 给定
        state = Medium.setState_phX(p, h, X);
      end if;

      if Medium.ThermoStates == IndependentVariables.dTX then
        medium.d = Medium.density(state);
      else
        medium.p = Medium.pressure(state);
      end if;

      if Medium.ThermoStates == IndependentVariables.ph or 
        Medium.ThermoStates == IndependentVariables.phX then
        medium.h = Medium.specificEnthalpy(state);
      else
        medium.T = Medium.temperature(state);
      end if;

    else
      // d 给定
      if use_T then
        // d,T,X 给定
        state = Medium.setState_dTX(d, T, X);

        if Medium.ThermoStates == IndependentVariables.dTX then
          medium.d = Medium.density(state);
        else
          medium.p = Medium.pressure(state);
        end if;

        if Medium.ThermoStates == IndependentVariables.ph or 
          Medium.ThermoStates == IndependentVariables.phX then
          medium.h = Medium.specificEnthalpy(state);
        else
          medium.T = Medium.temperature(state);
        end if;

      else
        // d,h,X 给定
        medium.d = d;
        medium.h = h;
        state = Medium.setState_dTX(d, T, X);
      end if;
    end if;

    medium.Xi = X[1:Medium.nXi];

    ports.C_outflow = fill(C, nPorts);
    annotation(defaultComponentName = "boundary", 
      Icon(coordinateSystem(
      preserveAspectRatio = false, 
      extent = {{-100, -100}, {100, 100}}), graphics = {Ellipse(
      extent = {{-100, 100}, {100, -100}}, 
      fillPattern = FillPattern.Sphere, 
      fillColor = {0, 127, 255}), Text(
      extent = {{-150, 110}, {150, 150}}, 
      textString = "%name", 
      textColor = {0, 0, 255})}), 
      Documentation(info = "<html>
<p>
模型 <strong>FixedBoundary</strong> 定义了边界条件的常量值：
</p>
<ul>
<li> 边界压力或边界密度。</li>
<li> 边界温度或边界比焓。</li>
<li> 边界成分（仅适用于多物质或微量物质流动）。</li>
</ul>
<p>
注意，边界温度、密度、比焓、质量分数和微量物质仅在质量流量从边界流向接口时才有效。如果质量从接口流向边界，除了边界压力之外，边界定义没有效果。
</p>

</html>"  ));
  end FixedBoundary;

  model Boundary_pT 
    "具有规定压力、温度、成分和微量物质的边界"
    import Modelica.Media.Interfaces.Choices.IndependentVariables;

    extends Sources.BaseClasses.PartialSource;
    parameter Boolean use_p_in = false 
      "从输入接口获取压力" 
      annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
    parameter Boolean use_T_in = false 
      "从输入连接器获取温度" 
      annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
    parameter Boolean use_X_in = false 
      "从输入连接器获取成分" 
      annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
    parameter Boolean use_C_in = false 
      "从输入连接器获取微量物质" 
      annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
    parameter Medium.AbsolutePressure p = Medium.p_default 
      "压力的固定值" 
      annotation(Dialog(enable = not use_p_in));
    parameter Medium.Temperature T = Medium.T_default 
      "温度的固定值" 
      annotation(Dialog(enable = not use_T_in));
    parameter Medium.MassFraction X[Medium.nX] = Medium.X_default 
      "成分的固定值" 
      annotation(Dialog(enable = (not use_X_in) and Medium.nXi > 0));
    parameter Medium.ExtraProperty C[Medium.nC](
      quantity = Medium.extraPropertiesNames) = Medium.C_default 
      "微量物质的固定值" 
      annotation(Dialog(enable = (not use_C_in) and Medium.nC > 0));
    Modelica.Blocks.Interfaces.RealInput p_in(unit = "Pa") if use_p_in 
      "规定的边界压力" 
      annotation(Placement(transformation(extent = {{-140, 60}, {-100, 100}})));
    Modelica.Blocks.Interfaces.RealInput T_in(unit = "K") if use_T_in 
      "规定的边界温度" 
      annotation(Placement(transformation(extent = {{-140, 20}, {-100, 60}})));
    Modelica.Blocks.Interfaces.RealInput X_in[Medium.nX](each unit = "1") if use_X_in 
      "规定的边界成分" 
      annotation(Placement(transformation(extent = {{-140, -60}, {-100, -20}})));
    Modelica.Blocks.Interfaces.RealInput C_in[Medium.nC] if use_C_in 
      "规定边界微量物质" 
      annotation(Placement(transformation(extent = {{-140, -100}, {-100, -60}})));
  protected
    Modelica.Blocks.Interfaces.RealInput p_in_internal(unit = "Pa") 
      "需要连接条件连接器";
    Modelica.Blocks.Interfaces.RealInput T_in_internal(unit = "K") 
      "需要连接条件连接器";
    Modelica.Blocks.Interfaces.RealInput X_in_internal[Medium.nX](each unit = "1") 
      "需要连接条件连接器";
    Modelica.Blocks.Interfaces.RealInput C_in_internal[Medium.nC] 
      "需要连接条件连接器";
  equation
    Modelica.Fluid.Utilities.checkBoundary(Medium.mediumName, Medium.substanceNames, 
      Medium.singleState, true, X_in_internal, "Boundary_pT");
    connect(p_in, p_in_internal);
    connect(T_in, T_in_internal);
    connect(X_in, X_in_internal);
    connect(C_in, C_in_internal);
    if not use_p_in then
      p_in_internal = p;
    end if;
    if not use_T_in then
      T_in_internal = T;
    end if;
    if not use_X_in then
      X_in_internal = X;
    end if;
    if not use_C_in then
      C_in_internal = C;
    end if;
    medium.p = p_in_internal;
    if Medium.ThermoStates == IndependentVariables.ph or 
      Medium.ThermoStates == IndependentVariables.phX then
      medium.h = Medium.specificEnthalpy(Medium.setState_pTX(p_in_internal, T_in_internal, X_in_internal));
    else
      medium.T = T_in_internal;
    end if;
    medium.Xi = X_in_internal[1:Medium.nXi];
    ports.C_outflow = fill(C_in_internal, nPorts);
    annotation(defaultComponentName = "boundary", 
      Icon(coordinateSystem(
      preserveAspectRatio = false, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Ellipse(
      extent = {{-100, 100}, {100, -100}}, 
      fillPattern = FillPattern.Sphere, 
      fillColor = {0, 127, 255}), 
      Text(
      extent = {{-150, 120}, {150, 160}}, 
      textString = "%name", 
      textColor = {0, 0, 255}), 
      Line(
      visible = use_p_in, 
      points = {{-100, 80}, {-58, 80}}, 
      color = {0, 0, 255}), 
      Line(
      visible = use_T_in, 
      points = {{-100, 40}, {-92, 40}}, 
      color = {0, 0, 255}), 
      Line(
      visible = use_X_in, 
      points = {{-100, -40}, {-92, -40}}, 
      color = {0, 0, 255}), 
      Line(
      visible = use_C_in, 
      points = {{-100, -80}, {-60, -80}}, 
      color = {0, 0, 255}), 
      Text(
      visible = use_p_in, 
      extent = {{-152, 134}, {-68, 94}}, 
      textString = "p"), 
      Text(
      visible = use_X_in, 
      extent = {{-164, 4}, {-62, -36}}, 
      textString = "X"), 
      Text(
      visible = use_C_in, 
      extent = {{-164, -90}, {-62, -130}}, 
      textString = "C"), 
      Text(
      visible = use_T_in, 
      extent = {{-162, 34}, {-60, -6}}, 
      textString = "T")}), 
      Documentation(info = "<html>
<p>
定义边界条件的规定值：
</p>
<ul>
<li> 规定的边界压力。</li>
<li> 规定的边界温度。</li>
<li> 边界成分（仅适用于多物质流或微量物质流）。</li>
</ul>
<p>
如果 <code>use_p_in</code> 为 false（默认选项），则使用 <code>p</code> 参数作为边界压力，并禁用 <code>p_in</code> 输入连接器；
如果 <code>use_p_in</code> 为 true，则忽略 <code>p</code> 参数，并使用输入连接器提供的值。
</p>
<p>温度、成分和微量物质也是如此。</p>
<p>
请注意，只有当质量流从边界流入接口时，边界温度、质量分数和微量物质才会产生影响。
如果质量流从接口流入边界，则边界定义（边界压力除外）不会产生影响。
</p>
</html>"));
  end Boundary_pT;

  model Boundary_ph 
    "具有规定压力、比焓、成分和微量物质的边界"
    import Modelica.Media.Interfaces.Choices.IndependentVariables;
    extends Sources.BaseClasses.PartialSource;
    parameter Boolean use_p_in = false 
      "从输入连接器获取压力" 
      annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
    parameter Boolean use_h_in = false 
      "从输入连接器获取比焓" 
      annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
    parameter Boolean use_X_in = false 
      "从输入连接器中获取成分" 
      annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
    parameter Boolean use_C_in = false 
      "从输入连接器获取微量物质" 
      annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
    parameter Medium.AbsolutePressure p = Medium.p_default 
      "压力的固定值" 
      annotation(Dialog(enable = not use_p_in));
    parameter Medium.SpecificEnthalpy h = Medium.h_default 
      "比焓的固定值" 
      annotation(Dialog(enable = not use_h_in));
    parameter Medium.MassFraction X[Medium.nX] = Medium.X_default 
      "成分的固定值" 
      annotation(Dialog(enable = (not use_X_in) and Medium.nXi > 0));
    parameter Medium.ExtraProperty C[Medium.nC](
      quantity = Medium.extraPropertiesNames) = Medium.C_default 
      "微量物质的固定值" 
      annotation(Dialog(enable = (not use_C_in) and Medium.nC > 0));
    Modelica.Blocks.Interfaces.RealInput p_in(unit = "Pa") if use_p_in 
      "规定的边界压力" 
      annotation(Placement(transformation(extent = {{-140, 60}, {-100, 100}})));
    Modelica.Blocks.Interfaces.RealInput h_in(unit = "J/kg") if use_h_in 
      "规定边界比焓" 
      annotation(Placement(transformation(extent = {{-140, 20}, {-100, 60}})));
    Modelica.Blocks.Interfaces.RealInput X_in[Medium.nX](each unit = "1") if use_X_in 
      "规定的边界成分" 
      annotation(Placement(transformation(extent = {{-140, -60}, {-100, -20}})));
    Modelica.Blocks.Interfaces.RealInput C_in[Medium.nC] if use_C_in 
      "规定边界微量物质" 
      annotation(Placement(transformation(extent = {{-140, -100}, {-100, -60}})));
  protected
    Modelica.Blocks.Interfaces.RealInput p_in_internal(unit = "Pa") 
      "需要连接条件连接器";
    Modelica.Blocks.Interfaces.RealInput h_in_internal(unit = "J/kg") 
      "需要连接条件连接器";
    Modelica.Blocks.Interfaces.RealInput X_in_internal[Medium.nX](each unit = "1") 
      "需要连接条件连接器";
    Modelica.Blocks.Interfaces.RealInput C_in_internal[Medium.nC] 
      "需要连接条件连接器";
  equation
    Modelica.Fluid.Utilities.checkBoundary(Medium.mediumName, Medium.substanceNames, 
      Medium.singleState, true, X_in_internal, "Boundary_ph");
    connect(p_in, p_in_internal);
    connect(h_in, h_in_internal);
    connect(X_in, X_in_internal);
    connect(C_in, C_in_internal);
    if not use_p_in then
      p_in_internal = p;
    end if;
    if not use_h_in then
      h_in_internal = h;
    end if;
    if not use_X_in then
      X_in_internal = X;
    end if;
    if not use_C_in then
      C_in_internal = C;
    end if;
    medium.p = p_in_internal;
    if Medium.ThermoStates == IndependentVariables.ph or 
      Medium.ThermoStates == IndependentVariables.phX then
      medium.h = h_in_internal;
    else
      medium.T = Medium.temperature(Medium.setState_phX(p_in_internal, h_in_internal, X_in_internal));
    end if;
    medium.Xi = X_in_internal[1:Medium.nXi];
    ports.C_outflow = fill(C_in_internal, nPorts);
    annotation(defaultComponentName = "boundary", 
      Icon(coordinateSystem(
      preserveAspectRatio = false, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Ellipse(
      extent = {{-100, 100}, {100, -100}}, 
      fillPattern = FillPattern.Sphere, 
      fillColor = {0, 127, 255}), 
      Text(
      extent = {{-150, 110}, {150, 150}}, 
      textString = "%name", 
      textColor = {0, 0, 255}), 
      Line(
      visible = use_p_in, 
      points = {{-100, 80}, {-60, 80}}, 
      color = {0, 0, 255}), 
      Line(
      visible = use_h_in, 
      points = {{-100, 40}, {-92, 40}}, 
      color = {0, 0, 255}), 
      Line(
      visible = use_X_in, 
      points = {{-100, -40}, {-92, -40}}, 
      color = {0, 0, 255}), 
      Line(
      visible = use_C_in, 
      points = {{-100, -80}, {-60, -80}}, 
      color = {0, 0, 255}), 
      Text(
      visible = use_p_in, 
      extent = {{-150, 134}, {-72, 94}}, 
      textString = "p"), 
      Text(
      visible = use_h_in, 
      extent = {{-166, 34}, {-64, -6}}, 
      textString = "h"), 
      Text(
      visible = use_X_in, 
      extent = {{-164, 4}, {-62, -36}}, 
      textString = "X"), 
      Text(
      visible = use_C_in, 
      extent = {{-164, -90}, {-62, -130}}, 
      textString = "C")}), 
      Documentation(info = "<html>
<p>
定义边界条件的规定值：
</p>
<ul>
<li> 规定的边界压力。</li>
<li> 规定的边界温度。</li>
<li> 边界成分（仅适用于多物质流或微量物质流）。</li>
</ul>
<p>
如果 <code>use_p_in</code> 为 false（默认选项），则使用 <code>p</code> 参数作为边界压力，并禁用 <code>p_in</code> 输入连接器；
如果 <code>use_p_in</code> 为 true，则忽略 <code>p</code> 参数，并使用输入连接器提供的值。
</p>
<p>比焓和成分也是如此</p>
<p>
请注意，只有当质量流从边界流入接口时，边界温度、质量分数和微量物质才会产生影响。 
如果质量流从接口流入边界，则边界定义（边界压力除外）不会产生影响。
</p>
</html>"));
  end Boundary_ph;

  model MassFlowSource_T 
    "理想流动边界，可产生具有规定的温度、质量分数和微量物质的规定质量流量"
    import Modelica.Media.Interfaces.Choices.IndependentVariables;
    extends Sources.BaseClasses.PartialFlowSource;
    parameter Boolean use_m_flow_in = false 
      "从输入连接器获取质量流量" 
      annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
    parameter Boolean use_T_in = false 
      "从输入连接器获取温度" 
      annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
    parameter Boolean use_X_in = false 
      "从输入连接器获取成分" 
      annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
    parameter Boolean use_C_in = false 
      "从输入连接器获取微量物质" 
      annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
    parameter Medium.MassFlowRate m_flow = 0 
      "流体出口的固定质量流量" 
      annotation(Dialog(enable = not use_m_flow_in));
    parameter Medium.Temperature T = Medium.T_default 
      "温度的固定值" 
      annotation(Dialog(enable = not use_T_in));
    parameter Medium.MassFraction X[Medium.nX] = Medium.X_default 
      "成分的固定值" 
      annotation(Dialog(enable = (not use_X_in) and Medium.nXi > 0));
    parameter Medium.ExtraProperty C[Medium.nC](
      quantity = Medium.extraPropertiesNames) = Medium.C_default 
      "微量物质的固定值" 
      annotation(Dialog(enable = (not use_C_in) and Medium.nC > 0));
    Modelica.Blocks.Interfaces.RealInput m_flow_in(unit = "kg/s") if use_m_flow_in 
      "规定的质量流量" 
      annotation(Placement(transformation(extent = {{-120, 60}, {-80, 100}}), iconTransformation(extent = {{-120, 60}, {-80, 100}})));
    Modelica.Blocks.Interfaces.RealInput T_in(unit = "K") if use_T_in 
      "规定的流体温度" 
      annotation(Placement(transformation(extent = {{-140, 20}, {-100, 60}}), iconTransformation(extent = {{-140, 20}, {-100, 60}})));
    Modelica.Blocks.Interfaces.RealInput X_in[Medium.nX](each unit = "1") if use_X_in 
      "规定的流体成分" 
      annotation(Placement(transformation(extent = {{-140, -60}, {-100, -20}})));
    Modelica.Blocks.Interfaces.RealInput C_in[Medium.nC] if use_C_in 
      "规定边界微量物质" 
      annotation(Placement(transformation(extent = {{-120, -100}, {-80, -60}})));
  protected
    Modelica.Blocks.Interfaces.RealInput m_flow_in_internal(unit = "kg/s") 
      "需要连接条件连接器";
    Modelica.Blocks.Interfaces.RealInput T_in_internal(unit = "K") 
      "需要连接条件连接器";
    Modelica.Blocks.Interfaces.RealInput X_in_internal[Medium.nX](each unit = "1") 
      "需要连接条件连接器";
    Modelica.Blocks.Interfaces.RealInput C_in_internal[Medium.nC] 
      "需要连接条件连接器";
  equation
    Utilities.checkBoundary(Medium.mediumName, Medium.substanceNames, 
      Medium.singleState, true, X_in_internal, "MassFlowSource_T");
    connect(m_flow_in, m_flow_in_internal);
    connect(T_in, T_in_internal);
    connect(X_in, X_in_internal);
    connect(C_in, C_in_internal);
    if not use_m_flow_in then
      m_flow_in_internal = m_flow;
    end if;
    if not use_T_in then
      T_in_internal = T;
    end if;
    if not use_X_in then
      X_in_internal = X;
    end if;
    if not use_C_in then
      C_in_internal = C;
    end if;
    if Medium.ThermoStates == IndependentVariables.ph or 
      Medium.ThermoStates == IndependentVariables.phX then
      medium.h = Medium.specificEnthalpy(Medium.setState_pTX(medium.p, T_in_internal, X_in_internal));
    else
      medium.T = T_in_internal;
    end if;
    sum(ports.m_flow) = -m_flow_in_internal;
    medium.Xi = X_in_internal[1:Medium.nXi];
    ports.C_outflow = fill(C_in_internal, nPorts);
    annotation(defaultComponentName = "boundary", 
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Rectangle(
      extent = {{35, 45}, {100, -45}}, 
      fillPattern = FillPattern.HorizontalCylinder, 
      fillColor = {0, 127, 255}), 
      Ellipse(
      extent = {{-100, 80}, {60, -80}}, 
      lineColor = {0, 0, 255}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid), 
      Polygon(
      points = {{-60, 70}, {60, 0}, {-60, -68}, {-60, 70}}, 
      lineColor = {0, 0, 255}, 
      fillColor = {0, 0, 255}, 
      fillPattern = FillPattern.Solid), 
      Text(
      extent = {{-54, 32}, {16, -30}}, 
      textColor = {255, 0, 0}, 
      textString = "m"), 
      Text(
      extent = {{-150, 130}, {150, 170}}, 
      textString = "%name", 
      textColor = {0, 0, 255}), 
      Ellipse(
      extent = {{-26, 30}, {-18, 22}}, 
      lineColor = {255, 0, 0}, 
      fillColor = {255, 0, 0}, 
      fillPattern = FillPattern.Solid), 
      Text(
      visible = use_m_flow_in, 
      extent = {{-185, 132}, {-45, 100}}, 
      textString = "m_flow"), 
      Text(
      visible = use_T_in, 
      extent = {{-111, 71}, {-71, 37}}, 
      textString = "T"), 
      Text(
      visible = use_X_in, 
      extent = {{-153, -44}, {-33, -72}}, 
      textString = "X"), 
      Text(
      visible = use_C_in, 
      extent = {{-155, -98}, {-35, -126}}, 
      textString = "C")}), 
      Documentation(info = "<html>
<p>
模拟理想的流动边界，具有规定的流速、温度、成分和微量物质值：
</p>
<ul>
<li> 规定的质量流量</li>
<li> 规定温度</li>
<li> 边界成分（仅适用于多物质流或微量物质流）</li>
</ul>
<p>
如果 <code>use_m_flow_in</code> 为 false（默认选项），则使用 <code>m_flow</code> 参数作为边界压力，并禁用 <code>m_flow_in</code> 输入连接器；
如果 <code>m_flow_in</code> 为 true，则忽略 <code>m_flow</code> 参数，并使用输入连接器提供的值。
<p>温度和成分也是如此</p>
<p>
请注意，边界温度、质量分数和微量物质只有在质量流从边界流向接口时才有影响。
如果质量流从接口流入边界，则边界定义（边界流速除外）不会产生影响。
</p>
</html>"));
  end MassFlowSource_T;

  model MassFlowSource_h 
    "理想流动边界，可产生具有规定的比焓、质量分数和微量物质的规定质量流量"
    import Modelica.Media.Interfaces.Choices.IndependentVariables;
    extends Sources.BaseClasses.PartialFlowSource;
    parameter Boolean use_m_flow_in = false 
      "从输入连接器获取质量流量" 
      annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
    parameter Boolean use_h_in = false 
      "从输入连接器获取比热" 
      annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
    parameter Boolean use_X_in = false 
      "从输入连接器获取成分" 
      annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
    parameter Boolean use_C_in = false 
      "从输入连接器获取微量物质" 
      annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
    parameter Medium.MassFlowRate m_flow = 0 
      "流体出口的固定质量流量" 
      annotation(Dialog(enable = not use_m_flow_in));
    parameter Medium.SpecificEnthalpy h = Medium.h_default 
      "比焓的固定值" 
      annotation(Dialog(enable = not use_h_in));
    parameter Medium.MassFraction X[Medium.nX] = Medium.X_default 
      "成分的固定值" 
      annotation(Dialog(enable = (not use_X_in) and Medium.nXi > 0));
    parameter Medium.ExtraProperty C[Medium.nC](
      quantity = Medium.extraPropertiesNames) = Medium.C_default 
      "微量物质的固定值" 
      annotation(Dialog(enable = (not use_C_in) and Medium.nC > 0));
    Modelica.Blocks.Interfaces.RealInput m_flow_in(unit = "kg/s") if use_m_flow_in 
      "规定的质量流量" 
      annotation(Placement(transformation(extent = {{-120, 60}, {-80, 100}})));
    Modelica.Blocks.Interfaces.RealInput h_in(unit = "J/kg") if use_h_in 
      "规定的流体比热" 
      annotation(Placement(transformation(extent = {{-140, 20}, {-100, 60}}), iconTransformation(extent = {{-140, 20}, {-100, 60}})));
    Modelica.Blocks.Interfaces.RealInput X_in[Medium.nX](each unit = "1") if use_X_in 
      "规定的流体成分" 
      annotation(Placement(transformation(extent = {{-140, -60}, {-100, -20}})));
    Modelica.Blocks.Interfaces.RealInput C_in[Medium.nC] if use_C_in 
      "规定边界微量物质" 
      annotation(Placement(transformation(extent = {{-120, -100}, {-80, -60}}), iconTransformation(extent = {{-120, -100}, {-80, -60}})));
  protected
    Modelica.Blocks.Interfaces.RealInput m_flow_in_internal(unit = "kg/s") 
      "需要连接条件连接器";
    Modelica.Blocks.Interfaces.RealInput h_in_internal(unit = "J/kg") 
      "需要连接条件连接器";
    Modelica.Blocks.Interfaces.RealInput X_in_internal[Medium.nX](each unit = "1") 
      "需要连接条件连接器";
    Modelica.Blocks.Interfaces.RealInput C_in_internal[Medium.nC] 
      "需要连接条件连接器";
  equation
    Utilities.checkBoundary(Medium.mediumName, Medium.substanceNames, 
      Medium.singleState, true, X_in_internal, "MassFlowSource_h");
    connect(m_flow_in, m_flow_in_internal);
    connect(h_in, h_in_internal);
    connect(X_in, X_in_internal);
    connect(C_in, C_in_internal);
    if not use_m_flow_in then
      m_flow_in_internal = m_flow;
    end if;
    if not use_h_in then
      h_in_internal = h;
    end if;
    if not use_X_in then
      X_in_internal = X;
    end if;
    if not use_C_in then
      C_in_internal = C;
    end if;
    if Medium.ThermoStates == IndependentVariables.ph or 
      Medium.ThermoStates == IndependentVariables.phX then
      medium.h = h_in_internal;
    else
      medium.T = Medium.temperature(Medium.setState_phX(medium.p, h_in_internal, X_in_internal));
    end if;
    sum(ports.m_flow) = -m_flow_in_internal;
    medium.Xi = X_in_internal[1:Medium.nXi];
    ports.C_outflow = fill(C_in_internal, nPorts);
    annotation(defaultComponentName = "boundary", 
      Icon(coordinateSystem(
      preserveAspectRatio = false, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Rectangle(
      extent = {{36, 45}, {100, -45}}, 
      fillPattern = FillPattern.HorizontalCylinder, 
      fillColor = {0, 127, 255}), 
      Ellipse(
      extent = {{-100, 80}, {60, -80}}, 
      lineColor = {0, 0, 255}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid), 
      Polygon(
      points = {{-60, 70}, {60, 0}, {-60, -68}, {-60, 70}}, 
      lineColor = {0, 0, 255}, 
      fillColor = {0, 0, 255}, 
      fillPattern = FillPattern.Solid), 
      Text(
      extent = {{-54, 32}, {16, -30}}, 
      textColor = {255, 0, 0}, 
      textString = "m"), 
      Ellipse(
      extent = {{-26, 30}, {-18, 22}}, 
      lineColor = {255, 0, 0}, 
      fillColor = {255, 0, 0}, 
      fillPattern = FillPattern.Solid), 
      Text(
      visible = use_m_flow_in, 
      extent = {{-185, 132}, {-45, 100}}, 
      textString = "m_flow"), 
      Text(
      visible = use_h_in, 
      extent = {{-113, 72}, {-73, 38}}, 
      textString = "h"), 
      Text(
      visible = use_X_in, 
      extent = {{-153, -44}, {-33, -72}}, 
      textString = "X"), 
      Text(
      visible = use_X_in, 
      extent = {{-155, -98}, {-35, -126}}, 
      textString = "C"), 
      Text(
      extent = {{-150, 110}, {150, 150}}, 
      textString = "%name", 
      textColor = {0, 0, 255})}), 
      Documentation(info = "<html>
<p>
模拟理想的流动边界，具有规定的流速、温度和成分值：
</p>
<ul>
<li> 规定的质量流量</li>
<li> 规定比焓</li>
<li> 边界成分（仅适用于多物质流或微量物质流）</li>
</ul>
<p>
如果 <code>use_m_flow_in</code> 为 false（默认选项），则使用 <code>m_flow</code> 参数作为边界压力，并禁用 <code>m_flow_in</code> 输入连接器；
如果 <code>m_flow_in</code> 为 true，则忽略 <code>m_flow</code> 参数，并使用输入连接器提供的值。
<p>温度和成分也是如此</p>
<p>
请注意，边界温度、质量分数和微量物质只有在质量流从边界流向接口时才有影响。
如果质量流从接口流入边界，则边界定义（边界流速除外）不会产生影响。
</p>
</html>"));
  end MassFlowSource_h;

  package BaseClasses 
    "边界库的基类 (只用于建立新的组件模型)"
    extends Modelica.Icons.BasesPackage;
    partial model PartialSource 
      "带一个流体连接器的边界基类组件"
      import Modelica.Constants;

      parameter Integer nPorts = 0 "接口数" annotation(Dialog(connectorSizing = true));

      replaceable package Medium = 
        Modelica.Media.Interfaces.PartialMedium 
        "边界内的介质模型" 
        annotation(choicesAllMatching = true);

      Medium.BaseProperties medium "边界内的介质";

      Interfaces.FluidPorts_b ports[nPorts](
      redeclare each package Medium = Medium, 
        m_flow(each max = if flowDirection == Types.PortFlowDirection.Leaving then 0 else 
        +Constants.inf, 
        each min = if flowDirection == Types.PortFlowDirection.Entering then 0 else 
        -Constants.inf)) 
        annotation(Placement(transformation(extent = {{90, 40}, {110, -40}})));
    protected
      parameter Types.PortFlowDirection flowDirection = 
        Types.PortFlowDirection.Bidirectional 
        "允许的流向" annotation(Evaluate = true, Dialog(tab = "高级"));
    equation
      // 一个接口只允许一个连接，以避免不必要的理想混合
      for i in 1:nPorts loop
        assert(cardinality(ports[i]) <= 1, "
边界的每个端口[i]最多只能连接一个分量。
如果存在两个或两个以上的连接，这些连接就会产生理想的混合，这通常不符合预期。增加 nPorts 可以增加一个端口。
"  );

        ports[i].p = medium.p;
        ports[i].h_outflow = medium.h;
        ports[i].Xi_outflow = medium.Xi;
      end for;

      annotation(defaultComponentName = "boundary", Documentation(info = "<html>
<p>
基类组件，用于对质量流量边界等<strong>边界</strong>组件的<strong>容积接口</strong>进行建模。其基本特征如下
</p>
<ul>
<li> 连接口的压力 (= ports.p) 与容积的压力相同。</li>
<li> 流出焓（= port.h_outflow）和物质成分（= port.Xi_outflow）与容积中的对应值相同。</li>
</ul>
</html>"  ));
    end PartialSource;

    partial model PartialFlowSource 
      "带一个流体连接器的边界基类组件"
      import Modelica.Constants;

      parameter Integer nPorts = 0 "接口数" annotation(Dialog(connectorSizing = true));

      replaceable package Medium = 
        Modelica.Media.Interfaces.PartialMedium 
        "边界内的介质模型" 
        annotation(choicesAllMatching = true);

      Medium.BaseProperties medium "边界内的介质";

      Interfaces.FluidPort_b ports[nPorts](
      redeclare each package Medium = Medium, 
        m_flow(each max = if flowDirection == Types.PortFlowDirection.Leaving then 0 else 
        +Constants.inf, 
        each min = if flowDirection == Types.PortFlowDirection.Entering then 0 else 
        -Constants.inf)) 
        annotation(Placement(transformation(extent = {{90, 10}, {110, -10}})));
    protected
      parameter Types.PortFlowDirection flowDirection = 
        Types.PortFlowDirection.Bidirectional 
        "允许的流向" annotation(Evaluate = true, Dialog(tab = "高级"));
    equation
      assert(abs(sum(abs(ports.m_flow)) - max(abs(ports.m_flow))) <= Modelica.Constants.small, "FlowSource 仅支持一个带流量的连接");
      assert(nPorts > 0, "至少需要有一个接口存在（nPorts > 0），否则模型是奇异的");
      // 一个接口只允许一个连接，以避免不必要的理想混合
      for i in 1:nPorts loop
        assert(cardinality(ports[i]) <= 1, "
边界的每个接口 ports[i] 最多只能连接到一个组件。 
如果存在两个或更多的连接，就会发生理想的混合，这通常与模型不符合。
增加 nPorts 可以增加一个附加接口。
"      );
        ports[i].p = medium.p;
        ports[i].h_outflow = medium.h;
        ports[i].Xi_outflow = medium.Xi;
      end for;

      annotation(defaultComponentName = "boundary", Documentation(info = "<html>
<p>
基类组件，用于对质量流量边界等<strong>边界</strong>组件的<strong>容积接口</strong>进行建模。其基本特征如下
</p>
<ul>
<li> 连接口的压力 (= ports.p) 与容积的压力相同。</li>
<li> 流出焓（= port.h_outflow）和物质成分（= port.Xi_outflow）与容积中的对应值相同。</li>
</ul>
</html>"      ));
    end PartialFlowSource;
    annotation();
  end BaseClasses;
  annotation(Documentation(info = "<html>
<p>
<strong>边界库</strong>包含流体连接器的通用边界，用于定义固定或规定的环境条件。
</p>
</html>"));
end Sources;