within Modelica.Electrical.Analog.Sources;
model ConstantVoltage "恒压电源"

  parameter SI.Voltage V(start = 1) "恒压源的电压参数";
  extends Interfaces.OnePort;
  extends Modelica.Electrical.Analog.Icons.VoltageSource;
equation
  v = V;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
    100}}), graphics = {
    Text(
    extent = {{-150, -110}, {150, -70}}, 
    textString = "V=%V")}), 
    Documentation(revisions = "<html>
<ul>
<li><em> 1998   </em>
       Christoph Clauss<br>创建<br>
       </li>
</ul>
</html>", 
    info = "<html>

<p>恒压源是一个简单的源，提供了一个可调参数的理想恒定电压。它没有内部电阻。如果用它来替代电池模型，它是不太现实的：这个电池将永不放电。
</p>
</html>"));
end ConstantVoltage;