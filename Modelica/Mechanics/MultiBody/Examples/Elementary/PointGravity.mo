within Modelica.Mechanics.MultiBody.Examples.Elementary;
model PointGravity "点重力场中的两个质点"
  extends Modelica.Icons.Example;
  inner Modelica.Mechanics.MultiBody.World world(
    mu=1, 
    gravitySphereDiameter=0.1, 
    gravityType=Modelica.Mechanics.MultiBody.Types.GravityTypes.PointGravity) 
    annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  Modelica.Mechanics.MultiBody.Parts.Body body1(
    m=1, 
    sphereDiameter=0.1, 
    I_11=0.1, 
    I_22=0.1, 
    I_33=0.1, 
    r_0(start={0,0.6,0}, each fixed=true), 
    v_0(start={1,0,0}, each fixed=true), 
    angles_fixed=true, 
    w_0_fixed=true, 
    r_CM={0,0,0}) 
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Modelica.Mechanics.MultiBody.Parts.Body body2(
    m=1, 
    sphereDiameter=0.1, 
    I_11=0.1, 
    I_22=0.1, 
    I_33=0.1, 
    r_0(start={0.6,0.6,0}, each fixed=true), 
    v_0(start={0.6,0,0}, each fixed=true), 
    angles_fixed=true, 
    w_0_fixed=true, 
    r_CM={0,0,0}) 
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  annotation (
    experiment(StopTime=5), 
    Documentation(info="<html><p>
这个模型演示了一个点重力场。两个物体放置在重力场中。
选择这些物体的初始位置和速度，使得一个物体绕着圆形运动，而另一个物体绕着椭圆形运动，围绕点重力场的中心。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/PointGravity.png\" alt=\"model Examples.Elementary.PointGravity\" data-href=\"\" style=\"\"/>
</p>
</html>"));
end PointGravity;