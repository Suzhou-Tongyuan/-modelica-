within Modelica.Clocked.RealSignals.NonPeriodic;
block FractionalDelay 
  "将时钟输入信号延迟至采样周期的整数倍"
extends Clocked.RealSignals.Interfaces.PartialClockedSISO;

  parameter Integer shift(min=0) = 0 
    "延迟 = 间隔() * 移位/分辨率";
  parameter Integer resolution(min=1) = 1 
    "采样间隔的时间量化分辨率";
protected
  parameter Integer n = div(shift,resolution);
  Real u_buffer[n+1](each start=0.0) 
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
          color={0,0,127}), 
        Text(
          extent={{-150,-110},{150,-150}}, 
          textString="%shift/%resolution"), 
        Ellipse(
          extent={{-90,50},{-70,30}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-30,-30},{-10,-50}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{30,10},{50,-10}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-60,50},{-40,30}}, 
          lineColor={0,0,127}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{0,-30},{20,-50}}, 
          lineColor={0,0,127}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{60,10},{80,-10}}, 
          lineColor={0,0,127}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid)}), 
    Documentation(info="<html>
<p>
这个模块延迟一个信号。
与 <a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.ShiftSample\">ShiftSample</a> 
模块类似，输出信号 y 的时钟第一次激活相对于输入信号 u 延迟了
<strong>shiftCounter</strong>/<strong>resolution</strong>*interval(u)的时间（这里interval(u)是与输入u关联的时钟的采样周期）。
然而，与ShiftSample不同的是，该模块为输入值提供了一个缓冲区，并真正延迟了输入信号。
</p>

<h4>Example</h4>

<p>
下面的<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.FractionalDelay\">example</a>
显示了正弦信号样本的延迟方式。
<br>
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/FractionalDelay_Model.png\" alt=\"FractionalDelay_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/FractionalDelay_Result.png\" alt=\"FractionalDelay_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
<p>
参数值 <strong>shiftCounter</strong>=3 和 <strong>resolution</strong>=2 可见于分数延迟模块的底部。
</p>
</html>"));
end FractionalDelay;