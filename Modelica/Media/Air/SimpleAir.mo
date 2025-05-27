within Modelica.Media.Air;
package SimpleAir "Air:简单干空气模型 (0..100 摄氏度)"
  extends Modelica.Icons.MaterialProperty;
  extends Interfaces.PartialSimpleIdealGasMedium(
    mediumName="SimpleAir", 
    cp_const=1005.45, 
    MM_const=0.0289651159, 
    R_gas=Constants.R/0.0289651159, 
    eta_const=1.82e-5, 
    lambda_const=0.026, 
    T_min=Cv.from_degC(0), 
    T_max=Cv.from_degC(100), 
    fluidConstants=airConstants, 
    Temperature(min=Modelica.Units.Conversions.from_degC(0), max= 
          Modelica.Units.Conversions.from_degC(100)));

  import Modelica.Constants;

  constant Modelica.Media.Interfaces.Types.Basic.FluidConstants[nS] 
    airConstants={Modelica.Media.Interfaces.Types.Basic.FluidConstants(
        iupacName="simple air", 
        casRegistryNumber="not a real substance", 
        chemicalFormula="N2, O2", 
        structureFormula="N2, O2", 
        molarMass=Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM)} 
    "流体的常量数据";

  annotation (Documentation(info="<html>
                            <h4>用于低温的简单理想气体空气模型</h4>
                            <p>该模型演示了如何使用PartialSimpleIdealGas基类来构建具有有限温度有效范围的简单理想气体模型。</p>
                            </html>"));
end SimpleAir;