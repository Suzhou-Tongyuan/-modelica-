within Modelica.Electrical.Machines.Utilities;
record TransformerData "从额定值计算阻抗"
  extends Modelica.Icons.Record;
  parameter SI.Frequency f(start=50) "额定频率";
  parameter SI.Voltage V1(start=100) 
    "一次额定线电压(有效值)";
  parameter String C1(start="Y") "选择一次侧连接方式" annotation (
      choices(choice="Y" "星形连接", choice="D" "三角形连接"));
  parameter SI.Voltage V2(start=100) 
    "二次开路线电压(有效值)，在一次额定电压下";
  parameter String C2(start="y") "选择二次侧连接方式" annotation (
      choices(
      choice="y" "星形连接", 
      choice="d" "三角形连接", 
      choice="z" "Z形连接"));
  parameter SI.ApparentPower SNominal(start=30E3) 
    "额定视在功率";
  parameter Real v_sc(
    final min=0, 
    final max=1, 
    start=0.05) "阻抗电压降pu";
  parameter SI.Power P_sc(start=300) 
    "短路(铜)损耗";
  parameter Real n=V1/V2 
    "一次电压(线电压)/二次电压(线电压)比例" 
    annotation (Dialog(tab="Result",enable=false));
  final parameter SI.Voltage V1ph=V1/(if C1 == "D" then 1 
       else sqrt(3)) "一次相电压(有效值)";
  final parameter SI.Current I1ph=SNominal/(3*V1ph) 
    "一次相电流(有效值)";
  final parameter SI.Voltage V2ph=V2/(if C2 == "d" then 1 
       else sqrt(3)) "二次相电压(有效值)";
  final parameter SI.Current I2ph=SNominal/(3*V2ph) 
    "二次相电流(有效值)";
  final parameter SI.Impedance Z1ph=0.5*v_sc*V1ph/I1ph 
    "每相一次阻抗";
  parameter SI.Resistance R1=0.5*P_sc/(3*I1ph^2) 
    "一次绕组每相电阻(在温度下)" 
    annotation (Dialog(tab="Result",enable=false));
  parameter SI.Inductance L1sigma=sqrt(Z1ph^2 - R1^2)/(2* 
      Modelica.Constants.pi*f) "一次绕组每相漏感" 
    annotation (Dialog(tab="Result",enable=false));
  final parameter SI.Impedance Z2ph=0.5*v_sc*V2ph/I2ph 
    "每相二次阻抗";
  parameter SI.Resistance R2=0.5*P_sc/(3*I2ph^2) 
    "二次绕组每相电阻(在温度下)" 
    annotation (Dialog(tab="Result",enable=false));
  parameter SI.Inductance L2sigma=sqrt(Z2ph^2 - R2^2)/(2* 
      Modelica.Constants.pi*f) "二次绕组每相漏感" 
    annotation (Dialog(tab="Result",enable=false));
  annotation (defaultComponentPrefixes="parameter",Documentation(info="<html>
<p>从技术描述中通常给定的参数计算变压器模型的参数。</p>
</html>"));
end TransformerData;