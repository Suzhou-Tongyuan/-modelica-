within Modelica.Electrical.Polyphase.Examples.Utilities;
record PolyphaseRectifierData "多相整流器数据记录"
  extends Icons.Record;
  import Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems;
  import Modelica.Math.isPowerOf2;
  parameter Integer m(final min=2)=6 "相数" annotation(Evaluate=true);
  parameter Integer mSystems=numberOfSymmetricBaseSystems(m) 
    "基本系统数量" 
    annotation(Dialog(enable=false));
  parameter Integer mBasic=integer(m/mSystems) 
    "每个基本系统的相数" 
    annotation(Dialog(enable=false));
  final parameter Integer kPolygon=max(1, integer((mBasic - 1)/2)) 
    "最大多边形电压的替代";
  parameter Integer ParDesired(final min=1, final max=mSystems)=mSystems "期望的并联子系统数";
  final parameter Integer Par=if isPowerOf2(ParDesired) then ParDesired else mSystems "并联连接的子系统数";
  final parameter Integer Ser=integer(mSystems/Par) "串联连接的子系统数";
  parameter SI.Voltage VrmsY=100 "星点到线电压的有效值";
  parameter SI.Frequency f=50 "源频率";
  parameter SI.Resistance RLoad=2*Ser/Par "负载电阻";
  parameter SI.Resistance RDC=1e-3 "直流电阻";
  parameter SI.Inductance LDC=3e-3 "直流电感";
  parameter SI.Resistance RGnd=1e5 "接地电阻";
  annotation(defaultComponentPrefixes="parameter");
end PolyphaseRectifierData;