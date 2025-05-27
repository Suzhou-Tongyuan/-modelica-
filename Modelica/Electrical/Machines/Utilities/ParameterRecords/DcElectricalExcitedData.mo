within Modelica.Electrical.Machines.Utilities.ParameterRecords;
record DcElectricalExcitedData "直流机器的通用参数"
  extends DcPermanentMagnetData;
  parameter SI.Current IeNominal=1 
    "额定励磁电流" annotation (Dialog(tab="励磁"));
  parameter SI.Resistance Re=100 
    "在TeRef下的励磁电阻" 
    annotation (Dialog(tab="励磁"));
  parameter SI.Temperature TeRef=293.15 
    "励磁电阻的参考温度" 
    annotation (Dialog(tab="励磁"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20e=0 
    "励磁电阻的温度系数" 
    annotation (Dialog(tab="励磁"));
  parameter SI.Inductance Le=1 
    "总励磁电感" 
    annotation (Dialog(tab="励磁"));
  parameter Real sigmae(
    min=0, 
    max=0.99) = 0 "总励磁电感的漏电系数" 
    annotation (Dialog(tab="励磁"));
  annotation (
    defaultComponentName="dceeData", 
    defaultComponentPrefixes="parameter", 
    Documentation(info="<html>
<p>直流机器的基本参数已预定义为默认值。</p>
</html>"));
end DcElectricalExcitedData;