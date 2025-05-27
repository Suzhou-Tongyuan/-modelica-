within Modelica.Mechanics.MultiBody.Examples.Elementary;
model RollingWheel 
  "单轮以初始速度开始在地面滚动"
   extends Modelica.Icons.Example;

  Modelica.Mechanics.MultiBody.Parts.RollingWheel wheel1(
    radius=0.3, 
    m=2, 
    I_axis=0.06, 
    I_long=0.12, 
    hollowFraction=0.6, 
    x(start=0.2), 
    y(start=0.2), 
    der_angles(start={0,5,1})) 
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  inner Modelica.Mechanics.MultiBody.World world(
    label2="z", 
    n={0,0,-1}, 
    animateGround=true, 
    groundLength_u=4, 
    groundColor={130,200,130}) 
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  annotation (
    experiment(StopTime=4), 
    Documentation(info="<html><p>
演示单个车轮如何在地面上滚动(从初始设置速度开始)。
</p>
</html>"));
end RollingWheel;