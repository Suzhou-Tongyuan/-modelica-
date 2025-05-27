within Modelica.Media.IdealGases.Common;
package Functions 
  "理想气体的基本函数：cp、h、s、thermal conductivity、viscosity"
  extends Modelica.Icons.FunctionsPackage;

  constant Boolean excludeEnthalpyOfFormation=true 
    "如果为真，则在比焓 h 中不包括生成焓 Hf";
  constant Modelica.Media.Interfaces.Choices.ReferenceEnthalpy referenceChoice=Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.ZeroAt0K 
    "基准焓的选择";
  constant Modelica.Media.Interfaces.Types.SpecificEnthalpy h_offset=0.0 
    "基准焓的用户定义偏移量，如果 referenceChoice = UserDefined";
  constant Integer methodForThermalConductivity(min=1,max=2)=1;

  function cp_T 
    "根据温度和气体数据计算定压比热容"
    extends Modelica.Icons.Function;
    input IdealGases.Common.DataRecord data "理想气体数据";
    input SI.Temperature T "温度";
    output SI.SpecificHeatCapacity cp "温度为 T 时的定压比热容";
  algorithm
    cp := smooth(0,if T < data.Tlimit then data.R_s*(1/(T*T)*(data.alow[1] + T*(
      data.alow[2] + T*(1.*data.alow[3] + T*(data.alow[4] + T*(data.alow[5] + T 
      *(data.alow[6] + data.alow[7]*T))))))) else data.R_s*(1/(T*T)*(data.ahigh[1] 
       + T*(data.ahigh[2] + T*(1.*data.ahigh[3] + T*(data.ahigh[4] + T*(data.
      ahigh[5] + T*(data.ahigh[6] + data.ahigh[7]*T))))))));
    annotation (Inline=true,smoothOrder=2);
  end cp_T;

  function cp_Tlow 
    "计算定压比热容，低温区域"
    extends Modelica.Icons.Function;
    input IdealGases.Common.DataRecord data "理想气体数据";
    input SI.Temperature T "温度";
    output SI.SpecificHeatCapacity cp "温度为 T 时的定压比热容";
  algorithm
    cp := data.R_s*(1/(T*T)*(data.alow[1] + T*(
      data.alow[2] + T*(1.*data.alow[3] + T*(data.alow[4] + T*(data.alow[5] + T 
      *(data.alow[6] + data.alow[7]*T)))))));
    annotation (Inline=false, derivative(zeroDerivative=data) = cp_Tlow_der);
  end cp_Tlow;

  function cp_Tlow_der 
    "计算定压比热容在常压下的温度导数，低温区域"
    extends Modelica.Icons.Function;
    input IdealGases.Common.DataRecord data "理想气体数据";
    input SI.Temperature T "温度";
    input Real dT(unit="K/s") "温度导数";
    output Real cp_der(unit="J/(kg.K.s)") "定压比热容的导数";
  algorithm
    cp_der := dT*data.R_s/(T*T*T)*(-2*data.alow[1] + T*(
      -data.alow[2] + T*T*(data.alow[4] + T*(2.*data.alow[5] + T 
      *(3.*data.alow[6] + 4.*data.alow[7]*T)))));
    annotation(smoothOrder=2);
  end cp_Tlow_der;

  function h_T "从温度和气体数据计算比焓；参考值由 refChoice 输入或默认的 referenceChoice 库常量决定"
    import Modelica.Media.Interfaces.Choices;
    extends Modelica.Icons.Function;
    input IdealGases.Common.DataRecord data "理想气体数据";
    input SI.Temperature T "温度";
    input Boolean exclEnthForm=excludeEnthalpyOfFormation 
      "如果为真，则在比焓 h 中不包括生成焓 Hf";
    input Modelica.Media.Interfaces.Choices.ReferenceEnthalpy 
                                    refChoice=referenceChoice 
      "基准焓的选择";
    input SI.SpecificEnthalpy h_off=h_offset 
      "基准焓的用户定义偏移量，如果 referenceChoice = UserDefined";
    output SI.SpecificEnthalpy h "温度为 T 时的比焓";
  algorithm
    h := smooth(0,(if T < data.Tlimit then data.R_s*((-data.alow[1] + T*(data.
      blow[1] + data.alow[2]*Math.log(T) + T*(1.*data.alow[3] + T*(0.5*data.
      alow[4] + T*(1/3*data.alow[5] + T*(0.25*data.alow[6] + 0.2*data.alow[7]*T)))))) 
      /T) else data.R_s*((-data.ahigh[1] + T*(data.bhigh[1] + data.ahigh[2]* 
      Math.log(T) + T*(1.*data.ahigh[3] + T*(0.5*data.ahigh[4] + T*(1/3*data.
      ahigh[5] + T*(0.25*data.ahigh[6] + 0.2*data.ahigh[7]*T))))))/T)) + (if 
      exclEnthForm then -data.Hf else 0.0) + (if (refChoice 
       == Choices.ReferenceEnthalpy.ZeroAt0K) then data.H0 else 0.0) + (if 
      refChoice == Choices.ReferenceEnthalpy.UserDefined then h_off else 
            0.0));
    annotation (Inline=false,smoothOrder=2);
  end h_T;

  function h_T_der "h_T 的导数函数"
    import Modelica.Media.Interfaces.Choices;
    extends Modelica.Icons.Function;
    input IdealGases.Common.DataRecord data "理想气体数据";
    input SI.Temperature T "温度";
    input Boolean exclEnthForm=excludeEnthalpyOfFormation 
      "如果为真，则在比焓 h 中不包括生成焓 Hf";
    input Modelica.Media.Interfaces.Choices.ReferenceEnthalpy 
                                    refChoice=referenceChoice 
      "基准焓的选择";
    input SI.SpecificEnthalpy h_off=h_offset 
      "基准焓的用户定义偏移量，如果 referenceChoice = UserDefined";
    input Real dT(unit="K/s") "温度导数";
    output Real h_der(unit="J/(kg.s)") "温度为 T 时比焓的导数";
  algorithm
    h_der := dT*Modelica.Media.IdealGases.Common.Functions.cp_T(
                     data,T);
    annotation(Inline=true,smoothOrder=1);
  end h_T_der;

  function h_Tlow "计算比焓，低温区域；基准由 refChoice 输入或默认的 referenceChoice 库常量决定"
    import Modelica.Media.Interfaces.Choices;
    extends Modelica.Icons.Function;
    input IdealGases.Common.DataRecord data "理想气体数据";
    input SI.Temperature T "温度";
    input Boolean exclEnthForm=excludeEnthalpyOfFormation 
      "如果为真，则在比焓 h 中不包括生成焓 Hf";
    input Modelica.Media.Interfaces.Choices.ReferenceEnthalpy 
                                    refChoice=referenceChoice 
      "基准焓的选择";
    input SI.SpecificEnthalpy h_off=h_offset 
      "基准焓的用户定义偏移量，如果 referenceChoice = UserDefined";
    output SI.SpecificEnthalpy h "温度为 T 时的比焓";

  algorithm
    h := data.R_s*((-data.alow[1] + T*(data.
      blow[1] + data.alow[2]*Math.log(T) + T*(1.*data.alow[3] + T*(0.5*data.
      alow[4] + T*(1/3*data.alow[5] + T*(0.25*data.alow[6] + 0.2*data.alow[7]*T)))))) 
      /T) + (if 
      exclEnthForm then -data.Hf else 0.0) + (if (refChoice 
       == Choices.ReferenceEnthalpy.ZeroAt0K) then data.H0 else 0.0) + (if 
      refChoice == Choices.ReferenceEnthalpy.UserDefined then h_off else 
            0.0);
    annotation(Inline=false,smoothOrder=2);
  end h_Tlow;

  function h_Tlow_der "计算比焓的导数，低温区域；基准由 refChoice 输入或默认的 referenceChoice 库常量决定"
    import Modelica.Media.Interfaces.Choices;
    extends Modelica.Icons.Function;
    input IdealGases.Common.DataRecord data "理想气体数据";
    input SI.Temperature T "温度";
    input Boolean exclEnthForm=excludeEnthalpyOfFormation 
      "如果为真，则在比焓 h 中不包括生成焓 Hf";
    input Modelica.Media.Interfaces.Choices.ReferenceEnthalpy 
                                    refChoice=referenceChoice 
      "基准焓的选择";
    input SI.SpecificEnthalpy h_off=h_offset 
      "基准焓的用户定义偏移量，如果 referenceChoice = UserDefined";
    input Real dT(unit="K/s") "温度导数";
    output Real h_der(unit="J/(kg.s)") 
      "温度为 T 时比焓的导数";
  algorithm
    h_der := dT*Modelica.Media.IdealGases.Common.Functions.cp_Tlow(
                        data,T);
    annotation(Inline=true,smoothOrder=2);
  end h_Tlow_der;

  function s0_T "计算比熵，由温度和气体数据确定"
    extends Modelica.Icons.Function;
    input IdealGases.Common.DataRecord data "理想气体数据";
    input SI.Temperature T "温度";
    output SI.SpecificEntropy s "温度为 T 时的比熵";
  algorithm
    s := if T < data.Tlimit then data.R_s*(data.blow[2] - 0.5*data.alow[
      1]/(T*T) - data.alow[2]/T + data.alow[3]*Math.log(T) + T*(
      data.alow[4] + T*(0.5*data.alow[5] + T*(1/3*data.alow[6] + 0.25*data.alow[
      7]*T)))) else data.R_s*(data.bhigh[2] - 0.5*data.ahigh[1]/(T*T) - data.
      ahigh[2]/T + data.ahigh[3]*Math.log(T) + T*(data.ahigh[4] 
       + T*(0.5*data.ahigh[5] + T*(1/3*data.ahigh[6] + 0.25*data.ahigh[7]*T))));
    annotation (Inline=true, smoothOrder=2);
  end s0_T;

  function s0_Tlow "计算比熵，低温区域"
    extends Modelica.Icons.Function;
    input IdealGases.Common.DataRecord data "理想气体数据";
    input SI.Temperature T "温度";
    output SI.SpecificEntropy s "温度为 T 时的比熵";
  algorithm
    s := data.R_s*(data.blow[2] - 0.5*data.alow[
      1]/(T*T) - data.alow[2]/T + data.alow[3]*Math.log(T) + T*(
      data.alow[4] + T*(0.5*data.alow[5] + T*(1/3*data.alow[6] + 0.25*data.alow[
      7]*T))));
    annotation (Inline=true, smoothOrder=2);
  end s0_Tlow;

  function s0_Tlow_der "计算比熵的导数，低温区域"
    extends Modelica.Icons.Function;
    input IdealGases.Common.DataRecord data "理想气体数据";
    input SI.Temperature T "温度";
    input Real T_der(unit="K/s") "温度导数";
    output Real s_der(unit="J/(kg.K.s)") "温度为 T 时的比熵的导数";
  algorithm
    s_der := data.R_s*T_der*(data.alow[1]/(T*T*T) + data.alow[2]/(T*T) + data.alow[3]/T + data.alow[4] + T*(data.alow[5] + T*(data.alow[6] + T*data.alow[7])));
    annotation (Inline=true);
  end s0_Tlow_der;

  function dynamicViscosityLowPressure 
    "低压气体的动力黏度"
    extends Modelica.Icons.Function;
    input SI.Temperature T "气体温度";
    input SI.Temperature Tc "气体的临界温度";
    input SI.MolarMass M "气体的摩尔质量";
    input SI.MolarVolume Vc "气体的临界摩尔体积";
    input Real w "气体的偏心因子";
    input Modelica.Media.Interfaces.Types.DipoleMoment mu 
      "气体分子的偶极矩";
    input Real k =  0.0 "高极性物质的特殊修正";
    output SI.DynamicViscosity eta "气体的动力黏度";
  protected
    parameter Real Const1_SI=40.785*10^(-9.5) 
      "转换为 SI 单位的 eta 公式中的常数";
    parameter Real Const2_SI=131.3/1000.0 
      "转换为 SI 单位的 mur 公式中的常数";
    Real mur=Const2_SI*mu/sqrt(Vc*Tc) 
      "气体分子的无量纲偶极矩";
    Real Fc=1 - 0.2756*w + 0.059035*mur^4 + k 
      "考虑气体分子形状和极性的因素";
    Real Tstar "由下式定义的无量纲温度";
    Real Ov "气体的黏度碰撞积分";

  algorithm
    Tstar := 1.2593*T/Tc;
    Ov := 1.16145*Tstar^(-0.14874) + 0.52487*Modelica.Math.exp(-0.7732*Tstar) + 2.16178*Modelica.Math.exp(-2.43787 
      *Tstar);
    eta := Const1_SI*Fc*sqrt(M*T)/(Vc^(2/3)*Ov);
  annotation (smoothOrder=2, 
                Documentation(info="<html><p>
所使用的公式基于 Chung 等人 (1984, 1988) 在参考文献 [1] 第 9 章中提到的方法。 使用的公式是 9-4.10。该公式给出的是非 SI 单位，以下转换常数用于将公式转换为 SI 单位：
</p>
<ul><li>
<strong>Const1_SI:</strong> 因子 10^(-9.5) =10^(-2.5)*1e-7，其中 因子 10^(-2.5) 源自 g/mol-&gt;kg/mol + cm^3/mol-&gt;m^3/mol 的转换，因子 1e-7 源自 microPoise-&gt;Pa.s 的转换。</li>
<li>
<strong>Const2_SI:</strong> 因子 1/3.335641e-27 = 1e-3/3.335641e-30， 其中因子 3.335641e-30 源自 debye-&gt;C.m 的转换， 而 1e-3 源自 cm^3/mol-&gt;m^3/mol 的转换</li>
</ul><h4>参考文献</h4><p>
[1] Bruce E. Poling, John E. Prausnitz, John P. O\\'Connell, \"The Properties of Gases and Liquids\" 5th Ed. Mc Graw Hill.
</p>
<h4>作者</h4><p>
T. Skoglund, Lund, Sweden, 2004-08-31
</p>
</html>"));
  end dynamicViscosityLowPressure;

  function thermalConductivityEstimate 
    "多原子气体的导热系数（Eucken 和 Modified Eucken 相关性）"
    extends Modelica.Icons.Function;
    input Modelica.Media.Interfaces.Types.SpecificHeatCapacity Cp 
      "定压热容";
    input Modelica.Media.Interfaces.Types.DynamicViscosity eta 
      "动力黏度";
    input Integer method(min=1,max=2)=1 
      "1: Eucken 方法, 2: Modified Eucken 方法";
    input IdealGases.Common.DataRecord data "理想气体数据";
    output Modelica.Media.Interfaces.Types.ThermalConductivity lambda 
      "导热系数 [W/(m.k)]";
  algorithm
    lambda := if method == 1 then eta*(Cp - data.R_s + (9/4)*data.R_s) 
                             else eta*(Cp - data.R_s)*(1.32 + 1.77/((Cp/data.R_s) - 1.0));
    annotation (smoothOrder=2, 
                Documentation(info="<html>
<p>
此函数提供两种类似的方法来估算多原子气体的导热系数。
Eucken 方法（输入 method == 1）在低温下给出良好的结果，
但在较高温度下倾向于低估导热系数（lambda）的值。<br>
Modified Eucken 方法（输入 method == 2）在高温下给出良好的结果，
但在低温下倾向于高估导热系数（lambda）的值。
</p>
</html>"));
  end thermalConductivityEstimate;
  annotation();
end Functions;