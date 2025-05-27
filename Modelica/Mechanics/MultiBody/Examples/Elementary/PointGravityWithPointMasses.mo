within Modelica.Mechanics.MultiBody.Examples.Elementary;
model PointGravityWithPointMasses 
  "点重力场中的两个点质量(忽略物体的旋转)"
  extends Modelica.Icons.Example;
  inner Modelica.Mechanics.MultiBody.World world(
    mu=1, 
    gravitySphereDiameter=0.1, 
    gravityType=Modelica.Mechanics.MultiBody.Types.GravityTypes.PointGravity) 
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  Modelica.Mechanics.MultiBody.Parts.PointMass body1(
    m=1, 
    sphereDiameter=0.1, 
    r_0(start={0,0.6,0}, each fixed=true), 
    v_0(start={1,0,0}, each fixed=true)) 
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Modelica.Mechanics.MultiBody.Parts.PointMass body2(
    m=1, 
    sphereDiameter=0.1, 
    r_0(start={0.6,0.6,0}, each fixed=true), 
    v_0(start={0.6,0,0}, each fixed=true)) 
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  Modelica.Mechanics.MultiBody.Parts.PointMass body3(
    m=1, 
    sphereDiameter=0.1, 
    r_0(start={0,0.8,0}, each fixed=true), 
    v_0(start={0.6,0,0}, each fixed=true)) 
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  Modelica.Mechanics.MultiBody.Parts.PointMass body4(
    m=1, 
    sphereDiameter=0.1, 
    r_0(start={0.3,0.8,0}, each fixed=true), 
    v_0(start={0.6,0,0}, each fixed=true)) 
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  Forces.Spring spring(showMass=false, c=10, 
    fixedRotationAtFrame_b=true, 
    fixedRotationAtFrame_a=true) annotation (Placement(
        transformation(extent={{0,60},{20,80}})));
equation

  connect(spring.frame_a, body3.frame_a) annotation (Line(
      points={{0,70},{-10,70}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(spring.frame_b, body4.frame_a) annotation (Line(
      points={{20,70},{30,70}}, 
      color={95,95,95}, 
      thickness=0.5));
  annotation (
    experiment(StopTime=2), 
    Documentation(info="<html><p>
这个模型演示了在点重力场中使用Parts.PointMass模型的情况。PointMass模型具有一个特性，即不考虑旋转，因此也无法计算旋转。这个例子演示了两种情况：
如果一个PointMass没有连接(body1，body2)，那么这些点质量中的方向对象被设置为一个单位旋转。
如果一个PointMass被线性力元素连接，例如所使用的Forces.LineForceWithMass组件，那么方向对象就在线性力元素内被设置为一个单位旋转。
这两种情况下，当物理系统没有提供方程式时，转动会自动设置为默认值。
</p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/PointGravity.png\"
alt=\"model Examples.Elementary.PointGravity\">
</html>"));
end PointGravityWithPointMasses;