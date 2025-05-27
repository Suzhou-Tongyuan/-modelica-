within Modelica.Electrical.Analog.Ideal;
model DA_Converter "简单的数字模拟转换器"
  import L = Modelica.Electrical.Digital.Interfaces.Logic;
  Modelica.Electrical.Digital.Interfaces.DigitalInput trig "触发输入" 
    annotation(Placement(transformation(extent = {{-10, 92}, {10, 112}}), 
    iconTransformation(
    extent = {{-10, -10}, {10, 10}}, 
    rotation = -90, 
    origin = {0, 100})));
  Modelica.Electrical.Digital.Interfaces.DigitalInput x[N] "数字化输入" 
    annotation(Placement(transformation(extent = {{-110, -10}, {-90, 10}}), iconTransformation(extent = {{-110, -10}, {-90, 10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin p 
    "正极电气引脚(输出)" annotation(Placement(transformation(
    extent = {{90, 90}, {110, 110}}), 
    iconTransformation(extent = {{90, 90}, {110, 110}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n 
    "负极电气引脚(输出)" annotation(Placement(transformation(
    extent = {{90, -110}, {110, -90}}), 
    iconTransformation(extent = {{90, -110}, {110, -90}})));

  SI.Voltage vout(start = 0, fixed = true);
  Real y(start = 0, fixed = true);
  parameter Integer N(final min = 1, start = 8) "分辨率-输入信号宽度";
  parameter SI.Voltage Vref(start = 10) "参考电压";

algorithm
  when trig == L.'1' or trig == L.'H' then
    y := 0;
    for i in 1:N loop
      y := if (x[i] == L.'1' or x[i] == L.'H') then y + 2 ^ (i - 1) else y;
    end for;
    vout := y * Vref / (2 ^ N - 1);
  end when;

equation
  p.v - n.v = vout;
  p.i + n.i = 0;

  annotation(defaultComponentName = "converter", Documentation(info = "<html>

<p>一个简单的数字到模拟转换器，具有可变输入信号宽度N位。输入信号是一个N维逻辑向量(根据IEEE 1164 STD_ULOGIC标准，向量具有9值逻辑）。由理想电压源生成的输出电压值为y。只有当触发信号trig的类型为逻辑，并且变为'1'(强制或弱)时，输出电压才能改变。在这种情况下，输出电压按以下方式计算：
</p>
<blockquote><pre>
     N
y = SUM ( x[i]*2^(i-1) )*Vref/(2^N-1),
    i=1
</pre></blockquote>

<p>其中x[i](i=1,...,N)的值为1或0。Vref是参考值。因此，输入向量x[1]中的第一个位是最少有效位(LSB)，而x[N]是最重要位(MSB)。
</p>

<p>这是一个(DAC数字模拟转换器)的抽象模型。因此，它无法涵盖转换器的动态行为。因此，当触发信号上升，输出将立即改变。
</p>

</html>", 
    revisions = "<html>
<ul>
<li><em>2009年10月13日</em>
       Matthias Franke
       </li>
</ul>

</html>"), 
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
    {100, 100}}), graphics = {
    Rectangle(extent = {{-100, 100}, {100, -100}}, 
    lineColor = {0, 0, 255}), 
    Polygon(
    points = {{-100, -100}, {100, 100}, {-100, 100}, {-100, -100}}, 
    lineColor = {0, 0, 255}, 
    fillColor = {127, 0, 127}, 
    fillPattern = FillPattern.Solid), 
    Text(
    extent = {{-60, 50}, {60, 10}}, 
    textColor = {0, 0, 255}, 
    textString = "%n-bit"), 
    Text(
    extent = {{-60, -10}, {60, -50}}, 
    textColor = {0, 0, 255}, 
    textString = "DAC")}));
end DA_Converter;