within Modelica.Clocked.IntegerSignals.Sampler;
block Sample 
  "采样连续时间整数输入信号，并将其作为时钟输出信号(推断时钟)"
  extends Clocked.IntegerSignals.Interfaces.PartialSISOSampler;

equation
  y = sample(u);

  annotation(
    defaultComponentName = "sample1", 
    Icon(coordinateSystem(
    preserveAspectRatio = false, 
    extent = {{-100, -100}, {100, 100}}, 
    initialScale = 0.06), 
    graphics = {
    Text(
    extent = {{-150, 90}, {150, 50}}, 
    textColor = {0, 0, 255}, 
    textString = "%name")}), 
    Documentation(info = "<html>
<p>
该整数信号模块的工作原理与相应的实数信号模块类似
(参见 <a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Sample\">RealSignals.Sampler.Sample</a>)。
</p>
<p>
与相应的实数信号模块示例类似，整数信号模块也有两个基本示例，
即<a href=\"modelica://Modelica.Clocked.Examples.Elementary.IntegerSignals.Sample1\">Sample1</a>和
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.IntegerSignals.Sample2\">Sample2</a>。
</p>
</html>"));
end Sample;