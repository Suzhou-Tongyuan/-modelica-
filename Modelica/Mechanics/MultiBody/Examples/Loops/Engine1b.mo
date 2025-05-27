within Modelica.Mechanics.MultiBody.Examples.Loops;
model Engine1b 
  "具有气压力和组合运动副JointRRP准备的气缸发动机模型"
  extends Modelica.Icons.Example;
  extends Utilities.Engine1bBase;
  Modelica.Mechanics.MultiBody.Joints.Revolute b1(
    n={1,0,0}, 
    cylinderLength=0.02, 
    cylinderDiameter=0.05) annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Joints.RevolutePlanarLoopConstraint b2(
    n={1,0,0}, 
    cylinderLength=0.02, 
    cylinderDiameter=0.05) annotation (Placement(transformation(extent={{40,-30},{60,-50}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic cylinder(
    useAxisFlange=true, 
    boxWidth=0.02, 
    n={0,-1,0}) annotation (Placement(transformation(
        origin={50,80}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Parts.FixedTranslation rod1(r={0,-0.2,0},animation=false) annotation (
      Placement(transformation(
        origin={70,-20}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
  Parts.FixedTranslation rod3(r={0,-0.1,0}, animation=false) annotation (
      Placement(transformation(
        origin={50,40}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
equation
  connect(cylinder.frame_b, rod3.frame_a) annotation (Line(
      points={{50,70},{50,50}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(cylPosition.frame_b, cylinder.frame_a) annotation (Line(
      points={{-70,50},{-70,94},{50,94},{50,90}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(gasForce.flange_a, cylinder.support) 
    annotation (Line(
      points={{90,90},{74,90},{74,84},{56,84}}, 
      color={0,127,0}));
  connect(gasForce.flange_b, cylinder.axis) 
    annotation (Line(
      points={{90,70},{74,70},{74,72},{56,72}}, 
      color={0,127,0}));
  connect(piston.frame_a, cylinder.frame_b) annotation (Line(
      points={{90,50},{90,60},{50,60},{50,70}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(rod3.frame_b, b1.frame_a) annotation (Line(
      points={{50,30},{50,20},{30,20},{30,0},{40,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(mid.frame_b, b2.frame_a) annotation (Line(
      points={{30,-40},{40,-40}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(b2.frame_b, connectingRod.frame_b) annotation (Line(
      points={{60,-40},{90,-40},{90,-30}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(b2.frame_b, rod1.frame_b) annotation (Line(
      points={{60,-40},{70,-40},{70,-30}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(b1.frame_b, rod1.frame_a) annotation (Line(
      points={{60,0},{70,0},{70,-10}}, 
      color={95,95,95}, 
      thickness=0.5));
  annotation (
    experiment(StopTime=0.5), 
    Diagram(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), 
      graphics={
        Text(
          extent={{-18,-6},{42,-26}}, 
          textColor={255,0,0}, 
          textString="jointRRP in model
Loops.Engine1b_analytic"), 
        Polygon(
          points={{-20,100},{78,100},{78,-52},{36,-52},{36,-28},{-20,-28},{-20,100}}, 
          lineColor={255,0,0}, 
          lineThickness=0.5)}), 
    Documentation(info="<html><p style=\"text-align: start;\">这是一个发动机单缸机械部分的模型。它与<a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Engine1a#diagram\" target=\"\">Loops.Engine1a</a>类似。不同之处在于，增加了一个气缸内气压力的简单模型，并且该模型已重新组织，以便平面运动循环的中心部分可以轻松地替换为复合关节“Modelica.Mechanics.MultiBody.Joints.Assemblies.<strong>JointRRP</strong>”。这种运动循环的交换在 <a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Engine1b_analytic#diagram\" target=\"\">Loops.Engine1b_analytic</a>中进行了展示。使用JointRRP的优点在于，该循环的非线性代数方程是解析求解的，而不是像本模型(Engine1b)中那样数值求解。
</p>
<p style=\"text-align: start;\">以下图例中展示了此示例的动画效果。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/Engine.png\" alt=\"model Examples.Loops.Engine\">
</p>
</html>"));
end Engine1b;