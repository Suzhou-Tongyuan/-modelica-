within Modelica.Clocked.IntegerSignals.NonPeriodic;
block UnitDelay "将时钟输入信号延迟一个采样周期"
  extends Clocked.IntegerSignals.Interfaces.PartialClockedSISO(u(final
        start=y_start));
  parameter Integer y_start=0 "第一个时钟周期的输出信号值";
equation
  y = previous(u);
  annotation (defaultComponentName="unitDelay1", 
       Icon(graphics={
        Line(points={{-30,0},{30,0}}, color={255,128,0}), 
        Text(
          extent={{-90,10},{90,90}}, 
          textString="1", 
          textColor={255,128,0}), 
        Text(
          extent={{-90,-10},{90,-90}}, 
          textString="z", 
          textColor={255,128,0}), 
        Text(
          extent={{-150,-150},{150,-110}}, 
          textString="y_start=%y_start")}), 
    Documentation(info="<html><p>
该模块描述了单位延迟：
</p>
<p>
<br>
</p>
<pre><code >// Time domain description
   y(ti) = previous(u(ti))

// Discrete transfer function
           1
   y(z) = --- * u(z)
           z
</code></pre><p>
<br>
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">也就是说，输出信号 y 是前一个时钟周期的输入信号 u。在第一个时钟周期，输出 y 被设置为参数 y_start。</span>
</p>
<p>
<br>
</p>
</html>"));
end UnitDelay;