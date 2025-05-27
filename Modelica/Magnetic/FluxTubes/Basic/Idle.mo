within Modelica.Magnetic.FluxTubes.Basic;
model Idle "开路分支"
  extends Interfaces.TwoPort;
  equation
  Phi = 0;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {
    100, 100}}), graphics = {
    Text(
    extent = {{-150, 50}, {150, 90}}, 
    textColor = {0, 0, 255}, 
    textString = "%name"), 
    Line(points = {{-100, 0}, {-40, 0}}, color = {255, 128, 0}), 
    Line(points = {{40, 0}, {100, 0}}, color = {255, 128, 0})}), 
    Documentation(info = "<html>
<p>
这是一个开路分支.
</p>

</html>", 
    revisions = "<html>
<h5>Version 3.2.2, 2014-01-15 (Christian Kral)</h5>
<ul>
<li>添加了空闲模型</li>
</ul>

</html>"), 
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, 
    {100, 100}}), graphics = {
    Line(points = {{60, 0}, {100, 0}}, color = {255, 128, 0})}));
end Idle;