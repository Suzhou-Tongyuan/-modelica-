within Modelica.Clocked.RealSignals;
package TickBasedSources "生成基于时钟的刻度/采样实信号的信号源模块包"
   extends Modelica.Icons.SourcesPackage;

  annotation (Documentation(info="<html><p>
该软件包提供的 源 组件类似于 <a href=\"modelica://Modelica.Blocks.Sources\" target=\"\">Modelica.Blocks.Sources</a>&nbsp; 中提供的模块， 但不同之处在于它们提供了
</p>
<ol><li>
<strong>时钟驱动</strong>的输出信号</li>
<li>
以<strong>时钟滴答</strong>为参数，而不是仿真时间。</li>
</ol></html>"));
end TickBasedSources;