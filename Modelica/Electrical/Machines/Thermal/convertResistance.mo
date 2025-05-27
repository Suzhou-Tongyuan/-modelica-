within Modelica.Electrical.Machines.Thermal;
function convertResistance 
  "将电阻从参考温度转换为实际温度"
  extends Modelica.Icons.Function;
  input SI.Resistance RRef "TRef 处的电阻";
  input SI.Temperature TRef "参考温度";
  input SI.LinearTemperatureCoefficient alpha20 
    "20°C 处的温度系数";
  input SI.Temperature T "实际温度";
  output SI.Resistance R "T 处的实际电阻";
algorithm
  R := RRef*(1 + Machines.Thermal.convertAlpha(alpha20, TRef)*(T - TRef));
  annotation (Inline=true,Documentation(info="<html>
<p>
从20°C处的温度系数<code>alpha20</code>(等于293.15K)计算参数<code>alphaRef</code>在<code>TRef</code>处：
</p>
<blockquote><pre>
                      alpha20
alphaRef = -------------------------------
            1 + alpha20 * (TRef - 293.15)
</pre></blockquote>
<p>
利用这个值，根据实际温度<code>T</code>，计算实际电阻<code>R</code>：
</p>
<blockquote><pre>
  R
------=1+alphaRef*(T-TRef)
RRef
</pre></blockquote>
<p>
其中<code>RRef</code>是参考温度<code>TRef</code>处的电阻。
</p>
</html>"));
end convertResistance;