within Modelica.Clocked.IntegerSignals;
package TimeBasedSources "生成基于时钟模拟时间的整数信号的信号源模块包"
   extends Modelica.Icons.SourcesPackage;

  annotation (Documentation(info="<html><p>
该软件包提供的 <strong>源</strong> 组件类似于 <a href=\"modelica://Modelica.Blocks.Sources\" target=\"\">Modelica.Blocks.Sources</a>&nbsp; 中提供的模块， 但不同之处在于它们提供<strong> 时钟驱动 </strong>输出信号。
</p>
<p>
因此，如果输出信号连接到需要时钟输入信号的系统， 就不必使用中间的采模样块。 因此，使用这个包提供的模块可能比使用 <a href=\"modelica://Modelica.Blocks.Sources\" target=\"\">Modelica.Blocks.Sources</a>&nbsp; 提供的模块稍微方便一些 （因为不需要为从连续时间信号到时钟信号的过渡添加额外的采样模块）。
</p>
</html>"));
end TimeBasedSources;