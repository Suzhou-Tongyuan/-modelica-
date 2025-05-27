within Modelica.Electrical.Machines.UsersGuide;
class ReleaseNotes "版本说明"
  extends Modelica.Icons.ReleaseNotes;
  annotation(preferredView = "info", Documentation(info = "<html>

<h5>版本 3.2.3, 2019-01-23(Anton Haumer, Christian Kral)</h5>
<ul>
  <li>缩短了默认组件名称，参见
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2301\">#2301</a></li>
  <li>添加了新的示例
      <a href=\"modelica://Modelica.Electrical.Machines.Examples.SynchronousMachines.SMEE_DOL\">SMEE_DOL</a>，参见
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2388\">#2388</a></li>
  <li>修复了在
      <a href=\"modelica://Modelica.Electrical.Machines.Losses.DCMachines.Brush\">Brush</a> 中的错误光滑阶次问题，参见
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2315\">#2315</a></li>
  <li>统一了通信间隔，参见
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2279\">#2279</a></li>
  <li>统一了模拟容差，参见
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2278\">#2278</a></li>
  <li>修复了 Modelica.Electrical.Machines.BasicMachines.Components 的图标，参见 <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2031\">#2031</a></li>
  <li>更新了用于三相系统的块和函数</li>
  <li>添加了标准块和函数</li>
  <li>改进了文档</li>
  <li>为松鼠笼模型添加了转子电流的别名</li>
  <li>根据 <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1706\">#1706</a> 更改了端子盒的图标和位置</li>
  <li>根据 <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1753\">#1753</a>、<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1754\">#1754</a> 和 <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1755\">#1755</a> 更新了文档</li>
</ul>

<h5>版本 3.2.1, 2014-10-05(Anton Haumer, Christian Kral)</h5>
<ul>
  <li>修复了功率计算符号错误和次级组件方向错误的错误；参见 #1474</li>
  <li>修正了转子电流方向错误的错误；参见 #1226</li>
  <li>修复了变压器环境模型中温度传播错误的错误；参见 #1579</li>
</ul>

<h5>版本 2.6.0, 2013-02-25(Anton Haumer)</h5>
<ul>
  <li>修正了带滑环转子的感应电机中 turnsRatio 的错误</li>
  <li>修正了参数描述</li>
</ul>

<h5>版本 2.5.0, 2012-XX-XX (Anton Haumer)</h5>
<ul>
  <li>包括了永磁损耗</li>
</ul>

<h5>版本 2.4.0, 2010-04-20(Anton Haumer)</h5>

<ul>
  <li>包括了旋转电机的铁心、摩擦和杂散载荷模型</li>
</ul>

<h5>版本 2.3.0, 2010-02-16(Anton Haumer)</h5>
<ul>
  <li>包括了准静态直流机模型</li>
</ul>

<h5>版本 2.2.0, 2010-02-10(Anton Haumer)</h5>
<ul>
  <li>所有机器都包括了条件热端口</li>
</ul>

<h5>版本 2.1.3, 2010-02-10(Anton Haumer)</h5>
<ul>
  <li>为松鼠笼和阻尼笼准备了条件热端口</li>
</ul>

<h5>版本 2.1.2, 2010-02-09(Anton Haumer)</h5>
<ul>
  <li>包括了新的示例:
<a href=\"modelica://Modelica.Electrical.Machines.Examples.InductionMachines.IMC_Transformer\">
IMC_Transformer</a>,
DC_Comparison</li>
</ul>

<h5>版本 2.1.1, 2010-02-05(Anton Haumer, Christian Kral)</h5>
<ul>
  <li>包括了
<a href=\"modelica://Modelica.Electrical.Machines.Utilities.SwitchedRheostat\">
SwitchedRheostat</a>,
<a href=\"modelica://Modelica.Electrical.Machines.Utilities.RampedRheostat\">
RampedRheostat</a></li>
</ul>

<h5>版本 2.1.0, 2009-08-26(Anton Haumer)</h5>
<ul>
  <li>设置了所有useHeatPort=false</li>
</ul>

<h5>版本 2.0.0, 2007-11-13(Anton Haumer)</h5>
<ul>
  <li>从气隙中移除了replaceable</li>
  <li>从支撑中移除了基数，使用了一个布尔参数</li>
  <li>移除了所有的非SI单位</li>
</ul>

<h5>版本 1.9.2, 2007-10-15(Anton Haumer)</h5>
<ul>
  <li>更改了一些名称以使其更简洁(参见转换脚本)</li>
</ul>

<h5>版本 1.9.1, 2007-10-15 (Anton Haumer)</h5>
<ul>
  <li>解决了可替换气隙/部分机器的错误</li>
</ul>

<h5>版本 1.9.0, 2007-08-24(Anton Haumer)</h5>

<ul>
  <li>移除了重新声明类型SignalType</li>
</ul>

<h5>版本 1.8.8, 2007-08-20(Anton Haumer)</h5>

<ul>
  <li>改进了文档</li>
</ul>

<h5>版本 1.8.7, 2007-08-20(Anton Haumer)</h5>
<ul>
  <li>更正了文档中的拼写错误</li>
</ul>

<h5>版本 1.8.6, 2007-08-12 (Anton Haumer)</h5>

<ul>
  <li>改进了文档</li>
</ul>

<h5>版本 1.8.5, 2007-06-26 (Anton Haumer)</h5>
<ul>
  <li>DCSE的一致参数</li>
</ul>

<h5>版本 1.8.4, 2007-06-25(Anton Haumer)</h5>
<ul>
  <li>更正了文档中的一些拼写错误</li>
</ul>

<h5>版本 1.8.3, 2007-06-08(Anton Haumer)</h5>
<ul>
  <li>文档更新</li>
</ul>

<h5>版本 1.8.2, 2007-01-15(Anton Haumer)</h5>
<ul>
  <li>解决了电励磁同步机中的一个错误</li>
</ul>

<h5>版本 1.8.1, 2006-12-01(Anton Haumer)</h5>
<ul>
  <li>解决了与气隙兼容性问题</li>
</ul>

<h5>版本 1.8.0, 2006-11-26(Anton Haumer)</h5>
<ul>
  <li>引入了Transformers 包</li>
  <li>将公共参数和功能移动到了部分模型中，分别为 Interfaces.PartialBasicInductionMachines 和 PartialBasicDCMachine，以保持兼容性</li>
  <li>实现了显示反作用力矩的支持</li>
</ul>

<h5>版本 1.7.1, 2006-02-06(Anton Haumer)</h5>
<ul>
  <li>更改了一些同步机的命名，不影响现有模型</li>
</ul>

<h5>版本 1.7.0, 2005-12-15(Anton Haumer)</h5>
<ul>
  <li>将命名后改回以确保向后兼容</li>
</ul>

<h5>版本 1.6.3, 2005-11-25(Anton Haumer)</h5>

<ul>
  <li>简化了感应电机IM_SlipRing模型的参数化</li>
</ul>

<h5>版本 1.6.2, 2005-10-23(Anton Haumer)</h5>
<ul>
  <li>为同步机包括了可选择的阻尼笼</li>
</ul>

<h5>版本 1.6.1, 2005-11-22(Anton Haumer)</h5>
<ul>
  <li>改进了SpacePhasor中的变换和旋转</li>
  <li>引入了Examples.Utilities.TerminalBox</li>
</ul>

<h5>版本 1.60, 2005-11-04(Anton Haumer)</h5>
<ul>
  <li>添加了
      <a href=\"modelica://Modelica.Electrical.Machines.SpacePhasors.Components.Rotator\">
      Rotator</a></li>
  <li>更正了参数和变量的一致命名</li>
</ul>

<h5>版本 1.53, 2005-10-14 (Anton Haumer)</h5>
<ul>
  <li>为同步机引入了非对称阻尼笼</li>
</ul>

<h5>版本 1.52, 2005-10-12(Anton Haumer)</h5>
<ul>
  <li>添加了
      <a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.SynchronousMachines.SM_ElectricalExcited\">
SM_ElectricalExcited</a>
      使用新的
      <a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.Components.ElectricalExcitation\">
      ElectricalExcitation</a>
      以及一个新的示例</li>
</ul>

<h5>版本 1.51, 2005-02-01(Anton Haumer)</h5>
<ul>
  <li>将参数polePairs更改为Integer</li>
</ul>

<h5>版本 1.4, 2004-11-11(Anton Haumer)</h5>
<ul>
  <li>移除了机械法兰支持，以便更轻松地在将来的版本中实现 3D 框架</li>
</ul>

<h5>版本 1.3.2, 2004-11-10(Anton Haumer)</h5>
<ul>
  <li>将ReluctanceRotor移动到SynchronousMachines</li>
</ul>

<h5>版本 1.3.1, 2004-11-06(Anton Haumer)</h5>
<ul>
  <li>在Examples.Utilities.VfController中进行了一些小的更改</li>
</ul>

<h5>版本 1.3, 2004-11-05 (Anton Haumer)</h5>
<ul>
  <li>SpacePhasors.Blocks中的几个改进</li>
</ul>

<h5>版本 1.2, 2004-10-27(Anton Haumer)</h5>
<ul>
  <li>修复了支撑(以前是轴承)的错误</li>
</ul>

<h5>版本 1.1, 2004-10-01(Anton Haumer)</h5>
<ul>
  <li>根据Modelica标准库2.1更改了命名和结构</li>
</ul>

<h5>版本 1.03, 2004-09-24(Anton Haumer)</h5>
<ul>
  <li>添加了Sensors包</li>
  <li>添加了串联励磁DC机器</li>
  <li>调试和改进了MoveToRotational</li>
</ul>

<h5>版本 1.02, 2004-09-19(Anton Haumer)</h5>
<ul>
  <li>添加了用于机器类型的新包结构，并添加了DC机器模型</li>
</ul>

<h5>版本 1.01, 2004-09-18(Anton Haumer)</h5>
<ul>
  <li>将机器模型中的常见方程移动到部分机器中改进了MoveToRotational</li>
</ul>

<h5>版本 1.00, 2004-09-16(Anton Haumer)</h5>
<ul>
  <li>第一个稳定版本</li>
</ul>
</html>"));
end ReleaseNotes;