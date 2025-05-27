within Modelica.Electrical.Analog.Sources;
model SignalCurrent 
  "使用输入信号作为电流源的通用电流源"

  extends Modelica.Electrical.Analog.Icons.CurrentSource;
  Interfaces.PositivePin p annotation(Placement(transformation(extent = {{-110, 
    -10}, {-90, 10}})));
  Interfaces.NegativePin n annotation(Placement(transformation(extent = {{110, 
    -10}, {90, 10}})));
  Modelica.Blocks.Interfaces.RealInput i(unit = "A") 
    "从引脚P流向引脚N的电流作为输入信号" annotation(
    Placement(transformation(
    origin = {0, 120}, 
    extent = {{-20, -20}, {20, 20}}, 
    rotation = 270)));
  SI.Voltage v "Voltage drop between the two pins (= p.v - n.v)";
equation
  v = p.v - n.v;
  0 = p.i + n.i;
  i = p.i;
  annotation(
    Documentation(revisions = "<html>
<ul>
<li><em> 1998   </em>
       Martin Otter<br>创建<br>
       </li>
</ul>
</html>", 
    info = "<html>

<p>信号电流源是一个无参数的转换器，它将实值信号转换为源电流。没有进一步的效果被建模。实值信号必须由块库中的组件提供。它可以被视为电流传感器的“对立面”。
</p>
</html>"));
end SignalCurrent;