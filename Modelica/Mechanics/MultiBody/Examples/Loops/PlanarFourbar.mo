within Modelica.Mechanics.MultiBody.Examples.Loops;
model PlanarFourbar "具有一个运动环的平面四杆机构(使用RevolutePlanarLoopConstraint运动副)"
  extends Modelica.Icons.Example;

  Joints.Revolute revolute1(
    animation=true, 
    n={0,0,1}, 
    stateSelect=StateSelect.always, 
    phi(fixed=true), 
    w(fixed=true), 
    useAxisFlange=true) 
                   annotation (Placement(transformation(extent={{-50,-20},{-30,-40}})));
  Joints.Revolute revolute2(animation=true, n={0,0,1}) annotation (Placement(transformation(extent={{30,-40},{50,-20}})));
  Joints.Revolute revolute3(animation=true, n={0,0,1}) annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
  Joints.RevolutePlanarLoopConstraint revolute4cut 
    annotation (Placement(transformation(extent={{30,40},{50,20}})));
  Parts.BodyBox body1(
    width=0.5*world.defaultJointLength, r={0.4,0,0}) 
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  Parts.BodyBox body2(
    width=body1.width, r={0.1,1.1,0}) 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={70,0})));
  Parts.BodyBox body3(
    width=body1.width, r={-0.15,1,0}) 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-70,2})));
  Parts.BodyBox body4(
    r=body1.r + body2.r - body3.r, 
    width=body1.width) 
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  inner Modelica.Mechanics.MultiBody.World world(enableAnimation=true) 
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Rotational.Components.Damper                    damper(d=0.1) 
    annotation (Placement(transformation(extent={{-50,-70},{-30,-50}})));
  Sensors.RelativeSensor sensorJoint4(
    animation=false, 
    resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a, 
    get_w_rel=true, 
    get_z_rel=true, 
    get_angles=true, 
    sequence={1,2,3}) annotation (Placement(transformation(extent={{30,84},{50,64}})));
equation
  connect(revolute1.frame_b, body1.frame_a) annotation (Line(
      points={{-30,-30},{-10,-30}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(revolute2.frame_a, body1.frame_b) annotation (Line(
      points={{30,-30},{10,-30}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(revolute2.frame_b, body2.frame_a) annotation (Line(
      points={{50,-30},{70,-30},{70,-10}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(world.frame_b, revolute1.frame_a) annotation (Line(
      points={{-80,-30},{-50,-30}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(world.frame_b, body3.frame_a) annotation (Line(
      points={{-80,-30},{-70,-30},{-70,-8}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(body3.frame_b, revolute3.frame_a) annotation (Line(
      points={{-70,12},{-70,30},{-50,30}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(revolute3.frame_b, body4.frame_a) annotation (Line(
      points={{-30,30},{-10,30}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(body4.frame_b, revolute4cut.frame_a) annotation (Line(
      points={{10,30},{30,30}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(body2.frame_b, revolute4cut.frame_b) annotation (Line(
      points={{70,10},{70,30},{50,30}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(damper.flange_b, revolute1.axis) annotation (Line(points={{-30,-60},{-30,-40},{-40,-40}}));
  connect(revolute1.support,damper. flange_a) annotation (Line(points={{-46,-40},{-50,-40},{-50,-60}}));
  connect(sensorJoint4.frame_a, revolute4cut.frame_a) annotation (Line(
      points={{30,74},{20,74},{20,30},{30,30}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(sensorJoint4.frame_b, revolute4cut.frame_b) annotation (Line(
      points={{50,74},{60,74},{60,30},{50,30}}, 
      color={95,95,95}, 
      thickness=0.5));
  annotation (
    experiment(StopTime=5), 
    Documentation(info="<html><pstyle=\"text-align: start;\"><p>这是一个平面四连杆机构，展示了<a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.RevolutePlanarLoopConstraint\"target=\"\">RevolutePlanarLoopConstraint</a>运动副的可能用法。
在这个平面示例中，所有的转动副都围绕垂直于x-y平面的轴旋转，即它们都是平行的。
为了在这种情况下获得唯一的数值解，必须引入一个RevolutePlanarLoopConstraint，而不是普通的转动副。
</p>
<pstyle=\"text-align: start;\">另一种选择是使用组合运动副<strong>Joints.Assemblies.JointRRR</strong>来替代机构的一部分，
如<a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.PlanarLoops_analytic\"target=\"\">PlanarLoops_analytic</a>示例中所示。
</p>
<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/PlanarFourbar.png\"alt=\"model Examples.Loops.PlanarFourbar\">
</blockquote>
</html>"), 
    Diagram(graphics={Polygon(
          points={{-54,48},{82,48},{82,-46},{26,-46},{26,0},{-54,0},{-54,48}}, 
          lineColor={255,0,0}, 
          lineThickness=0.5, 
          pattern=LinePattern.Dash),      Text(
          extent={{0,18},{0,2}}, 
          textColor={255,0,0}, 
          textString="CanbereplacedbyAssemblies.JointRRR", 
          fontSize=14)}));
end PlanarFourbar;