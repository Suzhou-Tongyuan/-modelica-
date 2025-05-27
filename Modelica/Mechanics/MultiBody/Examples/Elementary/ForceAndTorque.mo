within Modelica.Mechanics.MultiBody.Examples.Elementary;
model ForceAndTorque "演示组件ForceAndTorque的用法"
  extends Modelica.Icons.Example;
  inner World world(animateGravity=false, defaultNm_to_m=120, defaultN_to_m=1200) annotation (Placement(transformation(
          extent={{-90,30},{-70,50}})));
  Parts.BodyCylinder body(r={1,0,0}) annotation (Placement(transformation(
          extent={{0,30},{20,50}})));
  Parts.Fixed fixed1(r={0,-0.5,0}, width=0.03) 
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Parts.FixedRotation fixedRotation(n={0,0,1}, angle=30) 
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Forces.ForceAndTorque forceAndTorque(
    resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve) 
    annotation (Placement(transformation(extent={{60,50},{40,30}})));
  Joints.Revolute revolute2(n={0,1,0}, 
    phi(fixed=true), 
    w(fixed=true)) annotation (Placement(transformation(
        origin={-20,20}, 
        extent={{-10,-10},{10,10}}, 
        rotation=90)));
  Modelica.Blocks.Sources.Constant torque[3](k={-100,100,0}) 
    annotation (Placement(transformation(
        origin={40,-10}, 
        extent={{10,-10},{-10,10}}, 
        rotation=270)));
  Joints.Revolute revolute1(phi(fixed=true), w(fixed=true)) 
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Parts.Fixed fixed2(width=0.03, r={1.5,0.25,0}) 
    annotation (Placement(transformation(extent={{100,30},{80,50}})));
  Modelica.Blocks.Sources.Constant force[3](k={0,1000,0}) 
    annotation (Placement(transformation(
        origin={80,-10}, 
        extent={{10,-10},{-10,10}}, 
        rotation=270)));
equation
  connect(revolute2.frame_b, body.frame_a) annotation (Line(
      points={{-20,30},{-20,40},{0,40}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(forceAndTorque.frame_b, body.frame_b) 
    annotation (Line(
      points={{40,40},{20,40}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(fixed1.frame_b, revolute1.frame_a) 
    annotation (Line(
      points={{-80,0},{-60,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(revolute1.frame_b, revolute2.frame_a) 
    annotation (Line(
      points={{-40,0},{-20,0},{-20,10}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(fixed2.frame_b, forceAndTorque.frame_a) 
    annotation (Line(
      points={{80,40},{60,40}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(fixedRotation.frame_a, fixed1.frame_b) annotation (Line(
      points={{-20,-30},{-71,-30},{-71,0},{-80,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(forceAndTorque.frame_resolve, fixedRotation.frame_b) annotation (Line(
      points={{42,30},{20,30},{20,-30},{0,-30}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot, 
      thickness=0.5));
  connect(force.y, forceAndTorque.force) annotation (Line(
      points={{80,1},{80,10},{58,10},{58,28}}, color={0,0,127}));
  connect(torque.y, forceAndTorque.torque) annotation (Line(
      points={{40,1},{40,10},{50,10},{50,28}}, color={0,0,127}));
  annotation (
    Documentation(info="<html><p>
在这个例子中，展示了通用力组件\"<a href=\"modelica://Modelica.Mechanics.MultiBody.Forces.ForceAndTorque\" target=\"\">ForceAndTorque</a>\"的用法。一个 \"ForceAndTorque\" 元素被连接在一个物体和全局坐标系中的一个固定点之间。
力和扭矩由\"Constant\"模块定义。
这两个矢量在由\"fixedRotation\" 组件定义的坐标系中解析，该组件固定在全局坐标系中。
</p>
<p>
在t = 0时刻，其动画视图如下图所示。黄色线段从forceAndTorque组件的frame_a指向frame_b。绿色箭头表示作用在物体上的力从起点指向终点，而绿色双箭头表示作用在物体上的扭矩。
这两个向量的长度与力和扭矩向量的长度成比例(常数比例因子在forceAndTorque组件中定义为参数):
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/ForceAndTorque.png\" alt=\"\" data-href=\"\" style=\"\"/>
</p>
<p>
<br>
</p>
</html>"), experiment(StopTime=1.01));
end ForceAndTorque;