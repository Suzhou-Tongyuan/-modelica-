within Modelica.Thermal.HeatTransfer;
package Fahrenheit "带有华氏输入和/或输出的组件"
  extends Modelica.Icons.VariantsPackage;

  annotation (Documentation(info="<html><p style=\"text-align: start;\">该库中的组件专为习惯使用华氏度单位的人员提供便利，因为HeatTransfer库中的所有模型均基于开尔文单位。
</p>
<p style=\"text-align: start;\">注意：在Modelica.Units.Conversions库中，已提供开尔文（Kelvin）、摄氏度（°C）、华氏度（°F）和兰氏度（°R）之间的单位转换函数。这些函数允许在需要以开尔文为参数的任意位置直接进行单位转换。例如：
</p>
<p>
<br>
</p>
<pre><code >import Modelica.Units.Conversions.from_degF;
Modelica.Thermal.HeatTransfer.HeatCapacitor C(T0 = from_degF(70));
</code></pre><p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"));
end Fahrenheit;