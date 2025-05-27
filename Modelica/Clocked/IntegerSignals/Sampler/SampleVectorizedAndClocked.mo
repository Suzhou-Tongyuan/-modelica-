within Modelica.Clocked.IntegerSignals.Sampler;
block SampleVectorizedAndClocked 
  "对连续时间的整数输入信号向量进行采样，并将其作为时钟驱动的输出信号向量提供。时钟作为输入信号提供。"
  extends Clocked.IntegerSignals.Interfaces.SamplerIcon;
  parameter Integer n(min=1)=1 
    "输入信号向量 u 的大小（= 输出信号向量 y 的大小）";
  Modelica.Blocks.Interfaces.IntegerInput u[n] 
    "连续时间、整数输入信号矢量连接器" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}), iconTransformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.IntegerOutput y[n] 
    "时钟、整数输出信号矢量连接器" 
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Clocked.ClockSignals.Interfaces.ClockInput clock 
    "输出信号向量 y 与该时钟输入相关联" 
    annotation (Placement(transformation(
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
          textColor={0,0,255}, 
          textString="%name"), 
        Text(
          extent={{-150,-40},{20,-90}}, 
          textColor={0,0,0}, 
          textString="n=%n")}), 
    Documentation(info="<html>
<p>
该整数信号模块的工作原理与相应的实数信号模块类似
（参见 <a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.SampleVectorizedAndClocked\">RealSignals.Sampler.SampleVectorizedAndClocked</a>）。
</p>
<p>
与相应的实数信号模块示例类似，该整数信号模块也有一个基本 <a href=\"modelica://Modelica.Clocked.Examples.Elementary.IntegerSignals.SampleVectorizedAndClocked\">example</a>。
</p>
</html>"));
end SampleVectorizedAndClocked;