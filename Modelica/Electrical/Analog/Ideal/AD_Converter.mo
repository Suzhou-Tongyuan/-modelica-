within Modelica.Electrical.Analog.Ideal;
model AD_Converter "简单n位转换器(模拟至数字)"
  import L = Modelica.Electrical.Digital.Interfaces.Logic;
  Modelica.Electrical.Analog.Interfaces.PositivePin p 
    "电气正引脚(输入)" annotation(Placement(transformation(
    extent = {{-110, 90}, {-90, 110}}), 
    iconTransformation(extent = {{-110, 90}, {-90, 110}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n 
    "电气负引脚(输入)" annotation(Placement(transformation(
    extent = {{-110, -110}, {-90, -90}}), 
    iconTransformation(
    extent = {{-110, -110}, {-90, -90}})));
  Modelica.Electrical.Digital.Interfaces.DigitalOutput y[N] "数字(信号)输出" 
    annotation(Placement(transformation(extent = {{100, -10}, {120, 10}}), 
    iconTransformation(extent = {{100, -10}, {120, 10}})));
  Modelica.Electrical.Digital.Interfaces.DigitalInput trig "触发输入" 
    annotation(Placement(transformation(extent = {{-8, 90}, {12, 110}}), 
    iconTransformation(
    extent = {{-10, -10}, {10, 10}}, 
    rotation = -90, 
    origin = {0, 100})));
  parameter Integer N(final min = 1, start = 8) 
    "位分辨率-输出信号宽度";
  parameter SI.Voltage VRefHigh(start = 10) "高参考电压";

  parameter SI.Voltage VRefLow(final max = VRefHigh, start = 0) 
    "低参考电压";
  parameter SI.Resistance Rin(start = 10 ^ 6) "输入电阻";
  Integer z(start = 0, fixed = true);
  Real u;

initial algorithm
  for i in 1:N loop
    y[i] := L.'X';
  end for;

algorithm
  when (trig == L.'1' or trig == L.'H') then
    z := if u > VRefLow then integer((u - VRefLow) / (VRefHigh - VRefLow) * (2 ^ N 
      - 1) + 0.5) else 0;
    for i in 1:N loop
      y[i] := if mod(z, 2) > 0 then L.'1' else L.'0';
      z := div(z, 2);
    end for;
  end when;
equation
  p.v - n.v = u;
  p.i * Rin = u;
  p.i + n.i = 0;
  annotation(defaultComponentName = "converter", Documentation(info = "<html>
<p>
一个具有可变分辨率的简单模拟到数字转换器(A/D转换器)。它将输入电压<code>ppin.v-npin.v</code>转换为一个n位的逻辑向量(根据IEEE 1164标准，这个向量为9值逻辑的STD_ULOGIC类型)。输入电路的正负引脚之间的输入电阻由Rin决定。由于这是一个通用模型，因此如输入电容等必须在转换器外部建模。
</p>

<p>
输入信号范围(VRefLo，VRefHi)被分为2^n-1个等间距的阶段，每个阶段的长度为Vlsb=(VRefHi-VRefLo)/(2^n-1)。只要输入电压在第<code>k</code>个阶段，即在<code>Vlsb*(k-0.5)</code>到<code>Vlsb*(k+0.5)</code>的范围内，输出信号就是k的二进制代码。这种操作被称为中间踏板操作。此外，只有当触发信号<code>trig</code>(逻辑类型)变为'1'(强制或弱)时，输出值才能改变。
</p>

<p>输出向量是“小端序”(little-endian)的，即第一个元素y[1]是最低有效位(LSB)。这意味着在存储或处理输出向量时，位数从最低有效位(LSB)到最高有效位(MSB)排列。
</p>

<p>这是一个ADC的抽象模型，因此它无法涵盖转换器的动态行为。因此，当触发信号上升时，输出会瞬间变化。
</p>


</html>", 
    revisions = "<html>
<ul>
<li><em>2009年10月13日</em>
       作者：Matthias Franke
       </li>
</ul>

</html>"), 
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
    {100, 100}}), graphics = {
    Rectangle(extent = {{-100, 100}, {100, -100}}, 
    lineColor = {0, 0, 255}), 
    Polygon(
    points = {{-98, -100}, {100, 98}, {100, -100}, {-98, -100}}, 
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
    textString = "ADC")}));
end AD_Converter;