within Modelica.Media.Air;
package ReferenceMoistAir 

"ReferenceMoistAir：详细的湿空气模型(143.15...2000K)"

  extends Modelica.Media.Interfaces.PartialRealCondensingGases(
    mediumName = "Moist air", 
    substanceNames = {"water", "air"}, 
    final fixedX = false, 
    final reducedX = true, 
    final singleState = false, 
    reference_X = {0.01, 0.99}, 
    fluidConstants = {Utilities.Water95_Utilities.waterConstants, Modelica.Media.Air.ReferenceAir.airConstants}, 
    ThermoStates = Modelica.Media.Interfaces.Choices.IndependentVariables.pTX);

  constant Integer Water = 1 
    "水的索引 (在 substanceNames, 质量分数 X 等)";

  constant Integer Air = 2 
    "空气的索引 (在 substanceNames, 质量分数 X 等)";

  constant Boolean useEnhancementFactor = false 
    "在计算中使用增强因子";

  constant Boolean useDissociation = true 
    "在高温下考虑解离";

  constant Real k_mair = steam.MM / dryair.MM "摩尔质量比";

  constant Common.FundamentalConstants dryair = ReferenceAir.Air_Utilities.Basic.Constants;
  constant Common.FundamentalConstants steam = Utilities.Water95_Utilities.Constants;
  constant SI.MolarMass[2] MMX = {steam.MM, dryair.MM} 
    "组分的摩尔质量";

  import Modelica.Media.Interfaces;
  import Modelica.Math;

  import Modelica.Constants;
  import Modelica.Media.IdealGases.Common.SingleGasNasa;

  redeclare record extends ThermodynamicState 
    "湿空气的热力学状态记录"
    annotation();
  end ThermodynamicState;

  redeclare replaceable model extends BaseProperties(
    T(stateSelect = if preferredMediumStates then StateSelect.prefer else 
    StateSelect.default), 
    p(stateSelect = if preferredMediumStates then StateSelect.prefer else 
    StateSelect.default), 
    Xi(each stateSelect = if preferredMediumStates then StateSelect.prefer else 
    StateSelect.default), 
    final standardOrderComponents = true) "湿空气基本属性记录"

    Real x_water "总水质量/干空气质量";
    Real phi "相对湿度";

  protected
    MassFraction X_liquid "液态或固态水的质量分数";
    MassFraction X_steam "水蒸气的质量分数";
    MassFraction X_air "空气的质量分数";
    MassFraction X_sat 
      "饱和边界的水蒸气质量分数，单位 kg_water/kg_moistair";
    Real x_sat 
      "饱和边界的水蒸气质量含量，单位 kg_water/kg_dryair";
    AbsolutePressure p_steam_sat "水蒸气的饱和压力";

  equation
    assert(T >= 143.15 and T <= 2000, 
      "温度 T 不在允许范围内 143.15 K <= (T =" + String(T) 
      + " K) <= 2000 K，要求来自介质模型 \"" + mediumName + "\"。");

    MM = 1 / (Xi[Water] / MMX[Water] + (1.0 - Xi[Water]) / MMX[Air]);

    p_steam_sat = Modelica.Media.Air.ReferenceMoistAir.Utilities.pds_pT(p, T);
    X_sat = Modelica.Media.Air.ReferenceMoistAir.Xsaturation(state);
    X_liquid = max(Xi[Water] - X_sat, 0.0);
    X_steam = Xi[Water] - X_liquid;
    X_air = 1 - Xi[Water];

    h = specificEnthalpy_pTX(
      p, 
      T, 
      Xi);
    R_s = dryair.R_s * (X_air / (1 - X_liquid)) + steam.R_s * X_steam / (1 - X_liquid);
    u = Modelica.Media.Air.ReferenceMoistAir.Utilities.u_pTX(
      p, 
      T, 
      Xi);
    d = Modelica.Media.Air.ReferenceMoistAir.Utilities.rho_pTX(
      p, 
      T, 
      Xi);
    state.p = p;
    state.T = T;
    state.X = X;

    // 这些 x 是每单位质量的干空气！
    x_sat = Modelica.Media.Air.ReferenceMoistAir.xsaturation(state);
    x_water = Modelica.Media.Air.ReferenceMoistAir.waterContent_X(state.X);
    phi = Modelica.Media.Air.ReferenceMoistAir.Utilities.phi_pTX(
      p, 
      T, 
      Xi);

    annotation(Documentation(revisions = "<html>
2017-04-13 Stefan Wischhusen: 解决了高饱和压力和温度下的问题。
</html>"));
  end BaseProperties;

  redeclare function extends setState_pTX 
    "根据压力 p、温度 T 和组分 X 计算热力学状态"
    annotation();
  algorithm
    state := if size(X, 1) == nX then ThermodynamicState(
      p = p, 
      T = T, 
      X = X) else ThermodynamicState(
      p = p, 
      T = T, 
      X = cat(
      1, 
      X, 
      {1 - sum(X)}));
  end setState_pTX;

  redeclare function extends setState_phX 
    "根据压力 p、比焓 h 和组分 X 计算热力学状态"
    annotation();
  algorithm
    state := if size(X, 1) == nX then ThermodynamicState(
      p = p, 
      T = Modelica.Media.Air.ReferenceMoistAir.Utilities.Inverses.T_phX(
      p, 
      h, 
      X), 
      X = X) else ThermodynamicState(
      p = p, 
      T = Modelica.Media.Air.ReferenceMoistAir.Utilities.Inverses.T_phX(
      p, 
      h, 
      X), 
      X = cat(
      1, 
      X, 
      {1 - sum(X)}));
  end setState_phX;

  redeclare function extends setState_psX 
    "根据压力 p、焓 h 和组分 X 计算热力学状态"
    annotation();
  algorithm
    state := if size(X, 1) == nX then ThermodynamicState(
      p = p, 
      T = Modelica.Media.Air.ReferenceMoistAir.Utilities.Inverses.T_psX(
      p, 
      s, 
      X), 
      X = X) else ThermodynamicState(
      p = p, 
      T = Modelica.Media.Air.ReferenceMoistAir.Utilities.Inverses.T_psX(
      p, 
      s, 
      X), 
      X = cat(
      1, 
      X, 
      {1 - sum(X)}));
  end setState_psX;

  redeclare function extends setState_dTX 
    "根据密度 d、温度 T 和组分 X 计算热力学状态"
    annotation();
  algorithm
    state := if size(X, 1) == nX then ThermodynamicState(
      p = Modelica.Media.Air.ReferenceMoistAir.Utilities.Inverses.p_dTX(
      d, 
      T, 
      X), 
      T = T, 
      X = X) else ThermodynamicState(
      p = Modelica.Media.Air.ReferenceMoistAir.Utilities.Inverses.p_dTX(
      d, 
      T, 
      X), 
      T = T, 
      X = cat(
      1, 
      X, 
      {1 - sum(X)}));
  end setState_dTX;

  redeclare function extends setSmoothState 
    "计算热力学状态，以便平滑地近似：如果 x > 0 则为 state_a，否则为 state_b"
    annotation();
  algorithm
    state := ThermodynamicState(
      p = Modelica.Media.Common.smoothStep(
      x, 
      state_a.p, 
      state_b.p, 
      x_small), 
      T = Modelica.Media.Common.smoothStep(
      x, 
      state_a.T, 
      state_b.T, 
      x_small), 
      X = Modelica.Media.Common.smoothStep(
      x, 
      state_a.X, 
      state_b.X, 
      x_small));
  end setSmoothState;

  function Xsaturation 
    "计算在饱和时每单位湿空气质量中的绝对湿度，作为热力学状态记录的函数"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "热力学状态记录";
    output MassFraction X_sat "饱和边界的蒸汽质量分数";
  protected
    MassFraction[:] X = massFractionSaturation(state);
    annotation();
  algorithm
    //X := massFractionSaturation(state);
    X_sat := X[1];
  end Xsaturation;

  function xsaturation 
    "计算在饱和时每单位干空气质量中的绝对湿度，作为热力学状态记录的函数"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "热力学状态记录";
    output MassFraction x_sat "每单位干空气的绝对湿度";
    annotation();
  algorithm
    x_sat := Modelica.Media.Air.ReferenceMoistAir.Utilities.xws_pT(
      state.p, 
      state.T);
    assert(x_sat > -1, 
      "计算绝对湿度对于输入压力 p = " + String(state.p) + " Pa 和温度 T = " + String(state.T) + " K 毫无意义。");
  end xsaturation;

  redeclare function extends massFraction_pTphi 
    "计算作为压力、温度和相对湿度函数的质量分数"
  protected
    Real pds;
    annotation();

  algorithm
    assert(phi < 1.0 and phi > 0, "非法输入 phi = " + String(phi) + 
      "。相对湿度仅在范围内定义\n 0 <= phi <= 1.0。");
    pds := Modelica.Media.Air.ReferenceMoistAir.Utilities.pds_pT(p, T);
    assert(pds > -1, 
      "计算蒸汽质量分数对于输入压力 p = " + String(p) + " Pa 和温度 T = " + String(T) + " K 毫无意义。");
    X := {phi * k_mair / (p / pds - phi), 1 - phi * k_mair / (p / pds - phi)};
  end massFraction_pTphi;

  function massFractionWaterVapor 
    "计算水蒸气的质量分数"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "热力学状态记录";
    output MassFraction X "水蒸气的质量分数";
  protected
    Real xw;
    Real xws;
  algorithm
    xw := state.X[1] / max(100 * Modelica.Constants.eps, (1 - state.X[1]));
    xws := Utilities.xws_pT(state.p, state.T);
    X := if (xw <= xws) then xw / (1 + xw) else xws / (1 + xw);
    annotation(Documentation(revisions = "<html>
2017-04-13 Stefan Wischhusen: 引入防止除以零的保护。
</html>"));
  end massFractionWaterVapor;

  function massFractionWaterNonVapor 
    "计算液态和固态水的质量分数"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "热力学状态记录";
    output MassFraction X "液态和固态水的质量分数";
  protected
    Real xw;
    Real xws;
  algorithm
    xw := state.X[1] / max(100 * Modelica.Constants.eps, (1 - state.X[1]));
    xws := Utilities.xws_pT(state.p, state.T);
    X := if (xw <= xws) then 0 else (xw - xws) / (1 + xw);
    annotation(Documentation(revisions = "<html>
2017-04-13 Stefan Wischhusen: 引入防止除以零的保护。
</html>"));
  end massFractionWaterNonVapor;

  redeclare function extends massFractionSaturation(redeclare output MassFraction Xsat[2]) 
    "计算饱和质量分数"
  protected
    AbsolutePressure pds;
    annotation();
  algorithm
    pds := Utilities.pds_pT(state.p, state.T);
    Xsat := {k_mair / (state.p / pds - 1 + k_mair), (state.p / pds - 1) / (state.p / pds 
      - 1 + k_mair)};
    assert(Xsat[1] > -1, 
      "计算饱和质量分数是无意义的\n对于输入压力 p = " 
      + String(state.p) + " Pa 和温度 T = " + String(state.T) + " K。");
  end massFractionSaturation;

  function massFractionSaturation_ppsat 
    "根据压力和饱和压力计算饱和边界的质量分数"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "环境压力";
    input AbsolutePressure psat "饱和压力";
    output MassFraction[:] X "质量分数";
    annotation();
  algorithm
    X := {k_mair / (p / psat - 1 + k_mair), (p / psat - 1) / (p / psat - 1 + k_mair)};
  end massFractionSaturation_ppsat;

  function massFraction_waterContent 
    "根据压力、温度和绝对湿度计算质量分数（kg（水）/kg（干空气））"
    extends Modelica.Icons.Function;
    input Real xw "单位质量干空气中的水含量（kg（水）/kg（干空气））";
    output MassFraction[:] X "质量分数";
    annotation();
  algorithm
    X := {xw / (1 + xw), 1 / (1 + xw)};
  end massFraction_waterContent;

  function waterContent_X 
    "根据质量分数计算水含量（kg（水）/kg（干空气））"
    extends Modelica.Icons.Function;
    input MassFraction[:] X "质量分数";
    output Real xw "单位质量干空气中的水含量（kg（水）/kg（干空气））";
  algorithm
    xw := X[1] / max(100 * Modelica.Constants.eps, (1 - X[1]));
    annotation(Documentation(revisions = "<html>
2017-04-13 Stefan Wischhusen: 引入防止除以零的保护。
</html>"));
  end waterContent_X;


  redeclare function extends relativeHumidity "计算相对湿度"
    annotation();
  algorithm
    phi := Utilities.phi_pTX(
      state.p, 
      state.T, 
      state.X);
    assert(phi > -1, 
      "计算相对湿度是无意义的\n对于输入压力 p = " 
      + String(state.p) + " Pa 和温度 T = " + String(state.T) + " K。");
  end relativeHumidity;

  redeclare function extends gasConstant 
    "计算理想气体常数作为热力学状态的函数，仅在 phi<1 时有效"
    annotation();

  algorithm
    R_s := dryair.R_s * (1 - state.X[Water]) + steam.R_s * state.X[Water];
  end gasConstant;

  function saturationPressureLiquid 
    "根据温度 T 计算水的饱和压力"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "热力学状态记录";
    output AbsolutePressure psat "饱和压力";
    annotation();
  algorithm
    psat := 
      Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.psat(
      state.T);
  end saturationPressureLiquid;

  function sublimationPressureIce 
    "根据温度T计算水的升华压力，温度范围在223.16到273.16 K之间"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "热力学状态记录";
    output AbsolutePressure psat "升华压力";
    annotation();
  algorithm
    psat := 
      Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.psub(
      state.T);
  end sublimationPressureIce;

  redeclare function extends saturationPressure 
    "计算凝结流体的饱和压力"
    annotation();
  algorithm
    psat := Utilities.pds_pT(state.p, state.T);
    assert(psat > -1, 
      "计算饱和压力是无意义的\n对于输入温度 T = " 
      + String(state.T) + " K。");
  end saturationPressure;

  redeclare function extends saturationTemperature 
    "计算凝结流体的饱和温度"
  protected
    partial function Tsat_res
      extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
      input SI.Pressure p "压力";
      annotation();

    algorithm
      y := Modelica.Media.Air.ReferenceMoistAir.Utilities.pds_pT(p = p, T = u) - p;
    end Tsat_res;
    annotation();

  algorithm
    Tsat := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
      function Tsat_res(p = state.p), 
      50.0, 
      673.15, 
      1e-9);
  end saturationTemperature;

  redeclare function extends enthalpyOfVaporization 
    "计算水的汽化焓"
  protected
    AbsolutePressure p_liq;
    annotation();
  algorithm
    p_liq := saturationPressureLiquid(state);
    r0 := Modelica.Media.Water.IF97_Utilities.hv_p(p_liq) - 
      Modelica.Media.Water.IF97_Utilities.hl_p(p_liq);
  end enthalpyOfVaporization;

  redeclare function extends enthalpyOfLiquid 
    "计算液态水的焓"
  protected
    Real xw;
    Real xws;
    annotation();
  algorithm
    xw := state.X[1] / (1 - state.X[1]);
    xws := Utilities.xws_pT(state.p, state.T);
    if ((xws > xw) and (state.T > 273.15)) then
      h := Modelica.Media.Water.IF97_Utilities.h_pT(
        state.p, 
        state.T, 
        region = 1);
    else
      h := 0;
    end if;
  end enthalpyOfLiquid;

  redeclare function extends enthalpyOfGas 
    "计算气体（空气和蒸汽）的比焓"
  protected
    Real xw;
    Real xws;
    Real pd;
    Real pl;

  algorithm
    pd := Utilities.pd_pTX(
      state.p, 
      state.T, 
      state.X);
    pl := state.p - pd;
    xw := state.X[1] / (1 - state.X[1]);
    xws := Utilities.xws_pT(state.p, state.T);
    if ((xw <= xws) or (xws == -1)) then
      h := Modelica.Media.Air.ReferenceAir.Air_Utilities.h_pT(pl, state.T) + xw 
        * Utilities.IF97_new.h_pT(pd, state.T);
    else
      if (state.T < 273.16) then
        h := Modelica.Media.Air.ReferenceAir.Air_Utilities.h_pT(pl, state.T) + 
          xws * Utilities.IF97_new.h_pT(pd, state.T);
      else
        h := Modelica.Media.Air.ReferenceAir.Air_Utilities.h_pT(pl, state.T) + 
          xws * Utilities.IF97_new.h_pT(pd, state.T);
      end if;
    end if;
    annotation(Inline = false, LateInline = true);
  end enthalpyOfGas;

  redeclare function extends enthalpyOfCondensingGas 
    "计算蒸汽的比焓"
  protected
    Real xw;
    Real pd;

  algorithm
    pd := Utilities.pd_pTX(
      state.p, 
      state.T, 
      state.X);
    xw := state.X[1] / (1 - state.X[1]);
    h := xw * Utilities.IF97_new.h_pT(pd, state.T);
    annotation(Inline = false, LateInline = true);
  end enthalpyOfCondensingGas;

  redeclare function extends enthalpyOfNonCondensingGas 
    "计算干空气的比焓"
    annotation();

  algorithm
    h := Modelica.Media.Air.ReferenceAir.Air_Utilities.h_pT(state.p, state.T);
  end enthalpyOfNonCondensingGas;

  function enthalpyOfDryAir = enthalpyOfNonCondensingGas 
    "计算干空气的比焓" annotation();
  function enthalpyOfWater 
    "计算水的比焓（固体 + 液体 + 蒸汽）"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "热力学状态记录";
    output SI.SpecificEnthalpy h "水的比焓";
    annotation();
  algorithm
    h := specificEnthalpy(state) - enthalpyOfNonCondensingGas(state);
  end enthalpyOfWater;

  function enthalpyOfWaterVapor = enthalpyOfCondensingGas 
    "计算蒸汽的比焓" annotation();
  function enthalpyOfWaterNonVapor "计算液体和固体水的比焓"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "热力学状态记录";
    output SI.SpecificEnthalpy h "水的比焓";
    annotation();
  algorithm
    h := enthalpyOfWater(state) - enthalpyOfWaterVapor(state);
  end enthalpyOfWaterNonVapor;

  redeclare function extends pressure 
    "返回理想气体的压力作为热力学状态记录的函数"
    annotation();

  algorithm
    p := state.p;

  end pressure;

  redeclare function extends temperature 
    "返回理想气体的温度作为热力学状态记录的函数"
    annotation();

  algorithm
    T := state.T;

  end temperature;

  redeclare function extends density 
    "返回密度作为热力学状态记录的函数"
    annotation();

  algorithm
    d := Utilities.rho_pTX(
      state.p, 
      state.T, 
      state.X);

  end density;

  redeclare function extends specificEnthalpy 
    "返回湿空气的比焓作为热力学状态记录的函数"
    annotation();

  algorithm
    h := Modelica.Media.Air.ReferenceMoistAir.Utilities.h_pTX(
      state.p, 
      state.T, 
      state.X);

  end specificEnthalpy;

  redeclare function extends specificInternalEnergy 
    "返回湿空气的比内能作为热力学状态记录的函数"
    annotation();

  algorithm
    u := Utilities.u_pTX(
      state.p, 
      state.T, 
      state.X);

  end specificInternalEnergy;

  redeclare function extends specificEntropy 
    "根据热力学状态记录计算比熵，仅对 phi<1 有效"
    annotation();

  algorithm
    s := Utilities.s_pTX(
      state.p, 
      state.T, 
      state.X);

  end specificEntropy;

  redeclare function extends specificGibbsEnergy 
    "返回比吉布斯能作为热力学状态记录的函数，仅适用于 phi<1"
    annotation();
  algorithm
    g := Utilities.h_pTX(
      state.p, 
      state.T, 
      state.X) - state.T * Utilities.s_pTX(
      state.p, 
      state.T, 
      state.X);

  end specificGibbsEnergy;

  redeclare function extends specificHelmholtzEnergy 
    "返回比亥姆霍兹能作为热力学状态记录的函数，仅对于 phi<1 有效"
    annotation();

  algorithm
    f := Utilities.u_pTX(
      state.p, 
      state.T, 
      state.X) - state.T * Utilities.s_pTX(
      state.p, 
      state.T, 
      state.X);

  end specificHelmholtzEnergy;

  redeclare function extends specificHeatCapacityCp 
    "返回定压比热容作为热力学状态记录的函数"
    annotation();

  algorithm
    cp := Utilities.cp_pTX(
      state.p, 
      state.T, 
      state.X);

  end specificHeatCapacityCp;

  redeclare function extends specificHeatCapacityCv 
    "返回定容比热容作为热力学状态记录的函数"
    annotation();

  algorithm
    cv := Utilities.cv_pTX(
      state.p, 
      state.T, 
      state.X);

  end specificHeatCapacityCv;

  redeclare function extends isentropicExponent "计算等熵指数"
    annotation();
  algorithm
    gamma := specificHeatCapacityCp(state) / specificHeatCapacityCv(state);
  end isentropicExponent;

  redeclare function extends isentropicEnthalpy "计算等熵焓"
  protected
    MassFraction[nX] X "完整的 X 向量";
  algorithm
    /*X := if reducedX then cat(
    1,
    refState.X,
    {1 - sum(refState.X)}) else refState.X;*/
    X := refState.X;
    h_is := specificEnthalpy(setState_psX(
      p_downstream, 
      specificEntropy(refState), 
      X));
    annotation(Documentation(revisions = "<html>
2013-07-18 Stefan Wischhusen: 更改了 X 的内部计算方式.
</html>"));
  end isentropicEnthalpy;

  redeclare function extends velocityOfSound "计算声速"
    annotation();
  algorithm
    a := sqrt(max(0, gasConstant(state) * state.T * specificHeatCapacityCp(state) / 
      specificHeatCapacityCv(state)));
  end velocityOfSound;

  redeclare function extends molarMass "计算介质的摩尔质量"
    annotation();
  algorithm
    MM := 1 / (state.X[1] / steam.MM + state.X[2] / dryair.MM);
  end molarMass;

  redeclare function extends dynamicViscosity 
    "返回动力黏度作为热力学状态记录的函数，有效范围为 73.15 K 到 373.15 K"
    annotation();
  algorithm
    eta := Utilities.Transport.eta_pTX(
      state.p, 
      state.T, 
      state.X);

  end dynamicViscosity;

  redeclare function extends thermalConductivity 
    "返回导热系数作为一个函数，有效范围为从73.15K到373.15K"
    annotation();
  algorithm
    lambda := Utilities.Transport.lambda_pTX(
      state.p, 
      state.T, 
      state.X);

  end thermalConductivity;

  package Utilities "湿空气的公用库"
    extends Modelica.Icons.UtilitiesPackage;

    final constant MoleFraction[4] MMX = {18.015257E-003, 28.01348E-003, 
      31.9988E-003, 39.948E-003};

    final constant Real[3] Xi_Air = {0.7557, 0.2316, 0.0127};

    package Inverses "计算逆函数"
      extends Modelica.Icons.BasesPackage;

      function T_phX 
        "返回温度作为压力、比焓和质量分数的函数"
        extends Modelica.Icons.Function;
        input SI.AbsolutePressure p "压力";
        input SI.SpecificEnthalpy h "比焓";
        input SI.MassFraction X[:] = Modelica.Media.Air.ReferenceMoistAir.reference_X 
          "质量分数";
        output SI.Temperature T "温度";

      protected
        MassFraction[nX] Xfull = if size(X, 1) == nX then X else cat(
          1, 
          X, 
          {1 - sum(X)});

        function T_phX_res
          extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
          input SI.AbsolutePressure p "压力";
          input SI.SpecificEnthalpy h "比焓";
          input SI.MassFraction X[:] = Modelica.Media.Air.ReferenceMoistAir.reference_X 
            "质量分数";
          annotation();
        algorithm
          y := Modelica.Media.Air.ReferenceMoistAir.Utilities.h_pTX(
            p = p, 
            T = u, 
            X = X) - h;
        end T_phX_res;

      algorithm
        T := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
          function T_phX_res(
          p = p, 
          h = h, 
          X = Xfull), 
          173.15, 
          2000.0, 
          1e-9);
        annotation(inverse(h = 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.h_pTX(
          p = p, 
          T = T, 
          X = X)));
      end T_phX;

      function T_psX 
        "返回温度作为压力、比熵和质量分数的函数"
        extends Modelica.Icons.Function;
        input SI.AbsolutePressure p "压力";
        input SI.SpecificEntropy s "比熵";
        input SI.MassFraction X[:] = Modelica.Media.Air.ReferenceMoistAir.reference_X 
          "质量分数";
        output SI.Temperature T "温度";

      protected
        MassFraction[nX] Xfull = if size(X, 1) == nX then X else cat(
          1, 
          X, 
          {1 - sum(X)});

        function T_psX_res
          extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
          input SI.AbsolutePressure p "压力";
          input SI.SpecificEntropy s "比熵";
          input SI.MassFraction X[:] = Modelica.Media.Air.ReferenceMoistAir.reference_X 
            "质量分数";
          annotation();
        algorithm
          y := Modelica.Media.Air.ReferenceMoistAir.Utilities.s_pTX(
            p = p, 
            T = u, 
            X = X) - s;
        end T_psX_res;

      algorithm
        T := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
          function T_psX_res(
          p = p, 
          s = s, 
          X = Xfull), 
          173.15, 
          2000.0, 
          1e-9);
        annotation(inverse(s = 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.s_pTX(
          p = p, 
          T = T, 
          X = X)));
      end T_psX;

      function p_dTX 
        "返回压力作为密度、温度和质量分数的函数"
        extends Modelica.Icons.Function;
        input SI.Density d "密度";
        input SI.Temperature T "温度";
        input SI.MassFraction X[:] = Modelica.Media.Air.ReferenceMoistAir.reference_X 
          "质量分数";
        output SI.AbsolutePressure p "压力";

      protected
        MassFraction[nX] Xfull = if size(X, 1) == nX then X else cat(
          1, 
          X, 
          {1 - sum(X)});

        function p_dTX_res
          extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
          input SI.Density d "密度";
          input SI.Temperature T "温度";
          input SI.MassFraction X[:] = Modelica.Media.Air.ReferenceMoistAir.reference_X 
            "质量分数";
          annotation();
        algorithm
          y := Modelica.Media.Air.ReferenceMoistAir.Utilities.rho_pTX(
            p = u, 
            T = T, 
            X = X) - d;
        end p_dTX_res;

      algorithm
        p := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
          function p_dTX_res(
          d = d, 
          T = T, 
          X = Xfull), 
          611.2, 
          1e7, 
          1e-9);
        annotation(inverse(d = 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.rho_pTX(
          p = p, 
          T = T, 
          X = X)), Documentation(revisions = "<html>
2013-07-18 Stefan Wischhusen: 更正了压力的逆区间，以完善介质模型的范围。
</html>"  ));
      end p_dTX;
      annotation();
    end Inverses;

    package Transport "湿空气输运属性库"
      extends Modelica.Icons.BasesPackage;

      record coef 
        "用于计算输运属性的多项式系数"
        extends Modelica.Icons.Record;
        Real sigma = 2.52;
        Real epsilon = 775;
        Real M = 18.0152;
        Real R = 0.46144;
        Real[5] w = {0.69339511, -0.002597963, 1.2864772, 0.1576848, 0.02543632};
        Real[5] a = {0.4159259E+001, -0.1725577E-002, 0.5702012E-005, -0.4596049E-008, 
          0.1424309E-011};
        annotation();
      end coef;

      function eta_pTX "动力黏度"
        extends Modelica.Icons.Function;
        input SI.AbsolutePressure p "压力";
        input SI.Temperature T "温度";
        input SI.MassFraction X[:] = Modelica.Media.Air.ReferenceMoistAir.reference_X 
          "质量分数";
        output SI.DynamicViscosity eta "动力黏度";

      protected
        Real ya;
        Real yd;
        Real yf;
        Real va;
        Real vd;
        Real vf;
        Real xw;
        Real xws;
        Real pd;
        Real pl;
        Real da;
        Real dd;
        Real df;
        Real Omega;
        Real Tred;
        Real etad;
        Modelica.Media.Air.ReferenceMoistAir.Utilities.Transport.coef coef;
        annotation();

      algorithm
        xw := X[1] / (1 - X[1]);
        xws := Modelica.Media.Air.ReferenceMoistAir.Utilities.xws_pT(p, T);
        pd := Modelica.Media.Air.ReferenceMoistAir.Utilities.pd_pTX(
          p, 
          T, 
          X);
        pl := p - pd;
        da := Modelica.Media.Air.ReferenceAir.Air_Utilities.rho_pT(pl, T);
        if ((xw <= xws) or (xws == -1)) then
          if (T < 273.16) then
            dd := pd / (Modelica.Media.Air.ReferenceMoistAir.steam.R_s * T);
            ya := da / (da + dd);
            yd := 1 - ya;
            Tred := T / coef.epsilon;
            Omega := coef.w[1] + coef.w[2] * Tred + coef.w[3] * Modelica.Math.exp(
              coef.w[4] * Tred) / (coef.w[5] + Tred);
            etad := 2.6695E-006 * sqrt(T * coef.M) / (coef.sigma ^ 2 * Omega);
            eta := ya * 
              Modelica.Media.Air.ReferenceAir.Air_Utilities.Transport.eta_dT(da, 
              T) + yd * etad;
          else
            dd := 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.rho_pT(pd, 
              T);
            ya := da / (da + dd);
            yd := 1 - ya;
            eta := ya * 
              Modelica.Media.Air.ReferenceAir.Air_Utilities.Transport.eta_dT(da, 
              T) + yd * 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.visc_dT(
              dd, T);
          end if;
        else
          if (T < 273.16) then
            dd := pd / (Modelica.Media.Air.ReferenceMoistAir.steam.R_s * T);
            ya := da / (da + dd);
            yd := 1 - ya;
            Tred := T / coef.epsilon;
            Omega := coef.w[1] + coef.w[2] * Tred + coef.w[3] * Modelica.Math.exp(
              coef.w[4] * Tred) / (coef.w[5] + Tred);
            etad := 2.6695E-006 * sqrt(T * coef.M) / (coef.sigma ^ 2 * Omega);
            eta := ya * 
              Modelica.Media.Air.ReferenceAir.Air_Utilities.Transport.eta_dT(da, 
              T) + yd * etad;
          else
            dd := 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.rho_pT(pd, 
              T);
            df := Modelica.Media.Water.IF97_Utilities.rho_pT(p, T);
            yf := (xw - xws) / df / ((1 + xws) / (da + dd) + (xw - xws) / df);
            ya := (1 - yf) / (1 + dd / da);
            yd := 1 - (ya + yf);
            eta := ya * 
              Modelica.Media.Air.ReferenceAir.Air_Utilities.Transport.eta_dT(da, 
              T) + yd * 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.visc_dT(
              dd, T) + yf * 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.visc_dT(
              df, T);
          end if;
        end if;
      end eta_pTX;

      function lambda_pTX "导热系数"
        extends Modelica.Icons.Function;
        input SI.AbsolutePressure p "压力";
        input SI.Temperature T "温度";
        input SI.MassFraction X[:] = Modelica.Media.Air.ReferenceMoistAir.reference_X 
          "质量分数";
        output SI.ThermalConductivity lambda 
          "导热系数";

      protected
        Real ya;
        Real yd;
        Real yf;
        Real va;
        Real vd;
        Real vf;
        Real xw;
        Real xws;
        Real pd;
        Real pl;
        Real da;
        Real dd;
        Real df;
        Real Omega;
        Real Tred;
        Real cp;
        Real Eu;
        Real lambdad;
        Modelica.Media.Air.ReferenceMoistAir.Utilities.Transport.coef coef;
        annotation();

      algorithm
        xw := X[1] / (1 - X[1]);
        xws := Modelica.Media.Air.ReferenceMoistAir.Utilities.xws_pT(p, T);
        pd := Modelica.Media.Air.ReferenceMoistAir.Utilities.pd_pTX(
          p, 
          T, 
          X);
        pl := p - pd;
        da := Modelica.Media.Air.ReferenceAir.Air_Utilities.rho_pT(pl, T);
        if ((xw <= xws) or (xws == -1)) then
          if (T < 273.16) then
            dd := pd / (Modelica.Media.Air.ReferenceMoistAir.steam.R_s * T);
            ya := da / (da + dd);
            yd := 1 - ya;
            Tred := T / coef.epsilon;
            Omega := coef.w[1] + coef.w[2] * Tred + coef.w[3] * Modelica.Math.exp(
              coef.w[4] * Tred) / (coef.w[5] + Tred);
            cp := coef.a[1] + coef.a[2] * T + coef.a[3] * T ^ 2 + coef.a[4] * T ^ 3 + 
              coef.a[5] * T ^ 4;
            Eu := 0.35424 * cp + 0.1144;
            Eu := 0;
            lambdad := 0.083232 * sqrt(T / coef.M) / (coef.sigma ^ 2 * Omega) * Eu;
            lambda := ya * 
              Modelica.Media.Air.ReferenceAir.Air_Utilities.Transport.lambda_dT(
              da, T) + yd * lambdad;
          else
            dd := 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.rho_pT(pd, 
              T);
            ya := da / (da + dd);
            yd := 1 - ya;
            lambda := ya * 
              Modelica.Media.Air.ReferenceAir.Air_Utilities.Transport.lambda_dT(
              da, T) + yd * 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.cond_dT(
              dd, T);
          end if;
        else
          if (T < 273.16) then
            dd := pd / (Modelica.Media.Air.ReferenceMoistAir.steam.R_s * T);
            df := 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.rho_pT(
              p, T);
            yf := (xw - xws) / df / ((1 + xws) / (da + dd) + (xw - xws) / df);
            ya := (1 - yf) / (1 + dd / da);
            yd := 1 - (ya + yf);
            Tred := T / coef.epsilon;
            Omega := coef.w[1] + coef.w[2] * Tred + coef.w[3] * Modelica.Math.exp(
              coef.w[4] * Tred) / (coef.w[5] + Tred);
            cp := coef.a[1] + coef.a[2] * T + coef.a[3] * T ^ 2 + coef.a[4] * T ^ 3 + 
              coef.a[5] * T ^ 4;
            Eu := 0.35424 * cp + 0.1144;
            lambdad := 0.083232 * sqrt(T / coef.M) / (coef.sigma ^ 2 * Omega) * Eu;
            lambda := ya * 
              Modelica.Media.Air.ReferenceAir.Air_Utilities.Transport.lambda_dT(
              da, T) + yd * lambdad + yf * 2.21;
          else
            dd := 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.rho_pT(pd, 
              T);
            df := Modelica.Media.Water.IF97_Utilities.rho_pT(p, T);
            yf := (xw - xws) / df / ((1 + xws) / (da + dd) + (xw - xws) / df);
            ya := (1 - yf) / (1 + dd / da);
            yd := 1 - (ya + yf);
            lambda := ya * 
              Modelica.Media.Air.ReferenceAir.Air_Utilities.Transport.lambda_dT(
              da, T) + yd * 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.cond_dT(
              dd, T) + yf * 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.cond_dT(
              df, T);
          end if;
        end if;
      end lambda_pTX;
      annotation();
    end Transport;

    package VirialCoefficients 
      "空气和水的维里系数和交维里系数"
      extends Modelica.Icons.BasesPackage;

      function Baa_dT "干空气的第二摩尔维里系数"
        extends Modelica.Icons.Function;

        input SI.Density d "密度";
        input SI.Temperature T "温度";
        output SI.MolarVolume baa "第二维里系数";

      protected
        final constant Real[19] N = {0.118160747229, 0.713116392079, -0.161824192067E+001, 
          0.714140178971E-001, -0.865421396646E-001, 0.134211176704, 
          0.112626704218E-001, -0.420533228842E-001, 0.349008431982E-001, 
          0.164957183186E-003, -0.101365037912, -0.173813690970, -0.472103183731E-001, 
          -0.122523554253E-001, -0.146629609713, -0.316055879821E-001, 
          0.233594806142E-003, 0.148287891978E-001, -0.938782884667E-002};
        final constant Integer[19] i = {1, 1, 1, 2, 3, 3, 4, 4, 4, 6, 1, 3, 5, 6, 1, 3, 11, 1, 3};
        final constant Real[19] j = {0, 0.33, 1.01, 0, 0, 0.15, 0, 0.2, 0.35, 1.35, 1.6, 0.8, 
          0.95, 1.25, 3.6, 6, 3.25, 3.5, 15};
        Real tau = ReferenceAir.Air_Utilities.Basic.Constants.Tred / T;
        annotation();

      algorithm
        baa := 0;
        for k in 1:19 loop
          baa := if (i[k] == 1) then baa + N[k] * tau ^ j[k] else baa;
        end for;
        baa := 1 / ReferenceAir.Air_Utilities.Basic.Constants.rhored * baa;

      end Baa_dT;

      function Baw_dT "第二摩尔交维里 (cross-virial) 系数"
        extends Modelica.Icons.Function;

        input SI.Density d "密度";
        input SI.Temperature T "温度";
        output SI.MolarVolume baw 
          "第二交维里系数";

      protected
        final constant Real[3] a = {0.665687E+002, -0.238834E+003, -0.176755E+003};
        final constant Real[3] b = {-0.237, -1.048, -3.183};

        Real theta;
        annotation();

      algorithm
        baw := 0;
        theta := T / 100;
        for k in 1:3 loop
          baw := baw + a[k] * theta ^ b[k];
        end for;
        baw := baw * 1E-006;
      end Baw_dT;

      function Bww_dT "水的第二摩尔维里系数"
        extends Modelica.Icons.Function;

        input SI.Density d "密度";
        input SI.Temperature T "温度";
        output SI.MolarVolume bww "第二维里系数";

      protected
        final constant Real[56] N = {0.12533547935523E-001, 0.78957634722828E+001, 
          -0.87803203303561E+001, 0.31802509345418, -0.26145533859358, -0.78199751687981E-002, 
          0.88089493102134E-002, -0.66856572307965, 0.20433810950965, -0.66212605039687E-004, 
          -0.19232721156002, -0.25709043003438, 0.16074868486251, -0.40092828925807E-001, 
          0.39343422603254E-006, -0.75941377088144E-005, 0.56250979351888E-003, 
          -0.15608652257135E-004, 0.11537996422951E-008, 0.36582165144204E-006, 
          -0.13251180074668E-011, -0.62639586912454E-009, -0.10793600908932, 
          0.17611491008752E-001, 0.22132295167546, -0.40247669763528, 
          0.58083399985759, 0.49969146990806E-002, -0.31358700712549E-001, -0.74315929710341, 
          0.4780732991548, 0.20527940895948E-001, -0.13636435110343, 
          0.14180634400617E-001, 0.83326504880713E-002, -0.29052336009585E-001, 
          0.38615085574206E-001, -0.20393486513704E-001, -0.16554050063734E-002, 
          0.19955571979541E-002, 0.15870308324157E-003, -0.1638856834253E-004, 
          0.43613615723811E-001, 0.34994005463765E-001, -0.76788197844621E-001, 
          0.22446277332006E-001, -0.62689710414685E-004, -0.55711118565645E-009, 
          -0.19905718354408, 0.31777497330738, -0.11841182425981, -0.31306260323435E+002, 
          0.31546140237781E+002, -0.25213154341695E+004, -0.14874640856724, 
          0.31806110878444};
        final constant Integer[51] c = {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
          1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 4, 6, 6, 6, 6};
        final constant Integer[54] dd = {1, 1, 1, 2, 2, 3, 4, 1, 1, 1, 2, 2, 3, 4, 4, 5, 7, 9, 10, 
          11, 13, 15, 1, 2, 2, 2, 3, 4, 4, 4, 5, 6, 6, 7, 9, 9, 9, 9, 9, 10, 10, 12, 3, 4, 4, 5, 14, 3, 6, 
          6, 6, 3, 3, 3};
        final constant Real[54] t = {-0.5, 0.875, 1.0, 0.5, 0.75, 0.375, 1.0, 4.0, 6.0, 
          12.0, 1.0, 5.0, 4.0, 2.0, 13.0, 9.0, 3.0, 4.0, 11.0, 4.0, 13.0, 1.0, 7.0, 1.0, 9.0, 
          10.0, 10.0, 3.0, 7.0, 10.0, 10.0, 6.0, 10.0, 10.0, 1.0, 2.0, 3.0, 4.0, 8.0, 6.0, 
          9.0, 8.0, 16.0, 22.0, 23.0, 23.0, 10.0, 50.0, 44.0, 46.0, 50.0, 0.0, 1.0, 4.0};
        final constant Integer[54] alpha = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20, 
          20, 20};
        final constant Real[56] beta = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 150, 150, 250, 0.3, 0.3};
        final constant Real[54] gamma = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.21, 1.21, 1.25};
        final constant Integer[54] epsilon = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 
          1, 1};
        final constant Real[56] a = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.5, 3.5};
        final constant Real[56] b = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.85, 0.95};
        final constant Real[56] AA = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.32, 0.32};
        final constant Real[56] BB = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2};
        final constant Integer[56] CC = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
          28, 32};
        final constant Integer[56] DD = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
          700, 800};

        Real Delta55 = 0;
        Real Delta56 = 0;
        Real theta55 = 0;
        Real theta56 = 0;
        Real psi55 = 0;
        Real psi56 = 0;
        Real Delta55delta = 0;
        Real Delta56delta = 0;
        Real Deltab55delta = 0;
        Real Deltab56delta = 0;
        Real psi55delta = 0;
        Real psi56delta = 0;

        Real tau = Water95_Utilities.Constants.Tred / T;
        annotation();

      algorithm
        bww := 0;
        theta55 := (1 - tau) + AA[55];
        theta56 := (1 - tau) + AA[56];
        psi55 := exp(-CC[55] - DD[55] * (tau - 1) ^ 2);
        psi56 := exp(-CC[56] - DD[56] * (tau - 1) ^ 2);
        Delta55 := theta55 ^ 2 + BB[55];
        Delta56 := theta56 ^ 2 + BB[56];
        Delta55delta := -(AA[55] * theta55 * 2 / beta[55] + 2 * BB[55] * a[55]);
        Delta56delta := -(AA[56] * theta56 * 2 / beta[56] + 2 * BB[56] * a[56]);
        Deltab55delta := b[55] * Delta55 ^ (b[55] - 1) * Delta55delta;
        Deltab56delta := b[56] * Delta56 ^ (b[56] - 1) * Delta56delta;
        psi55delta := 2 * CC[55] * psi55;
        psi56delta := 2 * CC[56] * psi56;

        for k in 1:7 loop
          bww := if (dd[k] == 1) then bww + N[k] * tau ^ t[k] else bww;
        end for;
        for k in 8:51 loop
          bww := if (dd[k] == 1) then bww + N[k] * tau ^ t[k] * dd[k] else bww;
        end for;
        for k in 52:54 loop
          bww := if (dd[k] == 1) then bww + N[k] * tau ^ t[k] * exp(-alpha[k] * epsilon[
            k] ^ 2 - beta[k] * (tau - gamma[k]) ^ 2) else bww;
        end for;
        bww := (bww + N[55] * Delta55 ^ b[55] * psi55 + N[56] * Delta56 ^ b[56] * psi56) / 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.Constants.rhored 
          * Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.Constants.MM;
      end Bww_dT;

      function Caaa_dT "干空气的第三摩尔维里系数"
        extends Modelica.Icons.Function;

        input SI.Density d "密度";
        input SI.Temperature T "温度";
        output SI.MolarVolume caaa "第三维里系数";

      protected
        final constant Real[19] N = {0.118160747229, 0.713116392079, -0.161824192067E+001, 
          0.714140178971E-001, -0.865421396646E-001, 0.134211176704, 
          0.112626704218E-001, -0.420533228842E-001, 0.349008431982E-001, 
          0.164957183186E-003, -0.101365037912, -0.173813690970, -0.472103183731E-001, 
          -0.122523554253E-001, -0.146629609713, -0.316055879821E-001, 
          0.233594806142E-003, 0.148287891978E-001, -0.938782884667E-002};
        final constant Integer[19] i = {1, 1, 1, 2, 3, 3, 4, 4, 4, 6, 1, 3, 5, 6, 1, 3, 11, 1, 3};
        final constant Real[19] j = {0, 0.33, 1.01, 0, 0, 0.15, 0, 0.2, 0.35, 1.35, 1.6, 0.8, 
          0.95, 1.25, 3.6, 6, 3.25, 3.5, 15};
        final constant Integer[19] l = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 3, 3};
        Real tau = ReferenceAir.Air_Utilities.Basic.Constants.Tred / T;
        annotation();

      algorithm
        caaa := 0;
        for k in 1:10 loop
          caaa := if (i[k] == 2) then caaa + 2 * N[k] * tau ^ j[k] else caaa;
        end for;
        for k in 11:19 loop
          caaa := if (i[k] == 2) then caaa + 2 * N[k] * tau ^ j[k] else if ((i[k] == 1) 
            and (l[k] == 1)) then caaa - 2 * N[k] * tau ^ j[k] else caaa;
        end for;
        caaa := 1 / ReferenceAir.Air_Utilities.Basic.Constants.rhored ^ 2 * caaa;
      end Caaa_dT;

      function Caaw_dT "第三摩尔交维里 (cross-virial) 系数"
        extends Modelica.Icons.Function;

        input SI.Density d "密度";
        input SI.Temperature T "温度";
        output Real caaw "第三交维里系数";

      protected
        final constant Real[5] c = {0.482737E+003, 0.105678E+006, -0.656394E+008, 
          0.294442E+011, -0.319317E+013};

        Real theta = T;
        annotation();

      algorithm
        caaw := 0;
        for k in 1:5 loop
          caaw := caaw + c[k] * theta ^ (1 - k);
        end for;
        caaw := caaw * 1E-012;

      end Caaw_dT;

      function Caww_dT "第三摩尔交维里 (cross-virial) 系数"
        extends Modelica.Icons.Function;

        input SI.Density d "密度";
        input SI.Temperature T "温度";
        output Real caww "第三交维里系数";

      protected
        final constant Real[4] dd = {-0.1072887E+002, 0.347804E+004, -0.383383E+006, 
          0.33406E+008};

        Real theta = T;
        annotation();

      algorithm
        caww := 0;
        for k in 1:4 loop
          caww := caww + dd[k] * theta ^ (1 - k);
        end for;
        caww := -exp(caww) * 1E-012;

      end Caww_dT;

      function Cwww_dT "水的第三摩尔维里系数"
        extends Modelica.Icons.Function;

        input SI.Density d "密度";
        input SI.Temperature T "温度";
        output SI.MolarVolume cwww "第三维里系数";

      protected
        final constant Real[56] N = {0.12533547935523E-001, 0.78957634722828E+001, 
          -0.87803203303561E+001, 0.31802509345418, -0.26145533859358, -0.78199751687981E-002, 
          0.88089493102134E-002, -0.66856572307965, 0.20433810950965, -0.66212605039687E-004, 
          -0.19232721156002, -0.25709043003438, 0.16074868486251, -0.40092828925807E-001, 
          0.39343422603254E-006, -0.75941377088144E-005, 0.56250979351888E-003, 
          -0.15608652257135E-004, 0.11537996422951E-008, 0.36582165144204E-006, 
          -0.13251180074668E-011, -0.62639586912454E-009, -0.10793600908932, 
          0.17611491008752E-001, 0.22132295167546, -0.40247669763528, 
          0.58083399985759, 0.49969146990806E-002, -0.31358700712549E-001, -0.74315929710341, 
          0.4780732991548, 0.20527940895948E-001, -0.13636435110343, 
          0.14180634400617E-001, 0.83326504880713E-002, -0.29052336009585E-001, 
          0.38615085574206E-001, -0.20393486513704E-001, -0.16554050063734E-002, 
          0.19955571979541E-002, 0.15870308324157E-003, -0.1638856834253E-004, 
          0.43613615723811E-001, 0.34994005463765E-001, -0.76788197844621E-001, 
          0.22446277332006E-001, -0.62689710414685E-004, -0.55711118565645E-009, 
          -0.19905718354408, 0.31777497330738, -0.11841182425981, -0.31306260323435E+002, 
          0.31546140237781E+002, -0.25213154341695E+004, -0.14874640856724, 
          0.31806110878444};
        final constant Integer[51] c = {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
          1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 4, 6, 6, 6, 6};
        final constant Integer[54] dd = {1, 1, 1, 2, 2, 3, 4, 1, 1, 1, 2, 2, 3, 4, 4, 5, 7, 9, 10, 
          11, 13, 15, 1, 2, 2, 2, 3, 4, 4, 4, 5, 6, 6, 7, 9, 9, 9, 9, 9, 10, 10, 12, 3, 4, 4, 5, 14, 3, 6, 
          6, 6, 3, 3, 3};
        final constant Real[54] t = {-0.5, 0.875, 1.0, 0.5, 0.75, 0.375, 1.0, 4.0, 6.0, 
          12.0, 1.0, 5.0, 4.0, 2.0, 13.0, 9.0, 3.0, 4.0, 11.0, 4.0, 13.0, 1.0, 7.0, 1.0, 9.0, 
          10.0, 10.0, 3.0, 7.0, 10.0, 10.0, 6.0, 10.0, 10.0, 1.0, 2.0, 3.0, 4.0, 8.0, 6.0, 
          9.0, 8.0, 16.0, 22.0, 23.0, 23.0, 10.0, 50.0, 44.0, 46.0, 50.0, 0.0, 1.0, 4.0};
        final constant Integer[54] alpha = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20, 
          20, 20};
        final constant Real[56] beta = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 150, 150, 250, 0.3, 0.3};
        final constant Real[54] gamma = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.21, 1.21, 1.25};
        final constant Integer[54] epsilon = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 
          1, 1};
        final constant Real[56] a = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.5, 3.5};
        final constant Real[56] b = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.85, 0.95};
        final constant Real[56] AA = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.32, 0.32};
        final constant Real[56] BB = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2};
        final constant Integer[56] CC = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
          28, 32};
        final constant Integer[56] DD = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
          700, 800};

        Real Delta55 = 0;
        Real Delta56 = 0;
        Real theta55 = 0;
        Real theta56 = 0;
        Real psi55 = 0;
        Real psi56 = 0;
        Real Delta55delta = 0;
        Real Delta56delta = 0;
        Real Deltab55delta = 0;
        Real Deltab56delta = 0;
        Real psi55delta = 0;
        Real psi56delta = 0;
        Real Delta55deltadelta = 0;
        Real Delta56deltadelta = 0;
        Real Deltab55deltadelta = 0;
        Real Deltab56deltadelta = 0;
        Real psi55deltadelta = 0;
        Real psi56deltadelta = 0;

        Real tau = Water95_Utilities.Constants.Tred / T;
        annotation();

      algorithm
        cwww := 0;
        theta55 := (1 - tau) + AA[55];
        theta56 := (1 - tau) + AA[56];
        psi55 := exp(-CC[55] - DD[55] * (tau - 1) ^ 2);
        psi56 := exp(-CC[56] - DD[56] * (tau - 1) ^ 2);
        Delta55 := theta55 ^ 2 + BB[55];
        Delta56 := theta56 ^ 2 + BB[56];
        Delta55delta := -(AA[55] * theta55 * 2 / beta[55] + 2 * BB[55] * a[55]);
        Delta56delta := -(AA[56] * theta56 * 2 / beta[56] + 2 * BB[56] * a[56]);
        Deltab55delta := b[55] * Delta55 ^ (b[55] - 1) * Delta55delta;
        Deltab56delta := b[56] * Delta56 ^ (b[56] - 1) * Delta56delta;
        psi55delta := 2 * CC[55] * psi55;
        psi56delta := 2 * CC[56] * psi56;
        Delta55deltadelta := -Delta55delta + AA[55] ^ 2 * 2 / beta[55] ^ 2 + AA[55] * 
          theta55 * 4 / beta[55] * (1 / (2 * beta[55]) - 1) + 4 * BB[55] * a[55] * (a[55] - 1);
        Delta56deltadelta := -Delta56delta + AA[56] ^ 2 * 2 / beta[56] ^ 2 + AA[56] * 
          theta56 * 4 / beta[56] * (1 / (2 * beta[56]) - 1) + 4 * BB[56] * a[56] * (a[56] - 1);
        Deltab55deltadelta := b[55] * (Delta55 ^ (b[55] - 1) * Delta55deltadelta + (b[
          55] - 1) * Delta55 ^ (b[55] - 2) * Delta55delta ^ 2);
        Deltab56deltadelta := b[56] * (Delta56 ^ (b[56] - 1) * Delta56deltadelta + (b[
          56] - 1) * Delta56 ^ (b[56] - 2) * Delta56delta ^ 2);
        psi55deltadelta := (2 * CC[55] - 1) * 2 * CC[55] * psi55;
        psi56deltadelta := (2 * CC[56] - 1) * 2 * CC[56] * psi56;

        cwww := 0;
        for k in 1:7 loop
          cwww := if (dd[k] == 2) then cwww + 2 * N[k] * tau ^ t[k] else cwww;
        end for;
        for k in 8:51 loop
          cwww := if (dd[k] == 2) then cwww + 2 * N[k] * tau ^ t[k] else if ((dd[k] 
            == 1) and (c[k] == 1)) then cwww - 2 * N[k] * tau ^ t[k] else cwww;
        end for;
        cwww := cwww + N[55] * (Delta55 ^ b[55] * 2 * psi55delta + 2 * Deltab55delta * 
          psi55) + N[56] * (Delta56 ^ b[56] * 2 * psi56delta + 2 * Deltab56delta * psi56);
        cwww := Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.Constants.MM 
          ^ 2 / Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.Constants.rhored 
          ^ 2 * cwww * 1E-006;
      end Cwww_dT;
      annotation();
    end VirialCoefficients;

    package ReactionIndices 
      "用于确定反应变量（分解 VDI 4670）的参数和方程"
      extends Modelica.Icons.BasesPackage;

      final constant Real[6] AA = {20413.2, 1075.5, 165.95, 1491.75, 3235.34, 4.5542};
      final constant SI.Temperature[6] BB = {-33086.5, -30283.3, -19526.8, 
        -27488.0, -30807.8, -10973.6};
      final constant SI.MolarHeatCapacity[6] CC = {-19.5, -65.2, -18.7, 
        -3.6, -21.8, -5.6};
      final constant SI.MolarInternalEnergy[6] DD = {-1.15E+005, 
        3.03E+005, 5.72E+004, 3.93E+005, 1.5E+005, 1.62E+004};
      final constant Real[6] EE(each unit = "J.K/mol") = {9.483E+009, 7.277E+009, 
        3.136E+009, 5.826E+009, 7.659E+009, 9.94E+008};
      final constant SI.AbsolutePressure p0 = 101325 
        "参考压力";

      function U2 "生成 H2 的反应指数"
        extends Modelica.Icons.Function;
        input SI.AbsolutePressure p "压力";
        input SI.Temperature T "温度";
        input SI.MoleFraction[4] moleFraction "摩尔分数";
        output Real u "H2 的反应指数";
      algorithm
        u := AA[2] * moleFraction[1] / sqrt(moleFraction[3]) * (p / p0) ^ (-0.5) * 
          Modelica.Math.exp(BB[2] / T);
        annotation(
          derivative = U2_der, 
          Inline = false, 
          LateInline = true);
      end U2;

      function U3 "生成 OH 的反应指数"
        extends Modelica.Icons.Function;
        input SI.AbsolutePressure p "压力";
        input SI.Temperature T "温度";
        input SI.MoleFraction[4] moleFraction "摩尔分数";
        output Real u "OH 的反应指数";
      algorithm
        u := AA[3] * sqrt(moleFraction[1]) * sqrt(sqrt(moleFraction[3])) * (p / p0) ^ (-0.25) 
          * Modelica.Math.exp(BB[3] / T);
        annotation(
          derivative = U3_der, 
          Inline = false, 
          LateInline = true);
      end U3;

      function U4 "生成 H 的反应指数"
        extends Modelica.Icons.Function;
        input SI.AbsolutePressure p "压力";
        input SI.Temperature T "温度";
        input SI.MoleFraction[4] moleFraction "摩尔分数";
        output Real u "H 的反应指数";
      algorithm
        u := AA[4] * sqrt(U2(
          p, 
          T, 
          moleFraction)) * (p / p0) ^ (-0.5) * Modelica.Math.exp(BB[4] / T);
        annotation(
          derivative = U4_der, 
          Inline = false, 
          LateInline = true);
      end U4;

      function U5 "生成 O 的反应指数"
        extends Modelica.Icons.Function;
        input SI.AbsolutePressure p "压力";
        input SI.Temperature T "温度";
        input SI.MoleFraction[4] moleFraction "摩尔分数";
        output Real u "O 的反应指数";
      algorithm
        u := AA[5] * sqrt(moleFraction[3]) * (p / p0) ^ (-0.5) * Modelica.Math.exp(BB[5] / 
          T);
        annotation(
          derivative = U5_der, 
          Inline = false, 
          LateInline = true);
      end U5;

      function U6 "生成 NO 的反应指数"
        extends Modelica.Icons.Function;
        input SI.AbsolutePressure p "压力";
        input SI.Temperature T "温度";
        input SI.MoleFraction[4] moleFraction "摩尔分数";
        output Real u "NO 的反应指数";
      algorithm
        u := AA[6] * sqrt(moleFraction[2] * moleFraction[3]) * Modelica.Math.exp(BB[6] 
          / T);
        annotation(
          derivative = U6_der, 
          Inline = false, 
          LateInline = true);
      end U6;

      function V2 "生成 H2 的能量指数"
        extends Modelica.Icons.Function;
        input SI.Temperature T "温度";
        output SI.MolarHeatCapacity v "H2 的能量指数";
      algorithm
        v := CC[2] + DD[2] / T + EE[2] / T ^ 2;
        annotation(
          derivative = V2_der, 
          Inline = false, 
          LateInline = true);
      end V2;

      function V3 "生成 OH 的能量指数"
        extends Modelica.Icons.Function;
        input SI.Temperature T "温度";
        output SI.MolarHeatCapacity v "OH 的能量指数";
      algorithm
        v := CC[3] + DD[3] / T + EE[3] / T ^ 2;
        annotation(
          derivative = V3_der, 
          Inline = false, 
          LateInline = true);
      end V3;

      function V4 "生成 H 的能量指数"
        extends Modelica.Icons.Function;
        input SI.Temperature T "温度";
        output SI.MolarHeatCapacity v "H 的能量指数";
      algorithm
        v := CC[4] + DD[4] / T + EE[4] / T ^ 2;
        annotation(
          derivative = V4_der, 
          Inline = false, 
          LateInline = true);
      end V4;

      function V5 "生成 O 的能量指数"
        extends Modelica.Icons.Function;
        input SI.Temperature T "温度";
        output SI.MolarHeatCapacity v "O 的能量指数";
      algorithm
        v := CC[5] + DD[5] / T + EE[5] / T ^ 2;
        annotation(
          derivative = V5_der, 
          Inline = false, 
          LateInline = true);
      end V5;

      function V6 "生成 NO 的能量指数"
        extends Modelica.Icons.Function;
        input SI.Temperature T "温度";
        output SI.MolarHeatCapacity v "NO 的能量指数";
      algorithm
        v := CC[6] + DD[6] / T + EE[6] / T ^ 2;
        annotation(
          derivative = V6_der, 
          Inline = false, 
          LateInline = true);
      end V6;

      function U2_der "生成 H2 反应指数的导数"
        extends Modelica.Icons.Function;
        input SI.AbsolutePressure p "压力";
        input SI.Temperature T "温度";
        input SI.MoleFraction[4] moleFraction "摩尔分数";
        input Real p_der "压力的导数";
        input Real T_der "温度的导数";
        input Real[4] moleFraction_der "摩尔分数的导数";
        output Real u_der "H2 的反应指数的导数";

      protected
        Real o[4];
        annotation();
      algorithm
        o[1] := AA[2] * sqrt(moleFraction[3]) * (p / p0) ^ (-0.5) * Modelica.Math.exp(BB[
          2] / T);
        o[2] := -0.5 * AA[2] * moleFraction[1] / (moleFraction[3]) ^ 1.5 * (p / p0) ^ (-0.5) * 
          Modelica.Math.exp(BB[2] / T);
        o[3] := -0.5 * AA[2] * moleFraction[1] / sqrt(moleFraction[3]) * sqrt(p0) * p ^ (-1.5) 
          * Modelica.Math.exp(BB[2] / T);
        o[4] := -BB[2] * AA[2] * moleFraction[1] / sqrt(moleFraction[3]) * (p / p0) ^ (-0.5) 
          * Modelica.Math.exp(BB[2] / T) / T ^ 2;
        u_der := o[1] * moleFraction_der[1] + o[2] * moleFraction_der[3] + o[3] * 
          p_der + o[4] * T_der;

      end U2_der;

      function U3_der "生成 OH 反应指数的导数"
        extends Modelica.Icons.Function;
        input SI.AbsolutePressure p "压力";
        input SI.Temperature T "温度";
        input SI.MoleFraction[4] moleFraction "摩尔分数";
        input Real p_der "压力的导数";
        input Real T_der "温度的导数";
        input Real[4] moleFraction_der "摩尔分数的导数";
        output Real u_der "OH 的反应指数的导数";
      protected
        Real o[4];
        annotation();
      algorithm
        o[1] := 0.5 * AA[3] / sqrt(moleFraction[1]) * sqrt(sqrt(moleFraction[3])) * (p / 
          p0) ^ (-0.25) * Modelica.Math.exp(BB[3] / T);
        o[2] := 0.25 * AA[3] * sqrt(moleFraction[1]) / (moleFraction[3]) ^ 0.75 * (p / p0) ^ 
          (-0.25) * Modelica.Math.exp(BB[3] / T);
        o[3] := -0.25 * AA[3] * sqrt(moleFraction[1]) * sqrt(sqrt(moleFraction[3])) * 
          sqrt(sqrt(p0)) * p ^ (-1.25) * Modelica.Math.exp(BB[3] / T);
        o[4] := BB[3] * AA[3] * moleFraction[1] / sqrt(sqrt(moleFraction[3])) * (p / p0) ^ 
          (-0.25) * Modelica.Math.exp(BB[3] / T) / T ^ 2;
        u_der := o[1] * moleFraction_der[1] + o[2] * moleFraction_der[3] + o[3] * 
          p_der + o[4] * T_der;

      end U3_der;

      function U4_der "生成 H 反应指数的导数"
        extends Modelica.Icons.Function;
        input SI.AbsolutePressure p "压力";
        input SI.Temperature T "温度";
        input SI.MoleFraction[4] moleFraction "摩尔分数";
        input Real p_der "压力的导数";
        input Real T_der "温度的导数";
        input Real[4] moleFraction_der "摩尔分数的导数";
        output Real u_der "H 的反应指数的导数";
      protected
        Real o[3];
        annotation();
      algorithm
        o[1] := 0.5 * AA[4] / sqrt(U2(
          p, 
          T, 
          moleFraction)) * U2_der(
          p, 
          T, 
          moleFraction, 
          p_der, 
          T_der, 
          moleFraction_der) * (p / p0) ^ (-0.5) * Modelica.Math.exp(BB[4] / T);
        o[2] := -0.5 * AA[4] * sqrt(U2(
          p, 
          T, 
          moleFraction)) * sqrt(p0) * p ^ (-1.5) * Modelica.Math.exp(BB[4] / T);
        o[3] := BB[4] * AA[4] * sqrt(U2(
          p, 
          T, 
          moleFraction)) * (p / p0) ^ (-0.5) * Modelica.Math.exp(BB[4] / T) / T ^ 2;
        u_der := o[1] + o[2] * p_der + o[3] * T_der;

      end U4_der;

      function U5_der "生成 O 反应指数的导数"
        extends Modelica.Icons.Function;
        input SI.AbsolutePressure p "压力";
        input SI.Temperature T "温度";
        input SI.MoleFraction[4] moleFraction "摩尔分数";
        input Real p_der "压力的导数";
        input Real T_der "温度的导数";
        input Real[4] moleFraction_der "摩尔分数的导数";
        output Real u_der "O 的反应指数的导数";
      protected
        Real o[3];
        annotation();
      algorithm
        o[1] := 0.5 * AA[5] / sqrt(moleFraction[3]) * (p / p0) ^ (-0.5) * Modelica.Math.exp(
          BB[5] / T);
        o[2] := -0.5 * AA[5] * sqrt(moleFraction[3]) * sqrt(p0) * p ^ (-1.5) * 
          Modelica.Math.exp(BB[5] / T);
        o[3] := BB[5] * AA[5] * sqrt(moleFraction[3]) * (p / p0) ^ (-0.5) * 
          Modelica.Math.exp(BB[5] / T) / T ^ 2;
        u_der := o[1] * moleFraction[3] + o[2] * p_der + o[3] * T_der;
      end U5_der;

      function U6_der "生成 NO 反应指数的导数"
        extends Modelica.Icons.Function;
        input SI.AbsolutePressure p "压力";
        input SI.Temperature T "温度";
        input SI.MoleFraction[4] moleFraction "摩尔分数";
        input Real p_der "压力的导数";
        input Real T_der "温度的导数";
        input Real[4] moleFraction_der "摩尔分数的导数";
        output Real u_der "NO 的反应指数的导数";
      protected
        Real o[3];
        annotation();
      algorithm
        o[1] := 0.5 * AA[6] / sqrt(moleFraction[2] * moleFraction[3]) * moleFraction[3] 
          * Modelica.Math.exp(BB[6] / T);
        o[2] := 0.5 * AA[6] / sqrt(moleFraction[2] * moleFraction[3]) * moleFraction[2] 
          * Modelica.Math.exp(BB[6] / T);
        o[3] := BB[6] * AA[6] * sqrt(moleFraction[2] * moleFraction[3]) * 
          Modelica.Math.exp(BB[6] / T) / T ^ 2;
        u_der := o[1] * moleFraction[2] + o[2] * moleFraction[3] + o[3] * T_der;
      end U6_der;

      function V2_der "生成 H2 能量指数的导数"
        extends Modelica.Icons.Function;
        input SI.Temperature T "温度";
        input Real T_der "温度的导数";
        output Real v_der "H2 的能量指数的导数";
        annotation();
      algorithm
        v_der := (-DD[2] / T ^ 2 - 2 * EE[2] / T ^ 3) * T_der;
      end V2_der;

      function V3_der "生成 OH 能量指数的导数"
        extends Modelica.Icons.Function;
        input SI.Temperature T "温度";
        input Real T_der "温度的导数";
        output Real v_der "OH 的能量指数的导数";
        annotation();
      algorithm
        v_der := (-DD[3] / T ^ 2 - 2 * EE[3] / T ^ 3) * T_der;
      end V3_der;

      function V4_der "生成 H 能量指数的导数"
        extends Modelica.Icons.Function;
        input SI.Temperature T "温度";
        input Real T_der "温度的导数";
        output Real v_der "H 的能量指数的导数";
        annotation();
      algorithm
        v_der := (-DD[4] / T ^ 2 - 2 * EE[4] / T ^ 3) * T_der;
      end V4_der;

      function V5_der "生成 O 能量指数的导数"
        extends Modelica.Icons.Function;
        input SI.Temperature T "温度";
        input Real T_der "温度的导数";
        output Real v_der "O 的能量指数的导数";
        annotation();
      algorithm
        v_der := (-DD[5] / T ^ 2 - 2 * EE[5] / T ^ 3) * T_der;
      end V5_der;

      function V6_der "生成 NO 能量指数的导数"
        extends Modelica.Icons.Function;
        input SI.Temperature T "温度";
        input Real T_der "温度的导数";
        output Real v_der "NO 的能量指数的导数";
        annotation();
      algorithm
        v_der := (-DD[6] / T ^ 2 - 2 * EE[6] / T ^ 3) * T_der;
      end V6_der;
      annotation();
    end ReactionIndices;

    package IF97_new "规避区域有效性校验的针对IF97标准区域2的变通实现方案"
      extends Modelica.Icons.BasesPackage;

      final constant MolarMass molarMass = 0.018015257;

      function g2 = Modelica.Media.Water.IF97_Utilities.BaseIF97.Basic.g2(
        final checkLimits = false) 
        "区域2的吉布斯函数: g(p,T)" annotation();

      function h_pT "作为压力和温度函数的比焓"
        extends Modelica.Icons.Function;
        input SI.Pressure p "压力";
        input SI.Temperature T "温度";
        input Integer region = 0 
          "如果为 0，则区域未知，否则已知并且此输入未使用";
        output SI.SpecificEnthalpy h "比焓";
      protected
        Modelica.Media.Common.GibbsDerivs g;
      algorithm
        g := Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.g2(p, T);
        h := g.R_s * T * g.tau * g.gtau;
        annotation(
          derivative(noDerivative = region) = h_pT_der, 
          Inline = false, 
          LateInline = true);
      end h_pT;

      function s_pT "区域 2 中压力和温度的函数温度"
        extends Modelica.Icons.Function;
        input SI.Pressure p "压力";
        input SI.Temperature T "温度";
        input Integer region = 0 
          "如果为 0，则区域未知，否则已知并且此输入未使用";
        output SI.SpecificEntropy s "比熵";
      protected
        Modelica.Media.Common.GibbsDerivs g;
        annotation();
      algorithm
        g := Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.g2(p, T);
        s := g.R_s * (g.tau * g.gtau - g.g);
      end s_pT;

      function cp_pT 
        "区域 2 中定压比热容的压力和温度函数"
        extends Modelica.Icons.Function;
        input SI.Pressure p "压力";
        input SI.Temperature T "温度";
        input Integer region = 0 
          "如果为 0，则区域未知，否则已知并且此输入未使用";
        output SI.SpecificHeatCapacity cp 
          "定压比热容";
      protected
        Modelica.Media.Common.GibbsDerivs g;
        annotation();
      algorithm
        g := Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.g2(p, T);
        cp := -g.R_s * g.tau * g.tau * g.gtautau;
      end cp_pT;

      function cv_pT 
        "区域 2 中定容比热容的压力和温度函数"
        extends Modelica.Icons.Function;
        input SI.Pressure p "压力";
        input SI.Temperature T "温度";
        input Integer region = 0 
          "如果为 0，则区域未知，否则已知并且此输入未使用";
        output SI.SpecificHeatCapacity cv 
          "定容比热容";
      protected
        Modelica.Media.Common.GibbsDerivs g;
        annotation();
      algorithm
        g := Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.g2(p, T);
        cv := g.R_s * (-g.tau * g.tau * g.gtautau + ((g.gpi - g.tau * g.gtaupi) * (g.gpi - 
          g.tau * g.gtaupi) / g.gpipi));
      end cv_pT;

      function rho_pT "作为压力和温度函数的密度"
        extends Modelica.Icons.Function;
        input SI.Pressure p "压力";
        input SI.Temperature T "温度";
        output SI.Density rho "密度";
      protected
        Modelica.Media.Common.GibbsDerivs g;
      algorithm
        g := Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.g2(p, T);
        rho := p / (g.R_s * T * g.pi * g.gpi);
        annotation(
          derivative = rho_pT_der, 
          Inline = false, 
          LateInline = true);
      end rho_pT;

      function rho_pT_der "区域 2 的 rho_pT 的导数函数"
        extends Modelica.Icons.Function;
        input SI.Pressure p "压力";
        input SI.Temperature T "温度";
        input Real p_der "压力的导数";
        input Real T_der "温度的导数";
        output Real rho_der "密度的导数";
      protected
        Modelica.Media.Common.GibbsDerivs g;
        SI.Density d;
        Real vp;
        Real vt;
        annotation();
      algorithm
        g := Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.g2(p, T);
        vt := g.R_s / p * (g.pi * g.gpi - g.tau * g.pi * g.gtaupi);
        vp := g.R_s * T / (p * p) * g.pi * g.pi * g.gpipi;
        d := p / (g.R_s * T * g.pi * g.gpi);
        rho_der := (-d ^ 2 * vp) * p_der + (-d ^ 2 * vt) * T_der;
      end rho_pT_der;

      function visc_dT = Modelica.Media.Water.IF97_Utilities.BaseIF97.Transport.visc_dTp(
        final p = 0, final phase = 0, final checkLimits = false) 
        "动力黏度 eta(d,T)，工业用" annotation();

      function cond_dT = Modelica.Media.Water.IF97_Utilities.BaseIF97.Transport.cond_dTp(
        final p = 0, final phase = 0, final industrialMethod = true, final checkLimits = false) 
        "导热系数 lam(d,T)，工业用" annotation();

      function h_pT_der "区域 2 的 h_pT 的导数函数"
        extends Modelica.Icons.Function;
        input SI.Pressure p "压力";
        input SI.Temperature T "温度";
        input Integer region = 0 
          "如果为 0，则区域未知，否则已知并且此输入未使用";
        input Real p_der "压力的导数";
        input Real T_der "温度的导数";
        output Real h_der "比焓的导数";
      protected
        Modelica.Media.Common.GibbsDerivs g;
        SI.Density rho;
        Real vt;
        annotation();
      algorithm
        g := Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.g2(p, T);
        vt := g.R_s / p * (g.pi * g.gpi - g.tau * g.pi * g.gtaupi);
        rho := max(p / (g.R_s * T * g.pi * g.gpi), 1e-9);
        h_der := (1 / rho - T * vt) * p_der - g.R_s * g.tau * g.tau * g.gtautau * T_der;
      end h_pT_der;
      annotation(Documentation(info = "<html>
<p>
这是一个临时库，避免了 IF97 对于区域 2的公用函数
<a href=\"modelica://Modelica.Media.Water.IF97_Utilities.BaseIF97.Basic.g2\">BaseIF97.Basic.g2</a>,
<a href=\"modelica://Modelica.Media.Water.IF97_Utilities.BaseIF97.Transport.cond_dTp\">BaseIF97.Transport.cond_dTp</a> 和
<a href=\"modelica://Modelica.Media.Water.IF97_Utilities.BaseIF97.Transport.visc_dTp\">BaseIF97.Transport.visc_dTp</a>
的区域有效性检查。
</p>
</html>"          , revisions = "<html>
2020-01-08 Thomas Beutlich: 避免引入短类函数的代码重复。
</html>"          ));
    end IF97_new;

    package Water95_Utilities 
      "低于 273.15 K 时的 IAPWS95 公用函数"
      extends Modelica.Icons.BasesPackage;

      constant Common.FundamentalConstants Constants(
        R_bar = 8.314371, 
        R_s = 461.51805, 
        MM = 18.015268E-003, 
        rhored = 322, 
        Tred = 647.096, 
        pred = 22064000, 
        h_off = 0.0, 
        s_off = 0.0);

      constant Modelica.Media.Interfaces.Types.TwoPhase.FluidConstants 
        waterConstants(
        chemicalFormula = "H2O", 
        structureFormula = "H2O", 
        casRegistryNumber = "7732-18-5", 
        iupacName = "oxidane", 
        molarMass = 0.018015268, 
        criticalTemperature = 647.096, 
        criticalPressure = 22064.0e3, 
        criticalMolarVolume = 1 / 322.0 * 0.018015268, 
        triplePointTemperature = 273.16, 
        triplePointPressure = 611.657, 
        normalBoilingPoint = 373.124, 
        meltingPoint = 273.15, 
        acentricFactor = 0.344, 
        dipoleMoment = 1.8, 
        hasCriticalData = true, 
        hasIdealGasHeatCapacity = false, 
        hasDipoleMoment = true, 
        hasFundamentalEquation = true, 
        hasLiquidHeatCapacity = true, 
        hasSolidHeatCapacity = false, 
        hasAccurateViscosityData = true, 
        hasAccurateConductivityData = true, 
        hasVapourPressureCurve = false, 
        hasAcentricFactor = true, 
        HCRIT0 = 0.0, 
        SCRIT0 = 0.0, 
        deltah = 0.0, 
        deltas = 0.0);

      function psat "饱和压力"
        extends Modelica.Icons.Function;

        input SI.Temperature T "温度";
        output SI.AbsolutePressure p "压力";

      protected
        Real theta_s;
        Real A;
        Real B;
        Real C;
        final constant Real[10] n = {0.11670521452767E+004, -0.72421316703206E+006, 
          -0.17073846940092E+002, 0.1202082470247E+005, -0.32325550322333E+007, 
          0.1491510861353E+002, -0.48232657361591E+004, 0.40511340542057E+006, -0.23855557567849, 
          0.65017534844798E+003};
      algorithm
        theta_s := min(T, 553) + n[9] / (min(T, 553) - n[10]);
        A := theta_s ^ 2 + n[1] * theta_s + n[2];
        B := n[3] * theta_s ^ 2 + n[4] * theta_s + n[5];
        C := n[6] * theta_s ^ 2 + n[7] * theta_s + n[8];
        p := (2 * C / (-B + sqrt(B ^ 2 - 4 * A * C))) ^ 4 * 1E+006;
        annotation(
          derivative = psat_der, 
          Inline = false, 
          LateInline = true);
      end psat;

      function Tsat "饱和温度"
        extends Modelica.Icons.Function;

        input SI.AbsolutePressure p "压力";
        output SI.Temperature T "温度";

      protected
        Real beta;
        Real D;
        Real E;
        Real F;
        Real G;
        final constant Real[10] n = {0.11670521452767E+004, -0.72421316703206E+006, 
          -0.17073846940092E+002, 0.1202082470247E+005, -0.32325550322333E+007, 
          0.1491510861353E+002, -0.48232657361591E+004, 0.40511340542057E+006, -0.23855557567849, 
          0.65017534844798E+003};

      algorithm
        beta := (p * 1E-006) ^ 0.25;
        E := beta ^ 2 + n[3] * beta + n[6];
        F := n[1] * beta ^ 2 + n[4] * beta + n[7];
        G := n[2] * beta ^ 2 + n[5] * beta + n[8];
        D := 2 * G / (-F - sqrt(F ^ 2 - 4 * E * G));
        T := (n[10] + D - sqrt((n[10] + D) ^ 2 - 4 * (n[9] + n[10] * D))) / 2;
        annotation(
          derivative = Tsat_der, 
          Inline = false, 
          LateInline = true);
      end Tsat;

      function psat_der "饱和压力"
        extends Modelica.Icons.Function;

        input SI.Temperature T "温度";
        input Real T_der "温度的导数";
        output Real p_der "压力对于温度的导数";

      protected
        Real theta_s;
        Real theta_s_der;
        Real A;
        Real A_der;
        Real B;
        Real B_der;
        Real C;
        Real C_der;
        Real o_der[3];
        final constant Real[10] n = {0.11670521452767E+004, -0.72421316703206E+006, 
          -0.17073846940092E+002, 0.1202082470247E+005, -0.32325550322333E+007, 
          0.1491510861353E+002, -0.48232657361591E+004, 0.40511340542057E+006, -0.23855557567849, 
          0.65017534844798E+003};
        annotation();
      algorithm
        theta_s := min(T, 553) + n[9] / (min(T, 553) - n[10]);
        theta_s_der := (1 - n[9] / (min(T, 553) - n[10]) ^ 2);

        A := theta_s ^ 2 + n[1] * theta_s + n[2];
        B := n[3] * theta_s ^ 2 + n[4] * theta_s + n[5];
        C := n[6] * theta_s ^ 2 + n[7] * theta_s + n[8];
        A_der := 2 * theta_s * theta_s_der + n[1] * theta_s_der;
        B_der := 2 * n[3] * theta_s * theta_s_der + n[4] * theta_s_der;
        C_der := 2 * n[6] * theta_s * theta_s_der + n[7] * theta_s_der;
        o_der[1] := 2 * B * B_der - 4 * (A * C_der + A_der * C);
        o_der[2] := -B_der + 0.5 / sqrt(B ^ 2 - 4 * A * C) * o_der[1];
        o_der[3] := ((2 * C_der * (-B + sqrt(B ^ 2 - 4 * A * C))) - 2 * C * o_der[2]) / (-B + 
          sqrt(B ^ 2 - 4 * A * C)) ^ 2;

        p_der := 4 * ((2 * C / (-B + sqrt(B ^ 2 - 4 * A * C)))) ^ 3 * o_der[3] * 1E+006 * T_der;

      end psat_der;

      function Tsat_der "饱和温度的导数"
        extends Modelica.Icons.Function;

        input SI.AbsolutePressure p "压力";
        input Real p_der "压力导数";
        output Real T_der "温度导数";

      protected
        Real beta;
        Real beta_der;
        Real D;
        Real D_der;
        Real E;
        Real E_der;
        Real F;
        Real F_der;
        Real G;
        Real G_der;
        Real o_der[2];
        final constant Real[10] n = {0.11670521452767E+004, -0.72421316703206E+006, 
          -0.17073846940092E+002, 0.1202082470247E+005, -0.32325550322333E+007, 
          0.1491510861353E+002, -0.48232657361591E+004, 0.40511340542057E+006, -0.23855557567849, 
          0.65017534844798E+003};
        annotation();

      algorithm
        beta := (p * 1E-006) ^ 0.25;
        beta_der := 0.25 / (p * 1E-006) ^ 0.75 * 1E-006;
        E := beta ^ 2 + n[3] * beta + n[6];
        E_der := 2 * beta * beta_der + n[3];
        F := n[1] * beta ^ 2 + n[4] * beta + n[7];
        F_der := 2 * n[1] * beta * beta_der + n[4];
        G := n[2] * beta ^ 2 + n[5] * beta + n[8];
        G_der := 2 * n[2] * beta * beta_der + n[5];
        D := 2 * G / (-F - sqrt(F ^ 2 - 4 * E * G));
        o_der[1] := 2 * F * F_der - 4 * (E * G_der + E_der * G);
        o_der[2] := -F_der - 0.5 / sqrt(F ^ 2 - 4 * E * G) * o_der[1];
        D_der := ((2 * G_der * (-F - sqrt(F ^ 2 - 4 * E * G))) - 2 * G * o_der[2]) / (-F - sqrt(
          F ^ 2 - 4 * E * G)) ^ 2;
        T_der := (D_der - 0.5 / sqrt((n[10] + D) ^ 2 - 4 * (n[9] + n[10] * D)) * (2 * D * 
          D_der - 2 * n[10] * D_der)) / 2 * p_der;
      end Tsat_der;
      annotation();
    end Water95_Utilities;
    package Ice09_Utilities 
      "实现空气中冰相变计算所需的IAPWS09标准实用函数集"
      extends Modelica.Icons.BasesPackage;

      package Basic "基本状态方程"
        extends Modelica.Icons.BasesPackage;

        record IceConstants
          extends Common.FundamentalConstants;
          SI.AbsolutePressure p0;
          annotation();
        end IceConstants;

        constant IceConstants Constants(
          R_bar = 8.314472, 
          R_s = 461.52364, 
          MM = 18.015268E-003, 
          rhored = 1.0, 
          Tred = 273.16, 
          pred = 611.657, 
          p0 = 101325, 
          h_off = 0.0, 
          s_off = 0.0);

        function Gibbs "吉布斯状态方程"
          extends Modelica.Icons.Function;
          input SI.AbsolutePressure p "绝对压力";
          input SI.Temperature T "温度";
          output Common.GibbsDerivs2 g 
            "吉布斯函数及与 T 和 p 有关的导数";

        protected
          final constant Real[5] g_0 = {-0.632020233449497E+006, 0.655022213658955, 
            -0.189369929326131E-007, 0.339746123271053E-014, -0.556464869058991E-021} 
            "EOS 系数";
          final constant Real s_0 = -0.332733756492168E+004 "Coefficient of EOS";
          final Complex[2] t = {Complex(0.368017112855051E-001, 
            0.510878114959572E-001), Complex(0.337315741065416, 
            0.335449415919309)} "EOS 系数";
          final constant Complex r_1 = Complex(0.447050716285388E+002, 
            0.656876847463481E+002) "EOS 系数";
          final Complex[3] r_2 = {Complex(-0.725974574329220E+002, -0.781008427112870E+002), 
            Complex(-0.557107698030123E-004, 0.464578634580806E-004), 
            Complex(0.234801409215913E-010, -0.285651142904972E-010)} 
            "EOS 系数";
          final Real pi0 = Constants.p0 / Constants.pred "约简压力";

          //临时变量需要用于计算
          Real g0 = 0.0 "辅助变量";
          Real g0p = 0.0 "辅助变量";
          Real g0pp = 0.0 "辅助变量";
          Complex r2 "辅助变量";
          Complex r2p "辅助变量";
          Complex r2pp "辅助变量";
          Complex o[12] "辅助变量";
          annotation();

        algorithm
          g.p := p;
          g.T := T;
          g.R_s := Constants.R_s;

          //约简压力
          g.pi := g.p / Constants.pred;
          //约简温度
          g.theta := g.T / Constants.Tred;

          //计算临时值
          //0^0 可能会导致错误，因此我们必须使用一种解决方法
          g0 := g_0[1];
          for k in 2:5 loop
            g0 := g0 + g_0[k] * (g.pi - pi0) ^ (k - 1);
          end for;
          r2 := r_2[1];
          for k in 2:3 loop
            r2 := r2 + (r_2[k] * Complex((g.pi - pi0) ^ (k - 1)));
          end for;

          //g0 相对于 pi 的一阶导数
          g0p := g_0[2] / Constants.pred;
          for k in 3:5 loop
            g0p := g0p + g_0[k] * (k - 1) / Constants.pred * (g.pi - pi0) ^ (k - 2);
          end for;
          //r2 相对于 pi 的一阶导数
          r2p := (r_2[2] / Complex(Constants.pred)) + ((r_2[3] / Complex(Constants.pred / 2)) * Complex(g.pi - pi0));
          //g0 相对于 pi 的二阶导数
          g0pp := g_0[3] * 2 / Constants.pred ^ 2;
          for k in 4:5 loop
            g0pp := g0pp + g_0[k] * (k - 1) * (k - 2) / Constants.pred ^ 2 * (g.pi - pi0) ^ (k - 3);
          end for;
          //r2 相对于 pi 的二阶导数
          r2pp := r_2[3] * Complex(2 / Constants.pred ^ 2);

          o[1] := (t[1] - Complex(g.theta)) * Modelica.ComplexMath.log(t[1] - Complex(g.theta));
          o[2] := (t[1] + Complex(g.theta)) * Modelica.ComplexMath.log(t[1] + Complex(g.theta));
          o[3] := (t[2] - Complex(g.theta)) * Modelica.ComplexMath.log(t[2] - Complex(g.theta));
          o[4] := (t[2] + Complex(g.theta)) * Modelica.ComplexMath.log(t[2] + Complex(g.theta));
          o[5] := (Complex(2) * t[1]) * Modelica.ComplexMath.log(t[1]);
          o[6] := (Complex(2) * t[2]) * Modelica.ComplexMath.log(t[2]);
          o[7] := Complex(g.theta ^ 2) / t[1];
          o[8] := Complex(g.theta ^ 2) / t[2];
          o[9] := o[1] + o[2] - o[5] - o[7];
          o[10] := o[3] + o[4] - o[6] - o[8];

          //   //吉布斯方程
          //   g.g := g0 - s_0*Constants.Tred
          //     *g.theta + Constants.Tred
          //     *GibbsComplex.fromReal(r_1*((t[1] - g.theta)*GibbsComplexMath.log(t[1] - g.theta)
          //      + (t[1] + g.theta)*GibbsComplexMath.log(t[1] + g.theta) - 2*t[1]*
          //     GibbsComplexMath.log(t[1]) - g.theta^2/t[1]) + r2*((t[2] - g.theta)*
          //     GibbsComplexMath.log(t[2] - g.theta) + (t[2] + g.theta)*
          //     GibbsComplexMath.log(t[2] + g.theta) - 2*t[2]*GibbsComplexMath.log(t[2]) -
          //     g.theta^2/t[2]));

          //   //吉布斯方程
          g.g := g0 - s_0 * Constants.Tred * g.theta + Constants.Tred * Modelica.ComplexMath.real((r_1 * o[9]) + (r2 * o[10]));

          // //g 对 p 的一阶导数
          // g.gp := g0p + MoMoLib.Water.IAPWS09.Ice09_Utilities.Basic.Constants.Tred*
          //   ComplexMath.real(r2p*((t[2] - g.theta)*ComplexMath.log(t[2] - g.theta) + (t[
          //   2] + g.theta)*ComplexMath.log(t[2] + g.theta) - 2*t[2]*ComplexMath.log(t[2])
          //    - g.theta^2/t[2]));

          // //g 对 p 的一阶导数
          g.gp := g0p + Constants.Tred * Modelica.ComplexMath.real(r2p * o[10]);

          //   //g 对 p 的二阶导数
          //   g.gpp := g0pp + Constants.Tred
          //     *GibbsComplex.fromReal(r2pp*((t[2] - g.theta)*GibbsComplexMath.log(t[2] - g.theta)
          //      + (t[2] + g.theta)*GibbsComplexMath.log(t[2] + g.theta) - 2*t[2]*
          //     GibbsComplexMath.log(t[2]) - g.theta^2/t[2]));

          // //g 对 p 的二阶导数
          g.gpp := g0pp + Constants.Tred * Modelica.ComplexMath.real(r2pp * o[10]);

          //   //g 对 T 的一阶导数
          //   g.gT := -s_0 + GibbsComplex.fromReal(
          //       r_1*(+ GibbsComplexMath.log(t[1] + g.theta) - 2*g.theta/t[1] - GibbsComplexMath.log(t[1] - g.theta))
          //     + r2 *(- GibbsComplexMath.log(t[2] - g.theta) + GibbsComplexMath.log(t[2] + g.theta) - 2*g.theta/t[2]));

          o[11] := Modelica.ComplexMath.log(t[1] + Complex(g.theta)) - (Complex(2 * g.theta) / t[1]) - Modelica.ComplexMath.log(t[1] - Complex(g.theta));

          o[12] := Modelica.ComplexMath.log(t[2] + Complex(g.theta)) - Modelica.ComplexMath.log(t[2] - Complex(g.theta)) - (Complex(2 * g.theta) / t[2]);

          //   //g 对 T 的一阶导数
          g.gT := -s_0 + Modelica.ComplexMath.real((r_1 * o[11]) + (r2 * o[12]));

          //   //g 对 T 的二阶导数
          //   g.gTT := 1/Constants.Tred*GibbsComplex.fromReal(
          //       r_1*(1/(t[1] - g.theta) + 1/(t[1] + g.theta) - 2/t[1])
          //     + r2 *(1/(t[2] - g.theta) + 1/(t[2] + g.theta) - 2/t[2]));

          //   //g 对 T 的二阶导数
          g.gTT := 1 / Constants.Tred * Modelica.ComplexMath.real(
            (r_1 * (((Complex(1) / (t[1] - Complex(g.theta))) + (Complex(1) / (t[1] + Complex(g.theta)))) - (Complex(2) / t[1]))) 
            + (r2 * (((Complex(1) / (t[2] - Complex(g.theta))) + (Complex(1) / (t[2] + Complex(g.theta)))) - (Complex(2) / t[2]))));

          //  //g 与 T 和 p 的混合导数
          // g.gTp := ComplexMath.real(r2p*(-ComplexMath.log(t[2] - g.theta) +
          //   ComplexMath.log(t[2] + g.theta) - 2*g.theta/t[2]));

          //  //g 与 T 和 p 的混合导数
          g.gTp := Modelica.ComplexMath.real(r2p * (Modelica.ComplexMath.log(t[2] + Complex(g.theta)) - 
            ((Complex(2 * g.theta) / t[2]) + Modelica.ComplexMath.log(t[2] - Complex(g.theta)))));

        end Gibbs;

        function psub "升华压力"
          extends Modelica.Icons.Function;

          input SI.Temperature T "温度";
          output SI.AbsolutePressure p_sub "压力";

        protected
          final constant Real[3] a = {-0.212144006E+002, 0.273203819E+002, -0.610598130E+001};
          final constant Real[3] b = {0.333333333E-002, 0.120666667E+001, 0.170333333E+001};
          Real theta = 0;
          Real sum = 0;

        algorithm
          /*assert(T >= 50 and T < 273.16, "IAPWS-95 介质函数 psub：输入温度 T = "
          + String(T) + " K\n" + "必须在 50 <= T < 273.16 K 的范围内。");*/
          theta := T / Constants.Tred;

          for k in 1:3 loop
            sum := sum + a[k] * theta ^ b[k];
          end for;

          p_sub := exp(sum / theta) * Constants.pred;
          annotation(
            derivative = psub_der, 
            Inline = false, 
            LateInline = true);
        end psub;

        function Tsub "升华温度"
          extends Modelica.Icons.Function;
          input SI.AbsolutePressure p "压力";
          output SI.Temperature T_sub "温度";

        protected
          function Tsub_res
            extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
            input SI.AbsolutePressure p "压力";
            annotation();

          algorithm
            y := Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.psub(u) - p;

          end Tsub_res;
          annotation();

        algorithm
          T_sub := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
            function Tsub_res(p = p), 
            143.15, 
            2000.0, 
            1e-9);
        end Tsub;

        function psub_der "升华压力的导数"
          extends Modelica.Icons.Function;

          input SI.Temperature T "温度";
          input Real T_der "温度的导数";
          output Real p_sub_der "压力的导数";

        protected
          final constant Real[3] a = {-0.212144006E+002, 0.273203819E+002, -0.610598130E+001};
          final constant Real[3] b = {0.333333333E-002, 0.120666667E+001, 
            0.170333333E+001};
          Real theta;
          Real theta_der;
          Real sum = 0;
          Real sum_der = 0;
          annotation();

        algorithm
          /*assert(T >= 50 and T < 273.16, "IAPWS-95 介质函数 psub：输入温度 T = "
          + String(T) + " K\n" + "必须在 50 <= T < 273.16 K 的范围内。");*/
          theta := T / Constants.Tred;
          theta_der := 1 / Constants.Tred;

          for k in 1:3 loop
            sum := sum + a[k] * theta ^ b[k];
            sum_der := sum_der + a[k] * b[k] * theta ^ (b[k] - 1) * theta_der;
          end for;

          p_sub_der := (sum_der * theta - sum * theta_der) / theta ^ 2 * exp(sum / theta) * Constants.pred * T_der;

        end psub_der;
        annotation();

      end Basic;

      function ice09BaseProp_pT 
        "水介质中间属性记录(优先采用压力-温度状态参数)"
        extends Modelica.Icons.Function;
        input SI.Pressure p "压力";
        input SI.Temperature T "温度";
        output Common.AuxiliaryProperties aux "辅助记录";
      protected
        Common.GibbsDerivs2 g "吉布斯函数及与 p 和 T 有关的导数";
        annotation();
      algorithm
        aux.p := p;
        aux.T := T;
        aux.R_s := Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Constants.R_s;
        g := Basic.Gibbs(aux.p, T);
        aux.rho := 1 / g.gp;
        aux.h := g.g - g.T * g.gT - Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Constants.h_off;
        aux.s := -g.gT - Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Constants.s_off;
        aux.cp := -g.T * g.gTT;
        aux.cv := aux.cp - g.T / g.gpp * g.gTp ^ 2;
        aux.vt := 1 / aux.rho * g.gTp / g.gp;
        aux.vp := 1 / aux.rho * g.gpp / g.gp;
        aux.pd := -1 / (aux.rho * aux.rho * aux.vp);
        aux.pt := -aux.vt / aux.vp;
      end ice09BaseProp_pT;

      function rho_props_pT "密度作为压力和温度的函数"
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

      function rho_pT "密度作为压力和温度的函数"
        extends Modelica.Icons.Function;
        input SI.Pressure p "压力";
        input SI.Temperature T "温度";
        output SI.Density rho "密度";
        annotation();
      algorithm
        rho := rho_props_pT(
          p, 
          T, 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.ice09BaseProp_pT(
          p, T));

      end rho_pT;

      function rho_pT_der "rho_pT 的导函数"
        extends Modelica.Icons.Function;
        input SI.Pressure p "压力";
        input SI.Temperature T "温度";
        input Common.AuxiliaryProperties aux "辅助记录";
        input Real p_der "压力的导数";
        input Real T_der "温度的导数";
        output Real rho_der "密度的导数";
        annotation();
      algorithm
        rho_der := (-aux.rho * aux.rho * aux.vp) * p_der + (-aux.rho * aux.rho * aux.vt) * 
          T_der;
      end rho_pT_der;

      function h_props_pT 
        "比焓作为压力和温度的函数"
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

      function h_pT "比焓作为压力和温度的函数"
        extends Modelica.Icons.Function;
        input SI.Pressure p "压力";
        input SI.Temperature T "温度";
        output SI.SpecificEnthalpy h "比焓";
        annotation();
      algorithm
        h := h_props_pT(
          p, 
          T, 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.ice09BaseProp_pT(
          p, T));

      end h_pT;

      function h_pT_der "h_pT 的导函数"
        extends Modelica.Icons.Function;
        input SI.Pressure p "压力";
        input SI.Temperature T "温度";
        input Common.AuxiliaryProperties aux "辅助记录";
        input Real p_der "压力的导数";
        input Real T_der "温度的导数";
        output Real h_der "比焓的导数";
        annotation();
      algorithm
        h_der := (1 / aux.rho - aux.T * aux.vt) * p_der + aux.cp * T_der;
      end h_pT_der;

      function s_props_pT 
        "比熵作为压力和温度的函数"
        extends Modelica.Icons.Function;
        input SI.Pressure p "压力";
        input SI.Temperature T "温度";
        input Common.AuxiliaryProperties aux "辅助记录";
        output SI.SpecificEntropy s "比熵";
      algorithm
        s := aux.s;
        annotation(Inline = false, LateInline = true);
      end s_props_pT;

      function s_pT "比熵作为压力和温度的函数"
        extends Modelica.Icons.Function;
        input SI.Pressure p "压力";
        input SI.Temperature T "温度";
        output SI.SpecificEntropy s "比熵";
        annotation();
      algorithm
        s := s_props_pT(
          p, 
          T, 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.ice09BaseProp_pT(
          p, T));

      end s_pT;

      function kappa_props_pT 
        "等温压缩系数作为压力和温度的函数"
        extends Modelica.Icons.Function;
        input SI.Pressure p "压力";
        input SI.Temperature T "温度";
        input Common.AuxiliaryProperties aux "辅助记录";
        output SI.IsothermalCompressibility kappa 
          "等温压缩系数";
      algorithm
        kappa := -aux.vp * aux.rho;
        annotation(Inline = false, LateInline = true);
      end kappa_props_pT;

      function kappa_pT 
        "等温压缩系数作为压力和温度的函数"
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
          Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.ice09BaseProp_pT(
          p, T));

      end kappa_pT;
      annotation();

    end Ice09_Utilities;

    function beta_H "亨利定律常数"
      extends Modelica.Icons.Function;

      input SI.AbsolutePressure p "压力";
      input SI.Temperature T "温度";
      output Real beta_H(unit = "1/Pa") "亨利定律常数";

    protected
      Real[3] A = {-9.67578, -9.44833, -8.40954};
      Real[3] B = {4.72162, 4.43822, 4.29587};
      Real[3] C = {11.70585, 11.42005, 10.52779};
      Real[3] psi = {0.7812, 0.2095, 0.0093};

      Real[3] beta = fill(0, 3);
      Real Tr = T / 647.096;
      Real tau = 1 - Tr;
      annotation();

    algorithm
      if ((T < 273.15) or (T > 
        Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.Tsat(
        p))) then
        beta_H := 0;
      else
        for k in 1:3 loop
          beta[k] := 
            Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.psat(
            T) * exp(A[k] / Tr + B[k] * tau ^ (0.355) / Tr + C[k] * Tr ^ (-0.41) * exp(tau));
        end for;
        beta_H := 1 / 1.01325 * (psi[1] / beta[1] + psi[2] / beta[2] + psi[3] / beta[3]);
      end if;
    end beta_H;

    function f_pT "增强因子作为压力和温度的函数"
      extends Modelica.Icons.Function;

      input SI.AbsolutePressure p "压力";
      input SI.Temperature T "温度";
      output Real f "蒸气压增强因子";

    protected
      function f_res
        extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
        input SI.AbsolutePressure p "压力";
        input SI.Temperature T "温度";

      protected
        Real x = u;
        Real p_ws = 0;
        Real kappa_T = 0;
        Real v_ws = 0;
        Real beta_H = 0;
        Real psi_ws = 0;
        Real baa = 0;
        Real baw = 0;
        Real bww = 0;
        Real caaa = 0;
        Real caaw = 0;
        Real caww = 0;
        Real cwww = 0;
        final constant Real R_bar = 8.314472;
        annotation();

      algorithm
        //p_ws 是水的饱和压力
        p_ws := if (T >= 273.16) then 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.psat(
          T) else 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.psub(
          T);

        //kappa_T 是等温压缩系数
        if (p < p_ws) then
          kappa_T := 0;
        else
          kappa_T := if (T >= 273.16) then 
            Modelica.Media.Water.IF97_Utilities.kappa_pT(p, T) else 
            Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.kappa_pT(
            p, T);
        end if;

        //v_ws 是饱和水的摩尔体积
        v_ws := if (T >= 273.16) then Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.molarMass 
          / Modelica.Media.Water.IF97_Utilities.rho_pT(p, T) else Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Constants.MM 
          / Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.rho_pT(p, T);

        //beta_H 是亨利定律常数
        beta_H := Modelica.Media.Air.ReferenceMoistAir.Utilities.beta_H(p, T);

        //计算维里系数 baa, baw, bww, caaa, caaw, caww, cwww
        baa := Modelica.Media.Air.ReferenceMoistAir.Utilities.VirialCoefficients.Baa_dT(0, T);
        baw := Modelica.Media.Air.ReferenceMoistAir.Utilities.VirialCoefficients.Baw_dT(0, T);
        bww := Modelica.Media.Air.ReferenceMoistAir.Utilities.VirialCoefficients.Bww_dT(0, T);
        caaa := Modelica.Media.Air.ReferenceMoistAir.Utilities.VirialCoefficients.Caaa_dT(0, T);
        caaw := Modelica.Media.Air.ReferenceMoistAir.Utilities.VirialCoefficients.Caaw_dT(0, T);
        caww := Modelica.Media.Air.ReferenceMoistAir.Utilities.VirialCoefficients.Caww_dT(0, T);
        cwww := Modelica.Media.Air.ReferenceMoistAir.Utilities.VirialCoefficients.Cwww_dT(0, T);

        y := ((1 + kappa_T * p_ws) * (p - p_ws) - kappa_T * (p ^ 2 - p_ws ^ 2) / 2) / (R_bar * 
          T) * v_ws + log(1 - beta_H * (1 - x * p_ws / p) * p) + (1 - x * p_ws / p) ^ 2 * p / (
          R_bar * T) * baa - 2 * (1 - x * p_ws / p) ^ 2 * p / (R_bar * T) * baw - (p - p_ws - (1 - 
          x * p_ws / p) ^ 2 * p) / (R_bar * T) * bww + (1 - x * p_ws / p) ^ 3 * p ^ 2 / (R_bar * T) ^ 2 * caaa 
          + 3 * (1 - x * p_ws / p) ^ 2 * (1 - 2 * (1 - x * p_ws / p)) * p ^ 2 / (2 * (R_bar * T) ^ 2) * caaw 
          - 3 * (1 - x * p_ws / p) ^ 2 * x * p_ws / p * p ^ 2 / (R_bar * T) ^ 2 * caww - ((3 - 2 * x * p_ws / 
          p) * (x * p_ws / p) ^ 2 * p ^ 2 - p_ws ^ 2) / (2 * (R_bar * T) ^ 2) * cwww - (1 - x * p_ws / p) ^ 2 
          * (-2 + 3 * x * p_ws / p) * x * p_ws / p * p ^ 2 / (R_bar * T) ^ 2 * baa * bww - 2 * (1 - x * p_ws / p) 
          ^ 3 * (-1 + 3 * x * p_ws / p) * p ^ 2 / (R_bar * T) ^ 2 * baa * baw + 6 * (1 - x * p_ws / p) ^ 2 * (x * 
          p_ws / p) ^ 2 * p ^ 2 / (R_bar * T) ^ 2 * bww * baw - 3 * (1 - x * p_ws / p) ^ 4 * p ^ 2 / (2 * (R_bar * 
          T) ^ 2) * baa ^ 2 - 2 * (1 - x * p_ws / p) ^ 2 * x * p_ws / p * (-2 + 3 * x * p_ws / p) * p ^ 2 / (
          R_bar * T) ^ 2 * baw ^ 2 - (p_ws ^ 2 - (4 - 3 * x * p_ws / p) * (x * p_ws / p) ^ 3 * p ^ 2) / (2 * (
          R_bar * T) ^ 2) * bww ^ 2 - log(x);
      end f_res;
      Real xmax;
      annotation();

    algorithm
      if ((useEnhancementFactor == false) or (T >= 
        Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.Tsat(
        p))) then
        f := 1;
      else
        xmax := if (T < 273.16) then 120.0 else 8.0;
        f := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
          function f_res(p = p, T = T), 
          0.99999, 
          xmax, 
          1e-9);
      end if;
    end f_pT;

    function rho_pTX 
      "返回密度作为压力 p、温度 T 和组分 X 的函数"
      extends Modelica.Icons.Function;

      input SI.AbsolutePressure p "压力";
      input SI.Temperature T "温度";
      input SI.MassFraction X[:] = Modelica.Media.Air.ReferenceMoistAir.reference_X 
        "质量分数";
      output SI.Density d "密度";

    protected
      Real pd;
      Real pl;
      Real xw;
      Real xws;

    algorithm
      if (X[1] == 0) then
        d := Modelica.Media.Air.ReferenceAir.Air_Utilities.rho_pT(p, T);
      else
        xw := X[1] / (1 - X[1]);
        xws := xws_pT(p, T);
        pd := pd_pTX(
          p, 
          T, 
          X);
        pl := p - pd;
        if ((xw <= xws) or (xws == -1)) then
          if (T < 273.16) then
            d := Modelica.Media.Air.ReferenceAir.Air_Utilities.rho_pT(pl, T) + 
              pd / (.Modelica.Media.Air.ReferenceMoistAir.steam.R_s * T);
          else
            d := Modelica.Media.Air.ReferenceAir.Air_Utilities.rho_pT(pl, T) + 
              IF97_new.rho_pT(pd, T);
          end if;
        else
          if (T < 273.16) then
            d := (1 + xw) / ((1 + xws) / (
              Modelica.Media.Air.ReferenceAir.Air_Utilities.rho_pT(pl, T) + pd / 
              (.Modelica.Media.Air.ReferenceMoistAir.steam.R_s * T)) + (xw - xws) / 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.rho_pT(
              p, T));
          else
            d := (1 + xw) / ((1 + xws) / (
              Modelica.Media.Air.ReferenceAir.Air_Utilities.rho_pT(pl, T) + 
              IF97_new.rho_pT(pd, T)) + (xw - xws) / 
              Modelica.Media.Water.IF97_Utilities.rho_pT(p, T));
          end if;
        end if;
      end if;
      annotation(
        derivative = rho_pTX_der, 
        Inline = false, 
        LateInline = true);
    end rho_pTX;

    function pds_pT "蒸汽饱和分压"
      extends Modelica.Icons.Function;

      input SI.AbsolutePressure p "压力";
      input SI.Temperature T "温度";
      output SI.AbsolutePressure pds "压力";

    protected
      Real Tlim;

    algorithm
      if (T >= 273.16) then
        pds := 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.psat(
          T);
        Tlim := 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.Tsat(
          p);
      else
        pds := 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.psub(
          T);
        Tlim := 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Tsub(
          p);
      end if;
      if (T <= Tlim) then
        pds := Modelica.Media.Air.ReferenceMoistAir.Utilities.f_pT(p, T) * pds;
      else
        // pds := -1;
        pds := p;
      end if;
      annotation(
        derivative = pds_pT_der, 
        Inline = false, 
        LateInline = true, 
        Documentation(revisions = "<html>
2017-04-13 Stefan Wischhusen: 蒸汽分压不能高于绝对压力 p。
</html>"  ));
    end pds_pT;

    function pd_pTX "蒸汽分压"
      extends Modelica.Icons.Function;

      input SI.AbsolutePressure p "压力";
      input SI.Temperature T "温度";
      input SI.MassFraction X[:] = Modelica.Media.Air.ReferenceMoistAir.reference_X 
        "质量分数";
      output SI.AbsolutePressure pd "分压";

    protected
      Real xw;
      Real xws;
      Real pds;

    algorithm
      if (X[1] == 0) then
        pd := 0;
      else
        xw := X[1] / (1 - X[1]);
        pds := Modelica.Media.Air.ReferenceMoistAir.Utilities.pds_pT(p, T);
        pd := xw / (Modelica.Media.Air.ReferenceMoistAir.k_mair + xw) * p;
        xws := Modelica.Media.Air.ReferenceMoistAir.Utilities.xws_pT(p, T);
        pd := if ((xw <= xws) or (xws == -1)) then pd else pds;
      end if;
      annotation(
        derivative = pd_pTX_der, 
        Inline = false, 
        LateInline = true);
    end pd_pTX;

    function xws_pT "饱和湿空气的湿度比（绝对值）"
      extends Modelica.Icons.Function;

      input SI.AbsolutePressure p "压力";
      input SI.Temperature T "温度";
      output Real xws "绝对湿度比";

    protected
      Real pds;
      Real Tlim;

    algorithm
      pds := Modelica.Media.Air.ReferenceMoistAir.Utilities.pds_pT(p, T);
      Tlim := if (T <= 273.16) then 
        Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Tsub(
        p) else 
        Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.Tsat(p);
      //   xws := if (T <= Tlim) then Modelica.Media.Air.ReferenceMoistAir.k_mair*
      //     pds/(p - pds) else -1;
      xws := if (pds < p) then pds * Modelica.Media.Air.ReferenceMoistAir.k_mair / (p - pds) else Modelica.Constants.inf;
      annotation(
        derivative = xws_pT_der, 
        Inline = false, 
        LateInline = true, 
        Documentation(revisions = "<html>
2017-04-13 Stefan Wischhusen: xws 的新公式。
</html>"  ));
    end xws_pT;

    function phi_pTX "相对湿度"
      extends Modelica.Icons.Function;
      input SI.AbsolutePressure p "压力";
      input SI.Temperature T "温度";
      input SI.MassFraction X[:] = Modelica.Media.Air.ReferenceMoistAir.reference_X 
        "质量分数";
      output Real phi "相对湿度";

    protected
      Real xw;
      Real pd;
      Real pds;

    algorithm
      if (X[1] == 0) then
        phi := 0;
      else
        xw := X[1] / (1 - X[1]);
        if (T >= 273.16) then
          pds := Modelica.Media.Water.IF97_Utilities.BaseIF97.Basic.psat(T);
        else
          pds := 
            Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.psub(
            T);
        end if;
        pds := Modelica.Media.Air.ReferenceMoistAir.Utilities.f_pT(p, T) * pds;
        pd := xw / (Modelica.Media.Air.ReferenceMoistAir.k_mair + xw) * p;
        //     if (pd <= pds) then
        //       phi := pd/pds;
        //     else
        //       phi := -1;
        //     end if;
        phi := pd / max(100 * Modelica.Constants.eps, pds);
      end if;

      annotation(Inline = false, LateInline = true, 
        Documentation(revisions = "<html>
2017-04-13 Stefan Wischhusen: phi 的新计算方法。
</html>"  ));
    end phi_pTX;

    function cp_pTX "等压比热容"
      extends Modelica.Icons.Function;
      input SI.AbsolutePressure p "压力";
      input SI.Temperature T "温度";
      input SI.MassFraction X[:] = Modelica.Media.Air.ReferenceMoistAir.reference_X 
        "质量分数";
      output SI.SpecificHeatCapacity cp "比热容";

    protected
      Real xw;
      Real xws;
      Real pd;
      Real pl;

    algorithm
      if (X[1] == 0.0) then
        if (T >= 773.15) then
          cp := Modelica.Media.Air.ReferenceAir.Air_Utilities.cp_pT(p, T) + 
            Utilities.cp_dis_pTX(
            p, 
            T, 
            X);
        else
          cp := Modelica.Media.Air.ReferenceAir.Air_Utilities.cp_pT(p, T);
        end if;
      else
        pd := Modelica.Media.Air.ReferenceMoistAir.Utilities.pd_pTX(
          p, 
          T, 
          X);
        pl := p - pd;
        xw := X[1] / (1 - X[1]);
        xws := Modelica.Media.Air.ReferenceMoistAir.Utilities.xws_pT(p, T);
        if ((xw <= xws) or (xws == -1)) then
          if (T >= 773.15) then
            cp := X[1] * 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.cp_pT(pd, 
              T) + X[2] * Modelica.Media.Air.ReferenceAir.Air_Utilities.cp_pT(pl, 
              T) + Modelica.Media.Air.ReferenceMoistAir.Utilities.cp_dis_pTX(
              p, 
              T, 
              X);
          else
            cp := X[1] * 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.cp_pT(pd, 
              T) + X[2] * Modelica.Media.Air.ReferenceAir.Air_Utilities.cp_pT(pl, 
              T);
          end if;
        else
          cp := -1;
        end if;
      end if;
      annotation(Inline = false, LateInline = true);
    end cp_pTX;

    function cv_pTX "等温比热容"
      extends Modelica.Icons.Function;
      input SI.AbsolutePressure p "压力";
      input SI.Temperature T "温度";
      input SI.MassFraction X[:] = Modelica.Media.Air.ReferenceMoistAir.reference_X 
        "质量分数";
      output SI.SpecificHeatCapacity cv "比热容";

    protected
      Real xw;
      Real xws;
      Real pd;
      Real pl;

    algorithm
      if (X[1] == 0) then
        cv := Modelica.Media.Air.ReferenceAir.Air_Utilities.cv_pT(p, T);
      else
        pd := Modelica.Media.Air.ReferenceMoistAir.Utilities.pd_pTX(
          p, 
          T, 
          X);
        pl := p - pd;
        xw := X[1] / (1 - X[1]);
        xws := Modelica.Media.Air.ReferenceMoistAir.Utilities.xws_pT(p, T);
        if ((xw <= xws) or (xws == -1)) then
          cv := X[1] * 
            Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.cv_pT(pd, T) 
            + X[2] * Modelica.Media.Air.ReferenceAir.Air_Utilities.cv_pT(pl, T);
        else
          cv := -1;
        end if;
      end if;
      annotation(Inline = false, LateInline = true);
    end cv_pTX;

    function h_pTX "湿空气的比焓"
      extends Modelica.Icons.Function;
      input SI.AbsolutePressure p "压力";
      input SI.Temperature T "温度";
      input SI.MassFraction X[:] = Modelica.Media.Air.ReferenceMoistAir.reference_X 
        "质量分数";
      output SI.SpecificEnthalpy h "比焓";

    protected
      Real xw;
      Real xws;
      Real pd;
      Real pl;

    algorithm
      if (X[1] == 0) then
        h := Modelica.Media.Air.ReferenceAir.Air_Utilities.h_pT(p, T);
      else
        pd := Modelica.Media.Air.ReferenceMoistAir.Utilities.pd_pTX(
          p, 
          T, 
          X);
        pl := p - pd;
        xw := X[1] / (1 - X[1]);
        xws := Modelica.Media.Air.ReferenceMoistAir.Utilities.xws_pT(p, T);
        if ((xw <= xws) or (xws == -1)) then
          if (T >= 773.15) then
            h := Modelica.Media.Air.ReferenceAir.Air_Utilities.h_pT(pl, T) + xw 
              * Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.h_pT(pd, 
              T) + (1 + xw) * 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.h_dis_pTX(
              p, 
              T, 
              X);
          else
            h := Modelica.Media.Air.ReferenceAir.Air_Utilities.h_pT(pl, T) + xw 
              * Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.h_pT(pd, 
              T);
          end if;
        else
          if (T < 273.16) then
            h := Modelica.Media.Air.ReferenceAir.Air_Utilities.h_pT(pl, T) + 
              xws * Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.h_pT(
              pd, T) + (xw - xws) * 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.h_pT(
              p, T);
          else
            h := Modelica.Media.Air.ReferenceAir.Air_Utilities.h_pT(pl, T) + 
              xws * Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.h_pT(
              pd, T) + (xw - xws) * Modelica.Media.Water.IF97_Utilities.h_pT(p, T);
          end if;
        end if;
        h := h / (1 + xw);
      end if;
      annotation(
        derivative = h_pTX_der, 
        Inline = false, 
        LateInline = true);
    end h_pTX;

    function h_dis_pTX
      extends Modelica.Icons.Function;
      input SI.AbsolutePressure p "压力";
      input SI.Temperature T "温度";
      input SI.MassFraction X[:] = Modelica.Media.Air.ReferenceMoistAir.reference_X 
        "质量分数";
      output Real u "反应指数";
    protected
      Real uges;
      Real invMMX[4] "摩尔重量的倒数";
      SI.MolarMass Mmix "混合物的摩尔质量";
      MassFraction[4] massFraction "组分的质量分数";
      SI.MoleFraction[4] Y 
        "湿空气中各组分（H2O、N2、O2、Ar）的摩尔分数";
      annotation();
    algorithm
      if (useDissociation == false) then
        u := 0;
      elseif (size(X, 1) > 1) then
        massFraction := {X[1], X[2] * Xi_Air[1], X[2] * Xi_Air[2], X[2] * Xi_Air[3]};
        for i in 1:4 loop
          invMMX[i] := 1 / MMX[i];
        end for;
        Mmix := 1 / (massFraction * invMMX);
        for i in 1:4 loop
          Y[i] := Mmix * massFraction[i] / MMX[i];
        end for;
        uges := 1 + 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U2(
          p, 
          T, 
          Y) + 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U3(
          p, 
          T, 
          Y) + 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U4(
          p, 
          T, 
          Y) + 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U5(
          p, 
          T, 
          Y) + 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U6(
          p, 
          T, 
          Y);
        u := -T ^ 2 * (
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U2(
          p, 
          T, 
          Y) * 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.V2(T) / 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.BB[2] 
          + Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U3(
          p, 
          T, 
          Y) * 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.V3(T) / 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.BB[3] 
          + Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U4(
          p, 
          T, 
          Y) * 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.V4(T) / 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.BB[4] 
          + Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U5(
          p, 
          T, 
          Y) * 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.V5(T) / 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.BB[5] 
          + Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U6(
          p, 
          T, 
          Y) * 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.V6(T) / 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.BB[6]) 
          / uges * sum(massFraction[j] / MMX[j] for j in 1:4);
      end if;
    end h_dis_pTX;

    function s_pTX "湿空气的比熵"
      extends Modelica.Icons.Function;
      input SI.AbsolutePressure p "压力";
      input SI.Temperature T "温度";
      input SI.MassFraction X[:] = Modelica.Media.Air.ReferenceMoistAir.reference_X 
        "质量分数";
      output SI.SpecificEntropy s "比熵";

    protected
      Real xw;
      Real xws;
      Real pd;
      Real pl;

    algorithm
      if (X[1] == 0) then
        s := Modelica.Media.Air.ReferenceAir.Air_Utilities.s_pT(p, T);
      else
        pd := Modelica.Media.Air.ReferenceMoistAir.Utilities.pd_pTX(
          p, 
          T, 
          X);
        pl := p - pd;
        xw := X[1] / (1 - X[1]);
        xws := Modelica.Media.Air.ReferenceMoistAir.Utilities.xws_pT(p, T);
        if ((xw <= xws) or (xws == -1)) then
          if (T >= 773.15) then
            s := Modelica.Media.Air.ReferenceAir.Air_Utilities.s_pT(pl, T) + xw 
              * Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.s_pT(pd, 
              T) + (1 + xw) * 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.s_dis_pTX(
              p, 
              T, 
              X);
          else
            s := Modelica.Media.Air.ReferenceAir.Air_Utilities.s_pT(pl, T) + xw 
              * Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.s_pT(pd, 
              T);
          end if;
        else
          if (T < 273.16) then
            s := Modelica.Media.Air.ReferenceAir.Air_Utilities.s_pT(pl, T) + 
              xws * Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.s_pT(
              pd, T) + (xw - xws) * 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.s_pT(
              p, T);
          else
            s := Modelica.Media.Air.ReferenceAir.Air_Utilities.s_pT(pl, T) + 
              xws * Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.s_pT(
              pd, T) + (xw - xws) * Modelica.Media.Water.IF97_Utilities.s_pT(p, T);
          end if;
        end if;
        s := s / (1 + xw);
      end if;
      annotation(Inline = false, LateInline = true);
    end s_pTX;

    function u_pTX "内能"
      extends Modelica.Icons.Function;
      input SI.AbsolutePressure p "压力";
      input SI.Temperature T "温度";
      input SI.MassFraction X[:] = Modelica.Media.Air.ReferenceMoistAir.reference_X 
        "质量分数";
      output SI.SpecificEnergy u "比熵";

    algorithm
      u := Modelica.Media.Air.ReferenceMoistAir.Utilities.h_pTX(
        p, 
        T, 
        X) - p / Modelica.Media.Air.ReferenceMoistAir.Utilities.rho_pTX(
        p, 
        T, 
        X);
      annotation(
        derivative = u_pTX_der, 
        Inline = false, 
        LateInline = true);
    end u_pTX;

    function cp_dis_pTX
      extends Modelica.Icons.Function;
      input SI.AbsolutePressure p "压力";
      input SI.Temperature T "温度";
      input SI.MassFraction X[:] = Modelica.Media.Air.ReferenceMoistAir.reference_X 
        "质量分数";
      output Real u "反应指数";
    protected
      Real uges;
      Real invMMX[4] "摩尔重量的倒数";
      SI.MolarMass Mmix "混合物的摩尔质量";
      MassFraction[4] massFraction "组分的质量分数";
      SI.MoleFraction[4] Y 
        "湿空气中各组分（H2O、N2、O2、Ar）的摩尔分数";
      annotation();
    algorithm
      if (useDissociation == false) then
        u := 0;
      else
        massFraction := {X[1], X[2] * Xi_Air[1], X[2] * Xi_Air[2], X[2] * Xi_Air[3]};
        for i in 1:4 loop
          invMMX[i] := 1 / MMX[i];
        end for;
        Mmix := 1 / (massFraction * invMMX);
        for i in 1:4 loop
          Y[i] := Mmix * massFraction[i] / MMX[i];
        end for;
        uges := 1 + 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U2(
          p, 
          T, 
          Y) + 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U3(
          p, 
          T, 
          Y) + 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U4(
          p, 
          T, 
          Y) + 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U5(
          p, 
          T, 
          Y) + 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U6(
          p, 
          T, 
          Y);
        u := (Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U2(
          p, 
          T, 
          Y) * 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.V2(T) 
          + Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U3(
          p, 
          T, 
          Y) * 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.V3(T) 
          + Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U4(
          p, 
          T, 
          Y) * 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.V4(T) 
          + Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U5(
          p, 
          T, 
          Y) * 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.V5(T) 
          + Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U6(
          p, 
          T, 
          Y) * 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.V6(T)) 
          / uges * sum(massFraction[j] / MMX[j] for j in 1:4);
      end if;
    end cp_dis_pTX;

    function s_dis_pTX
      extends Modelica.Icons.Function;
      input SI.AbsolutePressure p "压力";
      input SI.Temperature T "温度";
      input SI.MassFraction X[:] = Modelica.Media.Air.ReferenceMoistAir.reference_X 
        "质量分数";
      output Real u "反应指数";
    protected
      Real uges;
      Real invMMX[4] "摩尔质量的倒数";
      SI.MolarMass Mmix "混合物的摩尔质量";
      MassFraction[4] massFraction "组分的质量分数";
      SI.MoleFraction[4] Y 
        "湿空气中各组分 (H2O, N2, O2, Ar) 的摩尔分数";
      annotation();
    algorithm
      if (useDissociation == false) then
        u := 0;
      else
        massFraction := {X[1], X[2] * Xi_Air[1], X[2] * Xi_Air[2], X[2] * Xi_Air[3]};
        for i in 1:4 loop
          invMMX[i] := 1 / MMX[i];
        end for;
        Mmix := 1 / (massFraction * invMMX);
        for i in 1:4 loop
          Y[i] := Mmix * massFraction[i] / MMX[i];
        end for;
        uges := 1 + 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U2(
          p, 
          T, 
          Y) + 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U3(
          p, 
          T, 
          Y) + 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U4(
          p, 
          T, 
          Y) + 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U5(
          p, 
          T, 
          Y) + 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U6(
          p, 
          T, 
          Y);
        u := -T * (
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U2(
          p, 
          T, 
          Y) * 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.V2(T) / 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.BB[2] 
          + Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U3(
          p, 
          T, 
          Y) * 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.V3(T) / 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.BB[3] 
          + Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U4(
          p, 
          T, 
          Y) * 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.V4(T) / 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.BB[4] 
          + Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U5(
          p, 
          T, 
          Y) * 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.V5(T) / 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.BB[5] 
          + Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U6(
          p, 
          T, 
          Y) * 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.V6(T) / 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.BB[6]) 
          / uges * sum(massFraction[j] / MMX[j] for j in 1:4);
      end if;
    end s_dis_pTX;

    function pd_pTX_der "水蒸气的分压导数"
      extends Modelica.Icons.Function;

      input SI.AbsolutePressure p "压力";
      input SI.Temperature T "温度";
      input SI.MassFraction X[:] = Modelica.Media.Air.ReferenceMoistAir.reference_X 
        "质量分数";
      input Real p_der "压力导数";
      input Real T_der "温度导数";
      input Real X_der[:] "质量分数导数";
      output Real pd_der "分压导数";

    protected
      Real xw;
      Real xw_der;
      Real xws;
      Real pds;
      Real pds_der;

    algorithm
      if (X[1] == 0) then
        //pd := 0;
        pd_der := 0;
      else
        xw := X[1] / (1 - X[1]) "d(xw)/dt = d(xw)/dX[1] * dX[1]/dt";
        xw_der := (X_der[1] * (1 - X[1]) + X[1] * X_der[1]) / (1 - X[1]) ^ 2;
        pds_der := Modelica.Media.Air.ReferenceMoistAir.Utilities.pds_pT_der(
          p, 
          T, 
          p_der, 
          T_der);
        //pd := xw/(Modelica.Media.Air.ReferenceMoistAir.k_mair + xw)*p;
        pd_der := (xw_der * (Modelica.Media.Air.ReferenceMoistAir.k_mair + xw) - 
          xw * xw_der) * p + xw / (Modelica.Media.Air.ReferenceMoistAir.k_mair + xw) * 
          p_der;
        xws := Modelica.Media.Air.ReferenceMoistAir.Utilities.xws_pT(p, T);
        pd_der := if (xw <= xws) then pd_der else pds_der;
      end if;
      annotation(Documentation(revisions = "<html>
2017-04-13 Stefan Wischhusen: 修改了导数函数。
</html>"  ));
    end pd_pTX_der;

    function xws_pT_der 
      "饱和湿空气的绝对湿度比的导数"
      extends Modelica.Icons.Function;

      input SI.AbsolutePressure p "压力";
      input SI.Temperature T "温度";
      input Real p_der "压力导数";
      input Real T_der "温度导数";
      output Real xws_der "绝对湿度比导数";

    protected
      Real pds;
      Real pds_der;
      Real Tlim;

    algorithm
      pds := Modelica.Media.Air.ReferenceMoistAir.Utilities.pds_pT(p, T);
      pds_der := Modelica.Media.Air.ReferenceMoistAir.Utilities.pds_pT_der(
        p, 
        T, 
        p_der, 
        T_der);
      Tlim := if (T <= 273.16) then 
        Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Tsub(
        p) else 
        Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.Tsat(p);
      if (pds < p) then
        xws_der := Modelica.Media.Air.ReferenceMoistAir.k_mair * ((pds_der * (p - 
          pds) + pds * pds_der) / (p - pds) ^ 2);
      else
        xws_der := 0;
      end if;
    annotation(Documentation(revisions = "<html>
2017-04-13 Stefan Wischhusen: 修改了导数函数。
</html>"  ));
    end xws_pT_der;

    function pds_pT_der "水蒸气饱和分压的导数"
      extends Modelica.Icons.Function;

      input SI.AbsolutePressure p "压力";
      input SI.Temperature T "温度";
      input Real p_der "压力导数";
      input Real T_der "温度导数";
      output Real pds_der "压力导数";

    protected
      Real Tlim;

    algorithm
      if (T >= 273.16) then
        pds_der := 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.psat_der(
          T, T_der);
        Tlim := 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.Tsat(
          p);
      else
        pds_der := 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.psub_der(
          T, T_der);
        Tlim := 
          Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Tsub(
          p);
      end if;
      if (T <= Tlim) then
        pds_der := pds_der;
      else
        pds_der := p_der;
      end if;
    annotation(Documentation(revisions = "<html>
2017-04-13 Stefan Wischhusen: 修改了导数，如果 pds=p。
</html>"  ));
    end pds_pT_der;

    function rho_pTX_der 
      "密度关于压力 p、温度 T 和组分 X 的导数"
      extends Modelica.Icons.Function;

      input SI.AbsolutePressure p "压力";
      input SI.Temperature T "温度";
      input SI.MassFraction X[:] = Modelica.Media.Air.ReferenceMoistAir.reference_X 
        "质量分数";
      input Real p_der "压力导数";
      input Real T_der "温度导数";
      input Real X_der[:] "质量分数导数";
      output Real d_der "密度导数";

    protected
      Real pd;
      Real pd_der;
      Real pl;
      Real pl_der;
      Real xw;
      Real xw_der;
      Real xws;
      Real xws_der;
      Real o[5];
      annotation();

    algorithm
      if (X[1] == 0) then
        d_der := Modelica.Media.Air.ReferenceAir.Air_Utilities.rho_pT_der(
          p, 
          T, 
          Modelica.Media.Air.ReferenceAir.Air_Utilities.airBaseProp_pT(p, T), 
          p_der, 
          T_der);
      else
        xw := X[1] / (1 - X[1]);
        xw_der := (X_der[1]) / (1 - X[1]) ^ 2;
        xws := xws_pT(p, T);
        xws_der := xws_pT_der(
          p, 
          T, 
          p_der, 
          T_der);
        pd := pd_pTX(
          p, 
          T, 
          X);
        pd_der := Modelica.Media.Air.ReferenceMoistAir.Utilities.pd_pTX_der(
          p, 
          T, 
          X, 
          p_der, 
          T_der, 
          X_der);
        pl := p - pd;
        pl_der := p_der - pd_der;
        if ((xw <= xws) or (xws == -1)) then
          if (T < 273.16) then
            d_der := Modelica.Media.Air.ReferenceAir.Air_Utilities.rho_pT_der(
              pl, 
              T, 
              Modelica.Media.Air.ReferenceAir.Air_Utilities.airBaseProp_pT(
              pl, T), 
              pl_der, 
              T_der) + Modelica.Media.Air.ReferenceMoistAir.steam.R_s * (pd_der 
              * T - pd * T_der) / (Modelica.Media.Air.ReferenceMoistAir.steam.R_s * T) ^ 2;

          else
            d_der := Modelica.Media.Air.ReferenceAir.Air_Utilities.rho_pT_der(
              pl, 
              T, 
              Modelica.Media.Air.ReferenceAir.Air_Utilities.airBaseProp_pT(
              pl, T), 
              pl_der, 
              T_der) + IF97_new.rho_pT_der(
              pd, 
              T, 
              pd_der, 
              T_der);

          end if;
        else
          if (T < 273.16) then
            o[1] := Modelica.Media.Air.ReferenceAir.Air_Utilities.rho_pT(pl, T);
            o[2] := 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.rho_pT(
              p, T);
            o[3] := ((1 + xws) / (
              Modelica.Media.Air.ReferenceAir.Air_Utilities.rho_pT(pl, T) + pd / 
              (.Modelica.Media.Air.ReferenceMoistAir.steam.R_s * T)) + (xw - xws) / 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.rho_pT(
              p, T));
            o[4] := Modelica.Media.Air.ReferenceAir.Air_Utilities.rho_pT_der(
              pl, 
              T, 
              Modelica.Media.Air.ReferenceAir.Air_Utilities.airBaseProp_pT(
              p, T), 
              p_der, 
              T_der);

            o[5] := (xws_der * o[1] - (1 + xws) * o[4]) / o[1] ^ 2 + (pd_der * T - pd * 
              T_der) / Modelica.Media.Air.ReferenceMoistAir.steam.R_s / T ^ 2 + (xw_der 
              * o[2] - xw * 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.rho_pT_der(
              p, 
              T, 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.ice09BaseProp_pT(
              p, T), 
              p_der, 
              T_der)) / o[2] ^ 2 - (xws_der * o[2] - xws * 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.rho_pT_der(
              p, 
              T, 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.ice09BaseProp_pT(
              p, T), 
              p_der, 
              T_der)) / o[2] ^ 2;

            d_der := (xw_der * o[3] - (1 + xw) * o[5]) / o[3] ^ 2;

          else
            o[1] := Modelica.Media.Air.ReferenceAir.Air_Utilities.rho_pT(pl, T) 
              + IF97_new.rho_pT(pd, T);
            o[2] := Modelica.Media.Water.IF97_Utilities.rho_pT(p, T);
            o[3] := ((1 + xws) / (
              Modelica.Media.Air.ReferenceAir.Air_Utilities.rho_pT(pl, T) + 
              IF97_new.rho_pT(pd, T)) + (xw - xws) / 
              Modelica.Media.Water.IF97_Utilities.rho_pT(p, T));
            o[4] := Modelica.Media.Air.ReferenceAir.Air_Utilities.rho_pT_der(
              pl, 
              T, 
              Modelica.Media.Air.ReferenceAir.Air_Utilities.airBaseProp_pT(
              p, T), 
              p_der, 
              T_der) + IF97_new.rho_pT_der(
              pd, 
              T, 
              pd_der, 
              T_der);

            o[5] := (xws_der * o[1] - (1 + xws) * o[4]) / o[1] ^ 2 + (xw_der * o[2] - xw * 
              Modelica.Media.Water.IF97_Utilities.rho_pT_der(
              p, 
              T, 
              Modelica.Media.Water.IF97_Utilities.waterBaseProp_pT(p, T), 
              p_der, 
              T_der)) / o[2] ^ 2 - (xws_der * o[2] - xws * 
              Modelica.Media.Water.IF97_Utilities.rho_pT_der(
              p, 
              T, 
              Modelica.Media.Water.IF97_Utilities.waterBaseProp_pT(p, T), 
              p_der, 
              T_der)) / o[2] ^ 2;
            d_der := (xw_der * o[3] - (1 + xw) * o[5]) / o[3] ^ 2;
          end if;
        end if;
      end if;
    end rho_pTX_der;

    function h_dis_pTX_der
      extends Modelica.Icons.Function;
      import Modelica.Media.Air.ReferenceMoistAir.Utilities;
      input SI.AbsolutePressure p "压力";
      input SI.Temperature T "温度";
      input SI.MassFraction X[:] = Modelica.Media.Air.ReferenceMoistAir.reference_X 
        "质量分数";
      input Real p_der "压力导数";
      input Real T_der "温度导数";
      input Real X_der[:] "质量分数导数";
      output Real u_der "反应指数导数";
    protected
      Real uges;
      Real uges_der;
      Real o[7];
      Real l;
      Real invMMX[4] "摩尔质量的倒数";
      SI.MolarMass Mmix "混合物的摩尔质量";
      Real Mmix_der "混合物摩尔质量的导数";
      MassFraction[4] massFraction "组分的质量分数";
      Real[4] massFraction_der "组分质量分数的导数";
      SI.MoleFraction[4] Y 
        "湿空气各组分（H2O、N2、O2、Ar）的摩尔分数";
      Real[4] Y_der 
        "湿空气各组分（H2O、N2、O2、Ar）摩尔分数的导数";
      annotation();

    algorithm
      if (useDissociation == false) then
        //u := 0;
        u_der := 0;
      elseif (size(X, 1) > 1) then
        massFraction := {X[1], X[2] * Xi_Air[1], X[2] * Xi_Air[2], X[2] * Xi_Air[3]};
        massFraction_der := {X_der[1], X_der[2] * Xi_Air[1], X_der[2] * Xi_Air[2], 
          X_der[2] * Xi_Air[3]};
        for i in 1:4 loop
          invMMX[i] := 1 / MMX[i];
        end for;
        Mmix := 1 / (massFraction * invMMX);
        Mmix_der := -1 / (massFraction * invMMX) ^ 2 * massFraction_der * invMMX;
        for i in 1:4 loop
          Y[i] := Mmix * massFraction[i] / MMX[i];
          Y_der[i] := (Mmix_der * massFraction[i] + Mmix * massFraction_der[i]) / MMX[
            i];
        end for;
        uges := 1 + Utilities.ReactionIndices.U2(
          p, 
          T, 
          Y) + Utilities.ReactionIndices.U3(
          p, 
          T, 
          Y) + Utilities.ReactionIndices.U4(
          p, 
          T, 
          Y) + Utilities.ReactionIndices.U5(
          p, 
          T, 
          Y) + Utilities.ReactionIndices.U6(
          p, 
          T, 
          Y);
        uges_der := Utilities.ReactionIndices.U2_der(
          p, 
          T, 
          Y, 
          p_der, 
          T_der, 
          Y_der) + Utilities.ReactionIndices.U3_der(
          p, 
          T, 
          Y, 
          p_der, 
          T_der, 
          Y_der) + Utilities.ReactionIndices.U4_der(
          p, 
          T, 
          Y, 
          p_der, 
          T_der, 
          Y_der) + Utilities.ReactionIndices.U5_der(
          p, 
          T, 
          Y, 
          p_der, 
          T_der, 
          Y_der) + Utilities.ReactionIndices.U6_der(
          p, 
          T, 
          Y, 
          p_der, 
          T_der, 
          Y_der);
        o[1] := (Utilities.ReactionIndices.U2_der(
          p, 
          T, 
          Y, 
          p_der, 
          T_der, 
          Y_der) * Utilities.ReactionIndices.V2(T) + 
          Utilities.ReactionIndices.U2(
          p, 
          T, 
          Y) * Utilities.ReactionIndices.V2_der(T, T_der)) / Utilities.ReactionIndices.BB[
          2];
        o[2] := (Utilities.ReactionIndices.U3_der(
          p, 
          T, 
          Y, 
          p_der, 
          T_der, 
          Y_der) * Utilities.ReactionIndices.V3(T) + 
          Utilities.ReactionIndices.U3(
          p, 
          T, 
          Y) * Utilities.ReactionIndices.V3_der(T, T_der)) / Utilities.ReactionIndices.BB[
          3];
        o[3] := (Utilities.ReactionIndices.U4_der(
          p, 
          T, 
          Y, 
          p_der, 
          T_der, 
          Y_der) * Utilities.ReactionIndices.V4(T) + 
          Utilities.ReactionIndices.U4(
          p, 
          T, 
          Y) * Utilities.ReactionIndices.V4_der(T, T_der)) / Utilities.ReactionIndices.BB[
          4];
        o[4] := (Utilities.ReactionIndices.U5_der(
          p, 
          T, 
          Y, 
          p_der, 
          T_der, 
          Y_der) * Utilities.ReactionIndices.V5(T) + 
          Utilities.ReactionIndices.U5(
          p, 
          T, 
          Y) * Utilities.ReactionIndices.V5_der(T, T_der)) / Utilities.ReactionIndices.BB[
          5];
        o[5] := (Utilities.ReactionIndices.U6_der(
          p, 
          T, 
          Y, 
          p_der, 
          T_der, 
          Y_der) * Utilities.ReactionIndices.V6(T) + 
          Utilities.ReactionIndices.U6(
          p, 
          T, 
          Y) * Utilities.ReactionIndices.V6_der(T, T_der)) / Utilities.ReactionIndices.BB[
          6];
        l := (Utilities.ReactionIndices.U2(
          p, 
          T, 
          Y) * Utilities.ReactionIndices.V2(T) / Utilities.ReactionIndices.BB[2] 
          + Utilities.ReactionIndices.U3(
          p, 
          T, 
          Y) * Utilities.ReactionIndices.V3(T) / Utilities.ReactionIndices.BB[3] 
          + Utilities.ReactionIndices.U4(
          p, 
          T, 
          Y) * Utilities.ReactionIndices.V4(T) / Utilities.ReactionIndices.BB[4] 
          + Utilities.ReactionIndices.U5(
          p, 
          T, 
          Y) * Utilities.ReactionIndices.V5(T) / Utilities.ReactionIndices.BB[5] 
          + Utilities.ReactionIndices.U6(
          p, 
          T, 
          Y) * Utilities.ReactionIndices.V6(T) / Utilities.ReactionIndices.BB[6]);
        o[6] := -2 * T * (Utilities.ReactionIndices.U2(
          p, 
          T, 
          Y) * Utilities.ReactionIndices.V2(T) / Utilities.ReactionIndices.BB[2] 
          + Utilities.ReactionIndices.U3(
          p, 
          T, 
          Y) * Utilities.ReactionIndices.V3(T) / Utilities.ReactionIndices.BB[3] 
          + Utilities.ReactionIndices.U4(
          p, 
          T, 
          Y) * Utilities.ReactionIndices.V4(T) / Utilities.ReactionIndices.BB[4] 
          + Utilities.ReactionIndices.U5(
          p, 
          T, 
          Y) * Utilities.ReactionIndices.V5(T) / Utilities.ReactionIndices.BB[5] 
          + Utilities.ReactionIndices.U6(
          p, 
          T, 
          Y) * Utilities.ReactionIndices.V6(T) / Utilities.ReactionIndices.BB[6]) 
          - T ^ 2 * sum(o[1:5]);
        o[7] := uges_der * sum(massFraction[j] / MMX[j] for j in 1:4) + uges * sum(
          massFraction_der[j] / MMX[j] for j in 1:4);
        u_der := (o[6] * (uges * sum(massFraction[j] / MMX[j] for j in 1:4)) - l * o[7]) 
          / (uges * sum(massFraction[j] / MMX[j] for j in 1:4)) ^ 2;

      end if;
    end h_dis_pTX_der;

    function h_pTX_der "湿空气比焓导数"
      extends Modelica.Icons.Function;
      input SI.AbsolutePressure p "压力";
      input SI.Temperature T "温度";
      input SI.MassFraction X[:] = Modelica.Media.Air.ReferenceMoistAir.reference_X 
        "质量分数";
      input Real p_der "压力导数";
      input Real T_der "温度导数";
      input Real X_der[:] "质量分数导数";
      output Real h_der "比焓导数";

    protected
      SI.SpecificEnthalpy h;
      Real xw;
      Real xw_der;
      Real xws;
      Real xws_der;
      Real pd;
      Real pd_der;
      Real pl;
      Real pl_der;
      annotation();

    algorithm
      if (X[1] == 0) then
        h_der := Modelica.Media.Air.ReferenceAir.Air_Utilities.h_pT_der(
          p, 
          T, 
          Modelica.Media.Air.ReferenceAir.Air_Utilities.airBaseProp_pT(p, T), 
          p_der, 
          T_der);
      else
        pd := Modelica.Media.Air.ReferenceMoistAir.Utilities.pd_pTX(
          p, 
          T, 
          X);
        pd_der := Modelica.Media.Air.ReferenceMoistAir.Utilities.pd_pTX_der(
          p, 
          T, 
          X, 
          p_der, 
          T_der, 
          X_der);
        pl := p - pd;
        pl_der := p_der - pd_der;
        xw := X[1] / (1 - X[1]);
        xw_der := (X_der[1]) / (1 - X[1]) ^ 2;
        xws := Modelica.Media.Air.ReferenceMoistAir.Utilities.xws_pT(p, T);
        xws_der := xws_pT_der(
          p, 
          T, 
          p_der, 
          T_der);
        if ((xw <= xws) or (xws == -1)) then
          if (T >= 773.15) then
            h_der := Modelica.Media.Air.ReferenceAir.Air_Utilities.h_pT_der(
              pl, 
              T, 
              Modelica.Media.Air.ReferenceAir.Air_Utilities.airBaseProp_pT(
              pl, T), 
              pl_der, 
              T_der) + xw_der * 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.h_pT(pd, 
              T) + xw * 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.h_pT_der(
              pd, 
              T, 
              0, 
              pd_der, 
              T_der) + xw_der * 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.h_dis_pTX(
              p, 
              T, 
              X) + xw * 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.h_dis_pTX_der(
              p, 
              T, 
              X, 
              p_der, 
              T_der, 
              X_der);

          else
            h_der := Modelica.Media.Air.ReferenceAir.Air_Utilities.h_pT_der(
              pl, 
              T, 
              Modelica.Media.Air.ReferenceAir.Air_Utilities.airBaseProp_pT(
              pl, T), 
              pl_der, 
              T_der) + xw_der * 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.h_pT(pd, 
              T) + xw * 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.h_pT_der(
              pd, 
              T, 
              0, 
              pd_der, 
              T_der);

          end if;
        else
          if (T < 273.16) then
            h_der := Modelica.Media.Air.ReferenceAir.Air_Utilities.h_pT_der(
              pl, 
              T, 
              Modelica.Media.Air.ReferenceAir.Air_Utilities.airBaseProp_pT(
              pl, T), 
              pl_der, 
              T_der) + xws_der * 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.h_pT(pd, 
              T) + xws * 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.h_pT_der(
              pd, 
              T, 
              0, 
              pd_der, 
              T_der) + xw_der * 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.h_pT(
              p, T) + xw * 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.h_pT_der(
              p, 
              T, 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.ice09BaseProp_pT(
              p, T), 
              p_der, 
              T_der) - xws_der * 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.h_pT(
              p, T) - xws * 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.h_pT_der(
              p, 
              T, 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.ice09BaseProp_pT(
              p, T), 
              p_der, 
              T_der);

          else
            h_der := Modelica.Media.Air.ReferenceAir.Air_Utilities.h_pT_der(
              pl, 
              T, 
              Modelica.Media.Air.ReferenceAir.Air_Utilities.airBaseProp_pT(
              p, T), 
              pl_der, 
              T_der) + xws_der * 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.h_pT(pd, 
              T) + xws * 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.h_pT_der(
              pd, 
              T, 
              0, 
              pd_der, 
              T_der) + xw_der * Modelica.Media.Water.IF97_Utilities.h_pT(p, T) 
              + xw * Modelica.Media.Water.IF97_Utilities.h_pT_der(
              p, 
              T, 
              Modelica.Media.Water.IF97_Utilities.waterBaseProp_pT(p, T), 
              p_der, 
              T_der) - xws_der * Modelica.Media.Water.IF97_Utilities.h_pT(p, 
              T) - xws * Modelica.Media.Water.IF97_Utilities.h_pT_der(
              p, 
              T, 
              Modelica.Media.Water.IF97_Utilities.waterBaseProp_pT(p, T), 
              p_der, 
              T_der);

          end if;
        end if;
        if ((xw <= xws) or (xws == -1)) then
          if (T >= 773.15) then
            h := Modelica.Media.Air.ReferenceAir.Air_Utilities.h_pT(pl, T) + xw 
              * Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.h_pT(pd, 
              T) + (1 + xw) * 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.h_dis_pTX(
              p, 
              T, 
              X);
          else
            h := Modelica.Media.Air.ReferenceAir.Air_Utilities.h_pT(pl, T) + xw 
              * Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.h_pT(pd, 
              T);
          end if;
        else
          if (T < 273.16) then
            h := Modelica.Media.Air.ReferenceAir.Air_Utilities.h_pT(pl, T) + 
              xws * Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.h_pT(
              pd, T) + (xw - xws) * 
              Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.h_pT(
              p, T);
          else
            h := Modelica.Media.Air.ReferenceAir.Air_Utilities.h_pT(pl, T) + 
              xws * Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.h_pT(
              pd, T) + (xw - xws) * Modelica.Media.Water.IF97_Utilities.h_pT(p, T);
          end if;
        end if;
        h_der := (h_der * (1 + xw) - h * xw_der) / (1 + xw) ^ 2;
      end if;
    end h_pTX_der;

    function u_pTX_der "内能导数"
      extends Modelica.Icons.Function;
      input SI.AbsolutePressure p "压力";
      input SI.Temperature T "温度";
      input SI.MassFraction X[:] = Modelica.Media.Air.ReferenceMoistAir.reference_X 
        "质量分数";
      input Real p_der "压力导数";
      input Real T_der "温度导数";
      input Real X_der[:] "质量分数导数";
      output Real u_der "比熵导数";
      annotation();

    algorithm
      u_der := Modelica.Media.Air.ReferenceMoistAir.Utilities.h_pTX_der(
        p, 
        T, 
        X, 
        p_der, 
        T_der, 
        X_der) - (p_der * 
        Modelica.Media.Air.ReferenceMoistAir.Utilities.rho_pTX(
        p, 
        T, 
        X) - p * Modelica.Media.Air.ReferenceMoistAir.Utilities.rho_pTX_der(
        p, 
        T, 
        X, 
        p_der, 
        T_der, 
        X_der)) / Modelica.Media.Air.ReferenceMoistAir.Utilities.rho_pTX(
        p, 
        T, 
        X) ^ 2;
    end u_pTX_der;
    annotation();
  end Utilities;
  annotation(Documentation(info="<html><p>
在143.15开尔文至2000开尔文的压力高达10 MPa的范围内计算湿空气的流体性质。这个湿空气模型基于Hellriegel的毕业论文[10]，稍作修改。湿空气被视为真实流体空气和水的理想混合物。
</p>
<h4>限制</h4><p>
此库提供的函数应在参考文献中指定的限制范围内使用。
</p>
<li>
<strong>611.2 Pa ≤ p ≤ 10 MPa</strong></li>
<li>
<strong>143.15 K ≤ T ≤ 2000 K</strong></li>
<h4>用法</h4><p>
MoistAir库可以像其他介质模型一样使用（详见<a href=\"modelica://Modelica.Media.UsersGuide\" target=\"\">Media库用户指南</a>&nbsp;）。该库定义了两个布尔常量 <strong>useEnhancementFactor</strong> 和 <strong>useDissociation</strong>，可以让用户对计算进行精细控制。
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>常量</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>默认值</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>含义</strong></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">useEnhancementFactor</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">false</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">在计算湿空气中水的饱和分压时使用了增强因子。它总是非常接近1，除了高压（&gt;2 MPa）和低温度（&lt;233.15 K）的情况。对于压力小于1 MPa的情况，可以将此因子安全地设为1。它的计算非常昂贵，因为只能通过迭代方法计算。</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">useDissociation</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">true</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">考虑了解离效应，适用于温度大于773.15 K的情况。</td></tr></tbody></table><h4>计算算法</h4><h5>符号说明</h5><table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">p</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">混合气压力，单位 Pa</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">T</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">温度，单位 K</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">x<sub>w</sub></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">绝对湿度，单位 kg(水)/kg(干空气)</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">x<sub>ws</sub></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">饱和边界上的绝对湿度，单位 kg(水)/kg(干空气)</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">φ</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">相对湿度（仅对非饱和湿空气定义）</td></tr></tbody></table><h5>非饱和和饱和湿空气 (0 ≤ x<sub>w</sub> ≤ x<sub>ws</sub>)</h5><p>
干空气和蒸汽的理想混合物
</p>
<li>
干空气: </li>
<li>
d,h,u,s,c<sub>p</sub> 参考文献[1]</li>
<li>
λ, η 参考文献[2]</li>
<li>
蒸汽: </li>
<li>
液滴的d,h,u,s,c<sub>p</sub> 参考文献[4]</li>
<li>
273.15 K ≤ T ≤ 1073.15 K 的液滴的 λ, η 参考文献[5]和[6]</li>
<li>
T &lt; 273.15 K 或 T &gt; 1073.15 K 的液滴的 λ, η 参考文献[12]</li>
<h5>过饱和湿空气 (液雾和冰雾)</h5><p>
<sub><strong>液雾 (xw &gt; xwsw) 且 T ≥ 273.16 K</strong></sub>
</p>
<p>
饱和湿空气和水的理想混合物
</p>
<li>
饱和湿空气 (见上文)</li>
<li>
液滴的d,h,u,s 参考文献[4]</li>
<li>
c<sub>p</sub> 未定义</li>
<li>
液滴的λ, η 参考文献[5]和[6]</li>
<p>
<sub><strong>冰雾 (xw &gt; xwsw) 且 T &lt; 273.16 K</strong></sub>
</p>
<p>
饱和湿空气和冰的理想混合物
</p>
<li>
饱和湿空气 (见上文)</li>
<li>
冰晶的d,h,u,s 参考文献[7]</li>
<li>
c<sub>p</sub> 未定义</li>
<li>
冰的λ 为常数值</li>
<li>
冰的η 被忽略</li>
<h5>湿空气中水的饱和压力</h5><p>
湿空气中水的饱和压力 p<sub>ds</sub> 由 p<sub>ds</sub> = f*p<sub>sat</sub> 计算，其中
</p>
<li>
f 是来自[9]和[3]的增强因子</li>
<li>
对于 T ≥ 273.16 K，p<sub>sat</sub> 是来自[4]的饱和压力</li>
<li>
对于 T &lt; 273.16 K，p<sub>sat</sub> 是来自[8]的饱和压力</li>
<h5>解离</h5><p>
对于高于773.15 K的温度，考虑了解离效应。解离模型按照[11]进行建模。对于高温下的湿空气，具有0 kg(水)/kg(干空气)（即干空气）的计算值可能与Modelica.Media.Air.ReferenceAir库计算的值不同，因后者未考虑解离作用。
</p>
<h4>参考文献</h4><p>
[1] <strong>Thermodynamic Properties of Air and Mixtures of Nitrogen, Argon, and Oxygen From 60 to 2000 K at Pressures to 2000 MPa</strong>. J. Phys. Chem. Ref. Data, Vol. 29, No. 3, 2000.<br>
</p>
<p>
[2] <strong>Viscosity and Thermal Conductivity Equations for Nitrogen, Oxygen, Argon, and Air</strong>. International Journal of Thermophysics, Vol. 25, No. 1, January 2004<br>
</p>
<p>
[3] <strong>Revised Release on the IAPWS Formulation 1995 for the Thermodynamic Properties of Ordinary Water Substance for General and Scientific Use</strong>. 2009 International Association for the Properties of Water and Steam.<br>
</p>
<p>
[4] <strong>Revised Release on the IAPWS Industrial Formulation 1997 for the Thermodynamic Properties of Water and Steam</strong>. 2007 International Association for the Properties of Water and Steam.<br>
</p>
<p>
[5] <strong>Release on the IAPWS Formulation 2008 for the Viscosity of Ordinary Water Substance</strong>. 2008 International Association for the Properties of Water and Steam<br>
</p>
<p>
[6] <strong>Release on the IAPWS Formulation 2011 for the Thermal Conductivity of Ordinary Water Substance</strong>. 2011 International Association for the Properties of Water and Steam.<br>
</p>
<p>
[7] <strong>Revised Release on the Equation of State 2006 for H2O Ice Ih</strong>. 2009 International Association for the Properties of Water and Steam.<br>
</p>
<p>
[8] <strong>Revised Release on the Pressure along the Melting and Sublimation Curves of Ordinary Water Substance</strong>. 2011 International Association for the Properties of Water and Steam.<br>
</p>
<p>
[9] <strong>Determination of Thermodynamic and Transport Properties of Humid Air for Power-Cycle Calculations</strong>. 2009 PTB, Braunschweig, Germany.<br>
</p>
<p>
[10] <strong>Berechnung der thermodynamischen Zustandsfunktionen von feuchter Luft in energietechnischen Prozessmodellierungen</strong>. 2001 Diplomarbeit, Zittau.<br>
</p>
<p>
[11] <strong>Thermodynamische Stoffwerte von feuchter Luft und Verbrennungsgasen</strong>. 2003 VDI-Richtlinie 4670.<br>
</p>
<p>
[12] <strong>Wärmeübertragung in Dampferzeugern und Wärmetauschern</strong>. 1985 FDBR-Fachbuchreihe, Bd. 2, Vulkan Verlag Essen.<br>
</p>
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
该库开发的验证报告可以在<a href=\"modelica://Modelica/Resources/Documentation/Media/MoMoLib_VerificationResults_XRG.pdf\" target=\"\">这里</a>&nbsp;找到。
</p>
<h4>致谢</h4><p>
本库由XRG Simulation GmbH作为<a href=\"http://www.cleansky.eu/\" target=\"\">Clean Sky</a>&nbsp; JTI项目的一部分开发（项目名称：MoMoLib-Modelica Model Library Development for Media, Magnetic Systems and Wavelets; 项目编号：296369; 主题：JTI-CS-2011-1-SGO-02-026: Modelica Model Library Development Part I）。欧盟对该库开发的部分财务支持表示感谢。
</p>
<p>
本库的部分内容参考了在隆德大学开发的热流体库（<a href=\"http://thermofluid.sourceforge.net/\" target=\"\">http://thermofluid.sourceforge.net</a>&nbsp;）。
</p>
<p>
版权所有 &copy; 2013-2020，Modelica Association 和贡献者
</p>
<p>
<br>
</p>
</html>"));
end ReferenceMoistAir;