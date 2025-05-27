within Modelica.Blocks;
package MathInteger 
  "作为输入/输出模块的整型数学函数库"
  extends Modelica.Icons.Package;
  block MultiSwitch 
    "设置与第一个有效输入信号相关联的整数表达式"

    input Integer expr[nu] = fill(0, nu) 
      "y=如果u[i]为真，那么为expr[i]，否则如果use_pre_as_default为真，那么为pre(y)，否则为y_default" annotation(Dialog);
    parameter Integer y_default = 0 
      "如果use_pre_as_default=false则输出y的默认值，以及初始时的pre(y)值";

    parameter Boolean use_pre_as_default = true 
      "=true，如果所有u[i]=false则y保留最后的值，否则y=y_default" 
      annotation(HideResult = true, choices(checkBox = true));
    parameter Integer nu(min = 0) = 0 "输入接口数量" 
      annotation(Dialog(connectorSizing = true), HideResult = true);

    Modelica.Blocks.Interfaces.BooleanVectorInput u[nu] 
      "设置y=expr[i]，如果u[i]=true" 
      annotation(Placement(transformation(extent = {{-110, 30}, {-90, -30}})));
    Modelica.Blocks.Interfaces.IntegerOutput y "根据表达式输出" 
      annotation(Placement(transformation(extent = {{300, -10}, {320, 10}})));

  protected
    Integer firstActiveIndex;
  initial equation
    pre(y) = y_default;
  equation
    firstActiveIndex = Modelica.Math.BooleanVectors.firstTrueIndex(
      u);
    y = if firstActiveIndex > 0 then expr[firstActiveIndex] else 
      if use_pre_as_default then pre(y) else y_default;
    annotation(defaultComponentName = "multiSwitch1", Icon(coordinateSystem(
      preserveAspectRatio = false, 
      extent = {{-100, -100}, {300, 100}}), graphics = {
      Text(
      extent = {{310, -25}, {410, -45}}, 
      textString = DynamicSelect(" ", String(
      y, 
      minimumLength = 1, 
      significantDigits = 0))), 
      Text(
      visible = not use_pre_as_default, 
      extent = {{-100, -60}, {300, -90}}, 
      textString = "else: %y_default"), 
      Text(
      visible = use_pre_as_default, 
      extent = {{-100, -50}, {300, -80}}, 
      textString = "else: pre(y)"), 
      Rectangle(
      extent = {{-100, -40}, {300, 40}}, 
      fillColor = {255, 213, 170}, 
      fillPattern = FillPattern.Solid, 
      borderPattern = BorderPattern.Raised), 
      Text(
      extent = {{-100, 90}, {300, 50}}, 
      textString = "%name", 
      textColor = {0, 0, 255}), 
      Text(
      extent = {{-80, 15}, {290, -15}}, 
      textString = "%expr")}), 
      Documentation(info = "<html>
<p>
该模块有一个布尔输入信号 u[nu] 矢量和一个（随时间变化的）整数表达式 expr[nu] 矢量。
如果 i 是输入向量 u 中第一个为真的元素，则输出信号 y 设为 expr[i]。
如果所有输入信号都为假，则 y 设置为参数 “y_default”；如果 use_pre_as_default = <strong>true</strong>，则保留最后一个值。
</p>

<blockquote><pre>
// Conceptual equation (not valid Modelica)
i = 'first element of u[:] that is true';
y = <strong>if</strong> i==0 <strong>then</strong> (<strong>if</strong> use_pre_as_default <strong>then</strong> pre(y)
                                        <strong>else</strong> y_default)
    <strong>else</strong> expr[i];
</pre></blockquote>

<p>
输入连接器是布尔输入信号的向量。
在绘制连接线时，输入向量的尺寸会放大一个，
连接线会自动连接到这个新的空白索引
（这要归功于 connectorSizing 注解）。
</p>

<p>
举例说明其用法 
<a href=\"modelica://Modelica.Blocks.Examples.IntegerNetwork1\">Modelica.Blocks.Examples.IntegerNetwork1</a>.
</p>

</html>"));
  end MultiSwitch;

  block Sum "整数之和： y=k[1]*u[1]+k[2]*u[2]+...+k[n]*u[n]"
    extends Modelica.Blocks.Interfaces.PartialIntegerMISO;
    parameter Integer k[nu] = fill(1, nu) "输入增益";
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
      textString = "+")}), Documentation(info="<html><p>
该模块将整数输入信号向量 u 的元素之和作为标量整数输出 “y” 进行计算：
</p>
<pre><code >y = k[1]*u[1] + k[2]*u[2] + ... k[N]*u[N];</code></pre><p>
输入连接器是一个整数输入信号向量。 绘制连接线时，输入矢量的尺寸会放大一个， 连接线会自动连接到这个新的空白索引 （这要归功于 connectorSizing 注解）。
</p>
<p>
举例说明其用法 <a href=\"modelica://Modelica.Blocks.Examples.IntegerNetwork1\" target=\"\">Modelica.Blocks.Examples.IntegerNetwork1</a>.
</p>
<p>
如果输入接口 “u” 没有连接，则输出设置为零：y=0。
</p>
<p>
<br>
</p>
</html>"));
  end Sum;

  block Product "整数的乘积：y=u[1]*u[2]*...*u[n]"
    extends Modelica.Blocks.Interfaces.PartialIntegerMISO;
  equation
    if size(u, 1) > 0 then
      y = product(u);
    else
      y = 0;
    end if;

    annotation(Icon(graphics = {Text(
      extent = {{-74, 50}, {94, -94}}, 
      textString = "*")}), Documentation(info="<html><p>
该模块将整数输入信号向量 u 的元素乘积作为标量整数输出 “y”：
</p>
<pre><code >y = u[1]*u[2]* ... *u[N];</code></pre><p>
输入连接器是一个整数输入信号向量。 绘制连接线时，输入矢量的尺寸会放大一个， 连接线会自动连接到这个新的空白索引 （这要归功于 connectorSizing 注解）。
</p>
<p>
举例说明其用法 <a href=\"modelica://Modelica.Blocks.Examples.IntegerNetwork1\" target=\"\">Modelica.Blocks.Examples.IntegerNetwork1</a>.
</p>
<p>
如果输入连接器 “u” 没有连接，则输出设置为零：y=0。
</p>
<p>
<br>
</p>
</html>"));
  end Product;



  block TriggeredAdd 
    "如果触发端口处于上升沿，则将输入值加到输出值的前一个值上"
    extends Modelica.Blocks.Interfaces.PartialIntegerSISO;

    parameter Boolean use_reset = false "=true，如果重置端口已启用" 
      annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
    parameter Boolean use_set = false 
      "=true，如果设置端口已启用，则重置时用作默认值" 
      annotation(Dialog(enable = use_reset), Evaluate = true, HideResult = true, choices(checkBox = true));
    parameter Integer y_start = 0 
      "如果不使用设置的端口，y的初始值和重置值";

    Modelica.Blocks.Interfaces.BooleanInput trigger annotation(Placement(
      transformation(
      extent = {{-20, -20}, {20, 20}}, 
      rotation = 90, 
      origin = {-60, -120})));
    Modelica.Blocks.Interfaces.BooleanInput reset if use_reset annotation(Placement(
      transformation(
      extent = {{-20, -20}, {20, 20}}, 
      rotation = 90, 
      origin = {60, -120})));
    Modelica.Blocks.Interfaces.IntegerInput set if use_set annotation(Placement(transformation(
      extent = {{-20, -20}, {20, 20}}, 
      rotation = 270, 
      origin = {60, 120}), iconTransformation(
      extent = {{-20, -20}, {20, 20}}, 
      rotation = 270, 
      origin = {28, 98})));
  protected
    Modelica.Blocks.Interfaces.BooleanOutput local_reset annotation(HideResult = true);
    Modelica.Blocks.Interfaces.IntegerOutput local_set;
  initial equation
    pre(y) = y_start;
  equation
    if use_reset then
      connect(reset, local_reset);
      if use_set then
        connect(set, local_set);
      else
        local_set = y_start;
      end if;
    else
      local_reset = false;
      local_set = 0;
    end if;

    when {trigger, local_reset} then
      y = if local_reset then local_set else pre(y) + u;
    end when;
    annotation(Icon(coordinateSystem(
      preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, 
      initialScale = 0.06), graphics = {
      Line(
      points = {{-100, 0}, {32, 76}}, 
      color = {255, 128, 0}, 
      pattern = LinePattern.Dot), 
      Line(
      points = {{-100, 0}, {32, -20}}, 
      color = {255, 128, 0}, 
      pattern = LinePattern.Dot), 
      Line(
      points = {{-54, -56}, {-26, -56}, {-26, -20}, {32, -20}, {32, 76}}), 
      Line(
      points = {{-60, -100}, {32, -20}}, 
      color = {255, 0, 255}, 
      pattern = LinePattern.Dot), 
      Text(
      visible = use_reset, 
      extent = {{-28, -62}, {94, -86}}, 
      textString = "reset")}), 
      Documentation(info = "<html>
<p>
如果触发端口处于上升沿，则将输入值加到输出值的前一个值上
</p>

<p>
该模块有一个整数输入端 “u”、一个布尔输入端 “触发”、
一个可选的布尔输入端 “重置”、一个可选的整数输入端 “设置” 和一个整数输出端 “y”。
可选输入可分别使用 “use_reset” 和 “use_set” 标志激活。
</p>

<p>
如果 “触发” 端口有一个上升沿，则输入 “u” 与输出 “y” 的前一个值相加。模拟开始时为 “y = y_start”。
</p>

<p>
如果启用了 “复位” 端口，那么只要 “复位” 端口出现上升沿，
输出 “y” 就会复位为 “set” 或 “y_start”（如果未启用 “set” 端口）。
</p>

<p>
举例说明其用法 
<a href=\"modelica://Modelica.Blocks.Examples.IntegerNetwork1\">Modelica.Blocks.Examples.IntegerNetwork1</a>.
</p>

</html>"));
  end TriggeredAdd;




  annotation(Documentation(info="<html><p>
该程序包包含<strong>Integer</strong>信号的基本<strong>mathematical operations</strong>。
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, 
    {100, 100}}), graphics = {Line(
    points = {{-74, -66}, {-46, -66}, {-46, -30}, {12, -30}, {12, 66}}, 
    color = {255, 128, 0}), Line(
    points = {{12, 66}, {70, 66}}, 
    color = {255, 128, 0})}));
end MathInteger;