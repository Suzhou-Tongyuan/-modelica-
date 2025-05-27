within Modelica.Clocked.IntegerSignals;
package TickBasedSources "生成基于时钟滴答/采样整数信号的信号源模块包"
   extends Modelica.Icons.SourcesPackage;

  annotation (Documentation(info="<html><p>
该软件包提供的 <strong>源</strong> 组件类似于 <a href=\"modelica://Modelica.Blocks.Sources\" target=\"\">Modelica.Blocks.Sources</a>&nbsp; 中提供的模块， 但不同之处在于它们提供了
</p>
<ol><li>
<span style=\"color: rgb(51, 51, 51);\">一个</span><span style=\"color: rgb(51, 51, 51);\"><strong>时钟驱动</strong></span><span style=\"color: rgb(51, 51, 51);\">的输出信号</span></li>
<li>
<span style=\"color: rgb(51, 51, 51);\">以</span><span style=\"color: rgb(51, 51, 51);\"><strong>时钟周期</strong></span><span style=\"color: rgb(51, 51, 51);\">而不是仿真时间为参数进行参数化</span></li>
</ol></html>"));
end TickBasedSources;