within Modelica.Clocked.RealSignals.Periodic;
block FIRbyCoefficients "由系数定义的 FIR 滤波器"
  extends Clocked.RealSignals.Interfaces.PartialClockedSISO;
  input Real a[:]={1/2,1/2} "FIR 滤波器系数" annotation(Dialog);
  parameter Real cBufStart[size(a,1)-1] = ones(size(a,1)-1) 
    "系数 u 缓冲区 [u(i-1)，u(i-2)，...，u(size(a,1)-1)] 以 u(i=1)*cBufStartof FIR 滤波器初始化。" 
                          annotation(Dialog(tab="高级"));
protected
  parameter Integer n = size(a, 1) - 1 "滤波器的阶数";
  Real u_buffer[n+1](each start=0.0) 
    "以前的输入值; u_buffer[1] = u, u_buffer[2] = previous(u_buffer[1]); u_buffer[3] = previous(u_buffer[2])";
  Boolean first(start=true) "用于识别第一个时钟刻度";
equation
  when Clock() then
     first = false;

     // 在第一次时钟跳动时，u_last 填入 “u”（初始化为稳定状态）。
     u_buffer = if previous(first) then cat( 1, {u}, u*cBufStart)  else 
                     cat( 1, {u}, previous(u_buffer[1:n]));

     // FIR 公式
     y = a*u_buffer;
  end when;

  annotation (defaultComponentName="FIR1", 
    Documentation(info="<html><p>
该模块将输出 y 计算为输入 u 及其过去值的线性组合（= FIR 滤波器）：
</p>
<p>
<br>
</p>
<pre><code >y(i) = a[1]*u(i) + a[2]*u(i-1) + a[3]*u(i-2) + …
</code></pre><p>
<br>
</p>
<p>
其中，y(i) 和 u(i) 是时钟刻度 i 时的 y 值和 u 值，a[:] 是滤波器系数。
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">在第一个时钟周期 i=1 时，过去的值被当前时刻的 u 填充（= 稳态初始化）。</span>
</p>
<p>
<br>
</p>
</html>"), 
    Icon(graphics={
    Polygon(points={{-84,90},{-92,68},{-76,68},{-84,90},{-84,90}}, lineColor={192,192,192}, fillColor={192,192,192}, 
            fillPattern =  FillPattern.Solid), 
     Line(points={{-84,78},{-84,-90}}, color={192,192,192}), 
    Line(points={{-84,30},{-72,30},{-52,28},{-32,20},{-26,16},{-22,12},{-18,6},{
              -14,-4},{-4,-46},{0,-64},{2,-82}}, 
         color={0,0,127}, 
         smooth=Smooth.Bezier), 
      Rectangle(extent={{-84,-82},{-18,4}}, 
            lineColor={192,192,192}, fillColor={255,255,255}, 
            fillPattern=FillPattern.Backward), 
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
    Line(points={{-90,-82},{82,-82}}, color={192,192,192}), 
        Text(
          extent={{-26,86},{88,56}}, 
          textColor={175,175,175}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Backward, 
          textString="FIR"), 
        Text(
          extent={{-150,-110},{150,-150}}, 
          fillPattern=FillPattern.Solid, 
          textString="a=%a")}));
end FIRbyCoefficients;