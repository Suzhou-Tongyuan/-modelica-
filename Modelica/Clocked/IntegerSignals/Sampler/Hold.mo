within Modelica.Clocked.IntegerSignals.Sampler;
block Hold 
  "保持时钟整数输入信号，并将其作为连续时间输出信号（零阶保持）"
  extends Clocked.IntegerSignals.Interfaces.PartialSISOHold;
  parameter Integer y_start = 0 
      "与输入 u 相关联的时钟第一次滴答声之前输出 y 的值";

equation
    y = hold(u);

  annotation (
    defaultComponentName="hold1", 
    Icon(coordinateSystem(
        preserveAspectRatio=false, 
        extent={{-100,-100},{100,100}}, 
        initialScale=0.06), 
                     graphics={
        Ellipse(
          extent={{-70,-28},{-50,-48}}, 
          lineColor={255,128,0}, 
          fillColor={255,128,0}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-30,28},{-10,8}}, 
          lineColor={255,128,0}, 
          fillColor={255,128,0}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{10,70},{30,50}}, 
          lineColor={255,128,0}, 
          fillColor={255,128,0}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{52,12},{72,-8}}, 
          lineColor={255,128,0}, 
          fillColor={255,128,0}, 
          fillPattern=FillPattern.Solid)}), 
    Documentation(info="<html>
<p>
该整数信号模块的工作原理与相应的实数信号模块类似
（参见 <a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Hold\">RealSignals.Sampler.Hold</a>）。
</p>

<p>
与相应的实数信号模块示例类似，该整数信号模块也有一个基本 <a href=\"modelica://Modelica.Clocked.Examples.Elementary.IntegerSignals.Hold\">example</a>。
</p>
</html>"));
end Hold;