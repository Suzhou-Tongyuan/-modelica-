within Modelica.Electrical.Analog.Lines;
model TLine1 
  "具有特性阻抗Z0和传输延迟TD的无损传输线"

  extends Modelica.Electrical.Analog.Interfaces.TwoPort;
  parameter SI.Resistance Z0(start = 1) 
    "特性阻抗";
  parameter SI.Time TD(start = 1) "传输延迟";
protected
  SI.Voltage er;
  SI.Voltage es;
equation
  assert(Z0 > 0, "Z0必须为正");
  assert(TD > 0, "TD必须为正");
  i1 = (v1 - es) / Z0;
  i2 = (v2 - er) / Z0;
  es = 2 * delay(v2, TD) - delay(er, TD);
  er = 2 * delay(v1, TD) - delay(es, TD);
  annotation(defaultComponentName = "line", 
    Documentation(info = "<html>
<p>无损传输线TLine1是一个双端口网络。每个端口分支由具有特性阻抗Z0的电阻和一个考虑了传输延迟TD的可控电压源组成。具体查看
[<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Branin1967</a>]。模型参数可以从每长度单位的电感和电容(L'和C')中得到，即Z0=sqrt(L'/C')和TD=sqrt(L'*C')*length_of_line。假设每米的电阻R'和电导G'为零。
</p>

<p><strong>参考文献：</strong>
   [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Branin1967</a>],
   [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Hoefer1985</a>]</p>
</html>", revisions = "<html>
<ul>
<li><em> 1998   </em>
      由Joachim Haase<br>最初实现<br>
       </li>
</ul>
</html>"), 
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Text(
    extent = {{-150, 150}, {150, 110}}, 
    textString = "%name", 
    textColor = {0, 0, 255}), 
    Rectangle(
    extent = {{-80, 80}, {80, -80}}, 
    lineColor = {0, 0, 255}, 
    fillPattern = FillPattern.Solid, 
    fillColor = {255, 255, 255}), 
    Line(points = {{60, -100}, {90, -100}}, color = {0, 0, 255}), 
    Line(points = {{60, 100}, {90, 100}}, color = {0, 0, 255}), 
    Line(points = {{-60, 100}, {-90, 100}}, color = {0, 0, 255}), 
    Line(points = {{-60, -100}, {-90, -100}}, color = {0, 0, 255}), 
    Text(
    extent = {{-70, -10}, {70, -50}}, 
    textString = "TLine1"), 
    Line(points = {{-40, 40}, {-40, 20}}), 
    Line(points = {{40, 30}, {-40, 30}}), 
    Line(points = {{40, 40}, {40, 20}}), 
    Line(points = {{-60, 100}, {-60, 80}}, color = {0, 0, 255}), 
    Line(points = {{60, 100}, {60, 80}}, color = {0, 0, 255}), 
    Line(points = {{60, -80}, {60, -100}}, color = {0, 0, 255}), 
    Line(points = {{-60, -80}, {-60, -100}}, color = {0, 0, 255})}));
end TLine1;