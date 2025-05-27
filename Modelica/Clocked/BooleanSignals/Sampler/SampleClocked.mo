within Modelica.Clocked.BooleanSignals.Sampler;
block SampleClocked 
  "对连续时间的布尔输入信号进行采样，并将其作为时钟驱动的输出信号提供。时钟作为输入信号提供。"
  extends Clocked.BooleanSignals.Interfaces.SamplerIcon;
  Clocked.ClockSignals.Interfaces.ClockInput clock 
    "输出信号 y 与该时钟输入相关联" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}}, 
        rotation=90, 
        origin={0,-120})));
  Modelica.Blocks.Interfaces.BooleanInput 
                                       u 
    "连续时间、布尔输入信号连接器" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput 
                                        y 
    "时钟、布尔输出信号的连接器" 
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
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
          textString="%name")}), 
    Documentation(info="<html>
<p>
这个布尔信号模块的工作原理与实数信号模块类似（参见 <a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.SampleClocked\">RealSignals.Sampler.SampleClocked</a>）。
</p>
<p>
类比于相应的实数信号模块示例，这里存在一个关于布尔信号模块的基础<a href=\"modelica://Modelica.Clocked.Examples.Elementary.BooleanSignals.SampleClocked\">example</a>。
</p>
</html>"));
end SampleClocked;