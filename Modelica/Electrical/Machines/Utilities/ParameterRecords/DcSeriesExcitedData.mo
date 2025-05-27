within Modelica.Electrical.Machines.Utilities.ParameterRecords;
record DcSeriesExcitedData "直流电机的通用参数"
  extends DcPermanentMagnetData(wNominal=1410*2*pi/60);
  import Modelica.Constants.pi;
  parameter SI.Resistance Re=0.01 
    "在 TeRef 下的串励电阻" 
    annotation (Dialog(tab="励磁"));
  parameter SI.Temperature TeRef=293.15 
    "串励电阻的参考温度" 
    annotation (Dialog(tab="励磁"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20e=0 
    "串励电阻的温度系数" 
    annotation (Dialog(tab="励磁"));
  parameter SI.Inductance Le=0.0005 
    "总串励电感" 
    annotation (Dialog(tab="励磁"));
  parameter Real sigmae(
    min=0, 
    max=0.99) = 0 "总串励电感的漏电系数" 
    annotation (Dialog(tab="励磁"));
  parameter SI.Temperature TeNominal=293.15 
    "额定串励温度" 
    annotation (Dialog(tab="额定参数"));
  annotation (
    defaultComponentName="dcseData", 
    defaultComponentPrefixes="parameter", 
    Documentation(info="<html>
<p>直流电机的基本参数已预定义为默认值。</p>
</html>"));
end DcSeriesExcitedData;