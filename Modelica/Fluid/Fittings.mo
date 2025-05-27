within Modelica.Fluid;
package Fittings 
  "连接流体部件和调节流体流量的装配部件"
  package Bends "弯管流动模型"
    extends Modelica.Icons.VariantsPackage;
    model CurvedBend "弯头"
      extends Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.Bend_i;
      extends Modelica.Fluid.Interfaces.PartialPressureLoss;

      parameter Modelica.Fluid.Fittings.BaseClasses.Bends.CurvedBend.Geometry geometry 
        "弯头几何" 
        annotation(Placement(transformation(extent = {{-20, 0}, {0, 20}})));

    protected
      parameter Medium.AbsolutePressure dp_small(min = 0) = 
        Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_DP(
        geometry, 
        Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_IN_var(
        rho = Medium.density(state_dp_small), 
        eta = Medium.dynamicViscosity(state_dp_small)), 
        m_flow_small) 
        "用于对层流和零流量进行正则化的默认小压降（由 m_flow_small 计算得出）";

    equation
      if allowFlowReversal then
        m_flow = Modelica.Fluid.Fittings.BaseClasses.Bends.CurvedBend.massFlowRate(
          dp, geometry, d_a, d_b, eta_a, eta_b, dp_small, m_flow_small);
      else
        m_flow = Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_MFLOW(
          geometry, 
          Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_IN_var(rho = d_a, eta = eta_a), dp);
      end if;

      annotation(Documentation(info = "<html>
<p>
该组件模拟了不可压缩和单相流体流经圆形截面区域时，考虑到表面粗糙度的整体流动状态下的<strong>弯头</strong>。
预计在Ma = 0.3 左右的可压缩流体流动也可处理。假定此组件不储存质量和能量。在该基本模型中，调用了一个函数来计算质量流量与弯头压力损失的函数关系。
此外，还定义了该函数的反函数，为了避免求解非线性方程，工具可能会使用该反函数。
</p>

<p>
该模型的详细介绍见
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Bend.dp_curvedOverall\">documentation of the underlying function</a>.
</p>
</html>"    ));
    end CurvedBend;

    model EdgedBend "直角弯管"
      extends Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.Bend_i;
      extends Modelica.Fluid.Interfaces.PartialPressureLoss;

      parameter Modelica.Fluid.Fittings.BaseClasses.Bends.EdgedBend.Geometry geometry 
        "直角弯管几何" 
        annotation(Placement(transformation(extent = {{-20, 0}, {0, 20}})));

    protected
      parameter Medium.AbsolutePressure dp_small(min = 0) = 
        Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_DP(
        Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_IN_con(
        d_hyd = geometry.d_hyd, 
        delta = geometry.delta, 
        K = geometry.K), 
        Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_IN_var(
        rho = Medium.density(state_dp_small), 
        eta = Medium.dynamicViscosity(state_dp_small)), 
        m_flow_small) 
        "用于对层流和零流量进行正则化的默认小压降（由 m_flow_small 计算得出）";

    equation
      if allowFlowReversal then
        m_flow = Modelica.Fluid.Fittings.BaseClasses.Bends.EdgedBend.massFlowRate(
          dp, geometry, d_a, d_b, eta_a, eta_b, dp_small, m_flow_small);
      else
        m_flow = Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_MFLOW(
          Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_IN_con(
          d_hyd = geometry.d_hyd, 
          delta = geometry.delta, 
          K = geometry.K), 
          Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_IN_var(rho = d_a, eta = eta_a), dp);
      end if;

      annotation(Documentation(info = "<html>
<p>
该组件模拟了不可压缩和单相流体流经圆形截面区域时，考虑到表面粗糙度的整体流动状态下的<strong>直角弯管</strong>。
预计在Ma = 0.3 左右的可压缩流体流动也可处理。假定此组件不储存质量和能量。
在该基本模型中，调用了一个函数来计算质量流量与直角弯管压力损失的函数关系。
此外，还定义了该函数的反函数，为了避免求解非线性方程，工具可能会使用该反函数。
</p>

<p>
该模型的详细介绍见
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Bend.dp_edgedOverall\">documentation of the underlying function</a>.
</p>

</html>"    ));
    end EdgedBend;
    annotation();
  end Bends;

  package Orifices "孔口流量模型"
    extends Modelica.Icons.VariantsPackage;

    model ThickEdgedOrifice "厚边孔流模型"
      extends Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.Orifice_i;
      extends Modelica.Fluid.Interfaces.PartialPressureLoss;

      parameter
        Modelica.Fluid.Fittings.BaseClasses.Orifices.ThickEdgedOrifice.Geometry geometry 
        "厚边孔口几何" 
        annotation(Placement(transformation(extent = {{-20, 0}, {0, 20}})), 
        choices(
        choice = Modelica.Fluid.Fittings.BaseClasses.Orifices.ThickEdgedOrifice.Choices.circular(), 
        choice = Modelica.Fluid.Fittings.BaseClasses.Orifices.ThickEdgedOrifice.Choices.rectangular(), 
        choice = Modelica.Fluid.Fittings.BaseClasses.Orifices.ThickEdgedOrifice.Choices.general()));

    protected
      parameter Medium.AbsolutePressure dp_small(min = 0) = 
        Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_DP(
        Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_IN_con(
        A_0 = geometry.venaCrossArea, 
        A_1 = geometry.crossArea, 
        C_0 = geometry.venaPerimeter, 
        C_1 = geometry.perimeter, 
        L = geometry.venaLength, 
        dp_smooth = 1e-10), 
        Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_IN_var(
        rho = Medium.density(state_dp_small), 
        eta = Medium.dynamicViscosity(state_dp_small)), 
        m_flow_small) 
        "用于对层流和零流量进行正则化的默认小压降（由 m_flow_small 计算得出）";
    equation
      if allowFlowReversal then
        m_flow = Modelica.Fluid.Fittings.BaseClasses.Orifices.ThickEdgedOrifice.massFlowRate(
          dp, geometry, d_a, d_b, eta_a, eta_b, dp_small, m_flow_small);
      else
        m_flow = Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_MFLOW(
          Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_IN_con(
          A_0 = geometry.venaCrossArea, 
          A_1 = geometry.crossArea, 
          C_0 = geometry.venaPerimeter, 
          C_1 = geometry.perimeter, 
          L = geometry.venaLength, 
          dp_smooth = dp_small), 
          Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_IN_var(rho = d_a, eta = eta_a), dp);
      end if;

      annotation(Documentation(info = "<html>
<p>
该组件在不可压缩和单相流体流经任意形状横截面积（方形、圆形等）的总体流动状态下，
对带有尖角的<strong>厚边孔口</strong> 进行建模，并考虑了表面粗糙度的影响。
预计在Ma = 0.3 左右的可压缩流体流动也可处理。假定此组件不储存质量和能量。
在该基本模型中，调用了一个函数来计算作为厚边孔口压力损失函数的质量流量。
此外，还定义了该函数的反函数，为了避免求解非线性方程，工具可能会使用该反函数。
</p>

<p>
该模型的详细介绍见
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Orifice.dp_thickEdgedOverall\">documentation of the underlying function</a>.
</p>

</html>"    ));
    end ThickEdgedOrifice;
    annotation();

  end Orifices;

  package GenericResistances "通用流动流阻模型"
    extends Modelica.Icons.VariantsPackage;

    model VolumeFlowRate "以体积流量为参数的通用阻力流动模型"

      extends Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.General_i;
      extends Modelica.Fluid.Interfaces.PartialTwoPortTransport;

      parameter Real a(unit = "(Pa.s2)/m6") "二次项系数" 
        annotation(Dialog(group = "dp = a*V_flow^2 + b*V_flow"));
      parameter Real b(unit = "(Pa.s)/m3") "一次项系数" 
        annotation(Dialog(group = "dp = a*V_flow^2 + b*V_flow"));

    protected
      parameter Medium.ThermodynamicState state_dp_small = Medium.setState_pTX(
        Medium.reference_p, 
        Medium.reference_T, 
        Medium.reference_X) 
        "计算 dp_small 的介质状态参数";
      parameter Medium.AbsolutePressure dp_small(min = 0) = 
        Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_DP(
        Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_IN_con(
        a = a, 
        b = b, 
        dp_min = 1e-10), 
        Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_IN_var(
        rho = Medium.density(state_dp_small)), 
        m_flow_small) 
        "用于对层流和零流量进行正则化的默认小压降（由 m_flow_small 计算得出）";
      Medium.Density d_a 
        "当流体从a接口流向b接口时，a接口的密度";
      Medium.Density d_b 
        "如果 allowFlowReversal=true 则当流体从b接口流向a接口时b接口的密度，否则为d_a";

    equation
      // 等温转化（无储存损失，无能量损失）
      port_a.h_outflow = inStream(port_b.h_outflow);
      port_b.h_outflow = inStream(port_a.h_outflow);

      // 介质属性
      d_a = Medium.density(state_a);
      if allowFlowReversal then
        d_b = Medium.density(state_b);
      else
        d_b = d_a;
      end if;

      if allowFlowReversal then
        m_flow = Modelica.Fluid.Fittings.BaseClasses.GenericResistances.VolumeFlowRate.massFlowRate(
          dp, a, b, d_a, d_b, dp_small, m_flow_small);
      else
        m_flow = Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_MFLOW(
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_IN_con(
          a = a, 
          b = b, 
          dp_min = dp_small), 
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_IN_var(rho = d_a), dp);
      end if;

      annotation(Documentation(info = "<html>
<p>
该组件模拟的是以体积流量为参数的通用阻力：
</p>

<blockquote><pre>
dp     = a*V_flow^2 + b*V_flow
m_flow = rho*V_flow
</pre></blockquote>

<p>
其中
</p>

<table>
<tr><td><strong> a              </strong></td><td> 二次项系数 [Pa*s^2/m^6],</td></tr>
<tr><td><strong> b              </strong></td><td> 线性项系数 [Pa*s/m3],</td></tr>
<tr><td><strong> dp             </strong></td><td> 压力损失 [Pa],</td></tr>
<tr><td><strong> m_flow         </strong></td><td> 质量流量 [kg/s],</td></tr>
<tr><td><strong> rho            </strong></td><td> 流体密度 [kg/m3],</td></tr>
<tr><td><strong> V_flow         </strong></td><td> 体积流量 [m3/s].</td></tr>
</table>

<p>
能量设备的几何参数通常不完全确定，这些参数对于压力损失计算是必要的。
因此，详细的压力损失计算模型需要简化。该组件使用了压力损失与体积流量之间的线性和二次依赖关系。
假设该组件既不存储质量也不存储能量。在基本模型中，调用一个函数来计算作为压力损失函数的质量流量。
同时，还定义了该函数的逆函数，某些工具可能会使用这个逆函数，以避免求解非线性方程。
</p>

<p>
该模型的详细介绍见
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_volumeFlowRate\">documentation of the underlying function</a>.
</p>

</html>"    ));
    end VolumeFlowRate;
    annotation(Documentation(info = "<html>
<p>
压力损失计算所需的能源装置的几何参数往往并不确切。
因此，必须简化压力损失计算。本子库中的组件可提供不同形式的近似值。
</p>
</html>"  ));
  end GenericResistances;

  extends Modelica.Icons.VariantsPackage;

  model SimpleGenericOrifice "由压力损失系数和直径定义的简单通用孔口（仅适用于从a接口到b接口的流动）"

    extends Modelica.Fluid.Interfaces.PartialTwoPortTransport(
      dp_start = dp_nominal, 
      m_flow_small = if system.use_eps_Re then system.eps_m_flow * m_flow_nominal else system.m_flow_small, 
      m_flow(stateSelect = if momentumDynamics == Types.Dynamics.SteadyState then StateSelect.default 
      else StateSelect.prefer));

    extends Modelica.Fluid.Interfaces.PartialLumpedFlow(
      final pathLength = 0, 
      final momentumDynamics = Types.Dynamics.SteadyState);

    parameter SI.Diameter diameter "孔口直径";
    parameter Real zeta "从a接口流向b接口的流量损失因数" 
      annotation(Dialog(enable = use_zeta));
    parameter Boolean use_zeta = true 
      "false: 从 dp_nominal 和 m_flow_nominal 得到 zeta";

    // 运行条件
    parameter SI.MassFlowRate m_flow_nominal = if system.use_eps_Re then system.m_flow_nominal else 1e2 * system.m_flow_small 
      "dp_nominal 的质量流量" 
      annotation(Dialog(group = "额定工作点"));
    parameter SI.Pressure dp_nominal = if not system.use_eps_Re then 1e3 else 
      BaseClasses.lossConstant_D_zeta(diameter, zeta) / Medium.density_pTX(Medium.p_default, Medium.T_default, Medium.X_default) * m_flow_nominal ^ 2 
      "额定压降" 
      annotation(Dialog(group = "额定工作点"));

    parameter Boolean use_Re = system.use_eps_Re 
      "true: 湍流区域由Re定义，否则由m_flow_small定义" 
      annotation(Dialog(tab = "高级"), Evaluate = true);

    parameter Boolean from_dp = true 
      "true: m_flow = f(dp) 否则 dp = f(m_flow)" 
      annotation(Evaluate = true, Dialog(tab = "高级"));

  protected
    parameter Medium.AbsolutePressure dp_small(min = 0) = if system.use_eps_Re then dp_nominal / m_flow_nominal * m_flow_small else system.dp_small 
      "如果 |dp| < dp_small，对零流量进行正则调整" 
      annotation(Dialog(tab = "高级", enable = not use_Re and from_dp));

    // 变量
  public
    Real zeta_nominal;
    Medium.Density d = 0.5 * (Medium.density(state_a) + Medium.density(state_b));
    SI.Pressure dp_fg(start = dp_start) 
      "摩擦和重力造成的压力损失";
    SI.Area A_mean = Modelica.Constants.pi / 4 * diameter ^ 2 
      "平均过流面积";

    constant SI.ReynoldsNumber Re_turbulent = 10000 "cf.锐缘孔口";
    SI.MassFlowRate m_flow_turbulent = if not use_Re then m_flow_small else 
      max(m_flow_small, 
      (Modelica.Constants.pi / 8) * diameter * (Medium.dynamicViscosity(state_a) + Medium.dynamicViscosity(state_b)) * Re_turbulent);
    SI.AbsolutePressure dp_turbulent = if not use_Re then dp_small else 
      max(dp_small, BaseClasses.lossConstant_D_zeta(diameter, zeta_nominal) / d * m_flow_turbulent ^ 2);
  equation
    if use_zeta then
      zeta_nominal = zeta;
    else
      zeta_nominal = 2 * A_mean ^ 2 * d * dp_nominal / m_flow_nominal ^ 2;
    end if;

    Ib_flow = 0;
    F_p = A_mean * (Medium.pressure(state_b) - Medium.pressure(state_a));
    F_fg = A_mean * dp_fg;

    /*
    dp = 0.5*zeta*d*v*|v|
    = 0.5*zeta*d*1/(d*A)^2 * m_flow * |m_flow|
    = 0.5*zeta/A^2 *1/d * m_flow * |m_flow|
    = k/d * m_flow * |m_flow|
    k  = 0.5*zeta/A^2
    = 0.5*zeta/(pi*(D/2)^2)^2
    = 8*zeta/(pi*D^2)^2
    */
    if from_dp then
      m_flow = homotopy(Utilities.regRoot2(
        dp_fg, 
        dp_turbulent, 
        Medium.density(state_a) / BaseClasses.lossConstant_D_zeta(diameter, zeta_nominal), 
        Medium.density(state_b) / BaseClasses.lossConstant_D_zeta(diameter, zeta_nominal)), 
        m_flow_nominal * dp_fg / dp_nominal);
    else
      dp_fg = homotopy(Utilities.regSquare2(
        m_flow, 
        m_flow_turbulent, 
        BaseClasses.lossConstant_D_zeta(diameter, zeta_nominal) / Medium.density(state_a), 
        BaseClasses.lossConstant_D_zeta(diameter, zeta_nominal) / Medium.density(state_b)), 
        dp_nominal * m_flow / m_flow_nominal);
    end if;

    // 等焓转化（无能量储存，无能量损失）
    port_a.h_outflow = inStream(port_b.h_outflow);
    port_b.h_outflow = inStream(port_a.h_outflow);

    annotation(defaultComponentName = "orifice", 
      Icon(coordinateSystem(
      preserveAspectRatio = false, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(
      points = {{-60, -50}, {-60, 50}, {60, -50}, {60, 50}}, 
      thickness = 0.5), 
      Line(points = {{-60, 0}, {-100, 0}}, color = {0, 127, 255}), 
      Line(points = {{60, 0}, {100, 0}}, color = {0, 127, 255}), 
      Text(
      extent = {{-173, 104}, {175, 62}}, 
      textString = "zeta=%zeta")}), 
      Documentation(info = "<html>
<p>
这个压降组件定义了一个简单通用孔口，其中的损失系数 &zeta; 是针对单流向提供的
（从参考书的损耗表中获取）：
</p>

<blockquote><pre>
&Delta;p = 0.5*&zeta;*&rho;*v*|v|
 = 8*&zeta;/(&pi;^2*D^4*&rho;) * m_flow*|m_flow|
</pre></blockquote>

<p>
其中
</p>
<ul>
<li> &Delta;p 代表压降：&Delta;p = port_a.p - port_b.p</li>
<li> D 代表 &zeta; 位置（port_a 或port_b）的孔径。
  如果孔口不是圆形截面，则 D = 4*A/P，其中 A 是截面面积，P 是湿周。</li>
<li> &zeta; 是相对于 D 的损失系数，取决于孔口的几何形状。在湍流状态下，假设 &zeta; 为常数。<br>
   对于小质量流量，流动是层流的，用多项式来近似，当 m_flow=0 时，多项式的导数是有限的。</li>
<li> v 代表平均速度</li>
<li> &rho; 代表上游密度。</li>
</ul>

<p>
由于压力损失系数 zeta 仅针对从 port_a 到 port_b 的质量流，因此当流动反向时，得到的压力损失是不正确的。
若反向流动只在很短的时间间隔内发生，那么这很可能是非临界状态。如果可能出现明显的反向流动，则不应使用该元件。
</p>
</html>"  ));
  end SimpleGenericOrifice;

  model SharpEdgedOrifice 
    "锐缘孔口造成的压降（两个流向）"
    import Modelica.Units.NonSI;
    extends BaseClasses.QuadraticTurbulent.BaseModel(final data = 
      BaseClasses.QuadraticTurbulent.LossFactorData.sharpEdgedOrifice(
      diameter, 
      leastDiameter, 
      length, 
      alpha));
    parameter SI.Length length "孔口长度";
    parameter SI.Diameter diameter 
      "管道内径 (= port_a 和 port_b 相同)";
    parameter SI.Diameter leastDiameter "最小孔径";
    parameter NonSI.Angle_deg alpha "孔口角度";
    annotation(defaultComponentName = "orifice", 
      Documentation(info = "<html>
</html>"  ), 
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Rectangle(
      extent = {{-100, 44}, {100, -44}}, 
      fillPattern = FillPattern.HorizontalCylinder, 
      fillColor = {0, 127, 255}), 
      Polygon(
      points = {{-25, 44}, {-25, 7}, {35, 37}, {35, 44}, {-25, 44}}, 
      fillPattern = FillPattern.Backward, 
      fillColor = {175, 175, 175}), 
      Polygon(
      points = {{-25, -7}, {-25, -44}, {35, -44}, {35, -36}, {-25, -7}}, 
      fillColor = {175, 175, 175}, 
      fillPattern = FillPattern.Backward)}), 
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {
      100, 100}}), graphics = {
      Rectangle(
      extent = {{-100, 60}, {100, -60}}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid), 
      Polygon(
      points = {{-30, 60}, {-30, 12}, {30, 50}, {30, 60}, {-30, 60}}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Backward), 
      Polygon(
      points = {{-30, -10}, {-30, -60}, {30, -60}, {30, -50}, {-30, -10}}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Backward), 
      Line(
      points = {{-82, -60}, {-82, 60}}, 
      color = {0, 0, 255}, 
      arrow = {Arrow.Filled, Arrow.Filled}), 
      Text(
      extent = {{-78, 16}, {-44, -8}}, 
      textColor = {0, 0, 255}, 
      textString = "diameter"), 
      Line(
      points = {{-30, -10}, {-30, 12}}, 
      color = {0, 0, 255}, 
      arrow = {Arrow.Filled, Arrow.Filled}), 
      Text(
      extent = {{-24, 14}, {8, -10}}, 
      textColor = {0, 0, 255}, 
      textString = "leastDiameter"), 
      Text(
      extent = {{-20, 84}, {18, 70}}, 
      textColor = {0, 0, 255}, 
      textString = "length"), 
      Line(
      points = {{30, 68}, {-30, 68}}, 
      color = {0, 0, 255}, 
      arrow = {Arrow.Filled, Arrow.Filled}), 
      Line(
      points = {{16, 40}, {32, 18}, {36, -2}, {34, -20}, {20, -42}}, 
      color = {0, 0, 255}, 
      arrow = {Arrow.Filled, Arrow.Filled}), 
      Text(
      extent = {{38, 8}, {92, -6}}, 
      textColor = {0, 0, 255}, 
      textString = "alpha")}));

  end SharpEdgedOrifice;

  model AbruptAdaptor 
    "突扩(缩)造成的压降(两个流向)"
    extends BaseClasses.QuadraticTurbulent.BaseModelNonconstantCrossSectionArea(final data = 
      BaseClasses.QuadraticTurbulent.LossFactorData.suddenExpansion(
      diameter_a, diameter_b));
    parameter SI.Diameter diameter_a "port_a 的管道内径";
    parameter SI.Diameter diameter_b "port_b 的管道内径";

    annotation(
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {
      100, 100}}), graphics = {
      Line(points = {{0, 40}, {-100, 40}, {-100, -40}, {0, -40}, {0, -100}, {100, -100}, 
      {100, 100}, {0, 100}, {0, 40}}), 
      Rectangle(
      extent = {{-100, 40}, {0, -40}}, 
      lineColor = {255, 255, 255}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid), 
      Rectangle(
      extent = {{0, 100}, {100, -100}}, 
      lineColor = {255, 255, 255}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{0, 40}, {-100, 40}, {-100, -40}, {0, -40}, {0, -100}, {100, -100}, 
      {100, 100}, {0, 100}, {0, 40}}), 
      Line(
      points = {{-60, -40}, {-60, 40}}, 
      color = {0, 0, 255}, 
      arrow = {Arrow.Filled, Arrow.Filled}), 
      Text(
      extent = {{-50, 16}, {-26, -10}}, 
      textColor = {0, 0, 255}, 
      textString = "diameter_a"), 
      Line(
      points = {{34, -100}, {34, 100}}, 
      color = {0, 0, 255}, 
      arrow = {Arrow.Filled, Arrow.Filled}), 
      Text(
      extent = {{54, 16}, {78, -10}}, 
      textColor = {0, 0, 255}, 
      textString = "diameter_b")}), 
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 
      100}}), graphics = {Rectangle(
      extent = DynamicSelect({{-100, 22}, {0, -22}}, {{-100, max(0.1, min(1, 
      diameter_a / max(diameter_a, diameter_b))) * 60}, {0, -max(0.1, min(1, 
      diameter_a / max(diameter_a, diameter_b))) * 60}}), 
      fillPattern = FillPattern.HorizontalCylinder, 
      fillColor = {0, 127, 255}), Rectangle(
      extent = DynamicSelect({{0, 60}, {100, -60}}, {{0, max(0.1, min(1, 
      diameter_b / max(diameter_a, diameter_b))) * 60}, {100, -max(0.1, min(
      1, diameter_b / max(diameter_a, diameter_b))) * 60}}), 
      fillPattern = FillPattern.HorizontalCylinder, 
      fillColor = {0, 127, 255})}), 
      Documentation(info = "<html>

</html>"));
  end AbruptAdaptor;

  model MultiPort 
    "多接口；用于对显示状态的接口进行多个连接"

    function positiveMax
      extends Modelica.Icons.Function;
      input Real x;
      output Real y;
      annotation();
    algorithm
      y := max(x, 1e-10);
    end positiveMax;

    import Modelica.Constants;

    replaceable package Medium = Modelica.Media.Interfaces.PartialMedium annotation(choicesAllMatching);

    // 接口
    parameter Integer nPorts_b = 0 
      "出口数量 (质量在出气口之间均匀分布)" 
      annotation(Dialog(connectorSizing = true));

    Modelica.Fluid.Interfaces.FluidPort_a port_a(
    redeclare package Medium = Medium) 
      annotation(Placement(transformation(extent = {{-50, -10}, {-30, 10}})));
    Modelica.Fluid.Interfaces.FluidPorts_b ports_b[nPorts_b](
    redeclare each package Medium = Medium) 
      annotation(Placement(transformation(extent = {{30, 40}, {50, -40}})));

    Medium.MassFraction ports_b_Xi_inStream[nPorts_b,Medium.nXi] 
      "ports_b 的内流质量分数";
    Medium.ExtraProperty ports_b_C_inStream[nPorts_b,Medium.nC] 
      "ports_b 的内流额外属性";

  equation
    // 一个接口只允许一个连接，以避免不必要的混合
    for i in 1:nPorts_b loop
      assert(cardinality(ports_b[i]) <= 1, "
边界的每个端口_b[i] 最多只能与一个分量相连。
如果存在两个或两个以上的连接，这些连接就会发生理想的混合，这通常是不符合预期的。增加 nPorts_b 可以增加一个端口。
"  );
    end for;

    // 质量和动量平衡
    0 = port_a.m_flow + sum(ports_b.m_flow);
    ports_b.p = fill(port_a.p, nPorts_b);

    // ports_a 接口混合
    port_a.h_outflow = sum({positiveMax(ports_b[j].m_flow) * inStream(ports_b[j].h_outflow) for j in 1:nPorts_b}) 
      / sum({positiveMax(ports_b[j].m_flow) for j in 1:nPorts_b});
    for j in 1:nPorts_b loop
      // 显示从 port_a 到 ports_b的流动值
      ports_b[j].h_outflow = inStream(port_a.h_outflow);
      ports_b[j].Xi_outflow = inStream(port_a.Xi_outflow);
      ports_b[j].C_outflow = inStream(port_a.C_outflow);

      ports_b_Xi_inStream[j,:] = inStream(ports_b[j].Xi_outflow);
      ports_b_C_inStream[j,:] = inStream(ports_b[j].C_outflow);
    end for;
    for i in 1:Medium.nXi loop
      port_a.Xi_outflow[i] = (positiveMax(ports_b.m_flow) * ports_b_Xi_inStream[:,i]) 
        / sum(positiveMax(ports_b.m_flow));
    end for;
    for i in 1:Medium.nC loop
      port_a.C_outflow[i] = (positiveMax(ports_b.m_flow) * ports_b_C_inStream[:,i]) 
        / sum(positiveMax(ports_b.m_flow));
    end for;
    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-40, 
      -100}, {40, 100}}), graphics = {
      Line(
      points = {{-40, 0}, {40, 0}}, 
      color = {0, 128, 255}, 
      thickness = 1), 
      Line(
      points = {{-40, 0}, {40, 26}}, 
      color = {0, 128, 255}, 
      thickness = 1), 
      Line(
      points = {{-40, 0}, {40, -26}}, 
      color = {0, 128, 255}, 
      thickness = 1), 
      Text(
      extent = {{-150, 100}, {150, 60}}, 
      textColor = {0, 0, 255}, 
      textString = "%name")}), 
      Documentation(info = "<html>
<p>
当需要将多个连接建立到暴露状态的容积模型（如具有ModelStructure av_vb的管道）的端口时，此模型非常有用。
混合过程被转移到连接到port_a 的容积中，然后结果再传播回每个port_b。
</p>
<p>
如果多个连接直接建立到容积上，则理想混合会在连接集内、容积外部发生，这通常是不符合预期的。
</p>
</html>"  ));
  end MultiPort;

  model TeeJunctionIdeal 
    "用于无穷小控制体积的带静态平衡的分流/合流组件"
    extends Modelica.Fluid.Fittings.BaseClasses.PartialTeeJunction;

  equation
    connect(port_1, port_2) annotation(Line(
      points = {{-100, 0}, {100, 0}}, color = {0, 127, 255}));
    connect(port_1, port_3) annotation(Line(
      points = {{-100, 0}, {0, 0}, {0, 100}}, color = {0, 127, 255}));
    annotation(Documentation(info = "<html>
<p>
该模型是三股分流/合流组件的最简单实现方式。无任何使用要求。
它用与连接语义相同的形式形成平衡方程。
使用该组件的主要优点是，当查看每个端口的具体焓值时，用户不会感到困惑——如果不使用分流/合流组件，这种查看方式可能会导致困惑，
造成这种困惑的的原因是，在查看连接器中的具体焓值时，实际上是在检查由连接语句引入的微小控制体积的混合焓，这可能与 \"真实世界 \"中端口处的具体焓值不相等。
</p>
</html>"  ));
  end TeeJunctionIdeal;

  model TeeJunctionVolume 
    "用于动态控制体积的带静态平衡的分流/合流组件"
    extends Modelica.Fluid.Fittings.BaseClasses.PartialTeeJunction;
    extends Modelica.Fluid.Interfaces.PartialLumpedVolume(
      final fluidVolume = V);

    parameter SI.Volume V "接头内的混合容积";

  equation
    // 一个接口只允许一个连接，以避免不必要的混合
    assert(cardinality(port_1) <= 1, "
port_1 最多只能连接到一个组件。
如果有两个或两个以上的连接，就会发生理想的混合，而这通常与模型不匹配。
"  );
    assert(cardinality(port_2) <= 1, "
port_2 最多只能连接到一个组件。
如果有两个或两个以上的连接，就会发生理想的混合，而这通常与模型不匹配。
"  );
    assert(cardinality(port_3) <= 1, "
port_3 最多只能连接到一个组件。
如果有两个或两个以上的连接，就会发生理想的混合，而这通常与模型不匹配。
"  );

    // 边界条件
    port_1.h_outflow = medium.h;
    port_2.h_outflow = medium.h;
    port_3.h_outflow = medium.h;

    port_1.Xi_outflow = medium.Xi;
    port_2.Xi_outflow = medium.Xi;
    port_3.Xi_outflow = medium.Xi;

    port_1.C_outflow = C;
    port_2.C_outflow = C;
    port_3.C_outflow = C;

    // 质量平衡
    mb_flow = port_1.m_flow + port_2.m_flow + port_3.m_flow "质量平衡";
    mbXi_flow = port_1.m_flow * actualStream(port_1.Xi_outflow) 
      + port_2.m_flow * actualStream(port_2.Xi_outflow) 
      + port_3.m_flow * actualStream(port_3.Xi_outflow) 
      "组件质量平衡";

    mbC_flow = port_1.m_flow * actualStream(port_1.C_outflow) 
      + port_2.m_flow * actualStream(port_2.C_outflow) 
      + port_3.m_flow * actualStream(port_3.C_outflow) 
      "微量物质质量平衡";

    // 动量平衡 (适用于可压缩介质)
    port_1.p = medium.p;
    port_2.p = medium.p;
    port_3.p = medium.p;

    // 能量平衡
    Hb_flow = port_1.m_flow * actualStream(port_1.h_outflow) 
      + port_2.m_flow * actualStream(port_2.h_outflow) 
      + port_3.m_flow * actualStream(port_3.h_outflow);
    Qb_flow = 0;
    Wb_flow = 0;

    annotation(Documentation(info = "<html>
<p>
该模型在接头处引入了混合体积。这有助于检查实际接头处发生的非理想混合。
</p>
</html>"  ), 
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {Ellipse(
      extent = {{-9, 10}, {11, -10}}, 
      fillPattern = FillPattern.Solid)}));
  end TeeJunctionVolume;

  package BaseClasses 
    "装配子库中的基类(只用于建立新的组件模型)"
    extends Modelica.Icons.BasesPackage;

    function lossConstant_D_zeta "计算损失常数 8*zeta/(pi^2*D^4)"
      extends Modelica.Icons.Function;

      input SI.Diameter D "port_a 或 port_b 的直径";
      input Real zeta 
        "与 D 有关的恒压损失系数 (port_a 或 port_b)";
      output Real k "损失常数 (= 8*zeta/(pi^2*D^4))";

    algorithm
      k := 8 * zeta / (Modelica.Constants.pi * Modelica.Constants.pi * D * D * D * D);
      annotation(Documentation(info = "<html>

</html>"    ));
    end lossConstant_D_zeta;

    package QuadraticTurbulent 
      "主要由损失系数恒定的二次湍流区定义的压力损失"
      extends Modelica.Icons.Package;
      record LossFactorData 
        "为 dp = zeta*rho*v*|v|/2 定义恒定损失系数数据的数据结构，以及为某些损失类型提供数据的函数"

        extends Modelica.Icons.Record;

        SI.Diameter diameter_a "port_a 处的直径" annotation(Dialog);
        SI.Diameter diameter_b "port_b 处的直径" annotation(Dialog);
        Real zeta1 "从 port_a 流向 port_b 的损失系数" annotation(Dialog);
        Real zeta2 "从 port_b 流向 port_a 的损失系数" annotation(Dialog);
        SI.ReynoldsNumber Re_turbulent 
          "适用于 Re >= Re_turbulent 的损失系数" annotation(Dialog);
        SI.Diameter D_Re "用于计算 Re 的直径" annotation(Dialog);
        Boolean zeta1_at_a = true 
          "dp = zeta1*(若为 zeta1_at_a 则乘 rho_a*v_a^2/2，否则乘 rho_b*v_b^2/2)" 
          annotation(Dialog);
        Boolean zeta2_at_a = false 
          "dp = -zeta2*(若为 zeta2_at_a 则乘 rho_a*v_a^2/2，否则乘 rho_b*v_b^2/2)" 
          annotation(Dialog);
        Boolean zetaLaminarKnown = false 
          "true: 层流区zeta = c0/Re" annotation(Dialog);
        Real c0 = 1 
          "zeta = c0/Re; dp = zeta*rho_Re*v_Re^2/2, Re=v_Re*D_Re*rho_Re/mu_Re)" 
          annotation(Dialog(enable = zetaLaminarKnown));

        encapsulated function wallFriction 
          "在管壁粗糙度不均匀的直管中，计算摩擦引起的压力损失数据（对光滑管道无用，因为 zeta 不是 Re 的函数）"
          import Modelica.Units.SI;
          import Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData;
          import Modelica.Fluid.Types.Roughness;
          import lg = Modelica.Math.log10;

          input SI.Length length "管道长度" annotation(Dialog);
          input SI.Diameter diameter "管道内径" annotation(Dialog);
          input Roughness roughness(min = 1e-10) 
            "管道绝对粗糙度（要求 > 0，详见信息层）" annotation(Dialog);
          output LossFactorData data 
            "两个流向的压力损失系数";
        protected
          Real Delta(min = 0) = roughness / diameter "相对粗糙度";
        algorithm
          data.diameter_a := diameter;
          data.diameter_b := diameter;
          data.zeta1 := (length / diameter) / (2 * lg(3.7 / Delta)) ^ 2;
          data.zeta2 := data.zeta1;
          data.Re_turbulent := 4000 
            ">= 560/Delta 流量不依赖于 Re，但不适用插值";
          data.D_Re := diameter;
          data.zeta1_at_a := true;
          data.zeta2_at_a := false;
          data.zetaLaminarKnown := true;
          data.c0 := 64 * (length / diameter);
          annotation(Icon(coordinateSystem(
            preserveAspectRatio = false, 
            extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(
            extent = {{-100, 50}, {100, -50}}, 
            fillColor = {255, 255, 255}, 
            fillPattern = FillPattern.Solid)}), 
            Diagram(coordinateSystem(
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
            textString = "diameter"), 
            Line(
            points = {{-100, 74}, {100, 74}}, 
            color = {0, 0, 255}, 
            arrow = {Arrow.Filled, Arrow.Filled}), 
            Text(
            extent = {{-34, 92}, {34, 74}}, 
            textColor = {0, 0, 255}, 
            textString = "length")}), 
            Documentation(info = "<html>
<p>
具有不均匀粗糙度管壁的直管（商用管道）摩擦力，该区域的摩擦力与雷诺数无关
</p>
<p>
从 port_a 到 port_b 的质量流量的损失系数为：
</p>
<blockquote><pre>
湍流 (Idelchik 1994, diagram 2-5, p. 117)
zeta = (L/D)/(2*lg(3.7 / &Delta;))^2, for Re >= 560/&Delta;

当 Re &ge; 560/&Delta; 时，损失系数与雷诺数无关。
当 Re &ge; 4000 时，流动为湍流，取决于 &Delta;，但也与 Re 有关。

层流 (Idelchik 1994, diagram 2-1, p. 110):
zeta = 64*(L/D)/Re
</pre></blockquote>
<p>
其中
</p>
<ul>
<li> D 代表管道内径</li>
<li> L 代表管道长度</li>
<li> &Delta; = &delta;/D 代表相对粗糙度，其中 &delta; 是绝对 \"粗糙度\"，即管道中表面粗糙度的平均高度。
(在使用过程中，由于表面粗糙度的增长，&delta; 可能会随时间而变化，参见 [Idelchik 1994, p. 85, Tables 2-1, 2-2] )
</li>
</ul>

<p>
由于 LossFactorData 的记录只能描述取决于几何形状（但不取决于雷诺数）的损失系数，因此该数据只描述 Re &ge; 560/&Delta; 的区域。
不过，具有上述 zeta 的湍流区域定为从 Re=4000 开始，否则 Re &lt; 560/&Delta; 的近似值就太差了。
</p>

<p>
绝对粗糙度 &delta; 通常需要估算。
<em>[Idelchik 1994, pp. 105-109,Table 2-5; Miller 1990, p. 190, Table 8-1]</em> 中举了很多例子。
简而言之：
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>光滑管道</strong></td>
<td>拉伸黄铜、铜、铝、玻璃等。</td>
<td>&delta; = 0.0025 mm</td>
</tr>
<tr><td rowspan=\"3\"><strong>钢管</strong></td>
<td>新的光滑管道</td>
<td>&delta; = 0.025 mm</td>
</tr>
<tr><td>砂浆内衬，表面一般处理</td>
<td>&delta; = 0.1 mm</td>
</tr>
<tr><td>严重生锈</td>
<td>&delta; = 1 mm</td>
</tr>
<tr><td rowspan=\"3\"><strong>混凝土管</strong></td>
<td>钢制模板，顶级工艺</td>
<td>&delta; = 0.025 mm</td>
</tr>
<tr><td>钢制模板，一般工艺</td>
<td>&delta; = 0.1 mm</td>
</tr>
<tr><td>块状衬里</td>
<td>&delta; = 1 mm</td>
</tr>
</table>
</html>"          ));
        end wallFriction;

        encapsulated function suddenExpansion 
          "计算管道突扩或突缩时的压力损失数据（双向流动）"
          import Modelica.Units.SI;
          import 
            Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData;

          input SI.Diameter diameter_a "port_a 管道内径" annotation(Dialog);
          input SI.Diameter diameter_b "port_b 管道内径" annotation(Dialog);
          output LossFactorData data 
            "两个流向的压力损失系数";
        protected
          Real A_rel;
        algorithm
          data.diameter_a := diameter_a;
          data.diameter_b := diameter_b;
          data.Re_turbulent := 100;
          data.zetaLaminarKnown := true;
          data.c0 := 30;

          if diameter_a <= diameter_b then
            A_rel := (diameter_a / diameter_b) ^ 2;
            data.zeta1 := (1 - A_rel) ^ 2;
            data.zeta2 := 0.5 * (1 - A_rel) ^ 0.75;
            data.zeta1_at_a := true;
            data.zeta2_at_a := true;
            data.D_Re := diameter_a;
          else
            A_rel := (diameter_b / diameter_a) ^ 2;
            data.zeta1 := 0.5 * (1 - A_rel) ^ 0.75;
            data.zeta2 := (1 - A_rel) ^ 2;
            data.zeta1_at_a := false;
            data.zeta2_at_a := false;
            data.D_Re := diameter_b;
          end if;
          annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, 
            -100}, {100, 100}}), graphics = {
            Rectangle(
            extent = {{-100, 40}, {0, -40}}, 
            lineColor = {255, 255, 255}, 
            fillColor = {255, 255, 255}, 
            fillPattern = FillPattern.Solid), 
            Rectangle(
            extent = {{0, 100}, {100, -100}}, 
            lineColor = {255, 255, 255}, 
            fillColor = {255, 255, 255}, 
            fillPattern = FillPattern.Solid), 
            Line(points = {{0, 40}, {-100, 40}, {-100, -40}, {0, -40}, {0, -100}, {100, 
            -100}, {100, 100}, {0, 100}, {0, 40}})}), 
            Diagram(coordinateSystem(
            preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), 
            graphics = {
            Line(points = {{0, 40}, {-100, 40}, {-100, -40}, {0, -40}, {0, -100}, {100, 
            -100}, {100, 100}, {0, 100}, {0, 40}}), 
            Rectangle(
            extent = {{-100, 40}, {0, -40}}, 
            lineColor = {255, 255, 255}, 
            fillColor = {255, 255, 255}, 
            fillPattern = FillPattern.Solid), 
            Rectangle(
            extent = {{0, 100}, {100, -100}}, 
            lineColor = {255, 255, 255}, 
            fillColor = {255, 255, 255}, 
            fillPattern = FillPattern.Solid), 
            Line(points = {{0, 40}, {-100, 40}, {-100, -40}, {0, -40}, {0, -100}, {100, 
            -100}, {100, 100}, {0, 100}, {0, 40}}), 
            Line(
            points = {{-60, -40}, {-60, 40}}, 
            color = {0, 0, 255}, 
            arrow = {Arrow.Filled, Arrow.Filled}), 
            Text(
            extent = {{-50, 16}, {-26, -10}}, 
            textColor = {0, 0, 255}, 
            textString = "diameter_a"), 
            Line(
            points = {{34, -100}, {34, 100}}, 
            color = {0, 0, 255}, 
            arrow = {Arrow.Filled, Arrow.Filled}), 
            Text(
            extent = {{54, 16}, {78, -10}}, 
            textColor = {0, 0, 255}, 
            textString = "diameter_b")}), 
            Documentation(info = "<html>
<p>
从 port_a 到 port_b 的质量流量的损失系数为：
</p>
<blockquote><pre>
A_a &lt; A_b (Idelchik 1994, diagram 4-1, p. 208):
zeta = dp/(rho_a*v_a^2/2)
= (1 - A_a/A_b)^2 for Re_a &ge; 3.3e3 (turbulent flow)
zeta = 30/Re           for Re_a &lt; 10    (laminar flow)

A_a &gt; A_b (Idelchik 1994, diagram 4-9, p. 216 and diagram 4-10, p. 217)
zeta = dp/(rho_b*v_b^2/2)
= 0.5*(1 - A_b/A_a)^0.75 for Re_b &ge; 1e4 (turbulent flow)
zeta = 30/Re                  for Re_a &lt; 10  (laminar flow)
</pre></blockquote>
</html>"          ));
        end suddenExpansion;

        encapsulated function sharpEdgedOrifice 
          "计算锐缘孔口的压力损失数据（两个流向）"
          import Modelica.Units.SI;
          import Modelica.Units.NonSI;
          import Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData;

          input SI.Diameter diameter 
            "管道直径(=port_a 和 port_b 相同)" annotation(Dialog);
          input SI.Diameter leastDiameter "最小孔径" annotation(Dialog);
          input SI.Diameter length "孔口长度" annotation(Dialog);
          input NonSI.Angle_deg alpha "孔口角度" annotation(Dialog);
          output LossFactorData data 
            "两个流向的压力损失系数";
        protected
          Real D_rel = leastDiameter / diameter;
          Real LD = length / leastDiameter;
          Real k = 0.13 + 0.34 * 10 ^ (-(3.4 * LD + 88.4 * LD ^ 2.3));
        algorithm
          data.diameter_a := diameter;
          data.diameter_b := diameter;
          data.zeta1 := ((1 - D_rel) + 0.707 * (1 - D_rel) ^ 0.375) ^ 2 * (1 / D_rel) ^ 2;
          data.zeta2 := k * (1 - D_rel) ^ 0.75 + (1 - D_rel) ^ 2 + 2 * sqrt(k * (1 - 
            D_rel) ^ 0.375) + (1 - D_rel);
          data.Re_turbulent := 1e4;
          data.D_Re := leastDiameter;
          data.zeta1_at_a := true;
          data.zeta2_at_a := false;
          data.zetaLaminarKnown := false;
          data.c0 := 0;
          annotation(
            Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, 
            {100, 100}}), graphics = {
            Rectangle(
            extent = {{-100, 60}, {100, -60}}, 
            fillColor = {255, 255, 255}, 
            fillPattern = FillPattern.Solid), 
            Polygon(
            points = {{-30, 60}, {-30, 12}, {30, 50}, {30, 60}, {-30, 60}}, 
            fillColor = {255, 255, 255}, 
            fillPattern = FillPattern.Backward), 
            Polygon(
            points = {{-30, -10}, {-30, -60}, {30, -60}, {30, -50}, {-30, -10}}, 
            fillColor = {255, 255, 255}, 
            fillPattern = FillPattern.Backward)}), 
            Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, 
            -100}, {100, 100}}), graphics = {
            Rectangle(
            extent = {{-100, 60}, {100, -60}}, 
            fillColor = {255, 255, 255}, 
            fillPattern = FillPattern.Solid), 
            Polygon(
            points = {{-30, 60}, {-30, 12}, {30, 50}, {30, 60}, {-30, 60}}, 
            fillColor = {255, 255, 255}, 
            fillPattern = FillPattern.Backward), 
            Polygon(
            points = {{-30, -10}, {-30, -60}, {30, -60}, {30, -50}, {-30, -10}}, 
            fillColor = {255, 255, 255}, 
            fillPattern = FillPattern.Backward), 
            Line(
            points = {{-82, -60}, {-82, 60}}, 
            color = {0, 0, 255}, 
            arrow = {Arrow.Filled, Arrow.Filled}), 
            Text(
            extent = {{-78, 16}, {-44, -8}}, 
            textColor = {0, 0, 255}, 
            textString = "diameter"), 
            Line(
            points = {{-30, -10}, {-30, 12}}, 
            color = {0, 0, 255}, 
            arrow = {Arrow.Filled, Arrow.Filled}), 
            Text(
            extent = {{-24, 14}, {8, -10}}, 
            textColor = {0, 0, 255}, 
            textString = "leastDiameter"), 
            Text(
            extent = {{-20, 84}, {18, 70}}, 
            textColor = {0, 0, 255}, 
            textString = "length"), 
            Line(
            points = {{30, 68}, {-30, 68}}, 
            color = {0, 0, 255}, 
            arrow = {Arrow.Filled, Arrow.Filled}), 
            Line(
            points = {{16, 40}, {32, 18}, {36, -2}, {34, -20}, {20, -42}}, 
            color = {0, 0, 255}, 
            arrow = {Arrow.Filled, Arrow.Filled}), 
            Text(
            extent = {{38, 8}, {92, -6}}, 
            textColor = {0, 0, 255}, 
            textString = "alpha")}), 
            Documentation(info = "<html>
<p>
从 port_a 到 port_b 的质量流量的损失系数为
(Idelchik 1994, diagram 4-14, p. 221):
</p>
<blockquote><pre>
zeta = [(1-A0/A1) + 0.707*(1-A0/A1)^0.375]^2*(A1/A0)^2
for Re(A0) &ge; 1e5,  与 &alpha; 无关
</pre></blockquote>
<p>
从 port_b 到 port_a 的质量流量的损失系数为
(Idelchik 1994, diagram 4-13, p. 220, with A2=A1):
</p>
<blockquote><pre>
zeta = k*(1 - A0/A1)^0.75 + (1 - A0/A1)^2 + 2*sqrt(k*(1-A0/A1)^0.375) + (1- A0/A1)
k  = 0.13 + 0.34*10^(-(3.4*LD+88.4*LD^2.3))
(diagram 4-13 中的公式有一处错误，上式对应于diagram 4-12 中的table (a) )

LD = L/D0
for Re(A0) &ge; 1e4, 40 deg &le; alpha &le; 60 deg
对于其他 &alpha; 值，k 如 diagram 3-7 所示 （这还没有包含在函数中）

</pre></blockquote>
</html>"          ));
        end sharpEdgedOrifice;

        annotation(preferredView = "info", Documentation(info = "<html>
<p>
本记录用最少的数据定义管道节块（孔口、弯曲等）的压力损失系数。
如果有，可以提供<strong>两个流动方向</strong>的数据，即从 port_a 到 port_b 的流动和从 port_b 到 port_a 的流动，以及<strong>层流区</strong>和<strong>湍流区</strong>的数据。
也可以选择只提供从 port_a 流向 port_b 的<strong>湍流区</strong>的损失系数。
</p>
<p>
使用的公式如下
</p>
<blockquote><pre>
&Delta;p = 0.5*&zeta;*&rho;*v*|v|
= 0.5*&zeta;/A^2 * (1/&rho;) * m_flow*|m_flow|
= 8*&zeta;/(&pi;^2*D^4*&rho;) * m_flow*|m_flow|
Re = |v|*D*&rho;/&mu;
</pre></blockquote>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>流动状态</strong></td>
<td><strong>&zeta;</strong> = </td>
<td><strong>流动区域</strong></td></tr>
<tr><td>湍流</td>
<td><strong>zeta1</strong> = 常数</td>
<td>Re &ge;  Re_turbulent, v &ge; 0</td></tr>
<tr><td></td>
<td><strong>zeta2</strong> = 常数</td>
<td>Re &ge; Re_turbulent, v &lt; 0</td></tr>
<tr><td>层流</td>
<td><strong>c0</strong>/Re</td>
<td>两个流动方向，Re 很小；c0 = 常数</td></tr>
</table>
<p>
其中
</p>
<ul>
<li> &Delta;p 代表压降: &Delta;p = port_a.p - port_b.p</li>
<li> v 代表平均速度</li>
<li> &rho; 代表密度</li>
<li> &zeta; 代表损失系数，取决于管道的几何形状。在湍流状态下，假定 &zeta; 为常数，根据流向由 \"zeta1 \"和 \"zeta2 \"给出。<br>
当雷诺数 Re 低于 \"Re_turbulent \"时，小流速时为层流。
对于较高的流速，存在一个从层流到湍流的过渡区域。
小流速下层流的损失系数由经常出现的近似值 c0/Re 定义。
如果两个流动方向的 c0 不同，则必须使用平均值（c0 = (c0_ab + c0_ba)/2）。
</li>
<li> 公式 \"Δp = 0.5*ζ*ρ*v*|v|\"要么是针对 port_a，要么是针对 port_b，这取决于特定损失系数 &zeta; 的定义。
（在某些参考文献中，损失系数是针对 port_a 定义的，而在其他参考文献中，损失系数是针对 port_b 定义的。）
</li>
<li> Re = |v|*D_Re*ρ/μ = |m_flow|*D_Re/(A_Re*μ) 是最小截面积处的雷诺数。
这通常位于 port_a 或 port_b，但也可能位于两个接口之间。
在记录表中，必须提供该最小截面区域的直径 D_Re以及 Re_turbulent（即湍流开始时的雷诺数绝对值）。
如果两个流向的 Re_turbulent 数值不同，则使用较小的数值作为 Re_turbulent。
</li>
<li> D 代表管道直径。如果管道横截面不是圆形，则 D = 4*A/P，其中 A 是横截面积，P 是湿周。</li>
<li> A 代表横截面积，A = &pi;(D/2)^2。</li>
<li> &mu; 代表动力黏度</li>
</ul>
<p>
层流区和过渡区通常没有太大的意义，因为工作点大多处于湍流区。
出于简化和数值原因，整个流动区域由两个三阶多项式来描述，一个多项式用于 m_flow &ge; 0，另一个多项式用于 m_flow &lt; 0。
多项式的起点为 Re = |m_flow|*4/(&pi;*D_Re*&mu;)，其中 D_Re 是 port_a 和 port_b 之间的最小直径。
根据公式 \"c0/Re \"计算出两个多项式在 Re = 0 时的导数。
请注意，上述层流区域的压降方程是针对最小直径 D_Re 而定义的。
</p>
<p>
如果没有 c0 的数据，则计算 Re = 0 的导数时，使两个多项式的二阶导数在 Re = 0 时相同。
多项式的构造使其能够平滑湍流区域的特征曲线。
因此，整个特征曲线是<strong>连续的</strong>，并且在<strong>任何地方</strong>都具有<strong>有限</strong>、<strong>连续的一阶导数</strong>。
在某些情况下，构造的多项式会 \"振动\"。
通过减小 Re=0 时的导数可以避免这种情况，从而保证多项式单调递增。
所使用的单调性充分标准如下：
</p>

<dl>
<dt> Fritsch F.N. and Carlson R.E. (1980):</dt>
<dd> <strong>Monotone piecewise cubic interpolation</strong>.
SIAM J. Numerc. Anal., Vol. 17, No. 2, April 1980, pp. 238-246</dd>
</dl>
</html>"          ));
      end LossFactorData;

      function massFlowRate_dp 
        "根据恒定损失系数和压降计算质量流量 (m_flow = f(dp))"
        //导入 Modelica.Fluid.PressureLosses.BaseClasses.lossConstant_D_zeta;
        extends Modelica.Icons.Function;

        input SI.Pressure dp "压降 (dp = port_a.p - port_b.p)";
        input SI.Density rho_a "port_a 处密度";
        input SI.Density rho_b "port_b 处密度";
        input LossFactorData data 
          "两个流向的恒定损失系数" annotation(
          choices(
          choice = Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData.wallFriction(), 
          choice = Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData.suddenExpansion(), 
          choice = Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData.sharpEdgedOrifice()));
        input SI.AbsolutePressure dp_small = 1 
          "如果 |dp| >= dp_small 则为湍流";
        output SI.MassFlowRate m_flow "port_a 到 port_b 的质量流量";

      protected
        Real k1 = lossConstant_D_zeta(if data.zeta1_at_a then data.diameter_a else data.diameter_b, data.zeta1);
        Real k2 = lossConstant_D_zeta(if data.zeta2_at_a then data.diameter_a else data.diameter_b, data.zeta2);
      algorithm
        /*
        dp = 0.5*zeta*rho*v*|v|
        = 0.5*zeta*rho*1/(rho*A)^2 * m_flow * |m_flow|
        = 0.5*zeta/A^2 *1/rho * m_flow * |m_flow|
        = k/rho * m_flow * |m_flow|
        k  = 0.5*zeta/A^2
        = 0.5*zeta/(pi*(D/2)^2)^2
        = 8*zeta/(pi*D^2)^2
        */
        m_flow := Utilities.regRoot2(dp, dp_small, rho_a / k1, rho_b / k2);
        annotation(smoothOrder = 1, Documentation(info = "<html>
<p>
根据恒定损失系数和压降计算质量流量 (m_flow = f(dp))。
对于小压降 (dp &lt; dp_small)，该特性用多项式近似，以便在质量流量为零时具有有限导数。
</p>
</html>"    ));
      end massFlowRate_dp;

      function massFlowRate_dp_and_Re 
        "根据恒定损失系数、压降和 Re 值计算质量流量 (m_flow = f(dp))"
        extends Modelica.Icons.Function;
        import Modelica.Constants.pi;
        input SI.Pressure dp "压降 (dp = port_a.p - port_b.p)";
        input SI.Density rho_a "port_a 处密度";
        input SI.Density rho_b "port_b 处密度";
        input SI.DynamicViscosity mu_a "port_a 处动力黏度";
        input SI.DynamicViscosity mu_b "port_b 处动力黏度";
        input LossFactorData data 
          "两个流向的恒定损失系数" annotation(
          choices(
          choice = Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData.wallFriction(), 
          choice = Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData.suddenExpansion(), 
          choice = Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData.sharpEdgedOrifice()));
        output SI.MassFlowRate m_flow "port_a 到 port_b 的质量流量";

      protected
        Real k0 = 2 * data.c0 / (pi * data.D_Re ^ 3);
        Real k1 = lossConstant_D_zeta(if data.zeta1_at_a then data.diameter_a else data.diameter_b, data.zeta1);
        Real k2 = lossConstant_D_zeta(if data.zeta2_at_a then data.diameter_a else data.diameter_b, data.zeta2);
        Real yd0 
          "如果 data.zetaLaminarKnown，m_flow=m_flow(dp) 在零点的导数";
        SI.AbsolutePressure dp_turbulent 
          "湍流区为|dp| >= dp_turbulent";
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
        
        湍流区的起点是根据动力黏度 mu 和密度 rho 的平均值计算得出的。否则，就必须为两个流向引入不同的 "delta "值。为了简化方法，只使用一个 delta 值。
        
        层流区：
        dp = 0.5*zeta/(A^2*d) * m_flow * |m_flow|
        = 0.5 * c0/(|m_flow|*(4/pi)/(D_Re*mu)) / ((pi*(D_Re/2)^2)^2*d) * m_flow*|m_flow|
        = 0.5 * c0*(pi/4)*(D_Re*mu) * 16/(pi^2*D_Re^4*d) * m_flow*|m_flow|
        = 2*c0/(pi*D_Re^3) * mu/rho * m_flow
        = k0 * mu/rho * m_flow
        k0 = 2*c0/(pi*D_Re^3)
        
        为了使 dp=f(m_flow) 的导数在 m_flow=0 时连续，在层流区使用了 mu 和 d 的平均值： mu/rho = (mu_a + mu_b)/(rho_a + rho_b)
        如果 data.zetaLaminarKnown = false，则 mu_a 和 mu_b 可能为零（因为是假值），因此只有在 zetaLaminarKnown = true 时才会进行除法运算。
        */
        dp_turbulent := (k1 + k2) / (rho_a + rho_b) * 
          ((mu_a + mu_b) * data.D_Re * pi / 8) ^ 2 * data.Re_turbulent ^ 2;
        yd0 := if data.zetaLaminarKnown then 
          (rho_a + rho_b) / (k0 * (mu_a + mu_b)) else 0;
        m_flow := Utilities.regRoot2(dp, dp_turbulent, rho_a / k1, rho_b / k2, 
          data.zetaLaminarKnown, yd0);
        annotation(smoothOrder = 1, Documentation(info = "<html>
<p>
根据恒定损失系数和压降计算质量流量（m_flow = f(dp)）。
如果雷诺数 Re &ge; data.Re_turbulent，则将流动视为具有恒定损失系数 zeta 的湍流。
如果雷诺数 Re &lt; data.Re_turbulent，则流动为层流和/或层流与湍流之间的过渡区域。
该区域由两个三阶多项式近似，一个是 m_flow &ge; 0 时的多项式，另一个是 m_flow &lt; 0 时的多项式。
两个多项式在 Re = 0 时的导数由方程 \"data.c0/Re \"计算得出。
</p>
<p>
如果没有 c0 的数据，则计算 Re = 0 的导数时，使两个多项式的二阶导数在 Re = 0 时相同。
多项式的构造使其能够平滑湍流区域的特征曲线。
因此，整个特征曲线是<strong>连续的</strong>，并且在<strong>任何地方</strong>都具有<strong>有限</strong>、<strong>连续的一阶导数</strong>。
在某些情况下，构造的多项式会 \"振动\"。
通过减小 Re=0 时的导数可以避免这种情况，从而保证多项式单调递增。
所使用的单调性充分标准如下：
</p>

<dl>
<dt> Fritsch F.N. and Carlson R.E. (1980):</dt>
<dd> <strong>单调分块三次插值</strong>.
SIAM J. Numerc. Anal., Vol. 17, No. 2, April 1980, pp. 238-246</dd>
</dl>
</html>"    ));
      end massFlowRate_dp_and_Re;

      function pressureLoss_m_flow 
        "根据恒定损失系数和质量流量计算回流压降 (dp = f(m_flow))"
        extends Modelica.Icons.Function;

        input SI.MassFlowRate m_flow "port_a 到 port_b 的质量流量";
        input SI.Density rho_a "port_a 处密度";
        input SI.Density rho_b "port_b 处密度";
        input LossFactorData data 
          "两个流向的恒定损失系数" annotation(
          choices(
          choice = Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData.wallFriction(), 
          choice = Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData.suddenExpansion(), 
          choice = Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData.sharpEdgedOrifice()));
        input SI.MassFlowRate m_flow_small = 0.01 
          "如果 |m_flow| >= m_flow_small 则为湍流";
        output SI.Pressure dp "压降 (dp = port_a.p - port_b.p)";

      protected
        Real k1 = lossConstant_D_zeta(if data.zeta1_at_a then data.diameter_a else data.diameter_b, data.zeta1);
        Real k2 = lossConstant_D_zeta(if data.zeta2_at_a then data.diameter_a else data.diameter_b, data.zeta2);
      algorithm
        /*
        dp = 0.5*zeta*rho*v*|v|
        = 0.5*zeta*rho*1/(rho*A)^2 * m_flow * |m_flow|
        = 0.5*zeta/A^2 *1/rho * m_flow * |m_flow|
        = k/rho * m_flow * |m_flow|
        k  = 0.5*zeta/A^2
        = 0.5*zeta/(pi*(D/2)^2)^2
        = 8*zeta/(pi*D^2)^2
        */
        dp := Utilities.regSquare2(m_flow, m_flow_small, k1 / rho_a, k2 / rho_b);
        annotation(smoothOrder = 1, Documentation(info = "<html>
<p>
根据恒定损失系数和质量流量计算压降 (dp = f(m_flow))。
对于小质量流量（|m_flow| < m_flow_small），该特性用多项式近似，以便在质量流量为零时具有有限导数。
</p>
</html>"    ));
      end pressureLoss_m_flow;

      function pressureLoss_m_flow_and_Re 
        "根据恒定损失系数、质量流量和 Re 值计算回流压降 (dp = f(m_flow))"
        extends Modelica.Icons.Function;
        import Modelica.Constants.pi;
        input SI.MassFlowRate m_flow "port_a 到 port_b 的质量流量";
        input SI.Density rho_a "port_a 处密度";
        input SI.Density rho_b "port_b 处密度";
        input SI.DynamicViscosity mu_a "port_a 处动力黏度";
        input SI.DynamicViscosity mu_b "port_b 处动力黏度";
        input LossFactorData data 
          "两个流向的恒定损失系数" annotation(
          choices(
          choice = Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData.wallFriction(), 
          choice = Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData.suddenExpansion(), 
          choice = Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData.sharpEdgedOrifice()));
        output SI.Pressure dp "压降 (dp = port_a.p - port_b.p)";

      protected
        Real k0 = 2 * data.c0 / (pi * data.D_Re ^ 3);
        Real k1 = lossConstant_D_zeta(if data.zeta1_at_a then data.diameter_a else data.diameter_b, data.zeta1);
        Real k2 = lossConstant_D_zeta(if data.zeta2_at_a then data.diameter_a else data.diameter_b, data.zeta2);
        Real yd0 
          "如果 data.zetaLaminarKnown，dp = f(m_flow) 在零点的导数";
        SI.MassFlowRate m_flow_turbulent 
          "湍流区域为 |m_flow| >= m_flow_turbulent";
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
        
        湍流区的起点是根据动力黏度 mu 和密度 rho 的平均值计算得出的。否则，就必须为两个流向引入不同的 "delta "值。为了简化方法，只使用一个 delta 值。
        
        层流区：
        dp = 0.5*zeta/(A^2*d) * m_flow * |m_flow|
        = 0.5 * c0/(|m_flow|*(4/pi)/(D_Re*mu)) / ((pi*(D_Re/2)^2)^2*d) * m_flow*|m_flow|
        = 0.5 * c0*(pi/4)*(D_Re*mu) * 16/(pi^2*D_Re^4*d) * m_flow*|m_flow|
        = 2*c0/(pi*D_Re^3) * mu/rho * m_flow
        = k0 * mu/rho * m_flow
        k0 = 2*c0/(pi*D_Re^3)
        
        为了使 dp=f(m_flow) 的导数在 m_flow=0 时连续，在层流区使用了 mu 和 d 的平均值：mu/rho = (mu_a + mu_b)/(rho_a + rho_b)
        如果 data.zetaLaminarKnown = false，则 mu_a 和 mu_b 可能为零（因为是假值），因此只有在 zetaLaminarKnown = true 时才会进行除法运算。
        */
        m_flow_turbulent := (pi / 8) * data.D_Re * (mu_a + mu_b) * data.Re_turbulent;
        yd0 := if data.zetaLaminarKnown then k0 * (mu_a + mu_b) / (rho_a + rho_b) else 0;
        dp := Utilities.regSquare2(m_flow, m_flow_turbulent, k1 / rho_a, k2 / rho_b, 
          data.zetaLaminarKnown, yd0);
        annotation(smoothOrder = 1, Documentation(info = "<html>
<p>
根据恒定损失系数和质量流量计算压降（dp = f(m_flow)）。
如果雷诺数 Re &ge; data.Re_turbulent，则将流动视为具有恒定损失系数 zeta 的湍流。
如果雷诺数 Re &lt; data.Re_turbulent，则流动为层流和/或层流与湍流之间的过渡区域。
该区域由两个三阶多项式近似，一个是 m_flow &ge; 0 时的多项式，另一个是 m_flow &lt; 0 时的多项式。
两个多项式在 Re = 0 时的导数由方程 \"data.c0/Re \"计算得出。
</p>
<p>
如果没有 c0 的数据，则计算 Re = 0 的导数时，使两个多项式的二阶导数在 Re = 0 时相同。
多项式的构造使其能够平滑湍流区域的特征曲线。
因此，整个特征曲线是<strong>连续的</strong>，并且在<strong>任何地方</strong>都具有<strong>有限</strong>、<strong>连续的一阶导数</strong>。
在某些情况下，构造的多项式会 \"振动\"。
通过减小 Re=0 时的导数可以避免这种情况，从而保证多项式单调递增。
所使用的单调性充分标准如下：
</p>

<dl>
<dt> Fritsch F.N. and Carlson R.E. (1980):</dt>
<dd> <strong>单调分块三次插值</strong>.
SIAM J. Numerc. Anal., Vol. 17, No. 2, April 1980, pp. 238-246</dd>
</dl>
</html>"    ));
      end pressureLoss_m_flow_and_Re;

      partial model BaseModel 
        "具有恒定湍流损失系数且无图标的通用压降组件"

        extends Modelica.Fluid.Interfaces.PartialTwoPortTransport(
          dp_start = dp_nominal, 
          m_flow_small = if system.use_eps_Re then system.eps_m_flow * m_flow_nominal else system.m_flow_small, 
          m_flow(stateSelect = if momentumDynamics == Types.Dynamics.SteadyState then StateSelect.default 
          else StateSelect.prefer));
        extends Modelica.Fluid.Interfaces.PartialLumpedFlow(
          final pathLength = 0, 
          final momentumDynamics = Types.Dynamics.SteadyState);

        parameter LossFactorData data "损失系数数据";
        parameter SI.MassFlowRate m_flow_nominal = if system.use_eps_Re then system.m_flow_nominal else 1e2 * system.m_flow_small 
          "额定质量流量" 
          annotation(Dialog(group = "额定工作点"));

        // 高级
        parameter Boolean use_Re = system.use_eps_Re 
          "true: 湍流区由 Re 定义，否则由 m_flow_small 定义" 
          annotation(Evaluate = true, Dialog(tab = "高级"));
        parameter Boolean from_dp = true 
          "true: 使用 m_flow = f(dp) 否则 dp = f(m_flow)" 
          annotation(Evaluate = true, Dialog(tab = "高级"));
      protected
        parameter Medium.ThermodynamicState state_nominal = Medium.setState_pTX(
          Medium.reference_p, 
          Medium.reference_T, 
          Medium.reference_X) 
          "计算额定压降的介质状态";
        parameter SI.Pressure dp_nominal = 
          pressureLoss_m_flow(m_flow_nominal, Medium.density(state_nominal), Medium.density(state_nominal), data, m_flow_small) 
          "额定压力损失";
        parameter Medium.AbsolutePressure dp_small(min = 0) = if system.use_eps_Re then dp_nominal / m_flow_nominal * m_flow_small else system.dp_small 
          "如果 |dp| < dp_small，对零流量进行正则调整" 
          annotation(Dialog(tab = "高级", enable = not use_Re and from_dp));
        //参数 Medium.MassFlowRate m_flow_small = system.m_flow_small
        //  "如果 |m_flow| >= m_flow_small 则为湍流"
        //  annotation(Dialog(tab = "高级", enable=not from_dp));

        // 诊断
      public
        parameter Boolean show_Re = false 
          "true: 雷诺数包括在曲线图中" 
          annotation(Evaluate = true, Dialog(tab = "高级", group = "诊断"));
        SI.ReynoldsNumber Re = Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber_m_flow(
          m_flow, 
          noEvent(if m_flow > 0 then Medium.dynamicViscosity(state_a) else Medium.dynamicViscosity(state_b)), 
          data.D_Re) if show_Re "直径为 date.D_Re 时的雷诺数";

        // 变量
        SI.Pressure dp_fg 
          "摩擦和重力造成的压降";
        SI.Area A_mean = Modelica.Constants.pi / 4 * (data.diameter_a ^ 2 + data.diameter_b ^ 2) / 2 
          "平均横截面积";

      equation
        Ib_flow = 0;
        F_p = A_mean * (Medium.pressure(state_b) - Medium.pressure(state_a));
        F_fg = A_mean * dp_fg;
        if from_dp then
          m_flow = homotopy(if use_Re then 
            massFlowRate_dp_and_Re(
            dp_fg, Medium.density(state_a), Medium.density(state_b), 
            Medium.dynamicViscosity(state_a), 
            Medium.dynamicViscosity(state_b), 
            data) else 
            massFlowRate_dp(dp_fg, Medium.density(state_a), Medium.density(state_b), data, dp_small), 
            m_flow_nominal * dp_fg / dp_nominal);
        else
          dp_fg = homotopy(if use_Re then 
            pressureLoss_m_flow_and_Re(
            m_flow, Medium.density(state_a), Medium.density(state_b), 
            Medium.dynamicViscosity(state_a), 
            Medium.dynamicViscosity(state_b), 
            data) else 
            pressureLoss_m_flow(m_flow, Medium.density(state_a), Medium.density(state_b), data, m_flow_small), 
            dp_nominal * m_flow / m_flow_nominal);
        end if;

        // 等焓状态转换 (无能量储存，无能量损失)
        port_a.h_outflow = inStream(port_b.h_outflow);
        port_b.h_outflow = inStream(port_a.h_outflow);

        annotation(
          Documentation(info = "<html>
<p>
本模型只需通过参数数据提供最少量的数据，即可计算管道节块（孔口、弯曲等）的压力损失
如果有，可以提供<strong>两个流动方向</strong>的数据，即从 port_a 到 port_b 的流动和从 port_b 到 port_a 的流动，以及<strong>层流区</strong>和<strong>湍流区</strong>的数据。
也可以选择只提供从 port_a 流向 port_b 的<strong>湍流区</strong>的损失系数。
</p>
<p>
使用的公式如下
</p>
<blockquote><pre>
&Delta;p = 0.5*&zeta;*&rho;*v*|v|
= 0.5*&zeta;/A^2 * (1/&rho;) * m_flow*|m_flow|
= 8*&zeta;/(&pi;^2*D^4*&rho;) * m_flow*|m_flow|
Re = |v|*D*&rho;/&mu;
</pre></blockquote>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>流动状态</strong></td>
<td><strong>&zeta;</strong> = </td>
<td><strong>流动区域</strong></td></tr>
<tr><td>湍流</td>
<td><strong>zeta1</strong> = 常数</td>
<td>Re &ge;  Re_turbulent, v &ge; 0</td></tr>
<tr><td></td>
<td><strong>zeta2</strong> = 常数</td>
<td>Re &ge; Re_turbulent, v &lt; 0</td></tr>
<tr><td>层流</td>
<td><strong>c0</strong>/Re</td>
<td>两个流动方向，Re 很小；c0 = 常数</td></tr>
</table>
<p>
其中
</p>
<ul>
<li> &Delta;p 代表压降: &Delta;p = port_a.p - port_b.p</li>
<li> v 代表平均速度</li>
<li> &rho; 代表密度</li>
<li> &zeta; 代表损失系数，取决于管道的几何形状。在湍流状态下，假定 &zeta; 为常数，根据流向由 \"zeta1 \"和 \"zeta2 \"给出。<br>
当雷诺数 Re 低于 \"Re_turbulent \"时，小流速时为层流。
对于较高的流速，存在一个从层流到湍流的过渡区域。
小流速下层流的损失系数由经常出现的近似值 c0/Re 定义。
如果两个流动方向的 c0 不同，则必须使用平均值（c0 = (c0_ab + c0_ba)/2）。
</li>
<li> 公式 \"Δp = 0.5*ζ*ρ*v*|v|\"要么是针对 port_a，要么是针对 port_b，这取决于特定损失系数 &zeta; 的定义。
（在某些参考文献中，损失系数是针对 port_a 定义的，而在其他参考文献中，损失系数是针对 port_b 定义的。）
</li>
<li> Re = |v|*D_Re*ρ/μ = |m_flow|*D_Re/(A_Re*μ) 是最小截面积处的雷诺数。
这通常位于 port_a 或 port_b，但也可能位于两个接口之间。
在记录表中，必须提供该最小截面区域的直径 D_Re以及 Re_turbulent（即湍流开始时的雷诺数绝对值）。
如果两个流向的 Re_turbulent 数值不同，则使用较小的数值作为 Re_turbulent。
</li>
<li> D 代表管道直径。如果管道横截面不是圆形，则 D = 4*A/P，其中 A 是横截面积，P 是湿周。</li>
<li> A 代表横截面积，A = &pi;(D/2)^2。</li>
<li> &mu; 代表动力黏度</li>
</ul>
<p>
层流区和过渡区通常没有太大的意义，因为工作点大多处于湍流区。
出于简化和数值原因，整个流动区域由两个三阶多项式来描述，一个多项式用于 m_flow &ge; 0，另一个多项式用于 m_flow &lt; 0。
多项式的起点为 Re = |m_flow|*4/(&pi;*D_Re*&mu;)，其中 D_Re 是 port_a 和 port_b 之间的最小直径。
根据公式 \"c0/Re \"计算出两个多项式在 Re = 0 时的导数。
请注意，上述层流区域的压降方程是针对最小直径 D_Re 而定义的。
</p>
<p>
如果没有 c0 的数据，则计算 Re = 0 的导数时，使两个多项式的二阶导数在 Re = 0 时相同。
多项式的构造使其能够平滑湍流区域的特征曲线。
因此，整个特征曲线是<strong>连续的</strong>，并且在<strong>任何地方</strong>都具有<strong>有限</strong>、<strong>连续的一阶导数</strong>。
在某些情况下，构造的多项式会 \"振动\"。
通过减小 Re=0 时的导数可以避免这种情况，从而保证多项式单调递增。
所使用的单调性充分标准如下：
</p>

<dl>
<dt> Fritsch F.N. and Carlson R.E. (1980):</dt>
<dd> <strong>单调分块三次插值</strong>.
SIAM J. Numerc. Anal., Vol. 17, No. 2, April 1980, pp. 238-246</dd>
</dl>
</html>"    ));
      end BaseModel;

      partial model BaseModelNonconstantCrossSectionArea 
        "横截面面积不恒定时，具有恒定湍流损失系数且不带图标的通用压降"

        extends Modelica.Fluid.Interfaces.PartialTwoPortTransport(
          final dp_start = dp_nominal, 
          m_flow_small = if system.use_eps_Re then system.eps_m_flow * m_flow_nominal else system.m_flow_small, 
          m_flow(stateSelect = if momentumDynamics == Types.Dynamics.SteadyState then StateSelect.default 
          else StateSelect.prefer));
        extends Modelica.Fluid.Interfaces.PartialLumpedFlow(
          final pathLength = 0, 
          final momentumDynamics = Types.Dynamics.SteadyState);

        parameter LossFactorData data "损失系数数据";
        parameter SI.MassFlowRate m_flow_nominal = if system.use_eps_Re then system.m_flow_nominal else 1e2 * system.m_flow_small 
          "额定质量流量" 
          annotation(Dialog(group = "额定工作点"));

        // 高级
        /// 最终值以外的其他设置尚未执行 ///
        final parameter Boolean use_Re = false 
          "true: 湍流区由 Re 定义，否则由 m_flow_small 定义" 
          annotation(Evaluate = true, Dialog(tab = "高级"));
        final parameter Boolean from_dp = false 
          "true: 使用 m_flow = f(dp) 否则 dp = f(m_flow)" 
          annotation(Evaluate = true, Dialog(tab = "高级"));
        // 结束尚未执行/////////////////////////////////////////
      protected
        parameter Medium.ThermodynamicState state_nominal = Medium.setState_pTX(
          Medium.reference_p, 
          Medium.reference_T, 
          Medium.reference_X) 
          "计算额定压降的介质状态" annotation(HideResult = true);
        parameter SI.Pressure dp_nominal = 
          pressureLoss_m_flow(m_flow_nominal, Medium.density(state_nominal), Medium.density(state_nominal), data, m_flow_small) 
          "额定压力损失";
        parameter Medium.AbsolutePressure dp_small(min = 0) = if system.use_eps_Re then dp_nominal / m_flow_nominal * m_flow_small else system.dp_small 
          "如果 |dp| < dp_small，对零流量进行正则调整" 
          annotation(Dialog(tab = "高级", enable = not use_Re and from_dp));
        //参数 Medium.MassFlowRate m_flow_small = system.m_flow_small
        //  "如果 |m_flow| >= m_flow_small 则为湍流"
        //  annotation(Dialog(tab = "高级", enable=not from_dp));

        // 诊断
      public
        parameter Boolean show_Re = false 
          "true: 雷诺数包括在曲线图中" 
          annotation(Evaluate = true, Dialog(tab = "高级", group = "诊断"));
        SI.ReynoldsNumber Re = Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber_m_flow(
          m_flow, 
          noEvent(if m_flow > 0 then Medium.dynamicViscosity(state_a) else Medium.dynamicViscosity(state_b)), 
          data.D_Re) if show_Re "直径为 date.D_Re 时的雷诺数";
        parameter Boolean show_totalPressures = false 
          "true: 总压力包括在曲线图中" 
          annotation(Evaluate = true, Dialog(tab = "高级", group = "诊断"));
        SI.AbsolutePressure p_total_a = port_a.p + 0.5 * m_flow ^ 2 / ((Modelica.Constants.pi / 4 * data.diameter_a ^ 2) ^ 2 * noEvent(if port_a.m_flow > 0 then Medium.density(state_a) else Medium.density(state_b))) if 
          show_totalPressures "port_a 处总压";
        SI.AbsolutePressure p_total_b = port_b.p + 0.5 * m_flow ^ 2 / ((Modelica.Constants.pi / 4 * data.diameter_b ^ 2) ^ 2 * noEvent(if port_b.m_flow > 0 then Medium.density(state_b) else Medium.density(state_a))) if 
          show_totalPressures "port_b 处总压";
        parameter Boolean show_portVelocities = false 
          "true: 绘制时包括接口速度" 
          annotation(Evaluate = true, Dialog(tab = "高级", group = "诊断"));
        SI.Velocity v_a = port_a.m_flow / (Modelica.Constants.pi / 4 * data.diameter_a ^ 2 * noEvent(if port_a.m_flow > 0 then Medium.density(state_a) else Medium.density(state_b))) if 
          show_portVelocities "进入 port_a 的流速";
        SI.Velocity v_b = port_b.m_flow / (Modelica.Constants.pi / 4 * data.diameter_b ^ 2 * noEvent(if port_b.m_flow > 0 then Medium.density(state_b) else Medium.density(state_a))) if 
          show_portVelocities "进入 port_b 的流速";

        // 变量
        SI.Pressure dp_fg 
          "摩擦和重力造成的压降";
        SI.Area A_mean = Modelica.Constants.pi / 4 * (data.diameter_a ^ 2 + data.diameter_b ^ 2) / 2 
          "平均横截面积";

        Medium.ThermodynamicState state_b_des 
          "流向 a 到 b 时 port_b 的热力学状态";
        Medium.ThermodynamicState state_a_nondes 
          "流向 b 到 a 时 port_a 的热力学状态";

      equation
        Ib_flow = 0;
        F_p = A_mean * (Medium.pressure(state_b) - Medium.pressure(state_a));
        F_fg = A_mean * dp_fg;
        if from_dp then
          m_flow = if use_Re then 
            massFlowRate_dp_and_Re(
            dp_fg, Medium.density(state_a), Medium.density(state_b), 
            Medium.dynamicViscosity(state_a), 
            Medium.dynamicViscosity(state_b), 
            data) else 
            massFlowRate_dp(dp_fg, Medium.density(state_a), Medium.density(state_b), data, dp_small);
        else
          dp_fg = if use_Re then 
            pressureLoss_m_flow_and_Re(
            m_flow, Medium.density(state_a), Medium.density(state_b), 
            Medium.dynamicViscosity(state_a), 
            Medium.dynamicViscosity(state_b), 
            data) else 
            pressureLoss_m_flow_totalPressure(m_flow, 
            Medium.density(state_a), 
            Medium.density(state_b_des), 
            Medium.density(state_b), 
            Medium.density(state_a_nondes), 
            data, m_flow_small);
        end if;

        // 等焓状态转换 (无能量储存，无能量损失)
        port_a.h_outflow = inStream(port_b.h_outflow);
        port_b.h_outflow = inStream(port_a.h_outflow);

        // 对于下游的介质状态，可能需要对其进行修改，忽略 state_a 和 state_b 的唯一区别，即压力的区别。
        // 这将移除额外的交互变量
        state_b_des = Medium.setState_phX(port_b.p, inStream(port_a.h_outflow), inStream(port_a.Xi_outflow));
        state_a_nondes = Medium.setState_phX(port_a.p, inStream(port_b.h_outflow), inStream(port_b.Xi_outflow));

        annotation(
          Documentation(info = "<html>
<p>
本模型只需通过参数数据提供最少量的数据，即可计算管道节块（孔口、弯曲等）的压力损失
如果有，可以提供<strong>两个流动方向</strong>的数据，即从 port_a 到 port_b 的流动和从 port_b 到 port_a 的流动，以及<strong>层流区</strong>和<strong>湍流区</strong>的数据。
也可以选择只提供从 port_a 流向 port_b 的<strong>湍流区</strong>的损失系数。
</p>
<p>
使用的公式如下
</p>
<blockquote><pre>
&Delta;p = 0.5*&zeta;*&rho;*v*|v|
= 0.5*&zeta;/A^2 * (1/&rho;) * m_flow*|m_flow|
= 8*&zeta;/(&pi;^2*D^4*&rho;) * m_flow*|m_flow|
Re = |v|*D*&rho;/&mu;
</pre></blockquote>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>流动状态</strong></td>
<td><strong>&zeta;</strong> = </td>
<td><strong>流动区域</strong></td></tr>
<tr><td>湍流</td>
<td><strong>zeta1</strong> = 常数</td>
<td>Re &ge;  Re_turbulent, v &ge; 0</td></tr>
<tr><td></td>
<td><strong>zeta2</strong> = 常数</td>
<td>Re &ge; Re_turbulent, v &lt; 0</td></tr>
<tr><td>层流</td>
<td><strong>c0</strong>/Re</td>
<td>两个流动方向，Re 很小；c0 = 常数</td></tr>
</table>
<p>
其中
</p>
<ul>
<li> &Delta;p 代表压降: &Delta;p = port_a.p - port_b.p</li>
<li> v 代表平均速度</li>
<li> &rho; 代表密度</li>
<li> &zeta; 代表损失系数，取决于管道的几何形状。在湍流状态下，假定 &zeta; 为常数，根据流向由 \"zeta1 \"和 \"zeta2 \"给出。<br>
当雷诺数 Re 低于 \"Re_turbulent \"时，小流速时为层流。
对于较高的流速，存在一个从层流到湍流的过渡区域。
小流速下层流的损失系数由经常出现的近似值 c0/Re 定义。
如果两个流动方向的 c0 不同，则必须使用平均值（c0 = (c0_ab + c0_ba)/2）。
</li>
<li> 公式 \"Δp = 0.5*ζ*ρ*v*|v|\"要么是针对 port_a，要么是针对 port_b，这取决于特定损失系数 &zeta; 的定义。
（在某些参考文献中，损失系数是针对 port_a 定义的，而在其他参考文献中，损失系数是针对 port_b 定义的。）
</li>
<li> Re = |v|*D_Re*ρ/μ = |m_flow|*D_Re/(A_Re*μ) 是最小截面积处的雷诺数。
这通常位于 port_a 或 port_b，但也可能位于两个接口之间。
在记录表中，必须提供该最小截面区域的直径 D_Re以及 Re_turbulent（即湍流开始时的雷诺数绝对值）。
如果两个流向的 Re_turbulent 数值不同，则使用较小的数值作为 Re_turbulent。
</li>
<li> D 代表管道直径。如果管道横截面不是圆形，则 D = 4*A/P，其中 A 是横截面积，P 是湿周。</li>
<li> A 代表横截面积，A = &pi;(D/2)^2。</li>
<li> &mu; 代表动力黏度</li>
</ul>
<p>
层流区和过渡区通常没有太大的意义，因为工作点大多处于湍流区。
出于简化和数值原因，整个流动区域由两个三阶多项式来描述，一个多项式用于 m_flow &ge; 0，另一个多项式用于 m_flow &lt; 0。
多项式的起点为 Re = |m_flow|*4/(&pi;*D_Re*&mu;)，其中 D_Re 是 port_a 和 port_b 之间的最小直径。
根据公式 \"c0/Re \"计算出两个多项式在 Re = 0 时的导数。
请注意，上述层流区域的压降方程是针对最小直径 D_Re 而定义的。
</p>
<p>
如果没有 c0 的数据，则计算 Re = 0 的导数时，使两个多项式的二阶导数在 Re = 0 时相同。
多项式的构造使其能够平滑湍流区域的特征曲线。
因此，整个特征曲线是<strong>连续的</strong>，并且在<strong>任何地方</strong>都具有<strong>有限</strong>、<strong>连续的一阶导数</strong>。
在某些情况下，构造的多项式会 \"振动\"。
通过减小 Re=0 时的导数可以避免这种情况，从而保证多项式单调递增。
所使用的单调性充分标准如下：
</p>

<dl>
<dt> Fritsch F.N. and Carlson R.E. (1980):</dt>
<dd> <strong>单调分块三次插值</strong>.
SIAM J. Numerc. Anal., Vol. 17, No. 2, April 1980, pp. 238-246</dd>
</dl>
</html>"    ));
      end BaseModelNonconstantCrossSectionArea;

      function pressureLoss_m_flow_totalPressure 
        "根据恒定损失系数和质量流量计算回流压降 (dp = f(m_flow))"
        extends Modelica.Icons.Function;

        input SI.MassFlowRate m_flow "port_a 到 port_b 的质量流量";
        input SI.Density rho_a_des 
          "port_a 的密度，设计方向 a 到 b 的质量流量";
        input SI.Density rho_b_des 
          "port_b 的密度，设计方向 a 到 b 的质量流量";
        input SI.Density rho_b_nondes 
          "port_b 的密度，反设计方向 b 到 a 的质量流量";
        input SI.Density rho_a_nondes 
          "port_a 的密度，反设计方向 b 到 a 的质量流量";
        input LossFactorData data 
          "两个流向的恒定损失系数" annotation(
          choices(
          choice = Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData.wallFriction(), 
          choice = Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData.suddenExpansion(), 
          choice = Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData.sharpEdgedOrifice()));
        input SI.MassFlowRate m_flow_small = 0.01 
          "如果 |m_flow| >= m_flow_small 则为湍流";
        output SI.Pressure dp "压降 (dp = port_a.p - port_b.p)";

      protected
        SI.Area A_a = Modelica.Constants.pi * data.diameter_a ^ 2 / 4 
          "port_a 的横截面积";
        SI.Area A_b = Modelica.Constants.pi * data.diameter_b ^ 2 / 4 
          "port_b 的横截面积";
      algorithm
        dp := 1 / 2 * m_flow ^ 2 * (if m_flow > 0 then 
          data.zeta1 / (if data.zeta1_at_a then rho_a_des * A_a ^ 2 else rho_b_des * A_b ^ 2) - 1 / (rho_a_des * A_a ^ 2) + 1 / (rho_b_des * A_b ^ 2) else 
          -data.zeta2 / (if data.zeta2_at_a then rho_a_nondes * A_a ^ 2 else rho_b_nondes * A_b ^ 2) - 1 / (rho_a_nondes * A_a ^ 2) + 1 / (rho_b_nondes * A_b ^ 2));
        annotation(smoothOrder = 1, Documentation(info = "<html>
<p>
根据恒定损失系数和质量流量计算压降 (dp = f(m_flow))。
对于小质量流量（|m_flow| < m_flow_small），该特性用多项式近似，以便在质量流量为零时具有有限导数。
</p>
</html>"    ));
      end pressureLoss_m_flow_totalPressure;
      annotation(Documentation(info = "<html>
<p>
该库以最少的数据量提供管道节块（孔口、弯曲等）的压力损失系数。
如果有，可以提供<strong>两个流动方向</strong>的数据，即从 port_a 到 port_b 的流动和从 port_b 到 port_a 的流动，以及<strong>层流区</strong>和<strong>湍流区</strong>的数据。
也可以选择只提供从 port_a 流向 port_b 的<strong>湍流区</strong>的损失系数。
基本上，压降由以下公式定义：
</p>
<blockquote><pre>
&Delta;p = 0.5*&zeta;*&rho;*v*|v|
= 0.5*&zeta;/A^2 * (1/&rho;) * m_flow*|m_flow|
= 8*&zeta;/(&pi;^2*D^4*&rho;) * m_flow*|m_flow|
</pre></blockquote>
<p>
其中
</p>
<ul>
<li> &Delta;p 代表压降: &Delta;p = port_a.p - port_b.p</li>
<li> v 代表平均速度</li>
<li> &rho; 代表密度</li>
<li> &zeta; 代表损失系数，取决于管道的几何形状。在湍流状态下，假定 &zeta; 为常数，根据流向由 \"zeta1 \"和 \"zeta2 \"给出。</li>
<li> D 代表管段的直径。如果不是圆形截面，则 D = 4*A/P，其中 A 是截面面积，P 是湿周。</li>
</ul>

</html>"    ));
    end QuadraticTurbulent;

    partial model PartialTeeJunction 
      "具有三个接口的分流/合流组件的基类"
      import Modelica.Fluid.Types;
      import Modelica.Fluid.Types.PortFlowDirection;

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium 
        "组件中的介质" 
        annotation(choicesAllMatching = true);

      Modelica.Fluid.Interfaces.FluidPort_a port_1(redeclare package Medium = 
        Medium, m_flow(min = if (portFlowDirection_1 == PortFlowDirection.Entering) then 
        0.0 else -Modelica.Constants.inf, max = if (portFlowDirection_1 
        == PortFlowDirection.Leaving) then 0.0 else Modelica.Constants.inf)) 
        annotation(Placement(transformation(extent = {{-110, -10}, {-90, 10}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_2(redeclare package Medium = 
        Medium, m_flow(min = if (portFlowDirection_2 == PortFlowDirection.Entering) then 
        0.0 else -Modelica.Constants.inf, max = if (portFlowDirection_2 
        == PortFlowDirection.Leaving) then 0.0 else Modelica.Constants.inf)) 
        annotation(Placement(transformation(extent = {{90, -10}, {110, 10}})));
      Modelica.Fluid.Interfaces.FluidPort_a port_3(
      redeclare package Medium = Medium, 
        m_flow(min = if (portFlowDirection_3 == PortFlowDirection.Entering) then 0.0 else -Modelica.Constants.inf, 
        max = if (portFlowDirection_3 == PortFlowDirection.Leaving) then 0.0 else Modelica.Constants.inf)) 
        annotation(Placement(transformation(extent = {{-10, 90}, {10, 110}})));

    protected
      parameter PortFlowDirection portFlowDirection_1 = PortFlowDirection.Bidirectional 
        "port_1 的流向" 
        annotation(Dialog(tab = "高级"));
      parameter PortFlowDirection portFlowDirection_2 = PortFlowDirection.Bidirectional 
        "port_2 的流向" 
        annotation(Dialog(tab = "高级"));
      parameter PortFlowDirection portFlowDirection_3 = PortFlowDirection.Bidirectional 
        "port_3 的流向" 
        annotation(Dialog(tab = "高级"));

      annotation(Icon(coordinateSystem(
        preserveAspectRatio = true, 
        extent = {{-100, -100}, {100, 100}}), graphics = {
        Rectangle(
        extent = {{-100, 44}, {100, -44}}, 
        fillPattern = FillPattern.HorizontalCylinder, 
        fillColor = {0, 127, 255}), 
        Text(
        extent = {{-150, -89}, {150, -129}}, 
        textColor = {0, 0, 255}, 
        textString = "%name"), 
        Rectangle(
        extent = {{-44, 100}, {44, 44}}, 
        fillPattern = FillPattern.VerticalCylinder, 
        fillColor = {0, 127, 255}), 
        Rectangle(
        extent = {{-22, 82}, {21, -4}}, 
        fillPattern = FillPattern.Solid, 
        fillColor = {0, 128, 255}, 
        pattern = LinePattern.None)}));
    end PartialTeeJunction;

    package Bends "弯管的压力损失函数"
      extends Modelica.Icons.VariantsPackage;

      package CurvedBend "弯头的压力损失函数"
        extends Modelica.Icons.Package;

        function massFlowRate 
          "计算质量流量 m_flow 与弯头压力损失 dp 的函数关系"
          extends Modelica.Icons.Function;
          input SI.Pressure dp "压降";
          input Geometry geometry "弯头几何形状";
          input SI.Density d_a 
            "当流体从 port_a 流向 port_b 时，port_a 的密度";
          input SI.Density d_b 
            "当流体从 port_b 流向 port_a 时，port_b 的密度";
          input SI.DynamicViscosity eta_a 
            "当流体从 port_a 流向 port_b 时，port_a 的动力黏度";
          input SI.DynamicViscosity eta_b 
            "当流体从 port_b 流向 port_a 时，port_b 的动力黏度";
          input SI.AbsolutePressure dp_small 
            "如果 m_flow=f(...,dp_small,...,dp)，用于正则化的小压降";
          input SI.MassFlowRate m_flow_small 
            "如果 dp=f_inv(...,m_flow_small,m_flow)，用于正则化的小质量流量";
          output SI.MassFlowRate m_flow "质量流量 (= port_a.m_flow)";
        algorithm
          m_flow := Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_MFLOW(
            geometry, 
            Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_IN_var(
            rho = Modelica.Fluid.Utilities.regStep(dp, d_a, d_b, dp_small), 
            eta = Modelica.Fluid.Utilities.regStep(dp, eta_a, eta_b, dp_small)), 
            dp);

          annotation(Inline = false, LateInline = true, 
            inverse(dp = Modelica.Fluid.Fittings.BaseClasses.Bends.CurvedBend.pressureLoss(
            m_flow, geometry, d_a, d_b, eta_a, eta_b, dp_small, m_flow_small)), 
            Documentation(info = "<html>
<p>
该函数计算弯头质量流量 m_flow 与压力损失 dp 的函数关系。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Bend.dp_curvedOverall\">此处</a>介绍了函数的详细信息。
</p>

<p>
弯管特性适用于恒定密度和恒定动力黏度。它也可近似用于可压缩介质。这需要提供上游密度和上游动力黏度。
为了能够在零质量流量附近对密度和动力黏度进行正则化，必须在流体从 port_a 流向 port_b 情况下给出 (d_a, eta_a)，流体从 port_b 流向 port_a 的情况下给出 (d_b, eta_b)。
</p>

</html>"            ));
        end massFlowRate;

        function pressureLoss 
          "计算压降 dp 与弯头质量流量 m_flow 的函数关系"
          extends Modelica.Icons.Function;

          input SI.MassFlowRate m_flow "质量流量 (= port_a.m_flow)";
          input Geometry geometry "弯头几何形状";
          input SI.Density d_a 
            "当流体从 port_a 流向 port_b 时，port_a 的密度";
          input SI.Density d_b 
            "当流体从 port_b 流向 port_a 时，port_b 的密度";
          input SI.DynamicViscosity eta_a 
            "当流体从 port_a 流向 port_b 时，port_a 的动力黏度";
          input SI.DynamicViscosity eta_b 
            "当流体从 port_b 流向 port_a 时，port_b 的动力黏度";
          input SI.AbsolutePressure dp_small 
            "如果 m_flow=f(...,dp_small,...,dp)，用于正则化的小压降";
          input SI.MassFlowRate m_flow_small 
            "如果 dp=f_inv(...,m_flow_small,m_flow)，用于正则化的小质量流量";
          output SI.Pressure dp "压降";
        algorithm
          dp := Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_DP(
            geometry, 
            Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_IN_var(
            rho = Modelica.Fluid.Utilities.regStep(m_flow, d_a, d_b, m_flow_small), 
            eta = Modelica.Fluid.Utilities.regStep(m_flow, eta_a, eta_b, m_flow_small)), 
            m_flow);

          annotation(Inline = true, Documentation(info = "<html>
<p>
该函数计算弯头的压力损失 dp 与质量流量 m_flow 的函数关系。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Bend.dp_curvedOverall\">此处</a>介绍了函数的详细信息。
</p>

<p>
弯管特性适用于恒定密度和恒定动力黏度。它也可近似用于可压缩介质。这需要提供上游密度和上游动力黏度。
为了能够在零质量流量附近对密度和动力黏度进行正则化，必须在流体从 port_a 流向 port_b 情况下给出 (d_a, eta_a)，流体从 port_b 流向 port_a 的情况下给出 (d_b, eta_b)。
</p>
</html>"            ));
        end pressureLoss;

        record Geometry "弯头几何数据"
          extends Modelica.Icons.Record;

          SI.Diameter d_hyd "水力直径" 
            annotation(Dialog);
          SI.Radius R_0 "曲率半径" annotation(Dialog);
          SI.Angle delta = 1.5707963267949 "转弯角度" annotation(Dialog);
          Modelica.Fluid.Types.Roughness K = 2.5e-5 
            "绝对粗糙度，默认为光滑钢管" 
            annotation(Dialog);
          annotation(Documentation(info = "<html>
<p>
该记录表用于定义弯头的几何（常数）数据。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Bend.dp_curvedOverall\">此处</a>将详细介绍该记录。
</p>
</html>"    ));
        end Geometry;
        annotation(Documentation(info = "<html>
<p>
该子库包含弯头组件的公用函数和记录表。
</p>

</html>"    ));
      end CurvedBend;

      package EdgedBend "直角弯管的压力损失函数"
        extends Modelica.Icons.Package;

        function massFlowRate 
          "计算质量流量 m_flow 与直角弯管压降 dp 的函数关系"
          extends Modelica.Icons.Function;

          input SI.Pressure dp "压降";
          input Geometry geometry "直角弯管几何形状";
          input SI.Density d_a 
            "当流体从 port_a 流向 port_b 时，port_a 的密度";
          input SI.Density d_b 
            "当流体从 port_b 流向 port_a 时，port_b 的密度";
          input SI.DynamicViscosity eta_a 
            "当流体从 port_a 流向 port_b 时，port_a 的动力黏度";
          input SI.DynamicViscosity eta_b 
            "当流体从 port_b 流向 port_a 时，port_b 的动力黏度";
          input SI.AbsolutePressure dp_small 
            "如果 m_flow=f(...,dp_small,...,dp)，用于正则化的小压降";
          input SI.MassFlowRate m_flow_small 
            "如果 dp=f_inv(...,m_flow_small,m_flow)，用于正则化的小质量流量";
          output SI.MassFlowRate m_flow "质量流量 (= port_a.m_flow)";
        algorithm
          m_flow := Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_MFLOW(
            Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_IN_con(
            d_hyd = geometry.d_hyd, 
            delta = geometry.delta, 
            K = geometry.K), 
            Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_IN_var(
            rho = Modelica.Fluid.Utilities.regStep(dp, d_a, d_b, dp_small), 
            eta = Modelica.Fluid.Utilities.regStep(dp, eta_a, eta_b, dp_small)), 
            dp);

          annotation(Inline = false, LateInline = true, 
            inverse(dp = Modelica.Fluid.Fittings.BaseClasses.Bends.EdgedBend.pressureLoss(
            m_flow, geometry, d_a, d_b, eta_a, eta_b, dp_small, m_flow_small)), 
            Documentation(info = "<html>
<p>
该函数计算直角弯管的质量流量 m_flow与压力损失 dp 的函数关系。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Bend.dp_edgedOverall\">此处</a>介绍了函数的详细信息。
</p>

<p>
弯管特性适用于恒定密度和恒定动力黏度。它也可近似用于可压缩介质。这需要提供上游密度和上游动力黏度。
为了能够在零质量流量附近对密度和动力黏度进行正则化，必须在流体从 port_a 流向 port_b 情况下给出 (d_a, eta_a)，流体从 port_b 流向 port_a 的情况下给出 (d_b, eta_b)。
</p>

</html>"                  ));
        end massFlowRate;

        function pressureLoss 
          "计算压力损失 dp 与直角弯管质量流量 m_flow 的函数关系"
          extends Modelica.Icons.Function;

          input SI.MassFlowRate m_flow "质量流量 (= port_a.m_flow)";
          input Geometry geometry "直角弯管几何形状";
          input SI.Density d_a 
            "当流体从 port_a 流向 port_b 时，port_a 的密度";
          input SI.Density d_b 
            "当流体从 port_b 流向 port_a 时，port_b 的密度";
          input SI.DynamicViscosity eta_a 
            "当流体从 port_a 流向 port_b 时，port_a 的动力黏度";
          input SI.DynamicViscosity eta_b 
            "当流体从 port_b 流向 port_a 时，port_b 的动力黏度";
          input SI.AbsolutePressure dp_small 
            "如果 m_flow=f(...,dp_small,...,dp)，用于正则化的小压降";
          input SI.MassFlowRate m_flow_small 
            "如果 dp=f_inv(...,m_flow_small,m_flow)，用于正则化的小质量流量";
          output SI.Pressure dp "压降";
        algorithm
          dp := Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_DP(
            Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_IN_con(
            d_hyd = geometry.d_hyd, 
            delta = geometry.delta, 
            K = geometry.K), 
            Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_IN_var(
            rho = Modelica.Fluid.Utilities.regStep(m_flow, d_a, d_b, m_flow_small), 
            eta = Modelica.Fluid.Utilities.regStep(m_flow, eta_a, eta_b, m_flow_small)), 
            m_flow);

          annotation(Inline = true, Documentation(info = "<html>
<p>
该函数计算直角弯管的质量流量 m_flow 与压力损失 dp的函数关系。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Bend.dp_edgedOverall\">此处</a>介绍了函数的详细信息。
</p>

<p>
弯管特性适用于恒定密度和恒定动力黏度。它也可近似用于可压缩介质。这需要提供上游密度和上游动力黏度。
为了能够在零质量流量附近对密度和动力黏度进行正则化，必须在流体从 port_a 流向 port_b 情况下给出 (d_a, eta_a)，流体从 port_b 流向 port_a 的情况下给出 (d_b, eta_b)。
</p>
</html>"                  ));
        end pressureLoss;

        record Geometry "直角弯管的几何数据"
          extends Modelica.Icons.Record;

          SI.Diameter d_hyd "水力直径" 
            annotation(Dialog);
          SI.Angle delta "转弯角度" annotation(Dialog);
          Modelica.Fluid.Types.Roughness K = 2.5e-5 
            "绝对粗糙度，默认为光滑钢管" 
            annotation(Dialog);
          annotation(Documentation(info = "<html>
<p>
该记录表用于定义直角弯管的几何（常数）数据。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Bend.dp_edgedOverall\">此处</a>将详细介绍该记录。
</p>
</html>"          ));
        end Geometry;
        annotation(Documentation(info = "<html>
<p>
该子库包含直角弯管组件的公用函数和记录表。
</p>

</html>"          ));
      end EdgedBend;
      annotation();
    end Bends;

    package Orifices "孔口压力损失函数"
      extends Modelica.Icons.VariantsPackage;
      package ThickEdgedOrifice 
        "厚边孔口的压力损失函数"
        extends Modelica.Icons.Package;

        function massFlowRate 
          "计算质量流量 m_flow 与厚边孔口压降 dp 的函数关系"
          extends Modelica.Icons.Function;

          input SI.Pressure dp "压降";
          input Geometry geometry "厚边孔口的几何形状";
          input SI.Density d_a 
            "当流体从 port_a 流向 port_b 时，port_a 的密度";
          input SI.Density d_b 
            "当流体从 port_b 流向 port_a 时，port_b 的密度";
          input SI.DynamicViscosity eta_a 
            "当流体从 port_a 流向 port_b 时，port_a 的动力黏度";
          input SI.DynamicViscosity eta_b 
            "当流体从 port_b 流向 port_a 时，port_b 的动力黏度";
          input SI.AbsolutePressure dp_small 
            "如果 m_flow=f(...,dp_small,...,dp)，用于正则化的小压降";
          input SI.MassFlowRate m_flow_small 
            "如果 dp=f_inv(...,m_flow_small,m_flow)，用于正则化的小质量流量";
          output SI.MassFlowRate m_flow "质量流量 (= port_a.m_flow)";
        algorithm
          m_flow := Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_MFLOW(
            Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_IN_con(
            A_0 = geometry.venaCrossArea, 
            A_1 = geometry.crossArea, 
            C_0 = geometry.venaPerimeter, 
            C_1 = geometry.perimeter, 
            L = geometry.venaLength, 
            dp_smooth = dp_small), 
            Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_IN_var(
            rho = Modelica.Fluid.Utilities.regStep(dp, d_a, d_b, dp_small), 
            eta = Modelica.Fluid.Utilities.regStep(dp, eta_a, eta_b, dp_small)), 
            dp);
          annotation(Inline = false, LateInline = true, 
            inverse(dp = Modelica.Fluid.Fittings.BaseClasses.Orifices.ThickEdgedOrifice.pressureLoss(
            m_flow, geometry, d_a, d_b, eta_a, eta_b, dp_small, m_flow_small)), 
            Documentation(info = "<html>
<p>
该函数计算厚边孔口的质量流量 m_flow 与压力损失 dp 的函数关系。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Orifice.dp_thickEdgedOverall\">此处</a>介绍了函数的详细信息。
</p>

<p>
孔口特性适用于恒定密度和恒定动态黏度。它也可近似用于可压缩介质。这需要提供上游密度和上游动力黏度。
为了能够在零质量流量附近对密度和动力黏度进行正则化，必须在流体从 port_a 流向 port_b 情况下给出 (d_a, eta_a)，流体从 port_b 流向 port_a 的情况下给出 (d_b, eta_b)。
</p>

</html>"            ));
        end massFlowRate;

        function pressureLoss 
          "计算厚边孔口的压力损失 dp 与质量流量 m_flow 的函数关系"
          extends Modelica.Icons.Function;

          input SI.MassFlowRate m_flow "质量流量 (= port_a.m_flow)";
          input Geometry geometry "厚边孔口的几何形状";
          input SI.Density d_a 
            "当流体从 port_a 流向 port_b 时，port_a 的密度";
          input SI.Density d_b 
            "当流体从 port_b 流向 port_a 时，port_b 的密度";
          input SI.DynamicViscosity eta_a 
            "当流体从 port_a 流向 port_b 时，port_a 的动力黏度";
          input SI.DynamicViscosity eta_b 
            "当流体从 port_b 流向 port_a 时，port_b 的动力黏度";
          input SI.AbsolutePressure dp_small 
            "如果 m_flow=f(...,dp_small,...,dp)，用于正则化的小压降";
          input SI.MassFlowRate m_flow_small 
            "如果 dp=f_inv(...,m_flow_small,m_flow)，用于正则化的小质量流量";
          output SI.Pressure dp "Pressure loss";
        algorithm
          dp := Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_DP(
            Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_IN_con(
            A_0 = geometry.venaCrossArea, 
            A_1 = geometry.crossArea, 
            C_0 = geometry.venaPerimeter, 
            C_1 = geometry.perimeter, 
            L = geometry.venaLength, 
            dp_smooth = dp_small), 
            Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_IN_var(
            rho = Modelica.Fluid.Utilities.regStep(m_flow, d_a, d_b, m_flow_small), 
            eta = Modelica.Fluid.Utilities.regStep(m_flow, eta_a, eta_b, m_flow_small)), 
            m_flow);

          annotation(Inline = true, Documentation(info = "<html>
<p>
该函数计算厚边孔板的压力损失 dp 与质量流量 m_flow 的函数关系。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Orifice.dp_thickEdgedOverall\">此处</a>介绍了函数的详细信息。
</p>

<p>
孔口特性适用于恒定密度和恒定动态黏度。它也可近似用于可压缩介质。这需要提供上游密度和上游动力黏度。
为了能够在零质量流量附近对密度和动力黏度进行正则化，必须在流体从 port_a 流向 port_b 情况下给出 (d_a, eta_a)，流体从 port_b 流向 port_a 的情况下给出 (d_b, eta_b)。
</p>
</html>"            ));
        end pressureLoss;

        record Geometry "厚边孔口的几何数据"
          extends Modelica.Icons.Record;

          SI.Area crossArea "内部横截面积" 
            annotation(Dialog);
          SI.Length perimeter "内周长" 
            annotation(Dialog);

          SI.Area venaCrossArea "缩流断面处的横截面积" 
            annotation(Dialog);
          SI.Length venaPerimeter "缩流断面周长" 
            annotation(Dialog);
          SI.Length venaLength "缩流断面长度" 
            annotation(Dialog);

          annotation(Documentation(info = "<html>
<p>
该记录表用于定义厚边孔口的几何（常数）数据。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Orifice.dp_thickEdgedOverall\">此处</a>说明记录表的详细信息。
</p>
</html>"    ));
        end Geometry;

        package Choices "几何选项"
          extends Modelica.Icons.Package;

          function circular "圆形横截面"
            import Modelica.Constants.pi;

            input SI.Diameter diameter "圆孔内径" 
              annotation(Dialog);
            input SI.Diameter venaDiameter "缩流断面直径" 
              annotation(Dialog);
            input SI.Length venaLength "缩流断面长度" 
              annotation(Dialog);

            output ThickEdgedOrifice.Geometry geometry 
              "厚边孔口的几何形状";
          algorithm
            geometry.crossArea := diameter ^ 2 * pi / 4;
            geometry.perimeter := pi * diameter;
            geometry.venaCrossArea := venaDiameter ^ 2 * pi / 4;
            geometry.venaPerimeter := pi * venaDiameter;
            geometry.venaLength := venaLength;
            annotation(Icon(coordinateSystem(preserveAspectRatio = false, 
              extent = {{-100, -100}, {100, 100}}), graphics = {Ellipse(
              extent = {{-80, 80}, {80, -80}}, 
              fillColor = {255, 255, 255}, 
              fillPattern = FillPattern.Solid)}), 
              Documentation(revisions = "", 
              info = "<html>
<p>
计算圆形孔口截面的 ThickEdgedOrifice.Geometry 函数。
</p>
</html>"    ));
          end circular;

          function rectangular "矩形横截面"
            import Modelica.Constants.pi;

            input SI.Length width "矩形孔内部宽度" 
              annotation(Dialog);
            input SI.Length height "矩形孔的内部高度" 
              annotation(Dialog);
            input SI.Length venaWidth "缩流断面宽度" 
              annotation(Dialog);
            input SI.Length venaHeight "缩流断面高度" 
              annotation(Dialog);
            input SI.Length venaLength "缩流断面长度" 
              annotation(Dialog);

            output ThickEdgedOrifice.Geometry geometry 
              "厚边孔口的几何形状";
          algorithm
            geometry.crossArea := width * height;
            geometry.perimeter := 2 * width + 2 * height;
            geometry.venaCrossArea := venaWidth * venaHeight;
            geometry.venaPerimeter := 2 * venaWidth + 2 * venaHeight;
            geometry.venaLength := venaLength;
            annotation(Icon(coordinateSystem(preserveAspectRatio = true, 
              extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(
              extent = {{-80, 60}, {80, -60}}, 
              fillColor = {255, 255, 255}, 
              fillPattern = FillPattern.Solid)}), 
              Documentation(revisions = "", 
              info = "<html>
<p>
计算矩形孔口截面的 ThickEdgedOrifice.Geometry 的函数。
</p>
</html>"    ));
          end rectangular;

          function general "一般横截面"
            import Modelica.Constants.pi;

            input SI.Area crossArea "内部横截面积" 
              annotation(Dialog);
            input SI.Length perimeter "内周长" 
              annotation(Dialog);

            input SI.Area venaCrossArea 
              "缩流断面横截面积" 
              annotation(Dialog);
            input SI.Length venaPerimeter "缩流断面周长" 
              annotation(Dialog);
            input SI.Length venaLength "缩流断面长度" 
              annotation(Dialog);

            output ThickEdgedOrifice.Geometry geometry 
              "厚边孔口的几何形状";
          algorithm
            geometry.crossArea := crossArea;
            geometry.perimeter := perimeter;
            geometry.venaCrossArea := venaCrossArea;
            geometry.venaPerimeter := venaPerimeter;
            geometry.venaLength := venaLength;
            annotation(Icon(coordinateSystem(preserveAspectRatio = false, 
              extent = {{-100, -100}, {100, 100}}), graphics = {
              Polygon(
              points = {{-80, 8}, {0, 80}, {80, 40}, {20, -20}, {40, -80}, {-60, -80}, {-80, 8}}, 
              fillColor = {255, 255, 255}, 
              fillPattern = FillPattern.Solid)}), 
              Documentation(revisions = "", 
              info = "<html>
<p>
计算一般横截面孔口的 ThickEdgedOrifice.Geometry 的函数。
</p>
</html>"    ));
          end general;
          annotation(Documentation(info = "<html>
<p>
选择计算厚边孔的\"几何\"记录表。
</p>
</html>"    ));
        end Choices;
        annotation(Documentation(info = "<html>
<p>
该子库包含厚边孔口组件的公用函数和记录表。
</p>
</html>"    ));
      end ThickEdgedOrifice;
      annotation();
    end Orifices;

    package GenericResistances 
      "通用且与几何形状无关的流动阻力的压降函数"
      extends Modelica.Icons.VariantsPackage;
      package VolumeFlowRate 
        "以体积流量为参数的通用阻力的压降函数"
        extends Modelica.Icons.Package;

        function massFlowRate 
          "计算质量流量 m_flow 与弯管压降 dp 的函数关系"
          extends Modelica.Icons.Function;

          input SI.Pressure dp "压降";
          input Real a(unit = "(Pa.s2)/m6") 
            "二次项系数 (dp = a*V_flow^2 + b*V_flow)";
          input Real b(unit = "(Pa.s)/m3") 
            "一次项系数 (dp = a*V_flow^2 + b*V_flow)";
          input SI.Density d_a 
            "当流体从 port_a 流向 port_b 时，port_a 的密度";
          input SI.Density d_b 
            "当流体从 port_b 流向 port_a 时，port_b 的密度";
          input SI.AbsolutePressure dp_small 
            "如果 m_flow=f(...,dp_small,...,dp)，用于正则化的小压降";
          input SI.MassFlowRate m_flow_small 
            "如果 dp=f_inv(...,m_flow_small,m_flow)，用于正则化的小质量流量";
          output SI.MassFlowRate m_flow "质量流量 (= port_a.m_flow)";
        algorithm
          m_flow := Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_MFLOW(
            Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_IN_con(
            a = a, 
            b = b, 
            dp_min = dp_small), 
            Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_IN_var(
            rho = Modelica.Fluid.Utilities.regStep(dp, d_a, d_b, dp_small)), 
            dp);

          annotation(LateInline = true, 
            inverse(dp = Modelica.Fluid.Fittings.BaseClasses.GenericResistances.VolumeFlowRate.pressureLoss(
            m_flow, a, b, d_a, d_b, dp_small, m_flow_small)), 
            Documentation(info = "<html>
<p>
该函数计算弯管质量流量 m_flow，作为的压力损失 dp 的函数。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_volumeFlowRate\">此处</a>介绍了函数的详细信息。
</p>

<p>
弯管特性适用于恒定密度和恒定动力黏度。它也可近似用于可压缩介质。这需要提供上游密度和上游动力黏度。
为了能够在零质量流量附近对密度和动力黏度进行正则化，必须在流体从 port_a 流向 port_b 情况下给出 (d_a, eta_a)，流体从 port_b 流向 port_a 的情况下给出 (d_b, eta_b)。
</p>

</html>"            ));
        end massFlowRate;

        function pressureLoss 
          "计算压降 dp 与弯管质量流量 m_flow 的函数关系"
          extends Modelica.Icons.Function;

          input SI.MassFlowRate m_flow "质量流量 (= port_a.m_flow)";
          input Real a(unit = "(Pa.s2)/m6") 
            "二次项系数 (dp = a*V_flow^2 + b*V_flow)";
          input Real b(unit = "(Pa.s)/m3") 
            "一次项系数 (dp = a*V_flow^2 + b*V_flow)";
          input SI.Density d_a 
            "当流体从 port_a 流向 port_b 时，port_a 的密度";
          input SI.Density d_b 
            "当流体从 port_b 流向 port_a 时，port_b 的密度";
          input SI.AbsolutePressure dp_small 
            "如果 m_flow=f(...,dp_small,...,dp)，用于正则化的小压降";
          input SI.MassFlowRate m_flow_small 
            "S如果 dp=f_inv(...,m_flow_small,m_flow)，用于正则化的小质量流量";
          output SI.Pressure dp "压降";
        algorithm
          dp := Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_DP(
            Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_IN_con(
            a = a, 
            b = b, 
            dp_min = dp_small), 
            Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_IN_var(
            rho = Modelica.Fluid.Utilities.regStep(m_flow, d_a, d_b, m_flow_small)), 
            m_flow);

          annotation(Inline = true, Documentation(info = "<html>
<p>
该函数计算弯管的质量流量 m_flow 和压力损失 dp 的函数关系。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_volumeFlowRate\">此处</a>介绍了函数的详细信息。
</p>

<p>
弯管特性适用于恒定密度和恒定动力黏度。它也可近似用于可压缩介质。这需要提供上游密度和上游动力黏度。
为了能够在零质量流量附近对密度和动力黏度进行正则化，必须在流体从 port_a 流向 port_b 情况下给出 (d_a, eta_a)，流体从 port_b 流向 port_a 的情况下给出 (d_b, eta_b)。
</p>
</html>"            ));
        end pressureLoss;

        annotation(Documentation(info = "<html>
<p>
该子库包含 VolumeFlowRate fitting 组件的公用函数。
</p>
</html>"    ));
      end VolumeFlowRate;
      annotation();
    end GenericResistances;
    annotation();
  end BaseClasses;
  annotation(Documentation(info="<html><p>
这个子库包含提供压力损失关联的模型和函数。该库中的所有模型都具有无质量和无能量存储在组件中的特性。因此，这些模型没有状态。
</p>
<p>
所有函数都是连续的，并且具有有限的、非零的、光滑的、一阶导数。 所有函数都保证严格单调递增。 这些特性保证每个函数存在唯一的反函数。注意，通常的二次压力损失关联
</p>
<li>
形式为 m_flow = f(dp) 在零质量流量时具有无限导数，因此使用起来有问题。</li>
<li>
形式为 dp = f(m_flow) 在零质量流量时具有零导数，因此反转时有问题，因为反函数在零质量流量时具有无限导数。</li>
<p>
通过在零质量流量附近用适当的多项式逼近特性解决了上述两个问题。使用以下结果保证单调性：
</p>
<p>
 Fritsch F.N. and Carlson R.E. (1980):
</p>
<p>
<strong>单调分块三次插值</strong>.<br> &nbsp; &nbsp; SIAM J. Numerc. Anal., Vol. 17, No. 2, April 1980, pp. 238-246
</p>
</html>",revisions = "<html>
<ul>
<li><em>Jan. 3, 2006</em>
    by <a href=\"mailto:Martin.Otter@DLR.de\">Martin Otter</a>:<br>
    基于先前的迭代进行了新的设计和实现。</li>
</ul>
</html>"));
end Fittings;