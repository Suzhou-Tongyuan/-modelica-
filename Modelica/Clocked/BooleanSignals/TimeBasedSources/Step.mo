within Modelica.Clocked.BooleanSignals.TimeBasedSources;
block Step "生成布尔类型的阶跃信号"
  extends BooleanSignals.Interfaces.PartialClockedSO;
  parameter SI.Time startTime=0 "阶梯开始的时间瞬间";
  parameter Boolean startValue = false "开始时间之前的输出";
protected
  SI.Time simTime;
equation
  simTime = sample(time);
  y = if simTime >= startTime then not startValue else startValue;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
            -100},{100,100}}), graphics={
        Text(
          extent={{-150,-150},{150,-110}}, 
          textString="startTime=%startTime"), 
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
        Line(points={{-80,-70},{0,-70},{0,50},{80,50}}, pattern=LinePattern.Dot), 
        Ellipse(
          extent={{-86,-64},{-74,-76}}, 
          lineColor={255,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-6,56},{6,44}}, 
          lineColor={255,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{74,56},{86,44}}, 
          lineColor={255,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-46,-64},{-34,-76}}, 
          lineColor={255,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{34,56},{46,44}}, 
          lineColor={255,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid)}), 
                          Diagram(coordinateSystem(preserveAspectRatio=true, 
          extent={{-100,-100},{100,100}}), graphics={
        Polygon(
          points={{-80,92},{-86,70},{-74,70},{-80,92}}, 
          lineColor={95,95,95}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-80,70},{-80,-80}}, color={95,95,95}), 
        Line(points={{-92,-70},{68,-70}}, color={95,95,95}), 
        Polygon(
          points={{90,-70},{68,-64},{68,-76},{90,-70}}, 
          lineColor={95,95,95}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{54,-80},{106,-92}}, 
          textString="time"), 
        Text(
          extent={{-74,92},{-56,74}}, 
          textString="y"), 
      Line(
          points={{-80,-70},{0,-70},{0,50},{80,50}}, 
          color={255,0,255}, 
          thickness=0.5, 
          pattern=LinePattern.Dot), 
      Text(
        extent={{-15,-80},{20,-88}}, 
        textString="startTime"), 
      Polygon(
        points={{-8,50},{-90,50},{-8,50}}, 
        lineColor={95,95,95}, 
        fillColor={95,95,95}, 
        fillPattern=FillPattern.Solid), 
      Text(
        extent={{-76,62},{-32,48}}, 
        textString="not startValue"), 
      Text(
        extent={{-78,-52},{-46,-66}}, 
        textString="startValue"), 
        Ellipse(
          extent={{-86,-64},{-74,-76}}, 
          lineColor={255,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-6,56},{6,44}}, 
          lineColor={255,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-46,-64},{-34,-76}}, 
          lineColor={255,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{74,56},{86,44}}, 
          lineColor={255,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{34,56},{46,44}}, 
          lineColor={255,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid)}), 
    Documentation(info="<html><p>
这个模块类似于 <a href=\"modelica://Modelica.Blocks.Sources.BooleanStep\" target=\"\">Modelica.Blocks.Sources.BooleanStep</a>&nbsp; 中的模块， <span style=\"color: rgb(51, 51, 51);\">但经过调整以在时钟分区中工作（通过对连续</span><span style=\"color: rgb(51, 51, 51);\"><strong>时间</strong></span><span style=\"color: rgb(51, 51, 51);\">变量的内部采样）</span>。 
</p>
<p>
 布尔输出 y 是一个阶跃信号：
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/BooleanStep.png\" alt=\"BooleanStep.png\" data-href=\"\" style=\"\"/>
</p>
<h4>Example</h4><p>
见模型 <a href=\"modelica://Modelica.Clocked.Examples.Elementary.BooleanSignals.TimeBasedStep\" target=\"\">Modelica.Clocked.Examples.Elementary.BooleanSignals.TimeBasedStep</a>&nbsp;. <br>
</p>
</html>"));
end Step;