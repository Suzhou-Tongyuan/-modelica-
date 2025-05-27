within Modelica.Electrical.Analog.Sources;
model ConstantCurrent "恒流源"
  parameter SI.Current I(start = 1) "恒流值";
  extends Interfaces.OnePort;
  extends Modelica.Electrical.Analog.Icons.CurrentSource;
equation
  i = I;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
    100}}), graphics = {
    Text(
    extent = {{-150, -100}, {150, -60}}, 
    textString = "I=%I")}), 
    Documentation(revisions = "<html>
<ul>
<li><em> 1998   </em>
       Christoph Clauss<br>创建<br>
       </li>
</ul>
</html>", 
    info = "<html>
<p>恒流源是一种理想化的简单电源，它提供的电流是通过一个参数设定的。这个电源模型中不包含内部电阻，也没有考虑其他额外的影响。特别地，电流流动是无限制的，不会自然停止。换言之，它是一个理想的电流源，能够提供恒定不变的电流，不受时间或负载变化的影响。
</p>

</html>"));
end ConstantCurrent;