within Modelica.Clocked.RealSignals.Sampler;
block BackSample 
  "将实数输入信号的时钟向后移动（并访问新时钟下的最新输入值）"
  parameter Integer backCounter(min=0)=0 "移位公式的分子" 
        annotation(Evaluate=true, Dialog(group="将第一个时钟激活时间移至'移位计数器/分辨率*interval(u)'秒的位置"));
  parameter Integer resolution(min=1)=1 "移位公式的分母" 
        annotation(Evaluate=true, Dialog(group="将第一个时钟激活时间移至'移位计数器/分辨率*interval(u)'秒的位置"));
  parameter Real y_start=0 
    "输入 u 的第一个时钟周期之前的输出 y 值";

  Modelica.Blocks.Interfaces.RealInput u(start=y_start) 
    "时钟实数输入信号连接器" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y 
    "时钟实数输出信号连接器（y 的时钟比 u 的时钟快）" 
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  y = backSample(u,backCounter,resolution);

  annotation (
   defaultComponentName="backSample1", 
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
          extent={{-90,-40},{-70,-60}}, 
          lineColor={0,0,127}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-50,60},{-30,40}}, 
          lineColor={0,0,127}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Polygon(
          points={{-16,0},{4,20},{4,10},{34,10},{34,-10},{4,-10},{4,-20},{-16,0}}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid, 
          lineColor={95,95,95}), 
        Ellipse(
          extent={{10,-40},{30,-60}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{50,60},{70,40}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-150,-100},{150,-140}}, 
          textColor={0,0,0}, 
          textString="y_start=%y_start"), 
        Text(
          extent={{-150,-150},{150,-190}}, 
          textColor={0,0,0}, 
          textString="%backCounter/%resolution"), 
        Text(
          extent={{-150,150},{150,110}}, 
          textString="%name", 
          textColor={0,0,255})}), 
    Documentation(info="<html><p>
该模块将输出 y 的时钟第一次激活按周期的分数 backCounter/resolution 进行偏移（对于非周期信号，则按上一个间隔的分数进行偏移），并使其发生在 u 时钟第一次激活之前。输出 y 被设置为输入 u 的最后一个可用值。在这里，<strong>backCounter</strong> 和 <strong>resolution</strong> 是正整数参数。
</p>
<p>
更加精确地说：这个模块构建了（概念上的）一个时钟 “cBase”
</p>
<p>
<br>
</p>
<pre><code >Clock cBase = subSample(superSample(u, resolution), backCounter)
</code></pre><p>
<br>
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">并且 y 的第一次时钟跳变被偏移到 u 时钟的第一次跳变之前，使得这一持续时间与 cBase 时钟的第一次和第二次跳变之间的持续时间相同。在 u 时钟的第一次跳变之前，块输出参数 </span><strong>y_start</strong> <span style=\"color: rgb(51, 51, 51);\">的值。之后，块返回 u 的最后一个可用值。</span>
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">请注意，对于 </span><a href=\"modelica://Modelica.Clocked.ClockSignals.Clocks.EventClock\" target=\"\">EventClock</a>&nbsp; s<span style=\"color: rgb(51, 51, 51);\">，有一个限制，即 </span><span style=\"color: rgb(51, 51, 51);\"><strong>BackSample </strong></span><span style=\"color: rgb(51, 51, 51);\">模块只能偏移 EventClock 时钟的跳变次数，但不能引入新的跳变，这是由于 </span><span style=\"color: rgb(51, 51, 51);\"><strong>superSample </strong></span><span style=\"color: rgb(51, 51, 51);\">操作符在 EventClocks 上的限制。</span>
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">还需注意，这个模块并不是简单地将信号在时间上进行偏移，因为输出仅使用 u 时钟上最后一个跳变时的 u 值。特别是，紧跟在 </span><strong>ShiftSample</strong> <span style=\"color: rgb(51, 51, 51);\">块之后的 </span><strong>BackSample</strong> <span style=\"color: rgb(51, 51, 51);\">块不能用于恢复 ShiftSample 的输入信号（对于因果系统来说这是不可能的）。</span>
</p>
<h4>Example</h4><p>
以下<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.BackSample\" target=\"\">example</a>&nbsp; &nbsp;对一个正弦信号进行采样， 采用周期为20毫秒的时钟， 然后使用shiftCounter = 4和resolution = 3进行移位采样， 最后使用backCounter = 4和resolution = 3进行反向采样：<br>
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"50\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/BackSample_Model.png\" alt=\"BackSample_Model.png\" data-href=\"\" style=\"\"/></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/BackSample_Result.png\" alt=\"BackSample_Result.png\" data-href=\"\" style=\"\"/></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">model</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">simulation result</td></tr></tbody></table><p>
block backSample1 的输出 y 的第一次激活比 block shiftSample1 的输出 y 的第一次激活提前了(4/3*20ms)。 <span style=\"color: rgb(51, 51, 51);\">因此，输出 y 的激活时间与 shiftSample1 模块的输入信号重合</span>。<span style=\"color: rgb(51, 51, 51);\">然而，如前所述，模块 backSample1 的输出</span><span style=\"color: rgb(51, 51, 51);\"><strong>并未</strong></span><span style=\"color: rgb(51, 51, 51);\">恢复原始的采样正弦信号！在前两个时钟跳变时，输出保持参数 </span><span style=\"color: rgb(51, 51, 51);\"><strong>y_start </strong></span><span style=\"color: rgb(51, 51, 51);\">= 0.5 的值。之后，在模块 backSample1 的时钟跳变时，输出为 shiftSample1 模块输出的最后一个值。参数值 </span><span style=\"color: rgb(51, 51, 51);\"><strong>y_start </strong></span><span style=\"color: rgb(51, 51, 51);\">= 0.5、</span><span style=\"color: rgb(51, 51, 51);\"><strong>shiftCounter </strong></span><span style=\"color: rgb(51, 51, 51);\">= 4 和 </span><span style=\"color: rgb(51, 51, 51);\"><strong>resolution </strong></span><span style=\"color: rgb(51, 51, 51);\">= 3 显示在图标的底部。</span>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"));
end BackSample;