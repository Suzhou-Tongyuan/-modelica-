within Modelica.Mechanics.MultiBody.Examples.Loops.Utilities;
partial block Engine1Base 
  "单缸发动机的基础模型"

  inner Modelica.Mechanics.MultiBody.World world 
    annotation (Placement(transformation(extent= {{-100,-100},{-80,-80}})));
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder piston(diameter=0.1, r={0,-0.1,0}) 
    annotation (Placement(transformation(
        origin={90,40}, 
        extent={{-10,10},{10,-10}}, 
        rotation=270)));
  Modelica.Mechanics.MultiBody.Parts.BodyBox connectingRod(
    widthDirection={1,0,0}, 
    width=0.02, 
    height=0.06, 
    color={0,0,200}, 
    r={0,-0.2,0}) 
    annotation (Placement(transformation(
        origin={90,-20}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
  Modelica.Mechanics.MultiBody.Joints.Revolute bearing(useAxisFlange=true, 
    n={1,0,0}, 
    cylinderLength=0.02, 
    cylinderDiameter=0.05) annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(
    stateSelect=StateSelect.always, 
    J=1, 
    w(fixed=true, 
      start = 10), 
    phi(
      fixed=true, 
      start=0.0, 
      displayUnit="rad")) annotation (Placement(transformation(
          extent={{-60,-60},{-40,-40}})));
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder crank1(diameter=0.05, r={0.1,0,0}) 
    annotation (Placement(transformation(extent={{-30,-100},{-10,-80}})));
  Modelica.Mechanics.MultiBody.Parts.BodyBox crank2(
    height=0.05, 
    widthDirection={1,0,0}, 
    width=0.02, 
    r={0,0.1,0}) 
    annotation (Placement(transformation(
        origin={0,-80}, 
        extent={{-10,-10},{10,10}}, 
        rotation=90)));
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder crank3(r={0.1,0,0}, diameter=0.03) annotation (
                                 Placement(transformation(extent={{40,-76},{60,-56}})));
  Modelica.Mechanics.MultiBody.Parts.BodyBox crank4(
    height=0.05, 
    widthDirection={1,0,0}, 
    width=0.02, 
    r={0,-0.1,0}) annotation (Placement(transformation(
        origin={90,-80}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation mid(r={0.05,0,0}) 
    annotation (Placement(transformation(extent={{-10,10},{10,-10}}, 
        origin={20,-40})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation cylPosition(
    animation=false, 
    r = {0.15,0.45,0}) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-70,40})));
equation
  connect(world.frame_b, bearing.frame_a) 
    annotation (Line(
      points={{-80,-90},{-60,-90}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(crank2.frame_a, crank1.frame_b) annotation (Line(
      points={{-4.44089e-16,-90},{-10,-90}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(bearing.frame_b, crank1.frame_a) annotation (Line(
      points={{-40,-90},{-30,-90}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(world.frame_b, cylPosition.frame_a) annotation (Line(
      points={{-80,-90},{-70,-90},{-70,30}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(crank3.frame_b, crank4.frame_a) annotation (Line(
      points={{60,-66},{90,-66},{90,-70}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(inertia.flange_b, bearing.axis) 
    annotation (Line(
      points={{-40,-50},{-30,-50},{-30,-70},{-50,-70},{-50,-80}}));
  connect(crank2.frame_b, crank3.frame_a) 
    annotation (Line(
      points={{0,-70},{0,-66},{40,-66}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(crank2.frame_b, mid.frame_a) 
    annotation (Line(
      points={{0,-70},{0,-40},{10,-40}}, 
      color={95,95,95}, 
      thickness=0.5));
  annotation (
    Documentation(info="<html>
<p>
这是一个发动机单个气缸机械部分的模型。
燃烧过程没有建模。左下角的“惯性”组件是驱动变速箱的发动机输出惯性。
为了展示发动机的运转情况，输出惯性的角速度起始值为10弧度/秒。
</p>
<p>
该发动机模型仅由旋转关节和平移关节组成。
由于这会导致形成一个<strong>平面</strong>环路，因此存在众所周知的困难，
即垂直于环路的局部力以及平面内的局部扭矩无法唯一计算。
这种模糊性通过在每个平面环路中的一个旋转关节的<strong>高级</strong>菜单中使用<strong>planarCutJoint</strong>选项来解决(此处为关节b1)。该选项将此关节旋转轴方向的局部力以及垂直于旋转轴的局部扭矩设置为零，从而使问题在数学上得到妥善解决。
</p>
<p>
该示例的动画效果展示在下图中。
</p><div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/Engine.png\" alt=\"model Examples.Loops.Engine\">
</div></html>"));
end Engine1Base;