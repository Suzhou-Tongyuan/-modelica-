within Modelica.Clocked.BooleanSignals.Sampler;
block BackSample 
  "将布尔输入信号的时钟向后移动（并访问新时钟下的最新输入值）"
  parameter Integer backCounter(min=0)=0 "移位公式的分子" 
        annotation(Evaluate=true, Dialog(group="将第一个时钟激活时间移至'移位计数器/分辨率*interval(u)'秒数的位置"));
  parameter Integer resolution(min=1)=1 "移位公式的分母" 
        annotation(Evaluate=true, Dialog(group="将第一个时钟激活时间移至'移位计数器/分辨率*interval(u)'秒数的位置"));
  parameter Boolean y_start=false 
    "输入 u 的第一个时钟周期之前的输出 y 值";

  Modelica.Blocks.Interfaces.BooleanInput 
                                       u(start=y_start) 
    "时钟、布尔输入信号连接器" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput 
                                        y 
    "时钟、布尔输出信号的连接器（y 的时钟比 u 的时钟快）" 
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
                                 color={255,0,255}, 
          pattern=LinePattern.Dot), 
        Text(
          extent={{-150,150},{150,110}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-150,-150},{150,-190}}, 
          textColor={0,0,0}, 
          textString="%backCounter/%resolution"), 
        Line(points={{-80,-50},{-40,-50},{-40,50}}, 
                                 color={255,0,255}, 
          pattern=LinePattern.Dot), 
        Ellipse(
          extent={{-90,-40},{-70,-60}}, 
          lineColor={255,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-50,60},{-30,40}}, 
          lineColor={255,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Polygon(
          points={{-16,0},{4,20},{4,10},{34,10},{34,-10},{4,-10},{4,-20},{-16,0}}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid, 
          lineColor={95,95,95}), 
        Ellipse(
          extent={{10,-40},{30,-60}}, 
          lineColor={255,0,255}, 
          fillColor={255,0,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{50,60},{70,40}}, 
          lineColor={255,0,255}, 
          fillColor={255,0,255}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-150,-100},{150,-140}}, 
          textColor={0,0,0}, 
          textString="y_start=%y_start")}), 
    Documentation(info="<html>
<p>
这个布尔信号模块的工作原理与实数信号模块类似（参见 <a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.BackSample\">RealSignals.Sampler.BackSample</a>）。
</p>
<p>
类比于相应的实数信号模块示例，这里存在一个关于布尔信号模块的基础<a href=\"modelica://Modelica.Clocked.Examples.Elementary.BooleanSignals.BackSample\">example</a>。
</p>
</html>"));
end BackSample;