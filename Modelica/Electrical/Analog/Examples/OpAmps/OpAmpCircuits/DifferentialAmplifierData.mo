within Modelica.Electrical.Analog.Examples.OpAmps.OpAmpCircuits;
record DifferentialAmplifierData "差分放大器的数据记录"
  extends Modelica.Icons.Record;
  parameter SI.Voltage VSource = 400 "电源线间有效值电压" 
    annotation(Dialog(group = "Source"));
  parameter SI.Frequency fSource = 50 "电源频率" 
    annotation(Dialog(group = "Source"));
  parameter SI.Resistance RLoad = 10 "电源的负载阻值" 
    annotation(Dialog(group = "Source"));
  parameter SI.Resistance RGround = 100e3 "接地连接电阻" 
    annotation(Dialog(group = "Source"));
  parameter Real V0 = 10e3 "无载差分放大倍数" 
    annotation(Dialog(group = "OpAmp"));
  parameter SI.Voltage VSupply = 15 "电压源" 
    annotation(Dialog(group = "OpAmp"));
  parameter Real k = 100 "衰减系数" 
    annotation(Dialog(group = "OpAmp"));
  parameter SI.Resistance R1 = 100e3 "电阻1" 
    annotation(Dialog(group = "OpAmp"));
  parameter SI.Resistance R2 = R1 "电阻2" 
    annotation(Dialog(group = "OpAmp"));
  parameter SI.Resistance R3 = R1 / k "电阻3" 
    annotation(Dialog(group = "OpAmp"));
  parameter SI.Resistance R4 = R3 "电阻4" 
    annotation(Dialog(group = "OpAmp"));
  parameter SI.Resistance RInstrument = 100e3 "仪器的输入阻抗" 
    annotation(Dialog(group = "Measurement"));
  annotation(defaultComponentPrefixes = "parameter", defaultComponentName = "data", 
    Documentation(info = "<html>
<p>
相关参数分类的总结：
</p>
<ul>
<li>电源部分</li>
<li>差分放大器</li>
<li>测量仪器</li>
</ul>
</html>"));
end DifferentialAmplifierData;