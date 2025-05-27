within Modelica.Clocked.RealSignals.Sampler;
block Hold 
  "保持时钟实数输入信号，并将其作为连续时间输出信号（零阶保持）"
extends Clocked.RealSignals.Interfaces.PartialSISOHold;

equation
    y = hold(u);

  annotation (
    defaultComponentName="hold1", 
    Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}, 
        initialScale=0.06), 
                     graphics={
        Ellipse(
          extent={{-70,-30},{-50,-50}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-30,28},{-10,8}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{10,70},{30,50}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{50,10},{70,-10}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid)}), 
    Documentation(info="<html><p>
<span style=\"color: rgb(51, 51, 51);\">该模块使用零阶保持器保持时钟化的实数输入信号 u，并将其作为连续时间输出信号 y。输入信号的时钟是由推断得出的（即，它需要在时钟化分区的其他地方定义）</span>
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">更准确地说：输入信号 u(ti) 必须是一个时钟化信号。输出信号 y(t) 是一个分段常数的连续时间信号。当 u 的时钟在时间 ti 跳变时，块的输出 y(ti) = u(ti)。否则，对于 t ≥ ti，y(t) 是上次时钟激活时 u(ti) 的值。在 u 的第一次时钟激活之前，块输出参数 </span><strong>y_start</strong> <span style=\"color: rgb(51, 51, 51);\">的值。该参数的值显示在图标下方。</span>
</p>
<h4><span style=\"color: rgb(51, 51, 51);\">示例</span></h4><p>
以下<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.Hold\" target=\"\">example</a>&nbsp; 通过一个周期为20毫秒的周期时钟对正弦信号进行采样， 并延迟了2个采样周期。 结果信号使用Hold模块进行保持。 因此，Hold模块的hold.u的时钟在40毫秒时开始计时。 模块的输出hold.y是一个从模拟开始就存在的连续时间信号。 在hold.u的时钟第一次触发之前， 它被设置为-1.0（即参数hold.y_start的值）。 <br>
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"50\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/Hold_Model.png\" alt=\"Hold_Model.png\" data-href=\"\" style=\"\"/></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/Hold_Result.png\" alt=\"Hold_Result.png\" data-href=\"\" style=\"\"/></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">model</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">simulation result</td></tr></tbody></table><p>
<br>
</p>
</html>"));
end Hold;