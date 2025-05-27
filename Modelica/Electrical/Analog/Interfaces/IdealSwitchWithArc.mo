within Modelica.Electrical.Analog.Interfaces;
partial model IdealSwitchWithArc "带简单电弧效应的理想开关"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  parameter SI.Resistance Ron = 1E-5 "闭合开关电阻";

  parameter SI.Conductance Goff = 1E-5 
    "打开开关导纳";
  parameter SI.Voltage V0(start = 30) "初始电弧电压";
  parameter SI.VoltageSlope dVdt(start = 10E3) 
    "电弧电压斜率";
  parameter SI.Voltage Vmax(start = 60) "最大电弧电压";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T = 293.15);
  Boolean off(start = true) "指示关闭状态(但可能未完全熄灭)";
protected
  Boolean quenched(start = true, fixed = true) 
    "指示熄灭的电弧(如果开关关闭)";

  discrete SI.Time tSwitch(start = -Modelica.Constants.inf, fixed = true) 
    "最后一次关闭开关的时间点";
equation
  when edge(off) then
    tSwitch = time;
  end when;
  quenched = off and (abs(i) <= abs(v) * Goff or pre(quenched));
  if off then
    if quenched then
      i = Goff * v;
    else
      v = min(Vmax, V0 + dVdt * (time - tSwitch)) * sign(i);
    end if;
  else
    v = Ron * i;
  end if;
  LossPower = v * i;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
    100}}), graphics = {
    Ellipse(extent = {{-44, 4}, {-36, -4}}, lineColor = {0, 0, 255}), 
    Line(points = {{-90, 0}, {-44, 0}}, color = {0, 0, 255}), 
    Line(points = {{-37, 2}, {40, 40}}, color = {0, 0, 255}), 
    Line(points = {{40, 0}, {90, 0}}, color = {0, 0, 255}), 
    Text(
    extent = {{-150, 90}, {150, 50}}, 
    textString = "%name", 
    textColor = {0, 0, 255})}), 
    Diagram(graphics = {Line(points = {{-60, 60}, {-60, -60}, {60, -60}}, color = {0, 0, 255}), 
    Line(points = {{-60, -60}, {-40, -60}, {-40, -40}, {-20, 40}, {40, 40}}), Text(
    extent = {{30, -60}, {50, -70}}, 
    textString = "time"), Text(
    extent = {{-60, 60}, {-20, 50}}, 
    textString = "voltage"), Text(
    extent = {{-60, -30}, {-40, -40}}, 
    textString = "V0"), Text(
    extent = {{-50, 40}, {-30, 30}}, 
    textString = "Vmax"), Text(
    extent = {{-40, 10}, {-20, 0}}, 
    textString = "dVdt"), Polygon(
    points = {{-60, 60}, {-62, 52}, {-58, 52}, {-60, 60}}, 
    fillPattern = FillPattern.Solid), Polygon(
    points = {{60, -60}, {54, -58}, {54, -62}, {60, -60}}, 
    fillPattern = FillPattern.Solid)}), 
    Documentation(info = "<html>
<p>
该模型基于<a href=\"modelica://Modelica.Electrical.Analog.Interfaces.IdealSwitch\">IdealSwitch</a>搭建。
</p>

<p>基本模型会在一个无限小的时间间隔内中断通过开关的电流。如果连接了一个感应电路，那么开关的电压仅受数值限制。为了更好地了解开关上的电压，模型添加了简单的弧效应：
</p>

<p>当布尔变量“off”发出信号打开开关时，会在开关上施加电压。这个电压首先以<code>V0</code>为起点(模拟弧根电压)，然后以<code>dVdt</code>为斜率(模拟伸长弧的电压)上升，直到达到最大电压<code>Vmax</code>。
</p>
<blockquote><pre>
     | voltage
Vmax |      +-----
     |     /
     |    /
V0   |   +
     |   |
     +---+-------- time
</pre></blockquote>

<p>这种弧电压倾向于降低通过开关的电流；它取决于所连接的电路，当弧被熄灭时。一旦弧被熄灭，也就是说，通过开关的电流变为零，就会激活断态方程<code>i=Goff*v</code>。
</p>

<p>当布尔变量<code>off</code>发出信号要再次关闭开关时，开关会立即关闭，即激活在状态方程<code>v=Ron*i</code>。
</p>

<p>请注意：在交流电路中，至少当电流的下一个自然零点交叉(即电流方向改变)时，电弧才会熄灭。而在直流电路中，如果电弧电压不足以使电流达到零点交叉，电弧将不会熄灭。换言之，交流电路中的电弧熄灭依赖于电流周期性变化，而直流电路则需要额外的条件(如足够的熄弧电压)才能使电弧停止。

<p>
<strong>请注意：</strong>
如果使用了HeatPort=true，则<strong>不会</strong>模拟电气行为的温度依赖性。参数的值在整个温度范围内保持不变。这意味着，即使环境温度发生变化，电路元件的电气参数(如电阻、电容、电感等)也不会发生变化。
</p>
</html>", 
    revisions = "<html>
<ul>
<li><em>June, 2009   </em>
       由Christoph Clauss<br>调试OpenerWithArc<br>
       </li>
<li><em>May, 2009   </em>
       由Anton Haumer<br>创建CloserWithArc<br>
       </li>
</ul>
</html>"));
end IdealSwitchWithArc;