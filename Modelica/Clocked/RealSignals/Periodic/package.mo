within Modelica.Clocked.RealSignals;
package Periodic "只对周期性时钟信号（主要由 Z 变换描述）进行操作的模块库"
extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>
这个软件包包含专为周期性时钟系统设计的模块。
如果更改采样率（而不同时更改模块的参数），
或者在非周期性时钟信号上使用这些模块，通常会导致意料之外的行为。
</p>
</html>"));
end Periodic;