within Modelica.Blocks;
package Noise "噪声模块库"
  extends Modelica.Icons.Package;

  model GlobalSeed 
    "定义Noise子库中各模块的全局设置，尤其是定义全局种子"
    parameter Boolean enableNoise = true 
      "=true，如果噪声模块产生噪声作为输出；=false，如果它们产生恒定输出" 
      annotation(choices(checkBox = true));
    parameter Boolean useAutomaticSeed = false 
      "=true，如果根据系统时间和进程id选择种子；=false，如果使用固定种子" 
      annotation(choices(checkBox = true));
    parameter Integer fixedSeed = 67867967 
      "固定了随机数生成器的全局种子(如果useAutomaticSeed=false)" 
      annotation(Dialog(enable = not useAutomaticSeed));
    final parameter Integer seed(fixed = false) "实际上使用了全局种子";
    final parameter Integer id_impure(fixed = false) 
      "非纯随机数生成模块Modelica.Math.Random.Utilities.impureXXX的id" annotation(HideResult = true);
  initial equation
    seed = if useAutomaticSeed then Modelica.Math.Random.Utilities.automaticGlobalSeed() else fixedSeed;
    id_impure = Modelica.Math.Random.Utilities.initializeImpureRandom(seed);

    annotation(
      defaultComponentName = "全局种子", 
      defaultComponentPrefixes = "内部", 
      missingInnerMessage = "
您的模型正在使用外部“全局种子”组件，
但内部“全局种子”组件没有定义，因此
该工具引入了一个默认的内部“全局种子”组件。
要更改默认设置，
请拖动Noise.GlobalSeed放入模型中并指定种子。
", Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), 
      graphics = {Ellipse(
      extent = {{-100, 100}, {100, -100}}, 
      lineColor = {0, 0, 127}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid), 
      Text(
      extent = {{-150, 150}, {150, 110}}, 
      textString = "%name", 
      textColor = {0, 0, 255}), 
      Line(visible = enableNoise, 
      points = {{-73, -15}, {-59, -15}, {-59, 1}, {-51, 1}, {-51, -47}, {-43, -47}, {-43, 
      -25}, {-35, -25}, {-35, 59}, {-27, 59}, {-27, 27}, {-27, 27}, {-27, -33}, {-17, -33}, {-17, -15}, {-7, -15}, {-7, -43}, {3, 
      -43}, {3, 39}, {9, 39}, {9, 53}, {15, 53}, {15, -3}, {25, -3}, {25, 9}, {31, 9}, {31, 
      -21}, {41, -21}, {41, 51}, {51, 51}, {51, 17}, {59, 17}, {59, -49}, {69, -49}}, 
      color = {215, 215, 215}), 
      Text(visible = enableNoise and not useAutomaticSeed, 
      extent = {{-90, -4}, {88, -30}}, 
      textColor = {255, 0, 0}, 
      textString = "%fixedSeed"), 
      Line(visible = not enableNoise, 
      points = {{-80, -4}, {84, -4}}, 
      color = {215, 215, 215}), 
      Text(visible = enableNoise and not useAutomaticSeed, 
      extent = {{-84, 34}, {94, 8}}, 
      textColor = {255, 0, 0}, 
      textString = "fixedSeed =")}), 
      Documentation(revisions = "<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
<img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
Initial version implemented by
A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>",info="<html><p>
在同一层次或更高层次上使用噪声子库的某个模块时， 必须拖动Noise.GlobalSeed 来产生一个声明
</p>
<pre><code >inner Modelica.Blocks.Noise.GlobalSeed globalSeed;</code></pre><p>
全局种子模块为同一层次或更低层次的所有噪声模块提供全局选项。 可以选择以下选项：
</p>
<table style=\"width: auto;\"><tbody><tr><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">图标</th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">描述</th></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> <img src=\"modelica://Modelica/Resources/Images/Blocks/Noise/GlobalSeed_FixedSeed.png\" alt=\"\" data-href=\"\" style=\"\"/> </td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> <strong>useAutomaticSeed=false</strong> (=默认):<br><br>固定的全局种子由整数参数固定种子定义。<br>固定种子的值显示在图标中。<br>默认情况下，所有噪声模块都使用固定种子来初始化其伪随机数生成器。<br>与为每个实例单独定义的本地种子相结合。<br>因此，只要使用相同的固定种子进行模拟，<br>噪声模块的所有实例都会生成完全相同的噪声<br>(前提是这些模块的设置也未发生变化)。<br><br>该选项可用于：(a)设计控制系统(如通过参数优化)，<br>并在所有仿真中保持相同的噪声；<br>或(b)执行蒙特卡罗仿真，在每次仿真中改变环境中的固定种子，<br>以便在每次仿真运行中产生不同的噪声。</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> <img src=\"modelica://Modelica/Resources/Images/Blocks/Noise/GlobalSeed_AutomaticSeed.png\" alt=\"\" data-href=\"\" style=\"\"/> </td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> <strong>useAutomaticSeed=true</strong>:<br><br>自动全局种子是通过仿真所在进程的ID和当前本地时间计算得出的。<br>因此，<br>每次新的模拟(包括并行模拟运行)都会自动更改全局种子。<br>该选项可用于以最小的代价(只需执行多次模拟运行)执行蒙特卡罗模拟，<br>每次模拟运行都会使用不同的噪声。</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> <img src=\"modelica://Modelica/Resources/Images/Blocks/Noise/GlobalSeed_NoNoise.png\" alt=\"\" data-href=\"\" style=\"\"/> </td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> <strong>enableNoise=false</strong>:<br><br>关闭所有噪声示例中的噪声，模块始终输出恒定信号(通常为零)。<br>如果需要在没有噪声的情况下测试模型，<br>并且需要快速关闭或打开噪声，则该选项非常有用。</td></tr></tbody></table><p>
此外，全局种子示例还会调用函数 <a href=\"modelica://Modelica.Math.Random.Utilities.initializeImpureRandom\" target=\"\">initializeImpureRandom</a> 来初始化不纯随机数生成器 (<a href=\"modelica://Modelica.Math.Random.Utilities.impureRandom\" target=\"\">impureRandom</a>和<a href=\"modelica://Modelica.Math.Random.Utilities.impureRandomInteger\" target=\"\">impureRandomInteger</a>)。 该函数的返回值存储在参数<strong>id_impure</strong>中。 无论何时需要调用其中一个不纯随机数生成器， 都必须将\"globalSeed.id_impure\"作为输入参数。
</p>
<p>
注意，我们将通过 <a href=\"modelica://Modelica.Blocks.Examples.Noise.AutomaticSeed\" target=\"\">AutomaticSeed</a>和<a href=\"modelica://Modelica.Blocks.Examples.Noise.ImpureGenerator\" target=\"\">ImpureGenerator</a> 示例来演示该代码块的用法。
</p>
<p>
请注意，由于使用<a href=\"modelica://Modelica.Math.Random.Utilities.initializeImpureRandom\" target=\"\">initializeImpureRandom</a> 初始化不纯随机数生成器，模型中只能定义一个全局种子实例！ 因此，该模块通常位于模型的顶层。
</p>
<p>
<br>
</p>
</html>"));
  end GlobalSeed;

  block UniformNoise "均匀分布的噪声发生模块"
    import distribution = Modelica.Math.Distributions.Uniform.quantile;
    extends Modelica.Blocks.Interfaces.PartialNoise;

    // 主对话菜单
    parameter Real y_min(start = 0) "y的下限" annotation(Dialog(enable = enableNoise));
    parameter Real y_max(start = 1) "y的上限" annotation(Dialog(enable = enableNoise));

  initial equation
    r = distribution(r_raw, y_min, y_max);

  equation
    // 在采样时间抽取随机数
    when generateNoise and sample(startTime, samplePeriod) then
      r = distribution(r_raw, y_min, y_max);
    end when;

    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, 
      {100, 100}}), graphics = {
      Line(visible = enableNoise, 
      points = {{-76, 60}, {78, 60}}, color = {95, 95, 95}, 
      pattern = LinePattern.Dot), 
      Line(visible = enableNoise, 
      points = {{-76, -60}, {78, -60}}, color = {95, 95, 95}, 
      pattern = LinePattern.Dot), 
      Text(visible = enableNoise, 
      extent = {{-70, 94}, {95, 64}}, 
      textColor = {175, 175, 175}, 
      textString = "%y_max"), 
      Text(visible = enableNoise, 
      extent = {{-70, -64}, {95, -94}}, 
      textColor = {175, 175, 175}, 
      textString = "%y_min")}), 
      Documentation(info = "<html>
<p>
<a href=\"modelica://Modelica.Blocks.Noise\">Blocks.Noise</a>
组件包的文档中提供了噪声模块的共同属性摘要。
UniformNoise模块根据均匀分布在输出端生成可重现的随机噪音。
这意味着随机值在参数y_min和y_max定义的范围内均匀分布
(参见<a href=\"modelica://Modelica.Blocks.Examples.Noise.UniformNoiseProperties\">Noise.UniformNoiseProperties</a>示例)。
默认情况下，两个或多个实例会在同一时间瞬间产生不同的、不相关的噪声。
只有在同一层次或更高的层次上，拖动模型
<a href=\"modelica://Modelica.Blocks.Noise.GlobalSeed\">Blocks.Noise.GlobalSeed</a>
为所有实例提供全局设置时，才能使用该模块。
</p>
</html>", revisions = "<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
   <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
   Initial version implemented by
   A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
   <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
  end UniformNoise;

  block NormalNoise "正态分布噪声发生模块"
    import distribution = Modelica.Math.Distributions.Normal.quantile;
    extends Modelica.Blocks.Interfaces.PartialNoise;

    // 主对话菜单
    parameter Real mu = 0 "正态分布的期望值(平均值)" annotation(Dialog(enable = enableNoise));
    parameter Real sigma(start = 1) 
      "正态分布标准差" annotation(Dialog(enable = enableNoise));

  initial equation
    r = distribution(r_raw, mu, sigma);

  equation
    // 在采样时间抽取随机数
    when generateNoise and sample(startTime, samplePeriod) then
      r = distribution(r_raw, mu, sigma);
    end when;

    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, 
      {100, 100}}), graphics = {
      Text(visible = enableNoise, 
      extent = {{-66, 92}, {94, 66}}, 
      textColor = {175, 175, 175}, 
      textString = "mu=%mu"), 
      Text(visible = enableNoise, 
      extent = {{-70, -68}, {94, -96}}, 
      textColor = {175, 175, 175}, 
      textString = "sigma=%sigma")}), 
      Documentation(info = "<html>
<p>
<a href=\"modelica://Modelica.Blocks.Noise\">Blocks.Noise</a>
模块的文档中提供了噪声模块的共同属性摘要。
NormalNoise模块根据正态分布在输出端生成可重现的随机噪音。
这意味着随机值呈正态分布，期望值为 mu，标准差为 sigma。
(参见<a href=\"modelica://Modelica.Blocks.Examples.Noise.NormalNoiseProperties\">Examples.Noise.NormalNoiseProperties</a>)。
默认情况下，两个或多个实例会在同一时间瞬间产生不同的、不相关的噪声。
只有在同一层次或更高层次上，
拖动模型<a href=\"modelica://Modelica.Blocks.Noise.GlobalSeed\">Blocks.Noise.GlobalSeed</a>
为所有示例提供全局设置时，才能使用该模块。
</p>
</html>", revisions = "<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
   <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
   Initial version implemented by
   A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
   <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
  end NormalNoise;

  block TruncatedNormalNoise 
    "截断正态分布的噪声发生模块"
    import distribution = 
      Modelica.Math.Distributions.TruncatedNormal.quantile;
    extends Modelica.Blocks.Interfaces.PartialNoise;

    // 主对话菜单
    parameter Real y_min(start = 0) "y的下限" annotation(Dialog(enable = enableNoise));
    parameter Real y_max(start = 1) "y的上限" annotation(Dialog(enable = enableNoise));
    parameter Real mu = (y_max + y_min) / 2 
      "正态分布的期望值(平均值)" annotation(Dialog(enable = enableNoise, tab = "高级", group = "噪声产生"));
    parameter Real sigma = (y_max - y_min) / 6 
      "正态分布的标准差" annotation(Dialog(enable = enableNoise, tab = "高级", group = "噪声产生"));

  initial equation
    r = distribution(r_raw, y_min, y_max, mu, sigma);

  equation
    // 在采样时间抽取随机数
    when generateNoise and sample(startTime, samplePeriod) then
      r = distribution(r_raw, y_min, y_max, mu, sigma);
    end when;

    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, 
      {100, 100}}), graphics = {
      Line(visible = enableNoise, 
      points = {{-76, 60}, {78, 60}}, color = {95, 95, 95}, 
      pattern = LinePattern.Dot), 
      Line(visible = enableNoise, 
      points = {{-76, -60}, {78, -60}}, color = {95, 95, 95}, 
      pattern = LinePattern.Dot), 
      Text(visible = enableNoise, 
      extent = {{-70, 94}, {95, 64}}, 
      textColor = {175, 175, 175}, 
      textString = "%y_max"), 
      Text(visible = enableNoise, 
      extent = {{-70, -64}, {95, -94}}, 
      textColor = {175, 175, 175}, 
      textString = "%y_min"), 
      Text(
      extent = {{-71, 12}, {71, -12}}, 
      textColor = {175, 175, 175}, 
      origin = {-88, -11}, 
      rotation = 90, 
      textString = "normal")}), 
      Documentation(info = "<html>
<p>
<a href=\"modelica://Modelica.Blocks.Noise\">Blocks.Noise</a>
模块的文档中提供了噪声模块的共同属性摘要。
TruncatedNormalNoise模块根据截断正态分布在输出端生成可重现的随机噪声。
这意味着正态分布的随机值被截断到y_min...y_max范围内。
测量噪声通常就是这种分布形式。
默认情况下，
截断正态分布的标准参数取自y_min...y_max：
</p>
<blockquote><p>
平均数=(y_max+y_min)/2,<br>标准差=(y_max-y_min)/6(99.7%的非截断正态分布在y_min...y_max范围内)。
</p></blockquote>

<p>
有关示例，请参阅
<a href=\"modelica://Modelica.Blocks.Examples.Noise.Distributions\">Examples.Noise.Distributions</a>
默认情况下，两个或多个示例会在同一时间瞬间产生不同的、不相关的噪声。
只有在同一层次或更高层次上，拖动模型
<a href=\"modelica://Modelica.Blocks.Noise.GlobalSeed\">Blocks.Noise.GlobalSeed</a>
为所有示例提供全局设置时，才能使用该模块。
</p>
</html>", revisions = "<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
 <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
 Initial version implemented by
 A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
 <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
  end TruncatedNormalNoise;

  block BandLimitedWhiteNoise 
    "用于产生正态分布带限白噪声的噪声发生模块"
    import distribution = Modelica.Math.Distributions.Normal.quantile;
    extends Modelica.Blocks.Interfaces.PartialNoise;

    // 主对话菜单
    parameter Real noisePower = 1 "白噪声信号的功率" annotation(Dialog(enable = enableNoise));

  protected
    parameter Real mu = 0;
    parameter Real sigma = sqrt(noisePower / samplePeriod);

  initial equation
    r = distribution(r_raw, mu, sigma);

  equation
    // 在采样时间抽取随机数
    when generateNoise and sample(startTime, samplePeriod) then
      r = distribution(r_raw, mu, sigma);
    end when;
    annotation(Dialog(enable = enableNoise), Icon(
      graphics = {Text(
      extent = {{-70, 96}, {92, 60}}, 
      textColor = {175, 175, 175}, 
      textString = "%noisePower"), 
      Text(
      extent = {{-96, 11}, {96, -11}}, 
      textColor = {175, 175, 175}, 
      origin = {-87, 0}, 
      rotation = 90, 
      textString = "white noise")}), 
      Documentation(info = "<html>
<p>
有关噪声模块的共同属性摘要，请参见
<a href=\"modelica://Modelica.Blocks.Noise\">Blocks.Noise</a>
文档。
带限白噪声模块根据带限白噪声分布在输出端生成可重现的随机噪声。
它采用正态分布,其中mu=0以及sigma=sqrt(noisePower/samplePeriod)。
</p>

<p>
为了使该模块产生有意义的结果，您应该设置以下参数：
</p>

<ul>
<li> 程序块的<strong>采样周期</strong>应该比模块输出所馈送系统的最快动态快得多(一般100倍)。</li>
<li> 信号的<strong>噪声功率</strong>应设置为白噪声的预期单位频率功率。
由于许多系统模型都假设噪声功率为1，
因此这一预设值应该是合理的首选值(=默认值)。</li>
</ul>

<h4>关于抽样频率</h4>

<p>
理想的白噪声包含所有频率，包括无限高的频率。
然而，在物理系统中通常无法观察到这些频率，
因为所有物理系统都以某种方式包含低通滤波器。
因此，只要噪声信号的频率内容与随后的动力学频率相比超过足够高的因子(例如100)，
就足以生成噪声信号的有限频带内容。
</p>

<h4>关于噪声功率</h4>

<p>
理想白噪声在所有频率上都呈现平坦的趋势，即恒定的功率谱密度。
因此，它具有无限高的功率，
因为信号的总功率可以通过将功率谱密度在所有频率上积分来获得。
以下三种思考信号功率的方式可能会有所帮助：
</p>

<ul>
<li> 信号的能量是其绝对值的平方在时间上的积分。
信号的功率是该积分除以时间跨度的积分。</li>
<li> 信号的总功率也可以通过对其(双边)功率谱密度在所有频率上进行积分来获得。</li>
<li> 信号的总功率最终也等于它的方差。</li>
</ul>

<p>
为了正确设定带限白噪声的功率谱密度水平，
可以直接影响它的正态分布变化的方差。
回顾噪声信号的样本周期生成频率内容在范围±0.5/samplePeriod内，
因此必须增加方差以生成足够的总信号功率。 
总功率必须匹配噪声功率及其频带宽度1/samplePeriod：
<code>signal power = signal variance = noisePower / samplePeriod</code>。
</p>

<p>
示例<a href=\"modelica://Modelica.Blocks.Examples.Noise.DrydenContinuousTurbulence\">Examples.Noise.DrydenContinuousTurbulence</a>
演示了如何利用本模块模拟阵风。
</p>
</html>"));
  end BandLimitedWhiteNoise;
  annotation(Icon(graphics = {Line(
    points = {{-84, 0}, {-54, 0}, {-54, 40}, {-24, 40}, {-24, -70}, {6, -70}, {6, 80}, 
    {36, 80}, {36, -20}, {66, -20}, {66, 60}})}), Documentation(info="<html><p>
该子库包含使用伪随机数生成<strong>可重现噪声</strong>的模块。 在手动或使用优化方法设计控制系统时， 可重复性非常重要 (例如，在改变控制系统的某个参数或某个组件并重新模拟时， 重要的是噪声不能改变， 否则很难确定改变后的控制系统或不同计算的噪声是否改变了受控系统的行为)。 子库<a href=\"modelica://Modelica.Blocks.Examples.Noise\" target=\"\">Blocks.Examples.Noise</a>&nbsp;中提供了许多如何使用噪声模块的示例。
</p>
<h4>全局选项</h4><p>
当使用该子库中的一个模块时，必须在相同或更高层次上拖动 <a href=\"modelica://Modelica.Blocks.Noise.GlobalSeed\" target=\"\">Noise.GlobalSeed</a>&nbsp;模块进行声明
</p>
<p>
<br>
</p>
<pre><code >inner Modelica.Blocks.Noise.GlobalSeed globalSeed;
</code></pre><p>
<br>
</p>
<p>
本模块用于定义对所有实例化的噪声模块都有效的全局选项 (例如用于初始化随机数生成器的全局种子，以及一个用于关闭噪声的开关)。 此外，在这里也初始化了非纯随机数生成器 <a href=\"modelica://Modelica.Math.Random.Utilities.impureRandom\" target=\"\">impureRandom</a>&nbsp; &nbsp;。
</p>
<p>
请注意，由于impureRandom(...)随机数生成器的初始化，模型中只能定义一个全局种子示例！ 因此，该模块通常位于模型的顶层。
</p>
<h4>需要定义的参数</h4><p>
当使用本组件包的噪声模块时，必须至少定义以下参数:
</p>
<p>
<br>
</p>
<table style=\"width: auto;\"><tbody><tr><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">参数</th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">描述</th></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> samplePeriod </td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 随机值以该参数定义的[s]采样率周期性抽取(时间事件在采样时刻产生)。 在采样之间，输出y保持恒定。</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> distribution data </td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 该组件包中的每个噪声模块都需要额外的数据来描述各自的分布。 随机数分布将从0.0...1.0范围内抽取的随机数映射到所需的范围和分布。</td></tr></tbody></table><p>
<br>
</p>
<p>
作为简单演示，请参阅 <a href=\"modelica://Modelica.Blocks.Examples.Noise.UniformNoise\" target=\"\">Blocks.Examples.Noise.UniformNoise</a>&nbsp; &nbsp;示例。 下图显示了抽样周期=0.02 s和uniformdistribution(y_min=-1，y_max=3)的模拟结果：
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/Noise/UniformNoise.png\" alt=\"\" data-href=\"\" style=\"\"/>
</p>
<h4>高级选项：常规设置</h4><p>
在参数菜单的<strong>高级</strong>选项中， 可以在噪声模块中设置更多选项，如下表所示：
</p>
<p>
<br>
</p>
<table style=\"width: auto;\"><tbody><tr><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">参数</th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">描述</th></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> enableNoise </td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> =true，如果在程序块的输出端产生噪声(=默认值)。<br> =false，如果关闭了噪声发生功能，则输出恒定值</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> y_off </td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 当enableNoise=false，模块示例的输出值为y_off。默认值为 y_off = 0.0。 此外，如果enableNoise=true且time&lt;startTime时，模块输出的也是y_off (参见下文对参数startTime的描述)。</td></tr></tbody></table><p>
<br>
</p>
<h4>高级选项：初始化</h4><p>
对于每个模块示例，内部使用的伪随机数生成模块都有自己的状态。 必须根据所需的情况对该状态进行适当的初始化。 为此，可以定义以下参数：
</p>
<p>
<br>
</p>
<table style=\"width: auto;\"><tbody><tr><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">参数</th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">描述</th></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> useGlobalSeed </td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">= true，表示在此噪声块实例中使用“inner GlobalSeed globalSeed”组件中定义的种子（即整数值）来初始化随机数生成器。因此，每当globalSeed定义不同的数字时，每次实例中的噪声都会发生变化。这是默认设置，因此globalSeed组件定义了每次新的仿真运行是否提供相同的噪声（例如，用于控制器参数优化），或者每次新的仿真运行是否提供不同的噪声（例如，用于蒙特卡洛仿真）。<br><br>= false，表示忽略globalSeed定义的种子。例如，如果通过噪声块建模空气动力学湍流，并且该湍流模型需要在所有蒙特卡洛仿真运行中使用，则必须将useGlobalSeed设置为false。</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> useAutomaticLocalSeed </td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">需要一个整数值，称为局部种子，用于初始化特定模块实例的随机数生成器。使用相同局部种子的实例会生成完全相同的随机数值（因此如果其他设置相同，则噪声也相同）。<br> 当<strong>useAutomaticLocalSeed=true</strong>， 本地种子将自动确定，使用的是查询Modelica内置操作符 <a href=\"https://specification.modelica.org/v3.4/Ch3.html#getinstancename\" target=\"\">getInstanceName()</a>&nbsp;得到的模型实例名称的哈希值。注意，这意味着如果组件被重命名，噪声会发生变化。<br>如果 <strong>useAutomaticLocalSeed = false</strong>，局部种子由参数 fixedLocalSeed 明确定义。这样可以保证生成的噪声始终保持相同（前提是其他参数值相同）。</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> fixedLocalSeed </td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 当useAutomaticLocalSeed=false，那么将使用指定的本地种子fixedLocalSeed。 这个种子可以是任何整数，包括零或负数。 初始化算法会根据fixedLocalSeed(当useAutomaticGlobalSeed=true) 还会根据全局种子生成一个有意义的随机数生成模块的初始状态， 即使种子是0或1这样的“坏种子”， 后续生成的随机数也总是具有统计学上的意义。</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> startTime </td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 在输出y处生成噪声的时间点，默认情况下，startTime=0。 对于时间小于startTime的情况，y=y_off。 在某些情况下，模拟一段时间直到达到近似稳态是有意义的。 在这种情况下，startTime应该设置为这个持续时间之后的时间点，以便在稳态开始后开始生成噪声。</td></tr></tbody></table><p>
<br>
</p>
<h4>随机数生成模块</h4><p>
噪声生成的核心是计算范围在0.0到1.0之间的均匀随机数 (这些随机数随后会被转换，见下文)。 这个子库使用Sebastiano Vigna在2014年开发的Xorshift随机数生成器系列 (详情请参考<a href=\"http://xorshift.di.unimi.it\" target=\"\">http://xorshift.di.unimi.it</a>&nbsp; &nbsp;和<a href=\"modelica://Modelica.Math.Random.Generators\" target=\"\">Math.Random.Generators</a>&nbsp; &nbsp;)。 这些随机数生成器具有优秀的统计特性， 即使从初始种子开始， 也能迅速产生具有统计意义的随机数， 而且内部状态向量长度合理， 为2、4和33个整数元素。 长度为2的内部状态向量的随机数生成器用于初始化其他两个生成模块。 长度为4的随机数生成模块被用于这个组件包中的噪声模块， 每个噪声模块都有自己的独立内部状态向量， 以确保噪声的可重复性。 长度为33的整数随机数生成模块则从非纯随机数生成模块中使用， 特别适合大规模并行模拟，每个模拟需要生成大量的随机值。 关于随机数生成模块的更多详细信息可以在 <a href=\"modelica://Modelica.Math.Random.Generators\" target=\"\">Math.Random.Generators</a>&nbsp;组件包的文档中找到。
</p>
<h4>分布情况</h4><p>
在0.0...1.0范围内的均匀随机数通过选择适当<strong>分布</strong>或<strong>截断分布</strong>被转换为所需的随机数分布。 例如，下面是一个截断分布的示例， 展示了正态分布的概率密度函数与其截断版本之间的比较图：
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/TruncatedNormal.density.png\" alt=\"\" data-href=\"\" style=\"\"/>
</p>
<p>
下一个图示显示了相应的反向累积分布函数：
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/TruncatedNormal.quantile.png\" alt=\"\" data-href=\"\" style=\"\"/>
</p>
<p>
当从一个随机数生成器中提供一个介于0.0...1.0之间的x值时， 截断的反向累积概率密度函数(在上述图示中)将这个值转换为所需的带宽 (在图中的范围：-1.5...1.5)。 与标准分布不同，截断分布的优势在于， 生成的随机值限定在定义的带宽内 (而标准正态分布可能产生任何值；当模拟已知在特定范围内的噪声时， 例如±0.1伏特时，使用截断正态分布可以保证随机值仅在这个带宽内生成)。 有关截断分布的更多详细信息，请参阅 <a href=\"modelica://Modelica.Math.Distributions\" target=\"\">Math.Distributions</a>&nbsp;组件包的文档。
</p>
<p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>",revisions = "<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
end Noise;