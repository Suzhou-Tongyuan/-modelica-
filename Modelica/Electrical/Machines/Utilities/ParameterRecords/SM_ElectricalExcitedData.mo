within Modelica.Electrical.Machines.Utilities.ParameterRecords;
record SM_ElectricalExcitedData 
  "电励磁同步电机的通用参数"
  extends SM_ReluctanceRotorData(Lmd=1.5/(2*pi*fsNominal), Lmq=1.5/(2*pi* 
        fsNominal));
  import Modelica.Constants.pi;
  parameter SI.Voltage VsNominal=100 
    "每相名义定子有效值电压" 
    annotation (Dialog(tab="励磁"));
  parameter SI.Current IeOpenCircuit=10 
    "在名义电压和频率下的开路励磁电流" 
    annotation (Dialog(tab="励磁"));
  parameter SI.Resistance Re=2.5 
    "在TRef下的励磁电阻" annotation (Dialog(tab="励磁"));
  parameter SI.Temperature TeRef=293.15 
    "励磁电阻的参考温度" 
    annotation (Dialog(tab="励磁"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20e=0 
    "励磁电阻的温度系数" 
    annotation (Dialog(tab="励磁"));
  parameter Real sigmae(
    min=0, 
    max=0.99) = 0.025 "总励磁电感的杂散分数" 
    annotation (Dialog(tab="励磁"));
  parameter Machines.Losses.BrushParameters brushParameters(V=0, ILinear=0.01) 
    "刷子损耗参数记录" annotation (Dialog(tab="损耗"));
  annotation (
    defaultComponentName="smeeData", 
    defaultComponentPrefixes="parameter", 
    Documentation(info="<html>
<p>电励磁同步电机的基本参数已预定义为默认值。</p>
</html>"));
end SM_ElectricalExcitedData;