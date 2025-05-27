within Modelica.Thermal.HeatTransfer;
package Celsius "带有摄氏输入和/或输出的组件"
  extends Modelica.Icons.VariantsPackage;

  annotation (Documentation(info="<html><p>
该库中的组件主要为习惯使用摄氏温标的用户提供便利，因为HeatTransfer库中的所有模型均基于开尔文温标。
</p>
<p>
请注意，在Modelica.Units.Conversions库中提供开尔文(K)、摄氏度(°C)、华氏度(°F)和兰氏度(°R)之间的单位转换函数。这些函数允许在需要以开尔文为参数的场景中直接进行单位转换。例如：
</p>
<p>
<br>
</p>
<pre><code >import Modelica.Units.Conversions.from_degC;
Modelica.Thermal.HeatTransfer.HeatCapacitor C(T0 = from_degC(20));
</code></pre><p>
<br>
</p>
<p>
<br>
</p>
</html>"));
end Celsius;