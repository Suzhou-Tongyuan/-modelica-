within Modelica.Mechanics.MultiBody.Examples.Elementary;
model InitSpringConstant 
  "给定弹簧常数，使系统在给定位置处于稳定状态"

  extends Modelica.Icons.Example;
  inner Modelica.Mechanics.MultiBody.World world(gravityType=Modelica.Mechanics.MultiBody.Types.GravityTypes.UniformGravity) 
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute rev(
    useAxisFlange=true, 
    n={0,0,1}, 
    phi(fixed=true), 
    w(fixed=true), 
    a(fixed=true)) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Mechanics.Rotational.Components.Damper damper(d=0.1) annotation (
      Placement(transformation(extent={{-40,30},{-20,50}})));
  Modelica.Mechanics.MultiBody.Parts.BodyShape body(
    r={1,0,0}, 
    r_CM={0.5,0,0}, 
    m=1) 
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Mechanics.MultiBody.Parts.Fixed fixed(r={1,0.2,0}, width=0.02) 
    annotation (Placement(transformation(
        origin={50,60}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Mechanics.MultiBody.Forces.Spring spring(s_unstretched=0.1, c(fixed= 
          false, start=100)) annotation (Placement(transformation(
        origin={50,20}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));

equation
  connect(world.frame_b, rev.frame_a) annotation (Line(
      points={{-60,0},{-40,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(damper.flange_b, rev.axis) annotation (Line(points={{-20,40},{-20,20},{-30,20},{-30,10}}));
  connect(rev.support, damper.flange_a) annotation (Line(points={{-36,10},{-36,20},{-40,20},{-40,40}}));
  connect(rev.frame_b, body.frame_a) annotation (Line(
      points={{-20,0},{0,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(fixed.frame_b, spring.frame_a) annotation (Line(
      points={{50,50},{50,30}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(body.frame_b, spring.frame_b) annotation (Line(
      points={{20,0},{50,0},{50,10}}, 
      color={95,95,95}, 
      thickness=0.5));
  annotation (Documentation(info="<html><p>
这个例子演示了一个非标准类型的初始化，通过计算一个弹簧常数，使一个单摆在稳定状态下处于一个给定的位置。
</p>
<p>
本示例的目的是当单摆的旋转角度为零时，单摆应该处于稳定状态。在初始化过程中计算弹簧的弹簧常数，以达到这个目标。
</p>
<p>
摆动有一个自由度，即两个状态变量。因此，必须提供两个额外的方程式进行初始化。
然而，弹簧组件的参数\"c\"被定义为属性\"fixed = <strong>false</strong>\"，即在初始化过程中计算该参数的值。
因此，在初始化期间需要一个额外的方程式。
3个初始方程式是旋转关节的旋转角、其一阶和二阶导数。
后两者为零，以便在稳态初始化。
通过将phi、w、a的起始值设置为零，并将它们的固定属性设置为true，定义了所需的3个初始方程式。
</p>
<p>
在翻译后，该模型以稳态初始化。
弹簧常数计算为c = 49.05 N/m。
此模拟的动画如下图所示。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/InitSpringConstant.png\"
alt=\"model Examples.Elementary.InitSpringConstant\">
</p>
</html>"), experiment(StopTime=1.01));
end InitSpringConstant;