within Modelica.Clocked.Types;
type Resolution = enumeration(
    y "y (year)", 
    d "d (day)", 
    h "h (hour)", 
    m "min (minutes)", 
    s "s (seconds)", 
    ms "ms (milli seconds)", 
    us "us (micro seconds)", 
    ns "ns (nano seconds)") 
  "枚举定义了时钟信号的分辨率" 
  annotation (Documentation(info="<html>
<p>
枚举定义了时钟信号的分辨率，特别是由模块 
<a href=\"modelica://Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock\">PeriodicExactClock</a>
生成的时钟信号。可能的取值包括：
<br>&nbsp;
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th><strong>Types.Resolution.</strong></th><th><strong>Meaning</strong></th></tr>
<tr><td valign=\"top\">y</td>
    <td valign=\"top\">year (= 365*24*60*60 seconds)</td></tr>

<tr><td valign=\"top\">d</td>
    <td valign=\"top\">day (= 24*60*60 seconds)</td></tr>

<tr><td valign=\"top\">h</td>
    <td valign=\"top\">hour (= 60*60 seconds)</td></tr>

<tr><td valign=\"top\">m</td>
    <td valign=\"top\">minute (= 60 seconds)</td></tr>

<tr><td valign=\"top\">s</td>
    <td valign=\"top\">seconds</td></tr>

<tr><td valign=\"top\">ms</td>
    <td valign=\"top\">milli seconds (= 1/1000 seconds)</td></tr>

<tr><td valign=\"top\">us</td>
    <td valign=\"top\">micro seconds (= 1/(1000*1000) seconds)</td></tr>

<tr><td valign=\"top\">ns</td>
    <td valign=\"top\">nano seconds (= 1/(1000*1000*1000) seconds)</td></tr>
</table>
</html>"));