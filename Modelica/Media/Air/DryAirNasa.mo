within Modelica.Media.Air;
package DryAirNasa "Air:详细干空气模型，作为理想气体 (200..6000 K)"
  extends Modelica.Icons.MaterialProperty;
  extends IdealGases.Common.SingleGasNasa(
    mediumName="Air", 
    data=IdealGases.Common.SingleGasesData.Air, 
    fluidConstants={IdealGases.Common.FluidData.N2});

  redeclare function dynamicViscosity 
    "计算干空气的动力黏度(简单多项式,湿度影响小,有效范围从123.15K到1273.15K,超出此范围使用线性外推)"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "热力状态记录类";
    output DynamicViscosity eta "动力黏度";
    import Modelica.Math.Polynomials;
  algorithm
    eta := 1e-6*Polynomials.evaluateWithRange(
        {9.7391102886305869E-15,-3.1353724870333906E-11,4.3004876595642225E-08, 
        -3.8228016291758240E-05,5.0427874367180762E-02,1.7239260139242528E+01}, 
        Cv.to_degC(123.15), 
        Cv.to_degC(1273.15), 
        Cv.to_degC(state.T));
    annotation (smoothOrder=2, Documentation(info="<html><p>
动力黏度通过温度使用简单多项式计算，适用于干空气。有效范围是 123.15 K 到 1273.15 K，忽略压力的影响。
</p>
<p>
资料来源：VDI Waermeatlas，第 8 版。
</p>
</html>"));
  end dynamicViscosity;

  redeclare function thermalConductivity 
    "计算干空气的热导率(简单多项式,湿度影响小,有效范围从123.15K到1273.15K,超出此范围使用线性外推)"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "热力状态记录类";
    input Integer method=1 "为了兼容性原因的假值";
    output ThermalConductivity lambda "导热系数";
    import Modelica.Math.Polynomials;
  algorithm
    lambda := 1e-3*Polynomials.evaluateWithRange(
        {6.5691470817717812E-15,-3.4025961923050509E-11,5.3279284846303157E-08, 
        -4.5340839289219472E-05,7.6129675309037664E-02,2.4169481088097051E+01}, 
        Cv.to_degC(123.15), 
        Cv.to_degC(1273.15), 
        Cv.to_degC(state.T));

    annotation (smoothOrder=2, Documentation(info="<html><p>
导热系数通过温度使用简单多项式计算，适用于干空气。有效范围是 123.15 K 到 1273.15 K，忽略压力的影响。
</p>
<p>
资料来源：VDI Waermeatlas，第 8 版。
</p>
</html>"));
  end thermalConductivity;

  annotation (Documentation(info="<html><p>
<img src=\"modelica://Modelica/Resources/Images/Media/Air/Air.png\" alt=\"\" data-href=\"\" style=\"\"/>
</p>
<p>
基于<a href=\"modelica://Modelica.Media.IdealGases\" target=\"\">IdealGases</a>&nbsp;库的理想气体介质模型，用于描述干空气，并额外提供了在有限温度范围内计算动态粘度和热导率的函数。
</p>
</html>"));
end DryAirNasa;