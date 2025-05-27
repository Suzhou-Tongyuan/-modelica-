within Modelica.Blocks;
package Routing "用于组合和提取信号的模块库"
  extends Modelica.Icons.Package;

  block Replicator "信号复制模块"
    extends Modelica.Blocks.Interfaces.SIMO;
  equation
    y = fill(u, nout);
    annotation(
      Icon(coordinateSystem(
      preserveAspectRatio = false, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{-100, 0}, {-6, 0}}, color = {0, 0, 127}), 
      Line(points = {{100, 0}, {10, 0}}, color = {0, 0, 127}), 
      Line(points = {{0, 0}, {100, 10}}, color = {0, 0, 127}), 
      Line(points = {{0, 0}, {100, -10}}, color = {0, 0, 127}), 
      Ellipse(
      extent = {{-15, 15}, {15, -15}}, 
      fillColor = {0, 0, 127}, 
      fillPattern = FillPattern.Solid)}), 
      Documentation(info = "<html>
<p>
本模块将输入信号复制到一个由相同输出信号组成的数组<code>nout</code>中。
</p>
</html>"));
  end Replicator;

  block IntegerReplicator "整数信号复制模块"
    extends Modelica.Blocks.Icons.IntegerBlock;
    parameter Integer nout = 1 "输出端数量";
    Modelica.Blocks.Interfaces.IntegerInput u 
      "整数输入信号连接器" 
      annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
    Modelica.Blocks.Interfaces.IntegerOutput y[nout] 
      "整数输出信号连接器" 
      annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));
  equation

    y = fill(u, nout);
    annotation(
      Icon(coordinateSystem(
      preserveAspectRatio = false, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{-100, 0}, {-6, 0}}, color = {255, 127, 0}), 
      Line(points = {{100, 0}, {10, 0}}, color = {255, 127, 0}), 
      Line(points = {{0, 0}, {100, 10}}, color = {255, 127, 0}), 
      Line(points = {{0, 0}, {100, -10}}, color = {255, 127, 0}), 
      Ellipse(
      extent = {{-15, 15}, {15, -15}}, 
      fillColor = {255, 127, 0}, 
      fillPattern = FillPattern.Solid)}), 
      Documentation(info = "<html>
<p>
本模块将整数输入信号复制到一个由相同整数输出信号组成的数组<code>nout</code>中。
</p>
</html>"));
  end IntegerReplicator;

  block BooleanReplicator "布尔信号复制模块"
    extends Modelica.Blocks.Icons.BooleanBlock;
    parameter Integer nout = 1 "输出端数量";
    Modelica.Blocks.Interfaces.BooleanInput u 
      "布尔输入信号连接器" 
      annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
    Modelica.Blocks.Interfaces.BooleanOutput y[nout] 
      "布尔输出信号连接器" 
      annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));
  equation

    y = fill(u, nout);
    annotation(
      Icon(coordinateSystem(
      preserveAspectRatio = false, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{-100, 0}, {-6, 0}}, color = {255, 0, 255}), 
      Line(points = {{100, 0}, {10, 0}}, color = {255, 0, 255}), 
      Line(points = {{0, 0}, {100, 10}}, color = {255, 0, 255}), 
      Line(points = {{0, 0}, {100, -10}}, color = {255, 0, 255}), 
      Ellipse(
      extent = {{-15, 15}, {15, -15}}, 
      fillColor = {255, 0, 255}, 
      fillPattern = FillPattern.Solid)}), 
      Documentation(info = "<html>
<p>
本模块将布尔输入信号复制到一个由相同布尔输出信号组成的数组<code>nout</code>中。
</p>
</html>"));
  end BooleanReplicator;

  block ExtractSignal "从输入信号向量中提取信号"
    extends Modelica.Blocks.Interfaces.MIMO;
    parameter Integer extract[nout] = 1:nout "提取向量";

  equation
    for i in 1:nout loop
      y[i] = u[extract[i]];

    end for;
    annotation(
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Rectangle(
      extent = {{-90, 51}, {-50, -49}}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid, 
      lineColor = {0, 0, 127}), 
      Rectangle(
      extent = {{50, 50}, {90, -50}}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid, 
      lineColor = {0, 0, 127}), 
      Polygon(
      points = {{-94.4104, 1.90792}, {-94.4104, -2.09208}, {-90.4104, -0.0920762}, 
      {-94.4104, 1.90792}}, 
      fillColor = {0, 0, 127}, 
      fillPattern = FillPattern.Solid, 
      lineColor = {0, 0, 127}), 
      Line(points = {{-72, 2}, {-60.1395, 12.907}, {-49.1395, 12.907}}, color = {0, 0, 127}), 
      Line(points = {{-73, 4}, {-59, 40}, {-49, 40}}, color = {0, 0, 127}), 
      Line(points = {{-113, 0}, {-76.0373, -0.0180176}}, color = {0, 0, 127}), 
      Ellipse(
      extent = {{-81.0437, 4.59255}, {-71.0437, -4.90745}}, 
      fillColor = {0, 0, 127}, 
      fillPattern = FillPattern.Solid, 
      lineColor = {0, 0, 127}), 
      Line(points = {{-73, -5}, {-60, -40}, {-49, -40}}, color = {0, 0, 127}), 
      Line(points = {{-72, -2}, {-60.0698, -12.907}, {-49.0698, -12.907}}, color = {
      0, 0, 127}), 
      Polygon(
      points = {{-48.8808, -11}, {-48.8808, -15}, {-44.8808, -13}, {-48.8808, -11}}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid, 
      lineColor = {0, 0, 127}), 
      Line(points = {{-46, 13}, {-35, 13}, {35, -30}, {45, -30}}, color = {0, 0, 127}), 
      Line(points = {{-45, 40}, {-35, 40}, {35, 0}, {44, 0}}, color = {0, 0, 127}), 
      Line(points = {{-45, -40}, {-34, -40}, {35, 30}, {44, 30}}, color = {0, 0, 127}), 
      Polygon(
      points = {{-49, 42}, {-49, 38}, {-45, 40}, {-49, 42}}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid, 
      lineColor = {0, 0, 127}), 
      Polygon(
      points = {{-48.8728, -38.0295}, {-48.8728, -42.0295}, {-44.8728, -40.0295}, 
      {-48.8728, -38.0295}}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid, 
      lineColor = {0, 0, 127}), 
      Polygon(
      points = {{-48.9983, 14.8801}, {-48.9983, 10.8801}, {-44.9983, 12.8801}, {-48.9983, 
      14.8801}}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid, 
      lineColor = {0, 0, 127}), 
      Ellipse(
      extent = {{69.3052, 4.12743}, {79.3052, -5.37257}}, 
      fillColor = {0, 0, 127}, 
      fillPattern = FillPattern.Solid, 
      lineColor = {0, 0, 127}), 
      Line(points = {{80, 0}, {100, 0}}, color = {0, 0, 127}), 
      Polygon(
      points = {{43.1618, 32.3085}, {43.1618, 28.3085}, {47.1618, 30.3085}, {
      43.1618, 32.3085}}, 
      fillColor = {0, 0, 127}, 
      fillPattern = FillPattern.Solid, 
      lineColor = {0, 0, 127}), 
      Polygon(
      points = {{43.2575, 1.80443}, {43.2575, -2.19557}, {47.2575, -0.195573}, {
      43.2575, 1.80443}}, 
      fillColor = {0, 0, 127}, 
      fillPattern = FillPattern.Solid, 
      lineColor = {0, 0, 127}), 
      Polygon(
      points = {{43.8805, -28.1745}, {43.8805, -32.1745}, {47.8805, -30.1745}, {
      43.8805, -28.1745}}, 
      fillColor = {0, 0, 127}, 
      fillPattern = FillPattern.Solid, 
      lineColor = {0, 0, 127}), 
      Line(points = {{48, 0}, {70, 0}}, color = {0, 0, 127}), 
      Line(points = {{47, 30}, {60, 30}, {73, 3}}, color = {0, 0, 127}), 
      Line(points = {{49, -30}, {60, -30}, {74, -4}}, color = {0, 0, 127}), 
      Text(
      extent = {{-150, -150}, {150, -110}}, 
      textString = "extract=%extract")}), 
      Documentation(info="<html><p>
从输入接口提取信号并传输到输出接口。
</p>
<p>
提取方案由整数向量“提取”给出。 该向量指定了哪些输入信号会被提取， 以及它们以何种顺序被传送到输出向量。 请注意， “提取”的维数必须与输出数相匹配。 此外， 输入连接器信号和输出连接器信号的尺寸必须通过参数\"nin\"和\"nout\"明确定义。
</p>
<p>
示例：
</p>
<pre><code >nin  = 7 \"Number of inputs\";
nout = 4 \"Number of outputs\";
extract[nout] = {6,3,3,2} \"Extracting vector\";</code></pre><p>
从输入向量(nin=7)的七个元素中提取四个输出信号(nout=4)：
</p>
<pre><code >output no. 1 is set equal to input no. 6
output no. 2 is set equal to input no. 3
output no. 3 is set equal to input no. 3
output no. 4 is set equal to input no. 2</code></pre><p>
<br>
</p>
</html>"));
  end ExtractSignal;

  block Extractor 
    "根据整数输入索引从信号向量中提取标量信号"

    extends Modelica.Blocks.Interfaces.MISO;

    parameter Boolean allowOutOfRange = false "索引可能超出范围";
    parameter Real outOfRangeValue = 1e10 "索引超出范围时输出信号";

    Modelica.Blocks.Interfaces.IntegerInput index annotation(Placement(
      transformation(
      origin = {0, -120}, 
      extent = {{-20, -20}, {20, 20}}, 
      rotation = 90)));
  protected
    Real k[nin];
  equation

    when {initial(), change(index)} then

      for i in 1:nin loop
        k[i] = if index == i then 1 else 0;

      end for;

    end when;

    y = if not allowOutOfRange or index > 0 and index <= nin then 
      k * u else outOfRangeValue;
    annotation(Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Rectangle(
      extent = {{-80, 50}, {-40, -50}}, 
      lineColor = {0, 0, 127}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid), 
      Polygon(
      points = {{-84.4104, 1.9079}, {-84.4104, -2.09208}, {-80.4104, -0.09208}, {
      -84.4104, 1.9079}}, 
      lineColor = {0, 0, 127}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-62, 2}, {-50.1395, 12.907}, {-39.1395, 12.907}}, color = {0, 0, 127}), 
      Line(points = {{-63, 4}, {-49, 40}, {-39, 40}}, color = {0, 0, 127}), 
      Line(points = {{-102, 0}, {-65.0373, -0.01802}}, color = {0, 0, 127}), 
      Ellipse(
      extent = {{-70.0437, 4.5925}, {-60.0437, -4.90745}}, 
      lineColor = {0, 0, 127}, 
      fillColor = {0, 0, 127}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-63, -5}, {-50, -40}, {-39, -40}}, color = {0, 0, 127}), 
      Line(points = {{-62, -2}, {-50.0698, -12.907}, {-39.0698, -12.907}}, color = {
      0, 0, 127}), 
      Polygon(
      points = {{-38.8808, -11}, {-38.8808, -15}, {-34.8808, -13}, {-38.8808, -11}}, 
      lineColor = {0, 0, 127}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid), 
      Polygon(
      points = {{-39, 42}, {-39, 38}, {-35, 40}, {-39, 42}}, 
      lineColor = {0, 0, 127}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid), 
      Polygon(
      points = {{-38.8728, -38.0295}, {-38.8728, -42.0295}, {-34.8728, -40.0295}, 
      {-38.8728, -38.0295}}, 
      lineColor = {0, 0, 127}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid), 
      Polygon(
      points = {{-38.9983, 14.8801}, {-38.9983, 10.8801}, {-34.9983, 12.8801}, {-38.9983, 
      14.8801}}, 
      lineColor = {0, 0, 127}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid), 
      Rectangle(
      extent = {{-30, 50}, {30, -50}}, 
      fillColor = {235, 235, 235}, 
      fillPattern = FillPattern.Solid, 
      lineColor = {0, 0, 127}), 
      Line(points = {{100, 0}, {0, 0}}, color = {0, 0, 127}), 
      Line(points = {{0, 2}, {0, -104}}, color = {255, 128, 0}), 
      Line(points = {{-35, 40}, {-20, 40}}, color = {0, 0, 127}), 
      Line(points = {{-35, 13}, {-20, 13}}, color = {0, 0, 127}), 
      Line(points = {{-35, -13}, {-20, -13}}, color = {0, 0, 127}), 
      Line(points = {{-35, -40}, {-20, -40}}, color = {0, 0, 127}), 
      Polygon(points = {{0, 0}, {-20, 13}, {-20, 13}, {0, 0}, {0, 0}}, lineColor = {0, 0, 
      127}), 
      Ellipse(
      extent = {{-6, 6}, {6, -6}}, 
      lineColor = {255, 128, 0}, 
      fillColor = {255, 128, 0}, 
      fillPattern = FillPattern.Solid)}), 
      Documentation(info="<html><p>
本模块从输入信号向量中提取一个标量输出信号， 该信号取决于附加u索引的整数值：
</p>
<pre><code >y = u [ index ] ;</code></pre><p>
其中，index是附加的整数输入信号。
</p>
<p>
<br>
</p>
</html>"));
  end Extractor;

  block Multiplex "用于连接任意数量输入连接器的多路复用模块"
    extends Modelica.Blocks.Icons.Block;
    parameter Integer n(min = 0) = 0 "输入信号连接器维度" annotation(Dialog(connectorSizing = true), HideResult = true);
    Modelica.Blocks.Interfaces.RealVectorInput u[n] 
      "实数输入信号连接器" annotation(Placement(transformation(extent = {{-120, 70}, {-80, -70}})));
    Modelica.Blocks.Interfaces.RealOutput y[n + 0] 
      "实数输出信号连接器" annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));

  equation
    y = u;
    annotation(
      defaultComponentName = "mux", 
      Documentation(info = "<html>
<p>
输出连接器与输入连接器是<strong>串联</strong>。</p>
</html>"), 
      Icon(
      coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), 
      graphics = {
      Line(points = {{8, 0}, {102, 0}}, color = {0, 0, 127}), 
      Line(points = {{-100, 70}, {-60, 70}, {-4, 4}}, color = {0, 0, 127}), 
      Line(points = {{-100, 0}, {-12, 0}}, color = {0, 0, 127}), 
      Line(points = {{-100, -70}, {-60, -70}, {-4, -4}}, color = {0, 0, 127}), 
      Ellipse(
      extent = {{-15, 15}, {15, -15}}, 
      fillColor = {0, 0, 127}, 
      fillPattern = FillPattern.Solid, 
      lineColor = {0, 0, 127}), 
      Line(points = {{-100, 0}, {-6, 0}}, color = {0, 0, 127}), 
      Text(
      extent = {{-140, -90}, {150, -50}}, 
      textString = "n=%n")}));
  end Multiplex;

  block Multiplex2 "用于两个输入连接器的多路复用模块"
    extends Modelica.Blocks.Icons.Block;
    parameter Integer n1 = 1 "输入信号连接器1的维度";
    parameter Integer n2 = 1 "输入信号连接器2的维度";
    Modelica.Blocks.Interfaces.RealInput u1[n1] 
      "实数输入信号连接器1" annotation(Placement(transformation(
      extent = {{-140, 40}, {-100, 80}})));
    Modelica.Blocks.Interfaces.RealInput u2[n2] 
      "实数输入信号连接器2" annotation(Placement(transformation(
      extent = {{-140, -80}, {-100, -40}})));
    Modelica.Blocks.Interfaces.RealOutput y[n1 + n2] 
      "实数输出信号连接器" annotation(Placement(transformation(
      extent = {{100, -10}, {120, 10}})));

  equation
    [y] = [u1; u2];
    annotation(
      Documentation(info = "<html>
<p>
输出连接器是两个输入连接器的<strong>组合</strong>。
注意，输入连接器信号的维度必须通过参数n1和n2明确定义。</p>
</html>"), Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{8, 0}, {102, 0}}, color = {0, 0, 127}), 
      Ellipse(
      extent = {{-15, 15}, {15, -15}}, 
      fillColor = {0, 0, 127}, 
      fillPattern = FillPattern.Solid, 
      lineColor = {0, 0, 127}), 
      Line(points = {{-100, 60}, {-60, 60}, {0, 0}}, color = {0, 0, 127}), 
      Line(points = {{-100, -60}, {-60, -60}, {0, 0}}, color = {0, 0, 127})}));
  end Multiplex2;

  block Multiplex3 "用于三个输入连接器的多路复用模块"
    extends Modelica.Blocks.Icons.Block;
    parameter Integer n1 = 1 "输入信号连接器1的维度";
    parameter Integer n2 = 1 "输入信号连接器2的维度";
    parameter Integer n3 = 1 "输入信号连接器3的维度";
    Modelica.Blocks.Interfaces.RealInput u1[n1] 
      "实数输入信号连接器1" annotation(Placement(transformation(
      extent = {{-140, 50}, {-100, 90}})));
    Modelica.Blocks.Interfaces.RealInput u2[n2] 
      "实数输入信号连接器2" annotation(Placement(transformation(
      extent = {{-140, -20}, {-100, 20}})));
    Modelica.Blocks.Interfaces.RealInput u3[n3] 
      "实数输入信号连接器3" annotation(Placement(transformation(
      extent = {{-140, -90}, {-100, -50}})));
    Modelica.Blocks.Interfaces.RealOutput y[n1 + n2 + n3] 
      "实数输出信号连接器" annotation(Placement(transformation(
      extent = {{100, -10}, {120, 10}})));

  equation
    [y] = [u1; u2; u3];
    annotation(
      Documentation(info = "<html>
<p>
输出连接器是三个输入连接器的<strong>组合</strong>。
注意，输入连接器信号的维度必须通过参数n1、n2和n3明确定义。</p>
</html>"), Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{8, 0}, {102, 0}}, color = {0, 0, 127}), 
      Line(points = {{-100, 70}, {-60, 70}, {0, 0}}, color = {0, 0, 127}), 
      Line(points = {{-100, 0}, {-12, 0}}, color = {0, 0, 127}), 
      Line(points = {{-100, -70}, {-60, -70}, {0, 0}}, color = {0, 0, 127}), 
      Ellipse(
      extent = {{-15, 15}, {15, -15}}, 
      fillColor = {0, 0, 127}, 
      fillPattern = FillPattern.Solid, 
      lineColor = {0, 0, 127})}));
  end Multiplex3;

  block Multiplex4 "用于四个输入连接器的多路复用模块"
    extends Modelica.Blocks.Icons.Block;
    parameter Integer n1 = 1 "输入信号连接器1的维度";
    parameter Integer n2 = 1 "输入信号连接器2的维度";
    parameter Integer n3 = 1 "输入信号连接器3的维度";
    parameter Integer n4 = 1 "输入信号连接器4的维度";
    Modelica.Blocks.Interfaces.RealInput u1[n1] 
      "实数输入信号连接器1" annotation(Placement(transformation(
      extent = {{-140, 70}, {-100, 110}})));
    Modelica.Blocks.Interfaces.RealInput u2[n2] 
      "实数输入信号连接器2" annotation(Placement(transformation(
      extent = {{-140, 10}, {-100, 50}})));
    Modelica.Blocks.Interfaces.RealInput u3[n3] 
      "实数输入信号连接器3" annotation(Placement(transformation(
      extent = {{-140, -50}, {-100, -10}})));
    Modelica.Blocks.Interfaces.RealInput u4[n4] 
      "实数输入信号连接器4" annotation(Placement(transformation(
      extent = {{-140, -110}, {-100, -70}})));
    Modelica.Blocks.Interfaces.RealOutput y[n1 + n2 + n3 + n4] 
      "实数输出信号连接器" annotation(Placement(transformation(
      extent = {{100, -10}, {120, 10}})));

  equation
    [y] = [u1; u2; u3; u4];
    annotation(
      Documentation(info="<html><p>
输出连接器是四个输入连接器的<strong>组合</strong>。 注意，输入连接器信号的维度必须通过参数n1、n2、n3和n4明确定义。
</p>
</html>"), Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{8, 0}, {102, 0}}, color = {0, 0, 127}), 
      Line(points = {{-100, 90}, {-60, 90}, {-3, 4}}, color = {0, 0, 127}), 
      Line(points = {{-100, 30}, {-60, 30}, {0, 0}}, color = {0, 0, 127}), 
      Line(points = {{-100, -30}, {-60, -30}, {0, 0}}, color = {0, 0, 127}), 
      Line(points = {{-100, -90}, {-60, -90}, {-5, -6}}, color = {0, 0, 127}), 
      Ellipse(
      extent = {{-15, 15}, {15, -15}}, 
      fillColor = {0, 0, 127}, 
      fillPattern = FillPattern.Solid, 
      lineColor = {0, 0, 127})}));
  end Multiplex4;

  block Multiplex5 "用于五个输入连接器的多路复用模块"
    extends Modelica.Blocks.Icons.Block;
    parameter Integer n1 = 1 "输入信号连接器1的维度";
    parameter Integer n2 = 1 "输入信号连接器2的维度";
    parameter Integer n3 = 1 "输入信号连接器3的维度";
    parameter Integer n4 = 1 "输入信号连接器4的维度";
    parameter Integer n5 = 1 "输入信号连接器5的维度";
    Modelica.Blocks.Interfaces.RealInput u1[n1] 
      "实数输入信号连接器1" annotation(Placement(transformation(
      extent = {{-140, 80}, {-100, 120}})));
    Modelica.Blocks.Interfaces.RealInput u2[n2] 
      "实数输入信号连接器2" annotation(Placement(transformation(
      extent = {{-140, 30}, {-100, 70}})));
    Modelica.Blocks.Interfaces.RealInput u3[n3] 
      "实数输入信号连接器3" annotation(Placement(transformation(
      extent = {{-140, -20}, {-100, 20}})));
    Modelica.Blocks.Interfaces.RealInput u4[n4] 
      "实数输入信号连接器4" annotation(Placement(transformation(
      extent = {{-140, -70}, {-100, -30}})));
    Modelica.Blocks.Interfaces.RealInput u5[n5] 
      "实数输入信号连接器5" annotation(Placement(transformation(
      extent = {{-140, -120}, {-100, -80}})));
    Modelica.Blocks.Interfaces.RealOutput y[n1 + n2 + n3 + n4 + n5] 
      "实数输出信号连接器" annotation(Placement(transformation(
      extent = {{100, -10}, {120, 10}})));

  equation
    [y] = [u1; u2; u3; u4; u5];
    annotation(
      Documentation(info = "<html>
<p>
输出连接器是五个输入连接器的<strong>组合</strong>。
注意，输入连接器信号的维度必须通过参数n1、n2、n3、n4和n5明确定义。</p>
</html>"), Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{8, 0}, {102, 0}}, color = {0, 0, 127}), 
      Line(points = {{-100, 100}, {-60, 100}, {0, 0}}, color = {0, 0, 127}), 
      Line(points = {{-100, 50}, {-60, 50}, {-4, 0}}, color = {0, 0, 127}), 
      Line(points = {{-100, 0}, {-7, 0}}, color = {0, 0, 127}), 
      Line(points = {{-100, -50}, {-60, -50}, {-4, 0}}, color = {0, 0, 127}), 
      Line(points = {{-100, -100}, {-60, -100}, {0, 0}}, color = {0, 0, 127}), 
      Ellipse(
      extent = {{-15, 15}, {15, -15}}, 
      fillColor = {0, 0, 127}, 
      fillPattern = FillPattern.Solid, 
      lineColor = {0, 0, 127})}));
  end Multiplex5;

  block Multiplex6 "用于六个输入连接器的多路复用模块"
    extends Modelica.Blocks.Icons.Block;
    parameter Integer n1 = 1 "输入信号连接器1的维度";
    parameter Integer n2 = 1 "输入信号连接器2的维度";
    parameter Integer n3 = 1 "输入信号连接器3的维度";
    parameter Integer n4 = 1 "输入信号连接器4的维度";
    parameter Integer n5 = 1 "输入信号连接器5的维度";
    parameter Integer n6 = 1 "输入信号连接器6的维度";
    Modelica.Blocks.Interfaces.RealInput u1[n1] 
      "实数输入信号连接器1" annotation(Placement(transformation(
      extent = {{-124, 73}, {-100, 97}})));
    Modelica.Blocks.Interfaces.RealInput u2[n2] 
      "实数输入信号连接器2" annotation(Placement(transformation(
      extent = {{-124, 39}, {-100, 63}})));
    Modelica.Blocks.Interfaces.RealInput u3[n3] 
      "实数输入信号连接器3" annotation(Placement(transformation(
      extent = {{-124, 5}, {-100, 29}})));

    Modelica.Blocks.Interfaces.RealInput u4[n4] 
      "实数输入信号连接器4" annotation(Placement(transformation(
      extent = {{-124, -29}, {-100, -5}})));
    Modelica.Blocks.Interfaces.RealInput u5[n5] 
      "实数输入信号连接器5" annotation(Placement(transformation(
      extent = {{-124, -63}, {-100, -39}})));
    Modelica.Blocks.Interfaces.RealInput u6[n6] 
      "实数输入信号连接器6" annotation(Placement(transformation(
      extent = {{-124, -97}, {-100, -73}})));
    Modelica.Blocks.Interfaces.RealOutput y[n1 + n2 + n3 + n4 + n5 + n6] 
      "实数输出信号连接器" annotation(Placement(transformation(
      extent = {{100, -10}, {120, 10}})));

  equation
    [y] = [u1; u2; u3; u4; u5; u6];
    annotation(
      Documentation(info = "<html>
<p>
输出连接器是六个输入连接器的<strong>组合</strong>。
注意，输入连接器信号的维度必须通过参数n1、n2、n3、n4、n5和n6明确定义。</p>
</html>"), Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{8, 0}, {102, 0}}, color = {0, 0, 127}), 
      Ellipse(
      extent = {{-15, 15}, {15, -15}}, 
      fillColor = {0, 0, 127}, 
      fillPattern = FillPattern.Solid, 
      lineColor = {0, 0, 127}), 
      Line(points = {{-100, 85}, {-60, 85}, {-3, 10}}, color = {0, 0, 127}), 
      Line(points = {{-100, 51}, {-60, 51}, {-7, 6}}, color = {0, 0, 127}), 
      Line(points = {{-100, -17}, {-60, -17}, {-10, -2}}, color = {0, 0, 127}), 
      Line(points = {{-100, 17}, {-60, 17}, {-10, 2}}, color = {0, 0, 127}), 
      Line(points = {{-100, -51}, {-60, -51}, {-7, -6}}, color = {0, 0, 127}), 
      Line(points = {{-100, -85}, {-60, -85}, {-3, -10}}, color = {0, 0, 127})}));
  end Multiplex6;

  block DeMultiplex "用于连接任意数量输出连接器的解复用器模块"
    extends Modelica.Blocks.Icons.Block;
    parameter Integer n(min = 0) = 0 "输出信号连接器的维度" annotation(Dialog(connectorSizing = true), HideResult = true);
    Modelica.Blocks.Interfaces.RealInput u[n + 0] 
      "实数输入信号连接器" annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
    Modelica.Blocks.Interfaces.RealVectorOutput y[n] 
      "实数输出信号连接器" 
      annotation(Placement(transformation(extent = {{80, 70}, {120, -70}})));

  equation
    y = u;
    annotation(
      defaultComponentName = "demux", 
      Documentation(info = "<html>
<p>
输入连接器被<strong>分割</strong>成多个输出连接器。</p>
</html>"), 
      Icon(
      coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), 
      graphics = {
      Line(points = {{8, 0}, {102, 0}}, color = {0, 0, 127}), 
      Ellipse(
      extent = {{-15, 15}, {15, -15}}, 
      fillColor = {0, 0, 127}, 
      fillPattern = FillPattern.Solid, 
      lineColor = {0, 0, 127}), 
      Line(points = {{-100, 0}, {-6, 0}}, color = {0, 0, 127}), 
      Line(points = {{100, 70}, {60, 70}, {4, 4}}, color = {0, 0, 127}), 
      Line(points = {{0, 0}, {100, 0}}, color = {0, 0, 127}), 
      Line(points = {{100, -70}, {60, -70}, {4, -4}}, color = {0, 0, 127}), 
      Text(
      extent = {{-140, -90}, {150, -50}}, 
      textString = "n=%n")}));
  end DeMultiplex;

  block DeMultiplex2 "用于连接两个输出连接器的解复用器模块"
    extends Modelica.Blocks.Icons.Block;
    parameter Integer n1 = 1 "输出信号连接器1的维度";
    parameter Integer n2 = 1 "输出信号连接器2的维度";
    Modelica.Blocks.Interfaces.RealInput u[n1 + n2] 
      "实数输入信号连接器" annotation(Placement(transformation(
      extent = {{-140, -20}, {-100, 20}})));
    Modelica.Blocks.Interfaces.RealOutput y1[n1] 
      "实数输出信号连接器1" annotation(Placement(transformation(
      extent = {{100, 50}, {120, 70}})));
    Modelica.Blocks.Interfaces.RealOutput y2[n2] 
      "实数输出信号连接器2" annotation(Placement(transformation(
      extent = {{100, -70}, {120, -50}})));

  equation
    [u] = [y1; y2];
    annotation(
      Documentation(info = "<html>
<p>
输入连接器被<strong>分割</strong>成两个输出连接器。
注意，输出连接器信号的维度必须通过参数n1和n2明确定义。</p>
</html>"), Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), 
      graphics = {
      Line(points = {{100, 60}, {60, 60}, {0, 0}}, color = {0, 0, 127}), 
      Ellipse(
      extent = {{-15, 15}, {15, -15}}, 
      fillColor = {0, 0, 127}, 
      fillPattern = FillPattern.Solid, 
      lineColor = {0, 0, 127}), 
      Line(points = {{100, -60}, {60, -60}, {0, 0}}, color = {0, 0, 127}), 
      Line(points = {{-100, 0}, {-6, 0}}, color = {0, 0, 127})}));
  end DeMultiplex2;

  block DeMultiplex3 "用于连接三个输出连接器的解复用器模块"
    extends Modelica.Blocks.Icons.Block;
    parameter Integer n1 = 1 "输出信号连接器1的维度";
    parameter Integer n2 = 1 "输出信号连接器2的维度";
    parameter Integer n3 = 1 "输出信号连接器3的维度";
    Modelica.Blocks.Interfaces.RealInput u[n1 + n2 + n3] 
      "实数输入信号连接器" annotation(Placement(transformation(
      extent = {{-140, -20}, {-100, 20}})));
    Modelica.Blocks.Interfaces.RealOutput y1[n1] 
      "实数输出信号连接器1" annotation(Placement(transformation(
      extent = {{100, 60}, {120, 80}})));
    Modelica.Blocks.Interfaces.RealOutput y2[n2] 
      "实数输出信号连接器2" annotation(Placement(transformation(
      extent = {{100, -10}, {120, 10}})));
    Modelica.Blocks.Interfaces.RealOutput y3[n3] 
      "实数输出信号连接器3" annotation(Placement(transformation(
      extent = {{100, -80}, {120, -60}})));

  equation
    [u] = [y1; y2; y3];
    annotation(
      Documentation(info = "<html>
<p>
输入连接器被<strong>分割</strong>成三个输出连接器。
注意，输出连接器信号的维度必须通过参数n1、n2和n3明确定义。</p>
</html>"), Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Ellipse(
      extent = {{-15, 15}, {15, -15}}, 
      fillColor = {0, 0, 127}, 
      fillPattern = FillPattern.Solid, 
      lineColor = {0, 0, 127}), 
      Line(points = {{-100, 0}, {-6, 0}}, color = {0, 0, 127}), 
      Line(points = {{100, 70}, {60, 70}, {0, 0}}, color = {0, 0, 127}), 
      Line(points = {{0, 0}, {100, 0}}, color = {0, 0, 127}), 
      Line(points = {{100, -70}, {60, -70}, {0, 0}}, color = {0, 0, 127})}));
  end DeMultiplex3;

  block DeMultiplex4 "用于连接四个输出连接器的解复用器模块"

    extends Modelica.Blocks.Icons.Block;
    parameter Integer n1 = 1 "输出信号连接器1的维度";
    parameter Integer n2 = 1 "输出信号连接器2的维度";
    parameter Integer n3 = 1 "输出信号连接器3的维度";
    parameter Integer n4 = 1 "输出信号连接器4的维度";
    Modelica.Blocks.Interfaces.RealInput u[n1 + n2 + n3 + n4] 
      "实数输入信号连接器" annotation(Placement(transformation(
      extent = {{-140, -20}, {-100, 20}})));
    Modelica.Blocks.Interfaces.RealOutput y1[n1] 
      "实数输出信号连接器1" annotation(Placement(transformation(
      extent = {{100, 80}, {120, 100}})));
    Modelica.Blocks.Interfaces.RealOutput y2[n2] 
      "实数输出信号连接器2" annotation(Placement(transformation(
      extent = {{100, 20}, {120, 40}})));
    Modelica.Blocks.Interfaces.RealOutput y3[n3] 
      "实数输出信号连接器3" annotation(Placement(transformation(
      extent = {{100, -40}, {120, -20}})));
    Modelica.Blocks.Interfaces.RealOutput y4[n4] 
      "实数输出信号连接器4" annotation(Placement(transformation(
      extent = {{100, -100}, {120, -80}})));

  equation
    [u] = [y1; y2; y3; y4];
    annotation(
      Documentation(info = "<html>
<p>
输入连接器被<strong>分割</strong>成四个输出连接器。
注意，输出连接器信号的维度必须通过参数n1、n2、n3和n4明确定义。</p>
</html>"), Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Ellipse(
      extent = {{-15, 15}, {15, -15}}, 
      fillColor = {0, 0, 127}, 
      fillPattern = FillPattern.Solid, 
      lineColor = {0, 0, 127}), 
      Line(points = {{-100, 0}, {-6, 0}}, color = {0, 0, 127}), 
      Line(points = {{100, 90}, {60, 90}, {0, 0}}, color = {0, 0, 127}), 
      Line(points = {{100, 30}, {60, 30}, {0, 0}}, color = {0, 0, 127}), 
      Line(points = {{100, -30}, {60, -30}, {0, 0}}, color = {0, 0, 127}), 
      Line(points = {{100, -90}, {60, -90}, {0, 0}}, color = {0, 0, 127})}));
  end DeMultiplex4;

  block DeMultiplex5 "用于连接五个输出连接器的解复用器模块"

    extends Modelica.Blocks.Icons.Block;
    parameter Integer n1 = 1 "输出信号连接器1的维度";
    parameter Integer n2 = 1 "输出信号连接器2的维度";
    parameter Integer n3 = 1 "输出信号连接器3的维度";
    parameter Integer n4 = 1 "输出信号连接器4的维度";
    parameter Integer n5 = 1 "输出信号连接器5的维度";
    Modelica.Blocks.Interfaces.RealInput u[n1 + n2 + n3 + n4 + n5] 
      "实数输入信号连接器" annotation(Placement(transformation(
      extent = {{-140, -20}, {-100, 20}})));
    Modelica.Blocks.Interfaces.RealOutput y1[n1] 
      "实数输出信号连接器1" annotation(Placement(transformation(
      extent = {{100, 70}, {120, 90}})));
    Modelica.Blocks.Interfaces.RealOutput y2[n2] 
      "实数输出信号连接器2" annotation(Placement(transformation(
      extent = {{100, 30}, {120, 50}})));
    Modelica.Blocks.Interfaces.RealOutput y3[n3] 
      "实数输出信号连接器3" annotation(Placement(transformation(
      extent = {{100, -10}, {120, 10}})));
    Modelica.Blocks.Interfaces.RealOutput y4[n4] 
      "实数输出信号连接器4" annotation(Placement(transformation(
      extent = {{100, -50}, {120, -30}})));
    Modelica.Blocks.Interfaces.RealOutput y5[n5] 
      "实数输出信号连接器5" annotation(Placement(transformation(
      extent = {{100, -90}, {120, -70}})));

  equation
    [u] = [y1; y2; y3; y4; y5];
    annotation(
      Documentation(info = "<html>
<p>
输入连接器被<strong>分割</strong>成五个输出连接器。
注意，输出连接器信号的维度必须通过参数n1、n2、n3、n4和n5明确定义。</p>
</html>"), Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Ellipse(
      extent = {{-15, 15}, {15, -15}}, 
      fillColor = {0, 0, 127}, 
      fillPattern = FillPattern.Solid, 
      lineColor = {0, 0, 127}), 
      Line(points = {{-100, 0}, {-6, 0}}, color = {0, 0, 127}), 
      Line(points = {{100, 80}, {60, 80}, {0, 0}}, color = {0, 0, 127}), 
      Line(points = {{100, 40}, {60, 40}, {8, 4}}, color = {0, 0, 127}), 
      Line(points = {{100, 0}, {10, 0}}, color = {0, 0, 127}), 
      Line(points = {{100, -40}, {60, -40}, {8, -4}}, color = {0, 0, 127}), 
      Line(points = {{100, -80}, {60, -80}, {0, 0}}, color = {0, 0, 127})}));
  end DeMultiplex5;

  block DeMultiplex6 "用于连接六个输出连接器的解复用器模块"
    extends Modelica.Blocks.Icons.Block;
    parameter Integer n1 = 1 "输出信号连接器1的维度";
    parameter Integer n2 = 1 "输出信号连接器2的维度";
    parameter Integer n3 = 1 "输出信号连接器3的维度";
    parameter Integer n4 = 1 "输出信号连接器4的维度";
    parameter Integer n5 = 1 "输出信号连接器5的维度";
    parameter Integer n6 = 1 "输出信号连接器6的维度";
    Modelica.Blocks.Interfaces.RealInput u[n1 + n2 + n3 + n4 + n5 + n6] 
      "实数输入信号连接器" annotation(Placement(transformation(
      extent = {{-140, -20}, {-100, 20}})));
    Modelica.Blocks.Interfaces.RealOutput y1[n1] 
      "实数输出信号连接器1" annotation(Placement(transformation(
      extent = {{100, 80}, {120, 100}})));
    Modelica.Blocks.Interfaces.RealOutput y2[n2] 
      "实数输出信号连接器2" annotation(Placement(transformation(
      extent = {{100, 44}, {120, 64}})));
    Modelica.Blocks.Interfaces.RealOutput y3[n3] 
      "实数输出信号连接器3" annotation(Placement(transformation(
      extent = {{100, 8}, {120, 28}})));
    Modelica.Blocks.Interfaces.RealOutput y4[n4] 
      "实数输出信号连接器4" annotation(Placement(transformation(
      extent = {{100, -28}, {120, -8}})));
    Modelica.Blocks.Interfaces.RealOutput y5[n5] 
      "实数输出信号连接器5" annotation(Placement(transformation(
      extent = {{100, -64}, {120, -44}})));
    Modelica.Blocks.Interfaces.RealOutput y6[n6] 
      "实数输出信号连接器6" annotation(Placement(transformation(
      extent = {{100, -100}, {120, -80}})));

  equation
    [u] = [y1; y2; y3; y4; y5; y6];
    annotation(
      Documentation(info = "<html>
<p>
输入连接器被<strong>分割</strong>成六个输出连接器。
注意，输出连接器信号的维度必须通过参数n1、n2、n3、n4、n5和n6明确定义。</p>
</html>"), Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Ellipse(
      extent = {{-15, 15}, {15, -15}}, 
      fillColor = {0, 0, 127}, 
      fillPattern = FillPattern.Solid, 
      lineColor = {0, 0, 127}), 
      Line(points = {{-100, 0}, {-6, 0}}, color = {0, 0, 127}), 
      Line(points = {{100, 90}, {60, 90}, {0, 4}}, color = {0, 0, 127}), 
      Line(points = {{100, 54}, {60, 54}, {8, 6}}, color = {0, 0, 127}), 
      Line(points = {{100, 18}, {60, 18}, {10, 2}}, color = {0, 0, 127}), 
      Line(points = {{100, -18}, {60, -18}, {10, -2}}, color = {0, 0, 127}), 
      Line(points = {{100, -54}, {60, -54}, {8, -6}}, color = {0, 0, 127}), 
      Line(points = {{100, -90}, {60, -90}, {0, -4}}, color = {0, 0, 127})}));
  end DeMultiplex6;

  model RealPassThrough "不加修改地传递实数信号"
    extends Modelica.Blocks.Interfaces.SISO;
  equation
    y = u;
    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
      -100}, {100, 100}}), graphics = {Line(points = {{-100, 0}, {100, 0}}, 
      color = {0, 0, 127})}), 
      Documentation(info = "<html>
<p>
可将信号从一条总线读出，更改其名称后再送回一条总线。
</p>
</html>"));
  end RealPassThrough;

  model IntegerPassThrough "不加修改地传递整数信号"
    extends Modelica.Blocks.Icons.IntegerBlock;

    Modelica.Blocks.Interfaces.IntegerInput u "输入信号" 
      annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
    Modelica.Blocks.Interfaces.IntegerOutput y "输出信号" 
      annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));
  equation
    y = u;

    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
      -100}, {100, 100}}), graphics = {Line(points = {{-100, 0}, {100, 0}}, 
      color = {255, 128, 0})}), 
      Documentation(info = "<html>
<p>可将信号从一条总线读出，更改其名称后再送回一条总线。</p>
</html>"));
  end IntegerPassThrough;

  model BooleanPassThrough "不加修改地传递布尔信号"
    extends Modelica.Blocks.Interfaces.BooleanSISO;
  equation
    y = u;
    annotation(Documentation(info = "<html>
<p>可将信号从一条总线读出，更改其名称后再送回一条总线。</p>
</html>"), 
      Icon(
      coordinateSystem(preserveAspectRatio = true, 
      extent = {{-100.0, -100.0}, {100.0, 100.0}}), 
      graphics = {
      Line(
      points = {{-100.0, 0.0}, {100.0, 0.0}}, 
      color = {255, 0, 255})}));
  end BooleanPassThrough;
  annotation(Documentation(info="<html><p>
本组件包中包含用于组合和提取信号的模块。
</p>
</html>"), Icon(graphics = {
    Line(points = {{-90, 0}, {4, 0}}, color = {95, 95, 95}), 
    Line(points = {{88, 65}, {48, 65}, {-8, 0}}, color = {95, 95, 95}), 
    Line(points = {{-8, 0}, {93, 0}}, color = {95, 95, 95}), 
    Line(points = {{87, -65}, {48, -65}, {-8, 0}}, color = {95, 95, 95})}));
end Routing;