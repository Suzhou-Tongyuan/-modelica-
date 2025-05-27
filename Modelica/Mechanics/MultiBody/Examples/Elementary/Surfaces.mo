within Modelica.Mechanics.MultiBody.Examples.Elementary;
model Surfaces 
  "演示正弦曲面的可视化，以及由曲面构建的环面和轮的可视化。"
  extends Modelica.Icons.Example;
  parameter Real x_min = -1 "x的最小值";
  parameter Real x_max = +1 "x的最大值";
  parameter Real y_min = -1 "y的最小值";
  parameter Real y_max = +1 "y的最大值";
  parameter Real z_min = 0 "z的最小值";
  parameter Real z_max = 1 "z的最大值";
  Real wz = time;
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Surface surface(
  redeclare function surfaceCharacteristic = 
    Modelica.Mechanics.MultiBody.Examples.Elementary.Utilities.sineSurface(
    x_min = x_min, 
    x_max = x_max, 
    y_min = y_min, 
    y_max = y_max, 
    z_min = z_min, 
    z_max = z_max, 
    wz = wz), 
    multiColoredSurface = false, 
    nu = 50, 
    nv = 50) 
    annotation(Placement(transformation(extent = {{60, -60}, {80, -40}})));
  inner World world(
    axisLength = 1, 
    n = {0, 0, -1}, 
    animateGround = true, 
    groundLength_u = 4, 
    groundColor = {215, 215, 215}) 
    annotation(Placement(transformation(extent = {{-100, -10}, {-80, 10}})));
  Visualizers.Torus torus 
    annotation(Placement(transformation(extent = {{30, 10}, {50, 30}})));
  Joints.Prismatic prismatic(useAxisFlange = true, animation = false, 
    v(fixed = true)) 
    annotation(Placement(transformation(extent = {{-40, 10}, {-20, 30}})));
  Translational.Sources.Position position 
    annotation(Placement(transformation(extent = {{-50, 50}, {-30, 70}})));
  Blocks.Sources.Sine sine(amplitude = 2, f = 0.5) 
    annotation(Placement(transformation(extent = {{-80, 50}, {-60, 70}})));
  Parts.FixedTranslation fixedTranslation1(r = {0, -1.3, torus.R + torus.r}, 
    animation = false) 
    annotation(Placement(transformation(extent = {{0, 10}, {20, 30}})));
  Parts.FixedTranslation fixedTranslation2(
    animation = false, r = {0, -1.6, wheel.rTire}) 
    annotation(Placement(transformation(extent = {{0, 50}, {20, 70}})));
  Visualizers.VoluminousWheel wheel 
    annotation(Placement(transformation(extent = {{30, 50}, {50, 70}})));
  Visualizers.PipeWithScalarField pipeWithScalarField(
    rOuter = 0.3, 
    length = 1, 
    T_min = 0, 
    T_max = 2, 
    T = Modelica.Math.sin(Modelica.Constants.pi * pipeWithScalarField.xsi) * 
    Modelica.Math.cos(Modelica.Constants.pi * time) .+ 1, 
    n_colors = 32) 
    annotation(Placement(transformation(extent = {{14, -30}, {34, -10}})));
  Parts.FixedTranslation fixedTranslation3(
    animation = false, r = {0, -2.2, 0}) 
    annotation(Placement(transformation(extent = {{-20, -30}, {0, -10}})));
equation
  connect(world.frame_b, prismatic.frame_a) annotation(Line(
    points = {{-80, 0}, {-60, 0}, {-60, 20}, {-40, 20}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(position.flange, prismatic.axis) annotation(Line(
    points = {{-30, 60}, {-22, 60}, {-22, 26}}, color = {0, 127, 0}));
  connect(sine.y, position.s_ref) annotation(Line(
    points = {{-59, 60}, {-52, 60}}, color = {0, 0, 127}));
  connect(prismatic.frame_b, fixedTranslation1.frame_a) 
    annotation(Line(
    points = {{-20, 20}, {0, 20}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(fixedTranslation1.frame_b, torus.frame_a) 
    annotation(Line(
    points = {{20, 20}, {30, 20}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(prismatic.frame_b, fixedTranslation2.frame_a) annotation(Line(
    points = {{-20, 20}, {-10, 20}, {-10, 60}, {0, 60}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(fixedTranslation2.frame_b, wheel.frame_a) annotation(Line(
    points = {{20, 60}, {30, 60}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(world.frame_b, fixedTranslation3.frame_a) annotation(Line(
    points = {{-80, 0}, {-60, 0}, {-60, -20}, {-20, -20}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(fixedTranslation3.frame_b, pipeWithScalarField.frame_a) annotation(
    Line(
    points = {{0, -20}, {14, -20}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  annotation(
    experiment(StopTime = 5), 
    Documentation(info = "<html><p>
该示例演示了 
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Surface\" target=\"\">Surface</a>可视化的使用，用于可视化一个移动的、参数化的曲面。
\"sine-wave\"曲面是对曲面模型的直接应用。
此外，\"torus\"曲面是
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Torus\" target=\"\"><u>Torus</u></a>  的一个实例 &nbsp;
\"wheel\"曲面是<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.VoluminousWheel\" target=\"\">VoluminousWheel</a> 
的一个实例，\"pipeWithScalarField\"曲面是<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.PipeWithScalarField\" target=\"\">PipeWithScalarField</a>
的一个实例。所有后者的可视化形状都是使用曲面(surface)模型构建的。以下图像显示了此示例模型的屏幕截图：
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/Surfaces.png\">
</blockquote>

</html>"));
end Surfaces;