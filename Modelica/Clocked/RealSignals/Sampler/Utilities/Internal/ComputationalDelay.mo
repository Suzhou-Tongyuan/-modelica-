within Modelica.Clocked.RealSignals.Sampler.Utilities.Internal;
block ComputationalDelay 
  "将一个时钟信号延迟最多一个周期，用于模拟计算延迟"
  extends Clocked.RealSignals.Interfaces.PartialClockedSISO;
  parameter Integer shiftCounter(min = 0, max = resolution) = 0 
    "(min=0, max=resolution)，计算延迟 = interval() * shiftCounter / resolution" 
    annotation(Evaluate = true, Dialog(group = "计算延迟（秒） = interval() * shiftCounter / resolution"));
  parameter Integer resolution(min = 1) = 1 
    "采样间隔的时间量化分辨率" 
    annotation(Evaluate = true, Dialog(group = "计算延迟（秒） = interval() * shiftCounter / resolution"));
protected
  Real ubuf(start = 0.0);
equation
  assert(resolution >= shiftCounter, "最大计算延迟为一个采样周期，但设置了大于该值的值");
  ubuf = u;
  if shiftCounter < resolution then
    y = shiftSample(u, shiftCounter, resolution);
  else
    y = shiftSample(previous(ubuf), shiftCounter, resolution);
  end if;

  annotation(Documentation(info = "<html>
<p>
该模块将时钟驱动的 Real 输入信号延迟一个周期，
延迟量为 shiftCounter/resolution。
有一个限制条件：shiftCounter/resolution <= 1。
</p>
</html>"));
end ComputationalDelay;