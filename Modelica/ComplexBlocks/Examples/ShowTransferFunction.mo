within Modelica.ComplexBlocks.Examples;
model ShowTransferFunction "测试复数传递函数模块"
  extends Modelica.Icons.Example;
  parameter Real d = 1 / sqrt(2) "阻尼系数";
  parameter Real b[:] = {1} "传递函数的分母多项式系数";
  parameter Real a[:] = {1, 2 * d, 1} "传递函数的分母多项式系数";
  parameter Real wMin = 0.01 "频率扫描下限";
  parameter Real wMax = 100 "频率扫描上限";
  Real lg_w = log10(logFrequencySweep.y) "频率对数";
  Real dB = 20 * log10(complexToPolar.len) "以分贝为单位的传递函数幅度";
  Modelica.Units.SI.Angle phi(displayUnit = "deg") = complexToPolar.phi "传递函数参数";
  Modelica.Blocks.Sources.LogFrequencySweep logFrequencySweep(
    duration = 1, 
    wMin = wMin, 
    wMax = wMax) annotation(Placement(transformation(extent = {{-80, -40}, {-60, -20}})));
  Modelica.ComplexBlocks.Sources.ComplexConstant const(k(re = 1, im = 0)) 
    annotation(Placement(transformation(extent = {{-80, -10}, {-60, 10}})));
  Modelica.ComplexBlocks.ComplexMath.TransferFunction transferFunction(b = b, 
    a = a) 
    annotation(Placement(transformation(extent = {{-40, -10}, {-20, 10}})));
  Modelica.ComplexBlocks.ComplexMath.ComplexToPolar complexToPolar 
    annotation(Placement(transformation(extent = {{0, -10}, {20, 10}})));
equation
  connect(const.y, transferFunction.u) 
    annotation(Line(points = {{-59, 0}, {-50.5, 0}, {-42, 0}}, color = {85, 170, 255}));
  connect(logFrequencySweep.y, transferFunction.w) 
    annotation(Line(points = {{-59, -30}, {-30, -30}, {-30, -12}}, color = {0, 0, 127}));
  connect(transferFunction.y, complexToPolar.u) 
    annotation(Line(points = {{-19, 0}, {-2, 0}}, color = {85, 170, 255}));
  annotation(
    experiment(StopTime = 1, Interval = 0.001), Documentation(info = 
    "<html>
<p>这个例子展示了由其传递函数定义的PT2的响应</p>
<blockquote><pre>
            1
H(jw)=-------------------
      1 + 2 d jw + (jw)^2
</pre></blockquote>
<p>频率执行从0.01到100s⁻¹的对数扫描。</p>
<p>
绘制幅度轨迹(以dB为单位)dB对数频率(lg_w)以及相位轨迹对数频率(lg_w)。
</p>
</html>"));
end ShowTransferFunction;