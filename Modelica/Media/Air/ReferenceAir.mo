within Modelica.Media.Air;
package ReferenceAir 
  "ReferenceAir:基于亥姆霍兹状态方程的详细干空气模型,工作范围(130... 2000K,0...2000MPa)"
  extends Modelica.Icons.VariantsPackage;

  constant Modelica.Media.Interfaces.Types.TwoPhase.FluidConstants 
    airConstants(
    chemicalFormula = "N2+O2+Ar", 
    structureFormula = "N2+O2+Ar", 
    casRegistryNumber = "1", 
    iupacName = "air", 
    molarMass = 0.02896546, 
    criticalTemperature = 132.5306, 
    criticalPressure = 3.786e6, 
    criticalMolarVolume = 0.02896546 / 342.68, 
    triplePointTemperature = 63.05 "From N2", 
    triplePointPressure = 0.1253e5 "From N2", 
    normalBoilingPoint = 78.903, 
    meltingPoint = 0, 
    acentricFactor = 0.0335, 
    dipoleMoment = 0.0, 
    hasCriticalData = true, 
    hasFundamentalEquation = true, 
    hasAccurateViscosityData = true, 
    hasAcentricFactor = true);

  type MolarHeatCapacity = SI.MolarHeatCapacity(
    min = 0, 
    max = 3.e5, 
    nominal = 3.e1, 
    start = 3.e1) 
    "具有介质特定属性的摩尔热容类型" annotation();

protected
  type MolarDensity = Real(
    final quantity = "MolarDensity", 
    final unit = "mol/m3", 
    min = 0) annotation();

  type IsothermalExpansionCoefficient = Real(
    min = 0, 
    max = 1e8, 
    unit = "1") annotation();

public
  package Air_ph 
    "ReferenceAir.Air_ph: 详细的干空气模型 (130...2000 K),显式表达 p 和 h"
    extends Modelica.Icons.MaterialProperty;
    extends Modelica.Media.Air.ReferenceAir.Air_Base(
      ThermoStates = Modelica.Media.Interfaces.Choices.IndependentVariables.ph, 

      final ph_explicit = true, 
      final dT_explicit = false, 
      final pT_explicit = false);

    annotation(Documentation(info = "<html>
<h4>使用方法</h4>
<p>
库 Air_ph 可以像其他介质模型一样使用（请参阅 <a href=\"modelica://Modelica.Media.UsersGuide\">介质库用户指南</a> 获取更多信息）。
</p>
</html>"));
  end Air_ph;

  package Air_pT 
    "ReferenceAir.Air_pT: 详细的干空气模型 (130...2000 K),显式表达 p 和 T"
    extends Modelica.Icons.MaterialProperty;
    extends Modelica.Media.Air.ReferenceAir.Air_Base(
      ThermoStates = Modelica.Media.Interfaces.Choices.IndependentVariables.pT, 

      final ph_explicit = false, 
      final dT_explicit = false, 
      final pT_explicit = true);

    annotation(Documentation(info = "<html>
<h4>使用方法</h4>
<p>
库 Air_pT 可以像其他介质模型一样使用（请参阅 <a href=\"modelica://Modelica.Media.UsersGuide\">介质库用户指南</a> 获取更多信息）。
</p>
</html>"));
  end Air_pT;

public
  package Air_dT 
    "ReferenceAir.Air_dT: 详细的干空气模型 (130...2000 K),显式表达 d 和 T"
    extends Modelica.Icons.MaterialProperty;
    extends Modelica.Media.Air.ReferenceAir.Air_Base(
      ThermoStates = Modelica.Media.Interfaces.Choices.IndependentVariables.dTX, 

      final ph_explicit = false, 
      final dT_explicit = true, 
      final pT_explicit = false);

    annotation(Documentation(info = "<html>
<h4>使用方法</h4>
<p>
库 Air_dT 可以像其他介质模型一样使用（请参阅 <a href=\"modelica://Modelica.Media.UsersGuide\">介质库用户指南</a> 获取更多信息）。
</p>
</html>"));
  end Air_dT;

partial package Air_Base 
    "使用 Lemmon 等人的状态方程计算的干空气性质"

    extends Modelica.Media.Interfaces.PartialPureSubstance(
      mediumName = "Air", 
      substanceNames = {"air"}, 
      singleState = false, 
      SpecificEnthalpy(start = 1.0e5, nominal = 5.0e5), 
      Density(start = 1.0, nominal = 1.2), 
      AbsolutePressure(
      start = 1e5, 
      nominal = 1e5, 
      min = 1.0, 
      max = 2000e6), 
      Temperature(
      start = 273.15, 
      nominal = 293.15, 
      min = 130, 
      max = 2000));

    constant Boolean ph_explicit 
      "如果是显式的压力和比焓，则为 true";
    constant Boolean dT_explicit 
      "如果是显式的密度和温度，则为 true";
    constant Boolean pT_explicit 
      "如果是显式的压力和温度，则为 true";

    redeclare record extends ThermodynamicState "热力学状态"
      SpecificEnthalpy h "比焓";
      Density d "密度";
      Temperature T "温度";
      AbsolutePressure p "压力";
      annotation();
    end ThermodynamicState;

    redeclare model extends BaseProperties(
      h(stateSelect = if ph_explicit and preferredMediumStates then StateSelect.prefer 
      else StateSelect.default), 
      d(stateSelect = if dT_explicit and preferredMediumStates then StateSelect.prefer 
      else StateSelect.default), 
      T(stateSelect = if (pT_explicit or dT_explicit) and preferredMediumStates 
      then StateSelect.prefer else StateSelect.default), 
      p(stateSelect = if (pT_explicit or ph_explicit) and preferredMediumStates 
      then StateSelect.prefer else StateSelect.default)) 
      "空气的基本性质"
      annotation();

    equation
      MM = Air_Utilities.Basic.Constants.MM;
      if dT_explicit then
        p = pressure_dT(d, T);
        h = specificEnthalpy_dT(d, T);
      elseif ph_explicit then
        d = density_ph(p, h);
        T = temperature_ph(p, h);
      else
        h = specificEnthalpy_pT(p, T);
        d = density_pT(p, T);
      end if;
      u = h - p / d;
      R_s = Air_Utilities.Basic.Constants.R_s;
      h = state.h;
      p = state.p;
      T = state.T;
      d = state.d;
    end BaseProperties;

    redeclare function density_ph 
      "根据压力和比焓计算密度"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "压力";
      input SpecificEnthalpy h "比焓";
      output Density d "密度";
    algorithm
      d := Air_Utilities.rho_ph(p, h);
      annotation(Inline = true);
    end density_ph;

    redeclare function temperature_ph 
      "根据压力和比焓计算温度"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "压力";
      input SpecificEnthalpy h "比焓";
      output Temperature T "温度";
    algorithm
      T := Air_Utilities.T_ph(p, h);
      annotation(Inline = true);
    end temperature_ph;

    redeclare function temperature_ps 
      "根据压力和比熵计算温度"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "压力";
      input SpecificEntropy s "比熵";
      output Temperature T "温度";
    algorithm
      T := Air_Utilities.T_ps(p, s);
      annotation(Inline = true);
    end temperature_ps;

    redeclare function density_ps 
      "根据压力和比熵计算密度"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "压力";
      input SpecificEntropy s "比熵";
      output Density d "密度";
    algorithm
      d := Air_Utilities.rho_ps(p, s);
      annotation(Inline = true);
    end density_ps;

    redeclare function pressure_dT 
      "根据密度和温度计算压力"
      extends Modelica.Icons.Function;
      input Density d "密度";
      input Temperature T "温度";
      output AbsolutePressure p "压力";
    algorithm
      p := Air_Utilities.p_dT(d, T);
      annotation(Inline = true);
    end pressure_dT;

    redeclare function specificEnthalpy_dT 
      "根据密度和温度计算比焓"
      extends Modelica.Icons.Function;
      input Density d "密度";
      input Temperature T "温度";
      output SpecificEnthalpy h "比焓";
    algorithm
      h := Air_Utilities.h_dT(d, T);
      annotation(Inline = true);
    end specificEnthalpy_dT;

    redeclare function specificEnthalpy_pT 
      "根据压力和温度计算比焓"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "压力";
      input Temperature T "温度";
      output SpecificEnthalpy h "比焓";
    algorithm
      h := Air_Utilities.h_pT(p, T);
      annotation(Inline = true);
    end specificEnthalpy_pT;

    redeclare function specificEnthalpy_ps 
      "根据压力和比熵计算比焓"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "压力";
      input SpecificEntropy s "比熵";
      output SpecificEnthalpy h "比焓";
    algorithm
      h := Air_Utilities.h_ps(p, s);
      annotation(Inline = true);
    end specificEnthalpy_ps;

    redeclare function density_pT 
      "根据压力和温度计算密度"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "压力";
      input Temperature T "温度";
      output Density d "密度";

    algorithm
      d := Air_Utilities.rho_pT(p, T);
      annotation(Inline = true);
    end density_pT;

    redeclare function extends dynamicViscosity 
      "计算热力状态记录的动力黏度"
    algorithm
      eta := Air_Utilities.Transport.eta_dT(state.d, state.T);
      annotation(Inline = true);
    end dynamicViscosity;

    redeclare function extends thermalConductivity 
      "计算空气的导热系数"
    algorithm
      lambda := Air_Utilities.Transport.lambda_dT(state.d, state.T);
      annotation(Inline = true);
    end thermalConductivity;

    redeclare function extends pressure "计算理想气体的压力"
    algorithm
      p := state.p;
      annotation(Inline = true);
    end pressure;

    redeclare function extends temperature "计算理想气体的温度"
    algorithm
      T := state.T;
      annotation(Inline = true);
    end temperature;

    redeclare function extends density "计算理想气体的密度"
    algorithm
      d := state.d;
      annotation(Inline = true);
    end density;

    redeclare function extends specificEnthalpy "计算比焓"

    algorithm
      h := state.h;
      annotation(Inline = true);
    end specificEnthalpy;

    redeclare function extends specificInternalEnergy 
      "计算比内能"
    algorithm
      u := state.h - state.p / state.d;
      annotation(Inline = true);
    end specificInternalEnergy;

    redeclare function extends specificGibbsEnergy 
      "计算比吉布斯能"
    algorithm
      g := state.h - state.T * specificEntropy(state);
      annotation(Inline = true);
    end specificGibbsEnergy;

    redeclare function extends specificHelmholtzEnergy 
      "计算比亥姆霍兹能"
    algorithm
      f := state.h - state.p / state.d - state.T * specificEntropy(state);
      annotation(Inline = true);
    end specificHelmholtzEnergy;

    redeclare function extends specificEntropy "计算空气的比熵"
      annotation();
    algorithm
      if dT_explicit then
        s := Air_Utilities.s_dT(state.d, state.T);
      elseif pT_explicit then
        s := Air_Utilities.s_pT(state.p, state.T);
      else
        s := Air_Utilities.s_ph(state.p, state.h);
      end if;
    end specificEntropy;

    redeclare function extends specificHeatCapacityCp 
      "空气在恒压下的比热容"
      annotation();
    algorithm
      if dT_explicit then
        cp := Air_Utilities.cp_dT(state.d, state.T);
      elseif pT_explicit then
        cp := Air_Utilities.cp_pT(state.p, state.T);
      else
        cp := Air_Utilities.cp_ph(state.p, state.h);
      end if;
    end specificHeatCapacityCp;

    redeclare function extends specificHeatCapacityCv 
      "空气在恒容下的比热容"
      annotation();
    algorithm
      if dT_explicit then
        cv := Air_Utilities.cv_dT(state.d, state.T);
      elseif pT_explicit then
        cv := Air_Utilities.cv_pT(state.p, state.T);
      else
        cv := Air_Utilities.cv_ph(state.p, state.h);
      end if;
    end specificHeatCapacityCv;

    redeclare function extends isentropicExponent 
      "计算等熵指数"
      annotation();
    algorithm
      if dT_explicit then
        gamma := Air_Utilities.isentropicExponent_dT(state.d, state.T);
      elseif pT_explicit then
        gamma := Air_Utilities.isentropicExponent_pT(state.p, state.T);
      else
        gamma := Air_Utilities.isentropicExponent_ph(state.p, state.h);
      end if;
    end isentropicExponent;

    redeclare function extends isothermalCompressibility 
      "空气的等温压缩系数"
      annotation();
    algorithm
      if dT_explicit then
        kappa := Air_Utilities.kappa_dT(state.d, state.T);
      elseif pT_explicit then
        kappa := Air_Utilities.kappa_pT(state.p, state.T);
      else
        kappa := Air_Utilities.kappa_ph(state.p, state.h);
      end if;
    end isothermalCompressibility;

    redeclare function extends isobaricExpansionCoefficient 
      "空气的等压膨胀系数"
      annotation();
    algorithm
      if dT_explicit then
        beta := Air_Utilities.beta_dT(state.d, state.T);
      elseif pT_explicit then
        beta := Air_Utilities.beta_pT(state.p, state.T);
      else
        beta := Air_Utilities.beta_ph(state.p, state.h);
      end if;
    end isobaricExpansionCoefficient;

    redeclare function extends velocityOfSound 
      "根据热力状态记录计算声速"
      annotation();

    algorithm
      if dT_explicit then
        a := Air_Utilities.velocityOfSound_dT(state.d, state.T);
      elseif pT_explicit then
        a := Air_Utilities.velocityOfSound_pT(state.p, state.T);
      else
        a := Air_Utilities.velocityOfSound_ph(state.p, state.h);
      end if;
    end velocityOfSound;

    redeclare function extends density_derh_p 
      "密度对比焓的导数"
    algorithm
      ddhp := Air_Utilities.ddhp(state.p, state.h);
      annotation(Inline = true);
    end density_derh_p;

    redeclare function extends density_derp_h 
      "密度对压力的导数"
    algorithm
      ddph := Air_Utilities.ddph(state.p, state.h);
      annotation(Inline = true);
    end density_derp_h;

    //   redeclare function extends density_derT_p
    //     "密度对温度的导数"
    //   algorithm
    //     ddTp := IF97_Utilities.ddTp(state.p, state.h, state.phase);
    //   end density_derT_p;
    //
    //   redeclare function extends density_derp_T
    //     "密度对压力的导数"
    //   algorithm
    //     ddpT := IF97_Utilities.ddpT(state.p, state.h, state.phase);
    //   end density_derp_T;

    redeclare function extends setState_dTX 
      "根据密度和温度计算空气的热力状态"

    algorithm
      state := ThermodynamicState(
        d = d, 
        T = T, 
        h = specificEnthalpy_dT(d, T), 
        p = pressure_dT(d, T));
      annotation(Inline = true);
    end setState_dTX;

    redeclare function extends setState_phX 
      "根据压力和焓计算空气的热力状态"
    algorithm
      state := ThermodynamicState(
        d = density_ph(p, h), 
        T = temperature_ph(p, h), 
        h = h, 
        p = p);
      annotation(Inline = true);
    end setState_phX;

    redeclare function extends setState_psX 
      "根据压力和熵计算空气的热力状态"
    algorithm
      state := ThermodynamicState(
        d = density_ps(p, s), 
        T = temperature_ps(p, s), 
        h = specificEnthalpy_ps(p, s), 
        p = p);
      annotation(Inline = true);
    end setState_psX;

    redeclare function extends setState_pTX 
      "根据压力和温度计算空气的热力状态"
    algorithm
      state := ThermodynamicState(
        d = density_pT(p, T), 
        T = T, 
        h = specificEnthalpy_pT(p, T), 
        p = p);
      annotation(Inline = true);
    end setState_pTX;

    redeclare function extends setSmoothState 
      "计算热力状态，使其平滑近似：如果 x > 0 则为 state_a，否则为 state_b"
      import Modelica.Media.Common.smoothStep;

    algorithm
      state := ThermodynamicState(
        p = smoothStep(
        x, 
        state_a.p, 
        state_b.p, 
        x_small), 
        h = smoothStep(
        x, 
        state_a.h, 
        state_b.h, 
        x_small), 
        d = density_ph(smoothStep(
        x, 
        state_a.p, 
        state_b.p, 
        x_small), smoothStep(
        x, 
        state_a.h, 
        state_b.h, 
        x_small)), 
        T = temperature_ph(smoothStep(
        x, 
        state_a.p, 
        state_b.p, 
        x_small), smoothStep(
        x, 
        state_a.h, 
        state_b.h, 
        x_small)));
      annotation(Inline = true);
    end setSmoothState;

    redeclare function extends isentropicEnthalpy
    algorithm
      h_is := specificEnthalpy_psX(
        p_downstream, 
        specificEntropy(refState), 
        reference_X);
      annotation(Inline = true);
    end isentropicEnthalpy;

    redeclare function extends molarMass 
      "计算介质的摩尔质量"
    algorithm
      MM := Modelica.Media.Air.ReferenceAir.airConstants.molarMass;
      annotation(Inline = true);
    end molarMass;

    annotation(Documentation(info="<html><p>
此模型计算空气在<strong>液相</strong>、<strong>气相</strong>和<strong>两相</strong>区域的介质性质。 该模型的独立变量可以有三对：
</p>
<ol><li>
压力<strong>p</strong>和比焓<strong>h</strong>是一般应用中最多的选择。这是大多数通用应用的推荐选择。</li>
<li>
压力<strong>p</strong>和温度<strong>T</strong>是空气始终处于同一相（液相或气相）时的最多选择。</li>
<li>
密度<strong>d</strong>和温度<strong>T</strong>在近临界区域是亥姆霍兹函数的显式变量，可以是超临界或近临界状态应用的最佳选择。</li>
</ol><p>
始终计算以下量：
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>变量</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>单位</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>描述</strong></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">T</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">K</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">温度</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">u</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">J/kg</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">比内能</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">d</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">kg/m^3</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">密度</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">p</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Pa</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">压力</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">h</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">J/kg</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">比焓</td></tr></tbody></table><p>
在某些情况下，需要额外的介质性质。 需要这些可选性质的组件必须调用以下列出的函数之一： <a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.OptionalProperties\" target=\"\"> Modelica.Media.UsersGuide.MediumUsage.OptionalProperties</a> 和 <a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.TwoPhase\" target=\"\"> Modelica.Media.UsersGuide.MediumUsage.TwoPhase</a>。
</p>
<p>
可以计算许多进一步的性质。使用著名的 Bridgman 表，可以轻松计算标准热力学变量的所有一阶偏导数。
</p>
<p>
<br>
</p>
</html>"));
  end Air_Base;

  package Air_Utilities 
    "高精度干空气属性的低级和公用计算"
    extends Modelica.Icons.UtilitiesPackage;

    record iter = Inverses.accuracy annotation();
    package Basic "基本状态方程"
      extends Modelica.Icons.BasesPackage;

      constant Modelica.Media.Common.FundamentalConstants Constants(
        final R_bar = 8.31451, 
        final R_s = 287.117, 
        final MM = 28.9586E-003, 
        final rhored = 10447.7, 
        final Tred = 132.6312, 
        final pred = 3785020, 
        h_off = 1589557.62320524, 
        s_off = 6610.41237132543);

      function Helmholtz "亥姆霍兹状态方程"
        extends Modelica.Icons.Function;
        input SI.Density d "密度";
        input SI.Temperature T "温度 (K)";
        output Modelica.Media.Common.HelmholtzDerivs f 
          "无量纲亥姆霍兹函数及其对 delta 和 tau 的导数";

      protected
        final constant Real[13] N_0 = {0.605719400E-007, -0.210274769E-004, -0.158860716E-003, 
          -0.13841928076E002, 0.17275266575E002, -0.195363420E-003, 
          0.2490888032E001, 0.791309509, 0.212236768, 0.197938904, 
          0.2536365E002, 0.1690741E002, 0.8731279E002};
        final constant Real[19] N = {0.118160747229, 0.713116392079, -0.161824192067E001, 
          0.714140178971E-001, -0.865421396646E-001, 0.134211176704, 
          0.112626704218E-001, -0.420533228842E-001, 0.349008431982E-001, 
          0.164957183186E-003, -0.101365037912, -0.173813690970, -0.472103183731E-001, 
          -0.122523554253E-001, -0.146629609713, -0.316055879821E-001, 
          0.233594806142E-003, 0.148287891978E-001, -0.938782884667E-002};
        final constant Integer[19] i = {1, 1, 1, 2, 3, 3, 4, 4, 4, 6, 1, 3, 5, 6, 1, 3, 11, 1, 3};
        final constant Real[19] j = {0, 0.33, 1.01, 0, 0, 0.15, 0, 0.2, 0.35, 1.35, 1.6, 
          0.8, 0.95, 1.25, 3.6, 6, 3.25, 3.5, 15};
        final constant Integer[19] l = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 3, 3};
        annotation();

      algorithm
        f.d := d;
        f.T := T;
        f.R_s := ReferenceAir.Air_Utilities.Basic.Constants.R_s;
        //约简密度
        f.delta := d / (ReferenceAir.Air_Utilities.Basic.Constants.MM * 
          ReferenceAir.Air_Utilities.Basic.Constants.rhored);
        //倒数约简温度
        f.tau := ReferenceAir.Air_Utilities.Basic.Constants.Tred / T;

        //无量纲的亥姆霍兹方程
        f.f := 0;
        //理想气体部分
        for k in 1:5 loop
          f.f := f.f + N_0[k] * f.tau ^ (k - 4);
        end for;
        f.f := f.f + log(f.delta) + N_0[6] * f.tau * sqrt(f.tau) + N_0[7] * log(f.tau) 
          + N_0[8] * log(1 - exp(-N_0[11] * f.tau)) + N_0[9] * log(1 - exp(-N_0[12] 
          * f.tau)) + N_0[10] * log(2 / 3 + exp(N_0[13] * f.tau));
        //残差部分
        for k in 1:10 loop
          f.f := f.f + N[k] * f.delta ^ i[k] * f.tau ^ j[k];
        end for;
        for k in 11:19 loop
          f.f := f.f + N[k] * f.delta ^ i[k] * f.tau ^ j[k] * exp(-f.delta ^ l[k]);
        end for;

        //对 delta 求 f 的一阶导数
        f.fdelta := 0;
        //理想气体部分
        f.fdelta := 1 / f.delta;
        //残差部分
        for k in 1:10 loop
          f.fdelta := f.fdelta + i[k] * N[k] * f.delta ^ (i[k] - 1) * f.tau ^ j[k];
        end for;
        for k in 11:19 loop
          f.fdelta := f.fdelta + N[k] * f.delta ^ (i[k] - 1) * f.tau ^ j[k] * exp(-f.delta 
            ^ l[k]) * (i[k] - l[k] * f.delta ^ l[k]);
        end for;

        //对 delta 求 f 的二阶导数
        f.fdeltadelta := 0;
        //理想气体部分
        f.fdeltadelta := -1 / f.delta ^ 2;
        //残差部分
        for k in 1:10 loop
          f.fdeltadelta := f.fdeltadelta + i[k] * (i[k] - 1) * N[k] * f.delta ^ (i[k] 
            - 2) * f.tau ^ j[k];
        end for;
        for k in 11:19 loop
          f.fdeltadelta := f.fdeltadelta + N[k] * f.delta ^ (i[k] - 2) * f.tau ^ j[k] 
            * exp(-f.delta ^ l[k]) * ((i[k] - l[k] * f.delta ^ l[k]) * (i[k] - 1 - l[k] * 
            f.delta ^ l[k]) - l[k] ^ 2 * f.delta ^ l[k]);
        end for;

        //对 tau 求 f 的一阶导数
        f.ftau := 0;
        //理想气体部分
        for k in 1:5 loop
          f.ftau := f.ftau + (k - 4) * N_0[k] * f.tau ^ (k - 5);
        end for;
        f.ftau := f.ftau + 1.5 * N_0[6] * sqrt(f.tau) + N_0[7] / f.tau + N_0[8] * N_0
          [11] / (exp(N_0[11] * f.tau) - 1) + N_0[9] * N_0[12] / (exp(N_0[12] * f.tau) 
          - 1) + N_0[10] * N_0[13] / (2 / 3 * exp(-N_0[13] * f.tau) + 1);
        //残差部分
        for k in 1:10 loop
          f.ftau := f.ftau + j[k] * N[k] * f.delta ^ i[k] * f.tau ^ (j[k] - 1);
        end for;
        for k in 11:19 loop
          f.ftau := f.ftau + j[k] * N[k] * f.delta ^ i[k] * f.tau ^ (j[k] - 1) * exp(-f.delta 
            ^ l[k]);
        end for;

        //对 tau 求 f 的二阶导数
        f.ftautau := 0;
        //理想气体部分
        for k in 1:3 loop
          f.ftautau := f.ftautau + (k - 4) * (k - 5) * N_0[k] * f.tau ^ (k - 6);
        end for;
        f.ftautau := f.ftautau + 0.75 * N_0[6] / sqrt(f.tau) - N_0[7] / f.tau ^ 2 - 
          N_0[8] * N_0[11] ^ 2 * exp(N_0[11] * f.tau) / (exp(N_0[11] * f.tau) - 1) ^ 2 - 
          N_0[9] * N_0[12] ^ 2 * exp(N_0[12] * f.tau) / (exp(N_0[12] * f.tau) - 1) ^ 2 + 2 / 
          3 * N_0[10] * N_0[13] ^ 2 * exp(-N_0[13] * f.tau) / (2 / 3 * exp(-N_0[13] * f.tau) + 
          1) ^ 2;

        //残差部分
        for k in 1:10 loop
          f.ftautau := f.ftautau + j[k] * (j[k] - 1) * N[k] * f.delta ^ i[k] * f.tau ^ (j[
            k] - 2);
        end for;
        for k in 11:19 loop
          f.ftautau := f.ftautau + j[k] * (j[k] - 1) * N[k] * f.delta ^ i[k] * f.tau ^ (j[
            k] - 2) * exp(-f.delta ^ l[k]);
        end for;
        //对 delta 和 tau 求 f 的混合二阶导数
        f.fdeltatau := 0;
        //残差部分（理想气体部分为零）
        for k in 1:10 loop
          f.fdeltatau := f.fdeltatau + i[k] * j[k] * N[k] * f.delta ^ (i[k] - 1) * f.tau 
            ^ (j[k] - 1);
        end for;
        for k in 11:19 loop
          f.fdeltatau := f.fdeltatau + j[k] * N[k] * f.delta ^ (i[k] - 1) * f.tau ^ (j[
            k] - 1) * exp(-f.delta ^ l[k]) * (i[k] - l[k] * f.delta ^ l[k]);
        end for;

      end Helmholtz;
      annotation();
    end Basic;

    package Inverses "逆函数"
      extends Modelica.Icons.BasesPackage;

      record accuracy "迭代的精度"
        extends Modelica.Icons.Record;
        constant Real delp = 1E-001 "p 的精度";
        constant Real delh = 1E-009 "h 的精度";
        constant Real dels = 1E-006 "s 的精度";
        annotation();
      end accuracy;

      function dofpT "为给定的 p 和 T 计算 d"
        extends Modelica.Icons.Function;
        input SI.Pressure p "压力";
        input SI.Temperature T "温度（K）";
        input SI.Pressure delp "如果（p-pre(p) < delp）则迭代收敛";
        output SI.Density d "密度";

      protected
        Integer i = 0 "循环计数器";
        Real dp "压力差";
        SI.Density deld "密度步长";
        Modelica.Media.Common.HelmholtzDerivs f 
          "无量纲的亥姆霍兹函数及其对 delta 和 tau 的导数";
        Modelica.Media.Common.NewtonDerivatives_pT nDerivs 
          "牛顿迭代中需要的导数";
        Boolean found = false "迭代成功的标志";
        annotation();


      algorithm
        d := p / (ReferenceAir.Air_Utilities.Basic.Constants.R_s * T);

        while ((i < 100) and not found) loop
          f := Basic.Helmholtz(d, T);
          nDerivs := Modelica.Media.Common.Helmholtz_pT(f);
          dp := nDerivs.p - p;
          if (abs(dp) <= delp) then
            found := true;
          end if;
          deld := dp / nDerivs.pd;
          d := d - deld;
          i := i + 1;
        end while;
      end dofpT;

      function dTofph "计算 d 和 T 作为 p 和 h 的函数"
        extends Modelica.Icons.Function;
        input SI.Pressure p "压力";
        input SI.SpecificEnthalpy h "比焓";
        input SI.Pressure delp "迭代精度";
        input SI.SpecificEnthalpy delh "迭代精度";
        output SI.Density d "密度";
        output SI.Temperature T "温度（K）";

      protected
        SI.Temperature Tguess "初始温度";
        SI.Density dguess "初始密度";
        Integer i "迭代计数器";
        Real dh "h 方向上的牛顿误差";
        Real dp "p 方向上的牛顿误差";
        Real det "方向导数的行列式";
        Real deld "d 方向上的牛顿步长";
        Real delt "T 方向上的牛顿步长";
        Modelica.Media.Common.HelmholtzDerivs f 
          "无量纲的亥姆霍兹函数及其对 delta 和 tau 的导数";
        Modelica.Media.Common.NewtonDerivatives_ph nDerivs 
          "牛顿迭代中需要的导数";
        Boolean found = false "迭代成功的标志";
        annotation();

      algorithm
        // Stefan Wischhusen: 更好的高温初始值估计：

        T := h / 1000 + 273.15;
        d := p / (ReferenceAir.Air_Utilities.Basic.Constants.R_s * T);
        i := 0;

        while ((i < 100) and not found) loop
          f := Basic.Helmholtz(d, T);
          nDerivs := Modelica.Media.Common.Helmholtz_ph(f);
          dh := nDerivs.h - ReferenceAir.Air_Utilities.Basic.Constants.h_off 
            - h;
          dp := nDerivs.p - p;
          if ((abs(dh) <= delh) and (abs(dp) <= delp)) then
            found := true;
          end if;
          det := nDerivs.ht * nDerivs.pd - nDerivs.pt * nDerivs.hd;
          delt := (nDerivs.pd * dh - nDerivs.hd * dp) / det;
          deld := (nDerivs.ht * dp - nDerivs.pt * dh) / det;
          T := T - delt;
          d := d - deld;
          i := i + 1;
        end while;
      end dTofph;

      function dTofps "计算 d 和 T 作为 p 和 s 的函数"
        extends Modelica.Icons.Function;
        input SI.Pressure p "压力";
        input SI.SpecificEntropy s "比熵";
        input SI.Pressure delp "迭代精度";
        input SI.SpecificEntropy dels "迭代精度";
        output SI.Density d "密度";
        output SI.Temperature T "温度（K）";

      protected
        SI.Temperature Tguess "初始温度";
        SI.Density dguess "初始密度";
        Integer i "迭代计数器";
        Real ds "s 方向上的牛顿误差";
        Real dp "p 方向上的牛顿误差";
        Real det "方向导数的行列式";
        Real deld "d 方向上的牛顿步长";
        Real delt "T 方向上的牛顿步长";
        Modelica.Media.Common.HelmholtzDerivs f 
          "无量纲的亥姆霍兹函数及其对 delta 和 tau 的导数";
        Modelica.Media.Common.NewtonDerivatives_ps nDerivs 
          "牛顿迭代中需要的导数";
        Boolean found = false "迭代成功的标志";
        annotation();


      algorithm
        T := 273.15;
        d := p / (ReferenceAir.Air_Utilities.Basic.Constants.R_s * T);
        i := 0;

        while ((i < 100) and not found) loop
          f := Basic.Helmholtz(d, T);
          nDerivs := Modelica.Media.Common.Helmholtz_ps(f);
          ds := nDerivs.s - ReferenceAir.Air_Utilities.Basic.Constants.s_off 
            - s;
          dp := nDerivs.p - p;
          if ((abs(ds) <= dels) and (abs(dp) <= delp)) then
            found := true;
          end if;
          det := nDerivs.st * nDerivs.pd - nDerivs.pt * nDerivs.sd;
          delt := (nDerivs.pd * ds - nDerivs.sd * dp) / det;
          deld := (nDerivs.st * dp - nDerivs.pt * ds) / det;
          T := T - delt;
          d := d - deld;
          i := i + 1;
        end while;
      end dTofps;
      annotation();
    end Inverses;

    package Transport "空气的输运属性"
      extends Modelica.Icons.BasesPackage;

      function eta_dT "计算动力黏度作为 d 和 T 的函数"
        extends Modelica.Icons.Function;
        input SI.Density d "密度";
        input SI.Temperature T "温度";
        output SI.DynamicViscosity eta "动力黏度";

      protected
        Real delta = d / (ReferenceAir.Air_Utilities.Basic.Constants.MM * 
          ReferenceAir.Air_Utilities.Basic.Constants.rhored) 
          "约简密度";
        Real tau = ReferenceAir.Air_Utilities.Basic.Constants.Tred / T 
          "倒数约简温度";
        Real Omega "碰撞积分";
        SI.DynamicViscosity eta_0 = 0 "稀薄气体黏度";
        SI.DynamicViscosity eta_r = 0 "剩余流体黏度";
        final constant Real[5] b = {0.431, -0.4623, 0.08406, 0.005341, -0.00331};
        final constant Real[5] Nvis = {10.72, 1.122, 0.002019, -8.876, -0.02916};
        final constant Real[5] tvis = {0.2, 0.05, 2.4, 0.6, 3.6};
        final constant Integer[5] dvis = {1, 4, 9, 1, 8};
        final constant Integer[5] lvis = {0, 0, 0, 1, 1};
        final constant Integer[5] gammavis = {0, 0, 0, 1, 1};
        annotation();

      algorithm
        Omega := exp(
          Modelica.Math.Polynomials.evaluate(
          {b[5], b[4], b[3], b[2], b[1]}, log(T / 103.3)));
        eta_0 := 0.0266958 * sqrt(1000 * ReferenceAir.Air_Utilities.Basic.Constants.MM 
          * T) / (0.36 ^ 2 * Omega);
        for i in 1:5 loop
          eta_r := eta_r + (Nvis[i] * (tau ^ tvis[i]) * (delta ^ dvis[i]) * exp(-
            gammavis[i] * (delta ^ lvis[i])));
        end for;
        eta := (eta_0 + eta_r) * 1E-006;
      end eta_dT;

      function lambda_dT 
        "计算导热系数作为 d 和 T 的函数"
        extends Modelica.Icons.Function;
        input SI.Density d "密度";
        input SI.Temperature T "温度";
        output SI.ThermalConductivity lambda "导热系数";

      protected
        Modelica.Media.Common.HelmholtzDerivs f 
          "无量纲的亥姆霍兹函数及其对 delta 和 tau 的导数";
        SI.ThermalConductivity lambda_0 = 0 "稀薄气体导热系数";
        SI.ThermalConductivity lambda_r = 0 
          "剩余流体导热系数";
        SI.ThermalConductivity lambda_c = 0 
          "导热系数临界增强";
        Real Omega "碰撞积分";
        SI.DynamicViscosity eta_0 = 0 "稀薄气体黏度";
        Real pddT;
        Real pddTref;
        Real pdTp;
        Real xi;
        Real xiref;
        Real Omega_tilde;
        Real Omega_0_tilde;
        Real cv;
        Real cp;
        final constant Real[5] b = {0.431, -0.4623, 0.08406, 0.005341, -0.00331};
        final constant Real[9] Ncon = {1.308, 1.405, -1.036, 8.743, 14.76, -16.62, 
          3.793, -6.142, -0.3778};
        final constant Real[9] tcon = {0.0, -1.1, -0.3, 0.1, 0.0, 0.5, 2.7, 0.3, 1.3};
        final constant Integer[9] dcon = {0, 0, 0, 1, 2, 3, 7, 7, 11};
        final constant Integer[9] lcon = {0, 0, 0, 0, 0, 2, 2, 2, 2};
        final constant Integer[9] gammacon = {0, 0, 0, 0, 0, 1, 1, 1, 1};
        annotation();

      algorithm
        //在参考温度 265.262 下的 chi_tilde
        f := Basic.Helmholtz(d, 265.262);
        pddTref := ReferenceAir.Air_Utilities.Basic.Constants.R_bar * 265.262 * (
          1 + 2 * f.delta * (f.fdelta - 1 / f.delta) + f.delta ^ 2 * (f.fdeltadelta + 1 
          / f.delta ^ 2));
        xiref := ReferenceAir.Air_Utilities.Basic.Constants.pred * (d / 
          ReferenceAir.Air_Utilities.Basic.Constants.MM) / ReferenceAir.Air_Utilities.Basic.Constants.rhored 
          ^ 2 / pddTref;
        //计算给定状态下的 f
        f := Basic.Helmholtz(d, T);
        Omega := exp(
          Modelica.Math.Polynomials.evaluate(
          {b[5], b[4], b[3], b[2], b[1]}, log(T / 103.3)));
        //动力黏度的理想气体部分
        eta_0 := 0.0266958 * sqrt(1000 * ReferenceAir.Air_Utilities.Basic.Constants.MM 
          * T) / (0.36 ^ 2 * Omega);
        //导热系数的理想气体部分
        lambda_0 := Ncon[1] * eta_0 + Ncon[2] * f.tau ^ tcon[2] + Ncon[3] * f.tau ^ 
          tcon[3];
        //导热系数的剩余部分
        for i in 4:9 loop
          lambda_r := lambda_r + Ncon[i] * f.tau ^ tcon[i] * f.delta ^ dcon[i] * exp(-
            gammacon[i] * f.delta ^ lcon[i]);
        end for;
        //在恒定温度下对 d 的 p 导数
        pddT := ReferenceAir.Air_Utilities.Basic.Constants.R_s * T * (1 + 2 * f.delta 
          * (f.fdelta - 1 / f.delta) + f.delta ^ 2 * (f.fdeltadelta + 1 / f.delta ^ 2));
        //给定状态下的 chi_tilde
        xi := ReferenceAir.Air_Utilities.Basic.Constants.pred * (d / ReferenceAir.Air_Utilities.Basic.Constants.MM) 
          / ReferenceAir.Air_Utilities.Basic.Constants.rhored ^ 2 / (pddT * 
          ReferenceAir.Air_Utilities.Basic.Constants.MM);
        //导热系数临界增强
        xi := xi - xiref * 265.262 / T;
        if (xi <= 0) then
          lambda_c := 0;
        else
          xi := 0.11 * (xi / 0.055) ^ (0.63 / 1.2415);
          //在恒定压力下对 T 的 p 导数
          pdTp := ReferenceAir.Air_Utilities.Basic.Constants.R_s * d * (1 + f.delta 
            * (f.fdelta - 1 / f.delta) - f.delta * f.tau * f.fdeltatau);
          //比定容热容
          cv := ReferenceAir.Air_Utilities.Basic.Constants.R_s * (-f.tau * f.tau * f.ftautau);
          //比定压热容
          cp := cv + T * pdTp * pdTp / (d * d * pddT);
          Omega_tilde := 2 / Modelica.Constants.pi * ((cp - cv) / cp * atan(xi / 0.31) 
            + cv / cp * xi / 0.31);
          Omega_0_tilde := 2 / Modelica.Constants.pi * (1 - exp(-1 / ((0.31 / xi) + 1 
            / 3 * (xi / 0.31) ^ 2 * (ReferenceAir.Air_Utilities.Basic.Constants.rhored 
            / (d / ReferenceAir.Air_Utilities.Basic.Constants.MM)) ^ 2)));
          lambda_c := d * cp * 1.380658E-023 * 1.01 * T / (6 * Modelica.Constants.pi * xi * 
            eta_dT(d, T)) * (Omega_tilde - Omega_0_tilde) * 1E012;
        end if;
        lambda := (lambda_0 + lambda_r + lambda_c) / 1000;
      end lambda_dT;
      annotation();
    end Transport;

    function airBaseProp_ps "空气的中间属性记录"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.SpecificEntropy s "比熵";
      output Common.AuxiliaryProperties aux "辅助记录";
    protected
      Modelica.Media.Common.HelmholtzDerivs f 
        "无量纲的亥姆霍兹函数及其对 delta 和 tau 的导数";
      annotation();
    algorithm
      aux.p := p;
      aux.s := s;
      aux.R_s := ReferenceAir.Air_Utilities.Basic.Constants.R_s;
      (aux.rho,aux.T) := Inverses.dTofps(
        p = p, 
        s = s, 
        delp = iter.delp, 
        dels = iter.dels);
      f := Basic.Helmholtz(aux.rho, aux.T);
      aux.h := aux.R_s * aux.T * (f.tau * f.ftau + f.delta * f.fdelta) - ReferenceAir.Air_Utilities.Basic.Constants.h_off;
      aux.pd := aux.R_s * aux.T * f.delta * (2 * f.fdelta + f.delta * f.fdeltadelta);
      aux.pt := aux.R_s * aux.rho * f.delta * (f.fdelta - f.tau * f.fdeltatau);
      aux.cv := aux.R_s * (-f.tau * f.tau * f.ftautau);
      aux.cp := aux.cv + aux.T * aux.pt * aux.pt / (aux.rho * aux.rho * aux.pd);
      aux.vp := -1 / (aux.rho * aux.rho) * 1 / aux.pd;
      aux.vt := aux.pt / (aux.rho * aux.rho * aux.pd);
    end airBaseProp_ps;

    function rho_props_ps 
      "密度作为压力和比熵的函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.SpecificEntropy s "比熵";
      input Common.AuxiliaryProperties aux "辅助记录";
      output SI.Density rho "密度";
    algorithm
      rho := aux.rho;
      annotation(Inline = false, LateInline = true);
    end rho_props_ps;

    function rho_ps "密度作为压力和比熵的函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.SpecificEntropy s "比熵";
      output SI.Density rho "密度";
      annotation();
    algorithm
      rho := rho_props_ps(
        p, 
        s, 
        Air_Utilities.airBaseProp_ps(p, s));
    end rho_ps;

    function T_props_ps 
      "温度作为压力和比熵的函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.SpecificEntropy s "比熵";
      input Common.AuxiliaryProperties aux "辅助记录";
      output SI.Temperature T "温度";
    algorithm
      T := aux.T;
      annotation(Inline = false, LateInline = true);
    end T_props_ps;

    function T_ps "温度作为压力和比熵的函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.SpecificEntropy s "比熵";
      output SI.Temperature T "温度";
      annotation();
    algorithm
      T := T_props_ps(
        p, 
        s, 
        Air_Utilities.airBaseProp_ps(p, s));
    end T_ps;

    function h_props_ps 
      "比焓作为压力和温度的函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.SpecificEntropy s "比熵";
      input Common.AuxiliaryProperties aux "辅助记录";
      output SI.SpecificEnthalpy h "比焓";
    algorithm
      h := aux.h;
      annotation(Inline = false, LateInline = true);
    end h_props_ps;

    function h_ps "比焓作为压力和温度的函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.SpecificEntropy s "比熵";
      output SI.SpecificEnthalpy h "比焓";
      annotation();
    algorithm
      h := h_props_ps(
        p, 
        s, 
        Air_Utilities.airBaseProp_ps(p, s));
    end h_ps;

    function airBaseProp_ph "空气的中间属性记录"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.SpecificEnthalpy h "比焓";
      output Common.AuxiliaryProperties aux "辅助记录";
    protected
      Modelica.Media.Common.HelmholtzDerivs f 
        "无量纲的亥姆霍兹函数及其对 delta 和 tau 的导数";
      Integer error "逆迭代的错误标志";
      annotation();
    algorithm
      aux.p := p;
      aux.h := h;
      aux.R_s := ReferenceAir.Air_Utilities.Basic.Constants.R_s;
      (aux.rho,aux.T) := Inverses.dTofph(
        p, 
        h, 
        delp = iter.delp, 
        delh = iter.delh);
      f := Basic.Helmholtz(aux.rho, aux.T);
      aux.s := aux.R_s * (f.tau * f.ftau - f.f) - ReferenceAir.Air_Utilities.Basic.Constants.s_off;
      aux.pd := aux.R_s * aux.T * f.delta * (2 * f.fdelta + f.delta * f.fdeltadelta);
      aux.pt := aux.R_s * aux.rho * f.delta * (f.fdelta - f.tau * f.fdeltatau);
      aux.cv := aux.R_s * (-f.tau * f.tau * f.ftautau);
      aux.cp := aux.cv + aux.T * aux.pt * aux.pt / (aux.rho * aux.rho * aux.pd);
      aux.vp := -1 / (aux.rho * aux.rho) * 1 / aux.pd;
      aux.vt := aux.pt / (aux.rho * aux.rho * aux.pd);
    end airBaseProp_ph;

    function rho_props_ph 
      "密度作为压力和比焓的函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.SpecificEnthalpy h "比焓";
      input Common.AuxiliaryProperties aux "辅助记录";
      output SI.Density rho "密度";
    algorithm
      rho := aux.rho;
      annotation(
        derivative(noDerivative = aux) = rho_ph_der, 
        Inline = false, 
        LateInline = true);
    end rho_props_ph;

    function rho_ph "密度作为压力和比焓的函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.SpecificEnthalpy h "比焓";
      output SI.Density rho "密度";
      annotation();
    algorithm
      rho := rho_props_ph(
        p, 
        h, 
        Air_Utilities.airBaseProp_ph(p, h));
    end rho_ph;

    function rho_ph_der "rho_ph的导数函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.SpecificEnthalpy h "比焓";
      input Common.AuxiliaryProperties aux "辅助记录";
      input Real p_der "压力的导数";
      input Real h_der "比焓的导数";
      output Real rho_der "密度的导数";
      annotation();
    algorithm
      rho_der := ((aux.rho * (aux.cv * aux.rho + aux.pt)) / (aux.rho * aux.rho * aux.pd 
        * aux.cv + aux.T * aux.pt * aux.pt)) * p_der + (-aux.rho * aux.rho * aux.pt / (aux.rho 
        * aux.rho * aux.pd * aux.cv + aux.T * aux.pt * aux.pt)) * h_der;
    end rho_ph_der;

    function T_props_ph 
      "温度作为压力和比焓的函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.SpecificEnthalpy h "比焓";
      input Common.AuxiliaryProperties aux "辅助记录";
      output SI.Temperature T "温度";
    algorithm
      T := aux.T;
      annotation(
        derivative(noDerivative = aux) = T_ph_der, 
        Inline = false, 
        LateInline = true);
    end T_props_ph;

    function T_ph "温度作为压力和比焓的函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.SpecificEnthalpy h "比焓";
      output SI.Temperature T "温度";
      annotation();
    algorithm
      T := T_props_ph(
        p, 
        h, 
        Air_Utilities.airBaseProp_ph(p, h));
    end T_ph;

    function T_ph_der "T_ph的导数函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.SpecificEnthalpy h "比焓";
      input Common.AuxiliaryProperties aux "辅助记录";
      input Real p_der "压力的导数";
      input Real h_der "比焓的导数";
      output Real T_der "温度的导数";
      annotation();
    algorithm
      T_der := ((-aux.rho * aux.pd + aux.T * aux.pt) / (aux.rho * aux.rho * aux.pd * aux.cv 
        + aux.T * aux.pt * aux.pt)) * p_der + ((aux.rho * aux.rho * aux.pd) / (aux.rho * 
        aux.rho * aux.pd * aux.cv + aux.T * aux.pt * aux.pt)) * h_der;
    end T_ph_der;

    function s_props_ph 
      "比熵作为压力和比焓的函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.SpecificEnthalpy h "比焓";
      input Common.AuxiliaryProperties aux "辅助记录";
      output SI.SpecificEntropy s "比熵";
    algorithm
      s := aux.s;
      annotation(
        derivative(noDerivative = aux) = s_ph_der, 
        Inline = false, 
        LateInline = true);
    end s_props_ph;

    function s_ph 
      "比熵作为压力和比焓的函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.SpecificEnthalpy h "比焓";
      output SI.SpecificEntropy s "比熵";
      annotation();
    algorithm
      s := s_props_ph(
        p, 
        h, 
        Air_Utilities.airBaseProp_ph(p, h));
    end s_ph;

    function s_ph_der 
      "比熵作为压力和比焓的导数函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.SpecificEnthalpy h "比焓";
      input Common.AuxiliaryProperties aux "辅助记录";
      input Real p_der "压力的导数";
      input Real h_der "比焓的导数";
      output Real s_der "比熵的导数";
      annotation();
    algorithm
      s_der := -1 / (aux.rho * aux.T) * p_der + 1 / aux.T * h_der;
    end s_ph_der;

    function cv_props_ph 
      "定容比热作为压力和比焓的函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.SpecificEnthalpy h "比焓";
      input Common.AuxiliaryProperties aux "辅助记录";
      output SI.SpecificHeatCapacity cv 
        "定容比热";
    algorithm
      cv := aux.cv;
      annotation(Inline = false, LateInline = true);
    end cv_props_ph;

    function cv_ph 
      "定容比热作为压力和比焓的函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.SpecificEnthalpy h "比焓";
      output SI.SpecificHeatCapacity cv 
        "定容比热";
      annotation();
    algorithm
      cv := cv_props_ph(
        p, 
        h, 
        Air_Utilities.airBaseProp_ph(p, h));
    end cv_ph;

    function cp_props_ph 
      "定压比热作为压力和比焓的函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.SpecificEnthalpy h "比焓";
      input Common.AuxiliaryProperties aux "辅助记录";
      output SI.SpecificHeatCapacity cp 
        "定压比热";
    algorithm
      cp := aux.cp;
      annotation(Inline = false, LateInline = true);
    end cp_props_ph;

    function cp_ph 
      "定压比热作为压力和比焓的函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.SpecificEnthalpy h "比焓";
      output SI.SpecificHeatCapacity cp 
        "定压比热";
      annotation();
    algorithm
      cp := cp_props_ph(
        p, 
        h, 
        Air_Utilities.airBaseProp_ph(p, h));
    end cp_ph;

    function beta_props_ph 
      "等压膨胀系数作为压力和比焓的函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.SpecificEnthalpy h "比焓";
      input Common.AuxiliaryProperties aux "辅助记录";
      output SI.RelativePressureCoefficient beta 
        "等压膨胀系数";
    algorithm
      beta := aux.pt / (aux.rho * aux.pd);
      annotation(Inline = false, LateInline = true);
    end beta_props_ph;

    function beta_ph 
      "等压膨胀系数作为压力和比焓的函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.SpecificEnthalpy h "比焓";
      output SI.RelativePressureCoefficient beta 
        "等压膨胀系数";
      annotation();
    algorithm
      beta := beta_props_ph(
        p, 
        h, 
        Air_Utilities.airBaseProp_ph(p, h));
    end beta_ph;

    function kappa_props_ph 
      "等温压缩系数作为压力和比焓的函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.SpecificEnthalpy h "比焓";
      input Common.AuxiliaryProperties aux "辅助记录";
      output SI.IsothermalCompressibility kappa 
        "等温压缩系数";
    algorithm
      kappa := 1 / (aux.rho * aux.pd);
      annotation(Inline = false, LateInline = true);
    end kappa_props_ph;

    function kappa_ph 
      "等温压缩系数作为压力和比焓的函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.SpecificEnthalpy h "比焓";
      output SI.IsothermalCompressibility kappa 
        "等温压缩系数";
      annotation();
    algorithm
      kappa := kappa_props_ph(
        p, 
        h, 
        Air_Utilities.airBaseProp_ph(p, h));
    end kappa_ph;

    function velocityOfSound_props_ph 
      "声速作为压力和比焓的函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.SpecificEnthalpy h "比焓";
      input Common.AuxiliaryProperties aux "辅助记录";
      output SI.Velocity a "声速";
    algorithm
      a := sqrt(max(0, aux.pd + aux.pt * aux.pt * aux.T / (aux.rho * aux.rho * aux.cv)));
      annotation(Inline = false, LateInline = true);
    end velocityOfSound_props_ph;

    function velocityOfSound_ph
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.SpecificEnthalpy h "比焓";
      output SI.Velocity a "声速";
      annotation();
    algorithm
      a := velocityOfSound_props_ph(
        p, 
        h, 
        Air_Utilities.airBaseProp_ph(p, h));
    end velocityOfSound_ph;

    function isentropicExponent_props_ph 
      "等熵指数作为压力和比焓的函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.SpecificEnthalpy h "比焓";
      input Common.AuxiliaryProperties aux "辅助记录";
      output Real gamma "等熵指数";
    algorithm
      gamma := 1 / (aux.rho * p) * ((aux.pd * aux.cv * aux.rho * aux.rho + aux.pt * aux.pt * 
        aux.T) / (aux.cv));
      annotation(Inline = false, LateInline = true);
    end isentropicExponent_props_ph;

    function isentropicExponent_ph 
      "等熵指数作为压力和比焓的函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.SpecificEnthalpy h "比焓";
      output Real gamma "等熵指数";
    algorithm
      gamma := isentropicExponent_props_ph(
        p, 
        h, 
        Air_Utilities.airBaseProp_ph(p, h));
      annotation(Inline = false, LateInline = true);
    end isentropicExponent_ph;

    function ddph_props "密度对压力的导数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.SpecificEnthalpy h "比焓";
      input Common.AuxiliaryProperties aux "辅助记录";
      output SI.DerDensityByPressure ddph 
        "密度对压力的导数";
    algorithm
      ddph := ((aux.rho * (aux.cv * aux.rho + aux.pt)) / (aux.rho * aux.rho * aux.pd * 
        aux.cv + aux.T * aux.pt * aux.pt));
      annotation(Inline = false, LateInline = true);
    end ddph_props;

    function ddph "密度对压力的导数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.SpecificEnthalpy h "比焓";
      output SI.DerDensityByPressure ddph 
        "密度对压力的导数";
      annotation();
    algorithm
      ddph := ddph_props(
        p, 
        h, 
        Air_Utilities.airBaseProp_ph(p, h));
    end ddph;

    function ddhp_props "密度对比焓的导数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.SpecificEnthalpy h "比焓";
      input Common.AuxiliaryProperties aux "辅助记录";
      output SI.DerDensityByEnthalpy ddhp 
        "密度对比焓的导数";
    algorithm
      ddhp := -aux.rho * aux.rho * aux.pt / (aux.rho * aux.rho * aux.pd * aux.cv + aux.T * 
        aux.pt * aux.pt);
      annotation(Inline = false, LateInline = true);
    end ddhp_props;

    function ddhp "密度对比焓的导数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.SpecificEnthalpy h "比焓";
      output SI.DerDensityByEnthalpy ddhp 
        "密度对比焓的导数";
      annotation();
    algorithm
      ddhp := ddhp_props(
        p, 
        h, 
        Air_Utilities.airBaseProp_ph(p, h));
    end ddhp;

    function airBaseProp_pT 
      "空气的中间属性记录（p 和 T 为首选状态）"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.Temperature T "温度";
      output Common.AuxiliaryProperties aux "辅助记录";
    protected
      Modelica.Media.Common.HelmholtzDerivs f 
        "无量纲亥姆霍兹函数及其对 delta 和 tau 的导数";
      annotation();
    algorithm
      aux.p := p;
      aux.T := T;
      aux.R_s := ReferenceAir.Air_Utilities.Basic.Constants.R_s;
      (aux.rho) := Inverses.dofpT(
        p = p, 
        T = T, 
        delp = iter.delp);
      f := Basic.Helmholtz(aux.rho, T);
      aux.h := aux.R_s * T * (f.tau * f.ftau + f.delta * f.fdelta) - ReferenceAir.Air_Utilities.Basic.Constants.h_off;
      aux.s := aux.R_s * (f.tau * f.ftau - f.f) - ReferenceAir.Air_Utilities.Basic.Constants.s_off;
      aux.pd := aux.R_s * T * f.delta * (2 * f.fdelta + f.delta * f.fdeltadelta);
      aux.pt := aux.R_s * aux.rho * f.delta * (f.fdelta - f.tau * f.fdeltatau);
      aux.cv := aux.R_s * (-f.tau * f.tau * f.ftautau);
      aux.cp := aux.cv + aux.T * aux.pt * aux.pt / (aux.rho * aux.rho * aux.pd);
      aux.vp := -1 / (aux.rho * aux.rho) * 1 / aux.pd;
      aux.vt := aux.pt / (aux.rho * aux.rho * aux.pd);
    end airBaseProp_pT;

    function rho_props_pT "压力和温度的密度函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.Temperature T "温度";
      input Common.AuxiliaryProperties aux "辅助记录";
      output SI.Density rho "密度";
    algorithm
      rho := aux.rho;
      annotation(
        derivative(noDerivative = aux) = rho_pT_der, 
        Inline = false, 
        LateInline = true);
    end rho_props_pT;

    function rho_pT "压力和温度的密度函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.Temperature T "温度";
      output SI.Density rho "密度";
      annotation();
    algorithm
      rho := rho_props_pT(
        p, 
        T, 
        Air_Utilities.airBaseProp_pT(p, T));
    end rho_pT;

    function rho_pT_der "rho_pT 的导数函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.Temperature T "温度";
      input Common.AuxiliaryProperties aux "辅助记录";
      input Real p_der "压力导数";
      input Real T_der "温度导数";
      output Real rho_der "密度导数";
      annotation();
    algorithm
      rho_der := (1 / aux.pd) * p_der - (aux.pt / aux.pd) * T_der;
    end rho_pT_der;

    function h_props_pT 
      "压力和温度的比焓函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.Temperature T "温度";
      input Common.AuxiliaryProperties aux "辅助记录";
      output SI.SpecificEnthalpy h "比焓";
    algorithm
      h := aux.h;
      annotation(
        derivative(noDerivative = aux) = h_pT_der, 
        Inline = false, 
        LateInline = true);
    end h_props_pT;

    function h_pT 
      "压力和温度的比焓函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.Temperature T "温度";
      output SI.SpecificEnthalpy h "比焓";
      annotation();
    algorithm
      h := h_props_pT(
        p, 
        T, 
        Air_Utilities.airBaseProp_pT(p, T));
    end h_pT;

    function h_pT_der 
      "h_pT 的导数函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.Temperature T "温度";
      input Common.AuxiliaryProperties aux "辅助记录";
      input Real p_der "压力导数";
      input Real T_der "温度导数";
      output Real h_der "比焓导数";
      annotation();
    algorithm
      h_der := ((-aux.rho * aux.pd + T * aux.pt) / (aux.rho * aux.rho * aux.pd)) * p_der 
        + ((aux.rho * aux.rho * aux.pd * aux.cv + aux.T * aux.pt * aux.pt) / (aux.rho * 
        aux.rho * aux.pd)) * T_der;
    end h_pT_der;

    function s_props_pT 
      "压力和温度的比熵函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.Temperature T "温度";
      input Common.AuxiliaryProperties aux "辅助记录";
      output SI.SpecificEntropy s "比熵";
    algorithm
      s := aux.s;
      annotation(Inline = false, LateInline = true);
    end s_props_pT;

    function s_pT 
      "压力和温度的比熵函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.Temperature T "温度";
      output SI.SpecificEntropy s "比熵";
      annotation();
    algorithm
      s := s_props_pT(
        p, 
        T, 
        Air_Utilities.airBaseProp_pT(p, T));
    end s_pT;

    function cv_props_pT 
      "压力和温度的定容比热函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.Temperature T "温度";
      input Common.AuxiliaryProperties aux "辅助记录";
      output SI.SpecificHeatCapacity cv 
        "定容比热";
    algorithm
      cv := aux.cv;
      annotation(Inline = false, LateInline = true);
    end cv_props_pT;

    function cv_pT 
      "压力和温度的定容比热函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.Temperature T "温度";
      output SI.SpecificHeatCapacity cv 
        "定容比热";
      annotation();
    algorithm
      cv := cv_props_pT(
        p, 
        T, 
        Air_Utilities.airBaseProp_pT(p, T));
    end cv_pT;

    function cp_props_pT 
      "压力和温度的定压比热函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.Temperature T "温度";
      input Common.AuxiliaryProperties aux "辅助记录";
      output SI.SpecificHeatCapacity cp 
        "定压比热";
    algorithm
      cp := aux.cp;
      annotation(Inline = false, LateInline = true);
    end cp_props_pT;

    function cp_pT 
      "压力和温度的定压比热函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.Temperature T "温度";
      output SI.SpecificHeatCapacity cp 
        "定压比热";
      annotation();
    algorithm
      cp := cp_props_pT(
        p, 
        T, 
        Air_Utilities.airBaseProp_pT(p, T));
    end cp_pT;

    function beta_props_pT 
      "压力和温度的等压膨胀系数函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.Temperature T "温度";
      input Common.AuxiliaryProperties aux "辅助记录";
      output SI.RelativePressureCoefficient beta 
        "等压膨胀系数";
    algorithm
      beta := aux.pt / (aux.rho * aux.pd);
      annotation(Inline = false, LateInline = true);
    end beta_props_pT;

    function beta_pT 
      "压力和温度的等压膨胀系数函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.Temperature T "温度";
      output SI.RelativePressureCoefficient beta 
        "等压膨胀系数";
      annotation();
    algorithm
      beta := beta_props_pT(
        p, 
        T, 
        Air_Utilities.airBaseProp_pT(p, T));
    end beta_pT;

    function kappa_props_pT 
      "压力和温度的等温压缩系数函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.Temperature T "温度";
      input Common.AuxiliaryProperties aux "辅助记录";
      output SI.IsothermalCompressibility kappa 
        "等温压缩系数";
    algorithm
      kappa := 1 / (aux.rho * aux.pd);
      annotation(Inline = false, LateInline = true);
    end kappa_props_pT;

    function kappa_pT 
      "压力和温度的等温压缩系数函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.Temperature T "温度";
      output SI.IsothermalCompressibility kappa 
        "等温压缩系数";
      annotation();
    algorithm
      kappa := kappa_props_pT(
        p, 
        T, 
        Air_Utilities.airBaseProp_pT(p, T));
    end kappa_pT;

    function velocityOfSound_props_pT 
      "压力和温度的声速函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.Temperature T "温度";
      input Common.AuxiliaryProperties aux "辅助记录";
      output SI.Velocity a "声速";
    algorithm
      a := sqrt(max(0, (aux.pd * aux.rho * aux.rho * aux.cv + aux.pt * aux.pt * aux.T) / 
        (aux.rho * aux.rho * aux.cv)));
      annotation(Inline = false, LateInline = true);
    end velocityOfSound_props_pT;

    function velocityOfSound_pT 
      "压力和温度的声速函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.Temperature T "温度";
      output SI.Velocity a "声速";
      annotation();
    algorithm
      a := velocityOfSound_props_pT(
        p, 
        T, 
        Air_Utilities.airBaseProp_pT(p, T));
    end velocityOfSound_pT;

    function isentropicExponent_props_pT 
      "压力和温度的等熵指数函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.Temperature T "温度";
      input Common.AuxiliaryProperties aux "辅助记录";
      output Real gamma "等熵指数";
    algorithm
      gamma := 1 / (aux.rho * p) * ((aux.pd * aux.cv * aux.rho * aux.rho + aux.pt * aux.pt * 
        aux.T) / (aux.cv));
      annotation(Inline = false, LateInline = true);
    end isentropicExponent_props_pT;

    function isentropicExponent_pT 
      "压力和温度的等熵指数函数"
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.Temperature T "温度";
      output Real gamma "等熵指数";
      annotation();
    algorithm
      gamma := isentropicExponent_props_pT(
        p, 
        T, 
        Air_Utilities.airBaseProp_pT(p, T));
    end isentropicExponent_pT;

    function airBaseProp_dT 
      "空气的中间属性记录（d 和 T 为首选状态）"
      extends Modelica.Icons.Function;
      input SI.Density d "密度";
      input SI.Temperature T "温度";
      output Common.AuxiliaryProperties aux "辅助记录";
    protected
      Modelica.Media.Common.HelmholtzDerivs f 
        "无量纲的亥姆霍兹函数和关于 delta 和 tau 的导数";
      annotation();
    algorithm
      aux.rho := d;
      aux.T := T;
      aux.R_s := ReferenceAir.Air_Utilities.Basic.Constants.R_s;
      f := Basic.Helmholtz(d, T);
      aux.p := aux.R_s * d * T * f.delta * f.fdelta;
      aux.h := aux.R_s * T * (f.tau * f.ftau + f.delta * f.fdelta) - ReferenceAir.Air_Utilities.Basic.Constants.h_off;
      aux.s := aux.R_s * (f.tau * f.ftau - f.f) - ReferenceAir.Air_Utilities.Basic.Constants.s_off;
      aux.pd := aux.R_s * T * f.delta * (2 * f.fdelta + f.delta * f.fdeltadelta);
      aux.pt := aux.R_s * d * f.delta * (f.fdelta - f.tau * f.fdeltatau);
      aux.cv := aux.R_s * (-f.tau * f.tau * f.ftautau);
      aux.cp := aux.cv + aux.T * aux.pt * aux.pt / (d * d * aux.pd);
      aux.vp := -1 / (aux.rho * aux.rho) * 1 / aux.pd;
      aux.vt := aux.pt / (aux.rho * aux.rho * aux.pd);
    end airBaseProp_dT;

    function h_props_dT 
      "密度和温度的比焓函数"
      extends Modelica.Icons.Function;
      input SI.Density d "密度";
      input SI.Temperature T "温度";
      input Common.AuxiliaryProperties aux "辅助记录";
      output SI.SpecificEnthalpy h "比焓";
    algorithm
      h := aux.h;
      annotation(
        derivative(noDerivative = aux) = h_dT_der, 
        Inline = false, 
        LateInline = true);
    end h_props_dT;

    function h_dT "密度和温度的比焓函数"
      extends Modelica.Icons.Function;
      input SI.Density d "密度";
      input SI.Temperature T "温度";
      output SI.SpecificEnthalpy h "比焓";
      annotation();
    algorithm
      h := h_props_dT(
        d, 
        T, 
        Air_Utilities.airBaseProp_dT(d, T));
    end h_dT;

    function h_dT_der "h_dT 的导数函数"
      extends Modelica.Icons.Function;
      input SI.Density d "密度";
      input SI.Temperature T "温度";
      input Common.AuxiliaryProperties aux "辅助记录";
      input Real d_der "密度的导数";
      input Real T_der "温度的导数";
      output Real h_der "比焓的导数";
      annotation();
    algorithm
      h_der := ((-d * aux.pd + T * aux.pt) / (d * d)) * d_der + ((aux.cv * d + aux.pt) / d) 
        * T_der;
    end h_dT_der;

    function p_props_dT "密度和温度的压力函数"
      extends Modelica.Icons.Function;
      input SI.Density d "密度";
      input SI.Temperature T "温度";
      input Common.AuxiliaryProperties aux "辅助记录";
      output SI.Pressure p "压力";
    algorithm
      p := aux.p;
      annotation(
        derivative(noDerivative = aux) = p_dT_der, 
        Inline = false, 
        LateInline = true);
    end p_props_dT;

    function p_dT "密度和温度的函数压力"
      extends Modelica.Icons.Function;
      input SI.Density d "密度";
      input SI.Temperature T "温度";
      output SI.Pressure p "压力";
      annotation();
    algorithm
      p := p_props_dT(
        d, 
        T, 
        Air_Utilities.airBaseProp_dT(d, T));
    end p_dT;

    function p_dT_der "p_dT 的导数函数"
      extends Modelica.Icons.Function;
      input SI.Density d "密度";
      input SI.Temperature T "温度";
      input Common.AuxiliaryProperties aux "辅助记录";
      input Real d_der "密度的导数";
      input Real T_der "温度的导数";
      output Real p_der "压力的导数";
      annotation();
    algorithm
      p_der := aux.pd * d_der + aux.pt * T_der;
    end p_dT_der;

    function s_props_dT 
      "密度和温度的比熵函数"
      extends Modelica.Icons.Function;
      input SI.Density d "密度";
      input SI.Temperature T "温度";
      input Common.AuxiliaryProperties aux "辅助记录";
      output SI.SpecificEntropy s   ;
    algorithm
      s := aux.s;
      annotation(Inline = false, LateInline = true);
    end s_props_dT;

    function s_dT 
      "密度和温度的温度函数"
      extends Modelica.Icons.Function;
      input SI.Density d "密度";
      input SI.Temperature T "温度";
      output SI.SpecificEntropy s   ;
      annotation();
    algorithm
      s := s_props_dT(
        d, 
        T, 
        Air_Utilities.airBaseProp_dT(d, T));
    end s_dT;

    function cv_props_dT 
      "常压下密度和温度的定容比热函数"
      extends Modelica.Icons.Function;
      input SI.Density d "密度";
      input SI.Temperature T "温度";
      input Common.AuxiliaryProperties aux "辅助记录";
      output SI.SpecificHeatCapacity cv 
        "定容比热";
    algorithm
      cv := aux.cv;
      annotation(Inline = false, LateInline = true);
    end cv_props_dT;

    function cv_dT 
      "常压下密度和温度的定容比热函数"
      extends Modelica.Icons.Function;
      input SI.Density d "密度";
      input SI.Temperature T "温度";
      output SI.SpecificHeatCapacity cv 
        "定容比热";
      annotation();
    algorithm
      cv := cv_props_dT(
        d, 
        T, 
        Air_Utilities.airBaseProp_dT(d, T));
    end cv_dT;

    function cp_props_dT 
      "常压下密度和温度的定压比热函数"
      extends Modelica.Icons.Function;
      input SI.Density d "密度";
      input SI.Temperature T "温度";
      input Common.AuxiliaryProperties aux "辅助记录";
      output SI.SpecificHeatCapacity cp 
        "定压比热";
    algorithm
      cp := aux.cp;
      annotation(Inline = false, LateInline = true);
    end cp_props_dT;

    function cp_dT 
      "常压下密度和温度的定压比热函数"
      extends Modelica.Icons.Function;
      input SI.Density d "密度";
      input SI.Temperature T "温度";
      output SI.SpecificHeatCapacity cp 
        "定压比热";
      annotation();
    algorithm
      cp := cp_props_dT(
        d, 
        T, 
        Air_Utilities.airBaseProp_dT(d, T));
    end cp_dT;

    function beta_props_dT 
      "密度和温度的等压膨胀系数函数"
      extends Modelica.Icons.Function;
      input SI.Density d "密度";
      input SI.Temperature T "温度";
      input Common.AuxiliaryProperties aux "辅助记录";
      output SI.RelativePressureCoefficient beta 
        "等压膨胀系数";
    algorithm
      beta := aux.pt / (aux.rho * aux.pd);
      annotation(Inline = false, LateInline = true);
    end beta_props_dT;

    function beta_dT 
      "密度和温度的等压膨胀系数函数"
      extends Modelica.Icons.Function;
      input SI.Density d "密度";
      input SI.Temperature T "温度";
      output SI.RelativePressureCoefficient beta 
        "等压膨胀系数";
      annotation();
    algorithm
      beta := beta_props_dT(
        d, 
        T, 
        Air_Utilities.airBaseProp_dT(d, T));
    end beta_dT;

    function kappa_props_dT 
      "密度和温度的等温压缩系数函数"
      extends Modelica.Icons.Function;
      input SI.Density d "密度";
      input SI.Temperature T "温度";
      input Common.AuxiliaryProperties aux "辅助记录";
      output SI.IsothermalCompressibility kappa 
        "等温压缩系数";
    algorithm
      kappa := 1 / (aux.rho * aux.pd);
      annotation(Inline = false, LateInline = true);
    end kappa_props_dT;

    function kappa_dT 
      "密度和温度的等温压缩系数函数"
      extends Modelica.Icons.Function;
      input SI.Density d "密度";
      input SI.Temperature T "温度";
      output SI.IsothermalCompressibility kappa 
        "等温压缩系数";
      annotation();
    algorithm
      kappa := kappa_props_dT(
        d, 
        T, 
        Air_Utilities.airBaseProp_dT(d, T));
    end kappa_dT;

    function velocityOfSound_props_dT 
      "密度和温度的声速函数"
      extends Modelica.Icons.Function;
      input SI.Density d "密度";
      input SI.Temperature T "温度";
      input Common.AuxiliaryProperties aux "辅助记录";
      output SI.Velocity a "声速";
    algorithm
      a := sqrt(max(0, ((aux.pd * aux.rho * aux.rho * aux.cv + aux.pt * aux.pt * aux.T) 
        / (aux.rho * aux.rho * aux.cv))));
      annotation(Inline = false, LateInline = true);
    end velocityOfSound_props_dT;

    function velocityOfSound_dT 
      "密度和温度的声速函数"
      extends Modelica.Icons.Function;
      input SI.Density d "密度";
      input SI.Temperature T "温度";
      output SI.Velocity a "声速";
      annotation();
    algorithm
      a := velocityOfSound_props_dT(
        d, 
        T, 
        Air_Utilities.airBaseProp_dT(d, T));
    end velocityOfSound_dT;

    function isentropicExponent_props_dT 
      "密度和温度的函数绝热指数"
      extends Modelica.Icons.Function;
      input SI.Density d "密度";
      input SI.Temperature T "温度";
      input Common.AuxiliaryProperties aux "辅助记录";
      output Real gamma "绝热指数";
    algorithm
      gamma := 1 / (aux.rho * aux.p) * ((aux.pd * aux.cv * aux.rho * aux.rho + aux.pt * aux.pt 
        * aux.T) / (aux.cv));
      annotation(Inline = false, LateInline = true);
    end isentropicExponent_props_dT;

    function isentropicExponent_dT 
      "密度和温度的绝热指数函数"
      extends Modelica.Icons.Function;
      input SI.Density d "密度";
      input SI.Temperature T "温度";
      output Real gamma "绝热指数";
      annotation();
    algorithm
      gamma := isentropicExponent_props_dT(
        d, 
        T, 
        Air_Utilities.airBaseProp_dT(d, T));
    end isentropicExponent_dT;

  package ThermoFluidSpecial
      extends Modelica.Icons.FunctionsPackage;
      function air_ph 
        "使用 p, h 作为状态计算动态仿真属性的属性记录"
        extends Modelica.Icons.Function;
        input SI.Pressure p "压力";
        input SI.SpecificEnthalpy h "比焓";
        output Modelica.Media.Common.ThermoFluidSpecial.ThermoProperties_ph 
          pro "动态仿真的属性记录";
      protected
        Modelica.Media.Common.HelmholtzDerivs f 
          "无量纲亥姆霍兹函数及其对 delta 和 tau 的导数";
        SI.Temperature T "温度";
        SI.Density d "密度";
        annotation();
      algorithm
        (d,T) := Air_Utilities.Inverses.dTofph(
          p = p, 
          h = h, 
          delp = 1.0e-7, 
          delh = 1.0e-6);
        f := Air_Utilities.Basic.Helmholtz(d, T);
        pro := Modelica.Media.Common.ThermoFluidSpecial.helmholtzToProps_ph(f);
      end air_ph;

      function air_dT 
        "使用 d 和 T 作为动态状态计算动态仿真属性的属性记录"
        extends Modelica.Icons.Function;
        input SI.Density d "密度";
        input SI.Temperature T "温度";
        output Modelica.Media.Common.ThermoFluidSpecial.ThermoProperties_dT 
          pro "动态仿真的属性记录";
      protected
        SI.Pressure p "压力";
        Modelica.Media.Common.HelmholtzDerivs f 
          "无量纲亥姆霍兹函数及其对 delta 和 tau 的导数";
        annotation();
      algorithm
        f := Air_Utilities.Basic.Helmholtz(d, T);
        pro := Modelica.Media.Common.ThermoFluidSpecial.helmholtzToProps_dT(f);
      end air_dT;

      function air_pT 
        "使用 p 和 T 作为动态状态计算动态仿真属性的属性记录"
        extends Modelica.Icons.Function;
        input SI.Pressure p "压力";
        input SI.Temperature T "温度";
        output Modelica.Media.Common.ThermoFluidSpecial.ThermoProperties_pT 
          pro "动态仿真的属性记录";
      protected
        SI.Density d "密度";
        Modelica.Media.Common.HelmholtzDerivs f 
          "无量纲亥姆霍兹函数及其对 delta 和 tau 的导数";
        annotation();
      algorithm
        d := Modelica.Media.Air.ReferenceAir.Air_Utilities.Inverses.dofpT(
          p = p, 
          T = T, 
          delp = 1e-7);
        f := Air_Utilities.Basic.Helmholtz(d, T);
        pro := Modelica.Media.Common.ThermoFluidSpecial.helmholtzToProps_pT(f);
      end air_pT;
    annotation();
    end ThermoFluidSpecial;
    annotation(Documentation(info="<html><p>
<br>
</p>
</html>"      ));

  end Air_Utilities;
annotation(Documentation(info="<html><p>
在130K 到2000K 的流体区域内，以最高2000MPa 的压力计算空气的流体性质。要在您的模型中使用此库，请根据您选择确定状态的变量选择<a href=\"modelica://Modelica.Media.Air.ReferenceAir.Air_dT\" target=\"\">Air_dT</a>&nbsp;、<a href=\"modelica://Modelica.Media.Air.ReferenceAir.Air_pT\" target=\"\">Air_pT</a>&nbsp;或<a href=\"modelica://Modelica.Media.Air.ReferenceAir.Air_ph\" target=\"\">Air_ph</a>&nbsp;。
</p>
<h4>限制</h4><p>
此库提供的函数应在所引用文献中规定的限制条件下使用。
</p>
<li>
<strong>p ≤ 2000 MPa</strong></li>
<li>
<strong>130 K ≤ T ≤ 2000 K</strong></li>
<h4>参考文献</h4><p>
Lemmon, E. W., Jacobsen, R. T., Penoncello, S. G., Friend, D. G.:
</p>
<p>
<strong>Thermodynamic Properties of Air and Mixtures of Nitrogen, Argon, and Oxygen From 60 to 2000 K at Pressures to 2000 MPa</strong>. J. Phys. Chem. Ref. Data, Vol. 29, No. 3, 2000.<br>
</p>
<p>
Lemmon, E. W., Jacobsen, R. T.:
</p>
<p>
<strong>Viscosity and Thermal Conductivity Equations for Nitrogen, Oxygen, Argon, and Air</strong>. International Journal of Thermophysics, Vol. 25, No. 1, January 2004<br>
</p>
<h4>验证</h4><p>
本库开发的验证报告请参见<a href=\"modelica://Modelica/Resources/Documentation/Media/MoMoLib_VerificationResults_XRG.pdf\" target=\"\">此处</a>&nbsp;。
</p>
<h4>致谢</h4><p>
本库由XRG Simulation GmbH开发，作为<a href=\"http://www.cleansky.eu/\" target=\"\">Clean Sky</a>&nbsp; JTI项目的一部分（项目标题：MoMoLib-Modelica Model Library Development for Media, Magnetic Systems and Wavelets; 项目编号：296369; 主题：JTI-CS-2011-1-SGO-02-026: Modelica Model Library Development Part I）开发。欧盟对本库开发的部分财务支持表示衷心的感谢。
</p>
<p>
本库的部分内容参考了隆德大学开发的ThermoFluid库（<a href=\"http://thermofluid.sourceforge.net/\" target=\"\">http://thermofluid.sourceforge.net</a>&nbsp;）。
</p>
<p>
版权所有 &copy; 2013-2020，Modelica协会及贡献者
</p>
</html>"));
end ReferenceAir;