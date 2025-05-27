within Modelica.Clocked.RealSignals.Periodic;
block PI "离散时间 PI 控制器"
  extends Clocked.RealSignals.Interfaces.PartialClockedSISO;
  parameter Real kd "离散PI控制器的增益";
  parameter Real Td(min=Modelica.Constants.small) 
    "离散 PI 控制器的时间常数";
  output Real x(start=0) "离散 PI 状态";
equation
  when Clock() then
     x = previous(x) + u/Td;
     y = kd*(x + u);
  end when;

  annotation (defaultComponentName="PI1", 
       Icon(graphics={
        Polygon(
          points={{90,-82},{68,-74},{68,-90},{90,-82}}, 
          lineColor={192,192,192}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-90,-82},{82,-82}}, color={192,192,192}), 
        Line(points={{-80,76},{-80,-92}}, color={192,192,192}), 
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}}, 
          lineColor={192,192,192}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Line(
          points={{-80,-82},{-80,-10},{-32,-10},{-32,18},{16,18},{16,46},{64,46}, 
              {64,80}}, 
          color={0,0,127}, 
          pattern=LinePattern.Dot), 
        Text(
          extent={{-30,-4},{82,-58}}, 
          textColor={192,192,192}, 
          textString="PI"), 
        Text(
          extent={{-150,-150},{150,-110}}, 
          textString="Td=%Td"), 
        Ellipse(
          extent={{-87,-3},{-75,-15}}, 
          lineColor={0,0,127}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-37,25},{-25,13}}, 
          lineColor={0,0,127}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{9,52},{21,40}}, 
          lineColor={0,0,127}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{58,87},{70,75}}, 
          lineColor={0,0,127}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid)}), 
    Documentation(info="<html>
<p>
该模块通过公式定义离散时间 PI 控制器：
</p>
<blockquote><pre>
// State space form:This block defines a discrete-time PI controller by the formula:
   x(ti) = previous(x(ti)) + u(ti)/Td;
   y(ti) = kd*(x(ti) + u(ti));

// Transfer function form:
   y(z) = kd*(c*z-1)/(z-1)*u(z);
          c = 1 + 1/Td
</pre></blockquote>
<p>
其中，kd 是增益，Td 是时间常数，ti 是第 i 个时钟周期的时间瞬间，z 是反移位算子。
</p>

<p>
这离散时间形式是通过使用隐式 Euler 离散化公式，从PI控制器的连续时间形式推导而来的。
</p>
</html>"));
end PI;