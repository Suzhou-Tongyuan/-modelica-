within Modelica.Clocked.IntegerSignals.NonPeriodic;
block FractionalDelay 
  "将时钟输入信号延迟至采样周期的整数倍"
extends Clocked.IntegerSignals.Interfaces.PartialClockedSISO;

  parameter Integer shift(min=0) = 0 
    "延迟 = 间隔() * 移位/分辨率";
  parameter Integer resolution(min=1) = 1 
    "采样间隔的时间量化分辨率";
protected
  parameter Integer n = div(shift,resolution);
  Integer u_buffer[n+1](each start=0) 
    "输入值的前一个值；u_last[1] = u, u_last[2] = previous(u_last[1]); u_last[3] = previous(u_last[2])";
  Boolean first(start=true) "用于识别第一个时钟刻度";
equation
 first = false;
 u_buffer = if previous(first) then fill(u,n+1) else cat(1, {u}, previous(u_buffer[1:n]));
 y = shiftSample(u_buffer[n+1], shift, resolution);

  annotation (    Icon(graphics={
        Line(
          points={{-100,0},{-80,0},{-80,40},{-20,40},{-20,-40},{40,-40},{40,0},{
              100,0}}, 
          color={215,215,215}, 
          pattern=LinePattern.Dot), 
        Line(
          points={{-100,0},{-50,0},{-50,40},{10,40},{10,-40},{70,-40},{70,-0.3125}, 
              {100,0}}, 
          pattern=LinePattern.Dot, 
          color={255,128,0}), 
        Text(
          extent={{-150,-110},{150,-150}}, 
          textString="%shift/%resolution"), 
        Ellipse(
          extent={{-90,50},{-70,30}}, 
          lineColor={255,128,0}, 
          fillColor={255,128,0}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-30,-30},{-10,-50}}, 
          lineColor={255,128,0}, 
          fillColor={255,128,0}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{30,10},{50,-10}}, 
          lineColor={255,128,0}, 
          fillColor={255,128,0}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-60,50},{-40,30}}, 
          lineColor={255,128,0}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{0,-30},{20,-50}}, 
          lineColor={255,128,0}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{60,10},{80,-10}}, 
          lineColor={255,128,0}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid)}));
end FractionalDelay;