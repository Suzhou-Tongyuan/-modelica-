within Modelica.Media.Air;
package MoistAir "Air: 湿空气模型(190 ... 647 K)"
  extends Interfaces.PartialCondensingGases(
    mediumName = "Moist air", 
    substanceNames = {"water", "air"}, 
    final reducedX = true, 
    final singleState = false, 
    reference_X = {0.01, 0.99}, 
    fluidConstants = {IdealGases.Common.FluidData.H2O, IdealGases.Common.FluidData.N2}, 
    Temperature(min = 190, max = 647));

  import Modelica.Media.IdealGases.Common.Functions;
  constant Integer Water = 1 
    "水的索引（在substanceNames、massFractions X等中）";
  constant Integer Air = 2 
    "空气的索引（在substanceNames、massFractions X等中）";
  //     constant SI.Pressure psat_low=saturationPressureWithoutLimits(200.0);
  //     constant SI.Pressure psat_high=saturationPressureWithoutLimits(422.16);
  constant Real k_mair = steam.MM / dryair.MM "摩尔质量比";

  constant IdealGases.Common.DataRecord dryair = IdealGases.Common.SingleGasesData.Air;
  constant IdealGases.Common.DataRecord steam = IdealGases.Common.SingleGasesData.H2O;
  constant SI.MolarMass[2] MMX = {steam.MM, dryair.MM} 
    "组分的摩尔质量";

  import Modelica.Media.Interfaces;
  import Modelica.Math;
  import Modelica.Constants;
  import Modelica.Media.IdealGases.Common.SingleGasNasa;
  import Modelica.Media.Interfaces.Choices.ReferenceEnthalpy;

  redeclare record extends ThermodynamicState 
    "湿空气的热力学状态记录"
    annotation();
  end ThermodynamicState;

  redeclare replaceable model extends BaseProperties(
    T(stateSelect = if preferredMediumStates then StateSelect.prefer else 
    StateSelect.default), 
    p(stateSelect = if preferredMediumStates then StateSelect.prefer else 
    StateSelect.default), 
    Xi(each stateSelect = if preferredMediumStates then StateSelect.prefer 
    else StateSelect.default), 
    final standardOrderComponents = true) "湿空气基本属性记录"

    /* p、T、X=X[水]作为首选状态，因为只有这样才能以递归序列计算所有其他量。
    如果选择其他变量作为状态，静态状态选择就不再可能，就会出现非线性代数方程。
    */
    MassFraction x_water "总水量/干空气质量";
    Real phi "相对湿度";

  protected
    MassFraction X_liquid "液态或固态水的质量分数";
    MassFraction X_steam "水蒸气的质量分数";
    MassFraction X_air "空气的质量分数";
    MassFraction X_sat 
      "水蒸汽在饱和边界的质量分数，单位为 kg_water/kg_moistair";
    MassFraction x_sat 
      "水蒸汽在饱和边界的质量含量，单位为 kg_water/kg_dryair";
    AbsolutePressure p_steam_sat "蒸汽的部分饱和压力";
  equation
    assert(T >= 190 and T <= 647, "
温度 T 不在允许范围内
190.0 K <= (T =" 
      + String(T) + " K) <= 647.0 K
要求来自介质模型 \"" 
      + mediumName + "\".");
    MM = 1 / (Xi[Water] / MMX[Water] + (1.0 - Xi[Water]) / MMX[Air]);

    p_steam_sat = min(saturationPressure(T), 0.999 * p);
    X_sat = min(p_steam_sat * k_mair / max(100 * Constants.eps, p - p_steam_sat) * (1 
      - Xi[Water]), 1.0) 
      "相对于实际水量的饱和水含量";
    X_liquid = max(Xi[Water] - X_sat, 0.0);
    X_steam = Xi[Water] - X_liquid;
    X_air = 1 - Xi[Water];

    h = specificEnthalpy_pTX(
      p, 
      T, 
      Xi);
    R_s = dryair.R_s * (X_air / (1 - X_liquid)) + steam.R_s * X_steam / (1 - X_liquid);
    //
    u = h - R_s * T;
    d = p / (R_s * T);
    /* 注意，u 和 d 是在假设液态水的容积相对于空气和蒸汽的容积可以忽略的情况下计算的
    */
    state.p = p;
    state.T = T;
    state.X = X;

    // x 是每单位干空气的质量！
    x_sat = k_mair * p_steam_sat / max(100 * Constants.eps, p - p_steam_sat);
    x_water = Xi[Water] / max(X_air, 100 * Constants.eps);
    phi = p / p_steam_sat * Xi[Water] / (Xi[Water] + k_mair * X_air);
    annotation(Documentation(info = "<html>
<p>该模型根据三个独立的（热力学或数值）状态变量计算湿空气的热力学性质。首选的数值状态是温度 T、压力 p 和包含水质量分数的简化组分向量 Xi。作为状态方程，使用<strong>理想气体定律</strong>，并适用相关限制条件。当存在液态水时，该模型也可以在<strong>雾区</strong>中使用。然而，假设液态水的容积相对于气相可以忽略。热属性的计算基于<a href=\"modelica://Modelica.Media.Air.DryAirNasa\">干空气</a>和水（来源：VDI- Wärmeatlas）的属性数据。除了标准的热力学变量外，模型还提供<strong>绝对和相对湿度</strong>，分别表示为 x_water 和 phi。大写 X 表示相对于湿空气质量的绝对湿度，而相对于干空气质量的绝对湿度在整个模型中用小写 x 表示。有关更多信息，请参见<a href=\"modelica://Modelica.Media.Air.MoistAir\">库描述</a>。</p>
</html>"  ));
  end BaseProperties;

  redeclare function setState_pTX 
    "计算热力学状态，作为压力 p、温度 T 和组分 X 的函数"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "压力";
    input Temperature T "温度";
    input MassFraction X[:] = reference_X "质量分数";
    output ThermodynamicState state "热力学状态";
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
    annotation(smoothOrder = 2, Documentation(info="<html><p>
<a href=\"modelica://Modelica.Media.Air.MoistAir.ThermodynamicState\" target=\"\">热力学状态记录</a>&nbsp; &nbsp;由压力 p、温度 T 和组分 X 计算得出。<br>
</p>
</html>"));
  end setState_pTX;

  redeclare function setState_phX 
    "计算热力学状态，作为压力 p、比焓 h 和组分 X 的函数"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "压力";
    input SpecificEnthalpy h "比焓";
    input MassFraction X[:] = reference_X "质量分数";
    output ThermodynamicState state "热力学状态";
  algorithm
    state := if size(X, 1) == nX then ThermodynamicState(
      p = p, 
      T = T_phX(
      p, 
      h, 
      X), 
      X = X) else ThermodynamicState(
      p = p, 
      T = T_phX(
      p, 
      h, 
      X), 
      X = cat(
      1, 
      X, 
      {1 - sum(X)}));
    annotation(smoothOrder = 2, Documentation(info="<html><p>
<a href=\"modelica://Modelica.Media.Air.MoistAir.ThermodynamicState\" target=\"\">热力学状态记录</a>&nbsp; 由压力 p、比焓 h 和组分 X 计算得出。<br>
</p>
</html>"));
  end setState_phX;

  redeclare function setState_dTX 
    "计算热力学状态，作为密度 d、温度 T 和组分 X 的函数"
    extends Modelica.Icons.Function;
    input Density d "密度";
    input Temperature T "温度";
    input MassFraction X[:] = reference_X "质量分数";
    output ThermodynamicState state "热力学状态";
  algorithm
    state := if size(X, 1) == nX then ThermodynamicState(
      p = d * ({steam.R_s, dryair.R_s} * X) * T, 
      T = T, 
      X = X) else ThermodynamicState(
      p = d * ({steam.R_s, dryair.R_s} * cat(
      1, 
      X, 
      {1 - sum(X)})) * T, 
      T = T, 
      X = cat(
      1, 
      X, 
      {1 - sum(X)}));
    annotation(smoothOrder = 2, Documentation(info="<html><p>
<a href=\"modelica://Modelica.Media.Air.MoistAir.ThermodynamicState\" target=\"\">热力学状态记录</a>&nbsp; 由密度 d、温度 T 和组分 X 计算得出。<br>
</p>
</html>"));
  end setState_dTX;

  redeclare function extends setSmoothState 
    "计算热力学状态，使其平滑近似：如果 x > 0 则为 state_a，否则为 state_b"
    annotation();
  algorithm
    state := ThermodynamicState(
      p = Media.Common.smoothStep(
      x, 
      state_a.p, 
      state_b.p, 
      x_small), 
      T = Media.Common.smoothStep(
      x, 
      state_a.T, 
      state_b.T, 
      x_small), 
      X = Media.Common.smoothStep(
      x, 
      state_a.X, 
      state_b.X, 
      x_small));
  end setSmoothState;

  function Xsaturation 
    "计算饱和状态下每单位质量湿空气的绝对湿度，作为热力学状态记录的函数"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "热力学状态记录";
    output MassFraction X_sat "饱和边界的蒸汽质量分数";
  algorithm
    X_sat := k_mair / (state.p / min(saturationPressure(state.T), 0.999 * state.p) 
      - 1 + k_mair);
    annotation(smoothOrder = 2, Documentation(info="<html><p>
饱和状态下每单位质量湿空气的绝对湿度由热力学状态记录类中的压力和温度计算得出。注意，与 BaseProperties 模型中的 X_sat 不同，该质量分数是指饱和状态下湿空气的质量。
</p>
</html>"    ));
  end Xsaturation;

  function xsaturation 
    "计算饱和状态下每单位质量干空气的绝对湿度，作为热力学状态记录的函数"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "热力学状态记录表";
    output MassFraction x_sat "每单位质量干空气的绝对湿度";
  algorithm
    x_sat := k_mair * saturationPressure(state.T) / max(100 * Constants.eps, state.p 
      - saturationPressure(state.T));
    annotation(smoothOrder = 2, Documentation(info="<html><p>
每单位质量干空气在饱和状态下的绝对湿度由热力学状态记录中的压力和温度计算得出。
</p>
</html>"  ));
  end xsaturation;

  function xsaturation_pT 
    "计算饱和状态下每单位质量干空气的绝对湿度，作为压力 p 和温度 T 的函数"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "压力";
    input SI.Temperature T "温度";
    output MassFraction x_sat "每单位质量干空气的绝对湿度";
  algorithm
    x_sat := k_mair * saturationPressure(T) / max(100 * Constants.eps, p - 
      saturationPressure(T));
    annotation(smoothOrder = 2, Documentation(info = "<html>
<p>
每单位质量干空气在饱和状态下的绝对湿度由压力和温度计算得出。
</p>
</html>"  ));
  end xsaturation_pT;

  function massFraction_pTphi 
    "计算蒸汽质量分数，作为相对湿度 phi 和温度 T 的函数"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "压力";
    input Temperature T "温度";
    input Real phi "相对湿度 (0 ... 1.0)";
    output MassFraction X_steam "绝对湿度，蒸汽质量分数";
  protected
    constant Real k = 0.621964713077499 "摩尔质量比";
    AbsolutePressure psat = saturationPressure(T) "饱和压力";
  algorithm
    X_steam := phi * k / (k * phi + p / psat - phi);
    annotation(smoothOrder = 2, Documentation(info = "<html>
<p>
每单位质量湿空气的绝对湿度由温度、压力和相对湿度计算得出。
</p>
</html>"  ));
  end massFraction_pTphi;

  function relativeHumidity_pTX 
    "计算相对湿度，作为压力 p、温度 T 和组分 X 的函数"
    extends Modelica.Icons.Function;
    input SI.Pressure p "压力";
    input SI.Temperature T "温度";
    input SI.MassFraction[:] X "组分";
    output Real phi "相对湿度";
  protected
    SI.Pressure p_steam_sat "饱和压力";
    SI.MassFraction X_air "干空气质量分数";
  algorithm
    p_steam_sat := min(saturationPressure(T), 0.999 * p);
    X_air := 1 - X[Water];
    phi := max(0.0, min(1.0, p / p_steam_sat * X[Water] / (X[Water] + k_mair * X_air)));
    annotation(smoothOrder = 2, Documentation(info = "<html>
<p>
相对湿度由压力、温度和组分计算得出，饱和时上限为 1.0。水的质量分数是组分向量中的第一个条目。
</p>
</html>"  ));
  end relativeHumidity_pTX;

  function relativeHumidity 
    "计算相对湿度，作为热力学状态的函数"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "热力学状态记录";
    output Real phi "相对湿度";
  algorithm
    phi := relativeHumidity_pTX(
      state.p, 
      state.T, 
      state.X);
    annotation(smoothOrder = 2, Documentation(info = "<html>
<p>
相对湿度由热力学状态记录表计算得出，饱和时上限为 1.0。
</p>
</html>"        ));
  end relativeHumidity;

  /*
  redeclare function setState_psX "Return thermodynamic state as function of p, s and composition X"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "压力";
  input SpecificEntropy s "比熵";
  input MassFraction X[:]=reference_X "质量分数";
  output ThermodynamicState state;
  algorithm
  state := if size(X,1) == nX then ThermodynamicState(p=p,T=T_psX(s,p,X),X=X)
  else ThermodynamicState(p=p,T=T_psX(p,s,X), X=cat(1,X,{1-sum(X)}));
  end setState_psX;
  */

  redeclare function extends gasConstant 
    "计算理想气体常数，作为热力学状态的函数，仅适用于 phi<1"

  algorithm
    R_s := dryair.R_s * (1 - state.X[Water]) + steam.R_s * state.X[Water];
    annotation(smoothOrder = 2, Documentation(info="<html><p>
湿空气的理想气体常数由<a href=\"modelica://Modelica.Media.Air.MoistAir.ThermodynamicState\" target=\"\">热力学状态记录</a>&nbsp;计算得出，假设所有水都在气相中。
</p>
</html>"));
  end gasConstant;

  function gasConstant_X 
    "计算理想气体常数，作为组分 X 的函数"
    extends Modelica.Icons.Function;
    input SI.MassFraction X[:] "气相组分";
    output SI.SpecificHeatCapacity R_s "理想气体常数";
  algorithm
    R_s := dryair.R_s * (1 - X[Water]) + steam.R_s * X[Water];
    annotation(smoothOrder = 2, Documentation(info = "<html>
<p>
湿空气的理想气体常数由气相组分计算得出。组分向量 X 中的第一个条目是气相的蒸汽质量分数。
</p>
</html>"  ));
  end gasConstant_X;

  function saturationPressureLiquid 
    "计算饱和状态下水的饱和压力，作为温度 T 的函数，范围为 273.16 到 647.096 K"

    extends Modelica.Icons.Function;
    input SI.Temperature Tsat "饱和温度";
    output SI.AbsolutePressure psat "饱和压力";
  protected
    SI.Temperature Tcritical = 647.096 "临界温度";
    SI.AbsolutePressure pcritical = 22.064e6 "临界压力";
    Real r1 = (1 - Tsat / Tcritical) "常见子表达式";
    Real a[:] = {-7.85951783, 1.84408259, -11.7866497, 22.6807411, -15.9618719, 
      1.80122502} "系数 a[:]";
    Real n[:] = {1.0, 1.5, 3.0, 3.5, 4.0, 7.5} "系数 n[:]";
  algorithm
    psat := exp(((a[1] * r1 ^ n[1] + a[2] * r1 ^ n[2] + a[3] * r1 ^ n[3] + a[4] * r1 ^ n[4] 
      + a[5] * r1 ^ n[5] + a[6] * r1 ^ n[6]) * Tcritical) / Tsat) * pcritical;
    annotation(
      derivative = saturationPressureLiquid_der, 
      Inline = false, 
      smoothOrder = 5, 
      Documentation(info = "<html>
<p>水在三相点温度以上的饱和压力由温度计算得出。</p>
<p>资料来源: A Saul, W Wagner: &quot;普通水物质的饱和性质的国际方程&quot;, 方程 2.1</p>
</html>"));
  end saturationPressureLiquid;

  function saturationPressureLiquid_der 
    "'saturationPressureLiquid'的导函数"

    extends Modelica.Icons.Function;
    input SI.Temperature Tsat "饱和温度";
    input Real dTsat(unit = "K/s") "饱和温度导数";
    output Real psat_der(unit = "Pa/s") "饱和压力导数";
  protected
    SI.Temperature Tcritical = 647.096 "临界温度";
    SI.AbsolutePressure pcritical = 22.064e6 "临界压力";
    Real r1 = (1 - Tsat / Tcritical) "常见子表达式 1";
    Real r1_der = -1 / Tcritical * dTsat "常见子表达式 1 的导数";
    Real a[:] = {-7.85951783, 1.84408259, -11.7866497, 22.6807411, -15.9618719, 
      1.80122502} "系数 a[:]";
    Real n[:] = {1.0, 1.5, 3.0, 3.5, 4.0, 7.5} "系数 n[:]";
    Real r2 = (a[1] * r1 ^ n[1] + a[2] * r1 ^ n[2] + a[3] * r1 ^ n[3] + a[4] * r1 ^ n[4] + a[5] 
      * r1 ^ n[5] + a[6] * r1 ^ n[6]) "常见子表达式 2";
  algorithm
    // 这里使用的方法基于 Baehr: "Thermodynamik", 12th edition p.204ff, "Method of Wagner"
    //psat := exp(((a[1]*r1^n[1] + a[2]*r1^n[2] + a[3]*r1^n[3] + a[4]*r1^n[4] + a[5]*r1^n[5] + a[6]*r1^n[6])*Tcritical)/Tsat) * pcritical;
    psat_der := exp((r2 * Tcritical) / Tsat) * pcritical * ((a[1] * (r1 ^ (n[1] - 1) * n[1] 
      * r1_der) + a[2] * (r1 ^ (n[2] - 1) * n[2] * r1_der) + a[3] * (r1 ^ (n[3] - 1) * n[3] * 
      r1_der) + a[4] * (r1 ^ (n[4] - 1) * n[4] * r1_der) + a[5] * (r1 ^ (n[5] - 1) * n[5] * 
      r1_der) + a[6] * (r1 ^ (n[6] - 1) * n[6] * r1_der)) * Tcritical / Tsat - r2 * 
      Tcritical * dTsat / Tsat ^ 2);
    annotation(
      Inline = false, 
      smoothOrder = 5, 
      Documentation(info = "<html>
<p>水在三相点温度以上的饱和压力由温度计算得出。</p>
<p>资料来源: A Saul, W Wagner: &quot;普通水物质的饱和性质的国际方程&quot;, 方程 2.1</p>
</html>"  ));
  end saturationPressureLiquid_der;

  function sublimationPressureIce 
    "计算水的升华压力，作为 190 到 273.16 K 温度范围内的函数"

    extends Modelica.Icons.Function;
    input SI.Temperature Tsat "升华温度";
    output SI.AbsolutePressure psat "升华压力";
  protected
    SI.Temperature Ttriple = 273.16 "三相点温度";
    SI.AbsolutePressure ptriple = 611.657 "三相点压力";
    Real r1 = Tsat / Ttriple "常见子表达式";
    Real a[:] = {-13.9281690, 34.7078238} "系数 a[:]";
    Real n[:] = {-1.5, -1.25} "系数 n[:]";
  algorithm
    psat := exp(a[1] - a[1] * r1 ^ n[1] + a[2] - a[2] * r1 ^ n[2]) * ptriple;
    annotation(
      Inline = false, 
      smoothOrder = 5, 
      derivative = sublimationPressureIce_der, 
      Documentation(info = "<html>
<p>水在三相点温度以下的升华压力由温度计算得出。</p>
<p>资料来源: W Wagner, A Saul, A Pruss: &quot;普通水物质在熔化和升华曲线上的压力国际方程&quot;, 方程 3.5</p>
</html>"));
  end sublimationPressureIce;

  function sublimationPressureIce_der 
    "'sublimationPressureIce'的导函数"

    extends Modelica.Icons.Function;
    input SI.Temperature Tsat "升华温度";
    input Real dTsat(unit = "K/s") "升华温度导数";
    output Real psat_der(unit = "Pa/s") "升华压力导数";
  protected
    SI.Temperature Ttriple = 273.16 "三相点温度";
    SI.AbsolutePressure ptriple = 611.657 "三相点压力";
    Real r1 = Tsat / Ttriple "常见子表达式 1";
    Real r1_der = dTsat / Ttriple "常见子表达式 1 的导数";
    Real a[:] = {-13.9281690, 34.7078238} "系数 a[:]";
    Real n[:] = {-1.5, -1.25} "系数 n[:]";
  algorithm
    //psat := exp(a[1] - a[1]*r1^n[1] + a[2] - a[2]*r1^n[2]) * ptriple;
    psat_der := exp(a[1] - a[1] * r1 ^ n[1] + a[2] - a[2] * r1 ^ n[2]) * ptriple * (-(a[1] 
      * (r1 ^ (n[1] - 1) * n[1] * r1_der)) - (a[2] * (r1 ^ (n[2] - 1) * n[2] * r1_der)));
    annotation(
      Inline = false, 
      smoothOrder = 5, 
      Documentation(info = "<html>
<p>水在三相点温度以下的升华压力由温度计算得出。</p>
<p>资料来源: W Wagner, A Saul, A Pruss: &quot;普通水物质在熔化和升华曲线上的压力国际方程&quot;, 方程 3.5</p>
</html>"  ));
  end sublimationPressureIce_der;

  redeclare function extends saturationPressure 
    "计算水的饱和压力，作为 190 到 647.096 K 温度范围内的函数"

  algorithm
    psat := Utilities.spliceFunction(
      saturationPressureLiquid(Tsat), 
      sublimationPressureIce(Tsat), 
      Tsat - 273.16, 
      1.0);
    annotation(
      Inline = false, 
      smoothOrder = 5, 
      derivative = saturationPressure_der, 
      Documentation(info = "<html>
<p>
水在液体和固体区域的饱和压力使用关联函数计算。<a href=\"modelica://Modelica.Media.Air.MoistAir.sublimationPressureIce\">固体</a>和<a href=\"modelica://Modelica.Media.Air.MoistAir.saturationPressureLiquid\">液体</a>区域的函数分别使用一阶导数连续的<a href=\"modelica://Modelica.Media.Air.MoistAir.Utilities.spliceFunction\">spliceFunction</a>结合。此函数的有效范围为 190 到 647.096 K。有关使用的关联函数类型的更多信息，请参阅链接函数的文档。
</p>
</html>"  ));
  end saturationPressure;

  function saturationPressure_der 
    "'saturationPressure' 的导函数"
    extends Modelica.Icons.Function;
    input Temperature Tsat "饱和温度";
    input Real dTsat(unit = "K/s") "饱和温度的时间导数";
    output Real psat_der(unit = "Pa/s") "饱和压力的导数";

  algorithm
    /*psat := Utilities.spliceFunction(saturationPressureLiquid(Tsat),sublimationPressureIce(Tsat),Tsat-273.16,1.0);*/
    psat_der := Utilities.spliceFunction_der(
      saturationPressureLiquid(Tsat), 
      sublimationPressureIce(Tsat), 
      Tsat - 273.16, 
      1.0, 
      saturationPressureLiquid_der(Tsat = Tsat, dTsat = dTsat), 
      sublimationPressureIce_der(Tsat = Tsat, dTsat = dTsat), 
      dTsat, 
      0);
    annotation(
      Inline = false, 
      smoothOrder = 5, 
      Documentation(info = "<html>
<p>
‘<a href=\"modelica://Modelica.Media.Air.MoistAir.saturationPressure\">saturationPressure</a>’ 的导函数
</p>
</html>"      ));
  end saturationPressure_der;

  function saturationTemperature 
    "计算水的饱和温度作为压力 p 的函数"
    extends Modelica.Icons.Function;
    input SI.Pressure p "压力";
    input SI.Temperature T_min = 190 "解的下边界";
    input SI.Temperature T_max = 647 "解的上边界";
    output SI.Temperature T "饱和温度";

    function f_nonlinear "通过给定的 p 求解 p(T) 得到 T"
      extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
      input SI.Pressure p "压力";
      annotation();
    algorithm
      y := saturationPressure(Tsat = u) - p;
    end f_nonlinear;

  algorithm
    T := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
      function f_nonlinear(p = p), T_min, T_max);
    annotation(Documentation(info = "<html>
<p>
通过数值反算 <a href=\"modelica://Modelica.Media.Air.MoistAir.saturationPressure\">saturationPressure</a> 函数从（部分）压力计算饱和温度。因此需要额外的输入（或使用默认值）作为上下温度边界。
</p>
</html>"    ));
  end saturationTemperature;

  redeclare function extends enthalpyOfVaporization 
    "计算水的汽化焓作为温度 T 的函数，273.16 到 647.096 K"

  protected
    Real Tcritical = 647.096 "临界温度";
    Real dcritical = 322 "临界密度";
    Real pcritical = 22.064e6 "临界压力";
    Real n[:] = {1, 1.5, 3, 3.5, 4, 7.5} "方程 (1) 中的幂次";
    Real a[:] = {-7.85951783, 1.84408259, -11.7866497, 22.6807411, -15.9618719, 
      1.80122502} "方程 (1) 中的系数 [1]";
    Real m[:] = {1 / 3, 2 / 3, 5 / 3, 16 / 3, 43 / 3, 110 / 3} "方程 (2) 中的幂次";
    Real b[:] = {1.99274064, 1.09965342, -0.510839303, -1.75493479, -45.5170352, -6.74694450e5} 
      "方程 (2) 中的系数 [1]";
    Real o[:] = {2 / 6, 4 / 6, 8 / 6, 18 / 6, 37 / 6, 71 / 6} "方程 (3) 中的幂次";
    Real c[:] = {-2.03150240, -2.68302940, -5.38626492, -17.2991605, -44.7586581, -63.9201063} 
      "方程 (3) 中的系数 [1]";
    Real tau = 1 - T / Tcritical "温度表达式";
    Real r1 = (a[1] * Tcritical * tau ^ n[1]) / T + (a[2] * Tcritical * tau ^ n[2]) / T + (a[3] 
      * Tcritical * tau ^ n[3]) / T + (a[4] * Tcritical * tau ^ n[4]) / T + (a[5] * 
      Tcritical * tau ^ n[5]) / T + (a[6] * Tcritical * tau ^ n[6]) / T "表达式 1";
    Real r2 = a[1] * n[1] * tau ^ n[1] + a[2] * n[2] * tau ^ n[2] + a[3] * n[3] * tau ^ n[3] + a[
      4] * n[4] * tau ^ n[4] + a[5] * n[5] * tau ^ n[5] + a[6] * n[6] * tau ^ n[6] 
      "表达式 2";
    Real dp = dcritical * (1 + b[1] * tau ^ m[1] + b[2] * tau ^ m[2] + b[3] * tau ^ m[3] + b[
      4] * tau ^ m[4] + b[5] * tau ^ m[5] + b[6] * tau ^ m[6]) 
      "饱和液体的密度";
    Real dpp = dcritical * exp(c[1] * tau ^ o[1] + c[2] * tau ^ o[2] + c[3] * tau ^ o[3] + c[
      4] * tau ^ o[4] + c[5] * tau ^ o[5] + c[6] * tau ^ o[6]) 
      "饱和蒸汽的密度";
  algorithm
    r0 := -(((dp - dpp) * exp(r1) * pcritical * (r2 + r1 * tau)) / (dp * dpp * tau)) 
      "方程 (7) 和 (6) 的差值";
    annotation(
      smoothOrder = 2, 
      Documentation(info = "<html>
<p>水的汽化焓是通过在 273.16 到 647.096 K 区域的温度计算得出的。</p>
<p>来源：W Wagner, A Pruss: \"International equations for the saturation properties of ordinary water substance. Revised according to the international temperature scale of 1990\" (1993).</p>
</html>"));
  end enthalpyOfVaporization;

  function HeatCapacityOfWater 
    "计算水（仅液态）的比热容作为温度 T 的函数"
    extends Modelica.Icons.Function;
    input Temperature T "温度";
    output SpecificHeatCapacity cp_fl "液态水的比热容";

  algorithm
    cp_fl := 1e3 * (4.2166 - (T - 273.15) * (0.0033166 + (T - 273.15) * (0.00010295 
      - (T - 273.15) * (1.3819e-6 + (T - 273.15) * 7.3221e-9))));
    annotation(Documentation(info = "<html>
<p>
水（液态和固态）的比热容是使用多项式方法和来自 VDI-Waermeatlas 8 版 (Db1) 的数据计算得出的。
</p>
</html>"    ), 
      smoothOrder = 2);
  end HeatCapacityOfWater;

  redeclare function extends enthalpyOfLiquid 
    "计算液态水的焓作为温度 T 的函数（使用 'enthalpyOfWater' 代替）"

  algorithm
    h := (T - 273.15) * 1e3 * (4.2166 - 0.5 * (T - 273.15) * (0.0033166 + 0.333333 * (T 
      - 273.15) * (0.00010295 - 0.25 * (T - 273.15) * (1.3819e-6 + 0.2 * (T - 273.15) 
      * 7.3221e-9))));
    annotation(
      Inline = false, 
      smoothOrder = 5, 
      Documentation(info = "<html>
<p>
液态水的比焓是通过使用多项式方法从温度计算得出的。为了兼容性保留，建议使用 <a href=\"modelica://Modelica.Media.Air.MoistAir.enthalpyOfWater\">enthalpyOfWater</a> 代替。
</p>
</html>"    ));
  end enthalpyOfLiquid;

  redeclare function extends enthalpyOfGas 
    "计算气体（空气和蒸汽）的比焓作为温度 T 和组分 X 的函数"

  algorithm
    h := Modelica.Media.IdealGases.Common.Functions.h_Tlow(
      data = steam, 
      T = T, 
      refChoice = ReferenceEnthalpy.UserDefined, 
      h_off = 46479.819 + 2501014.5) * X[Water] + 
      Modelica.Media.IdealGases.Common.Functions.h_Tlow(
      data = dryair, 
      T = T, 
      refChoice = ReferenceEnthalpy.UserDefined, 
      h_off = 25104.684) * (1.0 - X[Water]);
    annotation(
      Inline = false, 
      smoothOrder = 5, 
      Documentation(info = "<html>
<p>
湿空气的比焓是通过温度计算的，假定所有水都是气态。组分向量 X 中的第一个条目必须是蒸汽的质量分数。对于覆盖雾区的函数，请参考 <a href=\"modelica://Modelica.Media.Air.MoistAir.h_pTX\">h_pTX</a>。
</p>
</html>"    ));
  end enthalpyOfGas;

  redeclare function extends enthalpyOfCondensingGas 
    "计算蒸汽的比焓作为温度 T 的函数"

  algorithm
    h := Modelica.Media.IdealGases.Common.Functions.h_Tlow(
      data = steam, 
      T = T, 
      refChoice = ReferenceEnthalpy.UserDefined, 
      h_off = 46479.819 + 2501014.5);
    annotation(
      Inline = false, 
      smoothOrder = 5, 
      Documentation(info = "<html>
<p>
蒸汽的比焓是通过温度计算的。
</p>
</html>"  ));
  end enthalpyOfCondensingGas;

  redeclare function extends enthalpyOfNonCondensingGas 
    "计算干空气的比焓作为温度 T 的函数"

  algorithm
    h := Modelica.Media.IdealGases.Common.Functions.h_Tlow(
      data = dryair, 
      T = T, 
      refChoice = ReferenceEnthalpy.UserDefined, 
      h_off = 25104.684);
    annotation(
      Inline = false, 
      smoothOrder = 1, 
      Documentation(info = "<html>
<p>
干空气的比焓是通过温度计算的。
</p>
</html>"  ));
  end enthalpyOfNonCondensingGas;

  function enthalpyOfWater 
    "计算近似大气压下水（固态/液态）的比焓作为温度 T 的函数"
    extends Modelica.Icons.Function;
    input SI.Temperature T "温度";
    output SI.SpecificEnthalpy h "水的比焓";
  algorithm
    /*假设常数属性的简单模型:
    液态水的比热容：4200 J/kg
    固态水的比热容：2050 J/kg
    熔融焓（液态=>固态）：333000 J/kg*/

    h := Utilities.spliceFunction(
      4200 * (T - 273.15), 
      2050 * (T - 273.15) - 333000, 
      T - 273.16, 
      0.1);
    annotation(derivative = enthalpyOfWater_der, Documentation(info = "<html>
水（液态和固态）的比焓是通过使用如下常数属性从温度计算的：<br>
<ul>
<li>液态水的比热容：4200 J/kg</li>
<li>固态水的比热容：2050 J/kg</li>
<li>熔融焓（液态=>固态）：333000 J/kg</li>
</ul>
假设压力约为 1 bar。该函数通常用于确定湿空气的液态或固态部分的比焓。
</html>"));
  end enthalpyOfWater;

  function enthalpyOfWater_der "enthalpyOfWater 的导数函数"
    extends Modelica.Icons.Function;
    input SI.Temperature T "温度";
    input Real dT(unit = "K/s") "温度的时间导数";
    output Real dh(unit = "J/(kg.s)") "比焓的时间导数";
  algorithm
    /*假设常数属性的简单模型:
    液态水的比热容：4200 J/kg
    固态水的比热容：2050 J/kg
    熔融焓（液态=>固态）：333000 J/kg*/

    //h:=Utilities.spliceFunction(4200*(T-273.15),2050*(T-273.15)-333000,T-273.16,0.1);
    dh := Utilities.spliceFunction_der(
      4200 * (T - 273.15), 
      2050 * (T - 273.15) - 333000, 
      T - 273.16, 
      0.1, 
      4200 * dT, 
      2050 * dT, 
      dT, 
      0);
    annotation(Documentation(info = "<html>
<p>
<a href=\"modelica://Modelica.Media.Air.MoistAir.enthalpyOfWater\">enthalpyOfWater</a> 的导数函数。
</p>
</html>"  ));
  end enthalpyOfWater_der;

  redeclare function extends pressure 
    "计算理想气体的压力作为热力状态的函数"

  algorithm
    p := state.p;
    annotation(smoothOrder = 2, Documentation(info = "<html>
<p>
压力根据作为简单赋值输入的热力学状态记录中计算。
</p>
</html>"    ));
  end pressure;

  redeclare function extends temperature 
    "计算理想气体的温度作为热力状态的函数"

  algorithm
    T := state.T;
    annotation(smoothOrder = 2, Documentation(info = "<html>
<p>
温度根据作为简单赋值输入的热力学状态记录中计算。
</p>
</html>"    ));
  end temperature;

  function T_phX 
    "根据压力 p、比焓 h 和组分 X 计算温度的函数"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "压力";
    input SpecificEnthalpy h "比焓";
    input MassFraction[:] X "组分的质量分数";
    output Temperature T "温度";

  protected
    function f_nonlinear "用给定的 h 解决 h_pTX(p,T,X)=T 的函数"
      extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
      input AbsolutePressure p "压力";
      input SpecificEnthalpy h "比焓";
      input MassFraction[:] X "组分的质量分数";
      annotation();
    algorithm
      y := h_pTX(p = p, T = u, X = X) - h;
    end f_nonlinear;

  algorithm
    T := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
      function f_nonlinear(p = p, h = h, X = X[1:nXi]), 190, 647);
    annotation(Documentation(info = "<html>
<p>
通过数值反算函数 <a href=\"modelica://Modelica.Media.Air.MoistAir.h_pTX\">h_pTX</a>，根据压力、比焓和组分计算温度。
</p>
</html>"  ));
  end T_phX;

  redeclare function extends density 
    "基于热力状态计算理想气体的密度"

  algorithm
    d := state.p / (gasConstant(state) * state.T);
    annotation(smoothOrder = 2, Documentation(info = "<html>
<p>
应用理想气体定律，根据热力学状态记录中的压力、温度和组分计算密度。
</p>
</html>"    ));
  end density;

  redeclare function extends specificEnthalpy 
    "基于热力状态计算湿空气的比焓"

  algorithm
    h := h_pTX(
      state.p, 
      state.T, 
      state.X);
    annotation(smoothOrder = 2, Documentation(info = "<html>
<p>
根据热力学状态记录计算湿空气的比焓。冰雾和液雾区域都包括在内。
</p>
</html>"    ));
  end specificEnthalpy;

  function h_pTX 
    "基于压力 p、温度 T 和组分 X 计算湿空气的比焓"
    extends Modelica.Icons.Function;
    input SI.Pressure p "压力";
    input SI.Temperature T "温度";
    input SI.MassFraction X[:] "湿空气的质量分数";
    output SI.SpecificEnthalpy h "在 p、T、X 下的比焓";
  protected
    SI.AbsolutePressure p_steam_sat "蒸汽的部分饱和压力";
    SI.MassFraction X_sat "每单位质量湿空气的绝对湿度";
    SI.MassFraction X_liquid "液态水的质量分数";
    SI.MassFraction X_steam "水蒸气的质量分数";
    SI.MassFraction X_air "空气的质量分数";
  algorithm
    p_steam_sat := saturationPressure(T);
    //p_steam_sat :=min(saturationPressure(T), 0.999*p);
    X_sat := min(p_steam_sat * k_mair / max(100 * Constants.eps, p - p_steam_sat) * (
      1 - X[Water]), 1.0);
    X_liquid := max(X[Water] - X_sat, 0.0);
    X_steam := X[Water] - X_liquid;
    X_air := 1 - X[Water];
    /* h        := {SingleGasNasa.h_Tlow(data=steam,  T=T, refChoice=ReferenceEnthalpy.UserDefined, h_off=46479.819+2501014.5),
    SingleGasNasa.h_Tlow(data=dryair, T=T, refChoice=ReferenceEnthalpy.UserDefined, h_off=25104.684)}*
    {X_steam, X_air} + enthalpyOfLiquid(T)*X_liquid;*/
    h := {Modelica.Media.IdealGases.Common.Functions.h_Tlow(
      data = steam, 
      T = T, 
      refChoice = ReferenceEnthalpy.UserDefined, 
      h_off = 46479.819 + 2501014.5), 
      Modelica.Media.IdealGases.Common.Functions.h_Tlow(
      data = dryair, 
      T = T, 
      refChoice = ReferenceEnthalpy.UserDefined, 
      h_off = 25104.684)} * {X_steam, X_air} + enthalpyOfWater(T) * X_liquid;
    annotation(
      derivative = h_pTX_der, 
      Inline = false, 
      Documentation(info = "<html>
<p>
通过压力、温度和组分计算湿空气的比焓，其中 X[1] 是总水质量分数。冰雾和液雾区域都包括在内。
</p>
</html>"  ));
  end h_pTX;

  function h_pTX_der "h_pTX 的导数函数"
    extends Modelica.Icons.Function;
    input SI.Pressure p "压力";
    input SI.Temperature T "温度";
    input SI.MassFraction X[:] "湿空气的质量分数";
    input Real dp(unit = "Pa/s") "压力导数";
    input Real dT(unit = "K/s") "温度导数";
    input Real dX[:](each unit = "1/s") "组分导数";
    output Real h_der(unit = "J/(kg.s)") "比焓的时间导数";
  protected
    SI.AbsolutePressure p_steam_sat "蒸汽的部分饱和压力";
    SI.MassFraction X_sat "每单位干空气质量的绝对湿度";
    SI.MassFraction X_liquid "液态/固态水质量分数";
    SI.MassFraction X_steam "水蒸气的质量分数";
    SI.MassFraction X_air "干空气的质量分数";
    SI.MassFraction x_sat 
      "饱和时每单位质量干空气的绝对湿度";
    Real dX_steam(unit = "1/s") "蒸汽质量分数的时间导数";
    Real dX_air(unit = "1/s") "干空气质量分数的时间导数";
    Real dX_liq(unit = "1/s") 
      "液态/固态水质量分数的时间导数";
    Real dps(unit = "Pa/s") "饱和压力的时间导数";
    Real dx_sat(unit = "1/s") 
      "每单位质量干空气的绝对湿度的时间导数";

  algorithm
    p_steam_sat := saturationPressure(T);
    x_sat := p_steam_sat * k_mair / max(100 * Modelica.Constants.eps, p - 
      p_steam_sat);
    X_sat := min(x_sat * (1 - X[Water]), 1.0);
    X_liquid := Utilities.smoothMax(
      X[Water] - X_sat, 
      0.0, 
      1e-5);
    X_steam := X[Water] - X_liquid;
    X_air := 1 - X[Water];

    dX_air := -dX[Water];
    dps := saturationPressure_der(Tsat = T, dTsat = dT);
    dx_sat := k_mair * (dps * (p - p_steam_sat) - p_steam_sat * (dp - dps)) / (p - 
      p_steam_sat) / (p - p_steam_sat);
    dX_liq := Utilities.smoothMax_der(
      X[Water] - X_sat, 
      0.0, 
      1e-5, 
      (1 + x_sat) * dX[Water] - (1 - X[Water]) * dx_sat, 
      0, 
      0);
    dX_steam := dX[Water] - dX_liq;

    h_der := X_steam * Modelica.Media.IdealGases.Common.Functions.h_Tlow_der(
      data = steam, 
      T = T, 
      refChoice = ReferenceEnthalpy.UserDefined, 
      h_off = 46479.819 + 2501014.5, 
      dT = dT) + dX_steam * Modelica.Media.IdealGases.Common.Functions.h_Tlow(
      data = steam, 
      T = T, 
      refChoice = ReferenceEnthalpy.UserDefined, 
      h_off = 46479.819 + 2501014.5) + X_air * 
      Modelica.Media.IdealGases.Common.Functions.h_Tlow_der(
      data = dryair, 
      T = T, 
      refChoice = ReferenceEnthalpy.UserDefined, 
      h_off = 25104.684, 
      dT = dT) + dX_air * Modelica.Media.IdealGases.Common.Functions.h_Tlow(
      data = dryair, 
      T = T, 
      refChoice = ReferenceEnthalpy.UserDefined, 
      h_off = 25104.684) + X_liquid * enthalpyOfWater_der(T = T, dT = dT) + 
      dX_liq * enthalpyOfWater(T);

    annotation(
      Inline = false, 
      smoothOrder = 1, 
      Documentation(info = "<html>
<p>
<a href=\"modelica://Modelica.Media.Air.MoistAir.h_pTX\">h_pTX</a> 的导数函数。
</p>
</html>"    ));
  end h_pTX_der;

  redeclare function extends isentropicExponent 
    "计算等熵指数（仅适用于气体部分！）"
    annotation();
  algorithm
    gamma := specificHeatCapacityCp(state) / specificHeatCapacityCv(state);
  end isentropicExponent;

  function isentropicEnthalpyApproximation 
    "根据上游属性、下游压力近似计算 h_is，仅适用于气体部分"
    extends Modelica.Icons.Function;
    input AbsolutePressure p2 "下游压力";
    input ThermodynamicState state "上游位置的热力学状态";
    output SpecificEnthalpy h_is "等熵焓";
  protected
    SpecificEnthalpy h "上游位置的比焓";
    IsentropicExponent gamma = isentropicExponent(state) "等熵指数";
  protected
    MassFraction[nX] X "完整的 X 向量";
    annotation();
  algorithm
    X := state.X;
    //  X := 如果为 reducedX 则为 cat(1,state.X,{1-sum(state.X)}) 否则为 state.X;
    h := {Modelica.Media.IdealGases.Common.Functions.h_Tlow(
      data = steam, 
      T = state.T, 
      refChoice = ReferenceEnthalpy.UserDefined, 
      h_off = 46479.819 + 2501014.5), 
      Modelica.Media.IdealGases.Common.Functions.h_Tlow(
      data = dryair, 
      T = state.T, 
      refChoice = ReferenceEnthalpy.UserDefined, 
      h_off = 25104.684)} * X;

    h_is := h + gamma / (gamma - 1.0) * (state.T * gasConstant(state)) * ((p2 / state.p) 
      ^ ((gamma - 1) / gamma) - 1.0);
  end isentropicEnthalpyApproximation;

  redeclare function extends specificInternalEnergy 
    "计算湿空气的比内能，作为热力学状态记录的函数"
    extends Modelica.Icons.Function;
  algorithm
    u := specificInternalEnergy_pTX(
      state.p, 
      state.T, 
      state.X);

    annotation(smoothOrder = 2, Documentation(info = "<html>
<p>
比内能是根据热力学状态记录中确定的，假设液体或固体水的体积可以忽略不计。
</p>
</html>"  ));
  end specificInternalEnergy;

  function specificInternalEnergy_pTX 
    "计算湿空气的比内能，作为压力 p、温度 T 和组分 X 的函数"
    extends Modelica.Icons.Function;
    input SI.Pressure p "压力";
    input SI.Temperature T "温度";
    input SI.MassFraction X[:] "湿空气的质量分数";
    output SI.SpecificInternalEnergy u "比内能";
  protected
    SI.AbsolutePressure p_steam_sat "蒸汽的部分饱和压力";
    SI.MassFraction X_liquid "液体水的质量分数";
    SI.MassFraction X_steam "水蒸气的质量分数";
    SI.MassFraction X_air "空气的质量分数";
    SI.MassFraction X_sat "每单位质量湿空气的绝对湿度";
    SI.SpecificHeatCapacity R_gas "理想气体常数";

  algorithm
    p_steam_sat := saturationPressure(T);
    X_sat := min(p_steam_sat * k_mair / max(100 * Constants.eps, p - p_steam_sat) * (
      1 - X[Water]), 1.0);
    X_liquid := max(X[Water] - X_sat, 0.0);
    X_steam := X[Water] - X_liquid;
    X_air := 1 - X[Water];
    R_gas := dryair.R_s * X_air / (1 - X_liquid) + steam.R_s * X_steam / (1 - X_liquid);
    u := X_steam * Modelica.Media.IdealGases.Common.Functions.h_Tlow(
      data = steam, 
      T = T, 
      refChoice = ReferenceEnthalpy.UserDefined, 
      h_off = 46479.819 + 2501014.5) + X_air * 
      Modelica.Media.IdealGases.Common.Functions.h_Tlow(
      data = dryair, 
      T = T, 
      refChoice = ReferenceEnthalpy.UserDefined, 
      h_off = 25104.684) + enthalpyOfWater(T) * X_liquid - R_gas * T;

    annotation(derivative = specificInternalEnergy_pTX_der, Documentation(info = 
      "<html>
<p>
比内能是根据压力 p、温度 T 和组分 X 中确定的，假设液体或固体水的体积可以忽略不计。
</p>
</html>"  ));
  end specificInternalEnergy_pTX;

  function specificInternalEnergy_pTX_der 
    "specificInternalEnergy_pTX 的导数函数"
    extends Modelica.Icons.Function;
    input SI.Pressure p "压力";
    input SI.Temperature T "温度";
    input SI.MassFraction X[:] "湿空气的质量分数";
    input Real dp(unit = "Pa/s") "压力导数";
    input Real dT(unit = "K/s") "温度导数";
    input Real dX[:](each unit = "1/s") "质量分数导数";
    output Real u_der(unit = "J/(kg.s)") "比内能导数";
  protected
    SI.AbsolutePressure p_steam_sat "蒸汽的部分饱和压力";
    SI.MassFraction X_liquid "液体水的质量分数";
    SI.MassFraction X_steam "水蒸气的质量分数";
    SI.MassFraction X_air "空气的质量分数";
    SI.MassFraction X_sat "每单位质量湿空气的绝对湿度";
    SI.SpecificHeatCapacity R_gas "理想气体常数";

    SI.MassFraction x_sat 
      "干空气的每单位质量的绝对湿度在饱和时";
    Real dX_steam(unit = "1/s") "蒸汽质量分数的时间导数";
    Real dX_air(unit = "1/s") "干空气质量分数的时间导数";
    Real dX_liq(unit = "1/s") 
      "液体/固体水质量分数的时间导数";
    Real dps(unit = "Pa/s") "饱和压力的时间导数";
    Real dx_sat(unit = "1/s") 
      "干空气的每单位质量的绝对湿度的时间导数";
    Real dR_gas(unit = "J/(kg.K.s)") "理想气体常数的时间导数";
  algorithm
    p_steam_sat := saturationPressure(T);
    x_sat := p_steam_sat * k_mair / max(100 * Modelica.Constants.eps, p - 
      p_steam_sat);
    X_sat := min(x_sat * (1 - X[Water]), 1.0);
    X_liquid := Utilities.spliceFunction(
      X[Water] - X_sat, 
      0.0, 
      X[Water] - X_sat, 
      1e-6);
    X_steam := X[Water] - X_liquid;
    X_air := 1 - X[Water];
    R_gas := steam.R_s * X_steam / (1 - X_liquid) + dryair.R_s * X_air / (1 - X_liquid);

    dX_air := -dX[Water];
    dps := saturationPressure_der(Tsat = T, dTsat = dT);
    dx_sat := k_mair * (dps * (p - p_steam_sat) - p_steam_sat * (dp - dps)) / (p - 
      p_steam_sat) / (p - p_steam_sat);
    dX_liq := Utilities.spliceFunction_der(
      X[Water] - X_sat, 
      0.0, 
      X[Water] - X_sat, 
      1e-6, 
      (1 + x_sat) * dX[Water] - (1 - X[Water]) * dx_sat, 
      0.0, 
      (1 + x_sat) * dX[Water] - (1 - X[Water]) * dx_sat, 
      0.0);
    dX_steam := dX[Water] - dX_liq;
    dR_gas := (steam.R_s * (dX_steam * (1 - X_liquid) + dX_liq * X_steam) + dryair.R_s * 
      (dX_air * (1 - X_liquid) + dX_liq * X_air)) / (1 - X_liquid) / (1 - X_liquid);

    u_der := X_steam * Modelica.Media.IdealGases.Common.Functions.h_Tlow_der(
      data = steam, 
      T = T, 
      refChoice = ReferenceEnthalpy.UserDefined, 
      h_off = 46479.819 + 2501014.5, 
      dT = dT) + dX_steam * Modelica.Media.IdealGases.Common.Functions.h_Tlow(
      data = steam, 
      T = T, 
      refChoice = ReferenceEnthalpy.UserDefined, 
      h_off = 46479.819 + 2501014.5) + X_air * 
      Modelica.Media.IdealGases.Common.Functions.h_Tlow_der(
      data = dryair, 
      T = T, 
      refChoice = ReferenceEnthalpy.UserDefined, 
      h_off = 25104.684, 
      dT = dT) + dX_air * Modelica.Media.IdealGases.Common.Functions.h_Tlow(
      data = dryair, 
      T = T, 
      refChoice = ReferenceEnthalpy.UserDefined, 
      h_off = 25104.684) + X_liquid * enthalpyOfWater_der(T = T, dT = dT) + 
      dX_liq * enthalpyOfWater(T) - dR_gas * T - R_gas * dT;
    annotation(Documentation(info = "<html>
<p>
<a href=\"modelica://Modelica.Media.Air.MoistAir.specificInternalEnergy_pTX_der\">specificInternalEnergy_pTX</a> 的导数函数。
</p></html>"    ));
  end specificInternalEnergy_pTX_der;

  redeclare function extends specificEntropy 
    "根据热力学状态记录中计算比熵，仅对 phi<1 有效"

  algorithm
    s := s_pTX(
      state.p, 
      state.T, 
      state.X);
    annotation(
      Inline = false, 
      smoothOrder = 2, 
      Documentation(info="<html><p>
比熵是根据热力学状态记录计算得出的，假设理想气体行为并包括混合熵。不考虑液体或固体水，整个水含量 X[1] 假定处于汽态（相对湿度低于 1.0）。
</p>
</html>"));
  end specificEntropy;

  redeclare function extends specificGibbsEnergy 
    "根据热力状态计算比吉布斯能，仅对 phi<1 有效"
    extends Modelica.Icons.Function;
  algorithm
    g := h_pTX(
      state.p, 
      state.T, 
      state.X) - state.T * specificEntropy(state);
    annotation(smoothOrder = 2, Documentation(info = "<html>
<p>
比吉布斯能是根据湿空气的热力学状态记录计算得出的，其中水含量低于饱和。
</p>
</html>"    ));
  end specificGibbsEnergy;

  redeclare function extends specificHelmholtzEnergy 
    "根据热力状态计算比亥姆霍兹能，仅对 phi<1 有效"
    extends Modelica.Icons.Function;
  algorithm
    f := h_pTX(
      state.p, 
      state.T, 
      state.X) - gasConstant(state) * state.T - state.T * specificEntropy(
      state);
    annotation(smoothOrder = 2, Documentation(info="<html><p>
比赫姆霍兹能是根据热力学状态记录计算得出的，其中水含量低于饱和。
</p>
</html>"  ));
  end specificHelmholtzEnergy;

  redeclare function extends specificHeatCapacityCp 
    "根据热力状态计算定压比热容，仅对 phi<1 有效"

  protected
    Real dT(unit = "s/K") = 1.0;
  algorithm
    cp := h_pTX_der(
      state.p, 
      state.T, 
      state.X, 
      0.0, 
      1.0, 
      zeros(size(state.X, 1))) * dT "Definition of cp: dh/dT @ constant p";
    //      cp:= SingleGasNasa.cp_Tlow(dryair, state.T)*(1-state.X[Water])
    //        + SingleGasNasa.cp_Tlow(steam, state.T)*state.X[Water];
    annotation(
      Inline = false, 
      smoothOrder = 2, 
      Documentation(info = "<html>
<p>
定压比热容 <strong>cp</strong> 是根据温度和组分计算得出的，用于蒸汽（X[1]）和干空气的混合物。假定所有水都处于汽态。
</p>
</html>"    ));
  end specificHeatCapacityCp;

  redeclare function extends specificHeatCapacityCv 
    "根据热力状态计算定容比热容，仅对 phi<1 有效"

  algorithm
    cv := Modelica.Media.IdealGases.Common.Functions.cp_Tlow(dryair, state.T) 
      * (1 - state.X[Water]) + 
      Modelica.Media.IdealGases.Common.Functions.cp_Tlow(steam, state.T) * 
      state.X[Water] - gasConstant(state);
    annotation(
      Inline = false, 
      smoothOrder = 2, 
      Documentation(info = "<html>
<p>
定容比热容 <strong>cv</strong> 是根据温度和组分计算得出的，用于蒸汽（X[1]）和干空气的混合物。假定所有水都处于汽态。
</p>
</html>"    ));
  end specificHeatCapacityCv;

  redeclare function extends dynamicViscosity 
    "根据热力状态计算动力黏度，有效范围从 123.15 K 到 1273.15 K"

    import Modelica.Math.Polynomials;
  algorithm
    eta := 1e-6 * Polynomials.evaluateWithRange(
      {9.7391102886305869E-15, -3.1353724870333906E-11, 4.3004876595642225E-08, 
      -3.8228016291758240E-05, 5.0427874367180762E-02, 1.7239260139242528E+01}, 
      Cv.to_degC(123.15), 
      Cv.to_degC(1273.15), 
      Cv.to_degC(state.T));
    annotation(smoothOrder = 2, Documentation(info="<html><p>
动力黏度是根据干空气的温度使用简单多项式计算的，有效范围从 123.15 K 到 1273.15 K，忽略了压力和湿度的影响。
</p>
<p>
资料来源：VDI Waermeatlas，第 8 版。
</p>
</html>"));
  end dynamicViscosity;

  redeclare function extends thermalConductivity 
    "根据热力状态计算导热系数，有效范围从 123.15 K 到 1273.15 K"
    import Modelica.Math.Polynomials;
  algorithm
    lambda := 1e-3 * Polynomials.evaluateWithRange(
      {6.5691470817717812E-15, -3.4025961923050509E-11, 5.3279284846303157E-08, 
      -4.5340839289219472E-05, 7.6129675309037664E-02, 2.4169481088097051E+01}, 
      Cv.to_degC(123.15), 
      Cv.to_degC(1273.15), 
      Cv.to_degC(state.T));

    annotation(smoothOrder = 2, Documentation(info="<html><p>
导热系数是根据干空气的温度使用简单多项式计算的，有效范围从 123.15 K 到 1273.15 K，忽略了压力和湿度的影响。
</p>
<p>
资料来源：VDI Waermeatlas，第 8 版。
</p>
</html>"));
  end thermalConductivity;

  redeclare function extends velocityOfSound
  algorithm
    a := sqrt(isentropicExponent(state) * gasConstant(state) * temperature(state));
    annotation(Documentation(revisions = "<html>
<p>2012-01-12        Stefan Wischhusen: 初始版本。</p>
</html>"));
  end velocityOfSound;

  redeclare function extends isobaricExpansionCoefficient

  algorithm
    beta := 1 / temperature(state);
    annotation(Documentation(revisions = "<html>
<p>2012-01-12        Stefan Wischhusen: 初始版本。</p>
</html>"));
  end isobaricExpansionCoefficient;

  redeclare function extends isothermalCompressibility

  algorithm
    kappa := 1 / pressure(state);
    annotation(Documentation(revisions = "<html>
<p>2012-01-12        Stefan Wischhusen: 初始版本。</p>
</html>"));
  end isothermalCompressibility;

  redeclare function extends density_derp_h

  algorithm
    ddph := 1 / (gasConstant(state) * temperature(state));

    annotation(Documentation(revisions = "<html>
<p>2012-01-12        Stefan Wischhusen: 初始版本。</p>
</html>"));
  end density_derp_h;

  redeclare function extends density_derh_p

  algorithm
    ddhp := -density(state) / (specificHeatCapacityCp(state) * temperature(state));
    annotation(Documentation(revisions = "<html>
<p>2012-01-12        Stefan Wischhusen: 初始版本。</p>
</html>"));
  end density_derh_p;

  redeclare function extends density_derp_T

  algorithm
    ddpT := 1 / (gasConstant(state) * temperature(state));

    annotation(Documentation(revisions = "<html>
<p>2012-01-12        Stefan Wischhusen: 初始版本。</p>
</html>"));
  end density_derp_T;

  redeclare function extends density_derT_p

  algorithm
    ddTp := -density(state) / temperature(state);
    annotation(Documentation(revisions = "<html>
<p>2012-01-12        Stefan Wischhusen: 初始版本。</p>
</html>"));
  end density_derT_p;

  redeclare function extends density_derX

  algorithm
    dddX[Water] := -pressure(state) * (steam.R_s - dryair.R_s) / (((steam.R_s - dryair.R_s) 
      * state.X[Water] + dryair.R_s) ^ 2 * temperature(state));
    dddX[Air] := -pressure(state) * (dryair.R_s - steam.R_s) / ((steam.R_s + (dryair.R_s - steam.R_s) * 
      state.X[Air]) ^ 2 * temperature(state));

    annotation(Documentation(revisions = "<html>
<p>2012-01-12        Stefan Wischhusen: 初始版本。</p>
<p>2019-05-14        Stefan Wischhusen: 修正导数。</p>
</html>"));
  end density_derX;

  redeclare function extends molarMass
  algorithm
    MM := Modelica.Constants.R / Modelica.Media.Air.MoistAir.gasConstant(state);
    annotation(Documentation(revisions = "<html>
<p>2012-01-12        Stefan Wischhusen: 初始版本。</p>
</html>"));
  end molarMass;

  function T_psX 
    "计算温度，作为压力 p、比熵 s 和组分 X 为函数"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "压力";
    input SpecificEntropy s "比熵";
    input MassFraction[:] X "组分的质量分数";
    output Temperature T "温度";

  protected
    function f_nonlinear "对于给定的s，解决 s_pTX(p,T,X) 关于T的方程"
      extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
      input AbsolutePressure p "压力";
      input SpecificEntropy s "比熵";
      input MassFraction[:] X "组分的质量分数";
      annotation();
    algorithm
      y := s_pTX(p = p, T = u, X = X) - s;
    end f_nonlinear;

  algorithm
    T := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
      function f_nonlinear(p = p, s = s, X = X[1:nX]), 190, 647);
    annotation(Documentation(info = "<html>
<p>
压力、比熵和组分通过数值反算函数<a href=\"modelica://Modelica.Media.Air.MoistAir.s_pTX\">s_pTX</a>计算温度。
</p></html>"    , 
      revisions = "<html>
<p>2012-01-12        Stefan Wischhusen: 初始版本。</p>
</html>"    ));
  end T_psX;

  redeclare function extends setState_psX
  algorithm
    state := if size(X, 1) == nX then ThermodynamicState(
      p = p, 
      T = T_psX(
      p, 
      s, 
      X), 
      X = X) else ThermodynamicState(
      p = p, 
      T = T_psX(
      p, 
      s, 
      X), 
      X = cat(
      1, 
      X, 
      {1 - sum(X)}));
    annotation(smoothOrder = 2, Documentation(info = "<html>
<p>
<a href=\"modelica://Modelica.Media.Air.MoistAir.ThermodynamicState\">热力学状态记录</a>是由压力p、比焓h和组分X计算得到的。
</p>
</html>"  , 
      revisions = "<html>
<p>2012-01-12        Stefan Wischhusen: 初始版本。</p>
</html>"  ));
  end setState_psX;

  function s_pTX 
    "计算湿空气的比熵，作为压力p、温度T和组分X的函数（仅适用于phi<1）"
    extends Modelica.Icons.Function;
    input SI.Pressure p "压力";
    input SI.Temperature T "温度";
    input SI.MassFraction X[:] "湿空气的质量分数";
    output SI.SpecificEntropy s "在p、T、X处的比熵";
  protected
    MoleFraction[2] Y = massToMoleFractions(X, {steam.MM, dryair.MM}) 
      "摩尔分数";

  algorithm
    s := Modelica.Media.IdealGases.Common.Functions.s0_Tlow(dryair, T) * (1 - X[Water]) 
      + Modelica.Media.IdealGases.Common.Functions.s0_Tlow(steam, T) * X[Water] 
      - Modelica.Constants.R * (Utilities.smoothMax(X[Water] / MMX[Water], 0.0, 1e-9) * Modelica.Math.log(max(Y[Water], Modelica.Constants.eps) * p / reference_p) 
      + Utilities.smoothMax((1 - X[Water]) / MMX[Air], 0.0, 1e-9) * Modelica.Math.log(max(Y[Air], Modelica.Constants.eps) * p / reference_p));
    annotation(
      derivative = s_pTX_der, 
      Inline = false, 
      Documentation(info = "<html>
<p>湿空气的比熵是根据压力、温度和组分计算得出的，其中X[1]表示总水质量分数。</p>
</html>"  , 
      revisions = "<html>
<p>2012-01-12        Stefan Wischhusen: 初始版本。</p>
<p>2019-05-14        Stefan Wischhusen: 修正计算。</p>
<p>2019-09-10        Stefan Wischhusen: 修正了压力影响（p &lt; p_ref）。</p>
</html>"  ), 
      Icon(graphics = {Text(
      extent = {{-100, 100}, {100, -100}}, 
      textColor = {255, 127, 0}, 
      textString = "f")}));
  end s_pTX;

  function s_pTX_der 
    "计算湿空气的比熵，作为压力p、温度T和组分X的函数（仅适用于phi<1）"
    extends Modelica.Icons.Function;
    input SI.Pressure p "压力";
    input SI.Temperature T "温度";
    input SI.MassFraction X[:] "湿空气的质量分数";
    input Real dp(unit = "Pa/s") "压力导数";
    input Real dT(unit = "K/s") "温度导数";
    input Real dX[nX](each unit = "1/s") "质量分数导数";
    output Real ds(unit = "J/(kg.K.s)") "在p、T、X处的比熵";
  protected
    MoleFraction[2] Y = massToMoleFractions(X, {steam.MM, dryair.MM}) 
      "摩尔分数";
    MolarMass MM "摩尔质量";

  algorithm
    MM := MMX[Water] * MMX[Air] / (X[Water] * MMX[Air] + X[Air] * MMX[Water]);

    ds := IdealGases.Common.Functions.s0_Tlow_der(
      dryair, 
      T, 
      dT) * (1 - X[Water]) + IdealGases.Common.Functions.s0_Tlow_der(
      steam, 
      T, 
      dT) * X[Water] + Modelica.Media.IdealGases.Common.Functions.s0_Tlow(dryair, T) * dX[Air] + Modelica.Media.IdealGases.Common.Functions.s0_Tlow(steam, T) * dX[Water] - Modelica.Constants.R * (1 / MMX[Water] * (Utilities.smoothMax_der(
      X[Water], 
      0.0, 
      1e-9, 
      dX[Water], 
      0.0, 
      0.0) * (Modelica.Math.log(max(Y[Water], Modelica.Constants.eps) * p / reference_p) + MM / MMX[Air]) + dp / p * Utilities.smoothMax(
      X[Water], 
      0.0, 
      1e-9)) + 1 / MMX[Air] * (Utilities.smoothMax_der(
      X[Air], 
      0.0, 
      1e-9, 
      dX[Air], 
      0.0, 
      0.0) * (Modelica.Math.log(max(Y[Air], Modelica.Constants.eps) * p / reference_p) + MM / MMX[Water]) + dp / p * Utilities.smoothMax(
      X[Air], 
      0.0, 
      1e-9)));

    annotation(
      Inline = false, 
      smoothOrder = 1, 
      Documentation(info = "<html>
<p>
湿空气的比熵是根据压力、温度和组分计算得出的，其中X[1]表示总水质量分数。
</p>
</html>"  , 
      revisions = "<html>
<p>2012-01-12        Stefan Wischhusen: 初始版本。</p>
<p>2019-05-14        Stefan Wischhusen: 修正计算。</p>
<p>2019-09-10        Stefan Wischhusen: 修正了压力影响（p &lt; p_ref）。</p>
</html>"  ), 
      Icon(graphics = {Text(
      extent = {{-100, 100}, {100, -100}}, 
      textColor = {255, 127, 0}, 
      textString = "f")}));
  end s_pTX_der;

  redeclare function extends isentropicEnthalpy 
    "等熵焓（仅适用于phi<1）"
    extends Modelica.Icons.Function;
  algorithm
    h_is := Modelica.Media.Air.MoistAir.h_pTX(
      p_downstream, 
      Modelica.Media.Air.MoistAir.T_psX(
      p_downstream, 
      Modelica.Media.Air.MoistAir.specificEntropy(refState), 
      refState.X), 
      refState.X);

    annotation(Icon(graphics = {Text(
      extent = {{-100, 100}, {100, -100}}, 
      textColor = {255, 127, 0}, 
      textString = "f")}), Documentation(revisions = "<html>
<p>2012-01-12        Stefan Wischhusen: 初始版本。</p>
</html>"));
  end isentropicEnthalpy;

  package Utilities "公用函数"
    extends Modelica.Icons.UtilitiesPackage;
    function spliceFunction "两个函数的样条插值"
      extends Modelica.Icons.Function;
      input Real pos "当 x-deltax >= 0 时计算的值";
      input Real neg "当 x+deltax <= 0 时计算的值";
      input Real x "函数参数";
      input Real deltax = 1 "在 x 周围进行样条插值的区域";
      output Real out;
    protected
      Real scaledX;
      Real scaledX1;
      Real y;
    algorithm
      scaledX1 := x / deltax;
      scaledX := scaledX1 * Modelica.Math.asin(1);
      if scaledX1 <= -0.999999999 then
        y := 0;
      elseif scaledX1 >= 0.999999999 then
        y := 1;
      else
        y := (Modelica.Math.tanh(Modelica.Math.tan(scaledX)) + 1) / 2;
      end if;
      out := pos * y + (1 - y) * neg;
      annotation(derivative = spliceFunction_der);
    end spliceFunction;

    function spliceFunction_der "样条函数的导数"
      extends Modelica.Icons.Function;
      input Real pos;
      input Real neg;
      input Real x;
      input Real deltax = 1;
      input Real dpos;
      input Real dneg;
      input Real dx;
      input Real ddeltax = 0;
      output Real out;
    protected
      Real scaledX;
      Real scaledX1;
      Real dscaledX1;
      Real y;
      annotation();
    algorithm
      scaledX1 := x / deltax;
      scaledX := scaledX1 * Modelica.Math.asin(1);
      dscaledX1 := (dx - scaledX1 * ddeltax) / deltax;
      if scaledX1 <= -0.99999999999 then
        y := 0;
      elseif scaledX1 >= 0.9999999999 then
        y := 1;
      else
        y := (Modelica.Math.tanh(Modelica.Math.tan(scaledX)) + 1) / 2;
      end if;
      out := dpos * y + (1 - y) * dneg;
      if (abs(scaledX1) < 1) then
        out := out + (pos - neg) * dscaledX1 * Modelica.Math.asin(1) / 2 / (
          Modelica.Math.cosh(Modelica.Math.tan(scaledX)) * Modelica.Math.cos(
          scaledX)) ^ 2;
      end if;
    end spliceFunction_der;

    function smoothMax
      extends Modelica.Icons.Function;
      import Modelica.Math;

      input Real x1 "平滑最大值运算的第一个参数";
      input Real x2 "平滑最大值运算的第二个参数";
      input Real dx 
        "x1 和 x2 之间的近似差异，在此之下开始正则化";
      output Real y "平滑最大值运算的结果";
    algorithm
      y := max(x1, x2) + Math.log((exp((4 / dx) * (x1 - max(x1, x2)))) + (exp((4 / 
        dx) * (x2 - max(x1, x2))))) / (4 / dx);
      annotation(smoothOrder = 2, Documentation(info = "<html>
<p>Kreisselmeier Steinhauser平滑最大值的实现</p>
</html>"      ));
    end smoothMax;

    function smoothMax_der
      extends Modelica.Icons.Function;

      import Modelica.Math.exp;
      import Modelica.Math.log;

      input Real x1 "平滑最大值运算的第一个参数";
      input Real x2 "平滑最大值运算的第二个参数";
      input Real dx 
        "x1 和 x2 之间的近似差异，在此之下开始正则化";
      input Real dx1;
      input Real dx2;
      input Real ddx;
      output Real dy "平滑最大值运算的导数";
    algorithm
      dy := (if x1 > x2 then dx1 else dx2) + 0.25 * (((4 * (dx1 - (if x1 > x2 
        then dx1 else dx2)) / dx - 4 * (x1 - max(x1, x2)) * ddx / dx ^ 2) * exp(4 * (x1 - 
        max(x1, x2)) / dx) + (4 * (dx2 - (if x1 > x2 then dx1 else dx2)) / dx - 4 * (
        x2 - max(x1, x2)) * ddx / dx ^ 2) * exp(4 * (x2 - max(x1, x2)) / dx)) * dx / (exp(4 * (
        x1 - max(x1, x2)) / dx) + exp(4 * (x2 - max(x1, x2)) / dx)) + log(exp(4 * (x1 
        - max(x1, x2)) / dx) + exp(4 * (x2 - max(x1, x2)) / dx)) * ddx);

      annotation(Documentation(info = "<html>
<p>一个Kreisselmeier Steinhauser平滑最大值的实现</p>
</html>"    ));
    end smoothMax_der;
    annotation();
  end Utilities;

annotation(Documentation(info="<html><h4>热力学模型</h4><p>
此库提供了包括雾区和零下温度在内的湿空气的完整热力学模型。 本模型的基本假设包括：
</p>
<li>
理想气体定律适用</li>
<li>
除蒸汽外，忽略其他水体积</li>
<p>
为了与此库中的其他介质保持一致，所有广延性质均以总质量表示。然而，对于湿空气，通常将绝对湿度以干空气质量表示，这在使用图表时有优势。此外，在使用相对于总质量的质量分数进行数学运算时，必须小心确保所有性质在进行数学运算时都指的是相同的水含量（如果只基于干空气，则始终如此）。因此，在“BaseProperties”模型中计算了两个绝对湿度：<strong>X</strong>表示总质量的绝对湿度，而<strong>x</strong>表示单位干空气质量的绝对湿度。此外，还计算了相对湿度<strong>phi</strong>。
</p>
<p>
在水的三相点温度0.01°C或273.16 K及相对湿度大于1时，可能存在液态和固态冰的雾，导致焓介于固态和液态雾的两个等温线之间。出于数值原因，在此模型中假定在三相点的雾区中存在50%固态和50%液态雾的共存混合物。
</p>
<h4>适用范围</h4><p>
从上述假设可知，<strong>压力</strong>应在<strong>大气</strong>条件或以下范围内（尽管几bar仍然可以接受）。此外，低温下非常高的水含量会导致不正确的密度，因为液体或固体相的体积不再可以忽略不计。该模型不提供雾区中水滴尺寸的限制或与表面结合的凝结或蒸发过程的输运信息。所有多余的水，即不处于其蒸气状态的水，被假定仍然存在于空气中，关于其能量但不涉及其空间范围。<br><br>热力学模型可用于温度范围<strong>190 ... 647 K</strong>。这适用于所有函数，除非在其描述中另有说明。但是，尽管模型在饱和温度以上的温度下工作，使用“相对湿度”一词仍然是值得怀疑的。请注意，尽管有几个函数计算纯水的性质，但它们设计用于在湿空气介质模型内使用，其中的性质主要由处于蒸气状态的空气和蒸汽主导，并非用于纯液态水应用。
</p>
<h4>输运属性</h4><p>
有几个额外的函数不需要描述热力学系统，但需要对输运过程（如热量和质量传递）进行建模，可能会被调用。它们通常忽略了湿度的影响，除非另有说明。
</p>
<h4>应用</h4><p>
该模型主要适用于常压附近含湿量可能发生相变的湿空气冷却过程，涵盖民用及工业空调系统全场景应用。另一重要应用领域是以空气为载湿介质的散料脱水工艺。工程实践中，湿空气系统设计常借助焓湿图（Psychrometric Charts）实现热力学参数可视化分析，此类图表可通过本介质属性库自动生成。该模型<a href=\"modelica://Modelica.Media.Examples.PsychrometricData\" target=\"\">PsychrometricData</a>&nbsp; 可用于此目的，以获取图表数据，如下图所示（绘图本身不是模型的一部分）。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Media/Air/Mollier.png\" alt=\"\" data-href=\"\" style=\"\"/><br><img src=\"modelica://Modelica/Resources/Images/Media/Air/PsycroChart.png\" alt=\"\" data-href=\"\" style=\"\"/>
</p>
<p>
<strong>图例：</strong> 蓝色 - 常数比焓，红色 - 常数温度，黑色 - 常数相对湿度
</p>
</html>"));
end MoistAir;