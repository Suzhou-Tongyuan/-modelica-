within Modelica;
package Clocked "用于描述同步行为的时钟触发模块，适合用于控制系统的实现"
  extends Modelica.Icons.Package;

  annotation(preferredView = "info", 
    Documentation(info="<html>
<p>
<strong>Modelica.Clocked</strong> <span style=\"color: rgb(51, 51, 51);\">是一个 Modelica 包，用于精确定义和同步具有不同采样率的采样数据系统。该库包含用于定义周期性时钟和事件时钟的元素，这些时钟触发元素进行同步采样、子采样、超采样或移位采样。可以选择性地模拟量化效应、计算延迟或噪声。连续时间方程可以自动离散化，并用于采样数据系统中。每个分区的采样率只需在一个位置定义。</span>
</p>
<p>
在以下<a href=\"modelica://Modelica.Clocked.Examples.SimpleControlledDrive.ClockedWithDiscreteController\" target=\"\">示例</a>中展示了一个简单的采样数据系统， 其中离散时间分区的边界由采样保持操作符标记， 分区中使用了一个时钟驱动的PI控制器， 并且采样率在一个位置通过时钟进行定义：
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Clocked/SimpleSampledSystem.png\" alt=\"Simple sampled-data system\" data-href=\"\" style=\"\"/>
</p>
<p>
这个库的初始版本在成为Modelica标准库的<strong>Modelica.Clocked</strong>包之前，是以<strong>Modelica_Synchronous</strong>库的名义开发和发布的。基本原则和组件与初始库中的相同，因此<strong>Modelica_Synchronous</strong>的介绍材料仍然有效，特别是：
</p>
<li>
<a href=\"modelica://Modelica/Resources/Documentation/Clocked/Modelica_Synchronous.pdf\" target=\"\">Modelica_Synchronous.pdf</a>&nbsp;<span style=\"color: rgb(51, 51, 51);\">是一个概述该库的幻灯片集</span>。</li>
<li>
<a href=\"https://www.doi.org/10.3384/ecp1207627\" target=\"\">A Library for Synchronous Control Systems in Modelica</a>&nbsp;是相应的论文。</li>
<p>
此外：
</p>
<li>
<a href=\"modelica://Modelica.Clocked.UsersGuide\" target=\"\">User's Guide</a>&nbsp;讨论了该库最重要的方面。</li>
<li>
<a href=\"modelica://Modelica.Clocked.UsersGuide.ReleaseNotes\" target=\"\">Release Notes</a>&nbsp;概述了库版本的变化。</li>
<li>
<a href=\"modelica://Modelica.Clocked.UsersGuide.Contact\" target=\"\">Contact</a>&nbsp;提供该库的作者和致谢信息。</li>
<p>
<em>版权所有&copy; 2012-2020，Modelica协会及其贡献者。</em>
</p>
</html>",revisions = "<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> Aug. 28, 2012 </td>
    <td>
    <table border=\"0\">
    <tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
    </td><td valign=\"bottom\">
    Initial version implemented by M. Otter and B. Thiele released as <em>Modelica_Synchronous</em> (version 0.9) library.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
    </td></tr>
    </table>
</td></tr>

<tr><td></td><td>Several releases as <em>Modelica_Synchronous</em> library.</td></tr>

<tr><td> 2019 </td><td>The <em>Modelica_Synchronous</em> library is included as <em>Modelica.Clocked</em> in the Modelica Standard Library 4.0.0.</td></tr>

<tr><td></td><td>see <a href=\"modelica://Modelica.Clocked.UsersGuide.ReleaseNotes\">Release Notes</a>.</td></tr>

</table>
</html>"), 
    Icon(
    coordinateSystem(
    extent = {{-100, -100}, {100, 100}}, 
    preserveAspectRatio = true), 
    graphics = {
    Ellipse(extent = {{-80, -80}, {80, 80}}), 
    Line(points = {{80, 0}, {60, 0}}), 
    Line(points = {{69.282, 40}, {51.962, 30}}), 
    Line(points = {{40, 69.282}, {30, 51.962}}), 
    Line(points = {{0, 80}, {0, 60}}), 
    Line(points = {{-40, 69.282}, {-30, 51.962}}), 
    Line(points = {{-69.282, 40}, {-51.962, 30}}), 
    Line(points = {{-80, 0}, {-60, 0}}), 
    Line(points = {{-69.282, -40}, {-51.962, -30}}), 
    Line(points = {{-40, -69.282}, {-30, -51.962}}), 
    Line(points = {{0, -80}, {0, -60}}), 
    Line(points = {{40, -69.282}, {30, -51.962}}), 
    Line(points = {{69.282, -40}, {51.962, -30}}), 
    Line(points = {{80, 0}, {60, 0}}), 
    Line(points = {{0, 0}, {-50, 50}}), 
    Line(points = {{0, 0}, {40, 0}})}));
end Clocked;