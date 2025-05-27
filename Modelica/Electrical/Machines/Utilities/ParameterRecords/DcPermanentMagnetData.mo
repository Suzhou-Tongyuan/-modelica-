within Modelica.Electrical.Machines.Utilities.ParameterRecords;
record DcPermanentMagnetData "直流机器的通用参数"
  extends Modelica.Icons.Record;
  import Modelica.Constants.pi;
  parameter SI.Inertia Jr=0.15 "转子的转动惯量";
  parameter SI.Inertia Js=Jr "定子的转动惯量";
  parameter SI.Voltage VaNominal=100 
    "额定电枢电压" 
    annotation (Dialog(tab="名义参数"));
  parameter SI.Current IaNominal=100 
    "额定电枢电流(>0..电机,<0..发电机)" 
    annotation (Dialog(tab="名义参数"));
  parameter SI.AngularVelocity wNominal(displayUnit="rev/min")= 
       1425*2*pi/60 "额定转速" 
    annotation (Dialog(tab="名义参数"));
  parameter SI.Temperature TaNominal=293.15 
    "额定电枢温度" 
    annotation (Dialog(tab="名义参数"));
  parameter SI.Resistance Ra=0.05 
    "在 TaRef 下的电枢电阻" 
    annotation (Dialog(tab="电枢"));
  parameter SI.Temperature TaRef=293.15 
    "电枢电阻的参考温度" 
    annotation (Dialog(tab="电枢"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20a=0 
    "电枢电阻的温度系数" 
    annotation (Dialog(tab="电枢"));
  parameter SI.Inductance La=0.0015 "电枢电感" 
    annotation (Dialog(tab="电枢"));
  parameter Machines.Losses.FrictionParameters frictionParameters(PRef=0, wRef= 
        wNominal) "摩擦损耗参数记录" 
    annotation (Dialog(tab="损耗"));
  parameter SI.Voltage ViNominal=VaNominal - 
      Machines.Thermal.convertResistance(
            Ra, 
            TaRef, 
            alpha20a, 
            TaNominal)*IaNominal - 
      Machines.Losses.DCMachines.brushVoltageDrop(brushParameters, 
      IaNominal) "额定工作点的感应电压";
  parameter Machines.Losses.CoreParameters coreParameters(
    final m=1, 
    PRef=0, 
    VRef=ViNominal, 
    wRef=wNominal) "电枢铁芯损耗参数记录" 
    annotation (Dialog(tab="损耗"));
  parameter Machines.Losses.StrayLoadParameters strayLoadParameters(
    PRef=0, 
    IRef=IaNominal, 
    wRef=wNominal) "漏电损耗" annotation (Dialog(tab="损耗"));
  parameter Machines.Losses.BrushParameters brushParameters(V=0, ILinear=0.01* 
        IaNominal) "刷子损耗参数记录" 
    annotation (Dialog(tab="损耗"));
  annotation (
    defaultComponentName="dcpmData", 
    defaultComponentPrefixes="parameter", 
    Documentation(info="<html>
<p>直流机器的基本参数已预定义为默认值。</p>
</html>"));
end DcPermanentMagnetData;