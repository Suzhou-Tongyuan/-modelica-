within Modelica.Clocked.RealSignals.Sampler.Utilities;
block UpSample 
  "将时钟化的实数输入信号进行升采样，并将其作为时钟化的输出信号提供"

  parameter Boolean inferFactor = true 
    "= true, 如果上采样因子由推断得出" annotation(Evaluate = true, choices(checkBox = true));
  parameter Integer factor(min = 1) = 1 
    "上采样因子>= 1(如果inferFactor=false)" annotation(Evaluate = true, Dialog(enable = not inferFactor));
  Modelica.Blocks.Interfaces.RealInput u 
    "时钟化实数输入信号的连接器" 
    annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
  Modelica.Blocks.Interfaces.RealOutput y 
    "时钟化实数输出信号的连接器（y的时钟比u的时钟快）" 
    annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));
protected
  Real dummy annotation(HideResult = true);
  Boolean b(start = false);
  Boolean b_super(start = false);
  Real u_super;
equation
  when Clock() then  // clock of u
    dummy = u;
    b = not previous(b);
  end when;

  when Clock() then  // clock of y
    b_super = superSample(b);
    if inferFactor then
      u_super = superSample(u);
    else
      u_super = superSample(u, factor);
    end if;
    y = if b_super <> previous(b_super) then u_super else 0.0;
  end when;

  annotation(
    defaultComponentName = "upSample1", 
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}, 
    initialScale = 0.06), 
    graphics = {
    Line(
    points = {{-78, -60}, {40, -60}, {40, 0}, {40, 0}}, 
    color = {215, 215, 215}, 
    pattern = LinePattern.Dot), Line(points = {{-80, -60}, {-40, -60}, {-40, -60}, {-40, 0}, 
    {-40, 0}, {0, 0}, {40, 0}, {40, 80}, {40, 80}, {40, 80}, {80, 80}, {80, 0}, {80, 0}, 
    {100, 0}}, color = {0, 0, 127}, 
    pattern = LinePattern.Dot), Line(
    points = {{-80, -60}, {-80, 0}, {-100, 0}}, 
    color = {0, 0, 127}, 
    pattern = LinePattern.Dot), 
    Ellipse(
    extent = {{-95, -45}, {-65, -75}}, 
    lineColor = {0, 0, 127}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{-83, -57}, {-77, -63}}, 
    lineColor = {0, 0, 127}, 
    fillColor = {0, 0, 127}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{25, 96}, {55, 66}}, 
    lineColor = {0, 0, 127}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{37, 83}, {43, 77}}, 
    lineColor = {0, 0, 127}, 
    fillColor = {0, 0, 127}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{-55, 16}, {-25, -14}}, 
    lineColor = {0, 0, 127}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{-6, 16}, {24, -14}}, 
    lineColor = {0, 0, 127}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{64, 16}, {94, -14}}, 
    lineColor = {0, 0, 127}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), 
    Text(
    visible = not inferFactor, 
    extent = {{-150, -100}, {150, -140}}, 
    textString = "%factor", 
    textColor = {0, 0, 0}), 
    Line(
    points = {{80, 80}, {120, 80}}, 
    color = {215, 215, 215}, 
    pattern = LinePattern.Dot), 
    Polygon(
    points = {{25, 0}, {5, 20}, {5, 10}, {-25, 10}, {-25, -10}, {5, -10}, {5, -20}, 
    {25, 0}}, 
    fillColor = {95, 95, 95}, 
    fillPattern = FillPattern.Solid, 
    lineColor = {95, 95, 95}, 
    origin = {-71, 52}, 
    rotation = 90), 
    Text(
    extent = {{-150, 150}, {150, 110}}, 
    textString = "%name", 
    textColor = {0, 0, 255})}), 
    Documentation(info="<html><p style=\"text-align: start;\">该模块将时钟化的实数输入信号 u 进行升采样，并将其作为时钟化的输出信号 y 提供。
</p>
<p style=\"text-align: start;\">更具体地说：y 的时钟频率是 u 时钟频率的 factor 倍。在 u 时钟的每次跳变时，y 的值被设置为 u 的值，而在 y 时钟的中间跳变时，y 的值被设置为零。y 时钟的第一次激活与 u 时钟的第一次激活同时发生。默认情况下，升采样因子是自动推导的，也就是说，它必须在其他地方定义。如果参数 <strong>inferFactor</strong> = false，则升采样因子由整数参数 <strong>factor</strong> 定义。
</p>
<p style=\"text-align: start;\">对于信号插值，升采样后应使用适当的滤波器（抗影像滤波）。
</p>
<h4>示例</h4><p>
以下是一个 <a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.UpSample1\" target=\"\">示例</a>&nbsp; 该示例采样一个周期为20毫秒的正弦信号， 然后以3倍的因子对生成的时钟信号进行上采样：<br>
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"50\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/UpSample1_Model.png\" alt=\"UpSample1_Model.png\" data-href=\"\" style=\"\"/></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/UpSample1_Result.png\" alt=\"UpSample1_Result.png\" data-href=\"\" style=\"\"/></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">模型</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">仿真结果</td></tr></tbody></table><p style=\"text-align: start;\">升采样因子在 upSample2 模块中被显式地给出，这也使得因子在图标中可见。对于 upSample1 模块，升采样因子是自动推导的。可以看到，upSample1 模块为输出 y 引入了 3 个额外的时钟跳变。请注意，upSample 模块图标中的上箭头表示其输出时钟的频率比输入时钟的频率要高。
</p>
<p style=\"text-align: start;\">以下<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.UpSample2\" target=\"\">示例</a>&nbsp; 对一个周期为 20 毫秒的正弦信号进行采样，使用因子为 3 的升采样对结果的时钟信号进行升采样，并对该信号应用不同的滤波器：
</p>
<p>
<br>
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"50\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/UpSample2_Model.png\" alt=\"UpSample2_Model.png\" data-href=\"\" style=\"\"/></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">模型<br></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/UpSample2_Result1.png\" alt=\"UpSample2_Result1.png\" data-href=\"\" style=\"\"/></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">仿真结果 1<br></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/UpSample2_Result2.png\" alt=\"UpSample2_Result2.png\" data-href=\"\" style=\"\"/></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">仿真结果 2</td></tr></tbody></table><p>
<span style=\"color: rgb(51, 51, 51);\">该模型展示了对升采样信号进行处理的多种方式：当使用 FIR 块 FIR1 和 FIR 系数 {1,1,1} 对升采样信号进行滤波时，结果与超采样信号相同（参见图 \"simulation result 1\" 中的信号 FIR1.y）。另一方面，当使用 FIR 块 FIR2 和 FIR 系数 {1/3, 2/3, 1, 2/3, 1/3} 对升采样信号进行滤波时，结果是一个线性插值的超采样信号（参见图 \"simulation result 2\" 中的信号 FIR2.y）。相同的结果也可以通过块 </span><a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.SuperSampleInterpolated\" target=\"\">SuperSampleInterpolated</a>&nbsp; <span style=\"color: rgb(51, 51, 51);\">来实现（参见图 \"simulation result 2\" 中的信号 superSampleIpo1.y）。唯一的区别是第一个时钟跳变，因为 FIR2 信号的初始化方式略有不同。</span>
</p>
<p>
<br>
</p>
</html>"));
end UpSample;