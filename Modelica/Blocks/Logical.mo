within Modelica.Blocks;
package Logical "具有布尔输入和输出信号的元件库"
  extends Modelica.Icons.Package;

  block And "逻辑'and'：y=u1和u2"
    extends Blocks.Interfaces.partialBooleanSI2SO;
  equation
    y = u1 and u2;
    annotation(
      defaultComponentName = "and1", 
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {Text(
      extent = {{-90, 40}, {90, -40}}, 
      textString = "and")}), 
      Documentation(info="<html><p>
如果所有输入均为<strong>true</strong>，则输出为<strong>true，</strong>否则输出为<strong>false</strong>。<br>
</p>
</html>"));
  end And;

  block Or "逻辑'or'：y=u1或u2"
    extends Blocks.Interfaces.partialBooleanSI2SO;
  equation
    y = u1 or u2;
    annotation(
      defaultComponentName = "or1", 
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {Text(
      extent = {{-90, 40}, {90, -40}}, 
      textString = "or")}), 
      Documentation(info = "<html>
<p>
如果至少有一个输入为<strong>true</strong>，则输出为<strong>true</strong>，否则输出为<strong>false</strong>。
</p>
</html>"));
  end Or;

  block Xor "逻辑'xor'：y=u1异或u2"
    extends Blocks.Interfaces.partialBooleanSI2SO;
  equation
    y = not ((u1 and u2) or (not u1 and not u2));
    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
      {100, 100}}), graphics = {Text(
      extent = {{-90, 40}, {90, -40}}, 
      textString = "xor")}), Documentation(info = "<html>
<p>
如果正好有一个输入为<strong>true</strong>，则输出为<strong>true</strong>，否则输出为<strong>false</strong>。
</p>
</html>"));
  end Xor;

  block Nor "逻辑'nor'：y=非(u1或u2)"
    extends Blocks.Interfaces.partialBooleanSI2SO;
  equation
    y = not (u1 or u2);
    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
      {100, 100}}), graphics = {Text(
      extent = {{-90, 40}, {90, -40}}, 
      textString = "nor")}), Documentation(info = "<html>
<p>
如果输入都不为<strong>true</strong>，则输出为<strong>true</strong>，否则输出为<strong>false</strong>。
</p>
</html>"  ));
  end Nor;

  block Nand "逻辑'nand'：y=非(u1和u2)"
    extends Blocks.Interfaces.partialBooleanSI2SO;
  equation
    y = not (u1 and u2);
    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
      {100, 100}}), graphics = {Text(
      extent = {{-90, 40}, {90, -40}}, 
      textString = "nand")}), Documentation(info = "<html>
<p>
如果至少有一个输入为<strong>false</strong>，则输出为<strong>true</strong>，否则输出为<strong>false</strong>。
</p>
</html>"  ));
  end Nand;

  block Not "逻辑'not'：y=非u"
    extends Blocks.Interfaces.partialBooleanSISO;

  equation
    y = not u;
    annotation(
      defaultComponentName = "not1", 
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {Text(
      extent = {{-90, 40}, {90, -40}}, 
      textString = "not")}), 
      Documentation(info = "<html>
<p>
如果输入为<strong>false</strong>，则输出为<strong>true</strong>，否则输出为<strong>false</strong>。
</p>
</html>"  ));
  end Not;

  block Pre 
    "通过无限小的时间延迟打破代数循环(y=pre(u)：事件迭代持续到u=pre(u))"

    parameter Boolean pre_u_start = false "初始时pre(u)的初始值";
    extends Blocks.Interfaces.partialBooleanSISO;

  initial equation
    pre(u) = pre_u_start;
  equation
    y = pre(u);
    annotation(
      defaultComponentName = "pre1", 
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {Text(
      extent = {{-90, 40}, {90, -40}}, 
      textString = "pre")}), 
      Documentation(info="<html><p>
这个逻辑模块以无限小的时间延迟来延迟布尔输入，从而打破代数循环。 在逻辑块网络中，每个“闭合连接回路”中至少有一个逻辑块必须有延迟，因为布尔方程的代数系统是不可解的。
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">“Pre”块返回“输入”信号在上一次“事件迭代”中的值。一旦两个值相同（u = pre(u)），“事件迭代”停止。</span>
</p>
</html>"));
  end Pre;

  block Edge "如果输入u具有上升沿，则输出y为真(y=edge(u))"

    parameter Boolean pre_u_start = false "初始时pre(u)的初始值";
    extends Blocks.Interfaces.partialBooleanSISO;

  initial equation
    pre(u) = pre_u_start;
  equation
    y = edge(u);
    annotation(
      defaultComponentName = "边界1", 
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {Text(
      extent = {{-90, 40}, {90, -40}}, 
      textString = "edge")}), 
      Documentation(info = "<html>
<p>
如果布尔输入有一个从<strong>false</strong>到<strong>true</strong>的上升沿，
则输出为<strong>true</strong>，否则输出为<strong>false</strong>。
</p>
</html>"));
  end Edge;

  block FallingEdge 
    "如果输入u为下降沿，则输出y为真(=edge(not u))"

    parameter Boolean pre_u_start = false "初始时pre(u)的初始值";
    extends Blocks.Interfaces.partialBooleanSISO;

  protected
    Boolean not_u = not u;
  initial equation
    pre(not_u) = not pre_u_start;
  equation
    y = edge(not_u);
    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
      {100, 100}}), graphics = {Text(
      extent = {{-90, 40}, {90, -40}}, 
      textString = "falling")}), Documentation(info = "<html>
<p>
如果布尔输入有一个从<strong>true</strong>到<strong>false</strong>的下降沿，
则输出为<strong>true</strong>，否则输出为<strong>false</strong>。
</p>
</html>"));
  end FallingEdge;

  block Change 
    "如果输入u出现上升沿或下降沿，则输出y为真(y = change(u))"

    parameter Boolean pre_u_start = false "初始时pre(u)的初始值";
    extends Blocks.Interfaces.partialBooleanSISO;

  initial equation
    pre(u) = pre_u_start;
  equation
    y = change(u);
    annotation(
      defaultComponentName = "change1", 
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {Text(
      extent = {{-90, 40}, {90, -40}}, 
      textString = "change")}), 
      Documentation(info = "<html>
<p>
如果布尔输入有一个从<strong>false</strong>到<strong>true</strong>的上升沿
或一个从<strong>true</strong>到<strong>false</strong>的下降沿，
则输出为<strong>true</strong>，否则输出为<strong>false</strong>。
</p>
</html>"));
  end Change;

  block GreaterThreshold 
    "如果输入u大于阈值，则输出y为真"
    extends Blocks.Interfaces.partialBooleanThresholdComparison;
  equation
    y = u > threshold;
    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
      {100, 100}}), graphics = {
      Line(
      points = {{-54, 20}, {-8, 0}, {-54, -20}}, 
      thickness = 0.5)}), Documentation(info="<html><p>
如果实型输入值大于参数<strong>threshold</strong>， 则输出为<strong>true</strong>，否则输出为<strong>false</strong>。
</p>
</html>"));
  end GreaterThreshold;

  block GreaterEqualThreshold 
    "如果输入u大于或等于阈值，则输出y为真"

    extends Blocks.Interfaces.partialBooleanThresholdComparison;
  equation
    y = u >= threshold;
    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
      {100, 100}}), graphics = {
      Line(
      points = {{-54, 20}, {-8, 0}, {-54, -20}}, 
      thickness = 0.5), 
      Line(points = {{-54, -30}, {-8, -30}}, thickness = 0.5)}), 
      Documentation(info="<html><p>
如果实型输入值大于或等于参数<strong>threshold</strong>， 则输出为<strong>true</strong>，否则输出为<strong>false</strong>。
</p>
</html>"));
  end GreaterEqualThreshold;

  block LessThreshold "如果输入u小于阈值，则输出y为真"

    extends Blocks.Interfaces.partialBooleanThresholdComparison;
  equation
    y = u < threshold;
    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
      {100, 100}}), graphics = {
      Line(points = {{-8, 20}, {-54, 0}, {-8, -20}}, thickness = 0.5)}), Documentation(info="<html><p>
如果实型输入值小于参数<strong>threshold</strong>， 则输出为<strong>true</strong>，否则输出为<strong>false</strong>。
</p>
</html>"));
  end LessThreshold;

  block LessEqualThreshold 
    "如果输入u小于或等于阈值，则输出y为真"
    extends Blocks.Interfaces.partialBooleanThresholdComparison;
  equation
    y = u <= threshold;
    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
      {100, 100}}), graphics = {
      Line(points = {{-8, 20}, {-54, 0}, {-8, -20}}, thickness = 0.5), 
      Line(points = {{-54, -30}, {-8, -30}}, thickness = 0.5)}), 
      Documentation(info="<html><p>
如果实型输入值小于或等于参数<strong>threshold</strong>， 则输出为<strong>true</strong>，否则输出为<strong>false</strong>。
</p>
</html>"));
  end LessEqualThreshold;

  block Greater "如果输入u1大于输入 u2，则输出y为真"
    extends Blocks.Interfaces.partialBooleanComparison;

  equation
    y = u1 > u2;
    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, 
      -100}, {100, 100}}), graphics = {
      Ellipse(extent = {{32, 10}, {52, -10}}, lineColor = {0, 0, 127}), 
      Line(points = {{-100, -80}, {42, -80}, {42, 0}}, color = {0, 0, 127}), 
      Line(
      points = {{-54, 20}, {-8, 0}, {-54, -20}}, 
      thickness = 0.5)}), Documentation(info="<html><p>
如果实数输入 u1 大于实数输入 u2，则输出为<strong>true</strong>， 否则输出为<strong>false</strong>。
</p>
</html>"));
  end Greater;
  block IntegerGreater "如果输入u1大于输入 u2，则输出y为真"
    extends Interfaces.partialIntegerBooleanComparison;

  equation
    y = u1 > u2;
    annotation (Icon(coordinateSystem(extent={{-100,-100},{100,100}}, 
  grid={2,2}),graphics = {Ellipse(origin={42,0}, 
  lineColor={255,127,0}, 
  extent={{-10,10},{10,-10}}), Line(origin={-29,-40}, 
  points={{-71,-40},{71,-40},{71,40}}, 
  color={255,127,0}), Line(origin={-31,0}, 
  points={{-23,20},{23,0},{-23,-20}}, 
  thickness=0.5)}), Documentation(info="<html><p>
如果整型输入 u1 大于整型输入 u2，则输出为<strong>true</strong>， 否则输出为<strong>false</strong>。
</p>
</html>"));
  end IntegerGreater;

  block GreaterEqual 
    "如果输入 u1大于或等于输入u2，则输出y为真"
    extends Blocks.Interfaces.partialBooleanComparison;

  equation
    y = u1 >= u2;
    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, 
      -100}, {100, 100}}), graphics = {
      Ellipse(extent = {{32, 10}, {52, -10}}, lineColor = {0, 0, 127}), 
      Line(points = {{-100, -80}, {42, -80}, {42, 0}}, color = {0, 0, 127}), 
      Line(
      points = {{-54, 20}, {-8, 0}, {-54, -20}}, 
      thickness = 0.5), 
      Line(points = {{-54, -30}, {-8, -30}}, thickness = 0.5)}), 
      Documentation(info = "<html>
<p>
如果实数输入 u1 大于或等于实数输入 u2，则输出为<strong>true</strong>，
否则输出为<strong>false</strong>。
</p>
</html>"));
  end GreaterEqual;

  block Less "如果输入u1小于输入u2，则输出y为真"
    extends Blocks.Interfaces.partialBooleanComparison;

  equation
    y = u1 < u2;
    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, 
      -100}, {100, 100}}), graphics = {
      Ellipse(extent = {{32, 10}, {52, -10}}, lineColor = {0, 0, 127}), 
      Line(points = {{-100, -80}, {42, -80}, {42, 0}}, color = {0, 0, 127}), 
      Line(points = {{-8, 20}, {-54, 0}, {-8, -20}}, thickness = 0.5)}), Documentation(info = "<html>
<p>
如果实数输入 u1 小于实数输入 u2，则输出为<strong>true</strong>，
否则输出为<strong>false</strong>。
</p>
</html>"));
  end Less;

  block LessEqual "如果输入u1小于或等于输入u2，则输出y为真"
    extends Blocks.Interfaces.partialBooleanComparison;

  equation
    y = u1 <= u2;
    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, 
      -100}, {100, 100}}), graphics = {
      Ellipse(extent = {{32, 10}, {52, -10}}, lineColor = {0, 0, 127}), 
      Line(points = {{-100, -80}, {42, -80}, {42, 0}}, color = {0, 0, 127}), 
      Line(points = {{-8, 20}, {-54, 0}, {-8, -20}}, thickness = 0.5), 
      Line(points = {{-54, -30}, {-8, -30}}, thickness = 0.5)}), 
      Documentation(info = "<html>
<p>
如果实数输入 u1 小于或等于实数输入 u2，则输出为<strong>true</strong>，
否则输出为<strong>false</strong>。
</p>
</html>"));
  end LessEqual;
  block Equality "如果输入u1等于输入 u2，则输出y为真"
    Blocks.Interfaces.RealInput u1 "第一个实数输入信号连接器" 
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Blocks.Interfaces.RealInput u2 "第二个实数输入信号连接器" 
      annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
    Blocks.Interfaces.BooleanOutput y "实数输出信号连接器" 
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  equation
    y = u1 == u2;
    annotation (Icon(coordinateSystem(extent={{-100,-100},{100,100}}, 
  grid={2,2}),graphics = {Rectangle(origin={0,0}, 
  fillColor={210,210,210}, 
  fillPattern=FillPattern.Solid, 
  borderPattern=BorderPattern.Raised, 
  extent={{-100,100},{100,-100}}), Ellipse(origin={42,0}, 
  lineColor={0,0,127}, 
  extent={{-10,10},{10,-10}}), Line(origin={-29,-40}, 
  points={{-71,-40},{71,-40},{71,40}}, 
  color={0,0,127}), Line(origin={-30,16}, 
  points={{-24,0},{24,0}}, 
  thickness=0.5), Line(origin={-30,-14}, 
  points={{-24,0},{24,0}}, 
  thickness=0.5), Text(origin={0,130}, 
  lineColor={0,0,255}, 
  extent={{-150,20},{150,-20}}, 
  textString="%name", 
  textColor={0,0,255}), Ellipse(origin={76,0}, 
  lineColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}), 
  fillColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}), 
  fillPattern=FillPattern.Solid, 
  extent={{-7,7},{7,-7}})}), Documentation(info="<html><p>
如果实数输入 u1 等于实数输入 u2，则输出为<strong>true</strong>， 否则输出为<strong>false</strong>。
</p>
</html>"));
  end Equality;
  block IntegerEquality "如果输入u1等于输入 u2，则输出y为真"
    Interfaces.IntegerInput u1 "第一个实数输入信号连接器" 
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Interfaces.IntegerInput u2 "第二个实数输入信号连接器" 
      annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
    Interfaces.BooleanOutput y "实数输出信号连接器" 
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  equation
    y = u1 == u2;
    annotation (Icon(coordinateSystem(extent={{-100,-100},{100,100}}, 
  grid={2,2}),graphics = {Rectangle(origin={0,0}, 
  fillColor={210,210,210}, 
  fillPattern=FillPattern.Solid, 
  borderPattern=BorderPattern.Raised, 
  extent={{-100,100},{100,-100}}), Ellipse(origin={42,0}, 
  lineColor={0,0,127}, 
  extent={{-10,10},{10,-10}}), Line(origin={-29,-40}, 
  points={{-71,-40},{71,-40},{71,40}}, 
  color={0,0,127}), Line(origin={-30,16}, 
  points={{-24,0},{24,0}}, 
  thickness=0.5), Line(origin={-30,-14}, 
  points={{-24,0},{24,0}}, 
  thickness=0.5), Text(origin={0,130}, 
  lineColor={0,0,255}, 
  extent={{-150,20},{150,-20}}, 
  textString="%name", 
  textColor={0,0,255}), Ellipse(origin={76,0}, 
  lineColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}), 
  fillColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}), 
  fillPattern=FillPattern.Solid, 
  extent={{-7,7},{7,-7}})}), Documentation(info="<html><p>
如果整型输入 u1 等于整型输入 u2，则输出为<strong>true</strong>， 否则输出为<strong>false</strong>。
</p>
</html>"));
  end IntegerEquality;

  block ZeroCrossing "触发输入u的过零"
    extends Blocks.Interfaces.partialBooleanSO;
    Blocks.Interfaces.RealInput u annotation(Placement(transformation(extent = {
      {-140, -20}, {-100, 20}})));
    Blocks.Interfaces.BooleanInput enable 
      "如果启用输入信号为真，则触发过零输入" 
      annotation(Placement(transformation(
      origin = {0, -120}, 
      extent = {{-20, -20}, {20, 20}}, 
      rotation = 90)));

  protected
    Boolean disable = not enable;
    Boolean u_pos;
  initial equation
    pre(u_pos) = false;
    pre(enable) = false;
    pre(disable) = not pre(enable);
  equation
    u_pos = enable and u >= 0;
    y = change(u_pos) and not edge(enable) and not edge(disable);
    annotation(Documentation(info="<html><p>
<span style=\"color: rgb(51, 51, 51);\">当输入 \"u\" 变为零且输入 \"enable\" 为</span><span style=\"color: rgb(51, 51, 51);\"><strong>true</strong></span><span style=\"color: rgb(51, 51, 51);\">时，输出 \"y\" 在该时刻为</span><span style=\"color: rgb(51, 51, 51);\"><strong>true</strong></span><span style=\"color: rgb(51, 51, 51);\">。在所有其他时刻，输出 \"y\" 为</span><span style=\"color: rgb(51, 51, 51);\"><strong>false</strong></span><span style=\"color: rgb(51, 51, 51);\">。如果输入 \"u\" 在 \"enable\" 输入值发生变化的时刻为零，则输出 \"y\" 为</span><span style=\"color: rgb(51, 51, 51);\"><strong>false</strong></span><span style=\"color: rgb(51, 51, 51);\">。</span>
</p>
<p>
请注意，在 Modelica 模拟器的绘图窗口中，该模块的输出通常与<strong>false</strong>相同， 因为输出可能只在事件发生时为<strong>true</strong>，而在持续集成过程中并非如此。 为了检查该组件是否按预期运行，应将其输出连接到组件，例如 <em>Modelica.Blocks.Discrete.TriggeredSampler</em>.
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
      {100, 100}}), graphics = {
      Line(points = {{-78, 68}, {-78, -80}}, color = {192, 192, 192}), 
      Polygon(
      points = {{-78, 90}, {-86, 68}, {-70, 68}, {-78, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-88, 0}, {70, 0}}, color = {192, 192, 192}), 
      Line(points = {{-78, 0}, {-73.2, 32.3}, {-70, 50.3}, {-66.7, 64.5}, {-63.5, 74.2}, 
      {-60.3, 79.3}, {-57.1, 79.6}, {-53.9, 75.3}, {-50.7, 67.1}, {-46.6, 52.2}, 
      {-41, 25.8}, {-33, -13.9}, {-28.2, -33.7}, {-24.1, -45.9}, {-20.1, -53.2}, 
      {-16.1, -55.3}, {-12.1, -52.5}, {-8.1, -45.3}, {-3.23, -32.1}, {10.44, 
      13.7}, {15.3, 26.4}, {20.1, 34.8}, {24.1, 38}, {28.9, 37.2}, {33.8, 31.8}, 
      {40.2, 19.4}, {53.1, -10.5}, {59.5, -21.2}, {65.1, -25.9}, {70.7, -25.9}, 
      {77.2, -20.5}, {82, -13.8}}, color = {192, 192, 192}, smooth = Smooth.Bezier), 
      Polygon(
      points = {{92, 0}, {70, 8}, {70, -8}, {92, 0}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-36, -59}, {-36, 81}}, color = {255, 0, 255}), 
      Line(points = {{6, -59}, {6, 81}}, color = {255, 0, 255}), 
      Line(points = {{49, -59}, {49, 81}}, color = {255, 0, 255}), 
      Line(points = {{-78, 0}, {70, 0}}, color = {255, 0, 255})}));
  end ZeroCrossing;

  block LogicalSwitch "逻辑开关"
    extends Blocks.Interfaces.partialBooleanSI3SO;

  equation
    y = if u2 then u1 else u3;
    annotation(Documentation(info = "<html>
<p>
逻辑开关根据布尔值 u2 连接器（中间连接器）在两个可能的输入信号 u1（上连接器）和 u3（下连接器）之间进行切换。
</p>
<p>
如果 u2 为真，连接器 y 设为等于 u1，否则设为等于 u3。
</p>
</html>"), Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), 
      graphics = {
      Line(
      points = {{12, 0}, {100, 0}}, 
      color = {255, 0, 255}), 
      Line(
      points = {{-100, 0}, {-40, 0}}, 
      color = {255, 0, 255}), 
      Line(
      points = {{-100, -80}, {-40, -80}, {-40, -80}}, 
      color = {255, 0, 255}), 
      Line(points = {{-40, 12}, {-40, -10}}, color = {255, 0, 255}), 
      Line(points = {{-100, 80}, {-40, 80}}, color = {255, 0, 255}), 
      Line(
      points = DynamicSelect({{-40, 80}, {8, 2}}, if u2 then {{-40, 80}, {8, 2}} else {{-40, -80}, {8, 2}}), 
      color = {255, 0, 255}, 
      thickness = 1), 
      Ellipse(lineColor = {0, 0, 127}, 
      pattern = LinePattern.None, 
      fillPattern = FillPattern.Solid, 
      extent = {{2, -6}, {18, 8}})}));
  end LogicalSwitch;

  block Switch "在两个实数信号之间切换"
    extends Modelica.Blocks.Icons.PartialBooleanBlock;
    Blocks.Interfaces.RealInput u1 "第一个实数输入信号连接器" 
      annotation(Placement(transformation(extent = {{-140, 60}, {-100, 100}})));
    Blocks.Interfaces.BooleanInput u2 "布尔输入信号连接器" 
      annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
    Blocks.Interfaces.RealInput u3 "第二个实数输入信号连接器" 
      annotation(Placement(transformation(extent = {{-140, -100}, {-100, -60}})));
    Blocks.Interfaces.RealOutput y "实数输出信号连接器" 
      annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));

  equation
    y = if u2 then u1 else u3;
    annotation(
      defaultComponentName = "开关1", 
      Documentation(info="<html><p>
Logical.Switch 根据逻辑连接器 u2（中间连接器）在两个可能的输入信号 u1（上连接器）和 u3（下连接器）之间进行切换。
</p>
<p>
如果 u2 为<strong>true</strong>，输出信号 y 设置为等于 u1，否则设置为等于 u3。
</p>
</html>"  ), 
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{12, 0}, {100, 0}}, 
      color = {0, 0, 127}), 
      Line(points = {{-100, 0}, {-40, 0}}, 
      color = {255, 0, 255}), 
      Line(points = {{-100, -80}, {-40, -80}, {-40, -80}}, 
      color = {0, 0, 127}), 
      Line(points = {{-40, 12}, {-40, -12}}, 
      color = {255, 0, 255}), 
      Line(points = {{-100, 80}, {-38, 80}}, 
      color = {0, 0, 127}), 
      Line(points = DynamicSelect({{-38, 80}, {6, 2}}, if u2 then {{-38, 80}, {6, 2}} else {{-38, -80}, {6, 2}}), 
      color = {0, 0, 127}, 
      thickness = 1), 
      Ellipse(lineColor = {0, 0, 255}, 
      pattern = LinePattern.None, 
      fillPattern = FillPattern.Solid, 
      extent = {{2, -8}, {18, 8}})}));
  end Switch;
  block IntegerSwitch "在两个整型信号之间切换"
    extends Modelica.Blocks.Icons.PartialBooleanBlock;
    Interfaces.IntegerInput u1 "第一个整型输入信号连接器" 
      annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
    Interfaces.BooleanInput u2 "布尔输入信号连接器" 
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Interfaces.IntegerInput u3 "第二个整型输入信号连接器" 
      annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
    Interfaces.IntegerOutput y "实数输出信号连接器" 
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));


  equation
    y = if u2 then u1 else u3;
    annotation (
      defaultComponentName="integerswitch1", 
      Documentation(info="<html><p>
Logical.IntegerSwitch 根据逻辑连接器 u2（中间连接器）在两个可能的输入信号 u1（上连接器）和 u3（下连接器）之间进行切换。
</p>
<p>
如果 u2 为<strong>true</strong>，输出信号 y 设置为等于 u1，否则设置为等于 u3。
</p>
</html>"  ), 
      Icon(coordinateSystem(extent={{-100,-100},{100,100}}, 
  preserveAspectRatio=true, 
  grid={2,2}),graphics = {Line(origin={56,0}, 
  points={{-44,0},{44,0}}, 
  color={255,127,0}), Line(origin={-70,0}, 
  points={{-30,0},{30,0}}, 
  color={255,0,255}), Line(origin={-70,-80}, 
  points={{-30,0},{30,0},{30,0}}, 
  color={255,127,0}), Line(origin={-40,0}, 
  points={{0,12},{0,-12}}, 
  color={255,0,255}), Line(origin={-69,80}, 
  points={{-31,0},{31,0}}, 
  color={255,127,0}), Line(origin={0,0}, 
  points=DynamicSelect({{-38,80},{6,2}}, if u2 then {{-38,80},{6,2}} else {{-38,-80},{6,2}}), 
  color={255,127,0}, 
  thickness=1), Ellipse(origin={10,0}, 
  lineColor={0,0,255}, 
  pattern=LinePattern.None, 
  fillPattern=FillPattern.Solid, 
  extent={{-8,-8},{8,8}})}));
  end IntegerSwitch;

  block Hysteresis "将实数信号转换为带滞后的布尔信号"

    extends Modelica.Blocks.Icons.PartialBooleanBlock;
    parameter Real uLow(start = 0) "如果y=true且u<uLow，则切换为y=false";
    parameter Real uHigh(start = 1) "如果y=false且u>uHigh，则切换为y=true";
    parameter Boolean pre_y_start = false "初始时的pre(y)值";

    Blocks.Interfaces.RealInput u annotation(Placement(transformation(extent = {
      {-140, -20}, {-100, 20}})));
    Blocks.Interfaces.BooleanOutput y annotation(Placement(transformation(
      extent = {{100, -10}, {120, 10}})));

  initial equation
    pre(y) = pre_y_start;
  equation
    assert(uHigh > uLow, "滞后限值错误(uHigh<=uLow)");
    y = not pre(y) and u > uHigh or pre(y) and u >= uLow;
    annotation(
      Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
      100, 100}}), graphics = {Polygon(
      points = {{-65, 89}, {-73, 67}, {-57, 67}, {-65, 89}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), Line(points = {{-65, 67}, {-65, -81}}, 
      color = {192, 192, 192}), Line(points = {{-90, -70}, {82, -70}}, color = {192, 192, 192}), 
      Polygon(
      points = {{90, -70}, {68, -62}, {68, -78}, {90, -70}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), Text(
      extent = {{70, -80}, {94, -100}}, 
      textColor = {160, 160, 164}, 
      textString = "u"), Text(
      extent = {{-65, 93}, {-12, 75}}, 
      textColor = {160, 160, 164}, 
      textString = "y"), Line(
      points = {{-80, -70}, {30, -70}}, 
      thickness = 0.5), Line(
      points = {{-50, 10}, {80, 10}}, 
      thickness = 0.5), Line(
      points = {{-50, 10}, {-50, -70}}, 
      thickness = 0.5), Line(
      points = {{30, 10}, {30, -70}}, 
      thickness = 0.5), Line(
      points = {{-10, -65}, {0, -70}, {-10, -75}}, 
      thickness = 0.5), Line(
      points = {{-10, 15}, {-20, 10}, {-10, 5}}, 
      thickness = 0.5), Line(
      points = {{-55, -20}, {-50, -30}, {-44, -20}}, 
      thickness = 0.5), Line(
      points = {{25, -30}, {30, -19}, {35, -30}}, 
      thickness = 0.5), Text(
      extent = {{-99, 2}, {-70, 18}}, 
      textColor = {160, 160, 164}, 
      textString = "true"), Text(
      extent = {{-98, -87}, {-66, -73}}, 
      textColor = {160, 160, 164}, 
      textString = "false"), Text(
      extent = {{19, -87}, {44, -70}}, 
      textString = "uHigh"), Text(
      extent = {{-63, -88}, {-38, -71}}, 
      textString = "uLow"), Line(points = {{-69, 10}, {-60, 10}}, color = {160, 
      160, 164})}), 
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Polygon(
      points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-80, 68}, {-80, -29}}, color = {192, 192, 192}), 
      Polygon(
      points = {{92, -29}, {70, -21}, {70, -37}, {92, -29}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-79, -29}, {84, -29}}, color = {192, 192, 192}), 
      Line(points = {{-79, -29}, {41, -29}}), 
      Line(points = {{-15, -21}, {1, -29}, {-15, -36}}), 
      Line(points = {{41, 51}, {41, -29}}), 
      Line(points = {{33, 3}, {41, 22}, {50, 3}}), 
      Line(points = {{-49, 51}, {81, 51}}), 
      Line(points = {{-4, 59}, {-19, 51}, {-4, 43}}), 
      Line(points = {{-59, 29}, {-49, 11}, {-39, 29}}), 
      Line(points = {{-49, 51}, {-49, -29}}), 
      Text(
      extent = {{-92, -49}, {-9, -92}}, 
      textColor = {192, 192, 192}, 
      textString = "%uLow"), 
      Text(
      extent = {{2, -49}, {91, -92}}, 
      textColor = {192, 192, 192}, 
      textString = "%uHigh"), 
      Rectangle(extent = {{-91, -49}, {-8, -92}}, lineColor = {192, 192, 192}), 
      Line(points = {{-49, -29}, {-49, -49}}, color = {192, 192, 192}), 
      Rectangle(extent = {{2, -49}, {91, -92}}, lineColor = {192, 192, 192}), 
      Line(points = {{41, -29}, {41, -49}}, color = {192, 192, 192})}), 
      Documentation(info="<html><p>
该模块将<strong>Real</strong>输入信号<strong>u</strong>转换为<strong>Boolean</strong>输出信号<strong>y</strong>：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Logical/Hysteresis.png\" alt=\"Hysteresis.png\" data-href=\"\" style=\"\">
</p>
<ul><li>
当输出为<strong>false</strong>且输入<strong>greater</strong>参数<strong>uHigh</strong>时， 输出切换为<strong>true</strong>。</li>
<li>
当输出为<strong>true</strong>且输入<strong>less</strong>参数<strong>uLow</strong>时， 输出切换为<strong>false</strong>。</li>
</ul><p>
输出的起始值通过参数<strong>pre_y_start</strong>（= 初始时的 pre(y) 值）定义。 该参数的默认值为<strong>false</strong>。
</p>
</html>"));
  end Hysteresis;

  block OnOffController "开/关控制器"
    extends Modelica.Blocks.Icons.PartialBooleanBlock;
    Blocks.Interfaces.RealInput reference 
      "用作参考信号的实数输入信号连接器" annotation(
      Placement(transformation(extent = {{-140, 80}, {-100, 40}})));
    Blocks.Interfaces.RealInput u 
      "用作测量信号的实数输入信号连接器" annotation(
      Placement(transformation(extent = {{-140, -40}, {-100, -80}})));
    Blocks.Interfaces.BooleanOutput y 
      "用作制动信号的实数输出信号连接器" annotation(
      Placement(transformation(extent = {{100, -10}, {120, 10}})));

    parameter Real bandwidth(start = 0.1) "参考信号周围的带宽";
    parameter Boolean pre_y_start = false "初始时的pre(y)值";

  initial equation
    pre(y) = pre_y_start;
  equation
    y = pre(y) and (u < reference + bandwidth / 2) or (u < reference - bandwidth / 
      2);
    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
      -100}, {100, 100}}), graphics = {
      Text(
      extent = {{-92, 74}, {44, 44}}, 
      textString = "reference"), 
      Text(
      extent = {{-94, -52}, {-34, -74}}, 
      textString = "u"), 
      Line(points = {{-76, -32}, {-68, -6}, {-50, 26}, {-24, 40}, {-2, 42}, {16, 36}, {32, 28}, {48, 12}, {58, -6}, {68, -28}}, 
      color = {0, 0, 127}), 
      Line(points = {{-78, -2}, {-6, 18}, {82, -12}}, 
      color = {255, 0, 0}), 
      Line(points = {{-78, 12}, {-6, 30}, {82, 0}}), 
      Line(points = {{-78, -16}, {-6, 4}, {82, -26}}), 
      Line(points = {{-82, -18}, {-56, -18}, {-56, -40}, {64, -40}, {64, -20}, {90, -20}}, 
      color = {255, 0, 255})}), Documentation(info = "<html>
<p>当输入信号 <strong>u</strong>低于<strong>reference</strong>信号带宽的一半时，
OnOffController 模块将输出信号<strong>y</strong>设为<strong>true</strong>；
当输入信号<strong>u</strong>超过<strong>reference</strong>信号带宽的一半时，
OnOffController 模块将输出信号<strong>y</strong>设为<strong>false</strong>。
</p>
</html>"));
  end OnOffController;

  block TriggeredTrapezoid "触发式梯形信号发生器"
    extends Modelica.Blocks.Icons.PartialBooleanBlock;

    parameter Real amplitude = 1 "梯形振幅";
    parameter SI.Time rising(final min = 0) = 0 
      "梯形上升持续时间";
    parameter SI.Time falling(final min = 0) = rising 
      "梯形下降持续时间";
    parameter Real offset = 0 "输出信号偏移";

    Blocks.Interfaces.BooleanInput u "布尔输入信号连接器" 
      annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
    Blocks.Interfaces.RealOutput y "实数输出信号连接器" 
      annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));

  protected
    discrete Real endValue "最近边缘时刻y的值";
    discrete Real rate "当前上升/下降率";
    discrete SI.Time T 
      "输出达到终值的预测时间";
  equation
    y = if time < T then endValue - (T - time) * rate else endValue;

    when {initial(), u, not u} then
      endValue = if u then offset + amplitude else offset;
      rate = if u and (rising > 0) then amplitude / rising else if not u and (
        falling > 0) then -amplitude / falling else 0;
      T = if u and not (rising > 0) or not u and not (falling > 0) or not abs(
        amplitude) > 0 or initial() then time else time + (endValue - pre(y)) / 
        rate;
    end when;
    annotation(
      Icon(
      coordinateSystem(preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), 
      graphics = {
      Line(points = {{-60, -70}, {-60, -70}, {-30, 40}, {8, 40}, {40, -70}, {40, -70}}, 
      color = {0, 0, 127}), 
      Line(points = {{-90, -70}, {82, -70}}, 
      color = {192, 192, 192}), 
      Line(points = {{-80, 68}, {-80, -80}}, 
      color = {192, 192, 192}), 
      Polygon(lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid, 
      points = {{90, -70}, {68, -62}, {68, -78}, {90, -70}}), 
      Polygon(lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid, 
      points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}), 
      Line(points = {{-80, -70}, {-60, -70}, {-60, 24}, {8, 24}, {8, -70}, {60, -70}}, 
      color = {255, 0, 255})}), 
      Documentation(info="<html><p>
TriggeredTrapezoid 模块有一个布尔输入和一个实数输出信号， 需要<em>amplitude</em>、<em>rising</em>、<em>falling</em>和<em>offset</em>参数。 输出信号<strong>y</strong>代表一个梯形信号，取决于输入信号<strong>u</strong>。
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Logical/TriggeredTrapezoid.png\" alt=\"TriggeredTrapezoid.png\" data-href=\"\" style=\"\">
</p>
<p>
其行为如下：假设初始输入为false。 在这种情况下，输出将是<em>offset</em>的。 在上升沿后（即输入由false变true），输出在<em>rising</em>期间上升，达到<em>offset</em>和<em>amplitude</em>之和。 相反，在下降沿后（即输入由true变false），输出在<em>falling</em>期间下降到<em>offset</em>值。
</p>
<p>
请注意，在上升或下降沿到终点前边缘情况已经得到妥善处理。
</p>
</html>"  ));
  end TriggeredTrapezoid;

  block Timer 
    "计时器测量从布尔输入变为真的时间瞬间开始的时间"

    extends Modelica.Blocks.Icons.PartialBooleanBlock;
    Blocks.Interfaces.BooleanInput u "布尔输入信号连接器" 
      annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
    Blocks.Interfaces.RealOutput y "实数输出信号连接器" 
      annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));

  protected
    discrete SI.Time entryTime "u变为真的时间瞬间";
  initial equation
    pre(entryTime) = 0;
  equation
    when u then
      entryTime = time;
    end when;
    y = if u then time - entryTime else 0.0;
    annotation(
      Icon(
      coordinateSystem(preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), 
      graphics = {
      Line(points = {{-90, -70}, {82, -70}}, 
      color = {192, 192, 192}), 
      Line(points = {{-80, 68}, {-80, -80}}, 
      color = {192, 192, 192}), 
      Polygon(lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid, 
      points = {{90, -70}, {68, -62}, {68, -78}, {90, -70}}), 
      Polygon(lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid, 
      points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}), 
      Line(points = {{-80, -70}, {-60, -70}, {-60, -26}, {38, -26}, {38, -70}, {66, -70}}, 
      color = {255, 0, 255}), 
      Line(points = {{-80, 0}, {-62, 0}, {40, 90}, {40, 0}, {68, 0}}, 
      color = {0, 0, 127})}), 
      Documentation(info="<html><p>
当布尔输入<strong>u</strong>为<strong>true</strong>时，计时器开始计时， 输出<strong>y</strong>是<strong>u</strong>为 <strong>true</strong>后经过的时间。 当输入变为<strong>false</strong>时，计时器停止，输出重置为零。
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Logical/Timer.png\" alt=\"Timer.png\" data-href=\"\" style=\"\">
</p>
</html>"));
  end Timer;

  block LogicalDelay "延迟布尔信号"
    extends Blocks.Icons.PartialBooleanBlock;
    parameter SI.Time delayTime(final min = 0) = 0 "时间延迟";
    Blocks.Interfaces.BooleanInput u 
      annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
    Blocks.Interfaces.BooleanOutput y1 
      annotation(Placement(transformation(extent = {{100, 50}, {120, 70}})));
    Blocks.Interfaces.BooleanOutput y2 
      annotation(Placement(transformation(extent = {{100, -70}, {120, -50}})));
  protected
    discrete SI.Time tSwitch;
  initial equation
    tSwitch = time - 2 * delayTime;
  equation
    when {u, not u} then
      tSwitch = time;
    end when;
    y1 = if u then true else not (time >= tSwitch + delayTime);
    y2 = if not u then false else (time >= tSwitch + delayTime);
    annotation(Documentation(info = "<html>
<p>
当输入<code>u</code>为真时，输出<code>y1</code>立即为真，
输出<code>y2</code>则在<code>delayTime</code>后为真。
</p>
<p>
当输入<code>u</code>变为假时，输出<code>y1</code>在<code>delayTime</code>后变为假，
而输出<code>y2</code>则立即变为假。
</p>
</html>"), Icon(graphics = {
      Polygon(lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid, 
      points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}), 
      Line(points = {{-80, 68}, {-80, -80}}, 
      color = {192, 192, 192}), 
      Line(points = {{-90, -70}, {82, -70}}, 
      color = {192, 192, 192}), 
      Polygon(lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid, 
      points = {{90, -70}, {68, -62}, {68, -78}, {90, -70}}), 
      Line(points = {{-80, -10}, {-60, -10}, {-60, 10}, {40, 10}, {40, -10}, {80, -10}}, 
      color = {255, 0, 255}), 
      Line(points = {{-80, 50}, {-60, 50}, {-60, 70}, {50, 70}, {50, 50}, {80, 50}}, 
      color = {255, 0, 255}), 
      Line(points = {{-80, -70}, {-50, -70}, {-50, -50}, {40, -50}, {40, -70}, {80, -70}}, 
      color = {255, 0, 255}), 
      Line(
      points = {{-60, 70}, {-60, -70}}, 
      color = {192, 192, 192}, 
      pattern = LinePattern.Dot), 
      Line(
      points = {{40, 70}, {40, -70}}, 
      color = {192, 192, 192}, 
      pattern = LinePattern.Dot)}));
  end LogicalDelay;

  block RSFlipFlop "基本RS触发器"
    extends Modelica.Blocks.Icons.PartialBooleanBlock;
    parameter Boolean Qini = false "初始时Q的起始值";
    Modelica.Blocks.Interfaces.BooleanOutput Q annotation(Placement(
      transformation(extent = {{100, 50}, {120, 70}})));
    Modelica.Blocks.Interfaces.BooleanOutput QI annotation(Placement(
      transformation(extent = {{100, -70}, {120, -50}})));
    Modelica.Blocks.Logical.Nor nor annotation(Placement(transformation(extent = 
      {{-20, 20}, {0, 40}})));
    Modelica.Blocks.Logical.Nor nor1 annotation(Placement(transformation(
      extent = {{-20, -20}, {0, 0}})));
    Modelica.Blocks.Logical.Pre pre(pre_u_start = not (Qini)) annotation(
      Placement(transformation(extent = {{10, 20}, {30, 40}})));
    Modelica.Blocks.Interfaces.BooleanInput S 
      annotation(Placement(transformation(extent = {{-140, 40}, {-100, 80}})));
    Modelica.Blocks.Interfaces.BooleanInput R 
      annotation(Placement(transformation(extent = {{-140, -80}, {-100, -40}})));
  equation
    connect(nor1.y, nor.u2) annotation(Line(points = {{1, -10}, {40, -10}, {40, -40}, 
      {-60, -40}, {-60, 22}, {-22, 22}}, color = {255, 0, 255}));
    connect(nor1.y, Q) annotation(Line(points = {{1, -10}, {60, -10}, {60, 60}, {110, 
      60}}, color = {255, 0, 255}));
    connect(nor.y, pre.u) 
      annotation(Line(points = {{1, 30}, {8, 30}}, color = {255, 0, 255}));
    connect(pre.y, nor1.u1) annotation(Line(points = {{31, 30}, {40, 30}, {40, 10}, {-40, 
      10}, {-40, -10}, {-22, -10}}, color = {255, 0, 255}));
    connect(pre.y, QI) annotation(Line(points = {{31, 30}, {80, 30}, {80, -60}, {110, -60}}, color = {255, 0, 255}));
    connect(S, nor.u1) annotation(Line(
      points = {{-120, 60}, {-40, 60}, {-40, 30}, {-22, 30}}, color = {255, 0, 255}));
    connect(R, nor1.u2) annotation(Line(
      points = {{-120, -60}, {-40, -60}, {-40, -18}, {-22, -18}}, color = {255, 0, 255}));
    annotation(
      Icon(graphics = {
      Text(
      extent = {{-60, -30}, {-20, -90}}, 
      textString = "R"), 
      Text(
      extent = {{-62, 90}, {-22, 30}}, 
      textString = "S"), 
      Text(
      extent = {{20, 90}, {60, 30}}, 
      textString = "Q"), 
      Text(
      extent = {{6, -30}, {66, -90}}, 
      textString = "Q!"), 
      Ellipse(
      extent = {{-73, 54}, {-87, 68}}, 
      lineColor = DynamicSelect({235, 235, 235}, if S then {0, 255, 0} else {235, 235, 235}), 
      fillColor = DynamicSelect({235, 235, 235}, if S then {0, 255, 0} else {235, 235, 235}), 
      fillPattern = FillPattern.Solid), 
      Ellipse(
      extent = {{83, -53}, {69, -67}}, 
      lineColor = DynamicSelect({235, 235, 235}, if QI then {0, 255, 0} else {235, 235, 235}), 
      fillColor = DynamicSelect({235, 235, 235}, if QI then {0, 255, 0} else {235, 235, 235}), 
      fillPattern = FillPattern.Solid), 
      Ellipse(
      extent = {{-71, -52}, {-85, -66}}, 
      lineColor = DynamicSelect({235, 235, 235}, if R then {0, 255, 0} else {235, 235, 235}), 
      fillColor = DynamicSelect({235, 235, 235}, if R then {0, 255, 0} else {235, 235, 235}), 
      fillPattern = FillPattern.Solid), 
      Ellipse(
      extent = {{71, 67}, {85, 53}}, 
      lineColor = DynamicSelect({235, 235, 235}, if Q then {0, 255, 0} else {235, 235, 235}), 
      fillColor = DynamicSelect({235, 235, 235}, if Q then {0, 255, 0} else {235, 235, 235}), 
      fillPattern = FillPattern.Solid)}), 
      Documentation(info = "<html>
<p>
输出<code>Q</code>由输入<code>S</code>设置，
由输入<code>R</code>复位，并在两者之间保持其值。
<code>QI</code>是<code>Q</code>的倒数。
</p>
</html>"));
  end RSFlipFlop;

  block TerminateSimulation "如果条件满足，则终止模拟"

    Modelica.Blocks.Interfaces.BooleanOutput condition = false 
      "条件为真时终止模拟" annotation(Dialog, 
      Placement(transformation(extent = {{200, -10}, {220, 10}})));
    parameter String terminationText = "... End condition reached" 
      "模拟终止时将显示的文本";

  equation
    when condition then
      terminate(terminationText);
    end when;
    annotation(Icon(
      coordinateSystem(preserveAspectRatio = true, 
      extent = {{-200, -20}, {200, 20}}, 
      initialScale = 0.2), 
      graphics = {
      Rectangle(fillColor = {235, 235, 235}, 
      fillPattern = FillPattern.Solid, 
      lineThickness = 5, 
      borderPattern = BorderPattern.Raised, 
      extent = {{-200, -20}, {200, 20}}), 
      Text(extent = {{-166, -15}, {194, 15}}, 
      textString = "%condition"), 
      Rectangle(fillColor = {161, 35, 41}, 
      fillPattern = FillPattern.Solid, 
      borderPattern = BorderPattern.Raised, 
      extent = {{-194, -14}, {-168, 14}}), 
      Text(textColor = {0, 0, 255}, 
      extent = {{-200, 22}, {200, 46}}, 
      textString = "%name")}), Documentation(info = "<html>
<p>
在参数菜单中，可以通过变量<strong>condition</strong>定义<strong>time varying</strong>表达式，
例如 condition = x &lt; 0，其中 x 是在模型中声明的变量，TerminateSimulation 模块就在模型中。
如果该表达式为<strong>true</strong>，则模拟（成功）终止。
可以通过参数 termininationText 给出终止信息，解释终止的原因。
</p>

</html>"));
  end TerminateSimulation;
  annotation(Documentation(info = "<html>
<p>
该软件包提供布尔输入和输出信号块，用于描述逻辑网络。
下图是使用逻辑软件包构建逻辑网络的典型示例：
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Logical/LogicalNetwork1.png\"
     alt=\"LogicalNetwork1.png\">
</div>

<p>
布尔输入和/或输出信号的实际值以 “圆圈” 形式显示在相应的程序块图标中，
其中 “白色” 表示值为<strong>false</strong>，“绿色” 表示值为<strong>true</strong>。
这些值在图表动画中可视化。
</p>
</html>"), Icon(graphics = {Line(
    points = {{-86, -22}, {-50, -22}, {-50, 22}, {48, 22}, {48, -22}, {88, -24}}, 
    color = {255, 0, 255})}));
end Logical;