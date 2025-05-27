within Modelica.Electrical.Machines.Thermal;
function convertAlpha 
  "将alpha从温度1(默认为20°C)转换为温度2"
  extends Modelica.Icons.Function;
  input SI.LinearTemperatureCoefficient alpha1 
    "温度1(默认：20°C)处的温度系数";
  input SI.Temperature T2 "温度2";
  input SI.Temperature T1=293.15 
    "温度1(默认20°C)";
  output SI.LinearTemperatureCoefficient alpha2 
    "TRef处的温度系数";
algorithm
  alpha2 := alpha1/(1 + alpha1*(T2 - T1));
  annotation (Inline=true,Documentation(info="<html>
<p>
从温度<code>T1</code>(默认20°C=293.15K)处的温度系数<code>alpha1</code>，
计算出温度<code>T2</code>处的温度系数<code>alpha2</code>：
</p>
<blockquote><pre>
              alpha1
alpha2 = ------------------------
          1 + alpha1 * (T2 - T1)
</pre></blockquote>
</html>"));
end convertAlpha;