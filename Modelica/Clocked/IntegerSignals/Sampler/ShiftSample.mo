within Modelica.Clocked.IntegerSignals.Sampler;
block ShiftSample 
  "将时钟驱动的整数输入信号按最后一个间隔的某个分数进行偏移，并将其作为时钟驱动的输出信号提供。"
  parameter Integer shiftCounter(min=0)=0 "移位公式的分子" 
    annotation(Evaluate=true, Dialog(group="将第一次时钟激活向时间轴上移动，偏移量为 'shiftCounter/resolution*interval(u)' 秒"));
  parameter Integer resolution(min=1)=1 "移位公式的分母" 
    annotation(Evaluate=true, Dialog(group="将第一次时钟激活向时间轴上移动，偏移量为 'shiftCounter/resolution*interval(u)' 秒"));
  Modelica.Blocks.Interfaces.IntegerInput u 
    "时钟、整数输入信号连接器" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.IntegerOutput y 
    "时钟、整数输出信号连接器" 
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
                                 color={255,128,0}, 
          pattern=LinePattern.Dot), 
        Text(
          extent={{-150,150},{150,110}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-150,-100},{150,-140}}, 
          textString="%shiftCounter/%resolution"), 
        Line(points={{-80,-50},{-40,-50},{-40,50}}, 
                                 color={255,128,0}, 
          pattern=LinePattern.Dot), 
        Ellipse(
          extent={{10,-40},{30,-60}}, 
          lineColor={255,128,0}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{50,60},{70,40}}, 
          lineColor={255,128,0}, 
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
          lineColor={255,128,0}, 
          fillColor={255,128,0}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-50,60},{-30,40}}, 
          lineColor={255,128,0}, 
          fillColor={255,128,0}, 
          fillPattern=FillPattern.Solid)}), 
    Documentation(info="<html>
<p>
该整数信号模块的工作原理与相应的实数信号模块类似（参见 <a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.ShiftSample\">RealSignals.Sampler.ShiftSample</a>）。
</p>
<p>
与相应的实数信号模块示例类似，该整数信号模块也有一个基本<a href=\"modelica://Modelica.Clocked.Examples.Elementary.IntegerSignals.ShiftSample\">example</a>。
</p>
</html>"));
end ShiftSample;