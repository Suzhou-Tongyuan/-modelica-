within Modelica.Electrical.Analog.Basic;
model Capacitor "理想线性电容"
  extends Interfaces.OnePort(v(start = 0));
  parameter SI.Capacitance C(start = 1) "电容";

equation
  i = C * der(v);
  annotation(
    Documentation(info = "<html>
<p>线性电容器通过公式<em>i=C*dv/dt</em>将支路电压<em>v</em>与支路电流<em>i</em>连接起来。电容<em>C</em>只允许为正数或零。</p>

</html>", 
    revisions = "<html>
<ul>
<li><em> 1998   </em>
       Christoph Clauss<br>创建<br>
       </li>
</ul>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
    100}}), graphics = {
    Line(points = {{-6, 28}, {-6, -28}}, color = {0, 0, 255}), 
    Line(points = {{6, 28}, {6, -28}}, color = {0, 0, 255}), 
    Line(points = {{-90, 0}, {-6, 0}}, color = {0, 0, 255}), 
    Line(points = {{6, 0}, {90, 0}}, color = {0, 0, 255}), 
    Text(
    extent = {{-150, -40}, {150, -80}}, 
    textString = "C=%C"), 
    Text(
    extent = {{-150, 90}, {150, 50}}, 
    textString = "%name", 
    textColor = {0, 0, 255})}));
end Capacitor;