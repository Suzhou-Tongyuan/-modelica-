within Modelica.Clocked.UsersGuide.ReleaseNotes;
class Version_0_93_0 "版本 0.93.0 (April 10, 2019)"
  extends Modelica.Icons.ReleaseNotes;
  annotation (Documentation(info="<html>
<p>
Version 0.93.0 is backward compatible to version 0.92.1
</p>

<p>Enhancements:</p>
<ul>
<li>使用最新版本的 Modelica 标准库 (v3.2.3) (<a href=\"https://github.com/modelica/Modelica_Synchronous/issues/37\">#37</a>)。</li>
<li>用于事件时钟的新模块，每当观测到的输入角度发生变化时，就会产生一个时钟滴答声 (子软件包 <a href=\"modelica://Modelica.Clocked.ClockSignals.Clocks.Rotational\">ClockSignals.Clocks.Rotational</a>) (<a href=\"https://github.com/modelica/Modelica_Synchronous/issues/34\">#34</a>, <a href=\"https://github.com/modelica/Modelica_Synchronous/issues/36\">#36</a>)。</li>
<li>使用新的旋转事件时钟改进发动机油门控制示例(<a href=\"https://github.com/modelica/Modelica_Synchronous/issues/34\">#32</a>, <a href=\"https://github.com/modelica/Modelica_Synchronous/issues/36\">#33</a>)。</li>
<li>利用（特定于工具的）ModelicaServices 库中的 `SolverMethod` 方法 (<a href=\"https://github.com/modelica/Modelica_Synchronous/issues/20\">#20</a>)。</li>
<li>改进图标。</li>
</ul>
<p>Bug fixes:</p>
<ul>
<li>为数字比较添加容差 <a href=\"modelica://Modelica.Clocked.BooleanSignals.TimeBasedSources.Pulse\">BooleanSignals.TimeBasedSources.Pulse</a> (<a href=\"https://github.com/modelica/Modelica_Synchronous/issues/9\">#9</a>)。</li>
<li>修正了多个示例的过度受限初始系统(<a href=\"https://github.com/modelica/Modelica_Synchronous/issues/10\">#10</a>, <a href=\"https://github.com/modelica/Modelica_Synchronous/issues/11\">#11</a>)。</li>
<li> 在<a href=\"modelica://Modelica.Clocked.BooleanSignals.TickBasedSources.Pulse\">BooleanSignals.TickBasedSources.Pulse</a>中与实数的固定比较(<a href=\"https://github.com/modelica/Modelica_Synchronous/issues/12\">#12</a>)。</li>
<li>修正了在 <a href=\"modelica://Modelica.Clocked.Examples.CascadeControlledDrive\">CascadeControlledDrive</a> examples (<a href=\"https://github.com/modelica/Modelica_Synchronous/issues/30\">#30</a>)。</li>
</ul>

<p>其他（小）修复和改进。</p>
</html>"));
end Version_0_93_0;