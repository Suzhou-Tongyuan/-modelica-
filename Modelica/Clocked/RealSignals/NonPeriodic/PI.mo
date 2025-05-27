within Modelica.Clocked.RealSignals.NonPeriodic;
block PI 
  "带时钟输入和输出信号的离散时间 PI 控制器（用于周期性和非周期性系统，使用连续 PI 控制器的参数化方法）"
  extends Clocked.RealSignals.Interfaces.PartialClockedSISO;
  parameter Real k "连续 PI 控制器的增益";
  parameter Real T(min=Modelica.Constants.small) 
    "连续 PI 控制器的时间常数";
  output Real x(start=0) "离散 PI 状态";
protected
  Real Ts = interval(u) "采样时间（周期性或非周期性）";
equation
  when Clock() then
     x = previous(x) + u*(Ts/T);
     y = k*(x + u);
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
          points={{-80,-82},{-80,-10},{-32,-10},{-32,18},{54,18},{54,46},{84,46}, 
              {84,78}}, 
          color={0,0,127}, 
          pattern=LinePattern.Dot), 
        Text(
          extent={{-30,0},{80,-60}}, 
          textColor={192,192,192}, 
          textString="PI"), 
        Text(
          extent={{-150,-150},{150,-110}}, 
          textString="T=%T"), 
        Ellipse(
          extent={{-87,-3},{-75,-15}}, 
          lineColor={0,0,127}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-38,24},{-26,12}}, 
          lineColor={0,0,127}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{48,52},{60,40}}, 
          lineColor={0,0,127}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid)}), 
    Documentation(info="<html>
<p>
由连续时间 PI 控制器衍生出的离散时间 PI 控制器
</p>
<blockquote><pre>
              1
y = k * (1 + ---) * u
             T*s
        T*s + 1
  = k * ------- * u
          T*s
</pre></blockquote>
<p>
使用隐式欧拉离散化公式。
该模块的参数是连续 PI 模块的增益 k 和时间常数 T。
因此，PI 控制器的离散时间形式明确取决于控制器的采样时间，
改变采样时间仍可获得相似的性能。
</p>
</html>"));
end PI;