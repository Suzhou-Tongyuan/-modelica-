within Modelica.Clocked.RealSignals;
package TimeBasedSources "生成基于时钟模拟时间的实信号的信号源模块包"
   extends Modelica.Icons.SourcesPackage;

  annotation (Documentation(info="<html><p style=\"text-align: start;\">该包提供的源组件类似于 <a href=\"modelica://Modelica.Blocks.Sources\" target=\"\">Modelica.Blocks.Sources</a>&nbsp; 中的模块，不同之处在于它们提供的是<strong>时钟驱动</strong>的输出信号。
</p>
<p style=\"text-align: start;\">因此，当输出信号连接到需要时钟输入信号的系统时，无需使用额外的采样模块。因此，使用此包中的模块比使用 <a href=\"modelica://Modelica.Blocks.Sources\" target=\"\">Modelica.Blocks.Sources</a>&nbsp; 中的模块更为方便，因为无需为从连续时间信号转换到时钟信号添加额外的采样模块。
</p>
</html>"));
end TimeBasedSources;