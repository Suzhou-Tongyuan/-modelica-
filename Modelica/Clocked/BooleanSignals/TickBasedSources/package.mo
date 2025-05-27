within Modelica.Clocked.BooleanSignals;
package TickBasedSources "生成基于时钟刻度/采样布尔信号的信号源块软件包"
   extends Modelica.Icons.SourcesPackage;

  annotation (Documentation(info="<html><p>
<br>这个包提供类似于 <a href=\"modelica://Modelica.Blocks.Sources\" target=\"\">Modelica.Blocks.Sources</a>&nbsp; 中<br>提供的 <strong>源</strong> 组件，但不同之处在于它们提供<br>
</p>
<ol><li>
<span style=\"color: rgb(51, 51, 51);\">一个时钟输出信号</span></li>
<li>
<span style=\"color: rgb(51, 51, 51);\">以时钟周期为参数，而不是仿真时间</span>。</li>
</ol></html>"));
end TickBasedSources;