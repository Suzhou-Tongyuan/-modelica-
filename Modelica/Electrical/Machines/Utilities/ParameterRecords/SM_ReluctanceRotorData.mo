within Modelica.Electrical.Machines.Utilities.ParameterRecords;
record SM_ReluctanceRotorData 
  "具有磁阻转子的同步机的通用参数"
  extends InductionMachineData(Lssigma=0.1/(2*pi*fsNominal));
  import Modelica.Constants.pi;
  parameter SI.Inductance Lmd=2.9/(2*pi*fsNominal) 
    "d轴每相的定子主场电感" 
    annotation (Dialog(tab="名义电阻和电感"));
  parameter SI.Inductance Lmq=0.9/(2*pi*fsNominal) 
    "q轴每相的定子主场电感" 
    annotation (Dialog(tab="名义电阻和电感"));
  parameter Boolean useDamperCage=true "启用/禁用阻尼笼" 
    annotation (Evaluate=true,Dialog(tab= 
          "名义电阻和电感", group="阻尼笼"));
  parameter SI.Inductance Lrsigmad=0.05/(2*pi*fsNominal) 
    "d 轴阻尼笼杂散电感" annotation (Dialog(
      tab="名义电阻和电感", 
      group="阻尼笼", 
      enable=useDamperCage));
  parameter SI.Inductance Lrsigmaq=Lrsigmad 
    "q 轴阻尼笼杂散电感" annotation (Dialog(
      tab="名义电阻和电感", 
      group="阻尼笼", 
      enable=useDamperCage));
  parameter SI.Resistance Rrd=0.04 
    "d 轴上的阻尼电阻(在TRef下)" annotation (Dialog(
      tab="名义电阻和电感", 
      group="阻尼笼", 
      enable=useDamperCage));
  parameter SI.Resistance Rrq=Rrd 
    "q 轴上的阻尼电阻(在TRef下)" annotation (Dialog(
      tab="名义电阻和电感", 
      group="阻尼笼", 
      enable=useDamperCage));
  parameter SI.Temperature TrRef=293.15 
    "d-轴和 q-轴上的阻尼电阻的参考温度" 
    annotation (Dialog(
      tab="名义电阻和电感", 
      group="阻尼笼", 
      enable=useDamperCage));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20r=0 
    "d-轴和 q-轴上的阻尼电阻的温度系数" 
    annotation (Dialog(
      tab="名义电阻和电感", 
      group="阻尼笼", 
      enable=useDamperCage));
  annotation (
    defaultComponentName="smrData", 
    defaultComponentPrefixes="parameter", 
    Documentation(info="<html>
<p>具有磁阻转子的同步机的基本参数已预定义为默认值。</p>
</html>"));
end SM_ReluctanceRotorData;