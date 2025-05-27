within Modelica.Clocked;
package BooleanSignals "布尔信号时钟模块库"
  extends Modelica.Icons.Package;
  import Modelica.Units.SI;

  annotation (Documentation(info="<html>
<p>
这个包含了对时钟驱动布尔信号进行操作的模块。
特别地，提供了一些模块，用于将连续时间布尔信号转换为时钟驱动的布尔信号（使用采样器模块），
反之亦然（使用保持模块），以及以时间同步的方式将一个时钟驱动的布尔信号从一个时钟转换到另一个时钟。
</p>
</html>"));
end BooleanSignals;