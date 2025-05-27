within Modelica.Media;
package Incompressible 
  "温度依存特性介质模型,由表格或多项式定义"
  extends Modelica.Icons.VariantsPackage;
  import Modelica.Constants;
  import Modelica.Math;

  package Examples "不可压缩介质示例"
    extends Modelica.Icons.VariantsPackage;

    package Glycol47 "1,2-Propylene glycol, 47% 与水的混合物"
      extends TableBased(
        mediumName = "Glycol-Water 47%", 
        T_min = Cv.from_degC(-30), T_max = Cv.from_degC(100), 
        TinK = false, T0 = 273.15, 
        tableDensity = 
        [-30, 1066; -20, 1062; -10, 1058; 0, 1054;
        20, 1044; 40, 1030; 60, 1015; 80, 999; 100, 984], 
        tableHeatCapacity = 
        [-30, 3450; -20, 3490; -10, 3520; 0, 3560;
        20, 3620; 40, 3690; 60, 3760; 80, 3820; 100, 3890], 
        tableConductivity = 
        [-30, 0.397; -20, 0.396; -10, 0.395; 0, 0.395;
        20, 0.394; 40, 0.393; 60, 0.392; 80, 0.391; 100, 0.390], 
        tableViscosity = 
        [-30, 0.160; -20, 0.0743; -10, 0.0317; 0, 0.0190;
        20, 0.00626; 40, 0.00299; 60, 0.00162; 80, 0.00110; 100, 0.00081], 
        tableVaporPressure = 
        [0, 500; 20, 1.9e3; 40, 5.3e3; 60, 16e3; 80, 37e3; 100, 80e3]);
      annotation(Documentation(info = "<html>

</html>"));
    end Glycol47;

    package Essotherm650 "Essotherm 导热油"
      extends TableBased(
        mediumName = "Essotherm 650", 
        T_min = Cv.from_degC(0), T_max = Cv.from_degC(320), 
        TinK = false, T0 = 273.15, 
        tableDensity = 
        [0, 909; 20, 897; 40, 884; 60, 871; 80, 859; 100, 846;
        150, 813; 200, 781; 250, 748; 300, 715; 320, 702], 
        tableHeatCapacity = 
        [0, 1770; 20, 1850; 40, 1920; 60, 1990; 80, 2060; 100, 2130;
        150, 2310; 200, 2490; 250, 2670; 300, 2850; 320, 2920], 
        tableConductivity = 
        [0, 0.1302; 20, 0.1288; 40, 0.1274; 60, 0.1260; 80, 0.1246; 100, 0.1232;
        150, 0.1197; 200, 0.1163; 250, 0.1128; 300, 0.1093; 320, 0.1079], 
        tableViscosity = [0, 14370; 20, 1917; 40, 424; 60, 134; 80, 54.5;
        100, 26.64; 150, 7.47; 200, 3.22; 250, 1.76; 300, 1.10; 320, 0.94], 
        tableVaporPressure = 
        [160, 3; 180, 10; 200, 40; 220, 100; 240, 300; 260, 600;
        280, 1600; 300, 3e3; 320, 5.5e3]);
      annotation(Documentation(info = "<html>

</html>"));
    end Essotherm650;

    model TestGlycol "测试 Glycol47 介质模型"
      extends Modelica.Icons.Example;
      package Medium = Glycol47 "介质模型 (Glycol47)" annotation();
      Medium.BaseProperties medium;

      Medium.DynamicViscosity eta = Medium.dynamicViscosity(medium.state);
      Medium.ThermalConductivity lambda = Medium.thermalConductivity(medium.state);
      Medium.SpecificEntropy s = Medium.specificEntropy(medium.state);
      Medium.SpecificHeatCapacity cv = Medium.specificHeatCapacityCv(medium.state);
      Medium.SpecificInternalEnergy u = Medium.specificInternalEnergy(medium.state);
      Medium.SpecificInternalEnergy h = Medium.specificEnthalpy(medium.state);
      Medium.SpecificInternalEnergy d = Medium.density(medium.state);
    protected
      constant SI.Time timeUnit = 1;
      constant SI.Temperature Ta = 1;
    equation
      medium.p = 1.013e5;
      medium.T = Medium.T_min + time / timeUnit * Ta;
      annotation(experiment(StopTime = 1.01));
    end TestGlycol;

    annotation(
      Documentation(info = "<html>

<p>
这个库提供了一些构建不可压缩流体介质模型的示例。该库包含：
</p>
<ul>
<li><strong>Glycol47</strong>，基于温度的密度和比热表构建的47%乙二醇水混合物模型。</li>
<li><strong>Essotherm650</strong>，也是基于表格的热油介质模型。</li>
</ul>

</html>"));
  end Examples;

  package Common "常用数据结构"
    extends Modelica.Icons.Package;

    // 基于多项式的函数输入的扩展记录
    record BaseProps_Tpoly "流体状态记录"
      extends Modelica.Icons.Record;
      SI.Temperature T "温度";
      SI.Pressure p "压力";
      annotation();
      // SI.Density d "密度";
    end BaseProps_Tpoly;
    annotation();

    // 记录 BaseProps_Tpoly_old "流体状态记录"
    // extends Modelica.Media.Interfaces.PartialMedium.ThermodynamicState;
    // // SI.SpecificHeatCapacity cp "比热容";
    // SI.Temperature T "温度";
    // SI.Pressure p "压力";
    // // SI.Density d "密度";
    // parameter Real[:] poly_rho "多项式系数";
    // parameter Real[:] poly_Cp "多项式系数";
    // parameter Real[:] poly_eta "多项式系数";
    // parameter Real[:] poly_pVap "多项式系数";
    // parameter Real[:] poly_lam "多项式系数";
    // parameter Real[:] invTK "逆温度 [1/K]";
    // end BaseProps_Tpoly_old;

  end Common;

  package TableBased "基于表格的不可压缩介质特性"
    import Modelica.Math.Polynomials;

    extends Modelica.Media.Interfaces.PartialMedium(
      ThermoStates = if enthalpyOfT then Modelica.Media.Interfaces.Choices.IndependentVariables.T 
      else Modelica.Media.Interfaces.Choices.IndependentVariables.pT, 
      final reducedX = true, 
      final fixedX = true, 
      mediumName = "tableMedium", 
    redeclare record ThermodynamicState = Common.BaseProps_Tpoly, 
      singleState = true, 
      reference_p = 1.013e5, 
      Temperature(min = T_min, max = T_max));
    // 在实际介质中设置的常数
    constant Boolean enthalpyOfT = true 
      "如果焓只是温度 T 的函数（忽略了压力依赖性），则为 true";
    constant Boolean densityOfT = size(tableDensity, 1) > 1 
      "如果密度是温度的函数，则为 true";
    constant SI.Temperature T_min 
      "介质模型有效的最低温度";
    constant SI.Temperature T_max 
      "介质模型有效的最高温度";
    constant Temperature T0 = 273.15 "参考温度";
    constant SpecificEnthalpy h0 = 0 "在 T0, reference_p处的参考焓";
    constant SpecificEntropy s0 = 0 "在 T0, reference_p处的参考熵";
    constant MolarMass MM_const = 0.1 "摩尔质量";
    constant Integer npol = 2 "用于拟合的多项式的次数";
    constant Integer npolDensity = npol 
      "用于拟合 rho(T) 的多项式的次数";
    constant Integer npolHeatCapacity = npol 
      "用于拟合 Cp(T) 的多项式的次数";
    constant Integer npolViscosity = npol 
      "用于拟合 eta(T) 的多项式的次数";
    constant Integer npolVaporPressure = npol 
      "用于拟合 pVap(T) 的多项式的次数";
    constant Integer npolConductivity = npol 
      "用于拟合 lambda(T) 的多项式的次数";
    constant Integer neta = size(tableViscosity, 1) 
      "用于粘度的数据点数";
    constant Real[:,2] tableDensity "rho(T) 表";
    constant Real[:,2] tableHeatCapacity "Cp(T) 表";
    constant Real[:,2] tableViscosity "eta(T) 表";
    constant Real[:,2] tableVaporPressure "pVap(T) 表";
    constant Real[:,2] tableConductivity "lambda(T) 表";
    //    constant Real[:] TK=tableViscosity[:,1]+T0*ones(neta) "黏度温度";
    constant Boolean TinK "如果 T[K]，开尔文用于表温度，则为 true";
    constant Boolean hasDensity = not (size(tableDensity, 1) == 0) 
      "如果表 tableDensity 存在，则为 true";
    constant Boolean hasHeatCapacity = not (size(tableHeatCapacity, 1) == 0) 
      "如果表 tableHeatCapacity 存在，则为 true";
    constant Boolean hasViscosity = not (size(tableViscosity, 1) == 0) 
      "如果表 tableViscosity 存在，则为 true";
    constant Boolean hasVaporPressure = not (size(tableVaporPressure, 1) == 0) 
      "如果表 tableVaporPressure 存在，则为 true";
    final constant Real invTK[neta] = if size(tableViscosity, 1) > 0 then 
      (if TinK then 1 ./ tableViscosity[:,1] else 1 ./ Cv.from_degC(tableViscosity[:,1])) else fill(0, neta);
    final constant Real poly_rho[:] = if hasDensity then 
      Polynomials.fitting(tableDensity[:,1], tableDensity[:,2], npolDensity) else 
      zeros(npolDensity + 1);
    final constant Real poly_Cp[:] = if hasHeatCapacity then 
      Polynomials.fitting(tableHeatCapacity[:,1], tableHeatCapacity[:,2], npolHeatCapacity) else 
      zeros(npolHeatCapacity + 1);
    final constant Real poly_eta[:] = if hasViscosity then 
      Polynomials.fitting(invTK, Math.log(tableViscosity[:,2]), npolViscosity) else 
      zeros(npolViscosity + 1);
    final constant Real poly_pVap[:] = if hasVaporPressure then 
      Polynomials.fitting(tableVaporPressure[:,1], tableVaporPressure[:,2], npolVaporPressure) else 
      zeros(npolVaporPressure + 1);
    final constant Real poly_lam[:] = if size(tableConductivity, 1) > 0 then 
      Polynomials.fitting(tableConductivity[:,1], tableConductivity[:,2], npolConductivity) else 
      zeros(npolConductivity + 1);
    function invertTemp "反转温度的函数"
      extends Modelica.Icons.Function;
      input Real[:] table "表温度数据";
      input Boolean Tink "摄氏或开尔文的标志";
      output Real invTable[size(table, 1)] "反转的温度";
    algorithm
      for i in 1:size(table, 1) loop
        invTable[i] := if TinK then 1 / table[i] else 1 / Cv.from_degC(table[i]);
      end for;
      annotation(smoothOrder = 3);
    end invertTemp;

    redeclare model extends BaseProperties(
      final standardOrderComponents = true, 
      p_bar = Cv.to_bar(p), 
      T_degC(start = T_start - 273.15) = Cv.to_degC(T), 
      T(start = T_start, 
      stateSelect = if preferredMediumStates then StateSelect.prefer else StateSelect.default)) 
      "T 相关介质的基本特性"

      SI.SpecificHeatCapacity cp "比热容";
      parameter SI.Temperature T_start = 298.15 "初始温度";
    equation
      assert(hasDensity, "介质 " + mediumName + 
        " 未分配 tableDensity 时无法使用。");
      assert(T >= T_min and T <= T_max, "温度 T (= " + String(T) + 
        " K) 不在介质模型 \"" 
        + mediumName + "\" 所需的允许范围内 (" + String(T_min) + 
        " K <= T <= " + String(T_max) + " K)。");
      R_s = Modelica.Constants.R / MM_const;
      cp = Polynomials.evaluate(poly_Cp, if TinK then T else T_degC);
      h = specificEnthalpyOfT(p, T, densityOfT);
      u = h - (if singleState then reference_p / d else state.p / d);
      d = Polynomials.evaluate(poly_rho, if TinK then T else T_degC);
      state.T = T;
      state.p = p;
      MM = MM_const;
      annotation(Documentation(info="<html><p>
注意，内能忽略了压力依赖性，这仅适用于密度为常数的不可压缩介质。被忽略的项是 (p-reference_p)/rho*(T/rho)*(∂rho /∂T)。这对于液体来说非常小，因为与1/d^2成比例，但对于被建模为不可压缩的气体来说可能有问题。
</p>
<p>
需要注意的是，不可压缩介质每个控制体积只有一个状态（通常是 T），但对于完全正确的属性，T 和 p 都是输入。只使用依赖于 T 的属性的误差很小，因此存在一个布尔标志 enthalpyOfT。如果为 true，则将枚举 Choices.IndependentVariables 设置为 Choices.IndependentVariables.T，否则设置为 Choices.IndependentVariables.pT。
</p>
<p>
焓从来都只不仅仅是 T 的函数 (h = h(T) + (p-reference_p)/d)，但误差很小，可以避免非线性系统。特别是， 非线性系统是小型且局部的系统，而不是全部体积的大系统。
</p>
<p>
熵计算为
</p>
<pre><code >s = s0 + integral(Cp(T)/T,dt)
</code></pre><p>
这仅对于密度恒定的流体 d=d0 精确成立。
</p>
<p>
<br>
</p>
</html>"));
    end BaseProperties;

    redeclare function extends setState_pTX 
      "根据压力和温度计算状态记录"
    algorithm
      state := ThermodynamicState(p = p, T = T);
      annotation(smoothOrder = 3);
    end setState_pTX;

    redeclare function extends setState_dTX 
      "根据压力和温度计算状态记录"
      annotation();
    algorithm
      assert(false, "对于仅具有 d(T) 的不可压缩介质，状态不能根据密度和温度设置");
    end setState_dTX;

    function setState_pT "根据p和T计算状态记录"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "压力";
      input Temperature T "温度";
      output ThermodynamicState state "热力学状态";
    algorithm
      state.T := T;
      state.p := p;
      annotation(smoothOrder = 3);
    end setState_pT;

    redeclare function extends setState_phX 
      "根据压力和比焓计算状态记录"
    algorithm
      state := ThermodynamicState(p = p, T = T_ph(p, h));
      annotation(Inline = true, smoothOrder = 3);
    end setState_phX;

    function setState_ph "根据 p 和 h 计算状态记录"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "压力";
      input SpecificEnthalpy h "比焓";
      output ThermodynamicState state "热力学状态";
    algorithm
      state := ThermodynamicState(p = p, T = T_ph(p, h));
      annotation(Inline = true, smoothOrder = 3);
    end setState_ph;

    redeclare function extends setState_psX 
      "根据压力和比熵计算状态记录"
    algorithm
      state := ThermodynamicState(p = p, T = T_ps(p, s));
      annotation(Inline = true, smoothOrder = 3);
    end setState_psX;

    function setState_ps "根据 p 和 s 计算状态记录"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "压力";
      input SpecificEntropy s "比熵";
      output ThermodynamicState state "热力学状态";
    algorithm
      state := ThermodynamicState(p = p, T = T_ps(p, s));
      annotation(Inline = true, smoothOrder = 3);
    end setState_ps;

    redeclare function extends setSmoothState 
      "计算热力学状态，使其平滑地逼近：如果 x > 0，则计算 state_a，否则计算 state_b"
    algorithm
      state := ThermodynamicState(p = Media.Common.smoothStep(x, state_a.p, state_b.p, x_small), 
        T = Media.Common.smoothStep(x, state_a.T, state_b.T, x_small));
      annotation(Inline = true, smoothOrder = 3);
    end setSmoothState;

    redeclare function extends specificHeatCapacityCv 
      "介质在定容（或定压）条件下的比热容"

    algorithm
      assert(hasHeatCapacity, "介质 " 
        + mediumName + " 的比热容 Cv 未定义。");
      cv := Polynomials.evaluate(poly_Cp, if TinK then state.T else state.T - 273.15);
      annotation(smoothOrder = 2);
    end specificHeatCapacityCv;

    redeclare function extends specificHeatCapacityCp 
      "介质在定容（或定压）条件下的比热容"

    algorithm
      assert(hasHeatCapacity, "介质 " 
        + mediumName + " 的比热容 Cv 未定义。");
      cp := Polynomials.evaluate(poly_Cp, if TinK then state.T else state.T - 273.15);
      annotation(smoothOrder = 2);
    end specificHeatCapacityCp;

    redeclare function extends dynamicViscosity 
      "根据热力学状态记录计算动力黏度"

    algorithm
      assert(size(tableViscosity, 1) > 0, "介质 " 
        + mediumName + " 的动力黏度 eta 未定义。");
      eta := Math.exp(Polynomials.evaluate(poly_eta, 1 / state.T));
      annotation(smoothOrder = 2);
    end dynamicViscosity;

    redeclare function extends thermalConductivity 
      "根据热力学状态记录计算导热系数"

    algorithm
      assert(size(tableConductivity, 1) > 0, "介质 " 
        + mediumName + " 的导热系数 lambda 未定义。");
      lambda := Polynomials.evaluate(poly_lam, if TinK then state.T else Cv.to_degC(state.T));
      annotation(smoothOrder = 2);
    end thermalConductivity;

    function s_T "计算比熵"
      extends Modelica.Icons.Function;
      input Temperature T "温度";
      output SpecificEntropy s "比熵";
    algorithm
      s := s0 + (if TinK then 
        Polynomials.integralValue(poly_Cp[1:npol], T, T0) else 
        Polynomials.integralValue(poly_Cp[1:npol], Cv.to_degC(T), Cv.to_degC(T0))) 
        + Modelica.Math.log(T / T0) * 
        Polynomials.evaluate(poly_Cp, if TinK then 0 else Modelica.Constants.T_zero);
      annotation(Inline = true, smoothOrder = 2);
    end s_T;

    redeclare function extends specificEntropy 
      "根据热力学状态记录计算比熵"

    protected
      Integer npol = size(poly_Cp, 1) - 1;
    algorithm
      assert(hasHeatCapacity, "比熵 s(T) 未定义于介质 " 
        + mediumName + " 中。");
      s := s_T(state.T);
      annotation(smoothOrder = 2);
    end specificEntropy;

    function h_T "根据温度计算比焓"
      import Modelica.Units.Conversions.to_degC;
      extends Modelica.Icons.Function;
      input SI.Temperature T "温度";
      output SI.SpecificEnthalpy h "在 p、T 下的比焓";
    algorithm
      h := h0 + Polynomials.integralValue(poly_Cp, if TinK then T else Cv.to_degC(T), if TinK then 
        T0 else Cv.to_degC(T0));
      annotation(derivative = h_T_der);
    end h_T;

    function h_T_der "根据温度计算比焓"
      import Modelica.Units.Conversions.to_degC;
      extends Modelica.Icons.Function;
      input SI.Temperature T "温度";
      input Real dT "温度导数";
      output Real dh "在 T 下比焓的导数";
    algorithm
      dh := Polynomials.evaluate(poly_Cp, if TinK then T else Cv.to_degC(T)) * dT;
      annotation(smoothOrder = 1);
    end h_T_der;

    function h_pT "根据压力和温度计算比焓"
      import Modelica.Units.Conversions.to_degC;
      extends Modelica.Icons.Function;
      input SI.Pressure p "压力";
      input SI.Temperature T "温度";
      input Boolean densityOfT = false "包括或忽略比焓的密度导数依赖性";
      output SI.SpecificEnthalpy h "在 p、T 下的比焓";
    algorithm
      h := h0 + Polynomials.integralValue(poly_Cp, if TinK then T else Cv.to_degC(T), if TinK then 
        T0 else Cv.to_degC(T0)) + (p - reference_p) / Polynomials.evaluate(poly_rho, if TinK then 
        T else Cv.to_degC(T)) 
        * (if densityOfT then (1 + T / Polynomials.evaluate(poly_rho, if TinK then T else Cv.to_degC(T)) 
        * Polynomials.derivativeValue(poly_rho, if TinK then T else Cv.to_degC(T))) else 1.0);
      annotation(smoothOrder = 2);
    end h_pT;

    function density_T "根据温度计算密度"
      extends Modelica.Icons.Function;

      input Temperature T "温度";
      output Density d "密度";
    algorithm
      d := Polynomials.evaluate(poly_rho, if TinK then T else Cv.to_degC(T));
      annotation(Inline = true, smoothOrder = 2);
    end density_T;

    redeclare function extends temperature 
      "根据热力学状态记录计算温度"
    algorithm
      T := state.T;
      annotation(Inline = true, smoothOrder = 2);
    end temperature;

    redeclare function extends pressure 
      "根据热力学状态记录计算压力"
    algorithm
      p := state.p;
      annotation(Inline = true, smoothOrder = 2);
    end pressure;

    redeclare function extends density 
      "根据热力学状态记录计算密度"
    algorithm
      d := Polynomials.evaluate(poly_rho, if TinK then state.T else Cv.to_degC(state.T));
      annotation(Inline = true, smoothOrder = 2);
    end density;

    redeclare function extends specificEnthalpy 
      "根据热力学状态记录计算比焓"
    algorithm
      h := specificEnthalpyOfT(state.p, state.T);
      annotation(Inline = true, smoothOrder = 2);
    end specificEnthalpy;

    redeclare function extends specificInternalEnergy 
      "根据热力学状态记录计算比内能"
    algorithm
      u := specificEnthalpyOfT(state.p, state.T) - (if singleState then reference_p else state.p) / density(state);
      annotation(Inline = true, smoothOrder = 2);
    end specificInternalEnergy;

    function T_ph "根据压力和比焓计算温度"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "压力";
      input SpecificEnthalpy h "比焓";
      output Temperature T "温度";

    protected
      function f_nonlinear "解具有给定 h 的 T 的方程 specificEnthalpyOfT(p,T) 关于 T"
        extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
        input AbsolutePressure p "压力";
        input SpecificEnthalpy h "比焓";
        annotation();
      algorithm
        y := specificEnthalpyOfT(p = p, T = u) - h;
      end f_nonlinear;

    algorithm
      T := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
        function f_nonlinear(p = p, h = h), T_min, T_max);
      annotation(Inline = false, LateInline = true, inverse(h = specificEnthalpyOfT(p, T)));
    end T_ph;

    function T_ps "根据压力和比熵计算温度"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "压力 (未使用)";
      input SpecificEntropy s "比熵";
      output Temperature T "温度";

    protected
      function f_nonlinear "解具有给定 s 的 T 的方程 s_T(T)"
        extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
        input SpecificEntropy s "比熵";
        annotation();
      algorithm
        y := s_T(T = u) - s;
      end f_nonlinear;
      annotation();

    algorithm
      T := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
        function f_nonlinear(s = s), T_min, T_max);
    end T_ps;

  protected
    function specificEnthalpyOfT 
      "根据压力和温度计算比焓，考虑 enthalpyOfT 标志"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "压力";
      input Temperature T "温度";
      input Boolean densityOfT = false "包括或忽略比焓的密度导数依赖性";
      output SpecificEnthalpy h "比焓";
    algorithm
      h := if enthalpyOfT then h_T(T) else h_pT(p, T, densityOfT);
      annotation(Inline = true, smoothOrder = 2);
    end specificEnthalpyOfT;

    annotation(Documentation(info="<html><p>
本基础库为基于数据表的不可压缩流体介质模型提供架构支持。构建有效介质模型至少需提供密度与比热容随温度变化的函数表。
</p>
<p>
需要注意的是，不可压缩介质每个控制体积只有一个状态（通常是 T）， 但对于完全正确的性质，需要 T 和 p 作为输入。仅使用 T 相关的属性的误差很小， 因此存在一个布尔标志 enthalpyOfT。如果为 true，则枚举 Choices.IndependentVariables 设置为 Choices.IndependentVariables.T，否则设置为 Choices.IndependentVariables.pT。
</p>
<h4>使用 TableBased 包</h4><p>
要实现新的介质模型，请创建一个库，<strong>扩展</strong> TableBased，并提供一个或多个常量表：
</p>
<pre><code >tableDensity        = [T, d];
tableHeatCapacity   = [T, Cp];
tableConductivity   = [T, lam];
tableViscosity      = [T, eta];
tableVaporPressure  = [T, pVap];
</code></pre><p>
表格数据用于拟合 <strong>npol</strong> 阶常数多项式，不同性质的温度数据点不必相同。根据 d(T) 和 Cp(T) 的积分和导数，可以连续计算出焓、内能和熵等性质。因此，一个有用介质模型的最基本数据是密度和热容量。如果数据表为空，则无法使用相应的函数调用。
</p>
<p>
<br>
</p>
</html>"));
  end TableBased;

  annotation(
    Documentation(info="<html><h4>不可压缩介质库</h4><p>
本库提供了如何创建不可压缩流体（即压力对密度影响很小的流体）的简单介质模型的结构和示例。介质属性通常用表格、函数或多项式系数来描述。
</p>
<h4>定义</h4><p>
不可压缩的通常含义是指密度和焓等性质与压力无关。因此，可以方便地用温度的函数来描述这些性质，例如密度（T）和 cp（T）的多项式。然而，由于 h = u + p/d，焓和内能不可能都与压力无关。(通常，当 T 保持不变时，dh/dp≥0，du/dp≤0。）对于液体来说，忽略这两项的依赖性是很常见的，因为在密度不变的情况下，被忽略的项是 (p - p0)/d，与 cp 相比，对于大多数液体来说是非常小的。对于水来说，压力增加 1 bar 时的等效温度变化为 0.025 K。
</p>
<p>
两个布尔标志用于选择焓和内能的计算方式：
</p>
<li>
<strong>enthalpyOfT</strong>=true, 这意味着假设焓仅是温度的函数，忽略了与压力相关的项。</li>
<li>
<strong>singleState</strong>=true, &nbsp;这种方法也忽略了压力对内能的影响，使得所有介质特性都是温度的纯函数。</li>
<p>
这两个标志的默认设置都是 true，这使得仿真工具可以选择温度作为唯一的介质状态，避免非线性方程系统，请参阅《Modelica.Media 用户指南》中有关 <a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition.StaticStateSelection\" target=\"\">静态状态选择</a>&nbsp;的章节。
</p>
<h4>目录</h4><p>
目前，该库包含以下部分：
</p>
<ol><li>
<a href=\"modelica://Modelica.Media.Incompressible.TableBased\" target=\"\"> 基于表格的介质模型</a>&nbsp;</li>
<li>
<a href=\"modelica://Modelica.Media.Incompressible.Examples\" target=\"\"> 介质模型示例</a>&nbsp;</li>
</ol><p>
示例软件包中提供了一些示例。模型 <a href=\"modelica://Modelica.Media.Incompressible.Examples.Glycol47\" target=\"\"> Examples.Glycol47</a>&nbsp; 展示了如何使用中等模型。有关如何使用中型属性实现体积模型的更多实际示例，请参阅用户指南中的 <a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage\" target=\"\">介质使用</a>&nbsp; 。
</p>
</html>"));

end Incompressible;