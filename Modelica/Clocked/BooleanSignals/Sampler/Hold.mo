within Modelica.Clocked.BooleanSignals.Sampler;
block Hold 
  "保持时钟布尔输入信号，并将其作为连续时间输出信号（零阶保持）"
  parameter Boolean y_start = false 
    "与输入 u 相关联的时钟第一次滴答声之前输出 y 的值";

  Modelica.Blocks.Interfaces.BooleanInput 
                                       u(final start=y_start) 
    "时钟、布尔输入信号连接器" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput 
                                        y 
    "连续时间、布尔输出信号连接器" 
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
    y = hold(u);

  annotation (
    defaultComponentName="hold1", 
    Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}, 
        initialScale=0.06), 
                     graphics={Line(points={{-80,-60},{-40,-60},{-40,0},{0,0},{0, 
              0},{0,0},{0,80},{40,80},{40,40},{80,40},{80,0},{80,0},{80,0},{100, 
              0}},               color={255,0,255}), 
                                                   Line(
          points={{-80,-60},{-80,0},{-106,0}}, 
          color={255,0,255}), 
        Ellipse(
          extent={{-90,-50},{-70,-70}}, 
          lineColor={255,0,255}, 
          fillColor={255,0,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-50,10},{-30,-10}}, 
          lineColor={255,0,255}, 
          fillColor={255,0,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-10,90},{10,70}}, 
          lineColor={255,0,255}, 
          fillColor={255,0,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{30,50},{50,30}}, 
          lineColor={255,0,255}, 
          fillColor={255,0,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{70,10},{90,-10}}, 
          lineColor={255,0,255}, 
          fillColor={255,0,255}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-150,-100},{150,-140}}, 
          textString="%y_start", 
          textColor={0,0,0}), 
        Text(
          extent={{-150,130},{150,90}}, 
          textString="%name", 
          textColor={0,0,255})}), 
    Documentation(info="<html>
<p>
这个布尔信号模块的工作原理与实数信号模块类似（参见 <a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Hold\">RealSignals.Sampler.Hold</a>）。
</p>

<p>
类比于相应的实数信号模块示例，这里存在一个关于布尔信号模块的基础<a href=\"modelica://Modelica.Clocked.Examples.Elementary.BooleanSignals.Hold\">example</a>。
</p>

</html>"));
end Hold;