within Modelica.Media;
package Water "水模型"

  extends Modelica.Icons.VariantsPackage;

  import Modelica.Media.Water.ConstantPropertyLiquidWater.simpleWaterConstants;

  constant Modelica.Media.Interfaces.Types.TwoPhase.FluidConstants[1] 
    waterConstants(
    each chemicalFormula = "H2O", 
    each structureFormula = "H2O", 
    each casRegistryNumber = "7732-18-5", 
    each iupacName = "oxidane", 
    each molarMass = 0.018015268, 
    each criticalTemperature = 647.096, 
    each criticalPressure = 22064.0e3, 
    each criticalMolarVolume = 1 / 322.0 * 0.018015268, 
    each normalBoilingPoint = 373.124, 
    each meltingPoint = 273.15, 
    each triplePointTemperature = 273.16, 
    each triplePointPressure = 611.657, 
    each acentricFactor = 0.344, 
    each dipoleMoment = 1.8, 
    each hasCriticalData = true);

  package IdealSteam "水: 来自 NASA 的理想气体蒸汽"

    extends IdealGases.SingleGases.H2O;
    annotation(Documentation(info = "<html>

</html>"));
  end IdealSteam;

  package ConstantPropertyLiquidWater 
    "水: 简单液态水介质（不可压缩，数据恒定）"

    //   redeclare record extends FluidConstants
    //   end FluidConstants;

    constant Modelica.Media.Interfaces.Types.Basic.FluidConstants[1] 
      simpleWaterConstants(
      each chemicalFormula = "H2O", 
      each structureFormula = "H2O", 
      each casRegistryNumber = "7732-18-5", 
      each iupacName = "oxidane", 
      each molarMass = 0.018015268);

    extends Interfaces.PartialSimpleMedium(
      mediumName = "SimpleLiquidWater", 
      cp_const = 4184, 
      cv_const = 4184, 
      d_const = 995.586, 
      eta_const = 1.e-3, 
      lambda_const = 0.598, 
      a_const = 1484, 
      T_min = Cv.from_degC(-1), 
      T_max = Cv.from_degC(130), 
      T0 = 273.15, 
      MM_const = 0.018015268, 
      fluidConstants = simpleWaterConstants);

    annotation(Documentation(info = "<html>

</html>"));
  end ConstantPropertyLiquidWater;

  package StandardWater = WaterIF97_ph 
    "使用 IF97 标准的水，指定 p 和 h。推荐用于大多数应用" annotation();

  package StandardWaterOnePhase = WaterIF97_pT 
    "使用 IF97 标准的水，指定 p 和 T。推荐用于单相应用" annotation();

  package WaterIF97OnePhase_ph 
    "使用 IF97 标准的水，指定 p 和 h。并且仅在两相区域外有效"

    extends WaterIF97_base(
      ThermoStates = Modelica.Media.Interfaces.Choices.IndependentVariables.ph, 
      final ph_explicit = true, 
      final dT_explicit = false, 
      final pT_explicit = false, 
      final smoothModel = true, 
      final onePhase = true);
    annotation(Documentation(info = "<html>

</html>"));
  end WaterIF97OnePhase_ph;

  package WaterIF97_pT "使用 IF97 标准的水，指定 p 和 T"
    extends WaterIF97_base(
      ThermoStates = Modelica.Media.Interfaces.Choices.IndependentVariables.pT, 
      final ph_explicit = false, 
      final dT_explicit = false, 
      final pT_explicit = true, 
      final smoothModel = true, 
      final onePhase = true);
    annotation();
  end WaterIF97_pT;

  package WaterIF97_ph "使用 IF97 标准的水，指定 p 和 h"
    extends WaterIF97_base(
      ThermoStates = Modelica.Media.Interfaces.Choices.IndependentVariables.ph, 
      final ph_explicit = true, 
      final dT_explicit = false, 
      final pT_explicit = false, 
      smoothModel = false, 
      onePhase = false);
    annotation(Documentation(info = "<html>

</html>"  ));
  end WaterIF97_ph;

  partial package WaterIF97_base 
    "水：由 IAPWS/IF97 标准定义的蒸汽性质"

    extends Interfaces.PartialTwoPhaseMedium(
      mediumName = "WaterIF97", 
      substanceNames = {"water"}, 
      singleState = false, 
      SpecificEnthalpy(start = 1.0e5, nominal = 5.0e5), 
      Density(start = 150, nominal = 500), 
      AbsolutePressure(
      start = 50e5, 
      nominal = 10e5, 
      min = 611.657, 
      max = 100e6), 
      Temperature(
      start = 500, 
      nominal = 500, 
      min = 273.15, 
      max = 2273.15), 
      smoothModel = false, 
      onePhase = false, 
      fluidConstants = waterConstants);

    redeclare record extends SaturationProperties
      annotation();
    end SaturationProperties;

    redeclare record extends ThermodynamicState "热力学状态"
      SpecificEnthalpy h "比焓";
      Density d "密度";
      Temperature T "温度";
      AbsolutePressure p "压力";
      annotation();
    end ThermodynamicState;

    constant Integer Region = 0 "IF97 的区域，如果已知，则为零";
    constant Boolean ph_explicit 
      "如果明确指定了压力和比焓，则为 true";
    constant Boolean dT_explicit "如果明确指定了密度和温度，则为 true";
    constant Boolean pT_explicit "如果明确指定了压力和温度，则为 true";

    redeclare replaceable model extends BaseProperties(
      h(stateSelect = if ph_explicit and preferredMediumStates then StateSelect.prefer 
      else StateSelect.default), 
      d(stateSelect = if dT_explicit and preferredMediumStates then StateSelect.prefer 
      else StateSelect.default), 
      T(stateSelect = if (pT_explicit or dT_explicit) and preferredMediumStates 
      then StateSelect.prefer else StateSelect.default), 
      p(stateSelect = if (pT_explicit or ph_explicit) and preferredMediumStates 
      then StateSelect.prefer else StateSelect.default)) 
      "水的基本性质"
      Integer phase(
        min = 0, 
        max = 2, 
        start = 1, 
        fixed = false) "2 表示两相，1 表示单相，0 表示未知";
      annotation();
    equation
      MM = fluidConstants[1].molarMass;
      if Region > 0 then  // 固定区域
        phase = (if Region == 4 then 2 else 1);
      elseif smoothModel then
        if onePhase then
          phase = 1;
          if ph_explicit then
            assert(((h < bubbleEnthalpy(sat) or h > dewEnthalpy(sat)) or p > 
              fluidConstants[1].criticalPressure), 
              "当 onePhase=true 时，只能在单相状态 h < hl 或 h > hv 时调用该模型！" 
              + "(p = " + String(p) + ", h = " + String(h) + ")");
          else
            if dT_explicit then
              assert(not ((d < bubbleDensity(sat) and d > dewDensity(sat)) and T 
                < fluidConstants[1].criticalTemperature), 
                "当 onePhase=true 时，只能在单相状态 d > dl 或 d < dv 时调用该模型！" 
                + "(d = " + String(d) + ", T = " + String(T) + ")");
            end if;
          end if;
        else
          phase = 0;
        end if;
      else
        if ph_explicit then
          phase = if ((h < bubbleEnthalpy(sat) or h > dewEnthalpy(sat)) or p > 
            fluidConstants[1].criticalPressure) then 1 else 2;
        elseif dT_explicit then
          phase = if not ((d < bubbleDensity(sat) and d > dewDensity(sat)) and T 
            < fluidConstants[1].criticalTemperature) then 1 else 2;
        else
          phase = 1;
        //这是仅针对单相情况 pT
        end if;
      end if;
      if dT_explicit then
        p = pressure_dT(
          d, 
          T, 
          phase, 
          Region);
        h = specificEnthalpy_dT(
          d, 
          T, 
          phase, 
          Region);
        sat.Tsat = T;
        sat.psat = saturationPressure(T);
      elseif ph_explicit then
        d = density_ph(
          p, 
          h, 
          phase, 
          Region);
        T = temperature_ph(
          p, 
          h, 
          phase, 
          Region);
        sat.Tsat = saturationTemperature(p);
        sat.psat = p;
      else
        h = specificEnthalpy_pT(
          p, 
          T, 
          Region);
        d = density_pT(
          p, 
          T, 
          Region);
        sat.psat = p;
        sat.Tsat = saturationTemperature(p);
      end if;
      u = h - p / d;
      R_s = Modelica.Constants.R / fluidConstants[1].molarMass;
      h = state.h;
      p = state.p;
      T = state.T;
      d = state.d;
      phase = state.phase;
    end BaseProperties;

    redeclare function density_ph 
      "根据压力和比焓计算密度"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "压力";
      input SpecificEnthalpy h "比焓";
      input FixedPhase phase = 0 "2 表示两相，1 表示单相，0 表示未知";
      input Integer region = Region 
        "如果为 0，则区域未知，否则已知并作为此输入";
      output Density d "密度";
    algorithm
      d := IF97_Utilities.rho_ph(
        p, 
        h, 
        phase, 
        region);
      annotation(Inline = true);
    end density_ph;

    redeclare function temperature_ph 
      "根据压力和比焓计算温度"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "压力";
      input SpecificEnthalpy h "比焓";
      input FixedPhase phase = 0 "2 表示两相，1 表示单相，0 表示未知";
      input Integer region = Region 
        "如果为 0，则区域未知，否则已知并作为此输入";
      output Temperature T "温度";
    algorithm
      T := IF97_Utilities.T_ph(
        p, 
        h, 
        phase, 
        region);
      annotation(Inline = true);
    end temperature_ph;

    redeclare function temperature_ps 
      "根据压力和比熵计算温度"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "压力";
      input SpecificEntropy s "比熵";
      input FixedPhase phase = 0 "2 表示两相，1 表示单相，0 表示未知";
      input Integer region = Region 
        "如果为 0，则区域未知，否则已知并作为此输入";
      output Temperature T "温度";
    algorithm
      T := IF97_Utilities.T_ps(
        p, 
        s, 
        phase, 
        region);
      annotation(Inline = true);
    end temperature_ps;

    redeclare function density_ps 
      "根据压力和比熵计算密度"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "压力";
      input SpecificEntropy s "比熵";
      input FixedPhase phase = 0 "2 表示两相，1 表示单相，0 表示未知";
      input Integer region = Region 
        "如果为 0，则区域未知，否则已知并作为此输入";
      output Density d "密度";
    algorithm
      d := IF97_Utilities.rho_ps(
        p, 
        s, 
        phase, 
        region);
      annotation(Inline = true);
    end density_ps;

    redeclare function pressure_dT 
      "根据密度和温度计算压力"
      extends Modelica.Icons.Function;
      input Density d "密度";
      input Temperature T "温度";
      input FixedPhase phase = 0 "2 表示两相，1 表示单相，0 表示未知";
      input Integer region = Region 
        "如果为 0，则区域未知，否则已知并作为此输入";
      output AbsolutePressure p "压力";
    algorithm
      p := IF97_Utilities.p_dT(
        d, 
        T, 
        phase, 
        region);
      annotation(Inline = true);
    end pressure_dT;

    redeclare function specificEnthalpy_dT 
      "根据密度和温度计算比焓"
      extends Modelica.Icons.Function;
      input Density d "密度";
      input Temperature T "温度";
      input FixedPhase phase = 0 "2 表示两相，1 表示单相，0 表示未知";
      input Integer region = Region 
        "如果为 0，则区域未知，否则已知并作为此输入";
      output SpecificEnthalpy h "比焓";
    algorithm
      h := IF97_Utilities.h_dT(
        d, 
        T, 
        phase, 
        region);
      annotation(Inline = true);
    end specificEnthalpy_dT;

    redeclare function specificEnthalpy_pT 
      "根据压力和温度计算比焓"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "压力";
      input Temperature T "温度";
      input FixedPhase phase = 0 "2 表示两相，1 表示单相，0 表示未知";
      input Integer region = Region 
        "如果为 0，则区域未知，否则已知并作为此输入";
      output SpecificEnthalpy h "比焓";
    algorithm
      h := IF97_Utilities.h_pT(
        p, 
        T, 
        region);
      annotation(Inline = true);
    end specificEnthalpy_pT;

    redeclare function specificEnthalpy_ps 
      "根据压力和比熵计算比焓"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "压力";
      input SpecificEntropy s "比熵";
      input FixedPhase phase = 0 "2 表示两相，1 表示单相，0 表示未知";
      input Integer region = Region 
        "如果为 0，则区域未知，否则已知并作为此输入";
      output SpecificEnthalpy h "比焓";
    algorithm
      h := IF97_Utilities.h_ps(
        p, 
        s, 
        phase, 
        region);
      annotation(Inline = true);
    end specificEnthalpy_ps;

    redeclare function density_pT 
      "根据压力和温度计算密度"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "压力";
      input Temperature T "温度";
      input FixedPhase phase = 0 "2 表示两相，1 表示单相，0 表示未知";
      input Integer region = Region 
        "如果为 0，则区域未知，否则已知并作为此输入";
      output Density d "密度";
    algorithm
      d := IF97_Utilities.rho_pT(
        p, 
        T, 
        region);
      annotation(Inline = true);
    end density_pT;

    redeclare function extends setDewState 
      "计算在露线上的热力学状态"
    algorithm
      state := ThermodynamicState(
        phase = phase, 
        p = sat.psat, 
        T = sat.Tsat, 
        h = dewEnthalpy(sat), 
        d = dewDensity(sat));
      annotation(Inline = true);
    end setDewState;

    redeclare function extends setBubbleState 
      "计算在气泡线上的热力学状态"
    algorithm
      state := ThermodynamicState(
        phase = phase, 
        p = sat.psat, 
        T = sat.Tsat, 
        h = bubbleEnthalpy(sat), 
        d = bubbleDensity(sat));
      annotation(Inline = true);
    end setBubbleState;

    redeclare function extends dynamicViscosity "水的动力黏度"
    algorithm
      eta := IF97_Utilities.dynamicViscosity(
        state.d, 
        state.T, 
        state.p, 
        state.phase);
      annotation(Inline = true);
    end dynamicViscosity;

    redeclare function extends thermalConductivity 
      "水的导热系数"
    algorithm
      lambda := IF97_Utilities.thermalConductivity(
        state.d, 
        state.T, 
        state.p, 
        state.phase);
      annotation(Inline = true);
    end thermalConductivity;

    redeclare function extends surfaceTension 
      "水的两相区域表面张力"
    algorithm
      sigma := IF97_Utilities.surfaceTension(sat.Tsat);
      annotation(Inline = true);
    end surfaceTension;

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
      extends Modelica.Icons.Function;
    algorithm
      h := state.h;
      annotation(Inline = true);
    end specificEnthalpy;

    redeclare function extends specificInternalEnergy 
      "计算比内能"
      extends Modelica.Icons.Function;
    algorithm
      u := state.h - state.p / state.d;
      annotation(Inline = true);
    end specificInternalEnergy;

    redeclare function extends specificGibbsEnergy "计算比吉布斯自由能"
      extends Modelica.Icons.Function;
    algorithm
      g := state.h - state.T * specificEntropy(state);
      annotation(Inline = true);
    end specificGibbsEnergy;

    redeclare function extends specificHelmholtzEnergy 
      "计算比赫姆霍兹自由能"
      extends Modelica.Icons.Function;
    algorithm
      f := state.h - state.p / state.d - state.T * specificEntropy(state);
      annotation(Inline = true);
    end specificHelmholtzEnergy;

    redeclare function extends specificEntropy "水的比熵"
    algorithm
      s := if dT_explicit then IF97_Utilities.s_dT(
        state.d, 
        state.T, 
        state.phase, 
        Region) else if pT_explicit then IF97_Utilities.s_pT(
        state.p, 
        state.T, 
        Region) else IF97_Utilities.s_ph(
        state.p, 
        state.h, 
        state.phase, 
        Region);
      annotation(Inline = true);
    end specificEntropy;

    redeclare function extends specificHeatCapacityCp 
      "水的定压比热容"
    algorithm
      cp := if dT_explicit then IF97_Utilities.cp_dT(
        state.d, 
        state.T, 
        Region) else if pT_explicit then IF97_Utilities.cp_pT(
        state.p, 
        state.T, 
        Region) else IF97_Utilities.cp_ph(
        state.p, 
        state.h, 
        Region);
      annotation(Inline = true);
    end specificHeatCapacityCp;

    redeclare function extends specificHeatCapacityCv 
      "水的定容比热容"
    algorithm
      cv := if dT_explicit then IF97_Utilities.cv_dT(
        state.d, 
        state.T, 
        state.phase, 
        Region) else if pT_explicit then IF97_Utilities.cv_pT(
        state.p, 
        state.T, 
        Region) else IF97_Utilities.cv_ph(
        state.p, 
        state.h, 
        state.phase, 
        Region);
      annotation(Inline = true);
    end specificHeatCapacityCv;

    redeclare function extends isentropicExponent "计算等熵指数"
    algorithm
      gamma := if dT_explicit then IF97_Utilities.isentropicExponent_dT(
        state.d, 
        state.T, 
        state.phase, 
        Region) else if pT_explicit then IF97_Utilities.isentropicExponent_pT(
        state.p, 
        state.T, 
        Region) else IF97_Utilities.isentropicExponent_ph(
        state.p, 
        state.h, 
        state.phase, 
        Region);
      annotation(Inline = true);
    end isentropicExponent;

    redeclare function extends isothermalCompressibility 
      "水的等温压缩性"
    algorithm
      //    assert(state.phase <> 2, "等温可压缩性无法通过两相输入进行计算！");
      kappa := if dT_explicit then IF97_Utilities.kappa_dT(
        state.d, 
        state.T, 
        state.phase, 
        Region) else if pT_explicit then IF97_Utilities.kappa_pT(
        state.p, 
        state.T, 
        Region) else IF97_Utilities.kappa_ph(
        state.p, 
        state.h, 
        state.phase, 
        Region);
      annotation(Inline = true);
    end isothermalCompressibility;

    redeclare function extends isobaricExpansionCoefficient 
      "水的等压膨胀系数"
    algorithm
      //    assert(state.phase <> 2, "等压膨胀系数无法通过两相输入计算！");
      beta := if dT_explicit then IF97_Utilities.beta_dT(
        state.d, 
        state.T, 
        state.phase, 
        Region) else if pT_explicit then IF97_Utilities.beta_pT(
        state.p, 
        state.T, 
        Region) else IF97_Utilities.beta_ph(
        state.p, 
        state.h, 
        state.phase, 
        Region);
      annotation(Inline = true);
    end isobaricExpansionCoefficient;

    redeclare function extends velocityOfSound 
      "返回声速，作为热力学状态记录的函数"
    algorithm
      a := if dT_explicit then IF97_Utilities.velocityOfSound_dT(
        state.d, 
        state.T, 
        state.phase, 
        Region) else if pT_explicit then IF97_Utilities.velocityOfSound_pT(
        state.p, 
        state.T, 
        Region) else IF97_Utilities.velocityOfSound_ph(
        state.p, 
        state.h, 
        state.phase, 
        Region);
      annotation(Inline = true);
    end velocityOfSound;

    redeclare function extends isentropicEnthalpy "计算 h(s,p)"
    algorithm
      h_is := IF97_Utilities.isentropicEnthalpy(
        p_downstream, 
        specificEntropy(refState), 
        0);
      annotation(Inline = true);
    end isentropicEnthalpy;

    redeclare function extends density_derh_p 
      "密度关于比焓的导数"
    algorithm
      ddhp := IF97_Utilities.ddhp(
        state.p, 
        state.h, 
        state.phase, 
        Region);
      annotation(Inline = true);
    end density_derh_p;

    redeclare function extends density_derp_h "密度关于压力的导数"
    algorithm
      ddph := IF97_Utilities.ddph(
        state.p, 
        state.h, 
        state.phase, 
        Region);
      annotation(Inline = true);
    end density_derp_h;

    // redeclare function extends density_derT_p
    //   "密度关于温度的导数"
    // algorithm
    //   ddTp := IF97_Utilities.ddTp(state.p, state.h, state.phase);
    // end density_derT_p;
    //
    // redeclare function extends density_derp_T
    //   "密度关于压力的导数"
    // algorithm
    //   ddpT := IF97_Utilities.ddpT(state.p, state.h, state.phase);
    // end density_derp_T;

    redeclare function extends bubbleEnthalpy 
      "水的沸腾曲线比焓"
    algorithm
      hl := IF97_Utilities.BaseIF97.Regions.hl_p(sat.psat);
      annotation(Inline = true);
    end bubbleEnthalpy;

    redeclare function extends dewEnthalpy "水的露点曲线比焓"
    algorithm
      hv := IF97_Utilities.BaseIF97.Regions.hv_p(sat.psat);
      annotation(Inline = true);
    end dewEnthalpy;

    redeclare function extends bubbleEntropy 
      "水的沸腾曲线比熵"
    algorithm
      sl := IF97_Utilities.BaseIF97.Regions.sl_p(sat.psat);
      annotation(Inline = true);
    end bubbleEntropy;

    redeclare function extends dewEntropy "水的露点曲线比熵"
    algorithm
      sv := IF97_Utilities.BaseIF97.Regions.sv_p(sat.psat);
      annotation(Inline = true);
    end dewEntropy;

    redeclare function extends bubbleDensity 
      "水的沸腾曲线密度"
    algorithm
      dl := if ph_explicit or pT_explicit then 
        IF97_Utilities.BaseIF97.Regions.rhol_p(sat.psat) else 
        IF97_Utilities.BaseIF97.Regions.rhol_T(sat.Tsat);
      annotation(Inline = true);
    end bubbleDensity;

    redeclare function extends dewDensity "水的露点曲线密度"
    algorithm
      dv := if ph_explicit or pT_explicit then 
        IF97_Utilities.BaseIF97.Regions.rhov_p(sat.psat) else 
        IF97_Utilities.BaseIF97.Regions.rhov_T(sat.Tsat);
      annotation(Inline = true);
    end dewDensity;

    redeclare function extends saturationTemperature 
      "水的饱和温度"
    algorithm
      T := IF97_Utilities.BaseIF97.Basic.tsat(p);
      annotation(Inline = true);
    end saturationTemperature;

    redeclare function extends saturationTemperature_derp 
      "饱和温度相对于压力的导数"
    algorithm
      dTp := IF97_Utilities.BaseIF97.Basic.dtsatofp(p);
      annotation(Inline = true);
    end saturationTemperature_derp;

    redeclare function extends saturationPressure "水的饱和压力"
    algorithm
      p := IF97_Utilities.BaseIF97.Basic.psat(T);
      annotation(Inline = true);
    end saturationPressure;

    redeclare function extends dBubbleDensity_dPressure 
      "泡点密度导数"
    algorithm
      ddldp := IF97_Utilities.BaseIF97.Regions.drhol_dp(sat.psat);
      annotation(Inline = true);
    end dBubbleDensity_dPressure;

    redeclare function extends dDewDensity_dPressure 
      "露点密度导数"
    algorithm
      ddvdp := IF97_Utilities.BaseIF97.Regions.drhov_dp(sat.psat);
      annotation(Inline = true);
    end dDewDensity_dPressure;

    redeclare function extends dBubbleEnthalpy_dPressure 
      "泡点比焓导数"
    algorithm
      dhldp := IF97_Utilities.BaseIF97.Regions.dhl_dp(sat.psat);
      annotation(Inline = true);
    end dBubbleEnthalpy_dPressure;

    redeclare function extends dDewEnthalpy_dPressure 
      "露点比焓导数"
    algorithm
      dhvdp := IF97_Utilities.BaseIF97.Regions.dhv_dp(sat.psat);
      annotation(Inline = true);
    end dDewEnthalpy_dPressure;

    redeclare function extends setState_dTX 
      "根据密度、温度和可选区域计算水的热力学状态"
      input Integer region = Region 
        "如果为 0，则区域未知，否则已知并作为输入";
    algorithm
      state := ThermodynamicState(
        d = d, 
        T = T, 
        phase = if region == 0 then 0 else if 
        region == 4 then 2 else 1, 
        h = specificEnthalpy_dT(
        d, 
        T, 
        region = region), 
        p = pressure_dT(
        d, 
        T, 
        region = region));
      annotation(Inline = true);
    end setState_dTX;

    redeclare function extends setState_phX 
      "根据 p、h 和可选区域计算水的热力学状态"
      input Integer region = Region 
        "如果为0，则区域未知，否则已知并作为输入";
    algorithm
      state := ThermodynamicState(
        d = density_ph(
        p, 
        h, 
        region = region), 
        T = temperature_ph(
        p, 
        h, 
        region = region), 
        phase = if region == 0 then 0 else if region == 4 then 2 else 1, 
        h = h, 
        p = p);
      annotation(Inline = true);
    end setState_phX;

    redeclare function extends setState_psX 
      "根据 p、s 和可选区域计算水的热力学状态"
      input Integer region = Region 
        "如果为0，则区域未知，否则已知并作为输入";
    algorithm
      state := ThermodynamicState(
        d = density_ps(
        p, 
        s, 
        region = region), 
        T = temperature_ps(
        p, 
        s, 
        region = region), 
        phase = if region == 0 then 0 else if region == 4 then 2 else 1, 
        h = specificEnthalpy_ps(
        p, 
        s, 
        region = region), 
        p = p);
      annotation(Inline = true);
    end setState_psX;

    redeclare function extends setState_pTX 
      "根据 p、T 和可选区域计算水的热力学状态"
      input Integer region = Region 
        "如果为 0，则区域未知，否则已知并作为输入";
    algorithm
      state := ThermodynamicState(
        d = density_pT(
        p, 
        T, 
        region = region), 
        T = T, 
        phase = 1, 
        h = specificEnthalpy_pT(
        p, 
        T, 
        region = region), 
        p = p);
      annotation(Inline = true);
    end setState_pTX;

    redeclare function extends setSmoothState 
      "返回热力学状态，使其平滑地逼近：如果 x > 0 则为 state_a，否则为 state_b"
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
        x_small)), 
        phase = 0);
      annotation(Inline = true);
    end setSmoothState;
    annotation(Documentation(info="<html><p>
本模型依据IAPWS-IF97标准（国际公认的工业标准，在计算精度与效率间实现最佳平衡）计算水介质在液态、气态及两相区的物性参数。 有关更多详细信息，请参阅<a href=\"modelica://Modelica.Media.Water.IF97_Utilities\" target=\"\"> Modelica.Media.Water.IF97_Utilities</a>&nbsp; 。模型支持以下三组变量对作为独立输入参数：
</p>
<ol><li>
压力 <strong>p</strong> 和比焓 <strong>h</strong> 是一般应用最多的选择。这是大多数通用应用的推荐选择，特别是适用于发电厂。</li>
<li>
压力 <strong>p</strong> 和温度 <strong>T</strong> 是在水始终处于相同相态时最多的选择，对于液态水和蒸汽都是如此。</li>
<li>
密度 <strong>d</strong> 和温度 <strong>T</strong> 是在临界附近区域的亥姆霍兹函数的显式变量，对于超临界或临界状态的应用可能是最佳选择。</li>
</ol><p>
以下物性参数为系统强制计算项：
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>变量</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>单位</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>描述</strong></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">T</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">K</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">温度</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">u</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">J/kg</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">比内能</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">d</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">kg/m^3</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">密度</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">p</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Pa</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">压力</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">h</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">J/kg</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">比焓</td></tr></tbody></table><p>
在某些情况下，需要额外的介质属性。 需要这些可选属性的组件必须调用 <a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.OptionalProperties\" target=\"\"> Modelica.Media.UsersGuide.MediumUsage.OptionalProperties</a>&nbsp; &nbsp;和 <a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.TwoPhase\" target=\"\"> Modelica.Media.UsersGuide.MediumUsage.TwoPhase</a>&nbsp; &nbsp;中列出的函数之一。
</p>
<p>
此外，系统支持计算更多物性参数。通过应用著名的布里奇曼热力学导数表（Bridgman’s Tables），可便捷地计算出标准热力学变量的一阶偏导数。
</p>
<blockquote></blockquote></html>"));
  end WaterIF97_base;

  partial package WaterIF97_fixedregion 
    "水: IAPWS/IF97 标准定义的蒸汽属性，固定区域"
    extends WaterIF97_base(Region(min = 1) = 1);
    annotation();
  end WaterIF97_fixedregion;

  package WaterIF97_R4ph "根据 IF97 标准的第 4 区水"
    extends WaterIF97_fixedregion(
      final Region = 4, 
      ThermoStates = Modelica.Media.Interfaces.Choices.IndependentVariables.ph, 
      final ph_explicit = true, 
      final dT_explicit = false, 
      final pT_explicit = false, 
      smoothModel = true, 
      onePhase = false);
    annotation(Documentation(info = "<html>

</html>"  ));
  end WaterIF97_R4ph;

  package WaterIF97_R5ph "根据 IF97 标准的第 5 区水"
    extends WaterIF97_fixedregion(
      ThermoStates = Modelica.Media.Interfaces.Choices.IndependentVariables.ph, 
      final Region = 5, 
      final ph_explicit = true, 
      final dT_explicit = false, 
      final pT_explicit = false, 
      smoothModel = true, 
      onePhase = true);
    annotation(Documentation(info = "<html>

</html>"  ));
  end WaterIF97_R5ph;

  package WaterIF97_R1pT "根据 IF97 标准的第 1 区（液态）水"
    extends WaterIF97_fixedregion(
      ThermoStates = Modelica.Media.Interfaces.Choices.IndependentVariables.pT, 
      final Region = 1, 
      final ph_explicit = false, 
      final dT_explicit = false, 
      final pT_explicit = true, 
      smoothModel = true, 
      onePhase = true);
    annotation(Documentation(info = "<html>

</html>"  ));
  end WaterIF97_R1pT;

  package WaterIF97_R2pT "根据 IF97 标准的第 2 区（蒸汽）水"
    extends WaterIF97_fixedregion(
      ThermoStates = Modelica.Media.Interfaces.Choices.IndependentVariables.pT, 
      final Region = 2, 
      final ph_explicit = false, 
      final dT_explicit = false, 
      final pT_explicit = true, 
      smoothModel = true, 
      onePhase = true);
    annotation(Documentation(info = "<html>

</html>"  ));
  end WaterIF97_R2pT;

  package WaterIF97_R1ph "根据 IF97 标准的第 1 区（液态）水"
    extends WaterIF97_fixedregion(
      ThermoStates = Modelica.Media.Interfaces.Choices.IndependentVariables.ph, 
      final Region = 1, 
      final ph_explicit = true, 
      final dT_explicit = false, 
      final pT_explicit = false, 
      smoothModel = true, 
      onePhase = true);
    annotation(Documentation(info = "<html>

</html>"  ));
  end WaterIF97_R1ph;

  package WaterIF97_R2ph "根据 IF97 标准的第 2 区（蒸汽）水"
    extends WaterIF97_fixedregion(
      ThermoStates = Modelica.Media.Interfaces.Choices.IndependentVariables.ph, 
      final Region = 2, 
      final ph_explicit = true, 
      final dT_explicit = false, 
      final pT_explicit = false, 
      smoothModel = true, 
      onePhase = true);
    annotation(Documentation(info = "<html>

</html>"  ));
  end WaterIF97_R2ph;

  package WaterIF97_R3ph "根据 IF97 标准的第 3 区水"
    extends WaterIF97_fixedregion(
      final Region = 3, 
      ThermoStates = Modelica.Media.Interfaces.Choices.IndependentVariables.ph, 
      final ph_explicit = true, 
      final dT_explicit = false, 
      final pT_explicit = false, 
      smoothModel = true, 
      onePhase = true);
    annotation(Documentation(info = "<html>

</html>"  ));
  end WaterIF97_R3ph;

  annotation(Documentation(info="<html><p>
本库包含不同的水介质模型：
</p>
<li>
<strong>ConstantPropertyLiquidWater</strong><br> 简单的液态水介质（不可压缩，常量数据）。</li>
<li>
<strong>IdealSteam</strong><br> 理想气体状态下的蒸汽水介质，源自Media.IdealGases.SingleGases.H2O。</li>
<li>
<strong>WaterIF97 derived models</strong><br> 根据IAPWS/IF97标准高精度水模型（液态、蒸汽、两相区域）。提供了具有不同自变量的模型，以及仅对特定区域有效的模型。WaterIF97_ph模型在所有区域都有效，并且是推荐使用的模型。</li>
<h4>WaterIF97衍生水模型概述</h4><p>
WaterIF97模型根据IAPWS/IF97标准计算水的介质性质（液态、气态和两相区域），该标准是公认的工业标准，也是精度和计算时间之间的最佳折中。它曾是 ThermoFluid Modelica 库的一部分，经过扩展、重组和记录后成为 Modelica 标准库的一部分。
</p>
<p>
IF97 蒸汽特性标准实施方案的一个重要特点是，该实施方案在设计时就明确考虑到要在动态模拟中良好运行。计算性能非常重要。这就意味着，如果其中一个函数被频繁调用，通常有几种方法可以从不同的函数中得到相同的结果，但可以为此进行优化。
</p>
<p>
模型可以有三对变量作为自变量：
</p>
<ol><li>
压力 <strong>p</strong> 和比焓 <strong>h</strong> 对于一般应用是最多的选择。这是大多数通用应用的推荐选择，特别是对于发电厂。</li>
<li>
压力 <strong>p</strong> 和温度 <strong>T</strong> 对于水始终处于相同相态的应用是最多的选择，对于液态水和蒸汽都是如此。</li>
<li>
密度 <strong>d</strong> 和温度 <strong>T</strong> 是近临界区域的亥姆霍兹函数的显式变量，是超临界或近临界状态应用的最佳选择。</li>
</ol><p>
在Medium.BaseProperties中始终计算以下量：
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>Variable</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>Unit</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>Description</strong></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">T</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">K</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">温度</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">u</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">J/kg</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">比内能</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">d</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">kg/m^3</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">密度</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">p</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Pa</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">压力</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">h</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">J/kg</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">比焓</td></tr></tbody></table><p>
在某些情况下，需要额外的介质属性。需要这些可选属性的组件必须调用以下函数之一：
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>函数调用</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>单位</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>描述</strong></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Medium.dynamicViscosity(medium.state)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Pa.s</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">动力黏度</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Medium.thermalConductivity(medium.state)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">W/(m.K)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">导热系数</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Medium.prandtlNumber(medium.state)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">1</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">普朗特数</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Medium.specificEntropy(medium.state)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">J/(kg.K)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">比熵</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Medium.heatCapacity_cp(medium.state)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">J/(kg.K)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">定压比热容</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Medium.heatCapacity_cv(medium.state)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">J/(kg.K)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">定容比热容</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Medium.isentropicExponent(medium.state)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">1</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">等熵指数</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Medium.isentropicEnthalpy(pressure, medium.state)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">J/kg</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">等熵焓</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Medium.velocityOfSound(medium.state)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">m/s</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">声速</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Medium.isobaricExpansionCoefficient(medium.state)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">1/K</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">等压膨胀系数</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Medium.isothermalCompressibility(medium.state)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">1/Pa</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">等温压缩系数</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Medium.density_derp_h(medium.state)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">kg/(m3.Pa)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">在恒定焓下，密度对压力的导数</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Medium.density_derh_p(medium.state)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">kg2/(m3.J)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">在恒定压力下，密度对焓的导数</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Medium.density_derp_T(medium.state)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">kg/(m3.Pa)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">在恒定温度下，密度对压力的导数</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Medium.density_derT_p(medium.state)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">kg/(m3.K)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">在恒定压力下，密度对温度的导数</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Medium.density_derX(medium.state)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">kg/m3</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">密度对质量分数的导数</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Medium.molarMass(medium.state)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">kg/mol</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">摩尔质量</td></tr></tbody></table><p>
更多详细信息请参见 <a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.OptionalProperties\" target=\"\"> Modelica.Media.UsersGuide.MediumUsage.OptionalProperties</a>&nbsp;。定义了大量附加可选函数用于计算饱和介质（液态（泡点）或气态（露点））的物性参数。这些函数以饱和属性记录（saturationproperties record）作为输入参数，该记录既可通过设定饱和压力（saturation pressure）生成，也可通过设定饱和温度（saturation temperature）生成。针对包含压力p、温度t和饱和属性记录sat的模型，系统提供以下函数集：
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>函数调用</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>单位</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>描述</strong></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Medium.saturationPressure(T)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Pa</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">温度为T时的饱和压力</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Medium.saturationTemperature(p)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">K</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">压力为p时的饱和温度</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Medium.saturationTemperature_derp(p)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">K/Pa</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">饱和温度对压力的导数</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Medium.bubbleEnthalpy(sat)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">J/kg</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">泡点的比焓</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Medium.dewEnthalpy(sat)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">J/kg</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">露点的比焓</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Medium.bubbleEntropy(sat)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">J/(kg.K)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">泡点的比熵</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Medium.dewEntropy(sat)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">J/(kg.K)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">露点的比熵</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Medium.bubbleDensity(sat)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">kg/m3</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">泡点的密度</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Medium.dewDensity(sat)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">kg/m3</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">露点的密度</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Medium.dBubbleDensity_dPressure(sat)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">kg/(m3.Pa)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">泡点的密度对压力的导数</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Medium.dDewDensity_dPressure(sat)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">kg/(m3.Pa)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">露点的密度对压力的导数</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Medium.dBubbleEnthalpy_dPressure(sat)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">J/(kg.Pa)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">泡点的比焓对压力的导数</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Medium.dDewEnthalpy_dPressure(sat)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">J/(kg.Pa)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">露点的比焓对压力的导数</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Medium.surfaceTension(sat)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">N/m</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">液体和蒸汽相之间的表面张力</td></tr></tbody></table><p>
关于用法和一些示例的详细信息请参见： <a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.TwoPhase\" target=\"\"> Modelica.Media.UsersGuide.MediumUsage.TwoPhase</a>&nbsp;.
</p>
<p>
此外，系统支持计算更多物性参数。通过应用著名的布里奇曼热力学导数表（Bridgman’s Tables），可便捷地计算出标准热力学变量的一阶偏导数。
</p>
<p>
水蒸气物性标准文档可随计算机实现代码自由分发，其副本已集成于以下目录中（路径：Modelica/Resources/Documentation/Media/Water/IF97documentation）：
</p>
<li>
<a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/IF97.pdf\" target=\"\">IF97.pdf</a>&nbsp; IF97的标准文档的主要部分</li>
<li>
<a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/Back3.pdf\" target=\"\">Back3.pdf</a>&nbsp; 区域3的反向方程</li>
<li>
<a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/crits.pdf\" target=\"\">crits.pdf</a>&nbsp; 临界点数据。</li>
<li>
<a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/meltsub.pdf\" target=\"\">meltsub.pdf</a>&nbsp; 熔点和升华线的制定（未实现）</li>
<li>
<a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/surf.pdf\" target=\"\">surf.pdf</a>&nbsp; 表面张力的标准定义</li>
<li>
<a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/thcond.pdf\" target=\"\">thcond.pdf</a>&nbsp; 导热系数的标准定义</li>
<li>
<a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/visc.pdf\" target=\"\">visc.pdf</a>&nbsp; 黏度标准定义</li>
<p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"));
end Water;