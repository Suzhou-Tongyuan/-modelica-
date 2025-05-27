within Modelica.Clocked;
package RealSignals "用于实数信号的时钟模块库"
  extends Modelica.Icons.Package;
  import Modelica.Units.SI;

  annotation (Documentation(info="<html><p>
<span style=\"color: rgb(51, 51, 51);\">该包包含操作时钟化实数信号的块。特别提供了将连续时间实数信号转换为时钟化实数信号（使用采样器块）以及将时钟化实数信号转换回连续时间信号（使用保持块）的功能，还提供了以时间同步的方式将时钟化实数信号从一个时钟转换到另一个时钟的功能。</span>
</p>
</html>"));
end RealSignals;