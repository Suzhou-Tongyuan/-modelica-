within Modelica.Electrical.Analog.Interfaces;
partial model IdealSemiconductor "理想半导体"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  parameter SI.Resistance Ron(final min = 0) = 1e-5 
    "正向导通状态下的微分电阻(闭合电阻)";
  parameter SI.Conductance Goff(final min = 0) = 1e-5 
    "反向关态导纳(导通导纳)";
  parameter SI.Voltage Vknee(final min = 0) = 0 
    "正向阈值电压";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort;
  Boolean off(start = true) "开关状态";
protected
  Real s(start = 0, final unit = "1") 
    "辅助变量(用于描述理想二极管的实际状态特性)";

  /* s = 0: knee point
  s < 0: below knee point, blocking
  s > 0: above knee point, conducting */
  constant SI.Voltage unitVoltage = 1 annotation(HideResult = true);
  constant SI.Current unitCurrent = 1 annotation(HideResult = true);
equation
  v = (s * unitCurrent) * (if off then 1 else Ron) + Vknee;
  i = (s * unitVoltage) * (if off then Goff else 1) + Goff * Vknee;
  LossPower = v * i;
  annotation(
    Documentation(info = "<html>
<p>这是一个理想半导体:

<p>如果半导体处于反向偏置状态(电压降小于0)，则为<strong>关闭</strong>(打开)状态；如果处于传导状态(电流大于0)，则为<strong>打开</strong>(关闭)状态。

<br>

<br>这样的工作性能需满足其他参数都为0时的条件。<br><br>
请注意，有些电路中，理想描述(零电阻和零导电性)是无法实现的。为了在开关过程中避免出现奇点，当半导体开路时会有一个很小的导电性<em>Gon</em>，而当半导体闭合时，会有一个较低的电阻<em>Roff</em>，这是默认设置。这样的设计考虑到了实际器件的非理想特性，以确保电路行为的连续性和稳定性。</p>

<p>
正向阈值电压Vknee，允许沿<em>Gon</em>特性(导电特性)平移，直到<em>v=Vknee</em>。

<br><br>
<strong>请注意：</strong>
当useHeatPort设置为true时，电学行为的温度依赖性未被建模。这意味着，尽管热端口被启用，但该模型并<strong>未</strong>考虑温度变化对电气特性的影响。
</p>
</html>", 
    revisions = "<html>
<ul>
<li><em> March 11, 2009   </em>
       由Christoph Clauss<br>添加conditional heat port<br>
       </li>
<li><em>Mai 7, 2004   </em>
       由Christoph Clauss和Anton Haumer<br>添加Vknee<br>
       </li>
<li><em>几年前 </em>
       由Christoph Clauss<br>实现<br>
       </li>
</ul>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
    100}}), graphics = {
    Polygon(
    points = {{30, 0}, {-30, 40}, {-30, -40}, {30, 0}}, 
    lineColor = {0, 0, 255}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{-90, 0}, {40, 0}}, color = {0, 0, 255}), 
    Line(points = {{40, 0}, {90, 0}}, color = {0, 0, 255}), 
    Line(points = {{30, 40}, {30, -40}}, color = {0, 0, 255}), 
    Line(
    visible = useHeatPort, 
    points = {{0, -100}, {0, -20}}, 
    color = {127, 0, 0}, 
    pattern = LinePattern.Dot), 
    Text(
    extent = {{-150, 90}, {150, 50}}, 
    textString = "%name", 
    textColor = {0, 0, 255})}), 
    Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
    100, 100}}), graphics = {Line(points = {{-80, 0}, {80, 0}}, color = {128, 128, 128}), 
    Polygon(
    points = {{70, 4}, {80, 0}, {70, -4}, {70, 4}}, 
    lineColor = {128, 128, 128}, 
    fillColor = {128, 128, 128}, 
    fillPattern = FillPattern.Solid), Line(points = {{0, 80}, {0, -80}}, 
    color = {128, 128, 128}), Polygon(
    points = {{-4, 70}, {0, 80}, {4, 70}, {-4, 70}}, 
    lineColor = {128, 128, 128}, 
    fillColor = {128, 128, 128}, 
    fillPattern = FillPattern.Solid), Text(
    extent = {{10, 80}, {20, 70}}, 
    textColor = {128, 128, 128}, 
    textString = "i"), Text(
    extent = {{70, -10}, {80, -20}}, 
    textColor = {128, 128, 128}, 
    textString = "v"), Line(
    points = {{-80, -40}, {-20, -10}, {20, 10}, {40, 70}}, 
    thickness = 0.5), Line(
    points = {{20, 9}, {20, 0}}, 
    color = {128, 128, 128}, 
    pattern = LinePattern.Dot), Text(
    extent = {{20, 0}, {40, -10}}, 
    textColor = {128, 128, 128}, 
    textString = "Vknee"), Text(
    extent = {{20, 70}, {40, 60}}, 
    textColor = {128, 128, 128}, 
    textString = "Ron"), Text(
    extent = {{-20, 10}, {0, 0}}, 
    textColor = {128, 128, 128}, 
    textString = "Goff"), Ellipse(
    extent = {{18, 12}, {22, 8}}, 
    pattern = LinePattern.Dot, 
    lineColor = {0, 0, 255})}));
end IdealSemiconductor;