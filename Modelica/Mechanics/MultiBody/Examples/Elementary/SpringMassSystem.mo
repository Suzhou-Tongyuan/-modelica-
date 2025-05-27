within Modelica.Mechanics.MultiBody.Examples.Elementary;
model SpringMassSystem "用弹簧将质量块固定在全局坐标系上"
  extends Modelica.Icons.Example;
  parameter Boolean animation=true "= true, 如果应启用动画";
  inner Modelica.Mechanics.MultiBody.World world annotation (Placement(
        transformation(extent={{-80,20},{-60,40}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic p1(useAxisFlange=true, 
    n={0,-1,0}, 
    animation=animation, 
    boxWidth=0.05, 
    s(fixed=true, start=0.1), 
    v(fixed=true)) annotation (Placement(transformation(
        origin={-20,-10}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Mechanics.Translational.Components.Spring spring1(
                                                  c=30, s_rel0=0.1) 
    annotation (Placement(transformation(
        origin={10,-10}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Mechanics.MultiBody.Parts.Body body1(
    m=1, 
    sphereDiameter=0.2, 
    animation=animation, 
    r_CM={0,0,0}) annotation (Placement(transformation(
        origin={-20,-50}, 
        extent={{-10,10},{10,-10}}, 
        rotation=270)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation bar1(animation=animation, r={0.3,0,0}) 
    annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation bar2(animation=animation, r={0.3,0,0}) 
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  Modelica.Mechanics.MultiBody.Parts.Body body2(
    m=1, 
    sphereDiameter=0.2, 
    animation=animation, 
    r_CM={0,0,0}) annotation (Placement(transformation(
        origin={40,-50}, 
        extent={{-10,10},{10,-10}}, 
        rotation=270)));
  Modelica.Mechanics.MultiBody.Joints.Prismatic p2(useAxisFlange=true, 
    n={0,-1,0}, 
    animation=animation, 
    boxWidth=0.05, 
    stateSelect=StateSelect.always, 
    s(fixed=true, start=0.1), 
    v(fixed=true)) annotation (Placement(transformation(
        origin={40,-10}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Mechanics.MultiBody.Forces.Spring spring2(
    c=30, 
    s_unstretched=0.1, 
    width=0.1) annotation (Placement(transformation(
        origin={60,-10}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
equation
  connect(body1.frame_a, p1.frame_b) 
    annotation (Line(
      points={{-20,-40},{-20,-35},{-20,-35},{-20,-30},{-20,-20},{-20,-20}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(world.frame_b, bar1.frame_a) 
    annotation (Line(
      points={{-60,30},{-50,30}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(bar1.frame_b, p1.frame_a) annotation (Line(
      points={{-30,30},{-20,30},{-20,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(spring1.flange_b, p1.axis) annotation (Line(points={{10,-20},{-8,-20},{-8,-18},{-14,-18}}, color={0,127,0}));
  connect(bar1.frame_b, bar2.frame_a) 
    annotation (Line(
      points={{-30,30},{0,30}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(bar2.frame_b, p2.frame_a) 
    annotation (Line(
      points={{20,30},{40,30},{40,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(p2.frame_b, body2.frame_a) 
    annotation (Line(
      points={{40,-20},{40,-40}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(bar2.frame_b, spring2.frame_a) 
    annotation (Line(
      points={{20,30},{40,30},{40,10},{60,10},{60,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(body2.frame_a, spring2.frame_b) annotation (Line(
      points={{40,-40},{40,-40},{40,-30},{60,-30},{60,-20}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(spring1.flange_a, p1.support) annotation (Line(points={{10,0},{-8,0},{-8,-6},{-14,-6}}, color={0,127,0}));
  annotation (
    experiment(StopTime=5), 
    Documentation(info="<html><p>
这个例子展示了两种不同的方法来运用力学定律:
</p>
<ul><li>
在左侧系统中，通过一个平移关节将一个物体连接到全局坐标系。
平移关节具有两个一维平动接口(称为“支撑”和“轴”)，允许在支撑和轴连接器之间连接来自Modelica.Mechanics.Translational库的组件。
其效果是，由一维元素产生的力作为驱动力作用在平移关节的轴上。
在示例中，使用了一个简单的弹簧。
这种方法的优点是可以使用来自Translational库的许多元素，并且这种实现通常比使用三维弹簧更高效。</li>
<li>
在右侧系统中定义了相同的模型。
不同之处在于使用了来自Modelica.Mechanics.MultiBody.Forces库的三维弹簧。
这样做的好处是可以得到力组件的良好动画效果。</li>
<li>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/SpringMassSystem.png\"
alt=\"model Examples.Elementary.SpringMassSystem\"></li>
</ul></html>"));
end SpringMassSystem;