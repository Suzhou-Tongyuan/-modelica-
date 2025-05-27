within Modelica.Clocked.RealSignals.Sampler;
block Sample 
  "采样连续时间实数输入信号，并将其作为时钟输出信号（推断时钟）"
  extends Clocked.RealSignals.Interfaces.PartialSISOSampler;

equation
  y = sample(u);

  annotation(
    defaultComponentName = "sample1", 
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}, 
    initialScale = 0.06), 
    graphics = {
    Text(extent = {{-150, 90}, {150, 50}}, 
    textString = "%name", 
    textColor = {0, 0, 255})}), 
    Documentation(info="<html><p style=\"text-align: start;\">该块采样连续时间的实数输入信号 u，并将其作为时钟化输出信号 y。输出信号的时钟是由推断得出的（即，它需要在时钟化分区的其他地方定义）。如果不希望如此，请改用 <a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.SampleClocked\" target=\"\">SampleClocked</a>&nbsp; 模块，显式地将时钟分配给输出信号。
</p>
<p style=\"text-align: start;\">更准确地说：输入信号 u(t) 必须是一个连续时间信号。输出信号 y(ti) 与一个时钟相关联（该时钟在其他地方定义）。在时钟跳变时，u 的左极限被赋值给 y：<code>y(ti) = u(ti-eps)</code>（即时钟变为活动状态之前 u 的值）。由于该运算符返回 u 的左极限，它在连续时间和时钟化分区之间引入了一个极其微小的延迟。这与现实相符，在采样数据系统中不能无限快速地操作，即使是非常理想化的仿真，也存在一个极小的延迟。因此，时钟化和连续时间分区之间不能发生代数回路。
</p>
<h4>例如</h4><p>
以下的<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.Sample1\" target=\"\">example</a>&nbsp; 用一个周期为20毫秒的周期时钟对正弦信号进行采样： <br>
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"50\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/Sample1_Model.png\" alt=\"Sample1_Model.png\" data-href=\"\" style=\"\"/></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/Sample1_Result.png\" alt=\"Sample1_Result.png\" data-href=\"\" style=\"\"/></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">model</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">simulation result</td></tr></tbody></table><p>
<br> 在以下<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.Sample2\" target=\"\">example</a>&nbsp;中， 连续时间输入信号在0.1秒的时钟触发时包含一个不连续的值变化。 可以看到，Sample模块对阶跃信号进行左极限的采样： <br>
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"50\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/Sample2_Model.png\" alt=\"Sample2_Model.png\" data-href=\"\" style=\"\"/></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/Sample2_Result.png\" alt=\"Sample2_Result.png\" data-href=\"\" style=\"\"/></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">model</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">simulation result</td></tr></tbody></table><p>
<br> 在以下<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.Sample3\" target=\"\">example</a>&nbsp;中， 连续时间部分和时钟分区都存在直接传递。 如果没有时间延迟，这将导致代数环路。 然而，由于Sample模块采样连续时间信号的左极限， 采样引入了一个样本周期的延迟，从而打破了代数环路： <br>
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"50\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/Sample3_Model.png\" alt=\"Sample3_Model.png\" data-href=\"\" style=\"\"/></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">model<br></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/Sample3_Result.png\" alt=\"Sample3_Result.png\" data-href=\"\" style=\"\"/></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">simulation result</td></tr></tbody></table><p>
注意，延迟的原因是 sample2.y（=绿色，时钟信号）是hold.y（=红色，连续时间信号）的左极限。
</p>
<p>
<br>
</p>
</html>"));
end Sample;