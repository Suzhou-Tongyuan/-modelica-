within Modelica.Clocked.RealSignals.Sampler;
block SuperSample 
  "对时钟实数输入信号进行超级采样，并将其作为时钟输出信号提供"
  parameter Boolean inferFactor=true 
    "= true，如果推断出超采样因子"  annotation(Evaluate=true, choices(checkBox=true));
  parameter Integer factor(min=1)=1 
    "超采样因子 >= 1（如果 inferFactor=true 则忽略）" 
                                                annotation(Evaluate=true, Dialog(enable=not inferFactor));

  Modelica.Blocks.Interfaces.RealInput u 
    "时钟实数输入信号连接器" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y 
    "时钟实数输出信号连接器（y 的时钟与 u 的时钟一样快）" 
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  if inferFactor then
     y = superSample(u);
  else
     y = superSample(u,factor);
  end if;

  annotation (
   defaultComponentName="superSample1", 
   Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}, 
        initialScale=0.06), 
                     graphics={Line(points={{-80,-60},{-40,-60},{-40,-60}, 
              {0,-60},{0,-60},{0,-60},{0,80},{40,80},{40,80},{80,80},{80, 
              0},{80,0},{80,0},{100,0}}, 
                                 color={0,0,127}, 
          pattern=LinePattern.Dot),                Line(
          points={{-80,-60},{-80,0},{-100,0}}, 
          color={0,0,127}, 
          pattern=LinePattern.Dot), 
        Ellipse(
          extent={{-95,-45},{-65,-75}}, 
          lineColor={0,0,127}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-83,-57},{-77,-63}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-15,96},{15,66}}, 
          lineColor={0,0,127}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-3,83},{3,77}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{65,16},{95,-14}}, 
          lineColor={0,0,127}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{77,3},{83,-3}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-48,-46},{-18,-76}}, 
          lineColor={0,0,127}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{34,96},{64,66}}, 
          lineColor={0,0,127}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Polygon(
          points={{25,0},{5,20},{5,10},{-25,10},{-25,-10},{5,-10},{5,-20}, 
              {25,0}}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid, 
          lineColor={95,95,95}, 
          origin={-49,26}, 
          rotation=90), 
        Text(
          visible=not inferFactor, 
          extent={{-150,-100},{150,-140}}, 
          textString="%factor"), 
        Text(
          extent={{-150,150},{150,110}}, 
          textString="%name", 
          textColor={0,0,255})}), 
    Documentation(info="<html><p>
这个模块对被时钟控制的实数输入信号 u 进行超采样，并将其作为被时钟控制的输出信号 y。
</p>
<p>
更准确地说：y 的时钟比 u 的时钟快了 factor 倍。 在 y 的每个时钟跳变时刻， y 的值被设定为 u 在上一个 u 时钟跳变时刻的值。 y 的时钟的第一次激活与 u 的时钟的第一次激活同时发生。 默认情况下，超采样因子是通过推断得出的，也就是说，必须在其他地方定义。 如果参数 <strong>inferFactor</strong> = false，则超采样因子由整数参数 <strong>factor</strong> 定义。
</p>
<p>
对于控制应用，该模块引入了不必要的“振动”。在这种情况下，最好使用 <a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.SuperSampleInterpolated\" target=\"\">SuperSampleInterpolated</a>&nbsp; &nbsp;模块代替。
</p>
<h4>Example</h4><p>
<span style=\"color: rgb(51, 51, 51);\">以下</span><a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.SuperSample\" target=\"\">example</a>&nbsp; &nbsp;<span style=\"color: rgb(51, 51, 51);\">采样一个周期为 20 毫秒的时钟的正弦信号，然后以 3 的因子对结果时钟化信号进行超采样：</span><br>
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"50\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/SuperSample_Model.png\" alt=\"SuperSample_Model.png\" data-href=\"\" style=\"\"/></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/SuperSample_Result.png\" alt=\"SuperSample_Result.png\" data-href=\"\" style=\"\"/></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">model</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">simulation result</td></tr></tbody></table><p>
<span style=\"color: rgb(51, 51, 51);\">如所示，superSample 为输出 y 引入了因子-1 的额外时钟跳变。超采样因子 = 3 显示在 superSample 块的图标中。请注意，superSample 块图标中的上箭头表示 superSample.y 的时钟比 superSample.u 的时钟快。</span>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"));
end SuperSample;