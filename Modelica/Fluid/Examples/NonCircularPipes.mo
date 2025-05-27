within Modelica.Fluid.Examples;
model NonCircularPipes "圆管与非圆管的比较"
  extends Modelica.Icons.Example;
  replaceable package Medium = Modelica.Media.Water.StandardWater annotation();
  constant Real odim = 0.015;
  constant Real idim = 0.005;
  inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial) 
                                     annotation(Placement(transformation(origin = {-80, 80}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Fluid.Sources.Boundary_pT boundary(
    redeclare package Medium = Medium, 
    nPorts = 2, 
    p = 10.0e5, 
    T = 293.15) 
    annotation(Placement(transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Fluid.Sources.MassFlowSource_T massflowsink1(redeclare package
      Medium =                                                                     Medium, nPorts = 1, m_flow = -0.1, T = 293.15) annotation(Placement(transformation(origin = {40, 40}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Fluid.Sources.MassFlowSource_T massflowsink2(redeclare package
      Medium =                                                                     Medium, nPorts = 1, m_flow = -0.1, T = 293.15) annotation(Placement(transformation(origin = {40, -40}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Fluid.Pipes.DynamicPipe circular_pipe(
    redeclare package Medium = Medium, 
    length = 100, diameter = 0.01, 
    T_start = 293.15, 
    p_a_start = 10.0e5, p_b_start = 10.0e5) 
    annotation(Placement(transformation(origin = {-20, 40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Fluid.Pipes.DynamicPipe annulus_pipe(
    redeclare package Medium = Medium, 
    length = 100, 
    crossArea = Modelica.Constants.pi * (odim ^ 2 - idim ^ 2) / 4, 
    perimeter = Modelica.Constants.pi * (odim + idim), 
    isCircular=false, 
    diameter=0, 
    p_a_start=1000000, 
    p_b_start=1000000, 
    T_start=293.15) 
    annotation(Placement(transformation(origin = {-20, -40}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(boundary.ports[1], circular_pipe.port_a) annotation(Line(points={{-70,2}, 
          {-60,2},{-60,40},{-30,40}}, color = {0, 127, 255}));
  connect(boundary.ports[2], annulus_pipe.port_a) annotation(Line(points={{-70,-2}, 
          {-60,-2},{-60,-40},{-30,-40}}, color = {0, 127, 255}));
  connect(circular_pipe.port_b, massflowsink1.ports[1]) annotation(Line(points = {{-10, 40}, {30, 40}}, color = {0, 127, 255}));
  connect(annulus_pipe.port_b, massflowsink2.ports[1]) annotation(Line(points = {{-10, -40}, {30, -40}}, color = {0, 127, 255}));
  annotation(experiment(StopTime=1), 
  Documentation(info="<html><p>
在这个例子中，使用了两根管道来演示圆形管道（默认）和非圆形管道的使用，其中最顶端的管道是长度为 100 米、内径为 10 毫米的圆形管道，第二根管道是内径为 5 毫米、外径为 15 毫米的圆形环形管道。
</p>
<p>
两根管道都连接到一个 pT 边界（水，293.15 K，10 bar）和一个质量流量边界（0.1 kg/s流入量）。
</p>
<p>
虽然两根管道的水力直径相同，但截面不同导致流速不同，因此出口压力也不同（圆形管道为 7.324 bar，而环形管道为 9.231 bar）。
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/NonCircularPipes.png\" alt=\"NonCircularPipes.png\" data-href=\"\" style=\"\">
</p>
</html>",revisions="<html>
<ul>
<li>
January 6, 2015 by Alexander T&auml;schner:<br>
First implementation.
</li>
</ul>
</html>"));
end NonCircularPipes;