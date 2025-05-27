within Modelica.Mechanics.MultiBody.Examples.Elementary;
model FreeBody "自由构件通过两个弹簧连接到环境"
  extends Modelica.Icons.Example;
  parameter Boolean animation=true "= true, 如果应启用动画";
  inner Modelica.Mechanics.MultiBody.World world annotation (Placement(
        transformation(extent={{-60,20},{-40,40}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation bar2(r={0.8,0,0}, animation=false) 
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  Modelica.Mechanics.MultiBody.Forces.Spring spring1(
    width=0.1, 
    coilWidth=0.005, 
    numberOfWindings=5, 
    c=20, 
    s_unstretched=0) annotation (Placement(transformation(
        origin={-20,0}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Mechanics.MultiBody.Parts.BodyShape body(
    m=1, 
    I_11=1, 
    I_22=1, 
    I_33=1, 
    r={0.4,0,0}, 
    r_CM={0.2,0,0}, 
    width=0.05, 
    r_0(start={0.2,-0.5,0.1}, each fixed=true), 
    v_0(each fixed=true), 
    angles_fixed=true, 
    w_0_fixed=true, 
    angles_start={0.174532925199433,0.174532925199433,0.174532925199433}) 
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  Modelica.Mechanics.MultiBody.Forces.Spring spring2(
    c=20, 
    s_unstretched=0, 
    width=0.1, 
    coilWidth=0.005, 
    numberOfWindings=5) annotation (Placement(transformation(
        origin={40,0}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
equation
  connect(bar2.frame_a, world.frame_b) 
    annotation (Line(
      points={{0,30},{-40,30}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(spring1.frame_b, body.frame_a) annotation (Line(
      points={{-20,-10},{-20,-30},{0,-30}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(bar2.frame_b, spring2.frame_a) 
    annotation (Line(
      points={{20,30},{40,30},{40,10}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(spring1.frame_a, world.frame_b) annotation (Line(
      points={{-20,10},{-20,30},{-40,30}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(body.frame_b, spring2.frame_b) annotation (Line(
      points={{20,-30},{40,-30},{40,-10}}, 
      color={95,95,95}, 
      thickness=0.5));
  annotation (
    experiment(StopTime=10), 
    Documentation(info="<html><p>
该例子演示:
</p>
<ul>
<li>
弹簧和阻尼器组件的动画
</li>
<li>
一个构件在未连接到关节的情况下可以自由移动。在这种情况下，物体坐标会自动用作状态变量(如果存在关节，则首先尝试使用关节的广义坐标作为状态变量)。
</li>
<li>
如果物体是自由运动的，可以通过\"初始化\"菜单定义物体的初始位置和速度，如图左侧的物体\"body1\"所示(点击\"初始化\")。
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/FreeBody.png\"
alt=\"model Examples.Elementary.FreeBody\"></li>
</ul></html>"));
end FreeBody;