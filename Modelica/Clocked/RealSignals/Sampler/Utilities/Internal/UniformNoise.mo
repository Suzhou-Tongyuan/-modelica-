within Modelica.Clocked.RealSignals.Sampler.Utilities.Internal;
block UniformNoise "使用Wichmann-Hill算法的变种添加带限均匀噪声"
  extends Clocked.RealSignals.Interfaces.PartialNoise;
  parameter Real noiseMax = 0.1 "噪声带的上限";
  parameter Real noiseMin = -noiseMax "噪声带的下限";
  parameter Integer firstSeed[3](each min = 0, each max = 255) = {23, 87, 187} 
    "定义随机序列的Integer[3]；所需元素范围：0..255";
protected
  Integer seedState[3](start = firstSeed, each fixed = true) 
    "种子状态" annotation(HideResult = true);
  Real noise "0..1范围内的噪声" annotation(HideResult = true);
equation
  (noise,seedState) = 
    Clocked.RealSignals.Sampler.Utilities.Internal.random(previous(
    seedState));
  y = u + noiseMin + (noiseMax - noiseMin) * noise;

  annotation(Documentation(info="<html><p style=\"text-align: start;\">该模块将均匀分布的噪声（范围为 noiseMin 到 noiseMax）添加到时钟驱动的实数输入信号，并将其总和作为时钟驱动的实数输出信号提供。
</p>
<p style=\"text-align: start;\">Integer[3] 参数向量 <strong>firstSeed </strong>用于初始化基本的随机数生成器。firstSeed 的三个元素需要在 [0, 255] 范围内。使用相同的种子向量将导致在串行计算时生成相同的数字序列，这通常是不希望的。因此，对于每次使用 <strong>Noise </strong>模块时，应定义一个不同的 firstSeed。
</p>
<p style=\"text-align: start;\">该噪声生成器基于一个生成均匀分布的随机实数的函数，范围为半开区间 [0.0, 1.0)。该函数使用标准的 Wichmann-Hill 生成器，结合了三个模数分别为 30269、30307 和 30323 的纯乘法同余生成器。其周期（在完全重复序列之前生成的数字数量）为 6,953,607,871,644。虽然比大多数 C 库提供的 rand() 函数具有更高的质量，但其理论特性与单个大模数的线性同余生成器非常相似。有关更多细节，请参见底层函数 <a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Utilities.Internal.random\" target=\"\">Internal.random</a>&nbsp;。
</p>
<h4>示例</h4><p>
以下 <a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.UniformNoise\" target=\"\">示例</a>&nbsp; 使用20毫秒周期的时钟采样零信号，并在-0.1 … 0.1范围内添加噪声：<br>
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"50\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/UniformNoise_Model.png\" alt=\"UniformNoise_Model.png\" data-href=\"\" style=\"\"/></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/UniformNoise_Result.png\" alt=\"UniformNoise_Result.png\" data-href=\"\" style=\"\"/></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">模型</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">仿真结果</td></tr></tbody></table><p>
<br>
</p>
</html>"), 
    Icon(graphics = {
    Polygon(
    points = {{-81, 90}, {-89, 68}, {-73, 68}, {-81, 90}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), 
    Text(
    extent = {{-74, 92}, {90, 68}}, 
    textColor = {175, 175, 175}, 
    textString = "%noiseMax"), 
    Line(points = {{-81, 78}, {-81, -90}}, color = {192, 192, 192}), 
    Line(points = {{-89, 62}, {85, 62}}, color = {175, 175, 175}), 
    Line(points = {{-81, -17}, {-67, -17}, {-67, -1}, {-59, -1}, {-59, -49}, {
    -51, -49}, {-51, -27}, {-43, -27}, {-43, 57}, {-35, 57}, {-35, 25}}, 
    color = {0, 0, 127}, 
    pattern = LinePattern.Dot), 
    Line(points = {{-35, 25}, {-35, -35}, {-25, -35}, {-25, -17}, {-15, -17}, {
    -15, -45}, {-5, -45}, {-5, 37}, {1, 37}, {1, 51}, {7, 51}, {7, -5}, {17, 
    -5}, {17, 7}, {23, 7}, {23, -23}, {33, -23}, {33, 49}, {43, 49}, {43, 
    15}, {51, 15}, {51, -51}, {61, -51}}, 
    color = {0, 0, 127}, 
    pattern = LinePattern.Dot), 
    Line(points = {{-90, -23}, {82, -23}}, color = {192, 192, 192}), 
    Polygon(
    points = {{91, -22}, {69, -14}, {69, -30}, {91, -22}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{-90, -54}, {84, -54}}, color = {175, 175, 175}), 
    Ellipse(
    extent = {{-84, -13}, {-78, -19}}, 
    lineColor = {0, 0, 127}, 
    fillColor = {0, 0, 127}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{-70, 3}, {-64, -3}}, 
    lineColor = {0, 0, 127}, 
    fillColor = {0, 0, 127}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{-62, -47}, {-56, -53}}, 
    lineColor = {0, 0, 127}, 
    fillColor = {0, 0, 127}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{-54, -23}, {-48, -29}}, 
    lineColor = {0, 0, 127}, 
    fillColor = {0, 0, 127}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{-46, 59}, {-40, 53}}, 
    lineColor = {0, 0, 127}, 
    fillColor = {0, 0, 127}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{-38, -33}, {-32, -39}}, 
    lineColor = {0, 0, 127}, 
    fillColor = {0, 0, 127}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{-28, -15}, {-22, -21}}, 
    lineColor = {0, 0, 127}, 
    fillColor = {0, 0, 127}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{-18, -41}, {-12, -47}}, 
    lineColor = {0, 0, 127}, 
    fillColor = {0, 0, 127}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{-8, 39}, {-2, 33}}, 
    lineColor = {0, 0, 127}, 
    fillColor = {0, 0, 127}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{-2, 53}, {4, 47}}, 
    lineColor = {0, 0, 127}, 
    fillColor = {0, 0, 127}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{4, -1}, {10, -7}}, 
    lineColor = {0, 0, 127}, 
    fillColor = {0, 0, 127}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{14, 9}, {20, 3}}, 
    lineColor = {0, 0, 127}, 
    fillColor = {0, 0, 127}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{20, -19}, {26, -25}}, 
    lineColor = {0, 0, 127}, 
    fillColor = {0, 0, 127}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{30, 53}, {36, 47}}, 
    lineColor = {0, 0, 127}, 
    fillColor = {0, 0, 127}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{40, 19}, {46, 13}}, 
    lineColor = {0, 0, 127}, 
    fillColor = {0, 0, 127}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{48, -47}, {54, -53}}, 
    lineColor = {0, 0, 127}, 
    fillColor = {0, 0, 127}, 
    fillPattern = FillPattern.Solid), 
    Text(
    extent = {{-80, -62}, {98, -84}}, 
    textColor = {175, 175, 175}, 
    textString = "%noiseMin")}));
end UniformNoise;