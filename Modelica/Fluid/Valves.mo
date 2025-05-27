package Valves "调节和控制流动的部件"
    extends Modelica.Icons.VariantsPackage;

  model ValveIncompressible "不可压缩流体阀"
    extends BaseClasses.PartialValve(filteredOpening = false);
    import Modelica.Fluid.Types.CvTypes;
    import Modelica.Constants.pi;

    constant SI.ReynoldsNumber Re_turbulent = 4000 
      "cf. 阀门全开时为直管 -- dp_阀门关闭湍流程度增加";
    parameter Boolean use_Re = system.use_eps_Re 
      "true: 湍流区域由Re确定, false: 湍流区域由m_flow_small确定" 
      annotation(Dialog(tab = "高级"), Evaluate = true);
    //SI.MassFlowRate m_flow_turbulent=if not use_Re then m_flow_small else
    //  max(m_flow_small,
    //      (Modelica.Constants.pi/8)*sqrt(max(relativeFlowCoefficient,0.001)*Av*4/pi)*(Medium.dynamicViscosity(state_a) + Medium.dynamicViscosity(state_b))*Re_turbulent);
    //SI.AbsolutePressure dp_turbulent_=if not use_Re then dp_small else
    //  max(dp_small, m_flow_turbulent^2/(max(relativeFlowCoefficient,0.001)^2*Av^2*(Medium.density(state_a) + Medium.density(state_b))/2));
    // substitute m_flow_turbulent into dp_turbulent
    SI.AbsolutePressure dp_turbulent = if not use_Re then dp_small else 
      max(dp_small, (Medium.dynamicViscosity(state_a) + Medium.dynamicViscosity(state_b)) ^ 2 * pi / 8 * Re_turbulent ^ 2 
      / (max(relativeFlowCoefficient, 0.001) * Av * (Medium.density(state_a) + Medium.density(state_b))));

  protected
    Real relativeFlowCoefficient;
  initial equation
    if CvData == CvTypes.OpPoint then
      m_flow_nominal = valveCharacteristic(opening_nominal) * Av * sqrt(rho_nominal) * Utilities.regRoot(dp_nominal, dp_small) 
        "通过工作点确定 Av";
    end if;

  equation
    // m_flow = valveCharacteristic(opening)*Av*sqrt(d)*sqrt(dp);

    relativeFlowCoefficient = valveCharacteristic(opening_actual);
    if checkValve then
      m_flow = homotopy(relativeFlowCoefficient * Av * sqrt(Medium.density(state_a)) * 
        Utilities.regRoot2(dp, dp_turbulent, 1.0, 0.0, use_yd0 = true, yd0 = 0.0), 
        relativeFlowCoefficient * m_flow_nominal * dp / dp_nominal);
    /* 在 Modelica 3.1 中（缺点：在 dp=0 时出现不必要的事件，而不是 smooth=2）
    m_flow = valveCharacteristic(opening)*Av*sqrt(Medium.density(state_a))*
    (if dp>=0 then Utilities.regRoot(dp, dp_turbulent) else 0);
    */
    elseif not allowFlowReversal then
      m_flow = homotopy(relativeFlowCoefficient * Av * sqrt(Medium.density(state_a)) * 
        Utilities.regRoot(dp, dp_turbulent), 
        relativeFlowCoefficient * m_flow_nominal * dp / dp_nominal);
    else
      m_flow = homotopy(relativeFlowCoefficient * Av * 
        Utilities.regRoot2(dp, dp_turbulent, Medium.density(state_a), Medium.density(state_b)), 
        relativeFlowCoefficient * m_flow_nominal * dp / dp_nominal);
    /* 在 Modelica 3.1 中（缺点:在 dp=0 时出现不必要的事件，而不是 smooth=2）。
    In Modelica 3.1 (Disadvantage: Unnecessary event at dp=0, and instead of smooth=2)
    m_flow = smooth(0, Utilities.regRoot(dp, dp_turbulent)*(if dp>=0 then sqrt(Medium.density(state_a)) else sqrt(Medium.density(state_b))));
    */
    end if;

    annotation(
      Documentation(info = "<html><p>
阀门模型符合 IEC 534/ISA S.75 标准，用于不可压缩流体的阀门选型。
</p>
<p>
该模型的参数在<a href=\"modelica://Modelica.Fluid.Valves.BaseClasses.PartialValve\" target=\"\">PartialValve</a> （阀门的基本模型）中有详细说明。
</p>
<p>
该模型假定流体的可压缩性较低，故常用于液体。它也可用于气体，前提是压降低于入口绝对压力的 0.2 倍，这样流体密度在阀门内不会发生太大变化。
</p>
<p>
如果 <code>checkValve</code> 为false，则阀门支持反向流动，流动特性曲线对称。否则，将不支持反向流动（类似单向阀）。
</p>
<p>
有关参数<strong>Kv</strong> 和 <strong>Cv</strong> 在中<a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.ValveCharacteristics\" target=\"\">User's Guide</a>有详细说明。
</p>
</html>"  , revisions = "<html>
<ul>
<li><em>2 Nov 2005</em>
by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
改编自 ThermoPower 库。</li>
</ul>
</html>"  ));
  end ValveIncompressible;

  model ValveVaporizing "用于可能汽化的（几乎）不可压缩流体的阀门，考虑阻塞流条件"
    import Modelica.Fluid.Types.CvTypes;
    import Modelica.Constants.pi;
    extends BaseClasses.PartialValve(
    redeclare replaceable package Medium = 
      Modelica.Media.Water.WaterIF97_ph constrainedby 
      Modelica.Media.Interfaces.PartialTwoPhaseMedium);
    parameter Real Fl_nominal = 0.9 "液体压力恢复系数";
    replaceable function FlCharacteristic = 
      Modelica.Fluid.Valves.BaseClasses.ValveCharacteristics.one 
      constrainedby 
      Modelica.Fluid.Valves.BaseClasses.ValveCharacteristics.baseFun "压力恢复特性" annotation();
    Real Ff "Ff 系数 (参阅 IEC/ISA 标准)";
    Real Fl "压力恢复系数 Fl (参阅 IEC/ISA 标准)";
    SI.Pressure dpEff "有效压降";
    Medium.Temperature T_in "入口温度";
    Medium.AbsolutePressure p_sat "饱和压力";
    Medium.AbsolutePressure p_in "入口压力";
    Medium.AbsolutePressure p_out "出口压力";

    constant SI.ReynoldsNumber Re_turbulent = 4000 
      "cf.阀门全开时为直管-- dp_阀门关闭湍流程度增加";
    parameter Boolean use_Re = system.use_eps_Re 
      "true: 湍流区域由Re确定, false: 湍流区域由m_flow_small确定" 
      annotation(Dialog(tab = "高级"), Evaluate = true);
    //SI.Diameter diameter = Utilities.regRoot(4/pi*valveCharacteristic(opening_actual)*Av, 0.04/pi*valveCharacteristic(opening_nominal)*Av);
    SI.AbsolutePressure dp_turbulent = if not use_Re then dp_small else 
      max(dp_small, (Medium.dynamicViscosity(state_a) + Medium.dynamicViscosity(state_b)) ^ 2 * pi / 8 * Re_turbulent ^ 2 
      / (valveCharacteristic(opening_actual) * Av * (Medium.density(state_a) + Medium.density(state_b))));
  initial equation
    assert(not CvData == CvTypes.OpPoint, "汽化阀不支持 OpPoint 选项");
  equation
    p_in = port_a.p;
    p_out = port_b.p;
    T_in = Medium.temperature(state_a);
    p_sat = Medium.saturationPressure(T_in);
    Ff = 0.96 - 0.28 * sqrt(p_sat / Medium.fluidConstants[1].criticalPressure);
    Fl = Fl_nominal * FlCharacteristic(opening_actual);
    dpEff = if p_out < (1 - Fl ^ 2) * p_in + Ff * Fl ^ 2 * p_sat then 
      Fl ^ 2 * (p_in - Ff * p_sat) else dp 
      "有效压降，考虑可能的阻塞条件";
    // m_flow = valveCharacteristic(opening)*Av*sqrt(d)*sqrt(dpEff);
    if checkValve then
      m_flow = homotopy(valveCharacteristic(opening_actual) * Av * sqrt(Medium.density(state_a)) * 
        Utilities.regRoot2(dpEff, dp_turbulent, 1.0, 0.0, use_yd0 = true, yd0 = 0.0), 
        valveCharacteristic(opening_actual) * m_flow_nominal * dp / dp_nominal);
    /* 在 Modelica 3.1 中（缺点：在 dpEff=0 时出现不必要的事件，而不是 smooth=2）。
    m_flow = valveCharacteristic(opening)*Av*sqrt(Medium.density(state_a))*
    (if dpEff>=0 then Utilities.regRoot(dpEff, dp_turbulent) else 0);
    */
    elseif not allowFlowReversal then
      m_flow = homotopy(valveCharacteristic(opening_actual) * Av * sqrt(Medium.density(state_a)) * 
        Utilities.regRoot(dpEff, dp_turbulent), 
        valveCharacteristic(opening_actual) * m_flow_nominal * dp / dp_nominal);
    else
      m_flow = homotopy(valveCharacteristic(opening_actual) * Av * 
        Utilities.regRoot2(dpEff, dp_turbulent, Medium.density(state_a), Medium.density(state_b)), 
        valveCharacteristic(opening_actual) * m_flow_nominal * dp / dp_nominal);
    /* 在 Modelica 3.1 中（缺点:在 dp=0 时出现不必要的事件，而不是 smooth=2）。
    In Modelica 3.1 (Disadvantage: Unnecessary event at dp=0, and instead of smooth=2)
    m_flow = valveCharacteristic(opening)*Av*
    smooth(0, Utilities.regRoot(dpEff, dp_turbulent)*(if dpEff>=0 then sqrt(Medium.density(state_a)) else sqrt(Medium.density(state_b))));
    */
    end if;

    annotation(
      Documentation(info = "<html>
<p>
根据 IEC 534/ISA S.75 阀门尺寸标准制作的阀门模型，入口处为不可压缩流体，出口处可能为两相流体，包括阻塞流条件。
<p>
该模型的参数在 <a href=\"modelica://Modelica.Fluid.Valves.BaseClasses.PartialValve\">PartialValve</a>（阀门的基本模型）中有详细说明。
</p>

<p>模型的运行范围包括阻塞流操作，在出口压力较低时，由于缩流断面中的闪蒸而发生阻塞流；否则，假定为非阻塞流条件。
</p>
<p>
该模型需要一个两相介质模型来描述液体和（可能的）两相条件。
</p>
<p>
默认的液体压力恢复系数 <code>Fl</code> 是常数，由参数 <code>Fl_nominal</code> 给定。
通过替换 <code>FlCharacteristic</code> 函数，可将恢复系数的相对（单位）变化指定为阀门开度的给定函数。
</p>
<p>
如果 <code>checkValve</code> 为假，阀门支持反向流动，流量特性曲线对称。否则，将停止反向流动（单向阀行为）。
</p>

<p>
参数 <strong>Kv</strong> 和 <strong>Cv</strong> 的处理方法在 <a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.ValveCharacteristics\">User's Guide</a> 中有详细说明。
</p>

</html>"  , 
      revisions = "<html>
<ul>
<li><em>2 Nov 2005</em>
by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
改编自 ThermoPower 库。</li>
</ul>
</html>"  ));
  end ValveVaporizing;

  model ValveCompressible "可压缩流体阀门(考虑阻塞流条件)"
    extends BaseClasses.PartialValve;
    import Modelica.Fluid.Types.CvTypes;
    import Modelica.Constants.pi;
    parameter Medium.AbsolutePressure p_nominal "额定进口压力" 
    annotation(Dialog(group="额定工作点"));
    parameter Real Fxt_full=0.5 "全开时的 Fk*xt 临界比率";
    replaceable function xtCharacteristic = 
        Modelica.Fluid.Valves.BaseClasses.ValveCharacteristics.one 
      constrainedby 
      Modelica.Fluid.Valves.BaseClasses.ValveCharacteristics.baseFun 
      "临界比率" annotation();
    Real Fxt;
    Real x "压降比";
    Real xs "饱和压降比";
    Real Y "压缩系数";
    Medium.AbsolutePressure p "入口压力";

    constant SI.ReynoldsNumber Re_turbulent = 4000 
      "cf. 阀门全开时为直管 -- dp_阀门关闭湍流程度增加";
    parameter Boolean use_Re = system.use_eps_Re 
      "true: 湍流区域由 Re 确定, false: 湍流区域由 m_flow_small 确定" 
      annotation(Dialog(tab="高级"), Evaluate=true);
    SI.AbsolutePressure dp_turbulent = if not use_Re then dp_small else 
      max(dp_small, (Medium.dynamicViscosity(state_a) + Medium.dynamicViscosity(state_b))^2*pi/8*Re_turbulent^2 
                    /(max(valveCharacteristic(opening_actual),0.001)*Av*Y*(Medium.density(state_a) + Medium.density(state_b))));
  protected
    parameter Real Fxt_nominal(fixed=false) "额定 Fxt";
    parameter Real x_nominal(fixed=false) "额定压降比";
    parameter Real xs_nominal(fixed=false) "额定饱和压降比";
    parameter Real Y_nominal(fixed=false) "额定压缩系数";

  initial equation
    if CvData == CvTypes.OpPoint then
      // 根据额定工作点条件确定 Av
      Fxt_nominal = Fxt_full*xtCharacteristic(opening_nominal);
      x_nominal = dp_nominal/p_nominal;
      xs_nominal = smooth(0, if x_nominal > Fxt_nominal then Fxt_nominal else x_nominal);
      Y_nominal = 1 - abs(xs_nominal)/(3*Fxt_nominal);
      m_flow_nominal = valveCharacteristic(opening_nominal)*Av*Y_nominal*sqrt(rho_nominal)*Utilities.regRoot(p_nominal*xs_nominal, dp_small);
    else
      // 假值
      Fxt_nominal = 0;
      x_nominal = 0;
      xs_nominal = 0;
      Y_nominal = 0;
    end if;

  equation
    p = max(port_a.p, port_b.p);
    Fxt = Fxt_full*xtCharacteristic(opening_actual);
    x = dp/p;
    xs = max(-Fxt, min(x, Fxt));
    Y = 1 - abs(xs)/(3*Fxt);
    // m_flow = valveCharacteristic(opening)*Av*Y*sqrt(d)*sqrt(p*xs);
    if checkValve then
      m_flow = homotopy(valveCharacteristic(opening_actual)*Av*Y*sqrt(Medium.density(state_a))* 
                             (if xs>=0 then Utilities.regRoot(p*xs, dp_turbulent) else 0), 
                        valveCharacteristic(opening_actual)*m_flow_nominal*dp/dp_nominal);
    elseif not allowFlowReversal then
      m_flow = homotopy(valveCharacteristic(opening_actual)*Av*Y*sqrt(Medium.density(state_a))* 
                             Utilities.regRoot(p*xs, dp_turbulent), 
                        valveCharacteristic(opening_actual)*m_flow_nominal*dp/dp_nominal);
    else
      m_flow = homotopy(valveCharacteristic(opening_actual)*Av*Y* 
                             Utilities.regRoot2(p*xs, dp_turbulent, Medium.density(state_a), Medium.density(state_b)), 
                        valveCharacteristic(opening_actual)*m_flow_nominal*dp/dp_nominal);
  /* 使用 smooth(0, ...)的替代公式 -- 不应使用，因为 regRoot2 具有连续导数
    -- cf. ModelicaTest.Fluid.TestPipesAndValves.DynamicPipeInitialization --
    m_flow = homotopy(valveCharacteristic(opening_actual)*Av*Y*
                        smooth(0, Utilities.regRoot(p*xs, dp_turbulent)*
                        (if xs>=0 then sqrt(Medium.density(state_a)) else sqrt(Medium.density(state_b)))),
                      valveCharacteristic(opening_actual)*m_flow_nominal*dp/dp_nominal);
  */
    end if;

    annotation (
    Documentation(info="<html>
<p>阀门模型符合 IEC 534/ISA S.75 阀门选型标准，用于可压缩无相变流体，也涵盖阻塞流条件。</p>

<p>
该模型的参数在 <a href=\"modelica://Modelica.Fluid.Valves.BaseClasses.PartialValve\">PartialValve</a>（阀门的基本模型）中有详细说明。
</p>

<p>该模型可用于气体和蒸汽，入口和出口之间的压力比可任意设定。</p>

<p>
乘积 Fk*xt 由参数 <code>Fxt_full</code> 给出，默认为常数。
可以通过替换 xtCharacteristic 函数来指定 <code>xtCharacteristic</code> 系数随阀门开度的（单位）相对变化。
</p>

<p>
如果 <code>checkValve</code> 为假，阀门支持反向流动，流量特性曲线对称。否则，将停止反向流动（单向阀行为）。
</p>

<p>
参数 <strong>Kv</strong> 和 <strong>Cv</strong> 的处理方法在 <a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.ValveCharacteristics\">User's Guide</a> 中有详细说明。
</p>

</html>"          , 
      revisions="<html>
<ul>
<li><em>2 Nov 2005</em>
by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
改编自 ThermoPower 库。</li>
</ul>
</html>"          ));
  end ValveCompressible;

  model ValveLinear "用于线性压降的水/蒸汽阀门"
    extends Modelica.Fluid.Interfaces.PartialTwoPortTransport;
    parameter SI.AbsolutePressure dp_nominal 
      "全开时的额定压降" 
      annotation(Dialog(group="额定工作点"));
    parameter Medium.MassFlowRate m_flow_nominal 
      "全开时的额定质量流量";
    final parameter Types.HydraulicConductance k = m_flow_nominal/dp_nominal 
      "全开时的渗透系数";
    Modelica.Blocks.Interfaces.RealInput opening(min=0,max=1) 
      "=1: 完全打开， =0:完全关闭" 
    annotation (Placement(transformation(
          origin={0,90}, 
          extent={{-20,-20},{20,20}}, 
          rotation=270), iconTransformation(
          extent={{-20,-20},{20,20}}, 
          rotation=270, 
          origin={0,80})));

  equation
    m_flow = opening*k*dp;

    // 等温态转化（无储存损失，无能量损失）
    port_a.h_outflow = inStream(port_b.h_outflow);
    port_b.h_outflow = inStream(port_a.h_outflow);

  annotation (
    Icon(coordinateSystem(
          preserveAspectRatio=true, 
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{0,50},{0,0}}), 
          Rectangle(
            extent={{-20,60},{20,50}}, 
            fillPattern=FillPattern.Solid), 
          Polygon(
            points={{-100,50},{100,-50},{100,50},{0,0},{-100,-50},{-100,50}}, 
            fillColor={255,255,255}, 
            fillPattern=FillPattern.Solid), 
          Polygon(
            points=DynamicSelect({{-100,0},{100,-0},{100,0},{0,0},{-100,-0},{-100, 
                0}}, {{-100,50*opening},{-100,50*opening},{100,-50*opening},{
                100,50*opening},{0,0},{-100,-50*opening},{-100,50*opening}}), 
            fillColor={0,255,0}, 
            lineColor={255,255,255}, 
            fillPattern=FillPattern.Solid), 
          Polygon(points={{-100,50},{100,-50},{100,50},{0,0},{-100,-50},{-100, 
                50}})}), 
    Documentation(info="<html>
<p>
该模型非常简单，提供的压降与流速和 <code>opening</code> 输入成正比，无需计算任何流体特性。
当需要一个简单的可变压力损失模型时，它可用于测试目的。
</p>

<p>但必须指定介质模型，以便使用相同的介质模型将流体接口连接到其他组件。</p>
<p>该模型为绝热模型（不向环境散热），忽略了从入口到出口的动能变化。</p>
</html>"          , 
      revisions="<html>
<ul>
<li><em>2 Nov 2005</em>
by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
改编自 ThermoPower 库。</li>
</ul>
</html>"          ));
  end ValveLinear;

  model ValveDiscrete "用于线性压降的水/蒸汽阀门"
    extends Modelica.Fluid.Interfaces.PartialTwoPortTransport;
    parameter SI.AbsolutePressure dp_nominal "全开=1时的额定压降" 
      annotation(Dialog(group = "额定工作点"));
    parameter Medium.MassFlowRate m_flow_nominal "全开=1时的额定质量流量";
    final parameter Types.HydraulicConductance k = m_flow_nominal / dp_nominal 
      "全开=1时的渗透系数";
    Modelica.Blocks.Interfaces.BooleanInput open 
      annotation(Placement(transformation(
      origin = {0, 80}, 
      extent = {{-20, -20}, {20, 20}}, 
      rotation = 270)));
    parameter Real opening_min(min = 0) = 0 
      "如果关闭，阀门缝隙会造成少量泄漏流";
  equation
    m_flow = if open then 1 * k * dp else opening_min * k * dp;

    // 等温态转化（无储存损失，无能量损失）
    port_a.h_outflow = inStream(port_b.h_outflow);
    port_b.h_outflow = inStream(port_a.h_outflow);

    annotation(
      Icon(coordinateSystem(
      preserveAspectRatio = false, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{0, 50}, {0, 0}}), 
      Rectangle(
      extent = {{-20, 60}, {20, 50}}, 
      fillPattern = FillPattern.Solid), 
      Polygon(
      points = {{-100, 50}, {100, -50}, {100, 50}, {0, 0}, {-100, -50}, {-100, 50}}, 
      fillColor = DynamicSelect({255, 255, 255}, if open then {0, 255, 0} else {255, 255, 255}), 
      fillPattern = FillPattern.Solid)}), 
      Documentation(info = "<html>
<p>
如果 open = <strong>true</strong> ，这个非常简单的模型就会产生与流量成正比的（小）压降，否则，质量流量为零。如果 opening_min > 0，
则在 open = <strong>false</strong> 时会出现较小的泄漏质量流量。
</p>

<p>
该模型可用于简化开闭阀的建模，当不需要准确描述阀门开启时的压力损失时特别有用。虽然介质模型不是用来确定压力损失的，但必须指定介质模型，
以便流体端口可以连接到使用相同介质模型的其他组件。
</p>

<p>
该模型为绝热模型（不向环境散热），忽略了从入口到出口的动能变化。
</p>
<p>
在图示动画中，阀门打开时显示为 \"绿色\"。
</p>
</html>"  , 
      revisions = "<html>
<ul>
<li><em>Nov 2005</em>
by Katja Poschlad (based on ValveLinear).</li>
</ul>
</html>"  ));
  end ValveDiscrete;

  model ValveDiscreteRamp 
    "用于水/蒸汽的阀门，具有离散开启信号和斜坡开启功能"
    extends Modelica.Fluid.Interfaces.PartialTwoPortTransport;
    parameter SI.AbsolutePressure dp_nominal 
      "全开时的额定压降" 
      annotation(Dialog(group = "额定工作点"));
    parameter Medium.MassFlowRate m_flow_nominal 
      "全开时的额定质量流量";
    parameter Real opening_min(min = 0) = 0 
      "如果关闭，阀门缝隙会造成少量泄漏流";
    final parameter Types.HydraulicConductance k = m_flow_nominal / dp_nominal 
      "全开时的渗透系数";
    parameter SI.Time Topen "全开阀门的时间";
    parameter SI.Time Tclose = Topen "全关阀门的时间";

    Modelica.Blocks.Interfaces.BooleanInput open 
      annotation(Placement(transformation(
      origin = {0, 80}, 
      extent = {{-20, -20}, {20, 20}}, 
      rotation = 270)));
    Blocks.Logical.TriggeredTrapezoid openingGenerator(
      amplitude = 1 - opening_min, rising = Topen, falling = 
      Tclose, 
      offset = opening_min) 
      annotation(Placement(transformation(
      extent = {{-10, -10}, {10, 10}}, 
      rotation = -90, 
      origin = {0, 30})));



  equation
    m_flow = openingGenerator.y * k * dp;

    // 等焓转化（无储存损失，无能量损失）
    port_a.h_outflow = inStream(port_b.h_outflow);
    port_b.h_outflow = inStream(port_a.h_outflow);
    connect(open, openingGenerator.u) annotation(Line(points = {{0, 80}, {0, 42}, {2.22045e-15, 
      42}}, color = {255, 0, 255}));
    annotation(
      Icon(coordinateSystem(
      preserveAspectRatio = false, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{0, 50}, {0, 0}}), 
      Rectangle(
      extent = {{-20, 60}, {20, 50}}, 
      fillPattern = FillPattern.Solid), 
      Polygon(
      points = {{-100, 50}, {100, -50}, {100, 50}, {0, 0}, {-100, -50}, {-100, 50}}, 
      fillColor = DynamicSelect({255, 255, 255}, if open then {0, 255, 0} else {255, 255, 255}), 
      fillPattern = FillPattern.Solid)}), 
      Documentation(info = "<html>
<p>
该模型与 <a href=\"modelica://Modelica.Fluid.Valves.ValveDiscrete\">ValveDiscrete</a> 相似，
不同之处在于阀门在打开时间 <code>Tclose</code> 内逐渐打开，在关闭时间 <code>Tclose</code> 内逐渐关闭，而不是突然关闭。
这有助于避免在使用具有小压缩性的精确流体模型时出现不现实的现象，例如反向流动。
</p>
</html>"  , 
      revisions = "<html>
<ul>
<li><em>Mar 2020</em>
by Francesco Casella (based on ValveLinear and ValveDiscrete).</li>
</ul>
</html>"  ));
  end ValveDiscreteRamp;

  package BaseClasses 
    "阀门子库中使用的基类(只用于建立新的组件模型)"
    extends Modelica.Icons.BasesPackage;
    partial model PartialValve "阀门的基本模型"

      import Modelica.Fluid.Types.CvTypes;
      extends Modelica.Fluid.Interfaces.PartialTwoPortTransport(
        dp_start = dp_nominal, 
        m_flow_small = if system.use_eps_Re then system.eps_m_flow*m_flow_nominal else system.m_flow_small, 
        m_flow_start = m_flow_nominal);

      parameter Modelica.Fluid.Types.CvTypes CvData=Modelica.Fluid.Types.CvTypes.OpPoint 
        "选择流量系数" 
       annotation(Dialog(group = "流量系数"));
      parameter SI.Area Av(
        fixed= CvData == Modelica.Fluid.Types.CvTypes.Av, 
        start=m_flow_nominal/(sqrt(rho_nominal*dp_nominal))*valveCharacteristic(
            opening_nominal)) "（公制）流量系数 Av" 
       annotation(Dialog(group = "流量系数", 
                         enable = (CvData==Modelica.Fluid.Types.CvTypes.Av)));
      parameter Real Kv = 0 "（公制）流量系数 Kv [m3/h]" 
      annotation(Dialog(group = "流量系数", 
                        enable = (CvData==Modelica.Fluid.Types.CvTypes.Kv)));
      parameter Real Cv = 0 "（US） 流量系数 Cv [USG/min]" 
      annotation(Dialog(group = "流量系数", 
                        enable = (CvData==Modelica.Fluid.Types.CvTypes.Cv)));
      parameter SI.Pressure dp_nominal "额定压降" 
      annotation(Dialog(group="额定工作点"));
      parameter Medium.MassFlowRate m_flow_nominal "额定质量流量" 
      annotation(Dialog(group="额定工作点"));
      parameter Medium.Density rho_nominal=Medium.density_pTX(Medium.p_default, Medium.T_default, Medium.X_default) 
        "额定入口密度" 
      annotation(Dialog(group="额定工作点", 
                        enable = (CvData==Modelica.Fluid.Types.CvTypes.OpPoint)));
      parameter Real opening_nominal(min=0,max=1)=1 "额定开度" 
      annotation(Dialog(group="额定工作点", 
                        enable = (CvData==Modelica.Fluid.Types.CvTypes.OpPoint)));

      parameter Boolean filteredOpening=false 
        "true: 开度用2阶临界阻尼滤波器进行滤波" 
        annotation(Dialog(group="开度过滤"),choices(checkBox=true));
      parameter SI.Time riseTime=1 
        "滤波器的上升时间 (达到开度步进的99.6%所需的时间)" 
        annotation(Dialog(group="开度过滤",enable=filteredOpening));
      parameter Real leakageOpening(min=0,max=1)=1e-3 
        "开度信号受泄漏开度限制 (以改善数值计算)" 
        annotation(Dialog(group="开度过滤",enable=filteredOpening));
      parameter Boolean checkValve=false "反向流动停止" 
        annotation(Dialog(tab="假设"));

      replaceable function valveCharacteristic = 
          Modelica.Fluid.Valves.BaseClasses.ValveCharacteristics.linear 
        constrainedby 
        Modelica.Fluid.Valves.BaseClasses.ValveCharacteristics.baseFun 
        "内在流动特性" 
        annotation(choicesAllMatching=true);
    protected
      parameter SI.Pressure dp_small=if system.use_eps_Re then dp_nominal/m_flow_nominal*m_flow_small else system.dp_small 
        "零流量的正规化" 
       annotation(Dialog(tab="高级"));

    public
      constant SI.Area Kv2Av = 27.7e-6 "换算系数";
      constant SI.Area Cv2Av = 24.0e-6 "换算系数";

      Modelica.Blocks.Interfaces.RealInput opening(min=0, max=1) 
        "阀门位置范围 0...1" 
                                       annotation (Placement(transformation(
            origin={0,90}, 
            extent={{-20,-20},{20,20}}, 
            rotation=270), iconTransformation(
            extent={{-20,-20},{20,20}}, 
            rotation=270, 
            origin={0,80})));

      Modelica.Blocks.Interfaces.RealOutput opening_filtered if filteredOpening 
        "过滤阀位置范围 0...1" 
        annotation (Placement(transformation(extent={{60,40},{80,60}}), 
            iconTransformation(extent={{60,50},{80,70}})));

      Modelica.Blocks.Continuous.Filter filter(order=2, f_cut=5/(2*Modelica.Constants.pi 
            *riseTime)) if filteredOpening 
        annotation (Placement(transformation(extent={{34,44},{48,58}})));

    protected
      Modelica.Blocks.Interfaces.RealOutput opening_actual 
        annotation (Placement(transformation(extent={{60,10},{80,30}})));

    public
    block MinLimiter "将信号限制在阈值以上"
     parameter Real uMin=0 "输入信号的下限";
      extends Modelica.Blocks.Interfaces.SISO;

    equation
      y = smooth(0, noEvent( if u < uMin then uMin else u));
      annotation (
        Documentation(info="<html>
<p>
只要输入信号高于 uMin，程序块就会将输入信号作为输出信号。否则，y=uMin 将作为输出信号。
</p>
</html>"                  ), Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{0,-90},{0,68}}, color={192,192,192}), 
        Polygon(
          points={{0,90},{-8,68},{8,68},{0,90}}, 
          lineColor={192,192,192}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-90,0},{68,0}}, color={192,192,192}), 
        Polygon(
          points={{90,0},{68,-8},{68,8},{90,0}}, 
          lineColor={192,192,192}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-80,-70},{-50,-70},{50,70},{64,90}}), 
        Text(
          extent={{-150,-150},{150,-110}}, 
          textString="uMin=%uMin"), 
        Text(
          extent={{-150,150},{150,110}}, 
          textString="%name", 
          textColor={0,0,255})}), 
        Diagram(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{0,-60},{0,50}}, color={192,192,192}), 
        Polygon(
          points={{0,60},{-5,50},{5,50},{0,60}}, 
          lineColor={192,192,192}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-60,0},{50,0}}, color={192,192,192}), 
        Polygon(
          points={{60,0},{50,-5},{50,5},{60,0}}, 
          lineColor={192,192,192}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-50,-40},{-30,-40},{30,40},{50,40}}), 
        Text(
          extent={{46,-6},{68,-18}}, 
          textColor={128,128,128}, 
          textString="u"), 
        Text(
          extent={{-30,70},{-5,50}}, 
          textColor={128,128,128}, 
          textString="y"), 
        Text(
          extent={{-58,-54},{-28,-42}}, 
          textColor={128,128,128}, 
          textString="uMin"), 
        Text(
          extent={{26,40},{66,56}}, 
          textColor={128,128,128}, 
          textString="uMax")}));
    end MinLimiter;

      protected
      MinLimiter minLimiter(uMin=leakageOpening) 
        annotation (Placement(transformation(extent={{10,44},{24,58}})));
    initial equation
      if CvData == CvTypes.Kv then
        Av = Kv*Kv2Av "单位换算";
      elseif CvData == CvTypes.Cv then
        Av = Cv*Cv2Av "单位换算";
      end if;

    equation
      // 等焓转换(无能量储存，无能量损失)
      port_a.h_outflow = inStream(port_b.h_outflow);
      port_b.h_outflow = inStream(port_a.h_outflow);

      connect(filter.y, opening_filtered) annotation (Line(
          points={{48.7,51},{60,51},{60,50},{70,50}}, color={0,0,127}));

      if filteredOpening then
         connect(filter.y, opening_actual);
      else
         connect(opening, opening_actual);
      end if;

      connect(minLimiter.y, filter.u) annotation (Line(
          points={{24.7,51},{32.6,51}}, color={0,0,127}));
      connect(minLimiter.u, opening) annotation (Line(
          points={{8.6,51},{0,51},{0,90}}, color={0,0,127}));
      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=true, 
            extent={{-100,-100},{100,100}}), graphics={
            Line(points={{0,52},{0,0}}), 
            Rectangle(
              extent={{-20,60},{20,52}}, 
              fillPattern=FillPattern.Solid), 
            Polygon(
              points={{-100,50},{100,-50},{100,50},{0,0},{-100,-50},{-100,50}}, 
              fillColor={255,255,255}, 
              fillPattern=FillPattern.Solid), 
            Polygon(
              points=DynamicSelect({{-100,0},{100,-0},{100,0},{0,0},{-100,-0},{
                  -100,0}}, {{-100,50*opening_actual},{-100,50*opening_actual},{100,-50* 
                  opening},{100,50*opening_actual},{0,0},{-100,-50*opening_actual},{-100,50* 
                  opening}}), 
              fillColor={0,255,0}, 
              lineColor={255,255,255}, 
              fillPattern=FillPattern.Solid), 
            Polygon(points={{-100,50},{100,-50},{100,50},{0,0},{-100,-50},{-100, 
                  50}}), 
            Ellipse(visible=filteredOpening, 
              extent={{-40,94},{40,14}}, 
              lineColor={0,0,127}, 
              fillColor={255,255,255}, 
              fillPattern=FillPattern.Solid), 
            Line(visible=filteredOpening, 
              points={{-20,25},{-20,63},{0,41},{20,63},{20,25}}, 
              thickness=0.5), 
            Line(visible=filteredOpening, 
              points={{40,60},{60,60}}, 
              color={0,0,127})}), 
        Documentation(info="<html>
<p>这是 <code>ValveIncompressible</code>、<code>ValveVaporizing</code> 和 <code>ValveCompressible</code> 阀门模型的基础模型。该模型基于 IEC 534 / ISA S.75 阀门尺寸标准。</p>

<p>
该模型可选择支持反向流动条件（假设为对称行为）或止回阀操作，与标准方程相比，已进行了适当的正则化处理，以避免在零压降操作条件下出现数值奇异点。
</p>

<p>
模型假设绝热运行（不向环境中散热）；忽略了从入口到出口的动能变化。</p>
<p><strong>模型选项</strong></p>
<p>以下选项可用于指定全开条件下的阀门流量系数：</p>
<ul><li><code>CvData = Modelica.Fluid.Types.CvTypes.Av</code>: 流量系数由公制系数 <code>Av</code> (m^2) 得出。</li>
<li><code>CvData = Modelica.Fluid.Types.CvTypes.Kv</code>: 流量系数由公制系数 <code>Kv</code> (m^3/h) 得出。</li>
<li><code>CvData = Modelica.Fluid.Types.CvTypes.Cv</code>: 流量系数由系数 <code>Cv</code>（USG/min）得出。</li>
<li><code>CvData = Modelica.Fluid.Types.CvTypes.OpPoint</code>: 流量由 <code>p_nominal</code>, <code>dp_nominal</code>, <code>m_flow_nominal</code>, <code>rho_nominal</code>, <code>opening_nominal</code> 确定的额定工作点计算得出。</li>
</ul>

<p>
必须始终指定额定压降 <code>dp_nominal</code>；为避免出现数值奇异现象，
将对压降小于 <code>b*dp_nominal</code> 的流量特性进行修改（默认值为额定压降的 1%）。
如果在压力降很低的阀门中出现数值问题，请增加该参数的数值。
</p>

<p>
如果 <code>checkValve</code> 为真，那么当出口压力高于入口压力时，流动会停止；
否则，反向流动将会发生。慎用该选项，因为它会增加问题的数值复杂性。
</p>

<p>
阀门开启特性 <code>valveCharacteristic</code> 默认为线性，可由任何用户定义的函数代替。
库中已经提供了可自定义范围的二次函数和等百分比函数。
下两图显示了压力 port_a.p 和 port_b.p 恒定且开度连续变化时的特性：
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Valves/BaseClasses/ValveCharacteristics1a.png\"
alt=\"ValveCharacteristics1a.png\"><br>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Valves/BaseClasses/ValveCharacteristics1b.png\"
alt=\"Components/ValveCharacteristics1b.png\">
</blockquote>

<p>
参数 <strong>Kv</strong> 和 <strong>Cv</strong> 的处理方法在 <a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.ValveCharacteristics\">User's Guide</a> 中有详细说明。
</p>

<p>
通过可选参数 \"filteredOpening\"（过滤开度），可以用一个二阶临界阻尼滤波器对开度进行过滤，
使开度需求通过参数 \"riseTime\" 延迟。过滤后的开度可通过输出信号 \"opening_filtered \"获得，
并用于控制阀方程。这种方法近似于阀门的驱动装置。\"riseTime \"参数用于计算滤波器的截止频率，公式为：f_cut = 5/(2*pi*riseTime)，
它定义了 opening_filtered 达到步进输入开度的 99.6 % 所需的时间。
阀门图标的变化如下（左图：filteredOpening=false，右图：filteredOpening=true）：
</p>

<p>
<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Valves/BaseClasses/FilteredValveIcon.png\"
alt=\"FilteredValveIcon.png\">
</blockquote>
</p>

<p>
如果 \"filteredOpening=<strong>true</strong>\"，输入信号 \"opening \"将受到参数 <strong>leakageOpening</strong> 的限制，即如果 \"opening \"变小为 \"leakageOpening\"，则使用 \"leakageOpening \"而不是 \"opening \"作为滤波器的输入。
原因是 \"opening=0 \"可能会从结构上改变流体网络方程，从而导致奇点。
如果引入一个小的泄漏流（现实中经常存在），就可以避免出现奇点。
</p>

<p>
在下图中，\"opening \"和 \"filtered_opening \"显示的是 filteredOpening = <strong>true</strong>、riseTime = 1 s 和 leakageOpening = 0.02 的情况。
</p>

<p>
<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Valves/BaseClasses/ValveFilteredOpening.png\"
alt=\"ValveFilteredOpening.png\">
</blockquote>
</p>

</html>"              , revisions="<html>
<ul>
<li><em>Sept. 5, 2010</em>
by <a href=\"mailto:martin.otter@dlr.de\">Martin Otter</a>:<br>
根据 Mike Barth（汉堡联邦国防军大学）的提议，引入了可选的开局过滤功能 + 改进了文档。</li>
<li><em>2 Nov 2005</em>
by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
改编自 ThermoPower 库。</li>
</ul>
</html>"              ));
    end PartialValve;

  package ValveCharacteristics "阀门特性函数"
    extends Modelica.Icons.VariantsPackage;
    partial function baseFun "阀门特性基本函数"
      extends Modelica.Icons.Function;
      input Real pos(min=0, max=1) 
          "开度 (0: 关闭, 1: 全开)";
      output Real rc "相对流量系数 (单位)";
      annotation (Documentation(info="<html>
<p>
这是一个基本函数，用于定义阀门特性接口。该函数将 \"rc = valveCharacteristic \"作为开度 \"pos\"（范围 0...1）的函数返回：
</p>

<blockquote><pre>
dp = (zeta_TOT/2) * rho * velocity^2
m_flow =    sqrt(2/zeta_TOT) * Av * sqrt(rho * dp)
m_flow = valveCharacteristic * Av * sqrt(rho * dp)
m_flow =                  rc * Av * sqrt(rho * dp)
</pre></blockquote>

</html>"      ));
    end baseFun;

    function linear "线性特性"
      extends baseFun;
      annotation();
    algorithm
      rc := pos;
    end linear;

    function one "常数特性"
      extends baseFun;
      annotation();
    algorithm
      rc := 1;
    end one;

    function quadratic "二次方特性"
      extends baseFun;
      annotation();
    algorithm
      rc := pos*pos;
    end quadratic;

    function equalPercentage "等百分比特性"
      extends baseFun;
      input Real rangeability = 20 "适用范围" annotation(Dialog);
      input Real delta = 0.01 annotation(Dialog);
    algorithm
      rc := if pos > delta then rangeability^(pos-1) else 
              pos/delta*rangeability^(delta-1);
      annotation (Documentation(info="<html>
<p>这种特性使得流量系数的相对变化与开度位置的变化成正比：</p>
<p> d(rc)/d(pos) = k d(pos).</p>
<p> 常数 k 表示可变范围，即最大可用流量系数与最小可用流量系数之比：
The constant k is expressed in terms of the rangeability, i.e., the ratio between the maximum and the minimum useful flow coefficient:</p>
<p> rangeability = exp(k) = rc(1.0)/rc(0.0).</p>
<p> 当 pos = 0 时，阀门理论特性的开度不为零；当 pos &lt; delta 时，执行特性被修改，阀门能线性关闭。</p>
</html>"          ));
    end equalPercentage;
    annotation();

  end ValveCharacteristics;
    annotation();
  end BaseClasses;
  annotation (Documentation(info="<html>

</html>"));
end Valves;