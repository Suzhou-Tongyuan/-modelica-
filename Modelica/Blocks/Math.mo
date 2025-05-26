within Modelica.Blocks;
package Math "作为输入/输出块的实数函数库"

  import Modelica.Blocks.Interfaces;
  extends Modelica.Icons.Package;

  encapsulated package UnitConversions 
    "用于在国际单位制和非国际单位制信号之间进行转换的转换模块"
    import Modelica;

    import Modelica.Units.NonSI;
    extends Modelica.Icons.Package;

    block To_degC "开尔文换算成摄氏度"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit = "K"), y(
        unit = "degC"));

    equation
      y = Modelica.Units.Conversions.to_degC(u);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{-20, 100}, {-100, 20}}, 
        textString = "K"), Text(
        extent = {{100, -20}, {20, -100}}, 
        textString = "degC")}), Documentation(info = "<html>
<p>
该模块将输入信号从开尔文转换为摄氏度，并将结果作为输出信号返回。
</p>
</html>"));
    end To_degC;

    block From_degC "摄氏度换算成开尔文"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit = "degC"), 
        y(unit = "K"));
    equation
      y = Modelica.Units.Conversions.from_degC(u);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{-20, 100}, {-100, 20}}, 
        textString = "degC"), Text(
        extent = {{100, -20}, {20, -100}}, 
        textString = "K")}), Documentation(info = "<html>
<p>
该模块将输入信号从摄氏度转换为开尔文，并将结果作为输出信号返回。
</p>
</html>"));
    end From_degC;

    block To_degF "开尔文换算成华氏度"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit = "K"), y(
        unit = "degF"));
    equation
      y = Modelica.Units.Conversions.to_degF(u);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{-20, 100}, {-100, 20}}, 
        textString = "K"), Text(
        extent = {{100, -20}, {20, -100}}, 
        textString = "degF")}), Documentation(info = "<html>
<p>
该模块将输入信号从开尔文转换为华氏度，并将结果作为输出信号返回。
</p>
</html>"));
    end To_degF;

    block From_degF "华氏度换算成开尔文"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit = "degF"), 
        y(unit = "K"));
    equation
      y = Modelica.Units.Conversions.from_degF(u);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{-20, 100}, {-100, 20}}, 
        textString = "degF"), Text(
        extent = {{100, -20}, {20, -100}}, 
        textString = "K")}), Documentation(info = "<html>
<p>
该模块将输入信号从华氏度转换为开尔文，并将结果作为输出信号返回。
</p>
</html>"));
    end From_degF;

    block To_degRk "开尔文换算成兰氏度"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit = "K"), y(
        unit = "degRk"));
    equation
      y = Modelica.Units.Conversions.to_degRk(u);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{-20, 100}, {-100, 20}}, 
        textString = "K"), Text(
        extent = {{100, -20}, {20, -100}}, 
        textString = "degRk")}), Documentation(info = "<html>
<p>
该模块将输入信号从开尔文转换为兰氏度，并将结果作为输出信号返回。
</p>
</html>"));
    end To_degRk;

    block From_degRk "兰氏度换算成开尔文"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit = "degRk"), 
        y(unit = "K"));
    equation
      y = Modelica.Units.Conversions.from_degRk(u);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{-20, 100}, {-100, 20}}, 
        textString = "degRk"), Text(
        extent = {{100, -20}, {20, -100}}, 
        textString = "K")}), Documentation(info = "<html>
<p>
该模块将输入信号从兰氏度转换为开尔文，并将结果作为输出信号返回。
</p>
</html>"));
    end From_degRk;

    block To_deg "弧度换算成度数"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit = "rad"), 
        y(unit = "deg"));
    equation
      y = Modelica.Units.Conversions.to_deg(u);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{-20, 100}, {-100, 20}}, 
        textString = "rad"), Text(
        extent = {{100, -20}, {20, -100}}, 
        textString = "deg")}), Documentation(info = "<html>
<p>
该模块将输入信号从弧度转换为度，并将结果作为输出信号返回。
</p>
</html>"));
    end To_deg;

    block From_deg "度数换算成弧度"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit = "deg"), 
        y(unit = "rad"));
    equation
      y = Modelica.Units.Conversions.from_deg(u);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{-20, 100}, {-100, 20}}, 
        textString = "deg"), Text(
        extent = {{100, -20}, {20, -100}}, 
        textString = "rad")}), Documentation(info = "<html>
<p>
该模块将输入信号从度转换为弧度，并将结果作为输出信号返回。
</p>
</html>"));
    end From_deg;

    block To_rpm "弧度每秒换算成转数每分钟"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit = "rad/s"), 
        y(unit = "rev/min"));
    equation
      y = Modelica.Units.Conversions.to_rpm(u);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{26, 82}, {-98, 50}}, 
        textString = "rad/s"), Text(
        extent = {{100, -42}, {-62, -74}}, 
        textString = "rev/min")}), Documentation(info="<html><p>
该模块将输入信号从弧度每秒转换为转数每分钟，并将结果作为输出信号返回。
</p>
</html>"    ));
    end To_rpm;

    block From_rpm "每分钟转数换算成每秒弧度数"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit = "rev/min"), 
        y(unit = "rad/s"));
    equation
      y = Modelica.Units.Conversions.from_rpm(u);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{50, 84}, {-94, 56}}, 
        textString = "rev/min"), Text(
        extent = {{94, -42}, {-26, -74}}, 
        textString = "rad/s")}), Documentation(info="<html><p>
该模块将输入信号从转数每分钟转换为弧度每秒，并将结果作为输出信号返回。
</p>
</html>"));
    end From_rpm;

    block To_kmh "每秒米换算成每小时公里"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit = "m/s"), 
        y(unit = "km/h"));
    equation
      y = Modelica.Units.Conversions.to_kmh(u);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{0, 82}, {-96, 42}}, 
        textString = "m/s"), Text(
        extent = {{92, -40}, {-14, -84}}, 
        textString = "km/h")}), Documentation(info="<html><p>
该模块将输入信号从米每秒转换为公里每小时，并将结果作为输出信号返回。
</p>
</html>"));
    end To_kmh;

    block From_kmh "每小时公里换算成每秒米"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit = "km/h"), 
        y(unit = "m/s"));
    equation
      y = Modelica.Units.Conversions.from_kmh(u);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{26, 80}, {-96, 48}}, 
        textString = "km/h"), Text(
        extent = {{92, -46}, {-20, -82}}, 
        textString = "m/s")}), Documentation(info="<html><p>
该模块将输入信号从公里每小时转换为米每秒，并将结果作为输出信号返回。
</p>
</html>"));
    end From_kmh;

    block To_day "秒换算成天"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit = "s"), y(
        unit = "d"));
    equation
      y = Modelica.Units.Conversions.to_day(u);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{-20, 100}, {-100, 20}}, 
        textString = "s"), Text(
        extent = {{100, -20}, {20, -100}}, 
        textString = "day")}), Documentation(info = "<html>
<p>
该模块将输入信号从秒转换为天，并将结果作为输出信号返回。
</p>
</html>"));
    end To_day;

    block From_day "天换算成秒"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit = "d"), y(
        unit = "s"));
    equation
      y = Modelica.Units.Conversions.from_day(u);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{-20, 100}, {-100, 20}}, 
        textString = "day"), Text(
        extent = {{100, -20}, {20, -100}}, 
        textString = "s")}), Documentation(info = "<html>
<p>
该模块将输入信号从天转换为秒，并将结果作为输出信号返回。
</p>
</html>"));
    end From_day;

    block To_hour "秒换算成小时"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit = "s"), y(
        unit = "h"));
    equation
      y = Modelica.Units.Conversions.to_hour(u);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{-20, 100}, {-100, 20}}, 
        textString = "s"), Text(
        extent = {{100, -20}, {20, -100}}, 
        textString = "hour")}), Documentation(info = "<html>
<p>
该模块将输入信号从秒转换为小时，并将结果作为输出信号返回。
</p>
</html>"));
    end To_hour;

    block From_hour "小时换算成秒"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit = "h"), y(
        unit = "s"));
    equation
      y = Modelica.Units.Conversions.from_hour(u);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{-20, 100}, {-100, 20}}, 
        textString = "hour"), Text(
        extent = {{100, -20}, {20, -100}}, 
        textString = "s")}), Documentation(info = "<html>
<p>
该模块将输入信号从小时转换为秒，并将结果作为输出信号返回。
</p>
</html>"));
    end From_hour;

    block To_minute "秒换算成分钟"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit = "s"), y(
        unit = "min"));
    equation
      y = Modelica.Units.Conversions.to_minute(u);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{-20, 100}, {-100, 20}}, 
        textString = "s"), Text(
        extent = {{100, -20}, {20, -100}}, 
        textString = "minute")}), Documentation(info = "<html>
<p>
该模块将输入信号从秒转换为分钟，并将结果作为输出信号返回。
</p>
</html>"));
    end To_minute;

    block From_minute "分钟换算成秒"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit = "min"), 
        y(unit = "s"));
    equation
      y = Modelica.Units.Conversions.from_minute(u);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{-20, 100}, {-100, 20}}, 
        textString = "minute"), Text(
        extent = {{100, -20}, {20, -100}}, 
        textString = "s")}), Documentation(info = "<html>
<p>
该模块将输入信号从分钟转换为秒，并将结果作为输出信号返回。
</p>
</html>"));
    end From_minute;

    block To_litre "立方米换算成升"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit = "m3"), y(
        unit = "l"));
    equation
      y = Modelica.Units.Conversions.to_litre(u);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{-20, 100}, {-100, 20}}, 
        textString = "m3"), Text(
        extent = {{100, -20}, {20, -100}}, 
        textString = "litre")}), Documentation(info = "<html>
<p>
该模块将输入信号从立方米转换为升，并将结果作为输出信号返回。
</p>
</html>"));
    end To_litre;

    block From_litre "升换算成立方米"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit = "l"), y(
        unit = "m3"));
    equation
      y = Modelica.Units.Conversions.from_litre(u);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{-20, 100}, {-100, 20}}, 
        textString = "litre"), Text(
        extent = {{100, -20}, {20, -100}}, 
        textString = "m3")}), Documentation(info = "<html>
<p>
该模块将输入信号从升转换为立方米，并将结果作为输出信号返回。
</p>
</html>"));
    end From_litre;

    block To_kWh "焦耳换算成千瓦时"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit = "J"), y(
        unit = "kW.h"));
    equation
      y = Modelica.Units.Conversions.to_kWh(u);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{-20, 100}, {-100, 20}}, 
        textString = "J"), Text(
        extent = {{100, -20}, {20, -100}}, 
        textString = "kW.h")}), Documentation(info = "<html>
<p>
该模块将输入信号从焦耳转换为千瓦时，并将结果作为输出信号返回。
</p>
</html>"));
    end To_kWh;

    block From_kWh "千瓦小时换算成焦耳"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit = "kW.h"), 
        y(unit = "J"));
    equation
      y = Modelica.Units.Conversions.from_kWh(u);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{-20, 100}, {-100, 20}}, 
        textString = "kW.h"), Text(
        extent = {{100, -20}, {20, -100}}, 
        textString = "J")}), Documentation(info = "<html>
<p>
该模块将输入信号从千瓦时转换为焦耳，并将结果作为输出信号返回。
</p>
</html>"));
    end From_kWh;

    block To_bar "Pascal换算成bar"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit = "Pa"), y(
        unit = "bar"));
    equation
      y = Modelica.Units.Conversions.to_bar(u);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{-20, 100}, {-100, 20}}, 
        textString = "Pa"), Text(
        extent = {{100, -20}, {20, -100}}, 
        textString = "bar")}), Documentation(info="<html><p>
该莫块将输入信号从 Pa 转换为 bar，并将结果作为输出信号返回。
</p>
</html>"));
    end To_bar;

    block From_bar "bar换算成Pascal"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit = "bar"), 
        y(unit = "Pa"));
    equation
      y = Modelica.Units.Conversions.from_bar(u);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{-20, 100}, {-100, 20}}, 
        textString = "bar"), Text(
        extent = {{100, -20}, {20, -100}}, 
        textString = "Pa")}), Documentation(info="<html><p>
该模块将输入信号从 bar 转换为 Pa，并将结果作为输出信号返回。
</p>
</html>"));
    end From_bar;

    block To_gps "每秒千克换算成每秒克"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit = "kg/s"), 
        y(unit = "g/s"));
    equation
      y = Modelica.Units.Conversions.to_gps(u);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{-20, 100}, {-100, 20}}, 
        textString = "kg/s"), Text(
        extent = {{100, -20}, {20, -100}}, 
        textString = "g/s")}), Documentation(info="<html><p>
该模块将输入信号从千克每秒转换为克每秒，并将结果作为输出信号返回。
</p>
</html>"));
    end To_gps;

    block From_gps "每秒克换算成每秒千克"
      extends Modelica.Blocks.Interfaces.PartialConversionBlock(u(unit = "g/s"), 
        y(unit = "kg/s"));
    equation
      y = Modelica.Units.Conversions.from_gps(u);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Text(
        extent = {{-20, 100}, {-100, 20}}, 
        textString = "g/s"), Text(
        extent = {{100, -20}, {20, -100}}, 
        textString = "kg/s")}), Documentation(info="<html><p>
该模块将输入信号从克每秒转换为千克每秒，并将结果作为输出信号返回。
</p>
</html>"));
    end From_gps;
    annotation(Documentation(info="<html><p>
该程序包中包括将特定单位的输入信号转换为另一单位的输出信号的模块（例如，将角度信号从 “deg” 转换为 “rad”）。
</p>
</html>"));
  end UnitConversions;

  block InverseBlockConstraints 
    "通过要求两个输入和两个输出相同来构建逆模型"

    Modelica.Blocks.Interfaces.RealInput u1 "Input signal 1 (u1 = u2)" 
      annotation(Placement(transformation(extent = {{-240, -20}, {-200, 20}}), iconTransformation(extent = {{-240, -20}, {-200, 20}})));
    Modelica.Blocks.Interfaces.RealInput u2 "Input signal 2 (u1 = u2)" 
      annotation(Placement(transformation(extent = {{-140, -20}, {-180, 20}}), iconTransformation(extent = {{-140, -20}, {-180, 20}})));
    Modelica.Blocks.Interfaces.RealOutput y1 "Output signal 1 (y1 = y2)" 
      annotation(Placement(transformation(extent = {{200, -10}, {220, 10}}), iconTransformation(extent = {{200, -10}, {220, 10}})));
    Modelica.Blocks.Interfaces.RealOutput y2 "Output signal 2 (y1 = y2)" 
      annotation(Placement(transformation(
      extent = {{10, -10}, {-10, 10}}, 
      origin = {170, 0}), iconTransformation(extent = {{180, -10}, {160, 10}})));

  equation
    u1 = u2;
    y1 = y2;
    annotation(
      defaultConnectionStructurallyInconsistent = true, 
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-200, -120}, {200, 
      120}}), graphics = {
      Line(
      points = {{180, 0}, {200, 0}}, 
      color = {0, 0, 127}), 
      Line(
      points = {{-200, 0}, {-180, 0}}, 
      color = {0, 0, 127}), 
      Rectangle(extent = {{-190, 120}, {190, -120}}, lineColor = {135, 135, 135})}), 
      Documentation(info = "<html>
<p>
交换模块的输入和输出信号，即之前的模块输入变为模块输出，之前的模块输出变为模块输入。
该模块用于构建反演模型。示例演示了其用法：
<a href=\"modelica://Modelica.Blocks.Examples.InverseModel\">Modelica.Blocks.Examples.InverseModel</a>.
</p>

<p>
请注意，如果需要反转的模块有多个输入和输出模块，
则可以通过使用 InverseBlockConstraints 实例矢量来轻松实现：
</p>

<blockquote><pre>
InverseBlockConstraint invert[3];  // Block to be inverted has 3 input signals
</pre></blockquote>
</html>"));
  end InverseBlockConstraints;

  block Gain "输出增益值与输入信号的乘积"

    parameter Real k(start = 1, unit = "1") 
      "与输入信号相乘的增益值";
  public
    Interfaces.RealInput u "输入信号接口" annotation(Placement(
      transformation(extent = {{-140, -20}, {-100, 20}})));
    Interfaces.RealOutput y "输出信号接口" annotation(Placement(
      transformation(extent = {{100, -10}, {120, 10}})));

  equation
    y = k * u;
    annotation(
      Documentation(info="<html><p>
该模块计算的输出<em>y</em>是增益<em>k</em>与输入<em>u &nbsp;</em>的<em>乘积</em>：
</p>
<pre><code >y = k * u;</code></pre><p>
<br>
</p>
</html>"), 
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Polygon(
      points = {{-100, -100}, {-100, 100}, {100, 0}, {-100, -100}}, 
      lineColor = {0, 0, 127}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid), 
      Text(
      extent = {{-150, -140}, {150, -100}}, 
      textString = "k=%k"), 
      Text(
      extent = {{-150, 140}, {150, 100}}, 
      textString = "%name", 
      textColor = {0, 0, 255})}));
  end Gain;

  block MatrixGain 
    "输出增益矩阵与输入信号矢量的乘积"

    parameter Real K[:,:] = [1, 0; 0, 1] 
      "与输入相乘的增益矩阵";
    extends Interfaces.MIMO(final nin = size(K, 2), final nout = size(K, 1));
  equation
    y = K * u;
    annotation(
      Documentation(info="<html><p>
该模块计算的输出向量<strong>y</strong>是增益矩阵<strong>K</strong> 与输入信号向量<strong>u</strong>的<em>乘积</em>：
</p>
<pre><code >y = K * u;
</code></pre><p>
例如:
</p>
<pre><code >parameter: K = [0.12 2; 3 1.5]

results in the following equations:

| y[1] |     | 0.12  2.00 |   | u[1] |
|      |  =  |            | * |      |
| y[2] |     | 3.00  1.50 |   | u[2] |
</code></pre><p>
<br>
</p>
<p>
<br>
</p>
</html>"), 
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {Text(
      extent = {{-90, -60}, {90, 60}}, 
      textColor = {160, 160, 164}, 
      textString = "*K")}));
  end MatrixGain;

  block MultiSum "实数之和：y=k[1]*u[1]+k[2]*u[2]+...+k[n]*u[n]"
    extends Modelica.Blocks.Interfaces.PartialRealMISO;
    parameter Real k[nu] = fill(1, nu) "输入增益";
  equation
    if size(u, 1) > 0 then
      y = k * u;
    else
      y = 0;
    end if;

    annotation(Icon(graphics = {Text(
      extent = {{-200, -110}, {200, -140}}, 
      textString = "%k"), Text(
      extent = {{-72, 68}, {92, -68}}, 
      textString = "+")}), Documentation(info = "<html>
<p>
该模块计算的标量实数输出 y 是实数输入信号向量 u 的元素之和：
</p>
<blockquote><pre>
y = k[1]*u[1] + k[2]*u[2] + ... k[N]*u[N];
</pre></blockquote>

<p>
输入接口是一个实数输入信号的向量。
绘制连接线时，输入矢量的尺寸会放大一个，
连接线会自动连接到这个新的自由索引（这要归功于 connectorSizing 注解）。
</p>

<p>
举例说明其用法 
<a href=\"modelica://Modelica.Blocks.Examples.RealNetwork1\">Modelica.Blocks.Examples.RealNetwork1</a>.
</p>

<p>
如果输入接口 u 没有连接，则输出设置为零：y=0。
</p>

</html>"));
  end MultiSum;

  block MultiProduct "实数相乘：y=u[1]*u[2]*...*u[n]"
    extends Modelica.Blocks.Interfaces.PartialRealMISO;
  equation
    if size(u, 1) > 0 then
      y = product(u);
    else
      y = 0;
    end if;

    annotation(Icon(graphics = {Text(
      extent = {{-74, 50}, {94, -94}}, 
      textString = "*")}), Documentation(info="<html><p>
该模块计算的是实数输出标量 y 与实数输入信号向量 u 的乘积：
</p>
<pre><code >y = u[1]*u[2]* ... *u[N];</code></pre><p>
输入接口是一个实数输入信号的向量。 绘制连接线时，输入矢量的尺寸会放大一个， 连接线会自动连接到这个新的自由索引（这要归功于 connectorSizing 注解）。
</p>
<p>
举例说明其用法 <a href=\"modelica://Modelica.Blocks.Examples.RealNetwork1\" target=\"\">Modelica.Blocks.Examples.RealNetwork1</a>.
</p>
<p>
如果输入接口 u 没有连接，则输出设置为零：y=0。
</p>
</html>"));
  end MultiProduct;

  block MultiSwitch 
    "设置与第一个有效输入信号相关联的实数表达式"

    input Real expr[nu] = fill(0.0, nu) 
      "y=如果u[i]为真，那么expr[i]，否则为y_default(随时间变化)" 
      annotation(Dialog);
    parameter Real y_default = 0.0 
      "如果所有u[i]=false，输出y的默认值";

    parameter Integer nu(min = 0) = 0 "输入接口数量" 
      annotation(Dialog(connectorSizing = true), HideResult = true);
    parameter Integer precision(min = 0) = 3 
      "y的动态图表层中显示的有效数字位数" 
      annotation(Dialog(tab = "高级"));

    Modelica.Blocks.Interfaces.BooleanVectorInput u[nu] 
      "设置y=expr[i]，如果u[i]=true" 
      annotation(Placement(transformation(extent = {{-110, 30}, {-90, -30}})));
    Modelica.Blocks.Interfaces.RealOutput y "输出取决于表达式" 
      annotation(Placement(transformation(extent = {{300, -10}, {320, 10}})));

  protected
    Integer firstActiveIndex;
  initial equation
    pre(u) = fill(false, nu);
  equation
    firstActiveIndex = Modelica.Math.BooleanVectors.firstTrueIndex(u);
    y = if firstActiveIndex == 0 then y_default else expr[firstActiveIndex];
    annotation(
      defaultComponentName = "multiSwitch1", 
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {300, 
      100}}), graphics = {
      Rectangle(
      extent = {{-100, -51}, {300, 50}}, 
      lineThickness = 5.0, 
      fillColor = {170, 213, 255}, 
      fillPattern = FillPattern.Solid, 
      borderPattern = BorderPattern.Raised), 
      Text(
      extent = {{-86, 16}, {295, -17}}, 
      textString = "%expr"), 
      Text(
      extent = {{310, -25}, {410, -45}}, 
      textString = DynamicSelect(" ", String(
      y, 
      minimumLength = 1, 
      significantDigits = precision))), 
      Text(
      extent = {{-100, -60}, {300, -90}}, 
      textString = "else: %y_default"), 
      Text(
      extent = {{-100, 100}, {300, 60}}, 
      textString = "%name", 
      textColor = {0, 0, 255})}), 
      Documentation(info="<html><p>
该模块有一个布尔输入信号向量 u[nu] 和一个（随时间变化的）实数表达式向量 expr[nu]。 如果 i 是输入向量 u 中第一个为真的元素，则输出信号 y 设置为 expr[i]。 如果所有输入信号都为假，则 y 设置为参数 y_default。
</p>
<pre><code >// Conceptual equation (not valid Modelica)
i = \\'first element of u[:] that is true\\';
y = if i==0 then y_default else expr[i];</code></pre><p>
输入接口是布尔输入信号的向量。 在绘制连接线时，输入向量的尺寸会放大一个， 连接线会自动连接到这个新的空闲索引（这要归功于 connectorSizing 注解）。
</p>
<p>
举例说明其用法 <a href=\"modelica://Modelica.Blocks.Examples.RealNetwork1\" target=\"\">Modelica.Blocks.Examples.RealNetwork1</a>.
</p>
<p>
<br>
</p>
</html>"));
  end MultiSwitch;

  block Sum "输出输入向量元素之和"
    extends Interfaces.MISO;
    parameter Real k[nin] = ones(nin) "可选：系数总和";
  equation
    y = k * u;
    annotation(
      defaultComponentName = "sum1", 
      Documentation(info="<html><p>
该模块将输出<strong>y</strong>计算为输入信号向量<strong>u</strong>的元素之<em>和</em>：
</p>
<pre><code >y = u[1] + u[2] + ...;</code></pre><p>
例如:
</p>
<pre><code >parameter:   nin = 3;

results in the following equations:

y = u[1] + u[2] + u[3];</code></pre><p>
<br>
</p>
</html>"), 
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {Line(
      points = {{26, 42}, {-34, 42}, {6, 2}, {-34, -38}, {26, -38}})}));
  end Sum;

  block Feedback "指令和反馈输入之间的差"

    Interfaces.RealInput u1 "指令输入" annotation(Placement(transformation(extent = {{-100, 
      -20}, {-60, 20}})));
    Interfaces.RealInput u2 "反馈输入" annotation(Placement(transformation(
      origin = {0, -80}, 
      extent = {{-20, -20}, {20, 20}}, 
      rotation = 90)));
    Interfaces.RealOutput y annotation(Placement(transformation(extent = {{80, -10}, 
      {100, 10}})));

  equation
    y = u1 - u2;
    annotation(
      Documentation(info="<html><p>
该模块将指令输入<strong>u1</strong>和反馈输入<strong>u2</strong> 的<em>差值 </em>作为输出<strong>y</strong>计算：
</p>
<pre><code >y = u1 - u2;</code></pre><p>
例如:
</p>
<pre><code >parameter:   n = 2

results in the following equations:

y = u1 - u2</code></pre><p>
<br>
</p>
</html>"), 
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Ellipse(
      lineColor = {0, 0, 127}, 
      fillColor = {235, 235, 235}, 
      fillPattern = FillPattern.Solid, 
      extent = {{-20, -20}, {20, 20}}), 
      Line(points = {{-60, 0}, {-20, 0}}, color = {0, 0, 127}), 
      Line(points = {{20, 0}, {80, 0}}, color = {0, 0, 127}), 
      Line(points = {{0, -20}, {0, -60}}, color = {0, 0, 127}), 
      Text(extent = {{-14, -94}, {82, 0}}, textString = "-"), 
      Text(
      textColor = {0, 0, 255}, 
      extent = {{-150, 40}, {150, 80}}, 
      textString = "%name")}));
  end Feedback;

  block Add "输出两个输入的总和"
    extends Interfaces.SI2SO;

    parameter Real k1 = +1 "输入信号增益1";
    parameter Real k2 = +1 "输入信号增益2";

  equation
    y = k1 * u1 + k2 * u2;
    annotation(
      Documentation(info="<html><p>
该模块将输出<strong>y</strong>计算为两个输入信号 <strong>u1</strong>和<strong>u2</strong>之<em>和</em>：
</p>
<pre><code >y = k1*u1 + k2*u2;</code></pre><p>
例如:
</p>
<pre><code >parameter:   k1= +2, k2= -3

results in the following equations:

y = 2 * u1 - 3 * u2</code></pre><p>
<br>
</p>
</html>"), 
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{-100, 60}, {-74, 24}, {-44, 24}}, color = {0, 0, 127}), 
      Line(points = {{-100, -60}, {-74, -24}, {-44, -24}}, color = {0, 0, 127}), 
      Ellipse(lineColor = {0, 0, 127}, extent = {{-50, -50}, {50, 50}}), 
      Line(points = {{50, 0}, {100, 0}}, color = {0, 0, 127}), 
      Text(extent = {{-40, 40}, {40, -40}}, textString = "+"), 
      Text(extent = {{-100, 52}, {5, 92}}, textString = "%k1"), 
      Text(extent = {{-100, -92}, {5, -52}}, textString = "%k2")}), 
      Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
      100, 100}}), graphics = {Line(points = {{50, 0}, {100, 0}}, 
      color = {0, 0, 255}), Line(
      points = {{50, 0}, {100, 0}}, color = {0, 0, 127})}));
  end Add;

  block Add3 "输出三个输入的总和"
    extends Modelica.Blocks.Icons.Block;

    parameter Real k1 = +1 "输入信号增益1";
    parameter Real k2 = +1 "输入信号增益2";
    parameter Real k3 = +1 "输入信号增益3";
    Interfaces.RealInput u1 "实数输入信号接口1" annotation(
      Placement(transformation(extent = {{-140, 60}, {-100, 100}})));
    Interfaces.RealInput u2 "实数输入信号接口2" annotation(
      Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
    Interfaces.RealInput u3 "实数输入信号接口3" annotation(
      Placement(transformation(extent = {{-140, -100}, {-100, -60}})));
    Interfaces.RealOutput y "实数输出信号接口" annotation(
      Placement(transformation(extent = {{100, -10}, {120, 10}})));

  equation
    y = k1 * u1 + k2 * u2 + k3 * u3;
    annotation(
      Documentation(info="<html><p>
该模块将输出output <strong>y</strong>计算为三个输入信号 <strong>u1</strong>、<strong>u2</strong>和<strong>u3</strong>之<em>和</em>：
</p>
<pre><code >y = k1*u1 + k2*u2 + k3*u3;</code></pre><p>
例如:
</p>
<pre><code >parameter:   k1= +2, k2= -3, k3=1;

results in the following equations:

y = 2 * u1 - 3 * u2 + u3;</code></pre><p>
<br>
</p>
</html>"), 
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Text(
      extent = {{-100, 50}, {5, 90}}, 
      textString = "%k1"), 
      Text(
      extent = {{-100, -20}, {5, 20}}, 
      textString = "%k2"), 
      Text(
      extent = {{-100, -50}, {5, -90}}, 
      textString = "%k3"), 
      Text(
      extent = {{10, 40}, {90, -40}}, 
      textString = "+")}));
  end Add3;

  block Product "两个输入的输出乘积"
    extends Interfaces.SI2SO;

  equation
    y = u1 * u2;
    annotation(
      Documentation(info="<html><p>
该模块将输出<strong>y</strong>计算为两个输入 <strong>u1</strong>和<strong>u2</strong>的<em>乘积 </em>：
</p>
<pre><code >y = u1 * u2;</code></pre><p>
<br>
</p>
</html>"), 
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{-100, 60}, {-40, 60}, {-30, 40}}, color = {0, 0, 127}), 
      Line(points = {{-100, -60}, {-40, -60}, {-30, -40}}, color = {0, 0, 127}), 
      Line(points = {{50, 0}, {100, 0}}, color = {0, 0, 127}), 
      Line(points = {{-30, 0}, {30, 0}}), 
      Line(points = {{-15, 25.99}, {15, -25.99}}), 
      Line(points = {{-15, -25.99}, {15, 25.99}}), 
      Ellipse(lineColor = {0, 0, 127}, extent = {{-50, -50}, {50, 50}})}));
  end Product;

  block Division "输出第一个输入除以第二个输入"
    extends Interfaces.SI2SO;

  equation
    y = u1 / u2;
    annotation(
      Documentation(info="<html><p>
该模块通过两个输入 <strong>u1</strong>（被除数）和<strong>u2</strong>（除数） 相除来计算输出（商）<strong>y</strong>：
</p>
<pre><code >y = u1 / u2;</code></pre><p>
<br>
</p>
<p>
<br>
</p>
</html>"), 
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{-100, 60}, {-60, 60}, {0, 0}}, color = {0, 0, 127}), 
      Line(points = {{-100, -60}, {-60, -60}, {0, 0}}, color = {0, 0, 127}), 
      Ellipse(lineColor = {0, 0, 127}, extent = {{-50, -50}, {50, 50}}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{50, 0}, {100, 0}}, color = {0, 0, 127}), 
      Line(points = {{-30, 0}, {30, 0}}), 
      Ellipse(fillPattern = FillPattern.Solid, extent = {{-5, 20}, {5, 30}}), 
      Ellipse(fillPattern = FillPattern.Solid, extent = {{-5, -30}, {5, -20}}), 
      Text(
      extent = {{-60, 90}, {90, 50}}, 
      textColor = {128, 128, 128}, 
      textString = "u1 / u2")}), 
      Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, 
preserveAspectRatio=true, 
grid={2,2})));
  end Division;
  block MultiVector "向量的标量乘法: y[n] = k*u[n]"
    parameter Integer n = 1 "向量的长度";
    Modelica.Blocks.Interfaces.RealInput u[n] "实型向量输入信号连接器" annotation(Placement(
      transformation(extent = {{-140, 40}, {-100, 80}})));
    Modelica.Blocks.Interfaces.RealInput k "增益连接器" annotation(Placement(
      transformation(extent = {{-140, -80}, {-100, -40}})));
    Modelica.Blocks.Interfaces.RealOutput y[n] "实型向量输出信号连接器" annotation(Placement(
      transformation(extent = {{100, -10}, {120, 10}})));
  equation
    y = k * u;
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, 
      grid = {2, 2}), graphics = {Rectangle(origin = {0, 0}, 
      lineColor = {0, 0, 127}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid, 
      extent = {{-100, -100}, {100, 100}}), Line(origin = {-65, 50}, 
      points = {{-35, 10}, {25, 10}, {35, -10}}, 
      color = {0, 0, 127}), Line(origin = {-65, -50}, 
      points = {{-35, -10}, {25, -10}, {35, 10}}, 
      color = {0, 0, 127}), Line(origin = {75, 0}, 
      points = {{-25, 0}, {25, 0}}, 
      color = {0, 0, 127}), Line(origin = {0, 0}, 
      points = {{-30, 0}, {30, 0}}), Line(origin = {0, 0}, 
      points = {{-15, 25.99}, {15, -25.99}}), Line(origin = {0, 0}, 
      points = {{-15, -25.99}, {15, 25.99}}), Ellipse(origin = {0, 0}, 
      lineColor = {0, 0, 127}, 
      extent = {{-50, -50}, {50, 50}}), Text(origin = {0, 80}, 
      lineColor = {128, 128, 128}, 
      extent = {{-75, 20}, {75, -20}}, 
      textString = "u[n] *k", 
      textColor = {128, 128, 128}), Text(origin = {0, 130}, 
      lineColor = {0, 0, 255}, 
      extent = {{-150, 20}, {150, -20}}, 
      textString = "%name", 
      textColor = {0, 0, 255})}), Documentation(info = "<html><p>
<span style=\"color: rgb(51, 51, 51); background-color: rgb(243, 243, 243);\">该模块计算输出 </span><span style=\"color: rgb(51, 51, 51); background-color: rgb(243, 243, 243);\"><strong>y[n]</strong></span><span style=\"color: rgb(51, 51, 51); background-color: rgb(243, 243, 243);\">，它是向量的标量乘法 </span><span style=\"color: rgb(51, 51, 51); background-color: rgb(243, 243, 243);\"><strong>u[n]:</strong></span>
</p>
<p>
<span style=\"color: rgb(51, 51, 51); background-color: rgb(217, 217, 217);\"><strong>y[n]=k*u[n];</strong></span>
</p>
</html>"  ));
  end MultiVector;
  model DivVector "向量的标量除法：y[n] = u[n]/k"
    parameter Integer n = 1 "向量的长度";
    Modelica.Blocks.Interfaces.RealInput u[n] "向量输入信号的连接器" annotation(Placement(
      transformation(extent = {{-140, 40}, {-100, 80}})));
    Modelica.Blocks.Interfaces.RealInput k "增益的连接器" annotation(Placement(
      transformation(extent = {{-140, -80}, {-100, -40}})));
    Modelica.Blocks.Interfaces.RealOutput y[n] "向量输出信号的连接器" annotation(Placement(
      transformation(extent = {{100, -10}, {120, 10}})));
  equation
    y = u / k;
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, 
      grid = {2, 2}), graphics = {Rectangle(origin = {0, 0}, 
      lineColor = {0, 0, 127}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid, 
      extent = {{-100, -100}, {100, 100}}), Text(origin = {0, 130}, 
      lineColor = {0, 0, 255}, 
      extent = {{-150, 20}, {150, -20}}, 
      textString = "%name", 
      textColor = {0, 0, 255}), Line(origin = {-50, 30}, 
      points = {{-50, 30}, {-10, 30}, {50, -30}}, 
      color = {0, 0, 127}), Line(origin = {-50, -30}, 
      points = {{-50, -30}, {-10, -30}, {50, 30}}, 
      color = {0, 0, 127}), Ellipse(origin = {0, 0}, 
      lineColor = {0, 0, 127}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid, 
      extent = {{-50, -50}, {50, 50}}), Line(origin = {75, 0}, 
      points = {{-25, 0}, {25, 0}}, 
      color = {0, 0, 127}), Line(origin = {0, 0}, 
      points = {{-30, 0}, {30, 0}}), Ellipse(origin = {0, 25}, 
      fillPattern = FillPattern.Solid, 
      extent = {{-5, -5}, {5, 5}}), Ellipse(origin = {0, -25}, 
      fillPattern = FillPattern.Solid, 
      extent = {{-5, -5}, {5, 5}}), Text(origin = {15, 70}, 
      lineColor = {128, 128, 128}, 
      extent = {{-75, 20}, {75, -20}}, 
      textString = "u[n] / k", 
      textColor = {128, 128, 128})}), Documentation(info = "<html><p>
<span style=\"color: rgb(51, 51, 51); background-color: rgb(243, 243, 243);\">该块计算输出</span><span style=\"color: rgb(51, 51, 51); background-color: rgb(243, 243, 243);\"><strong>y[n]</strong></span><span style=\"color: rgb(51, 51, 51); background-color: rgb(243, 243, 243);\"> ， 作为向量的标量除法 </span><span style=\"color: rgb(51, 51, 51); background-color: rgb(243, 243, 243);\"><strong>u[n]:</strong></span>
</p>
<p>
<span style=\"color: rgb(51, 51, 51); background-color: rgb(217, 217, 217);\"><strong>y[n]=u[n]/k;</strong></span>
</p>
</html>"    ));
  end DivVector;
  model VectorAdd "向量加法：y[n] = k1*u1[n] + k2*u2[n]"
    extends Interfaces.VI2VO;
    parameter Real k1 = 1 "输入信号1的增益";
    parameter Real k2 = 1 "输入信号2的增益";
  equation
    y = k1 * u1 + k2 * u2;
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, 
      preserveAspectRatio = true, 
      grid = {2, 2}), graphics = {Line(origin = {-72, 42}, 
      points = {{-28, 18}, {-2, -18}, {28, -18}}, 
      color = {0, 0, 127}), Line(origin = {-72, -42}, 
      points = {{-28, -18}, {-2, 18}, {28, 18}}, 
      color = {0, 0, 127}), Ellipse(origin = {0, 0}, 
      lineColor = {0, 0, 127}, 
      extent = {{-50, -50}, {50, 50}}), Line(origin = {75, 0}, 
      points = {{-25, 0}, {25, 0}}, 
      color = {0, 0, 127}), Text(origin = {0, 0}, 
      extent = {{-40, 40}, {40, -40}}, 
      textString = "+"), Text(origin = {-47.5, 72}, 
      extent = {{-52.5, -20}, {52.5, 20}}, 
      textString = "%k1"), Text(origin = {-47.5, -72}, 
      extent = {{-52.5, -20}, {52.5, 20}}, 
      textString = "%k2")}), Documentation(info = "<html><p>
<span style=\"color: rgb(51, 51, 51); background-color: rgb(243, 243, 243);\">此模块计算输出 y[n]，其为两个输入向量信号 u1[n] 和 u2[n] 的和：</span>
</p>
<p>
<span style=\"color: rgb(51, 51, 51); background-color: rgb(217, 217, 217);\"><strong>y[n]=k1*u1[n]+k2*u2[n];</strong></span>
</p>
</html>"  ));
  end VectorAdd;

  block Abs "输出输入值的绝对值"
    extends Interfaces.SISO;
    parameter Boolean generateEvent = false 
      "选择是否生成事件" annotation(Evaluate = true);
  equation
    //y = abs(u);
    y = if generateEvent then (if u >= 0 then u else -u) else (if noEvent(u >= 
      0) then u else -u);
    annotation(
      defaultComponentName = "abs1", 
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Polygon(
      points = {{92, 0}, {70, 8}, {70, -8}, {92, 0}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-80, 80}, {0, 0}, {80, 80}}), 
      Line(points = {{0, -14}, {0, 68}}, color = {192, 192, 192}), 
      Polygon(
      points = {{0, 90}, {-8, 68}, {8, 68}, {0, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Text(
      extent = {{-34, -28}, {38, -76}}, 
      textColor = {192, 192, 192}, 
      textString = "abs"), 
      Line(points = {{-88, 0}, {76, 0}}, color = {192, 192, 192})}), 
      Documentation(info="<html><p>
该模块将输出<strong>y</strong>计算为 输入<strong>u</strong>的 <em>绝对值</em>：
</p>
<pre><code >y = abs( u );</code></pre><p>
布尔型参数 generateEvent 决定事件是否在过零点时生成（Modelica 规范 3 之前）。
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"));
  end Abs;

  block Sign "输出输入信号的符号"
    extends Interfaces.SISO;
    parameter Boolean generateEvent = false 
      "选择是否生成事件" annotation(Evaluate = true);
  equation
    //y = sign(u);
    y = if generateEvent then (if u > 0 then 1 else if u < 0 then -1 else 0) 
      else (if noEvent(u > 0) then 1 else if noEvent(u < 0) then -1 else 0);
    annotation(
      defaultComponentName = "sign1", 
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), 
      Polygon(
      points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-80, -80}, {0, -80}}), 
      Polygon(
      points = {{0, 90}, {-8, 68}, {8, 68}, {0, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{0, -80}, {0, 68}}, color = {192, 192, 192}), 
      Text(
      extent = {{-90, 72}, {-18, 24}}, 
      textColor = {192, 192, 192}, 
      textString = "sign"), 
      Line(points = {{0, 80}, {80, 80}}), 
      Rectangle(
      extent = {{-2, 2}, {2, -4}}, 
      fillPattern = FillPattern.Solid)}), 
      Documentation(info="<html><p>
该模块将输出<strong>y</strong> 计算为输入<strong>u</strong>的<strong>sign</strong>：
</p>
<pre><code >1  if u &gt; 0
y =  0  if u == 0
-1  if u &lt; 0</code></pre><p>
布尔型参数 generateEvent 决定事件是否在过零点时生成（Modelica 规范 3 之前）。
</p>
<p>
<br>
</p>
</html>"));
  end Sign;

  block Sqrt "输出输入值的平方根(要求输入值>=0)"
    extends Interfaces.SISO;

  equation
    y = sqrt(u);
    annotation(
      defaultComponentName = "sqrt1", 
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Line(points = {{-90, -80}, {68, -80}}, color = {192, 192, 192}), 
      Polygon(
      points = {{90, -80}, {68, -72}, {68, -88}, {90, -80}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(
      points = {{-80, -80}, {-79.2, -68.7}, {-78.4, -64}, {-76.8, -57.3}, {-73.6, -47.9}, 
      {-67.9, -36.1}, {-59.1, -22.2}, {-46.2, -6.49}, {-28.5, 10.7}, {-4.42, 
      30}, {27.7, 51.3}, {69.5, 74.7}, {80, 80}}, 
      smooth = Smooth.Bezier), 
      Polygon(
      points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-80, -88}, {-80, 68}}, color = {192, 192, 192}), 
      Text(
      extent = {{-8, -4}, {64, -52}}, 
      textColor = {192, 192, 192}, 
      textString = "sqrt")}), 
      Documentation(info="<html><p>
该模块将输出<strong>y</strong> 计算为输入<strong>u</strong>的<em>平方根</em>：
</p>
<pre><code >y = sqrt( u );</code></pre><p>
输入值必须为零或正。 否则会出错。
</p>
<p>
<br>
</p>
</html>"));
  end Sqrt;

  block Sin "输出输入信号的正弦值"
    extends Interfaces.SISO(u(unit = "rad"));
  equation
    y = Modelica.Math.sin(u);
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Polygon(
      points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-80, -80}, {-80, 68}}, color = {192, 192, 192}), 
      Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), 
      Line(
      points = {{-80, 0}, {-68.7, 34.2}, {-61.5, 53.1}, {-55.1, 66.4}, {-49.4, 74.6}, 
      {-43.8, 79.1}, {-38.2, 79.8}, {-32.6, 76.6}, {-26.9, 69.7}, {-21.3, 59.4}, 
      {-14.9, 44.1}, {-6.83, 21.2}, {10.1, -30.8}, {17.3, -50.2}, {23.7, -64.2}, 
      {29.3, -73.1}, {35, -78.4}, {40.6, -80}, {46.2, -77.6}, {51.9, -71.5}, {
      57.5, -61.9}, {63.9, -47.2}, {72, -24.8}, {80, 0}}, 
      smooth = Smooth.Bezier), 
      Polygon(
      points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Text(
      extent = {{12, 84}, {84, 36}}, 
      textColor = {192, 192, 192}, 
      textString = "sin")}), 
      Documentation(info="<html><p>
该模块将输出 <strong>y</strong> 计算为输入<strong>u</strong>的<strong>sine</strong>：
</p>
<pre><code >y = sin( u );

<img src=\"modelica://Modelica/Resources/Images/Math/sin.png\" alt=\"sin.png\" data-href=\"\" style=\"\"/></code></pre><p>
<br>
</p>
</html>"));
  end Sin;













  block Cos "输出输入值的余弦值"
    extends Interfaces.SISO(u(unit = "rad"));
  equation
    y = Modelica.Math.cos(u);
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Polygon(
      points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-80, -80}, {-80, 68}}, color = {192, 192, 192}), 
      Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), 
      Polygon(
      points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(
      points = {{-80, 80}, {-74.4, 78.1}, {-68.7, 72.3}, {-63.1, 63}, {-56.7, 48.7}, 
      {-48.6, 26.6}, {-29.3, -32.5}, {-22.1, -51.7}, {-15.7, -65.3}, {-10.1, -73.8}, 
      {-4.42, -78.8}, {1.21, -79.9}, {6.83, -77.1}, {12.5, -70.6}, {18.1, -60.6}, 
      {24.5, -45.7}, {32.6, -23}, {50.3, 31.3}, {57.5, 50.7}, {63.9, 64.6}, {
      69.5, 73.4}, {75.2, 78.6}, {80, 80}}, 
      smooth = Smooth.Bezier), 
      Text(
      extent = {{-36, 82}, {36, 34}}, 
      textColor = {192, 192, 192}, 
      textString = "cos")}), 
      Documentation(info="<html><p>
该模块将输出<strong>y</strong>计算为输入<strong>u</strong>的<strong>cos</strong>：
</p>
<blockquote><pre>
y = <strong>cos</strong>( u );
</pre></blockquote>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/cos.png\"
   alt=\"cos.png\">
</div>
</html>"  ));
  end Cos;
  block Tan "输出输入值的正切值"
    extends Interfaces.SISO(u(unit = "rad"));

  equation
    y = Modelica.Math.tan(u);
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Polygon(
      points = {{0, 90}, {-8, 68}, {8, 68}, {0, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{0, -80}, {0, 68}}, color = {192, 192, 192}), 
      Line(
      points = {{-80, -80}, {-78.4, -68.4}, {-76.8, -59.7}, {-74.4, -50}, {-71.2, -40.9}, 
      {-67.1, -33}, {-60.7, -24.8}, {-51.1, -17.2}, {-35.8, -9.98}, {-4.42, -1.07}, 
      {33.4, 9.12}, {49.4, 16.2}, {59.1, 23.2}, {65.5, 30.6}, {70.4, 39.1}, {
      73.6, 47.4}, {76, 56.1}, {77.6, 63.8}, {80, 80}}, 
      smooth = Smooth.Bezier), 
      Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), 
      Polygon(
      points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Text(
      extent = {{-90, 72}, {-18, 24}}, 
      textColor = {192, 192, 192}, 
      textString = "tan")}), 
      Documentation(info="<html><p>
该模块将输出<strong>y</strong> 计算为输入<strong>u</strong>的<strong>tan</strong>：
</p>
<blockquote><pre>
y = <strong>tan</strong>( u );
</pre></blockquote>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/tan.png\"
   alt=\"tan.png\">
</div>
</html>"  ));
  end Tan;

  block Asin "输出输入的反正弦值"
    extends Interfaces.SISO(y(unit = "rad"));

  equation
    y = Modelica.Math.asin(u);
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Polygon(
      points = {{0, 90}, {-8, 68}, {8, 68}, {0, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{0, -80}, {0, 68}}, color = {192, 192, 192}), 
      Line(
      points = {{-80, -80}, {-79.2, -72.8}, {-77.6, -67.5}, {-73.6, -59.4}, {-66.3, 
      -49.8}, {-53.5, -37.3}, {-30.2, -19.7}, {37.4, 24.8}, {57.5, 40.8}, {
      68.7, 52.7}, {75.2, 62.2}, {77.6, 67.5}, {80, 80}}, 
      smooth = Smooth.Bezier), 
      Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), 
      Polygon(
      points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Text(
      extent = {{-88, 78}, {-16, 30}}, 
      textColor = {192, 192, 192}, 
      textString = "asin")}), 
      Documentation(info="<html><p>
该模块将输出<strong>y</strong> 计算为输入<strong>u</strong>的<em>反正弦值</em>：
</p>
<pre><code >y = asin( u );</code></pre><p>
输入<strong>u</strong>的绝对值必须小于或等于 1（<strong>abs</strong>( u ) &lt;= 1）。 否则会出错。
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Math/asin.png\" alt=\"atan.png\" data-href=\"\" style=\"\">
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"));
  end Asin;

  block Acos "输出输入值的反余弦值"
    extends Interfaces.SISO(y(unit = "rad"));
  equation
    y = Modelica.Math.acos(u);
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Polygon(
      points = {{0, 90}, {-8, 68}, {8, 68}, {0, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(
      points = {{-80, 80}, {-79.2, 72.8}, {-77.6, 67.5}, {-73.6, 59.4}, {-66.3, 49.8}, 
      {-53.5, 37.3}, {-30.2, 19.7}, {37.4, -24.8}, {57.5, -40.8}, {68.7, -52.7}, 
      {75.2, -62.2}, {77.6, -67.5}, {80, -80}}, 
      smooth = Smooth.Bezier), 
      Line(points = {{0, -88}, {0, 68}}, color = {192, 192, 192}), 
      Line(points = {{-90, -80}, {68, -80}}, color = {192, 192, 192}), 
      Polygon(
      points = {{90, -80}, {68, -72}, {68, -88}, {90, -80}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Text(
      extent = {{-86, -14}, {-14, -62}}, 
      textColor = {192, 192, 192}, 
      textString = "acos")}), 
      Documentation(info="<html><p>
该模块将输出<strong>y</strong>计算为输入<strong>u</strong>的<em>反余弦值</em>：
</p>
<pre><code >y = acos( u );</code></pre><p>
输入<strong>u</strong>的绝对值必须小于或等于 1（<strong>abs</strong>( u ) &lt;= 1）。 否则会出错。
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Math/acos.png\" alt=\"acos.png\" data-href=\"\" style=\"\">
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"));
  end Acos;

  block Atan "输出输入的反正切值"
    extends Interfaces.SISO(y(unit = "rad"));
  equation
    y = Modelica.Math.atan(u);
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Polygon(
      points = {{0, 90}, {-8, 68}, {8, 68}, {0, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{0, -80}, {0, 68}}, color = {192, 192, 192}), 
      Line(
      points = {{-80, -80}, {-52.7, -75.2}, {-37.4, -69.7}, {-26.9, -63}, {-19.7, -55.2}, 
      {-14.1, -45.8}, {-10.1, -36.4}, {-6.03, -23.9}, {-1.21, -5.06}, {5.23, 
      21}, {9.25, 34.1}, {13.3, 44.2}, {18.1, 52.9}, {24.5, 60.8}, {33.4, 67.6}, 
      {47, 73.6}, {69.5, 78.6}, {80, 80}}, 
      smooth = Smooth.Bezier), 
      Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), 
      Polygon(
      points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Text(
      extent = {{-86, 68}, {-14, 20}}, 
      textColor = {192, 192, 192}, 
      textString = "atan")}), 
      Documentation(info="<html><p>
该模块将输出<strong>y</strong> 计算为输入<strong>u</strong>的<em>反正切值</em>：
</p>
<blockquote><pre>
y= <strong>atan</strong>( u );
</pre></blockquote>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/atan.png\"
   alt=\"atan.png\">
</div>
</html>"    ));
  end Atan;

  block Atan2 "输出为输入u1和u2的atan(u1/u2)"
    extends Interfaces.SI2SO(y(unit = "rad"));
  equation
    y = Modelica.Math.atan2(u1, u2);
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Polygon(
      points = {{0, 90}, {-8, 68}, {8, 68}, {0, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{0, -80}, {0, 68}}, color = {192, 192, 192}), 
      Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), 
      Polygon(
      points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(
      points = {{-80, -34.9}, {-46.1, -31.4}, {-29.4, -27.1}, {-18.3, -21.5}, {-10.3, 
      -14.5}, {-2.03, -3.17}, {7.97, 11.6}, {15.5, 19.4}, {24.3, 25}, {39, 30}, 
      {62.1, 33.5}, {80, 34.9}}, 
      smooth = Smooth.Bezier), 
      Line(
      points = {{-80, 45.1}, {-45.9, 48.7}, {-29.1, 52.9}, {-18.1, 58.6}, {-10.2, 
      65.8}, {-1.82, 77.2}, {0, 80}}, 
      smooth = Smooth.Bezier), 
      Line(
      points = {{0, -80}, {8.93, -67.2}, {17.1, -59.3}, {27.3, -53.6}, {42.1, -49.4}, 
      {69.9, -45.8}, {80, -45.1}}, 
      smooth = Smooth.Bezier), 
      Text(
      extent = {{-90, -46}, {-18, -94}}, 
      textColor = {192, 192, 192}, 
      textString = "atan2")}), 
      Documentation(info = "<html><p>
该模块将输出<strong>y</strong>计算为输入 <strong>u1</strong>除以输入<strong>u2</strong>的<em>反正切值</em>：
</p>
<pre><code >y = atan2( u1, u2 );</code></pre><p>
u1 和 u2 在同一时刻不得为零。 <strong>Atan2</strong>使用 u1 和 u2 的符号来构建 -180 deg ≤ y ≤ 180 度范围内的解， 而模块<strong>Atan</strong>则给出 -90 deg ≤ y ≤ 90 度范围内的解。
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Math/atan2.png\" alt=\"atan2.png\" data-href=\"\" style=\"\">
</p>
<p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"    ));
  end Atan2;

  block Sinh "输出输入值的双曲正弦值"
    extends Interfaces.SISO;
  equation
    y = Modelica.Math.sinh(u);
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Polygon(
      points = {{0, 90}, {-8, 68}, {8, 68}, {0, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Text(
      extent = {{-86, 80}, {-14, 32}}, 
      textColor = {192, 192, 192}, 
      textString = "sinh"), 
      Line(points = {{0, -80}, {0, 68}}, color = {192, 192, 192}), 
      Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), 
      Line(
      points = {{-80, -80}, {-76, -65.4}, {-71.2, -51.4}, {-65.5, -38.8}, {-59.1, -28.1}, 
      {-51.1, -18.7}, {-41.4, -11.4}, {-27.7, -5.5}, {-4.42, -0.653}, {24.5, 
      4.57}, {39, 10.1}, {49.4, 17.2}, {57.5, 25.9}, {63.9, 35.8}, {69.5, 47.4}, 
      {74.4, 60.4}, {78.4, 73.8}, {80, 80}}, 
      smooth = Smooth.Bezier), 
      Polygon(
      points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid)}), 
      Documentation(info="<html><p>
该模块将输出<strong>y</strong>计算为 输入<strong>u</strong>的<em>双曲正弦值</em>：
</p>
<blockquote><pre>
y = <strong>sinh</strong>( u );
</pre></blockquote>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/sinh.png\"
   alt=\"sinh.png\">
</div>
</html>"  ));
  end Sinh;

  block Cosh "输出输入值的双曲余弦值"
    extends Interfaces.SISO;
  equation
    y = Modelica.Math.cosh(u);
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Polygon(
      points = {{0, 90}, {-8, 68}, {8, 68}, {0, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{0, -80}, {0, 68}}, color = {192, 192, 192}), 
      Text(
      extent = {{4, 66}, {66, 20}}, 
      textColor = {192, 192, 192}, 
      textString = "cosh"), 
      Line(
      points = {{-80, 80}, {-77.6, 61.1}, {-74.4, 39.3}, {-71.2, 20.7}, {-67.1, 1.29}, 
      {-63.1, -14.6}, {-58.3, -29.8}, {-52.7, -43.5}, {-46.2, -55.1}, {-39, -64.3}, 
      {-30.2, -71.7}, {-18.9, -77.1}, {-4.42, -79.9}, {10.9, -79.1}, {23.7, -75.2}, 
      {34.2, -68.7}, {42.2, -60.6}, {48.6, -51.2}, {54.3, -40}, {59.1, -27.5}, 
      {63.1, -14.6}, {67.1, 1.29}, {71.2, 20.7}, {74.4, 39.3}, {77.6, 61.1}, {
      80, 80}}, 
      smooth = Smooth.Bezier), 
      Line(points = {{-90, -86.083}, {68, -86.083}}, color = {192, 192, 192}), 
      Polygon(
      points = {{90, -86.083}, {68, -78.083}, {68, -94.083}, {90, -86.083}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid)}), 
      Documentation(info="<html><p>
该模块将输出<strong>y</strong>计算为 输入<strong>u</strong>的<em>双曲余弦值</em>：
</p>
<pre><code >y = Cosh( u );
</pre>
<img src=\"modelica://Modelica/Resources/Images/Math/Cosh.png\" alt=\"sinh.png\" data-href=\"\" style=\"\"/></code><p>
<br>
</p>
</html>"  ));
  end Cosh;

  block Tanh "输出输入值的双曲正切值"
    extends Interfaces.SISO;
  equation
    y = Modelica.Math.tanh(u);
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Line(points = {{0, -90}, {0, 84}}, color = {192, 192, 192}), 
      Line(points = {{-100, 0}, {84, 0}}, color = {192, 192, 192}), 
      Line(
      points = {{-80, -80}, {-47.8, -78.7}, {-35.8, -75.7}, {-27.7, -70.6}, {-22.1, 
      -64.2}, {-17.3, -55.9}, {-12.5, -44.3}, {-7.64, -29.2}, {-1.21, -4.82}, 
      {6.83, 26.3}, {11.7, 42}, {16.5, 54.2}, {21.3, 63.1}, {26.9, 69.9}, {34.2, 
      75}, {45.4, 78.4}, {72, 79.9}, {80, 80}}, 
      smooth = Smooth.Bezier), 
      Polygon(
      points = {{0, 90}, {-8, 68}, {8, 68}, {0, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Text(
      extent = {{-88, 72}, {-16, 24}}, 
      textColor = {192, 192, 192}, 
      textString = "tanh"), 
      Polygon(
      points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid)}), 
      Documentation(info="<html><p>
该模块将输出<strong>y</strong>计算为 输入<strong>u</strong>的<em>双曲正切值</em>：
</p>
<blockquote><pre>
y = <strong>tanh</strong>( u );
</pre></blockquote>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/tanh.png\"
   alt=\"tanh.png\">
</div>
</html>"  ));
  end Tanh;

  block Exp "输出输入的指数函数（以e为底）"
    extends Interfaces.SISO;
  equation
    y = Modelica.Math.exp(u);
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Line(points = {{0, -80}, {0, 68}}, color = {192, 192, 192}), 
      Polygon(
      points = {{0, 90}, {-8, 68}, {8, 68}, {0, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Text(
      extent = {{-86, 50}, {-14, 2}}, 
      textColor = {192, 192, 192}, 
      textString = "exp"), 
      Line(points = {{-80, -80}, {-31, -77.9}, {-6.03, -74}, {10.9, -68.4}, {23.7, -61}, 
      {34.2, -51.6}, {43, -40.3}, {50.3, -27.8}, {56.7, -13.5}, {62.3, 2.23}, {
      67.1, 18.6}, {72, 38.2}, {76, 57.6}, {80, 80}}), 
      Line(
      points = {{-90, -80.3976}, {68, -80.3976}}, 
      color = {192, 192, 192}, 
      smooth = Smooth.Bezier), 
      Polygon(
      points = {{90, -80.3976}, {68, -72.3976}, {68, -88.3976}, {90, -80.3976}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid)}), 
      Documentation(info="<html><p>
该模块将输出<strong>y</strong> 计算为输入<strong>u</strong>的<em>指数</em>（基数为e）：
</p>
<blockquote><pre>
y = <strong>exp</strong>( u );
</pre></blockquote>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/exp.png\"
   alt=\"exp.png\">
</div>
</html>"    ));
  end Exp;

  block Power "输出输入的指数函数（以e为底）"
    extends Interfaces.SISO;
    parameter Real base = Modelica.Constants.e "幂的底数" annotation(Evaluate = true);
    parameter Boolean useExp = true "在执行中使用exp函数" annotation(Evaluate = true);
  equation
    y = if useExp then Modelica.Math.exp(u * Modelica.Math.log(base)) else base ^ u;
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Line(points = {{0, -80}, {0, 68}}, color = {192, 192, 192}), 
      Polygon(
      points = {{0, 90}, {-8, 68}, {8, 68}, {0, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Text(
      extent = {{-86, 50}, {-14, 2}}, 
      textColor = {192, 192, 192}, 
      textString = "^"), 
      Line(points = {{-80, -80}, {-31, -77.9}, {-6.03, -74}, {10.9, -68.4}, {23.7, -61}, 
      {34.2, -51.6}, {43, -40.3}, {50.3, -27.8}, {56.7, -13.5}, {62.3, 2.23}, {
      67.1, 18.6}, {72, 38.2}, {76, 57.6}, {80, 80}}), 
      Line(
      points = {{-90, -80.3976}, {68, -80.3976}}, 
      color = {192, 192, 192}, 
      smooth = Smooth.Bezier), 
      Polygon(
      points = {{90, -80.3976}, {68, -72.3976}, {68, -88.3976}, {90, -80.3976}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid)}), 
      Documentation(info="<html><p>
该模块将输出<strong>y</strong>计算为输入<strong>u</strong>以参数<em>base</em>为底的幂次方。 如果布尔参数<strong>useExp</strong>为真，则输出由以下方式决定：
</p>
<pre><code >y = exp ( u * log (base) )</code></pre><p>
否则:
</p>
<pre><code >y = base ^ u;</code></pre><p>
<br>
</p>
</html>"  ));
  end Power;
  block Pow "幂函数模块"
    extends Modelica.Blocks.Interfaces.SISO;
    parameter Boolean use_base_in = false "是否使用外接输入指数" annotation(Evaluate=true);
    parameter Real base = 0 "指数" annotation(Dialog(enable=not use_base_in),Evaluate=true);
    Modelica.Blocks.Interfaces.RealInput base_in if use_base_in "输入指数" 
      annotation (Placement(transformation(origin={-120,-60}, 
  extent={{-20,-20},{20,20}})));
  equation
    y =if use_base_in then u ^ base_in else u ^ base;
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
              100}}), graphics={
          Line(points={{0,-80},{0,68}}, color={192,192,192}), 
          Polygon(
            points={{0,90},{-8,68},{8,68},{0,90}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Text(
            extent={{-86,50},{-14,2}}, 
            textColor={192,192,192}, 
            textString="^"), 
          Line(points={{-80,-80},{-31,-77.9},{-6.03,-74},{10.9,-68.4},{23.7,-61}, 
                {34.2,-51.6},{43,-40.3},{50.3,-27.8},{56.7,-13.5},{62.3,2.23},{
                67.1,18.6},{72,38.2},{76,57.6},{80,80}}), 
          Line(
            points={{-90,-80.3976},{68,-80.3976}}, 
            color={192,192,192}, 
            smooth=Smooth.Bezier), 
          Polygon(
            points={{90,-80.3976},{68,-72.3976},{68,-88.3976},{90,-80.3976}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid)}), 
      Documentation(info="<html><p>
该模块为幂函数，底数为自变量u，幂为因变量y，指数为base
</p>
<pre><code >y = u ^ base;
</code></pre><p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"  ));
  end Pow;

  block Log 
    "输出输入值的对数(默认以e为底)(要求输入值>0)"

    extends Interfaces.SISO;
    parameter Real base = Modelica.Constants.e "对数底数" annotation(Evaluate = true);

  equation
    y = Modelica.Math.log(u) / Modelica.Math.log(base);
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Line(points = {{-80, -80}, {-80, 68}}, color = {192, 192, 192}), 
      Polygon(
      points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(
      points = {{-80, -80}, {-79.2, -50.6}, {-78.4, -37}, {-77.6, -28}, {-76.8, -21.3}, 
      {-75.2, -11.4}, {-72.8, -1.31}, {-69.5, 8.08}, {-64.7, 17.9}, {-57.5, 28}, 
      {-47, 38.1}, {-31.8, 48.1}, {-10.1, 58}, {22.1, 68}, {68.7, 78.1}, {80, 80}}, 
      smooth = Smooth.Bezier), 
      Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), 
      Polygon(
      points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Text(
      extent = {{-6, -24}, {66, -72}}, 
      textColor = {192, 192, 192}, 
      textString = "log")}), 
      Documentation(info="<html><p>
该模块将输出<strong>y</strong>计算为 输入<strong>u</strong>以e为底的<em>对数</em>：
</p>
<pre><code >y = log( u ) / log( base );</code></pre><p>
如果输入<strong>u</strong>为零或负值，则会出现错误。
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Math/log.png\" alt=\"log.png\" data-href=\"\" style=\"\">
</p>
<p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"));
  end Log;

  block Log10 "输出输入值以10为底数的对数(要求输入值>0)"

    extends Interfaces.SISO;
  equation
    y = Modelica.Math.log10(u);
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Polygon(
      points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), 
      Line(
      points = {{-79.8, -80}, {-79.2, -50.6}, {-78.4, -37}, {-77.6, -28}, {-76.8, -21.3}, 
      {-75.2, -11.4}, {-72.8, -1.31}, {-69.5, 8.08}, {-64.7, 17.9}, {-57.5, 28}, 
      {-47, 38.1}, {-31.8, 48.1}, {-10.1, 58}, {22.1, 68}, {68.7, 78.1}, {80, 80}}, 
      smooth = Smooth.Bezier), 
      Polygon(
      points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-80, -80}, {-80, 68}}, color = {192, 192, 192}), 
      Text(
      extent = {{-30, -22}, {60, -70}}, 
      textColor = {192, 192, 192}, 
      textString = "log10")}), 
      Documentation(info="<html><p>
该模块将输出<strong>y</strong>计算为输入<strong>u</strong>以<em>10 </em>为底的<em>对数</em>：
</p>
<pre><code >y = log10( u );</code></pre><p>
如果输入<strong>u</strong>为零或负值，则会出现错误。
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Math/log10.png\" alt=\"log10.png\" data-href=\"\" style=\"\">
</p>
<p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"));
  end Log10;

  block WrapAngle "将角度限制在区间[-pi,pi]或[0,2*pi]"

    extends Interfaces.SISO(u(unit = "rad"), y(unit = "rad"));
    parameter Boolean positiveRange = false "如果为真，只使用正输出范围";

  equation
    y = Modelica.Math.wrapAngle(u, positiveRange);
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Line(points = {{-80, 54}, {-80, 54}, {-60, 80}, {-60, -80}, {60, 80}, {60, -80}, {
      80, -52}}), 
      Polygon(
      points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), 
      Line(points = {{0, -80}, {0, 68}}, color = {192, 192, 192}), 
      Polygon(
      points = {{0, 90}, {-8, 68}, {8, 68}, {0, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid)}), 
      Documentation(info = "<html>
<p>
如果<code>positiveRange == false</code>，
则此模块会将输入的角度限制在区间 [-pi,pi] 中。
否则，输入的角度<code>u</code>将被限制到区间 [0,2*pi]。
</p>

</html>"));
  end WrapAngle;

  block RealToInteger "将实数信号转换为整数信号"
    extends Modelica.Blocks.Icons.IntegerBlock;
  public
    Interfaces.RealInput u "实数输入信号接口" annotation(
      Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
    Interfaces.IntegerOutput y "整数输出信号接口" annotation(
      Placement(transformation(extent = {{100, -10}, {120, 10}})));
  equation
    y = if (u > 0) then integer(floor(u + 0.5)) else integer(ceil(u - 0.5));
    annotation(Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100.0, -100.0}, {100.0, 100.0}}), graphics = {
      Text(
      textColor = {0, 0, 127}, 
      extent = {{-100.0, -40.0}, {0.0, 40.0}}, 
      textString = "R"), 
      Text(
      textColor = {255, 127, 0}, 
      extent = {{20.0, -40.0}, {120.0, 40.0}}, 
      textString = "I"), 
      Polygon(
      lineColor = {255, 127, 0}, 
      fillColor = {255, 127, 0}, 
      fillPattern = FillPattern.Solid, 
      points = {{50.0, 0.0}, {30.0, 20.0}, {30.0, 10.0}, {0.0, 10.0}, {0.0, -10.0}, {
      30.0, -10.0}, {30.0, -20.0}, {50.0, 0.0}})}), Documentation(info="<html><p>
该模块将输入<strong>u</strong>的输出<strong>y</strong>计算为<em>最接近的整数值 </em>：
</p>
<pre><code >y = integer( floor( u + 0.5 ) )  for  u &gt; 0;
y = integer( ceil ( u - 0.5 ) )  for  u &lt; 0;</code></pre><p>
<br>
</p>
</html>"));
  end RealToInteger;

  block IntegerToReal "将整数信号转换为实数信号"
    extends Modelica.Blocks.Icons.Block;
    Interfaces.IntegerInput u "整数输入信号接口" annotation(
      Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
    Interfaces.RealOutput y "实数输出信号接口" annotation(
      Placement(transformation(extent = {{100, -10}, {120, 10}})));
  equation
    y = u;
    annotation(Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100.0, -100.0}, {100.0, 100.0}}), graphics = {
      Text(
      textColor = {255, 127, 0}, 
      extent = {{-120.0, -40.0}, {-20.0, 40.0}}, 
      textString = "I"), 
      Text(
      textColor = {0, 0, 127}, 
      extent = {{0.0, -40.0}, {100.0, 40.0}}, 
      textString = "R"), 
      Polygon(
      lineColor = {0, 0, 127}, 
      fillColor = {0, 0, 127}, 
      fillPattern = FillPattern.Solid, 
      points = {{10.0, 0.0}, {-10.0, 20.0}, {-10.0, 10.0}, {-40.0, 10.0}, {-40.0, -10.0}, 
      {-10.0, -10.0}, {-10.0, -20.0}, {10.0, 0.0}})}), Documentation(info="<html><p>
该程序块将输出<strong>y</strong>计算为整数输入<strong>u</strong>的<em>实数值</em>：
</p>
<pre><code >y = u;</code></pre><p>
其中 <strong>u</strong> 为Integer型， <strong>y </strong>为 Real 型。
</p>
<p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"));
  end IntegerToReal;

  block BooleanToReal "将布尔信号转换为实数信号"
    extends Interfaces.partialBooleanSI;
    parameter Real realTrue = 1.0 "真布尔输入的输出信号";
    parameter Real realFalse = 0.0 "假布尔输入的输出信号";

    Blocks.Interfaces.RealOutput y "实数输出信号接口" 
      annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));

  equation
    y = if u then realTrue else realFalse;
    annotation(Documentation(info="<html><p>
该模块计算输出<strong>y</strong>，作为布尔输入<strong>u</strong>的<em>实数值</em>：
</p>
<pre><code >y = if u then realTrue else realFalse;</code></pre><p>
其中<strong>u</strong>为布尔类型，<strong>y</strong>为实数类型， <strong>realTrue</strong>和<strong>realFalse</strong>为参数。
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
      {100, 100}}), graphics = {
      Text(
      extent = {{-86, 92}, {-6, 10}}, 
      textColor = {255, 0, 255}, 
      textString = "B"), 
      Polygon(
      points = {{-12, -46}, {-32, -26}, {-32, -36}, {-64, -36}, {-64, -56}, {-32, -56}, 
      {-32, -66}, {-12, -46}}, 
      fillColor = {0, 0, 127}, 
      fillPattern = FillPattern.Solid, 
      lineColor = {0, 0, 127}), 
      Text(
      extent = {{8, -4}, {92, -94}}, 
      textString = "R", 
      textColor = {0, 0, 127})}));
  end BooleanToReal;

  block BooleanToInteger "将布尔信号转换为整数信号"
    extends Interfaces.partialBooleanSI;
    parameter Integer integerTrue = 1 "真布尔输入的输出信号";
    parameter Integer integerFalse = 0 "假布尔输入的输出信号";

    Blocks.Interfaces.IntegerOutput y "整数输出信号接口" 
      annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));

  equation
    y = if u then integerTrue else integerFalse;
    annotation(Documentation(info="<html><p>
该模块计算输出<strong>y</strong>，作为布尔输入<strong>u</strong>的<em>整数值</em>：
</p>
<pre><code >y = if u then integerTrue else integerFalse;</code></pre><p>
其中<strong>u</strong>为布尔类型，<strong>y</strong>为整数类型， <strong>integerTrue</strong>和<strong>integerFalse</strong>为参数。
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
      {100, 100}}), graphics = {
      Text(
      extent = {{-86, 92}, {-6, 10}}, 
      textColor = {255, 0, 255}, 
      textString = "B"), 
      Polygon(
      points = {{-12, -46}, {-32, -26}, {-32, -36}, {-64, -36}, {-64, -56}, {-32, -56}, 
      {-32, -66}, {-12, -46}}, 
      lineColor = {255, 170, 85}, 
      fillColor = {255, 170, 85}, 
      fillPattern = FillPattern.Solid), 
      Text(
      extent = {{8, -4}, {92, -94}}, 
      textColor = {255, 170, 85}, 
      textString = "I")}));
  end BooleanToInteger;

  block RealToBoolean "将实数信号转换为布尔信号"

    Blocks.Interfaces.RealInput u "实数输入信号接口" annotation(
      Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
    extends Interfaces.partialBooleanSO;
    parameter Real threshold = 0.5 
      "如果输入u>=临界值，则输出信号y为真";

  equation
    y = u >= threshold;
    annotation(Documentation(info="<html><p>
该模块通过公式计算实数输入<strong>u</strong>的布尔输出<strong>y</strong>：
</p>
<pre><code >y = u ≥ threshold;</code></pre><p>
其中<strong>threshold</strong>是一个参数。
</p>
<p>
<br>
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
      {100, 100}}), graphics = {
      Text(
      extent = {{-86, 92}, {-6, 10}}, 
      textColor = {0, 0, 127}, 
      textString = "R"), 
      Polygon(
      points = {{-12, -46}, {-32, -26}, {-32, -36}, {-64, -36}, {-64, -56}, {-32, -56}, 
      {-32, -66}, {-12, -46}}, 
      lineColor = {255, 0, 255}, 
      fillColor = {255, 0, 255}, 
      fillPattern = FillPattern.Solid), 
      Text(
      extent = {{8, -4}, {92, -94}}, 
      textColor = {255, 0, 255}, 
      textString = "B")}));
  end RealToBoolean;

  block IntegerToBoolean "将整数转换为布尔信号"

    Blocks.Interfaces.IntegerInput u "整数输入信号接口" 
      annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
    extends Interfaces.partialBooleanSO;
    parameter Integer threshold = 1 
      "如果输入u>=临界值，则输出信号y为真";

  equation
    y = u >= threshold;
    annotation(Documentation(info="<html><p>
该模块通过公式计算整数输入<strong>u</strong>的布尔输出<strong>y</strong>：
</p>
<pre><code >y = u ≥ threshold;</code></pre><p>
其中<strong>threshold</strong>是一个参数。
</p>
<p>
<br>
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
      {100, 100}}), graphics = {
      Text(
      extent = {{-86, 92}, {-6, 10}}, 
      textColor = {255, 128, 0}, 
      textString = "I"), 
      Polygon(
      points = {{-12, -46}, {-32, -26}, {-32, -36}, {-64, -36}, {-64, -56}, {-32, -56}, 
      {-32, -66}, {-12, -46}}, 
      lineColor = {255, 0, 255}, 
      fillColor = {255, 0, 255}, 
      fillPattern = FillPattern.Solid), 
      Text(
      extent = {{8, -4}, {92, -94}}, 
      textColor = {255, 0, 255}, 
      textString = "B")}));
  end IntegerToBoolean;

  block RectangularToPolar 
    "将直角坐标转换为极坐标"
    extends Modelica.Blocks.Icons.Block;
    Modelica.Blocks.Interfaces.RealInput u_re 
      "直角坐标的实部" annotation(Placement(
      transformation(extent = {{-140, 40}, {-100, 80}})));
    Modelica.Blocks.Interfaces.RealInput u_im 
      "直角坐标的虚部" annotation(Placement(
      transformation(extent = {{-140, -80}, {-100, -40}})));
    Modelica.Blocks.Interfaces.RealOutput y_abs 
      "极坐标长度" annotation(Placement(transformation(
      extent = {{100, 50}, {120, 70}})));
    Modelica.Blocks.Interfaces.RealOutput y_arg(unit = "rad") "极坐标角度" 
      annotation(Placement(transformation(extent = {{100, -70}, {120, -50}})));

  equation
    y_abs = sqrt(u_re * u_re + u_im * u_im);
    y_arg = Modelica.Math.atan2(u_im, u_re);
    annotation(Icon(graphics = {
      Text(
      extent = {{-90, 80}, {-20, 40}}, 
      textString = "re"), 
      Text(
      extent = {{-90, -40}, {-20, -80}}, 
      textString = "im"), 
      Text(
      extent = {{20, 80}, {90, 40}}, 
      textString = "abs"), 
      Text(
      extent = {{20, -40}, {90, -80}}, 
      textString = "arg")}), Documentation(info="<html><p>
该模块的输入值是二维相量的直角分量<code>u_re</code>和<code>u_im</code>。 该模块计算了该相量的极坐标表示的长度<code>y_abs</code>和角度<code>y_arg</code>。
</p>
<pre><code >y_abs = abs(u_re + j*u_im) = sqrt( u_re2 + u_im2 )
y_arg = arg(u_re + j*u_im) = atan2(u_im, u_re)</code></pre><p>
<br>
</p>
</html>"));
  end RectangularToPolar;

  block PolarToRectangular 
    "将极坐标转换为直角坐标"
    extends Modelica.Blocks.Icons.Block;
    Modelica.Blocks.Interfaces.RealInput u_abs "极坐标长度" 
      annotation(Placement(transformation(extent = {{-140, 40}, {-100, 80}})));
    Modelica.Blocks.Interfaces.RealInput u_arg(unit = "rad") "极坐标角度" 
      annotation(Placement(transformation(extent = {{-140, -80}, {-100, -40}})));
    Modelica.Blocks.Interfaces.RealOutput y_re 
      "直角坐标的实部" annotation(Placement(
      transformation(extent = {{100, 50}, {120, 70}})));
    Modelica.Blocks.Interfaces.RealOutput y_im 
      "直角坐标的虚部" annotation(Placement(
      transformation(extent = {{100, -70}, {120, -50}})));

  equation
    y_re = u_abs * Modelica.Math.cos(u_arg);
    y_im = u_abs * Modelica.Math.sin(u_arg);
    annotation(Icon(graphics = {
      Text(
      extent = {{-90, 80}, {-20, 40}}, 
      textString = "abs"), 
      Text(
      extent = {{-90, -40}, {-20, -80}}, 
      textString = "arg"), 
      Text(
      extent = {{20, 80}, {90, 40}}, 
      textString = "re"), 
      Text(
      extent = {{20, -40}, {90, -80}}, 
      textString = "im")}), Documentation(info="<html><p>
该模块的输入值是相量的极坐标分量<code>uabs</code>和<code>uarg</code>。 该模块计算了该相量的直角表示的分量<code>y_re</code>和<code>y_im</code>。
</p>
<pre><code >y_re = u_abs * cos( u_arg )
y_im = u_abs * sin( u_arg )</code></pre><p>
<br>
</p>
</html>"));
  end PolarToRectangular;

  block Mean "计算1/f期间的平均值"
    extends Modelica.Blocks.Interfaces.SISO;
    parameter SI.Frequency f(start = 50) "基础频率";
    parameter Real x0 = 0 "积分器状态的起始值";
    parameter Boolean yGreaterOrEqualZero = false 
      "=true，如果精确解的输出y保证>=0" 
      annotation(Evaluate = true, Dialog(tab = "高级"));
  protected
    parameter SI.Time t0(fixed = false) "仿真开始时间";
    Real x "积分器状态";
    discrete Real y_last "上次采样的平均值";
  initial equation
    t0 = time;
    x = x0;
    y_last = 0;
  equation
    der(x) = u;
    when sample(t0 + 1 / f, 1 / f) then
      y_last = if not yGreaterOrEqualZero then f * pre(x) else max(0.0, f * pre(x));
      reinit(x, 0);
    end when;
    y = y_last;
    annotation(Documentation(info="<html><p>
该模块计算输入信号 u 在给定周期 1/f 内的平均值：
</p>
<pre><code >1 T
- ∫ u(t) dt
T 0</code></pre><p>
注：每隔 1/f 定义的周期后，输出会更新。
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">如果“高级”选项卡中的参数 </span><span style=\"color: rgb(51, 51, 51);\"><strong>yGreaterOrEqualZero </strong></span><span style=\"color: rgb(51, 51, 51);\">为 </span><span style=\"color: rgb(51, 51, 51);\"><strong>true</strong></span><span style=\"color: rgb(51, 51, 51);\">（默认 = </span><span style=\"color: rgb(51, 51, 51);\"><strong>false</strong></span><span style=\"color: rgb(51, 51, 51);\">），则模型提供信息，表示输入信号的均值对于精确解来说保证大于或等于 0。然而，由于数值积分方案中的不准确性，输出可能略微为负。如果此参数设置为 true，则如果均值结果为负值，输出将明确设置为 0.0。</span>
</p>
<p>
<br>
</p>
</html>"), Icon(graphics = {Text(
      extent = {{-80, 60}, {80, 20}}, 
      textString = "mean"), Text(
      extent = {{-80, -20}, {80, -60}}, 
      textString = "f=%f")}));
  end Mean;

  block RectifiedMean "计算1/f期间的整流平均值"
    extends Modelica.Blocks.Interfaces.SISO;
    parameter SI.Frequency f(start = 50) "基础频率";
    parameter Real x0 = 0 "积分器状态的起始值";
    Mean mean(final f = f, final x0 = x0) 
      annotation(Placement(transformation(extent = {{0, -10}, {20, 10}})));
    Blocks.Math.Abs abs1 
      annotation(Placement(transformation(extent = {{-60, -10}, {-40, 10}})));
  equation
    connect(u, abs1.u) annotation(Line(
      points = {{-120, 0}, {-62, 0}}, color = {0, 0, 127}));
    connect(abs1.y, mean.u) annotation(Line(
      points = {{-39, 0}, {-2, 0}}, color = {0, 0, 127}));
    connect(mean.y, y) annotation(Line(
      points = {{21, 0}, {110, 0}}, color = {0, 0, 127}));
    annotation(Documentation(info = "<html>
<p>
该模块利用<a href=\"modelica://Modelica.Blocks.Math.Mean\">mean block</a>计算输入信号 u 在给定周期 1/f 内的整流平均值。
</p>
<p>
注：每隔 1/f 定义的周期后，输出会更新。
</p>
</html>"), Icon(graphics = {Text(
      extent = {{-80, 60}, {80, 20}}, 
      textString = "RM"), Text(
      extent = {{-80, -20}, {80, -60}}, 
      textString = "f=%f")}));
  end RectifiedMean;

  block ContinuousMean 
    "计算其输入信号的经验期望值(均值)"
    extends Modelica.Blocks.Icons.Block;
    parameter SI.Time t_eps(min = 100 * Modelica.Constants.eps) = 1e-7 
      "平均值计算从startTime+t_eps开始" 
      annotation(Dialog(group = "高级"));

    Modelica.Blocks.Interfaces.RealInput u "Noisy输入信号" annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
    Modelica.Blocks.Interfaces.RealOutput y 
      "输入信号的期望(均值)值" 
      annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));

  protected
    Real mu "内部积分器变量";
    parameter Real t_0(fixed = false) "起始时间";
  initial equation
    t_0 = time;
    mu = u;
  equation
    der(mu) = noEvent(if time >= t_0 + t_eps then (u - mu) / (time - t_0) else 0);
    y = noEvent(if time >= t_0 + t_eps then mu else u);

    annotation(Documentation(revisions = "<html>
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
</html>",info="<html><p>
该模块持续计算输入信号的平均值。它使用的函数是：
</p>
<pre><code >integral( u over time)
y = ------------------------
time - startTime</code></pre><p>
这可以用来确定随机信号的经验期望值， 比如由 <a href=\"modelica://Modelica.Blocks.Noise\" target=\"\">Noise</a> 模块生成的信号。
</p>
<p>
参数 t_eps 用于防止除以零 （均值计算从 &lt;<em>simulation start time</em>&gt; + t_eps 开始，在该时间点之前 y = u）。
</p>
<p>
另请参阅<a href=\"modelica://Modelica.Blocks.Math.Mean\" target=\"\">Mean</a>模块，了解抽样执行情况。
</p>
<p>
该模块在<a href=\"modelica://Modelica.Blocks.Examples.Noise.UniformNoiseProperties\" target=\"\">UniformNoiseProperties</a> 和<a href=\"modelica://Modelica.Blocks.Examples.Noise.NormalNoiseProperties\" target=\"\">NormalNoiseProperties</a>示例中进行了演示。
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"), Icon(coordinateSystem(
      preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), 
      graphics = {
      Polygon(
      points = {{94, 0}, {72, 8}, {72, -8}, {94, 0}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-86, 0}, {72, 0}}, color = {192, 192, 192}), 
      Line(points = {{-76, 68}, {-76, -80}}, color = {192, 192, 192}), 
      Polygon(
      points = {{-76, 90}, {-84, 68}, {-68, 68}, {-76, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(
      points = {{-76, -31}, {-62, -31}, {-62, -15}, {-54, -15}, {-54, -63}, {-46, -63}, 
      {-46, -41}, {-38, -41}, {-38, 43}, {-30, 43}, {-30, 11}, {-30, 11}, {-30, -49}, 
      {-20, -49}, {-20, -31}, {-10, -31}, {-10, -59}, {0, -59}, {0, 23}, {6, 23}, {6, 
      37}, {12, 37}, {12, -19}, {22, -19}, {22, -7}, {28, -7}, {28, -37}, {38, -37}, 
      {38, 35}, {48, 35}, {48, 1}, {56, 1}, {56, -65}, {66, -65}}, 
      color = {215, 215, 215}), 
      Line(
      points = {{-76, -24}, {70, -24}})}));
  end ContinuousMean;

  block RootMeanSquare "计算1/f期间的均方根"
    extends Modelica.Blocks.Interfaces.SISO;
    parameter SI.Frequency f(start = 50) "基础频率";
    parameter Real x0 = 0 "积分器状态的起始值";
    MultiProduct product(nu = 2) 
      annotation(Placement(transformation(extent = {{-40, -10}, {-20, 10}})));
    Mean mean(
      final f = f, 
      final yGreaterOrEqualZero = true, 
      final x0 = x0) 
      annotation(Placement(transformation(extent = {{0, -10}, {20, 10}})));
    Blocks.Math.Sqrt sqrt1 
      annotation(Placement(transformation(extent = {{40, -10}, {60, 10}})));
  equation

    connect(product.y, mean.u) annotation(Line(
      points = {{-18.3, 0}, {-2, 0}}, color = {0, 0, 127}));
    connect(mean.y, sqrt1.u) annotation(Line(
      points = {{21, 0}, {38, 0}}, color = {0, 0, 127}));
    connect(sqrt1.y, y) annotation(Line(
      points = {{61, 0}, {110, 0}}, color = {0, 0, 127}));
    connect(u, product.u[1]) annotation(Line(
      points = {{-120, 0}, {-60, 0}, {-60, 3.5}, {-40, 3.5}}, color = {0, 0, 127}));
    connect(u, product.u[2]) annotation(Line(
      points = {{-120, 0}, {-60, 0}, {-60, -3.5}, {-40, -3.5}}, color = {0, 0, 127}));
    annotation(Documentation(info="<html><p>
该模块利用<a href=\"modelica://Modelica.Blocks.Math.Mean\" target=\"\">mean block</a>计算输入信号 u 在给定周期 1/f 内的均方根。
</p>
<p>
注：输出在 1/f 所定义的每个周期后更新。
</p>
</html>"), Icon(graphics = {Text(
      extent = {{-80, 60}, {80, 20}}, 
      textString = "RMS"), Text(
      extent = {{-80, -20}, {80, -60}}, 
      textString = "f=%f")}));
  end RootMeanSquare;

  block Variance "计算输入信号的经验方差"
    extends Modelica.Blocks.Icons.Block;
    parameter SI.Time t_eps(min = 100 * Modelica.Constants.eps) = 1e-7 
      "方差计算从startTime+t_eps开始" 
      annotation(Dialog(group = "高级"));

    Modelica.Blocks.Interfaces.RealInput u "Noisy输入信号" annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
    Modelica.Blocks.Interfaces.RealOutput y "输入信号的方差" 
      annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));
  protected
    Real mu "均值(状态变量)";
    Real var "方差(状态变量)";
    parameter Real t_0(fixed = false) "起始时间";
  initial equation
    t_0 = time;
    mu = u;
    var = 0;
  equation
    der(mu) = noEvent(if time >= t_0 + t_eps then (u - mu) / (time - t_0) else 0);
    der(var) = noEvent(if time >= t_0 + t_eps then ((u - mu) ^ 2 - var) / (time - t_0) else 0);
    y = noEvent(if time >= t_0 + t_eps then max(var, 0) else 0);

    annotation(Documentation(revisions = "<html>
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
</html>",info="<html><p>
该模块计算输入信号的经验方差。 它以公式为基础（但以更可靠的数值方式实现）：
</p>
<pre><code >y = mean(  (u - mean(u))^2  )</code></pre><p>
参数 t_eps 用于防止除以零（方差计算从 &lt;<em>simulation start time</em>&gt; + t_eps 开始，在该时间点之前 y = 0）。
</p>
<p>
信号的方差也等于其平均功率。
</p>
<p>
该模块在示例<a href=\"modelica://Modelica.Blocks.Examples.Noise.UniformNoiseProperties\" target=\"\">UniformNoiseProperties</a> 和<a href=\"modelica://Modelica.Blocks.Examples.Noise.NormalNoiseProperties\" target=\"\">NormalNoiseProperties</a>中有演示。
</p>
<p>
<br>
</p>
</html>"), 
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Line(points = {{-76, 68}, {-76, -80}}, color = {192, 192, 192}), 
      Line(points = {{-86, 0}, {72, 0}}, color = {192, 192, 192}), 
      Line(
      points = {{-76, -13}, {-62, -13}, {-62, 3}, {-54, 3}, {-54, -45}, {-46, -45}, {-46, 
      -23}, {-38, -23}, {-38, 61}, {-30, 61}, {-30, 29}, {-30, 29}, {-30, -31}, {-20, 
      -31}, {-20, -13}, {-10, -13}, {-10, -41}, {0, -41}, {0, 41}, {6, 41}, {6, 55}, 
      {12, 55}, {12, -1}, {22, -1}, {22, 11}, {28, 11}, {28, -19}, {38, -19}, {38, 53}, 
      {48, 53}, {48, 19}, {56, 19}, {56, -47}, {66, -47}}, 
      color = {215, 215, 215}), 
      Polygon(
      points = {{94, 0}, {72, 8}, {72, -8}, {94, 0}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(
      points = {{-76, 66}, {70, 66}}, 
      color = {215, 215, 215}), 
      Line(
      points = {{-16, 0}, {-16, 48}}), 
      Polygon(
      points = {{-76, 90}, {-84, 68}, {-68, 68}, {-76, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Polygon(
      points = {{-16, 66}, {-24, 44}, {-8, 44}, {-16, 66}}, 
      fillPattern = FillPattern.Solid)}));
  end Variance;

  block StandardDeviation 
    "计算输入信号的经验标准偏差"
    extends Modelica.Blocks.Icons.Block;
    parameter SI.Time t_eps(min = 100 * Modelica.Constants.eps) = 1e-7 
      "标准偏差计算从startTime+t_eps开始" 
      annotation(Dialog(group = "高级"));

    Modelica.Blocks.Interfaces.RealInput u "Noisy输入信号" annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
    Modelica.Blocks.Interfaces.RealOutput y 
      "输入信号的标准偏差" 
      annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));

    Modelica.Blocks.Math.Variance variance(t_eps = t_eps) 
      annotation(Placement(transformation(extent = {{-60, -10}, {-40, 10}})));
    Modelica.Blocks.Math.Sqrt sqrt1 
      annotation(Placement(transformation(extent = {{-20, -10}, {0, 10}})));
  equation
    connect(variance.u, u) annotation(Line(
      points = {{-62, 0}, {-120, 0}}, color = {0, 0, 127}));
    connect(sqrt1.u, variance.y) annotation(Line(
      points = {{-22, 0}, {-39, 0}}, color = {0, 0, 127}));
    connect(sqrt1.y, y) annotation(Line(
      points = {{1, 0}, {110, 0}}, color = {0, 0, 127}));
    annotation(Documentation(revisions = "<html>
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
</html>",info="<html><p>
该模块计算其输入信号的标准差。 标准差是信号方差的平方根：
</p>
<pre><code >y = sqrt( variance(u) )</code></pre><p>
<a href=\"modelica://Modelica.Blocks.Math.Variance\" target=\"\">Variance</a>模块用于计算方差（u）。
</p>
<p>
参数 t_eps 用于防止除以零（标准差的计算从 &lt;<em>simulation start time</em>&gt; + t_eps 开始，在该时间点之前 y = 0）。
</p>
<p>
<a href=\"modelica://Modelica.Blocks.Examples.Noise.UniformNoiseProperties\" target=\"\">UniformNoiseProperties</a> 和<a href=\"modelica://Modelica.Blocks.Examples.Noise.NormalNoiseProperties\" target=\"\">NormalNoiseProperties</a>示例中演示了该模块。
</p>
<p>
<br>
</p>
</html>"), 
      Icon(graphics = {
      Line(points = {{-76, 68}, {-76, -80}}, color = {192, 192, 192}), 
      Line(points = {{-86, 0}, {72, 0}}, color = {192, 192, 192}), 
      Line(
      points = {{-76, -13}, {-62, -13}, {-62, 3}, {-54, 3}, {-54, -45}, {-46, -45}, {-46, 
      -23}, {-38, -23}, {-38, 61}, {-30, 61}, {-30, 29}, {-30, 29}, {-30, -31}, {-20, 
      -31}, {-20, -13}, {-10, -13}, {-10, -41}, {0, -41}, {0, 41}, {6, 41}, {6, 55}, 
      {12, 55}, {12, -1}, {22, -1}, {22, 11}, {28, 11}, {28, -19}, {38, -19}, {38, 53}, 
      {48, 53}, {48, 19}, {56, 19}, {56, -47}, {66, -47}}, 
      color = {215, 215, 215}), 
      Polygon(
      points = {{94, 0}, {72, 8}, {72, -8}, {94, 0}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(
      points = {{-76, 46}, {70, 46}}, 
      color = {215, 215, 215}), 
      Line(
      points = {{-16, 0}, {-16, 30}}), 
      Polygon(
      points = {{-76, 90}, {-84, 68}, {-68, 68}, {-76, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Polygon(
      points = {{-16, 46}, {-24, 24}, {-8, 24}, {-16, 46}}, 
      fillPattern = FillPattern.Solid)}));
  end StandardDeviation;

  block Harmonic "计算1/f期间的谐波"
    extends Modelica.Blocks.Icons.Block;
    parameter SI.Frequency f(start = 50) "基础频率";
    parameter Integer k(start = 1) "谐波阶数";
    parameter Boolean useConjugateComplex = false 
      "为真时给出共轭复数结果" 
      annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
    parameter Real x0Cos = 0 "cos积分器状态的起始值";
    parameter Real x0Sin = 0 "sin积分器状态的起始值";
    Sources.Cosine sin1(
      final amplitude = sqrt(2), 
      final f = k * f, 
      final phase = 0) annotation(Placement(transformation(
      extent = {{-10, -10}, {10, 10}}, 
      rotation = 270, 
      origin = {-80, 70})));
    Blocks.Sources.Sine sin2(
      final amplitude = sqrt(2), 
      final phase = 0, 
      final f = k * f) annotation(Placement(transformation(
      extent = {{-10, -10}, {10, 10}}, 
      rotation = 90, 
      origin = {-80, -70})));
    MultiProduct product1(nu = 2) 
      annotation(Placement(transformation(extent = {{-60, 30}, {-40, 50}})));
    MultiProduct product2(nu = 2) 
      annotation(Placement(transformation(extent = {{-60, -50}, {-40, -30}})));
    Mean mean1(final f = f, final x0 = x0Cos) 
      annotation(Placement(transformation(extent = {{-20, 30}, {0, 50}})));
    Mean mean2(final f = f, final x0 = x0Sin) 
      annotation(Placement(transformation(extent = {{-20, -50}, {0, -30}})));
    Blocks.Interfaces.RealInput u 
      annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
    Blocks.Interfaces.RealOutput y_rms 
      "极坐标表示的均方根" annotation(Placement(
      transformation(extent = {{100, 50}, {120, 70}})));
    Blocks.Interfaces.RealOutput y_arg(unit = "rad") "极坐标角度" 
      annotation(Placement(transformation(extent = {{100, -70}, {120, -50}})));
    Blocks.Math.RectangularToPolar rectangularToPolar 
      annotation(Placement(transformation(extent = {{40, -12}, {60, 8}})));
    Gain gain(final k = if useConjugateComplex then -1 else 1) annotation(Placement(transformation(
      extent = {{-10, -10}, {10, 10}}, 
      rotation = 270, 
      origin = {80, -30})));
  equation

    connect(product2.y, mean2.u) annotation(Line(
      points = {{-38.3, -40}, {-22, -40}}, color = {0, 0, 127}));
    connect(product1.y, mean1.u) annotation(Line(
      points = {{-38.3, 40}, {-22, 40}}, color = {0, 0, 127}));
    connect(mean1.y, rectangularToPolar.u_re) annotation(Line(
      points = {{1, 40}, {20, 40}, {20, 4}, {38, 4}}, color = {0, 0, 127}));
    connect(mean2.y, rectangularToPolar.u_im) annotation(Line(
      points = {{1, -40}, {20, -40}, {20, -8}, {38, -8}}, color = {0, 0, 127}));
    connect(rectangularToPolar.y_abs, y_rms) annotation(Line(
      points = {{61, 4}, {80, 4}, {80, 60}, {110, 60}}, color = {0, 0, 127}));
    connect(sin1.y, product1.u[1]) annotation(Line(
      points = {{-80, 59}, {-80, 59}, {-80, 43.5}, {-60, 43.5}}, color = {0, 0, 127}));
    connect(u, product1.u[2]) annotation(Line(
      points = {{-120, 0}, {-80, 0}, {-80, 36.5}, {-60, 36.5}}, color = {0, 0, 127}));
    connect(u, product2.u[1]) annotation(Line(
      points = {{-120, 0}, {-80, 0}, {-80, -36.5}, {-60, -36.5}}, color = {0, 0, 127}));
    connect(sin2.y, product2.u[2]) annotation(Line(
      points = {{-80, -59}, {-80, -43.5}, {-60, -43.5}}, color = {0, 0, 127}));
    connect(rectangularToPolar.y_arg, gain.u) 
      annotation(Line(points = {{61, -8}, {80, -8}, {80, -18}}, color = {0, 0, 127}));
    connect(gain.y, y_arg) 
      annotation(Line(points = {{80, -41}, {80, -60}, {110, -60}}, color = {0, 0, 127}));
    annotation(Documentation(info = "<html>
<p>
该模块利用<a href=\"modelica://Modelica.Blocks.Math.Mean\">mean block</a>
计算输入信号 u 在给定周期 1/f 内的单次谐波<em>k</em>的均方根和相位角。
</p>
<p>
注：每隔 1/f 定义的周期后，输出会更新。
</p>
<p>
注:<br>
如果 useConjugateComplex=false(default)，谐波的定义为<code>&radic;2 rms cos(k 2 &pi; f t - arg)</code><br>
如果 useConjugateComplex=true，谐波的定义为<code>&radic;2 rms cos(k 2 &pi; f t + arg)</code>
</p>
</html>"), Icon(graphics = {
      Text(
      extent = {{-80, 60}, {80, 20}}, 
      textString = "H%k"), 
      Text(
      extent = {{-80, -20}, {80, -60}}, 
      textString = "f=%f"), 
      Text(
      extent = {{20, 100}, {100, 60}}, 
      textString = "rms"), 
      Text(
      extent = {{20, -60}, {100, -100}}, 
      textString = "arg")}));
  end Harmonic;

  block TotalHarmonicDistortion "输出总谐波失真(THD)"
    extends Interfaces.SISO;
    parameter SI.Frequency f(start = 1) "基础频率";
    parameter Boolean useFirstHarmonic = true "如果为真，与一次谐波有关的THD，否则与总RMS有关";

    Harmonic harmonic(
      final f = f, 
      final k = 1, 
      final x0Cos = 0, 
      final x0Sin = 0) annotation(Placement(transformation(extent = {{-70, -62}, {-50, -42}})));
    RootMeanSquare rootMeanSquare(final f = f, final x0 = 0) annotation(Placement(transformation(extent = {{-70, 20}, {-50, 40}})));
    Logical.GreaterThreshold greaterThreshold annotation(Placement(transformation(extent = {{10, -70}, {30, -50}})));
    Interfaces.BooleanOutput valid "True, if output y is valid" annotation(Placement(transformation(extent = {{100, -70}, {120, -50}})));
    Division division annotation(Placement(transformation(extent = {{60, -10}, {80, 10}})));
    Nonlinear.Limiter limiter(uMin = Modelica.Constants.eps, uMax = Modelica.Constants.inf) annotation(Placement(transformation(extent = {{10, -30}, {30, -10}})));
    Pythagoras pythagoras(u1IsHypotenuse = true) annotation(Placement(transformation(extent = {{10, 0}, {30, 20}})));
    Logical.And andValid annotation(Placement(transformation(extent = {{60, -50}, {80, -30}})));
    Sources.BooleanExpression booleanExpression(final y = not useFirstHarmonic) annotation(Placement(transformation(extent = {{-70, -30}, {-50, -10}})));
    Logical.Switch switch1 annotation(Placement(transformation(extent = {{-20, -30}, {0, -10}})));
  equation
    connect(u, rootMeanSquare.u) annotation(Line(points = {{-120, 0}, {-90, 0}, {-90, 30}, {-72, 30}}, color = {0, 0, 127}));
    connect(u, harmonic.u) annotation(Line(points = {{-120, 0}, {-90, 0}, {-90, -52}, {-72, -52}}, color = {0, 0, 127}));
    connect(harmonic.y_rms, greaterThreshold.u) annotation(Line(points = {{-49, -46}, {-40, -46}, {-40, -60}, {8, -60}}, color = {0, 0, 127}));
    connect(division.y, y) annotation(Line(points = {{81, 0}, {110, 0}}, color = {0, 0, 127}));
    connect(pythagoras.u1, rootMeanSquare.y) annotation(Line(points = {{8, 16}, {-30, 16}, {-30, 30}, {-49, 30}}, color = {0, 0, 127}));
    connect(pythagoras.y, division.u1) annotation(Line(points = {{31, 10}, {50, 10}, {50, 6}, {58, 6}}, color = {0, 0, 127}));
    connect(pythagoras.valid, andValid.u1) annotation(Line(points = {{31, 4}, {40, 4}, {40, -40}, {58, -40}}, color = {255, 0, 255}));
    connect(greaterThreshold.y, andValid.u2) annotation(Line(points = {{31, -60}, {40, -60}, {40, -48}, {58, -48}}, color = {255, 0, 255}));
    connect(andValid.y, valid) annotation(Line(points = {{81, -40}, {90, -40}, {90, -60}, {110, -60}}, color = {255, 0, 255}));
    connect(limiter.y, division.u2) annotation(Line(points = {{31, -20}, {50, -20}, {50, -6}, {58, -6}}, color = {0, 0, 127}));
    connect(harmonic.y_rms, pythagoras.u2) annotation(Line(points = {{-49, -46}, {-40, -46}, {-40, 4}, {8, 4}}, color = {0, 0, 127}));
    connect(switch1.u1, rootMeanSquare.y) annotation(Line(points = {{-22, -12}, {-30, -12}, {-30, 30}, {-49, 30}}, color = {0, 0, 127}));
    connect(harmonic.y_rms, switch1.u3) annotation(Line(points = {{-49, -46}, {-40, -46}, {-40, -28}, {-22, -28}}, color = {0, 0, 127}));
    connect(booleanExpression.y, switch1.u2) annotation(Line(points = {{-49, -20}, {-22, -20}}, color = {255, 0, 255}));
    connect(switch1.y, limiter.u) annotation(Line(points = {{1, -20}, {8, -20}}, color = {0, 0, 127}));
    annotation(defaultComponentName = "thd", 
      Icon(coordinateSystem(grid = {2, 2}), graphics = {
      Line(points = {{-80, -80}, {-80, 68}}, color = {192, 192, 192}), 
      Polygon(
      points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), 
      Polygon(
      points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Polygon(
      points = {{-80, 0}, {-69, 34}, {-62, 53}, {-55, 68}, {-50, 75}, {-44, 79}, {-38, 80}, {-32, 76}, {-27, 70}, {-21, 59}, {-15, 44}, {-7, 21}, {10, -31}, {17, -50}, {24, -64}, {29, -73}, {35, -78}, {41, -81}, {46, -78}, {52, -71}, {57, -62}, {64, -47}, {72, -25}, {80, 0}, {72, -53}, {59, -37}, {46, -95}, {34, -53}, {22, -81}, {10, -10}, {-3, -27}, {-13, 63}, {-26, 46}, {-26, 48}, {-38, 94}, {-51, 49}, {-59, 80}, {-65, 18}, {-75, 38}, {-80, 0}}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Text(
      extent = {{2, 80}, {82, 20}}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid, 
      textString = "1", 
      visible = useFirstHarmonic), 
      Text(
      extent = {{2, 80}, {82, 20}}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid, 
      textString = "rms", 
      visible = not useFirstHarmonic), 
      Text(
      extent = {{-150, -110}, {150, -150}}, 
      textString = "f=%f")}), Documentation(info="<html><p>
该模块确定给定周期 <code>1/f</code> 内的总谐波失真（THD）。 考虑到输入 <code>u</code> 包含谐波 RMS 分量 <sub><code>U1</code></sub>, <sub><code>U2</code></sub>, <sub><code>U3</code></sub> 等等。 总 RMS 分量然后由以下公式确定：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Math/Urms.png\" alt=\"\" data-href=\"\" style=\"\">
</p>
<p>
总谐波失真的计算基于参数 <code>useFirstHarmonic</code>。 默认值 <code>useFirstHarmonic = true</code> 表示在 <a href=\"http://www.electropedia.org/iev/iev.nsf/display?openform&ievref=551-20-13\" target=\"\">electrical engineering</a>&nbsp; 中使用的<span style=\"color: rgb(51, 51, 51);\"><strong>标准</strong></span>THD 计算。 非默认值 <code>useFirstHarmonic = false</code> 计算通常用于评估音频信号的 THD。
</p>
<p>
如果 <code>useFirstHarmonic = true</code>，总高谐波内容（谐波阶数 &gt; 1）指的是基波的 RMS 值：
</p>
<p style=\"text-align: center;\"><br> <img src=\"modelica://Modelica/Resources/Images/Blocks/Math/THD1.png\" alt=\"\" data-href=\"\" style=\"\">
</p>
<p>
如果 <code>useFirstHarmonic = false</code>，总高谐波内容（谐波阶数 &gt; 1）指的是总 RMS：
</p>
<p style=\"text-align: center;\"><br> <img src=\"modelica://Modelica/Resources/Images/Blocks/Math/THDrms.png\" alt=\"\" data-href=\"\" style=\"\">
</p>
<p>
如果输入信号为零或在计算的第一周期内，布尔输出信号<code>valid</code>变为<code>false</code>， 表示计算结果无效。有效的计算用<code>valid = true 。</code>
</p>
</html>"));
  end TotalHarmonicDistortion;

  block RealFFT "输入u的采样和FFT"
    extends Modelica.Blocks.Interfaces.DiscreteBlock(final samplePeriod = 1 / (2 * f_res * div(ns, 2)));
    parameter SI.Frequency f_max "最大频率";
    parameter SI.Frequency f_res "频率分辨率";
    final parameter Integer ns = Modelica.Math.FastFourierTransform.realFFTsamplePoints(f_max, f_res, f_max_factor = 5) "Number of samples";
    final parameter Integer nf = max(1, min(integer(ceil(f_max / f_res)) + 1, div(ns, 2))) "频率点数";
    parameter String resultFileName = "realFFT.mat" "结果文件：f、abs、arg";
    output Integer info(start = 0, fixed = true) "来自FFT计算的信息标志";
    Modelica.Blocks.Interfaces.RealInput u 
      annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}}), iconTransformation(extent = {{-140, 
      -20}, {-100, 20}})));
  protected
    Real buf[ns](start = zeros(ns), each fixed = true) "输入缓冲器";
    Real abs[nf](start = zeros(nf), each fixed = true) "FFT振幅";
    Real arg[nf](start = zeros(nf), each fixed = true) "FFT相位";
    Integer iTick(start = 0, fixed = true) "采样时刻";
  algorithm
    when {sampleTrigger} then
      iTick := pre(iTick) + 1;
      if iTick <= ns then
        buf[iTick] := u;
      end if;
    end when;
    when terminal() then
      if iTick < ns then
        assert(false, "Sampling time not sufficient! stopTime>= " + String(startTime + (ns - 1) * samplePeriod));
      else
        (info,abs,arg) := Modelica.Math.FastFourierTransform.realFFT(buf, nf);
        assert(info == 0, "Error in FFT");
        Modelica.Math.FastFourierTransform.realFFTwriteToFile(startTime + (ns - 1) * samplePeriod, resultFileName, f_max, abs, arg);
      end if;
    end when;
    annotation(Documentation(info = "<html>
<p>
该模块对输入信号进行采样，
通过函数<a href=\"modelica://Modelica.Math.FastFourierTransform.realFFT\">Math.realFFT</a>计算快速傅立叶变换，
并（在模拟结束时）通过函数<a href=\"modelica://Modelica.Math.FastFourierTransform.realFFTwriteToFile\">Math.realFFTwriteToFile</a>将输出写入结果文件 resultFileName。
</p>
<p>
采样点数和采样周期根据所需的最大频率 f_max 和频率分辨率 f_res 计算得出。
</p>
<h4>注释</h4>
<p>
用户必须确保在模拟结束前采样到足够的点：startTime + (ns - 1)*samplePeriod <= stopTime。
</p>
<p>
结果文件以 mat 格式写入，第一列为频率，第二列为幅度，第三列为相位。
频率点由幅度和相位均为 0 的行分隔，因此可以直接绘制结果为频率线。
</p>
</html>"), Icon(graphics = {Polygon(
      points = {{-80, 96}, {-86, 80}, {-74, 80}, {-80, 96}}, 
      lineColor = {135, 135, 135}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), Line(
      points = {{-80, -92}, {-80, 80}}, 
      color = {135, 135, 135}), 
      Line(points = {{-92, -80}, {80, 
      -80.3976}}, 
      color = {135, 135, 135}), Polygon(
      points = {{96, -80.3976}, {80, -74.3976}, {80, -86.3976}, {96, -80.3976}}, 
      lineColor = {135, 135, 135}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(
      points = {{-70, 60}, {-70, -80}}, 
      thickness = 0.5), 
      Line(
      points = {{-30, -52}, {-30, -80}}, 
      thickness = 0.5), 
      Line(
      points = {{-10, -60}, {-10, -80}}, 
      thickness = 0.5), 
      Line(
      points = {{30, -68}, {30, -80}}, 
      thickness = 0.5), 
      Line(
      points = {{50, -70}, {50, -80}}, 
      thickness = 0.5)}));
  end RealFFT;
  block RealFFTWithOutput "输入u的采样和FFT"
    extends Modelica.Blocks.Interfaces.DiscreteBlock(final samplePeriod = 1 / (2 * f_res * div(ns, 2)));
    parameter Units.SI.Frequency f_max "最大频率";
    parameter Units.SI.Frequency f_res "频率分辨率";
    final parameter Integer ns = Modelica.Math.FastFourierTransform.realFFTsamplePoints(f_max, f_res, f_max_factor = 5) "Number of samples";
    final parameter Integer nf = max(1, min(integer(ceil(f_max / f_res)) + 1, div(ns, 2))) "频率点数";
    parameter String resultFileName = "realFFT.mat" "结果文件：f、abs、arg";
    output Integer info(start = 0, fixed = true) "来自FFT计算的信息标志";
    Modelica.Blocks.Interfaces.RealInput u 
      annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}}), iconTransformation(extent = {{-140, 
      -20}, {-100, 20}})));
  protected
    Real buf[ns](start = zeros(ns), each fixed = true) "输入缓冲器";
    Real abs[nf](start = zeros(nf), each fixed = true) "FFT振幅";
    Real arg[nf](start = zeros(nf), each fixed = true) "FFT相位";
    Integer iTick(start = 0, fixed = true) "采样时刻";
  public
    Interfaces.RealOutput y_amplitudes[nf] 
      annotation (Placement(transformation(origin={110,60}, 
  extent={{-10,-10},{10,10}})));
    Interfaces.RealOutput y_phases[nf] 
      annotation (Placement(transformation(origin={110,-50}, 
  extent={{-10,-10},{10,10}})));
  algorithm
    when {sampleTrigger} then
      iTick := pre(iTick) + 1;
      if iTick <= ns then
        buf[iTick] := u;
      end if;
    end when;
    when terminal() then
      if iTick < ns then
        assert(false, "Sampling time not sufficient! stopTime>= " + String(startTime + (ns - 1) * samplePeriod));
      else
        (info,abs,arg) := Modelica.Math.FastFourierTransform.realFFT(buf, nf);
        assert(info == 0, "Error in FFT");
        Modelica.Math.FastFourierTransform.realFFTwriteToFile(startTime + (ns - 1) * samplePeriod, resultFileName, f_max, abs, arg);
      end if;
    end when;
  equation
    abs=y_amplitudes;
    arg=y_phases;
    annotation(Documentation(info = "<html>
<p>
该模块对输入信号进行采样，
通过函数<a href=\"modelica://Modelica.Math.FastFourierTransform.realFFT\">Math.realFFT</a>计算快速傅立叶变换，
并（在模拟结束时）通过函数<a href=\"modelica://Modelica.Math.FastFourierTransform.realFFTwriteToFile\">Math.realFFTwriteToFile</a>将输出写入结果文件 resultFileName。
</p>
<p>
采样点数和采样周期根据所需的最大频率 f_max 和频率分辨率 f_res 计算得出。
</p>
<h4>注释</h4>
<p>
用户必须确保在模拟结束前采样到足够的点：startTime + (ns - 1)*samplePeriod <= stopTime。
</p>
<p>
结果文件以 mat 格式写入，第一列为频率，第二列为幅度，第三列为相位。
频率点由幅度和相位均为 0 的行分隔，因此可以直接绘制结果为频率线。
</p>
</html>"    ), Icon(graphics = {Polygon(
      points = {{-80, 96}, {-86, 80}, {-74, 80}, {-80, 96}}, 
      lineColor = {135, 135, 135}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), Line(
      points = {{-80, -92}, {-80, 80}}, 
      color = {135, 135, 135}), 
      Line(points = {{-92, -80}, {80, 
      -80.3976}}, 
      color = {135, 135, 135}), Polygon(
      points = {{96, -80.3976}, {80, -74.3976}, {80, -86.3976}, {96, -80.3976}}, 
      lineColor = {135, 135, 135}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(
      points = {{-70, 60}, {-70, -80}}, 
      thickness = 0.5), 
      Line(
      points = {{-30, -52}, {-30, -80}}, 
      thickness = 0.5), 
      Line(
      points = {{-10, -60}, {-10, -80}}, 
      thickness = 0.5), 
      Line(
      points = {{30, -68}, {30, -80}}, 
      thickness = 0.5), 
      Line(
      points = {{50, -70}, {50, -80}}, 
      thickness = 0.5)}));
  end RealFFTWithOutput;

  block Pythagoras "确定直角三角形的斜边或边长"
    extends Interfaces.SI2SO;
    parameter Boolean u1IsHypotenuse = false "=为真，如果u1是斜边，y是一条边";
    Interfaces.BooleanOutput valid "=真，如果y是有效结果" annotation(Placement(transformation(extent = {{100, -70}, {120, -50}})));
  protected
    Real y2 "y 的平方";
  equation
    if not u1IsHypotenuse then
      y2 = u1 ^ 2 + u2 ^ 2;
      y = sqrt(y2);
      valid = true;
    else
      y2 = u1 ^ 2 - u2 ^ 2;
      valid = y2 >= 0;
      y = if noEvent(y2 >= 0) then sqrt(y2) else 0;
    end if;

    annotation(Icon(graphics = {
      Polygon(
      points = {{34, -80}, {34, 80}, {-36, -40}, {34, -80}}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(
      points = {{-100, 60}, {22, 60}}, 
      pattern = LinePattern.Dash), 
      Line(
      points = {{34, 0}, {100, 0}}, 
      pattern = LinePattern.Dash), 
      Line(
      points = {{-100, -60}, {0, -60}}, 
      pattern = LinePattern.Dash), 
      Line(
      visible = u1IsHypotenuse, 
      points = {{22, 60}, {34, 60}}, 
      pattern = LinePattern.Dash), 
      Line(
      visible = u1IsHypotenuse, 
      points = {{-12, 0}, {34, 0}}, 
      pattern = LinePattern.Dash)}), Documentation(info = "<html>
<p>如果布尔参数<code>u1IsHyotenuse = false</code>，
则该代码块将确定斜边<code>y = sqrt(u1^2 + u2^2)</code>。
在这种情况下，两个输入<code>u1</code>和<code>u2</code>被解释为直角三角形的两边，
布尔输出<code>valid</code>始终等于<code>true</code>。
</p>

<p>如果<code>u1IsHyotenuse = true</code>，则输入的<code>u1</code>被解释为斜边，
而<code>u2</code>是直角三角形的两条边之一。
然后，如果<code>u1^2 - u2^2 &ge; 0</code>，直角三角形两条边中的另一条边就是输出，
由<code>y = sqrt(u1^2 - u2^2)</code>决定；在这种情况下，布尔输出<code>valid</code>等于<code>true</code>。
如果<code>u1^2 - u2^2 &lt; 0</code>，输出<code>y = 0</code>，<code>valid</code>设为<code>false</code>。
</p>
</html>"));
  end Pythagoras;

  block Max "传递最大信号"
    extends Interfaces.SI2SO;
  equation
    y = max(u1, u2);
    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
      {100, 100}}), graphics = {Text(
      extent = {{-90, 36}, {90, -36}}, 
      textColor = {160, 160, 164}, 
      textString = "max()")}), Documentation(info="<html><p>
该模块将输出<strong>y</strong>计算为两个实数输入<strong>u1</strong>和<strong>u2</strong>的<em>最大值</em>：
</p>
<pre><code >y = max ( u1 , u2 );</code></pre><p>
<br>
</p>
<p>
<br>
</p>
</html>"));
  end Max;

  block Min "传递最小信号"
    extends Interfaces.SI2SO;
  equation
    y = min(u1, u2);
    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
      {100, 100}}), graphics = {Text(
      extent = {{-90, 36}, {90, -36}}, 
      textColor = {160, 160, 164}, 
      textString = "min()")}), Documentation(info="<html><p>
该模块将输出<strong>y</strong>计算为两个实数输入<strong>u1</strong>和<strong>u2</strong>的<em>最小值</em>：
</p>
<pre><code >y = min ( u1 , u2 );</code></pre><p>
<br>
</p>
<p>
<br>
</p>
</html>"));
  end Min;

  block MinMax "输出输入向量的最小和最大元素"
    extends Modelica.Blocks.Icons.Block;
    parameter Integer nu(min = 0) = 0 "输入接口数量" 
      annotation(Dialog(connectorSizing = true), HideResult = true);
    Modelica.Blocks.Interfaces.RealVectorInput u[nu] 
      annotation(Placement(transformation(extent = {{-120, 70}, {-80, -70}})));
    Modelica.Blocks.Interfaces.RealOutput yMax annotation(Placement(
      transformation(extent = {{100, 50}, {120, 70}})));
    Modelica.Blocks.Interfaces.RealOutput yMin annotation(Placement(
      transformation(extent = {{100, -70}, {120, -50}})));
  equation
    yMax = max(u);
    yMin = min(u);
    annotation(Icon(coordinateSystem(
      preserveAspectRatio = false, 
      extent = {{-100, -100}, {100, 100}}), graphics = {Text(
      extent = {{-12, 80}, {100, 40}}, 
      textString = "yMax"), Text(
      extent = {{-10, -40}, {100, -80}}, 
      textString = "yMin")}), Documentation(info = "<html>
<p>
确定输入向量的最小和最大元素，并将这两个值作为输出。
</p>
</html>"));
  end MinMax;

  block LinearDependency "输出两个输入的线性组合"
    extends Modelica.Blocks.Interfaces.SI2SO;
    parameter Real y0 = 0 "初始值";
    parameter Real k1 = 0 "增益u1";
    parameter Real k2 = 0 "增益u2";
  equation
    y = y0 + k1 * u1 + k2 * u2;
    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, 
      -100}, {100, 100}}), graphics = {
      Line(
      points = {{-100, 60}, {100, 0}, {-100, -60}}, 
      color = {0, 0, 127}), 
      Text(
      extent = {{-14, 88}, {94, 32}}, 
      textString = "%k1"), 
      Text(
      extent = {{-40, -48}, {96, -96}}, 
      textString = "%k2"), 
      Text(
      extent = {{-94, 26}, {8, -30}}, 
      textString = "%y0")}), Documentation(info = "<html>
<p>确定两个输入的线性组合： <code>y = y0 + k1*u1 + k2*u2</code></p>
</html>"));
  end LinearDependency;

  block Edge "表示布尔信号的上升沿"
    extends Interfaces.BooleanSISO;
  equation
    y = edge(u);
    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
      {100, 100}}), graphics = {Text(
      extent = {{-90, 36}, {90, -36}}, 
      textColor = {160, 160, 164}, 
      textString = "edge()")}), Documentation(info="<html><p>
当布尔输入<strong>u</strong>显示<em>上升沿</em>时，该模块将布尔输出<strong>y</strong>设为真：
</p>
<pre><code >y = edge( u );</code></pre><p>
<br>
</p>
</html>"));
  end Edge;

  block BooleanChange "表示布尔信号变化"
    extends Interfaces.BooleanSISO;
  equation
    y = change(u);
    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
      {100, 100}}), graphics = {Text(
      extent = {{-90, 36}, {90, -36}}, 
      textColor = {160, 160, 164}, 
      textString = "change()")}), Documentation(info="<html><p>
当布尔输入 <strong>u</strong>出现<em>上升或下降沿</em>时， 即信号发生变化时，该模块将布尔输出<strong>y</strong>设为真：
</p>
<pre><code >y = change( u );</code></pre><p>
<br>
</p>
<p>
<br>
</p>
</html>"));
  end BooleanChange;

  block IntegerChange "表示整数信号发生变化"
    extends Interfaces.IntegerSIBooleanSO;
  equation
    y = change(u);
    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
      {100, 100}}), graphics = {Text(
      extent = {{-90, 36}, {90, -36}}, 
      textColor = {160, 160, 164}, 
      textString = "change()")}), Documentation(info="<html><p>
当整数输入<strong>u</strong>发生变化时，该模块将布尔输出<strong>y</strong>设为真：
</p>
<pre><code >y = change( u );</code></pre><p>
<br>
</p>
</html>"));
  end IntegerChange;

  annotation(Documentation(info="<html><p>
<span style=\"color: rgb(51, 51, 51);\">此包包含基本的</span><span style=\"color: rgb(51, 51, 51);\"><strong>数学运算</strong></span><span style=\"color: rgb(51, 51, 51);\">，如加法和乘法，以及基本的</span><span style=\"color: rgb(51, 51, 51);\"><strong>数学函数</strong></span><span style=\"color: rgb(51, 51, 51);\">，如平方根（sqrt）和正弦（sin），作为输入/输出块。该库中的所有块既可以与连续块连接，也可以与采样数据块连接。</span>
</p>
</html>",revisions = "<html>
<ul>
<li><em>August 24, 2016</em>
by Christian Kral: added WrapAngle</li>
<li><em>October 21, 2002</em>
by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
and Christian Schweiger:<br>
New blocks added: RealToInteger, IntegerToReal, Max, Min, Edge, BooleanChange, IntegerChange.</li>
<li><em>August 7, 1999</em>
by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
Realized (partly based on an existing Dymola library
of Dieter Moormann and Hilding Elmqvist).
</li>
</ul>
</html>"), Icon(graphics = {Line(
    points = {{-80, -2}, {-68.7, 32.2}, {-61.5, 51.1}, {-55.1, 64.4}, {-49.4, 72.6}, 
    {-43.8, 77.1}, {-38.2, 77.8}, {-32.6, 74.6}, {-26.9, 67.7}, {-21.3, 57.4}, 
    {-14.9, 42.1}, {-6.83, 19.2}, {10.1, -32.8}, {17.3, -52.2}, {23.7, -66.2}, 
    {29.3, -75.1}, {35, -80.4}, {40.6, -82}, {46.2, -79.6}, {51.9, -73.5}, {
    57.5, -63.9}, {63.9, -49.2}, {72, -26.8}, {80, -2}}, 
    color = {95, 95, 95}, 
    smooth = Smooth.Bezier)}));
end Math;