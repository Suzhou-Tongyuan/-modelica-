within Modelica.Mechanics.MultiBody.Examples.Elementary;
model SpringWithMass "悬挂在弹簧上的点质量"
  extends Modelica.Icons.Example;
  inner Modelica.Mechanics.MultiBody.World world(animateGravity=false) 
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Modelica.Mechanics.MultiBody.Forces.Spring spring(
    s_unstretched=0.2, 
    m=0.5, 
    c=40, 
    width=0.1, 
    massDiameter=0.07) annotation (Placement(transformation(
        origin={10,30}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Mechanics.MultiBody.Parts.Body body(
    r_0(start={0,-0.3,0}, each fixed=true), 
    v_0(each fixed=true), 
    angles_fixed=true, 
    w_0_fixed=true, 
    r_CM={0,0,0}, 
    m=1) annotation (Placement(transformation(
        origin={10,-10}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
equation
  connect(world.frame_b, spring.frame_a) 
    annotation (Line(
      points={{-20,50},{10,50},{10,40}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(body.frame_a, spring.frame_b) 
    annotation (Line(
      points={{10,0},{10,10},{10,20}}, 
      color={95,95,95}, 
      thickness=0.5));
  annotation (experiment(StopTime=5), Documentation(info="<html><p>
这个例子展示了一个力组件可能具有质量的情况。在本例中使用的三维弹簧，在连接弹簧的两个点之间有一个可选的质点。在动画中，这个质点用一个小的浅蓝色球体来表示。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/SpringWithMass.png\"
alt=\"model Examples.Elementary.SpringWithMass\">
</p>
</html>"));
end SpringWithMass;