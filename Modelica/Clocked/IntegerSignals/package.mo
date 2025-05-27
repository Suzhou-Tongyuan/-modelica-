within Modelica.Clocked;
package IntegerSignals "整数信号时钟模块库"
  extends Modelica.Icons.Package;
  import Modelica.Units.SI;

  annotation (Documentation(info="<html>
<p>
这个包含了对时钟整数信号进行操作的模块。
特别提供了一些模块，可以将连续时间整数信号转换为时钟整数信号（使用Sampler模块），
反之亦然（使用Hold器模块），以及以时间同步方式将一个时钟整数信号从一个时钟转换为另一个时钟的模块。
</p>
</html>"));
end IntegerSignals;