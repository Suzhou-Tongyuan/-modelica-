within Modelica.Media.IdealGases;
package Common "理想气体模型的通用库与数据"
  extends Modelica.Icons.Package;

  record DataRecord 
    "基于NASA来源的理想气体性质系数数据记录"
    extends Modelica.Icons.Record;
    String name "理想气体的名称";
    SI.MolarMass MM "摩尔质量";
    SI.SpecificEnthalpy Hf "298.15K 下的生成焓";
    SI.SpecificEnthalpy H0 "H0(298.15K) - H0(0K)";
    SI.Temperature Tlimit "低温和高温数据集之间的温度限制";
    Real alow[7] "低温系数 a";
    Real blow[2] "低温常数 b";
    Real ahigh[7] "高温系数 a";
    Real bhigh[2] "高温常数 b";
    SI.SpecificHeatCapacity R_s "气体常数";
    annotation(Documentation(info = "<html>
<p>
该数据记录包含理想气体方程的系数，具体如下：
</p>
<blockquote>
<p>McBride B.J., Zehe M.J., and Gordon S. (2002): <strong>NASA Glenn Coefficients
for Calculating Thermodynamic Properties of Individual Species</strong>. NASA
report TP-2002-211556</p>
</blockquote>
<p>
方程具有以下结构：
</p>
<div><img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/Common/singleEquations.png\"></div>
<p>
h(T)和s0(T)的多项式是通过从cp(T)的积分导出的，并包含定义参考比焓和熵的积分常数b1、b2。对于熵差，参考压力p0是任意的，但对于绝对熵不是。它被选择为一个标准大气压（101325 Pa）。
</p>
<p>
对于大多数气体，有效范围是从200 K到6000 K。
方程分为两个区域，由Tlimit（通常为1000 K）分隔。
在这两个区域中，气体由上述数据描述。
这两个分支在Tlimit处连续，在大多数气体中也是可微的。
</p>
</html>"    ));
  end DataRecord;

  partial package SingleGasNasa 
    "基于NASA来源的理想气体的介质模型"

    extends Interfaces.PartialPureSubstance(
      ThermoStates = Modelica.Media.Interfaces.Choices.IndependentVariables.pT, 
    redeclare final record FluidConstants = 
      Modelica.Media.Interfaces.Types.IdealGas.FluidConstants, 
      mediumName = data.name, 
      substanceNames = {data.name}, 
      singleState = false, 
      Temperature(min = 200, max = 6000, start = 500, nominal = 500), 
      SpecificEnthalpy(start = if Functions.referenceChoice == ReferenceEnthalpy.ZeroAt0K then data.H0 else 
      if Functions.referenceChoice == ReferenceEnthalpy.UserDefined then Functions.h_offset else 0, nominal = 1.0e5), 
      Density(start = 10, nominal = 10), 
      AbsolutePressure(start = 10e5, nominal = 10e5));

    redeclare record extends ThermodynamicState 
      "理想气体的热力学状态变量"
      AbsolutePressure p "介质的绝对压力";
      Temperature T "介质的温度";
      annotation();
    end ThermodynamicState;

    import Modelica.Math;
    import Modelica.Media.Interfaces.Choices.ReferenceEnthalpy;

    constant IdealGases.Common.DataRecord data 
      "理想气体物质的数据记录";

    constant FluidConstants[nS] fluidConstants "流体的常数数据";

    redeclare model extends BaseProperties(
      T(stateSelect = if preferredMediumStates then StateSelect.prefer else StateSelect.default), 
      p(stateSelect = if preferredMediumStates then StateSelect.prefer else StateSelect.default)) 
      "理想气体介质的基本属性"
      annotation();
    equation
      assert(T >= 200 and T <= 6000, "
温度 T (= " + String(T) + " K) 不在允许范围内
需要介质模型 \"" + mediumName + "\" 中的范围 200 K <= T <= 6000 K。
");
      MM = data.MM;
      R_s = data.R_s;
      h = Modelica.Media.IdealGases.Common.Functions.h_T(
        data, T, 
        Modelica.Media.IdealGases.Common.Functions.excludeEnthalpyOfFormation, 
        Modelica.Media.IdealGases.Common.Functions.referenceChoice, 
        Modelica.Media.IdealGases.Common.Functions.h_offset);
      u = h - R_s * T;

      // 必须以 d=f(p,T) 的形式编写，以便可以对 p 和 T 进行静态状态选择
      d = p / (R_s * T);
      // 将状态与 BaseProperties 连接
      state.T = T;
      state.p = p;
    end BaseProperties;

    redeclare function setState_pTX 
      "根据 p、T 和组分 X 计算热力学状态"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "压力";
      input Temperature T "温度";
      input MassFraction X[:] = reference_X "质量分数";
      output ThermodynamicState state;
    algorithm
      state := ThermodynamicState(p = p, T = T);
      annotation(Inline = true, smoothOrder = 2);
    end setState_pTX;

    redeclare function setState_phX 
      "根据 p、h 和组分 X 计算热力学状态"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "压力";
      input SpecificEnthalpy h "比焓";
      input MassFraction X[:] = reference_X "质量分数";
      output ThermodynamicState state;
    algorithm
      state := ThermodynamicState(p = p, T = T_h(h));
      annotation(Inline = true, smoothOrder = 2);
    end setState_phX;

    redeclare function setState_psX 
      "根据 p、s 和组分 X 计算热力学状态"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "压力";
      input SpecificEntropy s "比熵";
      input MassFraction X[:] = reference_X "质量分数";
      output ThermodynamicState state;
    algorithm
      state := ThermodynamicState(p = p, T = T_ps(p, s));
      annotation(Inline = true, smoothOrder = 2);
    end setState_psX;

    redeclare function setState_dTX 
      "根据 d, T 和组分 X 计算热力状态"
      extends Modelica.Icons.Function;
      input Density d "密度";
      input Temperature T "温度";
      input MassFraction X[:] = reference_X "质量分数";
      output ThermodynamicState state;
    algorithm
      state := ThermodynamicState(p = d * data.R_s * T, T = T);
      annotation(Inline = true, smoothOrder = 2);
    end setState_dTX;

    redeclare function extends setSmoothState 
      "计算热力状态，使其平滑近似：如果 x > 0 则为 state_a，否则为 state_b"
    algorithm
      state := ThermodynamicState(p = Media.Common.smoothStep(x, state_a.p, state_b.p, x_small), 
        T = Media.Common.smoothStep(x, state_a.T, state_b.T, x_small));
      annotation(Inline = true, smoothOrder = 2);
    end setSmoothState;

    redeclare function extends pressure "计算理想气体的压力"
    algorithm
      p := state.p;
      annotation(Inline = true, smoothOrder = 2);
    end pressure;

    redeclare function extends temperature "计算理想气体的温度"
    algorithm
      T := state.T;
      annotation(Inline = true, smoothOrder = 2);
    end temperature;

    redeclare function extends density "计算理想气体的密度"
    algorithm
      d := state.p / (data.R_s * state.T);
      annotation(Inline = true, smoothOrder = 2);
    end density;

    redeclare function extends specificEnthalpy "计算比焓"
      extends Modelica.Icons.Function;
    algorithm
      h := Modelica.Media.IdealGases.Common.Functions.h_T(
        data, state.T);
      annotation(Inline = true, smoothOrder = 2);
    end specificEnthalpy;

    redeclare function extends specificInternalEnergy 
      "计算比内能"
      extends Modelica.Icons.Function;
    algorithm
      u := Modelica.Media.IdealGases.Common.Functions.h_T(
        data, state.T) - data.R_s * state.T;
      annotation(Inline = true, smoothOrder = 2);
    end specificInternalEnergy;

    redeclare function extends specificEntropy "计算比熵"
      extends Modelica.Icons.Function;
    algorithm
      s := Modelica.Media.IdealGases.Common.Functions.s0_T(
        data, state.T) - data.R_s * Modelica.Math.log(state.p / reference_p);
      annotation(Inline = true, smoothOrder = 2);
    end specificEntropy;

    redeclare function extends specificGibbsEnergy "计算比吉布斯能"
      extends Modelica.Icons.Function;
    algorithm
      g := Modelica.Media.IdealGases.Common.Functions.h_T(
        data, state.T) - state.T * specificEntropy(state);
      annotation(Inline = true, smoothOrder = 2);
    end specificGibbsEnergy;

    redeclare function extends specificHelmholtzEnergy 
      "计算比亥姆霍兹能"
      extends Modelica.Icons.Function;
    algorithm
      f := Modelica.Media.IdealGases.Common.Functions.h_T(
        data, state.T) - data.R_s * state.T - state.T * specificEntropy(state);
      annotation(Inline = true, smoothOrder = 2);
    end specificHelmholtzEnergy;

    redeclare function extends specificHeatCapacityCp 
      "计算定压比热容"
    algorithm
      cp := Modelica.Media.IdealGases.Common.Functions.cp_T(
        data, state.T);
      annotation(Inline = true, smoothOrder = 2);
    end specificHeatCapacityCp;

    redeclare function extends specificHeatCapacityCv 
      "根据温度和气体数据计算定容比热容"
    algorithm
      cv := Modelica.Media.IdealGases.Common.Functions.cp_T(
        data, state.T) - data.R_s;
      annotation(Inline = true, smoothOrder = 2);
    end specificHeatCapacityCv;

    redeclare function extends isentropicExponent "计算等熵指数"
    algorithm
      gamma := specificHeatCapacityCp(state) / specificHeatCapacityCv(state);
      annotation(Inline = true, smoothOrder = 2);
    end isentropicExponent;

    redeclare function extends velocityOfSound "计算声速"
      extends Modelica.Icons.Function;
    algorithm
      a := sqrt(max(0, data.R_s * state.T * Modelica.Media.IdealGases.Common.Functions.cp_T(
        data, state.T) / specificHeatCapacityCv(state)));
      annotation(Inline = true, smoothOrder = 2);
    end velocityOfSound;

    function isentropicEnthalpyApproximation 
      "根据上游属性和下游压力近似计算等熵焓"
      extends Modelica.Icons.Function;
      input SI.Pressure p2 "下游压力";
      input ThermodynamicState state "上游位置的属性";
      input Boolean exclEnthForm = Functions.excludeEnthalpyOfFormation 
        "如果为真，则不包括生成焓 Hf 在比焓 h 中";
      input ReferenceEnthalpy refChoice = Functions.referenceChoice 
        "参考焓的选择";
      input SpecificEnthalpy h_off = Functions.h_offset 
        "用户定义的参考焓偏移，如果 referenceChoice = UserDefined";
      output SI.SpecificEnthalpy h_is "等熵焓";
    protected
      IsentropicExponent gamma = isentropicExponent(state) "等熵指数";
    algorithm
      h_is := Modelica.Media.IdealGases.Common.Functions.h_T(
        data, state.T, exclEnthForm, refChoice, h_off) + 
        gamma / (gamma - 1.0) * state.p / density(state) * ((p2 / state.p) ^ ((gamma - 1) / gamma) - 1.0);
      annotation(Inline = true, smoothOrder = 2);
    end isentropicEnthalpyApproximation;

    redeclare function extends isentropicEnthalpy "计算等熵焓"
      input Boolean exclEnthForm = Functions.excludeEnthalpyOfFormation 
        "如果为真，则不包括生成焓 Hf 在比焓 h 中";
      input ReferenceEnthalpy refChoice = Functions.referenceChoice 
        "参考焓的选择";
      input SpecificEnthalpy h_off = Functions.h_offset 
        "用户定义的参考焓偏移，如果 referenceChoice = UserDefined";
    algorithm
      h_is := isentropicEnthalpyApproximation(p_downstream, refState, exclEnthForm, refChoice, h_off);
      annotation(Inline = true, smoothOrder = 2);
    end isentropicEnthalpy;

    redeclare function extends isobaricExpansionCoefficient 
      "计算等压膨胀系数 beta"
    algorithm
      beta := 1 / state.T;
      annotation(Inline = true, smoothOrder = 2);
    end isobaricExpansionCoefficient;

    redeclare function extends isothermalCompressibility 
      "计算等温压缩系数"
    algorithm
      kappa := 1.0 / state.p;
      annotation(Inline = true, smoothOrder = 2);
    end isothermalCompressibility;

    redeclare function extends density_derp_T 
      "计算在恒定温度下密度对压力的偏导数"
    algorithm
      ddpT := 1 / (state.T * data.R_s);
      annotation(Inline = true, smoothOrder = 2);
    end density_derp_T;

    redeclare function extends density_derT_p 
      "计算在恒定压力下密度对温度的偏导数"
    algorithm
      ddTp := -state.p / (state.T * state.T * data.R_s);
      annotation(Inline = true, smoothOrder = 2);
    end density_derT_p;

    redeclare function extends density_derX 
      "计算在恒定压力和温度下密度对质量分数的偏导数"
    algorithm
      dddX := fill(0, nX);
      annotation(Inline = true, smoothOrder = 2);
    end density_derX;

    redeclare replaceable function extends dynamicViscosity "动力黏度"
    algorithm
      assert(fluidConstants[1].hasCriticalData, 
        "无法计算 dynamicViscosity: 对于物质 \"" + mediumName + "\" 没有临界数据。");
      assert(fluidConstants[1].hasDipoleMoment, 
        "无法计算 dynamicViscosity: 对于物质 \"" + mediumName + "\" 没有临界数据。");
      eta := Modelica.Media.IdealGases.Common.Functions.dynamicViscosityLowPressure(
        state.T, 
        fluidConstants[1].criticalTemperature, 
        fluidConstants[1].molarMass, 
        fluidConstants[1].criticalMolarVolume, 
        fluidConstants[1].acentricFactor, 
        fluidConstants[1].dipoleMoment);
      annotation(smoothOrder = 2);
    end dynamicViscosity;

    redeclare replaceable function extends thermalConductivity 
      "气体的导热系数"
      //  input IdealGases.Common.DataRecord data "理想气体数据";
      input Integer method = Functions.methodForThermalConductivity 
        "1: Eucken 方法, 2: 修正 Eucken 方法";
    algorithm
      assert(fluidConstants[1].hasCriticalData, 
        "计算 thermalConductivity 失败：物质 \"" + mediumName + "\" 没有临界数据。");
      lambda := Modelica.Media.IdealGases.Common.Functions.thermalConductivityEstimate(
        specificHeatCapacityCp(state), 
        dynamicViscosity(state), method = method, data = data);
      annotation(smoothOrder = 2);
    end thermalConductivity;

    redeclare function extends molarMass "计算介质的摩尔质量"
    algorithm
      MM := data.MM;
      annotation(Inline = true, smoothOrder = 2);
    end molarMass;

    function T_h "根据比焓计算温度"
      extends Modelica.Icons.Function;
      input SpecificEnthalpy h "比焓";
      output Temperature T "温度";

    protected
      function f_nonlinear "通过给定的 h 计算 T 中的 h(data,T)（仅通过 temperature_phX 间接使用）"
        extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
        input DataRecord data "理想气体数据";
        input SpecificEnthalpy h "比焓";
        annotation();
      algorithm
        y := Functions.h_T(data = data, T = u) - h;
      end f_nonlinear;
      annotation();

    algorithm
      T := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
        function f_nonlinear(data = data, h = h), 200, 6000);
    end T_h;

    function T_ps "根据压力和比熵计算温度"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "压力";
      input SpecificEntropy s "比熵";
      output Temperature T "温度";

    protected
      function f_nonlinear "通过给定的 s 计算 T 中的 s(data,T)（仅通过 temperature_psX 间接使用）"
        extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
        input DataRecord data "理想气体数据";
        input AbsolutePressure p "压力";
        input SpecificEntropy s "比熵";
        annotation();
      algorithm
        y := Functions.s0_T(data = data, T = u) - data.R_s * Modelica.Math.log(p / reference_p) - s;
      end f_nonlinear;
      annotation();

    algorithm
      T := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
        function f_nonlinear(data = data, p = p, s = s), 200, 6000);
    end T_ps;

    // 下面的函数并不是严格必需的，只是为了兼容性而存在

    function dynamicViscosityLowPressure 
      "低压气体的动力黏度"
      extends Modelica.Icons.Function;
      input SI.Temperature T "气体温度";
      input SI.Temperature Tc "气体的临界温度";
      input SI.MolarMass M "气体的摩尔质量";
      input SI.MolarVolume Vc "气体的临界摩尔体积";
      input Real w "气体的离心因子";
      input Modelica.Media.Interfaces.Types.DipoleMoment mu 
        "气体分子的偶极矩";
      input Real k = 0.0 "高极性物质的特殊修正";
      output Modelica.Media.Interfaces.Types.DynamicViscosity eta 
        "气体的动力黏度";
    protected
      parameter Real Const1_SI = 40.785 * 10 ^ (-9.5) 
        "将 eta 公式中的常数转换为 SI 单位";
      parameter Real Const2_SI = 131.3 / 1000.0 
        "将 mur 公式中的常数转换为 SI 单位";
      Real mur = Const2_SI * mu / sqrt(Vc * Tc) 
        "气体分子的无量纲偶极矩";
      Real Fc = 1 - 0.2756 * w + 0.059035 * mur ^ 4 + k 
        "考虑气体分子形状和极性的因素";
      Real Tstar "由下面方程定义的无量纲温度";
      Real Ov "气体的黏度碰撞积分";

    algorithm
      eta := Functions.dynamicViscosityLowPressure(T, Tc, M, Vc, w, mu, k);
      annotation(smoothOrder = 2, 
        Documentation(info = "<html>
<p>
所使用的公式基于 Chung 等人的方法（1984年，1988年），参考文献[1]第9章。
使用的是公式9-4.10。该公式给出的是非SI单位，以下转换常数用于将公式转换为SI单位：
</p>

<ul>
<li> <strong>Const1_SI:</strong> 因子 10^(-9.5) =10^(-2.5)*1e-7 其中
 因子 10^(-2.5) 来自于 g/mol->kg/mol + cm^3/mol->m^3/mol 的转换，
  因子 1e-7 来自于 microPoise->Pa.s 的转换。</li>
<li>  <strong>Const2_SI:</strong> 因子 1/3.335641e-27 = 1e-3/3.335641e-30
  其中因子 3.335641e-30 来自于 debye->C.m，
  因子 1e-3 来自于 cm^3/mol->m^3/mol 的转换</li>
</ul>

<h4>参考文献</h4>
<p>
[1] Bruce E. Poling, John E. Prausnitz, John P. O'Connell, \"The Properties of Gases and Liquids\" 5th Ed. Mc Graw Hill.
</p>

<h4>作者</h4>
<p>T. Skoglund, Lund, Sweden, 2004-08-31</p>

</html>"    ));
    end dynamicViscosityLowPressure;

    function thermalConductivityEstimate 
      "多原子气体的导热系数（Eucken和Modified Eucken相关性）"
      extends Modelica.Icons.Function;
      input Modelica.Media.Interfaces.Types.SpecificHeatCapacity Cp 
        "定压热容";
      input Modelica.Media.Interfaces.Types.DynamicViscosity eta 
        "动力黏度";
      input Integer method(min = 1, max = 2) = 1 
        "1: Eucken 方法, 2: 修正 Eucken 方法";
      input IdealGases.Common.DataRecord data "理想气体数据";
      output Modelica.Media.Interfaces.Types.ThermalConductivity lambda 
        "导热系数 [W/(m.k)]";
    algorithm
      lambda := Functions.thermalConductivityEstimate(Cp, eta, method, data);
      annotation(smoothOrder = 2, 
        Documentation(info="<html><p>
此函数提供了两种类似的方法来估算多原子气体的导热系数。 Eucken 方法（method == 1）在低温下给出良好结果， 但在高温下会低估导热系数（lambda）的值。<br> 修正 Eucken 方法（method == 2）在高温下给出 良好结果，但在低温下会高估导热系数（lambda）的值。
</p>
</html>"));
    end thermalConductivityEstimate;

    annotation(
      Documentation(info="<html><p>
该模型计算单一物质的理想气体介质的介质性质， 或由几种物质组成的理想气体的介质，其中质量分数固定。 独立变量是温度 <strong>T</strong> 和压力 <strong>p</strong>。 只有密度是 T 和 p 的函数。所有其他量都是 T 的函数。 这些性质适用于以下范围：
</p>
<p>
<br>
</p>
<pre><code >200 K ≤ T ≤ 6000 K
</code></pre><p>
<br>
</p>
<p>
以下物性参数为系统强制计算项：
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>变量</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>单位</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>描述</strong></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">h</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">J/kg</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">比焓 h = h(T)</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">u</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">J/kg</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">比内能 u = u(T)</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">d</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">kg/m^3</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">密度 d = d(p,T)</td></tr></tbody></table><p>
对于其他变量，请参阅 Modelica.Media.IdealGases.Common.SingleGasNasa 中的函数。 请注意，动力黏度和导热系数仅对使用来自 Modelica.Media.IdealGases.FluidData 的数据记录的气体提供。 目前，这些气体包括以下内容：
</p>
<p>
<br>
</p>
<pre><code >Ar
C2H2_vinylidene
C2H4
C2H5OH
C2H6
C3H6_propylene
C3H7OH
C3H8
C4H8_1_butene
C4H9OH
C4H10_n_butane
C5H10_1_pentene
C5H12_n_pentane
C6H6
C6H12_1_hexene
C6H14_n_heptane
C7H14_1_heptene
C8H10_ethylbenz
CH3OH
CH4
CL2
CO
CO2
F2
H2
H2O
He
N2
N2O
NH3
NO
O2
SO2
SO3
</code></pre><p>
<strong>模型和文献来源：<br></strong><br>原始数据：Computer program for calculation of complex chemical<br>equilibrium compositions and applications. Part 1: Analysis<br>文档编号：19950013764 N（95N20180）文件系列：NASA技术报告<br>报告编号：NASA-RP-1311 E-8017 NAS 1.61:1311<br>作者：Gordon, Sanford（NASA Lewis 研究中心）<br> Mcbride, Bonnie J.（NASA Lewis 研究中心）<br>发布日期：1994年10月1日。<br>
</p>
<p>
<br>
</p>
<p>
<strong>已知有效范围：</strong><br> 数据适用于 温度在200K和6000K之间。 一些单原子气体的数据集在1000K处具有不连续的一阶导数，但 到目前为止从未引起问题。
</p>
<p>
该模型已从ThermoFluid库复制并适应了Modelica.Media库。
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"));
    redeclare function extends density_derp_h 
      "返回温度恒定条件下密度对压力的偏导数"
    algorithm
      ddph := 1/(state.T*data.R_s);
      annotation(Inline=true,smoothOrder=2);
    end density_derp_h;
    redeclare function extends density_derh_p 
      "返回压力恒定条件下密度对温度的偏导数"
    algorithm
      ddhp := -state.p / (state.T * state.T * data.R_s * specificHeatCapacityCp(state));
      annotation(Inline = true, smoothOrder = 2);
    end density_derh_p;
  end SingleGasNasa;

  partial package MixtureGasNasa 
    "基于NASA资料来源的理想气体混合物的介质模型"

    import Modelica.Math;
    import Modelica.Media.Interfaces.Choices.ReferenceEnthalpy;

    extends Modelica.Media.Interfaces.PartialMixtureMedium(
      ThermoStates = Modelica.Media.Interfaces.Choices.IndependentVariables.pTX, 
      substanceNames = data[:].name, 
      reducedX = false, 
      singleState = false, 
      reference_X = fill(1 / nX, nX), 
      SpecificEnthalpy(start = if referenceChoice == ReferenceEnthalpy.ZeroAt0K then 3e5 else 
      if referenceChoice == ReferenceEnthalpy.UserDefined then h_offset else 0, nominal = 1.0e5), 
      Density(start = 10, nominal = 10), 
      AbsolutePressure(start = 10e5, nominal = 10e5), 
      Temperature(min = 200, max = 6000, start = 500, nominal = 500));

    redeclare record extends ThermodynamicState "热力状态变量"
      annotation();
    end ThermodynamicState;

    //   redeclare record extends FluidConstants "流体常数"
    //   end FluidConstants;

    constant Modelica.Media.IdealGases.Common.DataRecord[:] data 
      "理想气体物质的数据记录";
    // ={Common.SingleGasesData.N2,Common.SingleGasesData.O2}

    constant Boolean excludeEnthalpyOfFormation = true 
      "= true，则焓不包括生成焓 Hf";
    constant ReferenceEnthalpy referenceChoice = ReferenceEnthalpy.ZeroAt0K 
      "焓的基准选择";
    constant SpecificEnthalpy h_offset = 0.0 
      "如果 referenceChoice = UserDefined，用户定义的焓基准偏移";

    //   constant FluidConstants[nX] fluidConstants
    //     "输运属性所需的附加数据";
    constant MolarMass[nX] MMX = data[:].MM "组分的摩尔质量";
    constant Integer methodForThermalConductivity(min = 1, max = 2) = 1;
    redeclare replaceable model extends BaseProperties(
      T(stateSelect = if preferredMediumStates then StateSelect.prefer else StateSelect.default), 
      p(stateSelect = if preferredMediumStates then StateSelect.prefer else StateSelect.default), 
      Xi(each stateSelect = if preferredMediumStates then StateSelect.prefer else StateSelect.default), 
      final standardOrderComponents = true) 
      "基类属性 (p, d, T, h, u, R_s, MM, X 和 NASA 混合气体的 Xi)"
      annotation();
    equation
      assert(T >= 200 and T <= 6000, "
温度 T (="   + String(T) + " K = 200 K) 不在允许范围内
200 K <= T <= 6000 K
要求来自介质模型 \""   + mediumName + "\".");

      MM = molarMass(state);
      h = h_TX(T, X);
      R_s = data.R_s * X;
      u = h - R_s * T;
      d = p / (R_s * T);
      // 将状态连接到基类属性
      state.T = T;
      state.p = p;
      state.X = if fixedX then reference_X else X;
    end BaseProperties;

    redeclare function setState_pTX 
      "返回热力状态，作为 p, T 和组分 X 的函数"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "压强";
      input Temperature T "温度";
      input MassFraction X[:] = reference_X "质量分数";
      output ThermodynamicState state;
    algorithm
      state := if size(X, 1) == 0 then ThermodynamicState(p = p, T = T, X = reference_X) else if size(X, 1) == nX then ThermodynamicState(p = p, T = T, X = X) else 
        ThermodynamicState(p = p, T = T, X = cat(1, X, {1 - sum(X)}));
      annotation(Inline = true, smoothOrder = 2);
    end setState_pTX;

    redeclare function setState_phX 
      "返回热力状态，作为 p, h 和组分 X 的函数"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "压强";
      input SpecificEnthalpy h "比焓";
      input MassFraction X[:] = reference_X "质量分数";
      output ThermodynamicState state;
    algorithm
      state := if size(X, 1) == 0 then ThermodynamicState(p = p, T = T_hX(h, reference_X), X = reference_X) else if size(X, 1) == nX then ThermodynamicState(p = p, T = T_hX(h, X), X = X) else 
        ThermodynamicState(p = p, T = T_hX(h, X), X = cat(1, X, {1 - sum(X)}));
      annotation(Inline = true, smoothOrder = 2);
    end setState_phX;

    redeclare function setState_psX 
      "返回热力状态，作为 p, s 和组分 X 的函数"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "压强";
      input SpecificEntropy s "比熵";
      input MassFraction X[:] = reference_X "质量分数";
      output ThermodynamicState state;
    algorithm
      state := if size(X, 1) == 0 then ThermodynamicState(p = p, T = T_psX(p, s, reference_X), X = reference_X) else if size(X, 1) == nX then ThermodynamicState(p = p, T = T_psX(p, s, X), X = X) else 
        ThermodynamicState(p = p, T = T_psX(p, s, X), X = cat(1, X, {1 - sum(X)}));
      annotation(Inline = true, smoothOrder = 2);
    end setState_psX;

    redeclare function setState_dTX 
      "返回热力状态，作为 d, T 和组分 X 的函数"
      extends Modelica.Icons.Function;
      input Density d "密度";
      input Temperature T "温度";
      input MassFraction X[:] = reference_X "质量分数";
      output ThermodynamicState state;
    algorithm
      state := if size(X, 1) == 0 then ThermodynamicState(p = d * (data.R_s * reference_X) * T, T = T, X = reference_X) else if size(X, 1) == nX then ThermodynamicState(p = d * (data.R_s * X) * T, T = T, X = X) else 
        ThermodynamicState(p = d * (data.R_s * cat(1, X, {1 - sum(X)})) * T, T = T, X = cat(1, X, {1 - sum(X)}));
      annotation(Inline = true, smoothOrder = 2);
    end setState_dTX;

    redeclare function extends setSmoothState 
      "返回热力状态，以便平滑地逼近：如果 x > 0 则为 state_a 否则为 state_b"
    algorithm
      state := ThermodynamicState(p = Media.Common.smoothStep(x, state_a.p, state_b.p, x_small), 
        T = Media.Common.smoothStep(x, state_a.T, state_b.T, x_small), 
        X = Media.Common.smoothStep(x, state_a.X, state_b.X, x_small));
      annotation(Inline = true, smoothOrder = 2);
    end setSmoothState;

    redeclare function extends pressure "计算理想气体的压强"
    algorithm
      p := state.p;
      annotation(Inline = true, smoothOrder = 2);
    end pressure;

    redeclare function extends temperature "计算理想气体的温度"
    algorithm
      T := state.T;
      annotation(Inline = true, smoothOrder = 2);
    end temperature;

    redeclare function extends density "计算理想气体的密度"
    algorithm
      d := state.p / ((state.X * data.R_s) * state.T);
      annotation(Inline = true, smoothOrder = 3);
    end density;

    redeclare function extends specificEnthalpy "计算比焓"
      extends Modelica.Icons.Function;
    algorithm
      h := h_TX(state.T, state.X);
      annotation(Inline = true, smoothOrder = 2);
    end specificEnthalpy;

    redeclare function extends specificInternalEnergy 
      "计算比内能"
      extends Modelica.Icons.Function;
    algorithm
      u := h_TX(state.T, state.X) - gasConstant(state) * state.T;
      annotation(Inline = true, smoothOrder = 2);
    end specificInternalEnergy;

    redeclare function extends specificEntropy "计算比熵"
      extends Modelica.Icons.Function;
    algorithm
      s := specificEntropyOfpTX(state.p, state.T, state.X);
      annotation(Inline = true, smoothOrder = 2);
    end specificEntropy;

    redeclare function extends specificGibbsEnergy "计算比吉布斯能"
      extends Modelica.Icons.Function;
    algorithm
      g := h_TX(state.T, state.X) - state.T * specificEntropy(state);
      annotation(Inline = true, smoothOrder = 2);
    end specificGibbsEnergy;

    redeclare function extends specificHelmholtzEnergy 
      "计算比亥姆霍兹能"
      extends Modelica.Icons.Function;
    algorithm
      f := h_TX(state.T, state.X) - gasConstant(state) * state.T - state.T * specificEntropy(state);
      annotation(Inline = true, smoothOrder = 2);
    end specificHelmholtzEnergy;

    function h_TX "计算比焓"
      import Modelica.Media.Interfaces.Choices;
      extends Modelica.Icons.Function;
      input SI.Temperature T "温度";
      input MassFraction X[nX] = reference_X 
        "气体混合物的独立质量分数";
      input Boolean exclEnthForm = excludeEnthalpyOfFormation 
        "=true，比焓中不包括形成焓 Hf";
      input Modelica.Media.Interfaces.Choices.ReferenceEnthalpy 
        refChoice = referenceChoice 
        "参考焓的选择";
      input SI.SpecificEnthalpy h_off = h_offset 
        "如果 referenceChoice = UserDefined，用户定义的参考焓偏移";
      output SI.SpecificEnthalpy h "温度 T 下的比焓";
    algorithm
      h := (if fixedX then reference_X else X) * 
        {Modelica.Media.IdealGases.Common.Functions.h_T(
        data[i], T, exclEnthForm, refChoice, h_off) for i in 1:nX};
      annotation(Inline = false, smoothOrder = 2);
    end h_TX;

    function h_TX_der "计算比焓导数"
      import Modelica.Media.Interfaces.Choices;
      extends Modelica.Icons.Function;
      input SI.Temperature T "温度";
      input MassFraction X[nX] "气体混合物的独立质量分数";
      input Boolean exclEnthForm = excludeEnthalpyOfFormation 
        "=true，比焓中不包括形成焓 Hf";
      input Modelica.Media.Interfaces.Choices.ReferenceEnthalpy 
        refChoice = referenceChoice 
        "参考焓的选择";
      input SI.SpecificEnthalpy h_off = h_offset 
        "如果 referenceChoice = UserDefined，用户定义的参考焓偏移";
      input Real dT "温度导数";
      input Real dX[nX] "独立质量分数导数";
      output Real h_der "温度 T 下的比焓";
    algorithm
      h_der := if fixedX then 
        dT * sum((Modelica.Media.IdealGases.Common.Functions.cp_T(
        data[i], T) * reference_X[i]) for i in 1:nX) else 
        dT * sum((Modelica.Media.IdealGases.Common.Functions.cp_T(
        data[i], T) * X[i]) for i in 1:nX) + 
        sum((Modelica.Media.IdealGases.Common.Functions.h_T(
        data[i], T) * dX[i]) for i in 1:nX);
      annotation(Inline = false, smoothOrder = 1);
    end h_TX_der;

    redeclare function extends gasConstant "计算气体常数"
    algorithm
      R_s := data.R_s * state.X;
      annotation(Inline = true, smoothOrder = 3);
    end gasConstant;

    redeclare function extends specificHeatCapacityCp 
      "计算定压比热容"
    algorithm
      cp := {Modelica.Media.IdealGases.Common.Functions.cp_T(
        data[i], state.T) for i in 1:nX} * state.X;
      annotation(Inline = true, smoothOrder = 1);
    end specificHeatCapacityCp;

    redeclare function extends specificHeatCapacityCv 
      "计算温度和气体数据下的定容比热容"
    algorithm
      cv := {Modelica.Media.IdealGases.Common.Functions.cp_T(
        data[i], state.T) for i in 1:nX} * state.X - data.R_s * state.X;
      annotation(Inline = true, smoothOrder = 1);
    end specificHeatCapacityCv;

    function MixEntropy "计算理想气体的混合熵 / R"
      extends Modelica.Icons.Function;
      input SI.MoleFraction x[:] "混合物的摩尔分数";
      output Real smix "混合熵贡献，除以气体常数";
    algorithm
      smix := sum(if x[i] > Modelica.Constants.eps then -x[i] * Modelica.Math.log(x[i]) else 
        x[i] for i in 1:size(x, 1));
      annotation(Inline = true, smoothOrder = 2);
    end MixEntropy;

    function s_TX 
      "计算比熵的温度依赖部分"
      extends Modelica.Icons.Function;
      input Temperature T "温度";
      input MassFraction[nX] X "质量分数";
      output SpecificEntropy s "比熵";
    algorithm
      s := sum(Modelica.Media.IdealGases.Common.Functions.s0_T(
        data[i], T) * X[i] for i in 1:size(X, 1));
      annotation(Inline = true, smoothOrder = 2);
    end s_TX;

    redeclare function extends isentropicExponent "计算绝热指数"
    algorithm
      gamma := specificHeatCapacityCp(state) / specificHeatCapacityCv(state);
      annotation(Inline = true, smoothOrder = 2);
    end isentropicExponent;

    redeclare function extends velocityOfSound "计算声速"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "上游位置的属性";
    algorithm
      a := sqrt(max(0, gasConstant(state) * state.T * specificHeatCapacityCp(state) / specificHeatCapacityCv(state)));
      annotation(Inline = true, smoothOrder = 2);
    end velocityOfSound;

    function isentropicEnthalpyApproximation 
      "计算 h_is 的近似方法，基于上游性质和下游压力"
      extends Modelica.Icons.Function;
      input AbsolutePressure p2 "下游压力";
      input ThermodynamicState state "上游位置的热力状态";
      output SpecificEnthalpy h_is "等熵焓";
    protected
      SpecificEnthalpy h "上游位置的比焓";
      SpecificEnthalpy h_component[nX] "上游位置的比焓";
      IsentropicExponent gamma = isentropicExponent(state) "等熵指数";
    protected
      MassFraction[nX] X "完整的 X 向量";
    algorithm
      X := if reducedX then cat(1, state.X, {1 - sum(state.X)}) else state.X;
      h_component := {Modelica.Media.IdealGases.Common.Functions.h_T(
        data[i], state.T, excludeEnthalpyOfFormation, 
        referenceChoice, h_offset) for i in 1:nX};
      h := h_component * X;
      h_is := h + gamma / (gamma - 1.0) * (state.T * gasConstant(state)) * 
        ((p2 / state.p) ^ ((gamma - 1) / gamma) - 1.0);
      annotation(smoothOrder = 2);
    end isentropicEnthalpyApproximation;

    redeclare function extends isentropicEnthalpy "计算等熵焓"
      input Boolean exact = false 
        "是否使用精确或近似版本的标志";
    algorithm
      h_is := if exact then specificEnthalpy_psX(p_downstream, specificEntropy(refState), refState.X) else 
        isentropicEnthalpyApproximation(p_downstream, refState);
      annotation(Inline = true, smoothOrder = 2);
    end isentropicEnthalpy;

    function gasMixtureViscosity 
      "计算低压气体混合物的黏性（Wilke 方法）"
      extends Modelica.Icons.Function;
      input MoleFraction[:] yi "摩尔分数";
      input MolarMass[size(yi, 1)] M "摩尔质量";
      input DynamicViscosity[size(yi, 1)] eta "纯组分黏性";
      output DynamicViscosity etam "混合物的黏性";
    protected
      Real fi[size(yi, 1),size(yi, 1)];
    algorithm
      for i in 1:size(eta, 1) loop
        assert(fluidConstants[i].hasDipoleMoment, "流体常数 " + fluidConstants[i].chemicalFormula + 
          " 的偶极矩未知。无法计算黏度。");
        assert(fluidConstants[i].hasCriticalData, "流体常数 " + fluidConstants[i].chemicalFormula + 
          " 的临界数据未知。无法计算黏度。");
        for j in 1:size(eta, 1) loop
          if i == 1 then
            fi[i,j] := (1 + (eta[i] / eta[j]) ^ (1 / 2) * (M[j] / M[i]) ^ (1 / 4)) ^ 2 / (8 * (1 + M[i] / M[j])) ^ (1 / 2);
          elseif j < i then
            fi[i,j] := eta[i] / eta[j] * M[j] / M[i] * fi[j,i];
          else
            fi[i,j] := (1 + (eta[i] / eta[j]) ^ (1 / 2) * (M[j] / M[i]) ^ (1 / 4)) ^ 2 / (8 * (1 + M[i] / M[j])) ^ (1 / 2);
          end if;
        end for;
      end for;
      etam := sum(yi[i] * eta[i] / sum(yi[j] * fi[i,j] for j in 1:size(eta, 1)) for i in 1:size(eta, 1));

      annotation(smoothOrder = 2, 
        Documentation(info = "<html>

<p>
简化的动力学理论（Chapman 和 Enskog 理论）方法，忽略了二阶效应。<br>
<br>
该方程经过广泛测试（Amdur 和 Mason, 1958; Bromley 和 Wilke, 1951; Cheung, 1958; Dahler, 1959; Gandhi 和 Saxena,
1964; Ranz 和 Brodowsky, 1962; Saxena 和 Gambhir, 1963a; Strunk, 等人,
1964; Vanderslice, 等人, 1962; Wright 和 Gray, 1962）。在大多数情况下，仅比较了非极性混合物，得到了非常好的结果。对于一些含氢作为一个组分的系统，结果较不理想。Wilke 方法预测的 H2-N2 系统的混合黏性高于实验值，但对于 H2-NH3 系统，则低于实验值。<br>
Gururaja, 等人 (1967) 发现该方法在 H2-O2 情况下也高估了，但在 H2-CO2 系统中非常准确。<br>
Wilke 的近似方法即使对于脂肪族醇的极性-极性气体混合物也被证明是可靠的（Reid 和 Belenyessy, 1960）。<br>
主要保留意见在于 Mi&gt;&gt;Mj 和 etai&gt;&gt;etaj 的情况下。
</p>

</html>"  ));
    end gasMixtureViscosity;

    redeclare replaceable function extends dynamicViscosity 
      "计算混合物动力黏度"
    protected
      DynamicViscosity[nX] etaX "组分动力黏度";
    algorithm
      for i in 1:nX loop
        etaX[i] := Modelica.Media.IdealGases.Common.Functions.dynamicViscosityLowPressure(
          state.T, 
          fluidConstants[i].criticalTemperature, 
          fluidConstants[i].molarMass, 
          fluidConstants[i].criticalMolarVolume, 
          fluidConstants[i].acentricFactor, 
          fluidConstants[i].dipoleMoment);
      end for;
      eta := gasMixtureViscosity(massToMoleFractions(state.X, 
        fluidConstants[:].molarMass), 
        fluidConstants[:].molarMass, 
        etaX);
      annotation(smoothOrder = 2);
    end dynamicViscosity;

    function mixtureViscosityChung 
      "不通过组分黏性计算气体混合物的黏性（Chung 等人的规则）"
      extends Modelica.Icons.Function;

      input Temperature T "温度";
      input Temperature[nX] Tc "临界温度";
      input MolarVolume[nX] Vcrit "临界容积 (m3/mol)";
      input Real[nX] w "偏心因子";
      input Real[nX] mu "偶极矩 (debyes)";
      input MolarMass[nX] MolecularWeights "摩尔质量 (kg/mol)";
      input MoleFraction[nX] y "摩尔分数";
      input Real[nX] kappa = zeros(nX) "关联因子";
      output DynamicViscosity etaMixture "混合物黏度 (Pa.s)";
    protected
      constant Real[size(y, 1)] Vc = Vcrit * 1000000 "临界容积 (cm3/mol)";
      constant Real[size(y, 1)] M = MolecularWeights * 1000 
        "摩尔质量 (g/mol)";
      Integer n = size(y, 1) "混合元素数量";
      Real sigmam3 "混合物 sigma3 (单位：埃)";
      Real sigma[size(y, 1),size(y, 1)];
      Real edivkm;
      Real edivk[size(y, 1),size(y, 1)];
      Real Mm;
      Real Mij[size(y, 1),size(y, 1)];
      Real wm "偏心因子";
      Real wij[size(y, 1),size(y, 1)];
      Real kappam 
        "高度极性物质（如醇类和酸类）的相关性";
      Real kappaij[size(y, 1),size(y, 1)];
      Real mum;
      Real Vcm;
      Real Tcm;
      Real murm "混合物的无量纲偶极矩";
      Real Fcm "用于校正形状和极性的因子";
      Real omegav;
      Real Tmstar;
      Real etam "混合物黏度 (microP)";
    algorithm
      // 组合规则
      for i in 1:n loop
        for j in 1:n loop
          Mij[i,j] := 2 * M[i] * M[j] / (M[i] + M[j]);
          if i == j then
            sigma[i,j] := 0.809 * Vc[i] ^ (1 / 3);
            edivk[i,j] := Tc[i] / 1.2593;
            wij[i,j] := w[i];
            kappaij[i,j] := kappa[i];
          else
            sigma[i,j] := (0.809 * Vc[i] ^ (1 / 3) * 0.809 * Vc[j] ^ (1 / 3)) ^ (1 / 2);
            edivk[i,j] := (Tc[i] / 1.2593 * Tc[j] / 1.2593) ^ (1 / 2);
            wij[i,j] := (w[i] + w[j]) / 2;
            kappaij[i,j] := (kappa[i] * kappa[j]) ^ (1 / 2);
          end if;
        end for;
      end for;
      //混合规则
      sigmam3 := (sum(sum(y[i] * y[j] * sigma[i,j] ^ 3 for j in 1:n) for i in 1:n));
      //(epsilon/k)m
      edivkm := (sum(sum(y[i] * y[j] * edivk[i,j] * sigma[i,j] ^ 3 for j in 1:n) for i in 1:n)) / sigmam3;
      Mm := ((sum(sum(y[i] * y[j] * edivk[i,j] * sigma[i,j] ^ 2 * Mij[i,j] ^ (1 / 2) for j in 1:n) for i in 1:n)) / (edivkm * sigmam3 ^ (2 / 3))) ^ 2;
      wm := (sum(sum(y[i] * y[j] * wij[i,j] * sigma[i,j] ^ 3 for j in 1:n) for i in 1:n)) / sigmam3;
      mum := (sigmam3 * (sum(sum(y[i] * y[j] * mu[i] ^ 2 * mu[j] ^ 2 / sigma[i,j] ^ 3 for j in 1:n) for i in 1:n))) ^ (1 / 4);
      Vcm := sigmam3 / (0.809) ^ 3 "eq. (4)";
      Tcm := 1.2593 * edivkm "eq. (5)";
      murm := 131.3 * mum / (Vcm * Tcm) ^ (1 / 2) "eq. (8)";
      kappam := (sigmam3 * (sum(sum(y[i] * y[j] * kappaij[i,j] for j in 1:n) for i in 1:n)));
      Fcm := 1 - 0.275 * wm + 0.059035 * murm ^ 4 + kappam "eq. (7)";
      Tmstar := T / edivkm "eq. (3)";
      omegav := 1.16145 * (Tmstar) ^ (-0.14874) + 0.52487 * Modelica.Math.exp(-0.77320 * Tmstar) + 2.16178 * Modelica.Math.exp(-2.43787 * Tmstar) "eq. (2)";
      etam := 26.69 * Fcm * (Mm * T) ^ (1 / 2) / (sigmam3 ^ (2 / 3) * omegav) "eq. (1)";
      etaMixture := etam * 1e-7;  // 从microPoise到Pa.s的转换

      annotation(smoothOrder = 2, 
        Documentation(info = "<html>

<p>
用于估算低压下气体混合物黏度的方程。<br>
它是对 Chapman 和 Enskog 的严格运动理论进行简化的扩展，
用于确定多组分混合物在低压下的黏度，并用一个因子校正分子形状和极性。
</p>

<p>
输入参数 Kappa 是对高度极性物质如醇类和酸类的特殊修正。<br>
以下是一些材料的 kappa 值：
</p>

<table style=\"text-align: left; width: 302px; height: 200px;\" border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tbody>
<tr>
<td style=\"vertical-align: top;\">Compound<br>
</td>
<td style=\"vertical-align: top; text-align: center;\">Kappa<br>
</td>
<td style=\"vertical-align: top;\">Compound<br>
</td>
<td style=\"vertical-align: top;\">Kappa<br>
</td>
</tr>
<tr>
<td style=\"vertical-align: top;\">Methanol<br>
</td>
<td style=\"vertical-align: top;\">0.215<br>
</td>
<td style=\"vertical-align: top;\">n-Pentanol<br>
</td>
<td style=\"vertical-align: top;\">0.122<br>
</td>
</tr>
<tr>
<td style=\"vertical-align: top;\">Ethanol<br>
</td>
<td style=\"vertical-align: top;\">0.175<br>
</td>
<td style=\"vertical-align: top;\">n-Hexanol<br>
</td>
<td style=\"vertical-align: top;\">0.114<br>
</td>
</tr>
<tr>
<td style=\"vertical-align: top;\">n-Propanol<br>
</td>
<td style=\"vertical-align: top;\">0.143<br>
</td>
<td style=\"vertical-align: top;\">n-Heptanol<br>
</td>
<td style=\"vertical-align: top;\">0.109<br>
</td>
</tr>
<tr>
<td style=\"vertical-align: top;\">i-Propanol<br>
</td>
<td style=\"vertical-align: top;\">0.143<br>
</td>
<td style=\"vertical-align: top;\">Acetic Acid<br>
</td>
<td style=\"vertical-align: top;\">0.0916<br>
</td>
</tr>
<tr>
<td style=\"vertical-align: top;\">n-Butanol<br>
</td>
<td style=\"vertical-align: top;\">0.132<br>
</td>
<td style=\"vertical-align: top;\">Water<br>
</td>
<td style=\"vertical-align: top;\">0.076<br>
</td>
</tr>
<tr>
<td style=\"vertical-align: top;\">i-Butanol<br>
</td>
<td style=\"vertical-align: top;\">0.132</td>
<td style=\"vertical-align: top;\"><br>
</td>
<td style=\"vertical-align: top;\"><br>
</td>
</tr>
</tbody>
</table>
<p>
Chung, et al. (1984) suggest that for other alcohols not shown in the
table:<br>
&nbsp;&nbsp;&nbsp;&nbsp;<br>
&nbsp;&nbsp;&nbsp; kappa = 0.0682 + 4.704*[(number of -OH
groups)]/[molecular weight]<br>
<br>
<span style=\"font-weight: normal;\">S.I. 单位制中的 debyes 关系：&nbsp;</span><br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; 1 debye = 3.162e-25 (J.m^3)^(1/2)<br>
</p>
<h4>参考文献</h4>
<p>
[1] THE PROPERTIES OF GASES AND LIQUIDS, Fifth Edition,<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; Bruce E. Poling, John M.
Prausnitz, John P. O'Connell.<br>
[2] Chung, T.-H., M. Ajlan, L. L. Lee, and K. E. Starling: Ind. Eng.
Chem. Res., 27: 671 (1988).<br>
[3] Chung, T.-H., L. L. Lee, and K. E. Starling; Ing. Eng. Chem.
Fundam., 23: 3 ()1984).<br>
</p>
</html>"      ));
    end mixtureViscosityChung;

    function lowPressureThermalConductivity 
      "计算低压气体混合物的导热系数（Mason 和 Saxena 修改）"
      extends Modelica.Icons.Function;

      input MoleFraction[:] y "气体混合物中组分的摩尔分数";
      input Temperature T "温度";
      input Temperature[size(y, 1)] Tc "临界温度";
      input AbsolutePressure[size(y, 1)] Pc "临界压力";
      input MolarMass[size(y, 1)] M "摩尔质量";
      input ThermalConductivity[size(y, 1)] lambda 
        "纯气体的导热系数";
      output ThermalConductivity lambdam "气体混合物的导热系数";
    protected
      MolarMass[size(y, 1)] gamma;
      Real[size(y, 1)] Tr "还原温度";
      Real[size(y, 1),size(y, 1)] A "Mason 和 Saxena 修改";
      constant Real epsilon = 1.0 "接近于 1 的数值常数";
    algorithm
      for i in 1:size(y, 1) loop
        gamma[i] := 210 * (Tc[i] * M[i] ^ 3 / Pc[i] ^ 4) ^ (1 / 6);
        Tr[i] := T / Tc[i];
      end for;
      for i in 1:size(y, 1) loop
        for j in 1:size(y, 1) loop
          A[i,j] := epsilon * (1 + (gamma[j] * (Math.exp(0.0464 * Tr[i]) - Math.exp(-0.2412 * Tr[i])) / 
            (gamma[i] * (Math.exp(0.0464 * Tr[j]) - Math.exp(-0.2412 * Tr[j])))) ^ (1 / 2) * (M[i] / M[j]) ^ (1 / 4)) ^ 2 / 
            (8 * (1 + M[i] / M[j])) ^ (1 / 2);
        end for;
      end for;
      lambdam := sum(y[i] * lambda[i] / (sum(y[j] * A[i,j] for j in 1:size(y, 1))) for i in 1:size(y, 1));

      annotation(smoothOrder = 2, 
        Documentation(info="<html><p>
该函数应用了 Masson 和 Saxena 对 Wassiljewa 方程的修改，用于计算 n 元素的气体混合物在低压下的导热系数。
</p>
<p>
对于非极性气体混合物，误差通常小于 3% 至 4%。对于非极性-极性和极性-极性气体的混合物，可能会出现大于 5% 至 8% 的误差。对于组分分子的大小和极性差异不大的混合物，可以通过纯组分导热系数的摩尔分数平均值很好地估算导热系数。
</p>
</html>"  ));
    end lowPressureThermalConductivity;

    redeclare replaceable function extends thermalConductivity 
      "计算低压气体混合物的导热系数"
      input Integer method = methodForThermalConductivity 
        "计算单组分导热系数的方法";
    protected
      ThermalConductivity[nX] lambdaX "组分导热系数";
      DynamicViscosity[nX] eta "组分动力黏度";
      SpecificHeatCapacity[nX] cp "组分热容";
    algorithm
      for i in 1:nX loop
        assert(fluidConstants[i].hasCriticalData, "临界数据 " + fluidConstants[i].chemicalFormula + 
          " 未知。无法计算导热系数。");
        eta[i] := Modelica.Media.IdealGases.Common.Functions.dynamicViscosityLowPressure(
          state.T, 
          fluidConstants[i].criticalTemperature, 
          fluidConstants[i].molarMass, 
          fluidConstants[i].criticalMolarVolume, 
          fluidConstants[i].acentricFactor, 
          fluidConstants[i].dipoleMoment);
        cp[i] := Modelica.Media.IdealGases.Common.Functions.cp_T(
          data[i], state.T);
        lambdaX[i] := Modelica.Media.IdealGases.Common.Functions.thermalConductivityEstimate(
          Cp = cp[i], eta = 
          eta[i], method = method, data = data[i]);
      end for;
      lambda := lowPressureThermalConductivity(massToMoleFractions(state.X, 
        fluidConstants[:].molarMass), 
        state.T, 
        fluidConstants[:].criticalTemperature, 
        fluidConstants[:].criticalPressure, 
        fluidConstants[:].molarMass, 
        lambdaX);
      annotation(smoothOrder = 2);
    end thermalConductivity;

    redeclare function extends isobaricExpansionCoefficient 
      "计算定压膨胀系数 beta"
    algorithm
      beta := 1 / state.T;
      annotation(Inline = true, smoothOrder = 2);
    end isobaricExpansionCoefficient;

    redeclare function extends isothermalCompressibility 
      "计算等温压缩系数"
    algorithm
      kappa := 1.0 / state.p;
      annotation(Inline = true, smoothOrder = 2);
    end isothermalCompressibility;

    redeclare function extends density_derp_T  "计算密度对压力在恒温条件下的导数"
    algorithm
      ddpT := 1 / (state.T * gasConstant(state));
      annotation(Inline = true, smoothOrder = 2);
    end density_derp_T;

    redeclare function extends density_derT_p 
      "计算密度对温度在恒压条件下的导数"
    algorithm
      ddTp := -state.p / (state.T * state.T * gasConstant(state));
      annotation(Inline = true, smoothOrder = 2);
    end density_derT_p;

    redeclare function density_derX "计算密度对质量分数的导数"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "热力学状态记录表";
      output Density[nX] dddX "密度相对于质量分数的导数";
    algorithm
      dddX := {-state.p / (state.T * gasConstant(state)) * molarMass(state) / data[
        i].MM for i in 1:nX};
      annotation(Inline = true, smoothOrder = 2);
    end density_derX;

    redeclare function extends molarMass "计算混合物的摩尔质量"
    algorithm
      MM := 1 / sum(state.X[j] / data[j].MM for j in 1:size(state.X, 1));
      annotation(Inline = true, smoothOrder = 2);
    end molarMass;

    function T_hX "通过比焓和质量分数计算温度"
      extends Modelica.Icons.Function;
      input SpecificEnthalpy h "比焓";
      input MassFraction[nX] X "成分的质量分数";
      input Boolean exclEnthForm = excludeEnthalpyOfFormation 
        "=true，比焓 h 中不包括生成焓 Hf";
      input Modelica.Media.Interfaces.Choices.ReferenceEnthalpy 
        refChoice = referenceChoice 
        "基准焓的选择";
      input SI.SpecificEnthalpy h_off = h_offset 
        "如果 referenceChoice = UserDefined，用户定义的基准焓偏移量";
      output Temperature T "温度";

    protected
      function f_nonlinear "通过给定 h 求解 h_TX(T,X) 得到 T"
        extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
        input SpecificEnthalpy h "比焓";
        input MassFraction[nX] X "成分的质量分数";
        input Boolean exclEnthForm "=true，比焓 h 中不包括生成焓 Hf";
        input Modelica.Media.Interfaces.Choices.ReferenceEnthalpy refChoice "基准焓的选择";
        input SpecificEnthalpy h_off "如果 referenceChoice = UserDefined，用户定义的基准焓偏移量";
        annotation();
      algorithm
        y := h_TX(T = u, X = X, exclEnthForm = exclEnthForm, refChoice = refChoice, h_off = h_off) - h;
      end f_nonlinear;

    algorithm
      T := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
        function f_nonlinear(h = h, X = X, exclEnthForm = exclEnthForm, refChoice = refChoice, h_off = h_off), 200, 6000);
      annotation(inverse(h = h_TX(T, X, exclEnthForm, refChoice, h_off)));
    end T_hX;

    function T_psX 
      "通过压力、比熵和质量分数计算温度"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "压力";
      input SpecificEntropy s "比熵";
      input MassFraction[nX] X "成分的质量分数";
      output Temperature T "温度";

    protected
      function f_nonlinear "通过给定 s 求解 specificEntropyOfpTX(p,T,X) 得到 T"
        extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
        input AbsolutePressure p "压力";
        input SpecificEntropy s "比熵";
        input MassFraction[nX] X "成分的质量分数";
        annotation();
      algorithm
        y := specificEntropyOfpTX(p = p, T = u, X = X) - s;
      end f_nonlinear;

    algorithm
      T := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
        function f_nonlinear(p = p, s = s, X = X), 200, 6000);
      annotation(inverse(s = specificEntropyOfpTX(p, T, X)));
    end T_psX;

  protected
    function specificEntropyOfpTX 
      "通过压力、温度和质量分数计算比熵"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "压力";
      input Temperature T "温度";
      input MassFraction[nX] X "成分的质量分数";
      output SpecificEntropy s "比熵";
    protected
      Real[nX] Y(each unit = "mol/mol") = massToMoleFractions(X, data.MM) "摩尔分数";
    algorithm
      s := s_TX(T, X) - sum(X[i] * Modelica.Constants.R / MMX[i] * 
        (if X[i] < Modelica.Constants.eps then Y[i] else 
        Modelica.Math.log(Y[i] * p / reference_p)) for i in 1:nX);
      annotation(Inline = true, smoothOrder = 2);
    end specificEntropyOfpTX;

    annotation(Documentation(info = "<html>
<p>
此模型计算单组分理想气体的介质性质。
</p>
<p>
<strong>模型和文献来源：</strong><br>
原始数据：Computer program for calculation of complex chemical
equilibrium compositions and applications. Part 1: Analysis
文档 ID：19950013764 N (95N20180) 文件系列：NASA 技术报告
报告编号：NASA-RP-1311 E-8017 NAS 1.61:1311
作者：Sanford Gordon (NASA Lewis Research Center)
 Bonnie J. Mcbride (NASA Lewis Research Center)
出版时间：1994 年 10 月 1 日。
</p>
<p><strong>已知的有效性限制：</strong><br>
数据在 200 K 到 6000 K 的温度范围内有效。 
少数单原子气体的数据在 1000 K 时具有不连续的一阶导数，但到目前为止，这从未引起过问题。
</p>
<p>
此模型已从 ThermoFluid 库中复制。
由 Hubertus Tummescheit 开发。
</p>
</html>"  ));
  public
  redeclare function extends density_derp_h 
        "在恒温条件下返回密度对压力的导数"
      algorithm
        ddph := 1 / (state.T * gasConstant(state));
        annotation(Inline = true, smoothOrder = 2);
      end density_derp_h;
    redeclare function extends density_derh_p 
      "在恒压条件下返回密度对温度的导数"
    algorithm
      ddhp := -state.p / (state.T * state.T * gasConstant(state) * specificHeatCapacityCp(state));
      annotation(Inline = true, smoothOrder = 2);
    end density_derh_p;
  end MixtureGasNasa;
  annotation(Documentation(info = "<html>
</html>"));
end Common;