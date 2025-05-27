within Modelica.Electrical.Analog.Interfaces;
partial model VoltageSource "电压源接口"
  extends Modelica.Electrical.Analog.Icons.VoltageSource;
  extends OnePort;
  replaceable Modelica.Blocks.Interfaces.SignalSource signalSource(
    final offset = offset, final startTime = startTime) annotation(Placement(
    transformation(extent = {{70, 69}, {91, 89}})));
  parameter SI.Voltage offset = 0 "电压偏移";
  parameter SI.Time startTime = 0 "时间偏移";
equation
  v = signalSource.y;
  annotation(
    Documentation(revisions = "<html>
<ul>
<li><em> 1998   </em>
       由Christoph Clauss<br>创建<br>
       </li>
</ul>
</html>", 
    info = "<html>
<p>VoltageSource部分模型通过提供引脚、偏移量和startTime参数来准备电压源，这些参数在所有电压源中都是相同的。源行为通过从Modelica.Blocks信号源中继承和使用可替换模型获取。
</p>

</html>"));
end VoltageSource;