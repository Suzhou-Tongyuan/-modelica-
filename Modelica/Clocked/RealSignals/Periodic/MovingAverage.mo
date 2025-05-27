within Modelica.Clocked.RealSignals.Periodic;
block MovingAverage 
  "移动平均滤波器（= FIR 滤波器，系数 a = fill(1/n,n)，但以递归方式实现）"
  extends Clocked.RealSignals.Interfaces.PartialClockedSISO;
  parameter Integer n = 2 
    "取平均值的点数（= 相应 FIR 滤波器的系数数）";
protected
  Real u_buffer[n+1](each start=0.0) 
    "以前的输入值; u_buffer[1] = u, u_buffer[2] = previous(u_buffer[1]); u_buffer[3] = previous(u_buffer[2])";
  Boolean first(start=true) "Used to identify the first clock tick";
  Real uu(start=0.0) 
    "虚拟变量，为 y 提供虚拟起始值（无影响）";
  Real yy(start=0.0) 
    "虚拟变量，为 y 提供虚拟起始值（无影响）";
equation
  when Clock() then
     first = false;
     uu = u;

     // 在第一次时钟跳动时，u_last 填入 “u”（初始化为稳定状态）。
     u_buffer = if previous(first) then fill(uu,n+1) else 
                     cat( 1, {uu}, previous(u_buffer[1:n]));

     // 移动平均公式
     y = if previous(first) then uu else previous(yy) + (u_buffer[1] - u_buffer[n+1])/n;
     yy = y;
  end when;
  annotation (
    Documentation(info="<html>
<p>
该模块将输出 y 计算为输入 u 及其过去值的平均值（= 移动平均滤波器）：
</p>
<blockquote><pre>
y(i) = ( u(i) + u(i-1) + u(i-2) + &hellip; ) / n
</pre></blockquote>
<p>
其中，y(i) 和 u(i) 分别是第 i 个时钟刻度处的 y 值和 u 值，n 是要考虑的 u 值和过去 u 值的数量。
</p>

<p>
这个模块也可以通过使用系数 a = fill(1/n, n) 来使模块 <a href=\"modelica://Modelica.Clocked.RealSignals.Periodic.FIRbyCoefficients\">FIRbyCoefficients</a>
 实现。
然而，模块 <em>MovingAverage</em> 是一种更高效的实现方式，
因为它可以递归地实现，这与一般的 FIR 滤波器相反。
</p>

</html>"), Icon(graphics={
     Line(points={{-84,78},{-84,-90}}, color={192,192,192}), 
    Line(points={{-90,-82},{82,-82}}, color={192,192,192}), 
      Rectangle(extent={{-84,-82},{-18,4}}, 
            lineColor={192,192,192}, fillColor={255,255,255}, 
            fillPattern=FillPattern.Backward), 
    Line( points={{-84,30},{-72,30},{-52,28},{-32,20},{-26,16},{-22,12},{-18, 
              6},{-14,-4},{-4,-46},{0,-64},{2,-82}}, 
          color={0,0,127}, 
          smooth=Smooth.Bezier), 
    Polygon(points={{-84,90},{-92,68},{-76,68},{-84,90},{-84,90}}, lineColor={192,192,192}, fillColor={192,192,192}, 
            fillPattern =  FillPattern.Solid), 
      Line(
          points={{2,-82},{4,-64},{8,-56},{12,-56},{16,-60},{18,-66},{20,-82}}, 
          color={0,0,127}, 
          smooth=Smooth.Bezier), 
      Line(
          points={{20,-80},{20,-78},{20,-72},{22,-66},{24,-64},{28,-64},{32, 
              -66},{34,-70},{36,-78},{36,-82},{36,-74},{38,-68},{40,-66},{
              44,-66},{46,-68},{48,-72},{50,-78},{50,-82},{50,-78},{52,-70}, 
              {54,-68},{58,-68},{62,-72},{64,-76},{64,-78},{64,-80},{64,-82}}, 
          color={0,0,127}, 
          smooth=Smooth.Bezier), 
    Polygon(points={{90,-82},{68,-74},{68,-90},{90,-82}}, lineColor={192,192,192}, fillColor={192,192,192}, 
            fillPattern = FillPattern.Solid), 
        Text(
          extent={{-26,88},{88,48}}, 
          textColor={175,175,175}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Backward, 
          textString="MA"), 
        Text(
          extent={{-150,-110},{150,-150}}, 
          fillPattern=FillPattern.Solid, 
          textString="n=%n")}));
end MovingAverage;