within Modelica.Clocked.BooleanSignals;
package TimeBasedSources "生成基于时钟模拟时间的布尔信号的信号源模块包"
   extends Modelica.Icons.SourcesPackage;

  annotation (Documentation(info="<html><p>
这个包提供类似于 <a href=\"modelica://Modelica.Blocks.Sources\" target=\"\">Modelica.Blocks.Sources</a>&nbsp; &nbsp;中提供的 <strong>源</strong> 组件，<span style=\"color: rgb(51, 51, 51);\">但不同之处在于它们提供了一个时钟输出信号</span>。
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">因此，如果输出信号连接到需要时钟输入信号的系统，就不需要使用中间的采样（Sample）模块。因此，使用这个包提供的模块比使用</span><a href=\"modelica://Modelica.Blocks.Sources\" target=\"\">Modelica.Blocks.Sources</a>&nbsp; <span style=\"color: rgb(51, 51, 51);\"> 中的模块稍微更加方便，因为不需要为了从连续时间信号转换到时钟信号而额外添加一个采样模块。</span>
</p>
</html>"));
end TimeBasedSources;