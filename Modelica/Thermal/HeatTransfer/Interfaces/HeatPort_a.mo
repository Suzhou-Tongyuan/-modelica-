within Modelica.Thermal.HeatTransfer.Interfaces;
connector HeatPort_a 
  "用于一维热传导的热接口(实心矩形图标)"

  extends HeatPort;

  annotation(defaultComponentName = "port_a", 
    Documentation(info="<html><p>
该连接器用于组件之间的一维热流。连接器中的变量为:
</p>
<p>
<br>
</p>
<pre><code >T       温度 [Kelvin].
Q_flow  热流量 [Watt].
</code></pre><p>
<br>
</p>
<p>
根据Modelica符号约定，<strong>正</strong>热流率<strong>Q_flow</strong>被视为<strong>流入</strong>组件的方向。在模型类中使用该连接器时，必须遵循此约定。<br>注意：两个连接器<strong>HeatPort_a</strong>与<strong>HeatPort_b</strong>除<strong>图标布局</strong>不同外完全一致。
</p>
<p>
<br>
</p>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
    100, 100}}), graphics = {Rectangle(
    extent = {{-100, 100}, {100, -100}}, 
    lineColor = {191, 0, 0}, 
    fillColor = {191, 0, 0}, 
    fillPattern = FillPattern.Solid)}), 
    Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
    {100, 100}}), graphics = {Rectangle(
    extent = {{-50, 50}, {50, -50}}, 
    lineColor = {191, 0, 0}, 
    fillColor = {191, 0, 0}, 
    fillPattern = FillPattern.Solid), Text(
    extent = {{-120, 120}, {100, 60}}, 
    textColor = {191, 0, 0}, 
    textString = "%name")}));
end HeatPort_a;