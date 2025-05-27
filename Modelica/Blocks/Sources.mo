within Modelica.Blocks;
package Sources 
  "生成实数、整数和布尔信号的信号源模块库"
  import Modelica.Blocks.Interfaces;

  extends Modelica.Icons.SourcesPackage;

  block RealExpression "将输出信号设置为时变实数表达式"

    Modelica.Blocks.Interfaces.RealOutput y = 0.0 "实数输出值" 
      annotation(Dialog(group = "时变输出信号"), Placement(
      transformation(extent = {{100, -10}, {120, 10}})));

    annotation(Icon(coordinateSystem(
      preserveAspectRatio = false, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Rectangle(
      extent = {{-100, 40}, {100, -40}}, 
      fillColor = {235, 235, 235}, 
      fillPattern = FillPattern.Solid, 
      borderPattern = BorderPattern.Raised), 
      Text(
      extent = {{-96, 15}, {96, -15}}, 
      textString = "%y"), 
      Text(
      extent = {{-150, 90}, {150, 50}}, 
      textString = "%name", 
      textColor = {0, 0, 255})}), Documentation(info = "<html><p>
该模块的（时变）实数输出信号可在其参数菜单中通过变量<strong>y</strong>进行定义。 其目的是支持在框图中轻松定义实数表达式。 例如，在y菜单中，可以给出 “<span style=\"color: rgb(51, 51, 51);\">if time &lt; 1 then 0 else 1</span>” 的定义，以确定如果时间 ≥ 1，输出信号为 1，否则为 0。 请注意，“time” 是一个内置变量，可以随时访问，代表 “模型时间”，而变量<strong>y</strong>既是一个变量，也是一个连接器。
</p>
</html>"  ));

  end RealExpression;

  block IntegerExpression 
    "将输出信号设置为随时间变化的整数表达式"

    Modelica.Blocks.Interfaces.IntegerOutput y = 0 "整数输出值" 
      annotation(Dialog(group = "时变输出信号"), Placement(
      transformation(extent = {{100, -10}, {120, 10}})));

    annotation(Icon(coordinateSystem(
      preserveAspectRatio = false, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Rectangle(
      extent = {{-100, 40}, {100, -40}}, 
      fillColor = {235, 235, 235}, 
      fillPattern = FillPattern.Solid, 
      borderPattern = BorderPattern.Raised), 
      Text(
      extent = {{-96, 15}, {96, -15}}, 
      textString = "%y"), 
      Text(
      extent = {{-150, 90}, {150, 50}}, 
      textString = "%name", 
      textColor = {0, 0, 255})}), Documentation(info="<html><p>
该模块的整数输出信号（随时间变化）可通过变量<strong>y</strong>在参数菜单中定义。 其目的是支持在框图中简单定义整数表达式。 例如，在y菜单中，可以给出 “<span style=\"color: rgb(51, 51, 51);\">if time &lt; 1 then 0 else 1</span>” 的定义，以确定如果时间 ≥ 1，输出信号为 1，否则为 0。 请注意，“time” 是一个内置变量，可以随时访问，代表 “模型时间”，而变量<strong>y</strong>既是一个变量，也是一个连接器。
</p>
</html>"));

  end IntegerExpression;

  block BooleanExpression 
    "将输出信号设置为随时间变化的布尔表达式"

    Modelica.Blocks.Interfaces.BooleanOutput y = false "布尔输出值" 
      annotation(Dialog(group = "时变输出信号"), Placement(
      transformation(extent = {{100, -10}, {120, 10}})));

    annotation(Icon(coordinateSystem(
      preserveAspectRatio = false, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Rectangle(
      extent = {{-100, 40}, {100, -40}}, 
      fillColor = {235, 235, 235}, 
      fillPattern = FillPattern.Solid, 
      borderPattern = BorderPattern.Raised), 
      Text(
      extent = {{-96, 15}, {96, -15}}, 
      textString = "%y"), 
      Text(
      extent = {{-150, 90}, {150, 50}}, 
      textString = "%name", 
      textColor = {0, 0, 255}), 
      Polygon(
      points = {{100, 10}, {120, 0}, {100, -10}, {100, 10}}, 
      lineColor = DynamicSelect({255, 0, 255}, if y then {0, 255, 0} else {255, 0, 255}), 
      fillColor = DynamicSelect({255, 255, 255}, if y then {0, 255, 0} else {255, 255, 255}), 
      fillPattern = FillPattern.Solid)}), Documentation(info="<html><p>
该模块布尔输出信号（随时间变化）可通过变量<strong>y</strong>在参数菜单中定义。 其目的是支持在框图中简单定义布尔表达式。 例如，在y菜单中，可以给出 “<span style=\"color: rgb(51, 51, 51);\">time &gt;= 1 and time &lt;= 2</span>” 的定义， 以确定输出信号在时间间隔 1 ≤ 时间 ≤ 2 时为<strong>true</strong>，否则为<strong>false</strong>。 请注意，“time” 是一个内置变量，可以随时访问，代表 “模型时间”，而变量<strong>y</strong>既是一个变量，也是一个连接器。
</p>
</html>"));

  end BooleanExpression;
  block Clock "生成实际时间信号"
    extends Interfaces.SignalSource;

  equation
    y = offset + (if time < startTime then 0 else time - startTime);
    annotation(Protection(hideFromBrowser=true), 
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Ellipse(extent = {{-80, 80}, {80, -80}}, lineColor = {160, 160, 164}), 
      Line(points = {{0, 80}, {0, 60}}, color = {160, 160, 164}), 
      Line(points = {{80, 0}, {60, 0}}, color = {160, 160, 164}), 
      Line(points = {{0, -80}, {0, -60}}, color = {160, 160, 164}), 
      Line(points = {{-80, 0}, {-60, 0}}, color = {160, 160, 164}), 
      Line(points = {{37, 70}, {26, 50}}, color = {160, 160, 164}), 
      Line(points = {{70, 38}, {49, 26}}, color = {160, 160, 164}), 
      Line(points = {{71, -37}, {52, -27}}, color = {160, 160, 164}), 
      Line(points = {{39, -70}, {29, -51}}, color = {160, 160, 164}), 
      Line(points = {{-39, -70}, {-29, -52}}, color = {160, 160, 164}), 
      Line(points = {{-71, -37}, {-50, -26}}, color = {160, 160, 164}), 
      Line(points = {{-71, 37}, {-54, 28}}, color = {160, 160, 164}), 
      Line(points = {{-38, 70}, {-28, 51}}, color = {160, 160, 164}), 
      Line(
      points = {{0, 0}, {-50, 50}}, 
      thickness = 0.5), 
      Line(
      points = {{0, 0}, {40, 0}}, 
      thickness = 0.5), 
      Text(
      extent = {{-150, -150}, {150, -110}}, 
      textString = "startTime=%startTime")}), 
      Diagram(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Polygon(
      points = {{-80, 90}, {-85, 68}, {-75, 68}, {-80, 90}}, 
      lineColor = {95, 95, 95}, 
      fillColor = {95, 95, 95}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-80, 68}, {-80, -80}}, color = {95, 95, 95}), 
      Line(
      points = {{-80, 0}, {-10, 0}, {60, 70}}, 
      color = {0, 0, 255}, 
      thickness = 0.5), 
      Line(points = {{-90, -70}, {82, -70}}, color = {95, 95, 95}), 
      Polygon(
      points = {{90, -70}, {68, -64}, {68, -76}, {90, -70}}, 
      lineColor = {95, 95, 95}, 
      fillColor = {95, 95, 95}, 
      fillPattern = FillPattern.Solid), 
      Polygon(
      points = {{-34, 0}, {-37, -13}, {-31, -13}, {-34, 0}}, 
      lineColor = {95, 95, 95}, 
      fillColor = {95, 95, 95}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-34, 0}, {-34, -70}}, color = {95, 95, 95}), 
      Polygon(
      points = {{-34, -70}, {-37, -57}, {-31, -57}, {-34, -70}, {-34, -70}}, 
      lineColor = {95, 95, 95}, 
      fillColor = {95, 95, 95}, 
      fillPattern = FillPattern.Solid), 
      Text(
      extent = {{-77, -28}, {-35, -40}}, 
      textString = "offset"), 
      Text(
      extent = {{-30, -73}, {18, -86}}, 
      textString = "startTime"), 
      Text(
      extent = {{-81, 91}, {-40, 71}}, 
      textString = "y"), 
      Text(
      extent = {{63, -79}, {94, -89}}, 
      textString = "time"), 
      Line(points = {{-10, 0}, {-10, -70}}, color = {95, 95, 95}), 
      Line(points = {{-10, 0}, {50, 0}}, color = {95, 95, 95}), 
      Line(points = {{50, 0}, {50, 60}}, color = {95, 95, 95}), 
      Text(
      extent = {{35, 33}, {50, 23}}, 
      textString = "1"), 
      Text(
      extent = {{14, 13}, {32, 1}}, 
      textString = "1")}), 
      Documentation(info = "<html>
<p>
The Real output y is a clock signal:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Clock.png\"
 alt=\"Clock.png\">
</p>
</html>"  ));
  end Clock;

  block ContinuousClock "生成当前时间信号"
    extends Interfaces.SignalSource;

  equation
    y = offset + (if time < startTime then 0 else time - startTime);
    annotation(
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Ellipse(extent = {{-80, 80}, {80, -80}}, lineColor = {160, 160, 164}), 
      Line(points = {{0, 80}, {0, 60}}, color = {160, 160, 164}), 
      Line(points = {{80, 0}, {60, 0}}, color = {160, 160, 164}), 
      Line(points = {{0, -80}, {0, -60}}, color = {160, 160, 164}), 
      Line(points = {{-80, 0}, {-60, 0}}, color = {160, 160, 164}), 
      Line(points = {{37, 70}, {26, 50}}, color = {160, 160, 164}), 
      Line(points = {{70, 38}, {49, 26}}, color = {160, 160, 164}), 
      Line(points = {{71, -37}, {52, -27}}, color = {160, 160, 164}), 
      Line(points = {{39, -70}, {29, -51}}, color = {160, 160, 164}), 
      Line(points = {{-39, -70}, {-29, -52}}, color = {160, 160, 164}), 
      Line(points = {{-71, -37}, {-50, -26}}, color = {160, 160, 164}), 
      Line(points = {{-71, 37}, {-54, 28}}, color = {160, 160, 164}), 
      Line(points = {{-38, 70}, {-28, 51}}, color = {160, 160, 164}), 
      Line(
      points = {{0, 0}, {-50, 50}}, 
      thickness = 0.5), 
      Line(
      points = {{0, 0}, {40, 0}}, 
      thickness = 0.5), 
      Text(
      extent = {{-150, -150}, {150, -110}}, 
      textString = "startTime=%startTime")}), 
      Documentation(info="<html><p>
实数输出 y 是时钟信号：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/ContinuousClock.png\" alt=\"ContinuousClock.png\" data-href=\"\" style=\"\">
</p>
</html>"));
  end ContinuousClock;

  block Constant "生成实数类型的恒定信号"
    parameter Real k(start = 1) "恒定输出值" 
      annotation(Dialog(groupImage = "modelica://Modelica/Resources/Images/Blocks/Sources/Constant.png"));
    extends Interfaces.SO;

  equation
    y = k;
    annotation(
      defaultComponentName = "const", 
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{-80, 68}, {-80, -80}}, color = {192, 192, 192}), 
      Polygon(
      points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-90, -70}, {82, -70}}, color = {192, 192, 192}), 
      Polygon(
      points = {{90, -70}, {68, -62}, {68, -78}, {90, -70}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-80, 0}, {80, 0}}), 
      Text(
      extent = {{-150, -150}, {150, -110}}, 
      textString = "k=%k")}), 
      Documentation(info="<html><p>
实数输出 y 是一个恒定信号：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Constant.png\" alt=\"Constant.png\" data-href=\"\" style=\"\">
</p>
</html>"));
  end Constant;

  block Step "生成实数类型的阶跃信号"
    parameter Real height = 1 "阶越高度" 
      annotation(Dialog(groupImage = "modelica://Modelica/Resources/Images/Blocks/Sources/Step.png"));
    extends Interfaces.SignalSource;

  equation
    y = offset + (if time < startTime then 0 else height);
    annotation(
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{-80, 68}, {-80, -80}}, color = {192, 192, 192}), 
      Polygon(
      points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-90, -70}, {82, -70}}, color = {192, 192, 192}), 
      Polygon(
      points = {{90, -70}, {68, -62}, {68, -78}, {90, -70}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-80, -70}, {0, -70}, {0, 50}, {80, 50}}), 
      Text(
      extent = {{-150, -150}, {150, -110}}, 
      textString = "startTime=%startTime")}), 
      Documentation(info="<html><p>
实数输出 y 是一个阶跃信号：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Step.png\" alt=\"Step.png\" data-href=\"\" style=\"\">
</p>
</html>"));
  end Step;

  block Ramp "产生斜坡信号"
    parameter Real height = 1 "斜坡高度" 
      annotation(Dialog(groupImage = "modelica://Modelica/Resources/Images/Blocks/Sources/Ramp.png"));
    parameter SI.Time duration(min = 0.0, start = 2) 
      "斜坡持续时间(=0.0为一个阶跃)";
    extends Interfaces.SignalSource;

  equation
    y = offset + (if time < startTime then 0 else if time < (startTime + 
      duration) then (time - startTime) * height / duration else height);
    annotation(
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{-80, 68}, {-80, -80}}, color = {192, 192, 192}), 
      Polygon(
      points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-90, -70}, {82, -70}}, color = {192, 192, 192}), 
      Polygon(
      points = {{90, -70}, {68, -62}, {68, -78}, {90, -70}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-80, -70}, {-40, -70}, {31, 38}}), 
      Text(
      extent = {{-150, -150}, {150, -110}}, 
      textString = "duration=%duration"), 
      Line(points = {{31, 38}, {86, 38}})}), 
      Documentation(info="<html><p>
实数输出 y 是一个斜坡信号：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Ramp.png\" alt=\"Ramp.png\" data-href=\"\" style=\"\">
</p>
<p>
如果参数 duration 设置为 0.0, 则达到 Step 信号的极限。
</p>
</html>"));
  end Ramp;

  block Sine "产生正弦信号"
    import Modelica.Constants.pi;
    parameter Real amplitude = 1 "正弦波振幅" 
      annotation(Dialog(groupImage = "modelica://Modelica/Resources/Images/Blocks/Sources/Sine.png"));
    parameter SI.Frequency f(start = 1) "正弦波频率";
    parameter SI.Angle phase = 0 "正弦波相位";
    extends Interfaces.SignalSource;
  equation
    y = offset + (if time < startTime then 0 else amplitude * Modelica.Math.sin(2 
      * pi * f * (time - startTime) + phase));
    annotation(
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{-80, 68}, {-80, -80}}, color = {192, 192, 192}), 
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
      Line(points = {{-80, 0}, {-68.7, 34.2}, {-61.5, 53.1}, {-55.1, 66.4}, {-49.4, 
      74.6}, {-43.8, 79.1}, {-38.2, 79.8}, {-32.6, 76.6}, {-26.9, 69.7}, {-21.3, 
      59.4}, {-14.9, 44.1}, {-6.83, 21.2}, {10.1, -30.8}, {17.3, -50.2}, {23.7, 
      -64.2}, {29.3, -73.1}, {35, -78.4}, {40.6, -80}, {46.2, -77.6}, {51.9, -71.5}, 
      {57.5, -61.9}, {63.9, -47.2}, {72, -24.8}, {80, 0}}, smooth = Smooth.Bezier), 
      Text(
      extent = {{-147, -152}, {153, -112}}, 
      textString = "f=%f")}), 
      Documentation(info="<html><p>
实数输出 y 是一个正弦信号：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Sine.png\" alt=\"Sine.png\" data-href=\"\" style=\"\">
</p>
</html>"));
  end Sine;

  block Cosine "生成余弦信号"
    import Modelica.Constants.pi;
    parameter Real amplitude = 1 "余弦波振幅" 
      annotation(Dialog(groupImage = "modelica://Modelica/Resources/Images/Blocks/Sources/Cosine.png"));
    parameter SI.Frequency f(start = 1) "余弦波频率";
    parameter SI.Angle phase = 0 "余弦波的相位";
    extends Interfaces.SignalSource;
  equation
    y = offset + (if time < startTime then 0 else amplitude * Modelica.Math.cos(2 
      * pi * f * (time - startTime) + phase));
    annotation(
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{-80, 68}, {-80, -80}}, color = {192, 192, 192}), 
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
      Line(points = {{-80, 80}, {-76.2, 79.8}, {-70.6, 76.6}, {-64.9, 69.7}, {-59.3, 
      59.4}, {-52.9, 44.1}, {-44.83, 21.2}, {-27.9, -30.8}, {-20.7, -50.2}, {-14.3, 
      -64.2}, {-8.7, -73.1}, {-3, -78.4}, {2.6, -80}, {8.2, -77.6}, {13.9, -71.5}, 
      {19.5, -61.9}, {25.9, -47.2}, {34, -24.8}, {42, 0}}, smooth = Smooth.Bezier), 
      Text(
      extent = {{-147, -152}, {153, -112}}, 
      textString = "f=%f"), 
      Line(points = {{42, 1}, {53.3, 35.2}, {60.5, 54.1}, {66.9, 67.4}, {72.6, 75.6}, {
      78.2, 80.1}, {83.8, 80.8}})}), 
      Documentation(info="<html><p>
实数输出 y 是一个余弦信号：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Cosine.png\" alt=\"Cosine.png\" data-href=\"\" style=\"\">
</p>
</html>"));
  end Cosine;

  block SineVariableFrequencyAndAmplitude 
    "生成频率和振幅可变的正弦信号"
    extends Interfaces.SO;
    import Modelica.Constants.pi;
    parameter Boolean useConstantAmplitude = false "启用恒定振幅";
    parameter Real constantAmplitude = 1 "恒定振幅" 
      annotation(Dialog(enable = useConstantAmplitude));
    parameter Boolean useConstantFrequency = false "启用恒定频率";
    parameter SI.Frequency constantFrequency = 1 "恒定频率" 
      annotation(Dialog(enable = useConstantFrequency));
    parameter Real offset = 0 "正弦波偏移" 
      annotation(Dialog(groupImage = "modelica://Modelica/Resources/Images/Blocks/Sources/SineVariableFrequencyAndAmplitude.png"));
    SI.Angle phi(start = 0) "正弦波相位";
    Blocks.Interfaces.RealInput amplitude if not useConstantAmplitude "振幅" 
      annotation(Placement(
      transformation(
      extent = {{-20, -20}, {20, 20}}, 
      origin = {-120, 60})));
    Blocks.Interfaces.RealInput f(unit = "Hz") if not useConstantFrequency 
      "频率" annotation(Placement(
      transformation(
      extent = {{-20, -20}, {20, 20}}, 
      origin = {-120, -60})));
  protected
    Blocks.Interfaces.RealInput amplitude_internal "振幅" annotation(Placement(
      transformation(
      extent = {{-2, -2}, {2, 2}}, 
      origin = {-80, 60})));
    Blocks.Interfaces.RealInput f_internal(unit = "Hz") "频率" annotation(Placement(
      transformation(
      extent = {{-2, -2}, {2, 2}}, 
      origin = {-80, -60})));
    Blocks.Sources.Constant amplitude_constant(final k = constantAmplitude) if 
      useConstantAmplitude 
      annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, 
      rotation = 90, 
      origin = {-80, 30})));
    Blocks.Sources.Constant f_constant(final k = constantFrequency) if 
      useConstantFrequency 
      annotation(Placement(transformation(extent = {{10, -10}, {-10, 10}}, 
      rotation = 90, 
      origin = {-80, -30})));
  equation
    der(phi) = 2 * pi * f_internal;
    y = offset + amplitude_internal * sin(phi);
    connect(f, f_internal) 
      annotation(Line(points = {{-120, -60}, {-80, -60}}, color = {0, 0, 127}));
    connect(amplitude, amplitude_internal) 
      annotation(Line(points = {{-120, 60}, {-80, 60}}, color = {0, 0, 127}));
    connect(amplitude_constant.y, amplitude_internal) 
      annotation(Line(points = {{-80, 41}, {-80, 60}}, color = {0, 0, 127}));
    connect(f_constant.y, f_internal) 
      annotation(Line(points = {{-80, -41}, {-80, -60}}, color = {0, 0, 127}));
    annotation(defaultComponentName = "sine", 
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{-80, 68}, {-80, -80}}, color = {192, 192, 192}), 
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
      Line(points = {
      {-80, 0}, {-78.4, 0}, {-76.8, 0}, {-75.2, 0}, {-73.6, 0.1}, 
      {-72, 0.1}, {-70.4, 0.2}, {-68.8, 0.3}, {-67.2, 0.4}, {-65.6, 0.6}, 
      {-64, 0.8}, {-62.4, 1.1}, {-60.8, 1.4}, {-59.2, 1.8}, {-57.6, 2.2}, 
      {-56, 2.7}, {-54.4, 3.3}, {-52.8, 3.9}, {-51.2, 4.6}, {-49.6, 5.4}, 
      {-48, 6.2}, {-46.4, 7.2}, {-44.8, 8.2}, {-43.2, 9.2}, {-41.6, 10.4}, 
      {-40, 11.6}, {-38.4, 12.9}, {-36.8, 14.2}, {-35.2, 15.6}, {-33.6, 17.1}, 
      {-32, 18.6}, {-30.4, 20.1}, {-28.8, 21.6}, {-27.2, 23.1}, {-25.6, 24.6}, 
      {-24, 26.1}, {-22.4, 27.5}, {-20.8, 28.8}, {-19.2, 30}, {-17.6, 31.1}, 
      {-16, 32}, {-14.4, 32.7}, {-12.8, 33.2}, {-11.2, 33.5}, {-9.6, 33.5}, 
      {-8, 33.2}, {-6.4, 32.5}, {-4.8, 31.5}, {-3.2, 30.1}, {-1.6, 28.4}, 
      {0, 26.2}, {1.6, 23.6}, {3.2, 20.6}, {4.8, 17.2}, {6.4, 13.3}, 
      {8, 9.1}, {9.6, 4.6}, {11.2, -0.3}, {12.8, -5.4}, {14.4, -10.7}, 
      {16, -16.1}, {17.6, -21.6}, {19.2, -27.1}, {20.8, -32.3}, {22.4, -37.4}, 
      {24, -42.1}, {25.6, -46.3}, {27.2, -49.9}, {28.8, -52.8}, {30.4, -54.8}, 
      {32, -56}, {33.6, -56.1}, {35.2, -55.2}, {36.8, -53.1}, {38.4, -49.8}, 
      {40, -45.3}, {41.6, -39.7}, {43.2, -33}, {44.8, -25.3}, {46.4, -16.6}, 
      {48, -7.3}, {49.6, 2.6}, {51.2, 12.8}, {52.8, 23}, {54.4, 33}, 
      {56, 42.5}, {57.6, 51.2}, {59.2, 58.8}, {60.8, 64.9}, {62.4, 69.3}, 
      {64, 71.9}, {65.6, 72.3}, {67.2, 70.5}, {68.8, 66.4}, {70.4, 60}, 
      {72, 51.4}, {73.6, 40.8}, {75.2, 28.4}, {76.8, 14.7}, {78.4, 0}, 
      {80, -15.1}}, smooth = Smooth.Bezier)}), 
      Documentation(info = "<html>
<p>
该信号源提供频率<code>f</code>可变、振幅可变的正弦信号，即正弦波的相位角由 2*&pi;*f 积分而成。
</p>
<p>
请注意，相位角<code>phi</code>的初始值定义了初始相移，而参数<code>startTime</code>则省略了，
因为将输入<code>amplitude</code>设为零时，电压可以保持等于偏移量。
</p>
</html>"));
  end SineVariableFrequencyAndAmplitude;

  block CosineVariableFrequencyAndAmplitude 
    "生成频率和振幅可变的余弦信号"
    extends Interfaces.SO;
    import Modelica.Constants.pi;
    parameter Boolean useConstantAmplitude = false "启用恒定振幅";
    parameter Real constantAmplitude = 1 "恒定振幅" 
      annotation(Dialog(enable = useConstantAmplitude));
    parameter Boolean useConstantFrequency = false "启用恒定频率";
    parameter SI.Frequency constantFrequency = 1 "恒定频率" 
      annotation(Dialog(enable = useConstantFrequency));
    parameter Real offset = 0 "正弦波偏移" 
      annotation(Dialog(groupImage = "modelica://Modelica/Resources/Images/Blocks/Sources/CosineVariableFrequencyAndAmplitude.png"));
    SI.Angle phi(start = 0) "正弦波的相位";
    Blocks.Interfaces.RealInput amplitude if not useConstantAmplitude "振幅" 
      annotation(Placement(
      transformation(
      extent = {{-20, -20}, {20, 20}}, 
      origin = {-120, 60})));
    Blocks.Interfaces.RealInput f(unit = "Hz") if not useConstantFrequency 
      "频率" annotation(Placement(
      transformation(
      extent = {{-20, -20}, {20, 20}}, 
      origin = {-120, -60})));
  protected
    Blocks.Interfaces.RealInput amplitude_internal "振幅" annotation(Placement(
      transformation(
      extent = {{-2, -2}, {2, 2}}, 
      origin = {-80, 60})));
    Blocks.Interfaces.RealInput f_internal(unit = "Hz") "频率" annotation(Placement(
      transformation(
      extent = {{-2, -2}, {2, 2}}, 
      origin = {-80, -60})));
    Blocks.Sources.Constant amplitude_constant(final k = constantAmplitude) if 
      useConstantAmplitude 
      annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, 
      rotation = 90, 
      origin = {-80, 30})));
    Blocks.Sources.Constant f_constant(final k = constantFrequency) if 
      useConstantFrequency 
      annotation(Placement(transformation(extent = {{10, -10}, {-10, 10}}, 
      rotation = 90, 
      origin = {-80, -30})));
  equation
    der(phi) = 2 * pi * f_internal;
    y = offset + amplitude_internal * cos(phi);
    connect(f, f_internal) 
      annotation(Line(points = {{-120, -60}, {-80, -60}}, color = {0, 0, 127}));
    connect(amplitude, amplitude_internal) 
      annotation(Line(points = {{-120, 60}, {-80, 60}}, color = {0, 0, 127}));
    connect(amplitude_constant.y, amplitude_internal) 
      annotation(Line(points = {{-80, 41}, {-80, 60}}, color = {0, 0, 127}));
    connect(f_constant.y, f_internal) 
      annotation(Line(points = {{-80, -41}, {-80, -60}}, color = {0, 0, 127}));
    annotation(defaultComponentName = "cosine", 
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{-80, 68}, {-80, -80}}, color = {192, 192, 192}), 
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
      Line(points = {
      {-80, 80}, {-78.4, 79.6}, {-76.8, 79.2}, {-75.2, 78.8}, {-73.6, 78.4}, {-72, 78}, 
      {-70.4, 77.5}, {-68.8, 77.1}, {-67.2, 76.6}, {-65.6, 76.1}, {-64, 75.6}, 
      {-62.4, 75}, {-60.8, 74.4}, {-59.2, 73.7}, {-57.6, 73}, {-56, 72.2}, 
      {-54.4, 71.3}, {-52.8, 70.3}, {-51.2, 69.2}, {-49.6, 68}, {-48, 66.6}, 
      {-46.4, 65.2}, {-44.8, 63.6}, {-43.2, 61.8}, {-41.6, 59.9}, {-40, 57.7}, 
      {-38.4, 55.5}, {-36.8, 53}, {-35.2, 50.3}, {-33.6, 47.5}, {-32, 44.4}, 
      {-30.4, 41.1}, {-28.8, 37.7}, {-27.2, 34}, {-25.6, 30.1}, {-24, 26.1}, 
      {-22.4, 21.9}, {-20.8, 17.5}, {-19.2, 13}, {-17.6, 8.3}, {-16, 3.5}, 
      {-14.4, -1.3}, {-12.8, -6.2}, {-11.2, -11.1}, {-9.6, -16}, {-8, -20.8}, 
      {-6.4, -25.5}, {-4.8, -30.1}, {-3.2, -34.5}, {-1.6, -38.6}, {0, -42.4}, 
      {1.6, -45.9}, {3.2, -49}, {4.8, -51.7}, {6.4, -53.9}, {8, -55.5}, 
      {9.6, -56.5}, {11.2, -57}, {12.8, -56.8}, {14.4, -55.9}, {16, -54.4}, 
      {17.6, -52.2}, {19.2, -49.3}, {20.8, -45.7}, {22.4, -41.5}, {24, -36.7}, 
      {25.6, -31.4}, {27.2, -25.6}, {28.8, -19.4}, {30.4, -12.9}, {32, -6.2}, 
      {33.6, 0.6}, {35.2, 7.4}, {36.8, 14}, {38.4, 20.4}, {40, 26.3}, 
      {41.6, 31.8}, {43.2, 36.5}, {44.8, 40.6}, {46.4, 43.7}, {48, 45.9}, 
      {49.6, 47.1}, {51.2, 47.2}, {52.8, 46.2}, {54.4, 44.1}, {56, 41}, 
      {57.6, 36.8}, {59.2, 31.8}, {60.8, 25.9}, {62.4, 19.4}, {64, 12.4}, 
      {65.6, 5.1}, {67.2, -2.2}, {68.8, -9.5}, {70.4, -16.4}, {72, -22.8}, 
      {73.6, -28.4}, {75.2, -33}, {76.8, -36.6}, {78.4, -38.9}, {80, -39.8}}, 
      smooth = Smooth.Bezier)}), 
      Documentation(info = "<html>
<p>
该信号源提供频率<code>f</code>可变、<code>amplitude</code>可变的余弦信号，
即余弦波的相位角由 2*&pi;*f 积分而成。
</p>
<p>
请注意，相位角<code>phi</code>的初始值定义了初始相移，而参数<code>startTime</code>则省略了，
因为将输入<code>amplitude</code>设为零时，电压可以保持等于偏移量。
</p>
</html>"));
  end CosineVariableFrequencyAndAmplitude;

  block Sinc "生成sinc信号"
    import Modelica.Constants.pi;
    import Modelica.Constants.eps;
    parameter Real amplitude = 1 "正弦波振幅" 
      annotation(Dialog(groupImage = "modelica://Modelica/Resources/Images/Blocks/Sources/Sinc.png"));
    parameter SI.Frequency f(start = 1) "正弦波频率";
    extends Interfaces.SignalSource;
  protected
    SI.Angle x = 2 * pi * f * (time - startTime);
  equation
    y = offset + (if time < startTime then 0 else amplitude * 
      (if noEvent(time - startTime < eps) then 1 else (sin(x)) / x));
    annotation(
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{-80, 68}, {-80, -80}}, color = {192, 192, 192}), 
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
      Text(
      extent = {{-147, -152}, {153, -112}}, 
      textString = "f=%f", 
      textColor = {0, 0, 0}), 
      Line(points = {
      {-80, 80.0}, {-76, 78.7}, {-72, 74.8}, {-68, 68.7}, {-64, 60.5}, 
      {-60, 50.9}, {-56, 40.4}, {-52, 29.4}, {-48, 18.7}, {-44, 8.7}, 
      {-40, 0.0}, {-36, -7.2}, {-32, -12.5}, {-28, -15.8}, {-24, -17.3}, 
      {-20, -17.0}, {-16, -15.1}, {-12, -12.1}, {-8, -8.3}, {-4, -4.1}, 
      {0, 0.0}, {4, 3.7}, {8, 6.8}, {12, 9.0}, {16, 10.1}, 
      {20, 10.2}, {24, 9.3}, {28, 7.6}, {32, 5.3}, {36, 2.7}, 
      {40, 0.0}, {44, -2.5}, {48, -4.7}, {52, -6.2}, {56, -7.1}, 
      {60, -7.3}, {64, -6.7}, {68, -5.6}, {72, -3.9}, {76, -2.0}, 
      {80, 0.0}}, smooth = Smooth.Bezier)}), 
      Documentation(info="<html><p>
实数输出 y 是一个 sinc 信号： <code> amplitude*(sin(2*π*f*t))/((2*π*f*t))</code>
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Sinc.png\" alt=\"Sinc.png\" data-href=\"\" style=\"\">
</p>
</html>"));
  end Sinc;

  block ExpSine "生成指数阻尼正弦信号"
    import Modelica.Constants.pi;
    parameter Real amplitude = 1 "正弦波振幅" 
      annotation(Dialog(groupImage = "modelica://Modelica/Resources/Images/Blocks/Sources/ExpSine.png"));
    parameter SI.Frequency f(start = 2) "正弦波频率";
    parameter SI.Angle phase = 0 "正弦波相位";
    parameter SI.Damping damping(start = 1) 
      "正弦波阻尼系数";
    extends Interfaces.SignalSource;
  equation
    y = offset + (if time < startTime then 0 else amplitude * Modelica.Math.exp(-
      (time - startTime) * damping) * Modelica.Math.sin(2 * pi * f * (time - 
      startTime) + phase));
    annotation(
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{-80, 68}, {-80, -80}}, color = {192, 192, 192}), 
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
      Line(points = {{-80, 0}, {-75.2, 32.3}, {-72, 50.3}, {-68.7, 64.5}, {-65.5, 74.2}, 
      {-62.3, 79.3}, {-59.1, 79.6}, {-55.9, 75.3}, {-52.7, 67.1}, {-48.6, 52.2}, 
      {-43, 25.8}, {-35, -13.9}, {-30.2, -33.7}, {-26.1, -45.9}, {-22.1, -53.2}, 
      {-18.1, -55.3}, {-14.1, -52.5}, {-10.1, -45.3}, {-5.23, -32.1}, {8.44, 
      13.7}, {13.3, 26.4}, {18.1, 34.8}, {22.1, 38}, {26.9, 37.2}, {31.8, 31.8}, 
      {38.2, 19.4}, {51.1, -10.5}, {57.5, -21.2}, {63.1, -25.9}, {68.7, -25.9}, 
      {75.2, -20.5}, {80, -13.8}}, smooth = Smooth.Bezier), 
      Text(
      extent = {{-147, -152}, {153, -112}}, 
      textString = "f=%f")}), 
      Documentation(info="<html><p>
实数输出 y 是振幅呈指数变化的正弦信号：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/ExpSine.png\" alt=\"ExpSine.png\" data-href=\"\" style=\"\">
</p>
</html>"));
  end ExpSine;

  block Exponentials "生成上升和下降指数信号"

    parameter Real outMax = 1 "无限上升时间的输出高度" 
      annotation(Dialog(groupImage = "modelica://Modelica/Resources/Images/Blocks/Sources/Exponentials.png"));
    parameter SI.Time riseTime(min = 0, start = 0.5) "上升时间";
    parameter SI.Time riseTimeConst(min = Modelica.Constants.small) = 0.1 
      "上升时间常数；上升定义为outMax*(1-exp(-riseTime/riseTimeConst))";
    parameter SI.Time fallTimeConst(min = Modelica.Constants.small) = 
      riseTimeConst "下降时间常数";
    extends Interfaces.SignalSource;
  protected
    Real y_riseTime;

  equation
    y_riseTime = outMax * (1 - Modelica.Math.exp(-riseTime / riseTimeConst));
    y = offset + (if (time < startTime) then 0 else if (time < (startTime + 
      riseTime)) then outMax * (1 - Modelica.Math.exp(-(time - startTime) / 
      riseTimeConst)) else y_riseTime * Modelica.Math.exp(-(time - startTime - 
      riseTime) / fallTimeConst));

    annotation(
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{-90, -70}, {68, -70}}, color = {192, 192, 192}), 
      Polygon(
      points = {{90, -70}, {68, -62}, {68, -78}, {90, -70}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-80, -70}, {-77.2, -55.3}, {-74.3, -42.1}, {-70.8, -27.6}, {-67.3, 
      -15}, {-63.7, -4.08}, {-59.5, 7.18}, {-55.3, 16.7}, {-50.3, 26}, {-44.6, 
      34.5}, {-38.3, 42.1}, {-31.2, 48.6}, {-22.7, 54.3}, {-12.1, 59.2}, {-10, 
      60}, {-7.88, 47.5}, {-5.05, 32.7}, {-2.22, 19.8}, {0.606, 8.45}, {4.14, -3.7}, 
      {7.68, -14}, {11.9, -24.2}, {16.2, -32.6}, {21.1, -40.5}, {26.8, -47.4}, 
      {33.1, -53.3}, {40.9, -58.5}, {50.8, -62.8}, {60, -65.4}}), 
      Polygon(
      points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-80, 68}, {-80, -80}}, color = {192, 192, 192}), 
      Text(
      extent = {{-150, -150}, {150, -110}}, 
      textString = "riseTime=%riseTime")}), 
      Documentation(info="<html><p>
实数输出 y 是一个上升的指数信号，随后是一个下降的指数信号：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Exponentials.png\" alt=\"Exponentials.png\" data-href=\"\" style=\"\">
</p>
</html>"));
  end Exponentials;

  block Pulse "生成实数类型的脉冲信号"
    parameter Real amplitude = 1 "脉冲振幅" 
      annotation(Dialog(groupImage = "modelica://Modelica/Resources/Images/Blocks/Sources/Pulse.png"));
    parameter Real width(
      final min = Modelica.Constants.small, 
      final max = 100) = 50 "脉冲宽度（周期百分比）";
    parameter SI.Time period(final min = Modelica.Constants.small, 
      start = 1) "一个周期的时间";
    parameter Integer nperiod = -1 
      "周期数(<0表示无限周期数)";
    extends Interfaces.SignalSource;
  protected
    SI.Time T_width = period * width / 100;
    SI.Time T_start "当前时段的开始时间";
    Integer count "周期计数";
  initial algorithm
    count := integer((time - startTime) / period);
    T_start := startTime + count * period;
  equation
    when integer((time - startTime) / period) > pre(count) then
      count = pre(count) + 1;
      T_start = time;
    end when;
    y = offset + (if (time < startTime or nperiod == 0 or (nperiod > 0 and 
      count >= nperiod)) then 0 else if time < T_start + T_width then amplitude 
      else 0);
    annotation(
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{-80, 68}, {-80, -80}}, color = {192, 192, 192}), 
      Polygon(
      points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-90, -70}, {82, -70}}, color = {192, 192, 192}), 
      Polygon(
      points = {{90, -70}, {68, -62}, {68, -78}, {90, -70}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-80, -70}, {-40, -70}, {-40, 44}, {0, 44}, {0, -70}, {40, -70}, {40, 
      44}, {79, 44}}), 
      Text(
      extent = {{-147, -152}, {153, -112}}, 
      textString = "period=%period")}), 
      Documentation(info="<html><p>
实数输出 y 是一个脉冲信号：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Pulse.png\" alt=\"Pulse.png\" data-href=\"\" style=\"\">
</p>
</html>"));
  end Pulse;

  block SawTooth "产生锯齿信号"
    parameter Real amplitude = 1 "锯齿振幅" 
      annotation(Dialog(groupImage = "modelica://Modelica/Resources/Images/Blocks/Sources/SawTooth.png"));
    parameter SI.Time period(final min = Modelica.Constants.small, start = 1) 
      "一个时段的时间";
    parameter Integer nperiod = -1 
      "周期数(<0表示无限周期数)";
    extends Interfaces.SignalSource;
  protected
    SI.Time T_start(final start = startTime) "当前时段的开始时间";
    Integer count "周期计数";
  initial algorithm
    count := integer((time - startTime) / period);
    T_start := startTime + count * period;
  equation
    when integer((time - startTime) / period) > pre(count) then
      count = pre(count) + 1;
      T_start = time;
    end when;
    y = offset + (if (time < startTime or nperiod == 0 or (nperiod > 0 and 
      count >= nperiod)) then 0 else amplitude * (time - T_start) / period);
    annotation(
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{-80, 68}, {-80, -80}}, color = {192, 192, 192}), 
      Polygon(
      points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-90, -70}, {82, -70}}, color = {192, 192, 192}), 
      Polygon(
      points = {{90, -70}, {68, -62}, {68, -78}, {90, -70}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-80, -70}, {-60, -70}, {0, 40}, {0, -70}, {60, 41}, {60, -70}}), 
      Text(
      extent = {{-147, -152}, {153, -112}}, 
      textString = "period=%period")}), 
      Documentation(info="<html><p>
实数输出 y 是一个锯齿信号：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/SawTooth.png\" alt=\"SawTooth.png\" data-href=\"\" style=\"\">
</p>
</html>"));
  end SawTooth;
  model TriangleWave "生成三角波信号"
    import SI=Modelica.Units.SI;
    parameter Real amplitude=1 "三角波的幅值" ;
    final parameter SI.Time rising(final min=0) = 0.5*period;
    final parameter SI.Time width(final min=0) = 0;
    final parameter SI.Time falling(final min=0) = 0.5*period;
    parameter SI.Time period(final min=Modelica.Constants.small, start=1) "一个周期的时间";
    final parameter Integer nperiod=-1 ;
    extends Modelica.Blocks.Interfaces.SignalSource;
  protected
    final parameter SI.Time T_rising=rising ;
    final parameter SI.Time T_width=T_rising + width;
    final parameter SI.Time T_falling=T_width + falling;
    SI.Time T_start "当前周期的开始时间";
    Integer count "周期计数";
  initial algorithm
    count := integer((time - startTime)/period);
    T_start := startTime + count*period;
  equation
    when integer((time - startTime)/period) > pre(count) then
      count = pre(count) + 1;
      T_start = time;
    end when;
    y = offset + (if (time < startTime or nperiod == 0 or (nperiod > 0 and 
      count >= nperiod)) then 0 else if (time < T_start + T_rising) then 
      amplitude*(time - T_start)/rising else if (time < T_start + T_width) 
       then amplitude else if (time < T_start + T_falling) then amplitude*(
      T_start + T_falling - time)/falling else 0);
    annotation (
      Icon(coordinateSystem(extent={{-100,-100},{100,100}}, 
  preserveAspectRatio=true, 
  grid={2,2}),graphics = {Line(origin={-80,-6}, 
  points={{0,74},{0,-74}}, 
  color={192,192,192}), Polygon(origin={-80,79}, 
  lineColor={192,192,192}, 
  fillColor={192,192,192}, 
  fillPattern=FillPattern.Solid, 
  points={{0,11},{-8,-11},{8,-11},{0,11}}), Line(origin={-4,-70}, 
  points={{-86,0},{86,0}}, 
  color={192,192,192}), Polygon(origin={79,-70}, 
  lineColor={192,192,192}, 
  fillColor={192,192,192}, 
  fillPattern=FillPattern.Solid, 
  points={{11,0},{-11,8},{-11,-8},{11,0}}), Text(origin={3,-132}, 
  extent={{-150,-20},{150,20}}, 
  textString="period=%period"), Line(origin={-8,-15}, 
  points={{-72,-55},{-32,-55},{-6,55},{-6,55},{22,-55},{48,55},{72,-55}})}),__MWORKS(VisibleVariable={"y"
  }),Documentation(info="<html><p>
输出的实数信号 y是一个三角波信号:
</p>
<p>
<img src=\"data:image/png;base64,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\" alt=\"image.png\" data-href=\"\" style=\"width: 303.19px;height: 285.11px;\"/>
</p>
</html>"  ));

  end TriangleWave;

  block Trapezoid "生成实型梯形信号"
    parameter Real amplitude = 1 "梯形振幅" 
      annotation(Dialog(groupImage = "modelica://Modelica/Resources/Images/Blocks/Sources/Trapezoid.png"));
    parameter SI.Time rising(final min = 0) = 0 
      "梯形上升持续时间";
    parameter SI.Time width(final min = 0) = 0.5 
      "梯形宽度持续时间";
    parameter SI.Time falling(final min = 0) = 0 
      "梯形的下降持续时间";
    parameter SI.Time period(final min = Modelica.Constants.small, start = 1) 
      "一个时段的时间";
    parameter Integer nperiod = -1 
      "周期数(<0表示无限周期数)";
    extends Interfaces.SignalSource;
  protected
    parameter SI.Time T_rising = rising 
      "一个周期内上升阶段的结束时间";
    parameter SI.Time T_width = T_rising + width 
      "一个周期内宽度阶段的结束时间";
    parameter SI.Time T_falling = T_width + falling 
      "一个周期内下降阶段的结束时间";
    SI.Time T_start "当前时段的开始时间";
    Integer count "周期计数";
  initial algorithm
    count := integer((time - startTime) / period);
    T_start := startTime + count * period;
  equation
    when integer((time - startTime) / period) > pre(count) then
      count = pre(count) + 1;
      T_start = time;
    end when;
    y = offset + (if (time < startTime or nperiod == 0 or (nperiod > 0 and 
      count >= nperiod)) then 0 else if (time < T_start + T_rising) then 
      amplitude * (time - T_start) / rising else if (time < T_start + T_width) 
      then amplitude else if (time < T_start + T_falling) then amplitude * (
      T_start + T_falling - time) / falling else 0);
    annotation(
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{-80, 68}, {-80, -80}}, color = {192, 192, 192}), 
      Polygon(
      points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-90, -70}, {82, -70}}, color = {192, 192, 192}), 
      Polygon(
      points = {{90, -70}, {68, -62}, {68, -78}, {90, -70}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Text(
      extent = {{-147, -152}, {153, -112}}, 
      textString = "period=%period"), 
      Line(points = {{-81, -70}, {-60, -70}, {-30, 40}, {9, 40}, {39, -70}, {61, -70}, {
      90, 40}})}), 
      Documentation(info="<html><p>
实数输出 y 是一个梯形信号：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Trapezoid.png\" alt=\"Trapezoid\" data-href=\"\" style=\"\">
</p>
</html>"));
  end Trapezoid;

  block LogFrequencySweep "对数频率扫描"
    extends Modelica.Blocks.Interfaces.SO;
    import Modelica.Constants.eps;
    parameter Real wMin(final min = eps) "启动频率" 
      annotation(Dialog(groupImage = "modelica://Modelica/Resources/Images/Blocks/Sources/LogFrequencySweep.png"));
    parameter Real wMax(final min = eps) "结束频率";
    parameter SI.Time startTime = 0 "频率扫描开始时间";
    parameter SI.Time duration(min = 0.0, start = 1) "斜坡持续时间(=0.0为一个台阶)";
  equation
    y = if time < startTime then wMin else 
      if time < (startTime + max(duration, eps)) then 
      10 ^ (log10(wMin) + (log10(wMax) - log10(wMin)) * min(1, (time - startTime) / max(duration, eps))) 
      else 
      wMax;
    annotation(defaultComponentName = "logSweep", 
      Documentation(info="<html><p>
输出<code>y</code>执行对数频率扫描。 频率<code>w</code>的对数执行从<code>log10(wMin)</code>到<code>log10(wMax)</code>的线性斜坡。 输出为该对数斜坡的十进制幂。
</p>
<p>
<code>time &lt; startTime</code>时，输出等于<code>wMin</code>。
</p>
<p>
<code>time &gt; startTime+duration</code>时，输出等于<code>wMax</code>。
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/LogFrequencySweep.png\" alt=\"LogFrequencySweep.png\" data-href=\"\" style=\"\">
</p>
</html>"), 
      Icon(graphics = {
      Line(points = {{-78, 44}, {80, 44}}, color = {192, 192, 192}), 
      Line(points = {{-78, 34}, {80, 34}}, color = {192, 192, 192}), 
      Line(points = {{-78, 20}, {80, 20}}, color = {192, 192, 192}), 
      Line(points = {{-78, -2}, {80, -2}}, color = {192, 192, 192}), 
      Line(points = {{-78, -48}, {80, -48}}, color = {192, 192, 192}), 
      Line(
      points = {{-70, -48}, {-50, -48}, {50, 44}, {70, 44}}, 
      color = {0, 0, 127}, 
      thickness = 0.5), 
      Line(points = {{-50, -48}, {-50, 44}}, color = {192, 192, 192}), 
      Line(points = {{50, -48}, {50, 44}}, color = {192, 192, 192}), 
      Line(points = {{-78, 40}, {80, 40}}, color = {192, 192, 192}), 
      Polygon(
      points = {{90, -48}, {68, -40}, {68, -56}, {90, -48}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Polygon(
      points = {{-70, 90}, {-78, 68}, {-62, 68}, {-70, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-70, -56}, {-70, 68}}, color = {192, 192, 192})}));
  end LogFrequencySweep;

  block KinematicPTP 
    "在给定的运动学约束条件下，尽可能快地沿一定距离移动"

    parameter Real deltaq[:] = {1} "移动距离" 
      annotation(Dialog(groupImage = "modelica://Modelica/Resources/Images/Blocks/Sources/KinematicPTP.png"));
    parameter Real qd_max[:](each final min = Modelica.Constants.small) = {1} 
      "最大速度der(q)";
    parameter Real qdd_max[:](each final min = Modelica.Constants.small) = {1} 
      "最大加速度der(qd)";
    parameter SI.Time startTime = 0 "运动开始的时间瞬间";

    extends Interfaces.MO(final nout = max([size(deltaq, 1); size(qd_max, 1); size(qdd_max, 1)]));

  protected
    parameter Real p_deltaq[nout] = (if size(deltaq, 1) == 1 then ones(nout) * 
      deltaq[1] else deltaq);
    parameter Real p_qd_max[nout] = (if size(qd_max, 1) == 1 then ones(nout) * 
      qd_max[1] else qd_max);
    parameter Real p_qdd_max[nout] = (if size(qdd_max, 1) == 1 then ones(nout) * 
      qdd_max[1] else qdd_max);
    Real sd_max;
    Real sdd_max;
    Real sdd;
    Real aux1[nout];
    Real aux2[nout];
    SI.Time Ta1;
    SI.Time Ta2;
    SI.Time Tv;
    SI.Time Te;
    Boolean noWphase;

  equation
    for i in 1:nout loop
      aux1[i] = p_deltaq[i] / p_qd_max[i];
      aux2[i] = p_deltaq[i] / p_qdd_max[i];
    end for;
    sd_max = 1 / max(abs(aux1));
    sdd_max = 1 / max(abs(aux2));

    Ta1 = sqrt(1 / sdd_max);
    Ta2 = sd_max / sdd_max;
    noWphase = Ta2 >= Ta1;
    Tv = if noWphase then Ta1 else 1 / sd_max;
    Te = if noWphase then Ta1 + Ta1 else Tv + Ta2;

    // 路径加速
    sdd = if time < startTime then 0 else ((if noWphase then (if time < Ta1 + 
      startTime then sdd_max else (if time < Te + startTime then -sdd_max else 
      0)) else (if time < Ta2 + startTime then sdd_max else (if time < Tv + 
      startTime then 0 else (if time < Te + startTime then -sdd_max else 0)))));

    // 加速度
    y = p_deltaq * sdd;
    annotation(
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{-80, 78}, {-80, -82}}, color = {192, 192, 192}), 
      Polygon(
      points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 88}, {-80, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-90, 0}, {82, 0}}, color = {192, 192, 192}), 
      Polygon(
      points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(
      points = {{-80, 0}, {-70, 0}, {-70, 70}, {-30, 70}, {-30, 0}, {20, 0}, {20, -70}, {
      60, -70}, {60, 0}, {68, 0}}), 
      Text(
      extent = {{2, 80}, {80, 20}}, 
      textColor = {192, 192, 192}, 
      textString = "acc"), 
      Text(
      extent = {{-150, -150}, {150, -110}}, 
      textString = "deltaq=%deltaq")}), 
      Documentation(info="<html><p>
目标是在给定的<strong>运动学约束</strong>条件下， 以尽可能<strong>快</strong>的速度沿距离<span style=\"color: rgb(51, 51, 51); background-color: rgb(245, 246, 248); font-size: 14px;\"><strong>Δq</strong></span>移动。 距离可以是位置或角度范围。 在机器人技术中，这种运动被称为<strong>PTP</strong>（点对点）。 该信号源模块将该信号的<strong>加速度</strong> qdd 作为输出：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/KinematicPTP.png\" alt=\"KinematicPTP.png\" data-href=\"\" style=\"\">
</p>
<p>
<br>
</p>
<p style=\"text-align: start;\">在对输出信号进行两次积分后，得到位置q。该信号的构造方式确保在给定的<strong>最大允许速度</strong>qd_max和<strong>最大允许加速度</strong>qdd_max下，不可能以更快的速度移动。
</p>
<p style=\"text-align: start;\">如果给定多个距离（向量q包含多个元素），则构造一个加速度输出向量，使得所有信号在加速、恒速和减速阶段处于相同的周期中。这意味着，只有一个信号达到其限制，而其他信号则以同步的方式进行调整，以确保所有信号在同一时刻到达终点。
</p>
<p style=\"text-align: start;\">该元素对于生成控制器的参考信号非常有用，控制器可以用来控制驱动系统，或与模型Modelica.Mechanics.Rotational.Accelerate结合使用，以根据给定的加速度驱动法兰。
</p>
</html>",revisions = "<html>
<p><strong>Release Notes:</strong></p>
<ul>
<li><em>June 27, 2001</em>
by Bernhard Bachmann.<br>
Bug fixed that element is also correct if startTime is not zero.</li>
<li><em>Nov. 3, 1999</em>
by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
Vectorized and moved from Rotational to Blocks.Sources.</li>
<li><em>June 29, 1999</em>
by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
realized.</li>
</ul>
</html>"));
  end KinematicPTP;

  block KinematicPTP2 
    "在给定的运动学约束条件下，尽可能快地从起点位置移动到终点位置，输出信号q、qd=der(q)、qdd=der(qd)"

    parameter Real q_begin[:] = {0} "起始位置" 
      annotation(Dialog(groupImage = "modelica://Modelica/Resources/Images/Blocks/Sources/KinematicPTP2.png"));
    parameter Real q_end[:] = {1} "结束位置";
    parameter Real qd_max[:](each final min = Modelica.Constants.small) = {1} 
      "最大速度der(q)";
    parameter Real qdd_max[:](each final min = Modelica.Constants.small) = {1} 
      "最大加速度der(q)";
    parameter SI.Time startTime = 0 
      "运动开始的时间瞬间";

    extends Modelica.Blocks.Icons.Block;
    final parameter Integer nout = max([size(q_begin, 1); size(q_end, 1); size(qd_max, 1); size(qdd_max, 1)]) 
      "输出信号数(=q、qd、qdd、moving的维数）";
    output SI.Time endTime "运动停止的时间瞬间";

    Modelica.Blocks.Interfaces.RealOutput q[nout] 
      "路径规划参考位置" annotation(Placement(
      transformation(extent = {{100, 70}, {120, 90}})));
    Modelica.Blocks.Interfaces.RealOutput qd[nout] 
      "路径规划参考速度" annotation(Placement(transformation(
      extent = {{100, 20}, {120, 40}})));
    Modelica.Blocks.Interfaces.RealOutput qdd[nout] 
      "路径规划的参考加速度" annotation(Placement(
      transformation(extent = {{100, -40}, {120, -20}})));
    Modelica.Blocks.Interfaces.BooleanOutput moving[nout] 
      "=true，如果尚未到达末端位置；=false，如果到达末端位置或轴完全静止" 
      annotation(Placement(transformation(extent = {{100, -90}, {120, -70}})));

  protected
    parameter Real p_q_begin[nout] = (if size(q_begin, 1) == 1 then ones(nout) * 
      q_begin[1] else q_begin);
    parameter Real p_q_end[nout] = (if size(q_end, 1) == 1 then ones(nout) * q_end[
      1] else q_end);
    parameter Real p_qd_max[nout] = (if size(qd_max, 1) == 1 then ones(nout) * 
      qd_max[1] else qd_max);
    parameter Real p_qdd_max[nout] = (if size(qdd_max, 1) == 1 then ones(nout) * 
      qdd_max[1] else qdd_max);
    parameter Real p_deltaq[nout] = p_q_end - p_q_begin;
    constant Real eps = 10 * Modelica.Constants.eps;
    Boolean motion_ref;
    Real sd_max_inv;
    Real sdd_max_inv;
    Real sd_max;
    Real sdd_max;
    Real sdd;
    Real aux1[nout];
    Real aux2[nout];
    SI.Time Ta1;
    SI.Time Ta2;
    SI.Time Tv;
    SI.Time Te;
    Boolean noWphase;
    SI.Time Ta1s;
    SI.Time Ta2s;
    SI.Time Tvs;
    SI.Time Tes;
    Real sd_max2;
    Real s1;
    Real s2;
    Real s3;
    Real s;
    Real sd;

  equation
    for i in 1:nout loop
      aux1[i] = p_deltaq[i] / p_qd_max[i];
      aux2[i] = p_deltaq[i] / p_qdd_max[i];
    end for;

    sd_max_inv = max(abs(aux1));
    sdd_max_inv = max(abs(aux2));

    if sd_max_inv <= eps or sdd_max_inv <= eps then
      sd_max = 0;
      sdd_max = 0;
      Ta1 = 0;
      Ta2 = 0;
      noWphase = false;
      Tv = 0;
      Te = 0;
      Ta1s = 0;
      Ta2s = 0;
      Tvs = 0;
      Tes = 0;
      sd_max2 = 0;
      s1 = 0;
      s2 = 0;
      s3 = 0;
      s = 0;
    else
      sd_max = 1 / max(abs(aux1));
      sdd_max = 1 / max(abs(aux2));
      Ta1 = sqrt(1 / sdd_max);
      Ta2 = sd_max / sdd_max;
      noWphase = Ta2 >= Ta1;
      Tv = if noWphase then Ta1 else 1 / sd_max;
      Te = if noWphase then Ta1 + Ta1 else Tv + Ta2;
      Ta1s = Ta1 + startTime;
      Ta2s = Ta2 + startTime;
      Tvs = Tv + startTime;
      Tes = Te + startTime;
      sd_max2 = sdd_max * Ta1;
      s1 = sdd_max * (if noWphase then Ta1 * Ta1 else Ta2 * Ta2) / 2;
      s2 = s1 + (if noWphase then sd_max2 * (Te - Ta1) - (sdd_max / 2) * (Te - Ta1) ^ 2 
        else sd_max * (Tv - Ta2));
      s3 = s2 + sd_max * (Te - Tv) - (sdd_max / 2) * (Te - Tv) * (Te - Tv);

      if time < startTime then
        s = 0;
      elseif noWphase then
        if time < Ta1s then
          s = (sdd_max / 2) * (time - startTime) * (time - startTime);
        elseif time < Tes then
          s = s1 + sd_max2 * (time - Ta1s) - (sdd_max / 2) * (time - Ta1s) * (time - 
            Ta1s);
        else
          s = s2;
        end if;
      elseif time < Ta2s then
        s = (sdd_max / 2) * (time - startTime) * (time - startTime);
      elseif time < Tvs then
        s = s1 + sd_max * (time - Ta2s);
      elseif time < Tes then
        s = s2 + sd_max * (time - Tvs) - (sdd_max / 2) * (time - Tvs) * (time - Tvs);
      else
        s = s3;
      end if;

    end if;

    sd = der(s);
    sdd = der(sd);

    qdd = p_deltaq * sdd;
    qd = p_deltaq * sd;
    q = p_q_begin + p_deltaq * s;
    endTime = Tes;

    // 轴在移动时报告
    motion_ref = time < endTime;
    for i in 1:nout loop
      moving[i] = if abs(q_begin[i] - q_end[i]) > eps then motion_ref else 
        false;
    end for;

    annotation(
      defaultComponentName = "kinematicPTP", 
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{-80, 78}, {-80, -82}}, color = {192, 192, 192}), 
      Polygon(
      points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 88}, {-80, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-90, 0}, {17, 0}}, color = {192, 192, 192}), 
      Line(
      points = {{-80, 0}, {-70, 0}, {-70, 70}, {-50, 70}, {-50, 0}, {-15, 0}, {-15, -70}, 
      {5, -70}, {5, 0}, {18, 0}}), 
      Text(
      extent = {{34, 96}, {94, 66}}, 
      textString = "q"), 
      Text(
      extent = {{40, 44}, {96, 14}}, 
      textString = "qd"), 
      Text(
      extent = {{32, -18}, {99, -44}}, 
      textString = "qdd"), 
      Text(
      extent = {{-32, -74}, {97, -96}}, 
      textString = "moving")}), 
      Documentation(info="<html><p>
目标是在给定的<strong>运动学约束</strong>条件下，以尽可能<strong>快</strong>的速度 从起始位置<strong>q_begin</strong>移动到终点位置<strong>q_end</strong>。 位置可以是平移或旋转定义（即给出 q_begin/q_end）。 在机器人学中，这种运动被称为<strong>PTP</strong>（点对点）。 这个源模块的输出是<strong>位置</strong> q(t)、<strong>速度</strong> qd(t) = der(q) 和<strong>加速度</strong> qdd = der(qd)。 <span style=\"color: rgb(51, 51, 51);\">信号的构造方式确保在给定的</span><span style=\"color: rgb(51, 51, 51);\"><strong>最大允许速度</strong></span><span style=\"color: rgb(51, 51, 51);\">qd_max和</span><span style=\"color: rgb(51, 51, 51);\"><strong>最大允许加速度</strong></span><span style=\"color: rgb(51, 51, 51);\">qdd_max下，不可能以更快的速度移动</span>：
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/KinematicPTP2.png\" alt=\"KinematicPTP2.png\" data-href=\"\" style=\"\"/>
</p>
<p>
如果矢量 q_begin/q_end 有一个以上的元素， 则输出矢量的构造应使所有信号在加速、匀速和减速阶段处于相同的周期。 这意味着只有一个信号处于极限状态， 而其他信号则同步，在同一时刻到达终点。
</p>
<p>
该元件可为控制器生成参考信号，从而控制传动系统等，或根据给定的加速度驱动法兰。
</p>
</html>",revisions = "<html>
<ul>
<li><em>March 24, 2007</em>
by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
Non-standard Modelica function \"constrain(..)\" replaced by standard
Modelica implementation (via internal function position()).<br>
New output signal \"moving\" added.</li>
<li><em>June 27, 2001</em>
by Bernhard Bachmann.<br>
Bug fixed that element is also correct if startTime is not zero.</li>
<li><em>Nov. 3, 1999</em>
by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
Vectorized and moved from Rotational to Blocks.Sources.</li>
<li><em>June 29, 1999</em>
by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
realized.</li>
</ul>
</html>"));
  end KinematicPTP2;

  block TimeTable 
    "通过表格中的线性插值生成(可能不连续的)信号"

    parameter Real table[:,2] = fill(0.0, 0, 2) 
      "表格矩阵(时间=第一列；例如，table=[0,0;1,1;2,4])" 
      annotation(Dialog(groupImage = "modelica://Modelica/Resources/Images/Blocks/Sources/TimeTable.png"));
    parameter SI.Time timeScale(
      min = Modelica.Constants.eps) = 1 "表格第一列的时间刻度" 
      annotation(Evaluate = true);
    extends Interfaces.SignalSource;
    parameter SI.Time shiftTime = startTime 
      "表格第一列的移位时间";
  protected
    discrete Real a "实际区间的插值系数a(y=a*x+b)";
    discrete Real b "实际区间的插值系数b(y=a*x+b)";
    Integer last(start = 1) "上一次使用的下网格索引";
    discrete SI.Time nextEvent(start = 0, fixed = true) "下一个活动瞬间";
    discrete Real nextEventScaled(start = 0, fixed = true) 
      "下一个缩放事件瞬间";
    Real timeScaled "缩放时间";

    function getInterpolationCoefficients 
      "确定插值系数和下一个时间事件"
      extends Modelica.Icons.Function;
      input Real table[:,2] "插值表";
      input Real offset "y偏移";
      input Real startTimeScaled "缩放时间偏移";
      input Real timeScaled "实际缩放时间瞬间";
      input Integer last "上一次使用的下网格索引";
      input Real TimeEps "相对ε，用于检查相同的时间瞬间";
      input Real shiftTimeScaled "时差";
      output Real a "插值系数a(y=a*x + b)";
      output Real b "插值系数b(y=a*x + b)";
      output Real nextEventScaled "下一个缩放事件瞬间";
      output Integer next "新的下网格索引";
    protected
      Integer columns = 2 "待插值列";
      Integer ncol = 2 "待插值的列数";
      Integer nrow = size(table, 1) "表格行数";
      Integer next0;
      Real tp;
      Real dt;
      annotation();
    algorithm
      next := last;
      nextEventScaled := timeScaled - TimeEps * abs(timeScaled);
      // 以防没有更多的时间事件
      tp := timeScaled + TimeEps * abs(timeScaled);

      if tp < startTimeScaled then
        // 第一个事件尚未完成
        nextEventScaled := startTimeScaled;
        a := 0;
        b := offset;
      elseif nrow < 2 then
        // 如果表格只有一行，则执行特殊操作
        a := 0;
        b := offset + table[1,columns];
      else
        tp := tp - shiftTimeScaled;
        // 查找下一个时间事件瞬间。注意，两个连续的时间事件瞬时
        // 由于不连续点的存在，表中的值可能相同。
        while next < nrow and tp >= table[next,1] loop
          next := next + 1;
        end while;

        // 如果未到达上一个表项，则定义下一次事件
        if next < nrow then
          nextEventScaled := shiftTimeScaled + table[next,1];
        end if;

        // 确定插值系数
        if next == 1 then
          next := 2;
        end if;
        next0 := next - 1;
        dt := table[next,1] - table[next0,1];
        if dt <= TimeEps * abs(table[next,1]) then
          // 插值间隔不够大，使用“next”值
          a := 0;
          b := offset + table[next,columns];
        else
          a := (table[next,columns] - table[next0,columns]) / dt;
          b := offset + table[next0,columns] - a * table[next0,1];
        end if;
      end if;
      // 将shiftTimeScaled"a*(time-shiftTime)+b"考虑在内
      b := b - a * shiftTimeScaled;
    end getInterpolationCoefficients;
  algorithm
    if noEvent(size(table, 1) > 1) then
      assert(not (table[1,1] > 0.0 or table[1,1] < 0.0), "第一个时间点必须设为0，但表[1,1]=" + String(table[1,1]));
    end if;
    when {time >= pre(nextEvent), initial()} then
      (a,b,nextEventScaled,last) := getInterpolationCoefficients(
        table, 
        offset, 
        startTime / timeScale, 
        timeScaled, 
        last, 
        100 * Modelica.Constants.eps, 
        shiftTime / timeScale);
      nextEvent := nextEventScaled * timeScale;
    end when;
  equation
    assert(size(table, 1) > 0, "未定义表格值");
    timeScaled = time / timeScale;
    y = a * timeScaled + b;
    annotation(
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{-80, 68}, {-80, -80}}, color = {192, 192, 192}), 
      Polygon(
      points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-90, -70}, {82, -70}}, color = {192, 192, 192}), 
      Polygon(
      points = {{90, -70}, {68, -62}, {68, -78}, {90, -70}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Rectangle(
      extent = {{-48, 70}, {2, -50}}, 
      lineColor = {255, 255, 255}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-48, -50}, {-48, 70}, {52, 70}, {52, -50}, {-48, -50}, {-48, -20}, 
      {52, -20}, {52, 10}, {-48, 10}, {-48, 40}, {52, 40}, {52, 70}, {2, 70}, {2, -51}}), 
      Text(
      extent = {{-150, -150}, {150, -110}}, 
      textString = "offset=%offset")}), 
      Documentation(info = "<html><p>
该模块通过表格<strong>线性插值</strong>生成输出信号。 时间点和函数值存储在矩阵<strong>table[i,j]</strong>中， 其中第一列表[:,1]包含时间点，第二列包含待插值的数据。 表格插值具有以下特性：
</p>
<ul><li>
插值间隔是通过线性搜索找到的，其中最后一次调用中使用的间隔被用作起始间隔。</li>
<li>
时间点需要<strong>单调递增</strong>。</li>
<li>
<span style=\"color: rgb(85, 85, 85); font-size: 15px;\">可以通过在表中两次提供相同的时间点来允许</span><span style=\"color: rgb(85, 85, 85);\"><strong>不连续性</strong></span><span style=\"color: rgb(85, 85, 85);\">。</span></li>
<li>
表格范围之<strong>外</strong>的数值， 通过表格最后一个点或前两个点进行<strong>外推法</strong>计算。</li>
<li>
如果表格只有 <strong>一行</strong>， 则不执行插值，只返回与实际时间瞬间无关的函数值。</li>
<li>
通过参数<strong>shiftTime</strong>和<strong>offset</strong>， 表格中定义的曲线可以在时间和纵坐标值上进行移动。 因此，表格中存储的时间点是<strong>相对</strong>于移位时间<strong>shiftTime</strong>的。</li>
<li>
如果 time &lt; startTime，则不执行插值，而是使用偏移量作为输出的纵坐标值。</li>
<li>
如果表格有多行，则第一个时间点<strong>总是</strong>必须设置为<strong>0</strong>， 例如，<strong>table=[1,1;2,2]</strong>是<strong>非法的</strong>。 如果要在时间上移动时间表，请使用<strong>shiftTime</strong>参数。</li>
<li>
该表的实现采用了一种数值上稳健的方法，通过在间隔边界生成<strong>时间事件</strong>。 这为积分器生成了连续可微的值。</li>
<li>
通过参数<strong>timeScale</strong>，可以对表数组的第一列进行缩放， 例如，如果表数组以小时为单位（而不是秒），则<strong>timeScale</strong>应设置为3600。</li>
</ul><p>
Example:
</p>
<blockquote><pre>
   table = [0, 0;
            1, 0;
            1, 1;
            2, 4;
            3, 9;
            4, 16];
If, e.g., time = 1.0, the output y =  0.0 (before event), 1.0 (after event)
    e.g., time = 1.5, the output y =  2.5,
    e.g., time = 2.0, the output y =  4.0,
    e.g., time = 5.0, the output y = 23.0 (i.e., extrapolation).
</pre></blockquote><div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/TimeTable.png\"
     alt=\"TimeTable.png\">
</div>
</html>"  , revisions = "<html>
<h4>Release Notes</h4>
<ul>
<li><em>Oct. 21, 2002</em>
by Christian Schweiger:<br>
Corrected interface from
<blockquote><pre>
parameter Real table[:, :]=[0, 0; 1, 1; 2, 4];
</pre></blockquote>
to
<blockquote><pre>
parameter Real table[:, <strong>2</strong>]=[0, 0; 1, 1; 2, 4];
</pre></blockquote>
</li>
<li><em>Nov. 7, 1999</em>
by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
Realized.</li>
</ul>
</html>"  ));
  end TimeTable;

  block CombiTimeTable 
    "与时间和线性/周期外推法有关的表格查询(数据来自矩阵/文件)"
    import Modelica.Blocks.Tables.Internal;
    extends Modelica.Blocks.Interfaces.MO(final nout = max([size(columns, 1); size(offset, 1)]));
    parameter Boolean tableOnFile = false 
      "=true，如果表格已在文件或函数usertab中定义" 
      annotation(Dialog(group = "表格数据定义"));
    parameter Real table[:,:] = fill(0.0, 0, 2) 
      "表格矩阵(时间=第一列；例如，table=[0, 0; 1, 1; 2, 4])" 
      annotation(Dialog(group = "表格数据定义", enable = not tableOnFile));
    parameter String tableName = "NoName" 
      "文件或函数usertab中的表名(参见文档)" 
      annotation(Dialog(group = "表格数据定义", enable = tableOnFile));
    parameter String fileName = "NoName" "存储矩阵的文件" 
      annotation(Dialog(
      group = "表格数据定义", 
      enable = tableOnFile, 
      loadSelector(filter = "Text files (*.txt);;MATLAB MAT-files (*.mat)", 
      caption = "Open file in which table is present")));
    parameter Boolean verboseRead = true 
      "=true，如果要打印文件正在加载的信息消息" 
      annotation(Dialog(group = "表格数据定义", enable = tableOnFile));
    parameter Integer columns[:] = 2:size(table, 2) 
      "要插值的表格列数" 
      annotation(Dialog(group = "表格数据解释", 
      groupImage = "modelica://Modelica/Resources/Images/Blocks/Sources/CombiTimeTable.png"));
    parameter Modelica.Blocks.Types.Smoothness smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments 
      "表格插值的平滑度" 
      annotation(Dialog(group = "表格数据解释"));
    parameter Modelica.Blocks.Types.Extrapolation extrapolation = Modelica.Blocks.Types.Extrapolation.LastTwoPoints 
      "超出定义范围的数据外推法" 
      annotation(Dialog(group = "表格数据解释"));
    parameter SI.Time timeScale(
      min = Modelica.Constants.eps) = 1 "表格第一列的时间刻度" 
      annotation(Dialog(group = "表格数据解释"), Evaluate = true);
    parameter Real offset[:] = {0} "输出信号的偏移" 
      annotation(Dialog(group = "表格数据解释"));
    parameter SI.Time startTime = 0 
      "输出=时间<起始时间的偏移量" 
      annotation(Dialog(group = "表格数据解释"));
    parameter SI.Time shiftTime = startTime 
      "表格第一列的移位时间" 
      annotation(Dialog(group = "表格数据解释"));
    parameter Modelica.Blocks.Types.TimeEvents timeEvents = Modelica.Blocks.Types.TimeEvents.Always 
      "表格插值的时间事件处理" 
      annotation(Dialog(group = "表格数据解释", enable = smoothness == Modelica.Blocks.Types.Smoothness.LinearSegments));
    parameter Boolean verboseExtrapolation = false 
      "=true，如果时间超出表格定义范围，则打印警告信息" 
      annotation(Dialog(group = "表格数据解释", enable = extrapolation == Modelica.Blocks.Types.Extrapolation.LastTwoPoints or extrapolation == Modelica.Blocks.Types.Extrapolation.HoldLastPoint));
    final parameter SI.Time t_min = t_minScaled * timeScale 
      "表中定义的最小离散值";
    final parameter SI.Time t_max = t_maxScaled * timeScale 
      "表中定义的最大离散值";
    final parameter Real t_minScaled = Internal.getTimeTableTmin(tableID) 
      "表中定义的最小(缩放)离散值";
    final parameter Real t_maxScaled = Internal.getTimeTableTmax(tableID) 
      "表中定义的最大(缩放)离散值";
  protected
    final parameter Real p_offset[nout] = (if size(offset, 1) == 1 then ones(nout) * offset[1] else offset) 
      "输出信号的偏移";
    parameter Modelica.Blocks.Types.ExternalCombiTimeTable tableID = 
      Modelica.Blocks.Types.ExternalCombiTimeTable(
      if tableOnFile then tableName else "NoName", 
      if tableOnFile and fileName <> "NoName" and not Modelica.Utilities.Strings.isEmpty(fileName) then fileName else "NoName", 
      table, 
      startTime / timeScale, 
      columns, 
      smoothness, 
      extrapolation, 
      shiftTime / timeScale, 
      if smoothness == Modelica.Blocks.Types.Smoothness.LinearSegments then timeEvents else if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then Modelica.Blocks.Types.TimeEvents.Always else Modelica.Blocks.Types.TimeEvents.NoTimeEvents, 
      if tableOnFile then verboseRead else false) "外部数据表对象";
    discrete SI.Time nextTimeEvent(start = 0, fixed = true) 
      "下一个时间事件瞬间";
    discrete Real nextTimeEventScaled(start = 0, fixed = true) 
      "下一个缩放时间事件瞬间";
    Real timeScaled "缩放时间";
  equation
    if tableOnFile then
      assert(tableName <> "NoName", 
        "tableOnFile = true and no table name given");
    else
      assert(size(table, 1) > 0 and size(table, 2) > 0, 
        "tableOnFile = false and parameter table is an empty matrix");
    end if;

    if verboseExtrapolation and (
      extrapolation == Modelica.Blocks.Types.Extrapolation.LastTwoPoints or 
      extrapolation == Modelica.Blocks.Types.Extrapolation.HoldLastPoint) then
      assert(noEvent(time >= t_min), "
Extrapolation warning: Time (="   + String(time) + ") must be greater or equal
than the minimum abscissa value t_min (="   + String(t_min) + ") defined in the table.
"  , level = AssertionLevel.warning);
      assert(noEvent(time <= t_max), "
Extrapolation warning: Time (="   + String(time) + ") must be less or equal
than the maximum abscissa value t_max (="   + String(t_max) + ") defined in the table.
"  , level = AssertionLevel.warning);
    end if;

    timeScaled = time / timeScale;
    when {time >= pre(nextTimeEvent), initial()} then
      nextTimeEventScaled = Internal.getNextTimeEvent(tableID, timeScaled);
      nextTimeEvent = if nextTimeEventScaled < Modelica.Constants.inf then nextTimeEventScaled * timeScale else Modelica.Constants.inf;
    end when;
    if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then
      for i in 1:nout loop
        y[i] = p_offset[i] + Internal.getTimeTableValueNoDer(tableID, i, timeScaled, nextTimeEventScaled, pre(nextTimeEventScaled));
      end for;
    elseif smoothness == Modelica.Blocks.Types.Smoothness.LinearSegments then
      for i in 1:nout loop
        y[i] = p_offset[i] + Internal.getTimeTableValueNoDer2(tableID, i, timeScaled, nextTimeEventScaled, pre(nextTimeEventScaled));
      end for;
    else
      for i in 1:nout loop
        y[i] = p_offset[i] + Internal.getTimeTableValue(tableID, i, timeScaled, nextTimeEventScaled, pre(nextTimeEventScaled));
      end for;
    end if;
    annotation(
      Documentation(info="<html><p>
<span style=\"color: rgb(51, 51, 51);\">这个模块通过</span><span style=\"color: rgb(51, 51, 51);\"><strong>常数插值</strong></span><span style=\"color: rgb(51, 51, 51);\">、</span><span style=\"color: rgb(51, 51, 51);\"><strong>线性插值</strong></span><span style=\"color: rgb(51, 51, 51);\">或</span><span style=\"color: rgb(51, 51, 51);\"><strong>三次Hermite样条插值</strong></span><span style=\"color: rgb(51, 51, 51);\">在表格中生成输出信号y[:]。时间点和函数值存储在矩阵</span><span style=\"color: rgb(51, 51, 51);\"><strong>table[i,j]</strong></span><span style=\"color: rgb(51, 51, 51);\">中，其中第一列table[:,1]包含时间点，其他列包含待插值的数据。</span>
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/CombiTimeTable.png\" alt=\"CombiTimeTable.png\" data-href=\"\" style=\"\"/>
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">通过参数 </span><span style=\"color: rgb(51, 51, 51);\"><strong>columns </strong></span><span style=\"color: rgb(51, 51, 51);\">可以定义表格中哪些列进行插值。例如，如果 columns={2,4}，则假设有 2 个输出信号，第一个输出通过对表格矩阵第 2 列进行插值计算得到，第二个输出通过对表格矩阵第 4 列进行插值计算得到。表格插值具有以下特性：</span>
</p>
<li>
<span style=\"color: rgb(51, 51, 51);\">插值区间通过二分查找找到，其中上次调用使用的区间作为起始区间。</span></li>
<li>
<span style=\"color: rgb(51, 51, 51);\">对于三次Hermite样条插值，时间点需要</span><span style=\"color: rgb(51, 51, 51);\"><strong>严格递增</strong></span><span style=\"color: rgb(51, 51, 51);\">，否则需要</span><span style=\"color: rgb(51, 51, 51);\"><strong>单调递增</strong></span><span style=\"color: rgb(51, 51, 51);\">。</span></li>
<li>
<span style=\"color: rgb(51, 51, 51);\">对于常数插值或线性插值，通过在表格中提供相同的时间点两次可以允许</span><span style=\"color: rgb(51, 51, 51);\"><strong>不连续性</strong></span><span style=\"color: rgb(51, 51, 51);\">。</span></li>
<li>
<span style=\"color: rgb(51, 51, 51);\">通过参数 </span><span style=\"color: rgb(51, 51, 51);\"><strong>smoothness </strong></span><span style=\"color: rgb(51, 51, 51);\">可以定义数据的插值方式：</span></li>
<li>
<span style=\"color: rgb(51, 51, 51);\">提供一阶和二阶</span><span style=\"color: rgb(51, 51, 51);\"><strong>导数</strong></span><span style=\"color: rgb(51, 51, 51);\">，但以下两种平滑选项除外</span></li>
<ol><li>
<span style=\"color: rgb(51, 51, 51);\">常数段插值不提供导数。</span></li>
<li>
<span style=\"color: rgb(51, 51, 51);\">线性插值不提供二阶导数。存在设计不一致性，使用线性插值和重复的采样点可以模拟由常数段组成的信号。与常数段插值不同，线性插值提供的第一导数为零。</span></li>
</ol><li>
<span style=\"color: rgb(51, 51, 51);\"><strong>超出</strong></span><span style=\"color: rgb(51, 51, 51);\">表格范围的值，根据参数 </span><span style=\"color: rgb(51, 51, 51);\"><strong>extrapolation </strong></span><span style=\"color: rgb(51, 51, 51);\">的设置进行外推计算。</span></li>
<li>
<span style=\"color: rgb(51, 51, 51);\">如果表格只有</span><span style=\"color: rgb(51, 51, 51);\"><strong>一行</strong></span><span style=\"color: rgb(51, 51, 51);\">，则不执行插值，直接返回该行的表格值。</span></li>
<li>
<span style=\"color: rgb(51, 51, 51);\">通过参数 </span><strong>shiftTime</strong><span style=\"color: rgb(51, 51, 51);\"><strong> </strong></span><span style=\"color: rgb(51, 51, 51);\">和 </span><strong>offset</strong><span style=\"color: rgb(51, 51, 51);\">，可以将表格定义的曲线在时间和纵坐标值上进行平移。因此，表格中存储的时间点是</span><span style=\"color: rgb(51, 51, 51);\"><strong>相对于</strong></span><span style=\"color: rgb(51, 51, 51);\"> </span><strong>shiftTime</strong><span style=\"color: rgb(51, 51, 51);\"><strong> </strong></span><span style=\"color: rgb(51, 51, 51);\">的。</span></li>
<li>
<span style=\"color: rgb(51, 51, 51);\">如果 </span>time &lt; startTime<span style=\"color: rgb(51, 51, 51);\">，则不进行插值，直接使用 </span>offset<span style=\"color: rgb(51, 51, 51);\"> 作为所有输出的纵坐标值。</span></li>
<li>
<span style=\"color: rgb(51, 51, 51);\">该表格通过在区间边界生成</span><span style=\"color: rgb(51, 51, 51);\"><strong>时间事件</strong></span><span style=\"color: rgb(51, 51, 51);\">，以数值稳定的方式实现线性段插值，从而为积分器生成连续可微的值。通过参数 </span><strong>timeEvents</strong><span style=\"color: rgb(51, 51, 51);\"><strong> </strong></span><span style=\"color: rgb(51, 51, 51);\">定义了时间事件的生成方式：对于常数段插值，时间事件总是在区间边界生成；而对于平滑的三次Hermite样条插值，则不在区间边界生成时间事件。</span></li>
<li>
<span style=\"color: rgb(51, 51, 51);\">通过参数 </span><strong>timeScale</strong><span style=\"color: rgb(51, 51, 51);\"><strong> </strong></span><span style=\"color: rgb(51, 51, 51);\">可以对表格数组的第一列进行缩放，例如，如果表格数组是以小时为单位给出的（而不是秒），则应将 </span><strong>timeScale</strong><span style=\"color: rgb(51, 51, 51);\"><strong> </strong></span><span style=\"color: rgb(51, 51, 51);\">设置为 3600。</span></li>
<li>
<span style=\"color: rgb(51, 51, 51);\">对于特殊应用，有时需要知道表格中定义的最小和最大时间点作为参数。为此，提供了参数</span><span style=\"color: rgb(51, 51, 51);\"><strong> </strong></span><strong>t_min</strong><span style=\"color: rgb(51, 51, 51);\"><strong> / </strong></span><strong>t_minScaled</strong><span style=\"color: rgb(51, 51, 51);\"> 和</span><span style=\"color: rgb(51, 51, 51);\"><strong> </strong></span><strong>t_max</strong><span style=\"color: rgb(51, 51, 51);\"><strong> / </strong></span><strong>t_maxScaled</strong><span style=\"color: rgb(51, 51, 51);\">，可以从表格对象外部访问。其中，</span><strong>t_min</strong><span style=\"color: rgb(51, 51, 51);\"><strong> </strong></span><span style=\"color: rgb(51, 51, 51);\">和 </span><strong>t_max</strong><span style=\"color: rgb(51, 51, 51);\"><strong> </strong></span><span style=\"color: rgb(51, 51, 51);\">定义了以 SI.Time 为单位、使用 </span><strong>timeScale</strong><span style=\"color: rgb(51, 51, 51);\"><strong> </strong></span><span style=\"color: rgb(51, 51, 51);\">缩放后的横坐标值，而 </span><strong>t_minScaled</strong><span style=\"color: rgb(51, 51, 51);\"><strong> </strong></span><span style=\"color: rgb(51, 51, 51);\">和 </span><strong>t_maxScaled</strong><span style=\"color: rgb(51, 51, 51);\"><strong> </strong></span><span style=\"color: rgb(51, 51, 51);\">定义了表格的原始无量纲横坐标值。</span></li>
<p>
示例:
</p>
<p>
<br>
</p>
<pre><code >table = [0, 0;
         1, 0;
         1, 1;
         2, 4;
         3, 9;
         4, 16];
extrapolation = 2 (default), timeEvents = 2
If, e.g., time = 1.0, the output y =  0.0 (before event), 1.0 (after event)
    e.g., time = 1.5, the output y =  2.5,
    e.g., time = 2.0, the output y =  4.0,
    e.g., time = 5.0, the output y = 23.0 (i.e., extrapolation via last 2 points).
</code></pre><p>
<br>
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">表格矩阵可以通过以下方式定义：</span>
</p>
<ol><li>
<span style=\"color: rgb(51, 51, 51);\">显式地将</span><span style=\"color: rgb(51, 51, 51);\"><strong>矩阵</strong></span><span style=\"color: rgb(51, 51, 51);\">“table”作为</span><span style=\"color: rgb(51, 51, 51);\"><strong>参数</strong></span><span style=\"color: rgb(51, 51, 51);\">提供，其他参数的值如下：</span></li>
<li>
<span style=\"color: rgb(51, 51, 51);\">从</span><span style=\"color: rgb(51, 51, 51);\"><strong>文件</strong></span><span style=\"color: rgb(51, 51, 51);\"> \"fileName\" </span><span style=\"color: rgb(51, 51, 51);\"><strong>读取</strong></span><span style=\"color: rgb(51, 51, 51);\">，其中矩阵存储为 \"tableName\"。可以是文本格式或 MATLAB MAT 文件格式（文本格式如下所述）。MAT 文件格式有四个不同版本：v4、v6、v7 和 v7.3。该库至少支持 v4、v6 和 v7，而 v7.3 是可选的。当模型中需要使用三个表格 tab1、tab2、tab3 时，最方便的方式是通过 FreeMat 或 MATLAB® 的命令生成 MAT 文件，或者通过 Scilab 的命令生成。</span></li>
<li>
<span style=\"color: rgb(51, 51, 51);\">请注意，可以通过使用辅助函数 </span><a href=\"modelica://Modelica.Utilities.Files.loadResource\" target=\"\">loadResource</a>&nbsp;<span style=\"color: rgb(51, 51, 51);\"> 将 </span>fileName<span style=\"color: rgb(51, 51, 51);\"> 定义为 URI。</span></li>
<li>
<span style=\"color: rgb(51, 51, 51);\">静态存储在文件 \"usertab.c\" 中的函数 \"usertab\" 中。矩阵通过 \"tableName\" 进行标识。参数 fileName = \"NoName\" 或仅包含空格。始终优先使用按行存储，因为否则矩阵将被重新分配并转置。</span></li>
</ol><p>
<span style=\"color: rgb(51, 51, 51);\">当定义常量 \"NO_FILE_SYSTEM\" 时，所有与文件 I/O 相关的源代码部分将被 C 预处理器移除，从而不再进行文件访问。</span>
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">如果从文本文件中读取表格，则文件需要具有以下结构（\"-----\" 不是文件内容的一部分）：</span>
</p>
<p>
<br>
</p>
<pre><code >-----------------------------------------------------
#1
double tab1(6,2)   # comment line
  0   0
  1   0
  1   1
  2   4
  3   9
  4  16
double tab2(6,2)   # another comment line
  0   0
  2   0
  2   2
  4   8
  6  18
  8  32
-----------------------------------------------------
</code></pre><p>
<br>
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">请注意，文件中的前两个字符需要是 \"#1\"（行注释，用于定义文件格式的版本号）。之后，需要声明相应的矩阵，包含类型（如 \"double\" 或 \"float\"）、名称和实际维度。最后，在文件的连续行中，必须给出矩阵的元素。这些元素必须按行优先顺序作为数字序列提供（因此，一个矩阵的行可以跨越文件中的多行，并且不需要从行的开头开始）。数字必须按照 C 语法给出（例如 2.3，-2，+2.e4）。数字分隔符可以是空格、制表符（\\t）、逗号（,）或分号（;）。多个矩阵可以一个接一个地定义。行注释以井号（#）开始，并可以出现在任何地方。文本文件应为 ASCII 或 UTF-8 编码，其中 UTF-8 编码的字符串仅允许出现在行注释中，且文本文件开头的可选 UTF-8 BOM 会被忽略。文件中不允许其他字符，如尾随非注释部分。</span>
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">MATLAB 是 The MathWorks, Inc. 的注册商标。</span>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>",revisions = "<html>
<p><strong>Release Notes:</strong></p>
<ul>
<li><em>April 09, 2013</em>
       by Thomas Beutlich:<br>
       Implemented as external object.</li>
<li><em>March 31, 2001</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Used CombiTableTime as a basis and added the
       arguments <strong>extrapolation, columns, startTime</strong>.
       This allows periodic function definitions.</li>
</ul>
</html>"), 
      Icon(
      coordinateSystem(preserveAspectRatio = true, 
      extent = {{-100.0, -100.0}, {100.0, 100.0}}), 
      graphics = {
      Polygon(lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid, 
      points = {{-80.0, 90.0}, {-88.0, 68.0}, {-72.0, 68.0}, {-80.0, 90.0}}), 
      Line(points = {{-80.0, 68.0}, {-80.0, -80.0}}, 
      color = {192, 192, 192}), 
      Line(points = {{-90.0, -70.0}, {82.0, -70.0}}, 
      color = {192, 192, 192}), 
      Polygon(lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid, 
      points = {{90.0, -70.0}, {68.0, -62.0}, {68.0, -78.0}, {90.0, -70.0}}), 
      Rectangle(lineColor = {255, 255, 255}, 
      fillColor = {255, 215, 136}, 
      fillPattern = FillPattern.Solid, 
      extent = {{-48.0, -50.0}, {2.0, 70.0}}), 
      Line(points = {{-48.0, -50.0}, {-48.0, 70.0}, {52.0, 70.0}, {52.0, -50.0}, {-48.0, -50.0}, {-48.0, -20.0}, {52.0, -20.0}, {52.0, 10.0}, {-48.0, 10.0}, {-48.0, 40.0}, {52.0, 40.0}, {52.0, 70.0}, {2.0, 70.0}, {2.0, -51.0}})}));
  end CombiTimeTable;

  block BooleanConstant "生成布尔类型的常量信号"
    parameter Boolean k = true "恒定输出值" 
      annotation(Dialog(groupImage = "modelica://Modelica/Resources/Images/Blocks/Sources/BooleanConstant.png"));
    extends Interfaces.partialBooleanSource;

  equation
    y = k;
    annotation(
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-80, 0}, {80, 0}}), 
      Text(
      extent = {{-150, -140}, {150, -110}}, 
      textString = "%k")}), 
      Documentation(info="<html><p>
布尔输出 y 是一个常量信号：
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/BooleanConstant.png\"
     alt=\"BooleanConstant.png\">
</div>
</html>"  ));
  end BooleanConstant;

  block BooleanStep "生成布尔类型的阶跃信号"
    parameter SI.Time startTime = 0 "步骤开始的时间瞬间" 
      annotation(Dialog(groupImage = "modelica://Modelica/Resources/Images/Blocks/Sources/BooleanStep.png"));
    parameter Boolean startValue = false "开始时间之前的输出";

    extends Interfaces.partialBooleanSource;
  equation
    y = if time >= startTime then not startValue else startValue;
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Line(
      visible = not startValue, 
      points = {{-80, -70}, {0, -70}, {0, 50}, {80, 50}}), 
      Line(
      visible = startValue, 
      points = {{-80, 50}, {0, 50}, {0, -70}, {68, -70}}), 
      Text(
      extent = {{-150, -140}, {150, -110}}, 
      textString = "%startTime")}), 
      Documentation(info="<html><p>
布尔输出 y 是一个阶跃信号：
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/BooleanStep.png\"
     alt=\"BooleanStep.png\">
</div>
</html>"  ));
  end BooleanStep;

  block BooleanPulse "生成布尔类型的脉冲信号"

    parameter Real width(
      final min = Modelica.Constants.small, 
      final max = 100) = 50 "脉冲宽度占周期的百分比" 
      annotation(Dialog(groupImage = "modelica://Modelica/Resources/Images/Blocks/Sources/BooleanPulse.png"));
    parameter SI.Time period(final min = Modelica.Constants.small, 
      start = 1) "一个周期的时间";
    parameter SI.Time startTime = 0 "第一个脉冲的时刻";
    extends Modelica.Blocks.Interfaces.partialBooleanSource;

  protected
    parameter SI.Time Twidth = period * width / 100 
      "一个脉冲的宽度" annotation(HideResult = true);
    discrete SI.Time pulseStart "脉冲开始时间" 
      annotation(HideResult = true);
  initial equation
    pulseStart = startTime;
  equation
    when sample(startTime, period) then
      pulseStart = time;
    end when;
    y = time >= pulseStart and time < pulseStart + Twidth;
    annotation(
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {Text(
      extent = {{-150, -140}, {150, -110}}, 
      textString = "%period"), Line(points = {{-80, -70}, {-40, -70}, {-40, 44}, {0, 
      44}, {0, -70}, {40, -70}, {40, 44}, {79, 44}})}), 
      Documentation(info = "<html><p>
布尔输出 y 是一个脉冲信号：
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Pulse.png\"
     alt=\"Pulse.png\">
</div>
</html>"    ) );
  end BooleanPulse;

  block SampleTrigger "生成样本触发信号"
    parameter SI.Time period(final min = Modelica.Constants.small, 
      start = 0.01) "采样周期" 
      annotation(Dialog(groupImage = "modelica://Modelica/Resources/Images/Blocks/Sources/SampleTrigger.png"));
    parameter SI.Time startTime = 0 
      "第一次样本触发的时间瞬间";
    extends Interfaces.partialBooleanSource;

  equation
    y = sample(startTime, period);
    annotation(
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{-60, -70}, {-60, 70}}), 
      Line(points = {{-20, -70}, {-20, 70}}), 
      Line(points = {{20, -70}, {20, 70}}), 
      Line(points = {{60, -70}, {60, 70}}), 
      Text(
      extent = {{-150, -140}, {150, -110}}, 
      textString = "%period")}), 
      Documentation(info="<html><p>
布尔输出 y 是一个触发信号，只有在采样时间（由参数<strong>period</strong>定义）输出 y 为<strong>true</strong>， 否则输出 y 为<strong>false</strong>。
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/SampleTrigger.png\" alt=\"SampleTrigger.png\" data-href=\"\" style=\"\">
</p>
</html>"));
  end SampleTrigger;

  block BooleanTable 
    "根据时间瞬时矢量生成布尔输出信号"

    parameter SI.Time table[:] = {0, 1} 
      "时间点向量。在每个时间点，输出 y 都会得到相反的值(例如，table={0,1})" annotation(Dialog(group = "表格数据定义"));
    parameter Boolean startValue = false 
      "y的起始值。在时间=table[1]时，y变为‘not startValue’" annotation(Dialog(group = "表格数据解释", 
      groupImage = "modelica://Modelica/Resources/Images/Blocks/Sources/BooleanTable.png"));
    parameter Modelica.Blocks.Types.Extrapolation extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint 
      "超出定义范围的数据外推法" annotation(Dialog(group = "表格数据解释"));
    parameter SI.Time startTime = -Modelica.Constants.inf 
      "当time<startTime时，输出=false" annotation(Dialog(group = "表格数据解释"));
    parameter SI.Time shiftTime = 0 
      "表格的移位时间" annotation(Dialog(group = "表格数据解释"));

    extends Interfaces.partialBooleanSO;

    CombiTimeTable combiTimeTable(
      final table = if n > 0 then if startValue then [table[1], 1.0; table, {mod(i + 1, 2.0) for i in 1:n}] else [table[1], 0.0; table, {mod(i, 2.0) for i in 1:n}] else if startValue then [0.0, 1.0] else [0.0, 0.0], 
      final smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, 
      final columns = {2}, 
      final extrapolation = extrapolation, 
      final startTime = startTime, 
      final shiftTime = shiftTime) annotation(Placement(transformation(extent = {{-30, -10}, {-10, 10}})));
    Modelica.Blocks.Math.RealToBoolean realToBoolean annotation(Placement(transformation(extent = {{10, -10}, {30, 10}})));

  protected
    function isValidTable "检查表是否有效"
      extends Modelica.Icons.Function;
      input Real table[:] "时间瞬时矢量";
    protected
      constant Integer n = size(table, 1) "表格中数据点数";
      annotation();
    algorithm
      if n > 0 then
        // 检查时间值是否严格单调递增
        for i in 2:n loop
          assert(table[i] > table[i - 1], 
            "表格的时间值不是严格的单调递增：table[" 
            + String(i - 1) + "] = " + String(table[i - 1]) + ", table[" + 
            String(i) + "] = " + String(table[i]));
        end for;
      end if;
    end isValidTable;

    /*参数*/ constant Integer n = size(table, 1) "表格中数据点数";
  initial algorithm
    isValidTable(table);
  equation
    assert(extrapolation <> Modelica.Blocks.Types.Extrapolation.LastTwoPoints, "外推法设置不合适");
    connect(combiTimeTable.y[1], realToBoolean.u) annotation(Line(points = {{-9, 0}, {8, 0}}, color = {0, 0, 127}));
    connect(realToBoolean.y, y) annotation(Line(points = {{31, 0}, {110, 0}, {110, 0}}, color = {255, 127, 0}));
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {Polygon(
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
      Rectangle(
      extent = {{-18, 70}, {32, -50}}, 
      lineColor = {255, 255, 255}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), Line(points = {{-18, -50}, {-18, 70}, {32, 
      70}, {32, -50}, {-18, -50}, {-18, -20}, {32, -20}, {32, 10}, {-18, 10}, {-18, 
      40}, {32, 40}, {32, 70}, {32, 70}, {32, -51}})}), 
      Documentation(info="<html><p>
布尔输出 y 是由参数向量<strong>table</strong>定义的信号。 矢量中存储了时间点。表格插值具有以下特性：
</p>
<ul><li>
在每个时间点，输出 y 的值都会变为前一个时间点的负值；</li>
<li>
表格范围之<strong>外</strong>的数值将根据参数<strong>extrapolation</strong>的设置通过外推法计算；</li>
<li>
通过参数<strong>shiftTime</strong>，可以对表格中定义的曲线进行时间移动。 因此，<span style=\"color: rgb(51, 51, 51);\">表格中存储的时间点是</span><span style=\"color: rgb(51, 51, 51);\"><strong>相对</strong></span><span style=\"color: rgb(51, 51, 51);\">于移位时间</span><span style=\"color: rgb(51, 51, 51);\"><strong>shiftTime</strong></span><span style=\"color: rgb(51, 51, 51);\">的；</span></li>
<li>
如果 time &lt; startTime，则不执行插值，并使用<strong>false</strong>作为输出的纵坐标值。</li>
<li style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/BooleanTable.png\" alt=\"BooleanTable.png\" data-href=\"\" style=\"\"></li>
</ul><p>
准确的语义是：
</p>
<pre><code >if size(table,1) == 0 then
y = startValue;
else
//            time &lt; table[1]: y = startValue
// table[1] ≤ time &lt; table[2]: y = not startValue
// table[2] ≤ time &lt; table[3]: y = startValue
// table[3] ≤ time &lt; table[4]: y = not startValue
// ...
end if;
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
</html>"));
  end BooleanTable;

  block RadioButtonSource "模拟单选按钮的布尔信号源"

    parameter SI.Time buttonTimeTable[:] = {0, 1} 
      "按下按钮的时间瞬间";
    input Boolean reset[:] = {false} 
      "如果重置元素变为true，则将按钮重置为false" 
      annotation(Dialog(group = "时间变化表达式"));

    Modelica.Blocks.Interfaces.BooleanOutput on(start = false, fixed = true) 
      annotation(Placement(transformation(extent = {{100, -15}, {130, 15}})));
  protected
    Modelica.Blocks.Sources.BooleanTable table(table = buttonTimeTable, y(start = false, fixed = true));
    parameter Integer nReset = size(reset, 1);
    Boolean pre_reset[nReset];
  initial equation
    pre(pre_reset) = fill(false, nReset);
    pre(reset) = fill(false, nReset);
  algorithm
    pre_reset := pre(reset);
    when pre_reset then
      on := false;
    end when;

    when change(table.y) then
      on := true;
    end when;

    annotation(Icon(coordinateSystem(
      preserveAspectRatio = false, 
      extent = {{-100, -100}, {100, 100}}, 
      initialScale = 0.06), graphics = {Rectangle(
      extent = {{-100, -100}, {100, 100}}, 
      borderPattern = BorderPattern.Raised, 
      fillColor = DynamicSelect({192, 192, 192}, if on then {0, 255, 0} else {192, 192, 192}), 
      fillPattern = FillPattern.Solid, 
      lineColor = {128, 128, 128}), Text(
      extent = {{-300, 110}, {300, 175}}, 
      textColor = {0, 0, 255}, 
      textString = "%name")}, 
      interaction = {OnMouseDownSetBoolean(on, true)}), Documentation(info="<html><p>
模拟单选按钮的布尔信号源：通过一个表格，单选按钮被按下（即输出 “on” 被设为真）， 当布尔矢量 “reset” 的一个元素变为真时，单选按钮被重置。如果两者同时出现， 则根据表格设置按钮的优先级高于重置按钮。示例
</p>
<pre><code >RadioButtonSource start(buttonTimeTable={1,3}, reset={stop.on});
RadioButtonSource stop (buttonTimeTable={2,4}, reset={start.on});</code></pre><p>
“开始” 按钮在时间=1 s和时间=3 s时按下，而 “stop” 按钮在时间=2 s和时间=4 s时按下。 结果如下：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/RadioButtonSource.png\" alt=\"RadioButtonSource.png\" data-href=\"\" style=\"\">
</p>
<p>
该示例还可在 <a href=\"modelica://Modelica.Blocks.Examples.Interaction1\" target=\"\">Modelica.Blocks.Examples.Interaction1</a>
</p>
<p>
<br>
</p>
</html>"));
  end RadioButtonSource;

  block IntegerConstant "生成整数类型的常量信号"
    parameter Integer k(start = 1) "恒定输出值";
    extends Interfaces.IntegerSO;

  equation
    y = k;
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Line(points = {{-80, 68}, {-80, -80}}, color = {192, 192, 192}), 
      Polygon(
      points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-90, -70}, {82, -70}}, color = {192, 192, 192}), 
      Polygon(
      points = {{90, -70}, {68, -62}, {68, -78}, {90, -70}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-80, 0}, {80, 0}}), 
      Text(
      extent = {{-150, -150}, {150, -110}}, 
      textString = "k=%k")}), 
      Documentation(info="<html><p>
整数输出 y 是一个常量信号：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/IntegerConstant.png\" alt=\"IntegerConstant.png\" data-href=\"\" style=\"\">
</p>
</html>"));
  end IntegerConstant;

  block IntegerStep "生成整数类型的阶跃信号"
    parameter Integer height = 1 "阶跃高度";
    extends Interfaces.IntegerSignalSource;
  equation
    y = offset + (if time < startTime then 0 else height);
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Line(points = {{-80, 68}, {-80, -80}}, color = {192, 192, 192}), 
      Polygon(
      points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-90, -70}, {82, -70}}, color = {192, 192, 192}), 
      Polygon(
      points = {{90, -70}, {68, -62}, {68, -78}, {90, -70}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-80, -70}, {0, -70}, {0, 50}, {80, 50}}), 
      Text(
      extent = {{-150, -150}, {150, -110}}, 
      textString = "startTime=%startTime")}), 
      Documentation(info="<html><p>
整数输出 y 是一个阶跃信号：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/IntegerStep.png\" alt=\"IntegerStep.png\" data-href=\"\" style=\"\">
</p>
</html>"));
  end IntegerStep;

  block IntegerTable 
    "根据含有[time, yi]值的表格矩阵生成整数输出信号"

    parameter Real table[:,2] = fill(0, 0, 2) "表格矩阵(第一列：时间；第二列：y)" annotation(Dialog(group = "表格数据定义"));
    parameter Modelica.Blocks.Types.Extrapolation extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint 
      "超出定义范围的数据外推法" annotation(Dialog(group = "表格数据解释"));
    parameter SI.Time startTime = -Modelica.Constants.inf 
      "Time<startTime时，输出=0" annotation(Dialog(group = "表格数据解释"));
    parameter SI.Time shiftTime = 0 
      "表格第一列的移位时间" annotation(Dialog(group = "表格数据解释"));

    extends Interfaces.IntegerSO;

    CombiTimeTable combiTimeTable(
      final table = table, 
      final smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, 
      final columns = {2}, 
      final extrapolation = extrapolation, 
      final startTime = startTime, 
      final shiftTime = shiftTime) annotation(Placement(transformation(extent = {{-30, -10}, {-10, 10}})));
    Modelica.Blocks.Math.RealToInteger realToInteger annotation(Placement(transformation(extent = {{10, -10}, {30, 10}})));

  protected
    function isValidTable "检查表是否有效"
      extends Modelica.Icons.Function;
      input Real table[:,2] "表格矩阵";
    protected
      SI.Time t_last;
      Integer n = size(table, 1) "表格中数据点数";
      annotation();
    algorithm
      if n > 0 then
        // 检查时间值是否严格单调递增
        t_last := table[1,1];
        for i in 2:n loop
          assert(table[i,1] > t_last, 
            "表格的时间值不是严格的单调递增：table[" 
            + String(i - 1) + ",1] = " + String(table[i - 1,1]) + "table[" + 
            String(i) + ",1] = " + String(table[i,1]));
        end for;

        // 检查第二列中的所有值是否都是整数值
        for i in 1:n loop
          assert(rem(table[i,2], 1) == 0.0, 
            "表值不是整数：table[" + String(i) + ",2] = " + 
            String(table[i,2]));
        end for;
      end if;
    end isValidTable;

    parameter Integer n = size(table, 1) "表格中数据点数";
  initial algorithm
    isValidTable(table);
  equation
    assert(n > 0, "未定义表格值");
    assert(extrapolation <> Modelica.Blocks.Types.Extrapolation.LastTwoPoints, "外推法设置不合适");
    connect(combiTimeTable.y[1], realToInteger.u) annotation(Line(points = {{-9, 0}, {8, 0}}, color = {0, 0, 127}));
    connect(realToInteger.y, y) annotation(Line(points = {{31, 0}, {110, 0}, {110, 0}}, color = {255, 127, 0}));
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), 
      graphics = {
      Line(points = {{-80, 64}, {-80, -84}}, color = {192, 192, 192}), 
      Polygon(
      points = {{-80, 86}, {-88, 64}, {-72, 64}, {-80, 86}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-90, -74}, {82, -74}}, color = {192, 192, 192}), 
      Polygon(
      points = {{90, -74}, {68, -66}, {68, -82}, {90, -74}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Rectangle(
      extent = {{-46, 68}, {4, -52}}, 
      lineColor = {255, 255, 255}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-46, -52}, {-46, 68}, {54, 68}, {54, -52}, {-46, -52}, {-46, -22}, 
      {54, -22}, {54, 8}, {-46, 8}, {-46, 38}, {54, 38}, {54, 68}, {4, 68}, {4, -53}})}), 
      Documentation(info="<html><p>
该模块通过表格生成整数输出信号。 时间点和 y 值存储在矩阵<strong>table[i,j]</strong>中， 其中第一列 table[:,1]包含实数时间点， 第二列包含该时间点输出 y 的整数值。 表格插值具有以下特性：
</p>
<ul><li>
如果没有提供表格值， 如果时间点不是严格的单调递增， 或者如果表格矩阵的第二列不包含整数值， 则会触发断言。</li>
<li>
表格范围之<strong>外</strong>的数值将根据参数<strong>extrapolation</strong>的设置通过外推法计算：</li>
<li>
如果表格只有<strong>一行</strong>，则不执行插值，只返回这一行的表格值。</li>
<li>
通过参数 <strong>shiftTime</strong>，可以对表格中定义的曲线进行时间移动。 因此，<span style=\"color: rgb(51, 51, 51);\">表格中存储的时间点是</span><span style=\"color: rgb(51, 51, 51);\"><strong>相对</strong></span><span style=\"color: rgb(51, 51, 51);\">于移位时间</span><span style=\"color: rgb(51, 51, 51);\"><strong>shiftTime</strong></span><span style=\"color: rgb(51, 51, 51);\">的</span>。</li>
<li>
如果 time &lt; startTime，则不执行插值，输出的纵坐标值为零。</li>
</ul><p>
例如:
</p>
<pre><code >table = [  0, 1;
1, 4;
1.5, 5;
2, 6];</code></pre><p>
结果输出如下：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/IntegerTable.png\" alt=\"IntegerTable.png\" data-href=\"\" style=\"\">
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
  end IntegerTable;
  annotation(Documentation(info = "<html>
<p>
该程序包包含<strong>source</strong>组件，
即只有输出信号的模块。这些模块可用作实数、整数和布尔信号的信号发生器。
</p>

<p>
所有实数信号源（常数信号源除外）至少有以下两个参数：
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>offset</strong></td>
      <td>Value which is added to the signal</td>
  </tr>
  <tr><td><strong>startTime</strong></td>
      <td>Start time of signal. For time &lt; startTime,
                the output y is set to offset.</td>
  </tr>
</table>

<p>
<strong>offset</strong>参数尤其有助于移动相应的信号源，
使系统在初始时处于静止状态。
要确定相应的偏移值，通常需要进行微调计算。
</p>
</html>", revisions = "<html>
<ul>
<li><em>October 21, 2002</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and Christian Schweiger:<br>
       Integer sources added. Step, TimeTable and BooleanStep slightly changed.</li>
<li><em>Nov. 8, 1999</em>
       by <a href=\"mailto:christoph@clauss-it.com\">Christoph Clau&szlig;</a>,
       <a href=\"mailto:Andre.Schneider@eas.iis.fraunhofer.de\">Andre.Schneider@eas.iis.fraunhofer.de</a>,
       <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       New sources: Exponentials, TimeTable. Trapezoid slightly enhanced
       (nperiod=-1 is an infinite number of periods).</li>
<li><em>Oct. 31, 1999</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       <a href=\"mailto:christoph@clauss-it.com\">Christoph Clau&szlig;</a>,
       <a href=\"mailto:Andre.Schneider@eas.iis.fraunhofer.de\">Andre.Schneider@eas.iis.fraunhofer.de</a>,
       All sources vectorized. New sources: ExpSine, Trapezoid,
       BooleanConstant, BooleanStep, BooleanPulse, SampleTrigger.
       Improved documentation, especially detailed description of
       signals in diagram layer.</li>
<li><em>June 29, 1999</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized a first version, based on an existing Dymola library
       of Dieter Moormann and Hilding Elmqvist.</li>
</ul>
</html>"));
end Sources;