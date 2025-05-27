within Modelica.Clocked.RealSignals.Sampler;
block SampleClocked 
  "对连续实时输入信号进行采样，并将其作为时钟输出信号，时钟作为输入信号"
  extends Clocked.RealSignals.Interfaces.SamplerIcon;
  Modelica.Blocks.Interfaces.RealInput u 
    "连续时间、实数输入信号连接器" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y 
    "时钟实数输出信号连接器" 
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Clocked.ClockSignals.Interfaces.ClockInput clock 
    "输出信号 y 与该时钟输入相关联" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}}, 
        rotation=90, 
        origin={0,-120})));

equation
  y = sample(u,clock);

  annotation (
   defaultComponentName="sample1", 
   Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}, 
        initialScale=0.06), 
                     graphics={
        Line(
          points={{0,-100},{0,18}}, 
          color={175,175,175}, 
          pattern=LinePattern.Dot, 
          thickness=0.5), 
    Text(
        extent={{-150,90},{150,50}}, 
        textString="%name", 
        textColor={0,0,255})}), 
    Documentation(info="<html><p>
这个模块类似于<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Sample\" target=\"\">Sample</a>&nbsp; 模块。 唯一的区别在于通过第二个输入提供了一个时钟信号，并且输出与这个时钟相关联。
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">请注意，向量化此块没有太大意义，因为这样时钟输入也会被向量化。相反，如果输入信号是一个向量，请使用块 </span><a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.SampleVectorizedAndClocked\" target=\"\">SampleVectorizedAndClocked</a>&nbsp;<span style=\"color: rgb(51, 51, 51);\">，该块具有一个</span><span style=\"color: rgb(51, 51, 51);\"><strong>向量</strong></span><span style=\"color: rgb(51, 51, 51);\">实数输入和输出，以及一个</span><span style=\"color: rgb(51, 51, 51);\"><strong>标量</strong></span><span style=\"color: rgb(51, 51, 51);\">时钟输入。</span>
</p>
<h4>Example</h4><p>
以下<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.SampleClocked\" target=\"\">example</a>&nbsp; 使用周期为20毫秒的周期时钟对正弦信号进行采样：
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"50\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/SampleClocked_Model.png\" alt=\"SampleClocked_Model.png\" data-href=\"\" style=\"\"/></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/SampleClocked_Result.png\" alt=\"SampleClocked_Result.png\" data-href=\"\" style=\"\"/></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">model</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">simulation result<br></td></tr></tbody></table><p>
<br>
</p>
</html>"));
end SampleClocked;