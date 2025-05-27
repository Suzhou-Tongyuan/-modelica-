within Modelica.Clocked.BooleanSignals.TimeBasedSources;
block Pulse "生成布尔类型的脉冲信号"
  extends BooleanSignals.Interfaces.PartialClockedSO;
  parameter Real width(
    final min=Modelica.Constants.small, 
    final max=100) = 50 "脉冲宽度占周期的百分比";
  parameter SI.Time period(final min=Modelica.Constants.small,start=1) 
  "一个时段的时间";
  parameter SI.Time startTime=0 
  "第一个脉冲的时间瞬间";

protected
  SI.Time simTime;
  parameter SI.Duration Twidth=period*width/100 
  "一个脉冲的宽度" annotation(HideResult=true);

  SI.Time next(start=startTime, fixed=true) 
  "next = startTime + n*period, 对于最小的 n，使得 next>simTime";
  SI.Duration tol = 0.1*interval(simTime) "数值比较的容差";
equation
    simTime = sample(time);
    next = if (simTime >= previous(next) - tol) then previous(next) + period else previous(next);
    y = simTime >= next - period - tol and simTime < next - period + Twidth - tol;
  annotation (
    Icon(coordinateSystem(
      preserveAspectRatio=true, 
      extent={{-100,-100},{100,100}}), 
      graphics={Text(
        extent={{-150,-150},{150,-110}}, 
        textString="%period"), 
        Polygon(
          points={{-80,88},{-88,66},{-72,66},{-80,88}}, 
          lineColor={255,0,255}, 
          fillColor={255,0,255}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-80,66},{-80,-82}}, color={255,0,255}), 
        Line(points={{-90,-70},{72,-70}}, color={255,0,255}), 
        Polygon(
          points={{90,-70},{68,-62},{68,-78},{90,-70}}, 
          lineColor={255,0,255}, 
          fillColor={255,0,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{71,7},{85,-7}}, 
          lineColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}), 
          fillColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}), 
          fillPattern=FillPattern.Solid), 
        Line(points={{-80,-70},{-40,-70},{-40,44},{0,44}, 
              {0,-70},{40,-70},{40,44},{79,44}}, pattern=LinePattern.Dot), 
        Ellipse(
          extent={{-86,-64},{-74,-76}}, 
          lineColor={255,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-45,50},{-33,38}}, 
          lineColor={255,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-6,-64},{6,-76}}, 
          lineColor={255,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{34,49},{46,37}}, 
          lineColor={255,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid)}), 
    Diagram(coordinateSystem(
      preserveAspectRatio=true, 
      extent={{-100,-100},{100,100}}), 
      graphics={
      Text(
        extent={{-60,-74},{-19,-82}}, 
        textString="startTime"), 
      Line(
        points={{-78,-70},{-40,-70},{-40,20},{20,20},{20,-70},{50,-70},{
            50,20},{100,20}}, 
        color={255,0,255}, 
        thickness=0.5, 
        pattern=LinePattern.Dot), 
      Line(points={{-40,61},{-40,21}}, color={95,95,95}), 
      Line(points={{20,44},{20,20}}, color={95,95,95}), 
      Line(points={{50,58},{50,20}}, color={95,95,95}), 
      Line(points={{-40,53},{50,53}}, color={95,95,95}), 
      Line(points={{-40,35},{20,35}}, color={95,95,95}), 
      Text(
        extent={{-18,65},{28,55}}, 
        textString="period"), 
      Text(
        extent={{-33,47},{14,37}}, 
        textString="width"), 
      Line(points={{-70,20},{-41,20}}, color={95,95,95}), 
      Polygon(
        points={{-40,35},{-31,37},{-31,33},{-40,35}}, 
        lineColor={95,95,95}, 
        fillColor={95,95,95}, 
        fillPattern=FillPattern.Solid), 
      Polygon(
        points={{20,35},{12,37},{12,33},{20,35}}, 
        lineColor={95,95,95}, 
        fillColor={95,95,95}, 
        fillPattern=FillPattern.Solid), 
      Polygon(
        points={{-40,53},{-31,55},{-31,51},{-40,53}}, 
        lineColor={95,95,95}, 
        fillColor={95,95,95}, 
        fillPattern=FillPattern.Solid), 
      Polygon(
        points={{50,53},{42,55},{42,51},{50,53}}, 
        lineColor={95,95,95}, 
        fillColor={95,95,95}, 
        fillPattern=FillPattern.Solid), 
      Text(
        extent={{-95,26},{-66,17}}, 
        textString="true"), 
      Text(
        extent={{-96,-60},{-75,-69}}, 
        textString="false"), 
        Ellipse(
          extent={{-46,26},{-34,14}}, 
          lineColor={255,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-16,26},{-4,14}}, 
          lineColor={255,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{14,-63},{26,-75}}, 
          lineColor={255,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{44,25},{56,13}}, 
          lineColor={255,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{74,26},{86,14}}, 
          lineColor={255,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-76,-64},{-64,-76}}, 
          lineColor={255,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid)}), 
    Documentation(info="<html><p>
这个模块类似于 <a href=\"modelica://Modelica.Blocks.Sources.BooleanPulse\" target=\"\">Modelica.Blocks.Sources.BooleanPulse</a>&nbsp; 中的模块， <span style=\"color: rgb(51, 51, 51);\">但经过调整以在时钟分区中工作（通过对连续</span><span style=\"color: rgb(51, 51, 51);\"><strong>时间</strong></span><span style=\"color: rgb(51, 51, 51);\">变量的内部采样）</span>。
</p>
<p>
布尔输出 y 是一个脉冲信号：
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Pulse.png\" alt=\"Pulse.png\" data-href=\"\" style=\"\"/>
</p>
<h4>Example</h4><p>
见模型 <a href=\"modelica://Modelica.Clocked.Examples.Elementary.BooleanSignals.TimeBasedPulse\" target=\"\">Modelica.Clocked.Examples.Elementary.BooleanSignals.TimeBasedPulse</a>&nbsp;. <br>
</p>
</html>"));
end Pulse;