within Modelica.Clocked.BooleanSignals.Sampler;
block ShiftSample 
  "将时钟驱动的布尔输入信号按最后一个间隔的一个小分数进行移位，并将其作为时钟驱动的输出信号提供。"
  parameter Integer shiftCounter(min=0)=0 "移位公式的分子" 
        annotation(Evaluate=true, Dialog(group="将第一个时钟激活时间移至'移位计数器/分辨率*interval(u)'秒数的位置"));
  parameter Integer resolution(min=1)=1 "移位公式的分母" 
        annotation(Evaluate=true, Dialog(group="将第一个时钟激活时间移至'移位计数器/分辨率*interval(u)'秒数的位置"));

  Modelica.Blocks.Interfaces.BooleanInput u 
    "时钟、布尔输入信号连接器" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput y 
    "时钟、布尔输出信号的连接器（y 的时钟比 u 的时钟快）" 
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  y = shiftSample(u,shiftCounter,resolution);

  annotation (
   defaultComponentName="shiftSample1", 
   Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}, 
        initialScale=0.06), 
                     graphics={Line(points={{20,-50},{60,-50},{60,50}}, 
                                 color={255,0,255}, 
          pattern=LinePattern.Dot), 
        Text(
          extent={{-150,150},{150,110}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-150,-100},{150,-140}}, 
          textString="%shiftCounter/%resolution"), 
        Line(points={{-80,-50},{-40,-50},{-40,50}}, 
                                 color={255,0,255}, 
          pattern=LinePattern.Dot), 
        Ellipse(
          extent={{10,-40},{30,-60}}, 
          lineColor={255,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{50,60},{70,40}}, 
          lineColor={255,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Polygon(
          points={{34,0},{14,20},{14,10},{-16,10},{-16,-10},{14,-10},{14,-20},{34, 
              0}}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid, 
          lineColor={95,95,95}), 
        Ellipse(
          extent={{-90,-40},{-70,-60}}, 
          lineColor={255,0,255}, 
          fillColor={255,0,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-50,60},{-30,40}}, 
          lineColor={255,0,255}, 
          fillColor={255,0,255}, 
          fillPattern=FillPattern.Solid)}), 
    Documentation(info="<html>
<p>
这个布尔信号模块的工作原理与实数信号模块类似（参见 <a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.ShiftSample\">RealSignals.Sampler.ShiftSample</a>）。
</p>
<p>
类比于相应的实数信号模块示例，这里存在一个关于布尔信号模块的基础<a href=\"modelica://Modelica.Clocked.Examples.Elementary.BooleanSignals.ShiftSample\">example</a>。
</p>
</html>"));
end ShiftSample;