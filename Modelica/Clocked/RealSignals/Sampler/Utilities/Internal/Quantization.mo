within Modelica.Clocked.RealSignals.Sampler.Utilities.Internal;
model Quantization "DAC量化效应"
extends Clocked.RealSignals.Interfaces.PartialClockedSISO;

  parameter Boolean quantized = false 
    "= true, 如果需要计算量化效应";
  parameter Real yMax=1 "输出的上限";
  parameter Real yMin=-1 "输出的下限";
  parameter Integer bits(min=1)=8 
    "量化位数（当quantized = true时）";
protected
  parameter Real resolution = if quantized then ((yMax - yMin)/2^bits) else 0;
equation

  if quantized then
    y = resolution*floor(abs(u/resolution) + 0.5)* 
           (if u >= 0 then +1 else -1);
  else
    y = u;
  end if;
  annotation (Documentation(info="<html>
<p>
时钟驱动的Real输入信号被离散化
（离散化由参数 <strong>bits</strong> 定义）。
</p>
</html>"));
end Quantization;