within Modelica.Electrical.Machines.Utilities.ParameterRecords;
record InductionMachineData "感应电机的通用参数"
  extends Modelica.Icons.Record;
  import Modelica.Constants.pi;
  final parameter Integer m=3 "相数" annotation(Evaluate=true);
  parameter SI.Inertia Jr=0.29 "转子惯性矩";
  parameter SI.Inertia Js=Jr "定子惯性矩";
  parameter Integer p(min=1) = 2 "极对数 (整数)";
  parameter SI.Frequency fsNominal=50 "额定频率";
  parameter SI.Resistance Rs=0.03 
    "在 TRef 下每相定子电阻" 
    annotation (Dialog(tab="标称电阻和电感"));
  parameter SI.Temperature TsRef=293.15 
    "定子电阻的参考温度" 
    annotation (Dialog(tab="标称电阻和电感"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20s=0 
    "20°C时定子电阻的温度系数" 
    annotation (Dialog(tab="标称电阻和电感"));
  parameter Real effectiveStatorTurns=1 "有效定子匝数";
  parameter SI.Inductance Lszero=Lssigma 
    "定子零序电感" 
    annotation (Dialog(tab="标称电阻和电感"));
  parameter SI.Inductance Lssigma=3*(1 - sqrt(1 - 0.0667))/ 
      (2*pi*fsNominal) "每相定子漏感" 
    annotation (Dialog(tab="标称电阻和电感"));
  parameter Machines.Losses.FrictionParameters frictionParameters(PRef=0, wRef= 
        2*pi*fsNominal/p) "摩擦损耗参数记录" 
    annotation (Dialog(tab="损耗"));
  parameter Machines.Losses.CoreParameters statorCoreParameters(
    final m=m, 
    PRef=0, 
    VRef=100, 
    wRef=2*pi*fsNominal) 
    "定子铁心损耗参数记录；所有参数均指定子侧" 
    annotation (Dialog(tab="损耗"));
  parameter Machines.Losses.StrayLoadParameters strayLoadParameters(
    PRef=0, 
    IRef=100, 
    wRef=2*pi*fsNominal/p) "漏负载损耗" annotation (Dialog(tab="损耗"));
  annotation (
    defaultComponentName="inductionMachineData", 
    defaultComponentPrefixes="parameter", 
    Documentation(info="<html>
<p>感应电机的基本参数已预定义为默认值。</p>
</html>"));
end InductionMachineData;