within Modelica.Electrical.Polyphase.Functions;
function factorY2DC "从有效值Y电压计算直流电压的因子"
  extends Modelica.Icons.Function; // 使用函数图标
  import Modelica.Constants.pi; // 导入圆周率常数
  import Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems; // 导入对称基本系统数量函数
  input Integer m=3 "相数"; // 输入参数为相数，默认为3
  output Real y "Yrms 到直流的因子"; // 输出参数为因子Yrms到直流
protected
  parameter Integer mBasic=integer(m/numberOfSymmetricBaseSystems(m)); // 基本系统相数
  annotation();
algorithm
  if mBasic==2 then
    y := 4/pi; // 当基本系统相数为2时
  else
    y := 2*sin((mBasic - 1)/2*pi/mBasic)*sqrt(2)*sin(pi/(2*m))/(pi/(2*m)); // 其他情况下的计算公式
  end if;
end factorY2DC;