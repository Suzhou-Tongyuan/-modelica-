within Modelica.Electrical.QuasiStatic.UsersGuide;
class ReleaseNotes "发布说明"
  extends Modelica.Icons.ReleaseNotes;

  annotation (Documentation(info="<html>
<h5>版本 3.2.3, 2019-01-23</h5>
<ul>
    <li>添加了阻抗和导纳模型的频率依赖行为，参见
        <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2451\">#2451</a></li>
    <li>添加了频率扫描电压源和电流源，参见
        <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2442\">#2442</a>
    <ul>
        <li>单相 <a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.FrequencySweepVoltageSource\">FrequencySweepVoltageSource</a></li>
        <li>单相 <a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sources.FrequencySweepCurrentSource\">FrequencySweepCurrentSource</a></li>
        <li>多相 <a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sources.FrequencySweepVoltageSource\">FrequencySweepVoltageSource</a></li>
        <li>多相 <a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sources.FrequencySweepCurrentSource\">FrequencySweepCurrentSource</a></li>
    </ul></li>
    <li>缩短了默认组件名称，参见
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2301\">#2301</a></li>
    <li>修复了缺失的 <code>final useConjugateInput = false</code>，参见
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2251\">#2251</a>
    <ul>
      <li><a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Blocks.SymmetricalComponents\">Polyphase.Blocks.SymmetricalComponents</a></li>
      <li><a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Blocks.FromSymmetricalComponents\">Polyphase.Blocks.FromSymmetricalComponents</a></li>
      <li><a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Blocks.SingleToPolyphase\">Polyphase.Blocks.SingleToPolyphase</a></li>
    </ul></li>
<li>更新了电感和变压器模型的图标，参见 <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2210\">#2210</a></li>
<li>在理想准静态变压器模型中添加了极坐标和功率量，参见 <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2173\">#2173</a></li>
<li>删除了冗余的参数 m，来自于
    <a href=\"modelica://Modelica.Electrical.Polyphase.Basic.MutualInductor\">MutualInductor</a>,
    参见 <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2202\">#2202</a></li>
<li>添加了线性多相互感器模型，参见 <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2200\">#2200</a></li>
<li>添加了单相和多相包的复阻抗和导纳模型，参见 ticket
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1870\">#1870</a></li>
<li>在接口和传感器模型中添加了复电压和电流的大小和参数，参见 ticket
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1405\">#1405</a></li>
<li>在接口模型中添加了有功、无功和视在功率以及功率因数，参见 ticket
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1405\">#1405</a></li>
<li>添加了单相和多相复阻抗和导纳模型（ticket
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1367\">#1367</a>）</li>
<li>更新了电阻和导纳模型的温度依赖性文档</li>
<li>重写了源模型以简化初始化 (
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/commit/861851e3b9628fa483e958a943ab015c15fcb821\">r7031</a>)</li>
<li>实现了理想变压器模型</li>
</ul>

<h5>版本 1.0.0</h5>
<ul><li>首次正式发布</li></ul>
</html>", revisions="<html>
</html>"));
end ReleaseNotes;