within Modelica.Blocks;
package Interfaces 
  "输入/输出块的连接器和部分模型库"

  extends Modelica.Icons.InterfacesPackage;

  connector RealInput = input Real "实型输入接口" annotation(
    defaultComponentName = "u", 
    Icon(graphics = {
    Polygon(
    lineColor = {0, 0, 127}, 
    fillColor = {0, 0, 127}, 
    fillPattern = FillPattern.Solid, 
    points = {{-100.0, 100.0}, {100.0, 0.0}, {-100.0, -100.0}})}, 
    coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, 
    preserveAspectRatio = true, 
    initialScale = 0.2)), 
    Diagram(
    coordinateSystem(preserveAspectRatio = true, 
    initialScale = 0.2, 
    extent = {{-100.0, -100.0}, {100.0, 100.0}}), 
    graphics = {
    Polygon(
    lineColor = {0, 0, 127}, 
    fillColor = {0, 0, 127}, 
    fillPattern = FillPattern.Solid, 
    points = {{0.0, 50.0}, {100.0, 0.0}, {0.0, -50.0}, {0.0, 50.0}}), 
    Text(
    textColor = {0, 0, 127}, 
    extent = {{-10.0, 60.0}, {-10.0, 85.0}}, 
    textString = "%name")}), 
    Documentation(info = "<html>
<p>
具有一个 Real 类型输入信号的接口。
</p>
</html>"  ));

  connector RealOutput = output Real "实型输出接口" annotation(
    defaultComponentName = "y", 
    Icon(
    coordinateSystem(preserveAspectRatio = true, 
    extent = {{-100.0, -100.0}, {100.0, 100.0}}), 
    graphics = {
    Polygon(
    lineColor = {0, 0, 127}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid, 
    points = {{-100.0, 100.0}, {100.0, 0.0}, {-100.0, -100.0}})}), 
    Diagram(
    coordinateSystem(preserveAspectRatio = true, 
    extent = {{-100.0, -100.0}, {100.0, 100.0}}), 
    graphics = {
    Polygon(
    lineColor = {0, 0, 127}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid, 
    points = {{-100.0, 50.0}, {0.0, 0.0}, {-100.0, -50.0}}), 
    Text(
    textColor = {0, 0, 127}, 
    extent = {{30.0, 60.0}, {30.0, 110.0}}, 
    textString = "%name")}), 
    Documentation(info = "<html>
<p>
具有一个 Real 类型输出信号的接口。
</p>
</html>"  ));

  connector BooleanInput = input Boolean "布尔型输入接口" 
    annotation(
    defaultComponentName = "u", 
    Icon(graphics = {Polygon(
    points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}}, 
    lineColor = {255, 0, 255}, 
    fillColor = {255, 0, 255}, 
    fillPattern = FillPattern.Solid)}, coordinateSystem(
    extent = {{-100, -100}, {100, 100}}, 
    preserveAspectRatio = true, 
    initialScale = 0.2)), 
    Diagram(coordinateSystem(
    preserveAspectRatio = true, 
    initialScale = 0.2, 
    extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(
    points = {{0, 50}, {100, 0}, {0, -50}, {0, 50}}, 
    lineColor = {255, 0, 255}, 
    fillColor = {255, 0, 255}, 
    fillPattern = FillPattern.Solid), Text(
    extent = {{-10, 85}, {-10, 60}}, 
    textColor = {255, 0, 255}, 
    textString = "%name")}), 
    Documentation(info = "<html>
<p>
具有一个 Boolean 类型输入信号的接口。
</p>
</html>"  ));

  connector BooleanOutput = output Boolean "布尔型输出接口" 
    annotation(
    defaultComponentName = "y", 
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(
    points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}}, 
    lineColor = {255, 0, 255}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid)}), 
    Diagram(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(
    points = {{-100, 50}, {0, 0}, {-100, -50}, {-100, 50}}, 
    lineColor = {255, 0, 255}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), Text(
    extent = {{30, 110}, {30, 60}}, 
    textColor = {255, 0, 255}, 
    textString = "%name")}), 
    Documentation(info = "<html>
<p>
具有一个 Boolean 类型输出信号的接口。
</p>
</html>"    ));

  connector IntegerInput = input Integer "整型输入接口" 
    annotation(
    defaultComponentName = "u", 
    Icon(graphics = {Polygon(
    points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}}, 
    lineColor = {255, 127, 0}, 
    fillColor = {255, 127, 0}, 
    fillPattern = FillPattern.Solid)}, coordinateSystem(
    extent = {{-100, -100}, {100, 100}}, 
    preserveAspectRatio = true, 
    initialScale = 0.2)), 
    Diagram(coordinateSystem(
    preserveAspectRatio = true, 
    initialScale = 0.2, 
    extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(
    points = {{0, 50}, {100, 0}, {0, -50}, {0, 50}}, 
    lineColor = {255, 127, 0}, 
    fillColor = {255, 127, 0}, 
    fillPattern = FillPattern.Solid), Text(
    extent = {{-10, 85}, {-10, 60}}, 
    textColor = {255, 127, 0}, 
    textString = "%name")}), 
    Documentation(info = "<html>
<p>
具有一个 Integer 类型输入信号的接口。.
</p>
</html>"  ));

  connector IntegerOutput = output Integer "整型输出接口" 
    annotation(
    defaultComponentName = "y", 
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(
    points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}}, 
    lineColor = {255, 127, 0}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid)}), 
    Diagram(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(
    points = {{-100, 50}, {0, 0}, {-100, -50}, {-100, 50}}, 
    lineColor = {255, 127, 0}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), Text(
    extent = {{30, 110}, {30, 60}}, 
    textColor = {255, 127, 0}, 
    textString = "%name")}), 
    Documentation(info = "<html>
<p>
具有一个 Integer 类型输出信号的接口。
</p>
</html>"  ));

  connector RealVectorInput = input Real 
    "用于连接向量的实型输入连接器" annotation(
    defaultComponentName = "u", 
    Icon(graphics = {Ellipse(
    extent = {{-100, 100}, {100, -100}}, 
    lineColor = {0, 0, 127}, 
    fillColor = {0, 0, 127}, 
    fillPattern = FillPattern.Solid)}, coordinateSystem(
    extent = {{-100, -100}, {100, 100}}, 
    preserveAspectRatio = true, 
    initialScale = 0.2)), 
    Diagram(coordinateSystem(
    preserveAspectRatio = false, 
    initialScale = 0.2, 
    extent = {{-100, -100}, {100, 100}}), graphics = {Text(
    extent = {{-10, 85}, {-10, 60}}, 
    textColor = {0, 0, 127}, 
    textString = "%name"), Ellipse(
    extent = {{-50, 50}, {50, -50}}, 
    lineColor = {0, 0, 127}, 
    fillColor = {0, 0, 127}, 
    fillPattern = FillPattern.Solid)}), 
    Documentation(info = "<html>
<p>
实数输入连接器，用于向量连接器，
例如<a href=\"modelica://Modelica.Blocks.Interfaces.PartialRealMISO\">PartialRealMISO</a>，
因此具有与实数输入接口不同的图标。
</p>
</html>"  ));

  connector IntegerVectorInput = input Integer 
    "用于连接矢量的整数输入接口" annotation(
    defaultComponentName = "u", 
    Icon(graphics = {Ellipse(
    extent = {{-100, 100}, {100, -100}}, 
    lineColor = {255, 128, 0}, 
    fillColor = {255, 128, 0}, 
    fillPattern = FillPattern.Solid)}, coordinateSystem(
    extent = {{-100, -100}, {100, 100}}, 
    preserveAspectRatio = true, 
    initialScale = 0.2)), 
    Diagram(coordinateSystem(
    preserveAspectRatio = false, 
    initialScale = 0.2, 
    extent = {{-100, -100}, {100, 100}}), graphics = {Text(
    extent = {{-10, 85}, {-10, 60}}, 
    textColor = {255, 128, 0}, 
    textString = "%name"), Ellipse(
    extent = {{-50, 50}, {50, -50}}, 
    lineColor = {255, 128, 0}, 
    fillColor = {255, 128, 0}, 
    fillPattern = FillPattern.Solid)}), 
    Documentation(info="<html><p>
整数输入连接器，用于向量连接， 例如<a href=\"modelica://Modelica.Blocks.Interfaces.PartialIntegerMISO\" target=\"\">PartialIntegerMISO</a>&nbsp;， 因此具有与整数输入接口不同的图标。
</p>
</html>"));

  connector BooleanVectorInput = input Boolean 
    "用于连接器向量的布尔输入接口" annotation(
    defaultComponentName = "u", 
    Icon(graphics = {Ellipse(
    extent = {{-100, -100}, {100, 100}}, 
    lineColor = {255, 0, 255}, 
    fillColor = {255, 0, 255}, 
    fillPattern = FillPattern.Solid)}, coordinateSystem(
    extent = {{-100, -100}, {100, 100}}, 
    preserveAspectRatio = false, 
    initialScale = 0.2)), 
    Diagram(coordinateSystem(
    preserveAspectRatio = false, 
    initialScale = 0.2, 
    extent = {{-100, -100}, {100, 100}}), graphics = {Text(
    extent = {{-10, 85}, {-10, 60}}, 
    textColor = {255, 0, 255}, 
    textString = "%name"), Ellipse(
    extent = {{-50, 50}, {50, -50}}, 
    lineColor = {255, 0, 255}, 
    fillColor = {255, 0, 255}, 
    fillPattern = FillPattern.Solid)}), 
    Documentation(info="<html><p>
布尔输入连接器，用于向量连接， 例如<a href=\"modelica://Modelica.Blocks.Interfaces.PartialBooleanMISO\" target=\"\">PartialBooleanMISO</a>&nbsp;， 因此具有与布尔输入接口不同的图标。
</p>
</html>"));

  connector RealVectorOutput = output Real 
    "用于连接器矢量的实数输出接口" annotation(
    defaultComponentName = "y", 
    Icon(graphics = {Ellipse(
    extent = {{-100, 100}, {100, -100}}, 
    lineColor = {0, 0, 127}, 
    fillColor = {0, 0, 127}, 
    fillPattern = FillPattern.Solid)}, coordinateSystem(
    extent = {{-100, -100}, {100, 100}}, 
    preserveAspectRatio = true, 
    initialScale = 0.2)), 
    Diagram(coordinateSystem(
    preserveAspectRatio = false, 
    initialScale = 0.2, 
    extent = {{-100, -100}, {100, 100}}), graphics = {Text(
    extent = {{-10, 85}, {-10, 60}}, 
    textColor = {0, 0, 127}, 
    textString = "%name"), Ellipse(
    extent = {{-50, 50}, {50, -50}}, 
    lineColor = {0, 0, 127}, 
    fillColor = {0, 0, 127}, 
    fillPattern = FillPattern.Solid)}), 
    Documentation(info="<html><p>
实数输出连接器，用于向量连接， 例如<a href=\"modelica://Modelica.Blocks.Routing.DeMultiplex\" target=\"\">DeMultiplex</a>&nbsp;， 因此具有与实数输出接口不同的图标。
</p>
</html>"));

  partial block SO "单输出连续控制模块"
    extends Modelica.Blocks.Icons.Block;

    RealOutput y "实数输出信号接口" annotation(Placement(
      transformation(extent = {{100, -10}, {120, 10}})));
    annotation(Documentation(info = "<html>
<p>
有一个连续的实数输出信号模块。
</p>
</html>"  ));

  end SO;

  partial block MO "多输出连续控制模块"
    extends Modelica.Blocks.Icons.Block;

    parameter Integer nout(min = 1) = 1 "输出端数量";
    RealOutput y[nout] "实数输出信号接口" annotation(Placement(
      transformation(extent = {{100, -10}, {120, 10}})));
    annotation(Documentation(info = "<html>
<p>
有一个连续的实数输出信号矢量模块。
</p>
</html>"  ));

  end MO;

  partial block SISO "单输入单输出连续控制模块"
    extends Modelica.Blocks.Icons.Block;

    RealInput u "实数输入信号接口" annotation(Placement(
      transformation(extent = {{-140, -20}, {-100, 20}})));
    RealOutput y "实数输出信号接口" annotation(Placement(
      transformation(extent = {{100, -10}, {120, 10}})));
    annotation(Documentation(info = "<html>
<p>
有一个连续的实数输入信号和一个连续的实数输出信号模块。
</p>
</html>"  ));
  end SISO;

  partial block SI2SO 
    "2个单输入/1个单输出连续控制模块"
    extends Modelica.Blocks.Icons.Block;

    RealInput u1 "实数输入信号接口1" annotation(Placement(
      transformation(extent = {{-140, 40}, {-100, 80}})));
    RealInput u2 "实数输入信号接口2" annotation(Placement(
      transformation(extent = {{-140, -80}, {-100, -40}})));
    RealOutput y "实数输出信号接口" annotation(Placement(
      transformation(extent = {{100, -10}, {120, 10}})));

    annotation(Documentation(info = "<html>
<p>
有两个连续的实数输入信号u1和u2以及一个连续的实数输出信号y的模块。
</p>
</html>"  ));

  end SI2SO;

  partial block SIMO "单输入多输出连续控制模块"
    extends Modelica.Blocks.Icons.Block;
    parameter Integer nout = 1 "输出端数量";
    RealInput u "实数输入信号接口" annotation(Placement(
      transformation(extent = {{-140, -20}, {-100, 20}})));
    RealOutput y[nout] "实数输出信号接口" annotation(Placement(
      transformation(extent = {{100, -10}, {120, 10}})));

    annotation(Documentation(info = "<html>
<p>有一个连续的实数输入信号和一个连续的实数输出信号矢量模块。</p>

</html>"  ));
  end SIMO;

  partial block MISO "多输入单输出连续控制模块"

    extends Modelica.Blocks.Icons.Block;
    parameter Integer nin = 1 "输入端数量";
    RealInput u[nin] "实数输入信号接口" annotation(Placement(
      transformation(extent = {{-140, -20}, {-100, 20}})));
    RealOutput y "实数输出信号接口" annotation(Placement(
      transformation(extent = {{100, -10}, {120, 10}})));
    annotation(Documentation(info = "<html>
<p>
有一个连续的实数输入信号矢量和一个连续的实数输出信号模块。
</p>
</html>"  ));
  end MISO;

  partial block PartialRealMISO 
    "具有实型向量输入和实型输出信号的基础模块"

    parameter Integer significantDigits(min = 1) = 3 
      "y的动态图表层中要显示的有效数字位数" 
      annotation(Dialog(tab = "高级"));
    parameter Integer nu(min = 0) = 0 "输入接口数量" 
      annotation(Dialog(connectorSizing = true), HideResult = true);
    Modelica.Blocks.Interfaces.RealVectorInput u[nu] 
      annotation(Placement(transformation(extent = {{-120, 70}, {-80, -70}})));
    Modelica.Blocks.Interfaces.RealOutput y 
      annotation(Placement(transformation(extent = {{100, -17}, {134, 17}})));
    annotation(Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}, 
      initialScale = 0.06), graphics = {
      Text(
      extent = {{110, -50}, {300, -70}}, 
      textString = DynamicSelect(" ", String(y, significantDigits = 
      significantDigits))), 
      Text(
      extent = {{-250, 170}, {250, 110}}, 
      textString = "%name", 
      textColor = {0, 0, 255}), 
      Rectangle(
      extent = {{-100, 100}, {100, -100}}, 
      lineColor = {255, 137, 0}, 
      fillColor = {255, 255, 255}, 
      borderPattern = BorderPattern.Raised, 
      fillPattern = FillPattern.Solid)}),Documentation(info="<html><p>
<br>
</p>
</html>"));
  end PartialRealMISO;

  partial block MIMO "多输入多输出连续控制模块"

    extends Modelica.Blocks.Icons.Block;
    parameter Integer nin = 1 "输入数";
    parameter Integer nout = 1 "输出数";
    RealInput u[nin] "实数输入信号接口" annotation(Placement(
      transformation(extent = {{-140, -20}, {-100, 20}})));
    RealOutput y[nout] "实数输出信号接口" annotation(Placement(
      transformation(extent = {{100, -10}, {120, 10}})));
    annotation(Documentation(info = "<html>
<p>
有一个连续的实数输入和一个连续的实数输出信号矢量模块。
输入和输出矢量的信号大小可能不同。
</p>
</html>"  ));
  end MIMO;

  partial block MIMOs 
    "具有相同数量输入和输出的多输入多输出连续控制模块"

    extends Modelica.Blocks.Icons.Block;
    parameter Integer n = 1 "输入数(=输出数)";
    RealInput u[n] "实数输入信号接口" annotation(Placement(
      transformation(extent = {{-140, -20}, {-100, 20}})));
    RealOutput y[n] "实数输出信号接口" annotation(Placement(
      transformation(extent = {{100, -10}, {120, 10}})));
    annotation(Documentation(info = "<html>
<p>
有一个连续的实数输入和一个连续的实数输出信号矢量模块，输入和输出矢量的信号大小相同。
</p>
</html>"  ));
  end MIMOs;

  partial block MI2MO 
    "2个多路输入/多路输出连续控制模块"
    extends Modelica.Blocks.Icons.Block;

    parameter Integer n = 1 "输入和输出向量的维数";

    RealInput u1[n] "实数输入信号接口1" annotation(Placement(
      transformation(extent = {{-140, 40}, {-100, 80}})));
    RealInput u2[n] "实数输入信号接口2" annotation(Placement(
      transformation(extent = {{-140, -80}, {-100, -40}})));
    RealOutput y[n] "实数输出信号接口" annotation(Placement(
      transformation(extent = {{100, -10}, {120, 10}})));
    annotation(Documentation(info="<html><p>
有两个连续的实数输入向量 u1 和 u2 以及一个连续的实数输出向量 y 的模块，所有向量的元素个数相同。
</p>
</html>"  ));

  end MI2MO;
  partial block VI2VO 
    "2个向量输入/1个向量输出连续控制块"
    extends Modelica.Blocks.Icons.Block;
    parameter Integer n = 1 "向量的长度";
    Modelica.Blocks.Interfaces.RealInput u1[n] "实数向量输入信号1的连接器" annotation (Placement(
          transformation(extent={{-140,40},{-100,80}})));
    Modelica.Blocks.Interfaces.RealInput u2[n] "实数向量输入信号2的连接器" annotation (Placement(
          transformation(extent={{-140,-80},{-100,-40}})));
    Modelica.Blocks.Interfaces.RealOutput y[n] "实数向量输出信号的连接器" annotation (Placement(
          transformation(extent={{100,-10},{120,10}})));

    annotation (Documentation(info="<html><p>
该块具有两个连续的实数向量输入信号u1[n]和u2[n]，以及一个连续的实数向量输出信号y。
</p>
</html>"      ));

  end VI2VO;

  partial block SignalSource "连续信号源的基类"
    extends SO;
    parameter Real offset = 0 "输出信号y的偏移量";
    parameter SI.Time startTime = 0 "当time < startTime时，输出y = offset";
    annotation(Documentation(info = "<html>
<p>
Blocks.Sources 软件包中的实数信号源基本模块。
该组件有一个连续的实数输出信号y和两个参数(偏移量、开始时间)，用于移动生成的信号。
</p>
</html>"  ) );
  end SignalSource;

  partial block SVcontrol "单变量连续控制器"
    extends Modelica.Blocks.Icons.Block;

    RealInput u_s "设定值输入信号接口" annotation(Placement(
      transformation(extent = {{-140, -20}, {-100, 20}})));
    RealInput u_m "测量输入信号接口" annotation(Placement(
      transformation(
      origin = {0, -120}, 
      extent = {{20, -20}, {-20, 20}}, 
      rotation = 270)));
    RealOutput y "执行器输出信号接口" annotation(Placement(
      transformation(extent = {{100, -10}, {120, 10}})));
    annotation(Documentation(info = "<html>
<p>
有两个连续的实数输入信号和一个连续的实数输出信号的模块。
该模块可用作相应控制器的基类。
</p>
</html>"  ));
  end SVcontrol;

  partial block MVcontrol "多变量连续控制器"
    extends Modelica.Blocks.Icons.Block;

    parameter Integer nu_s = 1 "设定点输入数";
    parameter Integer nu_m = 1 "测量输入端数量";
    parameter Integer ny = 1 "执行器输出端数量";
    RealInput u_s[nu_s] "设定点输入信号接口" annotation(
      Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
    RealInput u_m[nu_m] "测量输入信号接口" annotation(
      Placement(transformation(
      origin = {0, -120}, 
      extent = {{20, -20}, {-20, 20}}, 
      rotation = 270)));
    RealOutput y[ny] "执行机构输出信号接口" annotation(
      Placement(transformation(extent = {{100, -10}, {120, 10}})));
    annotation(Documentation(info = "<html>
<p>
有两个连续的实数输入信号矢量和一个连续的实数输出信号矢量的模块。
该模块可用作相应控制器的基类。
</p>
</html>"  ));
  end MVcontrol;

  partial block DiscreteBlock "离散控制模块基类"
    extends Modelica.Blocks.Icons.DiscreteBlock;

    parameter SI.Time samplePeriod(min = 100 * Modelica.Constants.eps, start = 0.1) 
      "组件的采样周期";
    parameter SI.Time startTime = 0 "第一个采样时刻";
  protected
    output Boolean sampleTrigger "True，如果是采样时刻";
    output Boolean firstTrigger(start = false, fixed = true) 
      "上升沿信号首次采样时刻";
  equation
    sampleTrigger = sample(startTime, samplePeriod);
    when sampleTrigger then
      firstTrigger = time <= startTime + samplePeriod / 2;
    end when;
    annotation(Documentation(info="<html><p>
库 Blocks.Discrete 离散模块的基本定义。 输出只在事件发生时才会改变，但在 Modelica 中并不是正式的离散变量。 输入将被采样，因此可以是连续变量。
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">重要提示：如果连接多个离散块，通常应确保所有块的采样周期（samplePeriod）和起始时间（startTime）完全相同，因为否则一个块的输出将被转换为连续信号并进行采样，这可能导致最大为一个采样周期的变量延迟，从而产生意外的结果。</span>
</p>
<p>
Modelica 3.3 引入了同步运算符，避免了手动将 samplePeriod 传播到每个模块的需要。
</p>
</html>"));
  end DiscreteBlock;

  partial block DiscreteSISO 
    "单输入单输出离散控制模块"

    extends DiscreteBlock;

    Modelica.Blocks.Interfaces.RealInput u "实数输入信号接口" 
      annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
    Modelica.Blocks.Interfaces.RealOutput y "实数输出信号接口" 
      annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));
    annotation(Documentation(info = "<html>
<p>
有一个输入信号和一个输出信号的模块，根据定义的<strong>samplePeriod</strong>参数进行采样。
更多信息请参见基类<a href=\"modelica://Modelica.Blocks.Interfaces.DiscreteBlock\">DiscreteBlock</a>。
</p>
</html>"  ));
  end DiscreteSISO;

  partial block DiscreteMIMO 
    "多输入多输出离散控制模块"

    extends DiscreteBlock;
    parameter Integer nin = 1 "输入数";
    parameter Integer nout = 1 "输出数";

    Modelica.Blocks.Interfaces.RealInput u[nin] "实数输入信号接口" 
      annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
    Modelica.Blocks.Interfaces.RealOutput y[nout] "实际输出信号接口" 
      annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));

    annotation(Documentation(info = "<html>
<p>
离散模块有一个输入和一个输出信号矢量，它们根据定义的<strong>samplePeriod</strong>参数进行采样。
更多信息请参见基类<a href=\"modelica://Modelica.Blocks.Interfaces.DiscreteBlock\">DiscreteBlock</a>。
</p>
</html>"));
  end DiscreteMIMO;

  partial block DiscreteMIMOs 
    "多输入多输出离散控制模块"
    parameter Integer n = 1 "输入数(=输出数)";
    extends DiscreteBlock;

    Modelica.Blocks.Interfaces.RealInput u[n] "实数输入信号接口" 
      annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
    Modelica.Blocks.Interfaces.RealOutput y[n] "实数输出信号接口" 
      annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));

    annotation(Documentation(info = "<html>
<p>
有一个输入和一个输出信号矢量的模块，输入和输出矢量的信号大小相同。
这些信号根据定义的<strong>samplePeriod</strong>参数进行采样。
更多信息请参见基类<a href=\"modelica://Modelica.Blocks.Interfaces.DiscreteBlock\">DiscreteBlock</a>。
</p>
</html>"  ));

  end DiscreteMIMOs;

  partial block SVdiscrete "离散单变量控制器"
    extends DiscreteBlock;

    Discrete.Sampler sampler_s(final samplePeriod = samplePeriod, final startTime = 
      startTime) annotation(Placement(transformation(extent = {{-100, -10}, {-80, 
      10}})));
    Discrete.Sampler sampler_m(final samplePeriod = samplePeriod, final startTime = 
      startTime) annotation(Placement(transformation(
      origin = {0, -90}, 
      extent = {{-10, -10}, {10, 10}}, 
      rotation = 90)));
    Modelica.Blocks.Interfaces.RealInput u_s 
      "标量设定点输入信号" annotation(Placement(
      transformation(extent = {{-140, -20}, {-100, 20}})));
    Modelica.Blocks.Interfaces.RealInput u_m 
      "标量测量输入信号" annotation(Placement(
      transformation(
      origin = {0, -120}, 
      extent = {{20, -20}, {-20, 20}}, 
      rotation = 270)));
    Modelica.Blocks.Interfaces.RealOutput y 
      "标量执行器输出信号" annotation(Placement(
      transformation(extent = {{100, -10}, {120, 10}})));
  equation
    connect(u_s, sampler_s.u) annotation(Line(points = {{-120, 0}, {-102, 0}}));
    connect(u_m, sampler_m.u) 
      annotation(Line(points = {{0, -120}, {0, -111}, {0, -102}}));
    annotation(Documentation(info = "<html>
<p>
有两个实数输入信号和一个实数输出信号的模块，根据定义的<strong>samplePeriod</strong> parameter参数进行采样。
该模块可用作相应控制器的基类。
更多信息，请参阅基类<a href=\"modelica://Modelica.Blocks.Interfaces.DiscreteBlock\">DiscreteBlock</a>。
</p>
</html>"  ));
  end SVdiscrete;

  partial block MVdiscrete "离散多变量控制器"
    extends DiscreteBlock;
    parameter Integer nu_s = 1 "设定点输入数";
    parameter Integer nu_m = 1 "测量输入端数量";
    parameter Integer ny = 1 "执行器输出端数量";
    Discrete.Sampler sampler_s[nu_s](each final samplePeriod = samplePeriod, 
      each final startTime = startTime) annotation(Placement(transformation(
      extent = {{-90, -10}, {-70, 10}})));
    Discrete.Sampler sampler_m[nu_m](each final samplePeriod = samplePeriod, 
      each final startTime = startTime) annotation(Placement(transformation(
      origin = {0, -80}, 
      extent = {{-10, -10}, {10, 10}}, 
      rotation = 90)));
    Modelica.Blocks.Interfaces.RealInput u_s[nu_s] 
      "设定点输入信号" annotation(Placement(transformation(
      extent = {{-140, -20}, {-100, 20}})));
    Modelica.Blocks.Interfaces.RealInput u_m[nu_m] 
      "测量输入信号" annotation(Placement(
      transformation(
      origin = {0, -120}, 
      extent = {{20, -20}, {-20, 20}}, 
      rotation = 270)));
    Modelica.Blocks.Interfaces.RealOutput y[ny] 
      "执行器输出信号" annotation(Placement(transformation(
      extent = {{100, -10}, {120, 10}})));
  equation
    connect(u_s, sampler_s.u) annotation(Line(points = {{-120, 0}, {-92, 0}}));
    connect(u_m, sampler_m.u) 
      annotation(Line(points = {{0, -120}, {0, -106}, {0, -92}}));
    annotation(Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
      -100}, {100, 100}}), graphics = {Text(
      extent = {{-100, -10}, {-80, -30}}, 
      textString = "u_s", 
      textColor = {0, 0, 255})}), Documentation(info = "<html>
<p>
有两个实数输入信号矢量和一个实数输出信号矢量的模块。
矢量信号根据定义的<strong>samplePeriod</strong>参数进行采样。
该模块可用作相应控制器的基类。
更多信息，请参阅基类<a href=\"modelica://Modelica.Blocks.Interfaces.DiscreteBlock\">DiscreteBlock</a>。
</p>
</html>"  ));
  end MVdiscrete;

  partial block BooleanSISO 
    "带有布尔类型信号的单输入单输出控制模块"

    extends Modelica.Blocks.Icons.BooleanBlock;

  public
    BooleanInput u "布尔输入信号接口" annotation(Placement(
      transformation(extent = {{-140, -20}, {-100, 20}})));
    BooleanOutput y "布尔输出信号接口" annotation(Placement(
      transformation(extent = {{100, -10}, {120, 10}})));

    annotation(Documentation(info = "<html>
<p>
有一个连续布尔输入信号和一个连续布尔输出信号的模块。
</p>
</html>"  ));
  end BooleanSISO;

  partial block BooleanMIMOs 
    "具有相同数量的布尔类型输入和输出的多输入多输出连续控制模块"

    extends Modelica.Blocks.Icons.BooleanBlock;
    parameter Integer n = 1 "输入数(=输出数)";
    BooleanInput u[n] "布尔输入信号接口" annotation(
      Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
    BooleanOutput y[n] "布尔输出信号接口" annotation(
      Placement(transformation(extent = {{100, -10}, {120, 10}})));
    annotation(Documentation(info = "<html>
<p>
有一个连续的布尔输入和一个连续的布尔输出信号矢量的模块，其中输入和输出矢量的信号大小相同。
</p>
</html>"  ));
  end BooleanMIMOs;

  partial block MI2BooleanMOs 
    "信号长度相同的2个多路输入/布尔多路输出模块"

    extends Modelica.Blocks.Icons.BooleanBlock;
    parameter Integer n = 1 "输入和输出向量的维数";
    RealInput u1[n] "布尔输入信号接口1" annotation(
      Placement(transformation(extent = {{-140, 40}, {-100, 80}})));
    RealInput u2[n] "布尔输入信号接口2" annotation(
      Placement(transformation(extent = {{-140, -80}, {-100, -40}})));
    BooleanOutput y[n] "布尔输出信号接口" annotation(
      Placement(transformation(extent = {{100, -10}, {120, 10}})));
    annotation(Documentation(info = "<html>
<p>有两个布尔输入向量 u1 和 u2 以及一个布尔输出向量 y的模块。
所有向量的元素个数相同。</p>
</html>"  ));
  end MI2BooleanMOs;

  partial block SI2BooleanSO "2个单输入/布尔单输出模块"

    extends Modelica.Blocks.Icons.BooleanBlock;
    BooleanInput u1 "布尔输入信号接口1" annotation(
      Placement(transformation(extent = {{-140, 40}, {-100, 80}})));
    BooleanInput u2 "布尔输入信号接口2" annotation(
      Placement(transformation(extent = {{-140, -80}, {-100, -40}})));
    BooleanOutput y "布尔输出信号接口" annotation(
      Placement(transformation(extent = {{100, -10}, {120, 10}})));
    annotation(Documentation(info = "<html>
<p>
有两个布尔输入信号 u1 和 u2 以及一个布尔输出信号 y的模块。
</p>
</html>"  ));

  end SI2BooleanSO;

  partial block BooleanSignalSource "布尔信号源的基类"

    extends Modelica.Blocks.Icons.BooleanBlock;
    BooleanOutput y "布尔输出信号接口" annotation(Placement(
      transformation(extent = {{100, -10}, {120, 10}})));
    annotation(Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{-80, 68}, {-80, -80}}, color = {192, 192, 192}), 
      Polygon(
      points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-90, -70}, {68, -70}}, color = {192, 192, 192}), 
      Polygon(
      points = {{90, -70}, {68, -62}, {68, -78}, {90, -70}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid)}), Documentation(info = "<html>
<p>
属于 Blocks.Sources 软件包的布尔信号源基本模块。该组件有一个连续的布尔输出信号 y。
</p>
</html>"));

  end BooleanSignalSource;

  partial block IntegerSO "单整数输出连续控制模块"
    extends Modelica.Blocks.Icons.IntegerBlock;

    IntegerOutput y "整数输出信号接口" annotation(Placement(
      transformation(extent = {{100, -10}, {120, 10}})));
    annotation(Documentation(info = "<html>
<p>
有一个连续的整数输出信号的模块。
</p>
</html>"  ));
  end IntegerSO;

  partial block IntegerMO "多整数输出连续控制模块"
    extends Modelica.Blocks.Icons.IntegerBlock;

    parameter Integer nout(min = 1) = 1 "输出数";
    IntegerOutput y[nout] "整数输出信号接口" annotation(
      Placement(transformation(extent = {{100, -10}, {120, 10}})));
    annotation(Documentation(info = "<html>
<p>
有一个连续的整数输出信号矢量的模块。
</p>
</html>"  ));
  end IntegerMO;

  partial block IntegerSignalSource 
    "连续整数信号源的基类"
    extends IntegerSO;
    parameter Integer offset = 0 "输出信号y的偏移量";
    parameter SI.Time startTime = 0 "当time<startTime时，输出y=offset";
    annotation(Documentation(info="<html><p>
Blocks.Sources 软件包中整数信号源的基本模块。 该组件有一个连续整数输出信号 y 和两个参数（offset、startTime），用于移动生成的信号。 
</p>
</html>"));
  end IntegerSignalSource;

  partial block IntegerSIBooleanSO 
    "整数输入布尔输出连续控制模块"

    extends Modelica.Blocks.Icons.BooleanBlock;
    IntegerInput u "整数输入信号接口" annotation(Placement(
      transformation(extent = {{-140, -20}, {-100, 20}})));
    BooleanOutput y "布尔输出信号接口" annotation(Placement(
      transformation(extent = {{100, -10}, {120, 10}})));
    annotation(Documentation(info = "<html>
<p>
有一个连续的整数输入和一个连续的布尔输出信号的模块。</p>
</html>"  ));
  end IntegerSIBooleanSO;

  partial block IntegerMIBooleanMOs 
    "具有相同数量的整数输入和布尔输出的多输入多输出连续控制模块"

    extends Modelica.Blocks.Icons.BooleanBlock;
    parameter Integer n = 1 "输入数(=输出数)";
    IntegerInput u[n] "整数输入信号接口" annotation(
      Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
    BooleanOutput y[n] "C布尔输出信号接口" annotation(
      Placement(transformation(extent = {{100, -10}, {120, 10}})));
    annotation(Documentation(info = "<html>
<p>
有一个连续的整数输入和一个连续的布尔输出信号矢量，输入和输出矢量的信号大小相同的模块。
</p>
</html>"  ));
  end IntegerMIBooleanMOs;

  partial block PartialIntegerSISO 
    "带有整数输入和整数输出信号的部分模块"

    Modelica.Blocks.Interfaces.IntegerInput u "整数输入信号" 
      annotation(Placement(transformation(extent = {{-180, -40}, {-100, 40}})));
    Modelica.Blocks.Interfaces.IntegerOutput y "整数输出信号" 
      annotation(Placement(transformation(extent = {{100, -20}, {140, 20}})));
    annotation(Icon(coordinateSystem(
      preserveAspectRatio = false, 
      extent = {{-100, -100}, {100, 100}}, 
      initialScale = 0.06), graphics = {
      Text(
      extent = {{110, -50}, {250, -70}}, 
      textString = DynamicSelect(" ", String(
      y, 
      minimumLength = 1, 
      significantDigits = 0))), 
      Text(
      extent = {{-150, 150}, {150, 110}}, 
      textString = "%name", 
      textColor = {0, 0, 255}), 
      Rectangle(
      extent = {{-100, 100}, {100, -100}}, 
      fillColor = {255, 213, 170}, 
      fillPattern = FillPattern.Solid, 
      borderPattern = BorderPattern.Raised)}),Documentation(info="<html><p>
<br>
</p>
</html>"));
  end PartialIntegerSISO;

  partial block PartialIntegerMISO 
    "带有整数矢量输入和整数输出信号的基础模块"

    parameter Integer nu(min = 0) = 0 "输入接口数" 
      annotation(Dialog(connectorSizing = true), HideResult = true);
    Modelica.Blocks.Interfaces.IntegerVectorInput u[nu] 
      "整数输入信号向量" 
      annotation(Placement(transformation(extent = {{-120, 70}, {-80, -70}})));
    Modelica.Blocks.Interfaces.IntegerOutput y "整数输出信号" 
      annotation(Placement(transformation(extent = {{100, -15}, {130, 15}})));
    annotation(Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}, 
      initialScale = 0.06), graphics = {
      Text(
      extent = {{110, -50}, {250, -70}}, 
      textString = DynamicSelect(" ", String(
      y, 
      minimumLength = 1, 
      significantDigits = 0))), 
      Text(
      extent = {{-150, 150}, {150, 110}}, 
      textString = "%name", 
      textColor = {0, 0, 255}), 
      Rectangle(
      extent = {{-100, 100}, {100, -100}}, 
      lineColor = {255, 137, 0}, 
      fillColor = {255, 213, 170}, 
      borderPattern = BorderPattern.Raised, 
      fillPattern = FillPattern.Solid)}));
  end PartialIntegerMISO;

  partial block partialBooleanSISO 
    "带1个输入和1个输出布尔信号的基础模块"
    extends Modelica.Blocks.Icons.PartialBooleanBlock;
    Blocks.Interfaces.BooleanInput u "布尔输入信号接口" 
      annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
    Blocks.Interfaces.BooleanOutput y "布尔输出信号接口" 
      annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));

    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
      {100, 100}}), graphics = {Ellipse(
      extent = {{-71, 7}, {-85, -7}}, 
      lineColor = DynamicSelect({235, 235, 235}, if u then {0, 255, 0} else {235, 235, 235}), 
      fillColor = DynamicSelect({235, 235, 235}, if u then {0, 255, 0} else {235, 235, 235}), 
      fillPattern = FillPattern.Solid), Ellipse(
      extent = {{71, 7}, {85, -7}}, 
      lineColor = DynamicSelect({235, 235, 235}, if y then {0, 255, 0} else {235, 235, 235}), 
      fillColor = DynamicSelect({235, 235, 235}, if y then {0, 255, 0} else {235, 235, 235}), 
      fillPattern = FillPattern.Solid)}), Documentation(info = "<html>
<p>
有一个连续的布尔输入信号和一个连续的布尔输出信号的模块，
并带有三维图标（如在 Blocks.Logical 库中使用）。
</p>
</html>"    ));

  end partialBooleanSISO;

  partial block partialBooleanSI2SO 
    "带有2个输入和1个输出布尔信号的基础模块"
    extends Modelica.Blocks.Icons.PartialBooleanBlock;
    Blocks.Interfaces.BooleanInput u1 "第一个布尔输入信号接口" 
      annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
    Blocks.Interfaces.BooleanInput u2 
      "第二个布尔输入信号接口" annotation(Placement(
      transformation(extent = {{-140, -100}, {-100, -60}})));
    Blocks.Interfaces.BooleanOutput y "布尔输出信号接口" 
      annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));

    annotation(Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Ellipse(
      extent = {{-71, 7}, {-85, -7}}, 
      lineColor = DynamicSelect({235, 235, 235}, if u1 then {0, 255, 0} else {235, 235, 235}), 
      fillColor = DynamicSelect({235, 235, 235}, if u1 then {0, 255, 0} else {235, 235, 235}), 
      fillPattern = FillPattern.Solid), 
      Ellipse(
      extent = {{-71, -74}, {-85, -88}}, 
      lineColor = DynamicSelect({235, 235, 235}, if u2 then {0, 255, 0} else {235, 235, 235}), 
      fillColor = DynamicSelect({235, 235, 235}, if u2 then {0, 255, 0} else {235, 235, 235}), 
      fillPattern = FillPattern.Solid), 
      Ellipse(
      extent = {{71, 7}, {85, -7}}, 
      lineColor = DynamicSelect({235, 235, 235}, if y then {0, 255, 0} else {235, 235, 235}), 
      fillColor = DynamicSelect({235, 235, 235}, if y then {0, 255, 0} else {235, 235, 235}), 
      fillPattern = FillPattern.Solid)}), Documentation(info = "<html>
<p>
有两个连续的布尔输入信号和一个连续的布尔输出信号的模块，
并带有三维图标（如在 Blocks.Logical 库中使用）。
</p>
</html>"    ));

  end partialBooleanSI2SO;

  partial block partialBooleanSI3SO 
    "带有3个输入和1个输出布尔信号的基础模块"
    extends Modelica.Blocks.Icons.PartialBooleanBlock;
    Blocks.Interfaces.BooleanInput u1 "第一个布尔输入信号接口" 
      annotation(Placement(transformation(extent = {{-140, 60}, {-100, 100}})));
    Blocks.Interfaces.BooleanInput u2 
      "第二个布尔输入信号接口" annotation(Placement(
      transformation(extent = {{-140, -20}, {-100, 20}})));
    Blocks.Interfaces.BooleanInput u3 "第三个布尔输入信号接口" 
      annotation(Placement(transformation(extent = {{-140, -100}, {-100, -60}})));
    Blocks.Interfaces.BooleanOutput y "布尔输出信号接口" 
      annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));

    annotation(Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Ellipse(
      extent = {{-71, 74}, {-85, 88}}, 
      lineColor = DynamicSelect({235, 235, 235}, if u1 then {0, 255, 0} else {235, 235, 235}), 
      fillColor = DynamicSelect({235, 235, 235}, if u1 then {0, 255, 0} else {235, 235, 235}), 
      fillPattern = FillPattern.Solid), 
      Ellipse(
      extent = {{-71, 7}, {-85, -7}}, 
      lineColor = DynamicSelect({235, 235, 235}, if u2 then {0, 255, 0} else {235, 235, 235}), 
      fillColor = DynamicSelect({235, 235, 235}, if u2 then {0, 255, 0} else {235, 235, 235}), 
      fillPattern = FillPattern.Solid), 
      Ellipse(
      extent = {{-71, -74}, {-85, -88}}, 
      lineColor = DynamicSelect({235, 235, 235}, if u3 then {0, 255, 0} else {235, 235, 235}), 
      fillColor = DynamicSelect({235, 235, 235}, if u3 then {0, 255, 0} else {235, 235, 235}), 
      fillPattern = FillPattern.Solid), 
      Ellipse(
      extent = {{71, 7}, {85, -7}}, 
      lineColor = DynamicSelect({235, 235, 235}, if y then {0, 255, 0} else {235, 235, 235}), 
      fillColor = DynamicSelect({235, 235, 235}, if y then {0, 255, 0} else {235, 235, 235}), 
      fillPattern = FillPattern.Solid)}), Documentation(info = "<html><p>
有三个连续的布尔输入信号和一个连续的布尔输出信号的模块，
并带有三维图标（如在 Blocks.Logical 库中使用）。
</p>
</html>"    ));

  end partialBooleanSI3SO;

  partial block partialBooleanSI "带1个输入布尔信号的基础模块"
    extends Modelica.Blocks.Icons.PartialBooleanBlock;

    Blocks.Interfaces.BooleanInput u "布尔输入信号接口" 
      annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));

    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
      {100, 100}}), graphics = {Ellipse(
      extent = {{-71, 7}, {-85, -7}}, 
      lineColor = DynamicSelect({235, 235, 235}, if u then {0, 255, 0} else {235, 235, 235}), 
      fillColor = DynamicSelect({235, 235, 235}, if u then {0, 255, 0} else {235, 235, 235}), 
      fillPattern = FillPattern.Solid)}), Documentation(info = "<html>
<p>
有一个带有 3D 图标的连续布尔输入信号的模块（如在 Blocks.Logical 库中使用）。
</p>
</html>"    ));

  end partialBooleanSI;

  partial block partialBooleanSO "带1个布尔信号输出的基础模块"

    Blocks.Interfaces.BooleanOutput y "布尔输出信号接口" 
      annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));
    extends Modelica.Blocks.Icons.PartialBooleanBlock;

    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
      {100, 100}}), graphics = {Ellipse(
      extent = {{71, 7}, {85, -7}}, 
      lineColor = DynamicSelect({235, 235, 235}, if y then {0, 255, 0} else {235, 235, 235}), 
      fillColor = DynamicSelect({235, 235, 235}, if y then {0, 255, 0} else {235, 235, 235}), 
      fillPattern = FillPattern.Solid)}), Documentation(info = "<html>
<p>
有一个带 3D 图标的连续布尔输出信号的模块（如在 Blocks.Logical 库中使用）。
</p>
</html>"    ));

  end partialBooleanSO;

  partial block partialBooleanSource 
    "基础源模块(有1个输出布尔信号和一个适当的默认图标)"
    extends Modelica.Blocks.Icons.PartialBooleanBlock;

    Blocks.Interfaces.BooleanOutput y "布尔输出信号接口" 
      annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));

    annotation(
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Polygon(
      points = {{-80, 88}, {-88, 66}, {-72, 66}, {-80, 88}}, 
      lineColor = {255, 0, 255}, 
      fillColor = {255, 0, 255}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-80, 66}, {-80, -82}}, color = {255, 0, 255}), 
      Line(points = {{-90, -70}, {72, -70}}, color = {255, 0, 255}), 
      Polygon(
      points = {{90, -70}, {68, -62}, {68, -78}, {90, -70}}, 
      lineColor = {255, 0, 255}, 
      fillColor = {255, 0, 255}, 
      fillPattern = FillPattern.Solid), 
      Ellipse(
      extent = {{71, 7}, {85, -7}}, 
      lineColor = DynamicSelect({235, 235, 235}, if y then {0, 255, 0} else {235, 235, 235}), 
      fillColor = DynamicSelect({235, 235, 235}, if y then {0, 255, 0} else {235, 235, 235}), 
      fillPattern = FillPattern.Solid)}), 
      Documentation(info = "<html>
<p>
Blocks.Sources 软件包中布尔信号源的基本模块。
该组件有一个连续的布尔输出信号 y 和一个 3D 图标（如在 Blocks.Logical 库中使用）。
</p>
</html>"  ));

  end partialBooleanSource;

  partial block partialBooleanThresholdComparison 
    "基础模块用于将实数输入u与阈值进行比较，并将结果作为1个布尔输出信号"

    parameter Real threshold = 0 "与阈值的比较";

    Blocks.Interfaces.RealInput u "实数输入信号接口" 
      annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
    Blocks.Interfaces.BooleanOutput y "布尔输出信号接口" 
      annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));

    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
      {100, 100}}), graphics = {
      Rectangle(
      extent = {{-100, 100}, {100, -100}}, 
      fillColor = {210, 210, 210}, 
      fillPattern = FillPattern.Solid, 
      borderPattern = BorderPattern.Raised), 
      Text(
      extent = {{-150, -140}, {150, -110}}, 
      textString = "%threshold"), 
      Ellipse(
      extent = {{71, 7}, {85, -7}}, 
      lineColor = DynamicSelect({235, 235, 235}, if y then {0, 255, 0} else {235, 235, 235}), 
      fillColor = DynamicSelect({235, 235, 235}, if y then {0, 255, 0} else {235, 235, 235}), 
      fillPattern = FillPattern.Solid), Text(
      extent = {{-150, 150}, {150, 110}}, 
      textString = "%name", 
      textColor = {0, 0, 255})}), Documentation(info = "<html>
<p>
有一个连续的实数输入信号和一个连续的布尔输出信号的模块，以及一个三维图标（如在 Blocks.Logical 库中使用）。
</p>
</html>"    ));

  end partialBooleanThresholdComparison;

  partial block partialBooleanComparison 
    "具有2个实数输入和1个布尔输出信号(两个实数输入的比较结果)的基础模块"

    Blocks.Interfaces.RealInput u1 "第一个实数输入信号接口" 
      annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
    Blocks.Interfaces.RealInput u2 "第二个实数输入信号接口" 
      annotation(Placement(transformation(extent = {{-140, -100}, {-100, -60}})));
    Blocks.Interfaces.BooleanOutput y "布尔输出信号接口" 
      annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));

    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
      {100, 100}}), graphics = {
      Rectangle(
      extent = {{-100, 100}, {100, -100}}, 
      fillColor = {210, 210, 210}, 
      fillPattern = FillPattern.Solid, 
      borderPattern = BorderPattern.Raised), 
      Ellipse(
      extent = {{73, 7}, {87, -7}}, 
      lineColor = DynamicSelect({235, 235, 235}, if y then {0, 255, 0} else {235, 235, 235}), 
      fillColor = DynamicSelect({235, 235, 235}, if y then {0, 255, 0} else {235, 235, 235}), 
      fillPattern = FillPattern.Solid), 
      Ellipse(extent = {{32, 10}, {52, -10}}, lineColor = {0, 0, 127}), 
      Line(points = {{-100, -80}, {42, -80}, {42, 0}}, color = {0, 0, 127}), 
      Text(
      extent = {{-150, 150}, {150, 110}}, 
      textString = "%name", 
      textColor = {0, 0, 255})}), 
      Documentation(info="<html><p>
有两个连续的实数输入信号和一个连续的布尔输出信号的模块，输出信号是两个输入信号的比较结果。 模块有一个 3D 图标（如在 Blocks.Logical 库中使用）。
</p>
</html>"    ));

  end partialBooleanComparison;
  partial block partialIntegerBooleanComparison 
    "具有2个实数输入和1个布尔输出信号(两个实数输入的比较结果)的基础模块"

    IntegerInput u1 "第一个实数输入信号接口" 
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    IntegerInput u2 "第二个实数输入信号接口" 
      annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
    BooleanOutput y "布尔输出信号接口" 
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));

    annotation (Icon(coordinateSystem(extent={{-100,-100},{100,100}}, 
  preserveAspectRatio=true, 
  grid={2,2}),graphics = {Rectangle(origin={0,0}, 
  fillColor={210,210,210}, 
  fillPattern=FillPattern.Solid, 
  borderPattern=BorderPattern.Raised, 
  extent={{-100,100},{100,-100}}), Ellipse(origin={80,0}, 
  lineColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}), 
  fillColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}), 
  fillPattern=FillPattern.Solid, 
  extent={{-7,7},{7,-7}}), Ellipse(origin={42,0}, 
  lineColor={255,127,0}, 
  extent={{-10,10},{10,-10}}), Line(origin={-29,-40}, 
  points={{-71,-40},{71,-40},{71,40}}, 
  color={255,127,0}), Text(origin={0,130}, 
  lineColor={0,0,255}, 
  extent={{-150,20},{150,-20}}, 
  textString="%name", 
  textColor={0,0,255})}), 
        Documentation(info="<html><p>
有两个连续的整型输入信号和一个连续的布尔输出信号的模块，输出信号是两个输入信号的比较结果。 模块有一个 3D 图标（如在 Blocks.Logical 库中使用）。
</p>
</html>"    ));

  end partialIntegerBooleanComparison;

  partial block PartialBooleanSISO_small 
    "具有布尔输入和布尔输出信号以及小型块图标的基础模块"

    Modelica.Blocks.Interfaces.BooleanInput u "布尔输入信号" 
      annotation(Placement(transformation(extent = {{-180, -40}, {-100, 40}})));
    Modelica.Blocks.Interfaces.BooleanOutput y "布尔输出信号" 
      annotation(Placement(transformation(extent = {{100, -20}, {140, 20}})));
    annotation(Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}, 
      initialScale = 0.04), graphics = {
      Text(
      extent = {{-300, 200}, {300, 120}}, 
      textString = "%name", 
      textColor = {0, 0, 255}), 
      Rectangle(
      extent = {{-100, 100}, {100, -100}}, 
      fillColor = {215, 215, 215}, 
      fillPattern = FillPattern.Solid, 
      borderPattern = BorderPattern.Raised), 
      Ellipse(
      extent = {{60, 10}, {80, -10}}, 
      lineColor = DynamicSelect({235, 235, 235}, if y then {0, 255, 0} else {235, 235, 235}), 
      fillColor = DynamicSelect({235, 235, 235}, if y then {0, 255, 0} else {235, 235, 235}), 
      fillPattern = FillPattern.Solid)}));
  end PartialBooleanSISO_small;

  partial block PartialBooleanMISO 
    "带有布尔矢量输入和布尔输出信号的基础模块"

    parameter Integer nu(min = 0) = 0 "输入接口数" 
      annotation(Dialog(connectorSizing = true), HideResult = true);
    Modelica.Blocks.Interfaces.BooleanVectorInput u[nu] 
      "布尔输入信号向量" 
      annotation(Placement(transformation(extent = {{-120, 70}, {-80, -70}})));
    Modelica.Blocks.Interfaces.BooleanOutput y "布尔输出信号" 
      annotation(Placement(transformation(extent = {{100, -15}, {130, 15}})));
    annotation(Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}, 
      initialScale = 0.06), graphics = {
      Text(
      extent = {{-250, 170}, {250, 110}}, 
      textString = "%name", 
      textColor = {0, 0, 255}), 
      Rectangle(
      extent = {{-100, 100}, {100, -100}}, 
      fillColor = {215, 215, 215}, 
      fillPattern = FillPattern.Solid, 
      borderPattern = BorderPattern.Raised), 
      Ellipse(
      extent = {{60, 10}, {80, -10}}, 
      lineColor = DynamicSelect({235, 235, 235}, if y then {0, 255, 0} else {235, 235, 235}), 
      fillColor = DynamicSelect({235, 235, 235}, if y then {0, 255, 0} else {235, 235, 235}), 
      fillPattern = FillPattern.Solid)}));
  end PartialBooleanMISO;

  partial block PartialConversionBlock 
    "定义转换模块接口的基础模块"

    RealInput u "待转换实数输入信号的接口" annotation(
      Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
    RealOutput y 
      "包含另一设备输入信号u的实数输出信号接口" 
      annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));
    annotation(
      Icon(
      coordinateSystem(preserveAspectRatio = true, 
      extent = {{-100.0, -100.0}, {100.0, 100.0}}), 
      graphics = {
      Rectangle(
      lineColor = {0, 0, 127}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid, 
      extent = {{-100.0, -100.0}, {100.0, 100.0}}), 
      Line(
      points = {{-90.0, 0.0}, {30.0, 0.0}}, 
      color = {191, 0, 0}), 
      Polygon(
      lineColor = {191, 0, 0}, 
      fillColor = {191, 0, 0}, 
      fillPattern = FillPattern.Solid, 
      points = {{90.0, 0.0}, {30.0, 20.0}, {30.0, -20.0}, {90.0, 0.0}}), 
      Text(
      textColor = {0, 0, 255}, 
      extent = {{-150, 110}, {150, 150}}, 
      textString = "%name")}), Documentation(info = "<html>
<p>
该模块定义了转换程序块的接口，可将一个单位转换成另一个单位。
</p>

</html>"  ));

  end PartialConversionBlock;

  partial block PartialNoise "基础噪音发生器"
    import generator = Modelica.Math.Random.Generators.Xorshift128plus;
    import Modelica.Math.Random.Utilities.automaticLocalSeed;
    extends Modelica.Blocks.Interfaces.SO;

    // 主对话框菜单
    parameter SI.Period samplePeriod(start = 0.01) 
      "原始随机数的取样周期" 
      annotation(Dialog(enable = enableNoise));

    // 高级对话菜单：噪音生成
    parameter Boolean enableNoise = globalSeed.enableNoise 
      "=true：y=noise，否则y=y_off" 
      annotation(choices(checkBox = true), Dialog(tab = "高级", group = "噪音产生"));
    parameter Real y_off = 0.0 
      "设置y=y_off如果enableNoise=false(或time<startTime，见下文)" 
      annotation(Dialog(tab = "高级", group = "噪音产生"));

    // 高级对话菜单：初始化
    parameter Boolean useGlobalSeed = true 
      "=true：使用全局变量表，否则忽略" 
      annotation(choices(checkBox = true), Dialog(tab = "高级", group = "初始化", enable = enableNoise));
    parameter Boolean useAutomaticLocalSeed = true 
      "=true：使用自动本地表，否则使用固定本地表" 
      annotation(choices(checkBox = true), Dialog(tab = "高级", group = "初始化", enable = enableNoise));
    parameter Integer fixedLocalSeed = 1 "本地表(任意整数)" 
      annotation(Dialog(tab = "高级", group = "初始化", enable = enableNoise and not useAutomaticLocalSeed));
    parameter SI.Time startTime = 0.0 
      "原始随机数采样的开始时间" 
      annotation(Dialog(tab = "高级", group = "初始化", enable = enableNoise));
    final parameter Integer localSeed(fixed = false) "实际的localSeed";
  protected
    outer Modelica.Blocks.Noise.GlobalSeed globalSeed 
      "通过内部/外部定义全局表";
    parameter Integer actualGlobalSeed = if useGlobalSeed then globalSeed.seed else 0 
      "全局表，实际使用的是";
    parameter Boolean generateNoise = enableNoise and globalSeed.enableNoise 
      "=true，如果产生噪音，否则不产生噪音";

    // 声明状态变量和随机数变量
    Integer state[generator.nState] "随机数发生器的内部状态";
    discrete Real r "根据所需的分布随机数";
    discrete Real r_raw "(0,1]范围内的均匀随机数";

  initial equation
    localSeed = if useAutomaticLocalSeed then automaticLocalSeed(getInstanceName()) else fixedLocalSeed;
    pre(state) = generator.initialState(localSeed, actualGlobalSeed);
    r_raw = generator.random(pre(state));

  equation
    // 在抽样时间随机抽取号码
    when generateNoise and sample(startTime, samplePeriod) then
      (r_raw,state) = generator.random(pre(state));
    end when;

    // 根据要求产生噪音
    y = if not generateNoise or time < startTime then y_off else r;

    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, 
      {100, 100}}), graphics = {
      Polygon(
      points = {{-76, 90}, {-84, 68}, {-68, 68}, {-76, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-76, 68}, {-76, -80}}, color = {192, 192, 192}), 
      Line(points = {{-86, -14}, {72, -14}}, 
      color = {192, 192, 192}), 
      Polygon(
      points = {{94, -14}, {72, -6}, {72, -22}, {94, -14}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(visible = enableNoise, 
      points = {{-76, -19}, {-62, -19}, {-62, -3}, {-54, -3}, {-54, -51}, {-46, -51}, {-46, 
      -29}, {-38, -29}, {-38, 55}, {-30, 55}, {-30, 23}, {-30, 23}, {-30, -37}, {-20, 
      -37}, {-20, -19}, {-10, -19}, {-10, -47}, {0, -47}, {0, 35}, {6, 35}, {6, 49}, {12, 
      49}, {12, -7}, {22, -7}, {22, 5}, {28, 5}, {28, -25}, {38, -25}, {38, 47}, {48, 47}, 
      {48, 13}, {56, 13}, {56, -53}, {66, -53}}), 
      Text(
      extent = {{-150, -110}, {150, -150}}, 
      textString = "%samplePeriod s"), 
      Line(visible = not enableNoise, 
      points = {{-76, 48}, {72, 48}}), 
      Text(visible = not enableNoise, 
      extent = {{-75, 42}, {95, 2}}, 
      textString = "%y_off"), 
      Text(visible = enableNoise and not useAutomaticLocalSeed, 
      extent = {{-92, 20}, {98, -22}}, 
      textColor = {238, 46, 47}, 
      textString = "%fixedLocalSeed")}), 
      Documentation(info = "<html>
<p>
噪声发生器的部分基类，定义了噪声模块的共同特征。
</p>
</html>"    , revisions = "<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
   <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
   Initial version implemented by
   A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
   <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"    ));
  end PartialNoise;

  package Adaptors "适配器包(特别适用于FMU)"
    extends Modelica.Icons.InterfacesPackage;

    partial model FlowToPotentialAdaptor "信号适配器，用于一个具有流量、流量的一阶导数和流量的二阶导数作为输入，以及电势、电势的一阶导数和电势的二阶导数作为输出的连接器（特别适用于FMU）"
      parameter Boolean use_pder = true "使用电势的一阶导数的输出" 
        annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
      parameter Boolean use_pder2 = true "仅在使用一阶导数的情况下，使用电势的二阶导数输出" 
        annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
      parameter Boolean use_fder = true "使用输入值计算流量的一阶导数" 
        annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
      parameter Boolean use_fder2 = true "仅在使用一阶导数的情况下，使用输入值计算流量的二阶导数" 
        annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
      Modelica.Blocks.Interfaces.RealOutput p "电势的输出" 
        annotation(Placement(transformation(extent = {{20, 70}, {40, 90}})));
      Modelica.Blocks.Interfaces.RealOutput pder if use_pder 
        "可选输出der1(potential)" 
        annotation(Placement(transformation(extent = {{20, 40}, {40, 60}})));
      Modelica.Blocks.Interfaces.RealOutput pder2 if (use_pder and use_pder2) 
        "可选输出der2(potential)" 
        annotation(Placement(transformation(extent = {{20, 10}, {40, 30}})));
      Modelica.Blocks.Interfaces.RealInput f "流量输入" 
        annotation(Placement(transformation(extent = {{40, -90}, {20, -70}})));
      Modelica.Blocks.Interfaces.RealInput fder if use_fder 
        "可选输入der(flow)" 
        annotation(Placement(transformation(extent = {{40, -60}, {20, -40}})));
      Modelica.Blocks.Interfaces.RealInput fder2 if (use_fder and use_fder2) 
        "可选输入der2(flow)" 
        annotation(Placement(transformation(extent = {{40, -30}, {20, -10}})));
    protected
      parameter String Name_p = "p" "电势变量的名称";
      parameter String Name_pder = "der(p)" "电势变量的一阶导数名称";
      parameter String Name_pder2 = "der2(p)" "电势变量的二阶导数名称";
      parameter String Name_f = "f" "流量变量名称";
      parameter String Name_fder = "der(f)" "流量一阶导数变量的名称";
      parameter String Name_fder2 = "der2(f)" "流量二阶导数变量的名称";
      Real y "输出信号" annotation(HideResult = true);
      Modelica.Blocks.Interfaces.RealOutput y1 "输出可选一阶导数" annotation(HideResult = true);
      Modelica.Blocks.Interfaces.RealOutput y2 "输出可选二阶导数" annotation(HideResult = true);
      Real u "输入信号" annotation(HideResult = true);
      Modelica.Blocks.Interfaces.RealInput u1 "输入可选一阶导数" annotation(HideResult = true);
      Modelica.Blocks.Interfaces.RealInput u2 "输入可选二阶导数" annotation(HideResult = true);
    equation
      y = p;
      y1 = if use_pder then der(y) else 0;
      y2 = if (use_pder and use_pder2) then der(y1) else 0;
      connect(y1, pder);
      connect(y2, pder2);
      if use_fder then
        connect(fder, u1);
      else
        u1 = 0;
      end if;
      if (use_fder and use_fder2) then
        connect(fder2, u2);
      else
        u2 = 0;
      end if;
      if (use_fder and use_fder2) then
        u = Functions.state2({f, u1, u2}, time);
      elseif (use_fder and not use_fder2) then
        u = Functions.state1({f, u1}, time);
      else
        u = f;
      end if;
      annotation(Icon(coordinateSystem(preserveAspectRatio = false), graphics = {
        Text(
        extent = {{-150, 150}, {150, 110}}, 
        textColor = {0, 0, 255}, 
        textString = "%name"), 
        Rectangle(
        extent = {{-20, 100}, {20, -100}}, 
        lineColor = {0, 0, 127}, 
        radius = 10), 
        Text(
        extent = {{-18, 90}, {18, 70}}, 
        textString = "%Name_p"), 
        Text(
        extent = {{-18, 60}, {18, 40}}, 
        textString = "%Name_pder", 
        visible = use_pder), 
        Text(
        extent = {{-18, 30}, {18, 10}}, 
        textString = "%Name_pder2", 
        visible = (use_pder and use_pder2)), 
        Text(
        extent = {{-18, -70}, {18, -90}}, 
        textString = "%Name_f"), 
        Text(
        extent = {{-18, -40}, {18, -60}}, 
        textString = "%Name_fder", 
        visible = use_fder), 
        Text(
        extent = {{-18, -10}, {18, -30}}, 
        textString = "%Name_fder2", 
        visible = (use_fder and use_fder2))}), 
        Diagram(coordinateSystem(preserveAspectRatio = false)), 
        Documentation(info="<html><p>
<span style=\"color: rgb(51, 51, 51);\">物理连接器与连接器信号的信号表示之间的适配器。该组件用于为物理模型提供纯信号接口，并将该模型以输入/输出块的形式导出，特别是作为FMU。</span>（<a href=\"https://fmi-standard.org\" target=\"\">Functional Mock-up Unit</a>&nbsp; &nbsp;）。
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">该适配器具有流量、可选的流量一阶导数和可选的流量二阶导数作为输入信号，以及电势、可选的电势一阶导数和可选的电势二阶导数作为输出信号。</span>
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">注意，输入信号必须彼此一致（fder = der(f)，fder2 = der(fder)）。</span>
</p>
</html>"      ));
    end FlowToPotentialAdaptor;

    partial model PotentialToFlowAdaptor "信号适配器，用于一个具有电势、电势的一阶导数和电势的二阶导数作为输入，以及流量、流量的一阶导数和流量的二阶导数作为输出的连接器（特别适用于FMU）。"
      parameter Boolean use_pder = true "使用输入值计算电势的一阶导数" 
        annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
      parameter Boolean use_pder2 = true "仅在使用一阶导数的情况下，使用输入值计算电势的二阶导数" 
        annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
      parameter Boolean use_fder = true "使用输出值计算流量的一阶导数" 
        annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
      parameter Boolean use_fder2 = true "仅在使用一阶导数的情况下，使用输出值计算流量的二阶导数" 
        annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
      Modelica.Blocks.Interfaces.RealInput p "电势的输入" 
        annotation(Placement(transformation(extent = {{-40, 70}, {-20, 90}})));
      Modelica.Blocks.Interfaces.RealInput pder if use_pder 
        "可选输入der1(potential)" 
        annotation(Placement(transformation(extent = {{-40, 40}, {-20, 60}})));
      Modelica.Blocks.Interfaces.RealInput pder2 if (use_pder and use_pder2) 
        "可选输入der2(potential)" 
        annotation(Placement(transformation(extent = {{-40, 10}, {-20, 30}})));
      Modelica.Blocks.Interfaces.RealOutput f "流量输出" 
        annotation(Placement(transformation(extent = {{-20, -90}, {-40, -70}})));
      Modelica.Blocks.Interfaces.RealOutput fder if use_fder 
        "可选输出der(flow)" 
        annotation(Placement(transformation(extent = {{-20, -60}, {-40, -40}})));
      Modelica.Blocks.Interfaces.RealOutput fder2 if (use_fder and use_fder2) 
        "可选输出der2(flow)" 
        annotation(Placement(transformation(extent = {{-20, -30}, {-40, -10}})));
    protected
      parameter String Name_p = "p" "电势变量的名称";
      parameter String Name_pder = "der(p)" "电势变量的一阶导数名称";
      parameter String Name_pder2 = "der2(p)" "电势变量的二阶导数名称";
      parameter String Name_f = "f" "流量变量名称";
      parameter String Name_fder = "der(f)" "流量一阶导数变量的名称";
      parameter String Name_fder2 = "der2(f)" "流量二阶导数变量的名称";
      Real y "输出信号" annotation(HideResult = true);
      Modelica.Blocks.Interfaces.RealOutput y1 "输出可选一阶导数" annotation(HideResult = true);
      Modelica.Blocks.Interfaces.RealOutput y2 "输出可选二阶导数" annotation(HideResult = true);
      Real u "输入信号" annotation(HideResult = true);
      Modelica.Blocks.Interfaces.RealInput u1 "输入可选一阶导数" annotation(HideResult = true);
      Modelica.Blocks.Interfaces.RealInput u2 "输入可选二阶导数" annotation(HideResult = true);
    equation
      y = -f;
      y1 = if use_fder then -der(y) else 0;
      y2 = if (use_fder and use_fder2) then -der(y1) else 0;
      connect(y1, fder);
      connect(y2, fder2);
      if use_pder then
        connect(pder, u1);
      else
        u1 = 0;
      end if;
      if (use_pder and use_pder2) then
        connect(pder2, u2);
      else
        u2 = 0;
      end if;
      if (use_pder and use_pder2) then
        u = Functions.state2({p, u1, u2}, time);
      elseif (use_pder and not use_pder2) then
        u = Functions.state1({p, u1}, time);
      else
        u = p;
      end if;
      annotation(Icon(coordinateSystem(preserveAspectRatio = false), graphics = {
        Text(
        extent = {{-150, 150}, {150, 110}}, 
        textColor = {0, 0, 255}, 
        textString = "%name"), 
        Rectangle(
        extent = {{-20, 100}, {20, -100}}, 
        lineColor = {0, 0, 127}, 
        radius = 10), 
        Text(
        extent = {{-18, 90}, {18, 70}}, 
        textString = "%Name_p"), 
        Text(
        extent = {{-18, 60}, {18, 40}}, 
        textString = "%Name_pder", 
        visible = use_pder), 
        Text(
        extent = {{-18, 30}, {18, 10}}, 
        textString = "%Name_pder2", 
        visible = (use_pder and use_pder2)), 
        Text(
        extent = {{-18, -70}, {18, -90}}, 
        textString = "%Name_f"), 
        Text(
        extent = {{-18, -40}, {18, -60}}, 
        textString = "%Name_fder", 
        visible = use_fder), 
        Text(
        extent = {{-18, -10}, {18, -30}}, 
        textString = "%Name_fder2", 
        visible = (use_fder and use_fder2))}), 
        Diagram(coordinateSystem(preserveAspectRatio = false)), 
        Documentation(info = "<html><p>
<span style=\"color: rgb(51, 51, 51);\">物理连接器与连接器信号的信号表示之间的适配器。该组件用于为物理模型提供纯信号接口，并将该模型以输入/输出块的形式导出，特别是作为FMU</span>（<a href=\"https://fmi-standard.org\" target=\"\">Functional Mock-up Unit</a>&nbsp; ）。
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">该适配器具有电势、电势的一阶导数和电势的二阶导数作为输入信号，以及流量、流量的一阶导数和流量的二阶导数作为输出信号。</span>
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">注意，输入信号必须彼此一致（pder = der(p)，pder2 = der(pder)）。</span>
</p>
</html>"    ));
    end PotentialToFlowAdaptor;

    package Functions "适配器的功能"
      extends Modelica.Icons.FunctionsPackage;

      function state1 "返回状态(带一次导数)"
        extends Modelica.Icons.Function;
        input Real u[2] "状态和其导数的必要值";
        input Real dummy 
          "只需有一个输入信号，该信号应进行微分，以避免在Modelica工具中可能出现的问题(如果未使用)";
        output Real s;
      algorithm
        s := u[1];
        annotation(derivative(noDerivative = u) = state1der1, 
          InlineAfterIndexReduction = true);
      end state1;

      function state1der1 "返回第一阶导数(state1的der)"
        extends Modelica.Icons.Function;
        input Real u[2] "状态和其导数所需值";
        input Real dummy 
          "只需有一个输入信号，应该对其进行微分，以避免在Modelica工具中可能出现的问题(未使用)";
        input Real dummy_der;
        output Real sder1;
      algorithm
        sder1 := u[2];
        annotation(InlineAfterIndexReduction = true);
      end state1der1;

      function state2 "返回状态(带有两个导数)"
        extends Modelica.Icons.Function;
        input Real u[3] "状态和其导数所需值";
        input Real dummy 
          "只需有一个输入信号，应该对其进行微分，以避免在Modelica工具中可能出现的问题(未使用)";
        output Real s;
      algorithm
        s := u[1];
        annotation(derivative(noDerivative = u) = state2der1, 
          InlineAfterIndexReduction = true);
      end state2;

      function state2der1 "返回第一阶导数(state2的der)"
        extends Modelica.Icons.Function;
        input Real u[3] "状态和其导数所需值";
        input Real dummy 
          "只需有一个输入信号，应该对其进行微分，以避免在Modelica工具中可能出现的问题(未使用)";
        input Real dummy_der;
        output Real sder1;
      algorithm
        sder1 := u[2];
        annotation(derivative(noDerivative = u, order = 2) = state2der2, 
          InlineAfterIndexReduction = true);
      end state2der1;

      function state2der2 "返回第二阶导数(state2der1的der)"
        extends Modelica.Icons.Function;
        input Real u[3] "状态和其导数所需值";
        input Real dummy 
          "只需有一个输入信号，应该对其进行微分，以避免在Modelica工具中可能出现的问题(未使用)";
        input Real dummy_der;
        input Real dummy_der2;
        output Real sder2;
      algorithm
        sder2 := u[3];
        annotation(InlineAfterIndexReduction = true);
      end state2der2;
      annotation();
    end Functions;

    annotation(Documentation(info = "<html>
<p>
该软件包包含部分适配器，用于在物理连接器和连接器信号的信号表示之间的各种域中实现适配器。
该组件用于为物理模型提供纯信号接口，并以输入/输出块的形式输出该模型，
特别是作为 FMU（<a href=\"https://fmi-standard.org\">Functional Mock-up Unit</a>）。
</p>
</html>"      ));
  end Adaptors;

annotation (Documentation(info="<html><p>
该软件包包含用于<strong>连续</strong>输入/输出模块的接口定义，支持实数、整数和布尔信号。此外，它还包含连续和离散模块的部分模型。
</p>
</html>",revisions="<html>
<ul>
<li><em>2019年6月28日</em>
       作者: Thomas Beutlich:<br>
       移除了过时的块。</li>
<li><em>2002年10月21日</em>
       作者: <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       和 Christian Schweiger:<br>
       添加了多个新接口。</li>
<li><em>1999年10月24日</em>
       作者: <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       RealInputSignal 改名为 RealInput。RealOutputSignal 改名为
       output RealOutput。GraphBlock 改名为 BlockIcon。SISOreal 改名为
       SISO。SOreal 改名为 SO。I2SOreal 改名为 M2SO。
       SignalGenerator 改名为 SignalSource。引入了以下
       新模型：MIMO, MIMOs, SVcontrol, MVcontrol, DiscreteBlockIcon,
       DiscreteBlock, DiscreteSISO, DiscreteMIMO, DiscreteMIMOs,
       BooleanBlockIcon, BooleanSISO, BooleanSignalSource, MI2BooleanMOs。</li>
<li><em>1999年6月30日</em>
       作者: <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       实现了第一个版本，基于现有的Dymola库
       由 Dieter Moormann 和 Hilding Elmqvist 提供。</li>
</ul>
</html>"));
end Interfaces;