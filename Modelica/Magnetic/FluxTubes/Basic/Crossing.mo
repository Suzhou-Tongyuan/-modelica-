within Modelica.Magnetic.FluxTubes.Basic;
model Crossing "两个交叉分支"

  FluxTubes.Interfaces.PositiveMagneticPort port_p1 
    "正端口_p1 与端口_p2 连接" 
    annotation(Placement(transformation(extent = {{-110, 90}, {-90, 110}})));
  FluxTubes.Interfaces.PositiveMagneticPort port_p2 
    "正端口_p2 与端口_p1 连接" 
    annotation(Placement(transformation(extent = {{90, -110}, {110, -90}})));
  FluxTubes.Interfaces.NegativeMagneticPort port_n1 
    "负端口_n1 与端口_n2 连接" 
    annotation(Placement(transformation(extent = {{-110, -110}, {-90, -90}})));
  FluxTubes.Interfaces.NegativeMagneticPort port_n2 
    "负端口_n2 与端口_n1 连接" 
    annotation(Placement(transformation(extent = {{90, 90}, {110, 110}})));
equation
  connect(port_p1, port_p2) annotation(Line(
    points = {{-100, 100}, {-100, 20}, {0, 20}, {0, -20}, {100, -20}, {100, -100}}, color = {255, 128, 0}));
  connect(port_n1, port_n2) annotation(Line(
    points = {{-100, -100}, {-100, 0}, {100, 0}, {100, 100}}, color = {255, 128, 0}));
  annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, 
    -100}, {100, 100}}), graphics = {
    Line(
    points = {{100, 100}, {40, 100}, {-40, -100}, {-100, -100}}, 
    color = {255, 128, 0}), 
    Line(
    points = {{-100, 100}, {-40, 100}, {40, -100}, {100, -100}}, 
    color = {255, 128, 0}), 
    Text(
    extent = {{-150, 110}, {150, 150}}, 
    textColor = {0, 0, 255}, 
    textString = "%name")}), Documentation(
    info = "<html>
<p>
这是两个分支的简单交叉。连接端口<code>port_p1</code>和<code>port_p2</code>，以及<code>port_n1</code>和<code>port_n2</code>.
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Idle\">Idle</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Short\">Short</a>
</p>

</html>", 
    revisions = "<html>
<h5>Version 3.2.2, 2014-01-15 (Christian Kral)</h5>
<ul>
<li>增加交叉模型</li>
</ul>

</html>"));
end Crossing;