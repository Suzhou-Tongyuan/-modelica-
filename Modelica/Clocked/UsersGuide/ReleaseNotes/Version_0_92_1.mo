within Modelica.Clocked.UsersGuide.ReleaseNotes;
class Version_0_92_1 "版本 0.92.1 (March 11, 2016)"
  extends Modelica.Icons.ReleaseNotes;
  annotation (Documentation(info="<html>
<p>
0.92.1 版向后兼容 0.92 版
</p>

<p>
该版本使用 Modelica 3.2.2 软件包。
</p>

<p>
与 0.92 版相比的变更：
</p>

<ul>
<li> RealSignals.Sampler：删除了错误的 u 和 y 的双重声明（由于扩展和显式声明而存在）</li>
<li> 修复了文档中的无效链接(#1341)</li>
<li> 修正了 BooleanSignals.TickBasedSources.Pulse 错误的单位(#1889)</li>
<li> 修复了 RealSignals.Sampler.AssignClock 中缺失的 useClock 参数(#1919)</li>
<li> 为 {Real,Integer,Boolean}Signals.Sampler.{Shift,Back}Sample 的时钟参数设置 Evaluate=true(OpenModelica Ticket 3717)</li>
</ul>
</html>"));
end Version_0_92_1;