within Modelica.Mechanics.MultiBody.Examples.Elementary;
model ThreeSprings "三维空间下弹簧采用串联和并联连接"
  extends Modelica.Icons.Example;
  parameter Boolean animation = true "= true, 如果启用动画";
  inner Modelica.Mechanics.MultiBody.World world(animateWorld = animation) 
    annotation(Placement(transformation(extent = {{-60, 20}, {-40, 40}})));
  Modelica.Mechanics.MultiBody.Parts.Body body1(
    animation = animation, 
    r_CM = {0, -0.2, 0}, 
    m = 0.8, 
    I_11 = 0.1, 
    I_22 = 0.1, 
    I_33 = 0.1, 
    sphereDiameter = 0.2, 
    r_0(start = {0.5, -0.3, 0}, each fixed = true), 
    v_0(each fixed = true), 
    angles_fixed = true, 
    w_0_fixed = true) annotation(Placement(transformation(
    origin = {30, -70}, 
    extent = {{-10, 10}, {10, -10}}, 
    rotation = 270)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation bar1(animation = animation, r = {0.3, 0, 0}) 
    annotation(Placement(transformation(extent = {{-10, 20}, {10, 40}})));
  Modelica.Mechanics.MultiBody.Forces.Spring spring1(
    lineForce(r_rel_0(start = {-0.2, -0.2, 0.2})), 
    s_unstretched = 0.1, 
    width = 0.1, 
    coilWidth = 0.005, 
    numberOfWindings = 5, 
    c = 20, 
    animation = animation) annotation(Placement(transformation(
    origin = {30, 0}, 
    extent = {{-10, -10}, {10, 10}}, 
    rotation = 270)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation bar2(animation = animation, r = {0, 0, 0.3}) 
    annotation(Placement(transformation(
    origin = {-30, 0}, 
    extent = {{10, -10}, {-10, 10}}, 
    rotation = 90)));
  Modelica.Mechanics.MultiBody.Forces.Spring spring2(
    s_unstretched = 0.1, 
    width = 0.1, 
    coilWidth = 0.005, 
    numberOfWindings = 5, 
    c = 40, 
    animation = animation) annotation(Placement(transformation(
    origin = {30, -40}, 
    extent = {{-10, -10}, {10, 10}}, 
    rotation = 270)));
  Modelica.Mechanics.MultiBody.Forces.Spring spring3(
    s_unstretched = 0.1, 
    width = 0.1, 
    coilWidth = 0.005, 
    numberOfWindings = 5, 
    c = 20, 
    animation = animation, 
    fixedRotationAtFrame_b = true) 
    annotation(Placement(transformation(extent = {{-10, -30}, {10, -10}})));
equation
  connect(world.frame_b, bar1.frame_a) 
    annotation(Line(
    points = {{-40, 30}, {-10, 30}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(world.frame_b, bar2.frame_a) annotation(Line(
    points = {{-40, 30}, {-30, 30}, {-30, 10}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(bar1.frame_b, spring1.frame_a) 
    annotation(Line(
    points = {{10, 30}, {30, 30}, {30, 10}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(bar2.frame_b, spring3.frame_a) annotation(Line(
    points = {{-30, -10}, {-30, -20}, {-10, -20}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(spring2.frame_b, body1.frame_a) 
    annotation(Line(
    points = {{30, -50}, {30, -60}}, 
    thickness = 0.5));
  connect(spring3.frame_b, spring1.frame_b) 
    annotation(Line(
    points = {{10, -20}, {30, -20}, {30, -10}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(spring2.frame_a, spring1.frame_b) 
    annotation(Line(
    points = {{30, -30}, {30, -10}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  annotation(
    experiment(StopTime = 10), 
    Documentation(info = "<html><p>
这个例子演示了可以将<strong>三维线性力元素</strong>(这里是Modelica.Mechanics.MultiBody.Forces.Spring元素)<strong>串联</strong>在一起，
而无需在连接点处具有质量的物体(通常由多体程序要求)。
这是有利的，因为可以避免出现刚性系统，例如，由于连接点处的刚性弹簧和小质量的影响。
</p>
<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/ThreeSprings.png\"
alt=\"model Examples.Elementary.ThreeSprings\">
</blockquote><p>
有关更详细的解释，请参见<a href=\"modelica://Modelica.Mechanics.MultiBody.UsersGuide.Tutorial.ConnectionOfLineForces\" target=\"\">MultiBody.UsersGuide.Tutorial.ConnectionOfLineForces</a>.
</p>
</html>"));
end ThreeSprings;