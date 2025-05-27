within Modelica.Mechanics.MultiBody.Examples.Loops;
model Fourbar2 
  "一个包含四根杆件的运动环模型(具有万向节和球面运动副；1个非线性方程)"
  extends Modelica.Icons.Example;

  output SI.Angle j1_phi "旋转接头j1的角度";
  output SI.Position j2_s "平移副j2的距离";
  output SI.AngularVelocity j1_w "旋转接头j1的轴速度";
  output SI.Velocity j2_v "平移副j的轴速度";
  inner Modelica.Mechanics.MultiBody.World world annotation (Placement(
        transformation(extent={{-100,-70},{-80,-50}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute j1(
    n={1,0,0}, 
    stateSelect=StateSelect.always, 
    phi(fixed=true), 
    useAxisFlange=false, 
    w(displayUnit="deg/s", 
      start=5.235987755983, 
      fixed=true)) 
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic j2(
    n={1,0,0}, 
    boxWidth=0.05, 
    s(fixed=true, start=-0.2)) 
    annotation (Placement(transformation(extent={{-20,-70},{0,-50}})));
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder b1(r={0,0.5,0.1}, diameter=0.05) 
    annotation (Placement(transformation(
        origin={-30,-10}, 
        extent={{-10,-10},{10,10}}, 
        rotation=90)));
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder b2(r={0,0.2,0}, diameter=0.05) 
    annotation (Placement(transformation(
        origin={50,-40}, 
        extent={{-10,-10},{10,10}}, 
        rotation=90)));
  Modelica.Mechanics.MultiBody.Joints.UniversalSpherical universalSpherical(
    n1_a={0,1,0}, 
    computeRodLength=true, 
    rRod_ia={-1,0.3,0.1}) annotation (Placement(transformation(extent={{20,30},{0,50}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation b3(r={1.2,0,0}, animation=false) 
    annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
  Modelica.Mechanics.MultiBody.Visualizers.FixedFrame fixedFrame(color_x={0,0,255}) 
    annotation (Placement(transformation(
        extent={{20,60},{40,80}})));
equation
  j1_phi = j1.phi;
  j2_s = j2.s;
  j1_w = j1.w;
  j2_v = j2.v;
  connect(j2.frame_b, b2.frame_a) annotation (Line(
      points={{0,-60},{50,-60},{50,-50}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(j1.frame_b, b1.frame_a) annotation (Line(
      points={{-40,-30},{-30,-30},{-30,-20}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(j1.frame_a, world.frame_b) annotation (Line(
      points={{-60,-30},{-70,-30},{-70,-60},{-80,-60}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(b1.frame_b, universalSpherical.frame_b) annotation (Line(
      points={{-30,0},{-30,40},{0,40}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(universalSpherical.frame_a, b2.frame_b) 
    annotation (Line(
      points={{20,40},{50,40},{50,-30}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(b3.frame_a, world.frame_b) 
    annotation (Line(
      points={{-60,-60},{-80,-60}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(b3.frame_b, j2.frame_a) 
    annotation (Line(
      points={{-40,-60},{-20,-60}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(fixedFrame.frame_a, universalSpherical.frame_ia) annotation (Line(
      points={{20,70},{14,70},{14,50}}, 
      color={95,95,95}, 
      thickness=0.5));
  annotation (
    experiment(StopTime=5), 
    Documentation(info="<html><p>
这是“四连杆”机构的第二个版本，请参见图：</p>
<p>
<div><img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/Fourbar2.png\"alt=\"model Examples.Loops.Fourbar2\"></div></p>
<p>
在这种情况下，左上侧的三个转动副和右上侧的两个转动副已被联合球面运动副(<strong>UniversalSpherical</strong>)替换，该运动副是连接球面副和万向运动副的杆。
该运动副由<strong>一个约束</strong>定义，即两个球面副之间的距离是恒定的。
在运动环中使用这种运动副可以减小非线性代数方程的规模。
对于这个环路，仅剩下一个一阶非线性代数方程系统。
</p>
<p>
在UniversalSpherical运动副处，还存在一个额外的固定到杆上的frame_ia，可以将组件连接到连接杆上。
在这个例子中，只连接了一个坐标系以可视化frame_ia(右侧的蓝色坐标系)。
</p>
<p>
另一个特性是，在<strong>初始值</strong>期间可以自动计算连接杆的长度。
为了实现这一点，必须提供另一个初始值条件。
在这个例子中，通过“初始值”菜单固定了平移副j2的距离的初始值，并且在联合运动副“UniversalSpherical”的参数菜单中设置了参数<strong>computeLength</strong>=<strong>true</strong>，在初始值期间计算了杆的长度。
其主要优点是在初始值期间不需要解决非线性方程组，因此初始值始终有效。
准确地说，实际上是解决了如下的复杂的非线性方程以获得rodLength：</p>
<blockquote><pre>
rodLength*rodLength=f(angleofrevolutejoint,distanceofprismaticjoint)
</pre></blockquote>
</html>"));
end Fourbar2;