within Modelica.Electrical.Analog.Ideal;
model IdealTriac "理想双向可控硅(基于理想晶闸管)"

  parameter SI.Resistance Ron(final min = 0) = 1e-5 "关闭状态下双向可控硅的电阻";
  parameter SI.Conductance Goff(final min = 0) = 1e-5 
    "未触发双向可控硅的导通电阻";
  parameter SI.Voltage Vknee(
    final min = 0, 
    start = 0) = 0.8 "正相和负相的阈值电压";

  parameter SI.Resistance Rdis = 100 "抗干扰电阻";
  parameter SI.Capacitance Cdis = 0.005 "抗干扰能力";

  Modelica.Electrical.Analog.Ideal.IdealThyristor idealThyristor(
    Ron = Ron, 
    Goff = Goff, 
    Vknee = Vknee) annotation(Placement(transformation(
    extent = {{-10, -10}, {10, 10}}, 
    origin = {-10, 32})));
  Modelica.Electrical.Analog.Ideal.IdealThyristor idealThyristor1(
    Ron = Ron, 
    Goff = Goff, 
    Vknee = Vknee) annotation(Placement(transformation(
    extent = {{-10, -10}, {10, 10}}, 
    rotation = 180, 
    origin = {-10, -32})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R = Rdis) 
    annotation(Placement(transformation(extent = {{-60, -10}, {-40, 10}})));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor(C = Cdis) 
    annotation(Placement(transformation(extent = {{20, -10}, {40, 10}})));
  Modelica.Blocks.Interfaces.BooleanInput fire1 "Gate" 
    annotation(Placement(transformation(extent = {{-14, -14}, {14, 14}}, 
    rotation = 90, 
    origin = {-100, -114}), iconTransformation(
    extent = {{-14, -14}, {14, 14}}, 
    rotation = 90, 
    origin = {-100, -114})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n "Cathode" 
    annotation(Placement(transformation(extent = {{-110, -10}, {-90, 10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin p "Anode" 
    annotation(Placement(transformation(extent = {{90, -10}, {110, 10}})));
equation

  connect(idealThyristor.n, capacitor.n) annotation(Line(
    points = {{0, 32}, {40, 32}, {40, 0}}, color = {0, 0, 255}));
  connect(capacitor.n, idealThyristor1.p) annotation(Line(
    points = {{40, 0}, {40, -32}, {0, -32}}, color = {0, 0, 255}));
  connect(idealThyristor1.n, resistor.p) annotation(Line(
    points = {{-20, -32}, {-60, -32}, {-60, 0}}, color = {0, 0, 255}));
  connect(resistor.p, idealThyristor.p) annotation(Line(
    points = {{-60, 0}, {-60, 32}, {-20, 32}}, color = {0, 0, 255}));
  connect(resistor.n, capacitor.p) annotation(Line(
    points = {{-40, 0}, {20, 0}}, color = {0, 0, 255}));
  connect(idealThyristor1.fire, fire1) annotation(Line(
    points = {{-20, -44}, {-20, -100}, {-100, -100}, {-100, -114}, {-100, -114}}, color = {255, 0, 255}));
  connect(idealThyristor.fire, fire1) annotation(Line(
    points = {{0, 44}, {0, 60}, {-80, 60}, {-80, -100}, {-100, -100}, {-100, -114}, {-100, -114}}, color = {255, 0, 255}));
  connect(n, idealThyristor.p) annotation(Line(
    points = {{-100, 0}, {-90, 0}, {-90, 40}, {-20, 40}, {-20, 32}}, color = {0, 0, 255}));
  connect(idealThyristor1.p, p) annotation(Line(
    points = {{0, -32}, {0, -40}, {80, -40}, {80, 0}, {100, 0}}, color = {0, 0, 255}));
  annotation(defaultComponentName = "triac", 
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
    {100, 100}}), graphics = {
    Text(
    extent = {{-150, 130}, {150, 90}}, 
    textString = "%name", 
    textColor = {0, 0, 255}), 
    Line(
    points = {{-100, -100}, {-100, -80}}, 
    color = {255, 0, 255}, 
    pattern = LinePattern.Dash), 
    Line(points = {{-40, -70}, {-40, 70}}, color = {0, 0, 255}), 
    Line(points = {{40, -72}, {40, 70}}, color = {0, 0, 255}), 
    Polygon(points = {{-40, -70}, {40, -30}, {-40, 10}, {-40, -70}}, 
    lineColor = {0, 0, 
    255}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), 
    Polygon(points = {{40, -10}, {-40, 30}, {40, 70}, {40, -10}}, lineColor = {0, 0, 
    255}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{-40, 0}, {-90, 0}}, color = {0, 0, 255}), 
    Line(points = {{100, 0}, {40, 0}}, color = {0, 0, 255}), 
    Line(points = {{-100, -100}, {-100, -60}, {-40, -30}}, 
    color = {255, 0, 255})}), 
    Documentation(info = "<html>
<p>这是基于理想三极管模型的理想三极开关模型。
</p>

<p>
两个理想的三极管(Modelica.Electrical.Analog.Ideal.IdealThyristor)以相反的方式并联连接，并通过一个电阻(Rdis=100)和一个电容(Cdis=0.005)的串联连接来消除干扰。
</p>

<p>电气元件三极管(TRIode Alternating Current switch)是一种多功能应用单元，其复杂结构使其在频率、电压和电流方面具有操纵交流信号的能力。此元件的应用领域还包括总体阻断或过滤。但是，与三极管相比，三极管通常仅用于较小电流的应用，这是由其敏感结构决定的。通常，三极管的最大电压限制在800伏和最大电流限制在40安培。另一方面，三极管的最大电压可以达到8000伏，最大电流可以达到5000安培。
</p>

<p>构造和功能:</p>

<p>三极管的功能原理上与晶闸管相同，都是通过在一定电压(正向阻断电压或膝电压)以上时，在阳极和阴极之间开始导通电流。但是，三极管的这种过程也可以在反向极性下进行，因此可以控制交流电的两个半波。通过三极管中的栅极电极(三极管只需要一个栅极电极)的原理，可以确定三极管允许交流信号通过的时间点，从而可以影响交流信号被切断的相位。这种控制也称为相位角控制。此外，由于掺杂和特定的结构，膝电压和最大电流承载能力也是可变的。
</p>

<p>特征：</p>
<ul>

<li>在从导通状态到截止状态的高速切换过程中，直到反向电流相位被激活之前，栅极电极会被一个正向脉冲激活(称为晶闸管/三极管触发)。

</li>
<li>触发后，晶闸管路径会保持在低阻抗或导通状态，直到维持电压降至低于某一阈值，随后转变为截止状态，下一个晶闸管路径可以被触发。
</li>

<li>特别是在切换电感性元件时，三极管会产生谐波波，其频率范围可能进入广播频段，并可能在那里引起传输干扰。因此，三极管需要通过电感器和电容器来消除这些干扰。
</li>


</ul>
<p>应用场景:</p>
<ul>

<li>无级曝光(调光器)
</li>

<li>电动机转速调节
</li>

<li>相位角控制的其他应用(电力电子)
</li>

<li>可携带的电源单元
</li>

</ul>
<p>额外信息：这个模型基于Modelica.Electrical.Analog.Ideal.IdealThyristor搭建。</p>
</html>", 
    revisions = "<html>
<ul>
<li><em>2009年11月25日</em>
       作者：Susann Wolf
       </li>
</ul>

</html>"));
end IdealTriac;