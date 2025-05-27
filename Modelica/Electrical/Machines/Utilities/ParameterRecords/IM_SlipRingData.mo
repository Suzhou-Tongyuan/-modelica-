within Modelica.Electrical.Machines.Utilities.ParameterRecords;
record IM_SlipRingData 
  "带滑环感应电机的通用参数"
  extends InductionMachineData;
  import Modelica.Constants.pi;
  parameter SI.Inductance Lm=3*sqrt(1 - 0.0667)/(2*pi* 
      fsNominal) "每相定子主磁场电感" 
    annotation (Dialog(tab="标称电阻和电感"));
  parameter SI.Inductance Lrsigma=3*(1 - sqrt(1 - 0.0667))/ 
      (2*pi*fsNominal)/turnsRatio^2 
    "每相转子漏感(相对于转子侧)" 
    annotation (Dialog(tab="标称电阻和电感"));
  parameter SI.Inductance Lrzero=Lrsigma/turnsRatio^2 
    "每相转子零序电感(相对于转子侧)" 
    annotation (Dialog(tab="标称电阻和电感"));
  parameter SI.Resistance Rr=0.04/turnsRatio^2 
    "在 TRef 下每相转子电阻(相对于转子侧)" 
    annotation (Dialog(tab="标称电阻和电感"));
  parameter SI.Temperature TrRef=293.15 
    "转子电阻的参考温度" 
    annotation (Dialog(tab="标称电阻和电感"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20r=0 
    "20°C时转子电阻的温度系数" 
    annotation (Dialog(tab="标称电阻和电感"));
  parameter Boolean useTurnsRatio=true 
    "使用turnsRatio还是根据空载电压计算？";
  parameter Real turnsRatio(final min=Modelica.Constants.small)= 
    VsNominal/VrLockedRotor*(2*pi*fsNominal*Lm)/sqrt(Rs^2 + (2*pi* 
    fsNominal*(Lm + Lssigma))^2) 
    "有效定子匝数/有效转子匝数" 
    annotation (Dialog(enable=useTurnsRatio));
  parameter SI.Voltage VsNominal=100 
    "每相定子额定电压" 
    annotation (Dialog(enable=not useTurnsRatio));
  parameter SI.Voltage VrLockedRotor=100*(2*pi*fsNominal*Lm) 
      /sqrt(Rs^2 + (2*pi*fsNominal*(Lm + Lssigma))^2) 
    "每相空载电压" 
    annotation (Dialog(enable=not useTurnsRatio));
  parameter Machines.Losses.CoreParameters rotorCoreParameters(
    final m=3, 
    PRef=0, 
    VRef=1, 
    wRef=1) 
    "转子铁芯损耗参数记录；所有参数均参考转子侧" 
    annotation (Dialog(tab="损耗"));
  annotation (
    defaultComponentName="imsData", 
    defaultComponentPrefixes="parameter", 
    Documentation(info="<html>
<p>带滑环感应电机的基本参数已预定义为默认值。</p>
</html>"));
end IM_SlipRingData;