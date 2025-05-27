within Modelica.Thermal.FluidHeatFlow.UsersGuide;
class ReleaseNotes "发布说明"
  extends Modelica.Icons.ReleaseNotes;
  annotation(Documentation(info = "<html>

  <h5>4.0.0, 2020-06-04</h5>
  <ul>
  <li>移动软件包接口模型。旁注到
      <a href=\"modelica://Modelica.Thermal.FluidHeatFlow.Interfaces\">Interfaces</a> and
      <a href=\"modelica://Modelica.Thermal.FluidHeatFlow.BaseClasses\">BaseClasses</a>, 见
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2479\">#2479</a></li>
  </ul>

  <h5>3.2.3, 2018-05-28 (Anton Haumer)</h5>
  <ul>
  <li> 修复了IdealPump模型中的一个错误</li>
  <li> 添加了一个简单的开放式水箱模型</li>
  <li> 添加了一个简单的活塞/气缸模型</li>
  <li> 添加了更多媒体</li>
  <li> 添加了更多示例</li>
  </ul>

  <h5>3.2.2, 2010-06-25 (Christian Kral)</h5>
  <ul>
  <li> 添加了用户指南包，包括联系方式和发布说明</li>
  </ul>

  <h5>1.6.7, 2010-06-25 (Christian Kral)</h5>
  <ul>
  <li>阿森纳研究公司更名为 AIT</li>
  </ul>

  <h5>1.6.6, 2007-11-13 (Anton Haumer)</h5>
  <ul>
  <li> 替换了所有nonSIunits</li>
  <li> 重新命名，更加简洁</li>
  </ul>

  <h5>1.6.5, 2007-08-26 (Anton Haumer)</h5>
  <ul>
  <li> 修复了 SimpleFriction 中的单元错误</li>
  </ul>

  <h5>1.6.4, 2007-08-24 (Anton Haumer)</h5>
  <ul>
  <li> 删除了重新声明类型SignalType</li>
  </ul>

  <h5>1.6.3, 2007-08-21 (Anton Haumer)</h5>
  <ul>
  <li> Improved documentation</li>
  </ul>

  <h5>1.6.2, 2007-08-20 (Anton Haumer)</h5>
  <ul>
  <li> 改进文件</li>
  </ul>

  <h5>1.6.1, 2007-08-12 (Anton Haumer)</h5>
  <ul>
  <li> 改进文件</li>
  <li> 删除了TemperatureDifference类型，因为它是在SI中定义的</li>
  </ul>

  <h5>1.60, 2007-01-23 (Anton Haumer)</h5>
  <ul>
  <li> 定义热端口温度的新参数tapT</li>
  </ul>

  <h5>1.5.0 2005-09-07 (Anton Haumer)</h5>
  <ul>
  <li> SemiLinear工作正常</li>
  </ul>

  <h5>1.4.3 Beta 2005-06-20 (Anton Haumer)</h5>
  <ul>
  <li> 混合/半线性测试</li>
  <li>新测试范例： OneMass</li>
  <li>新测试范例： TwoMass</li>
  </ul>

  <h5>1.4.2 Beta, 2005-06-18 (Anton Haumer)</h5>
  <ul>
  <li> 新测试范例： ParallelPumpDropOut</li>
  </ul>

  <h5>1.4.0, 2005-06-13 (Anton Haumer)</h5>
  <ul>
  <li> 稳定版本</li>
  </ul>

  <h5>1.3.3 Beta, 2005-06-07 (Anton Haumer)</h5>
  <ul>
  <li> 更正了 simpleFlow 的用法</li>
  </ul>

  <h5>1.3.1 Beta, 2005/06/04 Anton Haumer</h5>
  <ul>
  <li>新范例： PumpAndValve</li>
  <li>新范例： PumpDropOut</li>
  </ul>

  <h5>1.3.0 Beta, 2005-06-02 (Anton Haumer)</h5>
  <ul>
  <li> 摩擦损失输送到介质</li>
  </ul>

  <h5>1.2.0 Beta, 2005-02-18 (Anton Haumer)</h5>
  <ul>
  <li>在Components.Pipes中引入大地测量高度</li>
  <li>新模型: Components.Valve, Sources.IdealPump</li>
  </ul>

  <h5>1.1.1, 2005-02-18 (Anton Haumer)</h5>
  <ul>
  <li>更正了cv和cp的使用</li>
  </ul>

  <h5>1.1.0, 2005-02-15 (Anton Haumer)</h5>
  <ul>
  <li>整套方案的重组</li>
  </ul>

  <h5>1.0.0, 2005-02-01 (Anton Haumer)</h5>
  <ul>
  <li>首次正式发布稳定版本</li>
  </ul>

</html>"));
end ReleaseNotes;