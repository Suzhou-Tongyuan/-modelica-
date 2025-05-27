within Modelica.Clocked.ClockSignals.Sampler;
block ShiftSample 
  "将输入时钟按最后一个间隔的一个分数进行偏移，并将其作为输出时钟提供"
  parameter Integer shiftCounter(min=0)=0 "移位公式的分子" 
        annotation(Dialog(group="将第一个时钟激活时间移至'移位计数器/分辨率*间隔(u)'秒"));
  parameter Integer resolution(min=1)=1 "移位公式的分母" 
        annotation(Dialog(group="将第一个时钟激活时间移至'移位计数器/分辨率*间隔(u)'秒"));

  Interfaces.ClockInput                u "时钟输入信号连接器" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Interfaces.ClockOutput                y 
    "时钟输出信号连接器" 
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  y = shiftSample(u,shiftCounter,resolution);

  annotation (
   defaultComponentName="shiftSample1", 
   Icon(coordinateSystem(
        preserveAspectRatio=false, 
        extent={{-100,-100},{100,100}}, 
        initialScale=0.06), 
                     graphics={Line(points={{20,-50},{60,-50},{60,50}}, 
                                 color={95,95,95}, 
          pattern=LinePattern.Dot), 
                               Line(points={{-80,-50},{-40,-50},{-40,50}}, 
                                 color={95,95,95}, 
          pattern=LinePattern.Dot), 
        Ellipse(
          extent={{10,-40},{30,-60}}, 
          lineColor={95,95,95}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{50,60},{70,40}}, 
          lineColor={95,95,95}, 
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
          lineColor={95,95,95}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-50,60},{-30,40}}, 
          lineColor={95,95,95}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-150,150},{150,110}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-150,-90},{150,-130}}, 
          textColor={0,0,0}, 
          textString="%shiftCounter/%resolution")}), 
    Documentation(info="<html><p>
<span style=\"color: rgb(51, 51, 51);\">该块将时钟输出 y 的第一次激活按照周期的分数 shiftCounter/resolution 进行偏移（对于非周期信号，则按最后一个间隔的分数进行偏移）。其中，</span><span style=\"color: rgb(51, 51, 51);\"><strong>shiftCounter </strong></span><span style=\"color: rgb(51, 51, 51);\">和 </span><span style=\"color: rgb(51, 51, 51);\"><strong>resolution </strong></span><span style=\"color: rgb(51, 51, 51);\">是正整数参数。</span>
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">更准确地说：该块（从概念上）构建了一个时钟“cBase”，</span>
</p>
<p>
<br>
</p>
<pre><code >Clock cBase = subSample(superSample(u, resolution), shiftCounter)
</code></pre><p>
<br>
</p>
<p>
和时钟 y 从 cBase 的第二个时钟刻度开始。
</p>
<h4>Example</h4><p>
下面的<a href=\"modelica://Modelica.Clocked.Examples.Elementary.ClockSignals.ShiftSample\" target=\"\">example</a>&nbsp; 生成了一个周期为 20 ms 的周期时钟， 然后使用 shiftCounter = 4 和 resolution = 3 对其进行移位： <br>
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"50\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/ClockSignals/ShiftSample_Model.png\" alt=\"ShiftSample_Model.png\" data-href=\"\" style=\"\"/></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/ClockSignals/ShiftSample_Result.png\" alt=\"ShiftSample_Result.png\" data-href=\"\" style=\"\"/></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">model</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">simulation result</td></tr></tbody></table><p>
shiftSample1 模块的时钟输出y的第一个激活在时间上被移位了（4/3 * 20ms）。 参数值 <strong>shiftCounter</strong> = 4 和 <strong>resolution</strong> = 3显示在图标底部。
</p>
<p>
<br>
</p>
</html>"));
end ShiftSample;