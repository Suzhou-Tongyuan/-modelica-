within Modelica.Magnetic.FundamentalWave.UsersGuide;
class ReleaseNotes "发布说明"
  extends Modelica.Icons.ReleaseNotes;
  annotation (Documentation(info="<html>

<h5>Version 3.2.3, 2019-01-23</h5>

<ul>
  <li>励磁泄漏因数的固定传播，见
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2403\">#2403</a></li>
  <li>添加了电励磁同步电机模型，直接在线启动，见
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2388\">#2388</a></li>
  <li>统一通信间隔，请参见
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2279\">#2279</a></li>
  <li>统一模拟公差，见
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2278\">#2278</a></li>
<li>添加了更多来自
    <a href=\"modelica://Modelica.Electrical.Machines.Examples\">Machines.Examples</a>, see
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2276\">#2276</a></li>
<li>根据以下标准替换文件中错误的渗透率图像
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2208\">#2208</a></li>
<li>已为 SymmetricMultiPhaseCageWinding_obsolete 和 SaliencyCageWinding_obsolete 添加过时注解、
    参见 <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1536\">#1536</a></li>
<li>更新下列文件
    <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Short\">Short</a>,
    <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Idle\">Idle</a> and
    <a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.PermanentMagnet\">PermanentMagnet</a>
    </li>
<li>新增组件:
<ul>
    <li><a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Crossing\">Crossing</a></li>
    <li><a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Permeance\">Permeance</a></li>
</ul></li>
<li>删除了磁阻和磁导模型图标层中的参数文本</li>
<li>根据票据，用磁阻模型代替电感模型重组笼模型
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1536\">#1536</a>;
由于转子状态的数量因新的实现方式而减少，因此需要对模型进行重组，以改变所包含示例的初始条件</li>
<li>根据
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1226\">#1226</a>,
因为并非所有的参考方向都是正确的</li>
<li>添加了复磁势差和磁通量的大小和参数变量，见
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1405\">#1405</a></li>
</ul>

<h5>Version 3.2.1, 2013-07-31</h5>

<ul>
<li>修复了鼠笼和阻尼器模型方向错误的 Bug，请参见程序单
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1226\">#1226</a>;
这还包括拆除之前使用的转子笼热传感器</li>
<li>修正了示例条件初始化的错误，请参见票据
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1223\">#1223</a></li>
<li>修复了 PM 同步电机环境中缺失的默认参数 TpmOperational，请参见工作票
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1216\">#1216</a>#1216</li>
<li>中添加了电压、电流、复磁通量和磁动势差作为全局变量。
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.PolyphaseElectroMagneticConverter\">polyphase converter</a></li>
<li>新增两个组件示例，显示电域和磁域的等效性质</li>
</ul>

<h5>Version 2.0.0, 2013-03-10</h5>

<ul>
<li>更正了错误的参数说明，请参见票据
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1003\">#1003</a></li>
<li>将机器型号的相位数扩展到大于或等于三，请参见票据
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/990\">#990</a></li>
</ul>

<h5>Version 1.7.3, 2013-02-25</h5>

<ul>
<li>更正了错误的参数描述</li>
</ul>

<h5>Version 1.7.2, 2011-06-28</h5>

<ul>
<li>修正了在以下情况下计算核心电导的错误
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricPolyphaseWinding\">SymmetricPolyphaseWinding</a>:
错误的计算<code>G=(m/2)*GcRef/effectiveTurns^2</code>现在被<code>G=(m/2)*GcRef*effectiveTurns^2</code>所取代</li>
</ul>

<h5>Version 1.7.1, 2010-09-03</h5>

<ul>
<li>的命名和文件
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.TwoPort\">
PartialTwoPort</a> 是由
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.TwoPortElementary\">
PartialTwoPortElementary</a> 的命名约定
<a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces\">
Rotational.Interfaces</a>
和 <a href=\"modelica://Modelica.Mechanics.Translational.Interfaces\">
Translational.Interfaces</a></li>
<li>修复了一个断裂的链接和更新的文档</li>
<li>对复杂单元的适应</li>
</ul>

<h5>Version 1.7.0, 2010-05-31</h5>

<ul>
<li>改变 <a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricPolyphaseWinding\">symmetric polyphase winding</a> 模型
  <ul>
      <li>增加了零序电感的基础上
          <a href=\"modelica://Modelica.Electrical.Polyphase.Basic.ZeroInductor\">zero inductor</a></li>
      <li>更换杂散电模型
          <a href=\"modelica://Modelica.Electrical.Polyphase.Basic.Inductor\">inductor</a> 由杂散
          <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Reluctance\">reluctance</a> 模型</li>
      <li>集成磁芯<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.EddyCurrent\">losses</a>
和 <a href=\"modelica://Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">heat port</a></li>
  </ul></li>
  <li>增加了带滑环的感应电机转子铁芯损耗参数</li>
  <li>的热口名称 <a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SinglePhaseWinding\">single-phase winding</a> and <a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricPolyphaseWinding\">symmetric polyphase winding</a>
     </li>
  <li>磁芯损耗在零电感和磁阻模型之间的重新定位</li>
  <li>在每个机器中重新命名定子和转子(绕组)模型的实例</li>
  <li>附加磁势传感器</li>
  <li>删除状态选择</li>
  <li>由于更改损耗变量和热端口名称的更新
      <a href=\"modelica://Modelica.Electrical.Machines\">Electrical.Machines</a></li>
  <li>增加了机器特定的输出记录，以总结功率和损耗平衡</li>
  <li>更新用户指南图片</li>
  <li>的参数中添加了<code>注释(Evaluate=true)</code>，从而提高了性能
      <a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SinglePhaseWinding\">single-phase winding</a></li>
  <li>减少了<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricPolyphaseCageWinding\">symmetric cage</a>模型通过引入一个额外的不接地星形连接</li>
</ul>

<h5>Version 1.6.0, 2010-05-05</h5>

<ul>
<li>将所有参数<code>windingAngle</code>重命名为<code>orientation</code>。以下类会受到影响:
<ul>
<li><a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.SinglePhaseElectroMagneticConverter\">SinglePhaseElectroMagneticConverter</a></li>
<li><a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.PolyphaseElectroMagneticConverter\">PolyphaseElectroMagneticConverter</a></li>
<li><a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SinglePhaseWinding\">SinglePhaseWinding</a></li>
<li><a href=\"modelica://Modelica.Electrical.Polyphase.Functions.symmetricOrientation\">symmetricOrientation</a></li>
</ul></li>
<li>中的类名更改而更新 <a href=\"modelica://Modelica.Electrical.Machines.Icons\">Machines.Icons</a></li>
<li>使用 <a href=\"modelica://Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPort\">HeatTransfer.Interfaces.PartialElementaryConditionalHeatPort</a> 代替
    <a href=\"modelica://Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort\">Analog.Interfaces.ConditionalHeatPort</a> in
    <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.EddyCurrent\">EddyCurrent</a></li>
<li>添加<code>modelica://</code>到所有modelica超链接</li>
<li>的参数显示错误 <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.EddyCurrent\">EddyCurrent</a></li>
<li>更新了部分图片(并将图片文件<code> losspwer .png</code>重命名为<code> losspwer .png</code>)</li>
<li><a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.RotorSaliencyAirGap\">RotorSaliencyAirGap</a>定子正负交换端口
模型，适应相应的方程和更新的代码文档.</li>
</ul>

<h5>Version 1.5.0, 2010-04-28</h5>

<ul>
<li>增加了定子铁心，摩擦，杂散负载和电刷损耗到所有机器类型的基础上
<a href=\"modelica://Modelica.Electrical.Machines. Losses\">loss models</a>
<li>更改的参数
<a href=\"modelica://Modelica.Electrical. Machines\">Machines</a>
模型从R到G</li>
<li>修正了内部数量<code>tauElectrical</code>的错误符号，模型行为不改变</li>
<li>重写了电磁耦合方程，看起来更优雅</li>
</ul>

<h5>Version 1.4.0, 2010-04-22</h5>

<ul>
<li>根据<a href=\"modelica://Modelica.Magnetic.FluxTubes\">FluxTubes</a> 库</li>
<li>增加了热端口的涡流模型</li>
<li>的依赖导致的小更新 <a href=\"modelica://Modelica.Electrical.Machines\">Machines</a></li>
</ul>

<h5>Version 1.3.0, 2010-02-26</h5>

<ul>
<li>更改了一些图标引用</li>
<li>增加了机器模型的状态选择</li>
<li>重组部分机器模型</li>
<li>新增版权信息</li>
</ul>

<h5>Version 1.2.0, 2010-02-17</h5>

<ul>
<li>将Machines重命名为BasicMachines</li>
<li>由于重命名类而更新的依赖项
<a href=\"modelica://Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20\">LinearTemperatureCoefficient20</a></li>
<li>用户指南新增版本说明</li>
</ul>

<h5>Version 1.1.0, 2010-02-15</h5>

<ul>
<li>增加了热连接器和温度相关电阻</li>
</ul>

<h5>Version 1.0.0, 2010-02-04</h5>

<ul>
<li>将库集成到MSL中</li>
</ul>

<h5>Version 0.4.0, 2009-10-29</h5>

<ul>
<li>修正了磁势计算中的错误</li>
</ul>

<h5>Version 0.3.0, 2009-10-28</h5>

<ul>
<li>重命名匝数和绕线角度</li>
</ul>

<h5>Version 0.2.0, 2009-10-20</h5>

<ul>
<li>增加空闲模型</li>
</ul>

<h5>Version 0.1.0, 2009-07-22</h5>

<ul>
<li>第一个版本基于FluxTubes库和Michael Beuschel的磁学库的概念
[<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.References\">Beuschel00</a>]</li>
</ul>
</html>"));
end ReleaseNotes;