within Modelica.Clocked.UsersGuide.ReleaseNotes;
class Version_0_91 "版本 0.91 (Sept. 20, 2012)"
  extends Modelica.Icons.ReleaseNotes;
  annotation (Documentation(info="<html>
<p>
在 Modelica 网页上提供的第一个版本的库。
与 0.9 版相比的变化：
</p>

<ul>
<li> 库的结构略有调整。 </li>
<li> 大大增强了文档功能（现在几乎所有库元素都有文档）。</li>
<li> 在新的 <a href=\"modelica://Modelica.Clocked.Examples.Elementary\">Examples.Elementary</a>
包中，为库中的许多模块添加了简单示例。
这些模块用于生成许多程序模块文档中的图表。
此外，它们还用于测试这些程序模块。</li>
</ul>

<p>
该库已通过 Dymola 2013 FD01 测试：
</p>

<ul>
<li> 使用 “Peda\"Pedantic = true\" 进行 \"Check\" 成功（因此该库应完全兼容 Modelica 3.3 规范）。</li>
<li> \"Check with Simulation\" 成功。</li>
<li> 测试的类覆盖率为 100%（即至少有一个测试使用了库中的每个类）。</li>
<li> 测试模型的结果要么经过人工检查，
要么与 Modelica_LinearSystems.Controller 或 Modelica.Blocks.Discrete 库的结果进行了比较。</li>
</ul>

<p>
该库还通过 MapleSim Standalone Modelica 解析器进行了测试
（因此，另一个 Modelica 工具也推断该库完全符合 Modelica 标准）。
</p>
</html>"));
end Version_0_91;