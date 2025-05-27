within Modelica.Clocked.RealSignals.Sampler;
block ShiftSample 
  "将时钟实数输入信号移位上一间隔的一部分，并将其作为时钟输出信号"

  parameter Integer shiftCounter(min=0)=0 "移位公式的分子" 
        annotation(Evaluate=true, Dialog(group="将第一个时钟激活时间移至'移位计数器/分辨率*interval(u)'秒的位置"));
  parameter Integer resolution(min=1)=1 "移位公式的分母" 
        annotation(Evaluate=true, Dialog(group="将第一个时钟激活时间移至'移位计数器/分辨率*interval(u)'秒的位置"));

  Modelica.Blocks.Interfaces.RealInput u 
    "时钟实数输入信号连接器" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y 
    "时钟实数输出信号连接器" 
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
                                 color={0,0,127}, 
          pattern=LinePattern.Dot), 
                               Line(points={{-80,-50},{-40,-50},{-40,50}}, 
                                 color={0,0,127}, 
          pattern=LinePattern.Dot), 
        Ellipse(
          extent={{10,-40},{30,-60}}, 
          lineColor={0,0,127}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{50,60},{70,40}}, 
          lineColor={0,0,127}, 
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
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-50,60},{-30,40}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-150,-100},{150,-140}}, 
          textString="%shiftCounter/%resolution"), 
        Text(
          extent={{-150,150},{150,110}}, 
          textString="%name", 
          textColor={0,0,255})}), 
    Documentation(info="<html><p>
<span style=\"color: rgb(51, 51, 51);\">该模块将输出 y 的时钟第一次激活按周期的分数 shiftCounter/resolution 进行偏移（对于非周期信号，则按上一个间隔的分数进行偏移），并将输出 y 设置为输入 u 的最后一个可用值。在这里，</span><span style=\"color: rgb(51, 51, 51);\"><strong>shiftCounter </strong></span><span style=\"color: rgb(51, 51, 51);\">和 </span><span style=\"color: rgb(51, 51, 51);\"><strong>resolution </strong></span><span style=\"color: rgb(51, 51, 51);\">是正整数参数。</span>
</p>
<p>
更准确地说： 该模块（从概念上）构建了一个时钟 “cBase&rdquo
</p>
<p>
<br>
</p>
<pre><code >Clock cBase = subSample(superSample(u, resolution), shiftCounter)
</code></pre><p>
<br>
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">并且 y 的时钟从 cBase 的第二个时钟跳变开始。每当 y 时钟跳变时，操作符返回来自 u 时钟上一个跳变的 u 值。</span>
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">请注意，对于 </span><a href=\"modelica://Modelica.Clocked.ClockSignals.Clocks.EventClock\" target=\"\">EventClock</a>&nbsp;<span style=\"color: rgb(51, 51, 51);\">，有一个限制，即 </span><span style=\"color: rgb(51, 51, 51);\"><strong>ShiftSample </strong></span><span style=\"color: rgb(51, 51, 51);\">块只能偏移 EventClock 时钟的跳变次数，但不能引入新的跳变，这是由于 </span><span style=\"color: rgb(51, 51, 51);\"><strong>superSample </strong></span><span style=\"color: rgb(51, 51, 51);\">操作符在 EventClocks 上的限制。</span>
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">还需注意，这个块并不是简单地将信号在时间上偏移，因为输出仅使用来自 u 时钟上一个跳变的 u 值。如果需要时间延迟的时钟，请改用 </span><a href=\"modelica://Modelica.Clocked.RealSignals.NonPeriodic.FractionalDelay\" target=\"\">NonPeriodic.FractionalDelay</a>&nbsp;<span style=\"color: rgb(51, 51, 51);\"> 块，在该块中输入信号会被延迟一个时间周期，并且 u 的旧值会存储在缓冲区中。如果时间延迟少于一个周期，则 ShiftSample 和 FractionalDelay 两个块会给出相同的结果。</span>
</p>
<h4>Example</h4><p>
以下是一个<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.ShiftSample\" target=\"\">example</a>&nbsp; ， 它使用周期为20毫秒的时钟对正弦信号进行采样，然后使用 shiftCounter = 4 和 resolution = 3 进行时移： <br>
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"50\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/ShiftSample_Model.png\" alt=\"ShiftSample_Model.png\" data-href=\"\" style=\"\"/></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/ShiftSample_Result.png\" alt=\"ShiftSample_Result.png\" data-href=\"\" style=\"\"/></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">model</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">simulation result</td></tr></tbody></table><p>
模块shiftSample1的输出信号y的第一个激活被时间移动了（4/3 * 20毫秒）。 参数值 <strong>shiftCounter</strong> = 4 和 <strong>resolution</strong> = 3 可以在图标底部看到。 还请注意，该信号并不仅仅是时间上的移动。 ShiftSample模块的输出始终是其输入时钟的 <em>last</em> 时钟脉冲时刻的值。
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"));
end ShiftSample;