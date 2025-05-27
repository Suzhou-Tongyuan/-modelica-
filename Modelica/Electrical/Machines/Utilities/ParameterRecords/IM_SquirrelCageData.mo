within Modelica.Electrical.Machines.Utilities.ParameterRecords;
record IM_SquirrelCageData 
  "鼠笼感应电机的通用参数"
  extends InductionMachineData;
  import Modelica.Constants.pi;
  parameter SI.Inductance Lm = 3 * sqrt(1 - 0.0667) / (2 * pi * 
    fsNominal) "每相定子主磁场电感" 
    annotation(Dialog(tab = "标称电阻和电感"));
  parameter SI.Inductance Lrsigma = 3 * (1 - sqrt(1 - 0.0667)) / 
    (2 * pi * fsNominal) 
    "每相转子漏感(等效三相绕组)" 
    annotation(Dialog(tab = "标称电阻和电感"));
  parameter SI.Resistance Rr = 0.04 
    "在 TRef 下每相转子电阻(等效三相绕组)" 
    annotation(Dialog(tab = "标称电阻和电感"));
  parameter SI.Temperature TrRef = 293.15 
    "转子电阻的参考温度" 
    annotation(Dialog(tab = "标称电阻和电感"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20r = 0 
    "20°C时转子电阻的温度系数" 
    annotation(Dialog(tab = "标称电阻和电感"));
  annotation(
    defaultComponentName = "imcData", 
    defaultComponentPrefixes = "parameter", 
    Documentation(info = "<html>
<p>鼠笼感应电机的基本参数已预定义为默认值。</p>
</html>"));
end IM_SquirrelCageData;