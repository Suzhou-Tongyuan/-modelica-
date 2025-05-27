within Modelica.Blocks;
package MathBoolean 
  "作为输入/输出模块的布尔数学函数库"
  extends Modelica.Icons.Package;

  block MultiSwitch 
    "设置与第一个活动输入信号相关联的布尔表达式"

    input Boolean expr[nu] = fill(false, nu) 
      "设置y=如果u[i]那么expr[i]否则y_default(随时间变化)" annotation(Dialog);
    parameter Boolean use_pre_as_default = true 
      "设置为真，将最后一个值保留为默认值(y_default=pre(y))" 
      annotation(HideResult = true, choices(checkBox = true));
    parameter Boolean y_default = false 
      "如果所有u[i]=false，输出y的默认值" 
      annotation(Dialog(enable = not use_pre_as_default));

    parameter Integer nu(min = 0) = 0 "输入接口数量" 
      annotation(Dialog(connectorSizing = true), HideResult = true);

    Modelica.Blocks.Interfaces.BooleanVectorInput u[nu] 
      "设置y=expr[i]，如果u[i]=true" 
      annotation(Placement(transformation(extent = {{-110, 30}, {-90, -30}})));
    Modelica.Blocks.Interfaces.BooleanOutput y "根据表达式输出" 
      annotation(Placement(transformation(extent = {{300, -10}, {320, 10}})));

  protected
    Integer firstActiveIndex;
  initial equation
    pre(y) = y_default;
  equation
    firstActiveIndex = 
      Modelica.Math.BooleanVectors.firstTrueIndex(
      u);
    y = if firstActiveIndex == 0 then (if use_pre_as_default then pre(y) else y_default) else 
      expr[firstActiveIndex];
    annotation(
      defaultComponentName = "set1", 
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {300, 100}}), graphics = {
      Text(
      visible = not use_pre_as_default, 
      extent = {{-100, -60}, {300, -90}}, 
      textString = "else: %y_default"), 
      Text(
      visible = use_pre_as_default, 
      extent = {{-100, -60}, {300, -90}}, 
      textString = "else: pre(y)"), 
      Text(
      extent = {{-99, 99}, {300, 59}}, 
      textString = "%name", 
      textColor = {0, 0, 255}), 
      Rectangle(
      extent = {{-100, -51}, {300, 50}}, 
      lineColor = {255, 127, 0}, 
      lineThickness = 5.0, 
      fillColor = {210, 210, 210}, 
      fillPattern = FillPattern.Solid, 
      borderPattern = BorderPattern.Raised), 
      Text(
      extent = {{-84, 16}, {273, -15}}, 
      textString = "%expr"), 
      Ellipse(
      extent = {{275, 8}, {289, -6}}, 
      lineColor = DynamicSelect({235, 235, 235}, if y then {0, 255, 0} else {235, 235, 235}), 
      fillColor = DynamicSelect({235, 235, 235}, if y then {0, 255, 0} else {235, 235, 235}), 
      fillPattern = FillPattern.Solid)}), 
      Documentation(info="<html><p>
该模块有一个布尔输入信号向量 u[nu] 和一个（随时间变化的）布尔表达式向量 expr[:]。 如果 i 是输入向量 u 中第一个为真的元素，则输出信号 y 设置为 expr[i]。 如果所有输入信号都为假，则 y 设置为参数 “y_default”； 如果参数 use_pre_as_default = <strong>true</strong>，则保留 y 之前的值：
</p>
<pre><code >// Conceptual equation (not valid Modelica)
i = \\\\'first element of u[:] that is true\\\\';
y = if i==0 then (if use_pre_as_default then pre(y)
else y_default)
else expr[i];</code></pre><p>
举例说明其用法 <a href=\"modelica://Modelica.Blocks.Examples.BooleanNetwork1\" target=\"\">Modelica.Blocks.Examples.BooleanNetwork1</a>.
</p>
</html>"));
  end MultiSwitch;

  block And "逻辑'and'：y=u[1]和u[2]和...和u[nu]"
    extends Modelica.Blocks.Interfaces.PartialBooleanMISO;

  equation
    y = Modelica.Math.BooleanVectors.andTrue(
      u);
    annotation(defaultComponentName = "and1", Icon(graphics = {Text(
      extent = {{-76, 40}, {60, -40}}, 
      textString = "and")}), 
      Documentation(info="<html><p>
<span style=\"color: rgb(51, 51, 51);\">如果所有输入都为真，则输出为真；否则，输出为假。</span>
</p>
<p>
输入连接器是布尔输入信号的向量。 绘制连接线时，输入矢量的尺寸会放大一个， 连接线会自动连接到这个新的自由索引上（这要归功于连接器尺寸注释）。
</p>
<p>
举例说明其用法 <a href=\"modelica://Modelica.Blocks.Examples.BooleanNetwork1\" target=\"\">Modelica.Blocks.Examples.BooleanNetwork1</a>&nbsp;.
</p>
<p>
如果输入接口 “u” 没有连接，则输出设置为 <strong>true</strong>：y=true。
</p>
</html>"));
  end And;

  block Or "逻辑'or'：y =u[1]或u[2]或...或u[nu]"
    extends Modelica.Blocks.Interfaces.PartialBooleanMISO;

  equation
    y = Modelica.Math.BooleanVectors.anyTrue(
      u);
    annotation(defaultComponentName = "or1", Icon(graphics = {Text(
      extent = {{-80, 40}, {60, -40}}, 
      textString = "or")}), 
      Documentation(info = "<html>
<p>
如果至少有一个输入为<strong>true</strong>，则输出为<strong>true</strong>，否则输出为<strong>false</strong>。
</p>

<p>
输入连接器是布尔输入信号的向量。
绘制连接线时，输入矢量的尺寸会放大一个，
连接线会自动连接到这个新的自由索引上（这要归功于连接器尺寸注释）。
</p>

<p>
举例说明其用法
<a href=\"modelica://Modelica.Blocks.Examples.BooleanNetwork1\">Modelica.Blocks.Examples.BooleanNetwork1</a>.
</p>

<p>
如果输入接口 “u” 没有连接，则输出设置为 <strong>false</strong>：y=true。
</p>

</html>"));
  end Or;

  block Xor 
    "逻辑'xor'：y=oneTrue(u)(如果u中正好有一个元素为真，则y为真；否则为假）"
    extends Modelica.Blocks.Interfaces.PartialBooleanMISO;

  equation
    y = Modelica.Math.BooleanVectors.oneTrue(
      u);
    annotation(defaultComponentName = "xor1", Icon(graphics = {Text(
      extent = {{-80, 40}, {60, -40}}, 
      textString = "xor")}), 
      Documentation(info = "<html>
<p>
如果正好有一个输入为<strong>true</strong>，则输出为<strong>true</strong>，
否则输出为<strong>false</strong>。
</p>

<p>
输入连接器是布尔输入信号的向量。
绘制连接线时，输入矢量的尺寸会放大一个，
连接线会自动连接到这个新的自由索引上（这要归功于连接器尺寸注释）。
</p>

<p>
举例说明其用法
<a href=\"modelica://Modelica.Blocks.Examples.BooleanNetwork1\">Modelica.Blocks.Examples.BooleanNetwork1</a>.
</p>

<p>
如果输入连接器 “u” 没有连接，则输出设置为 <strong>false</strong>：y=false。
</p>

</html>"));
  end Xor;

  block Nand "逻辑'nand'：y=非(u[1]和u[2]和...和u[nu])"
    extends Modelica.Blocks.Interfaces.PartialBooleanMISO;

  equation
    y = not Modelica.Math.BooleanVectors.andTrue(
      u);
    annotation(defaultComponentName = "nand1", Icon(graphics = {Text(
      extent = {{-78, 36}, {64, -30}}, 
      textString = "nand")}), 
      Documentation(info="<html><p>
如果至少有一个输入为<strong>false</strong>，则输出为<strong>true</strong>，否则输出为<strong>false</strong>。
</p>
<p>
输入连接器是布尔输入信号的向量。 绘制连接线时，输入矢量的尺寸会放大一个， 连接线会自动连接到这个新的自由索引上（这要归功于连接器尺寸注释）。
</p>
<p>
举例说明其用法 <a href=\"modelica://Modelica.Blocks.Examples.BooleanNetwork1\" target=\"\">Modelica.Blocks.Examples.BooleanNetwork1</a>.
</p>
<p>
如果输入连接器 “u” 没有连接，则输出设置为 <strong>false</strong>：y=false。
</p>
</html>"  ));
  end Nand;

  block Nor "逻辑'nor'：y=非(u[1]或u[2]或...或u[nu])"
    extends Modelica.Blocks.Interfaces.PartialBooleanMISO;

  equation
    y = not Modelica.Math.BooleanVectors.anyTrue(
      u);
    annotation(defaultComponentName = "nor1", Icon(graphics = {Text(
      extent = {{-80, 40}, {60, -40}}, 
      textString = "nor")}), 
      Documentation(info="<html><p>
如果至少有一个输入为<strong>true</strong>，则输出为<strong>false</strong>，否则输出为<strong>true</strong>。
</p>
<p>
输入连接器是布尔输入信号的向量。 绘制连接线时，输入矢量的尺寸会放大一个， 连接线会自动连接到这个新的自由索引上（这要归功于连接器尺寸注释）。
</p>
<p>
举例说明其用法 <a href=\"modelica://Modelica.Blocks.Examples.BooleanNetwork1\" target=\"\">Modelica.Blocks.Examples.BooleanNetwork1</a>.
</p>
<p>
如果输入连接器 “u” 没有连接，则输出设置为 <strong>false</strong>：y=false。
</p>
</html>"));
  end Nor;

  block Not "逻辑'not'：y=非u"
    extends Modelica.Blocks.Interfaces.PartialBooleanSISO_small;

  equation
    y = not u;
    annotation(defaultComponentName = "not1", Icon(graphics = {Text(
      extent = {{-98, 40}, {42, -40}}, 
      textString = "not")}), 
      Documentation(info="<html><p>
如果输入为<strong>true</strong>，则输出为<strong>false</strong>，否则输出为<strong>true</strong>。
</p>
<p>
输入连接器是布尔输入信号的向量。 绘制连接线时，输入矢量的尺寸会放大一个， 连接线会自动连接到这个新的自由索引上（这要归功于连接器尺寸注释）。
</p>
<p>
举例说明其用法 <a href=\"modelica://Modelica.Blocks.Examples.BooleanNetwork1\" target=\"\">Modelica.Blocks.Examples.BooleanNetwork1</a>&nbsp;.
</p>
</html>"));
  end Not;

  block RisingEdge 
    "如果输入u为上升沿，则输出y为真；否则为假(y=edge(u))"
    parameter Boolean pre_u_start = false "初始时的pre(u)值";
    extends Modelica.Blocks.Interfaces.PartialBooleanSISO_small;
  initial equation
    pre(u) = pre_u_start;
  equation
    y = edge(u);
    annotation(defaultComponentName = "rising1", Icon(graphics = {Line(points = 
      {{-80, -68}, {-36, -68}, {-36, -24}, {22, -24}, {22, -68}, {66, -68}}), Line(points = {{-80, 32}, {-36, 32}, {-36, 76}, {-36, 76}, 
      {-36, 32}, {66, 32}}, color = {255, 0, 255})}), 
      Documentation(info = "<html>
<p>
布尔输入 u 的上升沿导致该时刻 y = <strong>true</strong>。在所有其他时间瞬间，y = <strong>false</strong>。
</p>

<p>
举例说明其用法
<a href=\"modelica://Modelica.Blocks.Examples.BooleanNetwork1\">Modelica.Blocks.Examples.BooleanNetwork1</a>.
</p>

</html>"));
  end RisingEdge;

  block FallingEdge 
    "如果输入u为下降沿，则输出y为真；否则为假(y=edge(notu)"
    parameter Boolean pre_u_start = false "初始时的pre(u)值";
    extends Modelica.Blocks.Interfaces.PartialBooleanSISO_small;
  protected
    Boolean not_u = not u annotation(HideResult = true);
  initial equation
    pre(not_u) = not pre_u_start;
  equation
    y = edge(not_u);
    annotation(defaultComponentName = "falling1", Icon(graphics = {Line(points = 
      {{-80, -68}, {-36, -68}, {-36, -24}, {22, -24}, {22, -68}, {66, -68}}), Line(points = {{-80, 32}, {24, 32}, {24, 76}, {24, 76}, {
      24, 32}, {66, 32}}, color = {255, 0, 255})}), 
      Documentation(info = "<html>
<p>
布尔输入 u 的下降沿导致该时刻 y = <strong>true</strong>。
在所有其他时间瞬间，y =  <strong>false</strong>。

</p>

<p>
举例说明其用法
<a href=\"modelica://Modelica.Blocks.Examples.BooleanNetwork1\">Modelica.Blocks.Examples.BooleanNetwork1</a>.
</p>

</html>"  ));
  end FallingEdge;

  block ChangingEdge 
    "如果输入u出现上升沿或下降沿，则输出y为真；否则为假(y=change(u))"
    parameter Boolean pre_u_start = false "初始时的pre(u)值";
    extends Modelica.Blocks.Interfaces.PartialBooleanSISO_small;
  initial equation
    pre(u) = pre_u_start;
  equation
    y = change(u);
    annotation(defaultComponentName = "changing1", Icon(graphics = {
      Line(points = {{-80, -68}, {-36, -68}, {-36, -24}, {22, -24}, {22, -68}, {66, -68}}), 
      Line(points = {{-80, 32}, {-36, 32}, {-36, 76}, {-36, 76}, {-36, 32}, {66, 32}}, 
      color = {255, 0, 255}), 
      Line(
      points = {{24, 32}, {24, 76}}, 
      color = {255, 0, 255})}), Documentation(info = "<html>
<p>
布尔输入 u 的变化沿（即上升沿或下降沿）会导致该时刻的 y = <strong>true</strong>。
在所有其他时间瞬间，y = <strong>false</strong>。
</p>

<p>
举例说明其用法
<a href=\"modelica://Modelica.Blocks.Examples.BooleanNetwork1\">Modelica.Blocks.Examples.BooleanNetwork1</a>.
</p>

</html>"));
  end ChangingEdge;

  block OnDelay 
    "延迟输入的上升沿，但不延迟下降沿。"
    extends Modelica.Blocks.Interfaces.PartialBooleanSISO_small;
    parameter SI.Time delayTime "延迟时间";

  protected
    Boolean delaySignal(start = false, fixed = true);
    discrete SI.Time t_next;
  initial equation
    pre(u) = false;
    pre(t_next) = time - 1;
  algorithm
    when initial() then
      delaySignal := u;
      t_next := time - 1;
    elsewhen u then
      delaySignal := true;
      t_next := time + delayTime;
    elsewhen not u then
      delaySignal := false;
      t_next := time - 1;
    end when;
  equation
    if delaySignal then
      y = time >= t_next;
    else
      y = false;
    end if;
    annotation(Icon(graphics = {
      Text(
      extent = {{-250, -120}, {250, -150}}, 
      textString = "%delayTime s"), 
      Line(points = {{-80, -66}, {-60, -66}, {-60, -22}, {38, -22}, {38, -66}, {66, -66}}), 
      Line(points = {{-80, 32}, {-4, 32}, {-4, 76}, {38, 76}, {38, 32}, {66, 32}}, 
      color = {255, 0, 255})}), 
      Documentation(info="<html><p>
布尔输入 u 的上升沿给出延迟输出。 输入的下降沿则立即输出。
</p>
<p>
下图显示了一个延迟时间为 0.1 秒的典型例子的模拟结果。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/MathBoolean/OnDelay1.png\" alt=\"OnDelay1.png\" data-href=\"\" style=\"\"/><br><img src=\"modelica://Modelica/Resources/Images/Blocks/MathBoolean/OnDelay2.png\" alt=\"OnDelay2.png\" data-href=\"\" style=\"\"/>
</p>
<p>
举例说明其用法 <a href=\"modelica://Modelica.Blocks.Examples.BooleanNetwork1\" target=\"\">Modelica.Blocks.Examples.BooleanNetwork1</a>
</p>
</html>"));
  end OnDelay;

  annotation(Documentation(info="<html><p>
<span style=\"color: rgb(51, 51, 51);\">该包包含对</span><span style=\"color: rgb(51, 51, 51);\"><strong>布尔信号</strong></span><span style=\"color: rgb(51, 51, 51);\">的基本</span><span style=\"color: rgb(51, 51, 51);\"><strong>数学运算</strong></span>。
</p>
<p>
新特性包括：
</p>
<li>
<span style=\"color: rgb(51, 51, 51);\">如果需要，模块可以具有任意数量的输入（例如，具有 2、3、4 等布尔输入的“与”模块）。这基于“connectorSizing”注释，它允许工具方便地处理连接器的向量</span>。</li>
<li>
<span style=\"color: rgb(51, 51, 51);\">这些模块的尺寸较小，以便图表区域能更好地用于处理像“与”或“或”这样的小型模块。</span></li>
</html>"), Icon(graphics = {Line(points = {{-80, -16}, {-4, -16}, {-4, 28}, {38, 28}, {38, 
    -16}, {66, -16}}, color = {255, 0, 255})}));
end MathBoolean;