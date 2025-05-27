within Modelica.Electrical.Machines.Utilities.ParameterRecords;
record SM_PermanentMagnetData 
  "永磁同步电机的通用参数"
  extends SM_ReluctanceRotorData(Lmd=0.3/(2*pi*fsNominal), Lmq=0.3/(2*pi* 
        fsNominal));
  import Modelica.Constants.pi;
  parameter SI.Voltage VsOpenCircuit=112.3 
    "在fsNominal下的开路每相有效值电压";
  parameter Machines.Losses.PermanentMagnetLossParameters permanentMagnetLossParameters(
    PRef=0, 
    IRef=100, 
    wRef=2*pi*fsNominal/p) "永磁损耗参数记录" 
    annotation (Dialog(tab="损耗"));
  annotation (
    defaultComponentName="smpmData", 
    defaultComponentPrefixes="parameter", 
    Documentation(info="<html>
<p>永磁同步电机的基本参数已预定义为默认值。</p>
</html>"));
end SM_PermanentMagnetData;