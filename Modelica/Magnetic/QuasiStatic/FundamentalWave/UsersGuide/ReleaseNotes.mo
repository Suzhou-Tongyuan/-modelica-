within Modelica.Magnetic.QuasiStatic.FundamentalWave.UsersGuide;
class ReleaseNotes "发布说明"
  extends Modelica.Icons.ReleaseNotes;
  annotation (Documentation(info="<html>

<h5>Version 3.2.3, 2019-01-23</h5>
<ul>
  <li>励磁泄漏因数的固定传播，见
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2403\">#2403</a></li>
  <li>统一通信间隔，请参见
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2279\">#2279</a></li>
  <li>统一模拟公差，见
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2278\">#2278</a></li>
<li>修正了
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2277\">#2277</a></li>
<li>添加了更多来自
    <a href=\"modelica://Modelica.Electrical.Machines.Examples\">Machines.Examples</a>, see
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2276\">#2276</a></li>
<li>加入
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Sensors.RotorDisplacementAngle\">RotorDisplacementAngle</a>, see
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2050\">#2050</a></li>
</ul>

<h5>Version 3.2.2, 2015-02-02</h5>
<ul>
<li>重组接口和基类中的组件</li>
<li>将图书馆迁移到 MSL 主干网</li>
<li>更新和改进文件</li>
<li>新增组件:
<ul>
    <li><a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Permeance\">Permeance</a></li>
</ul></li>
<li>删除了磁阻和磁导模型图标层中的参数文本</li>
<li>修正了票据问题
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1524\">#1524</a></li>
<li>根据票据，用磁阻模型代替电感模型重组笼模型
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1537\">#1537</a></li>
<li>根据
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1226\">#1226</a></li>
<li>在界面、电磁耦合和机器模型中添加了复磁势、磁通量、电压和电流的大小和参数，请参见 #1405</li>
<li>在界面和机器模型中添加了有功功率、无功功率、视在功率和功率因数，请参见
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1405\">#1405</a></li>
<li>新增界面模型
    <a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.TwoPortExtended\">TwoPortExtended</a>
    以简化变量的一致包含，参见
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1405\">#1405</a></li>
<li>更改了接线盒的图标和位置。
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1706\">#1706</a></li>
</ul>

<h5>Version 0.4.1, 2013-12-18</h5>
<ul>
<li>将基本磁端口更名为 MagneticPort</li>
<li>单相至多相转换器的错误修正</li>
<li>修复了 SaliencyCageWinding 中相位数传播的错误</li>
<li>改进图书馆文档</li>
<li>添加了电流控制 SMR 示例，并指出 SMR 逆变器示例已过时</li>
<li>带阻尼笼的市电供电 SMPM 改进型示例</li>
</ul>

<h5>Version 0.4.0, 2013-11-13</h5>
<ul>
<li>根据
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1348\">#1348</a></li>
</ul>

<h5>Version 0.3.0, 2013-11-07</h5>
<ul>
<li>根据《准静态基底曼塔尔波》（QuasiStationaryFundamantalWave），将库从 准静态基底曼塔尔波 更名为 准静态基底曼塔尔波。
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1344\">#1344</a></li>
</ul>

<h5>Version 0.2.5, 2013-11-06</h5>
<ul>
<li>改变了对称组件的实现:symmetricTransformationMatrix(m)现在是
乘以numberOfSymmetricBaseSystems(m)，以克服计算上的差异
电流和电压对称元件。系统的对称组成部分
偶相数现在等于一个相应基系的对称分量.</li>
<li>改进了示例包并删除了SMPM_Inverter示例</li>
</ul>

<h5>Version 0.2.4, 2013-10-02</h5>
<ul>
<li>用逆变器实现了鼠笼式感应电机的实例</li>
<li>转换矩阵在Dymola中更快编译的替代实现</li>
</ul>

<h5>Version 0.2.3, 2013-09-25</h5>
<ul>
<li>自适应的正弦/余弦QS V/f转换器，以匹配瞬态行为</li>
</ul>

<h5>Version 0.2.2, 2013-09-24</h5>
<ul>
<li>固定初始化的例子(改变实现准静态。来源，增加了gamma, gamma, gamma的起始值)</li>
</ul>

<h5>Version 0.2.1, 2013-09-23</h5>
<ul>
<li>用逆变器实现永磁同步电机的实例</li>
</ul>

<h5>Version 0.2.0, 2013-09-01</h5>
<ul>
<li>实现了带滑环转子的感应电机，包括示例</li>
<li>实现磁交叉</li>
</ul>

<h5>Version 0.1.0, 2013-08-27</h5>
<ul>
<li>文档 <a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.UsersGuide.Concept\">phasor concept</a></li>
<li>Connections.branch之间的电和磁准静态连接器，以处理开路和电机操作的机器</li>
<li>显著性效应得到了适当的考虑</li>
<li>与模拟域的电磁耦合在电连接器上实现了完全准静态的v = 0，这可能在未来必须改变</li>
<li>实现的机器类型</li>
<li><ul>
<li>带鼠笼的感应电机</li>
<li>永磁同步电机，可选配阻尼笼</li>
<li>带可选阻尼笼的电励磁同步电机(可在第一次释放时拆卸)</li>
<li>带可选阻尼笼的同步磁阻电机(可在首次发布时拆卸)</li>
</ul></li>
</ul>
</html>"));
end ReleaseNotes;