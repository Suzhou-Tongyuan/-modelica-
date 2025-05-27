within Modelica.Electrical.Machines.Utilities.ParameterRecords;
record TransformerData "变压器的通用参数"
  extends Modelica.Icons.Record;
  parameter Real n_phase=1 
    "每相的主/次电压比";
  parameter String C1="Y" "选择主侧连接方式" annotation (choices(
        choice="Y" "星形连接", choice="D" "三角形连接"));
  parameter String C2="y" "选择次侧连接方式" annotation (
      choices(
      choice="y" "星形连接", 
      choice="d" "三角形连接", 
      choice="z" "Zig-zag连接"));
  parameter Real n=n_phase*(if C1 == "D" and (C2 == "y" or C2 == "z") 
       then 1/sqrt(3) else if C1 == "Y" and C2 == "d" then sqrt(3) else 1) 
    "主/次电压(线对线)比" 
    annotation (Dialog(enable=false));
  parameter SI.Resistance R1=5E-3/3 
    "主侧电阻每相在TRef下" 
    annotation (Dialog(tab="额定电阻和电感"));
  parameter SI.Temperature T1Ref=293.15 
    "主侧电阻的参考温度" 
    annotation (Dialog(tab="额定电阻和电感"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20_1=0 
    "20°C时主侧电阻的温度系数" 
    annotation (Dialog(tab="额定电阻和电感"));
  parameter SI.Inductance L1sigma=78E-6/3 
    "主侧漏感每相" 
    annotation (Dialog(tab="额定电阻和电感"));
  parameter SI.Resistance R2=5E-3/3 
    "次侧电阻每相在 TRef 下" 
    annotation (Dialog(tab="额定电阻和电感"));
  parameter SI.Temperature T2Ref=293.15 
    "次侧电阻的参考温度" 
    annotation (Dialog(tab="额定电阻和电感"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20_2=0 
    "20°C时次侧电阻的温度系数" 
    annotation (Dialog(tab="额定电阻和电感"));
  parameter SI.Inductance L2sigma=78E-6/3 
    "次侧漏感每相" 
    annotation (Dialog(tab="额定电阻和电感"));
  annotation (
    defaultComponentName="transformerData", 
    defaultComponentPrefixes="parameter", 
    Documentation(info="<html>
<p>变压器的基本参数已预定义为默认值。</p>
<p>注意：比值n定义为主/次线对线电压之比；因此用户必须考虑主和次侧的连接方式！</p>
</html>"));
end TransformerData;